SELECT noCamion
FROM Camion, Tracteur
WHERE Camion.noCamion = Tracteur.noCamion AND actif = '1'