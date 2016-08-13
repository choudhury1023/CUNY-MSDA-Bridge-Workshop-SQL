-- 1. Using MySQL Workbench, create a new database called BuildingEnergy. All of the work below should be
-- completed in the BuildingEnergy database. The SQL script should be self-contained, such that if it runs again it
-- will re-create the database.

DROP SCHEMA IF EXISTS BuildingEnergy;
CREATE SCHEMA BuildingEnergy;
USE BuildingEnergy;

-- 2. You should first create two tables, EnergyCategories and EnergyTypes. Each energy category can have
-- many energy types.
-- • Populate the EnergyCategories table with rows for Fossil and Renewable.
-- • Populate the EnergyTypes table with rows for Electricity, Gas, Steam, Fuel Oil, Solar, and Wind.
-- • In the EnergyTypes table, you should indicate that Electricity, Gas, Steam, and Fuel Oil are Fossil energy
-- sources, while Solar and Wind are renewable energy sources.
-- When inserting data into the tables, be sure to use an INSERT statement and not the table import wizard. 

DROP TABLE IF EXISTS EnergyCategories;
CREATE TABLE EnergyCategories (
cat_id INT NOT NULL,
cat VARCHAR(45) NOT NULL,
PRIMARY KEY (cat_id));

INSERT INTO EnergyCategories (cat_id, cat) VALUES (01, 'Fossil');
INSERT INTO EnergyCategories (cat_id, cat) VALUES (02, 'Renewable');

SELECT cat_id AS 'energycategory id', cat AS 'energycatagory' FROM EnergyCategories;


DROP TABLE IF EXISTS EnergyTypes;
CREATE TABLE EnergyTypes(
typ_id INT NOT NULL,
typ VARCHAR(45) NOT NULL,
cat_id INT REFERENCES EnergyCategories(cat_id),
PRIMARY KEY (typ_id));

INSERT INTO Energytypes (typ_id, typ, cat_id) VALUES (01, 'Electricity', 01);
INSERT INTO Energytypes (typ_id, typ, cat_id) VALUES (02, 'Fuel Oil', 01);
INSERT INTO Energytypes (typ_id, typ, cat_id) VALUES (03, 'Gas', 01);
INSERT INTO Energytypes (typ_id, typ, cat_id) VALUES (04, 'Solar', 02);
INSERT INTO Energytypes (typ_id, typ, cat_id) VALUES (05, 'Steam', 01);
INSERT INTO Energytypes (typ_id, typ, cat_id) VALUES (06, 'Wind', 02);

SELECT typ_id AS 'energytype id', typ AS 'energytype', cat_id AS 'energycategory id' FROM EnergyTypes;

-- 3. Write a JOIN statement that shows the energy categories and associated energy types that you entered
 
SELECT b.cat as 'energycategory', a.typ as 'energytype' 
FROM EnergyTypes a 
LEFT JOIN EnergyCategories b on a.cat_id = b.cat_id
ORDER BY a.typ;

-- 4. You should add a table called Buildings. There should be a many-to-many relationship between Buildings
-- and EnergyTypes. Here is the information that should be included about buildings in the database:
-- • Empire State Building; Energy Types: Electricity, Gas, Steam
-- • Chrysler Building; Energy Types: Electricity, Steam
-- • Borough of Manhattan Community College; Energy Types: Electricity, Steam, Solar

DROP TABLE IF EXISTS Buildings;
CREATE TABLE Buildings
(
  build_id INT NOT NULL,
  build_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (build_id));

INSERT INTO Buildings (build_id, build_name) VALUES (01, 'Empire State Building');
INSERT INTO Buildings (build_id, build_name) VALUES (02, 'Chrysler Building');
INSERT INTO Buildings (build_id, build_name) VALUES (03, 'Borough of Manhattan Community College');

SELECT build_id AS 'building id', build_name AS 'building' From Buildings;

-- 5. Write a JOIN statement that shows the buildings and associated energy types for each building.

DROP TABLE IF EXISTS EnergyTypesByBuildings;
CREATE TABLE EnergyTypesByBuildings
(
  build_id INT REFERENCES Buildings(build_id),
  typ_id INT REFERENCES EnergyTypes(typ_id)
);

INSERT INTO EnergyTypesByBuildings (build_id, typ_id) VALUES (01, 01);
INSERT INTO EnergyTypesByBuildings (build_id, typ_id) VALUES (01, 05);
INSERT INTO EnergyTypesByBuildings (build_id, typ_id) VALUES (01, 03);

INSERT INTO EnergyTypesByBuildings (build_id, typ_id) VALUES (02, 01);
INSERT INTO EnergyTypesByBuildings (build_id, typ_id) VALUES (02, 05);

INSERT INTO EnergyTypesByBuildings (build_id, typ_id) VALUES (03, 01);
INSERT INTO EnergyTypesByBuildings (build_id, typ_id) VALUES (03, 05);
INSERT INTO EnergyTypesByBuildings (build_id, typ_id) VALUES (03, 04);

SELECT build_id AS 'building id', typ_id AS 'energytype id' FROM EnergyTypesByBuildings;

SELECT a.build_name AS 'building', c.typ AS 'energytype' 
FROM Buildings a 
LEFT JOIN EnergyTypesByBuildings b ON a.build_id = b.build_id
LEFT JOIN EnergyTypes c ON b.typ_id = c.typ_id
ORDER BY a.build_name;

-- 6. Please add this information to the BuildingEnergy database, inserting rows as needed in various tables.
-- Building: Bronx Lion House; Energy Types: Geothermal
-- Brooklyn Childrens Museum: Energy Types: Electricity, Geothermal

INSERT INTO Buildings (build_id, build_name) VALUES (04, 'Bronx Lions House');
INSERT INTO Buildings (build_id, build_name) VALUES (05, 'Brooklyn Childrens Museum');

INSERT INTO Energytypes (typ_id, typ, cat_id) VALUES (07, 'Geothermal', 02);

INSERT INTO EnergyTypesByBuildings (build_id, typ_id) VALUES (04, 07);
INSERT INTO EnergyTypesByBuildings (build_id, typ_id) VALUES (05, 01);
INSERT INTO EnergyTypesByBuildings (build_id, typ_id) VALUES (05, 07);

-- 7. Write a SQL query that displays all of the buildings that use Renewable Energies.

SELECT d.build_name AS 'building', b.typ AS 'energytype', a.cat AS 'energycategory' from EnergyCategories as a 
LEFT JOIN EnergyTypes AS b ON a.cat_id = b.cat_id
RIGHT JOIN EnergyTypesByBuildings AS c ON b.typ_id = c.typ_id 
LEFT JOIN Buildings AS d ON c.build_id = d.build_id
WHERE a.cat = 'renewable';

-- 8. Write a SQL query that shows the frequency with which energy types are used in various buildings.

SELECT c.typ AS 'energyType', COUNT(*) AS 'count' 
FROM Buildings a 
LEFT JOIN EnergyTypesByBuildings b ON a.build_id = b.build_id
LEFT JOIN EnergyTypes c ON b.typ_id = c.typ_id
GROUP BY c.typ
ORDER BY COUNT(*) DESC;

-- 9. Do one (or more if you want!) of the following. 9(c) and 9(d) are both challenging--you are especially encouraged
-- to work on in a group if you tackle one or both of these exercises!
-- a. Create the appropriate foreign key constraints.

-- Foreign key constraints was used during the creation of the tables, for example cat_id in EnergyType table and typ_id and 
-- build_id in EnergyTypesByBuildings table.

-- b. Create an entity relationship (ER) diagram for the tables in the database. You can sketch this by hand and
-- include a photo or scan if you wish.

-- Please find the attached PDF named "SQL Final  ER Mockup"

-- c. Suppose you wanted to design a set of HTML pages to manage (add, edit, and delete) the information in the
-- various database tables; create a mockup of the user interface (on paper or using a package like Balsamiq
-- Mockups). 

-- Please find the attached PDF named "SQL Final  ER Mockup"