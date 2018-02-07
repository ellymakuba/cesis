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

	
$PageNumber=1;
$line_height=12;
if ($PageNumber>1){
	$pdf->newPage();
}
$FontSize=20;
$YPos= $Page_Height-$Top_Margin;
$XPos=0;
$pdf->addJpegFromFile($_SESSION['LogoFile'] ,250,$YPos-50,0,65);
$LeftOvers = $pdf->addTextWrap(140,$YPos-($line_height*7),400,$FontSize,_('MASINDE MULIRO UNIVERSITY'));
$LeftOvers = $pdf->addTextWrap(280,$YPos-($line_height*9),300,$FontSize, _('OF'));
$LeftOvers = $pdf->addTextWrap(160,$YPos-($line_height*11),300,$FontSize, _('SCIENCE AND TECHNOLOGY'));
$FontSize=13;
$sql = "SELECT dtr.name,dtr.debtorno,dp.department_name,cs.course_name,cs.additional FROM debtorsmaster dtr
INNER JOIN courses cs ON cs.id=dtr.course_id
INNER JOIN departments dp ON dp.id=cs.department_id
INNER JOIN gradelevels gl ON gl.id=dtr.grade_level_id 
WHERE dtr.id =  '". $_SESSION['student'] ."'";
$result=DB_query($sql,$db);
$myrow=DB_fetch_row($result);
$LeftOvers = $pdf->addTextWrap(240,$YPos-($line_height*14),300,$FontSize, _('This is to satisfy that'));
$FontSize=22;
$LeftOvers = $pdf->addTextWrap(230,$YPos-($line_height*16),300,$FontSize, $myrow[0]);
$FontSize=13;
$LeftOvers = $pdf->addTextWrap(220,$YPos-($line_height*18),300,$FontSize,_('having satisfied the requirements'));
$LeftOvers = $pdf->addTextWrap(230,$YPos-($line_height*20),300,$FontSize,_('for the award of the degree of'));
$FontSize=20;
$LeftOvers = $pdf->addTextWrap(200,$YPos-($line_height*22),300,$FontSize,$myrow[3]);
$FontSize=16;
$LeftOvers = $pdf->addTextWrap(270,$YPos-($line_height*24),300,$FontSize,_('(').$myrow[4].(')'));

$sql = "SELECT SUM(da.cumilative_marks) as numerator ,dm.name,dm.debtorno FROM degree_awards da
INNER JOIN debtorsmaster dm ON dm.id=da.student_id
WHERE da.student_id =  '". $_SESSION['student'] ."'
GROUP BY da.student_id";
$result=DB_query($sql,$db);
$myrow=DB_fetch_array($result);
$numerator=$myrow['numerator'];

$sql = "SELECT SUM(da.no_of_subjects) as totalsubs  FROM degree_awards da
WHERE da.student_id =  '". $_SESSION['student'] ."'";
$result=DB_query($sql,$db);
$myrow=DB_fetch_array($result);
$totalsubs=$myrow['totalsubs'];

$denominator=$totalsubs*3;
$degree=$numerator/$denominator;

$sql = "SELECT degree FROM degrees
		WHERE range_from <=  '". $degree."'
		AND range_to >='". $degree ."'";
        $result=DB_query($sql,$db);
$result=DB_query($sql,$db);
$myrow=DB_fetch_array($result);
$degree_name=$myrow['degree'];
$FontSize=18;
$LeftOvers = $pdf->addTextWrap(190,$YPos-($line_height*26),300,$FontSize,$degree_name);
$FontSize=13;
$LeftOvers = $pdf->addTextWrap(180,$YPos-($line_height*28),300,$FontSize,_('Was admitted to the degree at a a congregation held '));
$LeftOvers = $pdf->addTextWrap(260,$YPos-($line_height*30),300,$FontSize,_('at this university '));
$LeftOvers = $pdf->addTextWrap(240,$YPos-($line_height*32),300,$FontSize,_('on the ..... '));
$LeftOvers = $pdf->addTextWrap(240,$YPos-($line_height*34),300,$FontSize,_('in the year.... '));

		

	

$pdf->Output('Receipt-'.$_GET['ReceiptNumber'], 'I');
	
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