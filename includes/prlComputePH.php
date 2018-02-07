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
$DeductPH = GetYesNoStr(GetPayrollRow($PayrollID, $db,9));
$Status = GetOpenCloseStr(GetPayrollRow($PayrollID, $db,11));
if ($Status=='Closed') {
   exit("Payroll is Closed. Re-open first...");
}
if (isset($_POST['submit'])) {
   exit("Contact Administrator...");
} else {
	$sql="DELETE FROM prlempphfile WHERE payrollid ='" . $PayrollID . "'";
	$Postdelph= DB_query($sql,$db);
	
if (!Is_Date($_SESSION['DateBanked'])){
	$_SESSION['DateBanked']= Date($_SESSION['DefaultDateFormat']);
	 
}
$PeriodNo = GetPeriod($_SESSION['DateBanked'],$db);

$totalNet=0;
$sql = "SELECT id FROM prlpayrollperiod
			WHERE payrollid='" . $PayrollID . "'";
	$results = DB_query($sql,$db);
	$myrow = DB_fetch_array($results);
	$id=$myrow['id'];
		

	$sql = "UPDATE prlpayrolltrans SET	NHIF=0
				WHERE payrollid ='" . $PayrollID . "'";
	$RePostPH= DB_query($sql,$db);	
	
	if ($DeductPH=='Yes') {
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
					$PHDetails = DB_query($sql,$db);
					if(DB_num_rows($PHDetails)>0)
					{	
						$phrow=DB_fetch_array($PHDetails);
						$PHGP=$phrow['Gross'];
						if ($PHGP>0 or $PHGP<>null) {
									 $myphrow = GetPHRow($PHGP, $db);
										$sql = "INSERT INTO prlempphfile (		
												payrollid,
												employeeid,
												grosspay,				
												rangefrom,
												rangeto,
												salarycredit,
												employerph,
												employerec,
												employeeph,
												total,
												fsmonth,
												fsyear)
												VALUES ('$PayrollID', 
													'" . $myrow['employeeid'] . "',
													'$PHGP',
													'". $myphrow['rangefrom'] ."',
													'". $myphrow['rangeto'] ."',
													'". $myphrow['salarycredit'] ."',
													'". $myphrow['employerph'] ."',
													'". $myphrow['employerec'] ."',
													'". $myphrow['employeeph'] ."',
													'". $myphrow['total'] ."',
													'" . $myrow['fsmonth'] . "',
													'" . $myrow['fsyear'] . "'
													)";
												$ErrMsg = _('Inserting NHIF File failed.');
												$InsPHRecords = DB_query($sql,$db,$ErrMsg);
						} //if sssgp>0
					} //dbnumross sssdetials>0	
			}  //end of while
		}  //dbnumrows paydetails > 0
	} //deduct NSSF=yes
	
	//posting to payroll trans for NSSF
	if ($DeductPH=='Yes') {
		$sql = "SELECT counterindex,payrollid,employeeid,basicpay,absent,late,otpay,fsmonth,fsyear
				FROM prlpayrolltrans
				WHERE prlpayrolltrans.payrollid='" . $PayrollID . "'";
		$PayDetails = DB_query($sql,$db);
		if(DB_num_rows($PayDetails)>0)
		{
			while ($myrow = DB_fetch_array($PayDetails))
			{	
			$sql = "SELECT employeeph
					FROM prlempphfile
			        WHERE prlempphfile.employeeid='" . $myrow['employeeid'] . "'
					AND prlempphfile.payrollid='" . $PayrollID . "'";		
					$PHDetails = DB_query($sql,$db);
					if(DB_num_rows($PHDetails)>0)
					{
					    $phrow=DB_fetch_array($PHDetails);
						$PHPayment=$phrow['employeeph'];
						$sql = 'UPDATE prlpayrolltrans SET NHIF='.$PHPayment.'
					     WHERE counterindex = ' . $myrow['counterindex'];
					    $PostPHPay = DB_query($sql,$db);
						$totalNet=$totalNet+$PHPayment;
					}
			}
		}
	}
$sqlgl = "SELECT sum(amount) as amount
			FROM gltrans
			WHERE periodno='" . $PeriodNo . "'
			AND account=7310";
			$resultgl = DB_query($sqlgl,$db);
			$myrow = DB_fetch_array($resultgl);
		$added_amount=$myrow['amount'];
		if($added_amount>0)
	{
		$difference=$added_amount-$totalNet;
		if($added_amount>$totalNet && $added_amount != $totalNet){
		$sql = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
										VALUES (15,
										'".$id."',
										'".date('Y-m-d H-i-s')."',
										'" . $PeriodNo . "',
										7310,
										'".-$difference."'
												)";
	$result = DB_query($sql,$db);
	
	$sql = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
										VALUES (15,
										'".$id."',
										'".date('Y-m-d H-i-s')."',
										'" . $PeriodNo . "',
										1030,
										'".$difference."'
												)";
	$result = DB_query($sql,$db);
		}
		if($added_amount<$totalNet && $added_amount != $totalNet){
		$sql = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
										VALUES (15,
										'".$id."',
										'".date('Y-m-d H-i-s')."',
										'" . $PeriodNo . "',
										7310,
										'".$difference."'
												)";
	$result = DB_query($sql,$db);
	
	$sql = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
										VALUES (15,
										'".$id."',
										'".date('Y-m-d H-i-s')."',
										'" . $PeriodNo . "',
										1030,
										'".-$difference."'
												)";
	$result = DB_query($sql,$db);
		}	
	}	
	else{
	$sql = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
										VALUES (15,
										'".$id."',
										'".date('Y-m-d H-i-s')."',
										'" . $PeriodNo . "',
										7310,
										'".$totalNet."'
												)";
	$result = DB_query($sql,$db);
	$sql = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
										VALUES (15,
										'".$id."',
										'".date('Y-m-d H-i-s')."',
										'" . $PeriodNo . "',
										1030,
										'".-$totalNet."'
												)";
	$result = DB_query($sql,$db);
	}	
} //isset post submit
?>