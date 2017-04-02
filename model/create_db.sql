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

