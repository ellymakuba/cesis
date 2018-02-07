<?php
function total_marks_subject($student_id,$period_id,$subject_id,$db) {
		$sql = "select COUNT(sm.id) from studentsmarks sm
		INNER JOIN registered_students rs ON rs.id=sm.calendar_id
		INNER JOIN markingperiods mp ON mp.id=sm.exam_mode
		WHERE rs.student_id='$student_id'
		AND mp.exam_type_id=1
		AND rs.period_id='$period_id'
		AND rs.subject_id='$subject_id'";
		//echo $query; 
		$result = DB_query($sql,$db);
		$myrow = DB_fetch_row($result);
		$no_of_cats =$myrow[0];
		
		
		
		$sql = "select SUM(sm.marks) as smarks from studentsmarks sm
		INNER JOIN registered_students rs ON rs.id=sm.calendar_id
		INNER JOIN markingperiods mp ON mp.id=sm.exam_mode
		WHERE rs.student_id='$student_id'
		AND mp.exam_type_id=1
		AND rs.period_id='$period_id'
		AND rs.subject_id='$subject_id'";
		//echo $query; 
		$result = DB_query($sql,$db);
		$row = DB_fetch_array($result);
		$cat_marks=$row['smarks'];
		if($no_of_cats>0){
		$cat_average_marks=$cat_marks/$no_of_cats;
		}
		else{
		$cat_average_marks=$cat_marks/1;
		}
		
		$sql = "select SUM(sm.marks) as smarks from studentsmarks sm
		INNER JOIN registered_students rs ON rs.id=sm.calendar_id
		INNER JOIN markingperiods mp ON mp.id=sm.exam_mode
		WHERE rs.student_id='$student_id'
		AND mp.exam_type_id !=1
		AND rs.period_id='$period_id'
		AND rs.subject_id='$subject_id'";
		//echo $query; 
		$result = DB_query($sql,$db);
		$row = DB_fetch_array($result);
		$end_term_marks=$row['smarks'];
		
		$real_marks=$end_term_marks+$cat_average_marks;
		
		return number_format($real_marks,0);
		}
function tep_get_students2_subject($class,$db) {
	$sql = "select SUM(sm.marks) as totalmarks from debtorsmaster dm 
	INNER JOIN studentsmarks sm ON sm.student_id=dm.id
	WHERE class_id='$class'
	GROUP BY sm.student_id
	order by dm.id ";
	$result = DB_query($sql,$db);
	while ($row = DB_fetch_array($result)) {
		$students_array[] = array("id" => $row['id'],
				     "name" => $row['name']);
	}
	return $students_array;
}
function tep_set_students2_subject($debtorno,$period,$db) {
	$sql = "select id,student_id from registered_students 
	WHERE student_id='$debtorno'
	AND period_id='$period'";
	$result = DB_query($sql,$db);
	while ($row = DB_fetch_array($result)) {
		$ids[] = array("id" => $row['id'],
				     "student_id" => $row['student_id']);
	}
	
	return $ids;
}
function get_subjects_subject($class,$period,$db) {
	$sql = "select DISTINCT(rs.subject_id),sub.id from registered_students rs
	INNER JOIN subjects sub ON sub.id=rs.subject_id
	WHERE rs.class_id='$class'
	AND rs.period_id='$period'";
	$result = DB_query($sql,$db);
	while ($row = DB_fetch_array($result)) {
		$subjects_array[] = array("id" => $row['id'],
				     "subject_id" => $row['subject_id']);
	}
	
	return $subjects_array;
}
function get_streams_subject($db) {
	$sql = "SELECT id,class_name FROM classes";
	$result = DB_query($sql,$db);
	while ($row = DB_fetch_array($result)) {
		$streams_array[] = array("id" => $row['id'],
				     "class_name" => $row['class_name']);
	}
	
	return $streams_array;
}
function tep_get_exam_mode2_subject($db) {
	$sql = "select * from markingperiods order by id";
	$result = DB_query($sql,$db);
	while ($row = DB_fetch_array($result)) {
		$status_array[] = array("id" => $row['id'],
				     "title" => $row['title']);
	}
	return $status_array;
}
function tep_get_exam_mode_marks2_subject($marking_period_id, $calendar_id,$db) {
	$sql = "select marks from studentsmarks where 
	exam_mode='$marking_period_id' and calendar_id='$calendar_id'";
	$result = DB_query($sql,$db);
	$row = DB_fetch_array($result);
	return $row['marks'];
}

class student2_subject {

var $debtorno;
var $name;
var $class_id;
var $course_id;
var $grade_level_id;

function student2_subject($debtorno,$db) {
	$sql = "select * from debtorsmaster where id = '$debtorno' limit 1";
	$result = DB_query($sql,$db);
	$row = DB_fetch_array($result);
	$this->debtorno = $debtorno;
	$this->name = $row['name'];
	$this->class_id = $row['class_id'];
	$this->course_id = $row['course_id'];
}


function set_calendar_vars2_subject($calendar_id,$db) {
	$sql = "select * from registered_students where id='$calendar_id' LIMIT 1";
	$result = DB_query($sql,$db);
	$row = DB_fetch_array($result);
	$this->calendar_id = $calendar_id;
}


}

 class scheduled2_subject extends student2_subject {
	var $calendar_id;
	var $start_date;
	var $exam_mode;			//array containing the number of users in different status.
	var $total_users;
	var $cancelled;

	function scheduled2_subject($debtorno,$db) {
		$this->student2_subject($debtorno,$db);
	}

	

	function set_calendar_vars2_subject($calendar_id,$db) {
		$sql = "select * from registered_students where id='$calendar_id' LIMIT 1";
		$result = DB_query($sql,$db);
		$row = DB_fetch_array($result);
		$this->calendar_id = $calendar_id;
		// set status var
		$subjects_array = tep_get_exam_mode2_subject($db);
		foreach ($subjects_array as $r=>$s) {
			$this->exam_mode[] = array("id" => $s['id'],
								   "tmarks" => tep_get_exam_mode_marks2_subject($s['id'], $this->calendar_id,$db));
		}
	}

}
class bus_report2_subject {
	var $student;			//array of courses that are eligible for report
	var $start_date;
	var $end_date;

	var $scheduled_students;			//courses included in $course that was scheduled within the given time


	function bus_report2_subject($class,$period,$subject,$db) {
		$this->student = $this->get_student2_subject($db);

		$this->scheduled_students = $this->get_scheduled_students2_subject($class,$period,$subject,$db);
	}

	function get_student2_subject($db) {
		$student_array = array();
		// build where clause to exclude courses by previous choices.
		
		$sql = "select debtorno from debtorsmaster ";
		//echo $query;
		$result = DB_query($sql,$db);
		while ($row = DB_fetch_array($result)) {
			$student_array[] = $row['debtorno'];
		}
		return $student_array;
	}


	function get_scheduled_students2_subject($class,$period,$subject,$db) {
		

		$scheduled_students_array = array();
		$sql = "select rs.id, rs.student_id from registered_students rs
		INNER JOIN debtorsmaster dm ON dm.id=rs.student_id
		INNER JOIN classes cls ON cls.id=dm.class_id 
		WHERE period_id='$period'
		AND rs.subject_id='$subject'
		AND cls.id='$class'
		ORDER BY rs.student_id";
		//echo $query;
		$result = DB_query($sql,$db);
		if (DB_num_rows($result) > 0) {
			while ($row = DB_fetch_array($result)) {
				$scheduled_students_array[] = array('id' => $row['id'],
												'student_id' => $row['student_id']);
			}
			return $scheduled_students_array;
		}
		else
		{
			
			return $scheduled_students_array;
		}
	}
	
function subject_meangrade2_subject($subject_id,$period_id,$class,$db) {
		$sql = "select SUM(sm.marks) as submarks from studentsmarks sm
		INNER JOIN registered_students rs ON rs.id=sm.calendar_id
		INNER JOIN markingperiods mp ON mp.id=sm.exam_mode
		WHERE rs.subject_id='$subject_id'
		AND mp.title NOT LIKE 'Transcript'
		AND rs.academic_year_id='$period_id'
		AND rs.class_id='$class'";
		//echo $query; 
		$result = DB_query($sql,$db);
		$row = DB_fetch_array($result);
		return $row['submarks'];
		}
	
function total_marks_subject($student_id,$period_id,$subject_id,$db) {
		$sql = "select COUNT(sm.id) from studentsmarks sm
		INNER JOIN registered_students rs ON rs.id=sm.calendar_id
		INNER JOIN markingperiods mp ON mp.id=sm.exam_mode
		WHERE rs.student_id='$student_id'
		AND mp.exam_type_id=1
		AND rs.period_id='$period_id'
		AND rs.subject_id='$subject_id'";
		//echo $query; 
		$result = DB_query($sql,$db);
		$myrow = DB_fetch_row($result);
		$no_of_cats =$myrow[0];
		
		
		
		$sql = "select SUM(sm.marks) as smarks from studentsmarks sm
		INNER JOIN registered_students rs ON rs.id=sm.calendar_id
		INNER JOIN markingperiods mp ON mp.id=sm.exam_mode
		WHERE rs.student_id='$student_id'
		AND mp.exam_type_id=1
		AND rs.period_id='$period_id'
		AND rs.subject_id='$subject_id'";
		//echo $query; 
		$result = DB_query($sql,$db);
		$row = DB_fetch_array($result);
		$cat_marks=$row['smarks'];
		if($no_of_cats>0){
		$cat_average_marks=$cat_marks/$no_of_cats;
		}
		
		$sql = "select SUM(sm.marks) as smarks from studentsmarks sm
		INNER JOIN registered_students rs ON rs.id=sm.calendar_id
		INNER JOIN markingperiods mp ON mp.id=sm.exam_mode
		WHERE rs.student_id='$student_id'
		AND mp.exam_type_id !=1
		AND rs.period_id='$period_id'
		AND rs.subject_id='$subject_id'";
		//echo $query; 
		$result = DB_query($sql,$db);
		$row = DB_fetch_array($result);
		$end_term_marks=$row['smarks'];
		
		$real_marks=$end_term_marks+$cat_average_marks;
		
		return number_format($real_marks,0);
		}

 }

?>
