-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema key_cards
-- -----------------------------------------------------
-- This database maintains key-card access to rooms based on groups key-card holder belongs to.

-- -----------------------------------------------------
-- Schema key_cards
--
-- This database maintains key-card access to rooms based on groups key-card holder belongs to.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `key_cards` ;
USE `key_cards` ;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS groups;
DROP TABLE IF EXISTS rooms;

-- -----------------------------------------------------
-- Table `key_cards`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `key_cards`.`users` (
  `u_id` INT NOT NULL,
  `u_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`u_id`))
ENGINE = InnoDB;

INSERT INTO users (u_id, u_name)
SELECT 001, 'Modesto'
WHERE NOT EXISTS (SELECT * FROM users WHERE u_id=001);
INSERT INTO users (u_id, u_name)
SELECT 002, 'Ayine'
WHERE NOT EXISTS (SELECT * FROM users WHERE u_id=002);
INSERT INTO users (u_id, u_name)
SELECT 003, 'Christopher'
WHERE NOT EXISTS (SELECT * FROM users WHERE u_id=003);
INSERT INTO users (u_id, u_name)
SELECT 004, 'Cheong woo'
WHERE NOT EXISTS (SELECT * FROM users WHERE u_id=004);
INSERT INTO users (u_id, u_name)
SELECT 005, 'Saulat'
WHERE NOT EXISTS (SELECT * FROM users WHERE u_id=005);
INSERT INTO users (u_id, u_name)
SELECT 006, 'Heidy'
WHERE NOT EXISTS (SELECT * FROM users WHERE u_id=006);


-- -----------------------------------------------------
-- Table `key_cards`.`groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `key_cards`.`groups` (
  `g_entry` INT NOT NULL,
  `g_id` INT NOT NULL,
  `g_name` VARCHAR(45) NOT NULL,
  `u_id` INT NULL,
  PRIMARY KEY (`g_entry`))
ENGINE = InnoDB;
#'g_entry' column added to avoid giving same group two id's as primary key cannot be duplicate

INSERT INTO groups (g_entry, g_id, g_name, u_id)
SELECT 1, 01, 'I.T.', 001
WHERE NOT EXISTS (SELECT * FROM groups WHERE g_entry=01);
INSERT INTO groups (g_entry, g_id, g_name, u_id)
SELECT 2, 01, 'I.T.', 002
WHERE NOT EXISTS (SELECT * FROM groups WHERE g_entry=02);
INSERT INTO groups (g_entry, g_id, g_name, u_id)
SELECT 3, 02, 'Sales', 003
WHERE NOT EXISTS (SELECT * FROM groups WHERE g_entry=03);
INSERT INTO groups (g_entry, g_id, g_name, u_id)
SELECT 4, 02, 'Sales', 004
WHERE NOT EXISTS (SELECT * FROM groups WHERE g_entry=04);
INSERT INTO groups (g_entry, g_id, g_name, u_id)
SELECT 5, 03, 'Adminstration', 005
WHERE NOT EXISTS (SELECT * FROM groups WHERE g_entry=05);
INSERT INTO groups (g_entry, g_id, g_name, u_id)
SELECT 6, 04, 'Operations', null
WHERE NOT EXISTS (SELECT * FROM groups WHERE g_entry=06);


-- -----------------------------------------------------
-- Table `key_cards`.`rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `key_cards`.`rooms` (
  `r_entry` INT NOT NULL,
  `r_id` INT NOT NULL,
  `r_name` VARCHAR(45) NOT NULL,
  `g_id` INT NULL,
  PRIMARY KEY (`r_entry`))
ENGINE = InnoDB;
#'r_entry' column added to avoid giving same room two id's as primary key cannot be duplicate

INSERT INTO rooms (r_entry, r_id, r_name, g_id)
SELECT 1, 001, '101', 01
WHERE NOT EXISTS (SELECT * FROM rooms WHERE r_entry=1);
INSERT INTO rooms (r_entry, r_id, r_name, g_id)
SELECT 2, 002, '102', 01
WHERE NOT EXISTS (SELECT * FROM rooms WHERE r_entry=2);
INSERT INTO rooms (r_entry, r_id, r_name, g_id)
SELECT 3, 002, '102', 02
WHERE NOT EXISTS (SELECT * FROM rooms WHERE r_entry=3);
INSERT INTO rooms (r_entry, r_id, r_name, g_id)
SELECT 4, 003, 'Auditorium A', 02
WHERE NOT EXISTS (SELECT * FROM rooms WHERE r_entry=4);
INSERT INTO rooms (r_entry, r_id, r_name, g_id)
SELECT 5, 004, 'Auditorium B', null
WHERE NOT EXISTS (SELECT * FROM rooms WHERE r_entry=5);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


#All groups, and the users in each group. A group should appear even if there are no users assigned to the group
SELECT b.g_id AS Group_ID, b.g_name AS Group_Name, a.u_id AS User_ID, a.u_name AS User_Name FROM users a 
RIGHT JOIN groups b ON a.u_id = b.u_id;

#All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been
#assigned to them.
SELECT DISTINCT b.r_id AS Room_ID, b.r_name AS Room_Name, a.g_id AS Group_ID, a.g_name AS Group_Name FROM groups a 
RIGHT JOIN rooms b ON a.g_id = b.g_id
ORDER BY b.r_id;

#A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted
#alphabetically by user, then by group, then by room.
SELECT a.u_id as userid, a.u_name as employee_name, b.g_name as group_name, c.r_name as room_name FROM users a 
LEFT JOIN groups b ON a.u_id = b.u_id 
Left JOIN rooms c ON b.g_id = c.g_id 
ORDER BY a.u_name, b.g_name, c.r_name;
