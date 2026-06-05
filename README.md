# SkyTrack Airline System Database Project

## 1. Project Description

SkyTrack Airline System is a database project designed to manage the main operations of a regional airline. The system stores information about airports, aircraft, flights, passengers, bookings, crew members, and crew assignments.

The main purpose of this database is to organize airline data clearly and make it easier to track flights, passenger bookings, aircraft usage, and crew assignment.

---

## 2. ERD Summary

The database contains 6 main entities:

1. Airport
2. Aircraft
3. Flight
4. Passenger
5. Booking
6. CrewMember


### Main Relationships

- One airport can be used as the origin airport for many flights.
- One airport can be used as the destination airport for many flights.
- One aircraft can be assigned to many flights.
- One passenger can make many bookings.
- One flight can have many bookings.
- One flight can have many crew members.
- One crew member can work on many flights.

The many-to-many relationship between Flight and CrewMember was solved by creating the FlightCrew table in mapping.

---

## 3. Mapping Decisions

Each main entity was converted into a table. A primary key was added to each table using an identity ID.

### Foreign Key Decisions

- AircraftID was added to the Flight table because each flight must use one aircraft.
- OriginAirportID was added to the Flight table because each flight must depart from one airport.
- DestinationAirportID was added to the Flight table because each flight must arrive at one airport.
- PassengerID was added to the Booking table because each booking belongs to one passenger.
- FlightID was added to the Booking table because each booking is linked to one flight.
- FlightCrew was created to connect Flight and CrewMember because their relationship is many-to-many.

Foreign keys were created with ON DELETE CASCADE and ON UPDATE CASCADE as required by the project.

---

## 4. Normalization Summary

The database was normalized up to Third Normal Form.

### First Normal Form

All tables contain atomic values. There are no repeating groups or multi-value columns.

### Second Normal Form

All non-key attributes depend fully on the primary key. The FlightCrew table uses a composite primary key, and it does not contain unnecessary non-key attributes.

### Third Normal Form

There are no transitive dependencies. For example, aircraft details are stored in the Aircraft table instead of being repeated inside the Flight table.

---

## 5. Insert and Delete Notes

During data insertion, the data was added in the correct order to avoid foreign key errors. Parent tables were inserted first, such as Airport, Aircraft, Passenger, and CrewMember. After that, child tables such as Flight, Booking, and FlightCrew were inserted.

For the delete task, a SELECT statement was written before each DELETE statement to confirm that the row existed.

When deleting a passenger who already had bookings, the delete was allowed because ON DELETE CASCADE was used. This means the related bookings were automatically deleted when the passenger was deleted.

---

## 6. Difference Between WHERE and HAVING

WHERE is used to filter rows before grouping.

Example:
```sql
SELECT *
FROM Flight
WHERE Status = 'Cancelled';

HAVING is used to filter grouped results after GROUP BY.

Example:

SELECT FlightID, COUNT(*) AS TotalBookings
FROM Booking
GROUP BY FlightID
HAVING COUNT(*) > 1;
