<?php
function getUsers(){
	require 'sqlconnect.php';
	$query = 'SELECT * FROM Felhasznalo ';				
	$st = oci_parse($conn,$query);
	oci_execute($st) or die();
	oci_fetch_all($st, $res, null, null, OCI_FETCHSTATEMENT_BY_ROW);
	return $res;		
}

	
?>