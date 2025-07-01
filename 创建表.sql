-- office_supplies_db

-- 1. 供应商表（supplier）
-- 核心作用：作为商品的供应源头，记录供应商基础信息。
create table supplier (
    supplier_id int auto_increment primary key,             -- 供应商唯一标识符（主键）
    supplier_name varchar(100) not null,                    -- 供应商全名（必填）
    phone varchar(20) not null,                             -- 联系电话号码（格式验证在约束中处理）
    address varchar(200),                                   -- 供应商物理地址
    is_active boolean not null default true,                -- 供应商合作状态（true：活跃中，false：已终止）
    
    -- 电话号码格式约束
    constraint chk_supplier_phone_format 
        check (phone regexp '^(1[3-9][0-9]{9}|[0-9]{3,4}-[0-9]{7,8})$')
);

-- 2. 商品表（product）
-- 供应链角色：连接供应商与库存的核心实体。
create table product (
    product_id int auto_increment primary key,              -- 商品唯一标识符（主键）
    product_name varchar(100) not null,                     -- 商品名称（必填）
    category varchar(50) not null,                          -- 商品分类（如：办公文具、电子设备等）
    unit_price decimal(10,2) not null check (unit_price >= 0),-- 商品单价（货币单位，精确到分）
    supplier_id int,                                        -- 关联供应商ID（供应商不存在时可置空）
    is_discontinued boolean not null default false,         -- 商品状态（true：已停产，false：正常销售）
    
    -- 供应商外键约束（供应商删除时置空）
    constraint fk_product_supplier 
        foreign key (supplier_id) references supplier(supplier_id)
        on delete set null
);

-- 3. 库存表（inventory）
-- 功能定位：实时跟踪商品库存状态，支持库存变更审计。
create table inventory (
    product_id int primary key,                               -- 商品唯一标识符（主键，与商品一对一关系）
    current_quantity int not null default 0 check (current_quantity >= 0), -- 当前库存数量（非负整数）
    last_update datetime(3) not null default current_timestamp(3), -- 最后更新时间（精确到毫秒）
    
    -- 商品外键约束（商品删除时级联删除库存）
    constraint fk_inventory_product 
        foreign key (product_id) references product(product_id)
        on delete cascade
);

-- 4. 客户表（customer）
-- 核心作用：作为订单的购买方，提供客户基础信息。
create table customer (
    customer_id int auto_increment primary key,             -- 客户唯一标识符（主键）
    customer_name varchar(100) not null,                    -- 客户姓名或公司名称（必填）
    phone varchar(20) not null,                             -- 客户联系电话
    email varchar(100),                                     -- 客户电子邮箱
    
    -- 电话号码格式约束
    constraint chk_customer_phone_format 
        check (phone regexp '^(1[3-9][0-9]{9}|[0-9]{3,4}-[0-9]{7,8})$'),
    -- 邮箱格式约束
    constraint chk_customer_email_format 
        check (email is null or email regexp '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$')
);

-- 5. 员工表（employee）
-- 职能范围：管理员工信息，支持权限与职责划分。
create table employee (
    employee_id int auto_increment primary key,             -- 员工唯一标识符（主键）
    employee_name varchar(100) not null,                    -- 员工姓名（必填）
    position varchar(30),                                   -- 员工职位（如：销售经理、库存管理员等）
    hire_date date not null,                                -- 员工入职日期（必填）
    department varchar(30) not null                         -- 员工所属部门（如：销售部、采购部等）
);

-- 6. 订单表（orders）
-- 流程中枢：连接客户、员工与订单明细的核心表。
create table orders (
    order_id int auto_increment primary key,                -- 订单唯一标识符（主键）
    customer_id int not null,                               -- 关联客户ID（订单所属客户）
    order_date datetime(3) not null default current_timestamp(3), -- 订单创建日期（必填）
    employee_id int not null,                               -- 处理员工ID（负责此订单的员工）
    delivery_address varchar(200) not null,                 -- 商品送货地址（必填）
    status enum('待处理','已发货','已完成','已取消') not null default '待处理', -- 订单当前状态
    
    -- 客户外键约束（客户删除时级联删除订单）
    constraint fk_orders_customer 
        foreign key (customer_id) references customer(customer_id)
        on delete cascade,
    
    -- 员工外键约束（员工删除时限制操作）
    constraint fk_orders_employee 
        foreign key (employee_id) references employee(employee_id)
        on delete restrict
);

-- 7. 订单明细表（order_detail）
-- 订单拆分：解析订单中的具体商品项（如1个订单包含3种商品，对应3条明细记录）。
create table order_detail (
    order_id int not null,                                  -- 关联订单ID（所属订单）
    product_id int not null,                                -- 关联商品ID（购买的具体商品）
    quantity int not null,                                  -- 购买数量（必须大于0）
    unit_price decimal(10,2) not null check (unit_price >= 0),-- 商品购买时的单价（快照价格）

    primary key (order_id, product_id),  -- 复合主键替代detail_id
    
    -- 订单外键约束（订单删除时级联删除明细）
    constraint fk_order_detail_orders 
        foreign key (order_id) references orders(order_id)
        on delete cascade,
    
    -- 商品外键约束（商品删除时限制操作）
    constraint fk_order_detail_product 
        foreign key (product_id) references product(product_id)
        on delete restrict,
    
    -- 数量必须为正整数约束
    constraint chk_order_detail_quantity 
        check (quantity > 0)
);






