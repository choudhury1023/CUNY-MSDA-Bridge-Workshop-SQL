-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ATT
-- -----------------------------------------------------
-- Database contains record of ATT employees and organistional structure

-- -----------------------------------------------------
-- Schema ATT
--
-- Database contains record of ATT employees and organistional structure
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ATT` ;
USE `ATT` ;

DROP TABLE IF EXISTS employee;

-- -----------------------------------------------------
-- Table `ATT`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ATT`.`employee` (
  `emp_id` DECIMAL(10,0) NOT NULL,
  `emp_name` VARCHAR(75) NULL,
  `sup_id` DECIMAL(10,0) NULL,
  `j_title` VARCHAR(50) NULL,
  PRIMARY KEY (`emp_id`))
ENGINE = InnoDB;

INSERT INTO employee VALUES (001, 'Randall Stephenson', 000, 'Chairman and Chief Executive Officer');
INSERT INTO employee VALUES (002, 'Ralph de la Vega', 001, 'Vice Chairman');
INSERT INTO employee VALUES (003, 'John Donovan', 001, 'Chief Strategy Officer');
INSERT INTO employee VALUES (004, 'Lori Lee', 001,'Senior Executive Vice President');
INSERT INTO employee VALUES (005, 'John Stephens', 001, 'Chief Financial Officer');
INSERT INTO employee VALUES (006, 'John Stankey', 001, 'CEO–AT&T Entertainment Group');
INSERT INTO employee VALUES (007, 'LeAnn Priebe', 002, 'South Central Region President');
INSERT INTO employee VALUES (008, 'Steven J. Hodges', 002, 'President of Northeast Region');
INSERT INTO employee VALUES (009, 'Kirk Baily', 008, 'Director New York');
INSERT INTO employee VALUES (010, 'Linda Mayers', 008, 'Director New Jersy');
INSERT INTO employee VALUES (011, 'Bradly Kaiser', 009, 'Area Manager Long Island');
INSERT INTO employee VALUES (012, 'Derek Sheriff', 009, 'Area Manager Queens');
INSERT INTO employee VALUES (013, 'Ankur Sod', 009, 'Area Manager Manhattan');

SELECT
	employee.emp_id AS 'Employee ID',
    employee.emp_name AS 'Name',
    employee.j_title AS 'Tilte', 
    supervisor.emp_name AS 'Reports to',
    supervisor.j_title AS 'Supervisor Title'
FROM 
    employee AS employee LEFT JOIN 
    employee AS supervisor
	ON employee.sup_id = supervisor.emp_id
	ORDER BY employee.emp_id;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
