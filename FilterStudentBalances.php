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
<tr><th><font size="4" color="Blue">Admission No</font></th><th><font size="4" color="Blue">Name</font></th><th><font size="4" color="Blue">Date</font></th><th><font size="4" color="Blue">Last Paid</font></th><th><font size="4" color="Blue">Balance</font></th><th><font size="4" color="Blue">Percentage Balance</font></th></tr>
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
			
$targetpage = "FilterStudentBalances.php";
$rows_per_page = 25;
$lastpage      = ceil($numrows/$rows_per_page);
$pageno = (int)$pageno;
if ($pageno > $lastpage) {
   $pageno = $lastpage;
} // if
$limit = 'LIMIT ' .($pageno - 1) * $rows_per_page .',' .$rows_per_page;	


$sql = "SELECT 
					debtorsmaster.id as SID, debtorsmaster.debtorno,
					debtorsmaster.name as name, 
					
					(
						SELECT
				            coalesce(sum(invoice_items.totalinvoice),  0) AS total 
				        FROM
				            invoice_items  INNER JOIN
				            salesorderdetails ON (salesorderdetails.id = invoice_items.invoice_id)
				        WHERE  
				            salesorderdetails.student_id  = SID ) as student_total,
	                (
	                    SELECT 
	                        coalesce(-sum(debtortrans.ovamount), 0) AS amount
	                    FROM
	                        debtortrans INNER JOIN
	                        salesorderdetails  ON (salesorderdetails.id = debtortrans.transno)
	                    WHERE 
	                        salesorderdetails.student_id = SID) AS paid,
							
							(
	                    SELECT 
	                        Max(inputdate)
	                    FROM
	                        debtortrans INNER JOIN
	                        salesorderdetails  ON (salesorderdetails.id = debtortrans.transno)
	                    WHERE 
	                        salesorderdetails.student_id = SID) as maxdate,
							
							(
	                    SELECT 
	                         coalesce(-debtortrans.ovamount, 0) AS amount2
	                    FROM
	                        debtortrans INNER JOIN
	                        salesorderdetails  ON (salesorderdetails.id = debtortrans.transno)
	                    WHERE 
	                        salesorderdetails.student_id = SID
							AND inputdate=maxdate) as lastpaid,
							
	                ( select student_total - paid ) AS owing,
					( select  (1-(paid/student_total))*100 ) AS percentage
	
				FROM 
					debtorsmaster
				WHERE grade_level_id='".$_POST['class_id']."'	
	ORDER BY 
		percentage DESC $limit;";

            $DbgMsg = _('The SQL that was used to retrieve the information was');
            $ErrMsg = _('Could not check whether the group is recursive because');
            $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
			$balance=0;
			while ($row = DB_fetch_array($result))
			{
			$percent=number_format($row['percentage'],2);
			
		  echo "<td class=\"visible\">".$row['debtorno']."</td>";
		  echo "<td class=\"visible\">".$row['name']."</td>";
		  echo "<td class=\"visible\">".$row['maxdate']."</td>";
		  echo "<td class=\"visible\">".$row['lastpaid']."</td>";
		  echo "<td class=\"visible\">".$row['owing']."</td>";
		  echo "<td class=\"visible\">".$percent."%"."</td>";
		  $balance=$balance+$row['owing'];
		    echo "</tr>";
		  $j++;
			} ?>
<tr><td><font size="4" color="maroon"> Total Balance </td><td> -</td><td> -</td><td> -</td><td><?php echo number_format($balance,2) ?> </font></td></tr>					
</table><?php 
include('includes/footer.inc');
}
?>
   
	