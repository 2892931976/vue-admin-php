/*
Navicat MySQL Data Transfer

Source Server         : php
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : vue-admin

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-12-08 21:25:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for lmx_admin
-- ----------------------------
DROP TABLE IF EXISTS `lmx_admin`;
CREATE TABLE `lmx_admin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(60) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码；sp_password加密',
  `tel` varchar(50) NOT NULL DEFAULT '' COMMENT '用户手机号',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `avatar` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `sex` smallint(1) DEFAULT '0' COMMENT '性别；0：保密，1：男；2：女',
  `last_login_ip` varchar(16) DEFAULT NULL COMMENT '最后登录ip',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常 ；2：未验证',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`username`),
  KEY `user_nicename` (`tel`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of lmx_admin
-- ----------------------------
INSERT INTO `lmx_admin` VALUES ('2', 'admin', 'c3284d0f94606de1fd2af172aba15bf3', 'admin', 'lmxdawn@gmail.com', null, '0', '127.0.0.1', '1493103488', '1487868050', '1');
INSERT INTO `lmx_admin` VALUES ('5', 'demo', '6c5ac7b4d3bd3311f033f971196cfa75', 'demo', '862253272@qq.com', null, '1', '127.0.0.1', '1488169490', '1487966028', '1');
INSERT INTO `lmx_admin` VALUES ('6', 'demo1', '655e9d2a52f932bdde5ba3e0c544a6b9', 'demo1', '', null, '0', null, '0', '1487966314', '1');
INSERT INTO `lmx_admin` VALUES ('7', 'test', 'fb469d7ef430b0baf0cab6c436e70375', '', '', null, '0', null, '0', '1511865902', '0');
INSERT INTO `lmx_admin` VALUES ('8', 'test2', '7bfc85c0d74ff05806e0b5a0fa0c1df1', '', '', null, '0', null, '0', '1511868251', '0');
INSERT INTO `lmx_admin` VALUES ('9', 'test3', '7bfc85c0d74ff05806e0b5a0fa0c1df1', '', '', null, '0', null, '0', '1511868307', '1');
INSERT INTO `lmx_admin` VALUES ('10', 's', '0305d718926ac8776a442023509c21ce', '', '', null, '0', null, '0', '1511868379', '1');

-- ----------------------------
-- Table structure for lmx_auth_access
-- ----------------------------
DROP TABLE IF EXISTS `lmx_auth_access`;
CREATE TABLE `lmx_auth_access` (
  `role_id` int(11) unsigned NOT NULL COMMENT '角色',
  `auth_rule_id` int(11) NOT NULL DEFAULT '0' COMMENT '权限id',
  `type` varchar(30) DEFAULT NULL COMMENT '权限规则分类，请加应用前缀,如admin_',
  KEY `role_id` (`role_id`),
  KEY `rule_name` (`auth_rule_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='权限授权表';

-- ----------------------------
-- Records of lmx_auth_access
-- ----------------------------

-- ----------------------------
-- Table structure for lmx_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `lmx_auth_rule`;
CREATE TABLE `lmx_auth_rule` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则编号',
  `pid` int(11) DEFAULT '0' COMMENT '父级id',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一标识',
  `title` char(20) DEFAULT '' COMMENT '规则中文名称',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态：为1正常，为0禁用',
  `condition` char(100) DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证',
  `listorder` int(10) DEFAULT '0' COMMENT '排序，优先级，越小优先级越高',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- Records of lmx_auth_rule
-- ----------------------------

-- ----------------------------
-- Table structure for lmx_role
-- ----------------------------
DROP TABLE IF EXISTS `lmx_role`;
CREATE TABLE `lmx_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '角色名称',
  `pid` smallint(6) DEFAULT NULL COMMENT '父角色ID',
  `status` tinyint(1) unsigned DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `listorder` int(3) NOT NULL DEFAULT '0' COMMENT '排序，优先级，越小优先级越高',
  PRIMARY KEY (`id`),
  KEY `parentId` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of lmx_role
-- ----------------------------
INSERT INTO `lmx_role` VALUES ('1', '超级管理员', '0', '1', '拥有网站最高管理员权限！', '1329633709', '1329633709', '0');
INSERT INTO `lmx_role` VALUES ('2', '普通管理', '0', '1', '测试', '0', '0', '0');

-- ----------------------------
-- Table structure for lmx_role_admin
-- ----------------------------
DROP TABLE IF EXISTS `lmx_role_admin`;
CREATE TABLE `lmx_role_admin` (
  `role_id` int(11) unsigned DEFAULT '0' COMMENT '角色 id',
  `admin_id` int(11) DEFAULT '0' COMMENT '管理员id',
  KEY `group_id` (`role_id`),
  KEY `user_id` (`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户角色对应表';

-- ----------------------------
-- Records of lmx_role_admin
-- ----------------------------
INSERT INTO `lmx_role_admin` VALUES ('1', '3');
INSERT INTO `lmx_role_admin` VALUES ('3', '3');
INSERT INTO `lmx_role_admin` VALUES ('1', '5');
INSERT INTO `lmx_role_admin` VALUES ('2', '2');
INSERT INTO `lmx_role_admin` VALUES ('2', '5');
