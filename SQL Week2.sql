-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema how-to
-- -----------------------------------------------------
-- This database keeps a track of best "how-to" videos on youtube

-- -----------------------------------------------------
-- Schema how-to
--
-- This database keeps a track of best "how-to" videos on youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `how-to` ;
USE `how-to` ;

-- -----------------------------------------------------
-- Table `how-to`.`Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `how-to`.`Videos` (
  `unique_ID` INT NOT NULL,
  `title` VARCHAR(150) NULL,
  `length_min` DECIMAL(10,0) NULL,
  `URL` VARCHAR(150) NULL,
  PRIMARY KEY (`unique_ID`))
ENGINE = InnoDB;

#populate Videos Table

INSERT INTO Videos (unique_ID, title, length_min, URL)
SELECT 001, 'introduction to sql server 2008 - create schema', 12,
'https://www.youtube.com/watch?v=jxKyNQYV4zA'
WHERE NOT EXISTS (SELECT * FROM Videos WHERE unique_ID=001);

INSERT INTO Videos (unique_ID, title, length_min, URL)
SELECT 002, 'Github Tutorial For Beginners - Github Basics for Mac or Windows & Source Control Basics', 19,
'https://www.youtube.com/watch?v=0fKg7e37bQE'
WHERE NOT EXISTS (SELECT * FROM Videos WHERE unique_ID=002);

INSERT INTO Videos (unique_ID, title, length_min, URL)
SELECT 003, 'Installing SQL Server 2014 in Windows 10', 10,
'https://www.youtube.com/watch?v=LXvsKtX-boI'
WHERE NOT EXISTS (SELECT * FROM Videos WHERE unique_ID=003);



-- -----------------------------------------------------
-- Table `how-to`.`Reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `how-to`.`Reviews` (
  `review_id` INT NOT NULL,
  `unique_ID` VARCHAR(45) NULL,
  `reviewrs_name` VARCHAR(50) NULL,
  `rating` DECIMAL(10,0) NULL,
  `review` VARCHAR(250) NULL,
  PRIMARY KEY (`review_id`))
ENGINE = InnoDB;

#Populate reviews Table

INSERT INTO reviews (review_id, unique_ID, reviewrs_name, rating, review)
SELECT 101, 001,'JILL', 4,'very informational!'
WHERE NOT EXISTS (SELECT * FROM reviews WHERE  review_id = 101);


INSERT INTO reviews (review_id, unique_ID, reviewrs_name, rating, review)
SELECT 102, 001,'JILL', 4,'AWESOME!'
WHERE NOT EXISTS (SELECT * FROM reviews WHERE  review_id = 102);



INSERT INTO reviews (review_id, unique_ID, reviewrs_name, rating, review)
SELECT 103, 002,'John', 5,'Great!'
WHERE NOT EXISTS (SELECT * FROM reviews WHERE  review_id = 103);



INSERT INTO reviews (review_id, unique_ID, reviewrs_name, rating, review)
SELECT 104, 002,'Jesse', 4,'really helpful!'
WHERE NOT EXISTS (SELECT * FROM reviews WHERE  review_id = 104);


#Join statement

SELECT * FROM Videos LEFT JOIN Reviews 
ON videos.unique_ID = reviews.unique_ID
ORDER BY videos.unique_ID;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


