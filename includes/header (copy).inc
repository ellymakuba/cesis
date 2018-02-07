<?php

	$StrictXHTML=False;

	if (!headers_sent()){
		if ($StrictXHTML) {
			header('Content-type: application/xhtml+xml; charset=utf8');
		} else {
			header('Content-type: text/html; charset=utf8');
		}
	}
	echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
			"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">';


	echo '<head><title>' . $title . '</title>';
	if ($StrictXHTML) {
		echo '<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf8" />';
	} else {
		echo '<meta http-equiv="Content-Type" content="application/html; charset=utf8" />';
	}
	echo '<link href="' . $rootpath . '/css/'. $_SESSION['Theme'] .'/default.css" rel="stylesheet" type="text/css" />';
	echo '<script type="text/javascript" src = "'.$rootpath.'/javascripts/MiscFunctions.js"></script>';
	echo '</HEAD>';

	echo '<BODY>';
	echo '<TABLE CLASS="callout_main" CELLPADDING="0" CELLSPACING="0">';
	echo '<TR>';
	echo '<TD COLSPAN="2" ROWSPAN="2">';

	echo '<TABLE CLASS="main_page" ALIGN="right" CELLPADDING="0" CELLSPACING="0">';
	echo '<TR>';
	echo '<TD>';
	echo '<TABLE WIDTH="100%" BORDER="1" CELLPADDING="0" CELLSPACING="0">';
	echo '<TR>';
	echo '<TD CLASS="quick_menu">';


	if (isset($title)) {
		echo '<TABLE CELLPADDING="0" CELLSPACING="0">';
		echo '<TR>';
		
		echo '<TD ALIGN="left" WIDTH="50%" CLASS="quick_menu_left">';
		
		echo '   <a href="' .  $rootpath . '/UserSettings.php?' . SID . '"><img src="'.$rootpath.'/css/'.$theme.'/images/user.png" TITLE="User" ALT="' . _('User') . '"> </img>' . stripslashes($_SESSION['UsersRealName']).' '._('(Edit Profile)') . '</a>';
// Make the title text a class, can be set to display:none is some themes
		echo '</td>';
		
		echo '<TD ALIGN="center" WIDTH="80%" CLASS="quick_menu_left2">';
		echo '' . stripslashes($_SESSION['CompanyRecord']['coyname']) . '';
		echo '</td>';
		
		echo '<TD ALIGN="right">';
		echo '<IMG SRC="' .$rootpath . '/css/' . $theme .'/images/menucurve.gif" WIDTH="30" HEIGHT="30" alt=""></TD>';
		echo '<td class="quick_menu_tabs">';
		echo '<table CELLPADDING="5" CELLSPACING="5" ><tr>';
		echo '<td class="quick_menu_tabs" align="center"><a accesskey="1" href="' .  $rootpath . '/index.php?' . SID . '"><span style="text-decoration:underline;"></span> ' . _('Home Page') . '</a></td>';

		if (count($_SESSION['AllowedPageSecurityTokens'])>1){

			echo '<td class="quick_menu_tabs" align="center"><a accesskey="2" href="' .  $rootpath . '/SelectStudent.php?' . SID . '"><span style="text-decoration:underline;"></span> ' . _('Students') . '</a></td>';

			
		}

		echo '<td class="quick_menu_tabs" align="center"><a accesskey="0" href="' . $rootpath . '/Logout.php?' . SID . '" onclick="return confirm(\'' . _('Are you sure you wish to logout?') . '\');"><span style="text-decoration:underline;"></span> '  . _('Logout') . '</a></td>';

			echo '</TR></TABLE>';
		echo '</TD></TR></TABLE>';

	}

echo '</TD>';
echo '</TR>';
echo '</TABLE>';

?>
