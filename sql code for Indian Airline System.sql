CREATE DATABASE INDIAN_AIRLINES;
DROP DATABASE INDIAN_AIRLINES;
USE INDIAN_AIRLINES;
CREATE TABLE Flights (
    FlightID INT PRIMARY KEY,
    FlightNumber VARCHAR(10) NOT NULL,
    DepartureCity VARCHAR(50) NOT NULL,
    ArrivalCity VARCHAR(50) NOT NULL,
    DepartureTime DATETIME NOT NULL,
    ArrivalTime DATETIME NOT NULL,
    SeatsAvailable INT NOT NULL
);
DESC Flights;
-- Insert sample flight data
INSERT INTO Flights (FlightID, FlightNumber, DepartureCity, ArrivalCity, DepartureTime, ArrivalTime, SeatsAvailable)
VALUES
    (1, 'AI101', 'Mumbai', 'Delhi', '2023-10-15 08:00:00', '2023-10-15 10:30:00', 150),
    (2, 'SG202', 'Delhi', 'Bangalore', '2023-10-15 12:00:00', '2023-10-15 14:30:00', 120),
    (3, '6E303', 'Bangalore', 'Chennai', '2023-10-15 16:00:00', '2023-10-15 18:30:00', 100),
    (4, 'AI404', 'Chennai', 'Kolkata', '2023-10-15 20:00:00', '2023-10-15 22:30:00', 130),
    (5, 'SG505', 'Kolkata', 'Mumbai', '2023-10-16 08:00:00', '2023-10-16 10:30:00', 110);

select * from flights;

CREATE TABLE Passengers (
    PassengerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(15)
);
desc passengers;

-- Insert sample passenger data
INSERT INTO Passengers (PassengerID, FirstName, LastName, Email, Phone)
VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', '+1-555-123-4567'),
    (2, 'Jane', 'Smith', 'jane.smith@example.com', '+1-555-987-6543'),
    (3, 'Robert', 'Johnson', 'robert.j@example.com', '+1-555-777-8888'),
    (4, 'Emily', 'Brown', 'emily.b@example.com', '+1-555-444-5555'),
    (5, 'David', 'Wilson', 'david.w@example.com', '+1-555-999-1111'),
    (6, 'Sarah', 'Davis', 'sarah.d@example.com', '+1-555-333-7777');
select * from Passengers;

CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY,
    PassengerID INT,
    FlightID INT,
    Status VARCHAR(20) NOT NULL,
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);
desc reservations;

-- Insert sample reservation data
INSERT INTO Reservations (ReservationID, PassengerID, FlightID, Status)
VALUES
    (1, 1, 1, 'Confirmed'),
    (2, 2, 3, 'Confirmed'),
    (3, 3, 2, 'Confirmed'),
    (4, 4, 4, 'Confirmed'),
    (5, 5, 5, 'Confirmed'),
    (6, 6, 1, 'Confirmed');
select * from reservations;

CREATE TABLE Airports (
    AirportID INT PRIMARY KEY,
    AirportCode VARCHAR(3) NOT NULL,
    AirportName VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50),
    Country VARCHAR(50) NOT NULL
);
desc Airports;
-- Insert sample airport data
INSERT INTO Airports (AirportID, AirportCode, AirportName, City, State, Country)
VALUES
    (1, 'BOM', 'Chhatrapati Shivaji International Airport', 'Mumbai', 'Maharashtra', 'India'),
    (2, 'DEL', 'Indira Gandhi International Airport', 'Delhi', 'Delhi', 'India'),
    (3, 'BLR', 'Kempegowda International Airport', 'Bangalore', 'Karnataka', 'India'),
    (4, 'MAA', 'Chennai International Airport', 'Chennai', 'Tamil Nadu', 'India'),
    (5, 'CCU', 'Netaji Subhas Chandra Bose International Airport', 'Kolkata', 'West Bengal', 'India'),
    (6, 'HYD', 'Rajiv Gandhi International Airport', 'Hyderabad', 'Telangana', 'India');
select * from Airports;

CREATE TABLE Aircraft (
    AircraftID INT PRIMARY KEY,
    AircraftType VARCHAR(50) NOT NULL,
    SeatingCapacity INT NOT NULL
);
desc Aircraft;
-- Insert sample aircraft data
INSERT INTO Aircraft (AircraftID, AircraftType, SeatingCapacity)
VALUES
    (1, 'Boeing 737', 150),
    (2, 'Airbus A320', 180),
    (3, 'Boeing 777', 300),
    (4, 'Airbus A350', 250),
    (5, 'Embraer E190', 100);
select * from Aircraft;

CREATE TABLE FlightPassengerManifest (
    ManifestID INT PRIMARY KEY,
    FlightID INT,
    PassengerID INT,
    SeatNumber VARCHAR(10) NOT NULL,
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID)
);
desc FlightPassengerManifest;
-- Insert sample data into FlightPassengerManifest
INSERT INTO FlightPassengerManifest (ManifestID, FlightID, PassengerID, SeatNumber)
VALUES
    (1, 1, 1, '1A'),
    (2, 1, 2, '1B'),
    (3, 2, 3, '2A'),
    (4, 2, 4, '2B'),
    (5, 3, 5, '3A'),
    (6, 3, 6, '3B');
select * from FlightPassengerManifest;
-- joins--
-- inner joins
 -- Retrieve Passenger and Flight Information for a Reservation
 SELECT
    P.FirstName,
    P.LastName,
    F.FlightNumber,
    F.DepartureCity,
    F.ArrivalCity
FROM Passengers AS P
INNER JOIN Reservations AS R ON P.PassengerID = R.PassengerID
INNER JOIN Flights AS F ON R.FlightID = F.FlightID
WHERE R.ReservationID = 1; -- Replace 1 with the desired ReservationID

--  List All Passengers on a Specific Flight
 -- Replace 'AI101' with the desired FlightNumber
  SELECT
    P.FirstName,
    P.LastName
FROM Passengers AS P
INNER JOIN Reservations AS R ON P.PassengerID = R.PassengerID
INNER JOIN Flights AS F ON R.FlightID = F.FlightID
WHERE F.FlightNumber = 'AI101'; 

-- left join
-- Retrieve Passengers with Their Reservations (Including Unreserved Passengers)
SELECT
    P.FirstName,
    P.LastName,
    R.ReservationID
FROM Passengers AS P
LEFT JOIN Reservations AS R ON P.PassengerID = R.PassengerID;

-- List All Flights and Their Reservations (Including Flights with No Reservations)
SELECT
    F.FlightNumber,
    F.DepartureCity,
    F.ArrivalCity,
    R.ReservationID
FROM Flights AS F
LEFT JOIN Reservations AS R ON F.FlightID = R.FlightID;

-- right join
-- Retrieve Flights and Their Reservations (Including Flights with No Reservations)
SELECT
    F.FlightNumber,
    F.DepartureCity,
    F.ArrivalCity,
    R.ReservationID
FROM Flights AS F
RIGHT JOIN Reservations AS R ON F.FlightID = R.FlightID;

-- List All Reservations and Their Associated Passengers (Including Passengers with No Reservations)
SELECT
    R.ReservationID,
    P.FirstName,
    P.LastName
FROM Reservations AS R
RIGHT JOIN Passengers AS P ON R.PassengerID = P.PassengerID;


-- cross join
-- Combining All Flights and Passengers
SELECT F.FlightNumber, P.FirstName
FROM Flights F
CROSS JOIN Passengers P;

-- Combining All Flights and Airports
SELECT F.FlightNumber, A.AirportName
FROM Flights F
CROSS JOIN Airports A;



-- Using Comparison Operator in a Subquery
SELECT FirstName, LastName
FROM Passengers
WHERE PassengerID IN (SELECT PassengerID FROM Reservations
 WHERE FlightID = (SELECT FlightID FROM Flights WHERE DepartureCity = 'New York'));
 
 -- Using IN Subquery
 SELECT FirstName, LastName
FROM Passengers
WHERE PassengerID IN (SELECT PassengerID FROM Reservations WHERE FlightID IN (1, 2));

-- Using EXISTS Subquery
SELECT FlightNumber, DepartureCity, ArrivalCity
FROM Flights
WHERE EXISTS (SELECT 1 FROM Reservations
 WHERE Reservations.FlightID = Flights.FlightID);
 
 -- view create view
 -- Create a view to show flight information and reservation counts
CREATE VIEW FlightReservationCounts AS
SELECT
    F.FlightID,
    F.FlightNumber,
    F.DepartureCity,
    F.ArrivalCity,
    COUNT(R.ReservationID) AS ReservationCount
FROM Flights F
LEFT JOIN Reservations R ON F.FlightID = R.FlightID
GROUP BY F.FlightID, F.FlightNumber, F.DepartureCity, F.ArrivalCity;

-- view update view
-- Update the number of reservations for a specific flight
UPDATE Reservations
SET ReservationID = ReservationID  
WHERE FlightID = 1;  


SELECT * FROM FlightReservationCounts;


select* from FlightReservationCounts;

-- Retrieve Passengers with a Specific Last Name
SELECT FirstName, LastName, Email
FROM Passengers
WHERE LastName = 'Smith';

-- range operator
-- Retrieve Flights within a Date Range??

SELECT FlightNumber, DepartureCity, ArrivalCity, DepartureTime
FROM Flights
WHERE DepartureTime BETWEEN '2023-10-15 08:00:00' AND '2023-10-16 08:00:00';

-- list Operator
-- Find Flights from a List of Cities
SELECT FlightNumber, DepartureCity, ArrivalCity
FROM Flights
WHERE DepartureCity IN ('Mumbai', 'Delhi', 'Bangalore');

-- like operator

-- Find passengers with first names starting with 'A'
SELECT FirstName, LastName, Email
FROM Passengers
WHERE FirstName LIKE 'A%';


-- Find flights with numbers containing '123'
SELECT FlightNumber, DepartureCity, ArrivalCity
FROM Flights
WHERE FlightNumber LIKE '%123%';

-- Find passengers with email addresses from a specific domain
SELECT FirstName, LastName, Email
FROM Passengers
WHERE Email LIKE '%@example.com';

-- Orderby
-- Sort Flights by Departure City in Ascending Order
SELECT FlightNumber, DepartureCity, ArrivalCity
FROM Flights
ORDER BY DepartureCity;

-- Sort Airports by City in Ascending Order and State in Descending Order
SELECT AirportCode, AirportName, City, State
FROM Airports
ORDER BY City ASC, State DESC;

-- Distinct
-- Retrieve Distinct Departure Cities
SELECT DISTINCT DepartureCity
FROM Flights;

--  Find Distinct Aircraft Types
SELECT DISTINCT AircraftType
FROM Aircraft;

-- is null
--  Identify Passengers with Missing Phone Numbers
SELECT FirstName, LastName, Email, Phone
FROM Passengers
WHERE Phone IS NULL;

-- Retrieve Airports with Undefined State Information
SELECT AirportCode, AirportName, City, State
FROM Airports
WHERE State IS NULL;

-- is not null
-- Identify Passengers with Provided Phone Numbers
SELECT FirstName, LastName, Email, Phone
FROM Passengers
WHERE Phone IS NOT NULL;

-- Retrieve Airports with State Information Defined
SELECT AirportCode, AirportName, City, State
FROM Airports
WHERE State IS NOT NULL;

-- Built In String Function
select lower("INDIAN AIRLINE SYSTEM");
select upper( "indian airline system");
select substring("indian airline system",2,6);
select replace ("indian airline system", "india", "America");

-- group by clause
-- Find the Total Number of Flights Departing from Each City
SELECT DepartureCity, COUNT(*) AS NumberOfFlights
FROM Flights
GROUP BY DepartureCity;


-- Aggregation Function
-- count
-- Count the number of flights departing from each city.
SELECT DepartureCity, COUNT(*) AS NumberOfFlights
FROM Flights
GROUP BY DepartureCity;

-- SUM

-- Calculate the Total Seating Capacity for All Aircraft Types
SELECT SUM(SeatingCapacity) AS TotalSeatingCapacity
FROM Aircraft;

-- AVG
-- Calculate the Average Seating Capacity for All Aircraft Types
SELECT AVG(SeatingCapacity) AS AverageSeatingCapacity
FROM Aircraft;

-- max
-- Find the Highest Passenger ID
SELECT MAX(PassengerID) AS MaxPassengerID
FROM Passengers;

-- MIN
-- Find the Lowest Passenger ID
SELECT MIN(PassengerID) AS MinPassengerID
FROM Passengers;

-- concat
-- List all flight numbers departing from a specific city.
 SELECT DepartureCity, GROUP_CONCAT(FlightNumber) AS FlightNumbers
FROM Flights
WHERE DepartureCity = 'Delhi'
GROUP BY DepartureCity;












