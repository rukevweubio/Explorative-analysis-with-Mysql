create  table products(
	product_id serial primary key,
	name text not null,
	price  decimal(10,2) not null,
	category text not null
	
);
create table customers(
	customer_id serial primary key,
	name text not null,
	email text unique not null
);

create table orders(
	order_id serial primary key,
	customer_id integer not null,
	order_date date not null,
	foreign key (customer_id) references customers(customer_id)
	
);
 create table order_items(
	 order_items_id serial primary key,
	 order_id integer  not null,
	 product_id integer not null,
	 quantity integer not null,
	foreign key (order_id) references orders(order_id),
	 foreign key (product_id) references products(product_id)


	 
 );


-- some business quation answer from this dataset
--1** Total Sales Revenue
 select  sum(p.price*oi.quantity)  as total_revenue from  order_items oi
	 join products p 
	 on  oi.product_id=p.product_id;

--2** Top selling product
select  p.name, sum(oi.quantity) sumofquantitysold , count(*) as countproduct from  order_items oi
	 join products p 
	 on  oi.product_id=p.product_id
	group by p.name
	order by sumofquantitysold  desc;

--2** how many order that each customer make from the store 
select  distinct(c.name) ,count(*) from  orders o
	 join customers c 
	 on  o.customer_id=c.customer_id
	group by c.name
	order by count(*) desc;

--3* Top-Selling Products
 select  p.name, sum(oi.quantity )as top_product from  order_items oi
	 join products p 
	 on  oi.product_id=p.product_id
	 group by p.name
	 order by top_product desc;
	
--4*  Top 5 Customer Order Frequency
select  distinct(c.name) ,count(order_id) from  orders o
	 join customers c 
	 on  o.customer_id=c.customer_id
	group by c.name
	order by count(order_id) desc;
	 
	 
--5* Revenue by Customer
 select c.name, sum(oi.quantity*p.price) as total_revenue from  order_items oi
	 join products p 
	 on  oi.product_id=p.product_id
	 join orders o
	 using(order_id)
	 join customers c
	 on o.customer_id = c.customer_id
	 group by c.name
	 order by  total_revenue desc

--*5 top category  with high sales
	  select  p.category ,sum(p.price*oi.quantity)  as total_revenue from  order_items oi
	 join products p 
	 on  oi.product_id=p.product_id
	 group by p.category
	 order by total_revenue desc ;


--6* Monthly Sales Trends
--What are the 	monthly   sales trends for the current year?
select  TO_CHAR(o.order_date,'month') as months, sum(oi.quantity*p.price) as total_revenue from  order_items oi
	 join products p 
	 on  oi.product_id=p.product_id
	 join orders o
	 using(order_id)
	WHERE DATE_PART('year', o.order_date) = DATE_PART('year', CURRENT_DATE)
	group by months
	order by total_revenue desc

--7* Daily Sales Trend 
	--What are the 	Daily  sales trends for the current year?
	select  TO_CHAR(o.order_date,'Day') as months, sum(oi.quantity*p.price) as total_revenue from  order_items oi
	 join products p 
	 on  oi.product_id=p.product_id
	 join orders o
	 using(order_id)
	where date_part('day',o.order_date) = date_part('day',current_date)
	group by months
	order by total_revenue desc

--8* Monthly  sales Trend
	select  TO_CHAR(o.order_date,'month') as months, sum(oi.quantity*p.price) as total_revenue from  order_items oi
	 join products p 
	 on  oi.product_id=p.product_id
	 join orders o
	 using(order_id)
	WHERE DATE_PART('month', o.order_date) = DATE_PART('month',o.order_date)
	group by months
	order by total_revenue desc;

--8*  Average Order Value
	select  avg(new_table.top_product) as average_sales
	from (select p.name, o.order_id,  sum(oi.quantity *p.price)as top_product from  order_items oi
	 join products p 
	 on  oi.product_id=p.product_id
	join orders o
	on o.order_id = oi.order_id
	 group by p.name, o.order_id
	 order by top_product desc) as new_table

	
--9*  Product Performance by Category
	select  p.category, sum(oi.quantity )as top_product from  order_items oi
	 join products p 
	 on  oi.product_id=p.product_id
	 group by p.category
	 order by top_product desc;

--10*  the product that sold the higest
select  p.name,p.product_id,sum(oi.quantity) as quantity from  order_items oi
	 join products p 
	 on  oi.product_id=p.product_id
	group by p.name, p.product_id
	order by quantity desc
	limit 1;


---11* the category that have more than 10 sales 
select  p.category, count(o.order_id) from  order_items oi
	 join products p 
	 on  oi.product_id=p.product_id
	join orders o
	using(order_id)
	group by p.category
	having count(o.order_id)>10
	order by count(o.order_id) desc;
--12* find the avearge product price by category order by price 
select category, ceil(avg(price)) as price from products
	group by category
	order by price desc;


	
select date_part('month', order_date) from orders	
select TO_CHAR(ORDER_DATE,'MONTH') FROM ORDERS
SELECT MAX(EXTRACT('YEAR' FROM ORDER_DATE)) FROM ORDERS
	
	



drop table if exists product cascade;
drop table if exists customers cascade;
drop table if exists orders cascade;
drop table if exists order_items cascade;
	
