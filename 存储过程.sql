-- 下单

delimiter //

create procedure place_order(
    in p_customer_id int,
    in p_employee_id int,
    in p_delivery_address varchar(200),
    in p_product_id int,
    in p_quantity int
)

begin
    declare v_order_id int;
    declare v_price decimal(10,2);
    declare v_current_quantity int;
    
    -- 错误处理
    declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    -- 验证输入数据
    if p_customer_id not in (select customer_id from customer) then
        signal sqlstate '45000' 
        set message_text = '无效客户ID';
    end if;
    
    if p_employee_id not in (select employee_id from employee) then
        signal sqlstate '45000' 
        set message_text = '无效员工ID';
    end if;
    
    if p_quantity <= 0 then
        signal sqlstate '45000' 
        set message_text = '数量必须大于0';
    end if;
    
    start transaction;
    
    -- 库存检查（带行锁）
    select current_quantity into v_current_quantity 
    from inventory 
    where product_id = p_product_id
    for update;  -- 关键：锁定该行防止并发超卖
    
    if v_current_quantity < p_quantity then
        signal sqlstate '45000' 
        set message_text = '库存不足';
    end if;
    
    -- 创建新订单
    insert into orders (customer_id, order_date, employee_id, delivery_address, status)
    values (p_customer_id, current_timestamp(3), p_employee_id, p_delivery_address, '待处理');
    
    set v_order_id = last_insert_id();
    
    -- 获取当前价格（避免后续价格变动影响此单）
    select unit_price into v_price 
    from product 
    where product_id = p_product_id;
    
    -- 添加订单明细
    insert into order_detail (order_id, product_id, quantity, unit_price)
    values (v_order_id, p_product_id, p_quantity, v_price);
    
    -- 预扣库存（实际扣除在订单完成后由触发器执行）
    commit;
    
    select v_order_id as order_id;  -- 仅返回订单ID供程序使用
end //

delimiter ;

-----------------------------------------------------------------
--   更新物价
delimiter //

create procedure update_product_price(
    in p_product_id int,
    in p_new_price decimal(10,2),
    in p_reason varchar(200)
)

begin
    declare v_old_price decimal(10,2);
    declare v_product_name varchar(100);
    
    -- 错误处理
    declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    -- 验证商品存在
    if not exists (select 1 from product where product_id = p_product_id) then
        signal sqlstate '45000' 
        set message_text = '商品不存在';
    end if;
    
    -- 验证新价格合法
    if p_new_price <= 0 then
        signal sqlstate '45000' 
        set message_text = '价格必须大于0';
    end if;
    
    start transaction;
    
    -- 获取旧价格和商品名称
    select unit_price, product_name 
    into v_old_price, v_product_name
    from product 
    where product_id = p_product_id;
    
    -- 更新价格
    update product 
    set unit_price = p_new_price 
    where product_id = p_product_id;
    
    commit;
    
    -- 返回结构化的审计信息
    select 
        v_product_name as product_name,
        v_old_price as old_price,
        p_new_price as new_price,
        p_reason as reason;
end //

delimiter ;