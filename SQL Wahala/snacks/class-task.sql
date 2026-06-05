CREATE DATABASE IF NOT EXISTS lagos_rideshare;
USE lagos_rideshare;
CREATE TABLE IF NOT EXISTS Drivers (
    DriverID   INT PRIMARY KEY AUTO_INCREMENT,
    Name       VARCHAR(100)  NOT NULL,
    Rating     DECIMAL(3, 2),
    TotalRides INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS Riders (
    RiderID INT PRIMARY KEY AUTO_INCREMENT,
    Name    VARCHAR(100) NOT NULL,
    City    VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Rides (
    RideID     INT PRIMARY KEY AUTO_INCREMENT,
        DriverID   INT,
    RiderID    INT,
    Fare       DECIMAL(10, 2),
    Rating     DECIMAL(3, 2),
    DistanceKM DECIMAL(6, 2),
    Area       VARCHAR(100),
    RideDate   DATETIME DEFAULT CURRENT_TIMESTAMP,
    Duration   INT COMMENT 'Duration in minutes',
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID),
    FOREIGN KEY (RiderID)  REFERENCES Riders(RiderID)
);

CREATE TABLE IF NOT EXISTS Payments (
    PaymentID     INT PRIMARY KEY AUTO_INCREMENT,
    RideID        INT,
    Amount        DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (RideID) REFERENCES Rides(RideID)
);
INSERT INTO Riders (Name, City) VALUES
('Aisha Bello', 'Lagos'),
('Tunde Yusuf', 'Ikeja'),
('Chioma Nwosu', 'Surulere'),
('Ibrahim Musa', 'Yaba'),
('Kemi Akin', 'Lekki');
INSERT INTO Drivers (DriverID, Name, Rating, TotalRides) VALUES
(1, 'John Doe', 4.5, 120),
(2, 'Jane Smith', 4.2, 90),
(3, 'James Bond', 4.7, 150),
(4, 'Samantha James', 4.3, 80),
(5, 'Michael Brown', 4.0, 60),
(6, 'Nina Williams', 4.6, 200),
(7, 'Chris Johnson', 4.1, 110),
(8, 'Sarah Davis', 4.8, 100),
(9, 'David Lee', 3.9, 70),
(10, 'Emma Green', 4.4, 130),
(11, 'Olumide Adebayo', 4.7, 150),
(12, 'Grace Okafor', 4.3, 140),
(13, 'Julius Adedeji', 4.6, 175),
(14, 'Tolu Olowolagba', 4.2, 105),
(15, 'Fola Akinwunmi', 4.5, 125),
(16, 'Oluwaseun Bello', 4.1, 115),
(17, 'Kayode Ogunleye', 4.8, 180),
(18, 'Chinonso Ifeanyi', 3.8, 85),
(19, 'Oluwafunmilayo Bello', 4.3, 140),
(20, 'Adeola Akin', 4.6, 160);
INSERT INTO Rides (DriverID, RiderID, Fare, Rating, DistanceKM, Area, Duration)
VALUES
(1, 1, 5000, 4.5, 12.5, 'Ikeja', 25),
(2, 2, 8000, 4.0, 20.0, 'Lekki', 40),
(3, 3, 3000, 3.8, 8.0, 'Yaba', 15),
(4, 4, 12000, 4.7, 30.0, 'VI', 60),
(5, 5, 4500, 4.2, 10.0, 'Surulere', 22),
(6, 6, 7000, 4.6, 18.0, 'Ajah', 35),
(7, 7, 6000, 4.1, 14.0, 'Ikoyi', 30),
(8, 8, 15000, 4.8, 35.0, 'Lekki', 70),
(9, 9, 4000, 3.9, 9.0, 'Yaba', 20),
(10, 10, 5500, 4.4, 11.0, 'Surulere', 24);
INSERT INTO Payments (RideID, Amount, PaymentMethod)
VALUES
(1, 5000, 'Card'),
(2, 8000, 'Cash'),
(3, 3000, 'Transfer'),
(4, 12000, 'Card'),
(5, 4500, 'Cash'),
(6, 7000, 'Transfer'),
(7, 6000, 'Card'),
(8, 15000, 'Card'),
(9, 4000, 'Cash'),
(10, 5500, 'Transfer');
SELECT * FROM Drivers
ORDER BY Rating DESC
LIMIT 5;
SELECT SUM(Amount) AS TotalRevenue FROM Payments;
SELECT d.DriverID, d.Name, SUM(p.Amount) AS Revenue
FROM Drivers d
JOIN Rides r ON d.DriverID = r.DriverID
JOIN Payments p ON r.RideID = p.RideID
GROUP BY d.DriverID, d.Name
ORDER BY Revenue DESC
LIMIT 1;
SELECT Area, COUNT(*) AS TotalRides
FROM Rides
GROUP BY Area
ORDER BY TotalRides DESC;
SELECT RideID, DistanceKM, DriverID, RiderID
FROM Rides
ORDER BY DistanceKM DESC
LIMIT 5;
SELECT RideID, Duration, DriverID, RiderIDDriversDriversDrivers
FROM Rides
WHERE Duration > 120;
CREATE TABLE TopDrivers AS
SELECT * FROM Drivers
ORDER BY Rating DESC
LIMIT 5;
