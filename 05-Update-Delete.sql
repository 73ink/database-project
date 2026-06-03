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






