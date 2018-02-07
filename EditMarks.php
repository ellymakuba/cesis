
<?php
/* $Id: PcTypeTabs.php 3924 2010-09-30 15:10:30Z tim_schofield $ */

$PageSecurity = 15;

include('includes/session.inc');
$title = _('Edit Marks');
include('includes/header.inc');

echo '<p class="page_title_text">' . ' ' . _('Edit Marks') . '';


	echo "<form name='frmactive' method='post' action=" . $_SERVER['PHP_SELF'] . '>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '<table class=selection cellspacing=4><tr><td valign=top><table class=selection>';
	
	echo '<tr><td>' . _('Period') . ":</td>
		<td><select name='period'>";
		echo '<OPTION SELECTED VALUE=0>' . _('Select Period');
		$sql="SELECT cp.id,terms.title,years.year FROM collegeperiods cp
		INNER JOIN terms ON terms.id=cp.term_id
		INNER JOIN years ON years.id=cp.year ";
		$result=DB_query($sql,$db);
		while ($myrow = DB_fetch_array($result)) {
		echo '<option value='. $myrow['id'].  '>'.' '.$myrow['title'].' '.$myrow['year'];
		} //end while loop
		DB_data_seek($result,0);
		echo '</select></td></tr>';

	DB_data_seek($result,0);
	echo '</select></td></tr>';
	echo '<tr><td>' . _('Subject') . ":</td>
	<td><select name='subject'>";
	echo '<OPTION SELECTED VALUE=0>' . _('Select Subject');
	$sql="SELECT id,subject_name FROM subjects ";
	$result=DB_query($sql,$db);
	while ($myrow = DB_fetch_array($result)) {
	echo '<option value='. $myrow['id'] . '>' . $myrow['subject_name'];
} //end while loop
	DB_data_seek($result,0);
	echo '</select></td></tr>';
	echo '<tr><td>' . _('Exam Mode') . ":</td>
		<td><select name='exam_mode'>";
		echo '<OPTION SELECTED VALUE=0>' . _('Select exam mode');
		$sql="SELECT id,title FROM markingperiods ";
		$result=DB_query($sql,$db);
		while ($myrow = DB_fetch_array($result)) {
		echo '<option value='. $myrow['id'].  '>'.' '.$myrow['title'];
		} //end while loop
		DB_data_seek($result,0);
	echo '</select></td></tr>';	
echo '<tr><td>' . _('Class') . ': </td><td><select tabindex="5" name="student_class">';
$result = DB_query('SELECT * FROM classes',$db);
while ($myrow = DB_fetch_array($result)) {
	if ($myrow['id']==$_POST['class_name']) {
		echo '<option selected VALUE=';
	} else {
		echo '<option VALUE=';
	}
	echo $myrow['id'] . '>' . $myrow['class_name'];
} //end while loop
	echo'</select></td></tr></table></td></tr></table>';
	echo "<br><div class='centre'><input tabindex=20 type='Submit' name='submit' value='" . _('Submit') . "'>&nbsp;<input tabindex=21 type=submit action=RESET VALUE='" . _('Reset') . "'></div>";
	echo '</form>';
if (isset($_POST['submit'])) {
$_SESSION['subject'] = $_POST['subject'];
$_SESSION['period'] = $_POST['period'];
$_SESSION['exam_mode'] = $_POST['exam_mode'];
$_SESSION['class'] = $_POST['student_class'];
echo '<br><table width="40%">';
echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . '>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	
$sql = "SELECT fullaccess FROM www_users
		WHERE userid=  '" . trim($_SESSION['UserID']) . "'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);
		$user=$myrow[0];
$todays_date=FormatDateForSQL($todays_date);
$sql="SELECT (CASE WHEN (start_marks_posting_date <= now() and end_marks_posting_date >= now())
				  THEN '1'
				  ELSE '0'
				 END) AS postable
FROM collegeperiods				 
WHERE id= '" . $_POST['period'] . "'";
$result=DB_query($sql,$db);
$myrow=DB_fetch_array($result);
$postable=$myrow['postable'];
/*
if($postable==0 && $user !=8){
prnMsg(_('Today does not fall within the allocated period for editing Marks'),'warn');
exit("Please contact the administrator for assistance");
}
*/
$sql="SELECT year_status,year FROM collegeperiods
WHERE id= '" . $_POST['period'] . "'";
$result=DB_query($sql,$db);
$myrow = DB_fetch_array($result);
$year_status=$myrow['year_status'];
$year_period=$myrow['year'];
if($year_status==1){
prnMsg(_('This periods academic year has been closed'),'warn');
exit("Please note that you cannot add/edit marks of a clossed period");
}
$sql2 = "SELECT run FROM years
		WHERE id='".$year_period."'";
		$result2 = DB_query($sql2,$db);
		$myrow2 = DB_fetch_array($result2);
		$run=$myrow2['run'];
if($run==1){
 prnMsg(_('This academic year has already been compiled and cannot be edited'),'warn'); 
exit("Note that editing was disabled due to upholding data intergrity");
}	

$sql = "SELECT subject_name FROM subjects
		WHERE id =  '". $_POST['subject']."'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);	
echo "<tr><td colspan=2>" . _('Subject') . ":</td>
	<td>".$myrow[0]."</td></tr>";
	
$sql = "SELECT class_name FROM classes
		WHERE id =  '". $_POST['student_class']."'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);	
echo "<tr><td colspan=2>" . _('Class') . ":</td>
	<td>".$myrow[0]."</td></tr>";

$sql="SELECT cp.id,terms.title,years.year FROM collegeperiods cp
		INNER JOIN terms ON terms.id=cp.term_id
		INNER JOIN years ON years.id=cp.year 
		WHERE cp.id='".$_SESSION['period']."'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);	
echo "<tr><td colspan=2>" . _('Period') . ":</td>
	<td>".$myrow[1].'-'.$myrow[2]."</td></tr>";
echo "<tr><td colspan=2>" . _('Out Of') . ":</td>
	<td><input type='text' name='out_of' size=20></td></tr>";
echo '<tr><th>' . _('ID') . '</th>
	<th>' . _('AdmNo') . ':</th>
	<th>' . _('Name') . ':</th>
	<th>' . _('Marks') . ':</th></tr>';
	
	$sql = "SELECT exam_type_id FROM markingperiods
		WHERE id='". $_POST['exam_mode'] ."'";
		$result=DB_query($sql,$db);
		$row = DB_fetch_array($result);
		$real_type=$row['exam_type_id'];
		
         $sql = "SELECT rs.id as ids,rs.subject_id,rs.student_id,sm.marks,dm.debtorno,dm.name 
		 FROM registered_students rs
		 INNER JOIN studentsmarks sm ON rs.id=sm.calendar_id
		 INNER JOIN debtorsmaster dm ON dm.id=rs.student_id
		WHERE rs.subject_id =  '". $_POST['subject'] ."'
		AND rs.period_id =  '". $_POST['period'] ."'
		AND sm.exam_mode='". $_POST['exam_mode'] ."'
		AND rs.class_id='". $_POST['student_class'] ."'
		ORDER BY dm.name";
         $DbgMsg = _('The SQL that was used to retrieve the information was');
         $ErrMsg = _('Could not check whether the group is recursive because');
         $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
		 $count=DB_num_rows($result);	
	while ($row = DB_fetch_array($result))
			{
			 if (($j%2)==1)
		    echo "<tr>";
		  
	echo "<tr><td class=\"visible\"><input type='checkbox' name='calendar_id[]' value='".$row['ids']."'>".$row['ids']."</td>";
echo "<input type='hidden' name='student_id[]' value='".$row['student_id']."' readonly=''>"; 
echo "<td class=\"visible\"><input type='text' name='student_id2[]' value='".$row['debtorno']."' readonly=''></td>"; 
echo "<td class=\"visible\">".$row['name']."</td>"; 
echo "<td class=\"visible\">"; ?><input type="text" name='marks<?php echo $row['ids']; ?>' id='marks' value='<?php echo $row['marks']; ?>' size='20' > <?php "</td>";
	echo "</tr>";
	 $j++;
	}
echo "<tr><td></td><td></td><td><input type=submit name='edit_marks' value='"._('Edit Marks')."'></td><td><input  type=submit name='delete_marks' VALUE='" . _('Delete') . "'></td></tr>";
echo '</table><br></form>';		
}
if (isset($_POST['edit_marks'])){
$i=0;

foreach($_POST['calendar_id'] as $id){
$sql = "SELECT out_of FROM studentsmarks
		WHERE exam_mode='". $_SESSION['exam_mode'] ."'
		AND calendar_id='" .$id ."'";
		$result=DB_query($sql,$db);
		$row = DB_fetch_array($result);
		$outof=$row['out_of'];
		
$sql = "SELECT exam_type_id FROM markingperiods
		WHERE id='". $_SESSION['exam_mode'] ."'";
		$result=DB_query($sql,$db);
		$row = DB_fetch_array($result);
	if($row['exam_type_id']==1){
if($_POST['marks'.$id] > $outof){
 prnMsg(_('Marks cannot exceed Out of field'),'warn'); 
exit();
}		

$sql = "UPDATE studentsmarks  SET marks='" .$_POST['marks'.$id] ."',
	actual_marks='" .$_POST['marks'.$id] ."',
	percentage_marks='" .$_POST['marks'.$id] ."'
		WHERE calendar_id='" .$id ."'
		AND exam_mode='" .$_SESSION['exam_mode'] ."'";
		$ErrMsg = _('This marks could not be updated because');
			$result = DB_query($sql,$db,$ErrMsg);
			prnMsg( _('Marks updated'),'success');
	}
else{
if($_POST['marks'.$id] > $outof){
 prnMsg(_('Exam marks cannot exceed out of field'),'warn'); 
exit();
}	
$sql = "UPDATE studentsmarks  SET marks='" .$_POST['marks'.$id] ."',
		actual_marks='" .$_POST['marks'.$id] ."',
		percentage_marks='" .$_POST['marks'.$id] ."'
		WHERE calendar_id='" .$id."'
		AND exam_mode='" .$_SESSION['exam_mode'] ."'";
		$ErrMsg = _('This marks could not be updated because');
			$result = DB_query($sql,$db,$ErrMsg);
			prnMsg( _('Marks updated'),'success');
}
}
$i++;
}

if (isset($_POST['delete_marks'])){
	foreach($_POST['calendar_id'] as $id){
	$sql = "DELETE FROM studentsmarks 
		WHERE calendar_id='" .$id ."'
		AND exam_mode='" .$_SESSION['exam_mode'] ."'";
		$ErrMsg = _('This marks could not be updated because');
			$result = DB_query($sql,$db,$ErrMsg);
			prnMsg( _('Marks deleted'),'success');
	
	}
}		

include('includes/footer.inc');
?>


