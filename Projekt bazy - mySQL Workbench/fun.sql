CREATE FUNCTION nowy_rezystor_tme(nazwa varchar(45), cena FLOAT, foto varchar(45), rok year(4)) RETURNS integer
BEGIN
	INSERT INTO elektronika (Producent_Nazwa, Nazwa, Rok_Produkcji, Cena, Foto, Rodzaj_Nazwa) VALUES ("TME", nazwa, rok, cena, foto, "Rezystory");
	RETURN 1;
END