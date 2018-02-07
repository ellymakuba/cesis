<?php

$PageSecurity = 2;
if(isset($_POST['student_id']) && isset($_POST['PrintPDF'])){
include('includes/session.inc');
include('includes/PDFStarter.php');
require('grades/DegreeTranscriptClass.php');
require('grades/TranscriptAsterikClass.php');
	
$FontSize=13;
$pdf->addinfo('Title', _('Sales Receipt') );

$_SESSION['student'] = $_POST['student_id'];

$sql = "SELECT year FROM years
WHERE id =  '". $_POST['period_id'] ."'";
$result=DB_query($sql,$db);
$myrow=DB_fetch_row($result);
$year=$myrow[0];	
$PageNumber=1;
$line_height=12;
if ($PageNumber>1){
	$pdf->newPage();
}
$FontSize=10;
$YPos= $Page_Height-$Top_Margin;
$XPos=0;
$pdf->addJpegFromFile($_SESSION['LogoFile'] ,250,$YPos-50,0,50);
$LeftOvers = $pdf->addTextWrap(140,$YPos-($line_height*5),400,$FontSize,_('MASINDE MULIRO UNIVERSITY OF SCIENCE AND TECHNOLOGY'));
$FontSize=12;
$LeftOvers = $pdf->addTextWrap(260,$YPos-($line_height*6),300,$FontSize, _('(MMUST)'));

$FontSize=6;
$LeftOvers = $pdf->addTextWrap(80,$YPos-($line_height*6),300,$FontSize,$_SESSION['CompanyRecord']['telephone']);
$LeftOvers = $pdf->addTextWrap(80,$YPos-($line_height*6.5),300,$FontSize,$_SESSION['CompanyRecord']['fax']);
$LeftOvers = $pdf->addTextWrap(80,$YPos-($line_height*7),300,$FontSize,$_SESSION['CompanyRecord']['email']);
$LeftOvers = $pdf->addTextWrap(80,$YPos-($line_height*7.5),300,$FontSize, _('website').': ' . _('www.mmust.ac.ke'));
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-150,$YPos-($line_height*6),140,$FontSize, $_SESSION['CompanyRecord']['regoffice3']);
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-150,$YPos-($line_height*6.5),140,$FontSize, $_SESSION['CompanyRecord']['regoffice5']);
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-150,$YPos-($line_height*7),140,$FontSize, $_SESSION['CompanyRecord']['regoffice6']);

$sql = "SELECT dtr.name,dtr.debtorno,dp.department_name,cs.course_name,gl.grade_level FROM debtorsmaster dtr
INNER JOIN courses cs ON cs.id=dtr.course_id
INNER JOIN departments dp ON dp.id=cs.department_id
INNER JOIN gradelevels gl ON gl.id=dtr.grade_level_id 
WHERE dtr.id =  '". $_SESSION['student'] ."'";
$result=DB_query($sql,$db);
$myrow=DB_fetch_row($result);
		
$LeftOvers = $pdf->addTextWrap(40,$YPos-($line_height*11),300,$FontSize,_('NAME OF STUDENT').':'.$myrow[0]);
$LeftOvers = $pdf->addTextWrap(40,$YPos-($line_height*11.5),300,$FontSize,_('FACULTY').':'._('OF EDUCATION AND SOCIAL SCIENCES'));	
$LeftOvers = $pdf->addTextWrap(40,$YPos-($line_height*12),300,$FontSize,_('PROGRAMME').':'. $myrow[3]);
$LeftOvers = $pdf->addTextWrap(40,$YPos-($line_height*12.5),300,$FontSize,_('ACADEMIC YEAR').':'. $year );	
	
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-150,$YPos-($line_height*11),300,$FontSize, _('REGNO').': ' . $myrow[1]);
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-150,$YPos-($line_height*12.5),300,$FontSize, _('Year of Study').': ' . $myrow[4]);

$FontSize=10;	
$YPos -=100;
$LeftOvers = $pdf->addTextWrap(230,$YPos,300,$FontSize,$_SESSION['CompanyRecord']['coyname']);
$YPos -=(0.5*$line_height);
$pdf->line($Left_Margin, $YPos,$Page_Width-$Right_Margin, $YPos);
$YPos -=(1*$line_height);
$FontSize=6;	
$LeftOvers = $pdf->addTextWrap(220,$YPos,400,$FontSize,_('UNDERGRADUATE ACADEMIC TRANSCRIPT'));
$YPos -=(0.5*$line_height);
 $LeftOvers = $pdf->addTextWrap(219,$YPos,80,$FontSize,'______________________________________________________________________________');

$FontSize=8;
$YPos -=30;
$XPos=150;

$pdf->line($Left_Margin, $YPos,$Page_Width-$Right_Margin, $YPos);
$YPos -=(1*$line_height);
$YPos2=$YPos+$line_height;
$count=0;
$units=0;
$i=0;

$YPos -=24;
$line_height=10;
$bus_report = new bus_report($_POST['student_id'],$_POST['period_id'],$db);		

foreach ($bus_report->scheduled_subjects as $a => $b) {
$FontSize=8;
	$count=$count+1;
	
	$scheduled = new scheduled($b['subject_id'],$db);
	$scheduled->set_calendar_vars($_POST['student_id'],$_POST['period_id'],$b['id'],$db);
$FontSize=6;
	$LeftOvers = $pdf->addTextWrap(50,$YPos+13,300,$FontSize,$scheduled->subject_code);	
	$LeftOvers = $pdf->addTextWrap(155,$YPos+13,300,$FontSize,$scheduled->subject_name);
	$LeftOvers = $pdf->addTextWrap(330,$YPos+13,300,$FontSize,$scheduled->units);
	$pdf->line($Left_Margin, $YPos+$line_height,$Page_Width-$Right_Margin, $YPos+$line_height);
$units=$units+$scheduled->units;
	$XPos2=380;
	$YPos -=(1*$line_height);
foreach ($scheduled->subject as $sub => $s) {
if($s['asterik']==1){		
	$LeftOvers = $pdf->addTextWrap($XPos2+20,$YPos+23,300,$FontSize,_('*').$s['tmarks']);
}
else{
$LeftOvers = $pdf->addTextWrap($XPos2+20,$YPos+23,300,$FontSize,$s['tmarks']);	
}				
				
	$totalmarks_array2=$totalmarks_array2+$s['tmarks'];
	}//end of foreach subject
$totalmarks_array =$bus_report->total_marks($_POST['student_id'],$_POST['period_id'],$db);	
$sql = "SELECT title,grade FROM reportcardgrades
		WHERE range_from <=  '". $totalmarks_array."'
		AND range_to >='". $totalmarks_array ."'";
        $result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);
$LeftOvers = $pdf->addTextWrap($XPos2+90,$YPos+23,300,$FontSize,$myrow[1]);		
						
			}//end of foreach scheduled subjects
$LeftOvers = $pdf->addTextWrap(50,$YPos2-10,300,$FontSize,_('Course Code'));
$LeftOvers = $pdf->addTextWrap(155,$YPos2-10,300,$FontSize,_('Descriptive Title of Course'));	
$LeftOvers = $pdf->addTextWrap(330,$YPos2-10,300,$FontSize,_('UNITS'));					
$LeftOvers = $pdf->addTextWrap($XPos2+10,$YPos2-10,300,$FontSize,_('MARKS'));
$pdf->line($XPos2-10,$YPos2,$XPos2-10, $YPos+($line_height*1));
$LeftOvers = $pdf->addTextWrap($XPos2+80,$YPos2-10,300,$FontSize,_('GRADES'));
$pdf->line($XPos2+70,$YPos2,$XPos2+70, $YPos+($line_height*1));
$pdf->line($Left_Margin, $YPos2-14,$Page_Width-$Right_Margin, $YPos2-14);
$pdf->line(150,$YPos2,150, $YPos+($line_height*1));
$pdf->line(325,$YPos2,325, $YPos+($line_height*1));
$pdf->line(40,$YPos2,40, $YPos+($line_height*1));
$pdf->line(566,$YPos2,566, $YPos+($line_height*1));

$pdf->line($Left_Margin, $YPos+$line_height,$Page_Width-$Right_Margin, $YPos+$line_height);
$LeftOvers = $pdf->addTextWrap(40,$YPos,300,$FontSize,_('TOTAL NUMBER OF CURSES TAKEN').' :'._('[').$count._(']'));
$LeftOvers = $pdf->addTextWrap(40,$YPos-10,300,$FontSize,_('TOTAL NUMBER OF UNITS').' :'._('[').$units._(']'));
$out_of=100*$count;


$mean_grade=$totalmarks_array2/$count;
$sql = "SELECT title,comment FROM reportcardgrades
		WHERE range_from <=  '". $mean_grade ."'
		AND range_to >='". $mean_grade."'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);
$LeftOvers = $pdf->addTextWrap(40,$YPos-20,300,$FontSize,_('RESULTS').' :'.$myrow[1]);	
$LeftOvers = $pdf->addTextWrap(40,$YPos-40,300,$FontSize,_('KEY TO GRADING SYSTEM'));
$LeftOvers = $pdf->addTextWrap(40,$YPos-50,300,$FontSize,_('70%  and above'));
$LeftOvers = $pdf->addTextWrap(40,$YPos-60,300,$FontSize,_('60%-69%   '));
$LeftOvers = $pdf->addTextWrap(40,$YPos-70,300,$FontSize,_('50%-59%  '));
$LeftOvers = $pdf->addTextWrap(40,$YPos-80,300,$FontSize,_('40%-49%  '));
$LeftOvers = $pdf->addTextWrap(40,$YPos-90,300,$FontSize,_('39% and below'));

$LeftOvers = $pdf->addTextWrap(100,$YPos-50,300,$FontSize,_('A (excellent)'));
$LeftOvers = $pdf->addTextWrap(100,$YPos-60,300,$FontSize,_('B (Good)'));
$LeftOvers = $pdf->addTextWrap(100,$YPos-70,300,$FontSize,_('C (Average)'));
$LeftOvers = $pdf->addTextWrap(100,$YPos-80,300,$FontSize,_('D (Pass)'));
$LeftOvers = $pdf->addTextWrap(100,$YPos-90,300,$FontSize,_('E (Fail)'));


$LeftOvers = $pdf->addTextWrap(200,$YPos-40,300,$FontSize,_('EXPLANATION OF COURSE CODES'));	
$LeftOvers = $pdf->addTextWrap(200,$YPos-50,300,$FontSize,_('100-600     Undergraduate Courses'));
$LeftOvers = $pdf->addTextWrap(200,$YPos-60,300,$FontSize,_('OTHER KEYS'));
$LeftOvers = $pdf->addTextWrap(200,$YPos-70,300,$FontSize,_('* Pass after supplementary'));
$LeftOvers = $pdf->addTextWrap(200,$YPos-80,300,$FontSize,_('** Course repeated in its entirety'));
$LeftOvers = $pdf->addTextWrap(200,$YPos-90,300,$FontSize,_('E -Elective course'));

$LeftOvers = $pdf->addTextWrap(40,$YPos-120,300,$FontSize,_('NOTE: A semester is a period of 16 weeks '));
$LeftOvers = $pdf->addTextWrap(40,$YPos-130,500,$FontSize,_('A unit is one hour lecture per week per semester or two hours tutorials/seminar per week per semester or 3 hours of practical per week per semester'));

$FontSize=13;
$LeftOvers = $pdf->addTextWrap(40,$YPos-150,300,$FontSize,_('SIGNED'.':'));
$LeftOvers = $pdf->addTextWrap(90,$YPos-150,60,$FontSize,'______________________________________________________________________________');
$LeftOvers = $pdf->addTextWrap(220,$YPos-150,300,$FontSize,_('Date'));
$LeftOvers = $pdf->addTextWrap(250,$YPos-150,60,$FontSize,'______________________________________________________________________________');

$FontSize=8;
$LeftOvers = $pdf->addTextWrap(90,$YPos-160,300,$FontSize,_(' REGISTRAR (ACADEMIC AFFAIRS)'));

$pdf->Output('Receipt-'.$_GET['ReceiptNumber'], 'I');
	
}
if(isset($_POST['student_id']) && isset($_POST['html'])){
include('includes/session.inc');
require('grades/ReportCardClass.php');
?>
<html><body><br /><br /><br />
<?php
$_SESSION['student'] = $_POST['student_id'];
$_SESSION['period'] = $_POST['period_id'];
$sql = "SELECT dtr.name,dtr.debtorno,dp.department_name,cs.course_name as course,gl.grade_level FROM debtorsmaster dtr
INNER JOIN courses cs ON cs.id=dtr.course_id
INNER JOIN departments dp ON dp.id=cs.department_id
INNER JOIN gradelevels gl ON gl.id=dtr.grade_level_id 
		WHERE debtorno =  '". $_SESSION['student'] ."'";
        $result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);
		$course=$myrow['course'];
		
$sql="SELECT cp.id,terms.title,years.year,cp.end_date FROM collegeperiods cp
		INNER JOIN terms ON terms.id=cp.term_id
		INNER JOIN years ON years.id=cp.year 
		WHERE cp.id='".$_SESSION['period']."'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_array($result);
		$title=$myrow['title'];
$count=0;
$i=0;
$totalmarks_array2=0;
$bus_report = new bus_report($_POST['student_id'],$_POST['period_id'],$db);
$status_array = tep_get_status($db);
echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . "?" . SID . ">";
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
echo "<table border='1' width='50%' align='center'='20'>";
echo "<tr><td colspan='8'><font size='16'>"._('AFRICAN INSTITUTE')."</td></tr>";
echo "<tr><td colspan='8' align='center'><font size='4'>"._('of Research & Development Studies')."</td></tr>";
echo "<tr><td colspan='8' align='center'><font size='2'>"._('RegNO')._(': '). $_SESSION['student'] .
_('  ')._('Term')._(': ').$title._(' ')._('Course')._(': ').$course."</td></tr>";
echo "<tr><td>"._('Subject')."</td>";
foreach ($status_array as $r => $s) {
echo "<td>".$s['title']."</td>";
		}
echo "<td>"._('Total(%)')."</td>";
echo "<td>"._('Grade')."</td>";
echo "<td>"._('Comment')."</td>";
echo "</tr>"; 
foreach ($bus_report->scheduled_subjects as $a => $b) {

	$count=$count+1;
	$scheduled = new scheduled($b['subject_id'],$db);
	$scheduled->set_calendar_vars($b['id'],$db);
echo "<tr><td>".$scheduled->subject_name."</td>";
	$status_array = tep_get_status($db);
foreach ($scheduled->status as $y=>$z) {
	$i++;
echo "<td>".$z['marks']."</td>";
	
				}
	$totalmarks_array =$bus_report->total_marks($_POST['student_id'],$b['id'],$b['subject_id'],$db);
	$sql = "SELECT title,comment FROM reportcardgrades
	WHERE range_from <=  '". $totalmarks_array ."'
	AND range_to >='". $totalmarks_array ."'";
    $result=DB_query($sql,$db);
	$myrow=DB_fetch_row($result);
echo "<td>".$totalmarks_array."</td>";
echo "<td>".$myrow[0]."</td>";
echo "<td>".$myrow[1]."</td>";				
	$totalmarks_array2=$totalmarks_array2+$totalmarks_array;					
			}
echo "</tr><tr><td>"._('Total Subjects')._(' ').$count."</td>";
echo "<td>"._('Total Marks')._(' ').$totalmarks_array2."</td>";
$out_of=100*$count;
echo "<td>"._('Out of')._(' ').$out_of."</td></tr>";

$mean_grade=$totalmarks_array2/$count;
$sql = "SELECT title,comment FROM reportcardgrades
		WHERE range_from <=  '". $mean_grade ."'
		AND range_to >='". $mean_grade."'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);
echo "<tr>";		
echo "<td>"._('Mean Grade')._(' ').$myrow[1]."</td></tr>";
echo "<tr>";
echo "<td colspan='6'>"._('KEY TO GRADING SYSTEM')."</td></tr>";
echo "<tr><td colspan='2'>"._('100-90  1 Distinction')."</td><td colspan='2'>"._('69-60   4 Credit')."</td><td colspan='2'>"._('39-30  7 Reffered')."</td></tr>";
echo "<tr><td colspan='2'>"._('89-80   2 Distiction')."</td><td colspan='2'>"._('59-50  5 Pass')."</td><td colspan='2'>"._('29-0   8 Fail')."</td></tr>";
echo "<tr><td colspan='2'>"._('79-70   3 Credit')."</td><td colspan='2'>"._('49-40  6 Pass')."</td></tr>";






echo "</table>";	
}

else { /*The option to print PDF was not hit */

	include('includes/session.inc');
	$title = _('Manage Students');

include('includes/header.inc');

echo '<FORM METHOD="POST" ACTION="' . $_SERVER['PHP_SELF'] . '?' . SID . '">';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
echo '<CENTER><TABLE class="selection"><TR><TD class="visible">' . _('student:') . '</TD><TD class="visible"><SELECT Name="student_id">';
		DB_data_seek($result, 0);
		$sql = 'SELECT id,debtorno,name FROM debtorsmaster';
		$result = DB_query($sql, $db);
		while ($myrow = DB_fetch_array($result)) {
			if ($myrow['id'] == $_POST['student_id']) {  
				echo '<OPTION SELECTED VALUE=';
			} else {
				echo '<OPTION VALUE=';
			}
			echo $myrow['id'] . '>' . $myrow['name'];
		} //end while loop
	echo '</SELECT></TD></TR>';
		echo '<CENTER><TR><TD class="visible">' . _('Period:') . '</TD><TD class="visible"><SELECT Name="period_id">';
		$result = DB_query('SELECT id,year FROM years',$db);
while ($myrow = DB_fetch_array($result)) {
	if ($myrow['id']==$_POST['period_id']) {
		echo '<option selected VALUE=';
	} else {
		echo '<option VALUE=';
	}
	echo $myrow['id'] . '>' . $myrow['year'];
} //end while loop
	echo '</SELECT></TD></TR>';
	echo "</TABLE>";
	
	$sql = "SELECT fullaccess FROM www_users
		WHERE userid=  '" . trim($_SESSION['UserID']) . "'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);
	if($myrow[0]==8 || $myrow[0]==11){	
	echo "<P><INPUT TYPE='Submit' NAME='PrintPDF' VALUE='" . _('PrintPDF') . "'>";
	}

	include('includes/footer.inc');
} /*end of else not PrintPDF */

?>