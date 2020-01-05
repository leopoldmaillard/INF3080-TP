DELETE FROM Client;
DELETE FROM Route;
DELETE FROM camion;
DELETE FROM chargement;
DELETE FROM compagnie;
DELETE FROM soumission;
DELETE FROM typeequipement;
DELETE FROM position;
DELETE FROM tracteur;

SET ECHO ON

--Chargement Client
INSERT INTO Client
 	VALUES(10,'Luc Sansom')
    /
INSERT INTO Client
 	VALUES(20,'Dollard Tremblay')
    /
INSERT INTO Client
 	VALUES(30,'Lin Bo')
    /
INSERT INTO Client
 	VALUES(40,'Jean Leconte')
    /
INSERT INTO Client
 	VALUES(50,'Hafed Alaoui')
    /
INSERT INTO Client
 	VALUES(60,'Marie Leconte')
    /
INSERT INTO Client
  VALUES(70,'Leo Dupont')
    /

-- Chargement Route
INSERT INTO Route
    VALUES(11, 100.0, 200.0, 150.0, 290.0, 10, 10)
    /
INSERT INTO Route
    VALUES(21, 200.0, 300.0, 250.0, 190.0, 25, 20)
    /
INSERT INTO Route
    VALUES(31, 300.0, 600.0, 400.0, 120.0, 100, 30)
    /
INSERT INTO Route
    VALUES(41, 400.0, 100.0, 300.0, 960.0, 55, 40)
    /   
INSERT INTO Route
    VALUES(51, 500.0, 500.0, 300.0, 770.0, 30, 50)
    /
INSERT INTO Route
    VALUES(61, 300.0, 100.0, 500.0, 240.0, 70, 60)
    /
    
-- Chargement Soumission
INSERT INTO Soumission
    VALUES(12, 250.0, '30/09/2019', 13, 11)
    /
INSERT INTO Soumission
    VALUES(22, 150.0, '04/08/2019', 23, 21)
    /
INSERT INTO Soumission
    VALUES(32, 550.0, '27/04/2019', 33, 31)
    /
INSERT INTO Soumission
    VALUES(42, 390.0, '08/07/2019', 43, 41)
    /
INSERT INTO Soumission --2eme soumission pour route 41
    VALUES(43, 350.0, '09/07/2019', 43, 41)
    /
INSERT INTO Soumission
    VALUES(52, 440.0, '10/10/2019', 53, 51)
    /
INSERT INTO Soumission
    VALUES(62, 470.0, '28/09/2019', 63, 61)
    /
INSERT INTO Soumission --2eme soumission pour route 61
    VALUES(63, 450.0, '28/09/2019', 63, 61)
    /
INSERT INTO Soumission --3eme soumission pour route 61
    VALUES(64, 430.0, '29/09/2019', 63, 61)
    /
    
-- Chargement Camion
INSERT INTO Camion
    VALUES(14, 17, 13, 300.0, 10.0)
    /
INSERT INTO Camion
    VALUES(24, 27, 23, 340.0, 13.0)
    /
INSERT INTO Camion
    VALUES(34, 37, 13, 100.0, 17.0)
    /
INSERT INTO Camion
    VALUES(44, 47, 13, 610.0, 15.0)
    /
INSERT INTO Camion
    VALUES(54, 57, 43, 580.0, 14.0)
    /
INSERT INTO Camion
    VALUES(64, 67, 33, 450.0, 18.0)
    /
    
-- Chargement Chargement
INSERT INTO Chargement
    VALUES(10, 11, 14)
    /
INSERT INTO Chargement
    VALUES(20, 21, 24)
    /
INSERT INTO Chargement
    VALUES(30, 31, 34)
    /
INSERT INTO Chargement
    VALUES(40, 41, 44)
    /
INSERT INTO Chargement
    VALUES(50, 51, 54)
    /
INSERT INTO Chargement
    VALUES(60, 61, 64)
    /

-- Chargement Position
INSERT INTO Position
    VALUES(15, 100.0, 200.0, 14)
    /
INSERT INTO Position
    VALUES(25, 200.0, 300.0, 24)
    /
INSERT INTO Position
    VALUES(35, 300.0, 300.0, 34)
    /
INSERT INTO Position
    VALUES(45, 700.0, 600.0, 44)
    /
INSERT INTO Position
    VALUES(55, 400.0, 300.0, 54)
    /
INSERT INTO Position
    VALUES(65, 400.0, 500.0, 64)
    /
    
-- Chargement TypeEquipement
INSERT INTO TypeEquipement
    VALUES(13, 'flatbed', 4.00, 2.00, 3.00, 20.0, 300.0, 14)
    /
INSERT INTO TypeEquipement
    VALUES(23, 'drybox', 5.00, 2.50, 3.00, 30.0, 375.0, 24)
    /
INSERT INTO TypeEquipement
    VALUES(33, 'flatbed', 4.00, 2.00, 3.00, 20.0, 300.0, 34)
    /
INSERT INTO TypeEquipement
    VALUES(43, 'flatbed', 4.00, 2.00, 3.00, 20.0, 300.0, 44)
    /
INSERT INTO TypeEquipement
    VALUES(53, 'drybox', 5.00, 2.50, 3.00, 30.0, 375.0, 54)
    /
INSERT INTO TypeEquipement
    VALUES(63, 'drybox', 5.00, 2.50, 3.00, 30.0, 375.0, 64)
    /

-- Chargement Compagnie
INSERT INTO Compagnie
    VALUES(16, 1.18, 14)
    /
INSERT INTO Compagnie
    VALUES(26, 1.18, 24)
    /
INSERT INTO Compagnie
    VALUES(36, 1.18, 34)
    /
INSERT INTO Compagnie
    VALUES(46, 1.18, 44)
    /
INSERT INTO Compagnie
    VALUES(56, 1.18, 54)
    /
INSERT INTO Compagnie
    VALUES(66, 1.18, 64)
    /

-- Chargement Tracteur
INSERT INTO Tracteur
    VALUES(17, 9.5, '0', 1.10, 14)
    /
INSERT INTO Tracteur
    VALUES(27, 10.6, '1', 1.14, 24)
    /
INSERT INTO Tracteur
    VALUES(37, 12.0, '1', 1.10, 34)
    /
INSERT INTO Tracteur
    VALUES(47, 9.7, '1', 1.14, 44)
    /
INSERT INTO Tracteur
    VALUES(57, 11.2, '0', 1.14, 54)
    /
INSERT INTO Tracteur
    VALUES(67, 9.9, '1', 1.10, 64)
    /
    
COMMIT;
