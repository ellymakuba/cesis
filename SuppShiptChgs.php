<?php

/* $Id: SuppShiptChgs.php 4011 2010-09-30 16:05:22Z tim_schofield $*/

/*The supplier transaction uses the SuppTrans class to hold the information about the invoice
the SuppTrans class contains an array of Shipts objects - containing details of all shipment charges for invoicing
Shipment charges are posted to the debit of GRN suspense if the Creditors - GL link is on
This is cleared against credits to the GRN suspense when the products are received into stock and any
purchase price variance calculated when the shipment is closed */

include('includes/DefineSuppTransClass.php');

$PageSecurity = 5;

/* Session started here for password checking and authorisation level check */
include('includes/session.inc');

$title = _('Shipment Charges or Credits');

include('includes/header.inc');

if ($_SESSION['SuppTrans']->InvoiceOrCredit == 'Invoice'){
	echo '<a href="' . $rootpath . '/SupplierInvoice.php?' . SID . '">' . _('Back to Invoice Entry') . '</a>';
} else {
	echo '<a href="' . $rootpath . '/SupplierCredit.php?' . SID . '">' . _('Back to Credit Note Entry') . '</a>';
}

if (!isset($_SESSION['SuppTrans'])){
	prnMsg(_('Shipment charges or credits are entered against supplier invoices or credit notes respectively') . '. ' . _('To enter supplier transactions the supplier must first be selected from the supplier selection screen') . ', ' . _('then the link to enter a supplier invoice or credit note must be clicked on'),'info');
	echo "<br><a href='$rootpath/SelectSupplier.php?" . SID ."'>" . _('Select A Supplier') . '</a>';
	exit;
	/*It all stops here if there aint no supplier selected and invoice/credit initiated ie $_SESSION['SuppTrans'] started off*/
}

/*If the user hit the Add to transaction button then process this first before showing  all GL codes on the invoice otherwise it wouldnt show the latest addition*/

if (isset($_POST['AddShiptChgToInvoice'])){

	$InputError = False;
	if ($_POST['ShiptRef'] == ""){
		$_POST['ShiptRef'] = $_POST['ShiptSelection'];
	}
	if (!is_numeric($_POST['ShiptRef'])){
		prnMsg(_('The shipment reference must be numeric') . '. ' . _('This shipment charge cannot be added to the invoice'),'error');
		$InputError = True;
	}

	if (!is_numeric($_POST['Amount'])){
		prnMsg(_('The amount entered is not numeric') . '. ' . _('This shipment charge cannot be added to the invoice'),'error');
		$InputError = True;
	}

	if ($InputError == False){
		$_SESSION['SuppTrans']->Add_Shipt_To_Trans($_POST['ShiptRef'], $_POST['Amount']);
		unset($_POST['ShiptRef']);
		unset($_POST['Amount']);
	}
}

if (isset($_GET['Delete'])){

	$_SESSION['SuppTrans']->Remove_Shipt_From_Trans($_GET['Delete']);
}

/*Show all the selected ShiptRefs so far from the SESSION['SuppInv']->Shipts array */
if ($_SESSION['SuppTrans']->InvoiceOrCredit=='Invoice'){
	echo '<div class="centre"><p class="page_title_text">'. _('Shipment charges on Invoice') . ' ';
} else {
	echo '<div class="centre"><p class="page_title_text">' . _('Shipment credits on Credit Note') . ' ';
}
echo $_SESSION['SuppTrans']->SuppReference . ' ' ._('From') . ' ' . $_SESSION['SuppTrans']->SupplierName;
echo '</div>';
echo '<table cellpadding=2 class=selection>';
$TableHeader = '<tr><th>' . _('Shipment') . '</th>
		<th>' . _('Amount') . '</th></tr>';
echo $TableHeader;

$TotalShiptValue = 0;

foreach ($_SESSION['SuppTrans']->Shipts as $EnteredShiptRef){

	echo '<tr><td>' . $EnteredShiptRef->ShiptRef . '</td>
		<td class=number>' . number_format($EnteredShiptRef->Amount,2) . '</td>
		<td><a href="' . $_SERVER['PHP_SELF'] . '?' . SID . '&Delete=' . $EnteredShiptRef->Counter . '">' . _('Delete') . '</a></td></tr>';

	$TotalShiptValue = $TotalShiptValue + $EnteredShiptRef->Amount;

}

echo '<tr>
	<td class=number><font size=2 color=navy>' . _('Total') . ':</font></td>
	<td class=number><font size=2 color=navy><U>' . number_format($TotalShiptValue,2) . '</U></font></td>
</tr>
</table><br />';

/*Set up a form to allow input of new Shipment charges */
echo '<form action="' . $_SERVER['PHP_SELF'] . '?' . SID . '" method="post">';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';

if (!isset($_POST['ShiptRef'])) {
	$_POST['ShiptRef']='';
}
echo '<table class=selection>';
echo '<tr><td>' . _('Shipment Reference') . ':</td>
	<td><input type="text" name="ShiptRef" size="12" maxlength="11" VALUE="' .  $_POST['ShiptRef'] . '"></td></tr>';
echo '<tr><td>' . _('Shipment Selection') . ':<br> ' . _('If you know the code enter it above') . '<br>' . _('otherwise select the shipment from the list') . '</td><td><select name="ShiptSelection">';

$sql = 'SELECT shiptref,
							vessel,
							eta,
							suppname
						FROM shipments INNER JOIN suppliers
							ON shipments.supplierid=suppliers.supplierid
						WHERE closed=0';

$result = DB_query($sql, $db);

while ($myrow = DB_fetch_array($result)) {
	if (isset($_POST['ShiptSelection']) and $myrow['shiptref']==$_POST['ShiptSelection']) {
		echo '<option selected VALUE=';
	} else {
		echo '<option VALUE=';
	}
	echo $myrow['shiptref'] . '>' . $myrow['shiptref'] . ' - ' . $myrow['vessel'] . ' ' . _('ETA') . ' ' . ConvertSQLDate($myrow['eta']) . ' ' . _('from') . ' ' . $myrow['suppname']  . '</option>';
}

echo '</select></td></tr>';

if (!isset($_POST['Amount'])) {
	$_POST['Amount']=0;
}
echo '<tr><td>' . _('Amount') . ':</td>
	<td><input type="text" name="Amount" size="12" maxlength="11" VALUE="' .  $_POST['Amount'] . '"></td></tr>';
echo '</table>';

echo '<br /><div class=centre><input type="submit" name="AddShiptChgToInvoice" VALUE="' . _('Enter Shipment Charge') . '"></div>';

echo '</form>';
include('includes/footer.inc');
?>