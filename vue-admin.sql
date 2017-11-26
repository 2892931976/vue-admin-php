/*
 Navicat Premium Data Transfer

 Source Server         : php
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost
 Source Database       : vue-admin

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : utf-8

 Date: 11/26/2017 22:18:08 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `lmx_admin`
-- ----------------------------
DROP TABLE IF EXISTS `lmx_admin`;
CREATE TABLE `lmx_admin` (
  `admin_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(60) NOT NULL DEFAULT '' COMMENT '用户名',
  `pass` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码；sp_password加密',
  `tel` varchar(50) NOT NULL DEFAULT '' COMMENT '用户手机号',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `avatar` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `sex` smallint(1) DEFAULT '0' COMMENT '性别；0：保密，1：男；2：女',
  `last_login_ip` varchar(16) DEFAULT NULL COMMENT '最后登录ip',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常 ；2：未验证',
  PRIMARY KEY (`admin_id`),
  KEY `user_login_key` (`admin_name`),
  KEY `user_nicename` (`tel`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='后台用户表';

-- ----------------------------
--  Records of `lmx_admin`
-- ----------------------------
BEGIN;
INSERT INTO `lmx_admin` VALUES ('2', 'admin', 'c3284d0f94606de1fd2af172aba15bf3', 'admin', 'lmxdawn@gmail.com', null, '0', '127.0.0.1', '1493103488', '1487868050', '1'), ('5', 'demo', '6c5ac7b4d3bd3311f033f971196cfa75', 'demo', '862253272@qq.com', null, '1', '127.0.0.1', '1488169490', '1487966028', '1'), ('6', 'demo1', '655e9d2a52f932bdde5ba3e0c544a6b9', 'demo1', '', null, '0', null, '0', '1487966314', '1');
COMMIT;

-- ----------------------------
--  Table structure for `lmx_auth_access`
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
--  Records of `lmx_auth_access`
-- ----------------------------
BEGIN;
INSERT INTO `lmx_auth_access` VALUES ('1', 'admin/System/updateSiteConfig', 'admin'), ('2', 'admin/Backup/del_backup', 'admin'), ('2', 'admin/Backup/import', 'admin'), ('1', 'admin/System/siteConfig', 'admin'), ('1', 'admin/Setting/default', 'admin'), ('2', 'admin/Backup/restore', 'admin'), ('2', 'admin/Backup/index', 'admin'), ('2', 'admin/Backup/default', 'admin'), ('2', 'admin/System/siteConfig', 'admin'), ('2', 'admin/System/updateSiteConfig', 'admin'), ('2', 'admin/Setting/default', 'admin'), ('2', 'admin/Backup/download', 'admin'), ('2', 'admin/Node/default', 'admin'), ('2', 'admin/Node/index', 'admin'), ('2', 'admin/Node/add', 'admin'), ('1', 'admin/Backup/default', 'admin'), ('1', 'admin/Backup/index', 'admin'), ('1', 'admin/Backup/restore', 'admin'), ('1', 'admin/Backup/import', 'admin'), ('1', 'admin/Backup/del_backup', 'admin'), ('1', 'admin/Backup/download', 'admin'), ('1', 'admin/Users/default', 'admin'), ('1', 'admin/Users/default', 'admin'), ('1', 'admin/Users/index', 'admin'), ('1', 'admin/Admin/default', 'admin'), ('1', 'admin/Rbac/index', 'admin'), ('1', 'admin/Admin/index', 'admin'), ('1', 'admin/Admin/add', 'admin'), ('1', 'admin/Admin/edit', 'admin'), ('1', 'admin/Admin/delete', 'admin'), ('1', 'admin/Node/default', 'admin'), ('1', 'admin/Node/index', 'admin'), ('1', 'admin/Node/add', 'admin'), ('1', 'admin/Node/edit', 'admin'), ('1', 'admin/Node/delete', 'admin');
COMMIT;

-- ----------------------------
--  Table structure for `lmx_auth_rule`
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
--  Records of `lmx_auth_rule`
-- ----------------------------
BEGIN;
INSERT INTO `lmx_auth_rule` VALUES ('45', 'admin/Node/default', '菜单管理', '1', '1', '', '0', '1488007070', '1488007070'), ('46', 'admin/System/siteConfig', '网站配置', '1', '1', '', '0', '1488043079', '1489038654'), ('47', 'admin/System/updateSiteConfig', '更新配置', '1', '1', '', '0', '1488043231', '1488043231'), ('48', 'admin/Backup/default', '备份管理', '1', '1', '', '0', '1488044935', '1488044935'), ('31', 'admin/Node/index', '后台菜单', '1', '1', '', '0', '1487789220', '1487950594'), ('32', 'admin/Node/add', '添加菜单', '1', '1', '', '0', '1487789234', '1487789234'), ('33', 'admin/Node/delete', '删除菜单', '1', '1', '', '0', '1487789246', '1487789246'), ('34', 'admin/Node/edit', '编辑菜单', '1', '1', '', '0', '1487789255', '1487789255'), ('35', 'admin/Setting/default', '设置', '1', '1', '', '0', '1487951321', '1487951321'), ('36', 'admin/Users/default', '用户组', '1', '1', '', '0', '1487951847', '1487999511'), ('37', 'admin/Users/index', '本站用户', '1', '1', '', '0', '1487954667', '1487999501'), ('38', 'admin/Admin/default', '管理组', '1', '1', '', '0', '1487954732', '1487954732'), ('39', 'admin/Admin/index', '管理员', '1', '1', '', '0', '1487957700', '1487999532'), ('40', 'admin/Admin/add', '添加管理员', '1', '1', '', '0', '1487966778', '1487966778'), ('41', 'admin/Admin/edit', '编辑管理员', '1', '1', '', '0', '1487966821', '1487966821'), ('42', 'admin/Admin/delete', '删除管理员', '1', '1', '', '0', '1487966874', '1487966874'), ('43', 'admin/Role/index', '角色管理', '1', '1', '', '0', '1487997838', '1487997838'), ('44', 'admin/Rbac/index', '角色管理', '1', '1', '', '0', '1487998167', '1487999640'), ('49', 'admin/Backup/index', '数据备份', '1', '1', '', '0', '1488044981', '1488044981'), ('50', 'admin/Backup/restore', '数据列表', '1', '1', '', '0', '1488045030', '1488052426'), ('51', 'admin/Backup/import', '数据恢复', '1', '1', '', '0', '1488052552', '1488052552'), ('52', 'admin/Backup/del_backup', '数据删除', '1', '1', '', '0', '1488052594', '1488052594'), ('53', 'admin/Backup/download', '数据下载', '1', '1', '', '0', '1488052624', '1488052624'), ('54', 'admin/Content/default', '内容管理', '1', '1', '', '0', '1488597861', '1488597861'), ('82', 'admin/ArticleCategory/add', '添加分类', '1', '1', '', '0', '1493105153', '1493105153'), ('83', 'admin/ArticleCategory/edit', '编辑分类', '1', '1', '', '0', '1493105215', '1493105215'), ('84', 'admin/ArticleCategory/delete', '删除分类', '1', '1', '', '0', '1493105222', '1493105222'), ('85', 'admin/Article/add', '添加文章', '1', '1', '', '0', '1493105255', '1493105255'), ('59', 'admin/Article/index', '文章列表', '1', '1', '', '0', '1488691790', '1493103716'), ('60', 'admin/System/setAppAndroidConfig', 'android配置', '1', '1', '', '0', '1489031361', '1489031361'), ('61', 'admin/System/upAppAndroidConfig', '更新android配置', '1', '1', '', '0', '1489031431', '1489031431'), ('62', 'admin/Tool/default', '扩展工具', '1', '1', '', '0', '1489476084', '1489547712'), ('81', 'admin/ArticleCategory/index', '文章分类', '1', '1', '', '0', '1493103763', '1493111457'), ('80', 'admin/Article/default', '文章管理', '1', '1', '', '0', '1493103540', '1493103683'), ('65', 'admin/Slide/default', '幻灯片', '1', '1', '', '0', '1489489395', '1489489395'), ('66', 'admin/Slide/index', '幻灯片管理', '1', '1', '', '0', '1489489421', '1489489421'), ('67', 'admin/SlideCat/index', '幻灯片分类', '1', '1', '', '0', '1489489448', '1489489448'), ('68', 'admin/Slide/add', '添加幻灯片', '1', '1', '', '0', '1489546558', '1489546558'), ('69', 'admin/Slide/edit', '编辑幻灯片', '1', '1', '', '0', '1489546580', '1489546580'), ('70', 'admin/Slide/delete', '删除幻灯片', '1', '1', '', '0', '1489546608', '1489546608'), ('71', 'admin/SlideCat/add', '添加幻灯片分类', '1', '1', '', '0', '1489546644', '1489546644'), ('72', 'admin/SlideCat/edit', '编辑幻灯片分类', '1', '1', '', '0', '1489546670', '1489546670'), ('73', 'admin/SlideCat/delete', '删除幻灯片分类', '1', '1', '', '0', '1489546702', '1489546702'), ('74', 'admin/AppRecommend/index', '推荐应用管理', '1', '1', '', '0', '1489554977', '1489554977'), ('75', 'admin/AppRecommend/add', '添加推荐应用', '1', '1', '', '0', '1489555011', '1489555011'), ('76', 'admin/AppRecommend/edit', '编辑推荐应用', '1', '1', '', '0', '1489555035', '1489555035'), ('77', 'admin/AppRecommend/delete', '删除推荐应用', '1', '1', '', '0', '1489555118', '1489555118'), ('78', 'admin/AppRecommend/setShowCount', '客户端的显示数量', '1', '1', '', '0', '1489555243', '1489555256'), ('79', 'admin/AppRecommend/setAppRecommendConf', '推荐应用配置', '1', '1', '', '0', '1489557777', '1489557777'), ('86', 'admin/Article/edit', '编辑文章', '1', '1', '', '0', '1493105273', '1493105273'), ('87', 'admin/Article/delete', '删除文章', '1', '1', '', '0', '1493105291', '1493105291');
COMMIT;

-- ----------------------------
--  Table structure for `lmx_role`
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
--  Records of `lmx_role`
-- ----------------------------
BEGIN;
INSERT INTO `lmx_role` VALUES ('1', '超级管理员', '0', '1', '拥有网站最高管理员权限！', '1329633709', '1329633709', '0'), ('2', '普通管理', '0', '1', '测试', '0', '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `lmx_role_admin`
-- ----------------------------
DROP TABLE IF EXISTS `lmx_role_admin`;
CREATE TABLE `lmx_role_admin` (
  `role_id` int(11) unsigned DEFAULT '0' COMMENT '角色 id',
  `user_id` int(11) DEFAULT '0' COMMENT '用户id',
  KEY `group_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户角色对应表';

-- ----------------------------
--  Records of `lmx_role_admin`
-- ----------------------------
BEGIN;
INSERT INTO `lmx_role_admin` VALUES ('1', '3'), ('3', '3'), ('1', '5'), ('2', '2'), ('2', '5');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
