<?php
	$PageNumber++;
	if ($PageNumber>1){
		$pdf->newPage();
	}

	$FontSize =10;
	$YPos = $Page_Height - $Top_Margin;
	$YPos += (6 * $line_height);
	$pdf->addText($Left_Margin,$YPos,$FontSize,$_SESSION['CompanyRecord']['coyname']);

	$YPos -= $line_height;
	$FontSize =10;
	$Heading = _('Bank Transmitall for ') . $PayDesc;
	$pdf->addText($Left_Margin, $YPos, $FontSize, $Heading);
	$pdf->addText($Page_Width-$Right_Margin-120,$YPos,$FontSize,
		_('Printed'). ': ' . Date($_SESSION['DefaultDateFormat'])
		. '   '. _('Page'). ' ' . $PageNumber);
	$YPos -= (1 * $line_height);	
	$Heading1 = _('Period from ') . $FromPeriod .' to ' .$ToPeriod;
	$pdf->addText($Left_Margin,$YPos,$FontSize,$Heading1);
	
	$YPos -= (2 * $line_height);
	$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos,150,$FontSize,'Full Name');
	$LeftOvers = $pdf->addTextWrap($Left_Margin+150,$YPos,50,$FontSize,'Bank Name','right');
	$LeftOvers = $pdf->addTextWrap($Left_Margin+300,$YPos,50,$FontSize,'ATM Number','right');
	$LeftOvers = $pdf->addTextWrap($Left_Margin+410,$YPos,50,$FontSize,'Net Pay','right');
	$LeftOvers = $pdf->line($Page_Width-$Right_Margin, $YPos-5,$Left_Margin, $YPos-5);
	$YPos -= (2 * $line_height);
	

?>