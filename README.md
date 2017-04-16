# adatb_kozossegi
Adatbázis alapú rendszerek 2016-17 Kötelező program : Közösségi oldal

Deployment:
Kapcsolódás az adatbázishoz (windows 10-en tesztelve):  
1. Putty letöltés és beállítása:
  - letöltés : http://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html
  - session: host: linux.inf.u-szeged.hu
  - ssh/tunnels:
    * source port: 1521
    * destination: orania.inf.u-szeged.hu:1521
    * Add
  - connection: seconds between keepalive: 60
  - session: 
    * Saved sessions-hoz beirni egy nevet pl.: oracle
    * Save
  - jelentkezz be és hagyd nyitva az ablakot. ahhoz hogy az adatbázishoz csatlakozni tudjon a weboldal ennek folyamat nyitva kell lennie.

2. Webserver:
  - Instant client letöltés, kicsomagolás. http://www.oracle.com/technetwork/topics/winsoft-085727.html (a legfelső 32 bites basic kell)(regisztrálni kell az oreclehöz)
  - PATH-hoz hozzáadni a kicsomagolt mappát. 
  - xampp-ot felrakni https://www.apachefriends.org/hu/
  - xampp/php/php.ini-ben kivenni a ;-t a php_pdo_oci és az php_oci8_12c dll-ek elől.
  - xampp/php/php.ini-ben a UNIX-os include_path elé rakj ;-t és a windows-os elől vedd ki a ;-t, majd írd át a weboldal legkülső mappájára Pl: "C:\david\adatb_kozossegi"  
  - xampp/apache/conf/httpd.conf-ban a document root-ot és alatta a directory-t írd át a weboldalunk index.php fájljának mappájára. Pl: "C:\david\adatb_kozossegi\controller"
  - httpd-t újraindítani
  - KÉSZ!
