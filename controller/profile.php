<?php
session_start();
require_once 'model/norbi.php';

if(!isset($_GET['email'])){
    $_GET['email'] = $_SESSION['user']['EMAIL'];
}

$user = getUser($_GET['email']);

function getUserGender($user){
    switch($user["NEM"]){
        case "f":
            return "ferfi";
        break;
        case "n":
            return "nő";
        break;
    }
    return null;
}


require('view/profile.template.php');
?>