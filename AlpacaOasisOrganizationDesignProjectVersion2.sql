--- This is all the sql to create the Alpaca Oasis Organization Database ---

-- This is the SQL to create the tables and views for the Alpaca Oasis Organization Database --

--drop statements--
DROP VIEW StaffInformation;
DROP VIEW AlpacaInformation;
DROP TABLE IF EXISTS Addresses;
DROP TABLE IF EXISTS ProgressReports;
DROP TABLE IF EXISTS Alpacas;
DROP TABLE IF EXISTS AlpacaStatus;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Guests;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Sanctuaries;
DROP TABLE IF EXISTS Countries;
DROP TABLE IF EXISTS StaffStatus;


-- Lists the employee’s job at the sanctuary --
CREATE TABLE IF NOT EXISTS StaffStatus(
staffStatusCode INT,
staffStatusDescription TEXT,
PRIMARY KEY(staffStatusCode)
);

-- Lists all countries that sanctuaries operate in and alpacas are from --
CREATE TABLE IF NOT EXISTS Countries(
countryCode TEXT,
countryName TEXT,
PRIMARY KEY(countryCode)
);

-- Lists all sanctuaries associated with the Alpaca Oasis Organization --
CREATE TABLE IF NOT EXISTS Sanctuaries(
sanctuaryID SERIAL,
sanctuaryName TEXT,
dateEstablished DATE,
offersAccommodation BOOLEAN,
countryCode TEXT,
PRIMARY KEY(sanctuaryID),
FOREIGN KEY(countryCode) references Countries(countryCode)
);

-- Lists all people including staff and guests --
CREATE TABLE IF NOT EXISTS People(
peopleID SERIAL,
firstName TEXT,
lastName TEXT,
dateOfBirth DATE,
gender TEXT,
emailAddress TEXT,
PRIMARY KEY(peopleID)
);

-- Lists all the staff and their basic attributes --
CREATE TABLE IF NOT EXISTS Staff(
peopleID INT,
dateJoined DATE,
dateLeft DATE,
staffStatusCode INT,
sanctuaryID INT,
PRIMARY KEY(peopleID),
FOREIGN KEY(peopleID) references People(peopleID),
FOREIGN KEY(staffStatusCode) references StaffStatus(staffStatusCode),
FOREIGN KEY(sanctuaryID) references Sanctuaries(sanctuaryID)
);

-- Lists all rooms available for guests to stay in --
CREATE TABLE IF NOT EXISTS Rooms(
roomID SERIAL,
roomName TEXT,
roomDescription TEXT,
facilities TEXT,
otherDetails TEXT,
sanctuaryID INT,
PRIMARY KEY(roomID),
FOREIGN KEY(sanctuaryID) references Sanctuaries(sanctuaryID)
);

-- This lists all the guests at the sanctuary as well as what rooms they are staying in --
CREATE TABLE IF NOT EXISTS Guests(
peopleID INT references People(peopleID),
PRIMARY KEY(peopleID)
);

-- Lists all rooms booked by tourists --
CREATE TABLE IF NOT EXISTS Bookings(
roomID INT,
peopleID INT,
dateOfArrival DATE,
dateOfDeparture DATE,
PRIMARY KEY(roomID, peopleID, dateOfArrival),
FOREIGN KEY(peopleID) references People(peopleID),
FOREIGN KEY(roomID) references Rooms(roomID)
);

-- Lists each Alpaca’s temperament --
CREATE TABLE IF NOT EXISTS AlpacaStatus(
statusCode INT,
statusDescription TEXT,
PRIMARY KEY(statusCode)
);

-- Lists all alpacas along with their basic attributes --
CREATE TABLE IF NOT EXISTS Alpacas(
alpacaID SERIAL,
name TEXT,
gender TEXT,
conditionOnArrival TEXT,
dateOfArrival DATE,
dateOfDeparture DATE,
deceased BOOLEAN,
dateDeceased DATE,
statusCode INT,
countryCode TEXT,
sanctuaryID INT,
PRIMARY KEY(alpacaID),
FOREIGN KEY(statusCode) references AlpacaStatus(statusCode),
FOREIGN KEY(countryCode) references Countries(countryCode),
FOREIGN KEY(sanctuaryID) references Sanctuaries(sanctuaryID)
);

-- Lists all the checkup reports on alpacas for each sanctuary --
CREATE TABLE IF NOT EXISTS ProgressReports(
peopleID INT,
alpacaID INT,
dateOfReport DATE,
conditionOf TEXT,
treatment TEXT,
PRIMARY KEY(peopleID, alpacaID),
FOREIGN KEY(peopleID) references People(peopleID),
FOREIGN KEY(alpacaID) references Alpacas(alpacaID)
);

-- Lists the addresses of all people --
CREATE TABLE IF NOT EXISTS Addresses(
addressID SERIAL,
peopleID INT,
streetName TEXT,
streetNum INT,
zipCode INT,
stateCode TEXT,
countryCode TEXT,
PRIMARY KEY(addressID, peopleID),
FOREIGN KEY(countryCode) references Countries(countryCode),
FOREIGN KEY(peopleID) references People(peopleID)
);

-- View that lists the IDs, names, and positions of all staff --
CREATE VIEW StaffInformation AS
	SELECT s.peopleID , p.firstName, p.lastName, c.staffStatusDescription AS job
	FROM People p
	INNER JOIN Staff s
 	ON p.peopleID = s.peopleID
	LEFT JOIN StaffStatus c
	ON s.staffStatusCode = c.staffStatusCode
	ORDER BY peopleID ASC;

-- View that lists the IDs, names, and temperament of all alpacas --
CREATE VIEW AlpacaInformation AS
	SELECT a.alpacaID as ID, a.name, s.statusDescription AS temperament
	FROM Alpacas a
	INNER JOIN AlpacaStatus s
	ON a.statusCode = s.statusCode
	ORDER BY ID ASC;


-- This will truncate all the tables in the correct order --
TRUNCATE StaffStatus, Countries, Sanctuaries, People, Staff, Rooms, Guests, Bookings, AlpacaStatus, Alpacas, ProgressReports,Addresses;

-- This sets the serial integers back to one --
ALTER SEQUENCE People_peopleID_seq RESTART WITH 1;
ALTER SEQUENCE Sanctuaries_sanctuaryID_seq RESTART WITH 1;
ALTER SEQUENCE Rooms_roomID_seq RESTART WITH 1;
ALTER SEQUENCE Addresses_addressID_seq RESTART WITH 1;
ALTER SEQUENCE Alpacas_alpacaID_seq RESTART WITH 1;


INSERT INTO Countries (countryCode, countryName) VALUES 
('ALB', 'Albania'),
('AUS', 'Australia'),
('CHL', 'Chile'),
('CHN', 'China'),
('USA', 'United States of America'),
('HTI', 'Haiti'),
('PAK', 'Pakistan');

INSERT INTO People (firstName, lastName, dateOfBirth, gender, emailAddress) VALUES
('Robert', 'Sun', '1970-12-12', 'Male', 'BobSun@gmail.com'),
('Sally', 'Hensen', '1971-03-10', 'Female', 'SallyH@yahoo.com'),
('Barbara', 'Scofield', '1980-03-22', 'Female', 'Barbbb@gmail.com'),
('Michael', 'Scott', '1960-06-19', 'Male', 'Mscott@gmail.com'),
('Sarah', 'Smith', '1975-12-05', 'Female', 'SSHH@comcast.net'),
('Martin', 'Mathers', '1980-01-13', 'Male', 'MandM@gmail.com'),
('George', 'Lopez', '1978-02-02', 'Male', 'Georgie@yahoo.com'),
('Sam', 'Daniels', '1966-05-11', 'Male', 'SamDaniels@hotmail.com'),
('Danny', 'West', '1968-10-04', 'Male', 'EastWest@yahoo.com'),
('Robin', 'Tulip', '1984-01-14', 'Female', 'TulipFlowers@gmail.com'),
('Amanda', 'Bush', '1977-06-23', 'Female', 'Amanda1123@gmail.com'),
('Casey', 'Smith', '1994-11-18', 'Female', 'CaseyS444@hotmail.com'),
('Jaime', 'Jobs', '1989-12-09', 'Male', 'JJ@yahoo.com'),
('Alex', 'Frost', '1997-08-25', 'Male', 'Frosty@comcast.net');

INSERT INTO Addresses (peopleID, streetName, streetNum, zipCode, stateCode, countryCode) VALUES
(1, 'Grove Street', 44, 07455, 'CT', 'USA'),
(2, 'Pearl Street', 122, 11320, 'AL', 'USA'),
(3, 'Harbor Parkway', 35, 77732, 'FL', 'USA'),
(4, 'Cow Hill Road', 89, 59851, 'GA', 'USA'),
(5, 'Pratt Road', 200, 33465, 'CA', 'USA'),
(6, 'Goose Lane', 75, 99651, 'NY', 'USA'),
(7, 'Main Street', 652, 26788, 'MA', 'USA'),
(8, 'State Street', 63, 12451, 'NJ', 'USA'),
(9, 'Lincoln Road', 32, 77733, 'FL', 'USA'),
(10, 'Bush Lane', 90, 99653, 'NY', 'USA'),
(11, 'Jersey Drive', 81, 80012, 'MN', 'USA'),
(12, 'Sunset Lane', 23, 48370, 'MO', 'USA'),
(13, 'Birchwood Road', 26, 99648, 'NY', 'USA'),
(14, 'Lonely Lane', 55, 07454, 'CT', 'USA');

INSERT INTO StaffStatus (staffStatusCode, staffStatusDescription) VALUES
(100, 'Housekeeping'),
(101, 'Maintenance'),
(102, 'Animal Expert'),
(103, 'Veterinarian');

INSERT INTO Sanctuaries (sanctuaryName, dateEstablished, offersAccommodation, countryCode) VALUES
('Furry Friends', '2000-12-05', TRUE, 'PAK'),
('Alpaca Haven', '2002-03-10', TRUE, 'USA'),
('Wooly Farms', '2002-05-21', TRUE, 'HTI'),
('Packs of Alpacas', '2005-07-08', TRUE, 'AUS'),
('Alpaca Zoo', '2007-06-28', TRUE, 'ALB'),
('All the Alpacas', '2010-08-06', TRUE, 'CHL'),
('Sunny Alpaca Farm', '2015-04-14', FALSE, 'CHN');

INSERT INTO Staff (peopleID, dateJoined, dateLeft, staffStatusCode, sanctuaryID) VALUES
(1, '2000-08-10', NULL, 102, 2),
(2, '2001-03-07', NULL, 103, 2),
(3, '2001-04-16', '2001-06-15', 100, 2),
(4, '2002-06-20', '2012-07-21', 101, 2),
(5, '2005-11-29', NULL, 100, 2),
(6, '2005-12-01', NULL, 103, 2),
(7, '2006-07-08', NULL, 101, 2);


INSERT INTO Rooms (roomName, roomDescription, facilities, otherDetails, sanctuaryID) VALUES
('Oasis', 'Single', 'Full Bath', 'Handicap', 2),
('Breezeway', 'Doouble', 'Full Bath', 'No Windows', 2),
('Tuscan Sun', 'Double', 'Full Bath', 'Pool View', 2),
('Sunflower', 'Quad', 'Full Bath', 'Handicap', 2),
('Daisy', 'Single', 'Half Bath', 'Pool View', 2),
('Rose', 'Single', 'Half Bath', 'Hill View', 2),
('Hearth', 'Triple', 'Full Bath', 'Handicap', 2);

INSERT INTO Guests (peopleID) VALUES 
(8),
(9),
(10),
(11),
(12),
(13),
(14);

INSERT INTO Bookings (roomID, peopleID, dateOfArrival, dateOfDeparture) VALUES
(1, 8, '2014-04-01', '2014-04-03'),
(2, 9, '2014-09-16', '2014-09-17'),
(3, 10, '2015-11-07', '2015-11-09'),
(1, 11, '2015-03-10', '2015-03-15'),
(3, 12, '2015-05-22', '2015-05-24'),
(6, 13, '2015-06-17', '2015-06-19'),
(4, 14, '2016-08-19', '2016-08-22');

INSERT INTO AlpacaStatus (statusCode, statusDescription) VALUES 
(100, 'Loves Attention'),
(101, 'Docile'),
(102, 'Doesn''t like strangers'),
(103, 'Moody');

INSERT INTO Alpacas (name, gender, conditionOnArrival, dateOfArrival, dateOfDeparture, deceased, dateDeceased, statusCode, countryCode, sanctuaryID) VALUES
('Alfredo', 'Male', 'Broken Ankle', '2001-04-06', '2008-03-17', FALSE, NULL, 100, 'USA', 2),
('Perry', 'Male', 'Swollen Leg', '2001-07-10', '2006-05-09', FALSE, NULL, 101, 'USA', 2),
('Sammy', 'Male', 'Stable', '2002-01-05', NULL, FALSE, NULL, 103, 'USA', 2),
('Alma', 'Female', 'Flu', '2003-03-12', '2010-01-14', TRUE, '2010-01-14', 102, 'USA', 2),
('Spots', 'Female', 'Virus', '2003-06-25', NULL, FALSE, NULL, 101, 'USA', 2),
('Franny', 'Female', 'Stable', '2004-02-16', NULL, FALSE, NULL, 100, 'USA', 2),
('Matt', 'Male', 'Stable', '2006-05-20', NULL, FALSE, NULL, 101, 'USA', 2);

INSERT INTO ProgressReports (peopleID, alpacaID, dateOfReport, conditionOf, treatment) VALUES
(1, 2, '2013-11-22', 'Stable', 'Checkup'),
(2, 1, '2014-10-20', 'Stable', 'Vaccine'),
(2, 4, '2014-02-10', 'Stable', 'Vaccine'),
(1, 6, '2014-02-07', 'Flu', 'Checkup'),
(1, 5, '2014-03-06', 'Stable', 'Checkup'),
(6, 3, '2015-07-18', 'Flu', 'Vaccine'),
(6, 7, '2015-07-20', 'Swollen Hoof', 'Ice and Anti-swelling medicine');


-- Reports --

-- Returns the percentage of guests who are under 30 years old --
SELECT TRUNC (
	CAST (
		( SELECT COUNT (People.peopleID) AS under30
		FROM  People
		LEFT JOIN Guests
		ON People.peopleID = Guests.peopleID
		WHERE date_part ('year', age (dateOfBirth) ) < 30
		) as decimal (5,2)
	)
	/
	( SELECT COUNT (peopleID) AS allGuests
	FROM Guests
	)
	*100
	) as percentUnder30;

-- Displays the names of sanctuaries and alpacas who have the same countryCode --
SELECT s.sanctuaryName, s.countryCode, a.name
FROM Sanctuaries s
INNER JOIN Alpacas a
ON s.countryCode = a.countryCode
ORDER BY s.countryCode DESC;

-- Shows all staff that have been fired who once worked under the Alpaca Oasis Organization --
SELECT p.firstName, p.lastName, c.staffStatusDescription, s.dateJoined, s.dateLeft
FROM People p
INNER JOIN Staff s
ON p.peopleID = s.peopleID
INNER JOIN staffStatus c
ON c.staffStatusCode = s.staffStatusCode
WHERE s.dateLeft IS NOT NULL
ORDER BY s.peopleID DESC;

-- Displays all alpacas from any sanctuaries under the Alpaca Oasis Organization that have died --
SELECT a.name, a.gender, s.sanctuaryName, a.dateOfArrival, a.dateDeceased
FROM Alpacas a
INNER JOIN Sanctuaries s
ON a.sanctuaryID = s.sanctuaryID
WHERE a.dateDeceased IS NOT NULL
ORDER BY a.dateDeceased ASC;

-- Shows all the progress reports entered by animal experts --
SELECT p.firstName, p.lastName, s.sanctuaryName,d.staffStatusDescription, a.name, r.dateOfReport, r.conditionOf, r.treatment
FROM Staff c
INNER JOIN StaffStatus d
ON c.staffStatusCode = d.staffStatusCode
INNER JOIN People p
ON p.peopleID = c.peopleID
INNER JOIN ProgressReports r
ON p.peopleID = r.peopleID
INNER JOIN Alpacas a
ON r.alpacaID = a.alpacaID
INNER JOIN Sanctuaries s
ON a.sanctuaryID = s.sanctuaryID
WHERE c.staffStatusCode = 102
ORDER BY r.dateOfReport ASC;


-- Stored Procedures --

-- Calculates the age of a person that is in the People table --
CREATE OR REPLACE FUNCTION CalculateAge(peopleID INT) AS
$$
DECLARE
	age DATE := (SELECT EXTRACT (YEAR FROM age (CURRENT_DATE, (SELECT dateOfBirth FROM People
			WHERE People.peopleID = peopleID))));
BEGIN
	RETURN age;
END;
$$ LANGUAGE plpgsql;

-- Checks to see if a new row in the People table has inputs for the first name or last name and date of birth that are not null --
CREATE OR REPLACE FUNCTION ValidInput() 
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.firstName IS NULL AND NEW.lastName IS NULL THEN
		RAISE EXCEPTION 'firstName and lastName cannot be null';
	END IF;
	IF NEW.dateOfBirth IS NULL THEN
		RAISE EXCEPTION 'dateOfBirth cannot be null';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Automatically returns a table filled with the names of guests that the selected sanctuary has had visit --
CREATE OR REPLACE FUNCTION SanctuaryGuests(IN sanctuaryID INT)
	RETURNS TABLE (firstName text, lastName text) AS
	$$
BEGIN
RETURN QUERY SELECT DISTINCT p.firstName, p.lastName
		FROM People p
		INNER JOIN Guests g
		ON p.peopleID = g.peopleID
		INNER JOIN Bookings b
		ON g.peopleID = b.peopleID						INNER JOIN Rooms r
		ON b.roomID = r.RoomID
		WHERE r.sanctuaryID IS NOT NULL;
END;
$$ LANGUAGE plpgsql;


-- Triggers --

-- Runs the ValidInput() stored procedure whenever there is a new insert or update on the People table --
CREATE TRIGGER ValidInput 
BEFORE INSERT OR UPDATE ON People
FOR EACH ROW
EXECUTE PROCEDURE ValidInput();


-- Security --

--The admin of the database can see all information for all sanctuaries under the Alpaca Oasis Organization --
CREATE ROLE Admin;
GRANT ALL ON ALL TABLES
IN SCHEMA PUBLIC
TO Admin;

-- Employees who are either animal experts or veterinarians have access to all alpaca information, alpaca statuses, and progress reports on those alpacas --
CREATE ROLE AnimalHandler;
GRANT SELECT, INSERT, UPDATE ON AlpacaStatus, Alpacas, ProgressReports
TO AnimalHandler;

--All employees who are housekeepers will have access to view the bookings for rooms they are assigned to --
CREATE ROLE Housekeeper;
GRANT SELECT ON Bookings 
TO Housekeeper;

-- All guests staying at a sanctuary will be able to see the room they are staying in with all its details as well as the list of alpacas in that sanctuary --
CREATE ROLE Guest;
GRANT SELECT ON Rooms, Alpacas
TO Guest;