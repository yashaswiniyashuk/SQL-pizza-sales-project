-- Retrieve the total number of orders placed.
select count(order_id) as total_orders from orders;

-- Calculate the total revenue generated from pizza sales.
select
round(sum(order_details.QUANTITY * pizzas.price),2) as total_sales
from
order_details join pizzas on pizzas.pizza_id = order_details.PIZZA_ID;

-- Identify the highest-priced pizza.
select pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id 
order by pizzas.price desc limit 1; 

-- Identify the most common pizza size ordered.
select pizzas.size, count(order_details.ORDER_DETAILS_ID) as order_count
from pizzas join order_details 
on pizzas.pizza_id = order_details.PIZZA_ID
group by pizzas.size order by order_count desc limit 1;

-- List the top 5 most ordered pizza types along with their quantities.
select
pizza_types.name, sum(order_details.QUANTITY) as quantity
from pizza_types join pizzas 
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details 
on order_details.PIZZA_ID = pizzas.pizza_id
group by pizza_types.name order by quantity desc limit 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
select pizza_types.category, sum(order_details.QUANTITY) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on
order_details.PIZZA_ID = pizzas.pizza_id
group by pizza_types.category order by quantity desc;

-- Determine the distribution of orders by hour of the day.
select hour(ORDER_TIME), COUNT(ORDER_ID) AS ORDER_COUNT FROM orders
GROUP BY hour(ORDER_TIME);

-- Join relevant tables to find the category-wise distribution of pizzas.
select category, count(name) from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(quantity), 0) from
(select orders.ORDER_DATE, sum(order_details.QUANTITY) as quantity
from orders join order_details
on orders.ORDER_ID = order_details.ORDER_ID
group by orders.ORDER_DATE) as order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name, 
sum(order_details.QUANTITY * pizzas.price) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.PIZZA_ID = pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;

