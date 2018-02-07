<!DOCTYPE html
	PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />



	<link rel="stylesheet" type="text/css" href="css/employees.css" />
	<link rel="stylesheet" type="text/css" href="css/main.css"/>

	<title>View Employees</title>
	<meta name="generator" content="TYPO3 3.8 CMS" />
	

	

<style type="text/css">
<!--
.style4 {color: #FFFFFF}
.info   { color: black; background-color: transparent; font-weight: normal; }
.warn   { color: rgb(120,0,0); background-color: transparent; font-weight: normal; }
 .error  { color: red; background-color: transparent; font-weight: bold }
-->
</style>
 <link rel="stylesheet" type="text/css" href="css/epoch_styles.css"/>
 <script type="text/javascript" src="css/epoch_classes.js"></script>
 <script type="text/javascript" src="js/formval.js"></script> 
 <script language="JavaScript" src="js/calendar1.js"></script><!--  -->
 <script type="text/javascript">
/*You can also place this code in a separate file and link to it like epoch_classes.js*/
	var dp_cal,dob_cal,d_iss;      
     window.onload = function () {
	dp_cal  = new Epoch('epoch_popup','popup',document.getElementById('empdate'));
	dob_cal  = new Epoch('epoch_popup','popup',document.getElementById('dob'));
	d_iss  = new Epoch('epoch_popup','popup',document.getElementById('issuedate'));
};

</script>
</head>
<body bgcolor="#FFFFFF">
<?php 
  include "includes/functions.php";
  include "includes/config.php";
  require_once "includes/db.php";
  
  $d = new dbC();
  $d->connect($db_host, $db_user, $db_pass, $db); 
  
   

	  
  if (!empty($_GET["empid"]))
  {
     $empno=$_GET["empid"];
	
	 $sqlstr="select prmember.*,tbl_titles.title,designation.designation,DeptName,sex as gender,countryname from prmember
	      left join tbl_countries1 on tbl_countries1.id=prmember.nationality
		  left join designation on designation.id=prmember.position_fk
		  left join tbl_titles on tbl_titles.id=prmember.emptitle
		  left join prdept on prdept.deptcode=prmember.dept where
		  prmember.rowid=$empno";
		 		  
	  $result=$d->query($sqlstr) or die(mysql_error());
	  $row=$d->fetch_object($result);
	  $id=$row->rowid;
	 
  }
		    
		
?>
 
<table width="100%"  border="0">
  <tr>
    <th>&nbsp; </th>
  </tr>
  <tr>
    <td><?php if (!empty($id))  echo "<center><img src='viewimg.php?imgid=$id' width=170 Height=170 ></center>"; ?>
&nbsp;    </td>
  </tr>
  <tr>
    <td><?php if (!empty($row->FullName)) echo "<b>Full Name : </b>".$row->title." ".$row->FullName; 
		 
		 if (!empty($row->OtherNames)) echo "<br><b>Preferred Names :</b>".$row->OtherNames; 
		 
		 
		 ?></td>
  </tr>
  <tr>
    <td>&nbsp;<?php if (!empty($row->designation)) echo "<br><b>Designation :</b>".$row->designation; ?></td></tr>
	<tr><td>&nbsp;<?php if (!empty($row->DeptName)) echo "<br><b>DeptName :</b>".$row->DeptName; ?></td></tr>
  </tr>
</table>
<?php
  $d->close();
?>
</body>

</html>



