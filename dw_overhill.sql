-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema dw_overhill
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dw_overhill
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dw_overhill` ;
USE `dw_overhill` ;

-- -----------------------------------------------------
-- Table `dw_overhill`.`DimHistCost`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`DimHistCost` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`DimHistCost` (
  `CostID` INT NOT NULL AUTO_INCREMENT,
  `ProdCode` INT NOT NULL,
  `ProdYear` INT NOT NULL,
  `TotalProdVolume` INT NOT NULL,
  `AvgProdCost` DECIMAL(7,4) NOT NULL,
  `PackageSize` INT NOT NULL,
  PRIMARY KEY (`CostID`),
  INDEX `idx_year` (`ProdYear` ASC) ,
  INDEX `idx_product` (`ProdCode` ASC) );


-- -----------------------------------------------------
-- Table `dw_overhill`.`DimProducts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`DimProducts` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`DimProducts` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `ProdCode` VARCHAR(45) NULL,
  `Description` VARCHAR(100) NULL,
  `Group` VARCHAR(50) NULL,
  `Type` VARCHAR(50) NULL,
  `Brand` VARCHAR(50) NULL,
  `CostID` INT NULL,
  `SalesPrice` DECIMAL(7,2) NULL,
  `PriceVersion` INT NULL,
  `PriceDateFrom` DATE NULL,
  `PriceDateTo` DATE NULL,
  PRIMARY KEY (`ProductID`),
  INDEX `idx_group` (`Group` ASC) ,
  INDEX `idx_type` (`Type` ASC) ,
  INDEX `idx_brand` (`Brand` ASC) ,
  INDEX `fk_DimProducts_DimHistCost1_idx` (`CostID` ASC) ,
  CONSTRAINT `fk_DimProducts_DimHistCost1`
    FOREIGN KEY (`CostID`)
    REFERENCES `dw_overhill`.`DimHistCost` (`CostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `dw_overhill`.`DimCities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`DimCities` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`DimCities` (
  `CityID` INT NOT NULL AUTO_INCREMENT,
  `CityName` VARCHAR(50) NULL,
  PRIMARY KEY (`CityID`),
  INDEX `city_name_idx` (`CityName` ASC) );


-- -----------------------------------------------------
-- Table `dw_overhill`.`DimLocations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`DimLocations` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`DimLocations` (
  `LocationID` INT NOT NULL AUTO_INCREMENT,
  `CityID` INT NOT NULL,
  `LocationName` VARCHAR(50) NOT NULL,
  `PostCode` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`LocationID`),
  INDEX `fk_city_id_idx` (`CityID` ASC) ,
  INDEX `idx_postcode` (`PostCode` ASC) ,
  CONSTRAINT `fk_DimLocations_DimCities1`
    FOREIGN KEY (`CityID`)
    REFERENCES `dw_overhill`.`DimCities` (`CityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `dw_overhill`.`DimCustomers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`DimCustomers` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`DimCustomers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `CustKey` INT NULL,
  `Name` VARCHAR(50) NULL,
  `LastAddress` VARCHAR(500) NULL,
  `CurrentAddress` VARCHAR(500) NULL,
  `LocationID` INT NULL,
  `LastUpdated` DATE NULL,
  `Market` VARCHAR(50) NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `fk_customer_dim_location1_idx` (`LocationID` ASC) ,
  INDEX `idx_name` (`Name` ASC) ,
  INDEX `idx_market` (`Market` ASC) ,
  CONSTRAINT `fk_customer_dim_location1`
    FOREIGN KEY (`LocationID`)
    REFERENCES `dw_overhill`.`DimLocations` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `dw_overhill`.`DimAgents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`DimAgents` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`DimAgents` (
  `AgentID` INT NOT NULL AUTO_INCREMENT,
  `AgentKey` VARCHAR(50) NULL,
  `AgentFirstName` VARCHAR(50) NULL,
  `CommissionRate` DECIMAL(2,2) NULL DEFAULT 0,
  `AgentStartDate` DATE NULL,
  `AgentFinishDate` DATE NULL,
  `Version` INT NULL,
  `AgentLastName` VARCHAR(50) NULL,
  INDEX `idx_agent_name` (`AgentFirstName` ASC) ,
  PRIMARY KEY (`AgentID`));


-- -----------------------------------------------------
-- Table `dw_overhill`.`DimDates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`DimDates` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`DimDates` (
  `TimeID` INT NOT NULL AUTO_INCREMENT,
  `DateNum` INT NOT NULL,
  `Date` DATE NOT NULL,
  `YearMonthNum` INT NOT NULL,
  `Calendar_Quarter` VARCHAR(50) NOT NULL,
  `MonthNum` INT NOT NULL,
  `MonthName` VARCHAR(50) NOT NULL,
  `MonthShortName` VARCHAR(50) NOT NULL,
  `WeekNum` INT NOT NULL,
  `DayNumOfYear` INT NOT NULL,
  `DayNumOfMonth` INT NOT NULL,
  `DayNumOfWeek` INT NOT NULL,
  `DayName` VARCHAR(50) NOT NULL,
  `DayShortName` VARCHAR(50) NOT NULL,
  `Quarter` INT NOT NULL,
  `YearQuarterNum` INT NOT NULL,
  `DayNumOfQuarter` INT NOT NULL,
  PRIMARY KEY (`TimeID`),
  INDEX `idx_week` (`WeekNum` ASC) ,
  INDEX `idx_month` (`MonthName` ASC) ,
  INDEX `idx_quarter` (`Calendar_Quarter` ASC) ,
  INDEX `idx_date` (`Date` ASC) ,
  INDEX `idx_day` (`DayNumOfMonth` ASC) );


-- -----------------------------------------------------
-- Table `dw_overhill`.`DimMarkets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`DimMarkets` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`DimMarkets` (
  `MarketID` INT NOT NULL AUTO_INCREMENT,
  `MarketKey` VARCHAR(50) NOT NULL,
  `MarketName` VARCHAR(200) NOT NULL,
  `isActive` TINYINT NOT NULL,
  PRIMARY KEY (`MarketID`),
  CONSTRAINT `fk_DimMarkets_DimCustomers1`
    FOREIGN KEY (`MarketKey`)
    REFERENCES `dw_overhill`.`DimCustomers` (`Market`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `dw_overhill`.`WeeklyGrainSalesFact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`WeeklyGrainSalesFact` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`WeeklyGrainSalesFact` (
  `SalesID` INT NOT NULL AUTO_INCREMENT,
  `ProductID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `AgentID` INT NOT NULL,
  `TimeID` INT NOT NULL,
  `MarketID` INT NOT NULL,
  `TotalUnitsSold` INT NOT NULL,
  `TotalSales` DECIMAL(7,2) NOT NULL,
  `TotalCost` DECIMAL(7,2) NOT NULL,
  `TotalCommission` DECIMAL(7,2) NOT NULL,
  `TotalGrossMargin` DECIMAL(7,2) NOT NULL,
  `TotalNetMargin` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`SalesID`),
  INDEX `FK` (`ProductID` ASC, `CustomerID` ASC, `AgentID` ASC) ,
  INDEX `fk_weekly_grain_sales_fact_product_dim_idx` (`ProductID` ASC) ,
  INDEX `fk_weekly_grain_sales_fact_agent_dim_idx` (`AgentID` ASC) ,
  INDEX `idx_total_margin` (`TotalGrossMargin` ASC) ,
  INDEX `fk_WeeklyGrainSalesFact_DimDates1_idx` (`TimeID` ASC) ,
  INDEX `fk_WeeklyGrainSalesFact_DimMarkets1_idx` (`MarketID` ASC) ,
  INDEX `fk_weekly_grain_sales_fact_customer_dim1_idx` (`CustomerID` ASC) ,
  CONSTRAINT `fk_weekly_grain_sales_fact_product_dim1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `dw_overhill`.`DimProducts` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_weekly_grain_sales_fact_customer_dim1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `dw_overhill`.`DimCustomers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_WeeklyGrainSalesFact_DimAgents1`
    FOREIGN KEY (`AgentID`)
    REFERENCES `dw_overhill`.`DimAgents` (`AgentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_WeeklyGrainSalesFact_DimDates1`
    FOREIGN KEY (`TimeID`)
    REFERENCES `dw_overhill`.`DimDates` (`TimeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_WeeklyGrainSalesFact_DimMarkets1`
    FOREIGN KEY (`MarketID`)
    REFERENCES `dw_overhill`.`DimMarkets` (`MarketID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `dw_overhill`.`TxGrainSalesFact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`TxGrainSalesFact` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`TxGrainSalesFact` (
  `SalesID` INT NOT NULL ,
  `LineID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `AgentID` INT NOT NULL,
  `TimeID` INT NOT NULL,
  `MarketID` INT NOT NULL,
  `UnitsCost` DECIMAL(7,2) NOT NULL,
  `UnitSales` DECIMAL(7,2) NOT NULL,
  `GrossMargin` DECIMAL(7,2) NOT NULL,
  `NetMargin` DECIMAL(7,2) NOT NULL,
  `CommissionAmount` DECIMAL(7,2) NOT NULL,
  INDEX `FK` (`ProductID` ASC, `CustomerID` ASC, `AgentID` ASC) ,
  INDEX `fk_tx_grain_sales_fact_product_dim_idx` (`ProductID` ASC) ,
  INDEX `fk_tx_grain_sales_fact_agent_dim_idx` (`AgentID` ASC) ,
  INDEX `idx_total_margin` (`GrossMargin` ASC) ,
  INDEX `fk_TxGrainSalesFact_DimDates1_idx` (`TimeID` ASC) ,
  INDEX `fk_TxGrainSalesFact_DimMarkets1_idx` (`MarketID` ASC) ,
  INDEX `fk_weekly_grain_sales_fact_customer_dim10_idx` (`CustomerID` ASC) ,
  CONSTRAINT `fk_weekly_grain_sales_fact_product_dim10`
    FOREIGN KEY (`ProductID`)
    REFERENCES `dw_overhill`.`DimProducts` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_weekly_grain_sales_fact_customer_dim10`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `dw_overhill`.`DimCustomers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TxGrainSalesFact_DimAgents1`
    FOREIGN KEY (`AgentID`)
    REFERENCES `dw_overhill`.`DimAgents` (`AgentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TxGrainSalesFact_DimDates1`
    FOREIGN KEY (`TimeID`)
    REFERENCES `dw_overhill`.`DimDates` (`TimeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TxGrainSalesFact_DimMarkets1`
    FOREIGN KEY (`MarketID`)
    REFERENCES `dw_overhill`.`DimMarkets` (`MarketID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
