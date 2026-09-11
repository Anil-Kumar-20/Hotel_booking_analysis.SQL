show databases;
create database hotel;
use hotel;
select * from hotel_data;

-- Q-1
select booking_id from hotel_data where is_canceled = 1;

-- Q-2
select booking_id,lead_time from hotel_data where lead_time > 300;

-- Q-3
select country from hotel_data;

-- Q-4
select booking_id,adr from hotel_data where adr=0;

-- Q-5
select booking_id,children from hotel_data where children > 2;

-- Q-6
select hotel,count(booking_id) from hotel_data group by hotel;

-- Q-7
select hotel,round(100.0*sum(is_canceled)/count(*),2) as cancellation_rate from hotel_data group by hotel;

-- Q-8
select hotel,round(avg(adr),2)from hotel_data group by hotel;

-- Q-9
select max(arrival_date_month) from hotel_data;

-- Q-10
select market_segment,adr*(stays_in_week_nights + stays_in_weekend_nights)  as revenue from hotel_data;

-- Q-11
select country,count(*)as total_booking from hotel_data where country is not null group by country order by total_booking desc limit 10;

-- Q-12
select market_segment,round(100.0*sum(is_canceled)/count(*),2)as cancellation_rate from hotel_data group by market_segment having cancellation_rate > 30;

-- Q-13
select country,count(*)as total_bookings,avg(adr) from hotel_data group by country having total_bookings > 100 and avg(adr) > 100;

-- Q-14
create table booking(booking_id varchar(20),name varchar(20));
insert into booking values('BK100000', 'anil'),
						   ('BK100001','kumar'),
                           ('BK100002','kasi'),
                           ('BK100003','mahi'),
                           ('BK100004','rohit');
                           
create table guests(G_id int,G_country varchar(20));
insert into guests values('1', 'BEL'),
						   ('2','PRT'),
                           ('3','FAR'),
                           ('4','POL'),
                           ('5','DEU');

create table room_type(reserved_room_type char(1),assigned_room_type char(1));
insert into room_type values('F', 'F'),
						   ('A','A'),
                           ('A','G'),
                           ('B','D'),
                           ('E','E');
                           
select g.G_country,r.assigned_room_type from booking b join guests g on G_id = g.G_id join room_type r on reserved_room_type = r.reserved_room_type;

DROP TABLE bookings;
-- Q-15
CREATE TABLE agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(100)
);
select * from agents;

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

-- Q-16
SELECT *
FROM hotel_data
WHERE adr > (
    SELECT AVG(adr)
    FROM hotel_data
);

-- Q-17
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

-- Q-18
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