<?php
/* $Id: PO_SelectPurchOrder.php 3944 2010-09-30 15:19:37Z tim_schofield $*/
$PageSecurity = 2;
include ('includes/session.inc');
$title = _('Search Tenders');
include ('includes/header.inc');
echo '<p class="page_title_text"><img src="' . $rootpath . '/css/' . $theme . '/images/magnifier.png" title="' . _('Tenders') . '" alt="">' . ' ' . _('Purchase Orders') . '';
if (isset($_GET['SelectedStockItem'])) {
	$SelectedStockItem = $_GET['SelectedStockItem'];
} elseif (isset($_POST['SelectedStockItem'])) {
	$SelectedStockItem = $_POST['SelectedStockItem'];
}
if (isset($_GET['OrderNumber'])) {
	$OrderNumber = $_GET['OrderNumber'];
} elseif (isset($_POST['OrderNumber'])) {
	$OrderNumber = $_POST['OrderNumber'];
}
if (isset($_GET['SelectedSupplier'])) {
	$SelectedSupplier = $_GET['SelectedSupplier'];
} elseif (isset($_POST['SelectedSupplier'])) {
	$SelectedSupplier = $_POST['SelectedSupplier'];
}
echo '<form action="' . $_SERVER['PHP_SELF'] . '?' . SID . '" method=post>';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
if (isset($_POST['ResetPart'])) {
	unset($SelectedStockItem);
}
if (isset($OrderNumber) && $OrderNumber != "") {
	if (!is_numeric($OrderNumber)) {
		prnMsg(_('The Order Number entered') . ' <U>' . _('MUST') . '</U> ' . _('be numeric'), 'error');
		unset($OrderNumber);
	} else {
		echo _('Order Number') . ' - ' . $OrderNumber;
	}
} else {
	if (isset($SelectedSupplier)) {
		echo _('For supplier') . ': ' . $SelectedSupplier . ' ' . _('and') . ' ';
		echo '<input type=hidden name="SelectedSupplier" value=' . $SelectedSupplier . '>';
	}
}
if (isset($_POST['SearchParts'])) {
	if ($_POST['Keywords'] AND $_POST['StockCode']) {
		prnMsg(_('Stock description keywords have been used in preference to the Stock code extract entered'), 'info');
	}
	if ($_POST['Keywords']) {
		//insert wildcard characters in spaces
		$SearchString = '%' . str_replace(' ', '%', $_POST['Keywords']) . '%';
		$SQL = "SELECT stockmaster.stockid,
				stockmaster.description,
				SUM(locstock.quantity) as qoh,
				stockmaster.units,
				SUM(purchorderdetails.quantityord-purchorderdetails.quantityrecd) AS qord
			FROM stockmaster INNER JOIN locstock
			ON stockmaster.stockid = locstock.stockid INNER JOIN purchorderdetails
			ON stockmaster.stockid=purchorderdetails.itemcode
			WHERE purchorderdetails.completed=1
			AND stockmaster.description LIKE '" . $SearchString ."'
			AND stockmaster.categoryid='" . $_POST['StockCat'] . "'
			GROUP BY stockmaster.stockid,
				stockmaster.description,
				stockmaster.units
			ORDER BY stockmaster.stockid";
	} elseif ($_POST['StockCode']) {
		$SQL = "SELECT stockmaster.stockid,
				stockmaster.description,
				SUM(locstock.quantity) AS qoh,
				SUM(purchorderdetails.quantityord-purchorderdetails.quantityrecd) AS qord,
				stockmaster.units
			FROM stockmaster INNER JOIN locstock
				ON stockmaster.stockid = locstock.stockid
				INNER JOIN purchorderdetails ON stockmaster.stockid=purchorderdetails.itemcode
			WHERE purchorderdetails.completed=1
			AND stockmaster.stockid LIKE '%" . $_POST['StockCode'] . "%'
			AND stockmaster.categoryid='" . $_POST['StockCat'] . "'
			GROUP BY stockmaster.stockid,
				stockmaster.description,
				stockmaster.units
			ORDER BY stockmaster.stockid";
	} elseif (!$_POST['StockCode'] AND !$_POST['Keywords']) {
		$SQL = "SELECT stockmaster.stockid,
				stockmaster.description,
				SUM(locstock.quantity) AS qoh,
				stockmaster.units,
				SUM(purchorderdetails.quantityord-purchorderdetails.quantityrecd) AS qord
			FROM stockmaster INNER JOIN locstock ON stockmaster.stockid = locstock.stockid
				INNER JOIN purchorderdetails ON stockmaster.stockid=purchorderdetails.itemcode
			WHERE purchorderdetails.completed=1
			AND stockmaster.categoryid='" . $_POST['StockCat'] . "'
			GROUP BY stockmaster.stockid,
				stockmaster.description,
				stockmaster.units
			ORDER BY stockmaster.stockid";
	}
	$ErrMsg = _('No stock items were returned by the SQL because');
	$DbgMsg = _('The SQL used to retrieve the searched parts was');
	$StockItemsResult = DB_query($SQL, $db, $ErrMsg, $DbgMsg);
}
/* Not appropriate really to restrict search by date since user may miss older
* ouststanding orders
* $OrdersAfterDate = Date("d/m/Y",Mktime(0,0,0,Date("m")-2,Date("d"),Date("Y")));
*/
if (!isset($OrderNumber) or $OrderNumber == "") {
	echo '<table class=selection><tr><td>';
	if (isset($SelectedStockItem)) {
		echo _('For the part') . ':<b>' . $SelectedStockItem . '</b> ' . _('and') . ' <input type=hidden name="SelectedStockItem" value="' . $SelectedStockItem . '">';
	}
	echo _('Order Number') . ': <input type=text name="OrderNumber" maxlength=8 size=9> ' . _('Into Stock Location') . ':<select name="StockLocation"> ';
	$sql = "SELECT loccode, locationname FROM locations";
	$resultStkLocs = DB_query($sql, $db);
	while ($myrow = DB_fetch_array($resultStkLocs)) {
		if (isset($_POST['StockLocation'])) {
			if ($myrow['loccode'] == $_POST['StockLocation']) {
				echo '<option selected Value="' . $myrow['loccode'] . '">' . $myrow['locationname'];
			} else {
				echo '<option Value="' . $myrow['loccode'] . '">' . $myrow['locationname'];
			}
		} elseif ($myrow['loccode'] == $_SESSION['UserStockLocation']) {
			echo '<option selected Value="' . $myrow['loccode'] . '">' . $myrow['locationname'];
		} else {
			echo '<option Value="' . $myrow['loccode'] . '">' . $myrow['locationname'];
		}
	}
	echo '</select> <input type=submit name="SearchOrders" value="' . _('Search Purchase Orders') . '"></td></tr></table>';
}

echo '</select>';
echo '</table><br><br>';
if (isset($StockItemsResult)) {
	echo '<table cellpadding=2 colspan=7 class=selection>';
	$TableHeader = '<tr><td class="tableheader">' . _('Code') . '</td>
				<td class="tableheader">' . _('Description') . '</td>
				<td class="tableheader">' . _('On Hand') . '</td>
				<td class="tableheader">' . _('Orders') . '<br>' . _('Outstanding') . '</td>
				<td class="tableheader">' . _('Units') . '</td>
			</tr>';
	echo $TableHeader;
	$j = 1;
	$k = 0; //row colour counter
	while ($myrow = DB_fetch_array($StockItemsResult)) {
		if ($k == 1) {
			echo '<tr bgcolor="#CCCCCC">';
			$k = 0;
		} else {
			echo '<tr bgcolor="#EEEEEE">';
			$k = 1;
		}
		echo "<td><input type=submit name='SelectedStockItem' value='" . $myrow['stockid'] . "'</td>
				<td>" . $myrow['description'] . "</td>
			<td class=number>" . $myrow['qoh'] . "</td>
			<td class=number>" . $myrow['qord'] . "</td>
			<td>" . $myrow['units'] . "</td>
			</tr>";
		$j++;
		if ($j == 12) {
			$j = 1;
			echo $TableHeader;
		}
		//end of page full new headings if

	}
	//end of while loop
	echo '</table>';
}
//end if stock search results to show
else {
	//figure out the SQL required from the inputs available
	if (isset($OrderNumber) && $OrderNumber != "") {
		$SQL = "SELECT purchorders.orderno,
				suppliers.suppname,
				purchorders.orddate,
				purchorders.initiator,
				purchorders.requisitionno,
				purchorders.allowprint,
				suppliers.currcode,
				SUM(purchorderdetails.unitprice*purchorderdetails.quantityord) AS ordervalue
			FROM purchorders,
				purchorderdetails,
				suppliers
			WHERE purchorders.orderno = purchorderdetails.orderno
			AND purchorders.supplierno = suppliers.supplierid
			AND purchorders.orderno='" . $OrderNumber . "'
			GROUP BY purchorders.orderno";
	} else {
		/* $DateAfterCriteria = FormatDateforSQL($OrdersAfterDate); */
		if (empty($_POST['StockLocation'])) {
			$_POST['StockLocation'] = '';
		}
		if (isset($SelectedSupplier)) {
			if (isset($SelectedStockItem)) {
				$SQL = "SELECT purchorders.orderno,
						suppliers.suppname,
						purchorders.orddate,
						purchorders.initiator,
						purchorders.requisitionno,
						purchorders.allowprint,
						suppliers.currcode,
						SUM(purchorderdetails.unitprice*purchorderdetails.quantityord) AS ordervalue
					FROM purchorders,
						purchorderdetails,
						suppliers
					WHERE purchorders.orderno = purchorderdetails.orderno
					AND purchorders.supplierno = suppliers.supplierid
					AND  purchorderdetails.itemcode='" . $SelectedStockItem . "'
					AND purchorders.supplierno='" . $SelectedSupplier . "'
					AND purchorders.intostocklocation = '" . $_POST['StockLocation'] . "'
					GROUP BY purchorders.orderno,
						suppliers.suppname,
						purchorders.orddate,
						purchorders.initiator,
						purchorders.requisitionno,
						purchorders.allowprint,
						suppliers.currcode";
			} else {
				$SQL = "SELECT purchorders.orderno,
						suppliers.suppname,
						purchorders.orddate,
						purchorders.initiator,
						purchorders.requisitionno,
						purchorders.allowprint,
						suppliers.currcode,
						SUM(purchorderdetails.unitprice*purchorderdetails.quantityord) AS ordervalue
					FROM purchorders,
						purchorderdetails,
						suppliers
					WHERE purchorders.orderno = purchorderdetails.orderno
					AND purchorders.supplierno = suppliers.supplierid
					AND purchorders.supplierno='" . $SelectedSupplier . "'
					AND purchorders.intostocklocation = '" . $_POST['StockLocation'] . "'
					GROUP BY purchorders.orderno,
						suppliers.suppname,
						purchorders.orddate,
						purchorders.initiator,
						purchorders.requisitionno,
						purchorders.allowprint,
						suppliers.currcode";
			}
		} else { //no supplier selected
			if (isset($SelectedStockItem)) {
				$SQL = "SELECT purchorders.orderno,
						suppliers.suppname,
						purchorders.orddate,
						purchorders.initiator,
						purchorders.requisitionno,
						purchorders.allowprint,
						suppliers.currcode,
						SUM(purchorderdetails.unitprice*purchorderdetails.quantityord) AS ordervalue
					FROM purchorders,
						purchorderdetails,
						suppliers
					WHERE purchorders.orderno = purchorderdetails.orderno
					AND purchorders.supplierno = suppliers.supplierid
					AND purchorderdetails.itemcode='" . $SelectedStockItem . "'
					AND purchorders.intostocklocation = '" . $_POST['StockLocation'] . "'
					GROUP BY purchorders.orderno,
						suppliers.suppname,
						purchorders.orddate,
						purchorders.initiator,
						purchorders.requisitionno,
						purchorders.allowprint,
						suppliers.currcode";
			} else {
				$SQL = "SELECT purchorders.orderno,
						suppliers.suppname,
						purchorders.orddate,
						purchorders.initiator,
						purchorders.requisitionno,
						purchorders.allowprint,
						suppliers.currcode,
						sum(purchorderdetails.unitprice*purchorderdetails.quantityord) as ordervalue
					FROM purchorders,
						purchorderdetails,
						suppliers
					WHERE purchorders.orderno = purchorderdetails.orderno
					AND purchorders.supplierno = suppliers.supplierid
					AND purchorders.intostocklocation = '" . $_POST['StockLocation'] . "'
					GROUP BY purchorders.orderno,
						suppliers.suppname,
						purchorders.orddate,
						purchorders.initiator,
						purchorders.requisitionno,
						purchorders.allowprint,
						suppliers.currcode";
			}
		} //end selected supplier

	} //end not order number selected
	$ErrMsg = _('No orders were returned by the SQL because');
	$PurchOrdersResult = DB_query($SQL, $db, $ErrMsg);
	if (DB_num_rows($PurchOrdersResult) > 0) {
		/*show a table of the orders returned by the SQL */
		echo '<table cellpadding=2 colspan=7 width=90% class=selection>';
		$TableHeader = '<tr><th>' . _('View') . '</th>
				<th>' . _('Supplier') . '</th>
				<th>' . _('Currency') . '</th>
				<th>' . _('Requisition') . '</th>
				<th>' . _('Order Date') . '</th>
				<th>' . _('Initiator') . '</th>
				<th>' . _('Order Total') . '</th>
				</tr>';
		echo $TableHeader;
		$j = 1;
		$k = 0; //row colour counter
		while ($myrow = DB_fetch_array($PurchOrdersResult)) {
			if ($k == 1) { /*alternate bgcolour of row for highlighting */
				echo '<tr bgcolor="#CCCCCC">';
				$k = 0;
			} else {
				echo '<tr bgcolor="#EEEEEE">';
				$k++;
			}
			$ViewPurchOrder = $rootpath . '/PO_OrderDetails.php?' . SID . 'OrderNo=' . $myrow['orderno'];
			$FormatedOrderDate = ConvertSQLDate($myrow['orddate']);
			$FormatedOrderValue = number_format($myrow['ordervalue'], 2);
			/*						  View					   Supplier					Currency			   Requisition			 Order Date				 Initiator				Order Total
			ModifyPage, $myrow["orderno"],		  $myrow["suppname"],			$myrow["currcode"],		 $myrow["requisitionno"]		$FormatedOrderDate,			 $myrow["initiator"]			 $FormatedOrderValue */
			echo "<td><a href='" . $ViewPurchOrder . "'>" . $myrow['orderno'] . "</a></td>
					<td>" . $myrow['suppname'] . "</td>
				<td>" . $myrow['currcode'] . "</td>
				<td>" . $myrow['requisitionno'] . "</td>
				<td>" . $FormatedOrderDate . "</td>
				<td>" . $myrow['initiator'] . "</td>
				<td class=number>" . $FormatedOrderValue . "</td>
				</tr>";
			$j++;
			if ($j == 12) {
				$j = 1;
				echo $TableHeader;
			}
			//end of page full new headings if
		}
		//end of while loop
		echo '</table>';
	} // end if purchase orders to show
}
echo '</form>';
include ('includes/footer.inc');
?>