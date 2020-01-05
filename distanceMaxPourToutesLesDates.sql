--RQ : affiche 2 fois la dernière date 
CREATE OR REPLACE PROCEDURE distanceMaxToutesDates IS

    CURSOR c1 IS
            SELECT DISTINCT dateJour 
            FROM TrajetDuJour;
    laDate TrajetDuJour.dateJour%TYPE;
    leCamionMax TrajetDuJour.noCamion%TYPE;
            
BEGIN

    OPEN c1;
    LOOP
        FETCH c1 INTO laDate;
        leCamionMax :=  plusLongTrajet( laDate );
        /*DBMS_OUTPUT.PUT('Pour la date du : ');
        DBMS_OUTPUT.PUT_LINE(laDate);
        DBMS_OUTPUT.PUT('Le camion ayant parcouru le plus long trajet est : ');
        DBMS_OUTPUT.PUT_LINE(leCamionMax);*/
        EXIT WHEN c1%NOTFOUND;
    END LOOP;
    CLOSE c1;
    
END DistanceMaxToutesDates;




DROP TABLE TrajetDuJour cascade constraints purge;
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
insert into TrajetDuJour values(7, to_date('07-01-2000', 'dd-mm-yyyy'), 150);
insert into TrajetDuJour values(8, to_date('07-01-2000', 'dd-mm-yyyy'), 90);
insert into TrajetDuJour values(9, to_date('07-01-2000', 'dd-mm-yyyy'), 190);
insert into TrajetDuJour values(10, to_date('07-01-2000', 'dd-mm-yyyy'), 40);
insert into TrajetDuJour values(11, to_date('03-02-2000', 'dd-mm-yyyy'), 100);
insert into TrajetDuJour values(12, to_date('03-02-2000', 'dd-mm-yyyy'), 60);
insert into TrajetDuJour values(13, to_date('05-03-2000', 'dd-mm-yyyy'), 230);


EXECUTE distanceMaxToutesDates();