# adatb_kozossegi
Adatbázis alapú rendszerek 2016-17 Kötelező program : Közösségi oldal

Deployment:
Kapcsolódás az adatbázishoz:  
1. Putty letöltés és beállítása:
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
  - Instant client letöltés, kicsomagolás. http://www.oracle.com/technetwork/topics/winsoft-085727.html
SDK ugyaninnen. (Ez talán kihagyható lépés)
  - PATH-hoz hozzáadni a mappát. (az sdk mappája nem kell)
  - xampp-ot felrakni, figyelni ha az apache 32 bites akkor az instant client is az legyen.
  - xampp/php/php.ini-ben kivenni a ;-t a pdo_oci és az oci dll-ek elől.
  - xampp/apache/conf/httpd.conf-ban átírni a document root-ot és alatta a directory-t a weboldalunk index.php fájljának mappájára. Pl: "C:\david\adatb_kozossegi\controller"
  - httpd-t újraindítani
  


httpd.conf document root
php.ini include path
