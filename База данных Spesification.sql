-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Specification
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Specification` ;

-- -----------------------------------------------------
-- Schema Specification
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Specification` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `Specification` ;

-- -----------------------------------------------------
-- Table `СборочныеЕдиницы`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `СборочныеЕдиницы` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `СборочныеЕдиницы` (
  `Позиция` INT NOT NULL AUTO_INCREMENT,
  `Обозначение` VARCHAR(45) NOT NULL,
  `Наименование` VARCHAR(45) NOT NULL,
  `Количество` VARCHAR(3) NOT NULL,
  `Примечание` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`Позиция`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Детали`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Детали` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Детали` (
  `Позиция` INT NOT NULL AUTO_INCREMENT,
  `ПозицияСборочныхЕдиниц` INT NOT NULL,
  `Обозначение` VARCHAR(45) NOT NULL,
  `Наименование` VARCHAR(45) NOT NULL,
  `Количество` VARCHAR(3) NOT NULL,
  `Примечание` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`Позиция`, `ПозицияСборочныхЕдиниц`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `СтандартныеИзделия`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `СтандартныеИзделия` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `СтандартныеИзделия` (
  `Позиция` INT NOT NULL AUTO_INCREMENT,
  `Обозначение` VARCHAR(45) NOT NULL,
  `Наименование` VARCHAR(45) NOT NULL,
  `Количество` VARCHAR(3) NOT NULL,
  `Примечание` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`Позиция`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `СтандартныеИзделияВДеталях`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `СтандартныеИзделияВДеталях` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `СтандартныеИзделияВДеталях` (
  `ПозицияСтандартногоИзделия` INT NOT NULL,
  `ПозицияДетали` INT NOT NULL,
  PRIMARY KEY (`ПозицияСтандартногоИзделия`, `ПозицияДетали`),
  INDEX `fk_СтандартныеИзделия_has_Детали_Д_idx` (`ПозицияДетали` ASC) VISIBLE,
  INDEX `fk_СтандартныеИзделия_has_Детали_С_idx` (`ПозицияСтандартногоИзделия` ASC) VISIBLE,
  CONSTRAINT `fk_СтандартныеИзделия_has_Детали_Ст1`
    FOREIGN KEY (`ПозицияСтандартногоИзделия`)
    REFERENCES `СтандартныеИзделия` (`Позиция`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_СтандартныеИзделия_has_Детали_Де1`
    FOREIGN KEY (`ПозицияДетали`)
    REFERENCES `Детали` (`Позиция`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ДеталиВСборочныхЕдиницах`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ДеталиВСборочныхЕдиницах` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ДеталиВСборочныхЕдиницах` (
  `ПозицияДетали` INT NOT NULL,
  `ПозицияСборочныхЕдиниц` INT NOT NULL,
  PRIMARY KEY (`ПозицияДетали`, `ПозицияСборочныхЕдиниц`),
  INDEX `fk_Детали_has_СборочныеЕдиницы_Сбо_idx` (`ПозицияСборочныхЕдиниц` ASC) VISIBLE,
  INDEX `fk_Детали_has_СборочныеЕдиницы_Дет_idx` (`ПозицияДетали` ASC) VISIBLE,
  CONSTRAINT `fk_Детали_has_СборочныеЕдиницы_Дета1`
    FOREIGN KEY (`ПозицияДетали`)
    REFERENCES `Детали` (`Позиция`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Детали_has_СборочныеЕдиницы_Сбор1`
    FOREIGN KEY (`ПозицияСборочныхЕдиниц`)
    REFERENCES `СборочныеЕдиницы` (`Позиция`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
