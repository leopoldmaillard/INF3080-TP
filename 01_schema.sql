drop table ROUTE            cascade constraints purge;
drop table CLIENT           cascade constraints purge;
drop table SOUMISSION       cascade constraints purge;
drop table COMPAGNIE        cascade constraints purge;
drop table CAMION           cascade constraints purge;
drop table TRACTEUR         cascade constraints purge;
drop table POSITION         cascade constraints purge;
drop table TYPEEQUIPEMENT   cascade constraints purge;
drop table CARBURANT	    cascade CONSTRAINTS purge;
drop table FACTURE	        cascade CONSTRAINTS purge;
drop table TRAJETDUJOUR 	cascade constraints purge;
drop table EQUIPEMENT    cascade constraints purge;

SET ECHO ON

CREATE TABLE Client
(noClient 		INTEGER 		NOT NULL,
 nomClient 		VARCHAR(30) 	NOT NULL,
 PRIMARY KEY 	(noClient)
)
/

CREATE TABLE Route
(noRoute 		INTEGER		NOT NULL,
 latOri 	REAL             NOT NULL,
 longOri 	REAL	            NOT NULL,
 latDes     REAL             NOT NULL,
 longDes    REAL             NOT NULL,
 distance   REAL             NOT NULL
    CHECK (distance > 0),
 noClient   INTEGER          NOT NULL,
 PRIMARY KEY (noRoute),
 FOREIGN KEY (noClient) REFERENCES Client
 )
/

CREATE TABLE Soumission
(noSoumission 	    INTEGER 		NOT NULL,
 prix	            REAL			NOT NULL
    CHECK (prix > 0),
 dateSoumission	    DATE	     	NOT NULL,
 noTypeEquipement   INTEGER      NOT NULL,
 noRoute		    INTEGER		NOT NULL,
 typeCarte		    VARCHAR(20)	NOT NULL
      CHECK (typeCarte IN ('visa','master card','american express')),
 PRIMARY KEY 	(noSoumission),
 FOREIGN KEY 	(noRoute) REFERENCES Route
)
/
CREATE TABLE Compagnie
(noCompagnie    INTEGER  NOT NULL,
 profit         REAL     NOT NULL
    CHECK (profit > 0),
 nbTotalCamion	INTEGER	NOT NULL,
 PRIMARY KEY (noCompagnie)
)
/
CREATE TABLE Camion
(noCamion       INTEGER      NOT NULL,
 poids          REAL         NOT NULL
    CHECK (poids > 0),
 espaceOccupe   REAL         NOT NULL
    CHECK (espaceOccupe > 0),
 noTracteur    INTEGER   NOT NULL,
 noTypeEquipement   INTEGER      NOT NULL,
 noCompagnie   INTEGER       NOT NULL,
 noRoute       INTEGER       NOT NULL,
 PRIMARY KEY (noCamion),
 FOREIGN KEY (noCompagnie) REFERENCES Compagnie,
 FOREIGN KEY (noRoute) REFERENCES Route
)
/

CREATE TABLE Carburant
(nomCarburant	VARCHAR(15)	NOT NULL,
 cout			REAL			NOT NULL
      CHECK (cout > 0),
 PRIMARY KEY (nomCarburant)
)
/
CREATE TABLE Tracteur
(noTracteur    INTEGER  NOT NULL,
 consommation  REAL     NOT NULL
   CHECK (consommation > 0),
 actif         CHAR(1) NOT NULL 
   CHECK (actif = '1' OR actif = '0'),
 nomCarburant  VARCHAR(15)   NOT NULL,
 noCamion INTEGER  NOT NULL,
 PRIMARY KEY (noTracteur),
 FOREIGN KEY (noCamion) REFERENCES Camion,
 FOREIGN KEY (nomCarburant) REFERENCES Carburant
 )
 /

CREATE TABLE Position
(noPosition     INTEGER  NOT NULL,
 latitude       REAL     NOT NULL,
 longitude      REAL     NOT NULL,
 noCamion       INTEGER  NOT NULL,
 PRIMARY KEY (noPosition),
 FOREIGN KEY (noCamion) REFERENCES Camion
)
/

CREATE TABLE TypeEquipement
(nomTypeEquipement   VARCHAR(7)     NOT NULL
      CHECK (nomTypeEquipement IN ('drybox','flatbed')),
 cout       REAL     NOT NULL,
    CHECK (cout > 0),
 PRIMARY KEY (nomTypeEquipement)
)
/
CREATE TABLE Equipement
(noEquipement       INTEGER         NOT NULL,
 nomTypeEquipement   VARCHAR(7)     NOT NULL
      CHECK (nomTypeEquipement IN ('drybox','flatbed')),
 longueur           REAL            NOT NULL
       CHECK (longueur > 0),
 largeur            REAL            NOT NULL
       CHECK (largeur > 0),
 hauteur            REAL            NOT NULL
       CHECK (hauteur > 0),
 capacite           REAL            NOT NULL
       CHECK (capacite > 0),
 noCamion           INTEGER         NOT NULL,
 PRIMARY KEY (noEquipement),
 FOREIGN KEY (noCamion) REFERENCES Camion,
 FOREIGN KEY (nomTypeEquipement) REFERENCES TypeEquipement
)
/

CREATE TABLE Facture
(noFacture		INTEGER		NOT NULL,
 noSoumission	INTEGER		NOT NULL,
 PRIMARY KEY (noFacture),
 FOREIGN KEY (noSoumission) REFERENCES Soumission
)
/

CREATE TABLE TrajetDuJour
(noCamion		    	INTEGER		NOT NULL,
 dateJour			DATE			NOT NULL,
 latDepartJour		REAL			NOT NULL,
 longDepartJour		REAL			NOT NULL,
 latArriveeJour		REAL			NOT NULL,
 longArriveeJour		REAL			NOT NULL,
 distanceJour		REAL			NOT NULL,
 CONSTRAINT primary_key_noCamion_date UNIQUE (noCamion, dateJour),
 FOREIGN KEY (noCamion) REFERENCES CAMION
)
/
COMMIT;
