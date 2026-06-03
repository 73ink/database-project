USE SkyTrackAirlineDB;


-- ============================================
-- 1. Show each flight with its flight number,
-- origin airport, destination airport, aircraft model,
-- and total number of passengers booked on it.
-- Include flights that have no bookings.
-- ============================================
SELECT 
    F.FlightNumber,
    OriginAirport.Name AS OriginAirport,
    DestinationAirport.Name AS DestinationAirport,
    A.Model AS AircraftModel,
    COUNT(B.BookingID) AS TotalPassengersBooked
FROM Flight F
INNER JOIN Airport OriginAirport
    ON F.OriginAirportID = OriginAirport.AirportID
INNER JOIN Airport DestinationAirport
    ON F.DestinationAirportID = DestinationAirport.AirportID
INNER JOIN Aircraft A
    ON F.AircraftID = A.AircraftID
LEFT JOIN Booking B
    ON F.FlightID = B.FlightID
GROUP BY 
    F.FlightNumber,
    OriginAirport.Name,
    DestinationAirport.Name,
    A.Model;



-- ============================================
-- 2. List all passengers who have never made a booking.
-- ============================================
SELECT 
    P.PassengerID,
    P.FullName,
    P.Email,
    P.Nationality
FROM Passenger P
LEFT JOIN Booking B
    ON P.PassengerID = B.PassengerID
WHERE B.BookingID IS NULL;



-- ============================================
-- 3. For each flight, show the flight number
-- and total revenue generated from its bookings.
-- Show only flights where total revenue exceeds 500.
-- Order from highest to lowest.
-- ============================================
SELECT 
    F.FlightNumber,
    SUM(B.Price) AS TotalRevenue
FROM Flight F
INNER JOIN Booking B
    ON F.FlightID = B.FlightID
GROUP BY F.FlightNumber
HAVING SUM(B.Price) > 500
ORDER BY TotalRevenue DESC;



-- ============================================
-- 4. Show each crew member's full name and total number
-- of flights they have been assigned to.
-- Show only crew members assigned to more than one flight.
-- ============================================
SELECT 
    C.FullName,
    C.Role,
    COUNT(FC.FlightID) AS TotalFlightsAssigned
FROM CrewMember C
INNER JOIN FlightCrew FC
    ON C.CrewMemberID = FC.CrewMemberID
GROUP BY 
    C.FullName,
    C.Role
HAVING COUNT(FC.FlightID) > 1
ORDER BY TotalFlightsAssigned DESC;



-- ============================================
-- 5. Find the average booking price per flight.
-- Show only flights where the average price is above
-- the overall average price across all bookings.
-- ============================================
SELECT 
    F.FlightNumber,
    AVG(B.Price) AS AverageBookingPrice
FROM Flight F
INNER JOIN Booking B
    ON F.FlightID = B.FlightID
GROUP BY F.FlightNumber
HAVING AVG(B.Price) > (
    SELECT AVG(Price)
    FROM Booking
);



-- ============================================
-- 6. Show the flight with the highest number of bookings.
-- Display its flight number, origin, destination,
-- and total bookings.
-- ============================================
SELECT TOP 1
    F.FlightNumber,
    OriginAirport.Name AS OriginAirport,
    DestinationAirport.Name AS DestinationAirport,
    COUNT(B.BookingID) AS TotalBookings
FROM Flight F
INNER JOIN Booking B
    ON F.FlightID = B.FlightID
INNER JOIN Airport OriginAirport
    ON F.OriginAirportID = OriginAirport.AirportID
INNER JOIN Airport DestinationAirport
    ON F.DestinationAirportID = DestinationAirport.AirportID
GROUP BY 
    F.FlightNumber,
    OriginAirport.Name,
    DestinationAirport.Name
ORDER BY TotalBookings DESC;



-- ============================================
-- 7. For each booking class, show total revenue,
-- number of bookings, average price, highest price,
-- and lowest price.
-- ============================================
SELECT 
    Class,
    SUM(Price) AS TotalRevenue,
    COUNT(BookingID) AS NumberOfBookings,
    AVG(Price) AS AveragePrice,
    MAX(Price) AS HighestPrice,
    MIN(Price) AS LowestPrice
FROM Booking
GROUP BY Class;



-- ============================================
-- 8. List all passengers who booked a flight
-- that is currently 'Cancelled'.
-- Show passenger name, flight number, and booking date.
-- ============================================
SELECT 
    P.FullName AS PassengerName,
    F.FlightNumber,
    F.Status,
    B.BookingDate
FROM Passenger P
INNER JOIN Booking B
    ON P.PassengerID = B.PassengerID
INNER JOIN Flight F
    ON B.FlightID = F.FlightID
WHERE F.Status = 'Cancelled';



-- ============================================
-- 9. Show all flights that have at least one pilot
-- and at least one flight attendant assigned.
-- Display flight number, total crew count,
-- and departure datetime.
-- ============================================
SELECT 
    F.FlightNumber,
    COUNT(FC.CrewMemberID) AS TotalCrewCount,
    F.DepartureDT
FROM Flight F
INNER JOIN FlightCrew FC
    ON F.FlightID = FC.FlightID
INNER JOIN CrewMember C
    ON FC.CrewMemberID = C.CrewMemberID
GROUP BY 
    F.FlightID,
    F.FlightNumber,
    F.DepartureDT
HAVING 
    SUM(CASE WHEN C.Role = 'Pilot' THEN 1 ELSE 0 END) >= 1
    AND
    SUM(CASE WHEN C.Role = 'Flight Attendant' THEN 1 ELSE 0 END) >= 1;



-- ============================================
-- 10. FINAL CHALLENGE:
-- Show the complete flight summary:
-- flight number, origin airport city,
-- destination airport city, aircraft model,
-- aircraft manufacturer, total passengers booked,
-- total crew assigned, and total revenue.
-- Order by total revenue from highest to lowest.
-- ============================================
SELECT 
    F.FlightNumber,
    OriginAirport.City AS OriginAirportCity,
    DestinationAirport.City AS DestinationAirportCity,
    A.Model AS AircraftModel,
    A.Manufacturer AS AircraftManufacturer,

    COUNT(DISTINCT B.BookingID) AS TotalPassengersBooked,
    COUNT(DISTINCT FC.CrewMemberID) AS TotalCrewAssigned,
    COALESCE(SUM(DISTINCT B.Price), 0) AS TotalRevenue

FROM Flight F
INNER JOIN Airport OriginAirport
    ON F.OriginAirportID = OriginAirport.AirportID
INNER JOIN Airport DestinationAirport
    ON F.DestinationAirportID = DestinationAirport.AirportID
INNER JOIN Aircraft A
    ON F.AircraftID = A.AircraftID
LEFT JOIN Booking B
    ON F.FlightID = B.FlightID
LEFT JOIN FlightCrew FC
    ON F.FlightID = FC.FlightID
GROUP BY 
    F.FlightNumber,
    OriginAirport.City,
    DestinationAirport.City,
    A.Model,
    A.Manufacturer
ORDER BY TotalRevenue DESC;
