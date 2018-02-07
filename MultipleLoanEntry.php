<?php
/* $Id: PcTypeTabs.php 3924 2010-09-30 15:10:30Z tim_schofield $ */

$PageSecurity = 15;

include('includes/session.inc');
$title = _('Loan Entry Form');
include('includes/header.inc');

echo '<p class="page_title_text">' . ' ' . _('Loan Entry Form') . '';


	echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . '>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';

echo '<table border="1">';

echo '</br><tr><td>' . _('Loan Description') . ': </td>
			<td><input  type="Text" name="loan_description"  size=40 maxlength=50></td></tr>
<TR><TD>' . _('Loan Type') . ":</TD><TD><SELECT NAME='LoanTableID'>";		
	DB_data_seek($result, 0);
	$sql = 'SELECT loantableid, loantabledesc FROM prlloantable';
	$result = DB_query($sql, $db);
	while ($myrow = DB_fetch_array($result)) {
		if ($_POST['LoanTableID'] == $myrow['loantableid']){
			echo '<OPTION SELECTED VALUE=' . $myrow['loantableid'] . '>' . $myrow['loantabledesc'];
		} else {
			echo '<OPTION VALUE=' . $myrow['loantableid'] . '>' . $myrow['loantabledesc'];
		}
	} //end while loop			

echo '<tr><td>' . _('Loan Date') . ': </td>
<td><input  type="Text" class="date" alt="'.$_SESSION['DefaultDateFormat'].'" name="loan_date"  size=40  size=40 maxlength=50></td></tr>';

echo '<TR><TD>' . _('Account Code') . ":</TD><TD><SELECT NAME='AccountCode'>";		
	DB_data_seek($result, 0);
	$sql = 'SELECT accountcode, accountname FROM chartmaster';
	$result = DB_query($sql, $db);
	while ($myrow = DB_fetch_array($result)) {
		if ($_POST['AccountCode'] == $myrow['accountcode']){
			echo '<OPTION SELECTED VALUE=' . $myrow['accountcode'] . '>' . $myrow['accountname'];
		} else {
			echo '<OPTION VALUE=' . $myrow['accountcode'] . '>' . $myrow['accountname'];
		}
	} //end while loop	
	echo "</SELECT></TD></TR></TABLE></BR></BR>";

echo '<table border="1">';
echo '<tr><th>' . _('Emp ID') . '</th>
	<th>' . _('Name') . ':</th>
		<th>' . _('Amount') . ':</th>
		<th>' . _('Amortization') . ':</th>
		<th>' . _('Start Date') . ':</th>
		</tr>';	
$sql = "SELECT * FROM prlemployeemaster";
		$result=DB_query($sql,$db);
		
			while ($row = DB_fetch_array($result))
			{
			 if (($j%2)==1)
		    echo "<tr bgcolor=\"F0F0F0\">";
		  else
		    echo "<tr bgcolor=\"FFFFFF\">";
			$ovamount=-$row['ovamount']; ?>
			<?php 
		echo "<tr><td><Input type = 'Checkbox' name ='add_id[]' value='".$row['employeeid']."'>".$row['employeeid']."</td>";
			?><?php
		  echo "<td><Input type = 'text' value='".$row['firstname']._(' ').$row['lastname']."' size='20' readonly=''>"."</td>";
		  echo "<td><Input type = 'text' name='amount' size='20' >"."</td>";
		   echo "<td><Input type = 'text' name='amortization' size='20' >"."</td>";
 echo '<td><Input type="Text" class="date" alt="'.$_SESSION['DefaultDateFormat'].'" name="start_date"  size=20 >'."</td>";
		    echo "</tr>";
		  $j++;
}	

echo "<br><div class='centre'><input tabindex=20 type='Submit' name='submit' value='" . _('Submit') . "'>&nbsp;<input tabindex=21 type=submit action=RESET VALUE='" . _('Reset') . "'></div>";
	echo '</form>';
	
if (isset($_POST['add_marks'])){
foreach($_POST['marks'] as $value){

$sql = "INSERT INTO studentsmarks 
		(student_id,period_id,marks,out_of,exam_mode,calendar_id) 
		VALUES ('" .$_POST['student_id'][$i] ."','" .$_SESSION['period']."','" .$_POST['marks'][$i] ."','" .$_POST['out_of']."','" .$_POST['exam_mode_id']."','" .$_POST['calendar_id'][$i]."') ";
		$ErrMsg = _('This marks could not be added because');
		$result = DB_query($sql,$db,$ErrMsg);
		prnMsg( _('Marks Added'),'success');
}

echo '</form>';			
}	
include('includes/footer.inc');
?>


