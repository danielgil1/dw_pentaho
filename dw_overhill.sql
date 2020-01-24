-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dw_overhill
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dw_overhill` ;
USE `dw_overhill` ;

-- -----------------------------------------------------
-- Table `dw_overhill`.`country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`country` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`country` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `country_name` INT NOT NULL,
  PRIMARY KEY (`country_id`),
  INDEX `idx_country_name` (`country_name` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `dw_overhill`.`time_dim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`time_dim` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`time_dim` (
  `time_id` INT NOT NULL AUTO_INCREMENT,
  `DateNum` INT NOT NULL,
  `Date` DATETIME NOT NULL,
  `YearMonthNum` INT NOT NULL,
  `CalendarQuarter` VARCHAR(50) NOT NULL,
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
  PRIMARY KEY (`time_id`),
  INDEX `idx_week` (`WeekNum` ASC) VISIBLE,
  INDEX `idx_month` (`MonthName` ASC) VISIBLE,
  INDEX `idx_quarter` (`CalendarQuarter` ASC) VISIBLE,
  INDEX `idx_date` (`Date` ASC) VISIBLE,
  INDEX `idx_day` (`DayNumOfMonth` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `dw_overhill`.`hist_cost_dim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`hist_cost_dim` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`hist_cost_dim` (
  `cost_id` INT NOT NULL AUTO_INCREMENT,
  `total_prod_volume` INT NOT NULL,
  `avg_production_cost` DECIMAL(7,2) NOT NULL,
  `year` INT NOT NULL,
  PRIMARY KEY (`cost_id`),
  INDEX `idx_year` (`year` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `dw_overhill`.`product_dim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`product_dim` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`product_dim` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `sku` VARCHAR(50) NULL DEFAULT NULL,
  `description` INT NOT NULL,
  `group` INT NOT NULL,
  `type` INT NOT NULL,
  `brand` INT NOT NULL,
  `cost_id` INT NOT NULL,
  `sales_price` DECIMAL(7,2) NOT NULL,
  `size_package` INT NOT NULL,
  `type_package` VARCHAR(50) NOT NULL,
  `price_start_date` BLOB NOT NULL,
  `price_end_date` DATETIME NOT NULL DEFAULT '9999-12-31',
  `perc_alcohol` DECIMAL(2,1) NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `idx_sku` (`sku` ASC) VISIBLE,
  INDEX `fk_product_dim_hist_cost_dim_idx` (`cost_id` ASC) VISIBLE,
  INDEX `idx_group` (`group` ASC) VISIBLE,
  INDEX `idx_type` (`type` ASC) VISIBLE,
  INDEX `idx_brand` (`brand` ASC) VISIBLE,
  CONSTRAINT `fk_product_dim_hist_cost_dim`
    FOREIGN KEY (`cost_id`)
    REFERENCES `dw_overhill`.`hist_cost_dim` (`cost_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `dw_overhill`.`market_dim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`market_dim` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`market_dim` (
  `market_id` INT NOT NULL AUTO_INCREMENT,
  `market_name` INT NOT NULL,
  `opening_date` DATETIME NOT NULL,
  `closure_date` DATETIME NOT NULL DEFAULT '9999-12-31',
  `maraket_valuation` DECIMAL(7,2) NULL DEFAULT NULL,
  PRIMARY KEY (`market_id`),
  INDEX `idx_opening_date` (`opening_date` ASC) VISIBLE,
  INDEX `idx_market_name` (`market_name` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `dw_overhill`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`city` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `country_id` INT NOT NULL,
  `city_name` INT NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_country_id_idx` (`country_id` ASC) VISIBLE,
  INDEX `idx_city_name` (`city_name` ASC) VISIBLE,
  CONSTRAINT `fk_city_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `dw_overhill`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `dw_overhill`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`location` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`location` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `city_id` INT NOT NULL,
  `location_name` INT NOT NULL,
  `postcode` INT NOT NULL,
  PRIMARY KEY (`location_id`),
  INDEX `fk_city_id_idx` (`city_id` ASC) VISIBLE,
  INDEX `idx_postcode` (`postcode` ASC) VISIBLE,
  CONSTRAINT `fk_location_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `dw_overhill`.`city` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `dw_overhill`.`customer_dim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`customer_dim` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`customer_dim` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `industry_name` VARCHAR(50) NULL,
  `company_name` VARCHAR(50) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `website` VARCHAR(50) NULL DEFAULT NULL,
  `last_address` VARCHAR(50) NULL,
  `current_address` VARCHAR(50) NOT NULL,
  `location_id` INT NOT NULL,
  `is_active` INT NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_customer_dim_location1_idx` (`location_id` ASC) VISIBLE,
  INDEX `idx_industry_name` (`industry_name` ASC) VISIBLE,
  INDEX `idx_company_name` (`company_name` ASC) VISIBLE,
  INDEX `idx_name` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_customer_dim_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `dw_overhill`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `dw_overhill`.`weekly_grain_sales_fact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`weekly_grain_sales_fact` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`weekly_grain_sales_fact` (
  `sales_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `market_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `time_id` INT NOT NULL,
  `agent_id` INT NOT NULL,
  `total_units_sold` INT NOT NULL,
  `total_dollar_sales` DECIMAL(7,2) NOT NULL,
  `total_cost` DECIMAL(7,2) NOT NULL,
  `total_margin` DECIMAL(7,2) NOT NULL,
  `commision_amount` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`sales_id`),
  INDEX `FK` (`product_id` ASC, `market_id` ASC, `customer_id` ASC, `time_id` ASC, `agent_id` ASC) VISIBLE,
  INDEX `fk_weekly_grain_sales_fact_time_dim1_idx` (`time_id` ASC) VISIBLE,
  INDEX `fk_weekly_grain_sales_fact_market_dim1_idx` (`market_id` ASC) VISIBLE,
  INDEX `fk_weekly_grain_sales_fact_customer_dim1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_weekly_grain_sales_fact_product_dim_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_weekly_grain_sales_fact_agent_dim_idx` (`agent_id` ASC) VISIBLE,
  INDEX `idx_total_margin` (`total_margin` ASC) VISIBLE,
  CONSTRAINT `fk_weekly_grain_sales_fact_time_dim1`
    FOREIGN KEY (`time_id`)
    REFERENCES `dw_overhill`.`time_dim` (`time_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_weekly_grain_sales_fact_product_dim1`
    FOREIGN KEY (`product_id`)
    REFERENCES `dw_overhill`.`product_dim` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_weekly_grain_sales_fact_market_dim1`
    FOREIGN KEY (`market_id`)
    REFERENCES `dw_overhill`.`market_dim` (`market_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_weekly_grain_sales_fact_customer_dim1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `dw_overhill`.`customer_dim` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `dw_overhill`.`agent_dim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`agent_dim` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`agent_dim` (
  `agent_id` INT NOT NULL AUTO_INCREMENT,
  `agent_name` VARCHAR(50) NOT NULL,
  `commision_rate` DECIMAL(2,2) NOT NULL,
  `agent_start_date` DATETIME NOT NULL,
  `agent_finish_date` DATETIME NOT NULL DEFAULT '9999-12-31',
  PRIMARY KEY (`agent_id`),
  INDEX `idx_agent_name` (`agent_name` ASC) VISIBLE,
  CONSTRAINT `fk_agent_dim_weekly_grain_sales_fact1`
    FOREIGN KEY (`agent_id`)
    REFERENCES `dw_overhill`.`weekly_grain_sales_fact` (`agent_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `dw_overhill`.`tx_grain_sales_fact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_overhill`.`tx_grain_sales_fact` ;

CREATE TABLE IF NOT EXISTS `dw_overhill`.`tx_grain_sales_fact` (
  `sales_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `market_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `time_id` INT NOT NULL,
  `agent_id` INT NOT NULL,
  `units_sold` INT NOT NULL,
  `dollar_sales` DECIMAL(7,2) NOT NULL,
  `cost` DECIMAL(7,2) NOT NULL,
  `margin` DECIMAL(7,2) NOT NULL,
  `commision_amount` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`sales_id`),
  INDEX `FK` (`product_id` ASC, `market_id` ASC, `customer_id` ASC, `time_id` ASC, `agent_id` ASC) VISIBLE,
  INDEX `fk_tx_grain_sales_fact_time_dim1_idx` (`time_id` ASC) VISIBLE,
  INDEX `fk_tx_grain_sales_fact_market_dim1_idx` (`market_id` ASC) VISIBLE,
  INDEX `fk_tx_grain_sales_fact_customer_dim1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_tx_grain_sales_fact_product_dim_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_tx_grain_sales_fact_agent_dim_idx` (`agent_id` ASC) VISIBLE,
  INDEX `idx_total_margin` (`margin` ASC) VISIBLE,
  CONSTRAINT `fk_weekly_grain_sales_fact_time_dim10`
    FOREIGN KEY (`time_id`)
    REFERENCES `dw_overhill`.`time_dim` (`time_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_weekly_grain_sales_fact_product_dim10`
    FOREIGN KEY (`product_id`)
    REFERENCES `dw_overhill`.`product_dim` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_weekly_grain_sales_fact_market_dim10`
    FOREIGN KEY (`market_id`)
    REFERENCES `dw_overhill`.`market_dim` (`market_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_weekly_grain_sales_fact_customer_dim10`
    FOREIGN KEY (`customer_id`)
    REFERENCES `dw_overhill`.`customer_dim` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
