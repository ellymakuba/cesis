<?php

/* $Revision: 1.17 $ */
/* $Id: CustomerTransInquiry.php 3870 2010-09-30 14:54:21Z tim_schofield $*/

$PageSecurity = 2;

include('includes/session.inc');
$title = _('View Issued Products');
include('includes/header.inc');
echo "<form action='" . $_SERVER['PHP_SELF'] . "' method=post>";
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';


 ?>
<table width="70%" >
<tr><th><font size="4" color="Blue">Date Issued</font></th><th><font size="4" color="Blue">Product</font></th><th><font size="4" color="Blue">Issued To</font></th><th><font size="4" color="Blue">Quantity Issued</font></th><th><font size="4" color="Blue">Quantity Returned</font></th><th><font size="4" color="Blue">Quantity Written Off</font></th><th><font size="4" color="Blue">Balance In Stock</font></th><th><font size="4" color="Blue">Level</font></th><th><font size="4" color="Blue">Return</font></th><th><font size="4" color="Blue">Write Off</font></th></tr>
<?php
 if (isset($_GET['pageno'])) {
   $pageno = $_GET['pageno'];
} else {
   $pageno = 1;
}
$sql = "SELECT count(*) FROM issued_products";
$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
$query_data = DB_fetch_row($result);
$numrows = $query_data[0];
			
$targetpage = "NonReturnedProducts.php";
$rows_per_page = 25;
$lastpage      = ceil($numrows/$rows_per_page);
$pageno = (int)$pageno;
if ($pageno > $lastpage) {
   $pageno = $lastpage;
} // if
$limit = 'LIMIT ' .($pageno - 1) * $rows_per_page .',' .$rows_per_page;	




$sql = "SELECT ip.*,sm.description FROM issued_products ip 
INNER JOIN stockmaster sm ON sm.id=ip.product_id
$limit";

            $DbgMsg = _('The SQL that was used to retrieve the information was');
            $ErrMsg = _('Could not check whether the group is recursive because');
            $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
			$balance=0;
			while ($row = DB_fetch_array($result))
			{
			$QOHResult = DB_query("SELECT quantity
						FROM stockmaster
						WHERE id = '" . $row['product_id']. "'", $db);
		$QOHRow = DB_fetch_row($QOHResult);
		$QOH = $QOHRow[0];
			
			 if (($j%2)==1)
		    echo "<tr bgcolor=\"F0F0F0\">";
		  else
		    echo "<tr bgcolor=\"FFFFFF\">";
		  echo "<td class=\"visible\">".$row['date']."</td>";
		  echo "<td class=\"visible\">".$row['description']."</td>";
		  echo "<td class=\"visible\">".$row['issued_to']."</td>";
		  echo "<td class=\"visible\">".$row['quantity']."</td>";
		  echo "<td class=\"visible\">".$row['quantity_returned']."</td>";
		  echo "<td class=\"visible\">".$row['quantity_written_off']."</td>";
		  echo "<td class=\"visible\">".$QOH."</td>";
		  echo "<td class=\"visible\">".$row['level']."</td>";
		  echo '<td class="visible"><a   href="' .'ReturnProduct.php?SelectedProduct=' . $row['product_id']. '&id='.$row['id'].'">'._('Return').'</a></td>';
		  echo '<td class="visible"><a   href="' .'WriteOffProduct.php?SelectedProduct=' . $row['product_id']. '&id='.$row['id'].'">'._('Write Off').'</a></td>';
		    echo "</tr>";
		  $j++;
			} ?>				
<?php			
if ($pageno == 1) {
   echo "<tr><td>"." FIRST PREV</td> ";
} else {
   echo "<td> <a href='{$_SERVER['PHP_SELF']}?pageno=1'>FIRST</a> ";
   $prevpage = $pageno-1;
   echo " <a href='{$_SERVER['PHP_SELF']}?pageno=$prevpage'>PREV</a></td> ";
}
echo "<td> ( Page $pageno of $lastpage ) </td>";
if ($pageno == $lastpage) {
   echo "<td> NEXT LAST "."</td>";
} else {
   $nextpage = $pageno+1;
   echo "<td> <a href='{$_SERVER['PHP_SELF']}?pageno=$nextpage'>NEXT</a></td> ";
   echo "<td> <a href='{$_SERVER['PHP_SELF']}?pageno=$lastpage'>LAST</a></td></tr> ";
}		
?>
			</table><?php
include('includes/footer.inc');
?>
   
	