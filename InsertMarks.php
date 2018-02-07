<?php
/* $Id: PcTypeTabs.php 3924 2010-09-30 15:10:30Z tim_schofield $ */

$PageSecurity = 15;

include('includes/session.inc');
$title = _('Insert Marks');
include('includes/header.inc');

echo '<p class="page_title_text">' . ' ' . _('Insert Marks') . '';


	echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . '>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '<table class=selection cellspacing=4 width="40%"><tr><td valign=top><table class=selection width="50%">';
	
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
	$sql="SELECT id,subject_name FROM subjects 
	ORDER BY subject_name";
	$result=DB_query($sql,$db);
	while ($myrow = DB_fetch_array($result)) {
	echo '<option value='. $myrow['id'] . '>' . $myrow['subject_name'];
} //end while loop

	DB_data_seek($result,0);
	echo '</select></td></tr>';
	
	echo '<tr><td>' . _('Class') . ': </td><td><select tabindex="5" name="student_class">';
$result = DB_query('SELECT * FROM classes',$db);
while ($myrow = DB_fetch_array($result)) {
	if ($myrow['id']==$_POST['student_class']) {
		echo '<option selected VALUE=';
	} else {
		echo '<option VALUE=';
	}
	echo $myrow['id'] . '>' . $myrow['class_name'];
} //end while loop
	echo'</table></td></tr></table>';
	echo "<br><div class='centre'><input tabindex=20 type='Submit' name='submit' value='" . _('Submit') . "'>&nbsp;<input tabindex=21 type=submit action=RESET VALUE='" . _('Reset') . "'></div>";
	echo '</form>';
if (isset($_POST['submit'])) {
session_start();
$_SESSION['subject'] = $_POST['subject'];
$_SESSION['period'] = $_POST['period'];
$_SESSION['class'] = $_POST['student_class'];
echo '<br><table width="50%">';
echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . '>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
$sql = "SELECT subject_name FROM subjects
		WHERE id =  '". $_POST['subject']."'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);	
echo "<tr><td>" . _('Subject') . ":</td>
	<td>".$myrow[0]."</td>";

	$sql = "SELECT cl.class_name,gl.lower FROM classes cl
	INNER JOIN gradelevels gl ON  gl.id=cl.grade_level_id
	WHERE cl.id =  '". $_POST['student_class']."'";
	$result=DB_query($sql,$db);
	$myrow=DB_fetch_row($result);	
echo "<tr><td>" . _('Class') . ":</td>
	<td>".$myrow[0]."</td></tr>";
	$_SESSION['lower'] = $myrow[1];
	
$sql="SELECT cp.id,terms.title,years.year FROM collegeperiods cp
		INNER JOIN terms ON terms.id=cp.term_id
		INNER JOIN years ON years.id=cp.year 
		WHERE cp.id='".$_SESSION['period']."'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);	
echo "<tr><td>" . _('Period') . ":</td>
	<td>".$myrow[1].'-'.$myrow[2]."</td>";
echo '<tr><td>' . _('Exam Mode') . ":</td>
		<td><select name='exam_mode_id'>";
		echo '<OPTION SELECTED VALUE=0>' . _('Select exam mode');
		$sql="SELECT id,title FROM markingperiods ";
		$result=DB_query($sql,$db);
		while ($myrow = DB_fetch_array($result)) {
		echo '<option value='. $myrow['id'].  '>'.' '.$myrow['title'];
		} //end while loop
		DB_data_seek($result,0);
		echo '</select></td></tr>';
echo "<tr><td>" . _('Out Of') . ":</td>
	<td><input type='text' name='out_of' size=20></td>";
echo '<tr><th>' . _('AdmNo') . '</th>
	<th>' . _('Name') . ':</th>
	<th>' . _('Marks') . ':</th>';
		
$sql = "SELECT COUNT(*) FROM registered_students
		WHERE subject_id =  '". $_POST['subject'] ."'
		AND period_id =  '". $_POST['period'] ."'
		AND class_id='". $_SESSION['class'] ."'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);
		if ($myrow[0]>0 ){
         $sql = "SELECT rs.*,dm.name,dm.debtorno FROM registered_students rs
		 INNER JOIN debtorsmaster dm ON dm.id=rs.student_id
		WHERE subject_id =  '". $_POST['subject'] ."'
		AND period_id =  '". $_POST['period'] ."'
		AND rs.class_id='". $_SESSION['class'] ."'
		ORDER BY dm.gender,dm.name ASC";
         $DbgMsg = _('The SQL that was used to retrieve the information was');
         $ErrMsg = _('Could not check whether the group is recursive because');
         $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);	
	while ($row = DB_fetch_array($result))
			{
			 if (($j%2)==1)
		    echo "<tr bgcolor=\"F0F0F0\">";
		  else
	echo "<tr bgcolor=\"FFFFFF\">";
	echo "<input type='hidden' name='calendar_id[]' value='".$row['id']."'>";
	echo "<input type='hidden' name='student_id[]' value='".$row['student_id']."' >";
	echo "<tr><td class=\"visible\">".$row['debtorno']."</td>";
	echo "<td class=\"visible\">".$row['name']."</td>";
	echo "<td class=\"visible\"><input type='text' name='marks[]' size=20 ></td>";
	echo "</tr>";
	 $j++;
	}
	}
echo "<tr><td></td><td></td><td><input type=submit name='add_marks' value='"._('insert Marks')."'></td></tr>";
}
if (isset($_POST['add_marks']) && $_SESSION['CompanyRecord']['regoffice6'] ==_('primary')){
if($_POST['exam_mode_id']==0){
prnMsg(_(' You must select the exam mode'),'warn');
}
else{	
if(empty($_POST['out_of'])){
prnMsg(_(' Please fill the out of field'),'warn');
}
else{
$i=0;

foreach($_POST['marks'] as $value){
$sql = "SELECT name FROM debtorsmaster 
		WHERE id='". $_POST['student_id'][$i] ."'";
		$result=DB_query($sql,$db);
		$row=DB_fetch_row($result);
		$study1=$row[0];
$sql = "SELECT sm.id, dm.name FROM studentsmarks sm
INNER JOIN debtorsmaster dm ON dm.id=sm.student_id 
		WHERE sm.student_id='". $_POST['student_id'][$i] ."'
		AND sm.exam_mode='". $_POST['exam_mode_id'] ."'
		AND sm.calendar_id =  '".$_POST['calendar_id'][$i] ."'";
		$result=DB_query($sql,$db);
		$count=DB_fetch_row($result);
		$marks=$count[0];
		$study=$count[1];
	if($count>0){
prnMsg(_($study._(' ').'s marks has already been entered for this subject'),'warn');
	
}
else{
$sql = "SELECT exam_type_id FROM markingperiods
		WHERE id='". $_POST['exam_mode_id'] ."'";
		$result=DB_query($sql,$db);
		$row = DB_fetch_array($result);
	
if($_POST['marks'][$i] > $_POST['out_of']){
 prnMsg(_($study1._(' ').'Marks has exceeded out of field'),'warn'); 
}	//end of if marks>out of	
else{
if($_SESSION['subject']==11 || $_SESSION['subject']==10){
$sql = "INSERT INTO studentsmarks 
		(student_id,subject_id,period_id,marks,out_of,exam_mode,calendar_id,class_id,actual_marks,percentage_marks) 
		VALUES ('" .$_POST['student_id'][$i] ."','".$_SESSION['subject']."','" .$_SESSION['period']."',
		'" .($_POST['marks'][$i]/$_POST['out_of'])*40 ."','" .$_POST['out_of']."','" .$_POST['exam_mode_id']."','" .
		$_POST['calendar_id'][$i]."','".$_SESSION['class']."','".($_POST['marks'][$i]/$_POST['out_of'])*40 ."','".($_POST['marks'][$i]/$_POST['out_of'])*40 ."') ";
		$ErrMsg = _('This marks could not be added because');
			$result = DB_query($sql,$db,$ErrMsg);
}
elseif($_SESSION['subject']==8 || $_SESSION['subject']==12){
$sql = "INSERT INTO studentsmarks 
		(student_id,subject_id,period_id,marks,out_of,exam_mode,calendar_id,class_id,actual_marks,percentage_marks) 
		VALUES ('" .$_POST['student_id'][$i] ."','".$_SESSION['subject']."','" .$_SESSION['period']."',
		'" .($_POST['marks'][$i]/$_POST['out_of'])*60 ."','" .$_POST['out_of']."','" .$_POST['exam_mode_id']."','" .
		$_POST['calendar_id'][$i]."','".$_SESSION['class']."','".($_POST['marks'][$i]/$_POST['out_of'])*60 ."','".($_POST['marks'][$i]/$_POST['out_of'])*60 ."') ";
		$ErrMsg = _('This marks could not be added because');
			$result = DB_query($sql,$db,$ErrMsg);
}
elseif($_SESSION['subject']==13){
$sql = "INSERT INTO studentsmarks 
		(student_id,subject_id,period_id,marks,out_of,exam_mode,calendar_id,class_id,actual_marks,percentage_marks) 
		VALUES ('" .$_POST['student_id'][$i] ."','".$_SESSION['subject']."','" .$_SESSION['period']."',
		'" .($_POST['marks'][$i]/$_POST['out_of'])*30 ."','" .$_POST['out_of']."','" .$_POST['exam_mode_id']."','" .
		$_POST['calendar_id'][$i]."','".$_SESSION['class']."','".($_POST['marks'][$i]/$_POST['out_of'])*30 ."','".($_POST['marks'][$i]/$_POST['out_of'])*100 ."') ";
		$ErrMsg = _('This marks could not be added because');
			$result = DB_query($sql,$db,$ErrMsg);
}
elseif($_SESSION['subject']==14){
$sql = "INSERT INTO studentsmarks 
		(student_id,subject_id,period_id,marks,out_of,exam_mode,calendar_id,class_id,actual_marks,percentage_marks) 
		VALUES ('" .$_POST['student_id'][$i] ."','".$_SESSION['subject']."','" .$_SESSION['period']."',
		'" .($_POST['marks'][$i]/$_POST['out_of'])*60 ."','" .$_POST['out_of']."','" .$_POST['exam_mode_id']."','" .
		$_POST['calendar_id'][$i]."','".$_SESSION['class']."','".($_POST['marks'][$i]/$_POST['out_of'])*60 ."','".($_POST['marks'][$i]/$_POST['out_of'])*100 ."') ";
		$ErrMsg = _('This marks could not be added because');
			$result = DB_query($sql,$db,$ErrMsg);
}
elseif($_SESSION['subject']==7){
$sql="SELECT marks FROM studentsmarks
WHERE subject_id=13
AND period_id='" .$_SESSION['period']."'
AND student_id='" .$_POST['student_id'][$i] ."'
AND exam_mode='" .$_POST['exam_mode_id']."'";
$result=DB_query($sql, $db);
$myrow=DB_fetch_array($result);
$cre_marks=$myrow['marks'];

$sql="SELECT marks FROM studentsmarks
WHERE subject_id=14
AND period_id='" .$_SESSION['period']."'
AND student_id='" .$_POST['student_id'][$i] ."'
AND exam_mode='" .$_POST['exam_mode_id']."'";
$result=DB_query($sql, $db);
$myrow=DB_fetch_array($result);
$sst_marks=$myrow['marks'];

$sstcre_marks=$cre_marks+$sst_marks;
if($sstcre_marks !=''){
$sstcre_marks=($sstcre_marks/90)*100;
$sql = "INSERT INTO studentsmarks 
		(student_id,subject_id,period_id,marks,out_of,exam_mode,calendar_id,class_id,actual_marks) 
		VALUES ('" .$_POST['student_id'][$i] ."','".$_SESSION['subject']."','" .$_SESSION['period']."',
		'" . $sstcre_marks ."','" .$_POST['out_of']."','" .$_POST['exam_mode_id']."','" .
		$_POST['calendar_id'][$i]."','".$_SESSION['class']."','". $sstcre_marks ."') ";
		$ErrMsg = _('This marks could not be added because');
			$result = DB_query($sql,$db,$ErrMsg);
			}
}
elseif($_SESSION['subject']==4 && $_SESSION['lower']==0){
$sql="SELECT marks FROM studentsmarks
WHERE subject_id=11
AND period_id='" .$_SESSION['period']."'
AND student_id='" .$_POST['student_id'][$i] ."'
AND exam_mode='" .$_POST['exam_mode_id']."'";
$result=DB_query($sql, $db);
$myrow=DB_fetch_array($result);
$composition_marks=$myrow['marks'];

$sql="SELECT marks FROM studentsmarks
WHERE subject_id=12
AND period_id='" .$_SESSION['period']."'
AND student_id='" .$_POST['student_id'][$i] ."'
AND exam_mode='" .$_POST['exam_mode_id']."'";
$result=DB_query($sql, $db);
$myrow=DB_fetch_array($result);
$grammar_marks=$myrow['marks'];

$english_marks=$composition_marks+$grammar_marks;
if($english_marks !=''){
$sql = "INSERT INTO studentsmarks 
		(student_id,subject_id,period_id,marks,out_of,exam_mode,calendar_id,class_id,actual_marks,percentage_marks) 
		VALUES ('" .$_POST['student_id'][$i] ."','".$_SESSION['subject']."','" .$_SESSION['period']."',
		'" . $english_marks ."','" .$_POST['out_of']."','" .$_POST['exam_mode_id']."','" .
		$_POST['calendar_id'][$i]."','".$_SESSION['class']."','". $english_marks ."','$english_marks') ";
		$ErrMsg = _('This marks could not be added because');
			$result = DB_query($sql,$db,$ErrMsg);
			}
}
elseif($_SESSION['subject']==6 && $_SESSION['lower']==0){
$sql="SELECT marks FROM studentsmarks
WHERE subject_id=10
AND period_id='" .$_SESSION['period']."'
AND student_id='" .$_POST['student_id'][$i] ."'
AND exam_mode='" .$_POST['exam_mode_id']."'";
$result=DB_query($sql, $db);
$myrow=DB_fetch_array($result);
$insha_marks=$myrow['marks'];

$sql="SELECT marks FROM studentsmarks
WHERE subject_id=8
AND period_id='" .$_SESSION['period']."'
AND student_id='" .$_POST['student_id'][$i] ."'
AND exam_mode='" .$_POST['exam_mode_id']."'";
$result=DB_query($sql, $db);
$myrow=DB_fetch_array($result);
$lugha_marks=$myrow['marks'];

$kiswahili_marks=$insha_marks+$lugha_marks;
if($kiswahili_marks !=''){
$sql = "INSERT INTO studentsmarks 
		(student_id,subject_id,period_id,marks,out_of,exam_mode,calendar_id,class_id,actual_marks,percentage_marks) 
		VALUES ('" .$_POST['student_id'][$i] ."','".$_SESSION['subject']."','" .$_SESSION['period']."',
		'" . $kiswahili_marks."','" .$_POST['out_of']."','" .$_POST['exam_mode_id']."','" .
		$_POST['calendar_id'][$i]."','".$_SESSION['class']."','". $kiswahili_marks ."','". $kiswahili_marks ."') ";
		$ErrMsg = _('This marks could not be added because');
			$result = DB_query($sql,$db,$ErrMsg);
			}
}
else{
$sql = "INSERT INTO studentsmarks 
		(student_id,subject_id,period_id,marks,out_of,exam_mode,calendar_id,class_id,actual_marks,percentage_marks) 
		VALUES ('" .$_POST['student_id'][$i] ."','".$_SESSION['subject']."','" .$_SESSION['period']."',
		'" .($_POST['marks'][$i]/$_POST['out_of'])*100 ."','" .$_POST['out_of']."','" .$_POST['exam_mode_id']."','" .
		$_POST['calendar_id'][$i]."','".$_SESSION['class']."','".($_POST['marks'][$i]/$_POST['out_of'])*100 ."','".($_POST['marks'][$i]/$_POST['out_of'])*100 ."') ";
		$ErrMsg = _('This marks could not be added because');
			$result = DB_query($sql,$db,$ErrMsg);
			}	
		}

}//end of if marks >0
$i++;
}// end of foreach
prnMsg( _('Marks Added'),'success');
}//else out of field not empty
}// else exam mode selected
echo '</form>';			
}	// end of isset











elseif (isset($_POST['add_marks']) && $_SESSION['CompanyRecord']['regoffice6'] ==_('secondary')){
if($_POST['exam_mode_id']==0){
prnMsg(_(' You must select the exam mode'),'warn');
}
else{	
if(empty($_POST['out_of'])){
prnMsg(_(' Please fill the out of field'),'warn');
}
else{
$i=0;

foreach($_POST['marks'] as $value){
if($_POST['marks'][$i]>0){
$sql = "SELECT name FROM debtorsmaster 
		WHERE id='". $_POST['student_id'][$i] ."'";
		$result=DB_query($sql,$db);
		$row=DB_fetch_row($result);
		$study1=$row[0];
$sql = "SELECT sm.id, dm.name FROM studentsmarks sm
INNER JOIN debtorsmaster dm ON dm.id=sm.student_id 
		WHERE sm.student_id='". $_POST['student_id'][$i] ."'
		AND sm.exam_mode='". $_POST['exam_mode_id'] ."'
		AND sm.calendar_id =  '".$_POST['calendar_id'][$i] ."'";
		$result=DB_query($sql,$db);
		$count=DB_fetch_row($result);
		$marks=$count[0];
		$study=$count[1];
	if($count>0){
prnMsg(_($study._(' ').'s marks has already been entered for this subject'),'warn');
	
}
else{
$sql = "SELECT exam_type_id FROM markingperiods
		WHERE id='". $_POST['exam_mode_id'] ."'";
		$result=DB_query($sql,$db);
		$row = DB_fetch_array($result);
	if($row['exam_type_id']==1){
if($_POST['marks'][$i] > $_POST['out_of']){
 prnMsg(_($study1._(' ').'Marks has exceeded out of field'),'warn'); 
}	//end of if marks>out of	
else{
$sql = "INSERT INTO studentsmarks 
		(student_id,subject_id,period_id,marks,out_of,exam_mode,calendar_id,class_id,actual_marks) 
		VALUES ('" .$_POST['student_id'][$i] ."','".$_SESSION['subject']."','" .$_SESSION['period']."',
		'" .($_POST['marks'][$i]/$_POST['out_of'])*30 ."','" .$_POST['out_of']."','" .$_POST['exam_mode_id']."','" .
		$_POST['calendar_id'][$i]."','".$_SESSION['class']."','".($_POST['marks'][$i]/$_POST['out_of'])*100 ."') ";
		$ErrMsg = _('This marks could not be added because');
			$result = DB_query($sql,$db,$ErrMsg);
			
		}
	}//end of if exam type id==1
else{
if($_POST['marks'][$i] > $_POST['out_of']){
prnMsg(_($study1._(' ').'Marks has exceeded out of field'),'warn'); 
}
else{	
$sql = "INSERT INTO studentsmarks 
		(student_id,subject_id,period_id,marks,out_of,exam_mode,calendar_id,class_id,actual_marks) 
		VALUES ('" .$_POST['student_id'][$i] ."','".$_SESSION['subject']."','" .$_SESSION['period']."','" .($_POST['marks'][$i]/$_POST['out_of'])*70 ."','" .$_POST['out_of']."','" .$_POST['exam_mode_id']."','" .$_POST['calendar_id'][$i]."','".$_SESSION['class']."','" .($_POST['marks'][$i]/$_POST['out_of'])*100 ."') ";
		$ErrMsg = _('This marks could not be added because');
		$result = DB_query($sql,$db,$ErrMsg);
		
		}
}//end of else exam type !=1
}//end of if marks >0
}
$i++;
}// end of foreach
prnMsg( _('Marks Added'),'success');
}//else out of field not empty
}// else exam mode selected
echo '</form>';			
}	// end of isset
include('includes/footer.inc');
?>


