CREATE OR REPLACE PROCEDURE consulterSoumission
    (noSoumissionDemande Soumission.noSoumission%TYPE) IS
    
    --noSoumissionDemande Soumission.noSoumission%TYPE;
    leNoSoumission Soumission.noSoumission%TYPE;
    lePrix Soumission.prix%TYPE;
    laDateSoumission Soumission.dateSoumission%TYPE;
    leNoTypeEquipement Soumission.noTypeEquipement%TYPE;
    leNoRoute Soumission.noRoute%TYPE;
    leTypeCarte Soumission.typeCarte%TYPE;
    
    CURSOR ligneSoumission
        (UnNoSoumission Soumission.noSoumission%TYPE) IS
            SELECT * 
            FROM Soumission
            WHERE noSoumission = unNoSoumission;
            
BEGIN

    DBMS_OUTPUT.PUT('Pour la soumission no : ');
    DBMS_OUTPUT.PUT_LINE( noSoumissionDemande );
    
    OPEN ligneSoumission(noSoumissionDemande);
    
    LOOP
        FETCH ligneSoumission INTO leNoSoumission, lePrix, laDateSoumission, leNoTypeEquipement, leNoRoute, leTypeCarte;
        EXIT WHEN ligneSoumission%NOTFOUND;
        

        DBMS_OUTPUT.PUT('Prix : ');
        DBMS_OUTPUT.PUT_LINE( lePrix );
        DBMS_OUTPUT.PUT('Date de la soumission : ');
        DBMS_OUTPUT.PUT_LINE( laDateSoumission );
        DBMS_OUTPUT.PUT('Type équipement no  : ');
        DBMS_OUTPUT.PUT_LINE( leNoTypeEquipement );
        DBMS_OUTPUT.PUT('No de route associé  : ');
        DBMS_OUTPUT.PUT_LINE( leNoRoute );
        DBMS_OUTPUT.PUT('Type de carte de paiement : ');
        DBMS_OUTPUT.PUT_LINE( leTypeCarte );
    END LOOP;
    
    CLOSE ligneSoumission;
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'erreur interne');
        
        
END consulterSoumission;


Drop table soumission;       
CREATE TABLE Soumission
(noSoumission 	    INTEGER 		NOT NULL,
 prix	            REAL			NOT NULL
    CHECK (prix > 0),
 dateSoumission	VARCHAR(10)	     	NOT NULL,
 noTypeEquipement   INTEGER      NOT NULL,
 noRoute		    INTEGER		NOT NULL,
 typeCarte		VARCHAR(20)	NOT NULL
      CHECK (typeCarte IN ('visa','master card','american express')),
 PRIMARY KEY 	(noSoumission)
)

TRUNCATE TABLE Soumission;
insert into Soumission values (140, 100, to_date('01-01-2000', 'dd-mm-yyyy'), 2, 28, 'visa');
insert into Soumission values (170, 350, to_date('01-01-2000', 'dd-mm-yyyy'), 1, 24, 'visa');
insert into Soumission values (80, 700, to_date('01-01-2000', 'dd-mm-yyyy'), 2, 12, 'master card');
insert into Soumission values (150, 200, to_date('01-01-2000', 'dd-mm-yyyy'), 1, 18, 'american express');





SPOOL C:\Users\hugo\Desktop\testConsulter.txt
EXECUTE consulterSoumission(80);
EXECUTE consulterSoumission(150);