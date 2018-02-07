<?php
/* $Revision: 1.0 $ */

$PageSecurity = 2;

If (isset($_POST['PrintPDF'])
	AND isset($_POST['PayrollID'])) {

	include('includes/session.inc');
	include('includes/PDFStarterPayroll.php');
	include('includes/prlFunctions.php');

	$FontSize=12;

	$PageNumber=0;
	$line_height=12;
	
	$PayDesc = GetPayrollRow($_POST['PayrollID'], $db,1);
   	$FromPeriod = GetPayrollRow($_POST['PayrollID'], $db,3);
	$ToPeriod = GetPayrollRow($_POST['PayrollID'], $db,4);

	$FontSize = 10;
	$line_height = 12;
			$FullName ='';
			$ATM ='';
			$PayAmount = 0;
	$PayAmountTotal = 0;
	include('includes/PDFBankPageHeader.inc');
	
	$sql = "SELECT employeeid,netpay
			FROM prlpayrolltrans 
			WHERE  payrollid='" .$_POST['PayrollID']. "' ORDER BY netpay DESC";
	$PayResult = DB_query($sql,$db);
	if(DB_num_rows($PayResult)>0)
	{
		while ($myrow=DB_fetch_array($PayResult)) {
		    $EmpID =$myrow['employeeid'];
			$FullName=GetName($EmpID, $db);
			$bankName=getBankName($EmpID, $db);
			$bankCode=getBankCode($EmpID, $db);
			$ATM=GetEmpRow($EmpID, $db,19);
			$PayAmount =$myrow['netpay'];
				if (($PayAmount>0) and ($ATM<>'')) {
					$PayAmountTotal += $PayAmount;
					$FontSize = 10;
										$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos,150,$FontSize,$FullName);
										$LeftOvers = $pdf->addTextWrap($Left_Margin+150,$YPos,50,$FontSize,$bankName,'right');
										$LeftOvers = $pdf->addTextWrap($Left_Margin+300,$YPos,50,$FontSize,$ATM,'right');
										$LeftOvers = $pdf->addTextWrap($Left_Margin+410,$YPos,50,$FontSize,number_format($PayAmount,2),'right');
										$YPos -= $line_height;
										if ($YPos < ($Bottom_Margin)){		
											include('includes/PDFBankPageHeader.inc');
										}
				}
		}
	}	
	$LeftOvers = $pdf->line($Page_Width-$Right_Margin, $YPos,$Left_Margin, $YPos);
	$YPos -= (2 * $line_height);
	$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos,150,$FontSize,'Grand Total');
	$LeftOvers = $pdf->addTextWrap($Left_Margin+410,$YPos,50,$FontSize,number_format($PayAmountTotal,2),'right');
	$LeftOvers = $pdf->line($Page_Width-$Right_Margin, $YPos-5,$Left_Margin, $YPos-5);
	
	$buf = $pdf->output();
	$len = strlen($buf);

	header('Content-type: application/pdf');
	header("Content-Length: $len");
	header('Content-Disposition: inline; filename=BankListing.pdf');
	header('Expires: 0');
	header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
	header('Pragma: public');


} elseif (isset($_POST['ShowPR'])) {
		include('includes/session.inc');
		$title=_('Bank Transmittal Listing');
		include('includes/header.inc');
	   echo 'Use PrintPDF instead';
	   echo "<BR><A HREF='" .$rootpath ."/index.php?" . SID . "'>" . _('Back to the menu') . '</A>';
	   include('includes/footer.inc');
	   exit;
} else { /*The option to print PDF was not hit */

	include('includes/session.inc');
	$title=_('Bank Transmittal Listing');
	include('includes/header.inc');
	
echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . "?" . SID . ">";
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';		echo '<CENTER><TABLE><TR><TD>' . _('Select Payroll:') . '</TD><TD><SELECT Name="PayrollID">';
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
	echo "</TABLE";
	echo "<P><CENTER><INPUT TYPE='Submit' NAME='PrintPDF' VALUE='" . _('PrintPDF') . "'>";

	include('includes/footer.inc');;
} /*end of else not PrintPDF */

	
?>