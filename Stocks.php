<?php
/* $Revision: 1.21 $ */
/* $Id: BankAccounts.php 3845 2010-09-30 14:50:07Z tim_schofield $*/

$PageSecurity = 10;

include('includes/session.inc');

$title = _('Add new product form');

include('includes/header.inc');

echo '<p class="page_title_text">' . ' ' . _('Add new product form') . '';       

if (isset($_GET['SelectedProduct'])) {
	$SelectedProduct=$_GET['SelectedProduct'];
} elseif (isset($_POST['SelectedProduct'])) {
	$SelectedProduct=$_POST['SelectedProduct'];
}

if (isset($Errors)) {
	unset($Errors);
}

$Errors = array();

if (isset($_POST['submit'])) {

	//initialise no input errors assumed initially before we test
	$InputError = 0;

	$i=1;

	$sql="SELECT count(stockid)
			FROM stockmaster WHERE stockid='".$_POST['product_code']."'";
	$result=DB_query($sql, $db);
	$myrow=DB_fetch_row($result);

	if ($myrow[0]>0 and !isset($SelectedProduct)) {
		$InputError = 1;
		prnMsg( _('Stock id already exists in the database'),'error');
		$Errors[$i] = 'stock_id';
		$i++;
	}
	
	if (isset($SelectedProduct) AND $InputError !=1) {
	
			$sql = "UPDATE stockmaster
				SET stockid='" . $_POST['product_code'] . "',
				description='" . $_POST['description'] . "',
				categoryid='" . $_POST['category'] . "',
				units='" . $_POST['units'] . "',
				actualcost='" . $_POST['cost'] . "',
				consumable='" . $_POST['consumable'] . "'
			WHERE stockmaster.id = '" . $SelectedProduct . "'";
		
		$msg = _('The product details have been updated');
	} elseif ($InputError !=1) {

		$sql = "INSERT INTO stockmaster (
						stockid,
						categoryid,
						description,
						units,
						actualcost,
						consumable
						)
				VALUES (
					'" . $_POST['product_code'] . "',
					'" . $_POST['category'] . "',
					'" . $_POST['description'] . "',
					'" . $_POST['units'] . "',
					'" . $_POST['cost'] . "',
					'" . $_POST['consumable'] . "'
					)";
		$msg = _('The new product has been entered');
	}

	//run the SQL from either of the above possibilites
	if( $InputError !=1 ) {
		$ErrMsg = _('The product could not be inserted or modified because');
		$DbgMsg = _('The SQL used to insert/modify the subject details was');
		$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);

		prnMsg($msg,'success');
		echo '<br>';
		unset($_POST['description']);
		unset($_POST['category']);
		unset($_POST['units']);
		unset($_POST['product_code']);
		unset($_POST['cost']);
		unset($_POST['consumable']);
		unset($SelectedProduct);
	}


} elseif (isset($_POST['delete'])) {
	$CancelDelete = 0;

	$sql= "SELECT COUNT(*) FROM purchorderdetails WHERE itemcode='$SelectedProduct'";
	$result = DB_query($sql,$db);

	$myrow = DB_fetch_row($result);
	if ($myrow[0]>0) {
		$CancelDelete = 1;
		prnMsg( _('This product cannot be deleted since there are purchase ordes that refer to it'),'warn');
		echo '<br> ' . _('There are') . ' ' . $myrow[0] . ' ' . _('purcahase orders against this product');

	} 
	if ($CancelDelete==0) { //ie not cancelled the delete as a result of above tests
		$sql="DELETE FROM stockmaster WHERE stockid='" . $_POST['product_code'] . "'";
		$result = DB_query($sql,$db);
		prnMsg( _('Product') . ' ' . $_POST['product_code'] . ' ' . _('has been deleted') . ' !','success');
		include('includes/footer.inc');
		exit;
	} //end if Delete Customer
}

/* Always show the list of accounts */

echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . "?" . SID . ">";
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
if (isset($SelectedProduct) AND !isset($_GET['delete'])) {
	//editing an existing bank account  - not deleting

	$sql = "SELECT *
		FROM stockmaster
		WHERE id='$SelectedProduct'";

	$result = DB_query($sql, $db);
	$myrow = DB_fetch_array($result);

	$_POST['description'] = $myrow['description'];
	$_POST['product_code']  = $myrow['stockid'];
	$_POST['units']  = $myrow['units'];
	$_POST['cost']  = $myrow['actualcost'];
	$_POST['category']  = $myrow['categoryid'];
	$_POST['consumable'] = $myrow['consumable'];
	
	echo '<input type=hidden name=SelectedProduct VALUE=' . $SelectedProduct . '>';
	echo '<input type=hidden name=product_code VALUE=' . $_POST['product_code'] . '>';
	echo '<table class=selection> ';
} else { //end of if $Selectedbank account only do the else when a new record is being entered
	echo '<table class=selection><tr>';

	
}

// Check if details exist, if not set some defaults
if (!isset($_POST['description'])) {
	$_POST['description']='';
}
if (!isset($_POST['units'])) {
	$_POST['units']='';
}
if (!isset($_POST['actual_cost'])) {
        $_POST['actual_cost']='';
}
if (!isset($_POST['consumable'])) {
	$_POST['consumable']='';
}
if (!isset($_POST['product_code'])) {
	$_POST['product_code']='';
}
if (!isset($_POST['category'])) {
	$_POST['category']='';
}


echo '</br><tr><td class="visible">' . _('Product Code') . ': </td>
			<td class="visible"><input tabindex="2" ' . (in_array('product_code',$Errors) ?  'class="inputerror"' : '' ) .' type="Text" name="product_code" value="' . $_POST['product_code'] . '" size=40 maxlength=50></td></tr>
		<tr><td class="visible">' . _('Product Name') . ': </td>
                        <td class="visible"><input tabindex="3" ' . (in_array('description',$Errors) ?  'class="inputerror"' : '' ) .' type="Text" name="description" value="' . $_POST['description'] . '" size=40 maxlength=50></td></tr>
		<tr><td class="visible">' . _('Cost') . ': </td>
                        <td class="visible"><input tabindex="3" ' . (in_array('cost',$Errors) ?  'class="inputerror"' : '' ) .' type="text" name="cost" value="' . $_POST['cost'] . '" size=40 maxlength=50></td></tr>
<tr><td class="visible">' . _('Units') . ': </td><td class="visible"><select tabindex="5" name="units">';
$result = DB_query('SELECT * FROM unitsofmeasure',$db);
while ($myrow = DB_fetch_array($result)) {
	if ($myrow['unitid']==$_POST['unitname']) {
		echo '<option selected VALUE=';
	} else {
		echo '<option VALUE=';
	}
	echo $myrow['unitid'] . '>' . $myrow['unitname'];
} //end while loop
echo '</select></td></tr>

<tr><td class="visible">' . _('Category') . ': </td><td class="visible"><select tabindex="5" name="category">';
$result = DB_query('SELECT * FROM stockcategory',$db);
while ($myrow = DB_fetch_array($result)) {
	if ($myrow['id']==$_POST['category']) {
		echo '<option selected VALUE=';
	} else {
		echo '<option VALUE=';
	}
	echo $myrow['id'] . '>' . $myrow['categorydescription'];
} //end while loop
echo '</select></td></tr>';

echo '<tr><td class="visible">' . _('Consumable') . ':</td><td><select name="consumable">';
if (isset($_POST['consumable']) and $_POST['consumable']==1){
		echo '<option selected value=1>' . _('Yes'). '</option>';
} else {
		echo '<option value=1>' . _('Yes'). '</option>';
}
if (!isset($_POST['consumable']) or $_POST['consumable']==0){
		echo '<option selected value=0>' . _('No'). '</option>';
} else {
		echo '<option value=0>' . _('No'). '</option>';
}

echo '</select></td>';

echo '</tr></table><br>';
if (!isset($SelectedProduct)) {
echo '<div class="centre"><input tabindex="7" type="Submit" name="submit" value="'. _('Add Product') .'"></div>';
}
else{
$sql = "SELECT description
	FROM stockmaster
	WHERE id='$SelectedProduct'";
	$result = DB_query($sql, $db);
	$myrow = DB_fetch_array($result);
	$description=$myrow['description'];
echo "<br><div class='centre'><input type='Submit' name='submit' VALUE='" . _('Update Product') . "'>";
echo '&nbsp;<input type="Submit" name="delete" VALUE="' . _('Delete Product') . '" onclick="return confirm(\'' . _('Are You Sure want to delete').' '.$description._('?') . '\');">';
}
echo '</form>';
include('includes/footer.inc');
?>
