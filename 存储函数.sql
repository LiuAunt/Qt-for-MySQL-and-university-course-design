



------------------------------------------
-- 存储函数 (包含详细功能注释)
------------------------------------------

-- 商品库存价值计算器
delimiter //

create function calculate_inventory_value(p_product_id int)
returns decimal(10,2)
deterministic
/*
功能: 计算指定商品的总库存价值
参数: p_product_id - 商品ID
返回: 库存数量*商品单价
业务价值: 财务库存评估
*/
begin
    declare v_value decimal(10,2);
    declare v_qty int;
    declare v_price decimal(10,2);
    
    -- 从库存和商品表获取必要数据
    select current_quantity, unit_price 
    into v_qty, v_price
    from inventory i
    join product p on i.product_id = p.product_id
    where p.product_id = p_product_id;
    
    -- 计算库存价值
    set v_value = v_qty * v_price;
    return v_value;
end //

delimiter ;

-- 供应商活跃商品计数器
delimiter //

create function active_supplier_products(p_supplier_id int)
returns int
deterministic
/*
功能: 统计供应商当前的活跃商品数
参数: p_supplier_id - 供应商ID
返回: 活跃商品数量
业务价值: 供应商绩效评估
*/
begin
    declare v_count int;
    
    -- 统计供应商在售商品
    select count(*) 
    into v_count
    from product
    where supplier_id = p_supplier_id
      and is_discontinued = false;
      
    return v_count;
end //

delimiter ;

------------------------------------------
-- 触发器
------------------------------------------

