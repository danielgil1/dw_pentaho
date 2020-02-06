-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema meta_overhill
-- -----------------------------------------------------
-- 
-- 

-- -----------------------------------------------------
-- Schema meta_overhill
--
-- 
-- 
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `meta_overhill` ;
USE `meta_overhill` ;

-- -----------------------------------------------------
-- Table `meta_overhill`.`MetaOperations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meta_overhill`.`MetaOperations` (
  `Transformation` VARCHAR(200) NULL,
  `Fieldname` VARCHAR(200) NULL,
  `Comments` VARCHAR(200) NULL,
  `Type` VARCHAR(50) NULL,
  `Length` INT NULL,
  `Precision` INT NULL,
  `Origin` VARCHAR(200) NULL,
  `LastHostExecution` DATETIME NULL,
  `LastExecution` DATETIME NULL)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
