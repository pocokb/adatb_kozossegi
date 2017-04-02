begin
  FOR c IN (SELECT table_name FROM user_tables) LOOP
    EXECUTE IMMEDIATE ('DROP TABLE "' || c.table_name || '" CASCADE CONSTRAINTS');
  END LOOP;
  for i in (select 'drop '||object_type||' '|| object_name ||'' tbl from user_objects where object_type in ('SEQUENCE', 'TRIGGER')) loop
     execute immediate i.tbl;
  end loop;
end;
/

CREATE TABLE Felhasznalo(
	email varchar2(40) not null PRIMARY KEY,
	jelszo raw(16) not null,
	vezeteknev varchar2(40) not null,
	keresztnev varchar2(40) not null,
	szul_datom date,
	nem varchar2(20),
	munkahely varchar2(60),
	iskola varchar2(60),
	letrehozva timestamp(0) not null,
	meghivott_ismerosok_szama number(10) not null
);


CREATE TABLE Album(
	cim varchar2(40) not null,
	leiras varchar2(4000) not null,
	tulajdonos_email varchar2(40) not null REFERENCES Felhasznalo(email),
	PRIMARY KEY (cim,tulajdonos_email)
);


CREATE TABLE Fenykep(
	link varchar2(60) not null PRIMARY KEY,
	cim varchar2(40) not null,
	letrehozva timestamp(0) not null,
	meret number(4) not null,
	tulajdonos_email varchar2(40) not null REFERENCES Felhasznalo(email)
);


CREATE TABLE Album_fenykep(
	tulajdonos_email varchar2(40) not null,
	album_cim varchar2(40) not null,
	fenykep_link varchar2(60) not null REFERENCES Fenykep(link),
  FOREIGN KEY (tulajdonos_email, album_cim) REFERENCES Album(tulajdonos_email, cim),
	PRIMARY KEY (tulajdonos_email,album_cim,fenykep_link)
);


CREATE TABLE Ismeri(
	email_1 varchar2(40) not null REFERENCES Felhasznalo(email),
	email_2 varchar2(40) not null REFERENCES Felhasznalo(email),
	kezdete timestamp(0) not null,
	PRIMARY KEY (email_1,email_2)
);


CREATE TABLE Ismerosnek_jelol(
	jelolo_email varchar2(40) not null REFERENCES Felhasznalo(email),
	jelolt_email varchar2(40) not null REFERENCES Felhasznalo(email),
	PRIMARY KEY (jelolo_email,jelolt_email)
);


CREATE TABLE Klub(
	nev varchar2(60) not null PRIMARY KEY,
	leiras varchar2(4000) not null
);


CREATE TABLE Klub_tagja(
	klub_nev varchar2(60) not null,
	tag_email varchar2(60) not null REFERENCES Felhasznalo(email),
	PRIMARY KEY(klub_nev,tag_email)
);


CREATE TABLE Privat_uzenet(
	id NUMBER(10) not null PRIMARY KEY,
	szoveg varchar2(400) not null,
	letrehozva timestamp(0) not null,
	kuldo_email varchar2(40) not null REFERENCES Felhasznalo(email),
	fogado_email varchar2(40) not null REFERENCES Felhasznalo(email)
);
CREATE SEQUENCE privat_uzenet_seq START WITH 1;
CREATE OR REPLACE TRIGGER privat_uzenet_bir 
  BEFORE INSERT ON Privat_uzenet 
  FOR EACH ROW
BEGIN
  :new.id := privat_uzenet_seq.NEXTVAL;
END;
/

CREATE TABLE Uzenofali_uzenet(
	id NUMBER(10) not null PRIMARY KEY,
	szoveg varchar2(400) not null,
	letrehozva timestamp(0) not null,
	kuldo_email varchar2(40) not null REFERENCES Felhasznalo(email),
	fogado_email varchar2(40) not null REFERENCES Felhasznalo(email)
);
CREATE SEQUENCE uzenofali_uzenet_seq START WITH 1;
CREATE OR REPLACE TRIGGER uzenofali_uzenet_bir 
  BEFORE INSERT ON Uzenofali_uzenet 
  FOR EACH ROW
BEGIN
  :new.id := uzenofali_uzenet_seq.NEXTVAL;
END;
/


CREATE TABLE Komment(
	id NUMBER(10) not null PRIMARY KEY,
	szoveg varchar2(400) not null,
	letrehozva timestamp(0) not null,
	iro_email varchar2(40) not null REFERENCES Felhasznalo(email),
	tipus varchar2(40) not null,
	uzenofali_uzenet_id number(4) REFERENCES Uzenofali_uzenet(id),
	fenykep_link varchar2(60) REFERENCES Fenykep(link)
);
CREATE SEQUENCE komment_seq START WITH 1;
CREATE OR REPLACE TRIGGER komment_bir 
  BEFORE INSERT ON Komment 
  FOR EACH ROW
BEGIN
  :new.id := komment_seq.NEXTVAL;
END;
/

CREATE TABLE Meghivo(
	email varchar2(40) not null PRIMARY KEY,
	elfogadta  char(1) DEFAULT 'N' not null check (elfogadta in ( 'Y', 'N' )),
	letrehozva timestamp(0) not null,
	kuldo_email varchar2(40) not null REFERENCES Felhasznalo(email),
	fogado_email varchar2(40) REFERENCES Felhasznalo(email)
);

INSERT INTO Felhasznalo VALUES ('pocokb@gmail.com','745a02903f2a8e15f6bb833830d064e6','Bencsik','Dávid',TO_DATE('1989-04-13','YYYY-MM-DD'),'férfi','MÁV','SZTE',CURRENT_TIMESTAMP(0), 2 );
INSERT INTO Felhasznalo VALUES ('rozsa.regina.ta@gmail.com','dad3a37aa9d50688b5157698acfd7aee','Rózsa','Regina',TO_DATE('1992-02-22','YYYY-MM-DD'),'nő','Múzeumshop','MOME',CURRENT_TIMESTAMP(0), 0 );
INSERT INTO Felhasznalo VALUES ('lali@gmail.com','0cc175b9c0f1b6a831c399e269772661','Csóró','Lali',TO_DATE('1967-06-11','YYYY-MM-DD'),'férfi','MÁV',Null,CURRENT_TIMESTAMP(0), 0 );
INSERT INTO Felhasznalo VALUES ('ewin@vipmail.com','4124bc0a9335c27f086f24ba207a4912','Kovács','Éva',TO_DATE('1977-04-15','YYYY-MM-DD'),'nő','Fővárosi nagycirkusz','BME',CURRENT_TIMESTAMP(0), 0 );
INSERT INTO Felhasznalo VALUES ('feri@gmail.com','47bce5c74f589f4867dbd57e9ca9f808','Nagy','Feró',TO_DATE('1995-04-22','YYYY-MM-DD'),'férfi','MÁV','SZTE',CURRENT_TIMESTAMP(0), 0 );
INSERT INTO Felhasznalo VALUES ('karoly12@gmail.com','74b87337454200d4d33f80c4663dc5e5','Sós','Károly',TO_DATE('1911-04-27','YYYY-MM-DD'),'férfi','MÁV','MOME',CURRENT_TIMESTAMP(0), 0 );

INSERT INTO Privat_uzenet VALUES (1,'Szia!',CURRENT_TIMESTAMP(0),'pocokb@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (2,'Hi!',CURRENT_TIMESTAMP(0),'lali@gmail.com','pocokb@gmail.com');
INSERT INTO Privat_uzenet VALUES (3,'Mi a pálya?',CURRENT_TIMESTAMP(0),'pocokb@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (4,'Nincs sok, veled?',CURRENT_TIMESTAMP(0),'lali@gmail.com','pocokb@gmail.com');
INSERT INTO Privat_uzenet VALUES (5,'Áh semmi',CURRENT_TIMESTAMP(0),'pocokb@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (6,'Szereted a sört?',CURRENT_TIMESTAMP(0),'lali@gmail.com','pocokb@gmail.com');
INSERT INTO Privat_uzenet VALUES (7,'Jóhogy!',CURRENT_TIMESTAMP(0),'pocokb@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (8,'És a bort?',CURRENT_TIMESTAMP(0),'lali@gmail.com','pocokb@gmail.com');
INSERT INTO Privat_uzenet VALUES (9,'Áh azt nem',CURRENT_TIMESTAMP(0),'pocokb@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (10,'De miért nem?',CURRENT_TIMESTAMP(0),'lali@gmail.com','pocokb@gmail.com');
INSERT INTO Privat_uzenet VALUES (11,'Hát mert az rossz',CURRENT_TIMESTAMP(0),'pocokb@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (12,'jaok',CURRENT_TIMESTAMP(0),'lali@gmail.com','pocokb@gmail.com');
INSERT INTO Privat_uzenet VALUES (13,'És milyen volt jateba?',CURRENT_TIMESTAMP(0),'pocokb@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (14,'Berugtunk',CURRENT_TIMESTAMP(0),'lali@gmail.com','pocokb@gmail.com');
INSERT INTO Privat_uzenet VALUES (15,'Nah az jo',CURRENT_TIMESTAMP(0),'pocokb@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (16,'Fos volt a zene',CURRENT_TIMESTAMP(0),'lali@gmail.com','pocokb@gmail.com');
INSERT INTO Privat_uzenet VALUES (17,'Mindig az',CURRENT_TIMESTAMP(0),'pocokb@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (18,'Ohigen',CURRENT_TIMESTAMP(0),'lali@gmail.com','pocokb@gmail.com');
INSERT INTO Privat_uzenet VALUES (19,'De néha van koncert',CURRENT_TIMESTAMP(0),'pocokb@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (20,'Ja néha',CURRENT_TIMESTAMP(0),'lali@gmail.com','pocokb@gmail.com');
INSERT INTO Privat_uzenet VALUES (21,'Na most mennem kell',CURRENT_TIMESTAMP(0),'pocokb@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (22,'oké',CURRENT_TIMESTAMP(0),'lali@gmail.com','pocokb@gmail.com');
INSERT INTO Privat_uzenet VALUES (23,'csá',CURRENT_TIMESTAMP(0),'pocokb@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (24,'csá',CURRENT_TIMESTAMP(0),'lali@gmail.com','pocokb@gmail.com');

INSERT INTO Privat_uzenet VALUES (25,'Hi, ráérsz most?',CURRENT_TIMESTAMP(0),'feri@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (26,'Ja még 10 percig',CURRENT_TIMESTAMP(0),'lali@gmail.com','feri@gmail.com');
INSERT INTO Privat_uzenet VALUES (27,'Te fogtál már amúrt?',CURRENT_TIMESTAMP(0),'feri@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (28,'párszor',CURRENT_TIMESTAMP(0),'lali@gmail.com','feri@gmail.com');
INSERT INTO Privat_uzenet VALUES (29,'de hogy csináltad?',CURRENT_TIMESTAMP(0),'feri@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (30,'csontival a tiszán',CURRENT_TIMESTAMP(0),'lali@gmail.com','feri@gmail.com');
INSERT INTO Privat_uzenet VALUES (31,'vazze én is azt tolom és semmi',CURRENT_TIMESTAMP(0),'feri@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (32,'ja meg sörözök mellé',CURRENT_TIMESTAMP(0),'lali@gmail.com','feri@gmail.com');
INSERT INTO Privat_uzenet VALUES (33,'baszki, erre nem gondoltam',CURRENT_TIMESTAMP(0),'feri@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (34,'pedig az kell a halnak',CURRENT_TIMESTAMP(0),'lali@gmail.com','feri@gmail.com');
INSERT INTO Privat_uzenet VALUES (35,'alkohol?',CURRENT_TIMESTAMP(0),'feri@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (36,'igen arra jönnek',CURRENT_TIMESTAMP(0),'lali@gmail.com','feri@gmail.com');
INSERT INTO Privat_uzenet VALUES (37,'értem és a csonti?',CURRENT_TIMESTAMP(0),'feri@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (38,'az mind1, itasd át heinekennel és jó lesz',CURRENT_TIMESTAMP(0),'lali@gmail.com','feri@gmail.com');
INSERT INTO Privat_uzenet VALUES (39,'heineken az egy szar, éljen a csíki!',CURRENT_TIMESTAMP(0),'feri@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (40,'hagyjuk már',CURRENT_TIMESTAMP(0),'lali@gmail.com','feri@gmail.com');
INSERT INTO Privat_uzenet VALUES (41,'oké és te mit csinálsz este?',CURRENT_TIMESTAMP(0),'feri@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (42,'Iszok! és te?',CURRENT_TIMESTAMP(0),'lali@gmail.com','feri@gmail.com');
INSERT INTO Privat_uzenet VALUES (43,'Én is',CURRENT_TIMESTAMP(0),'feri@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (44,'LOL',CURRENT_TIMESTAMP(0),'lali@gmail.com','feri@gmail.com');
INSERT INTO Privat_uzenet VALUES (45,'xD',CURRENT_TIMESTAMP(0),'feri@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (46,'akkor igyunk együtt',CURRENT_TIMESTAMP(0),'lali@gmail.com','feri@gmail.com');
INSERT INTO Privat_uzenet VALUES (47,'jóvan',CURRENT_TIMESTAMP(0),'feri@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (48,'csá',CURRENT_TIMESTAMP(0),'lali@gmail.com','feri@gmail.com');
INSERT INTO Privat_uzenet VALUES (49,'csá',CURRENT_TIMESTAMP(0),'feri@gmail.com','lali@gmail.com');
INSERT INTO Privat_uzenet VALUES (50,'csácsá',CURRENT_TIMESTAMP(0),'lali@gmail.com','feri@gmail.com');

INSERT INTO Uzenofali_uzenet VALUES (1,'Ma életembe először 500-al nyomtam fekve',CURRENT_TIMESTAMP(0),'lali@gmail.com','lali@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (2,'Jó ez a majális',CURRENT_TIMESTAMP(0),'lali@gmail.com','lali@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (3,'Csak sok a köcsög',CURRENT_TIMESTAMP(0),'lali@gmail.com','lali@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (4,'600kg fekve!',CURRENT_TIMESTAMP(0),'lali@gmail.com','lali@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (5,'Semmit nem ér az élet sör nélkül',CURRENT_TIMESTAMP(0),'lali@gmail.com','lali@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (6,'Este magyar-portugál!!!',CURRENT_TIMESTAMP(0),'lali@gmail.com','lali@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (7,'Mi a jó ebben a plankelésben??',CURRENT_TIMESTAMP(0),'lali@gmail.com','lali@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (8,'Kedvenc ételem a pörkölt',CURRENT_TIMESTAMP(0),'lali@gmail.com','lali@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (9,'RIP Tupac Shakur',CURRENT_TIMESTAMP(0),'lali@gmail.com','lali@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (10,'Naneeee',CURRENT_TIMESTAMP(0),'lali@gmail.com','lali@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (11,'Szép az idő!',CURRENT_TIMESTAMP(0),'ewin@vipmail.com','ewin@vipmail.com');
INSERT INTO Uzenofali_uzenet VALUES (12,'Ma leszek 21 éves!',CURRENT_TIMESTAMP(0),'ewin@vipmail.com','ewin@vipmail.com');
INSERT INTO Uzenofali_uzenet VALUES (13,'Nagyon jó az idő',CURRENT_TIMESTAMP(0),'ewin@vipmail.com','ewin@vipmail.com');
INSERT INTO Uzenofali_uzenet VALUES (14,'Szépek a virágok',CURRENT_TIMESTAMP(0),'ewin@vipmail.com','ewin@vipmail.com');
INSERT INTO Uzenofali_uzenet VALUES (15,'Felhős az ég :(',CURRENT_TIMESTAMP(0),'ewin@vipmail.com','ewin@vipmail.com');
INSERT INTO Uzenofali_uzenet VALUES (16,'De jó ez a nyár',CURRENT_TIMESTAMP(0),'ewin@vipmail.com','ewin@vipmail.com');
INSERT INTO Uzenofali_uzenet VALUES (17,'Vettem új ruhát',CURRENT_TIMESTAMP(0),'ewin@vipmail.com','ewin@vipmail.com');
INSERT INTO Uzenofali_uzenet VALUES (18,'Meg cipőt',CURRENT_TIMESTAMP(0),'ewin@vipmail.com','ewin@vipmail.com');
INSERT INTO Uzenofali_uzenet VALUES (19,'Kedvenc előadóm Beyonce',CURRENT_TIMESTAMP(0),'ewin@vipmail.com','ewin@vipmail.com');
INSERT INTO Uzenofali_uzenet VALUES (20,'HALIHOOO',CURRENT_TIMESTAMP(0),'ewin@vipmail.com','ewin@vipmail.com');
INSERT INTO Uzenofali_uzenet VALUES (21,'Sör Sör és Sör',CURRENT_TIMESTAMP(0),'feri@gmail.com','feri@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (22,'Reggel disznot vágunk',CURRENT_TIMESTAMP(0),'feri@gmail.com','feri@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (23,'Foci este?',CURRENT_TIMESTAMP(0),'feri@gmail.com','feri@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (24,'Stadionépítés 1000el',CURRENT_TIMESTAMP(0),'feri@gmail.com','feri@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (25,'Ferrari mi?',CURRENT_TIMESTAMP(0),'feri@gmail.com','feri@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (26,'Traktort hajtok',CURRENT_TIMESTAMP(0),'feri@gmail.com','feri@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (27,'Milyen ly vagy j?',CURRENT_TIMESTAMP(0),'feri@gmail.com','feri@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (28,'Na az jó lesz!',CURRENT_TIMESTAMP(0),'feri@gmail.com','feri@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (29,'YOLO',CURRENT_TIMESTAMP(0),'feri@gmail.com','feri@gmail.com');
INSERT INTO Uzenofali_uzenet VALUES (30,'Ma inkább ne',CURRENT_TIMESTAMP(0),'feri@gmail.com','feri@gmail.com');

INSERT INTO Komment VALUES (1,'Boldogot!',CURRENT_TIMESTAMP(0),'lali@gmail.com','uzenet',12,Null);
INSERT INTO Komment VALUES (2,'Köszi!',CURRENT_TIMESTAMP(0),'ewin@vipmail.com','uzenet',12,Null);
INSERT INTO Komment VALUES (3,'Isten éltessen!',CURRENT_TIMESTAMP(0),'rozsa.regina.ta@gmail.com','uzenet',12,Null);
INSERT INTO Komment VALUES (4,'Köszkösz!',CURRENT_TIMESTAMP(0),'ewin@vipmail.com','uzenet',12,Null);
INSERT INTO Komment VALUES (5,'!:)!',CURRENT_TIMESTAMP(0),'pocokb@gmail.com','uzenet',12,Null);
INSERT INTO Komment VALUES (6,'!lol!',CURRENT_TIMESTAMP(0),'ewin@vipmail.com','uzenet',12,Null);
INSERT INTO Komment VALUES (7,'Isten éltessen sokáig!',CURRENT_TIMESTAMP(0),'feri@gmail.com','uzenet',12,Null);
INSERT INTO Komment VALUES (8,'Köszönöm!',CURRENT_TIMESTAMP(0),'ewin@vipmail.com','uzenet',12,Null);
INSERT INTO Komment VALUES (9,'Boldog szülit! :)',CURRENT_TIMESTAMP(0),'karoly12@gmail.com','uzenet',12,Null);
INSERT INTO Komment VALUES (10,'Köszi! :)',CURRENT_TIMESTAMP(0),'ewin@vipmail.com','uzenet',12,Null);

INSERT INTO Ismeri VALUES ('ewin@vipmail.com','lali@gmail.com',CURRENT_TIMESTAMP(0));
INSERT INTO Ismeri VALUES ('rozsa.regina.ta@gmail.com','lali@gmail.com',CURRENT_TIMESTAMP(0));
INSERT INTO Ismeri VALUES ('pocokb@gmail.com','lali@gmail.com',CURRENT_TIMESTAMP(0));
INSERT INTO Ismeri VALUES ('karoly12@gmail.com','lali@gmail.com',CURRENT_TIMESTAMP(0));
INSERT INTO Ismeri VALUES ('feri@gmail.com','lali@gmail.com',CURRENT_TIMESTAMP(0));
INSERT INTO Ismeri VALUES ('pocokb@gmail.com','rozsa.regina.ta@gmail.com',CURRENT_TIMESTAMP(0));
INSERT INTO Ismeri VALUES ('ewin@vipmail.com','pocokb@gmail.com',CURRENT_TIMESTAMP(0));
INSERT INTO Ismeri VALUES ('rozsa.regina.ta@gmail.com','karoly12@gmail.com',CURRENT_TIMESTAMP(0));
INSERT INTO Ismeri VALUES ('pocokb@gmail.com','feri@gmail.com',CURRENT_TIMESTAMP(0));
