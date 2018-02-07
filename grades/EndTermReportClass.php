<?php
function mode_marks($student_id,$period_id,$exam_mode,$db) {
	$sql = "select gl.lower FROM debtorsmaster dm
	INNER JOIN registered_students rs ON rs.student_id=dm.id
	INNER JOIN gradelevels gl ON gl.id=rs.yos
	WHERE dm.id='$student_id'
	AND rs.period_id='$period_id'
	GROUP BY student_id";
	$result = DB_query($sql,$db);
	$row = DB_fetch_row($result);
	$lower_display=$row[0];	
	
	if($lower_display==1){
	$sql = "select SUM(sm.percentage_marks) as actual_marks  from studentsmarks sm
	INNER JOIN subjects sub ON sub.id=sm.subject_id
	WHERE sm.student_id='$student_id'
	AND sm.period_id='$period_id'
	AND sm.exam_mode='$exam_mode'
	AND sub.lower_display=1";
	$result = DB_query($sql,$db);
	$row = DB_fetch_row($result);
	$actual_marks=$row[0];
	return $actual_marks;
	}
	else{
	$sql = "select SUM(sm.actual_marks) as actual_marks  from studentsmarks sm
	INNER JOIN subjects sub ON sub.id=sm.subject_id
	WHERE sm.student_id='$student_id'
	AND sm.period_id='$period_id'
	AND sm.exam_mode='$exam_mode'
	AND sub.display=1";
	$result = DB_query($sql,$db);
	$row = DB_fetch_row($result);
	$actual_marks=$row[0];
	return $actual_marks;
	}
		}

	
function get_form_terms($db) {
	$sql = "select id,title FROM terms";
	$result = DB_query($sql,$db);
	while ($row = DB_fetch_array($result)) {
		$terms_array[] = array("id" => $row['id'],
				     "title" => $row['title']);
	}
	return $terms_array;
}

function get_student_position($student_id,$period_id,$exam_mode,$db) {
	$sql = "select rank FROM exam_ranks
	WHERE exam_id='$exam_mode'
	AND student_id='$student_id'
	AND period_id='$period_id'";
	$result = DB_query($sql,$db);
	$row = DB_fetch_array($result);
	return  $row['rank'];
}
function get_tracking_out_of($period_id,$class,$db) {
$sql = "SELECT COUNT(*) FROM termly_class_ranks  
WHERE period_id =  '". $period_id ."'
AND class_id='$class'";
$result=DB_query($sql,$db);
$myrow=DB_fetch_row($result);
return $myrow[0];
}
function get_forms($db) {
	$sql = "select id,grade_level FROM gradelevels
	WHERE grade_level NOT LIKE 'None'";
	$result = DB_query($sql,$db);
	while ($row = DB_fetch_array($result)) {
		$forms_array[] = array("id" => $row['id'],
				     "grade_level" => $row['grade_level']);
	}
	return $forms_array;
}

function tep_get_status($period,$student,$db) {
	$sql = "select DISTINCT(sm.exam_mode), mp.* from markingperiods mp
	INNER JOIN studentsmarks sm ON sm.exam_mode=mp.id 
	WHERE mp.title NOT LIKE 'Transcript'
	AND sm.period_id='$period'
	AND sm.student_id='$student'
	order by mp.priority";
	$result = DB_query($sql,$db);
	while ($row = DB_fetch_array($result)) {
		$status_array[] = array("id" => $row['id'],
				     "title" => $row['title']);
	}
	return $status_array;
}
function tep_get_status_amount($marking_period_id, $calendar_id,$subject_id,$student_id,$period,$db) {
	$sql = "select COUNT(mp.exam_type_id)  from studentsmarks sm
	INNER JOIN registered_students rs ON rs.id=sm.calendar_id
	INNER JOIN markingperiods mp ON mp.id=sm.exam_mode
	INNER JOIN collegeperiods cp ON cp.id=sm.period_id
	WHERE rs.id='$calendar_id'
	AND mp.exam_type_id=1
	AND rs.subject_id='$subject_id'
	AND sm.calendar_id='$calendar_id'
	AND rs.student_id='$student_id'
	AND cp.id='$period'";
	$result = DB_query($sql,$db);
	$row = DB_fetch_row($result);
	$num_of_cats= $row[0];
	
	$sql = "select gl.lower FROM debtorsmaster dm
	INNER JOIN registered_students rs ON rs.student_id=dm.id
	INNER JOIN gradelevels gl ON gl.id=rs.yos
	WHERE dm.id='$student_id'
	AND rs.period_id='$period'
	GROUP BY student_id";
		$result = DB_query($sql,$db);
		$row = DB_fetch_row($result);
		$lower=$row[0];	
		
	if($lower==1){
		$sql = "select sm.percentage_marks from studentsmarks sm
		INNER JOIN registered_students rs ON rs.id=sm.calendar_id
		INNER JOIN markingperiods mp ON mp.id=sm.exam_mode
		INNER JOIN collegeperiods cp ON cp.id=sm.period_id
		WHERE rs.id='$calendar_id'
		AND mp.id ='$marking_period_id'
		AND rs.subject_id='$subject_id'
		AND sm.calendar_id='$calendar_id'
		AND rs.student_id='$student_id'
		AND cp.id='$period'";
		$result = DB_query($sql,$db);
		$row = DB_fetch_row($result);
		$marks= $row[0];
		
			return $marks;
			}
	else{	
	$sql = "select sm.marks from studentsmarks sm
	INNER JOIN registered_students rs ON rs.id=sm.calendar_id
	INNER JOIN markingperiods mp ON mp.id=sm.exam_mode
	INNER JOIN collegeperiods cp ON cp.id=sm.period_id
	WHERE rs.id='$calendar_id'
	AND mp.id ='$marking_period_id'
	AND rs.subject_id='$subject_id'
	AND sm.calendar_id='$calendar_id'
	AND rs.student_id='$student_id'
	AND cp.id='$period'";
	$result = DB_query($sql,$db);
	$row = DB_fetch_row($result);
	$marks= $row[0];
	
		return $marks;
		
	}	
	
}


class course {

var $id;
var $course_name;
var $course_code;
var $course_cost;
var $course_duration;

function course($id,$db) {
	$sql = "select * from courses where id = '$id' limit 1";
	$result = DB_query($sql,$db);
	$row = DB_fetch_array($result);
	$this->id = $id;
	$this->course_name = $row['course_name'];
	$this->course_code = $row['course_code'];
	$this->course_cost = $row['course_cost'];
	$this->course_duration = $row['course_duration'];
}


function set_calendar_vars($calendar_id,$db) {
	$sql = "select * from calendar where id='$calendar_id' LIMIT 1";
	$result = DB_query($sql,$db);
	$row = DB_fetch_array($result);
	$this->start_date = $row['start_date'];
	$this->calendar_id = $calendar_id;
}


}

class subject {

var $id;
var $subject_name;
var $subject_code;
var $course_id;
var $lecturer_id;
var $grading;

function subject($id,$db) {
	$sql = "select * from subjects where id = '$id' limit 1";
	$result = DB_query($sql,$db);
	$row = DB_fetch_array($result);
	$this->id = $id;
	$this->subject_name = $row['subject_name'];
	$this->subject_code = $row['subject_code'];
	$this->course_id = $row['course_id'];
	$this->lecturer_id = $row['lecturer_id'];
	$this->grading = $row['grading'];
}


function set_calendar_vars($calendar_id,$db) {
	$sql = "select * from registered_students where id='$calendar_id' LIMIT 1";
	$result = DB_query($sql,$db);
	$row = DB_fetch_array($result);
	$this->calendar_id = $calendar_id;
}


}

 class scheduled extends subject {
	var $calendar_id;
	var $start_date;
	var $status;
	var $asterik;			//array containing the number of users in different status.
	var $total_users;
	var $cancelled;

	function scheduled($id,$db) {
		$this->subject($id,$db);
	}

	

	function set_calendar_vars($calendar_id,$subject_id,$student_id,$period,$db) {
		$sql = "select * from registered_students where id='$calendar_id' LIMIT 1";
		$result = DB_query($sql,$db);
		$row = DB_fetch_array($result);
		$this->calendar_id = $calendar_id;
		$this->asterik = $row['asterik'];
		// set status var
		$status_array = tep_get_status($period,$student_id,$db);
		foreach ($status_array as $r=>$s) {
			$this->status[] = array("id" => $s['id'],
									"asterik" => $this->asterik,
								   "marks" => tep_get_status_amount($s['id'], $this->calendar_id,$subject_id,$student_id,$period,$db));
		}
	}

}
class bus_report {
	var $course;			//array of courses that are eligible for report
	var $start_date;
	var $end_date;

	var $scheduled_courses;			//courses included in $course that was scheduled within the given time


	function bus_report($student,$period, $db) {
		$this->subject = $this->get_subject($db);

		$this->scheduled_subjects = $this->get_scheduled_subjects($student,$period,$db);
	}

	function get_subject($db) {
		$subject_array = array();
		// build where clause to exclude courses by previous choices.
		
		$sql = "select id from subjects ";
		//echo $query;
		$result = DB_query($sql,$db);
		while ($row = DB_fetch_array($result)) {
			$subject_array[] = $row['id'];
		}
		return $subject_array;
	}


	function get_scheduled_subjects($student,$period,$db) {
		$sql = "select gl.lower FROM debtorsmaster dm
		INNER JOIN registered_students rs ON rs.student_id=dm.id
	INNER JOIN gradelevels gl ON gl.id=rs.yos
	WHERE dm.id='$student'
	AND rs.period_id='$period'
	GROUP BY student_id";
	$result = DB_query($sql,$db);
	$row = DB_fetch_row($result);
	$lower=$row[0];
	if($lower==1){
	
			$scheduled_subjects_array = array();
			$sql = "select rs.id, rs.subject_id,sub.lower_display from registered_students rs
			INNER JOIN subjects sub ON sub.id=rs.subject_id
			WHERE rs.period_id='$period'
			AND rs.student_id='$student'
			AND sub.lower_display=1
			ORDER BY sub.priority";
			//echo $query;
			$result = DB_query($sql,$db);
			if (DB_num_rows($result) > 0) {
				while ($row = DB_fetch_array($result)) {
					$scheduled_subjects_array[] = array('id' => $row['id'],
													'subject_id' => $row['subject_id'],
													'lower_display' => $row['lower_display']);
				}
				return $scheduled_subjects_array;
			}
			else
			{
				//there was not any courses in this time and we return an empty array
				return $scheduled_subjects_array;
			}
	}
	else{		
			$scheduled_subjects_array = array();
			$sql = "select rs.id, rs.subject_id,sub.lower_display from registered_students rs
			INNER JOIN subjects sub ON sub.id=rs.subject_id
			WHERE rs.period_id='$period'
			AND rs.student_id='$student'
			AND sub.display=1
			ORDER BY sub.priority";
			//echo $query;
			$result = DB_query($sql,$db);
			if (DB_num_rows($result) > 0) {
				while ($row = DB_fetch_array($result)) {
					$scheduled_subjects_array[] = array('id' => $row['id'],
													'subject_id' => $row['subject_id'],
													'lower_display' => $row['lower_display']);
				}
				return $scheduled_subjects_array;
			}
			else
			{
				//there was not any courses in this time and we return an empty array
				return $scheduled_subjects_array;
			}
		}
	}
	
function total_marks($subject_id,$student_id,$period,$calendar_id,$db) {
	
	
	$sql = "select COUNT(mp.exam_type_id)  from studentsmarks sm
	INNER JOIN registered_students rs ON rs.id=sm.calendar_id
	INNER JOIN markingperiods mp ON mp.id=sm.exam_mode
	INNER JOIN collegeperiods cp ON cp.id=sm.period_id
	WHERE rs.id='$calendar_id'
	AND rs.subject_id='$subject_id'
	AND sm.calendar_id='$calendar_id'
	AND rs.student_id='$student_id'
	AND cp.id='$period'";
	$result = DB_query($sql,$db);
	$row = DB_fetch_row($result);
	$num_of_exam_mode= $row[0];
	
	$sql = "select gl.lower FROM debtorsmaster dm
	INNER JOIN registered_students rs ON rs.student_id=dm.id
	INNER JOIN gradelevels gl ON gl.id=rs.yos
	WHERE dm.id='$student_id'
	AND rs.period_id='$period'
	GROUP BY student_id";
	$result = DB_query($sql,$db);
	$row = DB_fetch_row($result);
	$lower_display=$row[0];	
	
	if($lower_display==1){
	$sql = "select SUM(sm.percentage_marks) as cat_marks,SUM(sm.actual_marks) from studentsmarks sm
	INNER JOIN registered_students rs ON rs.id=sm.calendar_id
	INNER JOIN markingperiods mp ON mp.id=sm.exam_mode
	INNER JOIN collegeperiods cp ON cp.id=sm.period_id
	WHERE rs.id='$calendar_id'
	AND rs.subject_id='$subject_id'
	AND sm.calendar_id='$calendar_id'
	AND rs.student_id='$student_id'
	AND cp.id='$period'";
	$result = DB_query($sql,$db);
	$row = DB_fetch_row($result);
	$exam_marks= $row[0];
	$actual_marks= $row[1];
	}
	else{
	$sql = "select SUM(sm.marks) as cat_marks,SUM(sm.actual_marks) from studentsmarks sm
	INNER JOIN registered_students rs ON rs.id=sm.calendar_id
	INNER JOIN markingperiods mp ON mp.id=sm.exam_mode
	INNER JOIN collegeperiods cp ON cp.id=sm.period_id
	WHERE rs.id='$calendar_id'
	AND rs.subject_id='$subject_id'
	AND sm.calendar_id='$calendar_id'
	AND rs.student_id='$student_id'
	AND cp.id='$period'";
	$result = DB_query($sql,$db);
	$row = DB_fetch_row($result);
	$exam_marks= $row[0];
	$actual_marks= $row[1];
	}
	
	
		
	if(	$num_of_exam_mode>0){
	$real_marks=$exam_marks/$num_of_exam_mode;
	}
	
	
	if($real_marks > 0){
	$real_marks=number_format($real_marks,0);
	}
	else{
	$real_marks='';
	}
	
	
	return $real_marks;
	
	
		}
	


 }
 
 class exam_mode_totals {
	var $student;

	var $scheduled_subjects;			//courses included in $course that was scheduled within the given time


	function exam_mode_totals($student,$period,$exam_mode,$db) {

		$this->scheduled_subjects = $this->get_scheduled_subjects($student,$period,$exam_mode,$db);
	}

		function get_scheduled_subjects($student,$period,$exam_mode,$db) {
		
		$sql = "select gl.lower FROM debtorsmaster dm
		INNER JOIN classes cl ON cl.id=dm.class_id
		INNER JOIN gradelevels gl ON gl.id=cl.grade_level_id
		INNER JOIN registered_students rs On rs.student_id=dm.id
		WHERE dm.id='$student_id'
		AND rs.period_id='$period'
		GROUP BY rs.student";
		$result = DB_query($sql,$db);
		$row = DB_fetch_row($result);
		$lower=$row[0];	
		
		if($lower==1){
		$scheduled_subjects_array = array();
		$sql = "select rs.id, rs.subject_id from registered_students rs,studentsmarks sm,debtorsmaster dm,subjects sub
		WHERE rs.period_id='$period'
		AND dm.id=rs.student_id
		AND sm.calendar_id=rs.id
		AND sm.exam_mode='$exam_mode'
		AND sub.id=rs.subject_id
		AND sub.lower_display=1
		GROUP BY rs.student_id";
		//echo $query;
		$result = DB_query($sql,$db);
				if (DB_num_rows($result) > 0) {
					while ($row = DB_fetch_array($result)) {
						$scheduled_subjects_array[] = array('id' => $row['id'],
														'subject_id' => $row['subject_id']);
					}
					return $scheduled_subjects_array;
				}
				else
				{
					
					return $scheduled_subjects_array;
				}
		}
		else{
		$scheduled_subjects_array = array();
		$sql = "select rs.id, rs.subject_id from registered_students rs,studentsmarks sm,debtorsmaster dm,subjects sub
		WHERE rs.period_id='$period'
		AND dm.id=rs.student_id
		AND sm.calendar_id=rs.id
		AND sm.exam_mode='$exam_mode'
		AND sub.id=rs.subject_id
		AND sub.display=1
		GROUP BY rs.student_id";
		//echo $query;
		$result = DB_query($sql,$db);
		if (DB_num_rows($result) > 0) {
			while ($row = DB_fetch_array($result)) {
				$scheduled_subjects_array[] = array('id' => $row['id'],
												'subject_id' => $row['subject_id']);
			}
			return $scheduled_subjects_array;
		}
		else
		{
			
			return $scheduled_subjects_array;
		}
			}	
	}
	

 }

?>
