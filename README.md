# adatb_kozossegi
Adatbázis alapú rendszerek 2016-17 Kötelező program : Közösségi oldal

Deployment:
Kapcsolódás az adatbázishoz:  
1. Putty letöltés és beállítása:
  - session: host: linux.inf.u-szeged.hu
  - ssh/tunnels: * source port: 1521
                 * destination: orania.inf.u-szeged.hu:1521
                 * Add
  - connection: seconds between keepalive: 60
  - session: * Saved sessions-hoz beirni egy nevet pl.: oracle
             * Save
  - jelentkezz be és hagyd nyitva az ablakot. ahhoz hogy az adatbázishoz csatlakozni tudjon a weboldal ennek folyamat nyitva kell lennie.

2. Webserver:
  a. 


httpd.conf document root
php.ini include path
