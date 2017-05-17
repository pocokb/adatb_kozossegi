<!DOCTYPE html>
<?php
session_start();

if(isset($_SESSION['user'])) {
    header("Location: index.php?info=You are already registered.");
    exit();
}
require_once 'model/norbi.php';

function validate_not_null( $value ){
    if($value == null || empty($value) || $value == ""){
        header("Location: registration.php?error=Unexpected input");
        exit();
    }
    return $value;
}

if (isset($_POST['register'])) {
    if($_POST['jelszo'] !== $_POST['jelszo2']){
        header("Location: registration.php?error=>Passwords dont match");
        exit();
        validate_not_null($_POST['jelszo']);
    }
    $user = array();
    $user['vezeteknev'] = validate_not_null($_POST['vezeteknev']);
    $user['keresztnev'] = validate_not_null($_POST['keresztnev']);
    $user['szul_dat'] = date('Y-m-d',strtotime(validate_not_null($_POST['szul_dat'])));
    $user['nem'] = validate_not_null($_POST['nem']);
    $user['email'] = validate_not_null($_POST['email']);
    $user['jelszo'] = md5($_POST['jelszo']);
    $user['munkahely'] = $_POST['munkahely'];
    $user['iskola'] = $_POST['iskola'];

    $_SESSION['user'] = register($user);

    header("Location: index.php?info=Successful registration");
    exit();
}

require('view/registration.template.php');
?>