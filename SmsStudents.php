<?php
$PageSecurity = 5;
include('includes/DefineCartClass.php');
include('includes/DefineSerialItems.php');
include('includes/session.inc');
$title = _('Fee Structure');
include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc');
include('includes/GetSalesTransGLCodes.inc');
 require_once('AfricasTalkingGateway.php');
echo '<p class="page_title_text">' . ' ' . _('Send Class SMS') . '';
if (isset($_POST['sendMessage']))
{
$username   = "emakuba";
$apikey     = "76855f9038ca7ef116cdde867c48bf3b67af8cdba9127ca2bb5194ab35b73346";
$recipients = "+254702970522";
$gateway    = new AfricasTalkingGateway($username, $apikey);
try
    {
      // Thats it, hit send and we'll take care of the rest.
      $results = $gateway->sendMessage($recipients, $_POST['text']);
      foreach($results as $result) {
        // status is either "Success" or "error message"
        /*echo " Number: " .$result->number;
        echo " Status: " .$result->status;
        echo " MessageId: " .$result->messageId;
        echo " Cost: "   .$result->cost."\n";*/
      }
      echo "</br>Message(s) sent successfully";
    }
    catch ( AfricasTalkingGatewayException $e )
    {
      echo "Encountered an error while sending: ".$e->getMessage();
    }

}
echo "<form method='post' action=" . $_SERVER['PHP_SELF'] . '>';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
echo '<table class="enclosed">';
echo '<tr><td>' . _('Class') . ":</td>
<td><select name='class_id'>";
echo '<OPTION SELECTED VALUE=0>' . _('Select Class');
$sql="SELECT * FROM gradelevels WHERE id !=11 ORDER BY grade_level";
$result=DB_query($sql,$db);
while ($myrow = DB_fetch_array($result)) {
echo '<option value='. $myrow['id'] . '>' . $myrow['grade_level'];
} //end while loop
echo '</select></td></tr>';
echo '<tr><td>Text:</td><td><textarea name="text" rows="4" cols="150"></textarea></td></tr>';
echo '</table>';
echo '<table class="enclosed">';
echo "<div class='centre'><input  type='Submit' name='sendMessage' value='" . _('Send Message') . "'></div>";
echo "</form>";
include('includes/footer.inc');
?>
