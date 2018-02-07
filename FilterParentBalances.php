<?php

/* $Revision: 1.17 $ */
/* $Id: CustomerTransInquiry.php 3870 2010-09-30 14:54:21Z tim_schofield $*/

$PageSecurity = 2;

include('includes/session.inc');
$title = _('Student Balance');
include('includes/header.inc');

if(!isset($_POST['PrintPDF'])){
echo '<FORM METHOD="POST" ACTION="' . $_SERVER['PHP_SELF'] . '?' . SID . '">';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
echo '<CENTER><TABLE><TR><TD>' . _('Class:') . '</TD><TD><SELECT Name="class_id">';
		DB_data_seek($result, 0);
		$result = DB_query('SELECT * FROM gradelevels',$db);
while ($myrow = DB_fetch_array($result)) {
	if ($myrow['id']==$_POST['class_id']) {
		echo '<option selected VALUE=';
	} else {
		echo '<option VALUE=';
	}
	echo $myrow['id'] . '>' . $myrow['grade_level'];
} //end while loop
	echo '</SELECT></TD></TR>';
	echo "</TABLE>";
	echo "<P><CENTER><INPUT TYPE='Submit' NAME='PrintPDF' VALUE='" . _('View') . "'>";

	include('includes/footer.inc');
}	
if(isset($_POST['class_id']) && isset($_POST['PrintPDF'])){
$result = DB_query("SELECT grade_level FROM gradelevels WHERE id='".$_POST['class_id']."'",$db);
$myrow = DB_fetch_array($result);
$grade_level=$myrow['grade_level'];
 ?>
<table width="70%" >
<?php
	echo '<FORM METHOD="POST" ACTION="' . $_SERVER['PHP_SELF'] . '?' . SID . '">';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
?>
<tr><th colspan="6"><font size="6" color="maroon">Fee balance for <?php echo $grade_level ?> printed on <?php echo date('Y-m-d H-i-s') ?></font></th></tr>
<tr><th><font size="4" color="Blue">Name</font></th><th><font size="4" color="Blue">Mobile No</font></th><th><font size="4" color="Blue">Date</font></th><th><font size="4" color="Blue">Last Paid</font></th><th><font size="4" color="Blue">Balance</font></th><th><font size="4" color="Blue">Percentage Paid</font></th></tr>
<?php
 if (isset($_GET['pageno'])) {
   $pageno = $_GET['pageno'];
} else {
   $pageno = 1;
}
$sql = "SELECT count(*) FROM debtorsmaster";
$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
$query_data = DB_fetch_row($result);
$numrows = $query_data[0];
			
$targetpage = "FilterParentBalances.php";
$rows_per_page = 25;
$lastpage      = ceil($numrows/$rows_per_page);
$pageno = (int)$pageno;
if ($pageno > $lastpage) {
   $pageno = $lastpage;
} // if
$limit = 'LIMIT ' .($pageno - 1) * $rows_per_page .',' .$rows_per_page;	


$sql = "SELECT dm.gmobileno as mobileno,dm.id as SID, dm.debtorno,dm.gname as name
	FROM debtorsmaster dm
	WHERE grade_level_id='".$_POST['class_id']."'
	AND gmobileno>0	
	ORDER BY gname";

            $DbgMsg = _('The SQL that was used to retrieve the information was');
            $ErrMsg = _('Could not check whether the group is recursive because');
            $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
			$balance=0;
			$balance2=0;
			while ($row = DB_fetch_array($result))
			{
			$sqlpaid="SELECT -SUM(ovamount) as totalpayment 
			FROM debtortrans 
			INNER JOIN debtorsmaster d ON d.id=debtortrans.debtorno
			WHERE d.gmobileno='".$row['mobileno']."'";
			$resultpaid = DB_query($sqlpaid,$db);
			$rowpaid = DB_fetch_array($resultpaid);
			$paid=$rowpaid['totalpayment'];
			
			$sqlpaid="SELECT Max(inputdate) as date FROM
	                    debtortrans INNER JOIN
	                    salesorderdetails  ON (salesorderdetails.id = debtortrans.transno)
						INNER JOIN debtorsmaster d ON d.id=salesorderdetails.student_id
	                    WHERE 
	                        d.gmobileno='".$row['mobileno']."'";
			$resultpaid = DB_query($sqlpaid,$db);
			$rowpaid = DB_fetch_array($resultpaid);
			$date=$rowpaid['date'];
			
			$sqlpaid="SELECT 
	                         coalesce(-debtortrans.ovamount, 0) AS amount2
	                    FROM
	                        debtortrans INNER JOIN
	                        salesorderdetails  ON (salesorderdetails.id = debtortrans.transno)
							INNER JOIN debtorsmaster d ON d.id=salesorderdetails.student_id
	                    WHERE 
	                       d.gmobileno='".$row['mobileno']."'
							AND inputdate='$date'";
			$resultpaid = DB_query($sqlpaid,$db);
			$rowpaid = DB_fetch_array($resultpaid);
			$lastpaid=$rowpaid['amount2'];
			
			
			
			$sqlpaid="SELECT SUM(totalinvoice) as total FROM invoice_items,salesorderdetails 
			INNER JOIN debtorsmaster dm ON dm.id=salesorderdetails.student_id
			AND dm.gmobileno='".$row['mobileno']."'
			WHERE salesorderdetails.id=invoice_items.invoice_id";
			$resultpaid = DB_query($sqlpaid,$db);
			$rowpaid = DB_fetch_array($resultpaid);
			$invoiced=$rowpaid['total'];
			$balance=$invoiced-$paid;	
				
			$percent=number_format($paid/$invoiced*100,2);
			
		  echo "<td class=\"visible\">".$row['name']."</td>";
		  echo "<td class=\"visible\">".$row['mobileno']."</td>";
		  echo "<td class=\"visible\">".$date."</td>";
		  echo "<td class=\"visible\">".$lastpaid."</td>";
		  echo "<td class=\"visible\">".$balance."</td>";
		  echo "<td class=\"visible\">".$percent."%"."</td>";
		  $balance2=$balance2+$balance;
		    echo "</tr>";
		  $j++;
			} ?>
<tr><td><font size="4" color="maroon"> Total Balance </td><td> -</td><td> -</td><td> -</td><td><?php echo number_format($balance2,2) ?> </font></td></tr>					
</table><?php 
include('includes/footer.inc');
}
?>
   
	