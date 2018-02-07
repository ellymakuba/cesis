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
	$pdf->addinfo('Title',_('Tax Return'));
	$pdf->addinfo('Subject',_('Tax Return'));

	$PageNumber=0;
	$line_height=12;

	if ($_POST['FSMonth']==0) {
		$title = _('Monthly Tax Return Listing') . ' - ' . _('Problem Report');
	   include('includes/header.inc');
	   prnMsg(_('Month not selected'),'error');
	   echo "<BR><A HREF='" .$rootpath ."/index.php?" . SID . "'>" . _('Back to the menu') . '</A>';
	   include('includes/footer.inc');
	   exit;
	}
		if ($_POST['FSYear']==0) {
		$title = _('Monthly Tax Return Listing') . ' - ' . _('Problem Report');
	   include('includes/header.inc');
	   prnMsg(_('Year not selected'),'error');
	   echo "<BR><A HREF='" .$rootpath ."/index.php?" . SID . "'>" . _('Back to the menu') . '</A>';
	   include('includes/footer.inc');
	   exit;
	}
	$TaxMonth = $_POST['FSMonth'];
	$TaxYear = $_POST['FSYear'];
	$TaxMonthStr = GetMonthStr($TaxMonth);
	$PageNumber = 0;
	$FontSize = 10;
	$line_height = 12;
			$FullName ='';
			$TIN ='';
			$TaxStatus = 0;
			$TaxTotal = 0;

	include('includes/PDFTaxPageHeader.inc');
		$sql = "SELECT employeeid,taxactnumber,taxstatusid
			FROM prlemployeemaster 
			WHERE prlemployeemaster.taxstatusid <>''"; 
			$TaxDetails = DB_query($sql,$db);
					if(DB_num_rows($TaxDetails)>0)
					{
						while ($taxrow=DB_fetch_array($TaxDetails)) {
							$EmpID =$taxrow['employeeid'];
							$FullName=GetName($EmpID, $db);
							$TaxNumber=GetEmpRow($EmpID, $db,23);
							$TaxID=GetEmpRow($EmpID, $db,35);
							
							$sql = "SELECT sum(tax) AS Tax
							FROM prlpayrolltrans
							WHERE prlpayrolltrans.employeeid='" . $taxrow['employeeid'] . "'
							AND prlpayrolltrans.fsmonth='" . $TaxMonth . "'
							AND prlpayrolltrans.fsyear='" . $TaxYear . "'";		
							$TaxMonthly = DB_query($sql,$db);
							if(DB_num_rows($TaxMonthly)>0)
							{
								//although it is assume that PAYE deduction once only every month but who knows 
								while ($taxmonthlyrow=DB_fetch_array($TaxMonthly)) {			
									$TaxEE =$taxmonthlyrow['Tax'];
									//$YPos -= (2 * $line_height);  //double spacing
									if ($TaxEE>0) {
										$GTTaxEE += $TaxEE;
										$FontSize = 8;
										$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos,150,$FontSize,$FullName);
										$LeftOvers = $pdf->addTextWrap($Left_Margin+200,$YPos,50,$FontSize,$TaxNumber,'right');
										$LeftOvers = $pdf->addTextWrap($Left_Margin+290,$YPos,50,$FontSize,$TaxID,'right');
										$LeftOvers = $pdf->addTextWrap($Left_Margin+410,$YPos,50,$FontSize,number_format($TaxEE,2),'right');
										$YPos -= $line_height;
										if ($YPos < ($Bottom_Margin)){		
											include('includes/PDFTaxPremiumPageHeader.inc');
										}
									}	
								}
							}
						}
					}
					
	$LeftOvers = $pdf->line($Page_Width-$Right_Margin, $YPos,$Left_Margin, $YPos);
	$YPos -= (2 * $line_height);
	$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos,150,$FontSize,'Grand Total');
	$LeftOvers = $pdf->addTextWrap($Left_Margin+410,$YPos,50,$FontSize,number_format($GTTaxEE,2),'right');
	$LeftOvers = $pdf->line($Page_Width-$Right_Margin, $YPos,$Left_Margin, $YPos);
	
	$buf = $pdf->output();
	$len = strlen($buf);

	header('Content-type: application/pdf');
	header("Content-Length: $len");
	header('Content-Disposition: inline; filename=TAXListing.pdf');
	header('Expires: 0');
	header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
	header('Pragma: public');

	$pdf->stream();

} elseif (isset($_POST['ShowPR'])) {
		include('includes/session.inc');
		$title=_('Tax Monthly Return Listing');
		include('includes/header.inc');
	   echo 'Use PrintPDF instead';
	   echo "<BR><A HREF='" .$rootpath ."/index.php?" . SID . "'>" . _('Back to the menu') . '</A>';
	   include('includes/footer.inc');
	   exit;
} else { /*The option to print PDF was not hit */

	include('includes/session.inc');
	$title=_('Tax Monthly Return Listing');
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

	echo "</TABLE>";
	echo "<P><CENTER><INPUT TYPE='Submit' NAME='PrintPDF' VALUE='" . _('PrintPDF') . "'>";

	include('includes/footer.inc');;
} /*end of else not PrintPDF */

	
?>