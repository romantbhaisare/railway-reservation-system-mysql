-- Drop and recreate the database
DROP DATABASE IF EXISTS reservation_system;
CREATE DATABASE reservation_system;
USE reservation_system;


CREATE TABLE stations (
    station_id INT PRIMARY KEY,
    station_name VARCHAR(50) 
);


CREATE TABLE trains (
    train_no INT PRIMARY KEY,
    train_name VARCHAR(50),
    from_station_id INT,
    to_station_id INT,
    FOREIGN KEY (from_station_id) REFERENCES stations(station_id),
    FOREIGN KEY (to_station_id) REFERENCES stations(station_id)
);


CREATE TABLE trains_schedule (
    train_no INT,
    station_id INT,
    arrival_time TIME, 
    departure_time TIME,
    date DATE, 
    PRIMARY KEY (train_no, station_id, date),
    FOREIGN KEY (train_no) REFERENCES trains(train_no),
    FOREIGN KEY (station_id) REFERENCES stations(station_id)
);


CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY,
    passenger_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    is_student BOOLEAN,
    is_senior_citizen BOOLEAN,
    student_id VARCHAR(50)
);


CREATE TABLE bookings (
    prn_number INT PRIMARY KEY,
    passenger_id INT,
    train_no INT,
    coach_type VARCHAR(20),
    quota VARCHAR(20),
    booking_date DATE,
    journey_date DATE,
    from_station_id INT,
    to_station_id INT,
    seat_no varchar(20),
    is_confirmed boolean,
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (train_no) REFERENCES trains(train_no),
    FOREIGN KEY (from_station_id) REFERENCES stations(station_id),
    FOREIGN KEY (to_station_id) REFERENCES stations(station_id)
);


CREATE TABLE coach (
    train_no INT,
    coach_type VARCHAR(20),
    total_seats INT,
    available_seats INT,
    PRIMARY KEY (train_no, coach_type),
    FOREIGN KEY (train_no) REFERENCES trains(train_no)
);


CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    prn_number INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_mode VARCHAR(20),
    FOREIGN KEY (prn_number) REFERENCES bookings(prn_number)
);


CREATE TABLE waitlist (
    wl_id INT PRIMARY KEY,
    prn_number INT,
    passenger_id INT,
    train_no INT,
    wl_status VARCHAR(20),  
    FOREIGN KEY (prn_number) REFERENCES bookings(prn_number),
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (train_no) REFERENCES trains(train_no)
);


CREATE TABLE cancellations (
    cancel_id INT PRIMARY KEY,
    prn_number INT,
    cancel_date DATE,
    refund_amount DECIMAL(10,2),
    FOREIGN KEY (prn_number) REFERENCES bookings(prn_number)
);


INSERT INTO stations (station_id, station_name) VALUES
(1, 'Mumbai'),
(2, 'Pune'),
(3, 'Nashik'),
(4, 'Nagpur'),
(5, 'Gondia'),
(6, 'Kolhapur'),
(7, 'Delhi'),
(8, 'Chennai'),
(9, 'Hyderabad'),
(10, 'Bengaluru'),
(11, 'Jaipur'),
(12, 'Bhopal');


INSERT INTO trains (train_no, train_name, from_station_id, to_station_id) VALUES
(11023, 'Deccan Exp', 1, 2),
(12101, 'Vidharba Exp', 3, 4),
(11029, 'Shalimar Exp', 1, 4),
(11039, 'Maharashtra Exp', 6, 5),
(11213, 'Pune-Garib Rath', 4, 2),
(12121, 'Ngp-Vande Bharat', 2, 4),
(12245, 'Duronto Exp', 7, 8),
(12627, 'Karnataka Exp', 10, 7),
(12723, 'Hyderabad Exp', 9, 1),
(22917, 'Bhopal Shatabdi', 12, 7),
(12951, 'Mumbai Rajdhani', 1, 7);


INSERT INTO trains_schedule (train_no, station_id, arrival_time, departure_time, date) VALUES
(11023, 1, '10:00:00', '10:05:00', '2025-04-23'),
(12101, 3, '12:12:00', '12:17:00', '2025-05-15'),
(11029, 4, '11:00:00', '11:20:00', '2025-06-30'),
(11039, 6, '02:00:00', '13:20:00', '2025-08-16'),
(12245, 7, '05:00:00', '05:15:00', '2025-09-01'),
(12627, 10, '06:30:00', '06:45:00', '2025-09-02'),
(12723, 9, '08:10:00', '08:25:00', '2025-09-03'),
(22917, 12, '07:00:00', '07:20:00', '2025-09-04'),
(12951, 1, '16:00:00', '16:20:00', '2025-09-05');


INSERT INTO passengers(passenger_id, passenger_name, age, gender, is_student, is_senior_citizen, student_id) VALUES
(786,'Romant Bhaisare', 20, 'Male', TRUE, FALSE,'S40374'),
(213,'J archer', 30, 'Male', FALSE, FALSE, NULL),
(143, 'R reacher', 45, 'Male', FALSE, FALSE, NULL),
(201, 'Raju B', 19, 'Male', TRUE, FALSE, 'S50987'),
(202, 'Sneha P', 22, 'Female', TRUE, FALSE, 'S60123'),
(203, 'Rani S', 65, 'Female', FALSE, TRUE, NULL),
(204, 'Sham D', 72, 'Male', FALSE, TRUE, NULL),
(205, 'Vikas J', 34, 'Male', FALSE, FALSE, NULL),
(501, 'Yash G', 22, 'Male', TRUE, FALSE, 'STU501'),
(502, 'Priyanka V', 28, 'Female', FALSE, FALSE, NULL),
(503, 'Rohit M', 65, 'Male', FALSE, TRUE, NULL),
(504, 'Arpita B', 19, 'Female', TRUE, FALSE, 'STU504'),
(505, 'Shreyash D', 40, 'Male', FALSE, FALSE, NULL);


INSERT INTO bookings (prn_number, passenger_id, train_no, coach_type, quota, booking_date, journey_date, from_station_id, to_station_id, seat_no, is_confirmed) VALUES
(121, 786, 11023, 'Sleeper', 'General', '2025-04-29', '2025-05-10', 1, 2, 'S-10', TRUE),
(131, 213, 11029, 'AC 3-tier', 'Tatkal', '2025-04-10', '2025-06-09', 1, 2, 'B-23', FALSE),
(141, 143, 12101, 'AC 2-tier', 'Ladies', '2025-06-05', '2025-06-09', 1, 2, 'B-54', TRUE),
(151, 201, 12245, 'Sleeper', 'Student', '2025-08-15', '2025-09-01', 7, 8, 'S-12', TRUE),
(152, 202, 22917, 'AC 3-tier', 'Student', '2025-08-20', '2025-09-04', 12, 7, 'B-32', TRUE),
(153, 203, 12627, 'AC 2-tier', 'SeniorCitizen', '2025-08-22', '2025-09-02', 10, 7, 'A-14', TRUE),
(154, 204, 12951, 'AC 1st Class', 'SeniorCitizen', '2025-08-25', '2025-09-05', 1, 7, 'H-01', TRUE),
(155, 205, 12723, 'Sleeper', 'General', '2025-08-26', '2025-09-03', 9, 1, 'S-44', FALSE),
(156, 501, 11023, 'Sleeper', 'General', '2025-07-01', '2025-07-10', 1, 2, NULL, FALSE), 
(157, 502, 12101, 'AC 3-tier', 'Tatkal', '2025-07-02', '2025-07-11', 3, 4, NULL, FALSE), 
(158, 503, 11039, 'AC 2-tier', 'SeniorCitizen', '2025-07-03', '2025-07-12', 6, 5, 'B-12', TRUE), 
(159, 504, 11213, 'Sleeper', 'Student', '2025-07-04', '2025-07-13', 4, 2, NULL, FALSE),
(160, 505, 11029, 'AC 3-tier', 'General', '2025-07-05', '2025-07-14', 1, 4, 'C-22', TRUE);


INSERT INTO coach(train_no, coach_type, total_seats, available_seats) VALUES
(11029,'Sleeper', 85, 50),
(11023,'AC 3-tier', 70, 49),
(12101,'AC 2-tier', 70, 55),
(12245,'Sleeper', 90, 65),
(22917,'AC 3-tier', 72, 55),
(12627,'AC 2-tier', 60, 45),
(12951,'AC 1st Class', 40, 10),
(12723,'Sleeper', 85, 60);


INSERT INTO payments(payment_id, prn_number, amount, payment_date, payment_mode) VALUES
(102345, 121, 890.55, '2025-04-29', 'Credit-Card'),
(202345, 131, 1449.80, '2025-04-10', 'UPI'),
(302345, 141, 2549.00, '2025-06-05', 'UPI'),
(402345, 151, 450.00, '2025-08-15', 'UPI'),
(502345, 152, 1350.50, '2025-08-20', 'Debit-Card'),
(602345, 153, 2200.00, '2025-08-22', 'Credit-Card'),
(702345, 154, 3500.75, '2025-08-25', 'Net-Banking'),
(802345, 155, 500.00, '2025-08-26', 'UPI');


INSERT INTO waitlist (wl_id, prn_number, passenger_id, train_no, wl_status) VALUES
(9005, 151, 501, 11023, 'Waiting'),   
(9006, 152, 502, 12101, 'Confirm'),   
(9007, 154, 504, 11213, 'Waiting');   


INSERT INTO cancellations (cancel_id, prn_number, cancel_date, refund_amount) VALUES
(5001, 131, '2025-05-05', 1200.00),   
(5002, 141, '2025-06-07', 2000.00),  
(5003, 121, '2025-05-08', 800.00);  


SELECT train_no, coach_type, total_seats, available_seats 
FROM coach
ORDER BY available_seats DESC;

SELECT t.train_name, SUM(pay.amount) AS total_revenue
FROM payments pay
JOIN bookings b ON pay.prn_number = b.prn_number
JOIN trains t ON b.train_no = t.train_no
GROUP BY t.train_name;

SELECT passenger_name, age, gender
FROM passengers
WHERE is_senior_citizen = TRUE;

SELECT prn_number, passenger_id, train_no, seat_no
FROM bookings
WHERE is_confirmed = FALSE;

SELECT c.cancel_id, p.passenger_name, c.cancel_date, c.refund_amount
FROM cancellations c
JOIN bookings b ON c.prn_number = b.prn_number
JOIN passengers p ON b.passenger_id = p.passenger_id;
