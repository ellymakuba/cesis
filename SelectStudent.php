<?php
ob_start();
$PageSecurity = 2;
include('includes/session.inc');
$title = _('Manage Students');
include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc');
$msg='';
echo "<br><form method='post' action=" . $_SERVER['PHP_SELF'] . '>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '<table class=enclosed>';

echo '<tr><td>' . _('Search Student RegNo/Name') . ':<input type="Text" name="searchval"
  size=30   maxlength=20></td>
		<td><input  type="submit" name="form1" value="Search"></td></tr>';

    echo '<tr><th>' . _('Name') . ':</th>
		<th>' . _('Stream') . '</th>
		<th>' . _('Status') . '</th>
		<th>' . _('AdmNo') . '</th>
		<th>' . _('Invoice') . '</th>
		<th>' . _('Statement') . '</th>
		<th>' . _('Edit') . '</th>';
  if (isset($_GET['pageno'])) {
   $pageno = $_GET['pageno'];
} else {
   $pageno = 1;
}
$sql = "SELECT count(*) FROM debtorsmaster";
$result = DB_query($sql,$db);
$query_data = DB_fetch_row($result);
$numrows = $query_data[0];

$targetpage = "SelectStudent.php";
$rows_per_page = 25;
$lastpage      = ceil($numrows/$rows_per_page);
$pageno = (int)$pageno;
if ($pageno > $lastpage) {
   $pageno = $lastpage;
} // if
$limit = 'LIMIT ' .($pageno - 1) * $rows_per_page .',' .$rows_per_page;
$SearchString = '%' . str_replace(' ', '%', $_POST['searchval']) . '%';
if (isset($_POST['form1'])){
$sql = "SELECT dm.name,dm.debtorno,dm.id,dm.class_id,dm.status,
(SELECT class_name FROM classes WHERE id=class_id) as class
FROM debtorsmaster dm
WHERE debtorno LIKE  '". $SearchString."'
OR name LIKE  '". $SearchString."'";
$DbgMsg = _('The SQL that was used to retrieve the information was');
$ErrMsg = _('Could not check whether the group is recursive because');
$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
}
else{
$sql = "SELECT dm.name,dm.debtorno,dm.id,dm.class_id,dm.status,
(SELECT class_name FROM classes WHERE id=class_id) as class
FROM debtorsmaster dm
ORDER BY name $limit";
$DbgMsg = _('The SQL that was used to retrieve the information was');
$ErrMsg = _('Could not check whether the group is recursive because');
$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
}
while ($row = DB_fetch_array($result))
{
	$status='';
	if($row['status']==0){
		$status='Present';
	}
	else{
		$status='Transferred/Completed';
	}
	if ($k==1){
		echo '<tr class="EvenTableRows">';
		$k=0;
	} else {
		$k=1;
		echo "<tr >";
	}
		  echo "<td>".$row['name']."</td>";
			echo "<td>".$row['class']."</td>";
			echo "<td>".$status."</td>";
			echo "<td>".$row['debtorno']."</td>";
			echo '<td><a  href="' .'StudentBilling.php?debtorno=' . $row['debtorno'].'">'._('New Invoice').'</a></td>';
			echo '<td><a  href="' .'StudentStatements.php?debtorno=' . $row['debtorno'].'">'._('View Statement').'</a></td>';
		  echo '<td><a href="' . $rootpath .'/Students.php?&id=' . $row['id'] . '">' . _('Edit Student') . '</a></td>';
		  echo "</tr>";
		  $j++;
}
echo "<tr><td>";
if ($pageno == 1) {
   echo "FIRST PREV ";
} else {
   echo " <a href='{$_SERVER['PHP_SELF']}?pageno=1'>FIRST</a> ";
   $prevpage = $pageno-1;
   echo " <a href='{$_SERVER['PHP_SELF']}?pageno=$prevpage'>PREV</a> ";
}
echo " ( Page $pageno of $lastpage ) ";
if ($pageno == $lastpage) {
   echo " NEXT LAST ";
} else {
   $nextpage = $pageno+1;
   echo " <a href='{$_SERVER['PHP_SELF']}?pageno=$nextpage'>NEXT</a> ";
   echo " <a href='{$_SERVER['PHP_SELF']}?pageno=$lastpage'>LAST</a> ";
}
echo '</td></tr></table>';
include('includes/footer.inc');
?>
