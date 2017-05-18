<?php
require_once 'model/norbi.php';

$posts = getPosts($_SESSION['user']['EMAIL']);

require('view/posts.template.php');
?>