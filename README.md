# 🎮 Video Game Sales Database Analysis using MySQL  

A data analytics project using **MySQL and advanced SQL techniques** to analyze global video game sales. The project explores trends across **platforms, genres, publishers, and regions**, revealing performance patterns and helping in **market strategy, product targeting, and decision-making**.


---

## 📊 Project Overview

| Feature | Details |
|---------|---------|
| Total Records | ~16,598 |
| Columns | 11 |
| Database Used | MySQL |
| Tools | MySQL, Excel, Power BI (optional) |
| Focus Areas | Genre, Platform, Publisher, Year, Regional Sales |

**Dataset Attributes:**  
`name`, `platform`, `year`, `genre`, `publisher`, `na_sales`, `eu_sales`, `jp_sales`, `other_sales`, `global_sales`  
:contentReference[oaicite:0]{index=0}

---

## 🎯 Business Goals

✔ Analyze global and regional sales performance  
✔ Find top publishers and most profitable years  
✔ Discover top-selling platforms and genres  
✔ Identify regional preferences (NA, EU, JP, Others)  
✔ Highlight games above average sales  
✔ Track yearly sales growth and trends  

:contentReference[oaicite:1]{index=1}

---

## 🔍 SQL Insights & Key Queries

| Analysis | Query Highlight |
|----------|------------------|
| Total Sales by Year | `SUM(global_sales)` |
| Top 5 Publishers | `GROUP BY publisher ORDER BY total_sales DESC LIMIT 5` |
| Best-Selling Genre | `AVG(global_sales)` |
| Platform with Highest Sales | `AVG(global_sales)` |
| Regional Genre Strength | `SUM(na_sales), SUM(eu_sales), SUM(jp_sales)` |
| Games Above Avg Sales | `WHERE global_sales > (SELECT AVG(global_sales))` |
| Best Year per Publisher | `HAVING total_sales = MAX(...)` |
| Market Share (%) | `(SUM(global_sales) / total)*100` |
| Top 5 Games per Platform | `ROW_NUMBER() OVER (PARTITION BY platform)` |
| Underperforming Publishers | `HAVING avg_sales < (SELECT AVG(...))` |
:contentReference[oaicite:2]{index=2}

---

## 💡 Key Insights

- Action, Sports, and Shooter are the highest-selling game genres  
- PlayStation and Nintendo platforms dominate global sales  
- North America prefers Sports & Action; Japan favors RPGs  
- Nintendo, EA, and Activision are top-performing publishers  
- Some games sell 2× above industry average—high market demand  
- Smaller publishers lack reach — niche market opportunity  
:contentReference[oaicite:3]{index=3}

---

## 🚀 Recommendations

| Focus Area | Strategy |
|------------|----------|
| Genre Strategy | Invest in Action, Shooter, RPG, and Sports games |
| Platform Targeting | Focus releases on PlayStation & Nintendo |
| Regional Marketing | Tailor campaigns by region preferences |
| Publisher Strategy | Develop partnerships for niche publishers |
| Launch Strategy | Use platform-genre combinations for success |
| Future Planning | Track year-on-year trends for forecasting |
:contentReference[oaicite:4]{index=4}

---

## 🛠 Tools & Technologies Used

- **MySQL** – Database, SQL Queries, Window Functions  
- **Excel** – Formatting, presentation  
- **Power BI/Tableau (optional)** – Dashboard visualization  
- **SQL Concepts** – Aggregation, JOINs, CTE, Ranking, CASE Conditions  

---

## 📌 Future Enhancements

🔹 Build Power BI dashboard for interactive visuals  
🔹 Add sales forecasting model using Python  
🔹 Perform sentiment analysis using game reviews  
🔹 Analyze price trends over time and depreciation  

---

## 🏁 Conclusion  
This SQL-based analysis delivers valuable insights into **video game sales patterns, platform success, publisher dominance, and regional behavior**. It empowers better **market planning, genre targeting, and business decision-making** for gaming industry professionals.

---

