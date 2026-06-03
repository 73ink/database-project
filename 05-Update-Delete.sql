-- task of UPDATE, DELETE

USE SkyTrackAirlineDB;

-- UPDATE TASKS

-- 1. Update one flight status from 'Scheduled' to 'Completed'
UPDATE Flight
SET Status = 'Completed'
WHERE FlightNumber = 'SK101'
  AND Status = 'Scheduled';


SELECT FlightNumber, Status
FROM Flight
WHERE FlightNumber = 'SK101';



-- 2. Change one flight status from 'Delayed' to 'Cancelled'
UPDATE Flight
SET Status = 'Cancelled'
WHERE FlightNumber = 'SK102'
  AND Status = 'Delayed';


SELECT FlightNumber, Status
FROM Flight
WHERE FlightNumber = 'SK102';



-- 3. Increase all Economy class booking prices by 10%
UPDATE Booking
SET Price = Price * 1.10
WHERE Class = 'Economy';


SELECT BookingID, Class, Price
FROM Booking
WHERE Class = 'Economy';



-- 4. Update one passenger's phone number
UPDATE Passenger
SET Phone = '96899457111'
WHERE NationalID = 'OM1001';


SELECT PassengerID, FullName, NationalID, Phone
FROM Passenger
WHERE NationalID = 'OM1001';



-- 5. Move one crew member to a different role
UPDATE CrewMember
SET Role = 'Engineer'
WHERE LicenseNumber = 'LIC-CP002';


SELECT CrewMemberID, FullName, Role, LicenseNumber
FROM CrewMember
WHERE LicenseNumber = 'LIC-CP002';




-- PART 2: DELETE TASKS


-- 1. Delete one cancelled flight
-- First, confirm the cancelled flight exists
SELECT *
FROM Flight
WHERE FlightNumber = 'SK108'
  AND Status = 'Cancelled';


-- Delete the cancelled flight
DELETE FROM Flight
WHERE FlightNumber = 'SK108'
  AND Status = 'Cancelled';

-- Confirm deletion
SELECT *
FROM Flight
WHERE FlightNumber = 'SK108';



-- 2. Delete one booking linked to a cancelled flight
-- First, confirm the booking exists and is linked to a cancelled flight
SELECT 
    B.BookingID,
    B.SeatNumber,
    B.Class,
    B.Price,
    F.FlightNumber,
    F.Status
FROM Booking B
INNER JOIN Flight F
    ON B.FlightID = F.FlightID
WHERE F.Status = 'Cancelled';
GO

-- Delete one booking linked to cancelled flight SK103
DELETE B
FROM Booking B
INNER JOIN Flight F
    ON B.FlightID = F.FlightID
WHERE F.FlightNumber = 'SK103'
  AND F.Status = 'Cancelled';

-- Confirm deletion
SELECT 
    B.BookingID,
    B.SeatNumber,
    B.Class,
    B.Price,
    F.FlightNumber,
    F.Status
FROM Booking B
INNER JOIN Flight F
    ON B.FlightID = F.FlightID
WHERE F.FlightNumber = 'SK103';



-- 3. Try to delete a passenger who has existing bookings
-- First, confirm that the passenger exists and has bookings
SELECT 
    P.PassengerID,
    P.FullName,
    P.NationalID,
    B.BookingID,
    B.FlightID
FROM Passenger P
INNER JOIN Booking B
    ON P.PassengerID = B.PassengerID
WHERE P.NationalID = 'AE1002';

-- Try to delete the passenger
DELETE FROM Passenger
WHERE NationalID = 'AE1002';

-- Comment:
-- Because the foreign key from Booking to Passenger uses ON DELETE CASCADE,
-- deleting this passenger will also delete the passenger's related bookings automatically.
-- If ON DELETE CASCADE was not used, SQL Server would prevent the delete because related bookings exist.

-- Confirm what happened after deletion
SELECT *
FROM Passenger
WHERE NationalID = 'AE1002';


SELECT *
FROM Booking
WHERE PassengerID = 2;
