<?php
$PageSecurity = 2;

If (isset($_POST['PrintPDF'])
	AND isset($_POST['PayrollID'])) {
	
	include('includes/session.inc');
	include('includes/PDFStarterPayroll.php');
	include('includes/prlFunctions.php');

	$PageNumber=1;
	$line_height=12;
	
	$PayDesc = GetPayrollRow($_POST['PayrollID'], $db,1);
   	$FromPeriod = GetPayrollRow($_POST['PayrollID'], $db,3);
	$ToPeriod = GetPayrollRow($_POST['PayrollID'], $db,4);
	$FontSize = 10;
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
			$PhilHealt = 0;
			$Loan = 0;
			$Tax = 0;
			$Net = 0;
			

	$YPos = $Page_Height - $Top_Margin;
	$YPos += (6* $line_height);

	$PaySlip=1;
	$sql = "SELECT employeeid,basicpay,othincome,absent,late,otpay,grosspay,loandeduction,NSSF,NHIF,tax,netpay
			FROM prlpayrolltrans 
			WHERE  prlpayrolltrans.payrollid='" .$_POST['PayrollID']. "'";
	$PayResult = DB_query($sql,$db);
	if(DB_num_rows($PayResult)>0)
	{
		while ($myrow=DB_fetch_array($PayResult)) {
		
			    $EmpID =$myrow['employeeid'];
				$FullName=GetName($EmpID, $db);
				
				$Basic =$myrow['basicpay'];
				$OthInc = $myrow['othincome'];
				$Lates = $myrow['late'];
				$Absent = $myrow['absent'];
				$OT =$myrow['otpay'];
				$Gross =$myrow['grosspay'];
				$NSSF =$myrow['NSSF'];
				$NHIF = $myrow['NHIF'];
				$Loan =$myrow['loandeduction'];
				$Tax = $myrow['tax'];
				$Net =$myrow['netpay'];
				$Deduction=$NSSF+$NHIF+$Loan+$Tax;
				
				
				
			if ($PaySlip==1) {
				$FontSize =12;
				$HeadPos1= $YPos;				
				$LeftOvers =$pdf->addText($Left_Margin,$YPos,$FontSize,$_SESSION['CompanyRecord']['coyname']);
				$YPos -= (2 * $line_height);
				$FullName = _('Name : ') . $FullName;
				$LeftOvers =$pdf->addText($Left_Margin, $YPos, $FontSize, $FullName);
				$YPos -= (2 * $line_height);	
				$LeftOvers =$pdf->addText($Left_Margin, $YPos, $FontSize, $PayDesc);
				$YPos -= (2 * $line_height);	
				$Heading2 = _('Period from ') . $FromPeriod .' to ' .$ToPeriod;
				$LeftOvers =$pdf->addText($Left_Margin,$YPos,$FontSize,$Heading2);
				$YPos -=35;
				/*Draw a rectangle to put the headings in     */
				$BoxHeight =20;
				//$pdf->line($Left_Margin, $YPos+$BoxHeight,$Page_Width-$Right_Margin, $YPos+$BoxHeight); //top vertical
				$pdf->line($Left_Margin, $YPos+$BoxHeight,314, $YPos+$BoxHeight); //top vertical
				$pdf->line($Left_Margin, $YPos+$BoxHeight,$Left_Margin, $YPos);
				$pdf->line($Left_Margin, $YPos,314, $YPos); //bottom vertical
				$pdf->line(314, $YPos+$BoxHeight,314, $YPos);  //right horizontal
				$YPos +=5;
				/*set up the headings */
				$FontSize = 10;
				$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos,65,$FontSize,'Income','right');
				$LeftOvers = $pdf->addTextWrap(210,$YPos,65,$FontSize,'Deduction','right');
				$YPos -= (2 * $line_height);
				//$YPos -= (2 * $line_height);  //double spacing
				$OldYPos1= $YPos;
				$FontSize = 10;
				$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos,55,$FontSize,'Basic : ','right');
				$LeftOvers = $pdf->addTextWrap(110,$YPos,40,$FontSize,number_format($Basic,2),'right');
				$YPos -=(2*$line_height);
				$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos,55,$FontSize,'Other Income : ','right');
				$LeftOvers = $pdf->addTextWrap(110,$YPos,40,$FontSize,number_format($OthInc,2),'right');
				$YPos -=(2*$line_height);
				$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos,55,$FontSize,'Lates : ','right');
				$LeftOvers = $pdf->addTextWrap(110,$YPos,40,$FontSize,number_format($Lates,2),'right');
				$YPos -=(2*$line_height);
				$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos,55,$FontSize,'Absent : ','right');
				$LeftOvers = $pdf->addTextWrap(110,$YPos,40,$FontSize,number_format($Absent,2),'right');			
				$YPos -=(2*$line_height);
				$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos,55,$FontSize,'Overtime : ','right');
				$LeftOvers = $pdf->addTextWrap(110,$YPos,40,$FontSize,number_format($OT,2),'right');
				$YPos -=(2*$line_height);
			
				//2nd column
				$OldYPos2=$OldYPos1;
				$YPos=$OldYPos1;
				$FontSize = 10;
				$LeftOvers = $pdf->addTextWrap(210,$YPos,65,$FontSize,'NSSF : ','right');
				$LeftOvers = $pdf->addTextWrap(276,$YPos,40,$FontSize,number_format($NSSF,2),'right');
				
				$YPos -=(2*$line_height);
				$LeftOvers = $pdf->addTextWrap(210,$YPos,65,$FontSize,'NHIF : ','right');
				$LeftOvers = $pdf->addTextWrap(276,$YPos,40,$FontSize,number_format($NHIF,2),'right');
				$YPos -=(2*$line_height);
				$LeftOvers = $pdf->addTextWrap(210,$YPos,65,$FontSize,'Tax : ','right');
				$LeftOvers = $pdf->addTextWrap(276,$YPos,40,$FontSize,number_format($Tax,2),'right');			
				$YPos -=(2*$line_height);
				$LeftOvers = $pdf->addTextWrap(210,$YPos,65,$FontSize,'Loan Deduction : ','right');
				$LeftOvers = $pdf->addTextWrap(276,$YPos,40,$FontSize,number_format($Loan,2),'right');
				$YPos -=35;
				/*Draw a rectangle to put the headings in     */
				$BoxHeight =20;
				//$pdf->line($Left_Margin, $YPos+$BoxHeight,$Page_Width-$Right_Margin, $YPos+$BoxHeight); //top vertical
				$pdf->line($Left_Margin, $YPos-$BoxHeight,314, $YPos-$BoxHeight); //top vertical
				$pdf->line($Left_Margin, $YPos-$BoxHeight,$Left_Margin, $YPos);
				$pdf->line($Left_Margin, $YPos,314, $YPos); //bottom vertical
				$pdf->line(314, $YPos-$BoxHeight,314, $YPos);  //right horizontal
				$YPos -=10;
				/*set up the headings */
				$Xpos = $Left_Margin+1;
				$LeftOvers = $pdf->addTextWrap($Xpos,$YPos,65,$FontSize,'Gross Income : ','right');
				$LeftOvers = $pdf->addTextWrap(110,$YPos,40,$FontSize,number_format($Gross,2),'right');
				$LeftOvers = $pdf->addTextWrap(205,$YPos,65,$FontSize,'Total Deduction : ','right');
				$LeftOvers = $pdf->addTextWrap(271,$YPos,40,$FontSize,number_format($Deduction,2),'right');		

				$YPos -=50;
				/*Draw a rectangle to put the headings in     */
				$BoxHeight =45;
				//$pdf->line($Left_Margin, $YPos+$BoxHeight,262, $YPos+$BoxHeight); //top vertical
				$pdf->line($Left_Margin, $YPos+$BoxHeight,$Left_Margin, $YPos);
				$pdf->line($Left_Margin, $YPos,314, $YPos); //bottom vertical
				$pdf->line(314, $YPos+$BoxHeight,314, $YPos);  //right horizontal
				$YPos +=5;
				/*set up the headings */
				$Xpos = $Left_Margin+1;
				$LeftOvers = $pdf->addTextWrap($Xpos,$YPos,100,$FontSize,'Employee Signature','right');
				$LeftOvers = $pdf->addTextWrap(195,$YPos,65,$FontSize,'Net Pay : ','right');
				$LeftOvers = $pdf->addTextWrap(261,$YPos,40,$FontSize,number_format($Net,2),'right');		
				$YPos -= $line_height;

				$PaySlip=2;
			} elseif ($PaySlip==2) {
				//header		
				$FontSize =12;
				$YPos = $HeadPos1;	
				$LeftOvers =$pdf->addText(500,$YPos,$FontSize,$_SESSION['CompanyRecord']['coyname']);
				$YPos -= (2 * $line_height);	
				$FullName = _('Name : ') . $FullName;
				$LeftOvers =$pdf->addText(500, $YPos, $FontSize, $FullName);
				$YPos -= (2 * $line_height);	
				$LeftOvers =$pdf->addText(500, $YPos, $FontSize, $PayDesc);
				$YPos -= (2 * $line_height);	
				$Heading2 = _('Period from ') . $FromPeriod .' to ' .$ToPeriod;
				$LeftOvers =$pdf->addText(500,$YPos,$FontSize,$Heading2);
				$YPos -=35;
				/*Draw a rectangle to put the headings in     */
				$BoxHeight =20;
				$pdf->line(499, $YPos+$BoxHeight,772, $YPos+$BoxHeight); //top vertical
				$pdf->line(499, $YPos+$BoxHeight,499, $YPos); //left horizontal
				$pdf->line(499, $YPos,772, $YPos); //bottom vertical
				$pdf->line(772, $YPos+$BoxHeight,772, $YPos);  //right horizontal
				$YPos +=5;	
				/*set up the headings */
				$FontSize = 10;
				$LeftOvers = $pdf->addTextWrap(500,$YPos,65,$FontSize,'Income','right');
				$LeftOvers = $pdf->addTextWrap(661,$YPos,65,$FontSize,'Deduction','right');
				$YPos -= (5 * $line_height);
				
				//$YPos -= (2 * $line_height);  //double spacing
				$YPos=$OldYPos1;
				$LeftOvers = $pdf->addTextWrap(500,$YPos,65,$FontSize,'Basic : ','left');
				$LeftOvers = $pdf->addTextWrap(565,$YPos,40,$FontSize,number_format($Basic,2),'right');
				$YPos -= (2 * $line_height);
				$LeftOvers = $pdf->addTextWrap(500,$YPos,65,$FontSize,'Other Income : ','right');
				$LeftOvers = $pdf->addTextWrap(565,$YPos,40,$FontSize,number_format($OthInc,2),'right');
				$YPos -= (2 * $line_height);
				$LeftOvers = $pdf->addTextWrap(500,$YPos,65,$FontSize,'Lates : ','right');
				$LeftOvers = $pdf->addTextWrap(565,$YPos,40,$FontSize,number_format($Lates,2),'right');
				$YPos -= (2 * $line_height);
				$LeftOvers = $pdf->addTextWrap(500,$YPos,65,$FontSize,'Absent : ','right');
				$LeftOvers = $pdf->addTextWrap(565,$YPos,40,$FontSize,number_format($Absent,2),'right');			
				$YPos -= (2 * $line_height);
				$LeftOvers = $pdf->addTextWrap(500,$YPos,65,$FontSize,'Overtime : ','right');
				$LeftOvers = $pdf->addTextWrap(565,$YPos,40,$FontSize,number_format($OT,2),'right');
				$YPos -= (2 * $line_height);
			
				//2nd column
				$YPos=$OldYPos2;
				$LeftOvers = $pdf->addTextWrap(670,$YPos,65,$FontSize,'NSSF : ','right');
				$LeftOvers = $pdf->addTextWrap(736,$YPos,40,$FontSize,number_format($NSSF,2),'right');
				
				$YPos -= (2 * $line_height);
				$LeftOvers = $pdf->addTextWrap(670,$YPos,65,$FontSize,'NHIF : ','right');
				$LeftOvers = $pdf->addTextWrap(736,$YPos,40,$FontSize,number_format($NHIF,2),'right');
				$YPos -= (2 * $line_height);
				$LeftOvers = $pdf->addTextWrap(670,$YPos,65,$FontSize,'Tax : ','right');
				$LeftOvers = $pdf->addTextWrap(736,$YPos,40,$FontSize,number_format($Tax,2),'right');			
				$YPos -= (2 * $line_height);
				$LeftOvers = $pdf->addTextWrap(670,$YPos,65,$FontSize,'Loan Deduction : ','right');
				$LeftOvers = $pdf->addTextWrap(736,$YPos,40,$FontSize,number_format($Loan,2),'right');
				$YPos -=30;
				/*Draw a rectangle to put the headings in     */
				$BoxHeight =20;
				$pdf->line(499, $YPos-$BoxHeight,772, $YPos-$BoxHeight); //top vertical
				$pdf->line(499, $YPos-$BoxHeight,499, $YPos); //left horizontal
				$pdf->line(499, $YPos,772, $YPos); //bottom vertical
				$pdf->line(772, $YPos-$BoxHeight,772, $YPos);  //right horizontal
				$YPos -=8;
				/*set up the headings */
				$LeftOvers = $pdf->addTextWrap(500,$YPos,65,$FontSize,'Gross Income : ','right');
				$LeftOvers = $pdf->addTextWrap(565,$YPos,40,$FontSize,number_format($Gross,2),'right');
				$LeftOvers = $pdf->addTextWrap(665,$YPos,65,$FontSize,'Total Deduction : ','right');
				$LeftOvers = $pdf->addTextWrap(731,$YPos,40,$FontSize,number_format($Deduction,2),'right');		
				$YPos -=50;
				/*Draw a rectangle to put the headings in     */
				$BoxHeight =45;
				$pdf->line(499, $YPos+$BoxHeight,499, $YPos);
				$pdf->line(499, $YPos,772, $YPos); //bottom vertical
				$pdf->line(772, $YPos+$BoxHeight,772, $YPos);  //right horizontal
				$YPos +=5;
				/*set up the headings */
				$LeftOvers = $pdf->addTextWrap(500,$YPos,100,$FontSize,'Employee Signature','right');
				$LeftOvers = $pdf->addTextWrap(665,$YPos,65,$FontSize,'Net Pay : ','right');
				$LeftOvers = $pdf->addTextWrap(731,$YPos,40,$FontSize,number_format($Net,2),'right');		
				$YPos -= $line_height;
				$YPos -= (5 * $line_height);
				
				$PaySlip=1;
			}
			
			
				
			
			
			if ($YPos < ($Bottom_Margin)){		
				$PageNumber++;
				if ($PageNumber>1){
					$pdf->newPage();
					$YPos = $Page_Height - $Top_Margin;
					$YPos -= (2 * $line_height);
				}
			}
		}
		
	}//end of loop

	$pdf->Output('Receipt-', 'I');
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
	$title=_('Bank Transmittal Listing');
	include('includes/header.inc');
	
		echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . "?" . SID . ">";
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
	echo "</TABLE>";
	echo "<P><CENTER><INPUT TYPE='Submit' NAME='PrintPDF' VALUE='" . _('PrintPDF') . "'>";

	include('includes/footer.inc');;
} /*end of else not PrintPDF */

?>