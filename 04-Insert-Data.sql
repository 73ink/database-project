-- data insertion task

USE SkyTrackAirlineDB;

-- Insert Airports
INSERT INTO Airport (IATACode, Name, City, Country)
VALUES
('MCT', 'Muscat International Airport', 'Muscat', 'Oman'),
('DXB', 'Dubai International Airport', 'Dubai', 'United Arab Emirates'),
('DOH', 'Hamad International Airport', 'Doha', 'Qatar'),
('JED', 'King Abdulaziz International Airport', 'Jeddah', 'Saudi Arabia'),
('CAI', 'Cairo International Airport', 'Cairo', 'Egypt');


-- Insert Aircraft

INSERT INTO Aircraft (RegistrationNumber, Model, Manufacturer, Capacity, YearOfManufacture)
VALUES
('A4O-ST1', 'Boeing 737-800', 'Boeing', 162, 2018),
('A4O-ST2', 'Airbus A320neo', 'Airbus', 180, 2020),
('A4O-ST3', 'Embraer E190', 'Embraer', 100, 2017),
('A4O-ST4', 'ATR 72-600', 'ATR', 70, 2019),
('A4O-ST5', 'Boeing 787-9', 'Boeing', 290, 2021);


INSERT INTO Passenger (NationalID, FullName, Email, Phone, Nationality, DateOfBirth)
VALUES
('OM1001', 'Aisha Al Balushi', 'aisha.balushi@example.com', '96891234567', 'Omani', '1999-03-14'),
('AE1002', 'Mariam Al Mansoori', 'mariam.mansoori@example.com', '971501112233', 'Emirati', '1997-07-21'),
('QA1003', 'Khalid Al Thani', 'khalid.thani@example.com', '97455112233', 'Qatari', '1995-01-09'),
('SA1004', 'Fahad Al Harbi', 'fahad.harbi@example.com', '966555123456', 'Saudi', '1992-11-18'),
('EG1005', 'Nour Hassan', 'nour.hassan@example.com', '201001112233', 'Egyptian', '2000-05-25'),
('IN1006', 'Ravi Kumar', 'ravi.kumar@example.com', '919876543210', 'Indian', '1994-09-30'),
('PK1007', 'Sara Khan', 'sara.khan@example.com', '923001234567', 'Pakistani', '1998-12-12'),
('GB1008', 'James Wilson', 'james.wilson@example.com', '447700900123', 'British', '1990-04-06');

-- Insert Crew Members

INSERT INTO CrewMember (FullName, Role, LicenseNumber)
VALUES
('Ahmed Al Siyabi', 'Pilot', 'LIC-P001'),
('Salim Al Harthy', 'Co-Pilot', 'LIC-CP002'),
('Fatma Al Nabhani', 'Flight Attendant', 'LIC-FA003'),
('Maha Al Hinai', 'Flight Attendant', 'LIC-FA004'),
('Yousef Al Rawahi', 'Engineer', 'LIC-EN005'),
('Omar Al Kindi', 'Pilot', 'LIC-P006');

-- Insert Flights

INSERT INTO Flight 
(FlightNumber, DepartureDT, ArrivalDT, Status, AircraftID, OriginAirportID, DestinationAirportID)
VALUES
('SK101', '2026-06-10 08:00:00', '2026-06-10 10:00:00', 'Scheduled', 1, 1, 2),
('SK102', '2026-06-10 12:00:00', '2026-06-10 13:30:00', 'Delayed', 2, 2, 3),
('SK103', '2026-06-11 09:00:00', '2026-06-11 11:30:00', 'Cancelled', 3, 3, 4),
('SK104', '2026-06-11 15:00:00', '2026-06-11 18:00:00', 'Completed', 4, 4, 5),
('SK105', '2026-06-12 07:30:00', '2026-06-12 09:45:00', 'Scheduled', 5, 5, 1),
('SK106', '2026-06-12 14:00:00', '2026-06-12 16:15:00', 'Completed', 1, 1, 3),
('SK107', '2026-06-13 10:00:00', '2026-06-13 12:00:00', 'Delayed', 2, 2, 4),
('SK108', '2026-06-13 18:00:00', '2026-06-13 21:00:00', 'Cancelled', 3, 3, 5);

-- Insert Bookings

INSERT INTO Booking (PassengerID, FlightID, SeatNumber, Class, Price, BookingDate)
VALUES
(1, 1, '12A', 'Economy', 120.00, '2026-05-20'),
(2, 1, '2B', 'Business', 350.00, '2026-05-21'),
(3, 2, '1A', 'First', 600.00, '2026-05-22'),
(4, 3, '14C', 'Economy', 130.00, '2026-05-23'),
(5, 4, '3A', 'Business', 370.00, '2026-05-24'),
(6, 5, '15D', 'Economy', 115.00, '2026-05-25'),
(7, 6, '1B', 'First', 650.00, '2026-05-26'),
(8, 7, '16A', 'Economy', 140.00, '2026-05-27'),
(1, 8, '4C', 'Business', 390.00, '2026-05-28'),
(2, 6, '18F', 'Economy', 125.00, '2026-05-29');

-- Insert FlightCrew 

INSERT INTO FlightCrew (FlightID, CrewMemberID)
VALUES
-- Flight SK101
(1, 1),
(1, 3),

-- Flight SK102
(2, 1),
(2, 4),

-- Flight SK103
(3, 6),
(3, 3),

-- Flight SK104
(4, 6),
(4, 4),
(4, 5),

-- Flight SK105
(5, 1),
(5, 3),

-- Flight SK106
(6, 6),
(6, 4),
(6, 2),

-- Flight SK107
(7, 1),
(7, 3),
(7, 5),

-- Flight SK108
(8, 6),
(8, 4);

-- Check inserted data

SELECT * FROM Airport;
SELECT * FROM Aircraft;
SELECT * FROM Passenger;
SELECT * FROM CrewMember;
SELECT * FROM Flight;
SELECT * FROM Booking;
SELECT * FROM FlightCrew;