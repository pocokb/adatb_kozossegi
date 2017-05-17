<?php
function createDB(){
	require_once 'sqlconnect.php';
	
	/*
	$query = 'DROP DATABASE NOPROMPT kozossegi';
	oci_execute(oci_parse($conn,$query)) or die();	
	
	$query = 'CREATE DATABASE kozossegi';
	oci_execute(oci_parse($conn,$query)) or die();
	echo "Database created.";
	$query = 'USE kozossegi';
	oci_execute(oci_parse($conn,$query)) or die();		
	/*
	$query = '	DROP TABLE Ember ';				
	oci_execute(oci_parse($conn,$query)) or die();	//bug
	*/
	$query = '	CREATE TABLE Ember(
				nev varchar2(50))';				
	oci_execute(oci_parse($conn,$query)) or die();
	echo "Table:Ember created.";
	
	$query = "	INSERT ALL
					INTO Ember (nev) VALUES ('Laci')
					INTO Ember (nev) VALUES ('Sanyi')
					INTO Ember (nev) VALUES ('Feri')
				SELECT * FROM dual";
	oci_execute(oci_parse($conn,$query)) or die();
	echo "Sample data added to Ember.";

	$query = 'CREATE TABLE Felhasznalo (vezeteknev varchar2(100), keresztnev varchar2(100), szul_dat DATE, nem, email varchar2(100), jelszo varchar2(500), munkahely varchar2(100), iskola varchar2(100))';
	
	oci_execute(oci_parse($conn, $query)) or die();
	echo "Table: Felhasználó created.";

	$query = 'CREATE TABLE Post (id NUMBER,owner_email varchar2(100), content NCLOB, created DATE)';
	oci_execute(oci_parse($conn, $query)) or die();
	echo "Table: Post created.";

	$query = 'CREATE TABLE Komment (post_id NUMBER, owner_email varchar2(100), conent NCLOB, created DATE)';
	oci_execute(oci_parse($conn, $query)) or die();
	echo "Table: Komment created.";
}
	
?>