<?php
include('Numbers/Words.php');
$NumberWords = New Numbers_Words;
echo $NumberWords->toWords(2345,'fr_FR.utf8');
?>