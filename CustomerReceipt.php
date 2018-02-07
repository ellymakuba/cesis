<?php
$PageSecurity = 3;
include('includes/session.inc');
$title = _('Receipt Entry');
include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc');
if (isset($_REQUEST['id'])) {
$_SESSION['invoice_id'] = $_REQUEST['id'];
}
$msg='';
?>
<html><body><br /><br /><br />
<table class='enclosed'>
	<form name="payment" action="CustomerReceipt.php" method="post">
<?php
if(isset($_REQUEST['receiptno'])){
	$_SESSION['receiptno']=$_REQUEST['receiptno'];
	$sql="select transno,ovamount,receipt_no,invtext,inputdate from debtortrans where id='".$_SESSION['receiptno']."'";
	$result=DB_query($sql,$db);
	$row=DB_fetch_array($result);
	$_SESSION['invoice_id']=$row['transno'];
	$_POST['paid']=-$row['ovamount'];
	$_POST['receipt']=$row['receipt_no'];
	$_POST['notes']=-$row['invtext'];
	$_POST['inputdate']=$row['inputdate'];
}
if (isset($_SESSION['invoice_id'])){
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	$sql = "SELECT so.*,dm.name FROM salesorderdetails so
	INNER JOIN debtorsmaster dm ON dm.debtorno=so.student_id
	WHERE so.id='".$_SESSION['invoice_id']."'";
	$DbgMsg = _('The SQL that was used to retrieve the information was');
	$ErrMsg = _('Could not check whether the group is recursive because');
	$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
	$row = DB_fetch_array($result);
	$student_id = $row['student_id'];
?>
<tr><td>Student:<input type="text"  name="student_id" value="<?php echo $student_id ?>" readonly=""/>
<?php echo $row['name'] ?></td>
<input type="hidden"  name="invoice_id" value="<?php echo $_SESSION['invoice_id'] ?>"/>
<td>Receipt NO:<input type="text"  name="receipt" value="<?php echo $_POST['receipt'] ?>"/></td></tr>
</table>
<table class=enclosed>
<tr><th>Product</th><th>Amount</td><th>Paid</td></tr>
<?php
$sql = "SELECT SUM(totalinvoice) as total FROM invoice_items
WHERE  invoice_id='".$_SESSION['invoice_id']."'";
$DbgMsg = _('The SQL that was used to retrieve the information was');
$ErrMsg = _('Could not check whether the group is recursive because');
$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
$row = DB_fetch_array($result);
$invoice_total = $row['total'];
$sql="SELECT invoice_items.*,stockmaster.description as descrip
FROM invoice_items,stockmaster
WHERE invoice_items.product_id=stockmaster.stockid
AND invoice_id='".$_SESSION['invoice_id']."'
ORDER BY stockmaster.discontinued";
$result=DB_query($sql, $db);
$Level=0;
while ($myrow=DB_fetch_array($result)){
	echo '<tr>';
	echo '<td>'.$myrow['descrip'].'</td>';
	echo '<td>'.$myrow['totalinvoice'].'</td>';
	echo '<td>'.$myrow['paid'].'</td>';
	echo '</tr>';
}
?>
<tr><td>Invoice total:</td><td><input type="text"  name="total_invoice" value="<?php echo $invoice_total ?>" readonly=""/>
</table><table class=enclosed>
<?php
$sql = "SELECT SUM(ovamount) as paidsum FROM debtortrans
WHERE transno='".$_SESSION['invoice_id']."'";
$DbgMsg = _('The SQL that was used to retrieve the information was');
$ErrMsg = _('Could not check whether the group is recursive because');
$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
$row = DB_fetch_array($result);
$paidsum=-$row['paidsum'];
if($paidsum<=0)
{
		$paidsum=0;
}
?>
<tr><td>Bank Account:</td><td><select  name="account_code" >
<?php
$SQL = "SELECT	bankaccounts.accountcode,bankaccounts.bankaccountname
FROM bankaccounts,chartmaster
WHERE bankaccounts.accountcode=chartmaster.accountcode AND invoice=1";
$ErrMsg =_('The bank account name cannot be retrieved because');
$result= DB_query($SQL,$db,$ErrMsg);
while(list($accountcode, $accountname) = DB_fetch_row($result)) {
		echo '<option value="' . $accountcode . '">' . $accountname . '</option>';
}
?></select>
</td></tr>
<tr><td>Payment Method:</td><td><select  name="payment_method" >
<?php
	include('includes/GetPaymentMethods.php');
foreach ($ReceiptTypes as $RcptType) {
	if (isset($_POST['ReceiptType']) and $_POST['ReceiptType']==$RcptType){
		echo "<option selected Value='$RcptType'>$RcptType";
	} else {
		echo "<option Value='$RcptType'>$RcptType";
	}
}
echo '</select>
</td></tr>
<tr><td>Date(M/D/Y):</td><td><input type="text"  name="payment_date" value="'.$_POST['payment_date'].'"  class="date" readonly>
<tr><td>Amount:</td><td><input type="text"  name="amount" value="'.$_POST['paid'].'"></td></tr>
<input type="hidden"  name="paid" value="'.$_POST['paid'].'">
<tr><td>Notes:</td><td><textarea name="notes" value="'.$_POST['notes'].'"></textarea></td></tr>
</td></tr></table>
<div class="centre"><input type="submit"  name="payment" onClick="confirmation()" value="Receive Payment"></div>
</form>';
}
$_SESSION['DateBanked']= Date($_SESSION['DefaultDateFormat']);
$SQL = "SELECT currabrev FROM currencies,debtorsmaster WHERE
debtorsmaster.currcode=currencies.currabrev
AND debtorsmaster.debtorno='" . $_POST['student_id']."'";
$ErrMsg =_('The currency name cannot be retrieved because');
$result= DB_query($SQL,$db,$ErrMsg);
$row = DB_fetch_row($result);
$currcode=$row[0];
$_SESSION['Currency']=$currcode;
$PeriodNo = GetPeriod($_SESSION['DateBanked'],$db);
if (isset($Errors)) {
	unset($Errors);
}
$Errors = array();
$InputError = 0;
if (isset($_POST['payment'])) {
	$sql = "SELECT fullaccess FROM www_users
			WHERE userid=  '" . trim($_SESSION['UserID']) . "'";
			$result=DB_query($sql,$db);
			$myrow=DB_fetch_row($result);
			$administrator_rights=$myrow[0];
	$i=1;
	if (empty($_POST['payment_date'])) {
		$InputError = 1;
		prnMsg( _('Please enter a validate date'),'error');
		$Errors[$i] = 'payment_date';
		$i++;
	}
	if(($_POST['account_code']) ==0 ){
		$InputError = 1;
		prnMsg( _('Please Select a Bank account'),'error');
		$Errors[$i] = 'account_code';
		$i++;
	}
	if(strlen($_POST['receipt'])==0){
		$InputError = 1;
		prnMsg( _('Receipt No field cannot be empty'),'error');
		$Errors[$i] = 'receipt';
		$i++;
	}
	if($_POST['amount']<0 && $administrator_rights !=8){
		$InputError = 1;
		prnMsg( _('You cant post negative amount, please contact the administrator'),'error');
		$Errors[$i] = 'amount';
		$i++;
	}
	if($InputError==0){
		if(!isset($_SESSION['receiptno'])){
	$sql = "INSERT INTO debtortrans (transno,type,debtorno,trandate,inputdate,prd,ovamount,addedby,invtext,receipt_no)
	VALUES ('".$_SESSION['invoice_id']."',12,'".$_POST['student_id']."','".FormatDateForSQL($_POST['payment_date'])."',
	'" . date('Y-m-d H-i-s') . "','".$PeriodNo."','".-$_POST['amount']."','" . trim($_SESSION['UserID']) . "','".$_POST['notes']."','".$_POST['receipt']."')";
	$DbgMsg = _('The SQL that failed was');
	$ErrMsg = _('Unable to add the quotation line');
	$Ins_LineItemResult = DB_query($sql,$db,$ErrMsg,$DbgMsg,true);

	$sqltrans="SELECT LAST_INSERT_ID()";
	$resulttrans = DB_query($sqltrans,$db);
	$myrowtrans = DB_fetch_row($resulttrans);
	$transid = $myrowtrans[0];


	$SQL="INSERT INTO banktrans(type,transno,bankact,ref,exrate,functionalexrate,transdate,banktranstype,amount,
	inputdate,addedby,currcode,studenttransid)
	VALUES (12,'".$_SESSION['invoice_id']."','" . $_POST['account_code']. "','" .$_POST['notes']."',1,1,'".FormatDateForSQL($_POST['payment_date'])."',
	'" .$_POST['payment_method']  . "','" .$_POST['amount']  . "','" . date('Y-m-d') . "','" . trim($_SESSION['UserID']) . "',
	'" . $_SESSION['Currency'] . "','$transid')";
	$DbgMsg = _('The SQL that failed to insert the bank account transaction was');
	$ErrMsg = _('Cannot insert a bank transaction');
	$result = DB_query($SQL,$db,$ErrMsg,$DbgMsg,true);

	$sql="SELECT invoice_items.*,stockmaster.description as descrip
	FROM invoice_items,stockmaster
	WHERE invoice_items.product_id=stockmaster.stockid
	AND invoice_id='".$_SESSION['invoice_id']."'
	AND invoice_items.totalinvoice > 0
	ORDER BY stockmaster.discontinued";
	$result=DB_query($sql, $db);
	$product_paid=0;
	$rex=$_POST['amount'];
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
		$sqlInner = "UPDATE invoice_items SET paid=paid +'".$balance."'
		WHERE invoice_id='".$_SESSION['invoice_id']."'
		AND product_id like '".$myrow['product_id']."'";
	  DB_query($sqlInner,$db);

		$sqlInner= "INSERT INTO votehead_payments(receipt_no,product,paid)
		VALUES('".$transid."','".$myrow['product_id']."','".$balance."')";
		DB_query($sqlInner, $db);
    }
		else{
		$rex=$rex+$balance;
		$sqlInner= "UPDATE invoice_items SET paid=paid +'$rex'
		WHERE invoice_id='".$_SESSION['invoice_id']."'
		AND product_id like '".$myrow['product_id']."'";
		DB_query($sqlInner,$db);

		$sqlInner= "INSERT INTO votehead_payments(receipt_no,product,paid)
		VALUES('".$transid."','".$myrow['product_id']."','".$rex."')";
		DB_query($sqlInner, $db);
		$rex=0;
			}
			}
		}
	}
}
else{
	$sql="select sum(ovamount) as paid from debtortrans where transno='".$_SESSION['invoice_id']."'";
	$result=DB_query($sql,$db);
	$row=DB_fetch_array($result);
	$amountPaidOnInvoice=-$row['paid'];
	$amountPaidOnInvoice=$amountPaidOnInvoice-$_POST['paid'];

	$sql = "update banktrans set transdate='".FormatDateForSQL($_POST['payment_date'])."',
	amount='".$_POST['amount']."',
	ref='".$_POST['notes']."'
	WHERE transno='".$_SESSION['invoice_id']."'
	AND inputdate='".$_POST['inputdate']."'";
	DB_query($sql,$db);

	$sql = "update debtortrans set trandate='".FormatDateForSQL($_POST['payment_date'])."',
	ovamount='".-$_POST['amount']."',
	invtext='".$_POST['notes']."',
	receipt_no='".$_POST['receipt']."'
	WHERE id='".$_SESSION['receiptno']."'";
	DB_query($sql,$db);

	$sql="delete from votehead_payments where receipt_no='".$_SESSION['receiptno']."'";
	DB_query($sql,$db);
	$sql = "update invoice_items set paid=0	WHERE invoice_id='".$_SESSION['invoice_id']."'";
	DB_query($sql,$db);
 	$sql="SELECT invoice_items.*,stockmaster.description as descrip
	FROM invoice_items,stockmaster
	WHERE invoice_items.product_id=stockmaster.stockid
	AND invoice_id='".$_SESSION['invoice_id']."'
	AND invoice_items.totalinvoice > 0
	ORDER BY stockmaster.discontinued";
	$result=DB_query($sql, $db);
	$product_paid=0;
	$rex=$_POST['amount']+$amountPaidOnInvoice;
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
		$sqlInner = "UPDATE invoice_items SET paid=paid +'".$balance."'
		WHERE invoice_id='".$_SESSION['invoice_id']."'
		AND product_id like '".$myrow['product_id']."'";
	  DB_query($sqlInner,$db);

		$sqlInner= "INSERT INTO votehead_payments(receipt_no,product,paid)
		VALUES('".$_SESSION['receiptno']."','".$myrow['product_id']."','".$balance."')";
		DB_query($sqlInner, $db);
    }
		else{
		$rex=$rex+$balance;
		$sqlInner= "UPDATE invoice_items SET paid=paid +'$rex'
		WHERE invoice_id='".$_SESSION['invoice_id']."'
		AND product_id like '".$myrow['product_id']."'";
		DB_query($sqlInner,$db);

		$sqlInner= "INSERT INTO votehead_payments(receipt_no,product,paid)
		VALUES('".$_SESSION['receiptno']."','".$myrow['product_id']."','".$rex."')";
		DB_query($sqlInner, $db);
		$rex=0;
			}
			}
		}
	}
}//its an old invoice just updating
unset($_SESSION['invoice_id']);
unset($_SESSION['receiptno']);
echo "<meta http-equiv='Refresh' content='0; url=" . $rootpath ."/ManagePayments.php". "'>";
echo '<div class="centre">' . _('You should automatically be forwarded to the Manage Payment Page') .
'. ' . _('If this does not happen') .' (' . _('if the browser does not support META Refresh') . ') ' .
"<a href='" . $rootpath . "/ManagePayments.php". '.</div>';
}
}
include ('includes/GLPostings.inc');
include('includes/footer.inc');
?>
