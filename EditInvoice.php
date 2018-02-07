<?php
$PageSecurity = 5;
include('includes/DefineCartClass.php');
include('includes/DefineSerialItems.php');
include('includes/session.inc');
$title = _('Edit Invoice');
include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc');
include('includes/GetSalesTransGLCodes.inc');?>
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
  $('.columnPriceClass').change(function(){
        var totalPayableAmount=0;
	$(".columnPriceClass").each(function(){
	 totalPayableAmount=parseInt(totalPayableAmount)+parseFloat($(this).val());
	  })
	  document.getElementById("invoiceTotal").value=totalPayableAmount;
  })

  $("#invoiceTotal,#amountPaid").change(function(){
  document.getElementById("balance").value=parseFloat($("#invoiceTotal").val()) - parseFloat($("#amountPaid").val());

  })

  $(".columnPriorityClass").change(function(){
  	 $.ajax({
  		type:"POST",
  		url:"ManageselectedBatchs.php",
  		async:false,
  		success:function(){
  		  alert("am the value you are looking for "+$(this).val())
  		}
  	});
  	alert("am the value you are looking for "+$(this).val());
      });
})
</script><?php
echo '<p class="page_title_text">' . ' ' . _('Edit Student Invoice') . '';
$NewItemQty = 1;
echo '<table class="enclosed">';
echo '<form action="' . $_SERVER['PHP_SELF'] . '?' . SID . '" method=post>';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
echo '<div class="content">';
echo '<table cellpading=10 class=enclosed style="margin-bottom:20px; margin-top:20px; -moz-border-radius:20px; border-radius:20px;">
<tr><td style="margin-left:55%;">Type Item Name</td><td><input type="text" name="product" id="product" size="80" placeholder="Type the first three characters to display item" /></td>
<div id="result"></div>
</div>';
echo '<td><input type="submit" name="productSearch" value="'._('Add Item').'" /></td></tr>';
if(isset($_GET['invoiceNo']))
{
  $_SESSION['selectedInvoice']=$_GET['invoiceNo'];
	$_SESSION['EditInvoiceItems'] = new Cart;
  $sql="SELECT invoice_items.* FROM invoice_items,salesorderdetails
  WHERE  invoice_items.invoice_id = salesorderdetails.id
  AND  salesorderdetails.id ='" . $_GET['invoiceNo'] . "'
  ORDER BY  salesorderdetails.id";
  $result=DB_query($sql,$db);
	while($rows=DB_fetch_array($result))
	{
		$sql2="SELECT stockmaster.actualcost,stockmaster.stockid,stockmaster.description  FROM stockmaster
	  WHERE stockmaster.stockid='".$rows['product_id']."'";
		$result2=DB_query($sql2,$db);
		$myrow2 = DB_fetch_array($result2);

		$_SESSION['EditInvoiceItems']->add_to_cart ($myrow2['stockid'],$NewItemQty,$myrow2['description'],$rows['totalinvoice']
		,0,1,1,1,0,1,Date($_SESSION['DefaultDateFormat']),0,1,1,1,1,'','No',-1,1,'','','',1);
	}
}
if(isset($_POST['productSearch'])){
$SearchString =$_POST['product'];
$sql="SELECT * FROM stockmaster where description LIKE '$SearchString'";
$ErrMsg = _('There is a problem selecting the part records to display because');
$SearchResult = DB_query($sql,$db,$ErrMsg);

if (DB_num_rows($SearchResult)==0)
{
	prnMsg(_('There are no products available that match the criteria specified'),'info');
	if ($debug==1)
	{
	  prnMsg(_('The SQL statement used was') . ':<br>' . $SQL,'info');
	}
}
if (DB_num_rows($SearchResult)==1)
{
	$myrow=DB_fetch_array($SearchResult);
	$_POST['NewItem'] = $myrow['stockid'];
	DB_data_seek($SearchResult,0);
	$newitem=$_POST['NewItem'];
}

  $sql = "SELECT stockmaster.actualcost,stockmaster.stockid,stockmaster.description FROM stockmaster
	WHERE stockmaster.stockid = '". $_POST['NewItem'] . "'";
	$ErrMsg =  _('There is a problem selecting the item because');
	$result1 = DB_query($sql,$db,$ErrMsg);
	if ($myrow = DB_fetch_array($result1))
	{
		 $AlreadyOnThisCredit =0;
		   foreach ($_SESSION['EditInvoiceItems']->LineItems AS $OrderItem){
				$LineNumber = $_SESSION['EditInvoiceItems']->LineCounter;
			    if ($OrderItem->StockID ==$_POST['NewItem'])
				 {
				     $AlreadyOnThisCredit = 1;
					 //$NewItemQty =$NewItemQty+1;
				     prnMsg($_POST['NewItem'] . ' ' . _('is already on this batch - the system will not allow the
					 same item  more than once.'),'warn');
			    }
		   } /* end of the foreach loop to look for preexisting items of the same code */
		if ($AlreadyOnThisCredit!=1)
		{
			$_SESSION['EditInvoiceItems']->add_to_cart ($myrow['stockid'],$NewItemQty,$myrow['description'],$myrow['actualcost']
			,0,1,1,1,0,1,Date($_SESSION['DefaultDateFormat']),0,1,1,1,1,'','No',-1,1,'','','',1);
		}

	}
	else
	{
		prnMsg( $_POST['NewItem'] . ' ' . _('does not exist in the database and cannot therefore be added to the Invoice'),'warn');
	}

echo '</form>';
}//end of if(isset($_POST['productSearch']))
if (isset($_GET['Delete']))
{
	$_SESSION['EditInvoiceItems']->remove_from_cart($_GET['Delete']);
}
if (isset($_GET['Update']))
{
	$_SESSION['EditInvoiceItems']->update_cart_item($_GET['Update'],'2','500','10','','No','0','14','5');
}
if (count($_SESSION['EditInvoiceItems']->LineItems)>0)
{
	 echo '<form name="form1" action="'. $_SERVER['PHP_SELF'] . '?' . SID . '" method=post>';
	 echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
  $sql = "SELECT so.*,dm.name FROM salesorderdetails so
  INNER JOIN debtorsmaster dm ON dm.debtorno=so.student_id	WHERE so.id='".$_SESSION['selectedInvoice']."'";
  $DbgMsg = _('The SQL that was used to retrieve the information was');
  $ErrMsg = _('Could not check whether the group is recursive because');
  $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
  $row = DB_fetch_array($result);
  $regNo = $row['student_id'];
  $name=$row['name'];

echo '<tr><td colspan=3><table class="whiteBorderedTD" border-spacing: 2px; cellpadding=2 style="margin-bottom:20px; -moz-border-radius:20px;
 border-radius:20px; width:100%;"></br>';
echo '<tr><td colspan="6" style="text-align:center;"><h1><b>'.$regNo.':'.$name._(' invoice').'</b></h3></td></tr>';
echo "<tr><th style='width:40%;'>" . _('Item Name') . "</th><th>" . _('Amount') . "</th><th>" . _('Remove') . "</th></tr>";
		$k=0;
		$_SESSION['EditInvoiceItems']->total=0;
		foreach ($_SESSION['EditInvoiceItems']->LineItems as $InvoiceItem)
		{
			$LineTotal =  $InvoiceItem->Quantity * $InvoiceItem->Price * (1 - $InvoiceItem->DiscountPercent);
			echo '<tr>';
			$_SESSION['EditInvoiceItems']->total =$_SESSION['EditInvoiceItems']->total +$LineTotal;
			echo '<input type="hidden" name="id[]" id="stock_'.$InvoiceItem->LineNumber.'" value="'.$InvoiceItem->StockID.'" />';
			echo "<td>".$InvoiceItem->ItemDescription ."</td>";
			echo '<td><input type="text" class="columnPriceClass" name="price[]" id="price_'.$InvoiceItem->LineNumber.'"  value="'.$InvoiceItem->Price.'"></td>';
			echo "<td><a href='" . $_SERVER['PHP_SELF'] . "?" . SID . "&Delete=" . $InvoiceItem->LineNumber . "'>" . _('Remove Product') . "</a></td></tr>";

		}//end foreach ($_SESSION['EditInvoiceItems']->LineItems as $InvoiceItem)
echo '<tr><td>Total</td><td><input type="text" name="invoiceTotal" id="invoiceTotal"
value="'.number_format($_SESSION['EditInvoiceItems']->total,2).'" readonly=""/></td></tr>';
echo '<td><input type="submit" name="submitInvoice" id="submitInvoice" value="Edit Invoice" /></td>';
echo "</td><td><td><input  type=submit name='cancelInvoice' VALUE='" . _('Refresh') . "'
onclick=\"return confirm('" . _('Are you sure you want to refresh') . "');\"></td></tr>";
echo '</table>';
if(isset($_POST['cancelInvoice'])){
		unset($_SESSION['EditInvoiceItems']);
		unset($_SESSION['selectedInvoice']);
		unset($_SESSION['EditInvoiceItems']->LineItems);
		unset($_SESSION['EditInvoiceItems']->LineCounter);
		$_SESSION['EditInvoiceItems'] = new Cart;
		 echo "<meta http-equiv='Refresh' content='0; url=" . $rootpath ."/ManageInvoices.php". "'>";
}
if(isset($_POST['submitInvoice']) && isset($_SESSION['selectedInvoice'])){
		$PostingDate = Date($_SESSION['DefaultDateFormat'],mktime(0,0,0, Date('m'), 0,Date('Y')));
		$PeriodNo = GetPeriod($PostingDate,$db);
      $sql="DELETE FROM invoice_items WHERE invoice_id='".$_SESSION['selectedInvoice']."'";
      $result = DB_query($sql,$db);
			$i=0;
			foreach($_POST['id'] as $value)
			{
        $sql = "INSERT INTO invoice_items (invoice_id,product_id,qty,unitprice,totalinvoice,priority)
        VALUES ('" .$_SESSION['selectedInvoice']. "','" . $_POST['id'][$i] . "',1,
        '" . $_POST['price'][$i] . "','" . $_POST['price'][$i]. "','".$i."')";
        $ErrMsg = _('The record could not be updated because');
        $result = DB_query($sql,$db,$ErrMsg);
				$i++;
			 }
       $sql="SELECT sum(amount) as amount FROM banktrans
       where transno ='".$_SESSION['selectedInvoice']."'";
       $result=DB_query($sql, $db);
       $myrow=DB_fetch_array($result);
       $previousPayment=$myrow['amount'];
      $sql="SELECT invoice_items.*,stockmaster.description as descrip
     	FROM invoice_items,stockmaster
     	WHERE invoice_items.product_id=stockmaster.stockid
     	AND invoice_id='".$_SESSION['selectedInvoice']."'
     	AND invoice_items.totalinvoice > 0
     	ORDER BY stockmaster.discontinued";
     	$result=DB_query($sql, $db);
     	$product_paid=0;
     	$rex=$previousPayment;
     	while ($myrow=DB_fetch_array($result)){
     	$product_paid=$myrow['paid'];
     	$amount= $myrow['totalinvoice'];
     	if($rex>0){
     		if($product_paid == $amount){
     		}
     		else{
     		$balance=$amount-$product_paid;
     		$rex=$rex-$balance;
     		if($rex>0  || $rex==0){
     		$sql = "UPDATE invoice_items SET paid=paid +'".$balance."'
     		WHERE invoice_id='".$_SESSION['selectedInvoice']."'
     		AND product_id like '".$myrow['product_id']."'";
     		DB_query($sql,$db);
     		}
     		else{
     		$rex=$rex+$balance;
     		$sql = "UPDATE invoice_items SET paid=paid +'$rex'
     		WHERE invoice_id='".$_SESSION['selectedInvoice']."'
     		AND product_id like '".$myrow['product_id']."'";
     		DB_query($sql,$db);
     		$rex=0;
     				}
     			}
     		}
     	}
	 	prnMsg( _('products updated'),'success');
	  unset($_SESSION['EditInvoiceItems']);
	  unset($_SESSION['selectedInvoice']);
	  unset($_SESSION['EditInvoiceItems']->LineItems);
	  unset($_SESSION['EditInvoiceItems']->LineCounter);
	  $_SESSION['EditInvoiceItems'] = new Cart;
	  echo "<meta http-equiv='Refresh' content='0; url=" . $rootpath ."/ManageInvoices.php". "'>";
	}//end of if(isset($_POST['submitInvoice'])){
}//end of if (count($_SESSION['EditInvoiceItems']->LineItems)>0)
echo '</form>';
include('includes/footer.inc');
?>
