create database retailsales;
use retailsales;
select * from retailsales;
alter table retailsales
rename column ï»¿transactions_id to transactions_id;

select * from retailsales
-- Data cleaning(identifying missing values)
where transactions_id is null and 
	sale_date is null and 
	sale_time is null and 
	customer_id is null and 
	gender is  null and 
	age is null and 
	category is null and 
	quantiy is null and 
	price_per_unit is null and 
	cogs is null and 
	total_sale is null;

-- EDA 
-- How many records do we have in the datase?
select count(*) from retailsales;

-- How many sales do we have?
select count(*) as total_sale from retailsales;

-- How many unique customers do we have?
select  count(distinct(customer_id)) as Unique_cus from retailsales ;

-- How many distinct category do we have
 select distinct(category) as Dist_categories from retailsales; 
 
  select count(distinct category) as Dist_categories from retailsales;

-- Data Analysis and Business Key problem

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retailsales
where sale_date = "2022-11-05";

-- Q.2 *** Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
select * from retailsales where sale_date between '2022-11-01' and '2022-11-30' and 
							  category = "Clothing" and
                              quantiy >=4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category, sum(total_sale) as Total_sales,
count(*) as total_orders
from retailsales group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select category, round(avg(age),2) as Avg_Age from retailsales
where category = "Beauty";

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retailsales
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender, 
count(distinct(transactions_id)) as Total_transactions from retailsales
group by category, gender
order by category;

--  Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select 
		extract(year from sale_date) as year,
        extract(month from sale_date) as month,
        round(avg(total_sale),2) as Avg_sales
        from retailsales group by year, month
        order by year, month desc;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id, sum(total_sale) as Total_sales
from retailsales
group by customer_id order by Total_sales desc limit 5;

-- -- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category, count(distinct(customer_id)) as uniquec
from retailsales group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select * from retailsales;
with hourly_order as (
			select *, case when sale_time <=12 then "Morning"
			when sale_time between 12 and 17 then "Afternoon"
            else "Evening" end as shift
            from retailsales
            )
            select shift, count(*) as Num_order
            from hourly_order
			group by shift;







with hourly_sales as (
select *,  case when sale_time <=12 then "Morning"
		when sale_time between 12 and 17 then "Afternoon"
        else "Evening" end as shift
        from retailsales)
        select shift, count(*) as Total_order
        from hourly_sales
        group by shift;
        