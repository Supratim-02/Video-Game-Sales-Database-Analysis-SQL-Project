
-- --------------------------------------
-- Project: Video Game Sales Performance 
-- --------------------------------------

-- 1. Create Database
CREATE DATABASE IF NOT EXISTS video_game_sales_db;
USE video_game_sales_db;

-- 2. Create Table
CREATE TABLE IF NOT EXISTS video_games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    platform VARCHAR(50) NOT NULL,
    year YEAR,
    genre VARCHAR(50) NOT NULL,
    publisher VARCHAR(100),
    na_sales DECIMAL(6,2) DEFAULT 0,
    eu_sales DECIMAL(6,2) DEFAULT 0,
    jp_sales DECIMAL(6,2) DEFAULT 0,
    other_sales DECIMAL(6,2) DEFAULT 0,
    global_sales DECIMAL(6,2) DEFAULT 0
);
-- ================
-- 3. DATA CLEANING
-- Update year to 1979 where year=0
UPDATE video_games
SET year = 1979
WHERE year = 0;

-- =====================
-- 4. Queries Section

-- 1. Total Global Sales per Year
SELECT year, ROUND(SUM(global_sales),2) AS total_global_sales
FROM video_games
GROUP BY year
ORDER BY year ASC;

-- 2. Top 5 Publishers by Total Sales
SELECT publisher, ROUND(SUM(global_sales),2) AS total_sales
FROM video_games
GROUP BY publisher
ORDER BY total_sales DESC
LIMIT 5;

-- 3. Most Popular Genre by Average Global Sales
SELECT genre, ROUND(AVG(global_sales),2) AS avg_sales
FROM video_games
GROUP BY genre
ORDER BY avg_sales DESC
LIMIT 1;

-- 4. Platform with the Highest Average Sales
SELECT platform, ROUND(AVG(global_sales),2) AS avg_sales
FROM video_games
GROUP BY platform
ORDER BY avg_sales DESC
LIMIT 1;

-- 5. Regional Performance by Genre
SELECT genre,
       ROUND(SUM(na_sales),2) AS NA_Total,
       ROUND(SUM(eu_sales),2) AS EU_Total,
       ROUND(SUM(jp_sales),2) AS JP_Total
FROM video_games
GROUP BY genre
ORDER BY NA_Total DESC;

-- 6. Games with Sales Above Average (Global)
SELECT name, global_sales
FROM video_games
WHERE global_sales > (SELECT AVG(global_sales) FROM video_games)
ORDER BY global_sales DESC;

-- 7. Best Year for Each Publisher
SELECT publisher, year, ROUND(SUM(global_sales),2) AS total_sales
FROM video_games
GROUP BY publisher, year
HAVING total_sales = (
    SELECT MAX(total_sales_sub)
    FROM (
        SELECT publisher AS pub, year AS yr, SUM(global_sales) AS total_sales_sub
        FROM video_games
        GROUP BY publisher, year
    ) AS sub
    WHERE sub.pub = publisher
)
ORDER BY publisher;

-- 8. Top 3 Genres by Total Global Sales
SELECT genre, ROUND(SUM(global_sales),2) AS total_sales
FROM video_games
GROUP BY genre
ORDER BY total_sales DESC
LIMIT 3;

-- 9. Regional Leader (CASE Condition)
SELECT 
    name,
    CASE
        WHEN na_sales >= GREATEST(eu_sales, jp_sales, other_sales) THEN 'North America'
        WHEN eu_sales >= GREATEST(na_sales, jp_sales, other_sales) THEN 'Europe'
        WHEN jp_sales >= GREATEST(na_sales, eu_sales, other_sales) THEN 'Japan'
        ELSE 'Other Regions'
    END AS best_market
FROM video_games;

-- 10. Publisher Market Share (Global %)
SELECT publisher,
       ROUND((SUM(global_sales) / (SELECT SUM(global_sales) FROM video_games) * 100), 2) AS market_share_percent
FROM video_games
GROUP BY publisher
ORDER BY market_share_percent DESC;

-- 11. Average Global Sales by Platform and Genre
SELECT platform, genre, ROUND(AVG(global_sales),2) AS avg_sales
FROM video_games
GROUP BY platform, genre
ORDER BY avg_sales DESC;

-- 12. Top 5 Games for Each Platform (Fast and Reliable)
SELECT platform, name, global_sales
FROM (
    SELECT 
        platform,
        name,
        global_sales,
        ROW_NUMBER() OVER (PARTITION BY platform ORDER BY global_sales DESC) AS rank_per_platform
    FROM video_games
) ranked
WHERE rank_per_platform <= 5
ORDER BY platform, global_sales DESC;

-- 13. Identify Underperforming Publishers
SELECT publisher, ROUND(AVG(global_sales),2) AS avg_sales
FROM video_games
GROUP BY publisher
HAVING avg_sales < (SELECT AVG(global_sales) FROM video_games)
ORDER BY avg_sales ASC;

-- ===============
-- 14. Yearly Growth Trend (Sales Change)
SELECT t1.year, t1.total_sales AS current_year_sales,
       (t1.total_sales - t2.total_sales) AS sales_growth
FROM (
    SELECT year, SUM(global_sales) AS total_sales
    FROM video_games
    GROUP BY year
) t1
LEFT JOIN (
    SELECT year, SUM(global_sales) AS total_sales
    FROM video_games
    GROUP BY year
) t2 ON t1.year = t2.year + 1
ORDER BY t1.year ASC;

-- ========================



