/*
Navicat MySQL Data Transfer

Source Server         : php
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : vue-admin

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-11-28 21:03:25
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
  `role_id` mediumint(8) unsigned NOT NULL COMMENT '角色',
  `rule_name` varchar(255) NOT NULL COMMENT '规则唯一英文标识,全小写',
  `type` varchar(30) DEFAULT NULL COMMENT '权限规则分类，请加应用前缀,如admin_',
  KEY `role_id` (`role_id`),
  KEY `rule_name` (`rule_name`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='权限授权表';

-- ----------------------------
-- Records of lmx_auth_access
-- ----------------------------
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/System/updateSiteConfig', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('2', 'admin/Backup/del_backup', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('2', 'admin/Backup/import', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/System/siteConfig', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Setting/default', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('2', 'admin/Backup/restore', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('2', 'admin/Backup/index', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('2', 'admin/Backup/default', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('2', 'admin/System/siteConfig', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('2', 'admin/System/updateSiteConfig', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('2', 'admin/Setting/default', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('2', 'admin/Backup/download', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('2', 'admin/Node/default', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('2', 'admin/Node/index', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('2', 'admin/Node/add', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Backup/default', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Backup/index', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Backup/restore', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Backup/import', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Backup/del_backup', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Backup/download', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Users/default', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Users/default', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Users/index', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Admin/default', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Rbac/index', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Admin/index', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Admin/add', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Admin/edit', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Admin/delete', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Node/default', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Node/index', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Node/add', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Node/edit', 'admin');
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/Node/delete', 'admin');

-- ----------------------------
-- Table structure for lmx_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `lmx_auth_rule`;
CREATE TABLE `lmx_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则编号',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一标识',
  `title` char(20) DEFAULT '' COMMENT '规则中文名称',
  `type` tinyint(1) DEFAULT '1' COMMENT '规则类型',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态：为1正常，为0禁用',
  `condition` char(100) DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证',
  `listorder` int(10) DEFAULT '0' COMMENT '排序，优先级，越小优先级越高',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- Records of lmx_auth_rule
-- ----------------------------
INSERT INTO `lmx_auth_rule` VALUES ('45', 'admin/Node/default', '菜单管理', '1', '1', '', '0', '1488007070', '1488007070');
INSERT INTO `lmx_auth_rule` VALUES ('46', 'admin/System/siteConfig', '网站配置', '1', '1', '', '0', '1488043079', '1489038654');
INSERT INTO `lmx_auth_rule` VALUES ('47', 'admin/System/updateSiteConfig', '更新配置', '1', '1', '', '0', '1488043231', '1488043231');
INSERT INTO `lmx_auth_rule` VALUES ('48', 'admin/Backup/default', '备份管理', '1', '1', '', '0', '1488044935', '1488044935');
INSERT INTO `lmx_auth_rule` VALUES ('31', 'admin/Node/index', '后台菜单', '1', '1', '', '0', '1487789220', '1487950594');
INSERT INTO `lmx_auth_rule` VALUES ('32', 'admin/Node/add', '添加菜单', '1', '1', '', '0', '1487789234', '1487789234');
INSERT INTO `lmx_auth_rule` VALUES ('33', 'admin/Node/delete', '删除菜单', '1', '1', '', '0', '1487789246', '1487789246');
INSERT INTO `lmx_auth_rule` VALUES ('34', 'admin/Node/edit', '编辑菜单', '1', '1', '', '0', '1487789255', '1487789255');
INSERT INTO `lmx_auth_rule` VALUES ('35', 'admin/Setting/default', '设置', '1', '1', '', '0', '1487951321', '1487951321');
INSERT INTO `lmx_auth_rule` VALUES ('36', 'admin/Users/default', '用户组', '1', '1', '', '0', '1487951847', '1487999511');
INSERT INTO `lmx_auth_rule` VALUES ('37', 'admin/Users/index', '本站用户', '1', '1', '', '0', '1487954667', '1487999501');
INSERT INTO `lmx_auth_rule` VALUES ('38', 'admin/Admin/default', '管理组', '1', '1', '', '0', '1487954732', '1487954732');
INSERT INTO `lmx_auth_rule` VALUES ('39', 'admin/Admin/index', '管理员', '1', '1', '', '0', '1487957700', '1487999532');
INSERT INTO `lmx_auth_rule` VALUES ('40', 'admin/Admin/add', '添加管理员', '1', '1', '', '0', '1487966778', '1487966778');
INSERT INTO `lmx_auth_rule` VALUES ('41', 'admin/Admin/edit', '编辑管理员', '1', '1', '', '0', '1487966821', '1487966821');
INSERT INTO `lmx_auth_rule` VALUES ('42', 'admin/Admin/delete', '删除管理员', '1', '1', '', '0', '1487966874', '1487966874');
INSERT INTO `lmx_auth_rule` VALUES ('43', 'admin/Role/index', '角色管理', '1', '1', '', '0', '1487997838', '1487997838');
INSERT INTO `lmx_auth_rule` VALUES ('44', 'admin/Rbac/index', '角色管理', '1', '1', '', '0', '1487998167', '1487999640');
INSERT INTO `lmx_auth_rule` VALUES ('49', 'admin/Backup/index', '数据备份', '1', '1', '', '0', '1488044981', '1488044981');
INSERT INTO `lmx_auth_rule` VALUES ('50', 'admin/Backup/restore', '数据列表', '1', '1', '', '0', '1488045030', '1488052426');
INSERT INTO `lmx_auth_rule` VALUES ('51', 'admin/Backup/import', '数据恢复', '1', '1', '', '0', '1488052552', '1488052552');
INSERT INTO `lmx_auth_rule` VALUES ('52', 'admin/Backup/del_backup', '数据删除', '1', '1', '', '0', '1488052594', '1488052594');
INSERT INTO `lmx_auth_rule` VALUES ('53', 'admin/Backup/download', '数据下载', '1', '1', '', '0', '1488052624', '1488052624');
INSERT INTO `lmx_auth_rule` VALUES ('54', 'admin/Content/default', '内容管理', '1', '1', '', '0', '1488597861', '1488597861');
INSERT INTO `lmx_auth_rule` VALUES ('82', 'admin/ArticleCategory/add', '添加分类', '1', '1', '', '0', '1493105153', '1493105153');
INSERT INTO `lmx_auth_rule` VALUES ('83', 'admin/ArticleCategory/edit', '编辑分类', '1', '1', '', '0', '1493105215', '1493105215');
INSERT INTO `lmx_auth_rule` VALUES ('84', 'admin/ArticleCategory/delete', '删除分类', '1', '1', '', '0', '1493105222', '1493105222');
INSERT INTO `lmx_auth_rule` VALUES ('85', 'admin/Article/add', '添加文章', '1', '1', '', '0', '1493105255', '1493105255');
INSERT INTO `lmx_auth_rule` VALUES ('59', 'admin/Article/index', '文章列表', '1', '1', '', '0', '1488691790', '1493103716');
INSERT INTO `lmx_auth_rule` VALUES ('60', 'admin/System/setAppAndroidConfig', 'android配置', '1', '1', '', '0', '1489031361', '1489031361');
INSERT INTO `lmx_auth_rule` VALUES ('61', 'admin/System/upAppAndroidConfig', '更新android配置', '1', '1', '', '0', '1489031431', '1489031431');
INSERT INTO `lmx_auth_rule` VALUES ('62', 'admin/Tool/default', '扩展工具', '1', '1', '', '0', '1489476084', '1489547712');
INSERT INTO `lmx_auth_rule` VALUES ('81', 'admin/ArticleCategory/index', '文章分类', '1', '1', '', '0', '1493103763', '1493111457');
INSERT INTO `lmx_auth_rule` VALUES ('80', 'admin/Article/default', '文章管理', '1', '1', '', '0', '1493103540', '1493103683');
INSERT INTO `lmx_auth_rule` VALUES ('65', 'admin/Slide/default', '幻灯片', '1', '1', '', '0', '1489489395', '1489489395');
INSERT INTO `lmx_auth_rule` VALUES ('66', 'admin/Slide/index', '幻灯片管理', '1', '1', '', '0', '1489489421', '1489489421');
INSERT INTO `lmx_auth_rule` VALUES ('67', 'admin/SlideCat/index', '幻灯片分类', '1', '1', '', '0', '1489489448', '1489489448');
INSERT INTO `lmx_auth_rule` VALUES ('68', 'admin/Slide/add', '添加幻灯片', '1', '1', '', '0', '1489546558', '1489546558');
INSERT INTO `lmx_auth_rule` VALUES ('69', 'admin/Slide/edit', '编辑幻灯片', '1', '1', '', '0', '1489546580', '1489546580');
INSERT INTO `lmx_auth_rule` VALUES ('70', 'admin/Slide/delete', '删除幻灯片', '1', '1', '', '0', '1489546608', '1489546608');
INSERT INTO `lmx_auth_rule` VALUES ('71', 'admin/SlideCat/add', '添加幻灯片分类', '1', '1', '', '0', '1489546644', '1489546644');
INSERT INTO `lmx_auth_rule` VALUES ('72', 'admin/SlideCat/edit', '编辑幻灯片分类', '1', '1', '', '0', '1489546670', '1489546670');
INSERT INTO `lmx_auth_rule` VALUES ('73', 'admin/SlideCat/delete', '删除幻灯片分类', '1', '1', '', '0', '1489546702', '1489546702');
INSERT INTO `lmx_auth_rule` VALUES ('74', 'admin/AppRecommend/index', '推荐应用管理', '1', '1', '', '0', '1489554977', '1489554977');
INSERT INTO `lmx_auth_rule` VALUES ('75', 'admin/AppRecommend/add', '添加推荐应用', '1', '1', '', '0', '1489555011', '1489555011');
INSERT INTO `lmx_auth_rule` VALUES ('76', 'admin/AppRecommend/edit', '编辑推荐应用', '1', '1', '', '0', '1489555035', '1489555035');
INSERT INTO `lmx_auth_rule` VALUES ('77', 'admin/AppRecommend/delete', '删除推荐应用', '1', '1', '', '0', '1489555118', '1489555118');
INSERT INTO `lmx_auth_rule` VALUES ('78', 'admin/AppRecommend/setShowCount', '客户端的显示数量', '1', '1', '', '0', '1489555243', '1489555256');
INSERT INTO `lmx_auth_rule` VALUES ('79', 'admin/AppRecommend/setAppRecommendConf', '推荐应用配置', '1', '1', '', '0', '1489557777', '1489557777');
INSERT INTO `lmx_auth_rule` VALUES ('86', 'admin/Article/edit', '编辑文章', '1', '1', '', '0', '1493105273', '1493105273');
INSERT INTO `lmx_auth_rule` VALUES ('87', 'admin/Article/delete', '删除文章', '1', '1', '', '0', '1493105291', '1493105291');

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
