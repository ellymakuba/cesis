<?php

$PageSecurity = 8;
include ('includes/session.inc');
$title = _('Daily Student Bank Payments');
include('includes/header.inc'); ?>

<script type="text/javascript">
<!--
function confirmation() {
	var answer = confirm("Are you sure you want to add this Payment?")
	if (answer){
		alert("Bye bye!")
		window.location = "http://localhost/";
	}
	else{
		alert("Thanks for sticking around!")
	}
}
//-->
</script>

<?php
echo '<p class="page_title_text"><img src="'.$rootpath.'/css/'.$theme.'/images/money_add.png" title="' .
	 _('Search') . '" alt="">' . ' ' . $title.'</p>';

if (!isset($_POST['Show'])) {
	echo '<form action=' . $_SERVER['PHP_SELF'] . '?' . SID . ' method=post>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';

	echo '<table class=selection>';

	$SQL = 'SELECT bankaccountname,
				bankaccounts.accountcode,
				bankaccounts.currcode
			FROM bankaccounts,
				chartmaster
			WHERE bankaccounts.accountcode=chartmaster.accountcode';

	$ErrMsg = _('The bank accounts could not be retrieved because');
	$DbgMsg = _('The SQL used to retrieve the bank accounts was');
	$AccountsResults = DB_query($SQL,$db,$ErrMsg,$DbgMsg);

	echo '<tr><td>' . _('Transactions Dated') . ':</td>
		<td><input type="text" name="TransDate" class="date" alt="'.$_SESSION['DefaultDateFormat'].'" maxlength=10 size=11
			onChange="isDate(this, this.value, '."'".$_SESSION['DefaultDateFormat']."'".')" value="' .
				date($_SESSION['DefaultDateFormat']) . '"></td>
		</tr>';

	echo '</table>';
	echo '<br><div class="centre"><input type="submit" name="Show" value="' . _('Show transactions'). '"></div>';
	echo '</form>';
} else {
	$prevpayment=0;
	$todayspayment=0;
	$sql="SELECT banktrans.banktranstype,banktrans.banktransid,SUM(banktrans.amount) as amount,banktrans.transdate,banktrans.transdate,banktrans.inputdate,banktrans.addedby,debtorsmaster.name as name,debtorsmaster.debtorno as regno,
		systypes.typename,systypes.typeid,bankaccounts.bankaccountname as accname
			FROM banktrans,debtorsmaster,salesorderdetails,systypes,bankaccounts
			WHERE banktrans.inputdate='".FormatDateForSQL($_POST['TransDate'])."'
			AND transdate < '".FormatDateForSQL($_POST['TransDate'])."'
			AND salesorderdetails.id=banktrans.transno
			AND salesorderdetails.student_id=debtorsmaster.debtorno
			AND bankaccounts.accountcode=banktrans.bankact
			AND banktrans.type=systypes.typeid";
	$result = DB_query($sql, $db);
	$myrow=DB_fetch_array($result);
	$prevpayment=$myrow['amount'];
	
	$sql="SELECT banktrans.banktranstype,banktrans.banktransid,SUM(banktrans.amount) as amount,banktrans.transdate,banktrans.transdate,banktrans.inputdate,banktrans.addedby,debtorsmaster.name as name,debtorsmaster.debtorno as regno,
		systypes.typename,systypes.typeid,bankaccounts.bankaccountname as accname
			FROM banktrans,debtorsmaster,salesorderdetails,systypes,bankaccounts
			WHERE transdate='".FormatDateForSQL($_POST['TransDate'])."'
			AND banktrans.inputdate='".FormatDateForSQL($_POST['TransDate'])."'
			AND salesorderdetails.id=banktrans.transno
			AND salesorderdetails.student_id=debtorsmaster.debtorno
			AND bankaccounts.accountcode=banktrans.bankact
			AND banktrans.type=systypes.typeid";
	$result = DB_query($sql, $db);
	$myrow=DB_fetch_array($result);
	$todayspayment=$myrow['amount'];

	$sql="SELECT banktrans.banktranstype,banktrans.banktransid,banktrans.amount,banktrans.transdate,banktrans.transdate,banktrans.inputdate,banktrans.addedby,debtorsmaster.name as name,debtorsmaster.debtorno as regno,
		systypes.typename,systypes.typeid,bankaccounts.bankaccountname as accname
			FROM banktrans,debtorsmaster,salesorderdetails,systypes,bankaccounts
			WHERE banktrans.inputdate='".FormatDateForSQL($_POST['TransDate'])."'
			AND salesorderdetails.id=banktrans.transno
			AND salesorderdetails.student_id=debtorsmaster.debtorno
			AND bankaccounts.accountcode=banktrans.bankact
			AND banktrans.type=systypes.typeid ORDER BY banktransid";
	$result = DB_query($sql, $db);
	if (DB_num_rows($result)>0) {
		echo '<table border="\1"\>';
		echo '<tr><th colspan=7><font size=3 color=blue>';
		echo _('Payment Transactions For').' '.$_POST['TransDate'];
		echo '</font></th></tr>';
		echo '<tr>';
		echo '<th>'._('Transaction Type').'</th>';
		echo '<th>'._('Student RegNo').' '.'</th>';
		echo '<th>'._('Student Name').' '.'</th>';
		echo '<th>'._('Amount in').' '.$_SESSION['CompanyRecord']['currencydefault'].'</th>';
		echo '<th>'._('Bank Acoount').'</th>';
		echo '<th>'._('Slip Date').' '.'</th>';
		echo '<th>'._('System Entry Date').' '.'</th>';
		echo '<th>'._('Added By').' '.'</th>';
		echo '</tr>';
		while ($myrow=DB_fetch_array($result)) {
		echo '<tr>';
		echo '<td>'.$myrow['banktranstype'].'</td>';
		echo '<td>'.$myrow['regno'].'</td>';
		echo '<td>'.$myrow['name'].'</td>';
		echo '<td class=number>'.number_format($myrow['amount'],2).'</td>';
		echo '<td>'.$myrow['accname'].'</td>';
		echo '<td>'.$myrow['transdate'].'</td>';
		echo '<td>'.$myrow['inputdate'].'</td>';
		echo '<td>'.$myrow['addedby'].'</td>';
		$AccountCurrTotal += $myrow['amount'];
		echo '</tr>';
		}	
			echo '<tr>';
			echo '<td>'.Previous.'</td>';
			echo '<td>'.'</td>';
			echo '<td>'.'</td>';
			echo '<td>'.'</td>';
			echo '<td>'.number_format($prevpayment,2).'</td>';
			echo '</tr>';
			echo '<tr>';
			echo '<td>'.Todays.'</td>';
			echo '<td>'.'</td>';
			echo '<td>'.'</td>';
			echo '<td>'.'</td>';
			echo '<td>'.number_format($todayspayment,2).'</td>';
			echo '</tr>';
			echo '<tr>';
			echo '<td>'.Total.'</td>';
			echo '<td>'.'</td>';
			echo '<td>'.'</td>';
			echo '<td>'.'</td>';
			echo '<td>'.number_format($AccountCurrTotal,2).'</td>';
			echo '</tr>';
		echo '</table>';
	} else {
		prnMsg( _('There are no transactions for this account on that day'), 'info');
	}
	echo '<form action=' . $_SERVER['PHP_SELF'] . '?' . SID . ' method=post>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '<br><div class="centre"><input type="submit" name="Return" value="' . _('Select Another Date'). '"></div>';
	echo '</form>';
}
include('includes/footer.inc');

?>