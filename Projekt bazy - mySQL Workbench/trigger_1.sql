delimiter |
CREATE TRIGGER sprawdz_cene_foto
BEFORE UPDATE ON elektronika
FOR EACH ROW
BEGIN
	IF NEW.Cena>OLD.Cena 
		THEN SET NEW.Foto = 'brak';
	END IF;
END;
delimiter;