SELECT noSoumission, prix, dateSoumission, noTypeEquipement, Soumission.noRoute 
FROM Soumission, Route 
WHERE Soumission.noRoute = Route.noRoute AND Soumission.dateSoumission='30/09/2019' AND Route.noClient=10
