<?php
function getEmberek(){
	require 'sqlconnect.php';
	$query = 'SELECT * FROM Ember ';				
	$st = oci_parse($conn,$query);
	oci_execute($st) or die();		
	return $st;		
}
	
?>