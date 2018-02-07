<?php

function tep_get_status($db) {
	$sql = "select * from markingperiods 
	WHERE title NOT LIKE 'Transcript'
	order by id";
	$result = DB_query($sql,$db);
	while ($row = DB_fetch_array($result)) {
		$status_array[] = array("id" => $row['id'],
				     "title" => $row['title']);
	}
	return $status_array;
}
function tep_get_status_amount($marking_period_id, $calendar_id,$db) {
	$sql = "select marks from studentsmarks where 
	exam_mode='$marking_period_id' and calendar_id='$calendar_id'";
	$result = DB_query($sql,$db);
	$row = DB_fetch_array($result);
	return $row['marks'];
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

function subject($id,$db) {
	$sql = "select * from subjects where id = '$id' limit 1";
	$result = DB_query($sql,$db);
	$row = DB_fetch_array($result);
	$this->id = $id;
	$this->subject_name = $row['subject_name'];
	$this->subject_code = $row['subject_code'];
	$this->course_id = $row['course_id'];
	$this->lecturer_id = $row['lecturer_id'];
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

	

	function set_calendar_vars($calendar_id,$db) {
		$sql = "select * from registered_students where id='$calendar_id' LIMIT 1";
		$result = DB_query($sql,$db);
		$row = DB_fetch_array($result);
		$this->calendar_id = $calendar_id;
		$this->asterik = $row['asterik'];
		// set status var
		$status_array = tep_get_status($db);
		foreach ($status_array as $r=>$s) {
			$this->status[] = array("id" => $s['id'],
									"asterik" => $this->asterik,
								   "marks" => tep_get_status_amount($s['id'], $this->calendar_id,$db));
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
		

		$scheduled_subjects_array = array();
		$sql = "select id, subject_id from registered_students WHERE period_id='$period'
		AND student_id='$student'";
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
			//there was not any courses in this time and we return an empty array
			return $scheduled_subjects_array;
		}
	}
	
function total_marks($subject_id,$student_id,$period,$calendar_id,$db) {
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
	
	$sql = "select SUM(sm.marks) as cat_marks from studentsmarks sm
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
	$cat_marks= $row[0];
	
	if($num_of_cats > 0){
	$average_marks=$cat_marks/$num_of_cats;
	}
	else{
	$average_marks='';
	}
	
	$sql = "select SUM(sm.marks) as cat_marks from studentsmarks sm
	INNER JOIN registered_students rs ON rs.id=sm.calendar_id
	INNER JOIN markingperiods mp ON mp.id=sm.exam_mode
	INNER JOIN collegeperiods cp ON cp.id=sm.period_id
	WHERE rs.id='$calendar_id'
	AND mp.exam_type_id !=1
	AND rs.subject_id='$subject_id'
	AND sm.calendar_id='$calendar_id'
	AND rs.student_id='$student_id'
	AND cp.id='$period'";
	$result = DB_query($sql,$db);
	$row = DB_fetch_row($result);
	$exam_marks= $row[0];
		
	$real_marks=$exam_marks+$average_marks;
	
	if($real_marks > 0){
	$real_marks=number_format($real_marks,0);
	}
	else{
	$real_marks='';
	}
	
	return $real_marks;
		}
	


 }

?>
