DELETE FROM Client;
DELETE FROM Route;
DELETE FROM camion;
DELETE FROM compagnie;
DELETE FROM soumission;
DELETE FROM typeequipement;
DELETE FROM position;
DELETE FROM tracteur;
DELETE FROM carburant;
DELETE FROM facture;
DELETE FROM trajetdujour;
DELETE FROM equipement;

SET ECHO ON

INSERT INTO Client VALUES(10, 'Lisa')
/
-- montrer que la route n'est pas possible car distance = 100 > 50
INSERT INTO Route VALUES(77, 100.0, 100.0, 500.0, 500.0, 100.0, 10)
/
INSERT INTO Route VALUES(11, 100.0, 100.0, 500.0, 500.0, 45.0, 10)
/
-- montrer que la soumission n'est pas bonne car le noroute correspond pas--
INSERT INTO Soumission VALUES(60,150.0, '2019-12-06', 13, 999, 'visa')
/
INSERT INTO Compagnie VALUES(13,1.18,470)
/
INSERT INTO Camion VALUES(14,777.0,888.0,15,17,13,11)
/
INSERT INTO Camion VALUES(24,777.0,888.0,25,27,13,11)
/
SELECT * 
FROM Compagnie
/
INSERT INTO Soumission VALUES(12,150.0, '2019-12-06', 13, 11, 'visa')
/
SELECT * 
FROM Compagnie
/
COMMIT;