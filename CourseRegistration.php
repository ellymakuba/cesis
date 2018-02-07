<?php

/* $Id: CustomerReceipt.php 3868 2010-09-30 14:53:59Z tim_schofield $ */
/* $Revision: 1.46 $ */
ob_start();
$PageSecurity = 2;
include('includes/session.inc');

$title = _('Course Registration');

include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc');
$msg='';
$sql = "SELECT id FROM debtorsmaster
		WHERE debtorno= '". $_SESSION['UserID'] ."'";
        $result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);
		$student_id=$myrow[0];
echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . '>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '<table>';

echo '<tr><td>' . _('Semester') . ":</td>
		<td><select name='period_id'>";
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
		
echo '<tr><td class="visible">' . _('Registration Type') . ":</td>
		<td class=\"visible\"><select name='registration_type'>";
		echo '<OPTION SELECTED VALUE=0>' . _('Select Registration Type');
		$sql="SELECT * FROM registration_types ORDER BY name";
		$result=DB_query($sql,$db);
		while ($myrow = DB_fetch_array($result)) {
		echo '<option value='. $myrow['id'] . '>' . $myrow['name'];
		} //end while loop
		DB_data_seek($result,0);
		echo '</select></td></tr></table>';		
			
		echo '<table border="1">';
echo "<br><div class='centre'><input  type='Submit' name='submit' value='" . _('Display Courses') . "'>&nbsp;<input  type=submit action=RESET VALUE='" . _('Reset') . "'></div>";	

if (isset($_POST['submit'])) {
$sql="SELECT (CASE WHEN (start_semester_date <= now() and end_semester_date >= now())
				  THEN '1'
				  ELSE '0'
				 END) AS postable
FROM collegeperiods				 
WHERE id= '" . $_POST['period_id'] . "'";
$result=DB_query($sql,$db);
$myrow=DB_fetch_array($result);
$postable=$myrow['postable'];
if($postable==0){
prnMsg(_('The period for course registration is over'),'warn');
exit("Please contact the administrator for assistance");
}
$_SESSION['semester'] = $_POST['period_id'];
$_SESSION['registration'] = $_POST['registration_type'];
	if (isset($_GET['pageno'])) {
   $pageno = $_GET['pageno'];
} else {
   $pageno = 1;
}


$sql = "SELECT count(*) FROM debtorsmaster";
$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
$query_data = DB_fetch_row($result);
$numrows = $query_data[0];
			
$targetpage = "RegisterStudents.php";
$rows_per_page = 25;
$lastpage      = ceil($numrows/$rows_per_page);
$pageno = (int)$pageno;
if ($pageno > $lastpage) {
   $pageno = $lastpage;
} // if
$limit = 'LIMIT ' .($pageno - 1) * $rows_per_page .',' .$rows_per_page;	
$SearchString = '%' . str_replace(' ', '%', $_POST['searchval']) . '%';

if (isset($_SESSION['UserID']) 
  && isset($_POST['period_id']) && $_POST['period_id'] !=0
  && isset($_POST['registration_type']) && $_POST['registration_type'] !=0)
 {
$sql = "SELECT gl.id,gl.grade_level FROM gradelevels gl
INNER JOIN debtorsmaster dm ON dm.grade_level_id=gl.id 
WHERE dm.id='$student_id'";
$result = DB_query($sql,$db);
$query = DB_fetch_row($result);
$grade_level_id = $query[0];
$grade_level = $query[1];

$sql = "SELECT cl.id FROM classes cl
INNER JOIN debtorsmaster dm ON dm.class_id=cl.id
WHERE dm.id='$student_id'";
$result = DB_query($sql,$db);
$query = DB_fetch_row($result);
$student_class = $query[0];

$_SESSION['student_class']=$student_class;

$sql = "SELECT c.id,c.course_name FROM courses c
INNER JOIN debtorsmaster dm ON dm.course_id=c.id
WHERE dm.id='$student_id'";
$result = DB_query($sql,$db);
$query_data = DB_fetch_row($result);
$course_name = $query_data[1];
$course_id = $query_data[0];

$sql = "SELECT name FROM registration_types 
WHERE id='".$_SESSION['registration']."'";
$result = DB_query($sql,$db);
$query_data = DB_fetch_row($result);
$registration = $query_data[0];

echo '<tr><td>' . _('Program') . ":</td>
		<td>".$course_name."</td></tr>";
echo '<tr><td>' . _('Registration Type') . ":</td>
		<td>".$registration."</td></tr>";
if($_SESSION['registration']==4){

		$sql="SELECT sub.id,sub.subject_name,sub.subject_code FROM subjects sub
		INNER JOIN registered_students rs ON rs.subject_id=sub.id
		WHERE rs.student_id='".$student_id."'
		AND rs.period_id='".$_SESSION['semester']."'
		AND rs.asterik=1
		GROUP BY rs.subject_id
		ORDER BY sub.subject_name";
		$result=DB_query($sql,$db);
		
}
elseif($_SESSION['registration']==5){
echo '<tr><td>' . _('Preffered Center') . ":</td>
		<td><select name='preffered_center'>";
		echo '<OPTION SELECTED VALUE=0>' . _('Select Center');
		$sql="SELECT id,locationname FROM locations";
		$result=DB_query($sql,$db);
		while ($myrow = DB_fetch_array($result)) {
		echo '<option value='. $myrow['id'] . '>' . $myrow['locationname'];
		} //end while loop
		DB_data_seek($result,0);
		echo '</select></td></tr>';	

		$sql="SELECT sub.id,sub.subject_name,sub.subject_code FROM subjects sub
		INNER JOIN registered_students rs ON rs.subject_id=sub.id
		WHERE rs.student_id='".$student_id."'
		AND rs.period_id='".$_SESSION['semester']."'
		AND rs.asterik=1
		GROUP BY rs.subject_id
		ORDER BY sub.subject_name";
		$result=DB_query($sql,$db);
		
		

}
else{		

		$sql="SELECT sub.id,sub.subject_name,sub.subject_code FROM subjects sub
		INNER JOIN scheduled_courses sc ON sc.course_id=sub.id
		WHERE sc.program_id='".$course_id ."'
		AND sc.grade_level_id='".$grade_level_id."'
		AND sc.term_id='".$_SESSION['semester']."'
		ORDER BY sub.subject_name";
		$result=DB_query($sql,$db);
		
}	
	

}		
else{
prnMsg( _('Please choose program,class,semester and the registration type'),'error');
exit();
}			
			while ($row = DB_fetch_array($result))
			{
			 if (($j%2)==1)
		    echo "<tr bgcolor=\"F0F0F0\">";
		  else
		    echo "<tr bgcolor=\"FFFFFF\">";
			$ovamount=-$row['ovamount']; ?>
			<?php 
		echo "<tr><td class=\"visible\"><Input type = 'Checkbox' name ='add_id[]' value='".$row['id']."'>".$row['subject_code']."</td>";
			?><?php
		  echo "<td class=\"visible\">".$row['subject_name']."</td>";
		  
		    echo "</tr>";
		  $j++;
			}
			
if ($pageno == 1) {
   echo "<tr><td>"." FIRST PREV ";
} else {
   echo " <a href='{$_SERVER['PHP_SELF']}?pageno=1'>FIRST</a> ";
   $prevpage = $pageno-1;
   echo " <a href='{$_SERVER['PHP_SELF']}?pageno=$prevpage'>PREV</a> ";
}
echo " ( Page $pageno of $lastpage ) ";
if ($pageno == $lastpage) {
   echo " NEXT LAST "."</td></tr>";
} else {
   $nextpage = $pageno+1;
   echo " <a href='{$_SERVER['PHP_SELF']}?pageno=$nextpage'>NEXT</a> ";
   echo " <a href='{$_SERVER['PHP_SELF']}?pageno=$lastpage'>LAST</a> ";
}
echo "<br><div class='centre'><input  type='Submit' name='register' value='" . _('Register') . "'></div>";
}
if (isset($_POST['register'])){
$i=0;	
if($_SESSION['registration']==4){
if(isset($_POST['add_id'])){
foreach($_POST['add_id'] as $value){
$sql = "SELECT id FROM registered_retake_students
		WHERE subject_id='". $_POST['add_id'][$i] ."'
		AND student_id='". $student_id ."'
		AND period_id =  '".$_SESSION['semester'] ."'";
		$result=DB_query($sql,$db);
if(DB_fetch_row($result)>0){
prnMsg(_($_POST['add_id'][$i]._(' ').'has already been registered for this subject retake'),'warn');
$i++;		
}
else{
$sql = "SELECT id FROM registered_students
		WHERE subject_id='". $_POST['add_id'][$i] ."'
		AND student_id='". $student_id ."'
		AND period_id =  '".$_SESSION['semester'] ."'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);
		$calendar_id=$myrow[0];

$sql = "SELECT id FROM registered_supplimentary_students
		WHERE subject_id='". $_POST['add_id'][$i] ."'
		AND student_id='". $student_id ."'
		AND period_id =  '".$_SESSION['semester'] ."'";
		$result=DB_query($sql,$db);
if(DB_fetch_row($result)>0){
prnMsg(_($_POST['add_id'][$i]._(' ').'has already been registered for  subject supplimentary this period'),'warn');
$i++;		
}
else{
$sql = "INSERT INTO registered_retake_students (student_id,subject_id,period_id,calendar_id) 
		VALUES ('" .$student_id ."','" .$_POST['add_id'][$i] ."','" .$_SESSION['semester'] ."','" .$calendar_id  ."') ";
		$ErrMsg = _('The student could not be updated because');
$result = DB_query($sql,$db,$ErrMsg);
prnMsg( _('student retake registration successful'),'success');
$i++;
}
		
}//end of else
}//end of foreach
}//end of if $_POST['add_id']
include('includes/footer.inc');
			exit;
}//end of $_POST['register']


if($_SESSION['registration']==5){
if(!isset($_POST['preffered_center']) || $_POST['preffered_center']==0 ){
prnMsg(_('You must select the preffered center option'),'warn');
}
else{
if(isset($_POST['add_id'])){
foreach($_POST['add_id'] as $value){
$sql = "SELECT id FROM registered_supplimentary_students
		WHERE subject_id='". $_POST['add_id'][$i] ."'
		AND student_id='". $student_id ."'
		AND period_id =  '".$_SESSION['semester'] ."'";
		$result=DB_query($sql,$db);
if(DB_fetch_row($result)>0){
prnMsg(_($_POST['add_id'][$i]._(' ').'has already been registered for this subject supplimentary'),'warn');
$i++;		
}
else{
$sql = "SELECT id FROM registered_students
		WHERE subject_id='". $_POST['add_id'][$i] ."'
		AND student_id='". $student_id ."'
		AND period_id =  '".$_SESSION['semester'] ."'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);
		$calendar_id=$myrow[0];

$sql = "SELECT id FROM registered_retake_students
		WHERE subject_id='". $_POST['add_id'][$i] ."'
		AND student_id='". $student_id ."'
		AND period_id =  '".$_SESSION['semester'] ."'";
		$result=DB_query($sql,$db);
if(DB_fetch_row($result)>0){
prnMsg(_($_POST['add_id'][$i]._(' ').'has already been registered for subject retake this period'),'warn');
$i++;		
}
else{
$sql = "UPDATE registered_students SET 		 
center_id='".$_POST['preffered_center']."'
WHERE id = '".$calendar_id."'";
$query = DB_query($sql,$db);

$sql = "INSERT INTO registered_supplimentary_students (student_id,subject_id,period_id,calendar_id) 
		VALUES ('" .$student_id ."','" .$_POST['add_id'][$i] ."','" .$_SESSION['semester'] ."','" .$calendar_id ."') ";
		$ErrMsg = _('The student could not be updated because');
$result = DB_query($sql,$db,$ErrMsg);
prnMsg( _('student supplimentary registration successful'),'success');
$i++;
}
		
}//end of else
}//end of foreach
}//end of if $_POST['add_id']
include('includes/footer.inc');
			exit;
}//end of if $_SESSION['registration']==5
}


else{

if(isset($_POST['add_id'])){
foreach($_POST['add_id'] as $value){
$sql = "SELECT id FROM registered_students
		WHERE subject_id='". $_POST['add_id'][$i] ."'
		AND student_id='". $student_id ."'
		AND period_id =  '".$_SESSION['semester'] ."'";
		$result=DB_query($sql,$db);
if(DB_fetch_row($result)>0){
prnMsg(_($_POST['add_id'][$i]._(' ').'has already been registered for this subject'),'warn');
$i++;		
}
else{
$sql = "INSERT INTO registered_students (student_id,subject_id,period_id,class_id) 
		VALUES ('" .$student_id ."','" .$_POST['add_id'][$i] ."','" .$_SESSION['semester'] ."','" .$_SESSION['student_class'] ."') ";
		$ErrMsg = _('The student could not be updated because');
$result = DB_query($sql,$db,$ErrMsg);
$i++;
prnMsg( _('student registration successful'),'success');		
}//end of else
}//end of foreach
}//end of if $_POST['add_id']
include('includes/footer.inc');
			exit;
}//end of $_POST['register']
}
	
include('includes/footer.inc');
?>
