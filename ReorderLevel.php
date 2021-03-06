<?php

/* $Id: ReorderLevel.php 3954 2010-09-30 15:22:52Z tim_schofield $*/

/* $Revision: 1.6 $ */

// ReorderLevel.php - Report of parts with quantity below reorder level
// Shows if there are other locations that have quantities for the parts that are short
$PageSecurity = 2;
include('includes/session.inc');
If (isset($_POST['PrintPDF'])) {

	include('includes/PDFStarter.php');
	$pdf->addInfo('Title',_('Reorder Level Report'));
	$pdf->addInfo('Subject',_('Parts below reorder level'));
    $FontSize=9;
	$PageNumber=1;
	$line_height=12;

	$Xpos = $Left_Margin+1;
	$wherecategory = " ";
	$catdescription = " ";
	if ($_POST['StockCat'] != 'All') {
	    $wherecategory = " AND stockmaster.categoryid='" . $_POST['StockCat'] . "' ";
		$sql= "SELECT categoryid, categorydescription FROM stockcategory WHERE categoryid='" . $_POST['StockCat'] . "' ";
		$result = DB_query($sql,$db);
		$myrow = DB_fetch_row($result);
		$catdescription = $myrow[1];
	}
	$wherelocation = " ";
	if ($_POST['StockLocation'] != 'All') {
	    $wherelocation = " AND locstock.loccode='" . $_POST['StockLocation'] . "' ";
	}

	$sql = "SELECT locstock.stockid,
				stockmaster.description,
				locstock.loccode,
				locations.locationname,
				locstock.quantity,
				locstock.reorderlevel,
				stockmaster.decimalplaces,
				stockmaster.serialised,
				stockmaster.controlled
			FROM locstock,
				stockmaster,
				locations
			WHERE locstock.stockid=stockmaster.stockid " .
			$wherelocation .
			"AND locstock.loccode=locations.loccode
			AND locstock.reorderlevel > locstock.quantity
			AND (stockmaster.mbflag='B' OR stockmaster.mbflag='M') " .
			$wherecategory . " ORDER BY locstock.loccode,locstock.stockid";

	$result = DB_query($sql,$db,'','',false,true);

	if (DB_error_no($db) !=0) {
	  $title = _('Reorder Level') . ' - ' . _('Problem Report');
	  include('includes/header.inc');
	   prnMsg( _('The Reorder Level report could not be retrieved by the SQL because') . ' '  . DB_error_msg($db),'error');
	   echo "<br><a href='" .$rootpath .'/index.php?' . SID . "'>" . _('Back to the menu') . '</a>';
	   if ($debug==1){
	      echo "<br>$sql";
	   }
	   include('includes/footer.inc');
	   exit;
	}

	PrintHeader($pdf,$YPos,$PageNumber,$Page_Height,$Top_Margin,$Left_Margin,
	            $Page_Width,$Right_Margin,$catdescription);

    $FontSize=8;

    $ListCount = 0; // UldisN

	While ($myrow = DB_fetch_array($result,$db)){
			$YPos -=(2 * $line_height);

            $ListCount ++;

			// Parameters for addTextWrap are defined in /includes/class.pdf.php
			// 1) X position 2) Y position 3) Width
			// 4) Height 5) Text 6) Alignment 7) Border 8) Fill - True to use SetFillColor
			// and False to set to transparent
			$fill = '';
			$pdf->addTextWrap(50,$YPos,100,$FontSize,$myrow['stockid'],'',0,$fill);
			$pdf->addTextWrap(150,$YPos,150,$FontSize,$myrow['description'],'',0,$fill);
			$pdf->addTextWrap(310,$YPos,60,$FontSize,$myrow['loccode'],'left',0,$fill);
			$pdf->addTextWrap(370,$YPos,50,$FontSize,number_format($myrow['quantity'],
			                                    $myrow['decimalplaces']),'right',0,$fill);
			$pdf->addTextWrap(420,$YPos,50,$FontSize,number_format($myrow['reorderlevel'],
			                                    $myrow['decimalplaces']),'right',0,$fill);
			$shortage = $myrow['reorderlevel'] - $myrow['quantity'];
			$pdf->addTextWrap(470,$YPos,50,$FontSize,number_format($shortage,
			                                    $myrow['decimalplaces']),'right',0,$fill);

			if ($YPos < $Bottom_Margin + $line_height){
			   PrintHeader($pdf,$YPos,$PageNumber,$Page_Height,$Top_Margin,$Left_Margin,$Page_Width,
			               $Right_Margin,$catdescription);
			}

            	// Print if stock for part in other locations
            	$sql2 = "SELECT locstock.quantity,
            	                locstock.loccode,
            	                locstock.reorderlevel,
            	                stockmaster.decimalplaces
            	         FROM locstock, stockmaster
            	         WHERE locstock.quantity > 0
            	         AND locstock.quantity > reorderlevel
            	         AND locstock.stockid = stockmaster.stockid
            	         AND locstock.stockid ='" . $myrow['stockid'] .
            	         "' AND locstock.loccode !='" . $myrow['loccode'] . "'";
            	$otherresult = DB_query($sql2,$db,'','',false,true);
            	While ($myrow2 = DB_fetch_array($otherresult,$db)){
					$YPos -=$line_height;

					// Parameters for addTextWrap are defined in /includes/class.pdf.php
					// 1) X position 2) Y position 3) Width
					// 4) Height 5) Text 6) Alignment 7) Border 8) Fill - True to use SetFillColor
					// and False to set to transparent

						$pdf->addTextWrap(310,$YPos,60,$FontSize,$myrow2['loccode'],'left',0,$fill);
						$pdf->addTextWrap(370,$YPos,50,$FontSize,number_format($myrow2['quantity'],
															$myrow2['decimalplaces']),'right',0,$fill);
						$pdf->addTextWrap(420,$YPos,50,$FontSize,number_format($myrow2['reorderlevel'],
				                                    $myrow2['decimalplaces']),'right',0,$fill);

					if ($YPos < $Bottom_Margin + $line_height){
					   PrintHeader($pdf,$YPos,$PageNumber,$Page_Height,$Top_Margin,$Left_Margin,$Page_Width,
								   $Right_Margin,$catdescription);
					}

				} /*end while loop */

	} /*end while loop */

	if ($YPos < $Bottom_Margin + $line_height){
	       PrintHeader($pdf,$YPos,$PageNumber,$Page_Height,$Top_Margin,$Left_Margin,$Page_Width,
	                   $Right_Margin,$catdescription);
	}
/*Print out the grand totals */

	//$pdfcode = $pdf->output();
	//$len = strlen($pdfcode);

	if ($ListCount == 0){
			$title = _('Print Reorder Level Report');
			include('includes/header.inc');
			prnMsg(_('There were no items with demand greater than supply'),'error');
			echo "<br><a href='$rootpath/index.php?" . SID . "'>" . _('Back to the menu') . '</a>';
			include('includes/footer.inc');
			exit;
	} else {
/*
			header('Content-type: application/pdf');
			header("Content-Length: " . $len);
			header('Content-Disposition: inline; filename=ReorderLevel.pdf');
			header('Expires: 0');
			header('Cache-Control: private, post-check=0, pre-check=0');
			header('Pragma: public');

    		$pdf->Output('ReOrderLevel.pdf', 'I');
*/
            $pdf->OutputI($_SESSION['DatabaseName'] . '_ReOrderLevel_' . date('Y-m-d') . '.pdf');//UldisN
            $pdf->__destruct(); //UldisN
	}

} else { /*The option to print PDF was not hit so display form */

	$title=_('Reorder Level Reporting');
	include('includes/header.inc');
	echo '<p class="page_title_text"><img src="'.$rootpath.'/css/'.$theme.'/images/inventory.png" title="' . _('Inventory') . '" alt="" />' . ' ' . _('Inventory Reorder Level Report') . '</p>';
	echo '<div class="page_help_text">' . _('Use this report to display the reorder levels for Inventory items in different categories.') . '</div><br>';

	echo '</br></br><form action=' . $_SERVER['PHP_SELF'] . " method='post'><table>";
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	$sql = "SELECT loccode,
			locationname
		FROM locations";
	$resultStkLocs = DB_query($sql,$db);
	echo '<table class=selection><tr><td>' . _('From Stock Location') . ':</td><td><select name="StockLocation"> ';
	if (!isset($_POST['StockLocation'])){
		$_POST['StockLocation']='All';
	}
	if ($_POST['StockLocation']=='All'){
		echo '<option selected value="All">' . _('All');
	} else {
		echo '<option value="All">' . _('All');
	}
	while ($myrow=DB_fetch_array($resultStkLocs)){
		if ($myrow['loccode'] == $_POST['StockLocation']){
			 echo '<option selected Value="' . $myrow['loccode'] . '">' . $myrow['locationname'];
		} else {
			 echo '<option Value="' . $myrow['loccode'] . '">' . $myrow['locationname'];
		}
	}
	echo '</select></td></tr>';

	$SQL="SELECT categoryid, categorydescription FROM stockcategory ORDER BY categorydescription";
	$result1 = DB_query($SQL,$db);
	if (DB_num_rows($result1)==0){
		echo '</table></td></tr>
			</table>
			<p>';
		prnMsg(_('There are no stock categories currently defined please use the link below to set them up'),'warn');
		echo '<br><a href="' . $rootpath . '/StockCategories.php?' . SID .'">' . _('Define Stock Categories') . '</a>';
		include ('includes/footer.inc');
		exit;
	}

	echo '<tr><td>' . _('In Stock Category') . ':</td><td><select name="StockCat">';
	if (!isset($_POST['StockCat'])){
		$_POST['StockCat']='All';
	}
	if ($_POST['StockCat']=='All'){
		echo '<option selected value="All">' . _('All');
	} else {
		echo '<option value="All">' . _('All');
	}
	while ($myrow1 = DB_fetch_array($result1)) {
		if ($myrow1['categoryid']==$_POST['StockCat']){
			echo '<option selected value="' . $myrow1['categoryid'] . '">' . $myrow1['categorydescription'];
		} else {
			echo '<option value="' . $myrow1['categoryid'] . '">' . $myrow1['categorydescription'];
		}
	}
	echo '</select></td></tr>';
	echo "</table><br /><div class='centre'><input type=submit name='PrintPDF' value='" . _('Print PDF') . "'></div>";

	include('includes/footer.inc');

} /*end of else not PrintPDF */

function PrintHeader(&$pdf,&$YPos,&$PageNumber,$Page_Height,$Top_Margin,$Left_Margin,
                     $Page_Width,$Right_Margin,$catdescription) {

	/*PDF page header for Reorder Level report */
	if ($PageNumber>1){
		$pdf->newPage();
	}
	$line_height=12;
	$FontSize=9;
	$YPos= $Page_Height-$Top_Margin;

	$pdf->addTextWrap($Left_Margin,$YPos,300,$FontSize,$_SESSION['CompanyRecord']['coyname']);

	$YPos -=$line_height;

	$pdf->addTextWrap($Left_Margin,$YPos,150,$FontSize,_('Reorder Level Report'));
	$pdf->addTextWrap($Page_Width-$Right_Margin-150,$YPos,160,$FontSize,_('Printed') . ': ' .
		 Date($_SESSION['DefaultDateFormat']) . '   ' . _('Page') . ' ' . $PageNumber,'left');
	$YPos -= $line_height;
	$pdf->addTextWrap($Left_Margin,$YPos,50,$FontSize,_('Category'));
	$pdf->addTextWrap(95,$YPos,50,$FontSize,$_POST['StockCat']);
	$pdf->addTextWrap(160,$YPos,150,$FontSize,$catdescription,'left');
	$YPos -= $line_height;
	$pdf->addTextWrap($Left_Margin,$YPos,50,$FontSize,_('Location'));
	$pdf->addTextWrap(95,$YPos,50,$FontSize,$_POST['StockLocation']);
	$YPos -=(2*$line_height);

	/*set up the headings */
	$Xpos = $Left_Margin+1;

	$pdf->addTextWrap(50,$YPos,100,$FontSize,_('Part Number'), 'left');
	$pdf->addTextWrap(150,$YPos,150,$FontSize,_('Description'), 'left');
	$pdf->addTextWrap(310,$YPos,60,$FontSize,_('Location'), 'left');
	$pdf->addTextWrap(370,$YPos,50,$FontSize,_('Quantity'), 'right');
	$pdf->addTextWrap(420,$YPos,50,$FontSize,_('Reorder'), 'right');
	$pdf->addTextWrap(470,$YPos,50,$FontSize,_('Needed'), 'right');
	$YPos -= $line_height;
	$pdf->addTextWrap(415,$YPos,50,$FontSize,_('Level'), 'right');


	$FontSize=8;
//	$YPos =$YPos - (2*$line_height);
	$PageNumber++;
} // End of PrintHeader() function
?>