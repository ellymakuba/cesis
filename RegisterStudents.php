<?php
$PageSecurity = 2;
include('includes/session.inc');
$title = _('Manage Students');
include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc');
echo '<p class="page_title_text">' . ' ' . _('Register student subjects') . '';
$msg='';
echo "<form name='myform' method='post' action=" . $_SERVER['PHP_SELF'] . '>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '</br><table class=enclosed>';

echo '<tr><td>' . _('Stream') . ': </td><td><select tabindex="5" name="student_class">';
$result = DB_query('SELECT * FROM classes',$db);
while ($myrow = DB_fetch_array($result)) {
	if ($myrow['id']==$_POST['class_name']) {
		echo '<option selected VALUE=';
	} else {
		echo '<option VALUE=';
	}
	echo $myrow['id'] . '>' . $myrow['class_name'];
} //end while loop
	echo '</select></td></tr></table>';

echo "<br><div class='centre'><input  type='Submit' name='submit' value='" . _('Show Students') . "'></div><br>";

if (isset($_POST['submit'])) {
$_SESSION['class'] = $_POST['student_class'];
$sql = "SELECT grade_level_id FROM classes
WHERE id='".$_SESSION['class']."'";
$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
$query_data = DB_fetch_row($result);
$_SESSION['yos'] = $query_data[0];
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

echo '<table class=enclosed>';

if (isset($_POST['student_class']) && $_POST['student_class'] !=0) {
$sql = "SELECT class_name FROM classes
		WHERE id =  '". $_POST['student_class']."'";
		$result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);
echo "<tr><td class=\"visible\">" . _('Class') . ":</td>
	<td>".$myrow[0]."</td></tr>";

echo '<tr><td class="visible">' . _('Subject') . ":</td>
		<td class=\"visible\"><select name='subject_id'>";
		echo '<OPTION SELECTED VALUE=0>' . _('Select Subject');
		$sql="SELECT id,subject_name FROM subjects ORDER BY subject_name";
		$result=DB_query($sql,$db);
		while ($myrow = DB_fetch_array($result)) {
		echo '<option value='. $myrow['id'] . '>' . $myrow['subject_name'];
		} //end while loop
		DB_data_seek($result,0);
		echo '</select></td></tr>';
echo '<tr><td class="visible">' . _('Period') . ":</td>
		<td class=\"visible\"><select name='period_id'>";
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

		echo '<tr><td class="visible">' . _('Teacher') . ":</td>
		<td class=\"visible\"><select name='teacher'>";
		echo '<OPTION SELECTED VALUE=0>' . _('Select Teacher');
		$sql="SELECT userid,realname FROM www_users ";
		$result=DB_query($sql,$db);
		while ($myrow = DB_fetch_array($result)) {
		echo '<option value='. $myrow['userid'].  '>'.' '.$myrow['realname'];
		} //end while loop
		DB_data_seek($result,0);
		echo '</select></td></tr>';

echo '<tr><th>' . _('Add Student') . '</th>
		<th>' . _('RegNo') . ':</th>';


$sql = "SELECT COUNT(*) FROM debtorsmaster
		WHERE  class_id= '". $_POST['student_class'] ."'
		AND status=0";
        $result=DB_query($sql,$db);
		$myrow=DB_fetch_row($result);
		if ($myrow[0]>0 ){
		$sql = "SELECT * FROM debtorsmaster
		WHERE  class_id= '". $_POST['student_class'] ."'
		AND status=0
		ORDER BY name";
        $DbgMsg = _('The SQL that was used to retrieve the information was');
        $ErrMsg = _('Could not check whether the group is recursive because');
        $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
		}
		else{
		prnMsg( _('There are no records to display Currently'),'error');
exit();
}


}
else{
prnMsg( _('Please choose the search criteria'),'error');
exit();
}
echo '<tr><td>
	 <input type="button" name="Check_All" value="Check All"
onClick="Check(document.myform.tick)">
	  </td></tr>';
			while ($row = DB_fetch_array($result))
			{
			 if (($j%2)==1)
		    echo "<tr bgcolor=\"F0F0F0\">";
		  else
		    echo "<tr bgcolor=\"FFFFFF\">";
		echo "<tr>";
		echo "<td class=\"visible\"><Input type = 'Checkbox' name ='add_id[]' id='tick' value='".$row['id']."'>".$row['name']."</td>";
		echo "<td class=\"visible\">".$row['debtorno']."</td>";

		    echo "</tr>";
		  $j++;
			}


echo "<td><br><div class='centre'><input  type='Submit' name='register' value='" . _('Register') . "'></div></td></tr>";
}
if (isset($_POST['register'])){
$sql = "SELECT year FROM collegeperiods
		WHERE id =  '". $_POST['period_id'] ."'";
		$result=DB_query($sql,$db);
		$row=DB_fetch_row($result);
		$academic_year=$row[0];
		$_SESSION['year']=$academic_year;

$i=0;
if(isset($_POST['add_id'])){
foreach($_POST['add_id'] as $value){
$sql = "SELECT id FROM registered_students
		WHERE student_id='". $_POST['add_id'][$i] ."'
		AND subject_id='". $_POST['subject_id'] ."'
		AND period_id =  '". $_POST['period_id'] ."'";
		$result=DB_query($sql,$db);
if(DB_fetch_row($result)>0){
prnMsg(_($_POST['add_id'][$i]._(' ').'has already been registered for this subject'),'warn');
$i++;
}
else{
$sql = "INSERT INTO registered_students (student_id,subject_id,period_id,class_id,academic_year_id,teacher,yos)
		VALUES ('" .$_POST['add_id'][$i] ."','" .$_POST['subject_id'] ."','" .$_POST['period_id'] ."','" .$_SESSION['class'] ."','" .$_SESSION['year'] ."','" .$_POST['teacher'] ."','" .$_SESSION['yos'] ."') ";
		$ErrMsg = _('The student could not be updated because');
$result = DB_query($sql,$db,$ErrMsg);
$i++;
prnMsg( _('student registration successful'),'success');
}
}
}
include('includes/footer.inc');
			exit;
}
include('includes/footer.inc');
?>
<SCRIPT LANGUAGE="JavaScript">
<!--

<!-- Begin
function Check(chk)
{
if(document.myform.Check_All.value=="Check All"){
for (i = 0; i < chk.length; i++)
chk[i].checked = true ;
document.myform.Check_All.value="UnCheck All";
}else{

for (i = 0; i < chk.length; i++)
chk[i].checked = false ;
document.myform.Check_All.value="Check All";
}
}

// End -->
</script>
