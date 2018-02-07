<?php
/* $Revision: 1.0 $ */

$PageSecurity = 2;

If (isset($_POST['PrintPDF'])
	AND isset($_POST['FSMonth'])
	AND $_POST['FSMonth']>=0
	AND isset($_POST['FSYear'])
	AND $_POST['FSYear']>=0){

	include('includes/session.inc');
	include('includes/PDFStarterPayroll.php');
	include('includes/prlFunctions.php');

	$FontSize=12;
	$pdf->addinfo('Title',_('PAYE Monthly Premium'));
	$pdf->addinfo('Subject',_('PAYE Monthly Premium'));

	$PageNumber=0;
	$line_height=12;

	if ($_POST['FSMonth']==0) {
		$title = _('PAYE Monthly Premuim Listing') . ' - ' . _('Problem Report');
	   include('includes/header.inc');
	   prnMsg(_('Month not selected'),'error');
	   echo "<BR><A HREF='" .$rootpath ."/index.php?" . SID . "'>" . _('Back to the menu') . '</A>';
	   include('includes/footer.inc');
	   exit;
	}
		if ($_POST['FSYear']==0) {
		$title = _('PAYE Monthly Premuim Listing') . ' - ' . _('Problem Report');
	   include('includes/header.inc');
	   prnMsg(_('Year not selected'),'error');
	   echo "<BR><A HREF='" .$rootpath ."/index.php?" . SID . "'>" . _('Back to the menu') . '</A>';
	   include('includes/footer.inc');
	   exit;
	}
	$PAYEMonth = $_POST['FSMonth'];
	$PAYEYear = $_POST['FSYear'];
	$PAYEMonthStr = GetMonthStr($PAYEMonth);
	$PageNumber = 0;
	$FontSize = 10;
	$line_height = 12;
			$FullName ='';
			$PAYENumber ='';
			$PAYEER = 0;
			$PAYEEC = 0;
			$PAYEEE = 0;
			$PAYETotal = 0;

	include('includes/PDFHDMFPremiumPageHeader.inc');
	
	$sql = "SELECT employeeid,employerhdmf,employeehdmf,total
			FROM prlemphdmffile
			WHERE prlemphdmffile.fsmonth='" . $PAYEMonth . "'
			AND prlemphdmffile.fsyear='" . $PAYEYear . "'";		
			$PAYEDetails = DB_query($sql,$db);
					if(DB_num_rows($PAYEDetails)>0)
					{
						//although it is assume that PAYE deduction once only every month but who knows 
						while ($PAYErow=DB_fetch_array($PAYEDetails)) {
							$EmpID =$PAYErow['employeeid'];
							$FullName=GetName($EmpID, $db);
							$PAYENumber=GetEmpRow($EmpID, $db,21);
							$PAYEER =$PAYErow['employerhdmf'];
							$PAYEEE =$PAYErow['employeehdmf'];
							$PAYETotal=$PAYErow['total'];
							$GTPAYEER += $PAYEER;
							$GTPAYEEE += $PAYEEE;
							$GTPAYETotal += $PAYETotal;
							//$YPos -= (2 * $line_height);  //double spacing
							if ($PAYETotal>0) {
								$FontSize = 8;
								$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos,150,$FontSize,$FullName);
								$LeftOvers = $pdf->addTextWrap($Left_Margin+200,$YPos,50,$FontSize,$PAYENumber,'right');
								$LeftOvers = $pdf->addTextWrap($Left_Margin+350,$YPos,50,$FontSize,number_format($PAYEER,2),'right');
								$LeftOvers = $pdf->addTextWrap($Left_Margin+410,$YPos,50,$FontSize,number_format($PAYEEE,2),'right');
								$LeftOvers = $pdf->addTextWrap($Left_Margin+460,$YPos,50,$FontSize,number_format($PAYETotal,2),'right');
								$YPos -= $line_height;
								if ($YPos < ($Bottom_Margin)){		
									include('includes/PDFHDMFPremiumPageHeader.inc');
								}
							}	
						}
					}
	$LeftOvers = $pdf->line($Page_Width-$Right_Margin, $YPos,$Left_Margin, $YPos);
	$YPos -= (2 * $line_height);
	$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos,150,$FontSize,'Grand Total');
	$LeftOvers = $pdf->addTextWrap($Left_Margin+350,$YPos,50,$FontSize,number_format($GTPAYEER,2),'right');
	$LeftOvers = $pdf->addTextWrap($Left_Margin+410,$YPos,50,$FontSize,number_format($GTPAYEEE,2),'right');
	$LeftOvers = $pdf->addTextWrap($Left_Margin+460,$YPos,50,$FontSize,number_format($GTPAYETotal,2),'right');
	$LeftOvers = $pdf->line($Page_Width-$Right_Margin, $YPos,$Left_Margin, $YPos);
	
	$buf = $pdf->output();
	$len = strlen($buf);

	header('Content-type: application/pdf');
	header("Content-Length: $len");
	header('Content-Disposition: inline; filename=HDMFListing.pdf');
	header('Expires: 0');
	header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
	header('Pragma: public');

	$pdf->stream();

} elseif (isset($_POST['ShowPR'])) {
		include('includes/session.inc');
		$title=_('PAYE Monthly Premium Listing');
		include('includes/header.inc');
	   echo 'Use PrintPDF instead';
	   echo "<BR><A HREF='" .$rootpath ."/index.php?" . SID . "'>" . _('Back to the menu') . '</A>';
	   include('includes/footer.inc');
	   exit;
} else { /*The option to print PDF was not hit */

	include('includes/session.inc');
	$title=_('PAYE Monthly Premium Listing');
	include('includes/header.inc');
	
	echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . "?" . SID . ">";
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '<CENTER><TABLE>';
	echo '</SELECT></TD></TR>';
	echo '<TR><TD><align="centert"><b>' . _('FS Month') . ":<SELECT NAME='FSMonth'>";
	echo '<OPTION SELECTED VALUE=0>'. _('Select One');
	echo '<OPTION VALUE=1>' . _('January');
	echo '<OPTION VALUE=2>' . _('February');   
	echo '<OPTION VALUE=3>' . _('March');   
	echo '<OPTION VALUE=4>' . _('April');
	echo '<OPTION VALUE=5>' . _('May');
	echo '<OPTION VALUE=6>' . _('June');
	echo '<OPTION VALUE=7>' . _('July');
	echo '<OPTION VALUE=8>' . _('August');
	echo '<OPTION VALUE=9>' . _('September');
	echo '<OPTION VALUE=10>' . _('October');
	echo '<OPTION VALUE=11>' . _('November');
	echo '<OPTION VALUE=12>' . _('December');
	echo '</SELECT>';
	echo '<SELECT NAME="FSYear">';
			    echo '<OPTION SELECTED VALUE=0>'. _('Select One');
                    for ($yy=2006;$yy<=2015;$yy++)
                    {                     
                    	echo "<option value=$yy>$yy</option>\n";
                    }
	echo '</SELECT></TD></TR>';				

	echo "</TABLE><P><CENTER><INPUT TYPE='Submit' NAME='ShowPR' VALUE='" . _('Show PAYE Premium') . "'>";
	echo "<P><CENTER><INPUT TYPE='Submit' NAME='PrintPDF' VALUE='" . _('PrintPDF') . "'>";

	include('includes/footer.inc');;
} /*end of else not PrintPDF */

	
?>