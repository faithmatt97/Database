#After running this once, make sure to highlight query only or error will occur



#Functional Dependencies

#ID--> FirstName, LastName, birthdate    
#MPAANumber --> moviename, yearReleased  


    DROP TABLE IF EXISTS people CASCADE;
    DROP TABLE IF EXISTS Directedin CASCADE;
    DROP TABLE IF EXISTS Actedin CASCADE;
    DROP TABLE IF EXISTS actors CASCADE;
    DROP TABLE IF EXISTS directors CASCADE;
    DROP TABLE IF EXISTS movies CASCADE;







    CREATE TABLE IF NOT EXISTS Movies(
    MPAANumber                INT NOT NULL UNIQUE,
    moviename                      TEXT NOT NULL,
    yearReleased              INT NOT NULL,
    domesticBoxOfficeSalesUSD INT NOT NULL,
    foreignBoxOfficeSalesUSD  INT NOT NULL,
    dvdBlueRaySalesUSD        INT NOT NULL,
    primary key (MPAANumber)

    );

    CREATE TABLE IF NOT EXISTS People (
        id            INT NOT NULL UNIQUE,
        firstName     TEXT NOT NULL,
        lastName      TEXT NOT NULL,
        address       TEXT NOT NULL,
        spouseName    TEXT NOT NULL,
        primary key (id)
    );


    CREATE TABLE IF NOT EXISTS Actors (
    id            INT NOT NULL REFERENCES People(id)UNIQUE ,
    birthdate     DATE NOT NULL,  
    HairColor     TEXT NOT NULL,
    eyeColor      TEXT NOT NULL,
    heightInches  FLOAT NOT NULL,
    weight        INT NOT NULL,
    favoriteColor TEXT NOT NULL,
    primary key (id)
    );


    CREATE TABLE IF NOT EXISTS Directors (
    id               INT NOT NULL REFERENCES People(id),
    filmSchool       TEXT NOT NULL,
    directorsAnnDate DATE NOT NULL,
    favLensMaker     TEXT NOT NULL,
     primary key (id)
    );


    CREATE TABLE IF NOT EXISTS DirectedBy (
    MPAANumber INT NOT NULL REFERENCES Movies(MPAANumber),
    id         INT NOT NULL REFERENCES People(id),
    primary key(id,MPAAnumber)
    );


    CREATE TABLE IF NOT EXISTS ActedIn (
    MPAANumber INT NOT NULL REFERENCES Movies(MPAANumber),  
    id         INT NOT NULL REFERENCES People(id)  ,
    primary key(id,MPAAnumber)
    );

    #Populating tables wth sample data

    INSERT INTO People (id,firstName, lastName, address, spouseName)
    VALUES
    (1,'Amy', 'Lamey', '700 Cornrow Avenue', 'Alexander Revelation'),
    (2,'Sean', 'Connery', '560 Candylane Bridge', ' Micheline Roquebrune'),
    (3,'Taraji', 'Henson', 'Empire', 'She does not have one'),
    (4,'Terrance', 'Young', '678 Nine Street', 'Berkely Mather'),
    (5,'Jonathan', 'Zurer', '790 Riverdale Park', 'Lily Stormwood'),
    (6,'John', 'McTiernan', '800 Cash Now' ,'Karren Kyak'),
    (7,'Yeet', 'Fam', '857 Tinton Avenue', 'CarryAnn Limp'),
    (8,'Deadassb', 'Timbs', '777 Prospect', 'Barbra Simpson');






    INSERT INTO movies
    VALUES
    (1, 'The Hunt For Red October', 1990 , 12203, 785, 2345),
    (2, 'Dr. No', 1962, 123, 2344, 65787),
    (3, 'Trainwreck', 2015, 342, 45, 0),
    (4, 'Think Like A Man',2011, 43245, 65785, 2156);

    INSERT INTO Directors
    VALUES
    (5, 'California Film Academy', '01-01-2020', 'Gr8 Productions'),
    (6, 'Thriller Uni', '2051-09-21', 'GG'),
    (4, 'Dos Los Randos', '2017-04-16', 'Gr8 Productions'),
    (7, 'Blah Blah', '7021-11-20', 'Sample Data'),
    (8, 'Blah Blah', '2023-02-03', 'Sample Data');

    INSERT INTO Actors
    VALUES
    (1, '01-01-1980', 'blonde' ,'hazel', 61, 167, 'blue'),
    (3, '06-07-1975', 'black', 'brown', 66, 135, 'red'),
    (2, '09-18-1956' , 'white', 'blue', 75, 150, 'black');

    INSERT INTO DirectedBy (MPAANumber, id)
    VALUES
    (2, 4),
    (1, 5),
    (1, 6),
    (3, 7),
    (4, 8);

    INSERT INTO ActedIN
    VALUES
    (3, 1),
    (4, 3),
    (1, 2),
    (2, 2);

 
        
  select firstname, lastname, directors.id
  from Directors,People
  Where directors.id=People.id AND directors.id in
  		(select id 
         from DirectedBy
         WHere MPAANumber in
         		(select MPAANumber
                 from Actedin
                 WHere id in
                 		(select id
                         from Actors
                         where id in
                         		(select id
                                 from People
                                 where firstname='Sean' AND lastname='Connery'))))
                
    

