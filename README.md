# 🏨 Hotel Booking SQL Analysis

A practical **MySQL data analysis project** using hotel booking data to answer business-oriented questions with SQL.

The project covers data filtering, aggregation, `GROUP BY`, `HAVING`, joins, subqueries, and analytical calculations using a hotel booking dataset.

---

## 📌 Project Overview

This project analyzes hotel booking data using **MySQL** to identify booking patterns, cancellation behavior, revenue-related metrics, guest information, and lead-time trends.

The project contains **18 SQL questions** ranging from basic filtering to advanced subqueries.

### 🎯 Objectives

* Analyze hotel booking patterns
* Identify canceled bookings
* Analyze booking lead time
* Compare hotel performance
* Calculate cancellation rates
* Analyze ADR
* Identify top countries by bookings
* Analyze market segments
* Practice SQL joins
* Practice subqueries and correlated subqueries

---

## 🛠️ Technologies Used

* **MySQL**
* **MySQL Workbench**
* **SQL**
* **CSV Dataset**

### SQL Concepts Used

* `SELECT`
* `WHERE`
* `GROUP BY`
* `ORDER BY`
* `HAVING`
* Aggregate Functions
* `COUNT()`
* `SUM()`
* `AVG()`
* `MAX()`
* `ROUND()`
* `JOIN`
* Subqueries
* Correlated Subqueries
* `LIMIT`
* `CREATE TABLE`
* `INSERT`
* `DROP TABLE`

---

## 📂 Project Structure

```text
hotel-booking-sql-analysis/
│
├── README.md
├── sql/
│   └── hotel_booking_analysis.sql
│
├── data/
│   └── hotel_bookings_dataset.csv
│
├── screenshots/
│   ├── database.png
│   ├── queries.png
│   └── results.png
│
└── docs/
    └── project_questions.pdf
```

---

## 📊 Dataset

The project uses a hotel booking dataset containing information such as:

* Hotel type
* Cancellation status
* Lead time
* Arrival date
* Number of guests
* Country
* Market segment
* Room type
* Deposit type
* Customer type
* ADR
* Special requests

---

# 🔎 SQL Analysis

## Q1 — Find canceled bookings

```sql
SELECT booking_id
FROM hotel_data
WHERE is_canceled = 1;
```

## Q2 — Find bookings with lead time greater than 300 days

```sql
SELECT booking_id, lead_time
FROM hotel_data
WHERE lead_time > 300;
```

## Q3 — Find distinct countries

```sql
SELECT DISTINCT country
FROM hotel_data;
```

## Q4 — Find bookings where ADR is zero

```sql
SELECT booking_id, adr
FROM hotel_data
WHERE adr = 0;
```

## Q5 — Find bookings with more than 2 children

```sql
SELECT booking_id, children
FROM hotel_data
WHERE children > 2;
```

## Q6 — Total bookings by hotel

```sql
SELECT
    hotel,
    COUNT(booking_id) AS total_bookings
FROM hotel_data
GROUP BY hotel;
```

## Q7 — Cancellation rate by hotel

```sql
SELECT
    hotel,
    ROUND(100.0 * SUM(is_canceled) / COUNT(*), 2) AS cancellation_rate
FROM hotel_data
GROUP BY hotel;
```

## Q8 — Average ADR by hotel

```sql
SELECT
    hotel,
    ROUND(AVG(adr), 2) AS average_adr
FROM hotel_data
GROUP BY hotel;
```

## Q9 — Month with highest bookings

```sql
SELECT
    arrival_date_month,
    COUNT(*) AS total_bookings
FROM hotel_data
GROUP BY arrival_date_month
ORDER BY total_bookings DESC
LIMIT 1;
```

## Q10 — Revenue by market segment

```sql
SELECT
    market_segment,
    ROUND(
        SUM(adr * (stays_in_week_nights + stays_in_weekend_nights)),
        2
    ) AS total_revenue
FROM hotel_data
GROUP BY market_segment
ORDER BY total_revenue DESC;
```

## Q11 — Top 10 countries by bookings

```sql
SELECT
    country,
    COUNT(*) AS total_bookings
FROM hotel_data
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_bookings DESC
LIMIT 10;
```

## Q12 — Market segments with cancellation rate above 30%

```sql
SELECT
    market_segment,
    ROUND(100.0 * SUM(is_canceled) / COUNT(*), 2) AS cancellation_rate
FROM hotel_data
GROUP BY market_segment
HAVING cancellation_rate > 30;
```

## Q13 — Countries with more than 100 bookings and average ADR above 100

```sql
SELECT
    country,
    COUNT(*) AS total_bookings,
    AVG(adr) AS average_adr
FROM hotel_data
WHERE country IS NOT NULL
GROUP BY country
HAVING total_bookings > 100
   AND average_adr > 100;
```

---

# 🔗 Q14 — JOIN Analysis

Additional tables were created for practicing SQL joins:

* `booking`
* `guests`
* `room_type`

```sql
SELECT
    g.G_country,
    r.assigned_room_type
FROM booking b
JOIN guests g
    ON b.booking_id = b.booking_id
JOIN room_type r
    ON r.reserved_room_type = r.reserved_room_type;
```

> **Note:** This section was created as a JOIN practice exercise using the manually created tables.

---

# 👨‍💼 Q15 — Agent with the Most Bookings

The `agents` lookup table was created and joined with the main hotel booking data.

```sql
SELECT
    a.agent_id,
    a.agent_name,
    COUNT(*) AS total_bookings
FROM hotel_data h
JOIN agents a
    ON h.agent = a.agent_id
GROUP BY
    a.agent_id,
    a.agent_name
HAVING COUNT(*) = (
    SELECT MAX(booking_count)
    FROM (
        SELECT
            agent,
            COUNT(*) AS booking_count
        FROM hotel_data
        WHERE agent IS NOT NULL
        GROUP BY agent
    ) AS agent_counts
);
```

---

# 📈 Q16 — Bookings Above Overall Average ADR

```sql
SELECT *
FROM hotel_data
WHERE adr > (
    SELECT AVG(adr)
    FROM hotel_data
);
```

This uses a **subquery** to calculate the overall average ADR and returns bookings whose ADR is higher than that average.

---

# 🏨 Q17 — Lead Time Above Hotel Average

```sql
SELECT
    booking_id,
    hotel,
    lead_time
FROM hotel_data h
WHERE lead_time > (
    SELECT AVG(h2.lead_time)
    FROM hotel_data h2
    WHERE h2.hotel = h.hotel
);
```

This is a **correlated subquery** because the average lead time is calculated separately for each hotel type.

---

# 🌍 Q18 — Country with Highest Average Lead Time

```sql
SELECT
    country,
    AVG(lead_time) AS avg_lead_time
FROM hotel_data
WHERE country IS NOT NULL
GROUP BY country
HAVING AVG(lead_time) = (
    SELECT MAX(avg_lead_time)
    FROM (
        SELECT
            country,
            AVG(lead_time) AS avg_lead_time
        FROM hotel_data
        WHERE country IS NOT NULL
        GROUP BY country
    ) AS country_avg
);
```

This query calculates the average lead time for every country and then uses a subquery to identify the highest average.

---

# 💡 Key SQL Skills Demonstrated

### Beginner

* Data filtering
* Conditional queries
* Sorting
* Limiting results

### Intermediate

* Aggregation
* `GROUP BY`
* `HAVING`
* Business calculations
* Cancellation-rate analysis

### Advanced

* Inner joins
* Nested subqueries
* Correlated subqueries
* Aggregate subqueries
* Analytical SQL

---

# 🎓 What I Learned

Through this project, I practiced converting business questions into SQL queries and learned how to analyze real-world hotel booking data.

The project strengthened my understanding of:

* SQL data analysis
* Aggregation and grouping
* Business metrics
* Relational joins
* Subqueries
* Correlated subqueries
* Data-driven problem solving

---

## 👤 Author

**Anil Kumar**

Aspiring Data Scientist | AI & ML Enthusiast | SQL | Python | Power BI

---

⭐ If you find this project useful, consider giving the repository a star.
