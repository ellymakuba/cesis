<?php
/* $Revision: 1.21 $ */
/* $Id: BankAccounts.php 3845 2010-09-30 14:50:07Z tim_schofield $*/

$PageSecurity = 10;

include('includes/session.inc');

$title = _('Degree Class Management');

include('includes/header.inc');

echo '<p class="page_title_text">' . ' ' . _('Degree Class Management') . '';       

if (isset($_GET['SelectedDegree'])) {
	$SelectedDegree=$_GET['SelectedDegree'];
} elseif (isset($_POST['SelectedDegree'])) {
	$SelectedDegree=$_POST['SelectedDegree'];
}

if (isset($Errors)) {
	unset($Errors);
}

$Errors = array();

if (isset($_POST['submit'])) {

	//initialise no input errors assumed initially before we test
	$InputError = 0;

	/* actions to take once the user has clicked the submit button
	ie the page has called itself with some user input */

	//first off validate inputs sensible
	$i=1;

	$sql="SELECT count(degree)
			FROM degrees WHERE degree='".$_POST['degree']."'";
	$result=DB_query($sql, $db);
	$myrow=DB_fetch_row($result);

	if ($myrow[0]>0 and !isset($SelectedDegree)) {
		$InputError = 1;
		prnMsg( _('The degree already exists in the database'),'error');
		$Errors[$i] = 'rule';
		$i++;
	}
	
	if (isset($SelectedDegree) AND $InputError !=1) {

		/*Check if there are already transactions against this account - cant allow change currency if there are*/
			$sql = "UPDATE degrees
				SET degree='" . $_POST['degree'] . "',
				range_from='" . $_POST['range_from'] . "',
				range_to='" . $_POST['range_to'] . "'
			WHERE id = '" . $SelectedDegree . "'";
		

		$msg = _('The degree details have been updated');
	} elseif ($InputError !=1) {

	/*Selectedbank account is null cos no item selected on first time round so must be adding a    record must be submitting new entries in the new bank account form */

		$sql = "INSERT INTO degrees (range_from,range_to,degree
						)
				VALUES (
				'" . $_POST['range_from'] . "',
				'" . $_POST['range_to'] . "',
				'" . $_POST['degree'] . "'
					)";
		$msg = _('The new degree  has been entered');
	}

	//run the SQL from either of the above possibilites
	if( $InputError !=1 ) {
		$ErrMsg = _('The degree could not be inserted or modified because');
		$DbgMsg = _('The SQL used to insert/modify the report card grades details was');
		$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);

		prnMsg($msg,'success');
		echo '<br>';
		unset($_POST['degree']);
		unset($_POST['range_from']);
		unset($_POST['range_to']);
		unset($SelectedDegree);
	}


} elseif (isset($_GET['delete'])) {
//the link to delete a selected record was clicked instead of the submit button

	$CancelDelete = 0;

// PREVENT DELETES IF DEPENDENT RECORDS IN 'BankTrans'

	if (!$CancelDelete) {
		$sql="DELETE FROM degrees WHERE id='$SelectedDegree'";
		$result = DB_query($sql,$db);
		prnMsg(_('Degree deleted'),'success');
	} //end if Delete bank account

	unset($_GET['delete']);
	unset($SelectedDegree);
}

/* Always show the list of accounts */
If (!isset($SelectedDegree)) {
	$sql = "SELECT *
		FROM degrees
		ORDER BY id";
	$result = DB_query($sql,$db);

	echo '<table class=selection>';
	
	echo "<tr><th>" . _('Degree') . "</th>
		<th>" . _('Range From %') . "</th>
		<th>" . _('Range To %') . "</th>
	</tr>";
	$k=0; //row colour counter

	while ($myrow = DB_fetch_array($result)) {
		if ($k==1){
			echo '<tr class="EvenTableRows">';
			$k=0;
		} else {
			echo '<tr class="OddTableRows">';
			$k=1;
		}

		/*The SecurityHeadings array is defined in config.php */

		printf("<td>%s</td>
			<td>%s</td>
			<td>%s</td>
			<td><a href=\"%s&SelectedDegree=%s\">" . _('Edit') . "</a></td>
			<td><a href=\"%s&SelectedDegree=%s&delete=1&title=%s\">" . _('Delete') . "</a></td>
			</tr>",
			$myrow['degree'],
			$myrow['range_from'],
			$myrow['range_to'],
			$_SERVER['PHP_SELF']  . "?" . SID,
			$myrow['id'],
			$_SERVER['PHP_SELF'] . "?" . SID,
			$myrow['id'],
			urlencode($myrow['rule']));

	} //END WHILE LIST LOOP
	echo '</table><p>';
}

if (isset($SelectedDegree)) {
	echo '<p>';
	echo "<div class='centre'><a href='" . $_SERVER['PHP_SELF'] ."?" . SID . "'>" . _('Show all Degrees') . '</a></div>';
	echo '<p>';
}

echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . "?" . SID . ">";
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
if (isset($SelectedDegree) AND !isset($_GET['delete'])) {
	//editing an existing bank account  - not deleting

	$sql = "SELECT *
		FROM degrees
		WHERE id='$SelectedDegree'";

	$result = DB_query($sql, $db);
	$myrow = DB_fetch_array($result);

	$_POST['degree'] = $myrow['degree'];
	$_POST['range_from'] = $myrow['range_from'];
	$_POST['range_to'] = $myrow['range_to'];
	
	echo '<input type=hidden name=SelectedDegree VALUE=' . $SelectedDegree . '>';
	echo '<table class=selection> ';
} else { //end of if $Selectedbank account only do the else when a new record is being entered
	echo '<table class=selection><tr>';

	
}

// Check if details exist, if not set some defaults
if (!isset($_POST['rule'])) {
	$_POST['rule']='';
}

echo '<td>' . _('Rule') . ': </td>
			<td><input tabindex="2" ' . (in_array('degree',$Errors) ?  'class="inputerror"' : '' ) .' type="Text" name="degree" value="' . $_POST['degree'] . '" size=40 maxlength=50></td></tr>	
			<tr><td>' . _('Range From') . ': </td>
                        <td><input tabindex="3" ' . (in_array('range_from',$Errors) ?  'class="inputerror"' : '' ) .' type="range_from" name="range_from" value="' . $_POST['range_from'] . '" size=40 maxlength=50></td></tr>
						<tr><td>' . _('Range To') . ': </td>
                        <td><input tabindex="3" ' . (in_array('range_to',$Errors) ?  'class="inputerror"' : '' ) .' type="Text" name="range_to" value="' . $_POST['range_to'] . '" size=40 maxlength=50></td></tr>';
		


echo '</tr></table><br>
		<div class="centre"><input tabindex="7" type="Submit" name="submit" value="'. _('Enter Information') .'"></div>';

echo '</form>';
include('includes/footer.inc');
?>
