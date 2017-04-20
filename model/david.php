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
	$query = 'SELECT klub_nev as nev FROM klub_tagja WHERE tag_email = :email';				
    $st = oci_parse($conn,$query);
	oci_bind_by_name($st, ':email', $email);
    
    oci_execute($st) or die();
	oci_fetch_all($st, $res, null, null, OCI_FETCHSTATEMENT_BY_ROW);    
    
    oci_free_statement($st);
    oci_close($conn);
        
	return $res;   
}

function getClub($nev){
    require 'sqlconnect.php';
	$query = 'SELECT nev,leiras,vezeteknev,keresztnev FROM klub,felhasznalo WHERE nev = :nev AND tulajdonos_email = email';				
	$st = oci_parse($conn,$query);
    oci_bind_by_name($st, ':nev', $nev);
	oci_execute($st) or die();
	$club = oci_fetch_array($st, OCI_ASSOC);
    
    oci_free_statement($st);
    oci_close($conn);
    
    if($club){
        $club['TULAJDONOS'] = $club['VEZETEKNEV'] . ' ' . $club['KERESZTNEV'];    
        return $club;   
    }else{
        return false;
    }    	
}

function getAllClubs(){
    require 'sqlconnect.php';
	$query = 'SELECT * FROM klub ';				
	$st = oci_parse($conn,$query);
	oci_execute($st) or die();
	oci_fetch_all($st, $res, null, null, OCI_FETCHSTATEMENT_BY_ROW);
    
    oci_free_statement($st);
    oci_close($conn);
	return $res;
}
function getClubMembers($nev){
    require 'sqlconnect.php';
	$query = 'SELECT * FROM felhasznalo,klub_tagja WHERE klub_nev = :nev AND tag_email = email';				
	$st = oci_parse($conn,$query);
    oci_bind_by_name($st, ':nev', $nev);
	oci_execute($st) or die();
    
	oci_fetch_all($st, $members, null, null, OCI_FETCHSTATEMENT_BY_ROW);    
    
    oci_free_statement($st);
    oci_close($conn);
	return $members;    
}
function updateClubDescription($nev,$leiras){
    require 'sqlconnect.php';
	$query = 'UPDATE Klub SET leiras =:leiras WHERE nev=:nev';    
	$st = oci_parse($conn,$query);
    oci_bind_by_name($st, ':nev', $nev);
    oci_bind_by_name($st, ':leiras', $leiras);
	oci_execute($st) or die();    
    
    oci_free_statement($st);
    oci_close($conn);	
}
function getClubPosts($nev){
    require 'sqlconnect.php';
	$query = 'SELECT * FROM Uzenofali_uzenet WHERE fogado_email = :nev';				
	$st = oci_parse($conn,$query);
    oci_bind_by_name($st, ':nev', $nev);
	oci_execute($st) or die();
    
	oci_fetch_all($st, $posts, null, null, OCI_FETCHSTATEMENT_BY_ROW);    
    
    oci_free_statement($st);
    oci_close($conn);
	return $posts;  
}
?>