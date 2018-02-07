<?php
$PageSecurity = 5;
include('includes/DefineCartClass.php');
include('includes/DefineSerialItems.php');
include('includes/session.inc');
$title = _('Fee Structure');
include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc');
include('includes/GetSalesTransGLCodes.inc');
echo '<p class="page_title_text">' . ' ' . _('Class Invoice Summary') . '';

if (isset($_POST['show']))
{
	$sql="SELECT grade_level FROM gradelevels where id='".$_POST['class_id']."'";
	$result=DB_query($sql,$db);
	$row=DB_fetch_array($result);
	$className=$row['grade_level'];

	$sql="SELECT title FROM terms where id='".$_POST['term']."'";
	$result=DB_query($sql,$db);
	$row=DB_fetch_array($result);
	$term=$row['title'];

	$sql="SELECT dm.debtorno as regno,dm.name as name,
	(SELECT id FROM salesorderdetails WHERE  salesorderdetails.student_id  = regno
	AND salesorderdetails.term='".$_POST['term']."') as invoice,
		(SELECT coalesce(sum(invoice_items.totalinvoice),  0) AS total FROM invoice_items
		 WHERE  invoice_items.invoice_id=invoice) as student_total,
	  (SELECT  coalesce(-sum(debtortrans.ovamount), 0) AS amount FROM debtortrans
	  WHERE debtortrans.transno =invoice) AS paid,
	  (SELECT student_total - paid ) AS owing
		FROM debtorsmaster dm	WHERE dm.grade_level_id='".$_POST['class_id']."'
		AND dm.status=0
		GROUP BY dm.debtorno
		ORDER BY dm.name";
	$result = DB_query($sql, $db);
	$count=0;
	if (DB_num_rows($result)>0) {
		echo '<table class="enclosed">';
		echo '<tr><th colspan=10><font size=3 color=blue>';
		echo _('Invoice summary for ').' '.$className.' '.$term;
		echo '</font></th></tr>';
		echo '<tr>';
		echo '<th>'._('Count').'</th>';
		echo '<th>'._('Student RegNo').' '.'</th>';
		echo '<th>'._('Student Name').' '.'</th>';
		echo '<th>'._('Invoiced').' '.'</th>';
		echo '<th>'._('Paid').' '.'</th>';
		echo '<th>'._('Balance').'</th>';
		echo '</tr>';
		while ($myrow=DB_fetch_array($result)){
			if ($k==1){
				echo '<tr class="EvenTableRows">';
				$k=0;
			} else {
				echo '<tr>';
				$k=1;
			}
		$count=$count+1;
		echo '<td>'.$count.'</td>';
		echo '<td>'.$myrow['regno'].'</td>';
		echo '<td>'.$myrow['name'].'</td>';
		echo '<td>'.number_format($myrow['student_total'],2).'</td>';
		echo '<td>'.number_format($myrow['paid'],2).'</td>';
		echo '<td>'.number_format($myrow['owing'],2).'</td>';
		$totalInvoiced+=$myrow['student_total'];
		$totalPaid+=$myrow['paid'];
		$TotalBalance += $myrow['owing'];
		echo '</tr>';
		}
			echo '<tr>';
			echo '<td class="visible">'.Total.'</td>';
			echo '<td class="visible">'.'</td>';
			echo '<td class="visible">'.'</td>';
			echo '<td class="visible">'.number_format($totalInvoiced,2).'</td>';
			echo '<td class="visible">'.number_format($totalPaid,2).'</td>';
			echo '<td class="visible">'.number_format($TotalBalance,2).'</td>';
			echo '</tr>';
		echo '</table>';
	} else {
		prnMsg( _('There are no transactions for the selected term'), 'info');
	}
}
else{
echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . '>';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
echo '<table class="enclosed">';
echo '<tr><td>' . _('Class') . ":</td>
<td><select name='class_id'>";
echo '<OPTION SELECTED VALUE=0>' . _('Select Class');
$sql="SELECT * FROM gradelevels WHERE id !=11 ORDER BY grade_level";
$result=DB_query($sql,$db);
while ($myrow = DB_fetch_array($result)) {
echo '<option value='. $myrow['id'] . '>' . $myrow['grade_level'];
} //end while loop
echo '</select></td></tr>';
echo '<tr><td>' . _('Term') . ":</td>
<td><select name='term'>";
echo '<OPTION SELECTED VALUE=0>' . _('Select Term');
$sql="SELECT * FROM terms";
$result=DB_query($sql,$db);
while ($myrow = DB_fetch_array($result))
{
   echo '<option value='. $myrow['id'].  '>'.' '.$myrow['title'].' '.$myrow['year'];
} //end while loop
DB_data_seek($result,0);
echo '</select></td></tr>';
echo '</table>';
echo '<table class="enclosed">';
echo "<div class='centre'><input  type='Submit' name='show' value='" . _('Show Summary') . "'></div>";
echo "</form>";
}
include('includes/footer.inc');
?>
