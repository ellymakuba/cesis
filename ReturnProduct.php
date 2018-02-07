<?php
/* $Revision: 1.21 $ */
/* $Id: BankAccounts.php 3845 2010-09-30 14:50:07Z tim_schofield $*/

$PageSecurity = 10;

include('includes/session.inc');

$title = _('Issue Product');

include('includes/header.inc');

echo '<p class="page_title_text">' . ' ' . _('Return Product Form') . '';   

if (isset($_GET['id'])) {
	$_SESSION['id']=$_GET['id'];
}    

if (isset($_GET['SelectedProduct'])) {
	$SelectedProduct=$_GET['SelectedProduct'];
} elseif (isset($_POST['SelectedProduct'])) {
	$SelectedProduct=$_POST['SelectedProduct'];
}

if (isset($Errors)) {
	unset($Errors);
}

$Errors = array();

if (isset($_POST['issue'])) {
	$InputError = 0;
	
$sql="UPDATE issued_products
				SET quantity_returned=quantity_returned+'" . $_POST['quantity'] . "',
				date_returned='" . $_POST['date'] . "'
				WHERE id='" . $_SESSION['id'] . "'";
		$ErrMsg = _('The item could not be updated because');
		$result = DB_query($sql,$db,$ErrMsg);
		prnMsg( _('Item updated'),'success');
		
		$sql="UPDATE stockmaster
				SET quantity= quantity + '" . $_POST['quantity'] . "'
				WHERE id='".$SelectedProduct. "'";
		$ErrMsg = _('The item could not be updated because');
			$result = DB_query($sql,$db,$ErrMsg);
			prnMsg( _('Item updated'),'success');


} 

echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . "?" . SID . ">";
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
if (isset($SelectedProduct) AND !isset($_GET['delete'])) {
	//editing an existing bank account  - not deleting

	$sql = "SELECT *
		FROM stockmaster
		WHERE id='$SelectedProduct'";

	$result = DB_query($sql, $db);
	$myrow = DB_fetch_array($result);
	
	$sql2 = "SELECT *
		FROM issued_products
		WHERE id='".$_SESSION['id']."'";

	$result2 = DB_query($sql2, $db);
	$myrow2 = DB_fetch_array($result2);

	$_POST['description'] = $myrow['description'];
	$_POST['product_code']  = $myrow['stockid'];
	$_POST['issued_to']  = $myrow2['issued_to'];
	$_POST['product_id']  = $myrow['product_id'];
	
	echo '<input type=hidden name=SelectedProduct VALUE=' . $SelectedProduct . '>';
	echo '<input type=hidden name=product_code VALUE=' . $_POST['product_code'] . '>';
	echo '<table class=selection width="50%"> ';
} else { //end of if $Selectedbank account only do the else when a new record is being entered
	echo '<table class=selection width="80%"><tr>';

	
}

// Check if details exist, if not set some defaults
if (!isset($_POST['description'])) {
	$_POST['description']='';
}
if (!isset($_POST['units'])) {
	$_POST['units']='';
}
if (!isset($_POST['processingdate'])) {
        $_POST['processingdate']='';
}
if (!isset($_POST['quantity'])) {
	$_POST['quantity']='';
}
if (!isset($_POST['type'])) {
	$_POST['type']='';
}
if (!isset($_POST['issued_to'])) {
	$_POST['issued_to']='';
}
if (!isset($_POST['level'])) {
	$_POST['level']='';
}
if (!isset($_POST['permanent'])) {
	$_POST['permanent']='';
}
echo '<input type="hidden"  name="product_id" value="' . $_POST['product_id'] . '"></td></tr>';

			echo '<tr><td class="visible">'._('Date Returned').":</td>
			<td class=\"visible\"><input type='text' class='date' alt='".$_SESSION['DefaultDateFormat']."' name='processingdate' maxlength=10 size=20></td></tr>";	
echo '<tr><td class="visible">' . _('Product Code') . ': </td>
			<td class="visible"><input tabindex="2" ' . (in_array('product_code',$Errors) ?  'class="inputerror"' : '' ) .' type="Text" name="product_code" value="' . $_POST['product_code'] . '" size=40 maxlength=50></td></tr>
		<tr><td class="visible">' . _('Product Name') . ': </td>
                        <td class="visible"><input tabindex="3" ' . (in_array('description',$Errors) ?  'class="inputerror"' : '' ) .' type="Text" name="description" value="' . $_POST['description'] . '" size=40 maxlength=50></td></tr>
		<tr><td class="visible">' . _('Quantity Retuned') . ': </td>
         <td class="visible"><input tabindex="3" ' . (in_array('quantity',$Errors) ?  'class="inputerror"' : '' ) .' type="text" name="quantity" value="' . $_POST['quantity'] . '" size=30 maxlength=50></td></tr>';
echo '</tr></table><br>';

echo '<div class="centre"><input tabindex="7" type="Submit" name="issue" value="'. _('Return Product') .'"></div>';

echo '</form>';
include('includes/footer.inc');
?>
