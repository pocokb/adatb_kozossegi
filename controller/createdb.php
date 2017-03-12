<?php
	require_once 'model/sqlcreatedb.php';
	require_once 'model/nevek.php';
	createDB();
	$emberek = getEmberek();
	require_once 'view/createdb.html';
?>