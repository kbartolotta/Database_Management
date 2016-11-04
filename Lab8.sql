/*Katie Bartolotta*/

DROP DATABASE IF EXISTS Bond;
CREATE DATABASE IF NOT EXISTS Bond;

DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Directors;
DROP TABLE IF EXISTS MoviePeople;
DROP TABLE IF EXISTS Actors;
DROP TABLE IF EXISTS Movies;

CREATE TABLE IF NOT EXISTS People (
	peopleID CHAR(10) NOT NULL,
	name TEXT,
	address INT,
	spouseName TEXT,
	actor BOOLEAN,
	director BOOLEAN,
	PRIMARY KEY (peopleID)
);
CREATE TABLE IF NOT EXISTS Directors (
	peopleID CHAR(10) NOT NULL,
	filmSchool TEXT,
	DGADate DATETIME,
	lensMaker TEXT,
	moviesDirected INT,
	PRIMARY KEY (peopleID)
);
CREATE TABLE IF NOT EXISTS MoviePeople (
	movieID CHAR(10)  NOT NULL,
	peoopleID CHAR(10) NOT NULL,
	actor BOOLEAN,
	director BOOLEAN,
	PRIMARY KEY (movieID, peopleID)
);
CREATE TABLE IF NOT EXISTS Actors (
	poepleID CHAR(10) NOT NULL,
	birthDate DATETIME,
	hairColor TEXT,
	eyeColor TEXT,
	height INT,
	weight INT,
	favColor TEXT,
	SAGADate DATETIME,
	PRIMARY KEY (peopleID)
);
CREATE TABLE IF NOT EXISTS Movies (
	movieID CHAR(10) NOT NULL,
	name TEXT,
	releaseYear TEXT,
	MPAANumber INT,
	domesticSales INT,
	foreignSales INT,
	DVDBluraySales INT,¬¬
	PRIMARY KEY (movieID)
);
