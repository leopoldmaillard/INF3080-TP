SELECT noSoumission
FROM Soumission
WHERE prix < 300
--Doit afficher les noSoumission 12 et 22
/

SELECT DISTINCT noRoute
FROM Client, Route
WHERE distance > 50
--Doit afficher les noRoute : 31,41,61
/

SELECT noClient, nomClient
FROM Client, Chargement, Tracteur, TypeEquipement
WHERE Client.noClient = Chargement.noClient AND 
      Tracteur.noCamion = Chargement.noCamion AND
      Chargement.noCamion = TypeEquipement.noCamion AND
      equipement='flatbed' AND actif = '1'
      
/

SELECT noCamion, noTypeEquipement
FROM TypeEquipement
WHERE cout < 350.0

/

SELECT Client.noClient, noRoute
FROM Client, Route
WHERE Client.noClient = Route.noClient (+)
--Doit afficher les no. de Client et les no. de Routes associés, incluant les clients qui n'ont pas de Route (ici, le 70)
/

SELECT noCamion
FROM Camion
WHERE NOT EXISTS
      (SELECT *
      FROM TypeEquipement
      WHERE Camion.noCamion = TypeEquipement.noCamion AND equipement="flatbed"
--Doit afficher les camion exceptés ceux équipés en équipement flatbed (donc les camions 24, 54 et 64)
