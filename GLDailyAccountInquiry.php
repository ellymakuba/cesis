<?php

$PageSecurity = 8;
include ('includes/session.inc');
$title = _('Daily Banking Inquiry');
include('includes/header.inc');

echo '<p class="page_title_text"><img src="'.$rootpath.'/css/'.$theme.'/images/money_add.png" title="' .
	 _('Search') . '" alt="">' . ' ' . $title.'</p>';

if (!isset($_POST['Show'])) {
	echo '<form action=' . $_SERVER['PHP_SELF'] . '?' . SID . ' method=post>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';

	echo '<table width="70%">';

	$SQL = 'SELECT accountcode, accountname FROM chartmaster ORDER BY accountcode';

	$ErrMsg = _('The bank accounts could not be retrieved because');
	$DbgMsg = _('The SQL used to retrieve the bank accounts was');
	$AccountsResults = DB_query($SQL,$db,$ErrMsg,$DbgMsg);

	echo '<tr><td>' . _('GL Account') . ':</td><td><select name="Account">';

	if (DB_num_rows($AccountsResults)==0){
		echo '</select></td></tr></table><p>';
		prnMsg( _('Accounts have not yet been defined. You must first') . ' <a href="' . $rootpath . '/BankAccounts.php">' . _('define the bank accounts') . '</a> ' . _('and general ledger accounts to be affected'),'warn');
		include('includes/footer.inc');
		exit;
	} else {
		while ($myrow=DB_fetch_array($AccountsResults)){
		/*list the bank account names */
			if (!isset($_POST['Account'])){
				$_POST['Account']=$myrow['accountcode'];
			}
			if ($_POST['Account']==$myrow['accountcode']){
			echo '<option selected value="' . $myrow['accountcode'] . '">' . $myrow['accountname'] ;
			} else {
				echo '<option value="' . $myrow['accountcode'] . '">' . $myrow['accountname'];
			}
		}
		echo '</select></td></tr>';
	}
	echo '<tr><td>' . _('Transactions Dated') . ':</td>
		<td><input type="text" name="TransDate" class="date" alt="'.$_SESSION['DefaultDateFormat'].'" maxlength=10 size=11
			onChange="isDate(this, this.value, '."'".$_SESSION['DefaultDateFormat']."'".')" value="' .
				date($_SESSION['DefaultDateFormat']) . '"></td>
		</tr>';

	echo '</table>';
	echo '<br><div class="centre"><input type="submit" name="Show" value="' . _('Show transactions'). '"></div>';
	echo '</form>';
} else {
$FirstPeriodSelected = $_POST['TransDate'];
	$balancebf=0;
	$DebitAmountbf =0;
	$CreditAmountbf=0;
	$sql="SELECT amount
		FROM gltrans
		WHERE account = '" . $_POST['Account'] . "'
		AND trandate < '".FormatDateForSQL($_POST['TransDate'])."'
		ORDER BY trandate, counterindex";
	$result = DB_query($sql, $db);
	while ($myrow=DB_fetch_array($result)) {
	$balancebf=$myrow['amount']+$balancebf;
	}	
	$sql="SELECT  typeno,
			trandate,
			narrative,
			amount,
			periodno,
			tag
		FROM gltrans
		WHERE account = '" . $_POST['Account'] . "'
		AND trandate='".FormatDateForSQL($_POST['TransDate'])."'
		ORDER BY trandate, counterindex";
	$result = DB_query($sql, $db);
	if (DB_num_rows($result)>0 OR $balancebf>=0 OR $balancebf<=0) {
		$myrow = DB_fetch_array($result);
		echo '<table width="70%">';
		echo '<tr><th colspan=7><font size=3 color=blue>';
		echo _('Account Transactions For').' '.$myrow['accountname'].' '._('On').' '.$_POST['TransDate'];
		echo '</font></th></tr>';
		echo '<tr>';
		echo '<th>'._('Date').'</th>';
		echo '<th>'._('Debit').'</th>';
		echo '<th>'._('Credit').'</th>';
		echo '<th>'._('Narrative').'</th>';
		echo '</tr>';
		echo '<tr>';
		if($balancebf>=0){
			$DebitAmountbf = number_format($balancebf,2);
			$CreditAmountbf = '';
		} else {
			$CreditAmountbf = number_format(-$balancebf,2);
			$DebitAmountbf = '';
		}
		echo '<td>'._('Balance B/F').'</td>';
		echo '<td>'.$DebitAmountbf.'</td>';
		echo '<td>'.$CreditAmountbf.'</td>';
		echo '<td>'._('none').'</td>';
		echo '</tr>';
		
		echo '<tr>';
		if($myrow['amount']>=0){
			$DebitAmount = number_format($myrow['amount'],2);
			$CreditAmount = '';
		} else {
			$CreditAmount = number_format(-$myrow['amount'],2);
			$DebitAmount = '';
		}
		echo '<td>'.$myrow['trandate'].'</td>';
		echo '<td>'.$DebitAmount.'</td>';
		echo '<td>'.$CreditAmount.'</td>';
		echo '<td>'.$myrow['narrative'].'</td>';
		echo '</tr>';
		$total = 0;
		while ($myrow=DB_fetch_array($result)) {
		$total  =$total + $myrow['amount'];
		if($myrow['amount']>=0){
			$DebitAmount = number_format($myrow['amount'],2);
			$CreditAmount = '';
		} else {
			$CreditAmount = number_format(-$myrow['amount'],2);
			$DebitAmount = '';
		}
			
			echo '<tr>';
			echo '<td>'.$myrow['trandate'].'</td>';
			echo '<td>'.$DebitAmount.'</td>';
			echo '<td>'.$CreditAmount.'</td>';
			echo '<td>'.$myrow['narrative'].'</td>';
			echo '</tr>';
		}
		$balbf=$total+$balancebf; 
		if($balbf>=0){
		$CreditAmountcd = number_format($balbf,2);
			$DebitAmountcd = '';
			
		} else {
			$DebitAmountcd = number_format(-$balbf,2);
			$CreditAmountcd = '';
		}
		echo '<tr>';
			echo '<td>'._('Balance C/D').'</td>';
			echo '<td>'.$DebitAmountcd.'</td>';
			echo '<td>'.$CreditAmountcd.'</td>';
			echo '<td>'._('none').'</td>';
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