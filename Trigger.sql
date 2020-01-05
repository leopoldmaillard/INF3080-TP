-- Bloquer la réservation d'un camion lorsque le trajet est supérieur à 50km --

CREATE OR REPLACE TRIGGER MaxDistance
BEFORE INSERT ON Route
FOR EACH ROW
BEGIN
    IF (:NEW.distance > 50) THEN
        raise_application_error(-20100, 'blocage de la reservation : distance du trajet superieure a� 50km');
    END IF;
END;
/
 
-- Bloquer la soummision si le trajet n'a pas ete identifie -- 

CREATE OR REPLACE TRIGGER TrajetEstPresent
BEFORE INSERT ON Soumission
FOR EACH ROW
DECLARE
    route_count INTEGER;
BEGIN
    SELECT count(*) INTO route_count
    FROM Route 
    WHERE noRoute=:NEW.noRoute;
    
    IF (route_count = 0) THEN
        raise_application_error(-20100,'blocage de la soumission : trajet non identifie'); 
    END IF;
END;
/

-- Reduire la quantite des camions que le transporteur possede en fonction de la quantite louee --

CREATE OR REPLACE TRIGGER BaisserQuantiteCamion
AFTER INSERT ON Soumission 
FOR EACH ROW
DECLARE
    quantiteLouee   INTEGER;
    laCompagnie     INTEGER;
BEGIN
    SELECT COUNT(*) INTO quantiteLouee
    FROM Camion
    WHERE noRoute=:NEW.noRoute;
    
    SELECT distinct compagnie.nocompagnie INTO laCompagnie
    FROM Compagnie, Camion
    WHERE :NEW.noRoute=Camion.noRoute AND Compagnie.noCompagnie=Camion.noCompagnie;
    
    UPDATE Compagnie
    SET nbTotalCamion = nbTotalCamion - quantiteLouee
    WHERE Compagnie.noCompagnie = laCompagnie;
END;
/
--DROP TRIGGER MaxDistance; DROP TRIGGER TrajetEstPresent; DROP TRIGGER BaisserQuantiteCamion;--