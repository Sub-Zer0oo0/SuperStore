# SuperStore
SQL-driven retail analytics project for Superstore dataset, showcasing KPI-focused queries with CTEs, window functions, and profitability insights.
Overview
This project contains a collection of SQL queries designed to analyze a Superstore retail dataset. The schema includes attributes such as region, state, city, category, sub-category, sales, revenue, discount, cost, and profit.

The queries are structured to demonstrate both basic SQL proficiency and advanced analytical techniques (CTEs, window functions, ranking, contribution analysis). Each query is tied to industry-standard KPIs relevant to retail businesses.

Dataset Schema

Table: superstore
Ship_Mode (TEXT)
Segment (TEXT)
Country (TEXT)
City (TEXT)
State (TEXT)
Postal_Code (INT)
Region (TEXT)
Category (TEXT)
Sub_Category (TEXT)
Sales (DOUBLE)
Quantity (INT)
Revenue (DOUBLE)
Discount_rate (DOUBLE)
Discount (DOUBLE)
Cost (DOUBLE)
Profit (DOUBLE)

Project Objectives

Build SQL queries that reflect real-world KPIs used in retail analytics.
Showcase basic queries (retrieval, filtering, grouping) and complex queries (profitability analysis, discount impact, contribution percentages).

Demonstrate advanced SQL techniques:

Common Table Expressions (CTEs)
Window Functions (RANK, ROW_NUMBER, LAG, cumulative sums)
Aggregations and conditional logic

Key KPIs Covered

Profit Margin Analysis (Region, Segment, Category)
Loss Contribution (Negative profit by region)
Discount Effectiveness (Discount rate vs. margin)
Shipment Mode Distribution (Customer segment preferences)
Revenue Contribution (Sub-category share within category)
Top Performers (Cities, States, Sub-categories ranked by profit/margin)
Trend Analysis (Lag comparisons, moving averages)

Query Highlights

Regional Profit Margin – Revenue vs. Profit margin by region.

Regional Loss Contribution – Identifies regions with negative profit.

State-Level Discount Allocation – Total discounts applied per state.

Shipment Mode Distribution by Segment – Shipping preferences across customer segments.

Segment-Wise Profit Margin – Profitability comparison across segments.

Category & Sub-Category Discount vs. Margin – Discount impact on profitability.

State-Level Average Revenue per Unit (Lag Comparison) – Ranking states by average revenue.

Discount Rate vs. Total Discount Expense – Discount expense by rate.

Discount Rate vs. Profit Margin – Evaluates profitability impact of discounts.

Top Sub-Category by Profit Margin per Category – Identifies most profitable sub-category.

Top City by Profit Margin per State – City-level profitability ranking.

Top Sub-Category by Profit Contribution per City – Leading sub-category per city.

Top 5 High-Margin Orders – Individual orders with highest margins.

State Contribution to Regional Profit – State-level share of regional profit.

Sub-Category Contribution to Category Revenue – Sub-category share within category.

Tech Stack

Database: MySQL
Tooling: MySQL Workbench
Techniques: SQL Aggregations, CTEs, Window Functions, Ranking, Contribution Analysis

How to Use

Clone the repository.
Import the superstore dataset into MySQL.
Run queries in MySQL Workbench or any SQL client.
Explore results to derive insights into retail KPIs.

Applications

Retail business performance dashboards
Profitability and discount optimization analysis
Customer segmentation and shipment strategy
Interview-ready SQL portfolio showcasing advanced analytics

📌 Author

Ranit Barman  
Passionate about financial modeling, SQL analytics, and KPI-driven insights. Building a portfolio for analyst roles with a focus on Private Equity / Research Analyst positions
