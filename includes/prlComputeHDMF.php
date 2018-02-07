<?php
if (isset($_GET['PayrollID'])){
	$PayrollID = $_GET['PayrollID'];
} elseif (isset($_POST['PayrollID'])){
	$PayrollID = $_POST['PayrollID'];
} else {
	unset($PayrollID);
}
$FSMonthRow=GetPayrollRow($PayrollID, $db,5);
$FSYearRow=GetPayrollRow($PayrollID, $db,6);
$DeductPAYE = GetYesNoStr(GetPayrollRow($PayrollID, $db,8));
$Status = GetOpenCloseStr(GetPayrollRow($PayrollID, $db,11));
if ($Status=='Closed') {
   exit("Payroll is Closed. Re-open first...");
}
if (isset($_POST['submit'])) {
   exit("Contact Administrator...");
} else {
	$sql="DELETE FROM prlemphdmffile WHERE payrollid ='" . $PayrollID . "'";
	$PostdelPAYE= DB_query($sql,$db);

	$sql = "UPDATE prlpayrolltrans SET	PAYE=0
				WHERE payrollid ='" . $PayrollID . "'";
	$RePostPAYE= DB_query($sql,$db);	
	
	if ($DeductPAYE=='Yes') {
		$sql = "SELECT counterindex,payrollid,employeeid,basicpay,absent,late,otpay,fsmonth,fsyear
				FROM prlpayrolltrans
				WHERE prlpayrolltrans.payrollid='" . $PayrollID . "'";
		$PayDetails = DB_query($sql,$db);
		if(DB_num_rows($PayDetails)>0)
		{
			while ($myrow = DB_fetch_array($PayDetails))
			{	
				$sql = "SELECT sum(grosspay) AS Gross
					FROM prlpayrolltrans
					WHERE prlpayrolltrans.employeeid='" . $myrow['employeeid'] . "'
					AND prlpayrolltrans.fsmonth='" . $FSMonthRow . "'
					AND prlpayrolltrans.fsyear='" . $FSYearRow . "'";
					$PAYEDetails = DB_query($sql,$db);
					if(DB_num_rows($PAYEDetails)>0)
					{	
						$PAYErow=DB_fetch_array($PAYEDetails);
						$PAYEGP=$PAYErow['Gross'];
						if ($PAYEGP>0 or $PAYEGP<>null) {
							$HFMFER=GetPAYEER($PAYEGP, $db);
							$HFMFEE=GetPAYEEE($PAYEGP, $db);
							$PAYETOT=$HFMFEE+$HFMFER;
										$sql = "INSERT INTO prlemphdmffile (		
												payrollid,
												employeeid,
												grosspay,				
												employerhdmf,
												employeehdmf,
												total,
												fsmonth,
												fsyear)
												VALUES ('$PayrollID', 
													'" . $myrow['employeeid'] . "',
													'$PAYEGP',
													'$HFMFER',
													'$HFMFEE',
													'$PAYETOT',
													'" . $myrow['fsmonth'] . "',
													'" . $myrow['fsyear'] . "'
													)";
												$ErrMsg = _('Inserting PAYE File failed.');
												$InsSSSRecords = DB_query($sql,$db,$ErrMsg);
						} //if sssgp>0
					} //dbnumross sssdetials>0	
			}  //end of while
		}  //dbnumrows paydetails > 0
	} //deduct NSSF=yes
	
	//posting to payroll trans for PAYE
	if ($DeductPAYE=='Yes') {
		$sql = "SELECT counterindex,payrollid,employeeid,basicpay,absent,late,otpay,fsmonth,fsyear
				FROM prlpayrolltrans
				WHERE prlpayrolltrans.payrollid='" . $PayrollID . "'";
		$PayDetails = DB_query($sql,$db);
		if(DB_num_rows($PayDetails)>0)
		{
			while ($myrow = DB_fetch_array($PayDetails))
			{	
			$sql = "SELECT employeehdmf
					FROM prlemphdmffile
			        WHERE prlemphdmffile.employeeid='" . $myrow['employeeid'] . "'
					AND prlemphdmffile.payrollid='" . $PayrollID . "'";		
					$PAYEDetails = DB_query($sql,$db);
					if(DB_num_rows($PAYEDetails)>0)
					{
					    $PAYErow=DB_fetch_array($PAYEDetails);
						$PAYEPayment=$PAYErow['employeehdmf'];
						$sql = 'UPDATE prlpayrolltrans SET PAYE='.$PAYEPayment.'
					     WHERE counterindex = ' . $myrow['counterindex'];
					    $PostPAYEPay = DB_query($sql,$db);
					}
			}
		}
	}
} //isset post submit
?>