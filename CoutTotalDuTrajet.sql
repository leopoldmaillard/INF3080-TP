-- On créer une vue qui va permettre d'afficher tous les camions et leurs caractéristiques
-- (Compagnie, équipement utilisé, consommation, carburant etc.)
-- La vue permettra de facilement identifier les camions qui sont assignés à la même route d'une soumission

CREATE OR REPLACE VIEW LigneCamion AS
    SELECT Soumission.noSoumission, Route.noRoute, Route.distance, Camion.noCamion,
           Compagnie.noCompagnie, Compagnie.profit, Tracteur.consommation, Carburant.cout,
           TypeEquipement.nomTypeEquipement, TypeEquipement.cout AS coutEquipement
    FROM   Soumission, Route, Camion, Compagnie, Tracteur, Carburant, Equipement, TypeEquipement, Client
    WHERE  Soumission.noRoute = Route.noRoute  AND
           Route.noClient = Client.noClient AND
           Route.noRoute = Camion.noRoute AND
           Compagnie.noCompagnie = Camion.noCompagnie AND Equipement.noCamion = Camion.noCamion AND
           TypeEquipement.nomTypeEquipement = Equipement.nomTypeEquipement AND
           Tracteur.noCamion = Camion.noCamion AND Tracteur.nomCarburant = Carburant.nomCarburant;

-- On charge les tables de manière à avoir une soumission dont la Route sera attribuée à plusieurs camions
INSERT INTO Client VALUES(10,'Luc Sansom');
INSERT INTO Route VALUES(28, 100.0, 200.0, 150.0, 290.0, 250, 10); -- Route numéro 28, 250 km
INSERT INTO Soumission values (140, 100, to_date('01-01-2000', 'dd-mm-yyyy'), 2, 28, 'visa'); -- Soumission associée à la route 28

-- On ajoute un premier camion (14) associé à la route
INSERT INTO Compagnie VALUES(16, 1.18, 1000); -- Profit de 18%
INSERT INTO Camion VALUES(14, 18.0, 13.0, 31, 32, 16, 28); -- Tracteur 31, Equipement 32, Compagnie 16, Route 28
INSERT INTO TypeEquipement VALUES('drybox',259.0); -- Drybox coûte 259$
INSERT INTO Equipement VALUES(32, 'drybox',10.0, 3.0, 2.0, 20.0, 14); --Equipement du camion 14
INSERT INTO Carburant VALUES ('diesel',0.98); -- Diesel, 0.98$ le Litre
INSERT INTO Tracteur VALUES(31, 34, '0','diesel',14); -- Conso : 34L/100

-- On ajoute un deuxième camion (15) à la même route 
INSERT INTO Camion VALUES (15, 20.0, 17.0, 18, 38, 16, 28); -- Tracteur 18, Equipement 38, Compagnie 16, Route 28
INSERT INTO TypeEquipement VALUES('flatbed',369.0); -- Flatbed coûte 369$
INSERT INTO Equipement VALUES(38, 'flatbed',11.0, 4.0, 2.5, 24.0, 15); --Equipement du camion 15
INSERT INTO Carburant VALUES ('essence',1.09); -- Essence, 1.09$ le Litre
INSERT INTO Tracteur VALUES(18, 36, '0','essence',15); -- Conso : 36L/100;

-- Va calculer le prix total d'un trajet soumis
CREATE OR REPLACE FUNCTION CoutTotalDuTrajet
(leNoSoumissionEntre Soumission.noSoumission%TYPE)
RETURN REAL IS    
    resultat REAL;
    
    unNoSoumission Soumission.noSoumission%TYPE;    
    leNoSoumission soumission.noSoumission%TYPE;
    leNoRoute      Route.noRoute%TYPE;
    laDistance     Route.distance%TYPE;
    leNoCamion     Camion.noCamion%TYPE;
    leNoCompagnie  Compagnie.noCompagnie%TYPE;
    leProfit       Compagnie.profit%TYPE;
    laConsommation Tracteur.consommation%TYPE;
    leCout         Carburant.cout%TYPE;
    leNomTypeEquipement typeequipement.nomtypeequipement%TYPE;
    leCoutEquipement typeequipement.cout%TYPE;
     
     -- Le curseur va permettre, pour une même soumission, d'ajouter au résultat le coût du trajet de chaque camion
     -- attribué au trajet
     
    CURSOR ligneTotal
        (unNoSoumission Soumission.noSoumission%TYPE) IS
            SELECT *
            FROM LigneCamion
            WHERE LigneCamion.nosoumission = unNoSoumission;
     
    BEGIN
    
    resultat:=0.0;
    
    OPEN ligneTotal(leNoSoumissionEntre);
    
    LOOP
        FETCH ligneTotal INTO leNoSoumission, leNoRoute, laDistance, leNoCamion, leNoCompagnie, leProfit, laConsommation, leCout, leNomTypeEquipement, leCoutEquipement;
        EXIT WHEN ligneTotal%NOTFOUND;
        
        --Pour chaque camion, on prend en considération la distance parcourue, sa consommation et le coût du carburant
        --On ajoute le coût de son équipement
        --On multiplie par le profit réalisé par la compagnie propriétaire du camion
        
        resultat := resultat + ((laDistance/100) * laConsommation * leCout + leCoutEquipement)*leProfit ;
        
    END LOOP;
    
    CLOSE ligneTotal;
    
    RETURN resultat;
    
END CoutTotalDuTrajet;

-- On teste notre fonction pour la soumission 140

SELECT CoutTotalDuTrajet(140) FROM Soumission;
