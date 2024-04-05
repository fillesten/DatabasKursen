/*
C:\0 UNI SKOLAN\2Year_Courses\Databaser\Labs\lab2\Clinic\Allakommands.sql

mysql -u root 
use clinic 
eller use personal för nayebs genomgånggrejs

 select Lname, Fname from person,employee where (employee.personID='1');
 
 SHOW WARNINGS\G; efter något som lämnar en warning!!!


DESCRIBE TABLES: 

DESCRIBE person;
DESCRIBE employee;
DESCRIBE customer;
DESCRIBE animaltype;
DESCRIBE breed;
DESCRIBE pet;
DESCRIBE treatment;
DESCRIBE medication;
DESCRIBE appointment;
DESCRIBE aptformed;
DESCRIBE aptfortreat;

1. Varje vanlig entitetstyp blir en tabell. 
	Vanliga attribut blir kolumner i tabellen.

2. Varje 1:N- relationer blir en foreign 
	key i N-sidans entitetstypens tabell.

3. Varje 1:1- relationer blir en foreign 
	key i den ena entitetstypens tabell. 

4. Varje N:M relation blir en egen tabell.

5. Varje flervägsrelationer blir 
	en egen tabell.

6. Attribut på relationer blir kolumner. 
	För 1:1 och 1:N relationer i samma
	tabell som den med foreign key, 
	och för N:M relationer i den 
	särskilda relationstabellen.

7. Varje svag entitetstyp blir en tabell. 
	Primärnyckeln består av den svaga 
	entitetstypens partiella nyckel, 
	kombinerad med den identifierande 
	entitetens primärnyckel.

8. Sammansatta attribut behandlas som 
	om de bara bestod av delarna.

9. Varje flervärt attribut blir en egen 
	tabell. Primärnyckeln består av 
	entitetstypens primärnyckel, 
	kombinerad med det flervärda attributet.

10. Härledda attribut tas inte med 
	i databasen.

 
 
source C:\0 UNI SKOLAN\2Year_Courses\Databaser\Labs\lab2\Clinic
 
 
*/


--Basrelationer
/* 
från ER gör basrelationer INNAN sql-kod

BASRELATIONER!!!

person (PK = PersonID)

employee (PK = EmployeeID, FK = PersonID)

customer (PK = CustomerID, FK = PersonID)

animaltype (PK = Animalname)

breed (PK = Breedname, PK & FK = Animalname)

pet (PK = PetID, PK & FK = CustomerID, FK = Breedname, FK = Animalname)

treatment (PK = TreatmentID)

medication (PK = MedicationID )

appointment(PK = AppointmentID, FK = EmployeeID, FK = PetID, FK = CustomerID)

aptformed(PK & FK = AppointmentID, PK & FK = MedicationID)

aptfortreat(PK & FK = AppointmentID, PK & FK = TreatmentID)
*/


USE clinic;


DROP TABLE aptfortreat;
DROP TABLE aptformed;
DROP TABLE appointment;
DROP TABLE medication;
DROP TABLE treatment;
DROP TABLE pet;
DROP TABLE breed;
DROP TABLE animaltype;
DROP TABLE customer;
DROP TABLE employee;
DROP TABLE person;




CREATE TABLE person ( 
	PersonID int PRIMARY KEY NOT NULL,
	Lname VARCHAR (30), 
	Fname VARCHAR (30), 
	City VARCHAR (30),
	States VARCHAR (30),
	zip int
	);

CREATE TABLE employee (
	EmployeeID int PRIMARY KEY NOT NULL,
	Education VARCHAR (4), 
	Hiredate DATE,
	Address VARCHAR (30),
	Homephone VARCHAR (30),
	PersonID int NOT NULL,
	FOREIGN KEY (PersonID) REFERENCES person (PersonID)
	);

CREATE TABLE customer (
	CustomerID VARCHAR (10)	PRIMARY KEY NOT NULL, 
	Ctype int,
	Street VARCHAR (30), 
	PhoneNr VARCHAR(30),
	Faxnumber VARCHAR(30),
	PersonID int NOT NULL,
	FOREIGN KEY (PersonID) REFERENCES person (PersonID)
	);

CREATE TABLE animaltype (
	Animalname VARCHAR (30) PRIMARY KEY NOT NULL
	);
	
CREATE TABLE breed ( 
	Breedname VARCHAR (30)NOT NULL, 
	Animalname VARCHAR (30)NOT NULL,
	PRIMARY KEY (Breedname, Animalname),
	FOREIGN KEY (Animalname) REFERENCES animaltype (Animalname)	
	);
	
CREATE TABLE pet ( 
	PetID VARCHAR (3) NOT NULL, 
	DOB DATE, 
	Petname VARCHAR(30) , 
	Gender char (1),
	CustomerID VARCHAR (10) NOT NULL,
	Breedname VARCHAR (30) NOT NULL,
	Animalname VARCHAR (30) NOT NULL,
	PRIMARY KEY (PetID, CustomerID),
	FOREIGN KEY (CustomerID) REFERENCES customer (CustomerID),
	FOREIGN KEY (Breedname) REFERENCES breed (Breedname),
	FOREIGN KEY (Animalname) REFERENCES animaltype (Animalname)
	);

	
CREATE TABLE treatment (
	TreatmentID VARCHAR(10) PRIMARY KEY NOT NULL,
	Price DECIMAL (5,2), 
	Tname VARCHAR (30)
	);

CREATE TABLE medication ( 
	MedicationID VARCHAR(10) PRIMARY KEY NOT NULL, 
	Price DECIMAL (5,2), 
	Mname VARCHAR (30)
	);

CREATE TABLE appointment ( 
	AppointmentID int PRIMARY KEY NOT NULL,
	Aptdate DATE,
	EmployeeID int NOT NULL,
	PetID VARCHAR (3) NOT NULL,
	CustomerID VARCHAR (10),
	FOREIGN KEY (EmployeeID) REFERENCES employee (EmployeeID),
	FOREIGN KEY (PetID) REFERENCES pet (PetID),
	FOREIGN KEY (CustomerID) REFERENCES customer (CustomerID)
	);
	
CREATE TABLE aptformed(
	AppointmentID int NOT NULL,
	MedicationID VARCHAR (30) NOT NULL,
	AmountOz int,
	PRIMARY KEY (AppointmentID, MedicationID),
	FOREIGN KEY (AppointmentID) REFERENCES appointment (AppointmentID),
	FOREIGN KEY (MedicationID) REFERENCES medication (MedicationID)
	);

CREATE TABLE aptfortreat(
	AppointmentID int NOT NULL,
	TreatmentID VARCHAR (30) NOT NULL,
	PRIMARY KEY (AppointmentID, TreatmentID),
	FOREIGN KEY (AppointmentID) REFERENCES appointment (AppointmentID),
	FOREIGN KEY (TreatmentID) REFERENCES treatment (TreatmentID)
	);


/* 	employee (1-9),	customer (10-...)  */
INSERT INTO person (PersonID, Lname, Fname, City, States, zip)
VALUES	(1, 'Becker', 'Todd', 'Tacoma', 'WA', 98401), 
		(2, 'Bowie', 'Rosie', 'Seattle', 'WA', 98105), 
		(3, 'Carrington', 'Maram', 'Kirkland', 'WA', 98033), 
		(4, 'Chiu', 'Lin', 'Tacoma', 'WA', 98402), 
		(5, 'Dennis', 'Anne', 'Bellingham', 'WA', 98047), 
		(6, 'Peters', 'Peter', 'Bellingham', 'WA', 98047),  
		(7, 'Plotter', 'Mary', 'Seattle', 'WA', 98122),  
		(8, 'Wally', 'Robert', 'Seattle', 'WA', 98125),  
		(9, 'Walters', 'Margaret', 'Redmond', 'WA', 98052), 
		(10, 'All', 'Creatures', 'Tall Pines', 'WA', 98746 ), 
		(11, 'Adams', 'Jonathan', 'Mountain View', 'WA', 984101012 ), 
		(12, 'Adams', 'William', 'LAkeville', 'OR', 974011011 ),
		(13, 'Animal', 'Kingdom', 'Borderville', 'ID', 834835646 ),
		(14, 'Johnson', 'Adam', 'New York', 'NY', 84657),
		(15, 'Backan', 'Karl', 'Sundsvall', 'VN', 85233),
		(16, 'Petterson', 'Karl', 'Sundsvall', 'VN', 85233); 
			

INSERT INTO employee (EmployeeID, Education, Hiredate, Address, Homephone, PersonID)
VALUES 	(2, 'MS.', '1992-08-04', '908 W.Capital Way', '(206) 555-9482', 1 ),
		(8, 'BS.', '1994-03-15', '4726-11th Ave. N.E.', '(206) 555-1189', 2),
		(3, 'MS.', '1992-04-01', '722 Moss Bay Blvd.', '(206) 555-3412', 3),
		(6, 'MS.', '1993-10-17', 'Coventy House Miner Rd.', '(71) 555-7773', 4),
		(9, 'MS.', '1994-11-05', '7 Hounds tooth Rd.', '(71) 555-4444', 5),
		(5, 'BS.', '1993-10-17', '14 Garret Hill', '(71) 555-4848', 6),
		(1, 'PhD.', '1992-05-01', '507-20th Ave. E. Apt. 2A', '(206) 555-9857', 7),
		(7, 'AA.', '1994-01-02', 'Edgeham Hollow Wincester Way', '(71) 555-5598', 8),
		(4, 'MS.', '1993-05-03', '4110 Old Redmond Rd.', '(206) 555-8122', 9);
		
		
INSERT INTO customer (CustomerID, Ctype, Street, PhoneNr, Faxnumber, PersonID)
VALUES 	('AC001', 2, '21 Grace St.', '(206) 555-6622', '(206) 555-7854', 10),
		('AD001', 1, '66 10th St.', '(206) 555-7623', '(206) 555-8855', 11),
		('AD002', 1, '1122 10th St.', '(503) 555-6187', '(503) 555-7319', 12),
		('AK001', 2, '15 MArlin Lane', '(208) 555-7108', NULL, 13),
		('AD003', 1, '21 Groundlake St.', '(203) 555-3621', '(203) 555-7532', 14),
		('AD004', 1, '19 Svall St.', '+46 10-123 45 67', '+46 10-142 80 00', 15),
		('AD005', 1, '32 Svall ST', '+46 76-123 76 23', '+46 76-123 76 23', 16);
		

INSERT INTO animaltype (Animalname)
VALUES 	('RABBIT'),
		('DOG'),
		('LIZARD'),
		('SKUNK'),
		('PIG'),
		('HORSE'),
		('RAT'),
		('DUCK'),
		('WOLF'),
		('EAGLE'),
		('FROG');
		

INSERT INTO breed (Breedname, Animalname)
VALUES 	('Long Ear', 'RABBIT'),
		('German Shepherd', 'DOG'),
		('Chameleon', 'LIZARD'),
		('Flying', 'SKUNK'),
		('Potbelly', 'PIG'),
		('Palomino', 'HORSE'),
		('Manx', 'RAT'),
		('Mixed', 'DOG'),
		('Beagle', 'DOG'),
		('Big Wing', 'EAGLE'),
		('Long Jumper', 'FROG'),
		('Wild', 'WOLF');
		

INSERT INTO pet (PetID, DOB, Petname, Gender, CustomerID, Breedname, Animalname)
VALUES 	('-01', '1992-04-08', 'Bobo', 'M', 'AC001', 'Long Ear', 'RABBIT'),
		('-04', '1990-06-01', 'Fido', 'M', 'AC001', 'German Shepherd', 'DOG'),
		('-02', '1992-05-01', 'Presto Chango', 'F', 'AC001', 'Chameleon', 'LIZARD'),
		('-03', '1991-08-01', 'Stinky', 'M', 'AC001', 'Flying', 'SKUNK'),
		('-01', '1991-02-15', 'Patty', 'F', 'AD001', 'Potbelly', 'PIG'),
		('-02', '1990-04-10', 'Rising Sun', 'M', 'AD001', 'Palomino', 'HORSE'),
		('-01', '1991-02-15', 'Dee Dee', 'F', 'AD002', 'Mixed', 'DOG'),
		('-03', '1988-02-01', 'Jerry', 'M', 'AK001', 'Manx', 'RAT'),
		('-07', '1992-02-01', 'Luigi', 'M', 'AK001', 'Beagle', 'DOG'),
		('-01', NULL, 'Fi Fi', 'F', 'AD003', 'Long Jumper', 'FROG'),
		('-01', '1993-03-05', 'Flaxe', 'M', 'AD004', 'Big Wing', 'EAGLE'),
		('-01', '2012-03-07', 'Varge', 'F', 'AD005', 'Wild', 'WOLF');


INSERT INTO treatment (TreatmentID, Price, Tname)
VALUES 	('T1003', 35.00, 'Lab Work - Misc'),
		('T1001', 75.00, 'Lab Work - Cerology'),
		('T0300', 50.00, 'General Exam'),
		('T2003', 25.00, 'Flea Spray'),
		('T0404', 230.00, 'Repair Complex Fracture'),
		('T0408', 120.00, 'Cast Affected Area');

INSERT INTO medication (MedicationID, Price, Mname)
VALUES 	('M0202', 7.80, 'Zinc Oxide'),
		('M0500', 11.50, 'Nyostatine'),
		('M0702', 34.50, 'Xaritain Clyconol');


INSERT INTO appointment (AppointmentID, Aptdate, EmployeeID, PetID, CustomerID)
VALUES 	( 01, '1998-11-04', 3, '-04', 'AC001'),
		( 02, '1999-05-09', 4, '-01', 'AD003'),
		( 03, '2021-10-21', 1, '-01', 'AD004');
		
		
/* N:M relationship  from appointment to medication*/
INSERT INTO aptformed (AppointmentID, MedicationID, AmountOz)
VALUES 	(01, 'M0500', 4),
		(01, 'M0702', 1),
		(02, 'M0202', 2);
		

/* N:M relationship from appointment to treatment*/
INSERT INTO aptfortreat (AppointmentID, TreatmentID)
VALUES 	(01, 'T2003'),
		(01, 'T0404'),
		(01, 'T0408'),
		(02, 'T1003'),
		(02, 'T1001'),
		(02, 'T0300');

/*
vad som ska lämnas in:

1 ER-diagrammet
2 kod och resultat av koden
3 återskapa en bild från instruktionerna som 
tex alla hospital employees /daily visits report 
/customers and pets

*/


