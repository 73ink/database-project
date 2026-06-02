-- SkyTrack Airline System DataBase, Task 3


-- Create Database
CREATE DATABASE SkyTrackAirlineDB;


-- Use Database
USE SkyTrackAirlineDB;


-- Table 1: Airport

CREATE TABLE Airport (
    AirportID INT IDENTITY(1,1) PRIMARY KEY,
    IATACode VARCHAR(10) NOT NULL UNIQUE,
    Name VARCHAR(100) NOT NULL,
    City VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL
);

-- Table 2: Aircraft

CREATE TABLE Aircraft (
    AircraftID INT IDENTITY(1,1) PRIMARY KEY,
    RegistrationNumber VARCHAR(50) NOT NULL UNIQUE,
    Model VARCHAR(100) NOT NULL,
    Manufacturer VARCHAR(100) NOT NULL,
    Capacity INT NOT NULL,
    YearOfManufactor INT,

    CONSTRAINT CHK_Aircraft_Capacity 
    CHECK (Capacity > 0)
);


-- Table 3: Passenger

CREATE TABLE Passenger (
    PassengerID INT IDENTITY(1,1) PRIMARY KEY,
    NationalID VARCHAR(50) NOT NULL UNIQUE,
    FullName VARCHAR(150) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Phone VARCHAR(30),
    Nationality VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL
);


-- Table 4: CrewMember

CREATE TABLE CrewMember (
    CrewMemberID INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(150) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    LicenseNumber VARCHAR(50) NOT NULL UNIQUE,

    CONSTRAINT CHK_CrewMember_Role
    CHECK (Role IN ('Pilot', 'Co-Pilot', 'Flight Attendant', 'Engineer'))
);


-- Table 5: Flight

CREATE TABLE Flight (
    FlightID INT IDENTITY(1,1) PRIMARY KEY,
    FlightNumber VARCHAR(20) NOT NULL UNIQUE,
    DepartureDT DATETIME NOT NULL,
    ArrivalDT DATETIME NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Scheduled',

    AircraftID INT NOT NULL,
    OriginAirportID INT NOT NULL,
    DestinationAirportID INT NOT NULL,

    CONSTRAINT CHK_Flight_Status
    CHECK (Status IN ('Scheduled', 'Delayed', 'Cancelled', 'Completed')),

    CONSTRAINT CHK_Flight_Arrival
    CHECK (ArrivalDT > DepartureDT),

    CONSTRAINT FK_Flight_Aircraft
    FOREIGN KEY (AircraftID)
    REFERENCES Aircraft(AircraftID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_Flight_OriginAirport
    FOREIGN KEY (OriginAirportID)
    REFERENCES Airport(AirportID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_Flight_DestinationAirport
    FOREIGN KEY (DestinationAirportID)
    REFERENCES Airport(AirportID)
  --  ON DELETE CASCADE
  --  ON UPDATE CASCADE
);


-- Table 6: Booking

CREATE TABLE Booking (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    PassengerID INT NOT NULL,
    FlightID INT NOT NULL,
    SeatNumber VARCHAR(10) NOT NULL,
    Class VARCHAR(20) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    BookingDate DATE NOT NULL DEFAULT GETDATE(),

    CONSTRAINT CHK_Booking_Class
    CHECK (Class IN ('Economy', 'Business', 'First')),

    CONSTRAINT CHK_Booking_Price
    CHECK (Price > 0),

    CONSTRAINT FK_Booking_Passenger
    FOREIGN KEY (PassengerID)
    REFERENCES Passenger(PassengerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_Booking_Flight
    FOREIGN KEY (FlightID)
    REFERENCES Flight(FlightID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- Table 7: FlightCrew

CREATE TABLE FlightCrew (
    FlightID INT NOT NULL,
    CrewMemberID INT NOT NULL,

    CONSTRAINT PK_FlightCrew
    PRIMARY KEY (FlightID, CrewMemberID),

    CONSTRAINT FK_FlightCrew_Flight
    FOREIGN KEY (FlightID)
    REFERENCES Flight(FlightID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_FlightCrew_CrewMember
    FOREIGN KEY (CrewMemberID)
    REFERENCES CrewMember(CrewMemberID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
