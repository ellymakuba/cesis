<?php
/* $Revision: 1.21 $ */
/* $Id: BankAccounts.php 3845 2010-09-30 14:50:07Z tim_schofield $*/

$PageSecurity = 10;

include('includes/session.inc');

$title = _('Issue Product');

include('includes/header.inc');

echo '<p class="page_title_text">' . ' ' . _('Issue Product') . '';       

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

	//initialise no input errors assumed initially before we test
	$InputError = 0;

		$sql = "INSERT INTO issued_products (
						type,
						date,
						product_id,
						quantity,
						issued_to,
						level,
						permanent
						)
				VALUES (
					'" . $_SESSION['issue_type'] . "',
					'" . FormatDateForSQL($_POST['processingdate']) . "',
					'$SelectedProduct',
					'" . $_POST['quantity'] . "',
					'" . $_POST['issued_to'] . "',
					'" . $_POST['departments'] . "',
					'" . $_POST['permanent'] . "'
					)";
		$msg = _('The new product has been entered');
	

	//run the SQL from either of the above possibilites
	if( $InputError !=1 ) {
		$ErrMsg = _('The product could not be inserted or modified because');
		$DbgMsg = _('The SQL used to insert/modify the subject details was');
		$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
		prnMsg($msg,'success');
		
		$sql="UPDATE stockmaster
				SET quantity= quantity - '" . $_POST['quantity'] . "'
				WHERE id='".$SelectedProduct. "'";
		$ErrMsg = _('The item could not be updated because');
			$result = DB_query($sql,$db,$ErrMsg);
			prnMsg( _('Item updated'),'success');
		echo '<br>';
		unset($_POST['type']);
		unset($_POST['processingdate']);
		unset($_POST['product_id']);
		unset($_POST['quantity']);
		unset($_POST['issued_to']);
		unset($_POST['level']);
		unset($_POST['permanent']);
		unset($SelectedProduct);
	}


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

	$_POST['description'] = $myrow['description'];
	$_POST['product_code']  = $myrow['stockid'];
	$_POST['units']  = $myrow['units'];
	
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

	
			echo '<tr><td class="visible">'._('Date').":</td>
			<td class=\"visible\"><input type='text' class='date' alt='".$_SESSION['DefaultDateFormat']."' name='processingdate' maxlength=10 size=20></td></tr>";	
echo '<tr><td class="visible">' . _('Product Code') . ': </td>
			<td class="visible"><input tabindex="2" ' . (in_array('product_code',$Errors) ?  'class="inputerror"' : '' ) .' type="Text" name="product_code" value="' . $_POST['product_code'] . '" size=40 maxlength=50></td></tr>
		<tr><td class="visible">' . _('Product Name') . ': </td>
                        <td class="visible"><input tabindex="3" ' . (in_array('description',$Errors) ?  'class="inputerror"' : '' ) .' type="Text" name="description" value="' . $_POST['description'] . '" size=40 maxlength=50></td></tr>
		<tr><td class="visible">' . _('Quantity') . ': </td>
         <td class="visible"><input tabindex="3" ' . (in_array('quantity',$Errors) ?  'class="inputerror"' : '' ) .' type="text" name="quantity" value="' . $_POST['quantity'] . '" size=30 maxlength=50></td></tr>
		 <tr><td class="visible">' . _('Issued To') . ': </td>
         <td class="visible"><input tabindex="3" ' . (in_array('issued_to',$Errors) ?  'class="inputerror"' : '' ) .' type="text" name="issued_to" value="' . $_POST['issued_to'] . '" size=40 maxlength=50></td></tr>
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
echo '</select></td></tr>';
echo '<tr><td class="visible">' . _('Level') . ': </td><td class="visible"><select tabindex="5" name="departments">';
echo '<OPTION SELECTED VALUE=0>' . _('Personal');
$result = DB_query('SELECT * FROM departments',$db);
while ($myrow = DB_fetch_array($result)) {
	if ($myrow['id']==$_POST['departments']) {
		echo '<option selected VALUE=';
	} else {
		echo '<option VALUE=';
	}
	echo $myrow['id'] . '>' . $myrow['department_name'].' '._('department');
} //end while loop
echo '</select></td></tr>';
echo '<tr><td class="visible">' . _('Permanently') . ':</td><td class="visible"><select name="permanent">';
if (isset($_POST['permanent']) and $_POST['permanent']==1){
		echo '<option selected value=1>' . _('Yes'). '</option>';
} else {
		echo '<option value=1>' . _('Yes'). '</option>';
}
if (!isset($_POST['permanent']) or $_POST['permanent']==0){
		echo '<option selected value=0>' . _('No'). '</option>';
} else {
		echo '<option value=0>' . _('No'). '</option>';
}

echo '</select></td>';

echo '</tr></table><br>';

echo '<div class="centre"><input tabindex="7" type="Submit" name="issue" value="'. _('Issue Product') .'"></div>';
echo '</form>';
include('includes/footer.inc');
?>
