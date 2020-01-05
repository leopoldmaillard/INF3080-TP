
--test check sur le type de cartes : american non valable et prix > 0
insert into Soumission values (150, 200, to_date('01-01-2000', 'dd-mm-yyyy'), 1, 18, 'american');
insert into Soumission values (150, 0, to_date('01-01-2000', 'dd-mm-yyyy'), 1, 18, 'american express');


-- test nom equipement = flatbed ou drybox
insert into TypeEquipement values ('drybed', 100);



-- test profit > 0
insert into Compagnie values (10 , 0, 12);