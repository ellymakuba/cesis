<?php
$PageSecurity = 5;
include('includes/DefineCartClass.php');
include('includes/session.inc');
$title = _('Fee Structure');
include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc');
include('includes/GetSalesTransGLCodes.inc');
?>
<SCRIPT LANGUAGE="javascript">
$(document).ready(function(){
 $("#product").autocomplete({
 source:function(request,response){
     $.getJSON("search.php?term="+request.term,function(result){
     response($.map(result,function(item){
         return{
        id:item.stockid,
        value:item.description
        }
     }))
    })
 },
 minLength:3,
  messages: {
        noResults: '',
        results: function() {}
    }
  });
    $('.columnQuantityClass,.columnPriceClass,.columnDiscountClass').change(function(){
  var totalPayableAmount=0;
	  var id=$(this).attr('id');
	  var index=id.substring(id.indexOf("_")+1);
	  var discount=parseInt($("#discount_"+index).val());
	  if(isNaN(discount)){
	      document.getElementById("discount_"+index).value=0;
	  }
	  document.getElementById("lineTotal_"+index).value = parseFloat(document.getElementById("price_"+index).value)-parseInt(document.getElementById("discount_"+index).value);
	$(".lineTotalClass").each(function(){
	 totalPayableAmount=parseInt(totalPayableAmount)+parseFloat($(this).val());
	  })
	  document.getElementById("invoiceTotal").value=totalPayableAmount;
  })

  $(".columnPriorityClass").change(function(){
       $.ajax({
          type:"POST",
          url:"ManageFeeStructures.php",
          async:false,
          success:function(){
            alert("am the value you are looking for "+$(this).val())
          }
      });
      });
})
</script><?php
if(isset($_REQUEST['debtorno']))
{
	$_SESSION['student'] = $_REQUEST['debtorno'];
	$sql = "SELECT grade_level_id FROM debtorsmaster WHERE debtorno='" . $_SESSION['student'] . "'";
	$result= DB_query($sql, $db);
	$myrow= DB_fetch_array($result);
	$_SESSION['studentClassSession'] = $myrow['grade_level_id'];
}
if(isset($_REQUEST['invoice_id']))
{
	$_SESSION['invoice_id']=$_REQUEST['invoice_id'];
	$_SESSION['term']=$_REQUEST['period_id'];
}
echo '<p class="page_title_text">' . ' ' . _('Student Billing Form') . '';
echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . '>';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
echo '<table class="enclosed">';
echo '<tr><td>' . _('Student') . ":</td>";
$sql= "SELECT * FROM debtorsmaster WHERE debtorno='" . $_SESSION['student'] . "'";
$result= DB_query($sql, $db);
$myrow = DB_fetch_array($result);
echo '<td>' . $myrow['debtorno'] . ' ' . $myrow['name'] . '</td></tr>';
echo '<tr><td>' . _('Term') . ":</td><td><select name='term'>";
echo '<OPTION SELECTED VALUE=0>' . _('Select Term');
$sql    = "SELECT * FROM terms";
$result = DB_query($sql, $db);
while ($myrow = DB_fetch_array($result)) {
    echo '<option value=' . $myrow['id'] . '>' . ' ' . $myrow['title'] . ' ' . $myrow['year'];
} //end while loop
echo '</select></td></tr>';
echo '</table>';
echo '<table class="enclosed">';
    echo "<div class='centre'><input  type='Submit' name='loadFeeStructure' value='" . _('Load Fee Structure') . "'></div></br>";
echo "</form>";

if (isset($_POST['loadFeeStructure'])) {
    if ($_POST['term'] == 0) {
        prnMsg(_('Please select term you want to create fee structure'), 'error');
    }
    else{
        $_SESSION['term'] = $_POST['term'];
        $sql= 'SELECT grade_level FROM gradelevels WHERE id="' . $_SESSION['studentClassSession'] . '"';
        $result= DB_query($sql, $db);
        $myrow= DB_fetch_array($result);
        $_SESSION['class_name'] = $myrow['grade_level'];

        $LineNumber = $_SESSION['classFeeStructure']->LineCounter;
        $sql= 'SELECT title FROM terms WHERE id="' . $_SESSION['term'] . '"';
        $result = DB_query($sql, $db);
        $myrow = DB_fetch_array($result);
        $_SESSION['term_name'] = $myrow['title'];

        $sql = "SELECT ab.* FROM autobilling ab
    		WHERE  ab.class_id='".$_SESSION['studentClassSession']."'
    		AND ab.term_id='".$_SESSION['term']."'";
    		$result = DB_query($sql,$db);
    		$num_rows = DB_num_rows($result);
    		if ($num_rows<0 || $num_rows==0)
    		{
    			prnMsg(_('The fee structure for '.$_SESSION['class_name'].' has not been created for '.$_SESSION['term_name']),'warn');
    	    exit();
    	  }
    }
}
$NewItemQty = 1;
if ($_SESSION['studentClassSession'] > 0 && isset($_SESSION['term'])){
    $_SESSION['classFeeStructure'] = new Cart;
    $sql = "SELECT id FROM autobilling WHERE term_id='" . $_SESSION['term'] . "' AND class_id='" . $_SESSION['studentClassSession'] . "'";
    $result= DB_query($sql, $db);
    $myrow = DB_fetch_array($result);
    $_SESSION['feeStructure']= $myrow['id'];

    $sql    = "SELECT * FROM autobilling_items WHERE autobilling_id='" . $_SESSION['feeStructure'] . "' ORDER BY id";
    $result = DB_query($sql, $db);
    while ($rows = DB_fetch_array($result)) {
        $sql2    = "SELECT stockmaster.actualcost,stockmaster.stockid,stockmaster.description  FROM stockmaster
        WHERE stockmaster.stockid='" . $rows['product_id'] . "'";
        $result2 = DB_query($sql2, $db);
        $myrow2  = DB_fetch_array($result2);
        $_SESSION['classFeeStructure']->add_to_cart($myrow2['stockid'], $NewItemQty, $myrow2['description'], $rows['amount'], 0, 1, 1, 1, 0, 1, Date($_SESSION['DefaultDateFormat']), 0, 1, 1, 1, 1, '', 'No', -1, 1, '', '', '', 1);
    }
}
echo '</form>';
if (isset($_GET['Delete'])) {
    $_SESSION['classFeeStructure']->remove_from_cart($_GET['Delete']);
}
if (isset($_GET['Update'])) {
    $_SESSION['classFeeStructure']->update_cart_item($_GET['Update'], '2', '500', '10', '', 'No', '0', '14', '5');
}
if (count($_SESSION['classFeeStructure']->LineItems) > 0) {
    echo '<form name="form1" action="' . $_SERVER['PHP_SELF'] . '?' . SID . '" method=post>';
    echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
    $LineNumber= $_SESSION['InvoiceItems']->LineCounter;
    $sql= "SELECT dm.*,e.transport as trasnportfee FROM debtorsmaster dm
    LEFT JOIN estates e ON dm.estate_id=e.id
    WHERE debtorno = '" . $_SESSION['student'] . "'";
    $result= DB_query($sql, $db);
    $myrow = DB_fetch_array($result);
  	$studentDetails= $myrow['debtorno'] . '-' . $myrow['name'];
    $boarder=$myrow['group_id'];
    $transport=$myrow['transport'];
    $transportFee=$myrow['trasnportfee'];
    $boardingFeeAlreadyOnThisCredit = 0;
    $sql= "SELECT stockid FROM stockmaster
    WHERE stockid like 'boarding'";
    $result= DB_query($sql, $db);
    $myrow= DB_fetch_array($result);
    foreach ($_SESSION['classFeeStructure']->LineItems AS $OrderItem){
       if ($OrderItem->StockID ==$myrow['stockid'])
      {
          $boardingFeeAlreadyOnThisCredit = 1;
       }
    }
    if($boardingFeeAlreadyOnThisCredit==0 && $transport==1){
     $sql= "SELECT actualcost,stockid,description FROM stockmaster
     WHERE stockid like 'transport'";
     $result= DB_query($sql, $db);
     $myrow= DB_fetch_array($result);
     $AlreadyOnThisCredit = 0;
     foreach ($_SESSION['classFeeStructure']->LineItems AS $OrderItem){
        if ($OrderItem->StockID ==$myrow['id'])
       {
           $AlreadyOnThisCredit = 1;
        }
     }
     if($AlreadyOnThisCredit==0){
     $_SESSION['classFeeStructure']->add_to_cart($myrow['stockid'],$NewItemQty,$myrow['description'],$transportFee, 0,
     1, 1, 1, 0, 1, Date($_SESSION['DefaultDateFormat']), 0, 1, 1, 1, 1, '', 'No', -1, 1, '', '', '', 1);
   }
   }
  echo '<tr><td colspan=3><table class="whiteBorderedTD" border-spacing: 2px; cellpadding=2 style="margin-bottom:20px; -moz-border-radius:20px;
 border-radius:20px; width:100%;"></br>';
    echo '<tr><td colspan="6" style="text-align:center;"><h1><b>' .$studentDetails . '</b></h1></td></tr>';
	echo '<tr><td colspan="6" style="text-align:center;"><h3><b>' . $_SESSION['class_name'] . ' ' . $_SESSION['term_name'] . ' ' . _('Fee Structure Items') . '</b></h3></td></tr>';
    echo "<tr><th style='width:40%;'>" . _('Item Name') . "</th>";
	echo "<th>" . _('Amount') . "</th>";
	echo "<th>" . _('Remove') . "</th>";
	echo "</tr>";
    $k= 0;
    $_SESSION['classFeeStructure']->total = 0;
    foreach ($_SESSION['classFeeStructure']->LineItems as $InvoiceItem) {
        $LineTotal = $InvoiceItem->Price  - $InvoiceItem->DiscountPercent;
        echo '<tr>';
        $_SESSION['classFeeStructure']->total = $_SESSION['classFeeStructure']->total + $LineTotal;
        echo '<input type="hidden" name="id[]" id="stock_' . $InvoiceItem->LineNumber . '" value="' . $InvoiceItem->StockID . '" />';
        echo "<td>" . $InvoiceItem->ItemDescription . "</td>";
        echo '<td><input type="text" class="columnPriceClass" name="Price[]" id="price_' . $InvoiceItem->LineNumber . '"  value="' . $InvoiceItem->Price . '"></td>';
		echo '<input type="hidden"  class="columnDiscountClass" name="discount[]" id="discount_' . $InvoiceItem->LineNumber . '" size=5 value="' . $InvoiceItem->DiscountPercent . '">';
	  echo '<input type="hidden" class="lineTotalClass" name="lineTotal[]" id="lineTotal_'.$InvoiceItem->LineNumber.'"
			 value="'.$LineTotal.'" size=5"/';
    echo '<input type="hidden"  class="columnPriorityClass" name="priority[]" id="priority_' . $InvoiceItem->LineNumber . '" size=5 value="' . $InvoiceItem->LineNumber . '">';
	  echo "<td><a href='" . $_SERVER['PHP_SELF'] . "?" . SID . "&Delete=" . $InvoiceItem->LineNumber . "'>" . _('Remove Product') . "</a></td></tr>";
    } //end foreach ($_SESSION['InvoiceItems']->LineItems as $InvoiceItem)
    $_SESSION['form_already_loaded'] = 1;
    echo '<tr><td>Fee Structure Total</td><td><input type="text" name="invoiceTotal" id="invoiceTotal"
     value="' . number_format($_SESSION['classFeeStructure']->total, 2) . '" readonly=""/></td></tr>';
     echo '</table></table>';
	 echo "<div class='centre'><input  type='Submit' name='submitInvoice' value='" . _('Invoice Student') . "'></div>";

    if (isset($_POST['submitInvoice'])) {
        $PostingDate = Date($_SESSION['DefaultDateFormat'], mktime(0, 0, 0, Date('m'), 0, Date('Y')));
        $PeriodNo    = GetPeriod($PostingDate, $db);

        $sql_exist= "SELECT id FROM salesorderdetails
        WHERE term='" . $_SESSION['term'] . "'
        AND student_id='" . $_SESSION['student'] . "'
        AND year='".Date('Y')."'";
        $result_exist = DB_query($sql_exist, $db);
        if (DB_fetch_row($result_exist) > 0) {
          echo '</br>';
          prnMsg(_('This student has already been invoiced for this term'), 'warn');
        }
        else {
            $sql = "INSERT INTO salesorderdetails(student_id,invoice_date,transactiondate,addedby,term,class,year)
           VALUES ('" . $_SESSION['student'] . "','" . date('Y-m-d') . "','" . date('Y-m-d') . "','" . trim($_SESSION['UserID']) . "',
		       '" . $_SESSION['term'] . "','".$_SESSION['studentClassSession']."','".Date('Y')."')";
            $DbgMsg = _('The SQL that failed was');
            $ErrMsg= _('Unable to add the quotation line');
            $Ins_LineItemResult = DB_query($sql, $db, $ErrMsg, $DbgMsg, true);
            $sql  = "SELECT LAST_INSERT_ID()";
            $result= DB_query($sql, $db);
            $myrow= DB_fetch_row($result);
            $lastID= $myrow[0];

            $_SESSION['invoice_id']=$lastID;
            $glquery  = "SELECT SUM(amount) as total FROM autobilling_items
             WHERE autobilling_id='" . $_SESSION['feeStructure'] . "'";
            $glresult = DB_query($glquery, $db);
            $glmyrow  = DB_fetch_array($glresult);
            $glamount = $glmyrow['total'];

            $query  = "INSERT INTO gltrans ( type,typeno,trandate,periodno,account,amount)
            VALUES (10,'" . $id . "','" . date('Y-m-d H-i-s') . "','" . $PeriodNo . "',1100,'" . $glamount . "')";
            $result = DB_query($query, $db);

            $query  = "INSERT INTO gltrans ( type,typeno,trandate,periodno,account,amount)
            VALUES (10,'" . $id . "','" . date('Y-m-d H-i-s') . "','" . $PeriodNo . "',1,'" . -$glamount . "')";
            $result = DB_query($query, $db);

            $i = 0;
            foreach ($_POST['id'] as $value) {
                $sql    = "INSERT INTO invoice_items ( invoice_id,product_id,unitprice,priority,qty,totalinvoice)
                VALUES ('" . $lastID . "','" . $_POST['id'][$i] . "','" . $_POST['Price'][$i] . "',
                '".$i."','1','" . $_POST['Price'][$i] . "') ";
                $result = DB_query($sql, $db);
                $i++;
            }
            prnMsg(_('Invoicing successfully'), 'success');
            unset($_SESSION['classFeeStructure']);
            unset($_SESSION['feeStructure']);
            unset($_SESSION['classFeeStructure']->LineItems);
            unset($_SESSION['classFeeStructure']->LineCounter);
            unset($_SESSION['term']);
            unset($_SESSION['studentClassSession']);
            unset($_SESSION['class_name']);
            unset($_SESSION['term_name']);
            echo "<meta http-equiv='Refresh' content='0; url=" . $rootpath . "/SelectStudent.php" . "'>";
        }
    } //end of if(isset($_POST['submitInvoice'])){

} //end of if (count($_SESSION['InvoiceItems']->LineItems)>0)

echo '</form>';
include('includes/footer.inc');
?>
