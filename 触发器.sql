
-- 1.  无法下单已经停止合作或停止生产的产品

delimiter $$

-- 创建 insert 检查触发器
create trigger tr_order_detail_before_insert
before insert on order_detail
for each row
begin
    declare v_discontinued boolean;
    declare v_supplier_active boolean;
    
    -- 检查商品状态
    select is_discontinued into v_discontinued
    from product 
    where product_id = new.product_id;
    
    if v_discontinued then
        signal sqlstate '45000'
        set message_text = '不能订购已停产的产品。';
    end if;
    
    -- 检查供应商状态
    select s.is_active into v_supplier_active
    from product p
    join supplier s on p.supplier_id = s.supplier_id
    where p.product_id = new.product_id;
    
    if not v_supplier_active then
        signal sqlstate '45001'
        set message_text = '供应商已停用。';
    end if;
end
$$

delimiter ;



-- 更新时订单状态时，修改库存以及库存不足则报错

delimiter $$

create trigger orders_before_update_status
before update on orders
for each row
begin
    declare insufficient int default 0;
    
    -- 仅在状态变为'已完成'时触发
    if new.status = '已完成' and old.status <> '已完成' then
        -- 检查是否有库存不足的商品
        select count(*) into insufficient
        from order_detail od
        inner join inventory i on i.product_id = od.product_id
        where od.order_id = new.order_id
          and i.current_quantity < od.quantity;
        
        if insufficient > 0 then
            -- 简单明确的错误消息
            signal sqlstate '44000' 
            set message_text = '库存不足，无法完成订单';
        else
            -- 更新库存
            update inventory i
            inner join order_detail od on i.product_id = od.product_id
            set i.current_quantity = i.current_quantity - od.quantity
            where od.order_id = new.order_id;
        end if;
    end if;
end
$$

delimiter ;


















-- -- 订单状态更新后自动处理库存
-- delimiter //

-- create trigger after_order_completed
-- after update on orders
-- for each row
-- /*
-- 功能: 订单状态变为"已完成"时自动扣除库存
-- 逻辑: 
--   - 仅当状态从非已完成变为已完成时触发
--   - 关联更新库存数量
-- 业务价值: 保证库存实时准确性
-- */
-- begin
--     -- 仅处理状态变为"已完成"的订单
--     if new.status = '已完成' and old.status <> '已完成' then
--         -- 扣除订单中所有商品的库存
--         update inventory i
--         join order_detail od on i.product_id = od.product_id
--         set i.current_quantity = i.current_quantity - od.quantity,
--             i.last_update = current_timestamp(3)
--         where od.order_id = new.order_id;
--     end if;
-- end //

-- delimiter ;

-- -- 新订单明细插入前检查商品状态
-- delimiter //

-- create trigger before_order_detail_insert
-- before insert on order_detail
-- for each row
-- /*
-- 功能: 防止已停产商品被添加到新订单
-- 逻辑: 检查商品是否停产，如已停产则阻止插入
-- 业务价值: 强制执行业务规则
-- */
-- begin
--     declare v_discontinued boolean;
    
--     -- 检查商品状态
--     select is_discontinued into v_discontinued 
--     from product 
--     where product_id = new.product_id;
    
--     -- 商品已停产则阻止操作
--     if v_discontinued then
--         signal sqlstate '45000'
--         set message_text = '该商品已停产，无法添加到新订单';
--     end if;
-- end //

-- delimiter ;