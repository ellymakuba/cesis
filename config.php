<?php
$DefaultLanguage ='en_GB.utf8';
$allow_demo_mode = False;
$host = 'localhost';
$dbType = 'mysqli';
$dbuser = 'root';
$dbpassword = 'root';
putenv('TZ=Africa/Nairobi');
$AllowCompanySelectionBox = false;
$DefaultCompany = 'kipkeino';
$SessionLifeTime = 120;
$MaximumExecutionTime =3000;
$CryptFunction = 'sha1';
$DefaultClock = 12;
$rootpath = dirname($_SERVER['PHP_SELF']);
if (isset($DirectoryLevelsDeep)){
   for ($i=0;$i<$DirectoryLevelsDeep;$i++){
$rootpath = substr($rootpath,0, strrpos($rootpath,'/'));
} }
if ($rootpath == '/' OR $rootpath == '\\') {;
$rootpath = '';
}
error_reporting (E_ALL & ~E_NOTICE);
?>
