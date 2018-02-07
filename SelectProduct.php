<?php

/* $Id: CustomerReceipt.php 3868 2010-09-30 14:53:59Z tim_schofield $ */
/* $Revision: 1.46 $ */
ob_start();
$PageSecurity = 2;
include('includes/session.inc');

$title = _('Manage Products');

include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc');
$msg='';
echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . '>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '<table class="selection"> ';
echo '<tr><td class="visible">' . _('Search Product Code/Name') . ':<input type="Text" name="searchval" 
  size=30   maxlength=20></td>
		<td><input  type="submit" name="form1" value="submit"></td></tr>';
	
    echo '<tr><th>' . _('Code') . ':</th>
		<th>' . _('Name') . ':</th>
		<th>' . _('Cost') . ':</th>
		<th>' . _('units') . ':</th>
		<th>' . _('Consumable') . ':</th>
		<th>' . _('Available Quantity') . ':</th>
		<th>' . _('Issue') . ':</th>
		<th>' . _('Edit') . ':</th>';
		
  if (isset($_GET['pageno'])) {
   $pageno = $_GET['pageno'];
} else {
   $pageno = 1;
}
$sql = "SELECT count(*) FROM debtorsmaster";
$result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
$query_data = DB_fetch_row($result);
$numrows = $query_data[0];
			
$targetpage = "SelectProduct.php";
$rows_per_page = 25;
$lastpage      = ceil($numrows/$rows_per_page);
$pageno = (int)$pageno;
if ($pageno > $lastpage) {
   $pageno = $lastpage;
} // if
$limit = 'LIMIT ' .($pageno - 1) * $rows_per_page .',' .$rows_per_page;	
$SearchString = '%' . str_replace(' ', '%', $_POST['searchval']) . '%';
if (isset($_POST['form1'])){
$sql = "SELECT * FROM stockmaster
		WHERE stockid LIKE  '". $SearchString."'
		OR description LIKE  '". $SearchString."'
		";

            $DbgMsg = _('The SQL that was used to retrieve the information was');
            $ErrMsg = _('Could not check whether the group is recursive because');
            $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
			
			
}		
else{
$sql = "SELECT * FROM stockmaster
		WHERE categoryid !=2
		ORDER BY description 
		$limit";

            $DbgMsg = _('The SQL that was used to retrieve the information was');
            $ErrMsg = _('Could not check whether the group is recursive because');
            $result = DB_query($sql,$db,$ErrMsg,$DbgMsg);
}			
			while ($row = DB_fetch_array($result))
			{
			 if (($j%2)==1)
		    echo "<tr bgcolor=\"F0F0F0\">";
		  else
		    echo "<tr bgcolor=\"FFFFFF\">";
			 
			echo "<td class=\"visible\">".$row['stockid']."</td>";
		  	echo "<td class=\"visible\">".$row['description']."</td>";
			echo "<td class=\"visible\">".$row['actualcost']."</td>";
			echo "<td class=\"visible\">".$row['units']."</td>";
			echo "<td class=\"visible\">".$row['consumable']."</td>";
			echo "<td class=\"visible\">".$row['quantity']."</td>";
			echo '<td class="visible"><a  href="' .'IssueProduct.php? &SelectedProduct=' . $row['id'].'">'._('Issue').'</a></td>';
			echo '<td class="visible"><a href="' . $rootpath .'/Stocks.php?&SelectedProduct=' . $row['id'] . '">' . _('Edit') . '</a></td>';
		
		    echo "</tr>";
		  $j++;
			}
			

if ($pageno == 1) {
   echo "<tr><td>"." FIRST PREV ";
} else {
   echo " <a href='{$_SERVER['PHP_SELF']}?pageno=1'>FIRST</a> ";
   $prevpage = $pageno-1;
   echo " <a href='{$_SERVER['PHP_SELF']}?pageno=$prevpage'>PREV</a> ";
}
echo " ( Page $pageno of $lastpage ) ";
if ($pageno == $lastpage) {
   echo " NEXT LAST "."</td></tr>";
} else {
   $nextpage = $pageno+1;
   echo " <a href='{$_SERVER['PHP_SELF']}?pageno=$nextpage'>NEXT</a> ";
   echo " <a href='{$_SERVER['PHP_SELF']}?pageno=$lastpage'>LAST</a> ";
}
			
include('includes/footer.inc');
?>
