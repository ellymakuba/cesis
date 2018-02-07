<?php
$PageSecurity = 5;
include('includes/session.inc');
$title = _('Manage Products');
include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc'); ?>
<SCRIPT LANGUAGE="javascript">
$(document).ready(function(){
 $("#product").autocomplete({
 source:function(request,response){
 	$.getJSON("searchProduct.php?term="+request.term,function(result){
	 response($.map(result,function(item){
	 	return{
		id:item.stockid,
		value:item.description
		}
	 }))
	})
 },
 minLength:3,
  messages: {
        noResults: '',
        results: function() {}
    }
  });
  })
 </script> <?php
echo '<p class="page_title_text">' . ' ' . $title.'</p>';
if (isset($_GET['itemID'])) {
	$itemID=$_GET['itemID'];
} elseif (isset($_POST['itemID'])) {
	$itemID=$_POST['itemID'];
}
if (isset($Errors)) {
	unset($Errors);
}

$Errors = array();
if (isset($_POST['Submit']))
{
       if ($_POST['description']=="")
        {
         prnMsg( _('Item description cannot be empty'),'error');
          $InputError=1;
        }

		 if (strlen($_POST['description'])>0 && !isset($itemID))
        {
    			$sql="SELECT COUNT(description) as numberOfRows FROM stockmaster WHERE description LIKE '".$_POST['description']."'";
    			$result=DB_query($sql,$db);
    			$row=DB_fetch_row($result);
    			if($row[0] > 0)
    			{
    				prnMsg( _('An item with the same name already exists'),'error');
    			    $InputError=1;
    			}
          $sql="SELECT COUNT(stockid) as numberOfRows FROM stockmaster WHERE stockid LIKE '".$_POST['product_id']."'";
          $result=DB_query($sql,$db);
          $row=DB_fetch_row($result);
          if($row[0] > 0)
          {
            prnMsg( _('An item with the same ID already exists'),'error');
              $InputError=1;
          }
        }
       	if ($InputError != 1){
       		if (!isset($_POST['New'])) {
       			$sql = "UPDATE stockmaster SET
       			categoryid='" . DB_escape_string($_POST['categoryID']) . "',
       			description='" . DB_escape_string($_POST['description']) . "',
            discontinued='" . DB_escape_string($_POST['priority']) . "',
       			actualcost='" . DB_escape_string($_POST['sellingPrice']) . "'
            WHERE stockid = '".$itemID."'";
       			$ErrMsg = _('The item could not be updated because');
       			$DbgMsg = _('The SQL that was used for update  was');
       			$result = DB_query($sql, $db, $ErrMsg, $DbgMsg);
       			prnMsg(_('product') . ' ' . $_POST['description'] . ' ' . _('has been updated'),'success');
       		} else { //its a new employee
              			$sql = "INSERT INTO stockmaster (stockid,categoryid,description,actualcost,discontinued)
       			VALUES ('".DB_escape_string($_POST['product_id'])."','".DB_escape_string($_POST['categoryID']) ."'
            ,'".DB_escape_string($_POST['description']) ."',
				    '" . DB_escape_string($_POST['sellingPrice']) ."',
            '" . DB_escape_string($_POST['priority']) ."')";
       			$ErrMsg = _('The item') . ' ' . $_POST['description'] . ' ' . _('could not be added because');
       			$DbgMsg = _('The SQL that was used to insert the product but failed was');
       			$result = DB_query($sql, $db, $ErrMsg, $DbgMsg);
       			prnMsg(_('The product') . ' ' . $_POST['description']. ' ' . _('has been added to the database'),'success');
       			unset ($itemID);
       			unset($_POST['categoryID']);
            unset($_POST['product_id']);
       			unset($_POST['description']);
       			unset($_POST['sellingPrice']);
            unset($_POST['priority']);
       		}

       	} else {
 			prnMsg(_('Validation failed') . _('no updates or deletes took place'),'warn');
 		}

} elseif (isset($_POST['delete'])) {
	$CancelDelete = 0;
	$sql = "SELECT product_id FROM invoice_items
	WHERE product_id='" . $itemID. "'";
	$Details = DB_query($sql,$db);
	if(DB_num_rows($Details)>0)
	{
	$CancelDelete = 1;
	exit("This item has been invoiced and so cannot be deleted..");
	}
	if ($CancelDelete == 0) {
		$sql="DELETE FROM stockmaster WHERE stockid='".$itemID."'";
		$result = DB_query($sql, $db);
		prnMsg(_('product') . ' ' . $itemID. ' ' . _('has been deleted'),'success');
		unset($_POST['product_id']);
    unset($_POST['categoryID']);
    unset($_POST['description']);
    unset($_POST['sellingPrice']);
	}
}
if (!isset($itemID)) {
echo "<form method='post'  action=" . $_SERVER['PHP_SELF'] .  '>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo "<INPUT TYPE='hidden' NAME='New' VALUE='Yes'>";
	echo '<CENTER><table class="enclosed">';
	echo '<TR><TD class="visible">' . _('Product ID') . ":</TD><TD>
  <INPUT TYPE='text' NAME='product_id' value='".$_POST['product_id']."' SIZE=50></TD></tr>";
  echo '<TR><TD class="visible">' . _('Description') . ":</TD><TD>
  <INPUT TYPE='text' NAME='description' value='".$_POST['description']."' SIZE=50></TD></tr>";
  echo '<TR><TD class="visible">' . _('Priority') . ":</TD><TD>
  <INPUT TYPE='text' NAME='priority' value='".$_POST['priority']."' SIZE=50></TD></tr>";
	echo '<tr><td class="visible">' . _(' Category') . ":</td>
	<td class=\"visible\"><select name='categoryID'>";
	echo '<OPTION SELECTED VALUE=0>' . _('Select Category');
	$sql="SELECT * FROM stockcategory";
	$result=DB_query($sql,$db);
	while ($myrow = DB_fetch_array($result))
	 {
      echo '<option value='. $myrow['id'] . '>'.$myrow['categorydescription'];
	} //end while loop
	echo '</select></td></tr>';
	echo '<TR><TD class="visible">' . _('Amount') . ":</TD><TD class='visible'><input type='Text' name='sellingPrice' /></TD></TR>";
	echo "</TABLE><p><CENTER><INPUT TYPE='Submit' NAME='Submit' VALUE='" . _('Insert New Product') . "'>";
	echo '</FORM>';

	echo '<table class="enclosed">';
	echo '<tr><td style="margin-left:55%;">Type Item Name</td><td><input type="text"
	name="product" id="product" size="50" placeholder="Type any three characters to display item" /></td>
	<div id="result"></div>
	</div>';
	echo '<td><input type="submit" name="productSearch" value="search Product" /></td></tr>';
	echo "<tr>";
	echo "<th style='width:50%;'>" . _('Description') . "</th>";
	echo "<th>" . _('Amount') . "</th>";
	echo "<th>" . _('Category') . "</th>";
	echo "</tr>";

	$totalValue=0;

	if(isset($_POST['productSearch'])){
	$SearchString =$_POST['product'];
	$sql="SELECT sm.*,sc.categorydescription as category FROM stockmaster sm
	INNER JOIN stockcategory sc ON sc.id=sm.categoryid
	where sm.description LIKE '$SearchString'
  ORDER BY sm.description";
	$ErrMsg = _('There is a problem selecting the record to display because');
	$result = DB_query($sql,$db,$ErrMsg);
	if (DB_num_rows($result)==0)
	{
		prnMsg(_('There is no product marching the search'),'info');
	}
	else{
			while ($myrow = DB_fetch_array($result))
			{
				printf("<td>%s</td><td>%s</td><td>%s</td>
				<td><a href=\"%s&itemID=%s\">" . _('Edit') . "</a></td>
				</tr>",
				$myrow['description'],
				number_format($myrow['actualcost'],2),
				$myrow['category'],
				$_SERVER['PHP_SELF']  . "?" . SID,$myrow['stockid'],
				urlencode($myrow['title']));
			}
		}

    }
	else
	{
		$sql="SELECT sm.*,sc.categorydescription as category FROM stockmaster sm
    INNER JOIN stockcategory sc ON sc.id=sm.categoryid
    ORDER BY sm.description";
		$result = DB_query($sql,$db);
		while ($myrow = DB_fetch_array($result))
		 {
			printf("<td>%s</td><td>%s</td><td>%s</td>
				<td><a href=\"%s&itemID=%s\">" . _('Edit') . "</a></td>
				</tr>",
				$myrow['description'],
				number_format($myrow['actualcost'],2),
				$myrow['category'],
				$_SERVER['PHP_SELF']  . "?" . SID,$myrow['stockid'],
				urlencode($myrow['title']));
		} //END WHILE LIST LOOP

	}
	echo '</table>';
}
else {
	echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . '>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '<table class="enclosed">';
	if (!isset($_POST['New'])) {
		$sql = "SELECT * FROM stockmaster WHERE stockid = '$itemID'";
		$result = DB_query($sql, $db);
		$myrow = DB_fetch_array($result);
		$_POST['categoryID'] = $myrow['categoryid'];
		$_POST['description'] = $myrow['description'];
    $_POST['priority'] = $myrow['discontinued'];
		$_POST['sellingPrice'] = $myrow['actualcost'];
		}
		else {
		// its a new employee  being added
		echo "<INPUT TYPE=HIDDEN NAME='New' VALUE='Yes'>";
		}
	echo "<tr><td>Product ID</td><td><INPUT TYPE='text' NAME='itemID' VALUE='$itemID' readonly></td></tr>";
	echo '<TR><TD>' . _('Description') . ":</TD><TD><INPUT TYPE='text' NAME='description'  size=100
	value='" . $_POST['description'] . "'></TD></tr>";
  echo '<TR><TD>' . _('Priority') . ":</TD><TD><INPUT TYPE='text' NAME='priority'  size=100
	value='" . $_POST['priority'] . "'></TD></tr>";
	echo '<tr><td>' . _('Category') . ":</td><td ><select name='categoryID'>";
	$sql="SELECT * FROM stockcategory";
	$result=DB_query($sql,$db);
	while ($myrow = DB_fetch_array($result))
	 {
	   if(isset($_POST['categoryID']) and $myrow['id']==$_POST['categoryID'])
	    {
			echo '<OPTION SELECTED VALUE="'.$myrow['id'] . '">'.$myrow['categorydescription'];
		}
		else
		{
		   echo '<OPTION  VALUE="'.$myrow['id'] . '">'.$myrow['categorydescription'];
		}
      //echo  $myrow['id'] . '>'.$myrow['categorydescription'];
	} //end while loop
	echo '</select></td></tr>';
	echo '<TR><TD class="visible">' . _('Amount Price') . ":</TD><TD class='visible'><input type='Text' name='sellingPrice'
	value='".$_POST['sellingPrice']."' /></TD></TR>";

	if (isset($_POST['New'])) {
		echo "</TABLE><P><CENTER><INPUT TYPE='Submit' NAME='Submit' VALUE='" . _('Insert New Item') . "'></FORM></br>";
	}
	else {

		echo "</TABLE><P><CENTER><INPUT TYPE='Submit' NAME='Submit' VALUE='" . _('Update Item') . "'></FORM></br>";
		//echo "<INPUT TYPE='Submit' NAME='delete' VALUE='" . _('Delete Item') . "' onclick=\"return confirm('" . _('Are you sure you wish to delete this item?') . "');\"></FORM></br>";
	}
  echo '</table>';

} // end of main ifs

include('includes/footer.inc');
?>
