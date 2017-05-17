<?php
	require_once 'model/sqlcreatedb.php';
	createDB();
	$emberek = getEmberek();
	require_once 'view/createdb.html';
?>