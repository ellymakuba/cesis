<?php

/* $Id: POReport.php 3945 2010-09-30 15:19:53Z tim_schofield $ */

// POReport.php
// Inquiry on Purchase Orders
// If Date Type is Order, the main file is purchorderdetails
// If Date Type is Delivery, the main file is grns
$PageSecurity=2;

include('includes/session.inc');
$title = _('Tenders Report');
include('includes/header.inc');

# Sets default date range for current month
if (!isset($_POST['FromDate'])){
	$_POST['FromDate']=Date($_SESSION['DefaultDateFormat'], mktime(0,0,0,Date('m'),1,Date('Y')));
}
if (!isset($_POST['ToDate'])){
	$_POST['ToDate'] = Date($_SESSION['DefaultDateFormat']);
}

if (isset($_POST['submit']) or isset($_POST['submitcsv'])) {
	if (isset($_POST['PartNumber'])){
		$PartNumber = trim(strtoupper($_POST['PartNumber']));
	} elseif (isset($_GET['PartNumber'])){
		$PartNumber = trim(strtoupper($_GET['PartNumber']));
	}

	# Part Number operator - either LIKE or =
	$PartNumberOp = $_POST['PartNumberOp'];

	if (isset($_POST['SupplierId'])){
		$SupplierId = trim(strtoupper($_POST['SupplierId']));
	} elseif (isset($_GET['SupplierId'])){
		$SupplierId = trim(strtoupper($_GET['SupplierId']));
	}

	$SupplierIdOp = $_POST['SupplierIdOp'];

	$SupplierNameOp = $_POST['SupplierNameOp'];

	// Save $_POST['SummaryType'] in $savesummarytype because change $_POST['SummaryType'] when
	// create $sql
	$savesummarytype = $_POST['SummaryType'];
}

if (isset($_POST['SupplierName'])){
	$SupplierName = trim(strtoupper($_POST['SupplierName']));
} elseif (isset($_GET['SupplierName'])){
	$SupplierName = trim(strtoupper($_GET['SupplierName']));
}

// Had to add supplierid to SummaryType when do summary by name because there could be several accounts
// with the same name. Tried passing 'suppname,supplierid' in form, but it only read 'suppname'
if (isset($_POST['SummaryType']) and $_POST['SummaryType'] == 'suppname') {
	$_POST['SummaryType'] = 'suppname,suppliers.supplierid';
}

if (isset($_POST['submit'])) {
	echo '<p class="page_title_text"><img src="'.$rootpath.'/css/'.$theme.'/images/maintenance.png" title="' . _('Search') .
		'" alt="">' . ' ' . $title.'</p>';
	submit($db,$PartNumber,$PartNumberOp,$SupplierId,$SupplierIdOp,$SupplierName,$SupplierNameOp,$savesummarytype);
} else if (isset($_POST['submitcsv'])) {
	echo '<p class="page_title_text"><img src="'.$rootpath.'/css/'.$theme.'/images/maintenance.png" title="' . _('Search') .
		'" alt="">' . ' ' . $title.'</p>';
	submitcsv($db,$PartNumber,$PartNumberOp,$SupplierId,$SupplierIdOp,$SupplierName,$SupplierNameOp,$savesummarytype);
} else {
	echo '<p class="page_title_text"><img src="'.$rootpath.'/css/'.$theme.'/images/maintenance.png" title="' . _('Search') .
		'" alt="">' . '</img>' . $title.'</p>';
	display($db);
}


//####_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT####
function submit(&$db,$PartNumber,$PartNumberOp,$SupplierId,$SupplierIdOp,$SupplierName,$SupplierNameOp,$savesummarytype)
{

	//initialize no input errors
	$InputError = 0;

	/* actions to take once the user has clicked the submit button
	ie the page has called itself with some user input */

	//first off validate inputs sensible

	if (!Is_Date($_POST['FromDate'])) {
		$InputError = 1;
		prnMsg(_('Invalid From Date'),'error');
	}
	if (!Is_Date($_POST['ToDate'])) {
		$InputError = 1;
		prnMsg(_('Invalid To Date'),'error');
	}

	# Add more to WHERE statement, if user entered something for the part number,supplierid, name
	$wherepart = ' ';
	if (strlen($PartNumber) > 0 && $PartNumberOp == 'LIKE') {
		$PartNumber = $PartNumber . '%';
	} else {
		$PartNumberOp = '=';
	}
	if (strlen($PartNumber) > 0) {
		$wherepart = " AND purchorderdetails.itemcode " . $PartNumberOp . " '" . $PartNumber . "'  ";
	} else {
		$wherepart=' ';
	}

	$wheresupplierid = ' ';
	if ($SupplierIdOp == 'LIKE') {
		$SupplierId = $SupplierId . '%';
	} else {
		$SupplierIdOp = '=';
	}
	if (strlen($SupplierId) > 0) {
		$wheresupplierid = " AND purchorders.supplierno " . $SupplierIdOp . " '" . $SupplierId . "'  ";
	} else {
		$wheresupplierid=' ';
	}

	$wheresuppliername = ' ';
	if (strlen($SupplierName) > 0 && $SupplierNameOp == 'LIKE') {
		$SupplierName = $SupplierName . '%';
	} else {
		$SupplierNameOp = '=';
	}
	if (strlen($SupplierName) > 0) {
		$wheresuppliername = " AND suppliers.suppname " . $SupplierNameOp . " '" . $SupplierName . "'  ";
	} else {
		$wheresuppliername=' ';
	}

	if (strlen($_POST['OrderNo']) > 0) {
		$whereorderno = ' AND purchorderdetails.orderno = ' . " '" . $_POST['OrderNo'] . "'  ";
	} else {
		$whereorderno=' ';
	}

	$wherelinestatus = ' ';
	# Had to use IF statement instead of comparing 'linestatus' to $_POST['LineStatus']
	#in WHERE clause because the WHERE clause didn't recognize
	# that had used the IF statement to create a field called linestatus
	if ($_POST['LineStatus'] != 'All') {
		if ($_POST['DateType'] == 'Order') {
			$wherelinestatus = " AND IF(purchorderdetails.quantityord = purchorderdetails.qtyinvoiced ||
			  purchorderdetails.completed = 1,'Completed','Open') = '" . $_POST['LineStatus'] . "'";
		 } else {
			$wherelinestatus = " AND IF(grns.qtyrecd - grns.quantityinv <> 0,'Open','Completed') = '"
			. $_POST['LineStatus'] . "'";
		 }
	}


	$wherecategory = ' ';
	if ($_POST['Category'] != 'All') {
		$wherecategory = " AND stockmaster.categoryid = '" . $_POST['Category'] . "'";
	}

	if ($InputError !=1) {
		$fromdate = FormatDateForSQL($_POST['FromDate']);
		$todate = FormatDateForSQL($_POST['ToDate']);
		if ($_POST['ReportType'] == 'Detail') {
			if ($_POST['DateType'] == 'Order') {
				$sql = "SELECT purchorderdetails.orderno,
							   purchorderdetails.itemcode,
							   purchorderdetails.deliverydate,
							   purchorders.supplierno,
							   purchorders.orddate,
							   purchorderdetails.quantityord,
							   purchorderdetails.qtyinvoiced,
							   (purchorderdetails.quantityord * purchorderdetails.unitprice) as extprice,
							   (purchorderdetails.quantityord * purchorderdetails.stdcostunit) as extcost,
							   IF(purchorderdetails.quantityord = purchorderdetails.qtyinvoiced ||
								  purchorderdetails.completed = 1,'Completed','Open') as linestatus,
							   suppliers.suppname,
							   stockmaster.decimalplaces,
							   stockmaster.description
							   FROM purchorderdetails
						LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
						LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
						LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
						WHERE purchorders.orddate >='$fromdate'
						 AND purchorders.orddate <='$todate'
						$wherepart
						$wheresupplierid
						$wheresuppliername
						$whereorderno
						$wherelinestatus
						$wherecategory
						ORDER BY " . $_POST['SortBy'];
			} else {
				// Selects by delivery date from grns
				$sql = "SELECT purchorderdetails.orderno,
							   purchorderdetails.itemcode,
							   grns.deliverydate,
							   purchorders.supplierno,
							   purchorders.orddate,
							   grns.qtyrecd as quantityord,
							   grns.quantityinv as qtyinvoiced,
							   (grns.qtyrecd * purchorderdetails.unitprice) as extprice,
							   (grns.qtyrecd * grns.stdcostunit) as extcost,
							   IF(grns.qtyrecd - grns.quantityinv <> 0,'Open','Completed') as linestatus,
							   suppliers.suppname,
							   stockmaster.decimalplaces,
							   stockmaster.description
							   FROM grns
						LEFT JOIN purchorderdetails ON grns.podetailitem = purchorderdetails.podetailitem
						LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
						LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
						LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
						WHERE grns.deliverydate >='$fromdate'
						 AND grns.deliverydate <='$todate'
						$wherepart
						$wheresupplierid
						$wheresuppliername
						$whereorderno
						$wherelinestatus
						$wherecategory
						ORDER BY " . $_POST['SortBy'];
			}
		} else {
			// sql for Summary report
			$orderby = $_POST['SummaryType'];
			// The following is because the 'extprice' summary is a special case - with the other
			// summaries, you group and order on the same field; with 'extprice', you are actually
			// grouping on the stkcode and ordering by extprice descending
			if ($_POST['SummaryType'] == 'extprice') {
				$_POST['SummaryType'] = 'itemcode';
				$orderby = 'extprice DESC';
			}
			if ($_POST['DateType'] == 'Order') {
				if ($_POST['SummaryType'] == 'extprice' || $_POST['SummaryType'] == 'itemcode') {
					$sql = "SELECT purchorderdetails.itemcode,
								   SUM(purchorderdetails.quantityord) as quantityord,
								   SUM(purchorderdetails.qtyinvoiced) as qtyinvoiced,
								   SUM(purchorderdetails.quantityord * purchorderdetails.unitprice) as extprice,
								   SUM(purchorderdetails.quantityord * purchorderdetails.stdcostunit) as extcost,
								   stockmaster.decimalplaces,
								   stockmaster.description
								   FROM purchorderdetails
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE purchorders.orddate >='$fromdate'
							 AND purchorders.orddate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							',stockmaster.decimalplaces,
							  stockmaster.description
							ORDER BY ' . $orderby;
				} elseif ($_POST['SummaryType'] == 'orderno') {
					$sql = "SELECT purchorderdetails.orderno,
								   purchorders.supplierno,
								   SUM(purchorderdetails.quantityord) as quantityord,
								   SUM(purchorderdetails.qtyinvoiced) as qtyinvoiced,
								   SUM(purchorderdetails.quantityord * purchorderdetails.unitprice) as extprice,
								   SUM(purchorderdetails.quantityord * purchorderdetails.stdcostunit) as extcost,
								   suppliers.suppname
								   FROM purchorderdetails
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE purchorders.orddate >='$fromdate'
							 AND purchorders.orddate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							',purchorders.supplierno,
							  suppliers.suppname
							ORDER BY ' . $orderby;
				} elseif ($_POST['SummaryType'] == 'supplierno' || $_POST['SummaryType'] == 'suppname,suppliers.supplierid') {
					$sql = "SELECT purchorders.supplierno,
								   SUM(purchorderdetails.quantityord) as quantityord,
								   SUM(purchorderdetails.qtyinvoiced) as qtyinvoiced,
								   SUM(purchorderdetails.quantityord * purchorderdetails.unitprice) as extprice,
								   SUM(purchorderdetails.quantityord * purchorderdetails.stdcostunit) as extcost,
								   suppliers.suppname
								   FROM purchorderdetails
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE purchorders.orddate >='$fromdate'
							 AND purchorders.orddate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							',purchorders.supplierno,
							  suppliers.suppname
							ORDER BY ' . $orderby;
				} elseif ($_POST['SummaryType'] == 'month') {
					$sql = "SELECT EXTRACT(YEAR_MONTH from purchorders.orddate) as month,
								   CONCAT(MONTHNAME(purchorders.orddate),' ',YEAR(purchorders.orddate)) as monthname,
								   SUM(purchorderdetails.quantityord) as quantityord,
								   SUM(purchorderdetails.qtyinvoiced) as qtyinvoiced,
								   SUM(purchorderdetails.quantityord * purchorderdetails.unitprice) as extprice,
								   SUM(purchorderdetails.quantityord * purchorderdetails.stdcostunit) as extcost
								   FROM purchorderdetails
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE purchorders.orddate >='$fromdate'
							 AND purchorders.orddate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							', monthname
							ORDER BY ' . $orderby;
				} elseif ($_POST['SummaryType'] == 'categoryid') {
					$sql = "SELECT SUM(purchorderdetails.quantityord) as quantityord,
								   SUM(purchorderdetails.qtyinvoiced) as qtyinvoiced,
								   SUM(purchorderdetails.quantityord * purchorderdetails.unitprice) as extprice,
								   SUM(purchorderdetails.quantityord * purchorderdetails.stdcostunit) as extcost,
								   stockmaster.categoryid,
								   stockcategory.categorydescription
								   FROM purchorderdetails
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE purchorders.orddate >='$fromdate'
							 AND purchorders.orddate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							', categorydescription
							ORDER BY ' . $orderby;
				}
			} else {
					// Selects by delivery date from grns
				if ($_POST['SummaryType'] == 'extprice' || $_POST['SummaryType'] == 'itemcode') {
					$sql = "SELECT purchorderdetails.itemcode,
								   SUM(grns.qtyrecd) as quantityord,
								   SUM(grns.quantityinv) as qtyinvoiced,
								   SUM(grns.qtyrecd * purchorderdetails.unitprice) as extprice,
								   SUM(grns.qtyrecd * grns.stdcostunit) as extcost,
								   stockmaster.description
								   FROM grns
							LEFT JOIN purchorderdetails ON grns.podetailitem = purchorderdetails.podetailitem
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE grns.deliverydate >='$fromdate'
							 AND grns.deliverydate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							', stockmaster.description
							ORDER BY ' . $orderby;
				} elseif ($_POST['SummaryType'] == 'orderno') {
					$sql = "SELECT purchorderdetails.orderno,
								   purchorders.supplierno,
								   SUM(grns.qtyrecd) as quantityord,
								   SUM(grns.quantityinv) as qtyinvoiced,
								   SUM(grns.qtyrecd * purchorderdetails.unitprice) as extprice,
								   SUM(grns.qtyrecd * grns.stdcostunit) as extcost,
								   suppliers.suppname
								   FROM grns
							LEFT JOIN purchorderdetails ON grns.podetailitem = purchorderdetails.podetailitem
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE grns.deliverydate >='$fromdate'
							 AND grns.deliverydate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							', purchorders.supplierno,
							   suppliers.suppname
							ORDER BY ' . $orderby;
				} elseif ($_POST['SummaryType'] == 'supplierno' || $_POST['SummaryType'] == 'suppname,suppliers.supplierid') {
					$sql = "SELECT purchorders.supplierno,
								   SUM(grns.qtyrecd) as quantityord,
								   SUM(grns.quantityinv) as qtyinvoiced,
								   SUM(grns.qtyrecd * purchorderdetails.unitprice) as extprice,
								   SUM(grns.qtyrecd * grns.stdcostunit) as extcost,
								   suppliers.suppname
								   FROM grns
							LEFT JOIN purchorderdetails ON grns.podetailitem = purchorderdetails.podetailitem
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE grns.deliverydate >='$fromdate'
							 AND grns.deliverydate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							', purchorders.supplierno,
							   suppliers.suppname
							ORDER BY ' . $orderby;
				} elseif ($_POST['SummaryType'] == 'month') {
					$sql = "SELECT EXTRACT(YEAR_MONTH from purchorders.orddate) as month,
								   CONCAT(MONTHNAME(purchorders.orddate),' ',YEAR(purchorders.orddate)) as monthname,
								   SUM(grns.qtyrecd) as quantityord,
								   SUM(grns.quantityinv) as qtyinvoiced,
								   SUM(grns.qtyrecd * purchorderdetails.unitprice) as extprice,
								   SUM(grns.qtyrecd * grns.stdcostunit) as extcost
								   FROM grns
							LEFT JOIN purchorderdetails ON grns.podetailitem = purchorderdetails.podetailitem
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE grns.deliverydate >='$fromdate'
							 AND grns.deliverydate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							',monthname
							ORDER BY ' . $orderby;
				} elseif ($_POST['SummaryType'] == 'categoryid') {
					$sql = "SELECT stockmaster.categoryid,
								   stockcategory.categorydescription,
								   SUM(grns.qtyrecd) as quantityord,
								   SUM(grns.quantityinv) as qtyinvoiced,
								   SUM(grns.qtyrecd * purchorderdetails.unitprice) as extprice,
								   SUM(grns.qtyrecd * grns.stdcostunit) as extcost
								   FROM grns
							LEFT JOIN purchorderdetails ON grns.podetailitem = purchorderdetails.podetailitem
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE grns.deliverydate >='$fromdate'
							 AND grns.deliverydate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							',categorydescription
							ORDER BY ' . $orderby;
				}
			}
		} // End of if ($_POST['ReportType']
		//echo "<br/>$sql<br/>";
		$ErrMsg = _('The SQL to find the parts selected failed with the message');
		$result = DB_query($sql,$db,$ErrMsg);
		$ctr = 0;
		$totalqty = 0;
		$totalextcost = 0;
		$totalextprice = 0;
		$totalinvqty = 0;

		// Create array for summary type to display in header. Access it with $savesummarytype
		$summary_array["orderno"] =  _('Order Number');
		$summary_array["itemcode"] =  _('Item Code');
		$summary_array["extprice"] =  _('Cost');
		$summary_array["supplierno"] =  _('Supplier Number');
		$summary_array["suppname"] =  _('Supplier Name');
		$summary_array["month"] =  _('Month');
		$summary_array["categoryid"] =  _('Stock Category');

		// Create array for sort for detail report to display in header
		$detail_array['purchorderdetails.orderno'] = _('Order Number');
		$detail_array['purchorderdetails.itemcode'] = _('Item Number');
		$detail_array['suppliers.supplierid,purchorderdetails.orderno'] = _('Supplier Number');
		$detail_array['suppliers.suppname,suppliers.supplierid,purchorderdetails.orderno'] = _('Supplier Name');

		// Display Header info
		echo '<table class=selection>';
		if ($_POST['ReportType'] == 'Summary') {
			$sortby_display = $summary_array[$savesummarytype];
		} else {
			$sortby_display = $detail_array[$_POST['SortBy']];
		}
		echo '<tr><th colspan=2><font size=3 color=navy>'._('Header Details').'</font></th></tr>';
		echo '<tr><td>' . _('Tenders Report') . '</td><td>' . $_POST['ReportType'] . ' By '.$sortby_display .'</td></tr>';
		echo '<tr><td>' . _('Date Type') . '</td><td>' . $_POST['DateType'] . '</tr>';
		echo '<tr><td>' . _('Date Range') . '</td><td>' . $_POST['FromDate'] . _(' To ') .  $_POST['ToDate'] . '</td></tr>';
		if (strlen(trim($PartNumber)) > 0) {
			echo '<tr><td>' . _('Item Number') . '</td><td>' . $_POST['PartNumberOp'] . ' ' . $_POST['PartNumber'] . '</td></tr>';
		}
		if (strlen(trim($_POST['SupplierId'])) > 0) {
			echo '<tr><td>' . _('Supplier Number') . '</td><td>' . $_POST['SupplierIdOp'] . ' ' . $_POST['SupplierId'] . '</td></tr>';
		}
		if (strlen(trim($_POST['SupplierName'])) > 0) {
			echo '<tr><td>' . _('Supplier Name') . '</td><td>' . $_POST['SupplierNameOp'] . ' ' . $_POST['SupplierName'] . '</td></tr>';
		}
		echo '<tr><td>' . _('Line Item Status') . '</td><td>' . $_POST['LineStatus'] . '</tr>';
		echo '<tr><td>' . _('Stock Category') . '</td><td>' . $_POST['Category'] . '</tr></table>';

		if ($_POST['ReportType'] == 'Detail') {
			echo '<br><table class=selection width=98%>';
			if ($_POST['DateType'] == 'Order') {
				printf("<tr><th>%s</th><th>%s</th><th>%s</th><th>%s</th><th>%s</th><th>%s</th><th>%s</th><th>%s</th><th>%-s</th><th>%s",
					 _('Order No'),
					 _('Item Number'),
					 _('Order Date'),
					 _('Supplier No'),
					 _('Supplier Name'),
					 _('Order Qty'),
					 _('Cost'),
					 _('Line Status'),
					 _('Item Due'),
					 _('Description'));
					$linectr = 0;
					$k = 0;
				while ($myrow = DB_fetch_array($result)) {
					if ($k==1){
						echo '<tr class="EvenTableRows">';
						$k=0;
					} else {
						echo '<tr class="OddTableRows">';
						$k++;
					}
					$linectr++;
				   // Detail for both DateType of Order
					printf("<td>%s</td><td>%s</td><td>%s</td><td class=number>%s</td>
						<td class=number>%s</td><td class=number>%s</td><td class=number>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>",
					$myrow['orderno'],
					$myrow['itemcode'],
					ConvertSQLDate($myrow['orddate']),
					$myrow['supplierno'],
					$myrow['suppname'],
					number_format($myrow['quantityord'],$myrow['decimalplaces']),
					number_format($myrow['extprice'],2),
					$myrow['linestatus'],
					ConvertSQLDate($myrow['deliverydate']),
					$myrow['description']);
					$lastdecimalplaces = $myrow['decimalplaces'];
					$totalqty += $myrow['quantityord'];
					$totalextcost += $myrow['extcost'];
					$totalextprice += $myrow['extprice'];
					$totalinvqty += $myrow['qtyinvoiced'];
				} //END WHILE LIST LOOP
				// Print totals
					printf("<tr><td>%s</td><td class=number>%s</td><td class=number>%s</td>
						<td class=number>%s</td><td class=number>%s</td><td>%s</td><td>%s</td></tr>",
					'Totals',
					_('Lines - ') . $linectr,
					' ',
					' ',
					' ',
					number_format($totalqty,2),
					number_format($totalextprice,2),
					number_format($totalinvqty,2),
					' ',
					' ');
			} else {
			  // Header for Date Type of Delivery Date
				printf("<tr><th>%s</th><th>%s</th><th>%s</th><th>%s</th><th>%s</th><th>%s</th><th>%s</th><th>%s</th><th>%s</th><th>%s</th><th>%s</th></tr>",
					 _('Order No'),
					 _('Item Code'),
					 _('Order Date'),
					 _('Supplier No'),
					 _('Supplier Name'),
					 _('Received'),
					 _('Cost'),
					 _('Line Status'),
					 _('Delivered'),
					 _('Item Description'));
					$linectr = 0;
					$k = 0;
				while ($myrow = DB_fetch_array($result)) {
					if ($k==1){
						echo '<tr class="EvenTableRows">';
						$k=0;
					} else {
						echo '<tr class="OddTableRows">';
						$k++;
					}
					$linectr++;
				   // Detail for both DateType of Ship
				   // In sql, had to alias grns.qtyrecd as quantityord so could use same name here
					printf("<td>%s</td><td>%s</td><td>%s</td><td>%s</td><td class=number>%s</td><td class=number>
						%s</td><td class=number>%s</td><td class=number>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>",
						$myrow['orderno'],
						$myrow['itemcode'],
						ConvertSQLDate($myrow['orddate']),
						$myrow['supplierno'],
						$myrow['suppname'],
						number_format($myrow['quantityord'],$myrow['decimalplaces']),
						number_format($myrow['extprice'],2),
						$myrow['linestatus'],
						ConvertSQLDate($myrow['deliverydate']),
						$myrow['description']);
						$lastdecimalplaces = $myrow['decimalplaces'];
						$totalqty += $myrow['quantityord'];
						$totalextcost += $myrow['extcost'];
						$totalextprice += $myrow['extprice'];
						$totalinvqty += $myrow['qtyinvoiced'];
				} //END WHILE LIST LOOP
				// Print totals
					printf("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td class=number>%s</td><td class=number>
						%s</td><td class=number>%s</td><td class=number>%s</td><td>%s</td><td>%s</td></tr>",
					'Totals',
					_('Lines - ') . $linectr,
					' ',
					' ',
					' ',
					number_format($totalqty,$lastdecimalplaces),
					number_format($totalextcost,2),
					number_format($totalextprice,2),
					number_format($totalinvqty,$lastdecimalplaces),
					' ',
					' ');
			}
			echo '</table>';
		} else {
		  // Print summary stuff
			echo '<br><table class=selection width=98%>';
			$summarytype = $_POST['SummaryType'];
			// For SummaryType 'suppname' had to add supplierid to it for the GROUP BY in the sql,
			// but have to take it away for $myrow[$summarytype] to be valid
			// Set up description based on the Summary Type
			if ($summarytype == 'suppname,suppliers.supplierid') {
				$summarytype = 'suppname';
				$description = 'supplierno';
				$summaryheader = _('Supplier Name');
				$descriptionheader = _('Supplier Number');
			}
			if ($summarytype == 'itemcode' || $summarytype == 'extprice') {
				$description = 'description';
				$summaryheader = _('Item Number');
				$descriptionheader = _('Item Description');
			}
			if ($summarytype == 'supplierno') {
				$description = 'suppname';
				$summaryheader = _('Supplier Number');
				$descriptionheader = _('Supplier Name');
			}
			if ($summarytype == 'orderno') {
				$description = 'supplierno';
				$summaryheader = _('Order Number');
				$descriptionheader = _('Supplier Number');
			}
			if ($summarytype == 'categoryid') {
				$description = 'categorydescription';
				$summaryheader = _('Stock Category');
				$descriptionheader = _('Category Description');
			}
			$summarydesc = $summaryheader;
			if ($orderby == 'extprice DESC') {
				$summarydesc = _('Cost');
			}
			if ($summarytype == 'month') {
				$description = 'monthname';
				$summaryheader = _('Month');
				$descriptionheader = _('Month');
			}
			printf("<tr><th>%s</th><th>%s</th><th>%s</th><th>%s</th></tr>",
				 _($summaryheader),
				 _($descriptionheader),
				 _('Quantity'),
				 _('Cost'));

				$suppname = ' ';
				$linectr = 0;
				$k=0;
			while ($myrow = DB_fetch_array($result)) {
				$linectr++;
				if ($summarytype == 'orderno') {
					$suppname = $myrow['suppname'];
				}
					if ($k==1){
						echo '<tr class="EvenTableRows">';
						$k=0;
					} else {
						echo '<tr class="OddTableRows">';
						$k++;
					}
				printf("<td>%s</td><td>%s</td><td class=number>%s</td><td class=number>%s</td></tr>",
				$myrow[$summarytype],
				$myrow[$description],
				$myrow['quantityord'],
				number_format($myrow['extprice'],2),
				$suppname);
				$totalqty += $myrow['quantityord'];
				$totalextcost += $myrow['extcost'];
				$totalextprice += $myrow['extprice'];
				$totalinvqty += $myrow['qtyinvoiced'];
			} //END WHILE LIST LOOP
			// Print totals
				printf("<tr><td>%s</td><td>%s</td><td class=number>%s</td><td class=number>%s</td><td class=number>%s</td></tr>",
				'Totals',
				_('Lines - ') . $linectr,
				$totalqty,
				number_format($totalextcost,2),
				number_format($totalextprice,2),
				$totalinvqty,
				' ');
		} // End of if ($_POST['ReportType']
		echo '</table>';
		echo "<form action=" . $_SERVER['PHP_SELF'] . "?" . SID ." method=post>";
		echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
		echo "<input type=hidden name='ReportType' value=".$_POST['ReportType'].">";
		echo "<input type=hidden name='DateType' value=".$_POST['DateType'].">";
		echo "<input type=hidden name='FromDate' value=".$_POST['FromDate'].">";
		echo "<input type=hidden name='ToDate' value=".$_POST['ToDate'].">";
		echo "<input type=hidden name='PartNumberOp' value=".$_POST['PartNumberOp'].">";
		echo "<input type=hidden name='PartNumber' value=".$_POST['PartNumber'].">";
		echo "<input type=hidden name='SupplierIdOp' value=".$_POST['SupplierIdOp'].">";
		echo "<input type=hidden name='SupplierId' value=".$_POST['SupplierId'].">";
		echo "<input type=hidden name='SupplierNameOp' value=".$_POST['SupplierNameOp'].">";
		echo "<input type=hidden name='SupplierName' value=".$_POST['SupplierName'].">";
		echo "<input type=hidden name='OrderNo' value=".$_POST['OrderNo'].">";
		echo "<input type=hidden name='LineStatus' value=".$_POST['LineStatus'].">";
		echo "<input type=hidden name='Category' value=".$_POST['Category'].">";
		echo "<input type=hidden name='SortBy' value=".$_POST['SortBy'].">";
		echo "<input type=hidden name='SummaryType' value=".$_POST['SummaryType'].">";
		
		echo "</form>";
	} // End of if inputerror != 1
} // End of function submit()

//####_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT_SUBMIT####
function submitcsv(&$db,$PartNumber,$PartNumberOp,$SupplierId,$SupplierIdOp,$SupplierName,$SupplierNameOp,$savesummarytype)
{

	//initialize no input errors
	$InputError = 0;

	/* actions to take once the user has clicked the submit button
	ie the page has called itself with some user input */

	//first off validate inputs sensible

	if (!Is_Date($_POST['FromDate'])) {
		$InputError = 1;
		prnMsg(_('Invalid From Date'),'error');
	}
	if (!Is_Date($_POST['ToDate'])) {
		$InputError = 1;
		prnMsg(_('Invalid To Date'),'error');
	}

	# Add more to WHERE statement, if user entered something for the part number,supplierid, name
	$wherepart = ' ';
	if (strlen($PartNumber) > 0 && $PartNumberOp == 'LIKE') {
		$PartNumber = $PartNumber . '%';
	} else {
		$PartNumberOp = '=';
	}
	if (strlen($PartNumber) > 0) {
		$wherepart = " AND purchorderdetails.itemcode " . $PartNumberOp . " '" . $PartNumber . "'  ";
	} else {
		$wherepart=' ';
	}

	$wheresupplierid = ' ';
	if ($SupplierIdOp == 'LIKE') {
		$SupplierId = $SupplierId . '%';
	} else {
		$SupplierIdOp = '=';
	}
	if (strlen($SupplierId) > 0) {
		$wheresupplierid = " AND purchorders.supplierno " . $SupplierIdOp . " '" . $SupplierId . "'  ";
	} else {
		$wheresupplierid=' ';
	}

	$wheresuppliername = ' ';
	if (strlen($SupplierName) > 0 && $SupplierNameOp == 'LIKE') {
		$SupplierName = $SupplierName . '%';
	} else {
		$SupplierNameOp = '=';
	}
	if (strlen($SupplierName) > 0) {
		$wheresuppliername = " AND suppliers.suppname " . $SupplierNameOp . " '" . $SupplierName . "'  ";
	} else {
		$wheresuppliername=' ';
	}

	if (strlen($_POST['OrderNo']) > 0) {
		$whereorderno = ' AND purchorderdetails.orderno = ' . " '" . $_POST['OrderNo'] . "'  ";
	} else {
		$whereorderno=' ';
	}

	$wherelinestatus = ' ';
	# Had to use IF statement instead of comparing 'linestatus' to $_POST['LineStatus']
	#in WHERE clause because the WHERE clause didn't recognize
	# that had used the IF statement to create a field called linestatus
	if ($_POST['LineStatus'] != 'All') {
		if ($_POST['DateType'] == 'Order') {
			$wherelinestatus = " AND IF(purchorderdetails.quantityord = purchorderdetails.qtyinvoiced ||
			  purchorderdetails.completed = 1,'Completed','Open') = '" . $_POST['LineStatus'] . "'";
		 } else {
			$wherelinestatus = " AND IF(grns.qtyrecd - grns.quantityinv <> 0,'Open','Completed') = '"
			. $_POST['LineStatus'] . "'";
		 }
	}


	$wherecategory = ' ';
	if ($_POST['Category'] != 'All') {
		$wherecategory = " AND stockmaster.categoryid = '" . $_POST['Category'] . "'";
	}

	if ($InputError !=1) {
		$fromdate = FormatDateForSQL($_POST['FromDate']);
		$todate = FormatDateForSQL($_POST['ToDate']);
		if ($_POST['ReportType'] == 'Detail') {
			if ($_POST['DateType'] == 'Order') {
				$sql = "SELECT purchorderdetails.orderno,
							   purchorderdetails.itemcode,
							   purchorderdetails.deliverydate,
							   purchorders.supplierno,
							   purchorders.orddate,
							   purchorderdetails.quantityord,
							   purchorderdetails.qtyinvoiced,
							   (purchorderdetails.quantityord * purchorderdetails.unitprice) as extprice,
							   (purchorderdetails.quantityord * purchorderdetails.stdcostunit) as extcost,
							   IF(purchorderdetails.quantityord = purchorderdetails.qtyinvoiced ||
								  purchorderdetails.completed = 1,'Completed','Open') as linestatus,
							   suppliers.suppname,
							   stockmaster.decimalplaces,
							   stockmaster.description
							   FROM purchorderdetails
						LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
						LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
						LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
						WHERE purchorders.orddate >='$fromdate'
						 AND purchorders.orddate <='$todate'
						$wherepart
						$wheresupplierid
						$wheresuppliername
						$whereorderno
						$wherelinestatus
						$wherecategory
						ORDER BY " . $_POST['SortBy'];
			} else {
				// Selects by delivery date from grns
				$sql = "SELECT purchorderdetails.orderno,
							   purchorderdetails.itemcode,
							   grns.deliverydate,
							   purchorders.supplierno,
							   purchorders.orddate,
							   grns.qtyrecd as quantityord,
							   grns.quantityinv as qtyinvoiced,
							   (grns.qtyrecd * purchorderdetails.unitprice) as extprice,
							   (grns.qtyrecd * grns.stdcostunit) as extcost,
							   IF(grns.qtyrecd - grns.quantityinv <> 0,'Open','Completed') as linestatus,
							   suppliers.suppname,
							   stockmaster.decimalplaces,
							   stockmaster.description
							   FROM grns
						LEFT JOIN purchorderdetails ON grns.podetailitem = purchorderdetails.podetailitem
						LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
						LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
						LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
						WHERE grns.deliverydate >='$fromdate'
						 AND grns.deliverydate <='$todate'
						$wherepart
						$wheresupplierid
						$wheresuppliername
						$whereorderno
						$wherelinestatus
						$wherecategory
						ORDER BY " . $_POST['SortBy'];
		   }
		} else {
		  // sql for Summary report
		  $orderby = $_POST['SummaryType'];
		  // The following is because the 'extprice' summary is a special case - with the other
		  // summaries, you group and order on the same field; with 'extprice', you are actually
		  // grouping on the stkcode and ordering by extprice descending
		  if ($_POST['SummaryType'] == 'extprice') {
			  $_POST['SummaryType'] = 'itemcode';
			  $orderby = 'extprice DESC';
		  }
		  if ($_POST['DateType'] == 'Order') {
				if ($_POST['SummaryType'] == 'extprice' || $_POST['SummaryType'] == 'itemcode') {
					$sql = "SELECT purchorderdetails.itemcode,
								   SUM(purchorderdetails.quantityord) as quantityord,
								   SUM(purchorderdetails.qtyinvoiced) as qtyinvoiced,
								   SUM(purchorderdetails.quantityord * purchorderdetails.unitprice) as extprice,
								   SUM(purchorderdetails.quantityord * purchorderdetails.stdcostunit) as extcost,
								   stockmaster.decimalplaces,
								   stockmaster.description
								   FROM purchorderdetails
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE purchorders.orddate >='$fromdate'
							 AND purchorders.orddate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							',stockmaster.decimalplaces,
							  stockmaster.description
							ORDER BY ' . $orderby;
			   } elseif ($_POST['SummaryType'] == 'orderno') {
					$sql = "SELECT purchorderdetails.orderno,
								   purchorders.supplierno,
								   SUM(purchorderdetails.quantityord) as quantityord,
								   SUM(purchorderdetails.qtyinvoiced) as qtyinvoiced,
								   SUM(purchorderdetails.quantityord * purchorderdetails.unitprice) as extprice,
								   SUM(purchorderdetails.quantityord * purchorderdetails.stdcostunit) as extcost,
								   suppliers.suppname
								   FROM purchorderdetails
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE purchorders.orddate >='$fromdate'
							 AND purchorders.orddate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							',purchorders.supplierno,
							  suppliers.suppname
							ORDER BY ' . $orderby;
			} elseif ($_POST['SummaryType'] == 'supplierno' || $_POST['SummaryType'] == 'suppname,suppliers.supplierid') {
					$sql = "SELECT purchorders.supplierno,
								   SUM(purchorderdetails.quantityord) as quantityord,
								   SUM(purchorderdetails.qtyinvoiced) as qtyinvoiced,
								   SUM(purchorderdetails.quantityord * purchorderdetails.unitprice) as extprice,
								   SUM(purchorderdetails.quantityord * purchorderdetails.stdcostunit) as extcost,
								   suppliers.suppname
								   FROM purchorderdetails
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE purchorders.orddate >='$fromdate'
							 AND purchorders.orddate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							',purchorders.supplierno,
							  suppliers.suppname
							ORDER BY ' . $orderby;
			} elseif ($_POST['SummaryType'] == 'month') {
					$sql = "SELECT EXTRACT(YEAR_MONTH from purchorders.orddate) as month,
								   CONCAT(MONTHNAME(purchorders.orddate),' ',YEAR(purchorders.orddate)) as monthname,
								   SUM(purchorderdetails.quantityord) as quantityord,
								   SUM(purchorderdetails.qtyinvoiced) as qtyinvoiced,
								   SUM(purchorderdetails.quantityord * purchorderdetails.unitprice) as extprice,
								   SUM(purchorderdetails.quantityord * purchorderdetails.stdcostunit) as extcost
								   FROM purchorderdetails
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE purchorders.orddate >='$fromdate'
							 AND purchorders.orddate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							', monthname
							ORDER BY ' . $orderby;
			} elseif ($_POST['SummaryType'] == 'categoryid') {
					$sql = "SELECT SUM(purchorderdetails.quantityord) as quantityord,
								   SUM(purchorderdetails.qtyinvoiced) as qtyinvoiced,
								   SUM(purchorderdetails.quantityord * purchorderdetails.unitprice) as extprice,
								   SUM(purchorderdetails.quantityord * purchorderdetails.stdcostunit) as extcost,
								   stockmaster.categoryid,
								   stockcategory.categorydescription
								   FROM purchorderdetails
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE purchorders.orddate >='$fromdate'
							 AND purchorders.orddate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							', categorydescription
							ORDER BY ' . $orderby;
			}
		} else {
					// Selects by delivery date from grns
				if ($_POST['SummaryType'] == 'extprice' || $_POST['SummaryType'] == 'itemcode') {
					$sql = "SELECT purchorderdetails.itemcode,
								   SUM(grns.qtyrecd) as quantityord,
								   SUM(grns.quantityinv) as qtyinvoiced,
								   SUM(grns.qtyrecd * purchorderdetails.unitprice) as extprice,
								   SUM(grns.qtyrecd * grns.stdcostunit) as extcost,
								   stockmaster.description
								   FROM grns
							LEFT JOIN purchorderdetails ON grns.podetailitem = purchorderdetails.podetailitem
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE grns.deliverydate >='$fromdate'
							 AND grns.deliverydate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							', stockmaster.description
							ORDER BY ' . $orderby;
				} elseif ($_POST['SummaryType'] == 'orderno') {
					$sql = "SELECT purchorderdetails.orderno,
								   purchorders.supplierno,
								   SUM(grns.qtyrecd) as quantityord,
								   SUM(grns.quantityinv) as qtyinvoiced,
								   SUM(grns.qtyrecd * purchorderdetails.unitprice) as extprice,
								   SUM(grns.qtyrecd * grns.stdcostunit) as extcost,
								   suppliers.suppname
								   FROM grns
							LEFT JOIN purchorderdetails ON grns.podetailitem = purchorderdetails.podetailitem
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE grns.deliverydate >='$fromdate'
							 AND grns.deliverydate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							', purchorders.supplierno,
							   suppliers.suppname
							ORDER BY ' . $orderby;
			} elseif ($_POST['SummaryType'] == 'supplierno' || $_POST['SummaryType'] == 'suppname,suppliers.supplierid') {
					$sql = "SELECT purchorders.supplierno,
								   SUM(grns.qtyrecd) as quantityord,
								   SUM(grns.quantityinv) as qtyinvoiced,
								   SUM(grns.qtyrecd * purchorderdetails.unitprice) as extprice,
								   SUM(grns.qtyrecd * grns.stdcostunit) as extcost,
								   suppliers.suppname
								   FROM grns
							LEFT JOIN purchorderdetails ON grns.podetailitem = purchorderdetails.podetailitem
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE grns.deliverydate >='$fromdate'
							 AND grns.deliverydate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							', purchorders.supplierno,
							   suppliers.suppname
							ORDER BY ' . $orderby;
				} elseif ($_POST['SummaryType'] == 'month') {
					$sql = "SELECT EXTRACT(YEAR_MONTH from purchorders.orddate) as month,
								   CONCAT(MONTHNAME(purchorders.orddate),' ',YEAR(purchorders.orddate)) as monthname,
								   SUM(grns.qtyrecd) as quantityord,
								   SUM(grns.quantityinv) as qtyinvoiced,
								   SUM(grns.qtyrecd * purchorderdetails.unitprice) as extprice,
								   SUM(grns.qtyrecd * grns.stdcostunit) as extcost
								   FROM grns
							LEFT JOIN purchorderdetails ON grns.podetailitem = purchorderdetails.podetailitem
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE grns.deliverydate >='$fromdate'
							 AND grns.deliverydate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							',monthname
							ORDER BY ' . $orderby;
				} elseif ($_POST['SummaryType'] == 'categoryid') {
					$sql = "SELECT stockmaster.categoryid,
								   stockcategory.categorydescription,
								   SUM(grns.qtyrecd) as quantityord,
								   SUM(grns.quantityinv) as qtyinvoiced,
								   SUM(grns.qtyrecd * purchorderdetails.unitprice) as extprice,
								   SUM(grns.qtyrecd * grns.stdcostunit) as extcost
								   FROM grns
							LEFT JOIN purchorderdetails ON grns.podetailitem = purchorderdetails.podetailitem
							LEFT JOIN purchorders ON purchorders.orderno=purchorderdetails.orderno
							LEFT JOIN suppliers ON purchorders.supplierno = suppliers.supplierid
							LEFT JOIN stockmaster ON purchorderdetails.itemcode = stockmaster.stockid
							LEFT JOIN stockcategory ON stockcategory.categoryid = stockmaster.categoryid
							WHERE grns.deliverydate >='$fromdate'
							 AND grns.deliverydate <='$todate'
							$wherepart
							$wheresupplierid
							$wheresuppliername
							$whereorderno
							$wherelinestatus
							$wherecategory
							GROUP BY " . $_POST['SummaryType'] .
							',categorydescription
							ORDER BY ' . $orderby;
				}
			}
		} // End of if ($_POST['ReportType']
		//echo "<br/>$sql<br/>";
		$ErrMsg = _('The SQL to find the parts selected failed with the message');
		$result = DB_query($sql,$db,$ErrMsg);
		$ctr = 0;
		$totalqty = 0;
		$totalextcost = 0;
		$totalextprice = 0;
		$totalinvqty = 0;
		$FileName = $_SESSION['reports_dir'] .'/POReport.csv';
		$FileHandle = fopen($FileName, 'w');
		// Create array for summary type to display in header. Access it with $savesummarytype
		$summary_array["orderno"] =  _('Order Number');
		$summary_array["itemcode"] =  _('Item Number');
		$summary_array["extprice"] =  _('Price');
		$summary_array["supplierno"] =  _('Customer Number');
		$summary_array["suppname"] =  _('Customer Name');
		$summary_array["month"] =  _('Month');
		$summary_array["categoryid"] =  _('Stock Category');

		// Create array for sort for detail report to display in header
		$detail_array['purchorderdetails.orderno'] = _('Order Number');
		$detail_array['purchorderdetails.itemcode'] = _('Item Number');
		$detail_array['suppliers.supplierid,purchorderdetails.orderno'] = _('Supplier Number');
		$detail_array['suppliers.suppname,suppliers.supplierid,purchorderdetails.orderno'] = _('Supplier Name');

		// Display Header info
		if ($_POST['ReportType'] == 'Summary') {
			$sortby_display = $summary_array[$savesummarytype];
		} else {
			$sortby_display = $detail_array[$_POST['SortBy']];
		}
		fprintf($FileHandle, '"'. _('Purchase Order Report') . '","' . $_POST['ReportType'] . ' '._('By').' '.$sortby_display ."\n");
		fprintf($FileHandle, '"'. _('Date Type') . '","' . $_POST['DateType'] . '"'. "\n");
		fprintf($FileHandle, '"'. _('Date Range') . '","' . $_POST['FromDate'] . _(' To ') .  $_POST['ToDate'] . '"'."\n");
		if (strlen(trim($PartNumber)) > 0) {
			fprintf($FileHandle, '"'. _('Item Number') . '","' . $_POST['PartNumberOp'] . ' ' . $_POST['PartNumber'] . '"'."\n");
		}
		if (strlen(trim($_POST['SupplierId'])) > 0) {
			fprintf($FileHandle, '"'. _('Supplier Number') . '","' . $_POST['SupplierIdOp'] . ' ' . $_POST['SupplierId'] . '"'."\n");
		}
		if (strlen(trim($_POST['SupplierName'])) > 0) {
			fprintf($FileHandle, '"'. _('Supplier Name') . '","' . $_POST['SupplierNameOp'] . ' ' . $_POST['SupplierName'] . '"'."\n");
		}
		fprintf($FileHandle, '"'._('Line Item Status') . '","' . $_POST['LineStatus'] . '"'."\n");
		fprintf($FileHandle, '"'. _('Stock Category') . '","' . $_POST['Category'] . '"'."\n");

		if ($_POST['ReportType'] == 'Detail') {
			if ($_POST['DateType'] == 'Order') {
				fprintf($FileHandle, '"%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s"'."\n",
					 _('Order No'),
					 _('Item Number'),
					 _('Order Date'),
					 _('Supplier No'),
					 _('Supplier Name'),
					 _('Order Qty'),
					 _('Cost'),
					 _('Invoiced Qty'),
					 _('Line Status'),
					 _('Item Due'),
					 _('Description'));
					$linectr = 0;
				while ($myrow = DB_fetch_array($result)) {
					$linectr++;
				   // Detail for both DateType of Order
					fprintf($FileHandle, '"%s","%s","%s","%s",%s,%s,%s,%s,"%s","%s","%s"'."\n",
					$myrow['orderno'],
					$myrow['itemcode'],
					ConvertSQLDate($myrow['orddate']),
					$myrow['supplierno'],
					$myrow['suppname'],
					number_format($myrow['quantityord'],$myrow['decimalplaces']),
					number_format($myrow['extprice'],2),
					number_format($myrow['qtyinvoiced'],$myrow['decimalplaces']),
					$myrow['linestatus'],
					ConvertSQLDate($myrow['deliverydate']),
					$myrow['description']);
					$lastdecimalplaces = $myrow['decimalplaces'];
					$totalqty += $myrow['quantityord'];
					$totalextcost += $myrow['extcost'];
					$totalextprice += $myrow['extprice'];
					$totalinvqty += $myrow['qtyinvoiced'];
				} //END WHILE LIST LOOP
				// Print totals
					fprintf($FileHandle, '"%s","%s","%s","%s","%s",%s,%s,%s,%s,"%s","%s"'."\n",
					'Totals',
					_('Lines - ') . $linectr,
					' ',
					' ',
					' ',
					number_format($totalqty,2),
					number_format($totalextcost,2),
					number_format($totalextprice,2),
					number_format($totalinvqty,2),
					' ',
					' ');
			} else {
			  // Header for Date Type of Delivery Date
				fprintf($FileHandle, '"%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s"'."\n",
					 _('Order No'),
					 _('Item Number'),
					 _('Order Date'),
					 _('Supplier No'),
					 _('Supplier Name'),
					 _('Received'),
					 _('Cost'),
					 _('Invoiced Qty'),
					 _('Line Status'),
					 _('Delivered'),
					 _('Description'));
					$linectr = 0;
				while ($myrow = DB_fetch_array($result)) {
					$linectr++;
				   // Detail for both DateType of Ship
				   // In sql, had to alias grns.qtyrecd as quantityord so could use same name here
					fprintf($FileHandle, '"%s","%s","%s","%s",%s,%s,%s,%s,"%s","%s","%s"'."\n",
					$myrow['orderno'],
					$myrow['itemcode'],
					ConvertSQLDate($myrow['orddate']),
					$myrow['supplierno'],
					$myrow['suppname'],
					number_format($myrow['quantityord'],$myrow['decimalplaces']),
					number_format($myrow['extcost'],2),
					number_format($myrow['extprice'],2),
					$myrow['linestatus'],
					ConvertSQLDate($myrow['deliverydate']),
					$myrow['description']);
					$lastdecimalplaces = $myrow['decimalplaces'];
					$totalqty += $myrow['quantityord'];
					$totalextcost += $myrow['extcost'];
					$totalextprice += $myrow['extprice'];
					$totalinvqty += $myrow['qtyinvoiced'];
				} //END WHILE LIST LOOP
				// Print totals
					fprintf($FileHandle, '"%s","%s","%s","%s","%s",%s,%s,%s,%s,"%s","%s"'."\n",
					'Totals',
					_('Lines - ') . $linectr,
					' ',
					' ',
					' ',
					number_format($totalqty,$lastdecimalplaces),
					number_format($totalextcost,2),
					number_format($totalextprice,2),
					number_format($totalinvqty,$lastdecimalplaces),
					" ",
					" ");
			}
		} else {
		  // Print summary stuff
			$summarytype = $_POST['SummaryType'];
			// For SummaryType 'suppname' had to add supplierid to it for the GROUP BY in the sql,
			// but have to take it away for $myrow[$summarytype] to be valid
			// Set up description based on the Summary Type
			if ($summarytype == 'suppname,suppliers.supplierid') {
				$summarytype = 'suppname';
				$description = 'supplierno';
				$summaryheader = _('Supplier Name');
				$descriptionheader = _('Supplier Number');
			}
			if ($summarytype == 'itemcode' || $summarytype == 'extprice') {
				$description = 'description';
				$summaryheader = _('Part Number');
				$descriptionheader = _('Item Description');
			}
			if ($summarytype == 'supplierno') {
				$description = 'suppname';
				$summaryheader = _('Supplier Number');
				$descriptionheader = _('Supplier Name');
			}
			if ($summarytype == 'orderno') {
				$description = 'supplierno';
				$summaryheader = _('Order Number');
				$descriptionheader = _('Supplier Number');
			}
			if ($summarytype == 'categoryid') {
				$description = 'categorydescription';
				$summaryheader = _('Stock Category');
				$descriptionheader = _('Category Description');
			}
			$summarydesc = $summaryheader;
			if ($orderby == 'extprice DESC') {
				$summarydesc = _('Cost');
			}
			if ($summarytype == 'month') {
				$description = 'monthname';
				$summaryheader = _('Month');
				$descriptionheader = _('Month');
			}
			fprintf($FileHandle, '"%s","%s","%s","%s","%s"'."\n",
				 _($summaryheader),
				 _($descriptionheader),
				 _('Quantity'),
				 _('Cost'),
				 _('Invoiced Qty'));

				$suppname = ' ';
				$linectr = 0;
			while ($myrow = DB_fetch_array($result)) {
				$linectr++;
				if ($summarytype == 'orderno') {
					$suppname = $myrow['suppname'];
				}
				fprintf($FileHandle, '"%s","%s",%s,%s,%s,"%s"'."\n",
				$myrow[$summarytype],
				$myrow[$description],
				number_format($myrow['quantityord'],$myrow['decimalplaces']),
				number_format($myrow['extcost'],2),
				number_format($myrow['extprice'],2),
				$suppname);
				print '<br/>';
				$lastdecimalplaces = $myrow['decimalplaces'];
				$totalqty += $myrow['quantityord'];
				$totalextcost += $myrow['extcost'];
				$totalextprice += $myrow['extprice'];
				$totalinvqty += $myrow['qtyinvoiced'];
			} //END WHILE LIST LOOP
			// Print totals
				fprintf($FileHandle, '"%s","%s",%s,%s,%s,%s,"%s"'."\n",
				'Totals',
				_('Lines - ') . $linectr,
				number_format($totalqty,$lastdecimalplaces),
				number_format($totalextcost,2),
				number_format($totalextprice,2),
				number_format($totalinvqty,$lastdecimalplaces),
				' ');
		} // End of if ($_POST['ReportType']
		fclose($FileHandle);
		echo '<div class=centre><p>'._('The report has been exported as a csv file.').'</p>';
		echo '<p><a href="' .  $FileName . '">' . _('click here') . '</a> ' . _('to view the file') . '</div></p>';

	} // End of if inputerror != 1
} // End of function submitcvs()


function display(&$db)  //####DISPLAY_DISPLAY_DISPLAY_DISPLAY_DISPLAY_DISPLAY_#####
{
// Display form fields. This function is called the first time
// the page is called.

	echo "<form action=" . $_SERVER['PHP_SELF'] . "?" . SID ." method=post>";
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';

	echo '<table class=selection>';

	echo '<tr><td>' . _('Report Type') . ':</td>';
	echo "<td><select name='ReportType'>";
	echo "<option selected value='Detail'>" . _('Detail');
	echo "<option value='Summary'>" . _('Summary');
	echo '</select></td><td>&nbsp</td></tr>';

	echo '<tr><td>' . _('Date Type') . ':</td>';
	echo "<td><select name='DateType'>";
	echo "<option selected value='Order'>" . _('Order Date');
	echo "<option value='Delivery'>" . _('Delivery Date');
	echo '</select></td><td>&nbsp</td></tr>';

	echo '<tr>
		<td>' . _('Date Range') . ":</td>
		<td><input type='Text' class=date alt='".$_SESSION['DefaultDateFormat']."' name='FromDate' size=10 maxlength=10 value=" . $_POST['FromDate'] .
		'> ' . _('To') . ":&nbsp&nbsp
		<input type='Text' class=date alt='".$_SESSION['DefaultDateFormat']."' name='ToDate' size=10 maxlength=10 value=" . $_POST['ToDate'] . "></td>
	</tr>";

	echo '<tr><td>' . _('Item Number') . ':</td>';
	echo "<td><select name='PartNumberOp'>";
	echo "<option selected value='Equals'>" . _('Equals');
	echo "<option value='LIKE'>" . _('Begins With');
	echo '</select>';
	echo "&nbsp&nbsp<input type='Text' name='PartNumber' size=20 maxlength=20 value=";
	if (isset($_POST['PartNumber'])) {
		echo $_POST['PartNumber'] . "></td></tr>";
	} else {
		echo "></td></tr>";
	}

	echo '<tr><td>' . _('Supplier Number') . ':</td>';
	echo "<td><select name='SupplierIdOp'>";
	echo "<option selected value='Equals'>" . _('Equals');
	echo "<option value='LIKE'>" . _('Begins With');
	echo '</select>';
	echo "&nbsp&nbsp<input type='Text' name='SupplierId' size=10 maxlength=10 value=";
	if (isset($_POST['SupplierId'])) {
		echo $_POST['SupplierId'] . "></td></tr>";
	} else {
		echo  "></td></tr>";
	}

	echo '<tr><td>' . _('Supplier Name') . ':</td>';
	echo "<td><select name='SupplierNameOp'>";
	echo "<option selected value='LIKE'>" . _('Begins With');
	echo "<option value='Equals'>" . _('Equals');
	echo '</select>';
	echo "&nbsp&nbsp<input type='Text' name='SupplierName' size=30 maxlength=30 value=";
	if (isset($_POST['SupplierName'])) {
		echo $_POST['SupplierName'] . "></td></tr>";
	} else {
		echo  "></td></tr>";
	}

	echo '<tr><td>' . _('Order Number') . ':</td>';
	echo '<td>'._('Equals').':&nbsp&nbsp';
	echo "<input type='Text' name='OrderNo' size=10 maxlength=10 value=";
	if (isset($_POST['OrderNo'])) {
		echo $_POST['OrderNo'] . "></td></tr>";
	} else {
		echo  "></td></tr>";
	}

	echo '<tr><td>' . _('Line Item Status') . ':</td>';
	echo "<td><select name='LineStatus'>";
	echo "<option selected value='All'>" . _('All');
	echo "<option value='Completed'>" . _('Completed');
	echo "<option value='Open'>" . _('Not Completed');
	echo '</select></td><td>&nbsp</td></tr>';

	echo '<tr><td>' . _('Stock Categories') . ":</td><td><select name='Category'>";
	$sql='SELECT categoryid, categorydescription FROM stockcategory';
	$CategoryResult= DB_query($sql,$db);
	echo '<option selected value="All">' . _('All Categories');
	While ($myrow = DB_fetch_array($CategoryResult)){
		echo '<option value="' . $myrow['categoryid'] . '">' . $myrow['categorydescription'];
	}
	echo '</select></td></tr>';

	echo '<tr><td>&nbsp</td></tr>';
	echo '<tr><td>' . _('Sort By') . ':</td>';
	echo "<td><select name='SortBy'>";
	echo "<option selected value='purchorderdetails.orderno'>" . _('Order Number');
	echo "<option value='purchorderdetails.itemcode'>" . _('Item Number');
	echo "<option value='suppliers.supplierid,purchorderdetails.orderno'>" . _('Supplier Number');
	echo "<option value='suppliers.suppname,suppliers.supplierid,purchorderdetails.orderno'>" . _('Supplier Name');
	echo '</select></td><td>&nbsp</td></tr>';

	echo '<tr><td>&nbsp</td></tr>';
	echo '<tr><td>' . _('Summary Type') . ':</td>';
	echo "<td><select name='SummaryType'>";
	echo "<option selected value='orderno'>" . _('Order Number');
	echo "<option value='itemcode'>" . _('Item Number');
	echo "<option value='extprice'>" . _('Cost');
	echo "<option value='supplierno'>" . _('Supplier Number');
	echo "<option value='suppname'>" . _('Supplier Name');
	echo "<option value='month'>" . _('Month');
	echo "<option value='categoryid'>" . _('Stock Category');
	echo '</select></td><td>&nbsp</td></tr>';

	echo "
	<tr><td>&nbsp</td></tr>
	<tr>
		<td colspan=4><div class=centre><input type='submit' name='submit' value='" . _('Run Inquiry') . "'></div></td>
	</tr>
	</table>
	<br/>";
   echo '</form>';

} // End of function display()


include('includes/footer.inc');
?>
