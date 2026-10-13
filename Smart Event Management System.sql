CREATE DATABASE SMARTEVENT;
OUTPUT:
Query OK, 1 row affected (0.133 sec)

USE SMARTEVENT;
OUTPUT:
Database changed

Create the Venues table

CREATE TABLE Venues (
    venue_id INT PRIMARY KEY AUTO_INCREMENT,
    venue_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    capacity INT
);
OUTPUT:
Query OK, 0 rows affected (0.370 sec)

Create the Organizers table

CREATE TABLE Organizers (
    organizer_id INT PRIMARY KEY AUTO_INCREMENT,
    organizer_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100),
    phone_number VARCHAR(20)
);
OUTPUT:
Query OK, 0 rows affected (0.324 sec)

Create the Events table

CREATE TABLE Events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    event_name VARCHAR(100) NOT NULL,
    event_date DATETIME,
    venue_id INT,
    organizer_id INT,
    ticket_price DECIMAL(10,2),
    total_seats INT,
    available_seats INT,
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id),
    FOREIGN KEY (organizer_id) REFERENCES Organizers(organizer_id)
);
OUTPUT:
Query OK, 0 rows affected (0.448 sec)

Create the Attendees table

CREATE TABLE Attendees (
    attendee_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(20)
);
OUTPUT:
Query OK, 0 rows affected (0.285 sec)

Create the Tickets table

CREATE TABLE Tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT,
    attendee_id INT,
    booking_date DATETIME,
    status VARCHAR(20) CHECK (status IN ('Confirmed', 'Cancelled', 'Pending')),
    UNIQUE (event_id, attendee_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id),
    FOREIGN KEY (attendee_id) REFERENCES Attendees(attendee_id)
);
OUTPUT:
Query OK, 0 rows affected (0.501 sec)

Create the Payments table

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id INT,
    amount_paid DECIMAL(10,2),
    payment_status VARCHAR(20) CHECK (payment_status IN ('Success', 'Failed', 'Pending')),
    payment_date DATETIME,
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id)
);
OUTPUT:
Query OK, 0 rows affected (0.375 sec)

Insert data into the Venues table

INSERT INTO Venues (venue_name, location, capacity)
VALUES
('Grand Hall', 'New York', 500),
('City Auditorium', 'Chicago', 200),
('Tech Arena', 'San Francisco', 300);
OUTPUT:
Query OK, 3 rows affected (0.133 sec)
Records: 3  Duplicates: 0  Warnings: 0

Insert data into the Organizers table

INSERT INTO Organizers (organizer_name, contact_email, phone_number)
VALUES
('john doe events', 'john@gmail.com', '1234567890'),
('tech summits inc', 'info@techsummit.com', '9876543210'),
('MUSIC VIBES', NULL, '5551234567');
OUTPUT:
Query OK, 3 rows affected (0.120 sec)
Records: 3  Duplicates: 0  Warnings: 0

Insert data into the Events table

INSERT INTO Events
(event_name, event_date, venue_id, organizer_id,
 ticket_price, total_seats, available_seats)
VALUES
('Tech Conference 2026', '2026-12-15 10:00:00', 3, 2, 150.00, 100, 40),
('Music Fest', '2026-08-20 18:00:00', 1, 3, 50.00, 500, 80),
('Art Exhibition', '2026-12-10 09:00:00', 2, 1, 20.00, 200, 150),
('Coding Bootcamp', '2026-06-10 11:00:00', 3, 2, 0.00, 50, 5);
OUTPUT:
Query OK, 4 rows affected (0.067 sec)
Records: 4  Duplicates: 0  Warnings: 0

Insert data into the Attendees table

INSERT INTO Attendees (name, email, phone_number)
VALUES
('Alice Smith', 'alice@yahoo.com', '1112223334'),
('  Bob Jones  ', 'bob@gmail.com', '2223334445'),
('Charlie Brown', NULL, '3334445556'),
('Diana Prince', 'diana@amazon.com', '4445556667');
OUTPUT:
Query OK, 4 rows affected (0.124 sec)
Records: 4  Duplicates: 0  Warnings: 0

Insert data into the Tickets table

INSERT INTO Tickets (event_id, attendee_id, booking_date, status)
VALUES
(1, 1, '2026-10-01 12:00:00', 'Confirmed'),
(2, 2, '2026-10-05 14:30:00', 'Pending'),
(3, 3, '2026-10-08 09:15:00', 'Confirmed'),
(1, 2, '2026-10-09 16:00:00', 'Confirmed');
OUTPUT:
Query OK, 4 rows affected (0.127 sec)
Records: 4  Duplicates: 0  Warnings: 0

Insert data into the Payments table

INSERT INTO Payments
(ticket_id, amount_paid, payment_status, payment_date)
VALUES
(1, 150.00, 'Success', '2026-10-01 12:05:00'),
(2, 50.00, 'Pending', '2026-10-05 14:35:00'),
(3, 20.00, 'Success', '2026-10-08 09:20:00');
OUTPUT:
Query OK, 3 rows affected (0.130 sec)
Records: 3  Duplicates: 0  Warnings: 0

Display all events

SELECT * FROM Events;
OUTPUT:
+----------+----------------------+---------------------+----------+--------------+--------------+-------------+-----------------+
| event_id | event_name           | event_date          | venue_id | organizer_id | ticket_price | total_seats | available_seats |
+----------+----------------------+---------------------+----------+--------------+--------------+-------------+-----------------+
|        1 | Tech Conference 2026 | 2026-12-15 10:00:00 |        3 |            2 |       150.00 |         100 |              40 |
|        2 | Music Fest           | 2026-08-20 18:00:00 |        1 |            3 |        50.00 |         500 |              80 |
|        3 | Art Exhibition       | 2026-12-10 09:00:00 |        2 |            1 |        20.00 |         200 |             150 |
|        4 | Coding Bootcamp      | 2026-06-10 11:00:00 |        3 |            2 |         0.00 |          50 |               5 |
+----------+----------------------+---------------------+----------+--------------+--------------+-------------+-----------------+
4 rows in set (0.010 sec)

Update Events ticket Price 

UPDATE Events
SET ticket_price = 160.00
WHERE event_id = 1;
OUTPUT:
Query OK, 1 row affected (0.116 sec)
Rows matched: 1  Changed: 1  Warnings: 0

Delete cancelled tickets

DELETE FROM Tickets
WHERE status = 'Cancelled';
OUTPUT:
Query OK, 0 rows affected (0.009 sec)

Search for events by name

SELECT *
FROM Events
WHERE event_name LIKE '%Tech%';
OUTPUT:
+----------+----------------------+---------------------+----------+--------------+--------------+-------------+-----------------+
| event_id | event_name           | event_date          | venue_id | organizer_id | ticket_price | total_seats | available_seats |
+----------+----------------------+---------------------+----------+--------------+--------------+-------------+-----------------+
|        1 | Tech Conference 2026 | 2026-12-15 10:00:00 |        3 |            2 |       160.00 |         100 |              40 |
+----------+----------------------+---------------------+----------+--------------+--------------+-------------+-----------------+
1 row in set (0.084 sec)

Find upcoming events in New York

SELECT e.*
FROM Events e
JOIN Venues v
ON e.venue_id = v.venue_id
WHERE v.location = 'New York'
AND e.event_date > NOW();
OUTPUT:
Empty set (0.091 sec)

Find the top 5 highest-revenue events

SELECT e.event_name,
       SUM(p.amount_paid) AS total_revenue
FROM Events e
JOIN Tickets t
ON e.event_id = t.event_id
JOIN Payments p
ON t.ticket_id = p.ticket_id
GROUP BY e.event_id, e.event_name
ORDER BY total_revenue DESC
LIMIT 5;
OUTPUT:
+----------------------+---------------+
| event_name           | total_revenue |
+----------------------+---------------+
| Tech Conference 2026 |        150.00 |
| Music Fest           |         50.00 |
| Art Exhibition       |         20.00 |
+----------------------+---------------+
3 rows in set (0.106 sec)

Find attendees who booked tickets in the last 7 days

SELECT DISTINCT a.*
FROM Attendees a
JOIN Tickets t
ON a.attendee_id = t.attendee_id
WHERE t.booking_date >= NOW() - INTERVAL 7 DAY;
OUTPUT:
+-------------+---------------+---------------+--------------+
| attendee_id | name          | email         | phone_number |
+-------------+---------------+---------------+--------------+
|           3 | Charlie Brown | NULL          | 3334445556   |
|           2 |   Bob Jones   | bob@gmail.com | 2223334445   |
+-------------+---------------+---------------+--------------+
2 rows in set (0.106 sec)

Find December events with more than 50% seats available

SELECT *
FROM Events
WHERE MONTH(event_date) = 12
AND available_seats > (total_seats * 0.5);
OUTPUT:
+----------+----------------+---------------------+----------+--------------+--------------+-------------+-----------------+
| event_id | event_name     | event_date          | venue_id | organizer_id | ticket_price | total_seats | available_seats |
+----------+----------------+---------------------+----------+--------------+--------------+-------------+-----------------+
|        3 | Art Exhibition | 2026-12-10 09:00:00 |        2 |            1 |        20.00 |         200 |             150 |
+----------+----------------+---------------------+----------+--------------+--------------+-------------+-----------------+
1 row in set (0.074 sec)

Find attendees who booked a ticket or have a pending payment

SELECT DISTINCT a.*
FROM Attendees a
LEFT JOIN Tickets t
ON a.attendee_id = t.attendee_id
LEFT JOIN Payments p
ON t.ticket_id = p.ticket_id
WHERE t.ticket_id IS NOT NULL
OR p.payment_status = 'Pending';
OUTPUT:
+-------------+---------------+-----------------+--------------+
| attendee_id | name          | email           | phone_number |
+-------------+---------------+-----------------+--------------+
|           1 | Alice Smith   | alice@yahoo.com | 1112223334   |
|           2 |   Bob Jones   | bob@gmail.com   | 2223334445   |
|           3 | Charlie Brown | NULL            | 3334445556   |
+-------------+---------------+-----------------+--------------+
3 rows in set (0.018 sec)

Find events that are not fully booked

SELECT *
FROM Events
WHERE NOT (available_seats = 0);
OUTPUT:
+----------+----------------------+---------------------+----------+--------------+--------------+-------------+-----------------+
| event_id | event_name           | event_date          | venue_id | organizer_id | ticket_price | total_seats | available_seats |
+----------+----------------------+---------------------+----------+--------------+--------------+-------------+-----------------+
|        1 | Tech Conference 2026 | 2026-12-15 10:00:00 |        3 |            2 |       160.00 |         100 |              40 |
|        2 | Music Fest           | 2026-08-20 18:00:00 |        1 |            3 |        50.00 |         500 |              80 |
|        3 | Art Exhibition       | 2026-12-10 09:00:00 |        2 |            1 |        20.00 |         200 |             150 |
|        4 | Coding Bootcamp      | 2026-06-10 11:00:00 |        3 |            2 |         0.00 |          50 |               5 |
+----------+----------------------+---------------------+----------+--------------+--------------+-------------+-----------------+
4 rows in set (0.011 sec)

Sort events by date

SELECT *
FROM Events
ORDER BY event_date ASC;
OUTPUT:
+----------+----------------------+---------------------+----------+--------------+--------------+-------------+-----------------+
| event_id | event_name           | event_date          | venue_id | organizer_id | ticket_price | total_seats | available_seats |
+----------+----------------------+---------------------+----------+--------------+--------------+-------------+-----------------+
|        4 | Coding Bootcamp      | 2026-06-10 11:00:00 |        3 |            2 |         0.00 |          50 |               5 |
|        2 | Music Fest           | 2026-08-20 18:00:00 |        1 |            3 |        50.00 |         500 |              80 |
|        3 | Art Exhibition       | 2026-12-10 09:00:00 |        2 |            1 |        20.00 |         200 |             150 |
|        1 | Tech Conference 2026 | 2026-12-15 10:00:00 |        3 |            2 |       160.00 |         100 |              40 |
+----------+----------------------+---------------------+----------+--------------+--------------+-------------+-----------------+
4 rows in set (0.013 sec)

Count attendees for each event

SELECT event_id,
       COUNT(attendee_id) AS attendee_count
FROM Tickets
GROUP BY event_id;
OUTPUT:
+----------+----------------+
| event_id | attendee_count |
+----------+----------------+
|        1 |              2 |
|        2 |              1 |
|        3 |              1 |
+----------+----------------+
3 rows in set (0.085 sec)

Calculate total revenue for each event

SELECT e.event_name,
       SUM(p.amount_paid) AS total_revenue
FROM Events e
JOIN Tickets t
ON e.event_id = t.event_id
JOIN Payments p
ON t.ticket_id = p.ticket_id
GROUP BY e.event_id, e.event_name;
OUTPUT:
+----------------------+---------------+
| event_name           | total_revenue |
+----------------------+---------------+
| Tech Conference 2026 |        150.00 |
| Music Fest           |         50.00 |
| Art Exhibition       |         20.00 |
+----------------------+---------------+
3 rows in set (0.012 sec)

Calculate total revenue from all events

SELECT SUM(amount_paid) AS grand_total_revenue
FROM Payments;
OUTPUT:
+---------------------+
| grand_total_revenue |
+---------------------+
|              220.00 |
+---------------------+
1 row in set (0.013 sec)

Find the event with the highest number of attendees

SELECT e.event_name,
       COUNT(t.attendee_id) AS total_attendees
FROM Events e
JOIN Tickets t
ON e.event_id = t.event_id
GROUP BY e.event_id, e.event_name
ORDER BY total_attendees DESC
LIMIT 1;
OUTPUT:
+----------------------+-----------------+
| event_name           | total_attendees |
+----------------------+-----------------+
| Tech Conference 2026 |               2 |
+----------------------+-----------------+
1 row in set (0.013 sec)

Calculate the average ticket price

SELECT AVG(ticket_price) AS average_ticket_price
FROM Events;
OUTPUT:
+----------------------+
| average_ticket_price |
+----------------------+
|            57.500000 |
+----------------------+
1 row in set (0.012 sec)

Check primary and foreign key relationships

SHOW CREATE TABLE Events;
OUTPUT:
Events | CREATE TABLE `events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(100) NOT NULL,
  `event_date` datetime DEFAULT NULL,
  `venue_id` int DEFAULT NULL,
  `organizer_id` int DEFAULT NULL,
  `ticket_price` decimal(10,2) DEFAULT NULL,
  `total_seats` int DEFAULT NULL,
  `available_seats` int DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `venue_id` (`venue_id`),
  KEY `organizer_id` (`organizer_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  CONSTRAINT `events_ibfk_2` FOREIGN KEY (`organizer_id`) REFERENCES `organizers` (`organizer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+--------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.016 sec)

Display event details with venue information using INNER JOIN

SELECT e.event_name,
       e.event_date,
       v.venue_name,
       v.location,
       v.capacity
FROM Events e
INNER JOIN Venues v
ON e.venue_id = v.venue_id;
OUTPUT:
+----------------------+---------------------+-----------------+---------------+----------+
| event_name           | event_date          | venue_name      | location      | capacity |
+----------------------+---------------------+-----------------+---------------+----------+
| Music Fest           | 2026-08-20 18:00:00 | Grand Hall      | New York      |      500 |
| Art Exhibition       | 2026-12-10 09:00:00 | City Auditorium | Chicago       |      200 |
| Tech Conference 2026 | 2026-12-15 10:00:00 | Tech Arena      | San Francisco |      300 |
| Coding Bootcamp      | 2026-06-10 11:00:00 | Tech Arena      | San Francisco |      300 |
+----------------------+---------------------+-----------------+---------------+----------+
4 rows in set (0.013 sec)

Find attendees who have not completed payment using LEFT JOIN

SELECT a.name,
       t.ticket_id,
       p.payment_status
FROM Attendees a
JOIN Tickets t
ON a.attendee_id = t.attendee_id
LEFT JOIN Payments p
ON t.ticket_id = p.ticket_id
WHERE p.payment_id IS NULL
OR p.payment_status != 'Success';
OUTPUT:
+---------------+-----------+----------------+
| name          | ticket_id | payment_status |
+---------------+-----------+----------------+
|   Bob Jones   |         2 | Pending        |
|   Bob Jones   |         4 | NULL           |
+---------------+-----------+----------------+
2 rows in set (0.033 sec)

Find events without any attendees using RIGHT JOIN

SELECT e.event_id,
       e.event_name
FROM Tickets t
RIGHT JOIN Events e
ON t.event_id = e.event_id
WHERE t.ticket_id IS NULL;
OUTPUT:
+----------+-----------------+
| event_id | event_name      |
+----------+-----------------+
|        4 | Coding Bootcamp |
+----------+-----------------+
1 row in set (0.014 sec)

Find attendees who have not booked any tickets

SELECT a.*
FROM Attendees a
LEFT JOIN Tickets t
ON a.attendee_id = t.attendee_id
WHERE t.ticket_id IS NULL
UNION
SELECT a.*
FROM Attendees a
RIGHT JOIN Tickets t
ON a.attendee_id = t.attendee_id
WHERE a.attendee_id IS NULL;
OUTPUT:
+-------------+--------------+------------------+--------------+
| attendee_id | name         | email            | phone_number |
+-------------+--------------+------------------+--------------+
|           4 | Diana Prince | diana@amazon.com | 4445556667   |
+-------------+--------------+------------------+--------------+
1 row in set (0.029 sec)

Find events with revenue above the average event revenue

SELECT e.event_name,
       SUM(p.amount_paid) AS event_revenue
FROM Events e
JOIN Tickets t
ON e.event_id = t.event_id
JOIN Payments p
ON t.ticket_id = p.ticket_id
GROUP BY e.event_id, e.event_name
HAVING SUM(p.amount_paid) > (
    SELECT AVG(total_revenue)
    FROM (
        SELECT SUM(p2.amount_paid) AS total_revenue
        FROM Events e2
        JOIN Tickets t2
        ON e2.event_id = t2.event_id
        JOIN Payments p2
        ON t2.ticket_id = p2.ticket_id
        GROUP BY e2.event_id
    ) AS event_totals
);
OUTPUT:
+----------------------+---------------+
| event_name           | event_revenue |
+----------------------+---------------+
| Tech Conference 2026 |        150.00 |
+----------------------+---------------+
1 row in set (0.051 sec)

Find attendees who booked multiple events

SELECT attendee_id
FROM Tickets
GROUP BY attendee_id
HAVING COUNT(DISTINCT event_id) > 1;
OUTPUT:
+-------------+
| attendee_id |
+-------------+
|           2 |
+-------------+
1 row in set (0.089 sec)

Find organizers who have managed more than 3 events

SELECT organizer_id,
       COUNT(event_id) AS total_events
FROM Events
GROUP BY organizer_id
HAVING COUNT(event_id) > 3;
OUTPUT:
Empty set (0.013 sec)

Extract the month from each event date

SELECT event_name,
       event_date,
       MONTH(event_date) AS event_month
FROM Events;
OUTPUT:
+----------------------+---------------------+-------------+
| event_name           | event_date          | event_month |
+----------------------+---------------------+-------------+
| Tech Conference 2026 | 2026-12-15 10:00:00 |          12 |
| Music Fest           | 2026-08-20 18:00:00 |           8 |
| Art Exhibition       | 2026-12-10 09:00:00 |          12 |
| Coding Bootcamp      | 2026-06-10 11:00:00 |           6 |
+----------------------+---------------------+-------------+
4 rows in set (0.011 sec)

Find the days remaining until each upcoming event

SELECT event_name,
       event_date,
       DATEDIFF(event_date, CURDATE()) AS days_remaining
FROM Events
WHERE event_date >= CURDATE()
ORDER BY event_date;
OUTPUT:
+----------------------+---------------------+----------------+
| event_name           | event_date          | days_remaining |
+----------------------+---------------------+----------------+
| Art Exhibition       | 2026-12-10 09:00:00 |             58 |
| Tech Conference 2026 | 2026-12-15 10:00:00 |             63 |
+----------------------+---------------------+----------------+
2 rows in set (0.088 sec)

Display payment dates in a readable format

SELECT payment_id,
       amount_paid,
       payment_status,
       DATE_FORMAT(payment_date, '%d-%m-%Y') AS formatted_date
FROM Payments;
OUTPUT:
+------------+-------------+----------------+----------------+
| payment_id | amount_paid | payment_status | formatted_date |
+------------+-------------+----------------+----------------+
|          1 |      150.00 | Success        | 01-10-2026     |
|          2 |       50.00 | Pending        | 05-10-2026     |
|          3 |       20.00 | Success        | 08-10-2026     |
+------------+-------------+----------------+----------------+
3 rows in set (0.090 sec)

Display organizer names in uppercase

SELECT organizer_id,
       UPPER(organizer_name) AS organizer_name
FROM Organizers;
OUTPUT:
+--------------+------------------+
| organizer_id | organizer_name   |
+--------------+------------------+
|            1 | JOHN DOE EVENTS  |
|            2 | TECH SUMMITS INC |
|            3 | MUSIC VIBES      |
+--------------+------------------+
3 rows in set (0.088 sec)

Remove extra spaces from attendee names

SELECT attendee_id,
       TRIM(name) AS attendee_name
FROM Attendees;
OUTPUT:
+-------------+---------------+
| attendee_id | attendee_name |
+-------------+---------------+
|           1 | Alice Smith   |
|           2 | Bob Jones     |
|           3 | Charlie Brown |
|           4 | Diana Prince  |
+-------------+---------------+
4 rows in set (0.092 sec)

Display a message when attenndees mail is missing

SELECT attendee_id,
       name,
       IFNULL(email, 'Not Provided') AS email
FROM Attendees;
OUTPUT:
+-------------+---------------+------------------+
| attendee_id | name          | email            |
+-------------+---------------+------------------+
|           1 | Alice Smith   | alice@yahoo.com  |
|           2 |   Bob Jones   | bob@gmail.com    |
|           3 | Charlie Brown | Not Provided     |
|           4 | Diana Prince  | diana@amazon.com |
+-------------+---------------+------------------+
4 rows in set (0.014 sec)

Rank events based on their total revenue

SELECT e.event_name,
       SUM(p.amount_paid) AS total_revenue,
       RANK() OVER (ORDER BY SUM(p.amount_paid) DESC) AS revenue_rank
FROM Events e
JOIN Tickets t ON e.event_id = t.event_id
JOIN Payments p ON t.ticket_id = p.ticket_id
GROUP BY e.event_id, e.event_name;
OUTPUT:
+----------------------+---------------+--------------+
| event_name           | total_revenue | revenue_rank |
+----------------------+---------------+--------------+
| Tech Conference 2026 |        150.00 |            1 |
| Music Fest           |         50.00 |            2 |
| Art Exhibition       |         20.00 |            3 |
+----------------------+---------------+--------------+
3 rows in set (0.103 sec)

Calculate cumulative revenue from payments

SELECT payment_id,
       amount_paid,
       SUM(amount_paid) OVER (ORDER BY payment_id) AS cumulative_revenue
FROM Payments;
OUTPUT:
+------------+-------------+--------------------+
| payment_id | amount_paid | cumulative_revenue |
+------------+-------------+--------------------+
|          1 |      150.00 |             150.00 |
|          2 |       50.00 |             200.00 |
|          3 |       20.00 |             220.00 |
+------------+-------------+--------------------+
3 rows in set (0.108 sec)

Calculate the running total of attendees for each event

SELECT event_id,
       attendee_id,
       ticket_id,
       COUNT(*) OVER (
           PARTITION BY event_id
           ORDER BY ticket_id
       ) AS running_attendee_total
FROM Tickets;
OUTPUT:
+----------+-------------+-----------+------------------------+
| event_id | attendee_id | ticket_id | running_attendee_total |
+----------+-------------+-----------+------------------------+
|        1 |           1 |         1 |                      1 |
|        1 |           2 |         4 |                      2 |
|        2 |           2 |         2 |                      1 |
|        3 |           3 |         3 |                      1 |
+----------+-------------+-----------+------------------------+
4 rows in set (0.013 sec)

Categorize events based on ticket demand

SELECT event_name,
       total_seats,
       available_seats,
       CASE
           WHEN available_seats <= total_seats * 0.10 THEN 'High Demand'
           WHEN available_seats <= total_seats * 0.50 THEN 'Medium Demand'
           ELSE 'Low Demand'
       END AS ticket_demand
FROM Events;
OUTPUT:
+----------------------+-------------+-----------------+---------------+
| event_name           | total_seats | available_seats | ticket_demand |
+----------------------+-------------+-----------------+---------------+
| Tech Conference 2026 |         100 |              40 | Medium Demand |
| Music Fest           |         500 |              80 | Medium Demand |
| Art Exhibition       |         200 |             150 | Low Demand    |
| Coding Bootcamp      |          50 |               5 | High Demand   |
+----------------------+-------------+-----------------+---------------+
4 rows in set (0.094 sec)

Display a readable message for each payment status

SELECT payment_id,
       amount_paid,
       payment_status,
       CASE
           WHEN payment_status = 'Success' THEN 'Payment Completed'
           WHEN payment_status = 'Failed' THEN 'Payment Failed'
           WHEN payment_status = 'Pending' THEN 'Waiting for Payment'
           ELSE 'Unknown Status'
       END AS payment_message
FROM Payments;
OUTPUT:
+------------+-------------+----------------+---------------------+
| payment_id | amount_paid | payment_status | payment_message     |
+------------+-------------+----------------+---------------------+
|          1 |      150.00 | Success        | Payment Completed   |
|          2 |       50.00 | Pending        | Waiting for Payment |
|          3 |       20.00 | Success        | Payment Completed   |
+------------+-------------+----------------+---------------------+
3 rows in set (0.011 sec)

Display events with their organizer names

SELECT e.event_name,
       o.organizer_name,
       e.event_date
FROM Events e
JOIN Organizers o
ON e.organizer_id = o.organizer_id;
OUTPUT:
+----------------------+------------------+---------------------+
| event_name           | organizer_name   | event_date          |
+----------------------+------------------+---------------------+
| Art Exhibition       | john doe events  | 2026-12-10 09:00:00 |
| Tech Conference 2026 | tech summits inc | 2026-12-15 10:00:00 |
| Coding Bootcamp      | tech summits inc | 2026-06-10 11:00:00 |
| Music Fest           | MUSIC VIBES      | 2026-08-20 18:00:00 |
+----------------------+------------------+---------------------+
4 rows in set (0.013 sec)

Count the total number of venues

SELECT COUNT(*) AS total_venues
FROM Venues;
OUTPUT:
+--------------+
| total_venues |
+--------------+
|            3 |
+--------------+
1 row in set (0.084 sec)

Display all tables in your Smart Event Management System database

SHOW TABLES;
OUTPUT:
+----------------------+
| Tables_in_smartevent |
+----------------------+
| attendees            |
| events               |
| organizers           |
| payments             |
| tickets              |
| venues               |
+----------------------+
6 rows in set (0.239 sec)
