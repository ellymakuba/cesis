<?php

/* $Id: CustomerReceipt.php 3868 2010-09-30 14:53:59Z tim_schofield $ */
/* $Revision: 1.46 $ */
ob_start();
$PageSecurity = 3;
include('includes/session.inc');

$title = _('Supplier Statement');

include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc');

$supplierid = $_REQUEST['SupplierID'];
$msg='';
?>
<html><body><br /><br /><br />
<table width="50%"><form name="payment" action="SupplierInquiry.php" method="post">
<?php
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
$order_total_amount=0;
$sql="SELECT orderno FROM purchorders WHERE supplierno='".$supplierid."'";
$result=DB_query($sql,$db);
while ($row=db_fetch_array($result)){
$OrderTotal=0;
$RecdTotal=0;
$LineItemsSQL = "SELECT purchorderdetails.* FROM purchorderdetails
INNER JOIN purchorders po ON po.orderno=purchorderdetails.orderno
WHERE po.supplierno = '" . $supplierid ."'
AND po.orderno='".$row['orderno']."'";

$LineItemsResult = db_query($LineItemsSQL,$db, $ErrMsg);			
  while ($myrow=db_fetch_array($LineItemsResult)) {

	$OrderTotal += ($myrow['quantityord'] * $myrow['unitprice']);
	$RecdTotal += ($myrow['quantityrecd'] * $myrow['unitprice']);
}
$order_total_amount=$order_total_amount+$OrderTotal;
}			
$sql = "SELECT SUM(ovamount) as totalpayment FROM supptrans WHERE supplierno='".$supplierid."'";

            $DbgMsg = _('The SQL that was used to retrieve the information was');
            $ErrMsg = _('Could not check whether the group is recursive because');

            $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);

            $row = DB_fetch_array($result);
			$suppliertotalpayment = -$row['totalpayment'];
			$totalbalance=$order_total_amount-$suppliertotalpayment;
$sql = "SELECT supplierid,suppname FROM suppliers WHERE supplierid='".$supplierid."'";

            $DbgMsg = _('The SQL that was used to retrieve the information was');
            $ErrMsg = _('Could not check whether the group is recursive because');

            $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);

            $row = DB_fetch_array($result);
			$supplier_id = $row['supplierid'];
			$name = $row['suppname'];
	
?>
<tr><td>Supplier Name:</td><td><?php echo $name  ?></td><td>Total Orders (KSH):</td><td><?php echo number_format($order_total_amount,2)  ?></td></tr>
<tr><td>Supplier Code:</td><td><?php echo $supplier_id  ?></td><td>Total Payments (KSH):</td><td><?php echo number_format($suppliertotalpayment,2)  ?></td></tr>
<tr><td><?php echo $name  ?>'s Invoices</td><td>Supplier Balance (KSH):</td><td><?php echo number_format($totalbalance,2)  ?></td></tr>
<tr><th>Tender ID</th><th>Amount Paid</th><th>Tendered Date</th></tr>
<?php
$sql = "SELECT	
		p.orderno, 
		p.orddate,
		(SELECT sum(st.ovamount) FROM supptrans st where st.transno = p.orderno) As pmt,
		(SELECT pmt) As paid
	FROM 
		purchorders p
	WHERE 
		p.supplierno ='".$supplierid."'
	ORDER BY 
		p.orderno DESC;";

            $DbgMsg = _('The SQL that was used to retrieve the information was');
            $ErrMsg = _('Could not check whether the group is recursive because');
            $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
			while ($row = DB_fetch_array($result))
			{
			 if (($j%2)==1)
		    echo "<tr bgcolor=\"F0F0F0\">";
		  else
		    echo "<tr bgcolor=\"FFFFFF\">";
			$ovamount=-$row['paid'];
		  echo "<td>"."<a href ='" . $rootpath ."/Payments.php?"."&SupplierID=" . $supplierid."&orderno=" . $row['orderno']. "'>". $row['orderno']."</a>"."</td>";
		  echo "<td>".number_format($ovamount,2)."</td>";
		  echo "<td>".$row['orddate']."</td>";
		    echo "</tr>";
		  $j++;
			} ?>
</table>
<table width="50%">
<tr><td><?php echo $name  ?>'s Payments</td></tr>
<tr><th>Tender NO</th><th>Amount Paid</th><th>Date</th></tr>
<?php
$sql = "SELECT * FROM supptrans
		WHERE supplierno='".$supplierid."'
		ORDER BY transno DESC";

            $DbgMsg = _('The SQL that was used to retrieve the information was');
            $ErrMsg = _('Could not check whether the group is recursive because');
            $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
			while ($row = DB_fetch_array($result))
			{
			 if (($j%2)==1)
		    echo "<tr bgcolor=\"F0F0F0\">";
		  else
		    echo "<tr bgcolor=\"FFFFFF\">";
			$ovamount=-$row['ovamount'];
			$balance=$row['totalinvoice']-$ovamount;
		    echo "<td>".$row['transno']."</td>";
		  echo "<td>".number_format($ovamount,2)."</td>";
		  echo "<td>".$row['trandate']."</td>";
		    echo "</tr>";
		  $j++;
			} ?>
			</table><?php
include('includes/footer.inc');
?>
