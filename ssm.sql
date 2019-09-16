/*
 Navicat Premium Data Transfer

 Source Server         : root
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : ssm

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 23/11/2018 07:33:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `age` int(3) NOT NULL,
  `department` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tel` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '员工1', '男', 50, '人事部', 'guodegang@foxmail.com', '12345678');
INSERT INTO `employee` VALUES (2, '员工2', '男', 35, '研发部', 'guodegang@foxmail.com', '12345678');
INSERT INTO `employee` VALUES (3, '员工3', '男', 23, '生产部', 'guodegang@foxmail.com', '12345678');
INSERT INTO `employee` VALUES (4, '员工4', '女', 31, '财务部', 'guodegang@foxmail.com', '12345678');
INSERT INTO `employee` VALUES (5, '员工5', '男', 41, '人事部', 'guodegang@foxmail.com', '12345678');
INSERT INTO `employee` VALUES (6, '员工6', '女', 30, '研发部', 'guodegang@foxmail.com', '12345678');
INSERT INTO `employee` VALUES (7, '员工7', '男', 30, '生产部', 'guodegang@foxmail.com', '12345678');
INSERT INTO `employee` VALUES (8, '员工8', '女', 25, '财务部', 'guodegang@foxmail.com', '12345678');
INSERT INTO `employee` VALUES (9, '员工9', '男', 18, '人事部', 'guodegang@foxmail.com', '12345678');
INSERT INTO `employee` VALUES (10, '员工10', '男', 49, '研发部', 'guodegang@foxmail.com', '12345678');
INSERT INTO `employee` VALUES (77, '员工11', '男', 25, '生产部', 'guodegang@foxmail.com', '12345678');
INSERT INTO `employee` VALUES (78, '员工12', '女', 31, '人事部', 'guodegang@foxmail.com', '12345678');
INSERT INTO `employee` VALUES (80, '员工13', '男', 18, '管理层', '123', '123');
INSERT INTO `employee` VALUES (81, '员工14', '女', 25, '生产部', '123', '123');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_identity` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_status` int(255) NOT NULL DEFAULT 0,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'jackma', '123', 'superadmin', 1);
INSERT INTO `role` VALUES (2, 'manager', '123', 'admin', 0);
INSERT INTO `role` VALUES (3, 'user', '123', 'user', 1);
INSERT INTO `role` VALUES (4, 'user2', '123', 'user', 1);
INSERT INTO `role` VALUES (5, 'user3', '123', 'user', 1);
INSERT INTO `role` VALUES (7, 'user3', '123', 'admin', 1);
INSERT INTO `role` VALUES (9, 'use4', '123', 'user', 0);

SET FOREIGN_KEY_CHECKS = 1;
