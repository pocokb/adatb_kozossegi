<?php
require_once 'model/david.php';
$login = 'pocokb@gmail.com';
$users = getUsers();
$self = getUser($login);
$clubsOfUser = getClubsOfUser($login);
include_once 'view/index.html';
?>