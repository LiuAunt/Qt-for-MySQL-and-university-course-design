
-- 查询所有"已完成"状态的订单详细信息
select order_id, customer_id, order_date, delivery_address 
from orders 
where status = '已完成'
order by order_date desc;


-- 查询订单id为1的所有商品明细
select o.order_id, p.product_name, od.quantity, od.unit_price, 
       (od.quantity * od.unit_price) as subtotal
from orders o
join order_detail od on o.order_id = od.order_id
join product p on od.product_id = p.product_id
where o.order_id = 1;


-- 统计各类别商品的总销售额和平均单价
select p.category, 
       count(*) as sales_count, 
       sum(od.quantity) as total_quantity,
       sum(od.quantity * od.unit_price) as total_sales,
       avg(od.unit_price) as avg_price
from order_detail od
join product p on od.product_id = p.product_id
group by p.category
order by total_sales desc;


-- 查询总消费金额超过1000元的客户及其消费总额
select c.customer_id, c.customer_name,
       sum(od.quantity * od.unit_price) as total_spent
from customer c
join orders o on c.customer_id = o.customer_id
join order_detail od on o.order_id = od.order_id
group by c.customer_id, c.customer_name
having total_spent > 1000
order by total_spent desc;

-- 查询至今到2023年的商品订单详情
select 
    o.order_id, 
    o.order_date, 
    c.customer_name,
    p.product_name, 
    p.category,
    od.quantity, 
    od.unit_price,
    (od.quantity * od.unit_price) as subtotal
from 
    orders o
    join customer c on o.customer_id = c.customer_id
    join order_detail od on o.order_id = od.order_id
    join product p on od.product_id = p.product_id
where 
    o.order_date between '2023-01-01' and '2026-01-1'
order by 
    o.order_date, 
    o.order_id,
    p.category;
		
-- 查询各类商品的销售总量和总销售额
select 
    p.category as '商品类别',
    count(*) as '销售记录数',
    sum(od.quantity) as '销售总量',
    round(sum(od.quantity * od.unit_price), 2) as '总销售额'
from 
    product p
    join order_detail od on p.product_id = od.product_id
group by 
    p.category
order by 
    sum(od.quantity * od.unit_price) desc;

-- 查询存在未完成订单的客户信息
select customer_id, customer_name, phone
from customer c
where exists (
    select 1 from orders o 
    where o.customer_id = c.customer_id 
    and o.status != '已完成'
);


-- 统计每位员工处理的订单总金额和订单数量
select e.employee_id, e.employee_name, e.department,
       count(distinct o.order_id) as order_count,
       sum(od.quantity * od.unit_price) as total_sales,
       rank() over (order by sum(od.quantity * od.unit_price) desc) as sales_rank
from employee e
join orders o on e.employee_id = o.employee_id
join order_detail od on o.order_id = od.order_id
group by e.employee_id, e.employee_name, e.department
order by total_sales desc;