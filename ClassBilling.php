<?php

/* $Id: CustomerReceipt.php 3868 2010-09-30 14:53:59Z tim_schofield $ */
/* $Revision: 1.46 $ */
ob_start();
$PageSecurity = 2;
include('includes/session.inc');

$title = _('Termly Billing');

include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc');
$msg='';
if ($_POST['Bill']==_('Bill Class'))
{
if (!Is_Date($_SESSION['DateBanked'])){
	$_SESSION['DateBanked']= Date($_SESSION['DefaultDateFormat']);
	 
}
$PeriodNo = GetPeriod($_SESSION['DateBanked'],$db);
$sql = "SELECT term_status
		FROM collegeperiods
		WHERE id='".$_SESSION['period']."'";
		$result = DB_query($sql,$db);		
		$myrow = DB_fetch_array($result);
		$Status=$myrow['term_status'];
if ($Status==1) {
   exit("This class has already been billed for this term. Re-open first...");
} else {  

		$sql = "SELECT ab.* FROM autobilling ab
		INNER JOIN debtorsmaster dm ON dm.class_id=ab.course_id
		WHERE  dm.class_id='".$_SESSION['class']."'
		AND ab.term_id='".$_SESSION['period']."'";
		$result = DB_query($sql,$db);
		$num_rows = DB_num_rows($result);
		if ($num_rows<0 || $num_rows==0) {
   exit("The course fee structure has not been created for this period.");
} else {	
		$sql = "SELECT ab.* FROM autobilling ab
		INNER JOIN debtorsmaster dm ON dm.class_id=ab.course_id
		WHERE  dm.class_id='".$_SESSION['class']."'
		AND ab.term_id='".$_SESSION['period']."'";
		$result = DB_query($sql,$db);		
		$myrow = DB_fetch_array($result);
		$auto_id=$myrow['id'];
		
				
		$sql2 = "SELECT * FROM debtorsmaster
				WHERE class_id='".$_SESSION['class']."'";
				$result2 = DB_query($sql2,$db);
				$student_no=DB_num_rows($result2);
				if($student_no>0)
				{
					while ($myrow2= DB_fetch_array($result2))
					{
		$sql_exist = "SELECT id FROM salesorderdetails
		WHERE period_id='". $_SESSION['period'] ."'
		AND student_id='". $myrow2['debtorno'] ."'";
		$result_exist=DB_query($sql_exist,$db);
		if(DB_fetch_row($result_exist)>0){
		prnMsg(_($myrow2['debtorno']._(' ').'has already been invoiced for this period'),	
		'warn');	
		}
		else{
		$students=$myrow2['debtorno'];
		$sql = "INSERT INTO salesorderdetails ( 	
		student_id,invoice_date,transactiondate,addedby,period_id)
		VALUES ('".$students."',
		'".date('Y-m-d H-i-s')."',
		'" . date('Y-m-d H-i-s'). "',
		'" . trim($_SESSION['UserID']) . "',
		'" . $_SESSION['period'] . "')";
	$DbgMsg = _('The SQL that failed was');
	$ErrMsg = _('Unable to add the quotation line');
	$Ins_LineItemResult = DB_query($sql,$db,$ErrMsg,$DbgMsg,true);
	$sql="SELECT LAST_INSERT_ID()";
	$result = DB_query($sql,$db);
	$myrow = DB_fetch_row($result);
	$id = $myrow[0];
	
	$glquery = "SELECT SUM(amount) as total FROM autobilling_items 
	WHERE autobilling_id='".$auto_id."'";
	$glresult = DB_query($glquery,$db);
	$glmyrow = DB_fetch_array($glresult);
	$glamount = $glmyrow['total'];	
	mysql_connect("localhost", "elly", "masinde");
	mysql_select_db("cmc") or die(mysql_error());
	$query = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
			VALUES (10,
				'".$id."',
				'".date('Y-m-d H-i-s')."',
				'" . $PeriodNo . "',
				1100,
				'".$glamount."')";
	$result = mysql_query($query);
	
	$query = "INSERT INTO gltrans ( type,
							typeno,
							trandate,
							periodno,
							account,
							amount)
										VALUES (10,
										'".$id."',
										'".date('Y-m-d H-i-s')."',
										'" . $PeriodNo . "',
										1,
										'".-$glamount."'
												)";
	$result = mysql_query($query);
	mysql_close($result);	
	
	$sql3 = "SELECT * FROM autobilling_items 
		WHERE autobilling_id='".$auto_id."'";
		$result3 = DB_query($sql3,$db);		
	
	while($myrow3 = DB_fetch_array($result3))
	{	
	$sql = "INSERT INTO invoice_items ( invoice_id,product_id,
															qty,
															unitprice,
															totalinvoice,
															priority
															)
										VALUES ('".$id."',
												'".$myrow3['product_id']."',
												1,
												'".$myrow3['amount']."',
												'".$myrow3['amount']."',
												'".$myrow3['priority']."'
												)";
	$DbgMsg = _('The SQL that failed was');
	$ErrMsg = _('Unable to add the quotation line');
	$Ins_LineItemResult = DB_query($sql,$db,$ErrMsg,$DbgMsg,true);
	
	
	}				
					
		}
	}
}		
	
$sql = "UPDATE collegeperiods SET term_status=1
WHERE id = '".$_SESSION['period']."'";
$ErrMsg = _('The record could not be updated because');
$DbgMsg = _('The SQL that was used to update  was');
$result = DB_query($sql, $db, $ErrMsg, $DbgMsg);
exit("Class has been succesfully billed...");
		}
	}
}
echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . '>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '<table border="1">';
	
echo '<tr><td>' . _('Period') . ":</td>
		<td><select name='period'>";
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

	DB_data_seek($result,0);
	echo '</select></td></tr>';
echo '<tr><td>' . _('Class') . ":</td>
		<td><select name='student_class'>";
		echo '<OPTION SELECTED VALUE=0>' . _('Select Class');
		$sql="SELECT cl.id,cl.class_name,c.course_name,gl.grade_level FROM classes cl 
		INNER JOIN courses c ON c.id=cl.course_id
		INNER JOIN gradelevels gl ON gl.id=cl.grade_level_id";
		$result=DB_query($sql,$db);
		while ($myrow = DB_fetch_array($result)) {
	echo '<option value='. $myrow['id'] . '>' . $myrow['class_name'];
		} //end while loop
		DB_data_seek($result,0);
	echo '</select></td></tr></table>';
		echo '<table border="1">';
echo "<br><div class='centre'><input  type='Submit' name='submit' value='" . _('Submit') . "'>&nbsp;<input  type=submit action=RESET VALUE='" . _('Reset') . "'></div>";	

if (isset($_POST['submit'])) {
$_SESSION['class'] = $_POST['student_class'];
$_SESSION['period'] = $_POST['period'];

echo "<TABLE BORDER=2><TR><td><INPUT TYPE=SUBMIT NAME='Bill' VALUE='" . _('Bill Class') . "'><INPUT TYPE=SUBMIT NAME='open' VALUE='" . _('Open Period') . "'></td></tr></table></BR>";

$sql2="SELECT t.title,cp.* FROM terms t
	INNER JOIN collegeperiods cp ON cp.term_id=t.id
	WHERE cp.id='".$_SESSION['period'] ."'";
	$result2=DB_query($sql2,$db);
	$myrow2 = DB_fetch_array($result2);
	$term_name=$myrow2['title'];
$sql="SELECT cl.*,m.month_name FROM classes cl
	INNER JOIN months m ON m.id=cl.month_id
	WHERE cl.id='".$_SESSION['class'] ."'";
	$result=DB_query($sql,$db);
	$myrow = DB_fetch_array($result);
?>
<table width="640" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="180" valign="top"> 
	
      <table width="90%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolordark="#CCCCCC" bordercolorlight="#CCCCCC" bgcolor="#F2F2F2">
        <tr bgcolor="#F4F4F4"> 
          <td height="30" width="26%"> 
            <div align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1">Month
              :</font></div>
          </td>
          <td height="30" width="74%"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1" color="#000066"><b><?php echo $myrow['month_name']; ?></b></font></td>
        </tr>
        <tr bgcolor="#F4F4F4"> 
          <td height="30" width="26%"> 
            <div align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1">Term 
              :</font></div>
          </td>
          <td height="30" width="74%"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1" color="#000066"><b><?php echo $term_name; ?></b></font></td>
        </tr>
        <tr bgcolor="#F4F4F4"> 
          <td height="30" width="26%"> 
            <div align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1">Start Date 
              :</font></div>
          </td>
          <td height="30" width="74%"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1" color="#000066"><b><?php echo $myrow2['start_date'] ?></a></b></font></td>
        </tr>
        <tr bgcolor="#F4F4F4"> 
          <td height="30" width="26%"> 
            <div align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1">End Date 
              :</font></div>
          </td>
          <td height="30" width="74%"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1" color="#000066"><b><?php echo $myrow2['end_date']; ?></a></b></font></td>
        </tr>
        <tr bgcolor="#F4F4F4"> 
          <td height="30" width="26%"> 
            <div align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1">Academic Year 
              :</font></div>
          </td>
          <td height="30" width="74%"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1" color="#000066"><b><?php echo $myrow2['year']; ?></a></b></font></td>
        </tr>
        
        <tr bgcolor="#F4F4F4"> 
          <td height="30" width="26%"> 
            <div align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1">Period Status
              :</font></div>
          </td>
          <td height="30" width="74%" bgcolor="#F4F4F4"><font face="Verdana, Arial, Helvetica, sans-serif" size="-1"><b><font color="#000066"><?php echo $myrow2['status']; ?></font></b></font></td>
        </tr>
      </table>
	  
    </td>
  </tr>

</table>
<?php	
}
include('includes/footer.inc');
?>
