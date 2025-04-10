/*
 Navicat Premium Data Transfer

 Source Server         : asd
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : errand

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 10/04/2025 19:00:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `door_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '门牌号',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系人',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '关联用户ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '联系人信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, '西16楼', '509', 'sdf', '12314', 2);
INSERT INTO `address` VALUES (6, '1', '1', '2', '3', NULL);
INSERT INTO `address` VALUES (7, 'dfg', '12', 'gh', '131', 4);
INSERT INTO `address` VALUES (8, 'qwe', 'df', '13', 'dfg', 4);
INSERT INTO `address` VALUES (9, 'sdfs', '123', '2342', '123', 2);

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', '管理员', 'http://localhost:9090/files/1697438073596-avatar.png', 'ADMIN', '13677889922', 'admin@xm.com');

-- ----------------------------
-- Table structure for certification
-- ----------------------------
DROP TABLE IF EXISTS `certification`;
CREATE TABLE `certification`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '账号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '本人照片',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系方式',
  `card_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证号码',
  `card1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证正面',
  `card2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证反面',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '常住地址',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '待审核' COMMENT '审核状态',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核理由',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '认证信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of certification
-- ----------------------------
INSERT INTO `certification` VALUES (6, 1, 'hhfj', NULL, '1434', '1531', NULL, NULL, 'bj', '待审核', NULL);
INSERT INTO `certification` VALUES (7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '待审核', NULL);
INSERT INTO `certification` VALUES (8, 2, '测试', 'http://localhost:9090/files/1714705480176-UMgRpbsfihLya3951df5c9467166b5b0d9fbbb776522.jpg', '12312', '34234', 'http://localhost:9090/files/1714705486892-4MjxwfExVKt9dc5eda37f0dc2990c81107be154c4b29.jpg', 'http://localhost:9090/files/1714705489668-DXo40PxkOdW53e1a610f295f844f99fe87ea2111ef37.png', '豆腐干豆腐干', '通过', NULL);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论',
  `star` double(10, 1) NULL DEFAULT 0.0 COMMENT '评分',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `accept_id` int(11) NULL DEFAULT NULL COMMENT '骑手ID',
  `order_id` int(11) NULL DEFAULT NULL COMMENT '订单ID',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`, `order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '评价表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 'ok', 5.0, 2, 2, 17, '2024-05-18 15:58:21');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '公告信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '今天系统正式上线，开始内测', '今天系统正式上线，开始内测', '2023-09-05', 'admin');
INSERT INTO `notice` VALUES (2, '所有功能都已完成，可以正常使用', '所有功能都已完成，可以正常使用', '2023-09-05', 'admin');
INSERT INTO `notice` VALUES (3, '今天天气很不错，可以出去一起玩了', '今天天气很不错，可以出去一起玩了', '2023-09-05', 'admin');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '物品名称',
  `descr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '物品图片',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '物品类型',
  `weight` double(10, 2) NULL DEFAULT NULL COMMENT '物品重量',
  `price` double(10, 2) NULL DEFAULT NULL COMMENT '小费',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '发起人ID',
  `accept_id` int(11) NULL DEFAULT NULL COMMENT '接单人ID',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
  `accept_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '接单时间',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单状态',
  `address_id` int(11) NULL DEFAULT NULL COMMENT '取货地址ID',
  `target_id` int(11) NULL DEFAULT NULL COMMENT '送货地址ID',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '订单信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (14, '1786300666529783808', '1341', NULL, NULL, '代拿快递', NULL, 1.00, 2, 2, '2024-05-03 15:34:01', '2024-05-03 15:44:11', '待评价', 9, 1, NULL);
INSERT INTO `orders` VALUES (15, '1788571994355929088', 'cvb', NULL, NULL, '代拿快递', NULL, 2.00, 2, 2, '2024-05-09 22:09:28', '2024-05-09 22:09:36', '待评价', 9, 1, NULL);
INSERT INTO `orders` VALUES (16, '1788572211859951616', 'cbc', NULL, NULL, '代拿快递', NULL, 2.00, 2, NULL, '2024-05-09 22:10:20', NULL, '已取消', 9, 1, NULL);
INSERT INTO `orders` VALUES (17, '1788575339946708992', 'j,jjk', NULL, NULL, '代拿快递', NULL, 1.00, 2, 2, '2024-05-09 22:22:45', '2024-05-09 22:22:52', '已完成', 9, 1, NULL);
INSERT INTO `orders` VALUES (18, '1788576682983878656', 'fghj', NULL, NULL, '代买零食', NULL, 1.00, 2, NULL, '2024-05-09 22:28:06', NULL, '已取消', 9, 1, NULL);

-- ----------------------------
-- Table structure for records
-- ----------------------------
DROP TABLE IF EXISTS `records`;
CREATE TABLE `records`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '事件',
  `money` decimal(10, 2) NULL DEFAULT NULL COMMENT '金额',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '时间',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '收支明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of records
-- ----------------------------
INSERT INTO `records` VALUES (5, '下单j,jjk', 1.00, 2, '2024-05-09 22:22:45', '支出');
INSERT INTO `records` VALUES (6, '接单j,jjk', 1.00, 2, '2024-05-09 22:23:16', '骑手');
INSERT INTO `records` VALUES (7, '支出fghj', 1.00, 2, '2024-05-09 22:28:06', '支出');
INSERT INTO `records` VALUES (8, '取消订单fghj', 1.00, 2, '2024-05-09 22:28:09', '取消');
INSERT INTO `records` VALUES (9, '充值', 6.00, 2, '2024-05-18 16:02:50', '充值');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png' COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `account` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '余额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'asd', '123', 'dfg', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', 'USER', '1', '123', 11.00);
INSERT INTO `user` VALUES (2, 'user', '123', 'user', 'http://localhost:9090/files/1714459593256-nZAOqM5DMt2la3951df5c9467166b5b0d9fbbb776522.jpg', 'USER', '1', NULL, 11.00);
INSERT INTO `user` VALUES (3, 'users', '123', 'users', 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png', 'USER', NULL, NULL, 1.00);
INSERT INTO `user` VALUES (4, '123', '123', '123', 'http://localhost:9090/files/1714377750474-Vbf3ytJEazXWdc5eda37f0dc2990c81107be154c4b29.jpg', 'USER', NULL, NULL, 0.00);

SET FOREIGN_KEY_CHECKS = 1;
