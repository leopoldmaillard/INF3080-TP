CREATE OR REPLACE FUNCTION plusLongTrajet
    (dateDemandee TrajetDuJour.dateJour%TYPE)
    RETURN TrajetDuJour.noCamion%TYPE IS

    -- DECALARATION VARIABLES
        CURSOR c1 
            (uneDateDemandee TrajetDuJour.dateJour%TYPE) IS
            SELECT noCamion, distanceJour 
            FROM TrajetDuJour
            WHERE dateJour = uneDateDemandee;
            
        distanceMax TrajetDujour.distanceJour%TYPE;
        noCamionDistanceMax TrajetDuJour.noCamion%TYPE;
        
        laDistance TrajetDujour.distanceJour%TYPE;
        leNoCamion TrajetDuJour.noCamion%TYPE;
    
    BEGIN
        distanceMax := 0;
        noCamionDistanceMax := 0;
        
        OPEN c1(dateDemandee);
        LOOP 
            FETCH c1 INTO leNoCamion, laDistance;
            IF (laDistance > distanceMax) THEN 
                noCamionDistanceMax := leNoCamion;
                distanceMax := laDistance;
            END IF;
            EXIT WHEN c1%NOTFOUND;
        END LOOP;
        CLOSE c1;
        
        IF distanceMax = 0 AND noCamionDistanceMax = 0 THEN
            DBMS_OUTPUT.PUT('Pas de trajet enregistrés pour ce jour.');
        ELSE
            DBMS_OUTPUT.PUT('Pour le :');
            DBMS_OUTPUT.PUT( dateDemandee );
            DBMS_OUTPUT.PUT(' la distance max effectuée est ');
            DBMS_OUTPUT.PUT( distanceMax );
            DBMS_OUTPUT.PUT(' km par le camion no : ');
            DBMS_OUTPUT.PUT( noCamionDistanceMax );
        END IF;
        
        RETURN noCamionDistanceMax;
    END;
    
    
DROP TABLE TrajetDuJour;    
CREATE TABLE TrajetDuJour
(noCamion		    	INTEGER		NOT NULL,
 dateJour			DATE			NOT NULL,
 distanceJour		REAL			NOT NULL,
 CONSTRAINT primary_key_noCamion_date UNIQUE (noCamion, dateJour)
)

TRUNCATE TABLE TrajetDuJour;
insert into TrajetDuJour values(1, to_date('01-01-2000', 'dd-mm-yyyy'), 100);
insert into TrajetDuJour values(2, to_date('01-01-2000', 'dd-mm-yyyy'), 200);
insert into TrajetDuJour values(3, to_date('01-01-2000', 'dd-mm-yyyy'), 300);
insert into TrajetDuJour values(4, to_date('01-01-2000', 'dd-mm-yyyy'), 400);
insert into TrajetDuJour values(5, to_date('01-01-2000', 'dd-mm-yyyy'), 500);
insert into TrajetDuJour values(6, to_date('01-01-2000', 'dd-mm-yyyy'), 60);
insert into TrajetDuJour values(7, to_date('02-01-2000', 'dd-mm-yyyy'), 190);
insert into TrajetDuJour values(8, to_date('02-01-2000', 'dd-mm-yyyy'), 90);


    SELECT plusLongTrajet( to_date('01-01-2000', 'dd-mm-yyyy') ) FROM DUAL;
    SELECT plusLongTrajet( to_date('02-01-2000', 'dd-mm-yyyy') ) FROM DUAL;