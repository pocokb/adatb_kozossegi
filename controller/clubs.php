<?php
require_once 'model/david.php';
//sidebarhoz:
$login = 'pocokb@gmail.com';
$self = getUser($login);
$clubsOfUser = getClubsOfUser($login);
//
if(isset($_GET["name"])){
    $clubNev = $_GET["name"];
    $club = getClub($clubNev);
    if($club){
        $clubMembers = getClubMembers($clubNev);
        include_once 'view/club.html';
    }else{
        include_once 'view/nocontent.html';
    }    
}else{    
    $clubs = getAllClubs();
    include_once 'view/clubs.html';    
}

?>