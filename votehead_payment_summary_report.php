<?php
$PageSecurity = 8;
function getAllVoteHeads($db){
  $sql="SELECT stockid,description FROM stockmaster ORDER BY discontinued";
  $result=DB_query($sql,$db);
  while($rows=DB_fetch_array($result)){
    $voteHeads[]=array("id"=>$rows['stockid'],"desc"=>$rows['description']);
  }
  return $voteHeads;
}
function getVoteHeadPayment($receiptNo,$db){
  $sql="SELECT stockid,
  (SELECT SUM(paid) as paid FROM votehead_payments WHERE receipt_no='".$receiptNo."' AND product=stockid) as paid
  FROM stockmaster ORDER BY discontinued";
  $result=DB_query($sql,$db);
  while($rows=DB_fetch_array($result)){
    $amount[]=array("amount"=>$rows['paid']);
  }
  return $amount;
}
function getVoteHeadTotals($startDate,$endDate,$product,$db){
  $total=0;
  $receipts=getPaymentsMadeWithinPeriod($startDate,$endDate,$db);
  foreach($receipts as $receipt){
    $sql="SELECT SUM(paid) paid FROM votehead_payments WHERE receipt_no='".$receipt['id']."' AND product='".$product."' LIMIT 1";
    $result=DB_query($sql,$db);
    $row=DB_fetch_row($result);
    $total+=$row[0];
  }
  return $total;
}
function getPaymentsMadeWithinPeriod($startDate,$endDate,$db){
  $sql="SELECT id FROM debtortrans WHERE trandate BETWEEN '".FormatDateForSQL($startDate)."' AND '".FormatDateForSQL($endDate)."'
  ORDER BY receipt_no";
  $result=DB_query($sql,$db);
  while($rows=DB_fetch_array($result)){
    $payments[]=array("id"=>$rows['id']);
  }
  return $payments;
}
if (!isset($_POST['Show']) && !isset($_POST['excel'])){
 include ('includes/session.inc');
 $title = _('Period Range Payments');
     include('includes/header.inc');
     echo '<p class="page_title_text"><img src="'.$rootpath.'/css/'.$theme.'/images/money_add.png" title="' .
     	 _('Search') . '" alt="">' . ' ' . $title.'</p>';
   	echo '<form action=' . $_SERVER['PHP_SELF'] . '?' . SID . ' method=post>';
   	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
   	echo '<table>';
   	$SQL = 'SELECT bankaccountname,bankaccounts.accountcode,bankaccounts.currcode	FROM bankaccounts,chartmaster
   	WHERE bankaccounts.accountcode=chartmaster.accountcode';
   	$ErrMsg = _('The bank accounts could not be retrieved because');
   	$DbgMsg = _('The SQL used to retrieve the bank accounts was');
   	$AccountsResults = DB_query($SQL,$db,$ErrMsg,$DbgMsg);

   	echo '<tr><td>' . _('Date From') . ':</td>
   		<td><input type="text" name="datefrom" class="date" alt="'.$_SESSION['DefaultDateFormat'].'" maxlength=10 size=11
   			onChange="isDate(this, this.value, '."'".$_SESSION['DefaultDateFormat']."'".')" value="' .
   				date($_SESSION['DefaultDateFormat']) . '"></td>';
   		echo '<td>' . _('Date To') . ':</td>
   		<td><input type="text" name="dateto" class="date" alt="'.$_SESSION['DefaultDateFormat'].'" maxlength=10 size=11
   			onChange="isDate(this, this.value, '."'".$_SESSION['DefaultDateFormat']."'".')" value="' .
   				date($_SESSION['DefaultDateFormat']) . '"></td>';
   	echo "<td><INPUT TYPE='Submit' NAME='excel' VALUE='" . _('Export To Excel') . "'>";
   	echo '<input type="submit" name="Show" value="' . _('Show transactions'). '"></td>';
   	echo '</tr></table>';
   	echo '</form></br>';
    include('includes/footer.inc');
   }
else if(isset($_POST['Show'])){
  include ('includes/session.inc');
  $title = _('Period Range Payments');
  include('includes/header.inc');
  echo '<p class="page_title_text"><img src="'.$rootpath.'/css/'.$theme.'/images/money_add.png" title="' .
  	 _('Search') . '" alt="">' . ' ' . $title.'</p>';

	if(FormatDateForSQL($_POST['datefrom']) > FormatDateForSQL($_POST['dateto']))
	{
		prnMsg( _('The Start Date Is Greater Than The End Date, Please re-enter Dates'), 'info');
	}
	else
	{
    //$receipts[]=getPaymentsMadeWithinPeriod($_POST['datefrom'],$_POST['dateto']);
    $voteHeads=getAllVoteHeads($db);
    $sql="SELECT id,receipt_no FROM debtortrans WHERE trandate
    BETWEEN '".FormatDateForSQL($_POST['datefrom'])."' AND '".FormatDateForSQL($_POST['dateto'])."'
    ORDER BY receipt_no";
    $result=DB_query($sql,$db);
	 if(DB_num_rows($result)>0){
    echo '<table class=enclosed>';
    echo '<tr><th>ReceiptNo</th>';
    foreach($voteHeads as $head){
      echo '<th>'.$head['desc'].'</th>';
    }
    echo '<th>Total</th>';
    echo '</tr>';
    $totalRow=0;
    while($rows=DB_fetch_array($result)){
      $items=getVoteHeadPayment($rows['id'],$db);
      echo '<tr>';
      echo '<td>'.$rows['receipt_no'].'</td>';
      $lineTotal=0;
      foreach($items as $item){
        echo '<td>'.$item['amount'].'</td>';
        $lineTotal+=$item['amount'];
      }
      echo '<td>'.number_format($lineTotal,2).'</td>';
      echo '</tr>';
      $totalRow+=$lineTotal;
    }
    echo '<tr><td>Totals</td>';
    foreach($voteHeads as $head){
      $total=getVoteHeadTotals($_POST['datefrom'],$_POST['dateto'],$head['id'],$db);
      echo '<td>'.number_format($total,2).'</td>';
    }
    echo '<td>'.number_format($totalRow,2).'</td>';
    echo '</tr>';
    echo '</table>';
	}
  else {
		prnMsg( _('There are no transactions for this account on that day'), 'info');
	}
	echo '<form action=' . $_SERVER['PHP_SELF'] . '?'.SID . ' method=post>';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '<br><div class="centre"><input type="submit" name="Return" value="' . _('Select Another Period'). '"></div>';
	echo '</form>';
}
include('includes/footer.inc');
}
else if(isset($_POST['excel'])){
  include ('includes/session.inc');
  include ('PHPExcel/Classes/PHPExcel.php');
  //require_once '/PHPExcel/Classes/PHPExcel.php';
  $objPHPExcel = new PHPExcel();
  $objPHPExcel->setActiveSheetIndex(0)->setCellValue('C1', 'Vote Head Payments between(MM/DD/YYYY): '.$_POST['datefrom'].' and '.$_POST['dateto'])->mergeCells('C1:I1');;
  $current_col = 0;
  $current_row = 2;
    $voteHeads=getAllVoteHeads($db);
    $sql="SELECT id,receipt_no FROM debtortrans WHERE trandate
    BETWEEN '".FormatDateForSQL($_POST['datefrom'])."' AND '".FormatDateForSQL($_POST['dateto'])."'
    ORDER BY receipt_no";
    $result=DB_query($sql,$db);
    if(DB_num_rows($result)>0){
    $objPHPExcel->getActiveSheet()->setCellValue('A2',"ReceiptNo");
    foreach($voteHeads as $head){
      $current_col++;
      $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow($current_col, $current_row,$head['desc']);
      //$objPHPExcel->getActiveSheet()->getColumnDimension($current_col)->setWidth(50);
    }
    $current_col++;
    $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow($current_col, $current_row,'Total');
    $totalRow=0;
    $current_col = 0;
    while($rows=DB_fetch_array($result)){
      $current_row++;
      $items=getVoteHeadPayment($rows['id'],$db);
      $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow($current_col, $current_row,$rows['receipt_no']);
      $current_col++;
      $lineTotal=0;
      foreach($items as $item){
        $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow($current_col, $current_row,$item['amount']);
        $current_col++;
        $lineTotal+=$item['amount'];
      }
      $totalRow+=$lineTotal;
      $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow($current_col, $current_row,number_format($lineTotal,2));
      $current_col = 0;
    }
    $current_row++;
    $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow($current_col, $current_row,'Totals');
    foreach($voteHeads as $head){
      $total=getVoteHeadTotals($_POST['datefrom'],$_POST['dateto'],$head['id'],$db);
      $current_col++;
      $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow($current_col, $current_row,number_format($total,2));
    }
    $current_col++;
    $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow($current_col, $current_row,number_format($totalRow,2));
  }
  //$objPHPExcel->getActiveSheet()->setCellValue('A8',"Hello\nWorld");
  header('Content-Type: application/vnd.ms-excel');
  header('Content-Disposition: attachment;filename="vote_head_payments.xlsx"');
  $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
  $objWriter->save('php://output');
}
?>
