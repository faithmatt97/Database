DROP  SEQUENCE  IF EXISTS lid_id_seq CASCADE;
DROP  SEQUENCE  IF EXISTS xid_id_seq CASCADE;
DROP  SEQUENCE  IF EXISTS monID_id_seq CASCADE;
DROP  SEQUENCE  IF EXISTS pid_id_seq CASCADE;

DROP TYPE IF EXISTS wType CASCADE;
DROP TYPE IF EXISTS typeofmaterial CASCADE;
DROP TYPE IF EXISTS effect CASCADE;
DROP TYPE IF EXISTS effectStr CASCADE;
DROP TYPE IF EXISTS nonedibletype CASCADE;

DROP TABLE IF EXISTS locations CASCADE;
DROP TABLE IF EXISTS items CASCADE;
DROP TABLE IF EXISTS Players CASCADE;
DROP TABLE IF EXISTS PlayerInventory CASCADE;
DROP TABLE IF EXISTS Monsters CASCADE;
DROP TABLE IF EXISTS KeyItems CASCADE;
DROP TABLE IF EXISTS Equipment CASCADE;
DROP TABLE IF EXISTS Materials CASCADE;
DROP TABLE IF EXISTS Armor CASCADE;
DROP TABLE IF EXISTS Weapons CASCADE;
DROP TABLE IF EXISTS EdibleMaterials CASCADE;
DROP TABLE IF EXISTS nonEdibleMaterials CASCADE;
DROP TABLE IF EXISTS nonEdibleEffects CASCADE;
DROP TABLE IF EXISTS MaterialswithEffects CASCADE;

DROP TABLE IF EXISTS hasitem CASCADE;

CREATE SEQUENCE IF NOT EXISTS lid_id_seq;
CREATE SEQUENCE IF NOT EXISTS xid_id_seq;
CREATE SEQUENCE IF NOT EXISTS monID_id_seq;
CREATE SEQUENCE IF NOT EXISTS pid_id_seq;

CREATE TYPE typeOfMaterial AS ENUM ('Fruit', 'Vegetation' , 'Meat', 
                                    'Elixir', 'Food', 'Machinery', 
                                    'Critter', 'Ore' ,'Monster Part');

CREATE TYPE effect AS ENUM ('None','Heat Resistance', 'Cold Resistance',
                            'Stealth', 'Shock Resistance',
                            'Attack', 'Defense,', 'Stamina' , 
                            'Health Increase', 'Movement');
							


CREATE TYPE effectStr AS ENUM ('None','Low', 'Med' ,'High');

CREATE TYPE aType AS ENUM ('Head', 'Feet', 'Body');
CREATE TABLE IF NOT EXISTS Locations (
  lid INT default nextval('lid_id_seq')primary key NOT NULL,
  locationName TEXT NOT NULL
  
);

CREATE TABLE IF NOT EXISTS Items (
  xid         INT default nextval('xid_id_seq')UNIQUE  NOT NULL,
  itemName    TEXT NOT NULL UNIQUE,
  Primary Key (xid)  
);
CREATE TABLE IF NOT EXISTS Players(
  pid         INT default nextval('pid_id_seq')UNIQUE  NOT NULL,
  playerName  TEXT NOT NULL,
  Primary Key (pid)
);
CREATE TABLE IF NOT EXISTS PlayerInventory (
  pid	 	  INT NOT NULL REFERENCES players(pid),
  xid         INT NOT NULL REFERENCES items(xid), 
  Qty         INT NOT NULL,
  Primary Key (pid, xid)
);


CREATE TABLE IF NOT EXISTS keyitems(
  xid	              INT NOT NULL REFERENCES Items(xid) UNIQUE,
  description         TEXT NOT NULL,
  Primary Key  (xid)
);

CREATE TABLE IF NOT EXISTS Materials(
  xid             INT NOT NULL REFERENCES Items(xid) UNIQUE,
  typeOfMaterial  typeofMaterial NOT NULL,
  salePriceRupees INT NOT NULL,
  Primary Key     (xid)
);

CREATE TABLE IF NOT EXISTS Equipment(
  xid	          INT NOT NULL REFERENCES Items(xid) UNIQUE,
  Primary Key     (xid)
);

CREATE TABLE IF NOT EXISTS Armor(
  xid             INT NOT NULL REFERENCES Items(xid) UNIQUE,
  baseDef         INT NOT NULL,
  Armortype       atype NOT NULL,
  Primary key (xid)
);
CREATE TYPE wType AS ENUM ('1H', '2H', 'Bow', 'Arrow');
CREATE TABLE IF NOT EXISTS Weapons (   
  xid             INT NOT NULL REFERENCES Items(xid) UNIQUE,
  baseAtk         INT NOT NULL,
  WeaponType      wType
);
	
CREATE TABLE IF NOT EXISTS Monsters(
  monID           INT default nextval('monID_id_seq'),
  monsterName     TEXT NOT NULL,
  Primary Key (monID)
);

CREATE TABLE IF NOT EXISTS MaterialsWithEffects(
  xid  INT NOT NULL REFERENCES materials(xid) UNIQUE,
  effectBoost  effect NOT NULL,
  effectBoostStrength    effectStr NOT NULL,
  Primary key (xid)
);


CREATE TABLE IF NOT EXISTS MaterialsNoEffects(
  xid  INT NOT NULL REFERENCES materials(xid) UNIQUE,
  Primary key(xid)
);


CREATE TABLE IF NOT EXISTS EdibleMaterials(
     xid             INT NOT NULL REFERENCES materials(xid) UNIQUE,
     heartsRestored  FLOAT NOT NULL,
      Primary Key (xid)
    );
 
 CREATE TABLE IF NOT EXISTS NonEdibleMaterials(
      xid             INT NOT NULL REFERENCES materials(xid) UNIQUE,
      Primary Key (xid)
     );
 CREATE TABLE IF NOT EXISTS NonEdibleEffects(
 	  xid             INT NOT NULL REFERENCES items(xid) UNIQUE,
      effectBoost     effect NOT NULL,
      effectBoostStrength effectStr NOT NULL,
      Primary key (xid)
      );
  CREATE TABLE IF NOT EXISTS HasItem(
      lid             INT NOT NULL REFERENCES locations(lid),
      xid             INT NOT NULL REFERENCES items(xid),
	  Primary key   (xid,lid)
  );
  CREATE TABLE IF NOT EXISTS MonsterDrops (
      monid 			 INT NOT NULL REFERENCES monsters(monid),
      xid            INT NOT NULL REFERENCES items(xid), 
      Primary Key   (xid, monid)
      
  );
  
  CREATE TABLE IF NOT EXISTS HasMonster(
      lid       INT NOT NULL REFERENCES locations(lid),
      monid     INT NOT NULL REFERENCES Monsters(monid),
      Primary Key (lid, monid)
  );
--Populating Tables with sample Data--

INSERT into Locations (locationName)
VALUES 
('Zoras Domain'),
('Central Hyrule'),
('Tabantha Frontier'),
('Hebra'),
('Eldin'),
('East Nucluda'),
('West Nucluda');

INSERT INTO Items 
VALUES 
(1,'Keese Wing'),
(2,'Keese Eyeball'),
(3,'Ruby' ),
(4,'Diamond'),
(5,'Sapphire'),
(6,'Hearty Salmon'),
(7,'Raw Gourmet Meat'),
(8,'Blue Nightshade'),
(9,'Silent Princess'),
(10,'Apple'),
(11,'Wildberry'),
(12,'Ancient Spring'),
(13,'Ancient Core'),
(14,'Tireless Frog'), 
(15,'Cold Darner'),
(16,'Hasty Elixir'),
(17, 'Spicy Elixir'),
(18,'Sneaky Meaty Rice Balls'),
(19,'Energizing Honeyed Apply'),
(20,'Paraglider'),
(21,'Stealth Mask'),
(22,'Zora Armor'),
(23,'Lightscale Trident'),
(24,'Flameblade'),
(25,'Great Frostblade'),
(26,'Knights Bow'), 
(27,'Lynel Bow'),
(28,'Ancient Arrow'),
(29,'Bomb Arrow'),
(30, 'Knights Shield'),
(31,'Steel Lizal Shield');

INSERT INTO KeyItems
		VALUES
		(20,'Allows you to glide from high places');
INSERT INTO Equipment 
VALUES
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31);
	INSERT INTO MATERIALS
	VALUES
	(1,'Monster Part' ,2),
	(2,'Monster Part', 20),
	(3,'Ore', 210),
	(4, 'Ore',500),
	(5, 'Ore',260),
	(6,'Meat',10),
	(7, 'Meat',35),
	(8, 'Vegetation',4),
	(9, 'Vegetation',10),
	(10, 'Fruit',3),
	(11, 'Fruit',3),
	(12, 'Machinery',15),
	(13, 'Machinery',80),
	(14, 'Critter',20), 
	(15, 'Critter',2);
	
	
	
INSERT INTO Armor 
    VALUES
    (21, 2,'Head'),
    (22, 3,'Body');
	
INSERT INTO Weapons
    VALUES
    (23, 26, '2H'),
    (24, 24,'1H'),
    (25, 30, '1H'),
    (26, 26, 'Bow'),
	(27, 10, 'Bow'),
    (28, 0, 'Arrow'),
    (29, 0, 'Arrow');

   INSERT INTO MaterialsNoEffects
   VALUES
   (1),
   (2),
   (3),
   (4),
   (5),
   (6),
   (12),
   (13);
    
   INSERT INTO MaterialsWithEffects
    VALUES
    (6,  'Health Increase', 'Low'),
    (8, 'Stealth', 'Low'),
    (9, 'Stealth', 'Med');

   
	Insert INTO NonEdibleMaterials 
    VALUES
    (1),
    (2),
    (3),
    (4),
    (5),
    (12),
    (13),
    (14),
    (15);
    
 INSERT INTO EdibleMaterials
    VALUES 
    (6, 4),
    (7, 5),
    (10, 0.5),
    (11, 0.5);

    INSERT INTO nonEdibleEffects
    VALUES
    (1, 'None' , 'None'),
    (2,'None', 'None'),
    (14, 'Stamina', 'Med'),
    (15,'Heat Resistance','Low');
    
    INSERT INTO hasItem
    VALUES
    (1, 10),
    (1, 11),
    (5, 8),
    (7, 9),
    (3,14),
    (2,15);
INSERT INTO Monsters (monsterName)
VALUES 
('Keese'),
('Fire Keese'),
('Electric Keese');

INSERT INTO MonsterDrops
VALUES
(1,1),
(1,2),
(2,1),
(2,2),
(3,2);

INSERT INTO HasMonster
VALUES
(1, 3),
(5, 2),
(7, 3);

INSERT INTO Players (playername)
VALUES
('Alan'),
('Skull Kid'),
('Tilted');

INSERT INTO PlayerInventory
VALUES
(1,31, 2),
(1,2, 20),
(1,4, 100),
(2,7,1);

--List all weapons and their attack stats
CREATE OR REPLACE VIEW WeaponStats AS
select items.xid, itemName, baseAtk
from weapons, items
WHERE items.xid=weapons.xid;
--list all armor and their defense stats


CREATE OR REPLACE VIEW ArmorStats as
select items.xid, itemName,armortype ,baseDef
from items, Armor
where items.xid=armor.xid;

CREATE OR REPLACE VIEW MatsEffectsInfo   AS
select materialswitheffects.xid, itemname, salepricerupees, effectboost, effectbooststrength, typeofmaterial
from  materials, materialswitheffects,items
where materials.xid=materialswitheffects.xid AND items.xid=materials.xid;

CREATE OR REPLACE VIEW HealthRestoreItems AS
SELECT ediblematerials.xid, itemname, heartsrestored 
from items,ediblematerials
where ediblematerials.xid=items.xid;


SELECT * 
from playerinventory;

SELECT playername, count(xid) As  NumOfDiffItems
FROM players, playerinventory
WHERE players.pid= playerinventory.pid
GROUP BY playername;

select playername, SUM(qty) AS numOfItems
FROM players, playerinventory
WHERE players.pid= playerinventory.pid
GROUP BY playername;


select playername, playerinventory.xid, qty, (salepriceRupees*qty) AS BulkSellPriceRupees
FROM players, playerinventory, materials
WHERE players.pid= playerinventory.pid AND playerinventory.xid=materials.xid;




--Armor DEf and weapon def functions 
create or replace function DefGreaterThan (int, REFCURSOR) returns refcursor as
$$

declare
   def int := $1;
   resultset REFCURSOR := $2;
begin 
	open resultset for
    	 select items.xid,itemname, basedef
	   from items, armor
	   where items.xid=armor.xid AND basedef in 
			(select basedef
             from weapons
             where basedef>=def);
            return resultset;
            
            end;
        $$
        language plpgsql;



create or replace function Atkgreaterthan (int, REFCURSOR) returns refcursor as
$$

declare
   atk int := $1;
   resultset REFCURSOR := $2;
begin 
	open resultset for
       select  items.xid,itemname, baseAtk
	   from items, weapons
	   where items.xid=weapons.xid AND baseAtk in 
			(select baseAtk
             from weapons
             where baseAtk>=atk);
            return resultset;
            
            end;
        $$
        language plpgsql;
        
        
create or replace function locHasItems (text, REFCURSOR) returns refcursor as
$$
declare
   loc text := $1;
   resultset REFCURSOR := $2;
begin 
	open resultset for
       select itemname, items.xid, locations.lid
        from  items, locations, hasitem
        Where hasitem.xid=items.xid 
        AND   hasitem.lid=locations.lid
        AND hasitem.lid in
        		(select lid
                 from hasitem
        		where loc LIKE locationName);
            return resultset;
            end;
        $$
        language plpgsql;
        
        
 CREATE OR REPLACE FUNCTION removeFromInvent()
RETURNS TRIGGER AS
$$
BEGIN
IF new.Qty <= 0
THEN

DELETE FROM PlayerInventory
WHERE PlayerInventory.qty =0;
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER removeFromInvent
AFTER UPDATE on PlayerInventory
FOR EACH ROW
EXECUTE PROCEDURE removeFromInvent();

select locHasItems('Zoras Domain', 'results');
Fetch all from results; 




             
            


