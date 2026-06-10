CREATE DATABASE War_Analysis;

USE War_Analysis;

CREATE TABLE war_events (
    Date DATE,
    Country VARCHAR(50),
    Area VARCHAR(100),
    Event_Type VARCHAR(50),
    Target_Type VARCHAR(50),
    Weather VARCHAR(50),
    Missiles_Launched INT,
    Drones_Launched INT,
    Defense_Interceptions INT,
    Deaths INT,
    Injuries INT,
    Oil_Price FLOAT,
    Gold_Price FLOAT,
    Stock_Index INT,
    Shipping_Index FLOAT,
    Media_Sentiment_score FLOAT,
    Total_Attacks INT,
    Total_Casualties INT,
    Attack_Success_Rate FLOAT,
    War_Intensity FLOAT,
    Month VARCHAR(10)
);

SHOW TABLES;

-- 1 total records
SELECT COUNT(*) FROM war_events;

-- 2 total attacks
SELECT SUM(missiles_launched + drones_launched) FROM war_events;

-- 3 total deaths
SELECT SUM(deaths) FROM war_events;

-- 4 total injuries
SELECT SUM(injuries) FROM war_events;

-- 5 total casualties
SELECT SUM(deaths + injuries) FROM war_events;

-- 6 avg oil price
SELECT AVG(oil_price) FROM war_events;

-- 7 avg gold price
SELECT AVG(gold_price) FROM war_events;

-- 8 avg stock index
SELECT AVG(stock_index) FROM war_events;

-- 9 attacks by country
SELECT country, SUM(missiles_launched + drones_launched)
FROM war_events GROUP BY country;

-- 10 deaths by country
SELECT country, SUM(deaths)
FROM war_events GROUP BY country;

-- 11 injuries by country
SELECT country, SUM(injuries)
FROM war_events GROUP BY country;

-- 12 casualties by country
SELECT country, SUM(deaths+injuries)
FROM war_events GROUP BY country;

-- 13 avg attacks per country
SELECT country, AVG(missiles_launched + drones_launched)
FROM war_events GROUP BY country;

-- 14 max deaths country
SELECT country, MAX(deaths)
FROM war_events GROUP BY country;

-- 15 country with highest attacks
SELECT country
FROM war_events
GROUP BY country
ORDER BY SUM(missiles_launched + drones_launched) DESC
LIMIT 1;

-- 16 country with highest casualties
SELECT country
FROM war_events
GROUP BY country
ORDER BY SUM(deaths+injuries) DESC
LIMIT 1;

-- 17 attacks by area
SELECT area, SUM(missiles_launched + drones_launched)
FROM war_events GROUP BY area;

-- 18 deaths by area
SELECT area, SUM(deaths)
FROM war_events GROUP BY area;

-- 19 top 10 dangerous areas
SELECT area, SUM(deaths)
FROM war_events GROUP BY area
ORDER BY SUM(deaths) DESC LIMIT 10;

-- 20 most targeted area
SELECT area, COUNT(*)
FROM war_events GROUP BY area
ORDER BY COUNT(*) DESC LIMIT 1;

-- 21 avg casualties by area
SELECT area, AVG(deaths+injuries)
FROM war_events GROUP BY area;

-- 22 max attack area
SELECT area, MAX(missiles_launched + drones_launched)
FROM war_events GROUP BY area;

-- 23 least attacked area
SELECT area
FROM war_events GROUP BY area
ORDER BY SUM(missiles_launched + drones_launched) ASC LIMIT 1;

-- 24 area with highest injuries
SELECT area
FROM war_events GROUP BY area
ORDER BY SUM(injuries) DESC LIMIT 1;

-- 25 attacks by event type
SELECT event_type, COUNT(*)
FROM war_events GROUP BY event_type;

-- 26 deaths by event type
SELECT event_type, SUM(deaths)
FROM war_events GROUP BY event_type;

-- 27 injuries by event type
SELECT event_type, SUM(injuries)
FROM war_events GROUP BY event_type;

-- 28 avg casualties per event
SELECT event_type, AVG(deaths+injuries)
FROM war_events GROUP BY event_type;

-- 29 most dangerous event
SELECT event_type
FROM war_events GROUP BY event_type
ORDER BY SUM(deaths) DESC LIMIT 1;

-- 30 most frequent event
SELECT event_type
FROM war_events GROUP BY event_type
ORDER BY COUNT(*) DESC LIMIT 1;

-- 31 attacks by date
SELECT date, SUM(missiles_launched + drones_launched)
FROM war_events GROUP BY date;

-- 32 casualties by date
SELECT date, SUM(deaths+injuries)
FROM war_events GROUP BY date;

-- 33 highest attack day
SELECT date
FROM war_events GROUP BY date
ORDER BY SUM(missiles_launched + drones_launched) DESC LIMIT 1;

-- 34 highest casualty day
SELECT date
FROM war_events GROUP BY date
ORDER BY SUM(deaths+injuries) DESC LIMIT 1;

-- 35 avg attacks per day
SELECT AVG(missiles_launched + drones_launched)
FROM war_events;

-- 36 trend analysis
SELECT date,
SUM(missiles_launched + drones_launched) AS attacks,
SUM(deaths+injuries) AS casualties
FROM war_events GROUP BY date;

-- 37 oil price trend
SELECT date, AVG(oil_price)
FROM war_events GROUP BY date;

-- 38 gold price trend
SELECT date, AVG(gold_price)
FROM war_events GROUP BY date;

-- 39 stock trend
SELECT date, AVG(stock_index)
FROM war_events GROUP BY date;

-- 40 oil spike day
SELECT date
FROM war_events GROUP BY date
ORDER BY AVG(oil_price) DESC LIMIT 1;

-- 41 gold spike day
SELECT date
FROM war_events GROUP BY date
ORDER BY AVG(gold_price) DESC LIMIT 1;

-- 42 market crash day
SELECT date
FROM war_events GROUP BY date
ORDER BY AVG(stock_index) ASC LIMIT 1;

-- 43 economic combined
SELECT date,
AVG(oil_price),
AVG(gold_price),
AVG(stock_index)
FROM war_events GROUP BY date;

-- 44 attack success rate
SELECT 
SUM(missiles_launched + drones_launched - defense_interceptions) /
SUM(missiles_launched + drones_launched)
FROM war_events;

-- 45 casualty ratio
SELECT 
SUM(deaths+injuries) /
SUM(missiles_launched + drones_launched)
FROM war_events;

-- 46 weather impact
SELECT weather, SUM(deaths)
FROM war_events GROUP BY weather;

-- 47 attacks by weather
SELECT weather, COUNT(*)
FROM war_events GROUP BY weather;

-- 48 high intensity days
SELECT date
FROM war_events
GROUP BY date
HAVING SUM(missiles_launched + drones_launched) > 100;