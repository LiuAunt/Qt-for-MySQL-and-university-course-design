/*
 Navicat Premium Data Transfer

 Source Server         : DataBase_assignment
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : localhost:3306
 Source Schema         : office_supplies_db

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 27/06/2025 15:38:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `customer_id` int(0) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1, '张三', '13800138000', 'zhangsan@example.com');
INSERT INTO `customer` VALUES (2, '李四科技有限公司', '010-62785678', 'lisi@tech.com');
INSERT INTO `customer` VALUES (3, '王五工作室', '021-58765432', 'wangwu@studio.cn');
INSERT INTO `customer` VALUES (4, '赵六文化传媒', '0571-87896543', 'zhaoliu@media.com');
INSERT INTO `customer` VALUES (5, '钱七贸易公司', '0755-83456789', 'qianqi@trade.com');
INSERT INTO `customer` VALUES (6, '孙八教育集团', '020-87654321', 'sunba@edu.org');
INSERT INTO `customer` VALUES (7, '周九设计事务所', '028-87766554', 'zhoujiu@design.com');
INSERT INTO `customer` VALUES (8, '吴十出版社', '025-83344556', 'wushi@publish.cn');
INSERT INTO `customer` VALUES (9, '环球贸易集团', '13876543219', 'global@trade.com');
INSERT INTO `customer` VALUES (10, '卓越教育中心', '13987654320', 'excellence@edu.com');
INSERT INTO `customer` VALUES (11, '钱多多有限公司', '0510-85749321', 'qianduo@company.com');
INSERT INTO `customer` VALUES (12, '创新科技有限公司', '0756-88776655', 'chuangxin@tech.com');
INSERT INTO `customer` VALUES (13, '智慧教育咨询', '029-85437698', 'zhihui@edu.cn');
INSERT INTO `customer` VALUES (14, '阳光文化传播', '023-67895432', 'yangguang@culture.com');
INSERT INTO `customer` VALUES (15, '未来科技有限公司', '0411-87654321', 'weilai@tech.com');
INSERT INTO `customer` VALUES (16, '云端数据服务', '0591-23456789', 'yunduan@data.com');
INSERT INTO `customer` VALUES (17, '星际网络科技', '0351-76543210', 'xingji@net.com');
INSERT INTO `customer` VALUES (18, '绿色能源科技', '0871-63457890', 'lvse@energy.com');
INSERT INTO `customer` VALUES (19, '创新设计工作室', '0551-88776655', 'chuangxin@design.com');
INSERT INTO `customer` VALUES (20, '星辰传媒集团', '0371-67894321', 'xingchen@media.cn');
INSERT INTO `customer` VALUES (21, '海洋生物科技', '0898-76895432', 'haiyang@bio.com');
INSERT INTO `customer` VALUES (22, '智慧城市方案', '0931-45678901', 'zhihui@city.com');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `employee_id` int(0) NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `position` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `hire_date` date NOT NULL,
  `department` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`employee_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '王晓明', '销售经理', '2020-03-15', '销售部');
INSERT INTO `employee` VALUES (2, '李建军', '销售代表', '2021-05-10', '销售部');
INSERT INTO `employee` VALUES (3, '张海洋', '库存管理员', '2019-11-20', '仓储部');
INSERT INTO `employee` VALUES (4, '刘慧', '会计', '2020-08-03', '财务部');
INSERT INTO `employee` VALUES (5, '陈晓', '采购专员', '2021-01-12', '采购部');
INSERT INTO `employee` VALUES (6, '杨帆', '客服专员', '2022-02-28', '客服部');
INSERT INTO `employee` VALUES (7, '赵静', '行政主管', '2018-07-22', '行政部');
INSERT INTO `employee` VALUES (8, '周刚', '仓库助理', '2021-09-05', '仓储部');
INSERT INTO `employee` VALUES (9, '吴婷', '销售代表', '2020-04-18', '销售部');
INSERT INTO `employee` VALUES (10, '郑华', '财务助理', '2022-01-15', '财务部');
INSERT INTO `employee` VALUES (11, '孙小美', '客服主管', '2019-12-01', '客服部');
INSERT INTO `employee` VALUES (12, '钱程', '系统管理员', '2020-06-30', '技术部');
INSERT INTO `employee` VALUES (13, '李云', '市场专员', '2021-03-22', '市场部');
INSERT INTO `employee` VALUES (14, '周小舟', '采购经理', '2018-09-10', '采购部');
INSERT INTO `employee` VALUES (15, '吴天', '物流专员', '2021-07-15', '物流部');
INSERT INTO `employee` VALUES (16, '郑雪', '人事专员', '2020-02-14', '人力资源部');
INSERT INTO `employee` VALUES (17, '王磊', '技术支持', '2022-04-01', '技术部');
INSERT INTO `employee` VALUES (18, '李娜', '销售代表', '2021-11-11', '销售部');
INSERT INTO `employee` VALUES (19, '张勇', '仓库主管', '2019-05-28', '仓储部');
INSERT INTO `employee` VALUES (20, '刘芳', '客户经理', '2020-10-25', '客服部');
INSERT INTO `employee` VALUES (21, '陈琳', '产品专员', '2021-08-09', '产品部');
INSERT INTO `employee` VALUES (22, '杨光', '市场总监', '2018-12-12', '市场部');

-- ----------------------------
-- Table structure for inventory
-- ----------------------------
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory`  (
  `product_id` int(0) NOT NULL,
  `current_quantity` int(0) NOT NULL DEFAULT 0,
  `last_update` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`product_id`) USING BTREE,
  CONSTRAINT `fk_inventory_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventory
-- ----------------------------
INSERT INTO `inventory` VALUES (1, 0, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (2, 800, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (3, 140, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (4, 115, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (5, 570, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (6, 220, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (7, 92, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (8, 600, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (9, 195, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (10, 120, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (11, 140, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (12, 700, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (13, 400, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (14, 350, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (15, 100, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (16, 1000, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (17, 100, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (18, 50, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (19, 14, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (20, 250, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (21, 80, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (22, 950, '2025-06-22 14:01:19.410');
INSERT INTO `inventory` VALUES (24, 500, '2025-06-24 16:59:23.557');
INSERT INTO `inventory` VALUES (25, 500, '2025-06-24 16:59:23.558');

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `order_id` int(0) NOT NULL,
  `product_id` int(0) NOT NULL,
  `quantity` int(0) NOT NULL,
  `unit_price` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`order_id`, `product_id`) USING BTREE,
  INDEX `fk_order_detail_product`(`product_id`) USING BTREE,
  CONSTRAINT `fk_order_detail_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_detail_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES (1, 1, 50, 2.50);
INSERT INTO `order_detail` VALUES (1, 4, 20, 15.80);
INSERT INTO `order_detail` VALUES (1, 17, 100, 2.00);
INSERT INTO `order_detail` VALUES (2, 3, 5, 89.00);
INSERT INTO `order_detail` VALUES (2, 15, 10, 65.00);
INSERT INTO `order_detail` VALUES (3, 2, 100, 25.00);
INSERT INTO `order_detail` VALUES (3, 8, 50, 3.50);
INSERT INTO `order_detail` VALUES (3, 11, 10, 18.50);
INSERT INTO `order_detail` VALUES (4, 6, 30, 12.50);
INSERT INTO `order_detail` VALUES (4, 9, 5, 21.00);
INSERT INTO `order_detail` VALUES (5, 7, 8, 45.00);
INSERT INTO `order_detail` VALUES (5, 19, 1, 1200.00);
INSERT INTO `order_detail` VALUES (6, 10, 15, 32.00);
INSERT INTO `order_detail` VALUES (6, 20, 200, 2.30);
INSERT INTO `order_detail` VALUES (7, 5, 40, 8.90);
INSERT INTO `order_detail` VALUES (7, 16, 200, 5.00);
INSERT INTO `order_detail` VALUES (8, 12, 100, 4.50);
INSERT INTO `order_detail` VALUES (8, 13, 50, 16.80);
INSERT INTO `order_detail` VALUES (9, 14, 60, 9.90);
INSERT INTO `order_detail` VALUES (9, 18, 5, 28.00);
INSERT INTO `order_detail` VALUES (10, 1, 100, 2.50);
INSERT INTO `order_detail` VALUES (10, 22, 150, 6.80);
INSERT INTO `order_detail` VALUES (11, 3, 8, 89.00);
INSERT INTO `order_detail` VALUES (11, 7, 5, 45.00);
INSERT INTO `order_detail` VALUES (12, 4, 30, 15.80);
INSERT INTO `order_detail` VALUES (12, 5, 50, 8.90);
INSERT INTO `order_detail` VALUES (13, 6, 40, 12.50);
INSERT INTO `order_detail` VALUES (13, 8, 100, 3.50);
INSERT INTO `order_detail` VALUES (14, 9, 10, 21.00);
INSERT INTO `order_detail` VALUES (14, 10, 8, 32.00);
INSERT INTO `order_detail` VALUES (15, 11, 15, 18.50);
INSERT INTO `order_detail` VALUES (15, 12, 120, 4.50);
INSERT INTO `order_detail` VALUES (16, 13, 25, 16.80);
INSERT INTO `order_detail` VALUES (16, 14, 70, 9.90);
INSERT INTO `order_detail` VALUES (17, 15, 12, 65.00);
INSERT INTO `order_detail` VALUES (17, 16, 150, 5.00);
INSERT INTO `order_detail` VALUES (18, 17, 200, 2.00);
INSERT INTO `order_detail` VALUES (18, 18, 3, 28.00);
INSERT INTO `order_detail` VALUES (19, 19, 2, 1200.00);
INSERT INTO `order_detail` VALUES (19, 20, 180, 2.30);
INSERT INTO `order_detail` VALUES (20, 21, 3, 150.00);
INSERT INTO `order_detail` VALUES (20, 22, 120, 6.80);
INSERT INTO `order_detail` VALUES (21, 1, 80, 2.50);
INSERT INTO `order_detail` VALUES (21, 3, 6, 89.00);
INSERT INTO `order_detail` VALUES (35, 4, 9, 8.00);
INSERT INTO `order_detail` VALUES (36, 4, 9, 8.00);
INSERT INTO `order_detail` VALUES (37, 2, 9, 29.00);
INSERT INTO `order_detail` VALUES (38, 2, 9, 29.00);
INSERT INTO `order_detail` VALUES (47, 22, 1, 6.80);
INSERT INTO `order_detail` VALUES (55, 2, 1, 29.00);
INSERT INTO `order_detail` VALUES (59, 2, 1, 20.00);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `order_id` int(0) NOT NULL AUTO_INCREMENT,
  `customer_id` int(0) NOT NULL,
  `order_date` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `employee_id` int(0) NOT NULL,
  `delivery_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` enum('待处理','已发货','已完成','已取消') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '待处理',
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `fk_orders_customer`(`customer_id`) USING BTREE,
  INDEX `fk_orders_employee`(`employee_id`) USING BTREE,
  INDEX `idx_orders_status`(`status`) USING BTREE,
  INDEX `idx_orders_date`(`order_date`) USING BTREE,
  CONSTRAINT `fk_orders_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_orders_employee` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 1, '2025-06-22 14:01:19.412', 2, '北京市海淀区中关村大街101号', '待处理');
INSERT INTO `orders` VALUES (2, 3, '2025-06-22 14:01:19.412', 9, '上海市黄浦区南京东路88号', '已完成');
INSERT INTO `orders` VALUES (3, 2, '2025-06-22 14:01:19.412', 2, '广州市天河区珠江新城星汇园', '已完成');
INSERT INTO `orders` VALUES (4, 4, '2025-06-22 14:01:19.412', 18, '杭州市西湖区文三路199号', '已完成');
INSERT INTO `orders` VALUES (5, 5, '2025-06-22 14:01:19.412', 9, '深圳市福田区深南大道6001号', '已完成');
INSERT INTO `orders` VALUES (6, 6, '2025-06-22 14:01:19.412', 2, '成都市武侯区天府大道666号', '已完成');
INSERT INTO `orders` VALUES (7, 1, '2025-06-22 14:01:19.412', 18, '北京市朝阳区建国门外大街1号', '已发货');
INSERT INTO `orders` VALUES (8, 7, '2025-06-22 14:01:19.412', 2, '重庆市渝中区解放碑步行街', '待处理');
INSERT INTO `orders` VALUES (9, 8, '2025-06-22 14:01:19.412', 9, '南京市鼓楼区北京西路2号', '待处理');
INSERT INTO `orders` VALUES (10, 9, '2025-06-22 14:01:19.412', 18, '上海市浦东新区张江高科技园', '待处理');
INSERT INTO `orders` VALUES (11, 10, '2025-06-22 14:01:19.412', 2, '武汉市武昌区中南路99号', '已完成');
INSERT INTO `orders` VALUES (12, 11, '2025-06-22 14:01:19.412', 9, '西安市雁塔区小寨路108号', '待处理');
INSERT INTO `orders` VALUES (13, 12, '2025-06-22 14:01:19.412', 2, '长沙市岳麓区麓山路36号', '已发货');
INSERT INTO `orders` VALUES (14, 3, '2025-06-22 14:01:19.412', 18, '上海市浦东新区张江高科技园', '已发货');
INSERT INTO `orders` VALUES (15, 13, '2025-06-22 14:01:19.412', 2, '天津市和平区南京路75号', '已发货');
INSERT INTO `orders` VALUES (16, 14, '2025-06-22 14:01:19.412', 9, '郑州市金水区农业路东段', '待处理');
INSERT INTO `orders` VALUES (17, 15, '2025-06-22 14:01:19.412', 18, '合肥市蜀山区黄山路455号', '已完成');
INSERT INTO `orders` VALUES (18, 16, '2025-06-22 14:01:19.412', 2, '青岛市市南区香港中路9号', '已发货');
INSERT INTO `orders` VALUES (19, 17, '2025-06-22 14:01:19.412', 9, '厦门市思明区湖滨北路16号', '待处理');
INSERT INTO `orders` VALUES (20, 1, '2025-06-22 14:01:19.412', 18, '北京市海淀区清华大学', '已完成');
INSERT INTO `orders` VALUES (21, 18, '2025-06-22 14:01:19.412', 2, '大连市中山区人民路23号', '已发货');
INSERT INTO `orders` VALUES (35, 2, '2025-06-24 16:44:16.677', 2, 'aaaa', '待处理');
INSERT INTO `orders` VALUES (36, 2, '2025-06-24 16:44:19.951', 2, 'aaaa', '待处理');
INSERT INTO `orders` VALUES (37, 2, '2025-06-24 16:44:43.429', 2, 'aaaa', '待处理');
INSERT INTO `orders` VALUES (38, 22, '2025-06-24 16:46:04.410', 2, 'aaaa', '待处理');
INSERT INTO `orders` VALUES (47, 16, '2025-06-24 16:55:04.592', 4, 'AAAAA', '待处理');
INSERT INTO `orders` VALUES (55, 1, '2025-06-26 00:39:18.250', 3, 'xx区南京路', '待处理');
INSERT INTO `orders` VALUES (59, 1, '2025-06-26 14:36:06.229', 3, '江苏省', '待处理');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `product_id` int(0) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `unit_price` decimal(10, 2) NOT NULL,
  `supplier_id` int(0) NULL DEFAULT NULL,
  `is_discontinued` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`product_id`) USING BTREE,
  INDEX `fk_product_supplier`(`supplier_id`) USING BTREE,
  INDEX `idx_product_category`(`category`) USING BTREE,
  CONSTRAINT `fk_product_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, '中性笔0.5mm', '笔类', 19.01, 1, 0);
INSERT INTO `product` VALUES (2, 'a4复印纸', '纸品', 20.00, 14, 0);
INSERT INTO `product` VALUES (3, '无线鼠标', '电子产品', 17.00, 16, 0);
INSERT INTO `product` VALUES (4, '硬面抄笔记本', '本册', 8.00, 2, 0);
INSERT INTO `product` VALUES (5, '长尾夹', '装订用品', 8.90, 5, 0);
INSERT INTO `product` VALUES (6, '钢笔墨水', '墨水', 12.50, 8, 0);
INSERT INTO `product` VALUES (7, '计算器', '电子产品', 45.00, 17, 0);
INSERT INTO `product` VALUES (8, '透明胶带', '胶粘用品', 3.50, 6, 0);
INSERT INTO `product` VALUES (9, '荧光笔套装', '笔类', 21.00, 9, 0);
INSERT INTO `product` VALUES (10, '文件收纳盒', '收纳用品', 32.00, 3, 0);
INSERT INTO `product` VALUES (11, '订书机', '装订用品', 18.50, 2, 0);
INSERT INTO `product` VALUES (12, '记号笔', '笔类', 4.50, 7, 0);
INSERT INTO `product` VALUES (13, '铅笔套装', '笔类', 16.80, 11, 0);
INSERT INTO `product` VALUES (14, '绘图尺', '绘图工具', 9.90, 10, 0);
INSERT INTO `product` VALUES (15, 'u盘32gb', '电子产品', 65.00, 16, 0);
INSERT INTO `product` VALUES (16, '曲别针', '装订用品', 5.00, 5, 0);
INSERT INTO `product` VALUES (17, '橡皮擦', '修正用品', 2.00, 1, 0);
INSERT INTO `product` VALUES (18, '打孔机', '装订用品', 28.00, 4, 0);
INSERT INTO `product` VALUES (19, '投影仪', '电子产品', 1200.00, 18, 0);
INSERT INTO `product` VALUES (20, '文件袋', '收纳用品', 2.30, 3, 0);
INSERT INTO `product` VALUES (21, '电子笔', '电子产品', 150.00, 19, 0);
INSERT INTO `product` VALUES (22, '便签纸', '纸品', 6.80, 14, 0);
INSERT INTO `product` VALUES (24, '高级笔记本', '文具', 15.00, 23, 1);
INSERT INTO `product` VALUES (25, '黑色圆珠笔', '文具', 3.50, 23, 0);

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier`  (
  `supplier_id` int(0) NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`supplier_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of supplier
-- ----------------------------
INSERT INTO `supplier` VALUES (1, '晨光文具', '021-56781234', '上海市浦东新区张江路123号', 1);
INSERT INTO `supplier` VALUES (2, '得力集团', '0574-63889999', '宁波市宁海县得力工业园', 1);
INSERT INTO `supplier` VALUES (3, '齐心办公', '0755-26659999', '深圳市南山区科技园', 1);
INSERT INTO `supplier` VALUES (4, '真彩文具', '0760-88776655', '中山市火炬开发区', 1);
INSERT INTO `supplier` VALUES (5, '广博集团', '0574-88485678', '宁波市海曙区', 1);
INSERT INTO `supplier` VALUES (6, '三木控股', '0576-87221133', '台州市黄岩区', 1);
INSERT INTO `supplier` VALUES (7, '国誉文具', '021-62376789', '上海市长宁区', 1);
INSERT INTO `supplier` VALUES (8, '百乐文具', '0755-26465544', '深圳市福田区', 1);
INSERT INTO `supplier` VALUES (9, '派通文具', '020-84563214', '广州市天河区', 1);
INSERT INTO `supplier` VALUES (10, '樱花文具', '0512-57789900', '苏州市工业园区', 1);
INSERT INTO `supplier` VALUES (11, '马可铅笔', '0559-25856778', '安徽省黄山市', 1);
INSERT INTO `supplier` VALUES (12, '辉柏嘉', '020-83652447', '广州市越秀区', 1);
INSERT INTO `supplier` VALUES (13, '施耐德', '021-52438765', '上海市静安区', 1);
INSERT INTO `supplier` VALUES (14, '亚太森博', '0755-83456721', '深圳市宝安区', 1);
INSERT INTO `supplier` VALUES (15, '益而高', '0769-83845632', '东莞市', 1);
INSERT INTO `supplier` VALUES (16, '佳能办公', '021-38764532', '上海市浦东新区', 1);
INSERT INTO `supplier` VALUES (17, '理光办公', '0755-87654321', '深圳市南山区', 1);
INSERT INTO `supplier` VALUES (18, '兄弟办公', '020-76543219', '广州市黄埔区', 1);
INSERT INTO `supplier` VALUES (19, '欧迪办公', '010-68976543', '北京市海淀区', 1);
INSERT INTO `supplier` VALUES (20, '史泰博', '021-58907654', '上海市杨浦区', 1);
INSERT INTO `supplier` VALUES (21, '金万年', '020-87845632', '广州市白云区', 1);
INSERT INTO `supplier` VALUES (22, '白雪文具', '0532-85674563', '青岛市城阳区', 1);
INSERT INTO `supplier` VALUES (23, '小何文具', '021-5678144', '上海市浦东新区666路123号', 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `name` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `pwd` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `role` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('xiaoming', '123456', '访客');
INSERT INTO `user` VALUES ('root123', '1234', '管理员');

-- ----------------------------
-- View structure for customer_order_details
-- ----------------------------
DROP VIEW IF EXISTS `customer_order_details`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `customer_order_details` AS select `c`.`customer_id` AS `客户id`,`c`.`customer_name` AS `客户名称`,`o`.`order_id` AS `订单id`,date_format(`o`.`order_date`,'%y-%m-%d %h:%i') AS `订单时间`,`e`.`employee_name` AS `处理员工`,`o`.`delivery_address` AS `送货地址`,`o`.`status` AS `订单状态`,`p`.`product_name` AS `商品名称`,`od`.`quantity` AS `购买数量`,`od`.`unit_price` AS `单价`,(`od`.`quantity` * `od`.`unit_price`) AS `小计金额` from ((((`orders` `o` join `customer` `c` on((`o`.`customer_id` = `c`.`customer_id`))) join `employee` `e` on((`o`.`employee_id` = `e`.`employee_id`))) join `order_detail` `od` on((`o`.`order_id` = `od`.`order_id`))) join `product` `p` on((`od`.`product_id` = `p`.`product_id`)));

-- ----------------------------
-- View structure for inventory_overview
-- ----------------------------
DROP VIEW IF EXISTS `inventory_overview`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `inventory_overview` AS select `p`.`product_id` AS `商品id`,`p`.`product_name` AS `商品名称`,`p`.`category` AS `商品类别`,`p`.`unit_price` AS `单价`,`s`.`supplier_name` AS `供应商`,`i`.`current_quantity` AS `当前库存`,(case when (`i`.`current_quantity` = 0) then '缺货' when (`i`.`current_quantity` <= 10) then '低库存' else '充足' end) AS `库存状态` from ((`inventory` `i` join `product` `p` on((`i`.`product_id` = `p`.`product_id`))) join `supplier` `s` on((`p`.`supplier_id` = `s`.`supplier_id`)));

-- ----------------------------
-- View structure for sales_summary
-- ----------------------------
DROP VIEW IF EXISTS `sales_summary`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `sales_summary` AS select `p`.`product_id` AS `商品id`,`p`.`product_name` AS `商品名称`,`p`.`category` AS `商品类别`,count(distinct `o`.`order_id`) AS `销售订单数`,sum(`od`.`quantity`) AS `销售总量`,sum((`od`.`quantity` * `od`.`unit_price`)) AS `销售总额`,avg((`od`.`quantity` * `od`.`unit_price`)) AS `平均订单金额` from ((`order_detail` `od` join `orders` `o` on((`od`.`order_id` = `o`.`order_id`))) join `product` `p` on((`od`.`product_id` = `p`.`product_id`))) where (`o`.`status` in ('已发货','已完成')) group by `p`.`product_id`;

-- ----------------------------
-- Function structure for active_supplier_products
-- ----------------------------
DROP FUNCTION IF EXISTS `active_supplier_products`;
delimiter ;;
CREATE FUNCTION `active_supplier_products`(p_supplier_id int)
 RETURNS int
  DETERMINISTIC
begin
    declare v_count int;
    
    -- 统计供应商在售商品
    select count(*) 
    into v_count
    from product
    where supplier_id = p_supplier_id
      and is_discontinued = false;
      
    return v_count;
end
;;
delimiter ;

-- ----------------------------
-- Function structure for calculate_inventory_value
-- ----------------------------
DROP FUNCTION IF EXISTS `calculate_inventory_value`;
delimiter ;;
CREATE FUNCTION `calculate_inventory_value`(p_product_id int)
 RETURNS decimal(10,2)
  DETERMINISTIC
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
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for place_order
-- ----------------------------
DROP PROCEDURE IF EXISTS `place_order`;
delimiter ;;
CREATE PROCEDURE `place_order`(in p_customer_id int,
    in p_employee_id int,
    in p_delivery_address varchar(200),
    in p_product_id int,
    in p_quantity int)
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
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_product_price
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_product_price`;
delimiter ;;
CREATE PROCEDURE `update_product_price`(in p_product_id int,
    in p_new_price decimal(10,2),
    in p_reason varchar(200))
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
end
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table order_detail
-- ----------------------------
DROP TRIGGER IF EXISTS `tr_order_detail_before_insert`;
delimiter ;;
CREATE TRIGGER `tr_order_detail_before_insert` BEFORE INSERT ON `order_detail` FOR EACH ROW begin
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
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table orders
-- ----------------------------
DROP TRIGGER IF EXISTS `orders_before_update_status`;
delimiter ;;
CREATE TRIGGER `orders_before_update_status` BEFORE UPDATE ON `orders` FOR EACH ROW begin
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
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
