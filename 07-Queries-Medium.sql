
USE SkyTrackAirlineDB;

-- 1. For each flight, show the flight number, the name of the origin airport, and the name of the destination airport.
SELECT 
    F.FlightNumber,
    OriginAirport.Name AS OriginAirport,
    DestinationAirport.Name AS DestinationAirport
FROM Flight F
INNER JOIN Airport OriginAirport
    ON F.OriginAirportID = OriginAirport.AirportID
INNER JOIN Airport DestinationAirport
    ON F.DestinationAirportID = DestinationAirport.AirportID;


-- 2. Show each booking along with the full name of the passenger who made it and the flight number.
SELECT 
    B.BookingID,
    P.FullName AS PassengerName,
    F.FlightNumber,
    B.SeatNumber,
    B.Class,
    B.Price,
    B.BookingDate
FROM Booking B
INNER JOIN Passenger P
    ON B.PassengerID = P.PassengerID
INNER JOIN Flight F
    ON B.FlightID = F.FlightID;



-- 3. List all crew members assigned to flight 'SK101', showing their full name and role.
SELECT 
    C.FullName,
    C.Role
FROM CrewMember C
INNER JOIN FlightCrew FC
    ON C.CrewMemberID = FC.CrewMemberID
INNER JOIN Flight F
    ON FC.FlightID = F.FlightID
WHERE F.FlightNumber = 'SK101';


-- 4. Show all completed flights along with the aircraft model used on each flight.
SELECT 
    F.FlightNumber,
    F.Status,
    A.Model AS AircraftModel,
    A.Manufacturer
FROM Flight F
INNER JOIN Aircraft A
    ON F.AircraftID = A.AircraftID
WHERE F.Status = 'Completed';


-- 5. For each passenger, show their full name and the total number of bookings they have made.
-- Order by booking count from highest to lowest.

SELECT 
    P.FullName,
    COUNT(B.BookingID) AS TotalBookings
FROM Passenger P
LEFT JOIN Booking B
    ON P.PassengerID = B.PassengerID
GROUP BY P.FullName
ORDER BY TotalBookings DESC;



-- 6. Show the total revenue collected from each booking class.

SELECT 
    Class,
    SUM(Price) AS TotalRevenue
FROM Booking
GROUP BY Class;



-- 7. Count how many flights each aircraft has been assigned to.

SELECT 
    A.RegistrationNumber,
    A.Model,
    COUNT(F.FlightID) AS TotalFlightsAssigned
FROM Aircraft A
LEFT JOIN Flight F
    ON A.AircraftID = F.AircraftID
GROUP BY A.RegistrationNumber, A.Model
ORDER BY TotalFlightsAssigned DESC;


-- 8. List all flights that have more than one booking.

SELECT 
    F.FlightNumber,
    COUNT(B.BookingID) AS TotalBookings
FROM Flight F
INNER JOIN Booking B
    ON F.FlightID = B.FlightID
GROUP BY F.FlightNumber
HAVING COUNT(B.BookingID) > 1;



-- 9. Show the full details of all bookings: passenger name, flight number, origin airport, destination airport, class, and price paid.

SELECT 
    B.BookingID,
    P.FullName AS PassengerName,
    F.FlightNumber,
    OriginAirport.Name AS OriginAirport,
    DestinationAirport.Name AS DestinationAirport,
    B.Class,
    B.Price AS PricePaid,
    B.SeatNumber,
    B.BookingDate
FROM Booking B
INNER JOIN Passenger P
    ON B.PassengerID = P.PassengerID
INNER JOIN Flight F
    ON B.FlightID = F.FlightID
INNER JOIN Airport OriginAirport
    ON F.OriginAirportID = OriginAirport.AirportID
INNER JOIN Airport DestinationAirport
    ON F.DestinationAirportID = DestinationAirport.AirportID;
