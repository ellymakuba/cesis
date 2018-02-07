<?php

/* $Id: CustomerReceipt.php 3868 2010-09-30 14:53:59Z tim_schofield $ */
/* $Revision: 1.46 $ */
ob_start();
$PageSecurity = 2;
include('includes/session.inc');

$title = _('Termly Billing');

include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc');
$msg='';

$debtorno= $_REQUEST['debtorno'];
$discount= $_REQUEST['discount'];
if ($_POST['add_discount']==_('Add Discount'))
{
if($discount > 0){
if (!Is_Date($_SESSION['DateBanked'])){
	$_SESSION['DateBanked']= Date($_SESSION['DefaultDateFormat']);
	 
}
$PeriodNo = GetPeriod($_SESSION['DateBanked'],$db);
		
$sql = "SELECT id FROM salesorderdetails
		WHERE  student_id='".$_SESSION['debtorno']."'
		AND period_id='".$_SESSION['period']."' LIMIT 1";
		$result = DB_query($sql,$db);		
		$myrow = DB_fetch_array($result);
		$invoice_id=$myrow['id'];
		
$sql="SELECT ii.id FROM invoice_items ii
INNER JOIN salesorderdetails so ON so.id=invoice_id
WHERE ii.product_id LIKE 'DISCOUNT'
AND so.period_id='" . $_SESSION['period'] . "'";
$result=DB_query($sql,$db);
$myrow=DB_fetch_row($result);
if($myrow[0] > 0){
prnMsg(_(_('Discount ').'has already been added for this period'),	'warn');
	}
	else{

$sql = "INSERT INTO invoice_items ( invoice_id,product_id,
															qty,
															unitprice,
															totalinvoice
															)
										VALUES ('".$invoice_id."',
												'DISCOUNT',
												1,
												'".$discount ."',
												'".-$discount ."'
												)";
	$DbgMsg = _('The SQL that failed was');
	$ErrMsg = _('Unable to add the quotation line');
	$Ins_LineItemResult = DB_query($sql,$db,$ErrMsg,$DbgMsg,true);	
	
	mysql_connect("localhost", "elly", "masinde");
	mysql_select_db("cmc") or die(mysql_error());
	$query = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
			VALUES (10,
				'".$id."',
				'".date('Y-m-d H-i-s')."',
				'" . $PeriodNo . "',
				1100,
				'".-$discount."')";
	$result = mysql_query($query);
	
	$query = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
										VALUES (10,
										'".$id."',
										'".date('Y-m-d H-i-s')."',
										'" . $PeriodNo . "',
										4900,
										'".$discount."'
												)";
	$result = mysql_query($query);
	mysql_close($result);	
		}	
	}

}
if ($_POST['Bill']==_('Bill Student'))
{
if (!Is_Date($_SESSION['DateBanked'])){
	$_SESSION['DateBanked']= Date($_SESSION['DefaultDateFormat']);
	 
}
$PeriodNo = GetPeriod($_SESSION['DateBanked'],$db);
$sql = "SELECT id
		FROM salesorderdetails
		WHERE period_id='".$_SESSION['period']."'
		AND student_id='".$_SESSION['debtorno']."'";
		$result = DB_query($sql,$db);		
		$myrow = DB_fetch_row($result);
if ($myrow[0]>0) {
   exit("This student has already been billed for this term.");
} else {  
		
		$sql = "SELECT ab.* FROM autobilling ab
		INNER JOIN debtorsmaster dm ON dm.course_id=ab.course_id
		WHERE  dm.debtorno='".$_SESSION['debtorno']."'
		AND ab.term_id='".$_SESSION['period']."'";
		$result = DB_query($sql,$db);		
		$num_rows = DB_num_rows($result);
		if ($num_rows<0 || $num_rows==0) {
   exit("The student's fee structure has not been created for this period.");
} else {
$sql = "SELECT stockid FROM stockmaster
		WHERE  description LIKE 'hostel fee' LIMIT 1";
		$result = DB_query($sql,$db);		
		$myrow = DB_fetch_array($result);
		$hostel_fee=$myrow['stockid'];

$sql = "SELECT stockid FROM stockmaster
		WHERE  description LIKE 'transport fee' LIMIT 1";
		$result = DB_query($sql,$db);		
		$myrow = DB_fetch_array($result);
		$transport_fee=$myrow['stockid'];
		
$sql = "SELECT hostel FROM debtorsmaster
		WHERE  debtorno='".$_SESSION['debtorno']."'";
		$result = DB_query($sql,$db);		
		$myrow = DB_fetch_array($result);
		$hostel_status=$myrow['hostel'];
		
$sql = "SELECT transport FROM debtorsmaster
		WHERE  debtorno='".$_SESSION['debtorno']."'";
		$result = DB_query($sql,$db);		
		$myrow = DB_fetch_array($result);
		$transport_status=$myrow['transport'];		
		
		$sql = "SELECT ab.* FROM autobilling ab
		INNER JOIN debtorsmaster dm ON dm.course_id=ab.course_id
		WHERE  dm.debtorno='".$_SESSION['debtorno']."'
		AND ab.term_id='".$_SESSION['period']."'";
		$result = DB_query($sql,$db);		
		$myrow = DB_fetch_array($result);
		$auto_id=$myrow['id'];
		
		$sql = "INSERT INTO salesorderdetails ( 	
		student_id,invoice_date,transactiondate,addedby,period_id)
		VALUES ('".$_SESSION['debtorno']."',
		'".date('Y-m-d H-i-s')."',
		'" . date('Y-m-d H-i-s'). "',
		'" . trim($_SESSION['UserID']) . "',
		'" . $_SESSION['period'] . "')";
	$DbgMsg = _('The SQL that failed was');
	$ErrMsg = _('Unable to add the quotation line');
	$Ins_LineItemResult = DB_query($sql,$db,$ErrMsg,$DbgMsg,true);
	$sql="SELECT LAST_INSERT_ID()";
	$result = DB_query($sql,$db);
	$myrow = DB_fetch_row($result);
	$id = $myrow[0];
	
	$glquery = "SELECT SUM(amount) as total FROM autobilling_items 
	WHERE autobilling_id='".$auto_id."'";
	$glresult = DB_query($glquery,$db);
	$glmyrow = DB_fetch_array($glresult);
	$glamount = $glmyrow['total'];	
	mysql_connect("localhost", "elly", "masinde");
	mysql_select_db("cmc") or die(mysql_error());
	$query = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
			VALUES (10,
				'".$id."',
				'".date('Y-m-d H-i-s')."',
				'" . $PeriodNo . "',
				1100,
				'".$glamount."')";
	$result = mysql_query($query);
	
	$query = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
										VALUES (10,
										'".$id."',
										'".date('Y-m-d H-i-s')."',
										'" . $PeriodNo . "',
										1,
										'".-$glamount."'
												)";
	$result = mysql_query($query);
	
	if($hostel_status==1){
	$query = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
			VALUES (10,
				'".$id."',
				'".date('Y-m-d H-i-s')."',
				'" . $PeriodNo . "',
				1100,
				4000)";
	$result = mysql_query($query);
	
	$query = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
										VALUES (10,
										'".$id."',
										'".date('Y-m-d H-i-s')."',
										'" . $PeriodNo . "',
										1,
										-4000
												)";
	$result = mysql_query($query);
	}
	
	if($transport_status==1){
	$query = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
			VALUES (10,
				'".$id."',
				'".date('Y-m-d H-i-s')."',
				'" . $PeriodNo . "',
				1100,
				1200)";
	$result = mysql_query($query);
	
	$query = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
										VALUES (10,
										'".$id."',
										'".date('Y-m-d H-i-s')."',
										'" . $PeriodNo . "',
										1,
										-1200
												)";
	$result = mysql_query($query);
	}
	mysql_close($result);	
	
	$sql3 = "SELECT * FROM autobilling_items 
		WHERE autobilling_id='".$auto_id."'";
		$result3 = DB_query($sql3,$db);		
	
	while($myrow3 = DB_fetch_array($result3))
	{	
	$sql = "INSERT INTO invoice_items ( invoice_id,product_id,
															qty,
															unitprice,
															totalinvoice,
															priority
															)
										VALUES ('".$id."',
												'".$myrow3['product_id']."',
												1,
												'".$myrow3['amount']."',
												'".$myrow3['amount']."',
												'".$myrow3['priority']."'
												)";
	$DbgMsg = _('The SQL that failed was');
	$ErrMsg = _('Unable to add the quotation line');
	$Ins_LineItemResult = DB_query($sql,$db,$ErrMsg,$DbgMsg,true);				
					
		}
		if($hostel_status==1){
		$sql = "INSERT INTO invoice_items ( invoice_id,product_id,
															qty,
															unitprice,
															totalinvoice,
															priority
															)
										VALUES ('".$id."',
												'".$hostel_fee."',
												1,
												1,
												4000,
												0
												)";
	$DbgMsg = _('The SQL that failed was');
	$ErrMsg = _('Unable to add the record');
	$Ins_LineItemResult = DB_query($sql,$db,$ErrMsg,$DbgMsg,true);	
		}
		if($transport_status==1){
		$sql = "INSERT INTO invoice_items ( invoice_id,product_id,
															qty,
															unitprice,
															totalinvoice,
															priority
															)
										VALUES ('".$id."',
												'".$transport_fee."',
												1,
												1,
												1200,
												0
												)";
	$DbgMsg = _('The SQL that failed was');
	$ErrMsg = _('Unable to add the record');
	$Ins_LineItemResult = DB_query($sql,$db,$ErrMsg,$DbgMsg,true);	
		}
	
}		

exit("Student has been succesfully billed...");
}
}

echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . '>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '<table border="1">';
echo '<tr><td>' . _('Period') . ":</td>
		<td><select name='period'>";
		echo '<OPTION SELECTED VALUE=0>' . _('Select Period');
		$sql="SELECT cp.id,terms.title,years.year FROM collegeperiods cp
		INNER JOIN terms ON terms.id=cp.term_id
		INNER JOIN years ON years.id=cp.year ";
		$result=DB_query($sql,$db);
		while ($myrow = DB_fetch_array($result)) {
		echo '<option value='. $myrow['id'].  '>'.' '.$myrow['title'].' '.$myrow['year'];
		} //end while loop
		DB_data_seek($result,0);
		echo '</select></td></tr>';
	DB_data_seek($result,0);
	echo '</select></td></tr>';
	echo "<input type='hidden' name='studentno' value='".$debtorno."'>";
		echo '<table border="1">';
echo "<br><div class='centre'><input  type='Submit' name='submit' value='" . _('Submit') . "'>&nbsp;<input  type=submit action=RESET VALUE='" . _('Reset') . "'></div>";	

if (isset($_POST['submit'])) {
session_start();
$_SESSION['period'] = $_POST['period'];
$_SESSION['debtorno'] = $_POST['studentno'];
$sql = "SELECT SUM(totalinvoice) as total FROM invoice_items,salesorderdetails 
		WHERE salesorderdetails.id=invoice_items.invoice_id
		AND student_id='".$_SESSION['debtorno']."'";

            $DbgMsg = _('The SQL that was used to retrieve the information was');
            $ErrMsg = _('Could not check whether the group is recursive because');

            $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);

            $row = DB_fetch_array($result);
			$studenttotal = $row['total'];
			
$sql = "SELECT SUM(ovamount) as totalpayment FROM debtortrans WHERE debtorno='".$_SESSION['debtorno']."'";
  $DbgMsg = _('The SQL that was used to retrieve the information was');
 $ErrMsg = _('Could not check whether the group is recursive because');
            $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);

            $row = DB_fetch_array($result);
			$studenttotalpayment = -$row['totalpayment'];
			$totalbalance=$studenttotal-$studenttotalpayment;
echo "<TABLE BORDER=2><TR><td><INPUT TYPE=SUBMIT NAME='Bill' VALUE='" . _('Bill Student') . "'><INPUT TYPE=SUBMIT NAME='open' VALUE='" . _('Open Period') . "'>
<INPUT TYPE=SUBMIT NAME='add_discount' VALUE='" . _('Add Discount') . "'></td></tr></table></BR>";

$sql2="SELECT t.title,cp.*,y.year FROM terms t
	INNER JOIN collegeperiods cp ON cp.term_id=t.id
	INNER JOIN years y ON y.id=cp.year
	WHERE cp.id='".$_SESSION['period'] ."'";
	$result2=DB_query($sql2,$db);
	$myrow2 = DB_fetch_array($result2);
	$period_name=$myrow2['title']._(' ').$myrow2['year'];
	
$sql="SELECT * FROM debtorsmaster
	WHERE debtorno='".$_SESSION['debtorno'] ."'";
	$result=DB_query($sql,$db);
	$myrow = DB_fetch_array($result);
	$name=$myrow['name'];
?>
<table width="640" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="180" valign="top"> 
	
      <table width="90%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolordark="#CCCCCC" bordercolorlight="#CCCCCC" bgcolor="#F2F2F2">
        <tr bgcolor="#F4F4F4"> 
  <td height="30" width="26%"> 
<div align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1">Student RegNo
 :</font></div>
          </td>
          <td height="30" width="74%"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1" color="#000066"><b><?php echo $_SESSION['debtorno']; ?></b></font></td>
        </tr>
        <tr bgcolor="#F4F4F4"> 
          <td height="30" width="26%"> 
            <div align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1">Student Name 
              :</font></div>
          </td>
          <td height="30" width="74%"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1" color="#000066"><b><?php echo $name; ?></b></font></td>
        </tr>
        <tr bgcolor="#F4F4F4"> 
          <td height="30" width="26%"> 
            <div align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1">Period 
              :</font></div>
          </td>
          <td height="30" width="74%"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1" color="#000066"><b><?php echo $period_name; ?></a></b></font></td>
        </tr>
      <tr bgcolor="#F4F4F4"> 
          <td height="30" width="26%"> 
            <div align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1">Current Balance
              :</font></div>
          </td>
          <td height="30" width="74%"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1" color="#000066"><b><?php echo $totalbalance;  ?></a></b></font></td>
        </tr>
		<tr bgcolor="#F4F4F4"> 
          <td height="30" width="26%"> 
            <div align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1">Discount
              :</font></div>
          </td><?php 
        echo  '<td height="30" width="74%"><input type="text" name="discount" value='.$discount.'>'.'</td>'
		 ?>
        </tr>

      </table>
	  
    </td>
  </tr>

</table></b></b>

<?php
$sql = "SELECT ab.* FROM autobilling ab
		INNER JOIN debtorsmaster dm ON dm.course_id=ab.course_id
		WHERE  dm.debtorno='".$_SESSION['debtorno']."'
		AND ab.term_id='".$_SESSION['period']."'";
		$result = DB_query($sql,$db);		
		$myrow = DB_fetch_array($result);
		$auto_id=$myrow['id'];
		
$sql3 = "SELECT ab.*,sm.description FROM autobilling_items ab
INNER JOIN stockmaster sm ON sm.stockid=ab.product_id
WHERE ab.autobilling_id='".$auto_id."'";
$result3 = DB_query($sql3,$db);		
$total=0;
$num_rows=DB_num_rows($result3);
if(	$num_rows > 0){ ?>
<table width="50%"><tr bgcolor="#F4F4F4"> 
          <th height="30" colspan="3">
Fee Structure</th></tr>
<?php
	while($myrow3 = DB_fetch_array($result3)){ 
	$total=$total+$myrow3['amount'];
 echo  '<tr bgcolor="#F4F4F4"><td height="30" width="74%"><input type="checkbox" name="id[]" value='.$myrow3['id'].'>'.$myrow3['id'].'</td>';
	?>
          <td height="30"><input type="text" name="product_id<?php echo $myrow3['id'] ?>" value="<?php echo $myrow3['description'] ?>"  readonly='' /></td>
 <td height="30"><input type="text" name="amount<?php echo $myrow3['id'] ?>" value="<?php 

echo  $myrow3['amount']; ?>"  readonly='' />
<?php 
echo "</td></tr>";
}
$sql = "SELECT hostel FROM debtorsmaster
		WHERE  debtorno='".$_SESSION['debtorno']."'";
		$result = DB_query($sql,$db);		
		$myrow = DB_fetch_array($result);
		$hostel_status=$myrow['hostel'];
if($hostel_status==1){
$hostel=4000;
echo  '<tr bgcolor="#F4F4F4"><td height="30" width="74%"><input type="checkbox" name="hostel_name" value='._('Hostel Fee').'></td><td>'._('Hostel Fee').'</td>
<td height="30" width="74%"><input type="text" name="hostel" value='.$hostel.' readonly="" >'.'</td></tr>';
}

$sql = "SELECT transport FROM debtorsmaster
		WHERE  debtorno='".$_SESSION['debtorno']."'";
		$result = DB_query($sql,$db);		
		$myrow = DB_fetch_array($result);
		$transport_status=$myrow['transport'];
if($transport_status==1){
$transport=1200;
echo  '<tr bgcolor="#F4F4F4"><td height="30" width="74%"><input type="checkbox" name="transport_name" value='._('Transport Fee').'></td><td>'._('Transport Fee').'</td>
<td height="30" width="74%"><input type="text" name="transport" value='.$transport.' readonly="" >'.'</td></tr>';
}
$additions=0;
$sql = "SELECT hostel FROM debtorsmaster
		WHERE  debtorno='".$_SESSION['debtorno']."'";
		$result = DB_query($sql,$db);		
		$myrow = DB_fetch_array($result);
		$hostel_status=$myrow['hostel'];
if($hostel_status==1){
$additions=$additions+4000;
}
$sql = "SELECT transport FROM debtorsmaster
WHERE  debtorno='".$_SESSION['debtorno']."'";
$result = DB_query($sql,$db);		
$myrow = DB_fetch_array($result);
$transport_status=$myrow['transport'];
if($transport_status==1){
$additions=$additions+1200;
}
 ?>
<tr><td>Total</td><td><?php echo $total+$additions; ?></td></tr>
</table></b></b>
<?php	
	}
	else{
prnMsg(_('Students Fee Structure has not been created for this period,therefore you cannot bill the student'),	'warn');
}
}

include('includes/footer.inc');
?>
