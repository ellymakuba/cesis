<?php
$PageSecurity = 4;
include('includes/session.inc');
include('includes/PDFStarter.php');
$FontSize=12;
$pdf->addinfo('Title', _('Payment Receipt') );

$PageNumber=1;
$line_height=12;
if ($PageNumber>1){
	$pdf->newPage();
}

$FontSize=12;
$YPos= $Page_Height-$Top_Margin;
$XPos=0;
$pdf->addJpegFromFile($_SESSION['LogoFile'] ,$XPos+200,$YPos-130,0,150);

$sql="SELECT transno,receipt_no	FROM debtortrans	WHERE id='".$_GET['ReceiptNumber'] ."'";
$result=DB_query($sql, $db);
$myrow=DB_fetch_array($result);
$InvoioceNo=$myrow['transno'];

$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*1),300,$FontSize,$_SESSION['CompanyRecord']['coyname']);
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*2),300,$FontSize,$_SESSION['CompanyRecord']['regoffice1']);
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*3),300,$FontSize,$_SESSION['CompanyRecord']['regoffice2']);
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*4),300,$FontSize,$_SESSION['CompanyRecord']['regoffice3']);
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*5),300,$FontSize,$_SESSION['CompanyRecord']['regoffice4']);

$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-180,$YPos-($line_height*1),300,$FontSize, _('Email').': ' . _('kipkeino@yahoo.com'));
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-180,$YPos-($line_height*2),300,$FontSize, _('website').': ' . _('www.kipkeinoprimary.ac.ke'));
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-180,$YPos-($line_height*3),550,$FontSize, _('Receipt Number ').'  : ' .$myrow['receipt_no'] );
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-180,$YPos-($line_height*4),550,$FontSize, _('Invoice No ').'  : ' .$InvoioceNo );
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-180,$YPos-($line_height*5),140,$FontSize, _('Printed').': ' . Date($_SESSION['DefaultDateFormat']));

$YPos -= 75;

$YPos -=(6*$line_height);
$pdf->line($Left_Margin, $YPos+$line_height,$Page_Width-$Right_Margin, $YPos+$line_height);
$FontSize=12;
$PageNumber++;
$sql="SELECT MIN(id) as start FROM debtortrans WHERE type=12 AND transno='".$_GET['BatchNumber']. "'";
$result=DB_query($sql, $db);
$myrow=DB_fetch_array($result);
$StartReceiptNumber=$myrow['start'];

$sql="SELECT ba.bankaccountname as name FROM bankaccounts ba
INNER JOIN banktrans bt ON bt.bankact=ba.accountcode
WHERE studenttransid='".$_GET['ReceiptNumber']. "'";
$result=DB_query($sql, $db);
$myrow=DB_fetch_array($result);
$bankaccount = $myrow['name'];

$sql="SELECT 	debtortrans.debtorno,debtortrans.ovamount,debtortrans.invtext,bankaccounts.bankaccountname  as bankname
FROM debtortrans,banktrans,bankaccounts
WHERE debtortrans.type=12
AND banktrans.transno=debtortrans.transno
AND banktrans.bankact=bankaccounts.accountcode
AND debtortrans.id='".$_GET['ReceiptNumber'] ."'";
$result=DB_query($sql, $db);
$myrow=DB_fetch_array($result);
$DebtorNo=$myrow['debtorno'];
$Amount=$myrow['ovamount'];
$Narrative=$myrow['invtext'];

$sql="SELECT id,name,debtorno,grade_level_id,
(SELECT grade_level FROM gradelevels WHERE id=grade_level_id) as class
FROM debtorsmaster WHERE debtorno='".$DebtorNo."'";
$result=DB_query($sql, $db);
$myrow=DB_fetch_array($result);
$LeftOvers = $pdf->addTextWrap(180,$YPos,300,$FontSize, $myrow['class']);
$YPos -= (1.5 * $line_height);
$LeftOvers = $pdf->addTextWrap(50,$YPos,300,$FontSize,_('Received From').' : ');
$LeftOvers = $pdf->addTextWrap(180,$YPos,300,$FontSize, htmlspecialchars_decode($myrow['name']));
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*1),300,$FontSize, _('Student RegNO').' : ');
$LeftOvers = $pdf->addTextWrap(180,$YPos-($line_height*1),300,$FontSize, htmlspecialchars_decode($myrow['debtorno']));
$student=$myrow['debtorno'];
$YPos=$YPos-($line_height*1);
$YPos=$YPos-($line_height*2);

$LeftOvers = $pdf->addTextWrap(50,$YPos,500,$FontSize,_('Product Name'));
$LeftOvers = $pdf->addTextWrap(250,$YPos,500,$FontSize,_('Amount'));
$LeftOvers = $pdf->addTextWrap(350,$YPos,500,$FontSize,_('Paid'));
$sql="SELECT invoice_items.*,stockmaster.description as descrip
FROM invoice_items,stockmaster
WHERE invoice_items.product_id=stockmaster.stockid
AND invoice_id='".$InvoioceNo ."' ORDER BY stockmaster.discontinued";
$result=DB_query($sql, $db);
$Level=0;
while ($myrow=DB_fetch_array($result)){
$YPos -= $line_height;
$FontSize = 13;
$LeftOvers = $pdf->addTextWrap(50,$YPos,300,$FontSize,$myrow['descrip']);
$LeftOvers = $pdf->addTextWrap(250,$YPos,300,$FontSize,number_format($myrow['totalinvoice']));
$LeftOvers = $pdf->addTextWrap(350,$YPos,300,$FontSize,number_format($myrow['paid']));
}

$sql = "SELECT SUM(totalinvoice) as total FROM invoice_items,salesorderdetails
WHERE salesorderdetails.id=invoice_items.invoice_id
AND student_id='".$student."'";
$DbgMsg = _('The SQL that was used to retrieve the information was');
$ErrMsg = _('Could not check whether the group is recursive because');
$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
$row = DB_fetch_array($result);
$studenttotal = $row['total'];

$sql = "SELECT SUM(ovamount) as totalpayment FROM debtortrans WHERE debtorno='".$student."'";
$DbgMsg = _('The SQL that was used to retrieve the information was');
$ErrMsg = _('Could not check whether the group is recursive because');
$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
$row = DB_fetch_array($result);
$studenttotalpayment = -$row['totalpayment'];
$totalbalance=$studenttotal-$studenttotalpayment;

$YPos=$YPos-($line_height*1.5);
$FontSize = 13;
$LeftOvers = $pdf->addTextWrap(50,$YPos,300,$FontSize,_('Bank Account').' : ');
$LeftOvers = $pdf->addTextWrap(150,$YPos,300,$FontSize,$bankaccount);
$YPos=$YPos-($line_height*1.5);

$LeftOvers = $pdf->addTextWrap(50,$YPos,300,$FontSize,_('Amount Paid KSH').' : ');
$LeftOvers = $pdf->addTextWrap(250,$YPos,300,$FontSize,number_format(-$Amount,$DecimalPlaces));
$YPos=$YPos-($line_height*1.5);
$LeftOvers = $pdf->addTextWrap(50,$YPos,300,$FontSize,_('Total Balance KSH').' : ');
$LeftOvers = $pdf->addTextWrap(250,$YPos,300,$FontSize,number_format($totalbalance,$DecimalPlaces));
$YPos=$YPos-($line_height*1.5);
$LeftOvers = $pdf->addTextWrap(50,$YPos,500,$FontSize,_('Signed On Behalf Of').' :     '.$_SESSION['CompanyRecord']['coyname']);


$YPos=$YPos-($line_height*2);

$LeftOvers = $pdf->addTextWrap(50,$YPos,300,$FontSize,'______________________________________________________________________________');
$YPos=$YPos-($line_height*1.5);
$LeftOvers = $pdf->addTextWrap(50,$YPos,300,$FontSize,_('Note: Fees Once Paid Cannot Be Refunded.'));
$pdf->Output('Receipt-'.$_GET['ReceiptNumber'], 'I');
?>
