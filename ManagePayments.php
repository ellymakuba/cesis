<?php

/* $Id: CustomerReceipt.php 3868 2010-09-30 14:53:59Z tim_schofield $ */
/* $Revision: 1.46 $ */
ob_start();
$PageSecurity = 3;
include('includes/session.inc');
$title = _('Manage Payments');
include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc');
$msg='';
echo '<html><body><br /><br /><br />
<table class=enclosed>';
echo "<br><form method='post' action=" . $_SERVER['PHP_SELF'] . '>';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
echo '<tr><td>' . _('Enter Receipt No') . ':<input type="Text" name="searchval"
size=30   maxlength=20></td>
<td><input  type="submit" name="form1" value="Search"></td></tr>';
echo '<tr><th>Action</th><th>Receipt No</th><th>Invoice</th><th>Student</th><th>Amount</th><th>Date</th></tr>';
  if (isset($_GET['pageno'])) {
   $pageno = $_GET['pageno'];
} else {
   $pageno = 1;
}
$sql = "SELECT count(*) FROM debtortrans";
$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
$query_data = DB_fetch_row($result);
$numrows = $query_data[0];

$targetpage = "ManagePayment.php";
$rows_per_page = 25;
$lastpage      = ceil($numrows/$rows_per_page);
$pageno = (int)$pageno;
if ($pageno > $lastpage) {
   $pageno = $lastpage;
} // if
//$SearchString = '%' . str_replace(' ', '%', $_POST['searchval']) . '%';
if (isset($_POST['form1'])){
	$sql = "SELECT dt.*,dm.name as student_name
	FROM debtortrans dt
	LEFT JOIN salesorderdetails so ON dt.transno = so.id
	LEFT JOIN debtorsmaster dm ON so.student_id = dm.debtorno
	WHERE receipt_no='". $_POST['searchval']."'
	ORDER BY dt.id";
	$DbgMsg = _('The SQL that was used to retrieve the information was');
	$ErrMsg = _('Could not check whether the group is recursive because');
	$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
}
else{
    $limit = 'LIMIT ' .($pageno - 1) * $rows_per_page .',' .$rows_per_page;
    $sql = "SELECT debtortrans.*,debtorsmaster.name as student_name
		FROM debtortrans,debtorsmaster,salesorderdetails
		WHERE debtortrans.transno = salesorderdetails.id
		AND salesorderdetails.student_id = debtorsmaster.debtorno
		ORDER BY debtortrans.id DESC $limit";
		$DbgMsg = _('The SQL that was used to retrieve the information was');
    $ErrMsg = _('Could not check whether the group is recursive because');
    $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
	}
		while ($row = DB_fetch_array($result))
		{
			if ($k==1){
			 echo '<tr class="EvenTableRows">';
			 $k=0;
		 } else {
			 $k=1;
			 echo "<tr >";
		 }
			$ovamount=-$row['ovamount']; ?>
			<td><?php
			echo '<a target="_blank"  href="' . $rootpath . '/PDFReceipt.php?BatchNumber=' . $row['transno']. '&ReceiptNumber='.$row['id'].'">'._('Print Receipt').'</a>';
			?></td><?php
		  echo "<td>".$row['receipt_no']."</td>";
		  echo "<td>".$row['transno']."</td>";
		  echo "<td>".$row['student_name']."</td>";
		  echo "<td>".$ovamount."</td>";
		  echo "<td>".$row['trandate']."</td>";

		    echo "</tr>";
		  $j++;
			}
echo "<tr><td>";
if ($pageno == 1) {
   echo "FIRST PREV ";
} else {
   echo "<a href='{$_SERVER['PHP_SELF']}?pageno=1'>FIRST</a> ";
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
