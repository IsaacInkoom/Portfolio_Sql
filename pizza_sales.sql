-- This Query shows all columns in the table pizza_sales 

Select * from pizza_sales

-- This Query displays total revenue which is calculated by adding the total price

Select cast(sum(total_price) as decimal(10,2)) as Total_Revenue from pizza_sales


-- This Query displays the Average Order Value

Select cast(sum(total_price) /
count(distinct(order_id)) as decimal (10,2)) as Avg_Order_value from pizza_sales


-- This Query displays the total pizza sold

Select sum(quantity) as Total_Pizza_Sold from pizza_sales


-- This Query displays the total numbers of orders 

Select count(distinct(order_id)) as Total_Orders from pizza_sales

-- This Query displays Average pizzas per orders

Select  cast(cast(sum(quantity) as decimal(10,2)) /
cast(count(distinct (order_id)) as decimal(10,2)) as decimal(10,2)) as Avg_pizza_per_orders  from pizza_sales

--This Query displays the daily trend by number of orders 
Select datename(DW, order_date) as order_day, count(distinct(order_id)) as Total_orders
from pizza_sales
group by datename(DW, order_date)

--This query displays monthly trend by number of orders in descending order 
Select datename(Month, order_date) as order_month, count(distinct(order_id)) as Total_orders
from pizza_sales
group by datename(Month, order_date)
order by Total_orders desc

--Percentage of sales by Category in descending order 
Select pizza_category, sum(total_price) *100 /
(select sum(total_price) from pizza_sales)  as Percentage_of_Sales
from pizza_sales 
group by pizza_category
order by Percentage_of_Sales desc

--Percentage of sales by size
Select pizza_size, cast(sum(total_price)*100 /
(select sum(total_price) from pizza_sales) as decimal(10,2)) as Percentage_by_size
from pizza_sales 
group by pizza_size
order by Percentage_by_size desc

-- Top 5 pizza by total Revenue
Select top 5 pizza_name, sum(total_price) as Revenue
from pizza_sales
group by pizza_name
order by Revenue desc

--Bottom 5 pizza by Total revenue

Select top 5 pizza_name, sum(total_price) as Revenue
from pizza_sales
group by pizza_name
order by Revenue

--Bottom 5 Pizza by Total orders
Select top 5 pizza_name, count(distinct(order_id)) as Total_orders
from pizza_sales
group by pizza_name
order by Total_orders

--Top 5 pizza by total orders 
Select top 5 pizza_name, count(distinct(order_id)) as Total_orders
from pizza_sales
group by pizza_name
order by Total_orders desc

--Top 5 pizza by total quantity
Select top 5 pizza_name, sum(quantity) as Total_quantity
from pizza_sales
group by pizza_name
order by Total_quantity desc

--Bottom 5 pizza by total quantity
Select top 5 pizza_name, sum(quantity) as Total_quantity
from pizza_sales
group by pizza_name
order by Total_quantity









