<?php
if (isset($_GET['PayrollID'])){
	$PayrollID = $_GET['PayrollID'];
} elseif (isset($_POST['PayrollID'])){
	$PayrollID = $_POST['PayrollID'];
} else {
	unset($PayrollID);
}
$_SESSION['payid']=$PayrollID;
$Status = GetOpenCloseStr(GetPayrollRow($PayrollID, $db,11));
if ($Status=='Closed') {
   exit("Payroll is Closed. Re-open first...");
}
if (isset($_POST['submit'])) {
   exit("Contact Administrator...");
} else {
if (!Is_Date($_SESSION['DateBanked'])){
	$_SESSION['DateBanked']= Date($_SESSION['DefaultDateFormat']);
	 
}
$PeriodNo = GetPeriod($_SESSION['DateBanked'],$db);

$totalNet=0;
	$sql = "UPDATE prlpayrolltrans SET	netpay=0
				WHERE payrollid ='" . $PayrollID . "'";
	$RePostNPay= DB_query($sql,$db);	
	
	$sql = "SELECT id FROM prlpayrollperiod
			WHERE payrollid='" . $PayrollID . "'";
	$results = DB_query($sql,$db);
	$myrow = DB_fetch_array($results);
	$id=$myrow['id'];
	
	$sql = "SELECT counterindex,payrollid,employeeid,grosspay,loandeduction,NSSF,PAYE,NHIF,tax
			FROM prlpayrolltrans
			WHERE prlpayrolltrans.payrollid='" . $PayrollID . "'";
	$PayDetails = DB_query($sql,$db);
	if(DB_num_rows($PayDetails)>0)
	{
		while ($myrow = DB_fetch_array($PayDetails))
		{	
				$NetPay=$myrow['grosspay']-$myrow['loandeduction']-$myrow['NSSF']-$myrow['PAYE']-$myrow['NHIF']-$myrow['tax'];
				$sql = 'UPDATE prlpayrolltrans SET netpay='.$NetPay.'
						WHERE counterindex = ' . $myrow['counterindex'];
				$PostNPay = DB_query($sql,$db);
			$totalNet=$totalNet+$NetPay;	
		}
	$sqlgl = "SELECT sum(amount) as amount
			FROM gltrans
			WHERE periodno='" . $PeriodNo . "'
			AND account=7040";
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
										7040,
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
										7040,
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
										7040,
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
					 
	}
echo "Finished processing payroll...";
}
?>