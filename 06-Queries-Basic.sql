

USE SkyTrackAirlineDB;

-- 1. List all flights and their current status,
-- ordered by departure datetime from earliest to latest.

SELECT 
    FlightNumber,
    DepartureDT,
    ArrivalDT,
    Status
FROM Flight
ORDER BY DepartureDT ASC;


-- 
-- 2. Show all passengers,
-- ordered alphabetically by full name.

SELECT 
    PassengerID,
    FullName,
    NationalID,
    Email,
    Phone,
    Nationality,
    DateOfBirth
FROM Passenger
ORDER BY FullName ASC;



-- 3. List all aircraft and their seating capacity,
-- ordered from largest to smallest.

SELECT 
    AircraftID,
    RegistrationNumber,
    Model,
    Manufacturer,
    Capacity
FROM Aircraft
ORDER BY Capacity DESC;



-- 4. Show all bookings and their class.
-- Display only distinct class values that exist in the system.

SELECT DISTINCT 
    Class
FROM Booking;



-- 5. List all flights that have a status of
-- 'Delayed' or 'Cancelled'.
SELECT 
    FlightNumber,
    DepartureDT,
    ArrivalDT,
    Status
FROM Flight
WHERE Status IN ('Delayed', 'Cancelled');



--
-- 6. Show all passengers whose nationality is 'Omani'.

SELECT 
    PassengerID,
    FullName,
    NationalID,
    Email,
    Phone,
    Nationality,
    DateOfBirth
FROM Passenger
WHERE Nationality = 'Omani';



-- 
-- 7. List all airports, ordered by country.

SELECT 
    AirportID,
    IATACode,
    Name,
    City,
    Country
FROM Airport
ORDER BY Country ASC;


