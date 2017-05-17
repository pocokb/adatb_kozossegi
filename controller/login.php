<?php
session_start();
require_once 'model/norbi.php';

function validate_not_null($value) {
    if($value == null || empty($value) || $value == ""){
        echo '<h1>Unexpected input.</h1>';
        exit();
    }
    return $value;
}

if (isset($_POST['login'])) {
    $email = validate_not_null($_POST['email']);
    validate_not_null($_POST['jelszo']);
    $jelszo = md5($_POST['jelszo']);
    $_SESSION['user'] = authenticate($email, $jelszo);

    if($_SESSION['user'] == null) {
        header("Location: login.php?error=Wrong email / password combination.");
    } else {
        header("Location: index.php");
    }
}


require('view/login.template.php');
?>