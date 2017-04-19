<?php
function getUsers(){
	require 'sqlconnect.php';
	$query = 'SELECT * FROM Felhasznalo ';				
	$st = oci_parse($conn,$query);
	oci_execute($st) or die();
	oci_fetch_all($st, $res, null, null, OCI_FETCHSTATEMENT_BY_ROW);
    
    oci_free_statement($st);
    oci_close($conn);
	return $res;		
}
function getUser($email){
	require 'sqlconnect.php';
	$query = 'SELECT * FROM Felhasznalo WHERE email = :email';				
	$st = oci_parse($conn,$query);
    oci_bind_by_name($st, ':email', $email);
	oci_execute($st) or die();
	$user = oci_fetch_array($st, OCI_ASSOC);
    
    oci_free_statement($st);
    oci_close($conn);
	return $user;		
}
function getClubsOfUser($email){
    require 'sqlconnect.php';
	$query = 'SELECT klub_nev FROM klub_tagja WHERE tag_email = :email';				
    $st = oci_parse($conn,$query);
	oci_bind_by_name($st, ':email', $email);
    
    oci_execute($st) or die();
	oci_fetch_all($st, $res, null, null, OCI_FETCHSTATEMENT_BY_ROW);    
    
    oci_free_statement($st);
    oci_close($conn);
        
	return $res;   
}
?>