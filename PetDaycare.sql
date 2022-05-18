---IMT 563 - PetDayCare System
--- Group 3: Bonnie & Amruta

/*
USE Master
GO
drop database IMT_563_Proj_03
*/

---Create a brand new database [Bonnie]
Create database IMT_563_Proj_03

Use IMT_563_Proj_03

---Create tables [Bonnie]
----DetailType 
CREATE TABLE DetailType(
    DetailTypeID INT IDENTITY(1,1) PRIMARY KEY, 
    DetailTypeName VARCHAR(50) NOT NULL,
    DetailTypeDesc VARCHAR(255) NOT NULL
)
GO

----- Detail
CREATE TABLE Detail(
    DetailID INT IDENTITY(1,1) PRIMARY KEY, 
    DetailTypeID INT FOREIGN KEY REFERENCES DetailType(DetailTypeID) NOT NULL,
    DetailName VARCHAR(50) NOT NULL,
    DetailDesc VARCHAR(255) NOT NULL
)
GO

----- PetGender
CREATE TABLE PetGender(
    PetGenderID INT IDENTITY(1,1) PRIMARY KEY, 
    PetGenderName VARCHAR(50) NOT NULL,
)
GO


----- PetBreed
CREATE TABLE PetBreed(
    PetBreedID INT IDENTITY(1,1) PRIMARY KEY, 
    PetTypeID INT FOREIGN KEY REFERENCES PetType(PetTypeID) NOT NULL,
    PetBreedName VARCHAR(50) NOT NULL,
    PetBreedDesc VARCHAR(500) NOT NULL,
)
GO

----- PetType
CREATE TABLE PetType(
    PetTypeID INT IDENTITY(1,1) PRIMARY KEY, 
    PetType VARCHAR(50) NOT NULL
)
GO

----- tblService
CREATE TABLE Service(
    ServiceID INT IDENTITY(1,1) PRIMARY KEY, 
    ServiceName VARCHAR(50) NOT NULL,
    ServiceDesc VARCHAR(255) NOT NULL,
    ServicePrice DECIMAL(4,2) NOT NULL,
    ServiceDuration INT NOT NULL
)
GO

----- PetOwner
CREATE TABLE PetOwner(
    PetOwnerID INT IDENTITY(1,1) PRIMARY KEY, 
    PetOwnerFname VARCHAR(30) NOT NULL,
    PetOwnerLname VARCHAR(30) NOT NULL,
    PetOwnerPhone VARCHAR(10) NOT NULL,
    PetOwnerAddress VARCHAR(50) NOT NULL,
    PetOwnerDOB DATE NOT NULL,
    ZIP VARCHAR(5) NOT NULL,
    CityID INT FOREIGN KEY REFERENCES City(CityID) NOT NULL
)
GO
----- Pet
CREATE TABLE Pet(
    PetID INT IDENTITY(1,1) PRIMARY KEY, 
    PetName VARCHAR(50) NOT NULL,
    PetOwnerID INT FOREIGN KEY REFERENCES PetOwner(PetOwnerID) NOT NULL,
    PetGenderID INT FOREIGN KEY REFERENCES PetGender(PetGenderID) NOT NULL,
    PetBreedID INT FOREIGN KEY REFERENCES PetBreed(PetBreedID) NOT NULL,
    PetDateOfBirth DATE NOT NULL
)
GO

----- PetDetail
CREATE TABLE PetDetail(
    PetDetailID INT IDENTITY(1,1) PRIMARY KEY, 
    DetailID INT FOREIGN KEY REFERENCES Detail(DetailID) NOT NULL,
    PetID INT FOREIGN KEY REFERENCES Pet(PetID) NOT NULL,
    PetDetailDate DATE NOT NULL
)
GO

-----insert PetGender
Insert into PetGender(PetGenderName)
values('Male'),('Female')

-----insert State
INSERT into State (StateAbbr,StateName)
values
('AK', 'Alaska'),
('AL', 'Alabama'),
('AZ', 'Arizona'),
('AR', 'Arkansas'),
('CA', 'California'),
('CO', 'Colorado'),
('CT', 'Connecticut'),
('DE', 'Delaware'),
('DC', 'District of Columbia'),
('FL', 'Florida'),
('GA', 'Georgia'),
('HI', 'Hawaii'),
('ID', 'Idaho'),
('IL', 'Illinois'),
('IN', 'Indiana'),
('IA', 'Iowa'),
('KS', 'Kansas'),
('KY', 'Kentucky'),
('LA', 'Louisiana'),
('ME', 'Maine'),
('MD', 'Maryland'),
('MA', 'Massachusetts'),
('MI', 'Michigan'),
('MN', 'Minnesota'),
('MS', 'Mississippi'),
('MO', 'Missouri'),
('MT', 'Montana'),
('NE', 'Nebraska'),
('NV', 'Nevada'),
('NH', 'New Hampshire'),
('NJ', 'New Jersey'),
('NM', 'New Mexico'),
('NY', 'New York'),
('NC', 'North Carolina'),
('ND', 'North Dakota'),
('OH', 'Ohio'),
('OK', 'Oklahoma'),
('OR', 'Oregon'),
('PA', 'Pennsylvania'),
('PR', 'Puerto Rico'),
('RI', 'Rhode Island'),
('SC', 'South Carolina'),
('SD', 'South Dakota'),
('TN', 'Tennessee'),
('TX', 'Texas'),
('UT', 'Utah'),
('VT', 'Vermont'),
('VA', 'Virginia'),
('WA', 'Washington'),
('WV', 'West Virginia'),
('WI', 'Wisconsin'),
('WY', 'Wyoming')

-----insert PetType
INSERT into PetType (PetType)
values ('Cat'),('Dog'), ('Unknown')
select * from DetailType
-----insert DetailType
INSERT into DetailType (DetailTypeName,DetailTypeDesc)
values ('Vaccination','We require all pets to be current on certain vaccines, such as  DAPP (a.k.a. DHPP) Vaccine for dogs or FVRCP (Feline Viral Rhinotracheitis, Calicivirus & Panleukopenia) for cats'),
       ('Medication','Medication, vitamins or supplements your pet needs to take during their stay. '),
       ('Care','Details your pet’s history, health and behaviors (favorite toys/treats) so we can customize our care and attention during their stay. ')



--Create all nested GetID stored procedures
----------------------------------InsertPetBreed---------------------------------
INSERT into PetBreed (PetTypeID, PetBreedName,PetBreedDesc)
values
-----cat breeds
(1,'Abyssinian', 'Abyssinians are highly intelligent and intensely inquisitive. They love to investigate and will leave no nook or cranny unexplored. They’re sometimes referred to as “Aby-grabbys” because they tend to take things that grab their interest. The playful Aby loves to jump and climb. Keep a variety of toys on hand to keep her occupied, including puzzle toys that challenge her intelligence.'),
(1,'American Bobtail', 'The American Bobtail is an athletic breed that looks like a bobtailed wildcat and has many dog-like tendencies.'),
(1,'American Curl Cat', 'With unique ears that curl back, and an inquisitive expression reminiscent of happy surprise, the American Curl brings a smile to everyone who meets her.'),
(1,'American Shorthair', 'Formerly used to keep rodents and vermin away from food stores, the American Shorthair still enjoys exercising her hunting skills on unsuspecting insects. As a smart, moderately active feline, she enjoys learning tricks and challenging her intelligence with puzzles and interactive toys.'),
(1,'American Wirehair', 'Intelligent and highly adaptable, the American Wirehair is an American original, with a completely unique wired coat.'),
(1,'Balinese-Javanese', 'The Balinese, also known as Javanese depending on coat color and pattern, is regal and aristocratic in appearance, but a curious kitten at heart.'),
(1,'Bengal', 'Bengal Cats are curious and confident with the tameness of a domestic tabby and the beauty of an Asian Leopard Cat. Learn more about Bengals and their playful personality, plus information on their health and how to feed them.'),
(1,'Birman', 'The Birman is a cat of distinction as well as legend. With their exotic ancestry, luxurious pointed coats, “white gloved” paws and mesmerizing blue eyes, this is a breed with undeniable charisma.'),
(1,'Bombay', 'The Bombay is an easy-going, yet energetic cat. She does well in quiet apartments where she’s the center of attention as well as in lively homes with children and other pets. She’ll talk to you in a distinct voice, and you’re likely to find her in the warmest spot in your home, whether that’s in the sunlight from a window or curled up under the covers in bed with you.'),
(1,'British Shorthair', 'The British Shorthair is an easygoing feline. She enjoys affection but isn’t needy and dislikes being carried. She’ll follow you from room to room, though, out of curiosity. British Shorthairs aren’t lap cats, but they do enjoy snuggling next to their people on the couch.'),
(1,'Burmese', 'The Burmese thrives on companionship with her humans and other cats. Like her Siamese ancestors, she enjoys conversation, but has a much softer, sweeter voice.'),
(1,'Chartreux', 'Often called the smiling cat of France, the Chartreux has a sweet, smiling expression. This sturdy, powerful cat has a distinctive blue coat with a resilient wooly undercoat. Historically known as fine mousers with strong hunting instincts, the Chartreux enjoys toys that move. This is a slow-maturing breed that reaches adulthood in three to five years. A loving, gentle companion, the Chartreux forms a close bond with her family.'),
-----dog breeds
(2,'Affenpinscher', 'This ancient toy breed is fun-loving, loyal and fearless. He’s considered a hypoallergenic breed, so he could be a perfect companion for both people with and without allergies.'),
(2,'Afghan Hound', 'Dignified and aloof, the Afghan Hound has a happy temperament and makes an excellent family companion.'),
(2,'Airedale Terrier', 'The Airedale Terrier originated in the Valley of Aire in England, where factory workers bred them to be good hunters, as well as strong, intelligent guard dogs and companions.'),
(2,'Akita', 'Developed in the mountains of Japan, the courageous Akita is fiercely loyal and protective of his family.'),
(2,'Alaskan Malamute', 'One of the oldest Arctic sled dogs, the Alaskan Malamute was first bred in Alaska to carry large loads over long distances. A majestic, dignified breed, the Malamute is highly intelligent and learns quickly, but he also can be strong-willed. Loyal, devoted and highly athletic, he is an affectionate family companion that enjoys outdoor activities. The Malamute needs daily exercise, and his thick, coarse coat requires daily brushing and occasional baths.'),
(2,'American English Coonhound', 'A descendant of the English Foxhound, the American English Coonhound is known for his speed and endurance. This athletic hound, which is capable of hunting raccoon and fox all night long, needs regular exercise to stay in condition. The American English Coonhound is sociable with humans and other dogs. The breed’s hard, protective coat needs little grooming.'),
(2,'American Eskimo Dog', 'The American Eskimo Dog, which descended from European spitz-type dogs, was brought to the U.S. by German immigrants. The breed comes in three size varieties: Standard, Miniature and Toy. Nicknamed the “Eskie,” this breed has a heavy white coat that requires weekly brushing. Although intelligent, affectionate and playful, the American Eskimo Dog can be skeptical of strangers.'),
(2,'American Foxhound', 'A rare breed, the American Foxhound was developed by George Washington in the 1700s. Bred to run fast, the American Foxhound is ideal for pet owners in rural areas but also is adaptable to smaller homes if provided adequate exercise. A mild-tempered and easygoing breed, the American Foxhound gets along well with children and most pets. Stubborn and independent at times, he benefits from early training.'),
(2,'American Staffordshire Terrier', 'Stocky and muscular with a strong, powerful head, the American Staffordshire Terrier is a cross between the courageous Bulldog and the spirited, agile terrier breeds. '),
(2,'American Water Spaniel', 'Intelligent, energetic and eager to please, the American Water Spaniel is a versatile hunting dog and devoted family companion. One of the few breeds developed in the U.S., this rare breed only has about 3,000 registered dogs. The American Water Spaniel is an active dog that needs regular exercise. His naturally curly coat requires regular grooming and twice weekly brushing.'),
(2,'Anatolian Shepherd Dog', 'The Anatolian Shepherd Dog originated in rural Turkey about 6,000 years ago to guard livestock and serve as a companion to shepherds. Large, powerful and possessive, this breed adores his family but can be suspicious of strangers. The Anatolian Shepherd Dog has two coat varieties, Short and Rough, both which require little grooming. The breed does best with moderate exercise.'),
(2,'Australian Cattle Dog', 'Agile, strong and courageous, the Australian Cattle Dog was developed in the 1800s in Australia. An intelligent and determined high-energy working dog, the Australian Cattle Dog is happiest in large, open spaces with an engaging job to do. This loyal and protective breed bonds closely with his family, but his owners must establish themselves as the pack leaders. The breed’s smooth, short coat requires occasional bathing and brushing.')
GO
------------------------------Table PetBreed END------------------------------

------------------------------Table PetOwner Start------------------------------
----------------------------------InsertPetOwner---------------------------------
ALTER TABLE PetOwner ALTER column PetOwnerPhone varchar(15) not null

with tmp as (
    select *,
    cast(floor(rand(convert(varbinary, newid())) * 1000) as varchar) as areaCode, 
    cast(floor(rand(convert(varbinary, newid())) * 10000) as varchar) as mid4, 
    cast(floor(rand(convert(varbinary, newid())) * 10000) as varchar) as last4
    from UNIVERSITY.dbo.tblSTUDENT
    where StudentPermCity in (select CityName from City)
)
Insert into PetOwner(PetOwnerFname,PetOwnerLname,PetOwnerAddress,PetOwnerDOB,ZIP,CityID,PetOwnerPhone)
select StudentFname,
       StudentLname,
       StudentPermAddress, 
       StudentBirth,
       StudentPermZip,
       (select CityID from City where CityName =(select substring(StudentPermCity,1,1)+substring(lower(StudentPermCity),2,len(StudentPermCity)))) as CityId,
       ('(' + REPLICATE('0',3-LEN(tmp.areaCode)) + tmp.areaCode + ')-' 
       + REPLICATE('0',4-LEN(tmp.mid4)) + tmp.mid4 
       + '-' + REPLICATE('0',4-LEN(tmp.last4)) + tmp.last4) as phone_num 
        from tmp
------------------------------Table PetOwner END ------------------------------
----populate some rows for Pet Table
insert into Pet (PetName, PetOwnerID,PetGenderID, PetBreedID, PetDateOfBirth)
VALUES
('Bella',1,2,2,'2020-04-22'), 
('Luna',2,2,3,'2017-02-12'), 
('Lucy',3,2,4,'2014-05-24'), 
('Daizy',4,2,5,'2008-01-29'), 
('Zoe', 5,2,44,'2005-06-23'), 
('Lily',6,2,33,'2009-08-05'), 
('Lola', 7,2,26,'2012-12-02'), 
('Bailey', 8,2,23,'2015-12-12'), 
('Stella',9,2,4,'2016-11-05'), 
('Molly',10,2,22,'2020-07-07'), 
('Max',11,1,1,'2019-09-16'), 
('Charlie',12,1,3,'2021-07-22'), 
('Milo',13,1,5,'2022-03-26'), 
('Buddy',14,1,45,'2022-04-21'), 
('Rocky',15,1,34,'2021-05-16'), 
('Bear', 1,1,32,'2005-01-07'), 
('Leo', 3,1,2,'2009-06-09'), 
('Duke',2,1,23,'2013-08-17'), 
('Teddy',5,1,14,'2010-10-28'), 
('Tucker',3,1,35,'2015-10-26') 
------------------------------Table Detail START------------------------------
-----------------------------GetDetailTypeID----------------------------------
GO
CREATE PROCEDURE ruihabGetDetailTypeID
@detail_type varchar(50),
@detail_type_ID INT OUTPUT
AS

SET @detail_type_ID = (SELECT DetailTypeID FROM DetailType WHERE DetailTypeName = @detail_type)
GO

--DBCC CHECKIDENT('PETType', RESEED, 2)
----------------------------------InsertDetail---------------------------------
CREATE PROCEDURE ruihabINSERT_Detail
@detail_name varchar(50),
@detail_desc varchar(255),
@dt_name varchar(50)

AS 
DECLARE @dt_id int

EXEC ruihabGetDetailTypeID
@detail_type = @dt_name,
@detail_type_ID = @dt_id OUTPUT

-- error-handling here
IF @dt_id IS NULL
BEGIN
PRINT '@dt_id is empty...check spelling';
THROW 56554, '@dt_id cannot be NULL; process terminating',1;
END

INSERT INTO Detail (DetailTypeID, DetailName, DetailDesc)
VALUES (@dt_id, @detail_name, @detail_desc)
GO
------------------------------Table Detail END ------------------------------
--DBCC CHECKIDENT('DetailType', RESEED, 3)
------------------------------Insert Table Detail------------------------------

EXEC ruihabINSERT_Detail
@detail_name = "FVRCP",
@detail_desc = "1 or 3-yr. vaccine required",
@dt_name = "Vaccination"

EXEC ruihabINSERT_Detail
@detail_name = "Rabies",
@detail_desc = "1 or 3-yr. vaccine required",
@dt_name = "Vaccination"

EXEC ruihabINSERT_Detail
@detail_name = "Simparica Trio",
@detail_desc = "Simparica Trio is a once-a-month chewable that protects your dog with three proven ingredients designed for defense. ",
@dt_name = "Medication"

EXEC ruihabINSERT_Detail
@detail_name = "eats from a raised feeder, must use a harness",
@detail_desc = "Specific behaviors or requirements we need to be aware of",
@dt_name = "Care"
GO

------------------------------Table PetDetail Start------------------------------
----------------------------------InsertPetDetail--------------------------------
Alter Table Detail ALTER column DetailDesc varchar(255) null
GO

CREATE PROCEDURE ruihabGetDetailID
@dt_name varchar(50),
@dt_id INT OUTPUT
AS
SET @dt_id = (SELECT DetailID FROM Detail WHERE DetailName = @dt_name)
GO

CREATE PROCEDURE ruihabGetPetID
@pet_name varchar(50),
@petowner_fn varchar(50),
@petowner_ln varchar(50),
@petowner_phone varchar(15),
@pt_ID INT OUTPUT
AS
SET @pt_ID = (SELECT PetID FROM Pet p
             JOIN PetOwner po on po.PetOwnerID = p.PetOwnerID
             WHERE po.PetOwnerFname = @petowner_fn and po.PetOwnerLname = @petowner_ln and 
             po.PetOwnerPhone = @petowner_phone and PetName = @pet_name
             )
GO

Alter Table DetailType ALTER column DetailTypeDesc varchar(255) null
GO

--drop procedure ruihab_INSERT_PetDetail
CREATE PROCEDURE ruihab_INSERT_PetDetail
@pt_name varchar(50),
@detail_n varchar(50),
@po_fn varchar(50),
@po_ln varchar(50),
@po_phone varchar(15),
@detail_descr varchar(255) null,
@detailtype_descr varchar(255) null,
@detail_typename varchar(50),
@detail_date Date
AS
DECLARE @dt_ID INT, @pet_id INT

EXEC ruihabGetDetailID
 @dt_name = @detail_n,
 @dt_id  = @dt_ID OUTPUT

IF @dt_ID IS NULL
    EXEC ruihabINSERT_Detail
    @detail_name = @detail_n,
    @detail_desc = @detail_descr,
    @dt_name = @detail_typename

    EXEC ruihabGetDetailID
    @dt_name = @detail_n,
    @dt_id  = @dt_ID OUTPUT

EXEC ruihabGetPetID
@pet_name = @pt_name,
@petowner_fn = @po_fn,
@petowner_ln = @po_ln,
@petowner_phone = @po_phone,
@pt_ID  = @pet_id  OUTPUT
IF @pet_id IS NULL
BEGIN
PRINT 'So...I sense something wrong...this is failing...ask for help';
THROW 54665, '@pet_id is NULL and process is terminating', 1;
END
BEGIN TRANSACTION T1

INSERT INTO PetDetail (DetailID, PetID, PetDetailDate)
VALUES (@dt_ID, @pet_id, @detail_date)
IF @@ERROR <> 0
BEGIN
PRINT '@@ERROR is showing an error somewhere...terminating process'
ROLLBACK TRANSACTION T1
END
ELSE
COMMIT TRANSACTION T1
GO

EXEC ruihab_INSERT_PetDetail
@pt_name = 'Bella',
@detail_n = 'FVRCP',
@po_fn= 'Pam',
@po_ln = 'Cluster',
@po_phone= '(339)-2665-3482',
@detail_descr= '1 or 3-yr. vaccine required',
@detailtype_descr = NULL,
@detail_typename= 'Vaccination',
@detail_date= '2022-05-17'

EXEC ruihab_INSERT_PetDetail
@pt_name = 'Bear',
@detail_n = 'Rabies',
@po_fn= 'Pam',
@po_ln = 'Cluster',
@po_phone= '(339)-2665-3482',
@detail_descr= '1 or 3-yr. vaccine required',
@detailtype_descr = NULL,
@detail_typename= 'Vaccination',
@detail_date= '2022-05-17'

EXEC ruihab_INSERT_PetDetail
@pt_name = 'Lily',
@detail_n = 'eats from a raised feeder, must use a harness',
@po_fn= 'Daine',
@po_ln = 'Lubrano',
@po_phone= '(936)-4677-5450',
@detail_descr= "Specific behaviors or requirements we need to be aware of",
@detailtype_descr = NULL,
@detail_typename= 'Care',
@detail_date= '2022-05-18'

EXEC ruihab_INSERT_PetDetail
@pt_name = 'Leo',
@detail_n = 'has not teeth, need to feed him wet food',
@po_fn= 'Gracie',
@po_ln = 'Dedman',
@po_phone= '(495)-3601-0502',
@detail_descr= 'Specific behaviors or requirements we need to be aware of',
@detailtype_descr = NULL,
@detail_typename= 'Care',
@detail_date= '2022-05-19'


------------------------------Table Pet Start------------------------------
Alter Table PetBreed ALTER column PetBreedDesc varchar(500) null
select * from PetType
GO

CREATE PROCEDURE ruihabGetPetOwnerID
@ptOwner_fn varchar(50),
@ptOwner_ln varchar(50),
@ptOwner_phone varchar(15),
@ptOwnerID INT OUTPUT
AS
SET @ptOwnerID = (SELECT PetOwnerID FROM PetOwner WHERE PetOwnerFname = @ptOwner_fn and PetOwnerLname = @ptOwner_ln and PetOwnerPhone = @ptOwner_phone )
GO

CREATE PROCEDURE ruihabGetPetGenderID
@ptGender varchar(50),
@ptGenderID INT OUTPUT
AS
SET @ptGenderID = (SELECT PetGenderID FROM PetGender WHERE PetGenderName = @ptGender)
GO

CREATE PROCEDURE ruihabGetPetBreedID
@ptBreedName varchar(50),
@ptTypeName varchar(50),
@ptBreedID INT OUTPUT
AS
SET @ptBreedID = (SELECT PetBreedID FROM PetBreed pb
                   JOIN PetType pt on pt.PetTypeID = pb.PetBreedID
            WHERE PetBreedName  = @ptBreedName and PetType = @ptTypeName)
GO

----------------------------------InsertPetOwner--------------------------
--drop PROCEDURE ruihabGetCityID
CREATE PROCEDURE ruihabGetCityID
@CT_name varchar(50),
@CityID INT OUTPUT
AS
SET @CityID = (SELECT CityID FROM City WHERE CityName = @CT_name)
GO

CREATE PROCEDURE ruihab_INSERT_PetOwner
@pofn varchar(50),
@poln varchar(50),
@pophone varchar(15),
@po_address varchar(50),
@po_dob date,
@zip varchar(5),
@city_name varchar(50)
AS
DECLARE @city_id INT

EXEC ruihabGetCityID
@CT_name = @city_name,
@CityID = @city_id OUTPUT

IF @city_id IS NULL
BEGIN
    PRINT 'So...I sense something wrong...this is failing...ask for help';
    THROW 54665, '@city_id is NULL and process is terminating', 1;
END

BEGIN TRANSACTION T1

INSERT INTO PetOwner (PetOwnerFName,PetOwnerLName, PetOwnerPhone, PetOwnerAddress,PetOwnerDOB,ZIP,CityID)
VALUES (@pofn,@poln, @pophone, @po_address,@po_dob,@zip,@city_id)
IF @@ERROR <> 0
BEGIN
PRINT '@@ERROR is showing an error somewhere...terminating process'
ROLLBACK TRANSACTION T1
END
ELSE
COMMIT TRANSACTION T1
GO

--example:
ruihab_INSERT_PetOwner
@pofn = 'Bonnie',
@poln = 'Bao',
@pophone = '(858)247-8926',
@po_address= '902 NE 43rd ST ',
@po_dob= '1997-02-03',
@zip= '98105',
@city_name = 'Seattle'

----------------------------------InsertPetBreed-------------------
----------------------------------InsertPet--------------------------------
--drop PROCEDURE ruihabGetCityID
GO
CREATE PROCEDURE ruihabGetPetTypeID
@pet_type varchar(50),
@pet_type_id INT OUTPUT
AS
SET @pet_type_id = (SELECT PetTypeID FROM PetType WHERE PetType = @pet_type)
GO


--drop procedure ruihab_INSERT_Pet
GO
CREATE PROCEDURE ruihab_INSERT_Pet
@pet_nm varchar(50),
@petOwner_FName varchar(50),
@petOwner_LName varchar(50),
@petOwner_Phone varchar(15),
@petGD varchar(50),
@petBdName varchar(50),
@petTpName varchar(50),
@pet_DOB Date,
@peBdDescr varchar(500) null
AS
DECLARE @PETOWNERID INT, @PETGENDERID INT,@PETBREEDID INT,@PETTYPEID INT

EXEC ruihabGetPetOwnerID
@ptOwner_fn = @petOwner_FName,
@ptOwner_ln = @petOwner_LName,
@ptOwner_phone = @petOwner_Phone,
@ptOwnerID = @PETOWNERID OUTPUT

IF @PETOWNERID IS NULL
BEGIN
    PRINT 'PetOwnerId is empty...check spelling or fill pet owner information first';
    THROW 54665, '@PETOWNERID is NULL and process is terminating', 1;
END

EXEC ruihabGetPetGenderID
@ptGender = @petGD,
@ptGenderID =@PETGENDERID OUTPUT
IF @PETGENDERID IS NULL
BEGIN
PRINT 'So...I sense something wrong...this is failing...ask for help';
THROW 54665, '@PETGENDERID is NULL and process is terminating', 1;
END

EXEC ruihabGetPetBreedID
@ptBreedName = @petBdName,
@ptTypeName = @petTpName,
@ptBreedID = @PETBREEDID OUTPUT
IF @PETBREEDID IS NULL
BEGIN
    INSERT into PetBreed (PetTypeID, PetBreedName,PetBreedDesc)
    Values((Select PetTypeID from PetType where PetType = @petTpName),@petBdName,@peBdDescr)
END

SET @PETBREEDID = (Select MAX(PetBreedId) from PetBreed)

BEGIN TRANSACTION T1

INSERT INTO Pet (PetName,PetOwnerID, PetGenderID, PetBreedID,PetDateOfBirth)
VALUES (@pet_nm,@PETOWNERID, @PETGENDERID, @PETBREEDID,@pet_DOB)
IF @@ERROR <> 0
BEGIN
PRINT '@@ERROR is showing an error somewhere...terminating process'
ROLLBACK TRANSACTION T1
END
ELSE
COMMIT TRANSACTION T1
GO

--example
EXEC ruihab_INSERT_Pet
@pet_nm = 'Nimbus',
@petOwner_FName = 'Bonnie',
@petOwner_LName = 'Bao',
@petOwner_Phone = '(858)247-8926',
@petGD = 'Male',
@petBdName = 'Unknown',
@petTpName = 'Cat',
@pet_DOB = '2019-11-20',
@peBdDescr = NULL

delete from PETOwner
where PETOwnerID = 1270
select * from PetBreed
select * from petOwner
--DBCC CHECKIDENT('PetBreed', RESEED, 48)
------------------------------Table Pet END ------------------------------

BACKUP DATABASE IMT_563_Proj_03 TO DISK = 'C:\SQL\IMT_563_Proj_03.BAK' WITH DIFFERENTIAL

USE IMT_563_Proj_03
select * from City