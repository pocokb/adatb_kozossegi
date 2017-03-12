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
	*/
	$query = '	DROP TABLE Ember ';				
	oci_execute(oci_parse($conn,$query)) or die();	//bug
	
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
	
}
	
?>