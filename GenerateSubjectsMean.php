<?php
/* $Id: PDFReceipt.php 3714 2010-09-07 21:31:01Z tim_schofield $*/

$PageSecurity = 2;
if(isset($_POST['period_id'])){
include('includes/session.inc');
include('grades/ClassSubjectMean.php');
require('grades/LecturerSubjectClass.php');
include('grades/OveralStreamReportGenerate.php');
include('grades/OveralClassReportGenerate.php');
$FontSize=13;

$sql2 = "SELECT y.run FROM years y
INNER JOIN collegeperiods cp ON cp.year=y.id
WHERE cp.id='".$_POST['period_id']."'";
$result2 = DB_query($sql2,$db);
$myrow2 = DB_fetch_array($result2);
$run=$myrow2['run'];
if($run==1){
 prnMsg(_('This academic year has already been compiled, Unroll first'),'warn'); 
exit("");
}	

$_SESSION['period'] = $_POST['period_id'];

$sql="SELECT year FROM collegeperiods WHERE id='".$_POST['period_id']."'";
	$result=DB_query($sql, $db);
	$myrow=DB_fetch_array($result);
	$_SESSION['year']=$myrow['year'];		

$sql="DELETE FROM subject_mean WHERE period_id ='" . $_POST['period_id'] . "'
AND rolled=0";
$Postdelptrans= DB_query($sql,$db);

$sql="DELETE FROM exam_ranks WHERE period_id ='" . $_POST['period_id'] . "'
AND rolled=0";
$Postdelptrans= DB_query($sql,$db);

$sql="DELETE FROM class_means WHERE period_id ='" . $_POST['period_id'] . "'
AND rolled=0";
$Postdelptrans= DB_query($sql,$db);

$sql="DELETE FROM class_subject_mean WHERE period_id ='" . $_POST['period_id'] . "'
AND rolled=0";
$Postdelptrans= DB_query($sql,$db);

$sql="DELETE FROM termly_student_ranks WHERE period_id ='" . $_POST['period_id'] . "'
AND rolled=0";
$Postdelptrans= DB_query($sql,$db);

$sql="DELETE FROM termly_class_ranks WHERE period_id ='" . $_POST['period_id'] . "'
AND rolled=0";
$Postdelptrans= DB_query($sql,$db);

$sql="DELETE FROM students_subject_marks WHERE period_id ='" . $_POST['period_id'] . "'
AND rolled=0";
$Postdelptrans= DB_query($sql,$db);

$sqlclass = "SELECT * FROM gradelevels ";
		$resultclass = DB_query($sqlclass,$db);	
while ($myrowclass= DB_fetch_array($resultclass))
{
$class_mean=0;
$total_class_mean=0;
$counted=0;
$bus_report = new bus_report($myrowclass['id'],$_POST['period_id'],$db);

$rank =0;
if($bus_report->scheduled_students>0){
$subjects_taken_by_student=0;
foreach ($bus_report->scheduled_students as $sa => $st) {
$total=0;
$rank=$rank+1;
$student_total=0;
$student_total2=0;
$subjects_taken_by_student=0;
$subject_add=0;
$mean=0;
$scheduled = new scheduled($st['student_id'],$db);

if($_SESSION['CompanyRecord']['regoffice6'] ==_('primary')){	
$scheduled->set_primary_vars_class($myrowclass['id'],$st['student_id'],$_POST['period_id'],$st['id'],$db);
$subject_meangrade_array=0;

foreach ($scheduled->subject as $y=>$z) {


$student_total2=$student_total2+$z['tmarks'];	

$sqlroll = "SELECT an.rolled,dm.name FROM students_subject_marks an
INNER JOIN debtorsmaster dm ON dm.id=an.student_id
WHERE an.student_id='".$st['student_id']."'
AND an.period_id='".$_POST['period_id']."'
AND rolled=1";
$resultroll = DB_query($sqlroll,$db);	

if(DB_num_rows($resultroll) >0){
$myrowroll= DB_fetch_array($resultroll);
$rolled=$myrowroll['rolled'];
$name=$myrowroll['name'];
}
else{
$sql = "INSERT INTO students_subject_marks (student_id,subject_id,period_id,marks,academic_year)
VALUES ('" . $st['student_id'] ."','" .$z['id'] ."','" .$_POST['period_id'] ."','" .$z['tmarks'] ."','".$_SESSION['year']."')";
$result = DB_query($sql,$db);
					}				
		}//end of scheduled subject
	}

				
$subjects_taken_by_student=students_subjects_class($st['student_id'],$_POST['period_id'],$db);



$sqlroll = "SELECT an.rolled,dm.name FROM termly_class_ranks an
INNER JOIN debtorsmaster dm ON dm.id=an.student_id
WHERE an.student_id='".$st['student_id']."'
AND an.period_id='".$_POST['period_id']."'
AND rolled=1";
$resultroll = DB_query($sqlroll,$db);	

if(DB_num_rows($resultroll) >0){
$myrowroll= DB_fetch_array($resultroll);
$rolled=$myrowroll['rolled'];
$name=$myrowroll['name'];
}
else{

$mean=$student_total2/$subjects_taken_by_student;	
$sql = "INSERT INTO termly_class_ranks (student_id,period_id,class_id,academic_year,marks,mean)
VALUES ('" . $st['student_id'] ."','" .$_POST['period_id'] ."','" .$myrowclass['id'] ."','".$_SESSION['year']."','$student_total2','$mean')";
$result = DB_query($sql,$db);
$msg = _('Student ranks generated successfuly');	
	
	$ranked=0;
	$rank_ties=0;					
$sqlrank = "SELECT marks,student_id FROM termly_class_ranks 
WHERE class_id='".$myrowclass['id']."'
AND period_id='".$_POST['period_id']."'
ORDER BY marks DESC";
$resultrank = DB_query($sqlrank,$db);
$previous_marks='';	
while ($myrowrank= DB_fetch_array($resultrank)){
if ($myrowrank['marks'] == $previous_marks) {
 $ranked=$ranked;
 $rank_ties=$rank_ties+1;
}
else{
$ranked=$rank_ties+$ranked+1;
$rank_ties=0;
}
$stude=$myrowrank['student_id'];
$sqlgenerate = "UPDATE termly_class_ranks
SET class_rank='" . $ranked . "'
WHERE student_id='".$stude."'
AND period_id='".$_POST['period_id']."'
AND class_id='" .$myrowclass['id'] ."'";
$generate = DB_query($sqlgenerate,$db);	
$previous_marks=$myrowrank['marks'];						
							}
							}
			}
			
			}// end of if
			
$subjects_array1 = tep_get_subjects($myrowclass['id'],$_POST['period_id'],$db);
if($subjects_array1>0){
foreach ($subjects_array1 as $r => $s) {
$bus_report_class = new bus_report_class($myrowclass['id'],$_POST['period_id'],$s['id'],$db);
$count=0;
$total_marks=0;
$total_marks2=0;
foreach ($bus_report_class->scheduled_students as $a => $b) {
$total_marks=total_marks_class($b['student_id'],$_POST['period_id'],$s['id'],$db);
$total_marks2=$total_marks2+$total_marks;	
$count=$count+1;
}
if($count > 0){
$subject_mean=$total_marks2/$count;
}
else{
$subject_mean=0;
}


$sqlroll = "SELECT an.rolled FROM class_subject_mean an
WHERE an.period_id='".$_POST['period_id']."'
AND rolled=1";
$resultroll = DB_query($sqlroll,$db);	

if(DB_num_rows($resultroll) >0){
$myrowroll= DB_fetch_array($resultroll);
$rolled=$myrowroll['rolled'];
$name=$myrowroll['name'];
}
else{
	$sql="INSERT INTO class_subject_mean (subject_id,period_id,class,mean,academic_year)
 	VALUES ('" . $s['id'] ."','" . $_POST['period_id'] ."','" . $myrowclass['id']."',	'" .$subject_mean."','".$_SESSION['year']."')";
	
			$ErrMsg = _('Subject Mean calculation failed because');
			$result = DB_query($sql,$db,$ErrMsg);
			}

}//end of ssubjects array foreach
}
		if($myrowclass['lower']==1){
		$sql= "SELECT SUM(csm.mean) as smean FROM class_subject_mean csm
		INNER JOIN subjects sub ON sub.id=csm.subject_id
		WHERE csm.class='" . $myrowclass['id']."'
		AND sub.lower_display=1
		AND csm.period_id= '" . $_POST['period_id'] ."'";
		$result = DB_query($sql,$db);	
		$myrow= DB_fetch_array($result);
		$total_class_mean=$myrow['smean'];
		
		
		$sql= "SELECT COUNT(csm.id) FROM class_subject_mean csm
		INNER JOIN subjects sub ON sub.id=csm.subject_id
		WHERE csm.class='" . $myrowclass['id']."'
		AND sub.lower_display=1
		AND period_id= '" . $_POST['period_id'] ."'";
		$result = DB_query($sql,$db);	
		$myrow= DB_fetch_row($result);
		$counted=$myrow[0];
		}
		else{
		$sql= "SELECT SUM(csm.mean) as smean FROM class_subject_mean csm
		INNER JOIN subjects sub ON sub.id=csm.subject_id
		WHERE csm.class='" . $myrowclass['id']."'
		AND sub.display=1
		AND csm.period_id= '" . $_POST['period_id'] ."'";
		$result = DB_query($sql,$db);	
		$myrow= DB_fetch_array($result);
		$total_class_mean=$myrow['smean'];
		
		$sql= "SELECT COUNT(csm.id) FROM class_subject_mean csm
		INNER JOIN subjects sub ON sub.id=csm.subject_id
		WHERE csm.class='" . $myrowclass['id']."'
		AND sub.display=1
		AND period_id= '" . $_POST['period_id'] ."'";
		$result = DB_query($sql,$db);	
		$myrow= DB_fetch_row($result);
		$counted=$myrow[0];
		}
		
		if($counted>0){
		$class_mean=$total_class_mean/$counted;
		
$sqlroll = "SELECT an.rolled FROM class_means an
WHERE an.period_id='".$_POST['period_id']."'
AND rolled=1";
$resultroll = DB_query($sqlroll,$db);	

if(DB_num_rows($resultroll) >0){
$myrowroll= DB_fetch_array($resultroll);
$rolled=$myrowroll['rolled'];
$name=$myrowroll['name'];
}
else{
		$sql="INSERT INTO class_means (period_id,class,mean,academic_year)
 	VALUES ('" . $_POST['period_id'] ."','" . $myrowclass['id']."',	'" .$class_mean."','".$_SESSION['year']."')";
			$result = DB_query($sql,$db);
			}
		}
		

$exams=get_exams($db);

foreach($exams as $exms=>$ex){
$exam_rank=0;
$stud_array=mode_marks($myrowclass['id'],$_POST['period_id'] ,$ex['id'],$db);
if($stud_array>0){
	foreach($stud_array as $studs=>$stds){
		$exam_rank=$exam_rank+1;
		
		$sql = "INSERT INTO exam_ranks (student_id,period_id,class_id,marks,academic_year,exam_id)
		VALUES ('" . $stds['id']."','" .$_POST['period_id'] ."','" .$myrowclass['id'] ."','".$stds['actual_marks']."',
		'".$_SESSION['year']."','".$ex['id']."')";
		$result = DB_query($sql,$db);
						}
$sql = "SELECT id FROM markingperiods 
ORDER BY id";
$result=DB_query($sql,$db);
while ($myrow=DB_fetch_array($result)){
						
$ranked2=0;
$rank_ties2=0;					
$sqlrank2 = "SELECT marks,student_id FROM exam_ranks 
WHERE class_id='".$myrowclass['id']."'
AND period_id='".$_POST['period_id']."'
AND exam_id='".$myrow['id']."'
ORDER BY marks DESC";
$resultrank2 = DB_query($sqlrank2,$db);
$previous_marks2='';	
while ($myrowrank2= DB_fetch_array($resultrank2)){
if ($myrowrank2['marks'] == $previous_marks2) {
 $ranked2=$ranked2;
 $rank_ties2=$rank_ties2+1;
}
else{
$ranked2=$rank_ties2+$ranked2+1;
$rank_ties2=0;
}
$stude2=$myrowrank2['student_id'];
$sqlgenerate2 = "UPDATE exam_ranks
SET rank='" . $ranked2 . "'
WHERE student_id='".$stude2."'
AND period_id='".$_POST['period_id']."'
AND class_id='" .$myrowclass['id'] ."'
AND exam_id='".$myrow['id']."'";
$generate2 = DB_query($sqlgenerate2,$db);	
$previous_marks2=$myrowrank2['marks'];	
						}																										
					}					
				}
			}
				
}// end class while
prnMsg( _('Classes compiled successfully'),'success');


$sqlstream = "SELECT * FROM classes ";
		$resultstream = DB_query($sqlstream,$db);	
while ($myrowstream= DB_fetch_array($resultstream))
{
$bus_report_stream = new bus_report_stream($myrowstream['id'],$_POST['period_id'],$db);
$rank_stream =0;
if($bus_report_stream->scheduled_students>0){
	
foreach ($bus_report_stream->scheduled_students as $sa => $st) {
$total=0;
$rank_stream=$rank_stream+1;
$scheduled = new scheduled_stream($st['student_id'],$db);
$subjects_taken_by_student=0;
$student_total=0;
$student_total2=0;

if($_SESSION['CompanyRecord']['regoffice6'] ==_('primary')){	
$scheduled->set_primary_vars_stream($myrowstream['id'],$st['student_id'],$_POST['period_id'],$st['id'],$db);

$subject_meangrade_array=0;

foreach ($scheduled->subject as $y=>$z) {

$student_total2=$student_total2+$z['tmarks'];	



		}//end of scheduled subject
		

	}
$sqlroll = "SELECT an.rolled,dm.name FROM termly_student_ranks an
INNER JOIN debtorsmaster dm ON dm.id=an.student_id
WHERE an.student_id='".$st['student_id']."'
AND an.period_id='".$_POST['period_id']."'
AND rolled=1";
$resultroll = DB_query($sqlroll,$db);	

if(DB_num_rows($resultroll) >0){
$myrowroll= DB_fetch_array($resultroll);
$rolled=$myrowroll['rolled'];
$name=$myrowroll['name'];
}
else{
$sql = "INSERT INTO termly_student_ranks (student_id,period_id,class_id,marks,academic_year)
		VALUES ('" . $st['student_id']."','" .$_POST['period_id'] ."','" .$myrowstream['id'] ."','$student_total2','".$_SESSION['year']."')";
					$result = DB_query($sql,$db);
					$msg = _('Student ranks generated successfuly');	
					
$ranked=0;
$ties=0;					
$sqlrank = "SELECT marks,student_id FROM termly_student_ranks 
WHERE class_id='".$myrowstream['id']."'
AND period_id='".$_POST['period_id']."'
ORDER BY marks DESC";
$resultrank = DB_query($sqlrank,$db);	
$prevRow2 = '';
while ($myrowrank= DB_fetch_array($resultrank)){
if ($myrowrank['marks'] == $prevRow2) {
 $ranked=$ranked;
 $ties=$ties+1;
}
else{
$ranked=$ties+$ranked+1;
$ties=0;
}
$stude=$myrowrank['student_id'];
$sqlgenerate = "UPDATE termly_student_ranks
SET rank='" . $ranked . "'
WHERE student_id='".$stude."'
AND period_id='".$_POST['period_id']."'
AND class_id='" .$myrowstream['id'] ."'";
$generate = DB_query($sqlgenerate,$db);	
$prevRow2=$myrowrank['marks'];					
							}					
					}	
			}
	}
	
	
	
$subjects_array = tep_get_subjects_stream($myrowstream['id'],$_POST['period_id'],$db);
if($subjects_array>0){
foreach ($subjects_array as $r => $s) {
$bus_report2 = new bus_report2($myrowstream['id'],$_POST['period_id'],$s['id'],$db);
$count=0;
$total_marks=0;
$total_marks2=0;
foreach ($bus_report2->scheduled_students as $a => $b) {
$total_marks=total_marks($b['student_id'],$_POST['period_id'],$s['id'],$db);
$total_marks2=$total_marks2+$total_marks;	
$count=$count+1;
}
if($count > 0){
$subject_mean=$total_marks2/$count;
}
else{
$subject_mean=0;
}

$sqlroll = "SELECT an.rolled FROM subject_mean an
WHERE an.period_id='".$_POST['period_id']."'
AND rolled=1";
$resultroll = DB_query($sqlroll,$db);	

if(DB_num_rows($resultroll) >0){
$myrowroll= DB_fetch_array($resultroll);
}
else{
	$sql="INSERT INTO subject_mean (subject_id,period_id,stream,mean,roll,academic_year)
 	VALUES ('" . $s['id'] ."','" . $_POST['period_id'] ."','" . $myrowstream['id']."',	'" .$subject_mean."',	'" . $count."','".$_SESSION['year']."')";
	
			$ErrMsg = _('Subject Mean calculation failed because');
			$result = DB_query($sql,$db,$ErrMsg);
			}

}//end of ssubjects array foreach
}		
}// end stream while
prnMsg( _('Streams compiled successfully'),'success');

unset($_SESSION['year']);
}
else { /*The option to print PDF was not hit */

	include('includes/session.inc');
	$title = _('Manage Students2');

include('includes/header.inc');

echo '<FORM METHOD="POST" ACTION="' . $_SERVER['PHP_SELF'] . '?' . SID . '">';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
echo '<CENTER><TABLE><TR><TD>' . _('Period:') . '</TD><TD><SELECT Name="period_id">';
		DB_data_seek($result, 0);
		$sql="SELECT cp.id,terms.title,years.year FROM collegeperiods cp
		INNER JOIN terms ON terms.id=cp.term_id
		INNER JOIN years ON years.id=cp.year ";
		$result=DB_query($sql,$db);
		while ($myrow = DB_fetch_array($result)) {
			if ($myrow['id'] == $_POST['id']) {  
				echo '<OPTION SELECTED VALUE=';
			} else {
				echo '<OPTION VALUE=';
			}
			echo $myrow['id'] . '>'.' '.$myrow['title'].' '.$myrow['year'];
		} //end while loop
	echo '</SELECT></TD></TR>';
	echo "</TABLE>";
	echo "<P><CENTER><INPUT TYPE='Submit' NAME='generate' VALUE='" . _('Generate') . "'> ";

	include('includes/footer.inc');;
} /*end of else not PrintPDF */

?>