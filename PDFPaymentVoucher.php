<?php
/* $Id: PDFReceipt.php 3714 2010-09-07 21:31:01Z tim_schofield $*/

$PageSecurity = 2;
include('includes/session.inc');

include('includes/PDFStarter.php');

$FontSize=14;
$pdf->addinfo('Title', _('Sales Receipt') );

$PageNumber=1;
$line_height=14;
if ($PageNumber>1){
	$pdf->newPage();
}

$FontSize=14;
$YPos= $Page_Height-$Top_Margin;
$XPos=0;
$pdf->addJpegFromFile($_SESSION['LogoFile'] ,$XPos+200,$YPos-80,0,80);

$sql="SELECT gltrans.trandate,gltrans.narrative,gltrans.amount,gltrans.typeno,chartmaster.accountname
		FROM gltrans,chartmaster
			WHERE counterindex='".$_GET['acccountid'] ."'
			AND gltrans.account=chartmaster.accountcode";
$result=DB_query($sql, $db);
$myrow=DB_fetch_array($result);
$Trandate=$myrow['trandate'];
$Narrative=$myrow['narrative'];
$TypeNo=$myrow['typeno'];
$AccountName=$myrow['accountname'];
$Amount = $myrow['amount'];
if($Amount<0){
$Amount = -$myrow['amount'];
}


$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*1),300,$FontSize,$_SESSION['CompanyRecord']['coyname']);
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*2),300,$FontSize,$_SESSION['CompanyRecord']['regoffice1']);
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*3),300,$FontSize,$_SESSION['CompanyRecord']['regoffice2']);
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*4),300,$FontSize,$_SESSION['CompanyRecord']['regoffice3']);
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*5),300,$FontSize,$_SESSION['CompanyRecord']['regoffice4']);
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*6),300,$FontSize,$_SESSION['CompanyRecord']['regoffice5']);
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*7),300,$FontSize,$_SESSION['CompanyRecord']['regoffice6']);
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-180,$YPos-($line_height*1),550,$FontSize, _('Payment Voucher No ').'  : ' .$TypeNo);
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-180,$YPos-($line_height*2.5),140,$FontSize, _('Printed On').': ' . Date($_SESSION['DefaultDateFormat']));

$YPos -= 70;

$YPos -=$line_height;
//Note, this is ok for multilang as this is the value of a Select, text in option is different

$YPos -=(2*$line_height);

/*Draw a rectangle to put the headings in     */

$pdf->line($Left_Margin, $YPos+$line_height,$Page_Width-$Right_Margin, $YPos+$line_height);

$FontSize=14;
$YPos -= (1.5 * $line_height);

$PageNumber++;



$LeftOvers = $pdf->addTextWrap(50,$YPos,300,$FontSize,_('Details').' : ');
$LeftOvers = $pdf->addTextWrap(150,$YPos,300,$FontSize, htmlspecialchars_decode($Narrative));
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*1),300,$FontSize, _('Transaction Date').' : ');
$LeftOvers = $pdf->addTextWrap(150,$YPos-($line_height*1),300,$FontSize, htmlspecialchars_decode($Trandate));
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*2),300,$FontSize, _('Expense Account').' : ');
$LeftOvers = $pdf->addTextWrap(150,$YPos-($line_height*2),300,$FontSize, htmlspecialchars_decode($AccountName));
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*3),300,$FontSize, _('Amount').' : ');
$LeftOvers = $pdf->addTextWrap(150,$YPos-($line_height*3),300,$FontSize, htmlspecialchars_decode($Amount));
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*4),500,$FontSize,_('Finance Officer Sign').' :     ');
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*6),500,$FontSize,_('Payee ID NO').' :     ');
$LeftOvers = $pdf->addTextWrap(50,$YPos-($line_height*8),500,$FontSize,_('Payee Sign').' :     ');


$YPos=$YPos-($line_height*9);

$LeftOvers = $pdf->addTextWrap(50,$YPos,300,$FontSize,'______________________________________________________________________________');

$pdf->Output('Receipt-'.$_GET['acccountid'], 'I');
?>