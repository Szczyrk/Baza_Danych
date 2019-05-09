-- MySQL Script generated by MySQL Workbench
-- Wed Apr 24 23:38:41 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Sklep
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Sklep
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Sklep` DEFAULT CHARACTER SET utf8 COLLATE utf8_polish_ci ;
USE `Sklep` ;

-- -----------------------------------------------------
-- Table `Sklep`.`Producent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sklep`.`Producent` (
  `Nazwa` VARCHAR(45) NOT NULL,
  `Adres` VARCHAR(45) NOT NULL,
  `Telefon` INT(9) NULL,
  `Strona` VARCHAR(45) NULL,
  PRIMARY KEY (`Nazwa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sklep`.`Rodzaj`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sklep`.`Rodzaj` (
  `Nazwa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nazwa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sklep`.`Elektronika`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sklep`.`Elektronika` (
  `idElektronika` INT NOT NULL AUTO_INCREMENT,
  `Producent_Nazwa` VARCHAR(45) NOT NULL,
  `Nazwa` VARCHAR(45) NOT NULL,
  `Rok_Produkcji` YEAR(4) NULL,
  `Cena` FLOAT NOT NULL COMMENT '\n',
  `Foto` VARCHAR(45) NULL DEFAULT 'brak',
  `Rodzaj_Nazwa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idElektronika`),
  INDEX `fk_Elektronika_Producent1_idx` (`Producent_Nazwa` ASC) VISIBLE,
  INDEX `fk_Elektronika_Rodzaj1_idx` (`Rodzaj_Nazwa` ASC) VISIBLE,
  CONSTRAINT `fk_Elektronika_Producent1`
    FOREIGN KEY (`Producent_Nazwa`)
    REFERENCES `Sklep`.`Producent` (`Nazwa`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Elektronika_Rodzaj1`
    FOREIGN KEY (`Rodzaj_Nazwa`)
    REFERENCES `Sklep`.`Rodzaj` (`Nazwa`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sklep`.`Magazyn`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sklep`.`Magazyn` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Telefon` INT(9) NULL,
  `Adres` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sklep`.`Elementy_W_Magazynach`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sklep`.`Elementy_W_Magazynach` (
  `MagazynID` INT NOT NULL,
  `Elektronika_idElektronika` INT NOT NULL,
  `Liczba` INT NULL,
  `Magazyn_ID` INT NOT NULL,
  PRIMARY KEY (`MagazynID`, `Elektronika_idElektronika`),
  INDEX `fk_Elementy_W_Magazynach_Elektronika_idx` (`Elektronika_idElektronika` ASC) VISIBLE,
  INDEX `fk_Elementy_W_Magazynach_Magazyn1_idx` (`Magazyn_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Elementy_W_Magazynach_Elektronika`
    FOREIGN KEY (`Elektronika_idElektronika`)
    REFERENCES `Sklep`.`Elektronika` (`idElektronika`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Elementy_W_Magazynach_Magazyn1`
    FOREIGN KEY (`Magazyn_ID`)
    REFERENCES `Sklep`.`Magazyn` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sklep`.`Klient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sklep`.`Klient` (
  `Email` VARCHAR(45) NOT NULL,
  `Nazwa` VARCHAR(45) NOT NULL,
  `Telefon` INT(9) NOT NULL,
  `Adres` VARCHAR(45) NOT NULL,
  `Hasło` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Email`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sklep`.`Kosz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sklep`.`Kosz` (
  `ID_Kosz` INT NOT NULL,
  `Klient_Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Kosz`),
  INDEX `fk_Kosz_Klient1_idx` (`Klient_Email` ASC) VISIBLE,
  CONSTRAINT `fk_Kosz_Klient1`
    FOREIGN KEY (`Klient_Email`)
    REFERENCES `Sklep`.`Klient` (`Email`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sklep`.`Elementy_W_Koszu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sklep`.`Elementy_W_Koszu` (
  `Liczba` INT NULL,
  `Kosz_ID_Kosz` INT NOT NULL,
  `Elektronika_idElektronika` INT NOT NULL,
  INDEX `fk_Elementy_W_Koszu_Kosz1_idx` (`Kosz_ID_Kosz` ASC) VISIBLE,
  INDEX `fk_Elementy_W_Koszu_Elektronika1_idx` (`Elektronika_idElektronika` ASC) VISIBLE,
  CONSTRAINT `fk_Elementy_W_Koszu_Kosz1`
    FOREIGN KEY (`Kosz_ID_Kosz`)
    REFERENCES `Sklep`.`Kosz` (`ID_Kosz`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Elementy_W_Koszu_Elektronika1`
    FOREIGN KEY (`Elektronika_idElektronika`)
    REFERENCES `Sklep`.`Elektronika` (`idElektronika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sklep`.`Dane`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sklep`.`Dane` (
  `Nazwa` VARCHAR(45) NOT NULL,
  `Opis` VARCHAR(200) NULL,
  `Elektronika_idElektronika` INT NOT NULL,
  PRIMARY KEY (`Nazwa`),
  INDEX `fk_Dane_Elektronika1_idx` (`Elektronika_idElektronika` ASC) VISIBLE,
  CONSTRAINT `fk_Dane_Elektronika1`
    FOREIGN KEY (`Elektronika_idElektronika`)
    REFERENCES `Sklep`.`Elektronika` (`idElektronika`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

USE `Sklep` ;

-- -----------------------------------------------------
-- procedure search_promotions
-- -----------------------------------------------------

DELIMITER $$
USE `Sklep`$$
CREATE PROCEDURE `search_promotions` ()
BEGIN
	SELECT Nazwa, Cena, Foto
    FROM elektronika
    WHERE Cena < '10';
END$$

DELIMITER ;
CREATE USER 'admin' IDENTIFIED BY 'admin';

GRANT ALL ON `Sklep`.* TO 'admin';
CREATE USER 'guest' IDENTIFIED BY 'guest';

GRANT SELECT ON TABLE `Sklep`.* TO 'guest';
CREATE USER 'client' IDENTIFIED BY 'client';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `Sklep`.* TO 'client';
GRANT EXECUTE ON ROUTINE `Sklep`.* TO 'client';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
