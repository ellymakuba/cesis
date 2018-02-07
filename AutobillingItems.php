<?php

/* $Id: CustomerReceipt.php 3868 2010-09-30 14:53:59Z tim_schofield $ */
/* $Revision: 1.46 $ */
ob_start();
$PageSecurity = 2;
include('includes/session.inc');

$title = _('Manage Autobilling');

include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc');
$msg='';
echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . '>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '<table border="1">';
	
echo '<tr><td>' . _('YOS') . ":</td>
		<td><select name='yos'>";
		echo '<OPTION SELECTED VALUE=0>' . _('Select YOS');
		$sql="SELECT id,grade_level FROM gradelevels 
		ORDER BY grade_level";
		$result=DB_query($sql,$db);
		while ($myrow = DB_fetch_array($result)) {
	echo '<option value='. $myrow['id'] . '>' .$myrow['grade_level'];
		} //end while loop
		DB_data_seek($result,0);
	echo '</select></td></tr>';
echo '<tr><td>' . _('Term') . ":</td>
		<td><select name='term'>";
		echo '<OPTION SELECTED VALUE=0>' . _('Select Period');
		$sql="SELECT cp.id,terms.title,years.year FROM collegeperiods cp
		INNER JOIN terms ON terms.id=cp.term_id
		INNER JOIN years ON years.id=cp.year";
		$result=DB_query($sql,$db);
		while ($myrow = DB_fetch_array($result)) {
		echo '<option value='. $myrow['id'].  '>'.' '.$myrow['title'].' '.$myrow['year'];
		} //end while loop
		DB_data_seek($result,0);
		echo '</select></td></tr></table>';
		echo '<table border="1">';
echo "<br><div class='centre'><input  type='Submit' name='register' value='" . _('Submit') . "'>&nbsp;<input  type=submit action=RESET VALUE='" . _('Reset') . "'></div>";		
		
if (isset($_POST['register'])) {
$_SESSION['yos'] = $_POST['yos'];
$_SESSION['term'] = $_POST['term'];
		
echo '<table border="1">';

$sql="SELECT grade_level FROM gradelevels 
WHERE id='".$_SESSION['yos']."'";
$result=DB_query($sql,$db);
$myrow = DB_fetch_array($result);
echo "<tr><td>" . _('YOS') . ":</td>
	<td>".$myrow['grade_level']."</td>";
	
$sql="SELECT t.title,y.year FROM terms t
INNER JOIN collegeperiods cp ON cp.term_id=t.id
INNER JOIN years y ON y.id=cp.year
WHERE cp.id='".$_SESSION['period']."'";
$result=DB_query($sql,$db);
$myrow = DB_fetch_array($result);
echo "<tr><td>" . _('Term') . ":</td>
	<td>".$myrow['title'].' '.$myrow['year']."</td>";
	
echo '<tr><th>' . _('Receipt Product') . '</th>
<th>'. _('Amount') . ':</th>
		<th>' . _('priority') . ':</th>';
	 $sql = 'SELECT id,stockid, description FROM stockmaster WHERE 
	 categoryid = 2';
     $DbgMsg = _('The SQL that was used to retrieve the information was');
     $ErrMsg = _('Could not check whether the group is recursive because');
     $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
		 
while ($row = DB_fetch_array($result))
			{
			 if (($j%2)==1)
		    echo "<tr bgcolor=\"F0F0F0\">";
		  else
		    echo "<tr bgcolor=\"FFFFFF\">";
		echo "<tr><td><Input type = 'checkbox' name ='id[]' value='".$row['id']."' readonly=''>".$row['description']."</td>";
			
	
echo "<td>"; ?><input type="text" name='amount<?php echo $row['id']; ?>' id='amount'  size='10' > <?php "</td>";
		  echo "<td>"; ?><input type="text" name='priority<?php echo $row['id']; ?>' id='priority'  size='3' > <?php "</td>";
		    echo "</tr>";
		  $j++;	  
			}		 		
		echo '<table border="1">';
echo "<br><div class='centre'><input  type='Submit' name='submit' value='" . _('Submit') . "'>&nbsp;<input  type=submit action=RESET VALUE='" . _('Reset') . "'></div>";	
}

if (isset($_POST['submit'])) {
$sql = "SELECT id FROM autobilling
		WHERE yos='". $_SESSION['yos'] ."'
		AND term_id='". $_SESSION['term'] ."'";
		$result=DB_query($sql,$db);
if(DB_fetch_row($result)>0){
prnMsg(_('The Fee Structure for this class has already been created'),'warn');
exit();	
}
$sql = "INSERT INTO autobilling (yos,term_id) 
		VALUES ('" .$_SESSION['yos'] ."','" .$_SESSION['term'] ."') ";
		$ErrMsg = _('The student could not be updated because');
$result = DB_query($sql,$db,$ErrMsg);
prnMsg( _('items added successfully'),'success');

$sql="SELECT LAST_INSERT_ID()";
	$result = DB_query($sql,$db);
	$myrow = DB_fetch_row($result);
	$id = $myrow[0];

foreach($_POST['id'] as $value){
if($_POST['amount'.$value]>0){
$sql5="SELECT stockid FROM stockmaster 
WHERE id='".$value."'";
$result5=DB_query($sql5,$db);
$myrow5 = DB_fetch_array($result5);
$stock_id=$myrow5['stockid'];
$sql = "SELECT id FROM autobilling_items
		WHERE autobilling_id='". $id ."'
		AND product_id='". $value ."'";
		$result=DB_query($sql,$db);
if(DB_fetch_row($result)>0){
prnMsg(_($value._(' ').'has already been invoiced for this yos'),'warn');	
}
else{

$sql = "INSERT INTO autobilling_items (autobilling_id,product_id,amount,priority) 
		VALUES ('" .$id ."','" .$stock_id ."','" .$_POST['amount'.$value] ."','" .$_POST['priority'.$value]."') ";
	$result=DB_query($sql,$db);
prnMsg( _('products added successfully'),'success');
}		
}
}
}
include('includes/footer.inc');
?>
