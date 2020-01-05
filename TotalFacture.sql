-- Cette fonction va calculer le montant total d'une facture
-- Au coût total du trajet de la soumission, on ajoute les taxes en vigueur

CREATE OR REPLACE FUNCTION TotalFacture
(leNoFacture Facture.noFacture%TYPE)
RETURN REAL IS
    resultat REAL;
    
    coutSansTaxe REAL;
    leNoSoumission Soumission.noSoumission%TYPE;
    
    TPS CONSTANT REAL := 0.05;
    TVQ CONSTANT REAL := 0.0975;
    
BEGIN

    SELECT  Facture.noSoumission INTO leNoSoumission
    FROM    Facture
    WHERE   Facture.noFacture = leNoFacture;
    
    coutSansTaxe := CoutTotalDuTrajet(leNoSoumission);
    resultat := coutSansTaxe + TPS * coutSansTaxe + TVQ * coutSansTaxe ;
    
    RETURN resultat;
    
END TotalFacture;

-- On ajoute à la table la Facture associée à la soumission 140
INSERT INTO Facture VALUES(5,140);

-- On teste notre fonction 

SELECT DISTINCT TotalFacture(5) FROM Facture;
