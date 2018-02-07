<?php

$PageSecurity = 2;
if(isset($_POST['student_id']) && isset($_POST['PrintPDF'])){
include('includes/session.inc');
include('includes/PDFStarter.php');
require('grades/TranscriptClass.php');

$sql = "SELECT SUM(totalinvoice) as total FROM invoice_items,salesorderdetails 
		WHERE salesorderdetails.id=invoice_items.invoice_id
		AND student_id='".$_POST['student_id']."'";
		$DbgMsg = _('The SQL that was used to retrieve the information was');
        $ErrMsg = _('Could not check whether the group is recursive because');
        $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
        $row = DB_fetch_array($result);
		$studenttotal = $row['total'];
$sql = "SELECT SUM(ovamount) as totalpayment FROM debtortrans WHERE debtorno='".$_POST['student_id']."'";
        $ErrMsg = _('Could not check whether the group is recursive because');
        $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
        $row = DB_fetch_array($result);
		$studenttotalpayment = -$row['totalpayment'];
		$totalbalance=$studenttotal-$studenttotalpayment;
if($totalbalance<0)	{
prnMsg(_('Cannot print a reportcard of students with a balance, Please let him clear'),'warn');
}
else{	
$FontSize=13;
$pdf->addinfo('Title', _('Sales Receipt') );

$_SESSION['student'] = $_POST['student_id'];	
$PageNumber=1;
$line_height=12;
if ($PageNumber>1){
	$pdf->newPage();
}
$FontSize=13;
$YPos= $Page_Height-$Top_Margin;
$XPos=0;
$pdf->addJpegFromFile($_SESSION['LogoFile'] ,$XPos+200,$YPos-120,0,80);


$FontSize=24;
$LeftOvers = $pdf->addTextWrap(150,$YPos-($line_height),300,$FontSize, _('AFRICAN INSTITUTE '));
$FontSize=10;
$LeftOvers = $pdf->addTextWrap(200,$YPos-($line_height*2.5),300,$FontSize, _('Of Research and Development Studies '));

$FontSize=8;
$LeftOvers = $pdf->addTextWrap(40,$YPos-($line_height*5),300,$FontSize,_('Institute Plaza'));
$LeftOvers = $pdf->addTextWrap(40,$YPos-($line_height*6),300,$FontSize,_('Next to kenya Power'));
$LeftOvers = $pdf->addTextWrap(40,$YPos-($line_height*7),300,$FontSize,_('emergency office'));
$LeftOvers = $pdf->addTextWrap(40,$YPos-($line_height*8),300,$FontSize,$_SESSION['CompanyRecord']['regoffice3']);
$LeftOvers = $pdf->addTextWrap(40,$YPos-($line_height*9),300,$FontSize,$_SESSION['CompanyRecord']['regoffice4']);
$LeftOvers = $pdf->addTextWrap(40,$YPos-($line_height*10),300,$FontSize,$_SESSION['CompanyRecord']['regoffice6']);
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-150,$YPos-($line_height*5),140,$FontSize, _('Tel').': ' . $_SESSION['CompanyRecord']['regoffice2']);

$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-150,$YPos-($line_height*6),300,$FontSize, _('website').': ' . $_SESSION['CompanyRecord']['regoffice1']);



$sql = "SELECT dtr.name,dtr.debtorno,dp.department_name,cs.course_name,gl.grade_level,cl.course_id as courseid,cl.grade_level_id,mn.month_name,cl.year_id,cl.stage FROM debtorsmaster dtr
INNER JOIN courses cs ON cs.id=dtr.course_id
INNER JOIN classes cl ON cl.id=dtr.class_id
INNER JOIN departments dp ON dp.id=cs.department_id
INNER JOIN gradelevels gl ON gl.id=dtr.grade_level_id 
INNER JOIN months mn ON mn.id=cl.month_id
WHERE debtorno =  '". $_SESSION['student'] ."'";
$result=DB_query($sql,$db);
$myrow=DB_fetch_array($result);
		

/*$LeftOvers = $pdf->addTextWrap(100,$YPos-($line_height*11),500,$FontSize, _('Reportcard For').': ' . $myrow[0].'    '._('Period').': ' .$myrow2[1].'-'.$myrow2[2]);*/	
$LeftOvers = $pdf->addTextWrap(200,$YPos-($line_height*12),400,$FontSize,_('STUDENT ACADEMIC TRANSCRIPT'));
 $LeftOvers = $pdf->addTextWrap(200,$YPos-($line_height*12.3),70,$FontSize,'______________________________________________________________________________');
$LeftOvers = $pdf->addTextWrap(40,$YPos-($line_height*14),300,$FontSize,_('Name').':'.$myrow['name']);
$LeftOvers = $pdf->addTextWrap(40,$YPos-($line_height*15),300,$FontSize,_('Department').':'.$myrow['department_name']);	
$LeftOvers = $pdf->addTextWrap(40,$YPos-($line_height*16),300,$FontSize,_('Class').':'.$myrow['month_name']._('-').$myrow['grade_level']._('-').$myrow['course_name']);
$LeftOvers = $pdf->addTextWrap(40,$YPos-($line_height*17),300,$FontSize,_('Stage').':'.$myrow['stage']);

	
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-150,$YPos-($line_height*14),300,$FontSize, _('Admn No').': ' . $myrow['debtorno']);
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-150,$YPos-($line_height*15),300,$FontSize, _('Course').': ' . $myrow['course_name']);
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-150,$YPos-($line_height*16),300,$FontSize, _('Year of Study').': ' . $myrow['grade_level']);
$LeftOvers = $pdf->addTextWrap($Page_Width-$Right_Margin-150,$YPos-($line_height*17),300,$FontSize,_('Date Of Issue').':'. Date($_SESSION['DefaultDateFormat']) );	
	
$YPos +=20;
$YPos -=$line_height;
//Note, this is ok for multilang as this is the value of a Select, text in option is different

$YPos -=(12*$line_height);

/*Draw a rectangle to put the headings in     */
$BoxHeight =20;
$pdf->line($Left_Margin, $YPos+$line_height,$Page_Width-$Right_Margin, $YPos+$line_height);

$YPos -=83;
$YPos -=$line_height;
$pdf->line($Left_Margin, $YPos+$line_height,$Page_Width-$Right_Margin, $YPos+$line_height);

$line_width=70;
$XPos=150;
$YPos2=$YPos;
$count=0;
$i=0;

$status_array = tep_get_status($db);
foreach ($status_array as $r => $s) {
	//$LeftOvers = $pdf->addTextWrap($XPos+45,$YPos,300,$FontSize,$s['title']);
	//$XPos +=(1*$line_width);
		}
if(isset($_REQUEST['mp_arr']))
	{
	$mp_array=implode(', ', $_REQUEST['mp_arr']);

$mp_list = '\''.implode('\',\'',$_REQUEST['mp_arr']).'\'';
$bus_report = new bus_report($_POST['student_id'],$mp_array,$db);		
		$YPos =550;
foreach ($bus_report->scheduled_subjects as $a => $b) {

	$count=$count+1;
	$scheduled = new scheduled($b['subject_id'],$db);
	$scheduled->set_calendar_vars($b['id'],$db);
	$LeftOvers = $pdf->addTextWrap(50,$YPos,300,$FontSize,$scheduled->subject_name);
	$pdf->line($Left_Margin, $YPos+$line_height,$Page_Width-$Right_Margin, $YPos+$line_height);
	$status_array = tep_get_status($db);
	$XPos2=180;
	$YPos -=(2*$line_height);

foreach ($scheduled->status as $y=>$z) {
$i++;
	
	//$XPos2 +=(1*$line_width);
	
				}
	$totalmarks_array =$bus_report->total_marks($_POST['student_id'],$b['id'],$b['subject_id'],$db);
$sql = "SELECT title,comment FROM reportcardgrades
		WHERE range_from <=  '". $totalmarks_array ."'
		AND range_to >='". $totalmarks_array ."'";
        $result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);
	$LeftOvers = $pdf->addTextWrap($XPos2+20,$YPos+25,300,$FontSize,$totalmarks_array);					
	$LeftOvers = $pdf->addTextWrap($XPos2+90,$YPos+25,300,$FontSize,$myrow[0]);
	$LeftOvers = $pdf->addTextWrap($XPos2+150,$YPos+25,300,$FontSize,$myrow[1]);			
	$totalmarks_array2=$totalmarks_array2+$totalmarks_array;					
			}
					
$LeftOvers = $pdf->addTextWrap($XPos2+10,$YPos2,300,$FontSize,_('Exam(%)'));
$pdf->line($XPos2-10,593,$XPos2-10, $YPos+($line_height*1));
$LeftOvers = $pdf->addTextWrap($XPos2+80,$YPos2,300,$FontSize,_('Points'));
$pdf->line($XPos2+70,593,$XPos2+70, $YPos+($line_height*1));
$LeftOvers = $pdf->addTextWrap($XPos2+150,$YPos2,300,$FontSize,_('Grade'));
$pdf->line($XPos2+130,593,$XPos2+130, $YPos+($line_height*1));
$pdf->line(40, 593,40, $YPos+($line_height*1));
$pdf->line(566, 593,566, $YPos+($line_height*1));

$pdf->line($Left_Margin, $YPos+$line_height,$Page_Width-$Right_Margin, $YPos+$line_height);
$LeftOvers = $pdf->addTextWrap(40,$YPos-10,300,$FontSize,_('Total Subjects').' :'.$count);
$LeftOvers = $pdf->addTextWrap(250,$YPos-10,300,$FontSize,_('Total Marks').' :'.$totalmarks_array2);
$out_of=100*$count;
$LeftOvers = $pdf->addTextWrap(410,$YPos-10,300,$FontSize,_('Out of').' :'.$out_of);

$mean_grade=$totalmarks_array2/$count;
$sql = "SELECT title,comment FROM reportcardgrades
		WHERE range_from <=  '". $mean_grade ."'
		AND range_to >='". $mean_grade."'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);
$LeftOvers = $pdf->addTextWrap(40,$YPos-20,300,$FontSize,_('Mean Grade').' :'.$myrow[1]);	
$LeftOvers = $pdf->addTextWrap(40,$YPos-40,300,$FontSize,_('KEY TO GRADING SYSTEM'));
$LeftOvers = $pdf->addTextWrap(40,$YPos-50,300,$FontSize,_('100-90  1 Distinction'));
$LeftOvers = $pdf->addTextWrap(40,$YPos-60,300,$FontSize,_('89-80   2 Distiction'));
$LeftOvers = $pdf->addTextWrap(40,$YPos-70,300,$FontSize,_('79-70   3 Credit'));
$LeftOvers = $pdf->addTextWrap(40,$YPos-80,300,$FontSize,_('69-60   4 Credit'));

$LeftOvers = $pdf->addTextWrap(200,$YPos-50,300,$FontSize,_('59-50  5 Pass'));
$LeftOvers = $pdf->addTextWrap(200,$YPos-60,300,$FontSize,_('49-40  6 Pass'));
$LeftOvers = $pdf->addTextWrap(200,$YPos-70,300,$FontSize,_('39-30  7 Reffered'));
$LeftOvers = $pdf->addTextWrap(200,$YPos-80,300,$FontSize,_('29-0   8 Fail'));
$LeftOvers = $pdf->addTextWrap(40,$YPos-100,300,$FontSize,_('* Pass after supplementary'));

$LeftOvers = $pdf->addTextWrap(200,$YPos-100,300,$FontSize,_('Registrar'.':'));
$LeftOvers = $pdf->addTextWrap(230,$YPos-100,80,$FontSize,'______________________________________________________________________________');
$LeftOvers = $pdf->addTextWrap(40,$YPos-120,300,$FontSize,_('Principal'));
$LeftOvers = $pdf->addTextWrap(70,$YPos-120,80,$FontSize,'______________________________________________________________________________');
$LeftOvers = $pdf->addTextWrap(40,$YPos-140,300,$FontSize,_('Chief Examination Officer'));
$LeftOvers = $pdf->addTextWrap(125,$YPos-140,80,$FontSize,'______________________________________________________________________________');
$LeftOvers = $pdf->addTextWrap(40,$YPos-160,300,$FontSize,_('This transcript is not valid without the principals rubber stamp'));
}
$pdf->Output('Receipt-'.$_GET['ReceiptNumber'], 'I');

}	
}
if(isset($_POST['period_id']) && isset($_POST['student_id']) && isset($_POST['html'])){
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
echo '<CENTER><TABLE><TR><TD>' . _('student:') . '</TD><TD><SELECT Name="student_id">';
		DB_data_seek($result, 0);
		$sql = 'SELECT debtorno,name FROM debtorsmaster';
		$result = DB_query($sql, $db);
		while ($myrow = DB_fetch_array($result)) {
			if ($myrow['debtorno'] == $_POST['student_id']) {  
				echo '<OPTION SELECTED VALUE=';
			} else {
				echo '<OPTION VALUE=';
			}
			echo $myrow['debtorno'] . '>' . $myrow['name'];
		} //end while loop
	echo '</SELECT></TD></TR>';
		$sql ="SELECT cp.id,terms.title,years.year FROM collegeperiods cp
		INNER JOIN terms ON terms.id=cp.term_id
		INNER JOIN years ON years.id=cp.year ";
		$result=DB_query($sql,$db);
		while ($myrow = DB_fetch_array($result)) {
		$mps_RET[] = array("id" => $myrow['id'],
				     "title" => $myrow['title'],"year" => $myrow['year']);
		}

echo '<CENTER><TABLE><TR><TD>' . _('Period:') . '</TD>';
foreach($mps_RET as $sem=>$quarters)
{
echo '<TD><INPUT type=checkbox name=mp_arr[] value='.$quarters['id'].'>'.$quarters['title']._('-').$quarters['year'].'</TD>';
}
echo '</TR>';
echo "</TABLE>";
	$sql = "SELECT fullaccess FROM www_users
		WHERE userid=  '" . trim($_SESSION['UserID']) . "'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);
	if($myrow[0]==8 || $myrow[0]==11){	
	echo "<P><INPUT TYPE='Submit' NAME='PrintPDF' VALUE='" . _('PrintPDF') . "'>";
	}
	echo "<INPUT TYPE='Submit' NAME='html' VALUE='" . _('View Html') . "'>";

	include('includes/footer.inc');
} /*end of else not PrintPDF */

?>