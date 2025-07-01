-- 1. 订单状态索引 (加速订单状态查询)
create index idx_orders_status on orders(status);

-- 2. 商品分类索引 (加速按分类检索商品)
create index idx_product_category on product(category);

-- 3. 订单日期索引 (加速按日期范围查询订单)
create index idx_orders_date on orders(order_date);


-- 库存概览视图 (inventory_overview)

create view inventory_overview as
select 
    p.product_id as '商品id',
    p.product_name as '商品名称',
    p.category as '商品类别',
    p.unit_price as '单价',
    s.supplier_name as '供应商',
    i.current_quantity as '当前库存',
    case 
        when i.current_quantity = 0 then '缺货'
        when i.current_quantity <= 10 then '低库存'
        else '充足' 
    end as '库存状态'
from inventory i
join product p on i.product_id = p.product_id
join supplier s on p.supplier_id = s.supplier_id;


-- 销售统计视图 (sales_summary)

create view sales_summary as
select 
    p.product_id as '商品id',
    p.product_name as '商品名称',
    p.category as '商品类别',
    count(distinct o.order_id) as '销售订单数',
    sum(od.quantity) as '销售总量',
    sum(od.quantity * od.unit_price) as '销售总额',
    avg(od.quantity * od.unit_price) as '平均订单金额'
from order_detail od
join orders o on od.order_id = o.order_id
join product p on od.product_id = p.product_id
where o.status in ('已发货', '已完成')
group by p.product_id;


-- 客户订单详情视图 (customer_order_details)
create view customer_order_details as
select 
    c.customer_id as '客户id',
    c.customer_name as '客户名称',
    o.order_id as '订单id',
    date_format(o.order_date, '%y-%m-%d %h:%i') as '订单时间',
    e.employee_name as '处理员工',
    o.delivery_address as '送货地址',
    o.status as '订单状态',
    p.product_name as '商品名称',
    od.quantity as '购买数量',
    od.unit_price as '单价',
    (od.quantity * od.unit_price) as '小计金额'
from orders o
join customer c on o.customer_id = c.customer_id
join employee e on o.employee_id = e.employee_id
join order_detail od on o.order_id = od.order_id
join product p on od.product_id = p.product_id;