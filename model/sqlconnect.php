<?php
$tns = "
(DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = 127.0.0.1)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SID = kabinet)
    )
  )";
  
$username = 'h973833';
$password = 'kozos123';
$conn = oci_connect('SYSTEM', 'asd','localhost/xe','UTF8') or die();
?>