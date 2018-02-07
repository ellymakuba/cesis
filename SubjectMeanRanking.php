<?php
/* $Id: PDFReceipt.php 3714 2010-09-07 21:31:01Z tim_schofield $*/

$PageSecurity = 2;
if(isset($_POST['period_id']) && isset($_POST['grade'])){
include('includes/session.inc');
include('includes/PDFStarter.php');
require('grades/SubjectMeanRanking.php');

$_SESSION['class'] = $_POST['class_id'];
$_SESSION['period'] = $_POST['period_id'];
$_SESSION['subject'] = $_POST['subject_id'];			
$PageNumber=1;
$line_height=12;
if ($PageNumber>1){
	$pdf->newPage();
}
$FontSize=13;
$YPos= $Page_Height-$Top_Margin;
$XPos=0;
$FontSize=18;
$YPos= $Page_Height-$Top_Margin;
$XPos=0;
$pdf->addJpegFromFile($_SESSION['LogoFile'] ,$XPos+260,$YPos-120,0,100);
$YPos-=(2*$line_height);
$pdf->SetFont('times', '', 18, '', 'false');
$LeftOvers = $pdf->addTextWrap(230,$YPos-($line_height*10),400,$FontSize,_('KIPKEINO SCHOOL'));
$FontSize=12;
$LeftOvers = $pdf->addTextWrap(180,$YPos-($line_height*11),400,$FontSize,_('P.O BOX 7771 - ELDORET - Telephone: 020-2030047'));
$FontSize=10;
$LeftOvers = $pdf->addTextWrap(240,$YPos-($line_height*12),300,$FontSize,_('Email :').' '.$_SESSION['CompanyRecord']['email']);
$YPos-=(2*$line_height);
$pdf->SetFont('times', '', 12, '', 'false');
$FontSize=12;
$sql = "SELECT t.title,y.year FROM collegeperiods cp
INNER JOIN terms t ON t.id=cp.term_id
INNER JOIN years y ON y.id=cp.year
WHERE cp.id =  '". $_POST['period_id'] ."'";
$result=DB_query($sql,$db);
$myrow=DB_fetch_array($result);
$year=$myrow['year'];
$term=$myrow['title'];

$sql = "SELECT grade_level FROM gradelevels
WHERE id =  '". $_POST['grade'] ."'";
$result=DB_query($sql,$db);
$myrow=DB_fetch_array($result);
$grade=$myrow['grade_level'];

/*$LeftOvers = $pdf->addTextWrap(100,$YPos-($line_height*11),500,$FontSize, _('Reportcard For').': ' . $myrow[0].'    '._('Period').': ' .$myrow2[1].'-'.$myrow2[2]);*/	
$LeftOvers = $pdf->addTextWrap(200,$YPos-($line_height*12),400,$FontSize,_('SUBJECTS MEAN RANKING REPORT'));
 $LeftOvers = $pdf->addTextWrap(200,$YPos-($line_height*12.3),110,$FontSize,'______________________________________________________________________________');

$LeftOvers = $pdf->addTextWrap(40,$YPos-($line_height*15),300,$FontSize, _('Class').': ' . $grade);
$LeftOvers = $pdf->addTextWrap(300,$YPos-($line_height*15),300,$FontSize, _('Period').': ' . $term.' '.$year);	
$YPos +=20;
$YPos -=$line_height;
//Note, this is ok for multilang as this is the value of a Select, text in option is different

$YPos -=(12*$line_height);

$pdf->line(39, $YPos+$line_height,$Page_Width-$Right_Margin, $YPos+$line_height);

$YPos -=50;
$YPos -=$line_height;
$Left_Margin2=100;
$pdf->line(39, $YPos+$line_height,500, $YPos+$line_height);
$pdf->line(39, $YPos,500, $YPos);

$LeftOvers = $pdf->addTextWrap(40,$YPos+1,300,$FontSize,_('Rank'));
$LeftOvers = $pdf->addTextWrap(70,$YPos+1,300,$FontSize,_('Subjects'));
$LeftOvers = $pdf->addTextWrap(200,$YPos+1,300,$FontSize,_('Mean Score'));
$LeftOvers = $pdf->addTextWrap(300,$YPos+1,300,$FontSize,_('Mean Grade'));
$LeftOvers = $pdf->addTextWrap(370,$YPos+1,300,$FontSize,_('Teacher'));
$line_width=40;
$XPos=160;
$YPos2=$YPos+$line_height;
$count=0;
$i=0;
$reportgrade=0;
$total_mean=0;


$subjects_array=get_subjects($_POST['grade'],$_POST['period_id'],$db);
if($subjects_array>0){
$bus_report2 = new bus_report2($_POST['grade'],$_POST['period_id'],$db);
foreach ($bus_report2->calculate_subjects_mean as $a => $b) {
$count=$count+1;

$total_mean=$total_mean+$b['mean'];
$result = DB_query($sql,$db,$ErrMsg);
				
			}
		}	
			
if($count>0)
$subject_mean=number_format($total_mean/$count,2);
else
$subject_mean=0;
$count2=0;
		$sql = "select lower FROM  gradelevels 
	WHERE id='".$_POST['grade']."'";
	$result = DB_query($sql,$db);
	$row = DB_fetch_row($result);
	$lower_display=$row[0];	
	if($lower_display==1){
	
		$sql = "SELECT sub.subject_name,csm.mean,sub.grading,u.realname FROM class_subject_mean csm
		INNER JOIN subjects sub ON sub.id=csm.subject_id
		INNER JOIN registered_students rs ON rs.subject_id=sub.id
		INNER JOIN www_users u ON u.userid=rs.teacher
		WHERE csm.period_id='" . $_POST['period_id'] ."'
		AND csm.class='" . $_POST['grade'] ."'
		AND sub.lower_display=1
		GROUP BY rs.subject_id
		ORDER BY csm.mean DESC";
	}
	else{
	$sql = "SELECT sub.subject_name,csm.mean,sub.grading,u.realname FROM class_subject_mean csm
		INNER JOIN subjects sub ON sub.id=csm.subject_id
		INNER JOIN registered_students rs ON rs.subject_id=sub.id
		INNER JOIN www_users u ON u.userid=rs.teacher
		WHERE csm.period_id='" . $_POST['period_id'] ."'
		AND csm.class='" . $_POST['grade'] ."'
		AND sub.display=1
		GROUP BY rs.subject_id
		ORDER BY csm.mean DESC";
	}	
		$result=DB_query($sql,$db);
		while($myrow=DB_fetch_array($result)){
					$count2=$count2+1;
					$sql2 = "SELECT grade FROM reportcardgrades
					WHERE range_from <=  '".$myrow['mean']."'
					AND range_to >='". $myrow['mean']."'
					AND grading LIKE '". $myrow['grading']."'";
					$result2=DB_query($sql2,$db);
					$myrow2=DB_fetch_array($result2);
					$reportgrade=$myrow2['grade'];
					
			$LeftOvers = $pdf->addTextWrap(40,$YPos-10,300,$FontSize,$count2);
			$LeftOvers = $pdf->addTextWrap(70,$YPos-10,300,$FontSize,$myrow['subject_name']);	
			$LeftOvers = $pdf->addTextWrap(200,$YPos-10,300,$FontSize,number_format($myrow['mean'],2));
			$LeftOvers = $pdf->addTextWrap(300,$YPos-10,300,$FontSize,$reportgrade);
			$LeftOvers = $pdf->addTextWrap(370,$YPos-10,300,$FontSize,$myrow['realname']);
				
			$YPos -=$line_height;
		}
		
		
$sql = "SELECT grade FROM reportcardgrades
		WHERE range_from <=  '".$subject_mean."'
		AND range_to >='". $subject_mean."'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_array($result);
		$reportgrade=$myrow['grade'];	
$YPos -=$line_height;		
$LeftOvers = $pdf->addTextWrap(200,$YPos-10,300,$FontSize,_('Class Mean').' '.$subject_mean);		
$pdf->line(39, $YPos2,39, $YPos+($line_height*1));
$pdf->line(69, $YPos2,69, $YPos+($line_height*1));
$pdf->line(198, $YPos2,198, $YPos+($line_height*1));
$pdf->line(298, $YPos2,298, $YPos+($line_height*1));
$pdf->line(365, $YPos2,365, $YPos+($line_height*1));
$pdf->line(500, $YPos2,500, $YPos+($line_height*1));
$pdf->line(39, $YPos+$line_height,500, $YPos+$line_height);

$pdf->Output('Receipt-'.$_GET['ReceiptNumber'], 'I');


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
echo '<TR><TD>' . _('Class:') . '</TD><TD><SELECT Name="grade">';
		$sql="SELECT id,grade_level FROM gradelevels ";
		$result=DB_query($sql,$db);
		while ($myrow = DB_fetch_array($result)) {
			if ($myrow['id'] == $_POST['grade']) {  
				echo '<OPTION SELECTED VALUE=';
			} else {
				echo '<OPTION VALUE=';
			}
			echo $myrow['id'] . '>'.' '.$myrow['grade_level'];
		} //end while loop
	echo '</SELECT></TD></TR>';
	echo "</TABLE>";
	echo "<P><CENTER><INPUT TYPE='Submit' NAME='PrintPDF' VALUE='" . _('PrintPDF') . "'>";

	include('includes/footer.inc');;
} /*end of else not PrintPDF */

?>