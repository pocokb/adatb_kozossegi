<?php
session_start();
require_once('model/norbi.php');

if(isset($_POST['create'])) {
    sendPost($_SESSION['user']['EMAIL'], $_GET['email'], $_POST['value']);

    header("Location: profile.php?email=".$_GET['email']);
    exit();
}

require('view/createPost.template.php');
?>