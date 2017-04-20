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
        if(isset($_POST["leiras"])){
            updateClubDescription($clubNev,$_POST["leiras"]);
            
        }        
        $club = getClub($clubNev);
        $clubMembers = getClubMembers($clubNev);
        $clubPosts = getClubPosts($clubNev);
        include_once 'view/editclub.html';
    }else{        
        include_once 'view/nocontent.html';
    }    
}else{        
    include_once 'view/nocontent.html';
}

?>