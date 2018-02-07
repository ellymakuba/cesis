<?php
$PageSecurity = 2;

If (isset($_POST['PrintPDF'])
	AND isset($_POST['PayrollID'])) {
	include('includes/session.inc');
	include('includes/PDFStarterPayroll.php');
	include('includes/prlFunctions.php');
	
	
$FontSize=8;
$XPos=0;
$PageNumber=1;
	$line_height=12;
	
	$PayDesc = GetPayrollRow($_POST['PayrollID'], $db,1);
   	$FromPeriod = GetPayrollRow($_POST['PayrollID'], $db,3);
	$ToPeriod = GetPayrollRow($_POST['PayrollID'], $db,4);
	$PageNumber = 0;
	$FontSize = 8;
	$pdf->addinfo('Title', _('Payroll Register') );
	$pdf->addinfo('Subject', _('Payroll Register') );
	$line_height = 12;
		    $EmpID ='';
			$Basic = 0;
			$OthInc = 0;
			$Lates = 0;
			$Absent = 0;
			$OT = 0;
			$Gross = 0;
			$NSSF = 0;
			$PAYE ='';
			$PhilHealt = 0;
			$Loan = 0;
			$Tax = 0;
			$Net = 0;
	include('includes/PDFPayRegisterPageHeader.inc');
	
	$sql = "SELECT prlpayrolltrans.employeeid,prlpayrolltrans.basicpay,prlpayrolltrans.othincome,prlpayrolltrans.absent,prlpayrolltrans.late,prlpayrolltrans.otpay,prlpayrolltrans.grosspay,prlpayrolltrans.loandeduction,prlpayrolltrans.helbdeduction,prlpayrolltrans.pension,prlpayrolltrans.NSSF,prlpayrolltrans.PAYE,prlpayrolltrans.NHIF,prlpayrolltrans.tax,prlpayrolltrans.netpay,prlpayrolltrans.advance,prlpayrolltrans.arrears
			FROM prlpayrolltrans 
			WHERE  prlpayrolltrans.payrollid='" .$_POST['PayrollID']. "' ORDER BY basicpay DESC";
	$PayResult = DB_query($sql,$db);
	if(DB_num_rows($PayResult)>0)
	{
		while ($myrow=DB_fetch_array($PayResult)) {
		    $EmpID =$myrow['employeeid'];
			$FullName=GetName($EmpID, $db);
			$Basic =$myrow['basicpay'];
			$OthInc = $myrow['othincome']+$myrow['arrears'];
			$Lates = $myrow['late'];
			$Absent = $myrow['absent'];
			$OT =$myrow['otpay'];
			$Gross =$myrow['grosspay']+$myrow['arrears'];
			$NSSF =$myrow['NSSF'];
			$PAYE =$myrow['PAYE'];
			$NHIF = $myrow['NHIF'];
			$Loan =$myrow['loandeduction'];
			$Helb =$myrow['helbdeduction'];
			$Advance =$myrow['advance'];
			$Pension =$myrow['pension'];
			$Tax = $myrow['tax'];
			$Net =$myrow['netpay'];

			$GTBasic +=$myrow['basicpay'];
			$GTOthInc += $myrow['othincome'];
			$GTLates +=$myrow['late'];
			$GTAbsent +=$myrow['absent'];
			$GTOT +=$myrow['otpay'];
			$GTGross +=$myrow['grosspay'];
			$GTSSS +=$myrow['NSSF'];
			$GTPAYE +=$myrow['PAYE'];
			$GTPhilHealth += $myrow['NHIF'];
			$GTLoan +=$myrow['loandeduction'];
			$GTHelbLoan +=$myrow['helbdeduction'];
			$GTRahisiLoan +=$myrow['rahisiloandeduction'];
			$GTPension +=$myrow['pension'];
			$GTAdance +=$myrow['advance'];
			$GTTax += $myrow['tax'];
			$GTNet +=$myrow['netpay'];
			
			//$YPos -= (2 * $line_height);  //double spacing
			$FontSize = 10;
			//$pdf->selectFont('./fonts/Helvetica.afm');
			$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos,50,$FontSize,$EmpID);
			$LeftOvers = $pdf->addTextWrap(100,$YPos,120,$FontSize,$FullName,'left');
			$LeftOvers = $pdf->addTextWrap(221,$YPos,50,$FontSize,number_format($Basic,2),'right');
			$LeftOvers = $pdf->addTextWrap(272,$YPos,50,$FontSize,number_format($OthInc,2),'right');
			$LeftOvers = $pdf->addTextWrap(313,$YPos,50,$FontSize,number_format($Lates,2),'right');
			$LeftOvers = $pdf->addTextWrap(354,$YPos,50,$FontSize,number_format($Absent,2),'right');		
			$LeftOvers = $pdf->addTextWrap(395,$YPos,50,$FontSize,number_format($OT,2),'right');
			$LeftOvers = $pdf->addTextWrap(446,$YPos,50,$FontSize,number_format($Gross,2),'right');
			$LeftOvers = $pdf->addTextWrap(487,$YPos,50,$FontSize,number_format($NSSF,2),'right');
			$LeftOvers = $pdf->addTextWrap(528,$YPos,50,$FontSize,number_format($PAYE,2),'right');
			$LeftOvers = $pdf->addTextWrap(569,$YPos,50,$FontSize,number_format($NHIF,2),'right');
			$LeftOvers = $pdf->addTextWrap(609,$YPos,50,$FontSize,number_format($Loan,2),'right');
			$LeftOvers = $pdf->addTextWrap(679,$YPos,50,$FontSize,number_format($Tax,2),'right');
			$LeftOvers = $pdf->addTextWrap(729,$YPos,50,$FontSize,number_format($Net,2),'right');
			$YPos -= (2+$line_height);
			if ($YPos < ($Bottom_Margin)){		
				include('includes/PDFPayRegisterPageHeader.inc');
			}
		}
		
	}//end of loop
	
			$LeftOvers = $pdf->line($Page_Width-$Right_Margin, $YPos,$Left_Margin, $YPos);
			$YPos -= (2 * $line_height);
			$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos,150,$FontSize,'Grand Total');
			$LeftOvers = $pdf->addTextWrap(221,$YPos,50,$FontSize,number_format($GTBasic,2),'right');
			$LeftOvers = $pdf->addTextWrap(221,$YPos,50,$FontSize,number_format($GTBasic,2),'right');
			$LeftOvers = $pdf->addTextWrap(272,$YPos,50,$FontSize,number_format($GTOthInc,2),'right');
			$LeftOvers = $pdf->addTextWrap(313,$YPos,50,$FontSize,number_format($GTLates,2),'right');
			$LeftOvers = $pdf->addTextWrap(354,$YPos,50,$FontSize,number_format($GTAbsent,2),'right');		
			$LeftOvers = $pdf->addTextWrap(395,$YPos,50,$FontSize,number_format($GTOT,2),'right');
			$LeftOvers = $pdf->addTextWrap(446,$YPos,50,$FontSize,number_format($GTGross,2),'right');
			$LeftOvers = $pdf->addTextWrap(487,$YPos,50,$FontSize,number_format($GTSSS,2),'right');
			$LeftOvers = $pdf->addTextWrap(528,$YPos,50,$FontSize,number_format($GTPAYE,2),'right');
			$LeftOvers = $pdf->addTextWrap(609,$YPos,50,$FontSize,number_format($GTLoan,2),'right');
			$LeftOvers = $pdf->addTextWrap(679,$YPos,50,$FontSize,number_format($GTTax,2),'right');
			$LeftOvers = $pdf->addTextWrap(729,$YPos,50,$FontSize,number_format($GTNet,2),'right');
						
			$LeftOvers = $pdf->line($Page_Width-$Right_Margin, $YPos-10,$Left_Margin, $YPos-10);

	
	
$pdf->Output('Receipt-'.$_GET['ReceiptNumber'], 'I');
	exit;

} elseif (isset($_POST['ShowPR'])) {
		include('includes/session.inc');
		$title=_('NHIF Monthly Premium Listing');
		include('includes/header.inc');
	   echo 'Use PrintPDF instead';
	   echo "<BR><A HREF='" .$rootpath ."/index.php?" . SID . "'>" . _('Back to the menu') . '</A>';
	   include('includes/footer.inc');
	   exit;
} else { /*The option to print PDF was not hit */

	include('includes/session.inc');
	$title=_('Payroll Register');
	include('includes/header.inc');
	
			echo '<FORM METHOD="POST" ACTION="' . $_SERVER['PHP_SELF'] . '?' . SID . '">';
			echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
		echo '<CENTER><TABLE><TR><TD>' . _('Select Payroll:') . '</TD><TD><SELECT Name="PayrollID">';
		DB_data_seek($result, 0);
		$sql = 'SELECT payrollid, payrolldesc FROM prlpayrollperiod';
		$result = DB_query($sql, $db);
		while ($myrow = DB_fetch_array($result)) {
			if ($myrow['payrollid'] == $_POST['PayrollID']) {  
				echo '<OPTION SELECTED VALUE=';
			} else {
				echo '<OPTION VALUE=';
			}
			echo $myrow['payrollid'] . '>' . $myrow['payrolldesc'];
		} //end while loop
	echo '</SELECT></TD></TR>';
	echo "</TABLE><P><CENTER>";
	echo "<P><CENTER><INPUT TYPE='Submit' NAME='PrintPDF' VALUE='" . _('PrintPDF') . "'>";

	include('includes/footer.inc');;
} /*end of else not PrintPDF */

?>