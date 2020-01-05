-- Cette procédure va afficher au client les détails de sa facture

CREATE OR REPLACE PROCEDURE produireFacture
    (noFactureDemande     Facture.noFacture%TYPE) IS
    
    leNoFacture Facture.noFacture%TYPE;
    leNoSoumission Soumission.noSoumission%TYPE;
    laDateSoumission Soumission.dateSoumission%TYPE;
    leTypeCarte Soumission.typeCarte%TYPE;
    leNoClient Client.noClient%TYPE;
    leNomClient Client.nomClient%TYPE;
    leMontantHT REAL;
    leMontant REAL;
    
BEGIN
    
    SELECT Soumission.noSoumission, Soumission.dateSoumission, Soumission.typeCarte INTO leNoSoumission, laDateSoumission, leTypeCarte
    FROM Soumission, Facture
    WHERE Soumission.noSoumission = Facture.noSoumission AND Facture.noFacture = noFactureDemande;

    SELECT Client.noClient, Client.nomClient INTO leNoClient, leNomClient
    FROM Client, Route, Soumission, Facture
    WHERE Client.noClient = Route.noClient AND Route.noRoute = Soumission.noRoute AND Soumission.noSoumission = Facture.noSoumission AND 
                            Facture.noFacture = noFactureDemande;
    
    leMontantHT := CoutTotalDuTrajet(leNoSoumission);
    leMontant   := TotalFacture(nofacturedemande);
                            
    DBMS_OUTPUT.PUT('Facture n° ');
    DBMS_OUTPUT.PUT_LINE(noFactureDemande);
    DBMS_OUTPUT.PUT('Soumission associée : ');
    DBMS_OUTPUT.PUT_LINE(leNoSoumission);
    DBMS_OUTPUT.PUT('Numéro de client : ');
    DBMS_OUTPUT.PUT_LINE(leNoClient);
    DBMS_OUTPUT.PUT('Nom du client : ');
    DBMS_OUTPUT.PUT_LINE(leNomClient);
    DBMS_OUTPUT.PUT('Moyen de paiement : ');
    DBMS_OUTPUT.PUT_LINE(leTypeCarte);
    DBMS_OUTPUT.PUT('Montant Hors-Taxe : ');
    DBMS_OUTPUT.PUT_LINE(leMontantHT);
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT('Prix à payer : ');
    DBMS_OUTPUT.PUT_LINE(leMontant);

    
END produireFacture;

-- On teste la procédure pour notre facture no. 5
EXECUTE produireFacture(5);
