/*
Navicat MySQL Data Transfer

Source Server         : my.tm.idautoconsulting.net
Source Server Version : 50726
Source Host           : 10.0.8.160:3306
Source Database       : metavault

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2019-10-02 14:42:46
*/
CREATE DATABASE metavault;
USE metavault;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for event_log
-- ----------------------------
DROP TABLE IF EXISTS `event_log`;
CREATE TABLE `event_log` (
  `masterLiveId` varchar(50) NOT NULL,
  `insertedAt` datetime DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`masterLiveId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ingest_live
-- ----------------------------
DROP TABLE IF EXISTS `ingest_live`;
CREATE TABLE `ingest_live` (
  `masterLiveId` varchar(50) NOT NULL,
  `affiliation` varchar(20) NOT NULL,
  `objectId` varchar(20) NOT NULL,
  `object` json DEFAULT NULL,
  `insertedAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`masterLiveId`,`affiliation`,`objectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ingest_raw
-- ----------------------------
DROP TABLE IF EXISTS `ingest_raw`;
CREATE TABLE `ingest_raw` (
  `affiliation` varchar(20) NOT NULL,
  `objectId` varchar(20) NOT NULL,
  `object` json DEFAULT NULL,
  `insertedAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `operationFlags` bigint(20) DEFAULT '0',
  `errorFlag` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`affiliation`,`objectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for master_live
-- ----------------------------
DROP TABLE IF EXISTS `master_live`;
CREATE TABLE `master_live` (
  `id` varchar(50) NOT NULL,
  `affiliations` json DEFAULT NULL,
  `insertedAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for webhooks
-- ----------------------------
DROP TABLE IF EXISTS `webhooks`;
CREATE TABLE `webhooks` (
  `systemId` varchar(50) NOT NULL,
  `onEvent` char(1) NOT NULL,
  `method` varchar(6) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `body` varchar(255) DEFAULT NULL,
  `contentType` varchar(255) DEFAULT NULL,
  `key` varchar(255) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`systemId`,`onEvent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TRIGGER IF EXISTS `after_ingest_live_insert`;
DELIMITER ;;
CREATE TRIGGER `after_ingest_live_insert` AFTER INSERT ON `ingest_live` FOR EACH ROW INSERT IGNORE INTO event_log
SET insertedAt=CURTIME(),
	masterLiveId=NEW.masterLiveId,
	status='A'
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `after_ingest_live_update`;
DELIMITER ;;
CREATE TRIGGER `after_ingest_live_update` AFTER UPDATE ON `ingest_live` FOR EACH ROW INSERT IGNORE INTO event_log
SET insertedAt=CURTIME(),
	masterLiveId=OLD.masterLiveId,
	status='U'
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `before_insert_master_live_set_uuids`;
DELIMITER ;;
CREATE TRIGGER `before_insert_master_live_set_uuids` BEFORE INSERT ON `master_live` FOR EACH ROW SET new.id = uuid()
;;
DELIMITER ;
SET FOREIGN_KEY_CHECKS=1;
