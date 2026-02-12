-- 1. Regional Profit Margin Analysis:- Shows total revenue, profit, and margin % by region.

SELECT 
    *,
    ROUND((total_profit / total_revenue) * 100, 2) AS Profit_Margin
FROM
    (SELECT 
        Region,
            ROUND(SUM(REVENUE), 2) AS Total_Revenue,
            ROUND(SUM(PROFIT), 2) AS Total_Profit
    FROM
        superstore
    GROUP BY REGION) t
ORDER BY profit_margin DESC	;
    

-- 2. Regional Loss Contribution:- Identifies total losses (negative profit) per region.

select  Region , 
round(sum(PROFIT), 2) as Total_Loss
from superstore
where profit< 0
GROUP BY REGION
order by total_loss;


-- 3. State-Level Discount Allocation:- Summarizes total discounts applied across states.

select  
State,
round(sum(Discount),2) as Total_discount
from superstore
group by state
having sum(discount)  > 0
order by total_discount desc;


-- 4. Shipment Mode Distribution by Segment:- Breaks down shipping preferences across customer segments.

select 
segment,
sum(case when ship_mode = 'Same Day' then 1 else 0 end )as Same_Day,
sum(case when ship_mode = 'First Class' then 1 else 0 end )as First_class,
sum(case when ship_mode = 'Second Class' then 1 else 0 end )as Second_Class,
sum(case when ship_mode = 'Standard Class' then 1 else 0 end )as Standard_class,
count(Ship_Mode) as Total_Shipments
from superstore
group by segment;


-- 5. Segment-Wise Profit Margin Analysis:-  Compares profitability across customer segments.

select *, 
round((total_profit/total_revenue)*100,2) as Profit_Margin_perc 
from
	(select  segment , 
	round(SUM(REVENUE),2) as Total_Revenue,
	round(sum(PROFIT), 2) as Total_Profit
	 from superstore
	GROUP BY segment) t
    order by profit_margin_perc desc;


-- 6. Category & Sub-Category Discount vs. Margin:- Analyzes discount levels and profit margins at product category level.

select 
Category,
Sub_category,
round(sum(Discount),2) as Total_Discount,
round(sum(profit)/sum(revenue)*100,2) as Profit_Margin_Perc
from superstore
group by category, Sub_Category
order by total_discount desc;


-- 7. State-Level Average Revenue per Unit (with Lag Comparison):- Calculates average revenue per unit sold and compares with previous ranked state in percentage.

with f as
(select 
	*,
	lag(average_revenue) over (order by average_revenue desc) as lag_row
	from
		(select 
		State,
		round(sum(revenue)/sum(quantity),2) as Average_Revenue
		from superstore
		group by state
		order by Average_revenue desc) t
	)
    select 
    State,
    Average_Revenue,
    round((lag_row - Average_revenue) ,2) as Difference,
	round((lag_row - Average_revenue)*100/Average_Revenue,2) as Perc_diff
    from f;


-- 8. Discount Rate vs. Total Discount Expense:- Shows how much discount expense is tied to each discount rate.

select 
concat(Discount_rate* 100,'%') as Discount_Rate,
round(sum(discount), 2) as Total_Discount_exp
 from superstore 
 group by Discount_rate
 order by total_Discount_exp
 desc;

 
 -- 9. Discount Rate vs. Profit Margin:- Evaluates profitability impact of different discount rates.

 select 
concat(Discount_rate* 100,'%') as Discount_Rate,
round(sum(profit)/sum(revenue)*100, 2) as Profit_Margin
 from superstore 
 group by Discount_rate
 order by profit_margin
 desc;

 
 -- 10. Top Sub-Category by Profit Margin per Category:- Identifies the most profitable sub-category within each category.

 with f as 
	(select 
	*,
	row_number() over(partition by category order by profit_margin desc) as rnk
from
	(select 
	category,
	sub_category,
	round(sum(profit)/sum(revenue)*100, 2) as profit_margin
	 from superstore 
	 group by category, Sub_Category
	 order by category) t
 )
 
 select Category,
 Sub_category,
 Profit_margin
 from f
 where rnk = 1
 order by Profit_margin desc;

 
 -- 11. Top City by Profit Margin per State:- Highlights the most profitable city within each state.

 with f as 
	(select 
	*,
	row_number() over(partition by State order by profit_margin desc) as rnk
from
	(select 
	State,
	City,
	round(sum(profit)/sum(revenue)*100, 2) as profit_margin
	 from superstore 
	 group by State, city
	 order by state) t
 )
 
 select State,
 City,
 Profit_margin
 from f
 where rnk = 1
 order by Profit_margin desc;

 
 -- 12. Top Sub-Category by Profit Contribution per City:- Finds the leading sub-category driving profit in each city.

 with f as 
(SELECT 
*,
row_number() over( partition by city order by total_profit desc)  as rnk
FROM
(select 
CITY,
Sub_Category,
ROUND(SUM(PROFIT),2) TOTAL_PROFIT
from superstore
GROUP BY  CITY , SUB_CATEGORY
ORDER BY CITY, SUB_CATEGORY DESC) T)

select 
City, 
Sub_category, 
Total_profit
from f 
where rnk = 1
order by Total_profit desc;


-- 13. Top 5 High-Margin Orders:- Lists individual orders with the highest profit margins.

select 
*,
round((profit/revenue)*100,2) profit_Margin
 from superstore
 order by profit_margin desc
 limit 5;
 
 
 -- 14.State Contribution to Regional Profit:- Calculates each state’s share of regional profit.

 with t as
(select  
region, 
state,
round(sum(profit),2) as total_profit
FROM superstore
group by region, state
order by region , total_profit desc)
select Region, State,
round(total_profit*100/sum(total_profit) over(partition by region ),2) as Contribution_Percentage
from t;


--  15. Sub-Category Contribution to Category Revenue:- Shows percentage contribution of each sub-category to its parent category.

WITH CategorySales AS 
( SELECT Category, Sub_Category, ROUND(SUM(REVENUE),2) AS SubCat_Sales FROM superstore 
GROUP BY Category, Sub_Category )
SELECT Category, Sub_Category, SubCat_Sales, 
ROUND((SubCat_Sales * 100.0 / SUM(SubCat_Sales) OVER (PARTITION BY Category)),2) AS Contribution_Percentage 
FROM CategorySales
ORDER BY  Contribution_Percentage DESC;