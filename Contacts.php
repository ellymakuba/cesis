<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="css/employees.css" />
	<link rel="stylesheet" type="text/css" href="css/main.css"/>
	<link rel="stylesheet" href="../corehrmis/js/example.css" TYPE="text/css" MEDIA="screen">
	<link href="css/text.css" rel="stylesheet" type="text/css" />

<style type="text/css">

<style type="text/css">


#tablet{
	border:1px solid gray;
}


.style2 {font-size: x-small}
.style3 {	color: #FFFFFF;
	font-weight: bold;
}
.style4 {color: #FFFFFF}
.info   { color: black; background-color: transparent; font-weight: normal; }
  .warn   { color: rgb(120,0,0); background-color: transparent; font-weight: normal; }
  .error  { color: red; background-color: transparent; font-weight: bold }
-->
</style>
 <style type="text/css">
<!--
.style7 {
	color: #FF0000;
	font-size: 9px;
	font-family: "Courier New", Courier, mono;
}
.style8 {
	background-color: transparent;
	color: red;
	font-size: 12px;
}
-->
 </style>
 <link rel="stylesheet" type="text/css" href="css/epoch_styles.css"/>
<style type="text/css">
<!--
.style3 {color: #FFFFFF;
	font-weight: bold;
}
.style4 {color: #FFFFFF}
-->
</style>

 <script type="text/javascript" src="css/epoch_classes.js"></script>
 <script language="JavaScript" src="js/calendar1.js"></script><!--  -->
 <script type="text/javascript" src="js/formval.js"></script>
 <script type="text/javascript">
/*You can also place this code in a separate file and link to it like epoch_classes.js*/
	var dp_cal,dob_cal,d_iss,d_exp,d_eff,d_act,d_qdate;
		  
    window.onload = function () {
	dp_cal  = new Epoch('epoch_popup','popup',document.getElementById('empdate'));
	dob_cal  = new Epoch('epoch_popup','popup',document.getElementById('dob'));
	d_iss  = new Epoch('epoch_popup','popup',document.getElementById('issuedate'));
	d_exp = new Epoch('epoch_popup','popup',document.getElementById('expdate'));
	d_eff = new Epoch('epoch_popup','popup',document.getElementById('effdate'));
	d_act = new Epoch('epoch_popup','popup',document.getElementById('actdate'));
	d_qdate= new Epoch('epoch_popup','popup',document.getElementById('qdate'));
  };
function validateOnSubmit() {
	var elem;
    var errs=0;
	// execute all element validations in reverse order, so focus gets
    // set to the first one in error.
	
	
	
	if (errs>1)  alert('There are fields which need correction before submitting');
    if (errs==1) alert('There is a field which needs correction before submitting');
   	
    return (errs==0);
};
</script>


</head>

<body>
<?php 
 $PageSecurity = 3;

include('includes/session.inc');
include('includes/SQL_CommonFunctions.inc');
  
  if (!empty($_GET["studentid"]))
    $id=$_GET["studentid"];
	
  if (!empty($_GET["action"]))
    $action="update_go";
  
  if (!empty($_REQUEST["studentid"]))
  {
    $id=$_REQUEST["studentid"];
	$action = "update_go";
	
	
	$sql = "SELECT * FROM debtorsmaster
			WHERE id = '$id'";
	$ErrMsg = _('The student details could not be retrieved because');
	$result = DB_query($sql,$db,$ErrMsg);
	
	$myrow = DB_fetch_array($result);
	 
	    $boxNo = $myrow['boxno'];  
		$town = $myrow['town']; 
	    $zip=$myrow['zip']; 
	    $state=$myrow['state']; 
	    $mobileNo=$myrow['mobileno'];
		
		$gboxNo = $myrow['gboxno'];  
		$gtown = $myrow['gtown']; 
	    $gzip=$myrow['gzip'];
		$gName = $myrow['gname'];  
		$relationship = $myrow['relationship']; 
	    $gstate=$myrow['gstate'];
		$gmobileNo=$myrow['gmobileno'];   
	
  }
  
 ?>
<form action="Students.php" method="post" name="locationsfrm">
 <?php
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';

?>
<table width="100%">
<tr><td><table><tr><td colspan="2"><h3><font color="blue">Student Contacts </font></h3></td></tr>
<tr><td class="visible"><strong>P.O Box </strong></div></td>
   <td colspan="2" class="visible"><input name="boxno" type="text" id="boxno" <?php if (!empty($boxNo))  echo "value=$boxNo"; ?>></td></tr>
 <tr><td class="visible"><strong>Town </strong></div></td>
   <td class="visible"><input name="town" type="text" id="town" <?php if (!empty($town))  echo "value=$town"; ?>></td></tr>
   <tr><td class="visible"><strong>Postal Code </strong></div></td>
   <td colspan="2" class="visible"><input name="zip" type="text" id="zip" <?php if (!empty($zip))  echo "value=$zip"; ?>></td></tr>
 <tr><td  class="visible"><strong>State </strong></div></td>
   <td colspan="2" class="visible"><input name="state" type="text" id="state" <?php if (!empty($state))  echo "value=$state"; ?>></td></tr>
    <tr><td  class="visible"><strong>Mobile No </strong></div></td>
   <td colspan="2" class="visible"><input name="mobileno" type="text" id="mobileno" <?php if (!empty($mobileNo))  echo "value=$mobileNo"; ?>></td>

<tr><td  class="visible"><input type="reset" name="Reset" value="Reset"></td>
<td class="visible"><input type="submit" name="Submit" value="Submit"></td>
<input name="action" type="hidden" <?php if (!empty($action)) echo "value=$action" ?>>
			 <input name="studentid" type="hidden" <?php if (!empty($id)) echo "value=$id" ?>>
			 <input name="tabfrom" type="hidden" <?php echo "value=CONT" ?>></tr>
	</table></td>
<td><table><tr><td colspan="2"><h3><font color="blue">Guardian Contacts </font></h3></td></tr>
<tr><td class="visible"><strong>Relationship to Student </strong></td>
   <td colspan="2" class="visible"><input name="relationship" type="text" id="relationship" <?php if (!empty($relationship))  echo "value=$relationship"; ?>></td></tr>
   <tr><td class="visible"><strong>Full Name </strong></div></td>
   <td colspan="2" class="visible"><input name="gname" type="text" id="gname" <?php if (!empty($gName))  echo "value=$gName"; ?>></td></tr> 
    <tr><td  class="visible"><strong>Mobile No </strong></div></td>
   <td colspan="2" class="visible"><input name="gmobileno" type="text" id="gmobileno" <?php if (!empty($gmobileNo))  echo "value=$gmobileNo"; ?>></td></tr> 
   <tr><td class="visible"><strong>P.O Box </strong></td>
   <td colspan="2" class="visible"><input name="gboxno" type="text" id="gboxno" <?php if (!empty($gboxNo))  echo "value=$gboxNo"; ?>></td></tr>
<tr> <td class="visible"><strong>Town </strong></div></td>
   <td class="visible"><input name="gtown" type="text" id="gtown" <?php if (!empty($town))  echo "value=$gtown"; ?>></td></tr>
<tr> <td  class="visible"><strong>Postal Code</strong></div></td>
   <td colspan="2" class="visible"><input name="gstate" type="text" id="gstate" <?php if (!empty($gstate))  echo "value=$gstate"; ?>></td></tr>
</table>
</form>

</body>


</html>
