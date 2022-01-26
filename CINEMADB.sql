CREATE DATABASE CinemaDb

USE CinemaDb

CREATE TABLE Movies(
	Id int primary key identity,
	Name nvarchar(50)
)

ALTER TABLE Movies
ADD Duration nvarchar(50)

INSERT INTO Movies(Name, Duration)
VALUES ('Red Notice','1h 57m'),
	   ('Infinite','1h 50m'),
	   ('Mr Smith &Mrs Smith','2h 05m'),
	   ('DoLittle','1h 50m')

CREATE TABLE Genres(
	Id int primary key identity,
	Type nvarchar(50)
)

INSERT INTO Genres(Type)
VALUES ('Drama'),
	   ('Action'),
	   ('Romance'),
	   ('Fantacy')

INSERT INTO MoviesGenres(MovieId,GenreId)
VALUES (1,1),
	   (2,2),
	   (3,3),
	   (4,4)

CREATE TABLE Actors(
	Id int primary key identity,
	Fullname nvarchar(100)
)

INSERT INTO Actors(Fullname)
VALUES ('Gal Galdot'),
	   ('Ryan Reynolds'),
	   ('Mark Walhberg'),
	   ('Anjelina Jolie'),
	   ('Brad Pit'),
	   ('Robert Downey')

INSERT INTO MoviesActors(MovieId,ActorId)
VALUES (1,1),
	   (1,2),
	   (2,3),
	   (3,4),
	   (3,5),
	   (4,6)

CREATE  TABLE MoviesGenres(
	Id int primary key identity,
	MovieId int references Movies(Id),
	GenreId int references Genres(Id)
)

CREATE  TABLE MoviesActors(
	Id int primary key identity,
	MovieId int references Movies(Id),
	ActorId int references Actors(Id)
)

CREATE TABLE Halls(
	Id int primary key identity,
	Name nvarchar(50),
	Capacity int
)

INSERT INTO Halls(Name,Capacity)
VALUES  ('A',10),
		('B',15),
		('C',20),
		('D',25)

CREATE TABLE Customers(
	Id int primary key identity,
	Fullname nvarchar(100),
	PhoneNumber nvarchar(50),
	Age int
)

INSERT INTO Customers(Fullname,PhoneNumber,Age)
VALUES ('Ali Aliyev','0505555555',20),
		('Kamala Aliyev','0606666060',25),
		('Zahra Mustafa','0552553322',28),
		('Konul Mamadli','0707777777',23)

CREATE TABLE Sessions(
	Id int primary key identity,
	StarDate datetime,
	MovieId int references Movies(Id),
	HallId int references Halls(Id)
)

INSERT INTO Sessions(StarDate,MovieId,HallId)
VALUES  ('2022-01-24 15:00:00',1,1),
	    ('2022-01-24 17:00:00',2,2),
		('2022-01-24 19:00:00',3,3),
		('2022-01-24 21:00:00',4,4)

CREATE TABLE Tickets(
	Id int primary key identity,
	Price decimal(8,2),
	SessionId int references Sessions(Id),
	CustomerId int references Customers(Id)
)

INSERT INTO Tickets (Price,SessionId,CustomerId)
VALUES  (15,1,1),
		(12,2,2),
		(12,3,3),
		(20,4,4)

CREATE VIEW V_MovieSessionInfo
AS
SELECT C.Fullname 'CUSTOMER',S.StarDate,M.Name 'FILM',H.Name 'HALL',
G.Type 'GENRE', A.Fullname 'ACTOR',T.Price FROM Tickets T

INNER JOIN Customers C ON T.CustomerId=C.Id
INNER JOIN Sessions S ON T.SessionId=S.Id
INNER JOIN Movies M ON S.MovieId=M.Id
INNER JOIN Halls H ON S.HallId=H.Id
INNER JOIN MoviesGenres MG ON MG.MovieId=M.Id
INNER JOIN Genres G ON MG.GenreId=G.Id
INNER JOIN MoviesActors MA ON MA.MovieId=M.Id
INNER JOIN Actors A ON MA.ActorId=A.Id

SELECT * FROM V_MovieSessionInfo

