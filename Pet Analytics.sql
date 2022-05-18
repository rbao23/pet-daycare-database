----lab 7 
----Bonnie


USE Master
GO
drop database IMT_563_Lab7_03

---1) Create a brand new database (Bonnie)
Create database IMT_563_Lab7_03

---2) Use this new database (Bonnie)
USE IMT_563_Lab7_03

---3）Code the following tables into this database (Bonnie)
---3a. PET_TYPE
CREATE TABLE tblPET_TYPE(
    PetTypeID INT IDENTITY(1,1) primary key, 
    PetTypeName varchar(50) not null,
    PetDescr varchar(500) null
)
GO

---3b. COUNTRY
CREATE TABLE tblCOUNTRY(
    CountryID INT IDENTITY(1,1) primary key, 
    CountryName varchar(50) not null)
GO

---3c.TEMPERAMENT
CREATE TABLE tblTEMPERAMENT(
    TempID INT IDENTITY(1,1) primary key, 
    TempName varchar(50) not null,
    TempDescr varchar(500) null)
GO

---3d.GENDER
CREATE TABLE tblGENDER(
    GenderID INT IDENTITY(1,1) primary key, 
    GenderName varchar(50) not null)
GO

---3e.HOBBY
CREATE TABLE tblHOBBY(
    HobbyID INT IDENTITY(1,1) primary key, 
    HobbyName varchar(50) not null,
    HobbyDescr varchar(500) null)
GO

---3f.PET
CREATE TABLE tblPET(
    PetID INT IDENTITY(1,1) primary key, 
    PetName varchar(50) not null, 
    PetTypeID INT FOREIGN KEY REFERENCES tblPET_TYPE(PetTypeID) not null,
    CountryID INT FOREIGN KEY REFERENCES tblCOUNTRY(CountryID) not null,
    TempID INT FOREIGN KEY REFERENCES tblTEMPERAMENT(TempID) not null,
    Cost Numeric(8,2) not null,
    DOB date null, 
    GenderID INT FOREIGN KEY REFERENCES tblGENDER(GenderID))
GO

---3g.PET_HOBBY
CREATE TABLE tblPET_HOBBY(
    PetHobbyID INT IDENTITY(1,1) primary key, 
    PetID INT FOREIGN KEY REFERENCES tblPET(PetID) not null, 
    HobbyID INT FOREIGN KEY REFERENCES tblHOBBY(HobbyID) not null, 
    HobbyNum INT NULL)
GO

---4.Launch IMPORT Wizard (Bonnie)
SELECT *
INTO RAW_PetData
FROM gthayL3.dbo.RAW_DATA

---5.next get a clean copy of raw dataset
-- get rid of rows have null values in any PetName, PetType, Temperament,...
CREATE TABLE [dbo].CleanPet_PK(
    PetID INT IDENTITY(1,1) primary key,
	[PETNAME] [nvarchar](255) NULL,
	[PET_TYPE] [nvarchar](255) NULL,
	[TEMPERAMENT] [nvarchar](255) NULL,
	[COUNTRY] [nvarchar](255) NULL,
	[DATE_BIRTH] [date] NULL,
	[GENDER] [nvarchar](255) NULL,
	[HOBBY1] [nvarchar](255) NULL,
	[HOBBY2] [nvarchar](255) NULL,
	[HOBBY3] [nvarchar](255) NULL,
	[HOBBY4] [nvarchar](255) NULL,
	[Cost] [numeric](8, 2) NULL
) ON [PRIMARY]
GO

INSERT INTO CleanPet_PK
SELECT *
FROM RAW_PetData
WHERE PetName IS NOT NULL
AND Pet_Type IS NOT NULL
AND Gender IS NOT NULL 
AND Temperament IS NOT NULL
AND Date_Birth IS NOT NULL
AND Country IS NOT NULL
AND Date_Birth <= GetDate()

--Pet type
INSERT INTO tblPET_TYPE (PetTypeName)
SELECT DISTINCT PET_TYPE
From CleanPet_PK

--Country
INSERT INTO tblCOUNTRY (CountryName)
SELECT DISTINCT Country
From CleanPet_PK

--Temperament
INSERT INTO tblTEMPERAMENT (TempName)
SELECT DISTINCT Temperament
From CleanPet_PK

--Gender
INSERT INTO tblGENDER(GenderName)
SELECT DISTINCT Gender
From CleanPet_PK

---Hobby
CREATE TABLE #TempHobby
(HobbyName varchar(70))

INSERT INTO #TempHobby
SELECT DISTINCT HOBBY4
From CleanPet_PK

INSERT INTO tblHOBBY(HobbyName)
SELECT DISTINCT HobbyName
From #TempHobby
WHERE HobbyName is not null
GO

-- write nested 'GetID' stored procedures (GenderID, TempID, PetTypeID, PetID, HobbyID)
CREATE PROCEDURE ruihabGetGenderID
@GenName varchar(15),
@GenderID INT OUTPUT
AS
SET @GenderID = (SELECT GenderID FROM tblGENDER WHERE GenderName = @GenName)
GO
CREATE PROCEDURE ruihabGetPetTypeID
@PTypeName varchar(50),
@PTypeID INT OUTPUT
AS
SET @PTypeID = (SELECT PetTypeID FROM tblPET_TYPE WHERE PetTypeName = @PTypeName)
GO
CREATE PROCEDURE ruihabGetTemperamentID
@T_Name varchar(50),
@Temp_ID INT OUTPUT
AS
SET @Temp_ID = (SELECT TempID FROM tblTEMPERAMENT WHERE TempName = @T_Name)
GO
CREATE PROCEDURE ruihabGetCountryID
@CountryName varchar(50),
@CntID INT OUTPUT
AS
SET @CntID = (SELECT CountryID FROM tblCOUNTRY WHERE CountryName = @CountryName)
GO
CREATE PROCEDURE ruihabGetRegionID
@R_Name varchar(50),
@RegID INT OUTPUT
AS
SET @RegID = (SELECT RegionID FROM tblREGION WHERE RegionName = @R_Name)
GO
CREATE PROCEDURE ruihabGetHobbyTypeID
@HT_Name varchar(50),
@HobT_ID INT OUTPUT
AS
SET @HobT_ID = (SELECT HobbyTypeID FROM tblHOBBY_TYPE WHERE HobbyTypeName = @HT_Name)
GO
CREATE PROCEDURE ruihabGetHobbyID
@HB_Name varchar(50),
@HB_ID INT OUTPUT
AS
SET @HB_ID = (SELECT HobbyID FROM tblHOBBY WHERE HobbyName = @HB_Name)

--Create 'WORKING_COPY_Pets'
IF EXISTS (SELECT * FROM sys.sysobjects WHERE NAME = '#WORKING_COPY_Pets') -- will need to run the following block of code minus the DROP table line the very first time
    BEGIN
        SELECT *
        DROP table #WORKING_COPY_Pets
        INTO #WORKING_COPY_Pets
        FROM CleanPet_PK
        ORDER BY PetID 
END


---- ALTER TABLE tblPET and Add the column Price with a data type of numeric (8,2)
ALTER TABLE tblPet
ADD Price NUMERIC(8,2) 

--------Create Fee Type Table------
    CREATE TABLE tblFEE_TYPE
    (Fee_TypeID INT IDENTITY(1,1) primary key,
    FeeTypeName varchar(50) not null,
    FeeTypeDescr varchar(500) NULL)
    GO

    INSERT INTO tblFEE_TYPE (FeeTypeName)
    VALUES ('Percentage'), ('Dollar')
    GO

-- write the code to add tblHOBBY_TYPE --> 'musical Talent' ; domestic skills; gaming/artistic
CREATE TABLE tblHOBBY_TAG
(HobbyTagID INT IDENTITY(1,1) primary key,
HobbyTagName varchar(50) not null,
HobbyTagDescr varchar(500) not null)
GO

INSERT INTO tblHOBBY_TAG (HobbyTagName, HobbyTagDescr)
VALUES ('Musical', 'Play as a musical instrument'),('Domestic', 'Keeps the house working well'), 
('Engagement', 'Plays games or draws well')
GO

ALTER TABLE tblHOBBY
ADD HobbyTagID INT
FOREIGN KEY REFERENCES tblHOBBY_TAG (HobbyTagID)
GO

UPDATE tblHOBBY
SET HobbyTagID = (SELECT HobbyTagID FROM tblHOBBY_TAG WHERE HobbyTagName = 
'Musical')
WHERE HobbyName IN ('Piano','Guitar', 'MusicListening')
UPDATE tblHOBBY
SET HobbyTagID = (SELECT HobbyTagID FROM tblHOBBY_TAG WHERE HobbyTagName = 
'Domestic')
WHERE HobbyName IN ('Cooking','Knitting', 'HomeRepairProjects')
UPDATE tblHOBBY
SET HobbyTagID = (SELECT HobbyTagID FROM tblHOBBY_TAG WHERE HobbyTagName = 
'Engagement')
WHERE HobbyName IN ('Gaming','Painting','Drawing', 'Chess')

--- Create and insert Tag Table
 Create Table tblTag
 (TagID INT IDENTITY(1,1) primary key,
  Tag varchar(75) not null)

 INSERT INTO tblTag (Tag)
    VALUES ('Musical'),
    ('Domestic'),
    ('Engagement'),
    ('OutdoorBuddy'),
    ('PeacefulBuddy')
    GO

----- Add tagid in tblHobby_Tag
ALTER TABLE tblHOBBY_TAG
ADD TagID INT
FOREIGN KEY REFERENCES tblTag (TagID)
GO

UPDATE tblHobby_Tag
SET TagID = (SELECT TagID FROM tblTag WHERE Tag = 
'Musical')
WHERE HobbyTagName = 'Musical'

UPDATE tblHobby_Tag
SET TagID = (SELECT TagID FROM tblTag WHERE Tag = 
'Domestic')
WHERE HobbyTagName = 'Domestic'

UPDATE tblHobby_Tag
SET TagID = (SELECT TagID FROM tblTag WHERE Tag = 
'Engagement')
WHERE HobbyTagName = 'Engagement'

--------Create REGION Table and add Region ID in Table Country------
CREATE TABLE tblREGION
    (RegionID INT IDENTITY(1,1) primary key,
    RegionName varchar(75) not null)

     
INSERT INTO tblREGION (RegionName)
VALUES ('South America'),('Asia'),('Africa'),('North America'),('Caribbean'), ('Europe'), ('South Pacific'), ('Central America')

ALTER TABLE tblCOUNTRY
ADD RegionID INT FOREIGN KEY REFERENCES tblREGION (RegionID)

    UPDATE tblCOUNTRY
    SET RegionID = (SELECT RegionID FROM tblREGION WHERE RegionName = 'Caribbean')
    WHERE CountryName IN ('The Bahamas','Barbados','Cuba','Dominican Republic','Haiti','Jamaica','Trinidad')


    UPDATE tblCOUNTRY
    SET RegionID = (SELECT RegionID FROM tblREGION WHERE RegionName = 'Asia')
    WHERE CountryName IN ('Taiwan','Vietnam', 'Thailand','Japan', 'Russia','Laos', 'China', 'India', 'Phillipines', 'Korea', 'Kazakhstan','Pakistan')

    UPDATE tblCOUNTRY
    SET RegionID = (SELECT RegionID FROM tblREGION WHERE RegionName = 'Africa')
    WHERE CountryName IN ('Uganda','Egypt', 'Kenya')

    UPDATE tblCOUNTRY
    SET RegionID = (SELECT RegionID FROM tblREGION WHERE RegionName = 'North America')
    WHERE CountryName IN ('United States','Mexico', 'Canada')

    UPDATE tblCOUNTRY
    SET RegionID = (SELECT RegionID FROM tblREGION WHERE RegionName = 'South America')
    WHERE CountryName IN ('Peru','Brazil','Columbia', 'Venezuela')
    
    UPDATE tblCOUNTRY
    SET RegionID = (SELECT RegionID FROM tblREGION WHERE RegionName = 'Central America')
    WHERE CountryName IN ('Costa Rica','Panama')
    
    UPDATE tblCOUNTRY
    SET RegionID = (SELECT RegionID FROM tblREGION WHERE RegionName = 'South Pacific')
    WHERE CountryName IN ('Singapore', 'Malaysia', 'Autralia')
    
    UPDATE tblCOUNTRY
    SET RegionID = (SELECT RegionID FROM tblREGION WHERE RegionName = 'Europe')
    WHERE CountryName IN ('Germany', 'Iceland', 'France')

--------Create Fee Table------
    CREATE TABLE tblFEE
    (FeeID INT IDENTITY(1,1) primary key,
    FeeName varchar(50) not null,
    FeeAmount numeric(8,3) null,
    FeeTypeID INT FOREIGN KEY REFERENCES tblFEE_TYPE (Fee_TypeID) NOT NULL,
    FeeDescr varchar(500) NULL )
    GO

    INSERT INTO tblFEE (FeeName, FeeAmount, FeeTypeID)
    VALUES ('Asian Travel Fee', 3.75, (SELECT Fee_TypeID FROM tblFEE_TYPE WHERE FeeTypeName = 'Dollar')),
    ('European Tax',11.5, (SELECT Fee_TypeID FROM tblFEE_TYPE WHERE FeeTypeName = 'Percentage')),
    ('Insurance Fee', 23.50, (SELECT Fee_TypeID FROM tblFEE_TYPE WHERE FeeTypeName = 'Dollar')),
    ('Luxury Fee', 15.00, (SELECT Fee_TypeID FROM tblFEE_TYPE WHERE FeeTypeName = 'Dollar')),
    ('Thawing Fee', 4.25, (SELECT Fee_TypeID FROM tblFEE_TYPE WHERE FeeTypeName = 'Dollar')),
    ('Musical Talent Fee', 20.00, (SELECT Fee_TypeID FROM tblFEE_TYPE WHERE FeeTypeName = 'Dollar')),
    ('Domestic Talent Fee', 14.00, (SELECT Fee_TypeID FROM tblFEE_TYPE WHERE FeeTypeName = 'Dollar')),
    ('Engagement Talent Fee', 11.00, (SELECT Fee_TypeID FROM tblFEE_TYPE WHERE FeeTypeName = 'Dollar')),
    ('South American Tariff', 6.00, (SELECT Fee_TypeID FROM tblFEE_TYPE WHERE FeeTypeName = 'Dollar'))
    GO

--------Create Pet Fee Table------
    CREATE TABLE tblPET_FEE
    (PetID INT FOREIGN KEY REFERENCES tblPET (PetID) not null,
    FeeID INT FOREIGN KEY REFERENCES tblFEE (FeeID) not null,
    PRIMARY KEY (PetID, FeeID))
    GO

-----------------------------insert Pet & PetHobby Table -------------------------
-- read the first row and rip all of the values into variables (these are all reusable!)
-- DECLARE 11 named variables
DECLARE @Pet varchar(50), @PType varchar(50), @Gend varchar(20), @Temper varchar(50), 
@Country varchar(50), @Cost numeric(8,2), @DOB Date, @Hob1 varchar(50), @Hob2 varchar(50), @Hob3 
varchar(50), @Hob4 varchar(50)
DECLARE @MIN_PK INT -- keep track of which row/PK we are reading and ripping
DECLARE @RUN INT  = (SELECT COUNT(*) FROM #WORKING_COPY_Pets) -- keeps track of WHILE loop total loops --> row count of the Working_Copy (in this case 4577) --> must be outside loop
DECLARE @PT_ID INT, @T_ID INT, @C_ID INT, @G_ID INT,  @P_ID INT, @H_ID1 INT, @H_ID2 
INT, @H_ID3 INT, @H_ID4 INT, @HobNum INT -- DECLARE these outside the WHILE loop
WHILE @RUN > 0
BEGIN
-- determine @Min_PK to anchor single row to rip
SET @MIN_PK = (SELECT MIN(PetID) FROM #WORKING_COPY_Pets)
--populate the 'name' variables from the top row of working copy; must equate to @Min_PK
SET @Pet = (SELECT PetName FROM #WORKING_COPY_Pets WHERE PetID = @MIN_PK)
SET @PType = (SELECT Pet_Type FROM #WORKING_COPY_Pets WHERE PetID = @MIN_PK)
SET @Gend = (SELECT Gender FROM #WORKING_COPY_Pets WHERE PetID = @MIN_PK)
SET @Temper = (SELECT Temperament FROM #WORKING_COPY_Pets WHERE PetID = 
@MIN_PK)
SET @Country = (SELECT Country FROM #WORKING_COPY_Pets WHERE PetID = @MIN_PK)
SET @DOB = (SELECT Date_Birth FROM #WORKING_COPY_Pets WHERE PetID = @MIN_PK)
SET @Cost = (SELECT Cost FROM #WORKING_COPY_Pets WHERE PetID = @MIN_PK)
SET @Hob1 = (SELECT Hobby1 FROM #WORKING_COPY_Pets WHERE PetID = @MIN_PK)
SET @Hob2 = (SELECT Hobby2 FROM #WORKING_COPY_Pets WHERE PetID = @MIN_PK)
SET @Hob3 = (SELECT Hobby3 FROM #WORKING_COPY_Pets WHERE PetID = @MIN_PK)
SET @Hob4 = (SELECT Hobby4 FROM #WORKING_COPY_Pets WHERE PetID = @MIN_PK)
-- call the 4 nested stored procedures for obtaining the required FK values in tblPET (PetTypeID, GenderID, TemperamentID, CountryID)
EXEC ruihabGetCountryID
@CountryName = @Country,
@CntID = @C_ID OUTPUT
EXEC ruihabGetTemperamentID
@T_Name = @Temper,
@Temp_ID = @T_ID OUTPUT
EXEC ruihabGetPetTypeID
@PTypeName = @PType,
@PTypeID = @PT_ID OUTPUT
EXEC ruihabGetGenderID
@GenName = @Gend,
@GenderID = @G_ID OUTPUT
EXEC ruihabGetHobbyID
@HB_Name = @Hob1,
@HB_ID = @H_ID1 OUTPUT
EXEC ruihabGetHobbyID
@HB_Name = @Hob2,
@HB_ID = @H_ID2 OUTPUT
EXEC ruihabGetHobbyID
@HB_Name = @Hob3,
@HB_ID = @H_ID3 OUTPUT
EXEC ruihabGetHobbyID
@HB_Name = @Hob4,
@HB_ID = @H_ID4 OUTPUT
BEGIN TRANSACTION T1
INSERT INTO tblPET (PetName, PetTypeID, TempID, CountryID, DOB, GenderID, Cost)
VALUES (@Pet, @PT_ID, @T_ID, @C_ID, @DOB, @G_ID, @Cost)
SET @P_ID = (SELECT SCOPE_IDENTITY()) -- get the most-recent Identity value provided by the database within the scope of my transaction)
INSERT INTO tblPET_HOBBY (PetID, HobbyID, HobbyNum)
VALUES (@P_ID, @H_ID1, 1), (@P_ID, @H_ID2, 2), (@P_ID, @H_ID3, 3), (@P_ID, @H_ID4, 4)
IF @@ERROR <> 0
BEGIN
PRINT '@@ERROR <> 0; terminating process'
ROLLBACK TRANSACTION T1
END
ELSE 
COMMIT TRANSACTION T1
DELETE from #WORKING_COPY_Pets WHERE PetID = @MIN_PK -- delete the most-recent row from working copy to prevent re-read of same data
SET @RUN = @RUN - 1 -- decrement the outer WHILE loop to prevent infinite loop
PRINT @RUN
END
PRINT 'ALL DONE!'


-----populate pet_fee table
--- Asian Travel Fee
CREATE TABLE #PetFeeStaging
(PetFeeID INT IDENTITY(1,1) primary key,
PetID INT NOT NULL,
FeeID INT NOT NULL)
GO
INSERT INTO #PetFeeStaging
SELECT PetID, (SELECT FeeID FROM tblFEE WHERE FeeName =  'Asian Travel Fee')
FROM tblPET P
JOIN tblCOUNTRY C ON P.CountryID = C.CountryID
JOIN tblREGION R ON C.RegionID = R.RegionID
WHERE R.RegionName = 'Asia'
GO
INSERT INTO tblPET_FEE (PetID,FeeID)
SELECT PetID, FeeID
FROM #PetFeeStaging
DROP TABLE #PetFeeStaging

--- European Fee
CREATE TABLE #PetFeeStaging
(PetFeeID INT IDENTITY(1,1) primary key,
PetID INT NOT NULL,
FeeID INT NOT NULL)
GO
INSERT INTO #PetFeeStaging
SELECT PetID, (SELECT FeeID FROM tblFEE WHERE FeeName =  'European Tax')
FROM tblPET P
JOIN tblCOUNTRY C ON P.CountryID = C.CountryID
JOIN tblREGION R ON C.RegionID = R.RegionID
WHERE R.RegionName = 'Europe'
GO
INSERT INTO tblPET_FEE (PetID,FeeID)
SELECT PetID, FeeID
FROM #PetFeeStaging
DROP TABLE #PetFeeStaging

--- Insurance 
CREATE TABLE #PetFeeStaging
(PetFeeID INT IDENTITY(1,1) primary key,
PetID INT NOT NULL,
FeeID INT NOT NULL)
GO
INSERT INTO #PetFeeStaging
SELECT PetID, (SELECT FeeID FROM tblFEE WHERE FeeName =  'Insurance Fee')
FROM tblPET P
JOIN tblTEMPERAMENT T on T.TempID = P.TempID
WHERE T.TempName in ('Irascible','Defiant','Surly')
GO
INSERT INTO tblPET_FEE (PetID,FeeID)
SELECT PetID, FeeID
FROM #PetFeeStaging
DROP TABLE #PetFeeStaging

--- Luxury Fee 
CREATE TABLE #PetFeeStaging
(PetFeeID INT IDENTITY(1,1) primary key,
PetID INT NOT NULL,
FeeID INT NOT NULL)
GO
INSERT INTO #PetFeeStaging
SELECT PetID, (SELECT FeeID FROM tblFEE WHERE FeeName =  'Luxury Fee')
FROM tblPET P
JOIN tblTEMPERAMENT T on T.TempID = P.TempID
WHERE TempName in ('Loving','Pleasant','Friendly')
GO
INSERT INTO tblPET_FEE (PetID,FeeID)
SELECT PetID, FeeID
FROM #PetFeeStaging
DROP TABLE #PetFeeStaging

--- Thawing Fee 
CREATE TABLE #PetFeeStaging
(PetFeeID INT IDENTITY(1,1) primary key,
PetID INT NOT NULL,
FeeID INT NOT NULL)
GO
INSERT INTO #PetFeeStaging
SELECT PetID, (SELECT FeeID FROM tblFEE WHERE FeeName =  'Thawing Fee')
FROM tblPET P
JOIN tblCOUNTRY C ON P.CountryID = C.CountryID
WHERE C.CountryName = 'Iceland'
GO
INSERT INTO tblPET_FEE (PetID,FeeID)
SELECT PetID, FeeID
FROM #PetFeeStaging
DROP TABLE #PetFeeStaging


--- Tariff
CREATE TABLE #PetFeeStaging
(PetFeeID INT IDENTITY(1,1) primary key,
PetID INT NOT NULL,
FeeID INT NOT NULL)
GO
INSERT INTO #PetFeeStaging
SELECT PetID, (SELECT FeeID FROM tblFEE WHERE FeeName =  'South American Tariff')
FROM tblPET P
JOIN tblCOUNTRY C ON P.CountryID = C.CountryID
JOIN tblREGION R ON C.RegionID = R.RegionID
WHERE R.RegionName = 'South America'
GO
INSERT INTO tblPET_FEE (PetID,FeeID)
SELECT PetID, FeeID
FROM #PetFeeStaging
DROP TABLE #PetFeeStaging

--- Value add 1: musical talent
CREATE TABLE #PetFeeStaging
(PetFeeID INT IDENTITY(1,1) primary key,
PetID INT NOT NULL,
FeeID INT NOT NULL)
GO
INSERT INTO #PetFeeStaging
SELECT distinct P.PetID, (SELECT FeeID FROM tblFEE WHERE FeeName =  'Musical Talent Fee')
FROM tblPET P
JOIN tblPET_HOBBY PH ON PH.PetID = P.PetID
JOIN tblHOBBY H ON H.HobbyID = PH.HobbyID
JOIN tblHOBBY_TAG HT ON HT.HobbyTagID = H.HobbyTagID
WHERE HT.HobbyTagName = 'Musical'
GO
INSERT INTO tblPET_FEE (PetID,FeeID)
SELECT PetID, FeeID
FROM #PetFeeStaging
DROP TABLE #PetFeeStaging

--- Value add 2: domestic talent
CREATE TABLE #PetFeeStaging
(PetFeeID INT IDENTITY(1,1) primary key,
PetID INT NOT NULL,
FeeID INT NOT NULL)
GO
INSERT INTO #PetFeeStaging
SELECT distinct P.PetID, (SELECT FeeID FROM tblFEE WHERE FeeName =  'Domestic Talent Fee')
FROM tblPET P
JOIN tblPET_HOBBY PH ON PH.PetID = P.PetID
JOIN tblHOBBY H ON H.HobbyID = PH.HobbyID
JOIN tblHOBBY_TAG HT ON HT.HobbyTagID = H.HobbyTagID
WHERE HT.HobbyTagName = 'Domestic'
GO
INSERT INTO tblPET_FEE (PetID,FeeID)
SELECT PetID, FeeID
FROM #PetFeeStaging
DROP TABLE #PetFeeStaging


--- Value add 2: domestic talent
CREATE TABLE #PetFeeStaging
(PetFeeID INT IDENTITY(1,1) primary key,
PetID INT NOT NULL,
FeeID INT NOT NULL)
GO
INSERT INTO #PetFeeStaging
SELECT distinct P.PetID, (SELECT FeeID FROM tblFEE WHERE FeeName =  'Engagement Talent Fee')
FROM tblPET P
JOIN tblPET_HOBBY PH ON PH.PetID = P.PetID
JOIN tblHOBBY H ON H.HobbyID = PH.HobbyID
JOIN tblHOBBY_TAG HT ON HT.HobbyTagID = H.HobbyTagID
WHERE HT.HobbyTagName = 'Engagement'
GO
INSERT INTO tblPET_FEE (PetID,FeeID)
SELECT PetID, FeeID
FROM #PetFeeStaging
DROP TABLE #PetFeeStaging


select * from tblTag