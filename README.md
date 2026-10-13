[README (4).md](https://github.com/user-attachments/files/33385759/README.4.md)
# 🎟️ Smart Event Management System

A MySQL database project for managing events, venues, organizers, attendees, ticket bookings, and payments.

---

## 📌 Project Overview

The **Smart Event Management System** is a database project developed using **MySQL**. It is designed to manage events, venues, organizers, attendees, ticket bookings, and payments in one organized place.

The database helps to:

- Keep event information well organized
- Track how many seats are still available for each event
- Analyze booking and payment records using SQL queries

I developed this project while learning SQL, to practice designing related tables and writing queries that answer real questions about the data.

---

## 🎯 Project Objectives

- Store and manage event details.
- Maintain venue and organizer information.
- Register attendees and manage ticket bookings.
- Track payment amounts and payment statuses.
- Analyze event revenue and ticket demand.
- Retrieve useful information using SQL queries.

---

## 🛠️ Technologies Used

| Technology | Purpose |
|------------|---------|
| **MySQL** | Relational database management system |
| **SQL** | Creating tables, inserting data, and querying records |
| **MySQL Command Line Client** | Running the SQL statements |

---

## 🗂️ Database Structure

The project contains **six tables**:

| Table Name | Description |
|------------|-------------|
| `Venues` | Stores venue names, locations, and capacities. |
| `Organizers` | Stores organizer details and contact information. |
| `Events` | Stores event dates, prices, seat availability, and related IDs. |
| `Attendees` | Stores attendee names and contact details. |
| `Tickets` | Stores ticket bookings and booking statuses. |
| `Payments` | Stores payment amounts, statuses, and dates. |

### 🔗 Table Relationships

In simple terms, the tables are connected like this:

- One **venue** can host many **events**.
- One **organizer** can organize many **events**.
- One **event** can have many **tickets**.
- One **attendee** can book many **tickets**.
- Each **ticket** can have a **payment** record linked to it.

```text
Venues ──┐
         ├──< Events >──< Tickets >── Attendees
Organizers ┘                 │
                             └──< Payments
```

### 🔑 Keys and Constraints

| Concept | How It Is Used |
|---------|----------------|
| **Primary Key** | Every table has an ID column (such as `venue_id` or `event_id`) that uniquely identifies each row. |
| **Auto-Increment** | ID columns generate their values automatically, so each new record gets a new ID. |
| **Foreign Key** | `Events` refers to `Venues` and `Organizers`. `Tickets` refers to `Events` and `Attendees`. `Payments` refers to `Tickets`. |
| **UNIQUE** | Email addresses in `Organizers` and `Attendees` must not be repeated. |
| **CHECK** | Prevents invalid values, such as zero venue capacity, negative ticket prices, or negative available seats. |

### 📐 Table Definitions

```sql
CREATE TABLE Venues (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    venue_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    capacity INT NOT NULL CHECK (capacity > 0)
);

CREATE TABLE Organizers (
    organizer_id INT AUTO_INCREMENT PRIMARY KEY,
    organizer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

CREATE TABLE Events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL CHECK (ticket_price >= 0),
    available_seats INT NOT NULL CHECK (available_seats >= 0),
    venue_id INT,
    organizer_id INT,
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id),
    FOREIGN KEY (organizer_id) REFERENCES Organizers(organizer_id)
);

CREATE TABLE Attendees (
    attendee_id INT AUTO_INCREMENT PRIMARY KEY,
    attendee_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

CREATE TABLE Tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    attendee_id INT,
    booking_date DATE NOT NULL,
    booking_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (event_id) REFERENCES Events(event_id),
    FOREIGN KEY (attendee_id) REFERENCES Attendees(attendee_id)
);

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    payment_status VARCHAR(20) NOT NULL,
    payment_date DATE,
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id)
);
```

---

## ✨ Key Features

- Database and table creation
- Sample data insertion
- Event search and filtering
- Updating event ticket prices
- Deleting selected ticket records
- Date and time calculations
- Attendee and organizer information retrieval
- Ticket booking counts
- Revenue calculations and ranking
- Payment status analysis
- Event demand classification
- Joins, subqueries, aggregate functions, and window functions

---

## 🧠 SQL Concepts Practiced

- **DDL:** `CREATE`, `ALTER` where applicable, and `DROP`
- **DML:** `INSERT`, `UPDATE`, and `DELETE`
- **DQL:** `SELECT`
- **Filtering:** `WHERE`, `LIKE`, `AND`, `OR`, and `NOT`
- **Sorting and grouping:** `ORDER BY`, `GROUP BY`, and `HAVING`
- **Aggregate functions:** `COUNT()`, `SUM()`, and `AVG()`
- **Joins:** `INNER JOIN`, `LEFT JOIN`, and `RIGHT JOIN`
- **Subqueries**
- **Date and time functions:** `MONTH()`, `DATEDIFF()`, `CURDATE()`, and `DATE_FORMAT()`
- **String functions:** `UPPER()`, `TRIM()`, and `IFNULL()`
- **Window functions:** `RANK()`, `SUM() OVER()`, and `COUNT() OVER()`
- **Conditional expressions:** `CASE`

---

## 🚀 How to Run the Project

1. Install and open **MySQL**.
2. Open **MySQL Command Line Client** or a MySQL editor.
3. Create the database:
   ```sql
   CREATE DATABASE IF NOT EXISTS smart_event_db;
   ```
4. Select the database:
   ```sql
   USE smart_event_db;
   ```
5. Create the six tables in the correct order.
6. Insert the sample data.
7. Execute the analysis queries one by one.
8. Review the results returned by MySQL.

> 💡 **Note:** Tables that are referenced by foreign keys must be created first. A suitable order is: `Venues` → `Organizers` → `Events` → `Attendees` → `Tickets` → `Payments`.

---

## 💻 Example SQL Queries

### 1. Display all events

```sql
SELECT * FROM Events;
```

### 2. Find events with a particular name using `LIKE`

```sql
SELECT event_name, event_date, ticket_price
FROM Events
WHERE event_name LIKE '%Music%';
```

### 3. Display events with venue names using a join

```sql
SELECT e.event_name, e.event_date, v.venue_name, v.location
FROM Events e
INNER JOIN Venues v ON e.venue_id = v.venue_id;
```

### 4. Calculate total payment amounts

```sql
SELECT SUM(amount) AS total_payment_amount
FROM Payments;
```

### 5. Rank events by recorded payment revenue

```sql
SELECT e.event_name,
       SUM(p.amount) AS total_revenue,
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS revenue_rank
FROM Events e
INNER JOIN Tickets t ON e.event_id = t.event_id
INNER JOIN Payments p ON t.ticket_id = p.ticket_id
GROUP BY e.event_id, e.event_name;
```

### 6. Categorize events according to available seats

```sql
SELECT event_name,
       available_seats,
       CASE
           WHEN available_seats < 50  THEN 'High Demand'
           WHEN available_seats < 150 THEN 'Medium Demand'
           ELSE 'Low Demand'
       END AS demand_level
FROM Events;
```

---

## 📊 Sample Results

Running the project's queries can produce results such as:

| Result Type | Description |
|-------------|-------------|
| Total venues | The number of venues stored in the database |
| Bookings per event | The number of ticket bookings recorded for each event |
| Payment totals | The total amount recorded in the `Payments` table |
| Upcoming events | Event dates that are still to come |
| Attendee bookings | Which attendees booked tickets for which events |
| Payment status summary | Counts or totals grouped by payment status |

The exact output depends on the sample data inserted into the tables.

---

## 📁 Project Structure

```text
Smart-Event-Management-System/
│
├── smart_event_management.sql
└── README.md
```

This is the **recommended structure** for the project. The file `smart_event_management.sql` should contain the database creation statements, table definitions, sample records, and project queries.

---

## 🔮 Future Improvements

- Add a stored procedure for ticket booking.
- Automatically update available seats after bookings.
- Prevent bookings when no seats remain.
- Improve payment validation.
- Add triggers for ticket and seat management.
- Build a simple web interface for event registration and booking.

---

## 🎓 Learning Outcomes

This project gave me practical experience in:

- Relational database design
- Creating and managing table relationships
- Data manipulation using `INSERT`, `UPDATE`, and `DELETE`
- Writing SQL queries with joins, subqueries, and window functions
- Revenue analysis and reporting

---

## 👩‍💻 Author

**Lisa Patel**

This project demonstrates my practical SQL and database-management skills, along with my ability to design related tables and turn data into useful information.

⭐ Thank you for taking the time to explore my project! If you found it helpful or interesting, please consider giving this repository a star. Feedback and suggestions are always welcome, and I am happy to keep learning and improving.

---

## 📄 License

MIT License is a suggested option. To use it, add a `LICENSE` file with the MIT License text to the repository.
