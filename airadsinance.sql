/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50045
Source Host           : localhost:3306
Source Database       : airadsfinance

Target Server Type    : MYSQL
Target Server Version : 50045
File Encoding         : 65001

Date: 2011-06-18 07:16:55
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `accountgroups`
-- ----------------------------
DROP TABLE IF EXISTS `accountgroups`;
CREATE TABLE `accountgroups` (
  `groupname` char(30) NOT NULL default '',
  `sectioninaccounts` int(11) NOT NULL default '0',
  `pandl` tinyint(4) NOT NULL default '1',
  `sequenceintb` smallint(6) NOT NULL default '0',
  `parentgroupname` varchar(30) NOT NULL,
  PRIMARY KEY  (`groupname`),
  KEY `SequenceInTB` (`sequenceintb`),
  KEY `sectioninaccounts` (`sectioninaccounts`),
  KEY `parentgroupname` (`parentgroupname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of accountgroups
-- ----------------------------
INSERT INTO `accountgroups` VALUES ('BBQs', '5', '1', '6000', 'Promotions'), ('Cost of Goods Sold', '2', '1', '5000', ''), ('Current Assets', '20', '0', '1000', ''), ('Equity', '50', '0', '3000', ''), ('Fixed Assets', '10', '0', '500', ''), ('Giveaways', '5', '1', '6000', 'Promotions'), ('Income Tax', '5', '1', '9000', ''), ('Liabilities', '30', '0', '2000', ''), ('Marketing Expenses', '5', '1', '6000', ''), ('Operating Expenses', '5', '1', '7000', ''), ('Other Revenue and Expenses', '5', '1', '8000', ''), ('Outward Freight', '2', '1', '5000', 'Cost of Goods Sold'), ('Promotions', '5', '1', '6000', 'Marketing Expenses'), ('Revenue', '1', '1', '4000', ''), ('Sales', '1', '1', '10', '');

-- ----------------------------
-- Table structure for `accountsection`
-- ----------------------------
DROP TABLE IF EXISTS `accountsection`;
CREATE TABLE `accountsection` (
  `sectionid` int(11) NOT NULL default '0',
  `sectionname` text NOT NULL,
  PRIMARY KEY  (`sectionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of accountsection
-- ----------------------------
INSERT INTO `accountsection` VALUES ('1', 'Income'), ('2', 'Cost Of Sales'), ('5', 'Overheads'), ('10', 'Fixed Assets'), ('20', 'Amounts Receivable'), ('30', 'Amounts Payable'), ('50', 'Financed By');

-- ----------------------------
-- Table structure for `areas`
-- ----------------------------
DROP TABLE IF EXISTS `areas`;
CREATE TABLE `areas` (
  `areacode` char(3) NOT NULL,
  `areadescription` varchar(25) NOT NULL default '',
  PRIMARY KEY  (`areacode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of areas
-- ----------------------------
INSERT INTO `areas` VALUES ('DE', 'Default'), ('FL', 'Florida'), ('TR', 'Toronto');

-- ----------------------------
-- Table structure for `assetmanager`
-- ----------------------------
DROP TABLE IF EXISTS `assetmanager`;
CREATE TABLE `assetmanager` (
  `id` int(11) NOT NULL auto_increment,
  `stockid` varchar(20) NOT NULL default '',
  `serialno` varchar(30) NOT NULL default '',
  `location` varchar(15) NOT NULL default '',
  `cost` double NOT NULL default '0',
  `depn` double NOT NULL default '0',
  `datepurchased` date NOT NULL default '0000-00-00',
  `disposalvalue` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assetmanager
-- ----------------------------

-- ----------------------------
-- Table structure for `audittrail`
-- ----------------------------
DROP TABLE IF EXISTS `audittrail`;
CREATE TABLE `audittrail` (
  `transactiondate` datetime NOT NULL default '0000-00-00 00:00:00',
  `userid` varchar(20) NOT NULL default '',
  `querystring` text,
  KEY `UserID` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of audittrail
-- ----------------------------
INSERT INTO `audittrail` VALUES ('2011-06-17 13:27:53', 'admin', 'UPDATE config\n				SET confvalue=\'2011-06-17\'\n				WHERE confname=\'DB_Maintenance_LastRun\''), ('2011-06-17 13:27:53', 'admin', 'DELETE FROM audittrail\n						WHERE  transactiondate &lt;= \'2011-05-17\''), ('2011-06-17 13:28:24', 'admin', 'UPDATE www_users SET realname=\'Demonstration user\',\n						customerid=\'\',\n						phone=\'\',\n						email=\'ellymakuba@gmail.com\',\n						\n						branchcode=\'\',\n						supplierid=\'\',\n						salesman=\'\',\n						pagesize=\'A4\',\n						fullaccess=\'8\',\n						theme=\'professional\',\n						language =\'en_US.utf8\',\n						defaultlocation=\'MEL\',\n						modulesallowed=\'1,1,1,1,1,1,1,1,1,1,\',\n						blocked=\'0\',\n						pdflanguage=\'0\'\n					WHERE userid = \'admin\''), ('2011-06-17 13:28:57', 'admin', 'UPDATE www_users SET realname=\'Elly Makuba\',\n						customerid=\'\',\n						phone=\'\',\n						email=\'ellymakuba@gmail.com\',\n						\n						branchcode=\'\',\n						supplierid=\'\',\n						salesman=\'\',\n						pagesize=\'A4\',\n						fullaccess=\'8\',\n						theme=\'professional\',\n						language =\'en_US.utf8\',\n						defaultlocation=\'MEL\',\n						modulesallowed=\'1,1,1,1,1,1,1,1,1,1,\',\n						blocked=\'0\',\n						pdflanguage=\'0\'\n					WHERE userid = \'admin\''), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (3, \'2010/11/30\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (4, \'2010/12/31\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (5, \'2011/01/31\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (6, \'2011/02/28\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (7, \'2011/03/31\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (8, \'2011/04/30\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (9, \'2011/05/31\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (10, \'2011/06/30\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (11, \'2011/07/31\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (12, \'2011/08/31\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (13, \'2011/09/30\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (14, \'2011/10/31\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (15, \'2011/11/30\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (16, \'2011/12/31\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (17, \'2012/01/31\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (18, \'2012/02/29\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (19, \'2012/03/31\')'), ('2011-06-17 13:29:43', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (20, \'2012/04/30\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (-1, \'2010/07/31\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (-2, \'2010/06/30\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (-3, \'2010/05/31\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (-4, \'2010/04/30\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (21, \'2012/05/31\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (22, \'2012/06/30\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (23, \'2012/07/31\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (24, \'2012/08/31\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (25, \'2012/09/30\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (26, \'2012/10/31\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (27, \'2012/11/30\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (28, \'2012/12/31\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (29, \'2013/01/31\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (30, \'2013/02/28\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (31, \'2013/03/31\')'), ('2011-06-17 13:29:44', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (32, \'2013/04/30\')'), ('2011-06-17 13:29:44', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'-3\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'-2\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'-1\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'0\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'1\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'2\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'3\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'4\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'5\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'6\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'7\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'8\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'9\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'10\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'11\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'12\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'13\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'14\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'15\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'16\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'17\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'18\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'19\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'20\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'21\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'22\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'23\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'24\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'25\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'26\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'27\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'28\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'29\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:45', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'30\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:46', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'31\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:46', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'32\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:46', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'33\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:29:59', 'admin', 'INSERT INTO periods (periodno, lastdate_in_period) VALUES (33, \'2013/05/31\')'), ('2011-06-17 13:29:59', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'-3\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'-2\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'-1\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'0\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'1\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'2\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'3\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'4\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'5\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'6\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'7\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'8\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'9\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'10\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'11\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'12\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'13\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'14\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'15\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'16\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'17\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'18\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'19\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'20\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'21\'\n				AND  accountcode = \'1\'');
INSERT INTO `audittrail` VALUES ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'22\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'23\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'24\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'25\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'26\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'27\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'28\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'29\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'30\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'31\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'32\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'33\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:30:00', 'admin', 'UPDATE chartdetails\n				SET bfwdbudget=\'0\'\n				WHERE period=\'34\'\n				AND  accountcode = \'1\''), ('2011-06-17 13:32:13', 'admin', 'UPDATE www_users SET lastvisitdate=\'2011-06-17 13:32:13\'\n					WHERE www_users.userid=\'admin\''), ('2011-06-17 13:38:33', 'admin', 'UPDATE gltrans SET posted = 1 WHERE counterindex = 209'), ('2011-06-17 13:38:33', 'admin', 'UPDATE gltrans SET posted = 1 WHERE counterindex = 213'), ('2011-06-17 13:38:33', 'admin', 'UPDATE gltrans SET posted = 1 WHERE counterindex = 215'), ('2011-06-17 13:38:33', 'admin', 'UPDATE chartdetails SET actual = actual + 1412.93775\n					WHERE accountcode = 1440\n					AND period= 1'), ('2011-06-17 13:38:33', 'admin', 'UPDATE chartdetails SET bfwd = bfwd + 1412.93775\n					WHERE accountcode = 1440\n					AND period &gt; 1'), ('2011-06-17 13:38:33', 'admin', 'UPDATE gltrans SET posted = 1 WHERE counterindex = 210'), ('2011-06-17 13:38:33', 'admin', 'UPDATE gltrans SET posted = 1 WHERE counterindex = 214'), ('2011-06-17 13:38:33', 'admin', 'UPDATE gltrans SET posted = 1 WHERE counterindex = 216'), ('2011-06-17 13:38:33', 'admin', 'UPDATE chartdetails SET actual = actual + -1412.93775\n			WHERE accountcode = 5000\n			AND period= 1'), ('2011-06-17 13:38:33', 'admin', 'UPDATE chartdetails SET bfwd = bfwd + -1412.93775\n			WHERE accountcode = 5000\n			AND period &gt; 1');

-- ----------------------------
-- Table structure for `bankaccounts`
-- ----------------------------
DROP TABLE IF EXISTS `bankaccounts`;
CREATE TABLE `bankaccounts` (
  `accountcode` int(11) NOT NULL default '0',
  `currcode` char(3) NOT NULL,
  `invoice` smallint(2) NOT NULL default '0',
  `bankaccountcode` varchar(50) NOT NULL default '',
  `bankaccountname` char(50) NOT NULL default '',
  `bankaccountnumber` char(50) NOT NULL default '',
  `bankaddress` char(50) default NULL,
  PRIMARY KEY  (`accountcode`),
  KEY `currcode` (`currcode`),
  KEY `BankAccountName` (`bankaccountname`),
  KEY `BankAccountNumber` (`bankaccountnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bankaccounts
-- ----------------------------
INSERT INTO `bankaccounts` VALUES ('1030', 'AUD', '1', '12445', 'Cheque Account', '124455667789', '123 Straight Street'), ('1040', 'AUD', '0', '', 'Savings Account', '', '');

-- ----------------------------
-- Table structure for `banktrans`
-- ----------------------------
DROP TABLE IF EXISTS `banktrans`;
CREATE TABLE `banktrans` (
  `banktransid` bigint(20) NOT NULL auto_increment,
  `type` smallint(6) NOT NULL default '0',
  `transno` bigint(20) NOT NULL default '0',
  `bankact` int(11) NOT NULL default '0',
  `ref` varchar(50) NOT NULL default '',
  `amountcleared` double NOT NULL default '0',
  `exrate` double NOT NULL default '1' COMMENT 'From bank account currency to payment currency',
  `functionalexrate` double NOT NULL default '1' COMMENT 'Account currency to functional currency',
  `transdate` date NOT NULL default '0000-00-00',
  `banktranstype` varchar(30) NOT NULL default '',
  `amount` double NOT NULL default '0',
  `currcode` char(3) NOT NULL default '',
  PRIMARY KEY  (`banktransid`),
  KEY `BankAct` (`bankact`,`ref`),
  KEY `TransDate` (`transdate`),
  KEY `TransType` (`banktranstype`),
  KEY `Type` (`type`,`transno`),
  KEY `CurrCode` (`currcode`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of banktrans
-- ----------------------------
INSERT INTO `banktrans` VALUES ('1', '12', '1', '1030', '', '0', '1', '1', '2007-10-23', 'Cheque', '150', 'AUD'), ('2', '1', '2', '1030', '', '0', '1', '1', '2008-07-26', 'Cheque', '-500', 'AUD'), ('3', '12', '2', '1030', '', '0', '1', '1', '2009-02-04', 'Cash', '99', 'USD'), ('4', '12', '3', '1030', '', '0', '1', '1', '2009-02-04', 'Cash', '299', 'AUD'), ('5', '12', '5', '1040', 'Melbourne Counter Sale 10', '0', '1', '1', '2010-05-31', '2', '10.5', 'USD'), ('8', '12', '8', '1030', 'Melbourne Counter Sale 13', '0', '0.85', '1', '2010-05-31', '2', '5.8823529411765', 'USD'), ('9', '12', '9', '1030', 'Melbourne Counter Sale 14', '0', '0.85', '1', '2010-05-31', '1', '138.23529411765', 'USD');

-- ----------------------------
-- Table structure for `bom`
-- ----------------------------
DROP TABLE IF EXISTS `bom`;
CREATE TABLE `bom` (
  `parent` char(20) NOT NULL default '',
  `component` char(20) NOT NULL default '',
  `workcentreadded` char(5) NOT NULL default '',
  `loccode` char(5) NOT NULL default '',
  `effectiveafter` date NOT NULL default '0000-00-00',
  `effectiveto` date NOT NULL default '9999-12-31',
  `quantity` double NOT NULL default '1',
  `autoissue` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`parent`,`component`,`workcentreadded`,`loccode`),
  KEY `Component` (`component`),
  KEY `EffectiveAfter` (`effectiveafter`),
  KEY `EffectiveTo` (`effectiveto`),
  KEY `LocCode` (`loccode`),
  KEY `Parent` (`parent`,`effectiveafter`,`effectiveto`,`loccode`),
  KEY `Parent_2` (`parent`),
  KEY `WorkCentreAdded` (`workcentreadded`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bom
-- ----------------------------
INSERT INTO `bom` VALUES ('BIGEARS12', 'DVD-CASE', 'MEL', 'TOR', '2010-08-14', '2037-12-31', '1', '0'), ('BirthdayCakeConstruc', 'BREAD', 'MEL', 'TOR', '2010-08-14', '2037-12-31', '1', '0'), ('BirthdayCakeConstruc', 'DVD-CASE', 'MEL', 'TOR', '2010-08-14', '2037-12-31', '1', '0'), ('BirthdayCakeConstruc', 'FLOUR', 'MEL', 'TOR', '2010-08-14', '2037-12-31', '1', '0'), ('BirthdayCakeConstruc', 'SALT', 'MEL', 'TOR', '2010-08-14', '2037-12-31', '1', '0'), ('BirthdayCakeConstruc', 'YEAST', 'MEL', 'TOR', '2010-08-14', '2037-12-31', '1', '0'), ('BREAD', 'FLOUR', 'ASS', 'MEL', '2007-06-19', '2037-06-20', '1.4', '0'), ('BREAD', 'SALT', 'ASS', 'MEL', '2007-06-19', '2037-06-20', '0.025', '1'), ('BREAD', 'YEAST', 'ASS', 'MEL', '2007-06-19', '2037-06-20', '0.1', '0'), ('DVD_ACTION', 'DVD-CASE', 'ASS', 'MEL', '2007-06-12', '2037-06-13', '4', '0'), ('DVD_ACTION', 'DVD-DHWV', 'ASS', 'MEL', '2007-06-12', '2037-06-13', '1', '1'), ('DVD_ACTION', 'DVD-LTWP', 'ASS', 'MEL', '2007-06-12', '2037-06-13', '1', '1'), ('DVD_ACTION', 'DVD-UNSG', 'ASS', 'MEL', '2007-06-12', '2037-06-13', '1', '1'), ('DVD_ACTION', 'DVD-UNSG2', 'ASS', 'MEL', '2007-06-12', '2037-06-13', '1', '1'), ('FUJI9901ASS', 'FUJI990101', 'ASS', 'MEL', '2005-06-04', '2035-06-05', '1', '0'), ('FUJI9901ASS', 'FUJI990102', 'ASS', 'MEL', '2005-02-12', '2037-06-13', '1', '0'), ('SLICE', 'BREAD', 'ASS', 'MEL', '2007-06-19', '2037-06-20', '0.1', '1');

-- ----------------------------
-- Table structure for `buckets`
-- ----------------------------
DROP TABLE IF EXISTS `buckets`;
CREATE TABLE `buckets` (
  `workcentre` char(5) NOT NULL default '',
  `availdate` datetime NOT NULL default '0000-00-00 00:00:00',
  `capacity` double NOT NULL default '0',
  PRIMARY KEY  (`workcentre`,`availdate`),
  KEY `WorkCentre` (`workcentre`),
  KEY `AvailDate` (`availdate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of buckets
-- ----------------------------

-- ----------------------------
-- Table structure for `chartdetails`
-- ----------------------------
DROP TABLE IF EXISTS `chartdetails`;
CREATE TABLE `chartdetails` (
  `accountcode` int(11) NOT NULL default '0',
  `period` smallint(6) NOT NULL default '0',
  `budget` double NOT NULL default '0',
  `actual` double NOT NULL default '0',
  `bfwd` double NOT NULL default '0',
  `bfwdbudget` double NOT NULL default '0',
  PRIMARY KEY  (`accountcode`,`period`),
  KEY `Period` (`period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of chartdetails
-- ----------------------------
INSERT INTO `chartdetails` VALUES ('1', '-11', '0', '0', '0', '0'), ('1', '-10', '0', '0', '0', '0'), ('1', '-9', '0', '0', '0', '0'), ('1', '-8', '0', '0', '0', '0'), ('1', '-7', '0', '0', '0', '0'), ('1', '-6', '0', '0', '0', '0'), ('1', '-5', '0', '0', '0', '0'), ('1', '-4', '0', '0', '0', '0'), ('1', '-3', '0', '0', '0', '0'), ('1', '-2', '0', '0', '0', '0'), ('1', '-1', '0', '0', '0', '0'), ('1', '0', '0', '0', '0', '0'), ('1', '1', '0', '0', '0', '0'), ('1', '2', '0', '0', '0', '0'), ('1', '3', '0', '0', '0', '0'), ('1', '4', '0', '0', '0', '0'), ('1', '5', '0', '0', '0', '0'), ('1', '6', '0', '0', '0', '0'), ('1', '7', '0', '0', '0', '0'), ('1', '8', '0', '0', '0', '0'), ('1', '9', '0', '0', '0', '0'), ('1', '10', '0', '0', '0', '0'), ('1', '11', '0', '0', '0', '0'), ('1', '12', '0', '0', '0', '0'), ('1', '13', '0', '0', '0', '0'), ('1', '14', '0', '0', '0', '0'), ('1', '15', '0', '0', '0', '0'), ('1', '16', '0', '0', '0', '0'), ('1', '17', '0', '0', '0', '0'), ('1', '18', '0', '0', '0', '0'), ('1', '19', '0', '0', '0', '0'), ('1', '20', '0', '0', '0', '0'), ('1', '21', '0', '0', '0', '0'), ('1', '22', '0', '0', '0', '0'), ('1', '23', '0', '0', '0', '0'), ('1', '24', '0', '0', '0', '0'), ('1', '25', '0', '0', '0', '0'), ('1', '26', '0', '0', '0', '0'), ('1', '27', '0', '0', '0', '0'), ('1', '28', '0', '0', '0', '0'), ('1', '29', '0', '0', '0', '0'), ('1', '30', '0', '0', '0', '0'), ('1', '31', '0', '0', '0', '0'), ('1', '32', '0', '0', '0', '0'), ('1', '33', '0', '0', '0', '0'), ('1', '34', '0', '0', '0', '0'), ('1', '35', '0', '0', '0', '0'), ('1', '36', '0', '0', '0', '0'), ('1', '37', '0', '0', '0', '0'), ('1010', '-11', '0', '0', '0', '0'), ('1010', '-10', '0', '0', '0', '0'), ('1010', '-9', '0', '0', '0', '0'), ('1010', '-8', '0', '0', '0', '0'), ('1010', '-7', '0', '0', '0', '0'), ('1010', '-6', '0', '0', '0', '0'), ('1010', '-5', '0', '0', '0', '0'), ('1010', '-4', '0', '0', '0', '0'), ('1010', '-3', '0', '0', '0', '0'), ('1010', '-2', '0', '0', '0', '0'), ('1010', '-1', '0', '0', '0', '0'), ('1010', '0', '0', '0', '0', '0'), ('1010', '1', '0', '0', '0', '0'), ('1010', '2', '0', '0', '0', '0'), ('1010', '3', '0', '0', '0', '0'), ('1010', '4', '0', '0', '0', '0'), ('1010', '5', '0', '0', '0', '0'), ('1010', '6', '0', '0', '0', '0'), ('1010', '7', '0', '0', '0', '0'), ('1010', '8', '0', '0', '0', '0'), ('1010', '9', '0', '0', '0', '0'), ('1010', '10', '0', '0', '0', '0'), ('1010', '11', '0', '0', '0', '0'), ('1010', '12', '0', '0', '0', '0'), ('1010', '13', '0', '0', '0', '0'), ('1010', '14', '0', '0', '0', '0'), ('1010', '15', '0', '0', '0', '0'), ('1010', '16', '0', '0', '0', '0'), ('1010', '17', '0', '0', '0', '0'), ('1010', '18', '0', '0', '0', '0'), ('1010', '19', '0', '0', '0', '0'), ('1010', '20', '0', '0', '0', '0'), ('1010', '21', '0', '0', '0', '0'), ('1010', '22', '0', '0', '0', '0'), ('1010', '23', '0', '0', '0', '0'), ('1010', '24', '0', '0', '0', '0'), ('1010', '25', '0', '0', '0', '0'), ('1010', '26', '0', '0', '0', '0'), ('1010', '27', '0', '0', '0', '0'), ('1010', '28', '0', '0', '0', '0'), ('1010', '29', '0', '0', '0', '0'), ('1010', '30', '0', '0', '0', '0'), ('1010', '31', '0', '0', '0', '0'), ('1010', '32', '0', '0', '0', '0'), ('1010', '33', '0', '0', '0', '0'), ('1010', '34', '0', '0', '0', '0'), ('1010', '35', '0', '0', '0', '0'), ('1010', '36', '0', '0', '0', '0'), ('1010', '37', '0', '0', '0', '0'), ('1020', '-11', '0', '0', '0', '0'), ('1020', '-10', '0', '0', '0', '0'), ('1020', '-9', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1020', '-8', '0', '0', '0', '0'), ('1020', '-7', '0', '0', '0', '0'), ('1020', '-6', '0', '0', '0', '0'), ('1020', '-5', '0', '0', '0', '0'), ('1020', '-4', '0', '0', '0', '0'), ('1020', '-3', '0', '0', '0', '0'), ('1020', '-2', '0', '0', '0', '0'), ('1020', '-1', '0', '0', '0', '0'), ('1020', '0', '0', '0', '0', '0'), ('1020', '1', '0', '0', '0', '0'), ('1020', '2', '0', '0', '0', '0'), ('1020', '3', '0', '0', '0', '0'), ('1020', '4', '0', '0', '0', '0'), ('1020', '5', '0', '0', '0', '0'), ('1020', '6', '0', '0', '0', '0'), ('1020', '7', '0', '0', '0', '0'), ('1020', '8', '0', '0', '0', '0'), ('1020', '9', '0', '0', '0', '0'), ('1020', '10', '0', '0', '0', '0'), ('1020', '11', '0', '0', '0', '0'), ('1020', '12', '0', '0', '0', '0'), ('1020', '13', '0', '0', '0', '0'), ('1020', '14', '0', '0', '0', '0'), ('1020', '15', '0', '0', '0', '0'), ('1020', '16', '0', '0', '0', '0'), ('1020', '17', '0', '0', '0', '0'), ('1020', '18', '0', '0', '0', '0'), ('1020', '19', '0', '0', '0', '0'), ('1020', '20', '0', '0', '0', '0'), ('1020', '21', '0', '0', '0', '0'), ('1020', '22', '0', '0', '0', '0'), ('1020', '23', '0', '0', '0', '0'), ('1020', '24', '0', '0', '0', '0'), ('1020', '25', '0', '0', '0', '0'), ('1020', '26', '0', '0', '0', '0'), ('1020', '27', '0', '0', '0', '0'), ('1020', '28', '0', '0', '0', '0'), ('1020', '29', '0', '0', '0', '0'), ('1020', '30', '0', '0', '0', '0'), ('1020', '31', '0', '0', '0', '0'), ('1020', '32', '0', '0', '0', '0'), ('1020', '33', '0', '0', '0', '0'), ('1020', '34', '0', '0', '0', '0'), ('1020', '35', '0', '0', '0', '0'), ('1020', '36', '0', '0', '0', '0'), ('1020', '37', '0', '0', '0', '0'), ('1030', '-11', '0', '0', '0', '0'), ('1030', '-10', '0', '0', '0', '0'), ('1030', '-9', '0', '0', '0', '0'), ('1030', '-8', '0', '0', '0', '0'), ('1030', '-7', '0', '0', '0', '0'), ('1030', '-6', '0', '0', '0', '0'), ('1030', '-5', '0', '0', '0', '0'), ('1030', '-4', '0', '0', '0', '0'), ('1030', '-3', '0', '0', '0', '0'), ('1030', '-2', '0', '0', '0', '0'), ('1030', '-1', '0', '0', '0', '0'), ('1030', '0', '0', '0', '0', '0'), ('1030', '1', '0', '0', '0', '0'), ('1030', '2', '0', '0', '0', '0'), ('1030', '3', '0', '0', '0', '0'), ('1030', '4', '0', '0', '0', '0'), ('1030', '5', '0', '150', '0', '0'), ('1030', '6', '0', '0', '0', '0'), ('1030', '7', '0', '0', '0', '0'), ('1030', '8', '0', '0', '0', '0'), ('1030', '9', '0', '0', '0', '0'), ('1030', '10', '0', '0', '0', '0'), ('1030', '11', '0', '0', '0', '0'), ('1030', '12', '0', '0', '0', '0'), ('1030', '13', '0', '0', '0', '0'), ('1030', '14', '0', '-500', '0', '0'), ('1030', '15', '0', '0', '0', '0'), ('1030', '16', '0', '0', '0', '0'), ('1030', '17', '0', '0', '0', '0'), ('1030', '18', '0', '0', '0', '0'), ('1030', '19', '0', '0', '0', '0'), ('1030', '20', '0', '0', '0', '0'), ('1030', '21', '0', '398', '0', '0'), ('1030', '22', '0', '0', '398', '0'), ('1030', '23', '0', '0', '0', '0'), ('1030', '24', '0', '0', '0', '0'), ('1030', '25', '0', '0', '0', '0'), ('1030', '26', '0', '0', '0', '0'), ('1030', '27', '0', '0', '0', '0'), ('1030', '28', '0', '0', '0', '0'), ('1030', '29', '0', '0', '0', '0'), ('1030', '30', '0', '0', '0', '0'), ('1030', '31', '0', '0', '0', '0'), ('1030', '32', '0', '0', '0', '0'), ('1030', '33', '0', '0', '0', '0'), ('1030', '34', '0', '0', '0', '0'), ('1030', '35', '0', '0', '0', '0'), ('1030', '36', '0', '0', '0', '0'), ('1030', '37', '0', '0', '0', '0'), ('1040', '-11', '0', '0', '0', '0'), ('1040', '-10', '0', '0', '0', '0'), ('1040', '-9', '0', '0', '0', '0'), ('1040', '-8', '0', '0', '0', '0'), ('1040', '-7', '0', '0', '0', '0'), ('1040', '-6', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1040', '-5', '0', '0', '0', '0'), ('1040', '-4', '0', '0', '0', '0'), ('1040', '-3', '0', '0', '0', '0'), ('1040', '-2', '0', '0', '0', '0'), ('1040', '-1', '0', '0', '0', '0'), ('1040', '0', '0', '0', '0', '0'), ('1040', '1', '0', '0', '0', '0'), ('1040', '2', '0', '0', '0', '0'), ('1040', '3', '0', '0', '0', '0'), ('1040', '4', '0', '0', '0', '0'), ('1040', '5', '0', '0', '0', '0'), ('1040', '6', '0', '0', '0', '0'), ('1040', '7', '0', '0', '0', '0'), ('1040', '8', '0', '0', '0', '0'), ('1040', '9', '0', '0', '0', '0'), ('1040', '10', '0', '0', '0', '0'), ('1040', '11', '0', '0', '0', '0'), ('1040', '12', '0', '0', '0', '0'), ('1040', '13', '0', '0', '0', '0'), ('1040', '14', '0', '0', '0', '0'), ('1040', '15', '0', '0', '0', '0'), ('1040', '16', '0', '0', '0', '0'), ('1040', '17', '0', '0', '0', '0'), ('1040', '18', '0', '0', '0', '0'), ('1040', '19', '0', '0', '0', '0'), ('1040', '20', '0', '0', '0', '0'), ('1040', '21', '0', '0', '0', '0'), ('1040', '22', '0', '0', '0', '0'), ('1040', '23', '0', '0', '0', '0'), ('1040', '24', '0', '0', '0', '0'), ('1040', '25', '0', '0', '0', '0'), ('1040', '26', '0', '0', '0', '0'), ('1040', '27', '0', '0', '0', '0'), ('1040', '28', '0', '0', '0', '0'), ('1040', '29', '0', '0', '0', '0'), ('1040', '30', '0', '0', '0', '0'), ('1040', '31', '0', '0', '0', '0'), ('1040', '32', '0', '0', '0', '0'), ('1040', '33', '0', '0', '0', '0'), ('1040', '34', '0', '0', '0', '0'), ('1040', '35', '0', '0', '0', '0'), ('1040', '36', '0', '0', '0', '0'), ('1040', '37', '0', '0', '0', '0'), ('1050', '-11', '0', '0', '0', '0'), ('1050', '-10', '0', '0', '0', '0'), ('1050', '-9', '0', '0', '0', '0'), ('1050', '-8', '0', '0', '0', '0'), ('1050', '-7', '0', '0', '0', '0'), ('1050', '-6', '0', '0', '0', '0'), ('1050', '-5', '0', '0', '0', '0'), ('1050', '-4', '0', '0', '0', '0'), ('1050', '-3', '0', '0', '0', '0'), ('1050', '-2', '0', '0', '0', '0'), ('1050', '-1', '0', '0', '0', '0'), ('1050', '0', '0', '0', '0', '0'), ('1050', '1', '0', '0', '0', '0'), ('1050', '2', '0', '0', '0', '0'), ('1050', '3', '0', '0', '0', '0'), ('1050', '4', '0', '0', '0', '0'), ('1050', '5', '0', '0', '0', '0'), ('1050', '6', '0', '0', '0', '0'), ('1050', '7', '0', '0', '0', '0'), ('1050', '8', '0', '0', '0', '0'), ('1050', '9', '0', '0', '0', '0'), ('1050', '10', '0', '0', '0', '0'), ('1050', '11', '0', '0', '0', '0'), ('1050', '12', '0', '0', '0', '0'), ('1050', '13', '0', '0', '0', '0'), ('1050', '14', '0', '0', '0', '0'), ('1050', '15', '0', '0', '0', '0'), ('1050', '16', '0', '0', '0', '0'), ('1050', '17', '0', '0', '0', '0'), ('1050', '18', '0', '0', '0', '0'), ('1050', '19', '0', '0', '0', '0'), ('1050', '20', '0', '0', '0', '0'), ('1050', '21', '0', '0', '0', '0'), ('1050', '22', '0', '0', '0', '0'), ('1050', '23', '0', '0', '0', '0'), ('1050', '24', '0', '0', '0', '0'), ('1050', '25', '0', '0', '0', '0'), ('1050', '26', '0', '0', '0', '0'), ('1050', '27', '0', '0', '0', '0'), ('1050', '28', '0', '0', '0', '0'), ('1050', '29', '0', '0', '0', '0'), ('1050', '30', '0', '0', '0', '0'), ('1050', '31', '0', '0', '0', '0'), ('1050', '32', '0', '0', '0', '0'), ('1050', '33', '0', '0', '0', '0'), ('1050', '34', '0', '0', '0', '0'), ('1050', '35', '0', '0', '0', '0'), ('1050', '36', '0', '0', '0', '0'), ('1050', '37', '0', '0', '0', '0'), ('1060', '-11', '0', '0', '0', '0'), ('1060', '-10', '0', '0', '0', '0'), ('1060', '-9', '0', '0', '0', '0'), ('1060', '-8', '0', '0', '0', '0'), ('1060', '-7', '0', '0', '0', '0'), ('1060', '-6', '0', '0', '0', '0'), ('1060', '-5', '0', '0', '0', '0'), ('1060', '-4', '0', '0', '0', '0'), ('1060', '-3', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1060', '-2', '0', '0', '0', '0'), ('1060', '-1', '0', '0', '0', '0'), ('1060', '0', '0', '0', '0', '0'), ('1060', '1', '0', '0', '0', '0'), ('1060', '2', '0', '0', '0', '0'), ('1060', '3', '0', '0', '0', '0'), ('1060', '4', '0', '0', '0', '0'), ('1060', '5', '0', '0', '0', '0'), ('1060', '6', '0', '0', '0', '0'), ('1060', '7', '0', '0', '0', '0'), ('1060', '8', '0', '0', '0', '0'), ('1060', '9', '0', '0', '0', '0'), ('1060', '10', '0', '0', '0', '0'), ('1060', '11', '0', '0', '0', '0'), ('1060', '12', '0', '0', '0', '0'), ('1060', '13', '0', '0', '0', '0'), ('1060', '14', '0', '0', '0', '0'), ('1060', '15', '0', '0', '0', '0'), ('1060', '16', '0', '0', '0', '0'), ('1060', '17', '0', '0', '0', '0'), ('1060', '18', '0', '0', '0', '0'), ('1060', '19', '0', '0', '0', '0'), ('1060', '20', '0', '0', '0', '0'), ('1060', '21', '0', '0', '0', '0'), ('1060', '22', '0', '0', '0', '0'), ('1060', '23', '0', '0', '0', '0'), ('1060', '24', '0', '0', '0', '0'), ('1060', '25', '0', '0', '0', '0'), ('1060', '26', '0', '0', '0', '0'), ('1060', '27', '0', '0', '0', '0'), ('1060', '28', '0', '0', '0', '0'), ('1060', '29', '0', '0', '0', '0'), ('1060', '30', '0', '0', '0', '0'), ('1060', '31', '0', '0', '0', '0'), ('1060', '32', '0', '0', '0', '0'), ('1060', '33', '0', '0', '0', '0'), ('1060', '34', '0', '0', '0', '0'), ('1060', '35', '0', '0', '0', '0'), ('1060', '36', '0', '0', '0', '0'), ('1060', '37', '0', '0', '0', '0'), ('1070', '-11', '0', '0', '0', '0'), ('1070', '-10', '0', '0', '0', '0'), ('1070', '-9', '0', '0', '0', '0'), ('1070', '-8', '0', '0', '0', '0'), ('1070', '-7', '0', '0', '0', '0'), ('1070', '-6', '0', '0', '0', '0'), ('1070', '-5', '0', '0', '0', '0'), ('1070', '-4', '0', '0', '0', '0'), ('1070', '-3', '0', '0', '0', '0'), ('1070', '-2', '0', '0', '0', '0'), ('1070', '-1', '0', '0', '0', '0'), ('1070', '0', '0', '0', '0', '0'), ('1070', '1', '0', '0', '0', '0'), ('1070', '2', '0', '0', '0', '0'), ('1070', '3', '0', '0', '0', '0'), ('1070', '4', '0', '0', '0', '0'), ('1070', '5', '0', '0', '0', '0'), ('1070', '6', '0', '0', '0', '0'), ('1070', '7', '0', '0', '0', '0'), ('1070', '8', '0', '0', '0', '0'), ('1070', '9', '0', '0', '0', '0'), ('1070', '10', '0', '0', '0', '0'), ('1070', '11', '0', '0', '0', '0'), ('1070', '12', '0', '0', '0', '0'), ('1070', '13', '0', '0', '0', '0'), ('1070', '14', '0', '0', '0', '0'), ('1070', '15', '0', '0', '0', '0'), ('1070', '16', '0', '0', '0', '0'), ('1070', '17', '0', '0', '0', '0'), ('1070', '18', '0', '0', '0', '0'), ('1070', '19', '0', '0', '0', '0'), ('1070', '20', '0', '0', '0', '0'), ('1070', '21', '0', '0', '0', '0'), ('1070', '22', '0', '0', '0', '0'), ('1070', '23', '0', '0', '0', '0'), ('1070', '24', '0', '0', '0', '0'), ('1070', '25', '0', '0', '0', '0'), ('1070', '26', '0', '0', '0', '0'), ('1070', '27', '0', '0', '0', '0'), ('1070', '28', '0', '0', '0', '0'), ('1070', '29', '0', '0', '0', '0'), ('1070', '30', '0', '0', '0', '0'), ('1070', '31', '0', '0', '0', '0'), ('1070', '32', '0', '0', '0', '0'), ('1070', '33', '0', '0', '0', '0'), ('1070', '34', '0', '0', '0', '0'), ('1070', '35', '0', '0', '0', '0'), ('1070', '36', '0', '0', '0', '0'), ('1070', '37', '0', '0', '0', '0'), ('1080', '-11', '0', '0', '0', '0'), ('1080', '-10', '0', '0', '0', '0'), ('1080', '-9', '0', '0', '0', '0'), ('1080', '-8', '0', '0', '0', '0'), ('1080', '-7', '0', '0', '0', '0'), ('1080', '-6', '0', '0', '0', '0'), ('1080', '-5', '0', '0', '0', '0'), ('1080', '-4', '0', '0', '0', '0'), ('1080', '-3', '0', '0', '0', '0'), ('1080', '-2', '0', '0', '0', '0'), ('1080', '-1', '0', '0', '0', '0'), ('1080', '0', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1080', '1', '0', '0', '0', '0'), ('1080', '2', '0', '0', '0', '0'), ('1080', '3', '0', '0', '0', '0'), ('1080', '4', '0', '0', '0', '0'), ('1080', '5', '0', '0', '0', '0'), ('1080', '6', '0', '0', '0', '0'), ('1080', '7', '0', '0', '0', '0'), ('1080', '8', '0', '0', '0', '0'), ('1080', '9', '0', '0', '0', '0'), ('1080', '10', '0', '0', '0', '0'), ('1080', '11', '0', '0', '0', '0'), ('1080', '12', '0', '0', '0', '0'), ('1080', '13', '0', '0', '0', '0'), ('1080', '14', '0', '0', '0', '0'), ('1080', '15', '0', '0', '0', '0'), ('1080', '16', '0', '0', '0', '0'), ('1080', '17', '0', '0', '0', '0'), ('1080', '18', '0', '0', '0', '0'), ('1080', '19', '0', '0', '0', '0'), ('1080', '20', '0', '0', '0', '0'), ('1080', '21', '0', '0', '0', '0'), ('1080', '22', '0', '0', '0', '0'), ('1080', '23', '0', '0', '0', '0'), ('1080', '24', '0', '0', '0', '0'), ('1080', '25', '0', '0', '0', '0'), ('1080', '26', '0', '0', '0', '0'), ('1080', '27', '0', '0', '0', '0'), ('1080', '28', '0', '0', '0', '0'), ('1080', '29', '0', '0', '0', '0'), ('1080', '30', '0', '0', '0', '0'), ('1080', '31', '0', '0', '0', '0'), ('1080', '32', '0', '0', '0', '0'), ('1080', '33', '0', '0', '0', '0'), ('1080', '34', '0', '0', '0', '0'), ('1080', '35', '0', '0', '0', '0'), ('1080', '36', '0', '0', '0', '0'), ('1080', '37', '0', '0', '0', '0'), ('1090', '-11', '0', '0', '0', '0'), ('1090', '-10', '0', '0', '0', '0'), ('1090', '-9', '0', '0', '0', '0'), ('1090', '-8', '0', '0', '0', '0'), ('1090', '-7', '0', '0', '0', '0'), ('1090', '-6', '0', '0', '0', '0'), ('1090', '-5', '0', '0', '0', '0'), ('1090', '-4', '0', '0', '0', '0'), ('1090', '-3', '0', '0', '0', '0'), ('1090', '-2', '0', '0', '0', '0'), ('1090', '-1', '0', '0', '0', '0'), ('1090', '0', '0', '0', '0', '0'), ('1090', '1', '0', '0', '0', '0'), ('1090', '2', '0', '0', '0', '0'), ('1090', '3', '0', '0', '0', '0'), ('1090', '4', '0', '0', '0', '0'), ('1090', '5', '0', '0', '0', '0'), ('1090', '6', '0', '0', '0', '0'), ('1090', '7', '0', '0', '0', '0'), ('1090', '8', '0', '0', '0', '0'), ('1090', '9', '0', '0', '0', '0'), ('1090', '10', '0', '0', '0', '0'), ('1090', '11', '0', '0', '0', '0'), ('1090', '12', '0', '0', '0', '0'), ('1090', '13', '0', '0', '0', '0'), ('1090', '14', '0', '0', '0', '0'), ('1090', '15', '0', '0', '0', '0'), ('1090', '16', '0', '0', '0', '0'), ('1090', '17', '0', '0', '0', '0'), ('1090', '18', '0', '0', '0', '0'), ('1090', '19', '0', '0', '0', '0'), ('1090', '20', '0', '0', '0', '0'), ('1090', '21', '0', '0', '0', '0'), ('1090', '22', '0', '0', '0', '0'), ('1090', '23', '0', '0', '0', '0'), ('1090', '24', '0', '0', '0', '0'), ('1090', '25', '0', '0', '0', '0'), ('1090', '26', '0', '0', '0', '0'), ('1090', '27', '0', '0', '0', '0'), ('1090', '28', '0', '0', '0', '0'), ('1090', '29', '0', '0', '0', '0'), ('1090', '30', '0', '0', '0', '0'), ('1090', '31', '0', '0', '0', '0'), ('1090', '32', '0', '0', '0', '0'), ('1090', '33', '0', '0', '0', '0'), ('1090', '34', '0', '0', '0', '0'), ('1090', '35', '0', '0', '0', '0'), ('1090', '36', '0', '0', '0', '0'), ('1090', '37', '0', '0', '0', '0'), ('1100', '-11', '0', '0', '0', '0'), ('1100', '-10', '0', '0', '0', '0'), ('1100', '-9', '0', '0', '0', '0'), ('1100', '-8', '0', '0', '0', '0'), ('1100', '-7', '0', '0', '0', '0'), ('1100', '-6', '0', '0', '0', '0'), ('1100', '-5', '0', '0', '0', '0'), ('1100', '-4', '0', '0', '0', '0'), ('1100', '-3', '0', '0', '0', '0'), ('1100', '-2', '0', '0', '0', '0'), ('1100', '-1', '0', '0', '0', '0'), ('1100', '0', '0', '0', '0', '0'), ('1100', '1', '0', '0', '0', '0'), ('1100', '2', '0', '46.4', '0', '0'), ('1100', '3', '0', '-15.95', '0', '0');
INSERT INTO `chartdetails` VALUES ('1100', '4', '0', '0', '0', '0'), ('1100', '5', '0', '0', '0', '0'), ('1100', '6', '0', '0', '0', '0'), ('1100', '7', '0', '0', '0', '0'), ('1100', '8', '0', '0', '0', '0'), ('1100', '9', '0', '0', '0', '0'), ('1100', '10', '0', '0', '0', '0'), ('1100', '11', '0', '0', '0', '0'), ('1100', '12', '0', '0', '0', '0'), ('1100', '13', '0', '0', '0', '0'), ('1100', '14', '0', '0', '0', '0'), ('1100', '15', '0', '0', '0', '0'), ('1100', '16', '0', '0', '0', '0'), ('1100', '17', '0', '0', '0', '0'), ('1100', '18', '0', '0', '0', '0'), ('1100', '19', '0', '0', '0', '0'), ('1100', '20', '0', '0', '0', '0'), ('1100', '21', '0', '-99', '0', '0'), ('1100', '22', '0', '0', '-99', '0'), ('1100', '23', '0', '0', '0', '0'), ('1100', '24', '0', '0', '0', '0'), ('1100', '25', '0', '0', '0', '0'), ('1100', '26', '0', '0', '0', '0'), ('1100', '27', '0', '0', '0', '0'), ('1100', '28', '0', '0', '0', '0'), ('1100', '29', '0', '0', '0', '0'), ('1100', '30', '0', '0', '0', '0'), ('1100', '31', '0', '0', '0', '0'), ('1100', '32', '0', '0', '0', '0'), ('1100', '33', '0', '0', '0', '0'), ('1100', '34', '0', '0', '0', '0'), ('1100', '35', '0', '0', '0', '0'), ('1100', '36', '0', '0', '0', '0'), ('1100', '37', '0', '0', '0', '0'), ('1150', '-11', '0', '0', '0', '0'), ('1150', '-10', '0', '0', '0', '0'), ('1150', '-9', '0', '0', '0', '0'), ('1150', '-8', '0', '0', '0', '0'), ('1150', '-7', '0', '0', '0', '0'), ('1150', '-6', '0', '0', '0', '0'), ('1150', '-5', '0', '0', '0', '0'), ('1150', '-4', '0', '0', '0', '0'), ('1150', '-3', '0', '0', '0', '0'), ('1150', '-2', '0', '0', '0', '0'), ('1150', '-1', '0', '0', '0', '0'), ('1150', '0', '0', '0', '0', '0'), ('1150', '1', '0', '0', '0', '0'), ('1150', '2', '0', '0', '0', '0'), ('1150', '3', '0', '0', '0', '0'), ('1150', '4', '0', '0', '0', '0'), ('1150', '5', '0', '0', '0', '0'), ('1150', '6', '0', '0', '0', '0'), ('1150', '7', '0', '0', '0', '0'), ('1150', '8', '0', '0', '0', '0'), ('1150', '9', '0', '0', '0', '0'), ('1150', '10', '0', '0', '0', '0'), ('1150', '11', '0', '0', '0', '0'), ('1150', '12', '0', '0', '0', '0'), ('1150', '13', '0', '0', '0', '0'), ('1150', '14', '0', '0', '0', '0'), ('1150', '15', '0', '0', '0', '0'), ('1150', '16', '0', '0', '0', '0'), ('1150', '17', '0', '0', '0', '0'), ('1150', '18', '0', '0', '0', '0'), ('1150', '19', '0', '0', '0', '0'), ('1150', '20', '0', '0', '0', '0'), ('1150', '21', '0', '0', '0', '0'), ('1150', '22', '0', '0', '0', '0'), ('1150', '23', '0', '0', '0', '0'), ('1150', '24', '0', '0', '0', '0'), ('1150', '25', '0', '0', '0', '0'), ('1150', '26', '0', '0', '0', '0'), ('1150', '27', '0', '0', '0', '0'), ('1150', '28', '0', '0', '0', '0'), ('1150', '29', '0', '0', '0', '0'), ('1150', '30', '0', '0', '0', '0'), ('1150', '31', '0', '0', '0', '0'), ('1150', '32', '0', '0', '0', '0'), ('1150', '33', '0', '0', '0', '0'), ('1150', '34', '0', '0', '0', '0'), ('1150', '35', '0', '0', '0', '0'), ('1150', '36', '0', '0', '0', '0'), ('1150', '37', '0', '0', '0', '0'), ('1200', '-11', '0', '0', '0', '0'), ('1200', '-10', '0', '0', '0', '0'), ('1200', '-9', '0', '0', '0', '0'), ('1200', '-8', '0', '0', '0', '0'), ('1200', '-7', '0', '0', '0', '0'), ('1200', '-6', '0', '0', '0', '0'), ('1200', '-5', '0', '0', '0', '0'), ('1200', '-4', '0', '0', '0', '0'), ('1200', '-3', '0', '0', '0', '0'), ('1200', '-2', '0', '0', '0', '0'), ('1200', '-1', '0', '0', '0', '0'), ('1200', '0', '0', '0', '0', '0'), ('1200', '1', '0', '0', '0', '0'), ('1200', '2', '0', '0', '0', '0'), ('1200', '3', '0', '0', '0', '0'), ('1200', '4', '0', '0', '0', '0'), ('1200', '5', '0', '0', '0', '0'), ('1200', '6', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1200', '7', '0', '0', '0', '0'), ('1200', '8', '0', '0', '0', '0'), ('1200', '9', '0', '0', '0', '0'), ('1200', '10', '0', '0', '0', '0'), ('1200', '11', '0', '0', '0', '0'), ('1200', '12', '0', '0', '0', '0'), ('1200', '13', '0', '0', '0', '0'), ('1200', '14', '0', '0', '0', '0'), ('1200', '15', '0', '0', '0', '0'), ('1200', '16', '0', '0', '0', '0'), ('1200', '17', '0', '0', '0', '0'), ('1200', '18', '0', '0', '0', '0'), ('1200', '19', '0', '0', '0', '0'), ('1200', '20', '0', '0', '0', '0'), ('1200', '21', '0', '0', '0', '0'), ('1200', '22', '0', '0', '0', '0'), ('1200', '23', '0', '0', '0', '0'), ('1200', '24', '0', '0', '0', '0'), ('1200', '25', '0', '0', '0', '0'), ('1200', '26', '0', '0', '0', '0'), ('1200', '27', '0', '0', '0', '0'), ('1200', '28', '0', '0', '0', '0'), ('1200', '29', '0', '0', '0', '0'), ('1200', '30', '0', '0', '0', '0'), ('1200', '31', '0', '0', '0', '0'), ('1200', '32', '0', '0', '0', '0'), ('1200', '33', '0', '0', '0', '0'), ('1200', '34', '0', '0', '0', '0'), ('1200', '35', '0', '0', '0', '0'), ('1200', '36', '0', '0', '0', '0'), ('1200', '37', '0', '0', '0', '0'), ('1250', '-11', '0', '0', '0', '0'), ('1250', '-10', '0', '0', '0', '0'), ('1250', '-9', '0', '0', '0', '0'), ('1250', '-8', '0', '0', '0', '0'), ('1250', '-7', '0', '0', '0', '0'), ('1250', '-6', '0', '0', '0', '0'), ('1250', '-5', '0', '0', '0', '0'), ('1250', '-4', '0', '0', '0', '0'), ('1250', '-3', '0', '0', '0', '0'), ('1250', '-2', '0', '0', '0', '0'), ('1250', '-1', '0', '0', '0', '0'), ('1250', '0', '0', '0', '0', '0'), ('1250', '1', '0', '0', '0', '0'), ('1250', '2', '0', '0', '0', '0'), ('1250', '3', '0', '0', '0', '0'), ('1250', '4', '0', '0', '0', '0'), ('1250', '5', '0', '0', '0', '0'), ('1250', '6', '0', '0', '0', '0'), ('1250', '7', '0', '0', '0', '0'), ('1250', '8', '0', '0', '0', '0'), ('1250', '9', '0', '0', '0', '0'), ('1250', '10', '0', '0', '0', '0'), ('1250', '11', '0', '0', '0', '0'), ('1250', '12', '0', '0', '0', '0'), ('1250', '13', '0', '0', '0', '0'), ('1250', '14', '0', '0', '0', '0'), ('1250', '15', '0', '0', '0', '0'), ('1250', '16', '0', '0', '0', '0'), ('1250', '17', '0', '0', '0', '0'), ('1250', '18', '0', '0', '0', '0'), ('1250', '19', '0', '0', '0', '0'), ('1250', '20', '0', '0', '0', '0'), ('1250', '21', '0', '0', '0', '0'), ('1250', '22', '0', '0', '0', '0'), ('1250', '23', '0', '0', '0', '0'), ('1250', '24', '0', '0', '0', '0'), ('1250', '25', '0', '0', '0', '0'), ('1250', '26', '0', '0', '0', '0'), ('1250', '27', '0', '0', '0', '0'), ('1250', '28', '0', '0', '0', '0'), ('1250', '29', '0', '0', '0', '0'), ('1250', '30', '0', '0', '0', '0'), ('1250', '31', '0', '0', '0', '0'), ('1250', '32', '0', '0', '0', '0'), ('1250', '33', '0', '0', '0', '0'), ('1250', '34', '0', '0', '0', '0'), ('1250', '35', '0', '0', '0', '0'), ('1250', '36', '0', '0', '0', '0'), ('1250', '37', '0', '0', '0', '0'), ('1300', '-11', '0', '0', '0', '0'), ('1300', '-10', '0', '0', '0', '0'), ('1300', '-9', '0', '0', '0', '0'), ('1300', '-8', '0', '0', '0', '0'), ('1300', '-7', '0', '0', '0', '0'), ('1300', '-6', '0', '0', '0', '0'), ('1300', '-5', '0', '0', '0', '0'), ('1300', '-4', '0', '0', '0', '0'), ('1300', '-3', '0', '0', '0', '0'), ('1300', '-2', '0', '0', '0', '0'), ('1300', '-1', '0', '0', '0', '0'), ('1300', '0', '0', '0', '0', '0'), ('1300', '1', '0', '0', '0', '0'), ('1300', '2', '0', '0', '0', '0'), ('1300', '3', '0', '0', '0', '0'), ('1300', '4', '0', '0', '0', '0'), ('1300', '5', '0', '0', '0', '0'), ('1300', '6', '0', '0', '0', '0'), ('1300', '7', '0', '0', '0', '0'), ('1300', '8', '0', '0', '0', '0'), ('1300', '9', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1300', '10', '0', '0', '0', '0'), ('1300', '11', '0', '0', '0', '0'), ('1300', '12', '0', '0', '0', '0'), ('1300', '13', '0', '0', '0', '0'), ('1300', '14', '0', '0', '0', '0'), ('1300', '15', '0', '0', '0', '0'), ('1300', '16', '0', '0', '0', '0'), ('1300', '17', '0', '0', '0', '0'), ('1300', '18', '0', '0', '0', '0'), ('1300', '19', '0', '0', '0', '0'), ('1300', '20', '0', '0', '0', '0'), ('1300', '21', '0', '0', '0', '0'), ('1300', '22', '0', '0', '0', '0'), ('1300', '23', '0', '0', '0', '0'), ('1300', '24', '0', '0', '0', '0'), ('1300', '25', '0', '0', '0', '0'), ('1300', '26', '0', '0', '0', '0'), ('1300', '27', '0', '0', '0', '0'), ('1300', '28', '0', '0', '0', '0'), ('1300', '29', '0', '0', '0', '0'), ('1300', '30', '0', '0', '0', '0'), ('1300', '31', '0', '0', '0', '0'), ('1300', '32', '0', '0', '0', '0'), ('1300', '33', '0', '0', '0', '0'), ('1300', '34', '0', '0', '0', '0'), ('1300', '35', '0', '0', '0', '0'), ('1300', '36', '0', '0', '0', '0'), ('1300', '37', '0', '0', '0', '0'), ('1350', '-11', '0', '0', '0', '0'), ('1350', '-10', '0', '0', '0', '0'), ('1350', '-9', '0', '0', '0', '0'), ('1350', '-8', '0', '0', '0', '0'), ('1350', '-7', '0', '0', '0', '0'), ('1350', '-6', '0', '0', '0', '0'), ('1350', '-5', '0', '0', '0', '0'), ('1350', '-4', '0', '0', '0', '0'), ('1350', '-3', '0', '0', '0', '0'), ('1350', '-2', '0', '0', '0', '0'), ('1350', '-1', '0', '0', '0', '0'), ('1350', '0', '0', '0', '0', '0'), ('1350', '1', '0', '0', '0', '0'), ('1350', '2', '0', '0', '0', '0'), ('1350', '3', '0', '0', '0', '0'), ('1350', '4', '0', '0', '0', '0'), ('1350', '5', '0', '0', '0', '0'), ('1350', '6', '0', '0', '0', '0'), ('1350', '7', '0', '0', '0', '0'), ('1350', '8', '0', '0', '0', '0'), ('1350', '9', '0', '0', '0', '0'), ('1350', '10', '0', '0', '0', '0'), ('1350', '11', '0', '0', '0', '0'), ('1350', '12', '0', '0', '0', '0'), ('1350', '13', '0', '0', '0', '0'), ('1350', '14', '0', '500', '0', '0'), ('1350', '15', '0', '0', '0', '0'), ('1350', '16', '0', '0', '0', '0'), ('1350', '17', '0', '0', '0', '0'), ('1350', '18', '0', '0', '0', '0'), ('1350', '19', '0', '0', '0', '0'), ('1350', '20', '0', '0', '0', '0'), ('1350', '21', '0', '0', '0', '0'), ('1350', '22', '0', '0', '0', '0'), ('1350', '23', '0', '0', '0', '0'), ('1350', '24', '0', '0', '0', '0'), ('1350', '25', '0', '0', '0', '0'), ('1350', '26', '0', '0', '0', '0'), ('1350', '27', '0', '0', '0', '0'), ('1350', '28', '0', '0', '0', '0'), ('1350', '29', '0', '0', '0', '0'), ('1350', '30', '0', '0', '0', '0'), ('1350', '31', '0', '0', '0', '0'), ('1350', '32', '0', '0', '0', '0'), ('1350', '33', '0', '0', '0', '0'), ('1350', '34', '0', '0', '0', '0'), ('1350', '35', '0', '0', '0', '0'), ('1350', '36', '0', '0', '0', '0'), ('1350', '37', '0', '0', '0', '0'), ('1400', '-11', '0', '0', '0', '0'), ('1400', '-10', '0', '0', '0', '0'), ('1400', '-9', '0', '0', '0', '0'), ('1400', '-8', '0', '0', '0', '0'), ('1400', '-7', '0', '0', '0', '0'), ('1400', '-6', '0', '0', '0', '0'), ('1400', '-5', '0', '0', '0', '0'), ('1400', '-4', '0', '0', '0', '0'), ('1400', '-3', '0', '0', '0', '0'), ('1400', '-2', '0', '0', '0', '0'), ('1400', '-1', '0', '0', '0', '0'), ('1400', '0', '0', '0', '0', '0'), ('1400', '1', '0', '0', '0', '0'), ('1400', '2', '0', '0', '0', '0'), ('1400', '3', '0', '0', '0', '0'), ('1400', '4', '0', '0', '0', '0'), ('1400', '5', '0', '0', '0', '0'), ('1400', '6', '0', '0', '0', '0'), ('1400', '7', '0', '0', '0', '0'), ('1400', '8', '0', '0', '0', '0'), ('1400', '9', '0', '0', '0', '0'), ('1400', '10', '0', '0', '0', '0'), ('1400', '11', '0', '0', '0', '0'), ('1400', '12', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1400', '13', '0', '0', '0', '0'), ('1400', '14', '0', '0', '0', '0'), ('1400', '15', '0', '0', '0', '0'), ('1400', '16', '0', '0', '0', '0'), ('1400', '17', '0', '0', '0', '0'), ('1400', '18', '0', '0', '0', '0'), ('1400', '19', '0', '0', '0', '0'), ('1400', '20', '0', '0', '0', '0'), ('1400', '21', '0', '0', '0', '0'), ('1400', '22', '0', '0', '0', '0'), ('1400', '23', '0', '0', '0', '0'), ('1400', '24', '0', '0', '0', '0'), ('1400', '25', '0', '0', '0', '0'), ('1400', '26', '0', '0', '0', '0'), ('1400', '27', '0', '0', '0', '0'), ('1400', '28', '0', '0', '0', '0'), ('1400', '29', '0', '0', '0', '0'), ('1400', '30', '0', '0', '0', '0'), ('1400', '31', '0', '0', '0', '0'), ('1400', '32', '0', '0', '0', '0'), ('1400', '33', '0', '0', '0', '0'), ('1400', '34', '0', '0', '0', '0'), ('1400', '35', '0', '0', '0', '0'), ('1400', '36', '0', '0', '0', '0'), ('1400', '37', '0', '0', '0', '0'), ('1420', '-11', '0', '0', '0', '0'), ('1420', '-10', '0', '0', '0', '0'), ('1420', '-9', '0', '0', '0', '0'), ('1420', '-8', '0', '0', '0', '0'), ('1420', '-7', '0', '0', '0', '0'), ('1420', '-6', '0', '0', '0', '0'), ('1420', '-5', '0', '0', '0', '0'), ('1420', '-4', '0', '0', '0', '0'), ('1420', '-3', '0', '0', '0', '0'), ('1420', '-2', '0', '0', '0', '0'), ('1420', '-1', '0', '0', '0', '0'), ('1420', '0', '0', '0', '0', '0'), ('1420', '1', '0', '0', '0', '0'), ('1420', '2', '0', '0', '0', '0'), ('1420', '3', '0', '0', '0', '0'), ('1420', '4', '0', '0', '0', '0'), ('1420', '5', '0', '0', '0', '0'), ('1420', '6', '0', '0', '0', '0'), ('1420', '7', '0', '0', '0', '0'), ('1420', '8', '0', '0', '0', '0'), ('1420', '9', '0', '0', '0', '0'), ('1420', '10', '0', '0', '0', '0'), ('1420', '11', '0', '0', '0', '0'), ('1420', '12', '0', '0', '0', '0'), ('1420', '13', '0', '0', '0', '0'), ('1420', '14', '0', '0', '0', '0'), ('1420', '15', '0', '0', '0', '0'), ('1420', '16', '0', '0', '0', '0'), ('1420', '17', '0', '0', '0', '0'), ('1420', '18', '0', '0', '0', '0'), ('1420', '19', '0', '0', '0', '0'), ('1420', '20', '0', '0', '0', '0'), ('1420', '21', '0', '-299', '0', '0'), ('1420', '22', '0', '0', '-299', '0'), ('1420', '23', '0', '0', '0', '0'), ('1420', '24', '0', '0', '0', '0'), ('1420', '25', '0', '0', '0', '0'), ('1420', '26', '0', '0', '0', '0'), ('1420', '27', '0', '0', '0', '0'), ('1420', '28', '0', '0', '0', '0'), ('1420', '29', '0', '0', '0', '0'), ('1420', '30', '0', '0', '0', '0'), ('1420', '31', '0', '0', '0', '0'), ('1420', '32', '0', '0', '0', '0'), ('1420', '33', '0', '0', '0', '0'), ('1420', '34', '0', '0', '0', '0'), ('1420', '35', '0', '0', '0', '0'), ('1420', '36', '0', '0', '0', '0'), ('1420', '37', '0', '0', '0', '0'), ('1440', '-11', '0', '0', '0', '0'), ('1440', '-10', '0', '0', '0', '0'), ('1440', '-9', '0', '0', '0', '0'), ('1440', '-8', '0', '0', '0', '0'), ('1440', '-7', '0', '0', '0', '0'), ('1440', '-6', '0', '0', '0', '0'), ('1440', '-5', '0', '0', '0', '0'), ('1440', '-4', '0', '0', '0', '0'), ('1440', '-3', '0', '0', '0', '0'), ('1440', '-2', '0', '0', '0', '0'), ('1440', '-1', '0', '0', '0', '0'), ('1440', '0', '0', '1425.5905', '0', '0'), ('1440', '1', '0', '1883.917', '1425.5905', '0'), ('1440', '2', '0', '15.56', '3309.5075', '0'), ('1440', '3', '0', '0', '3309.5075', '0'), ('1440', '4', '0', '0', '3309.5075', '0'), ('1440', '5', '0', '0', '3309.5075', '0'), ('1440', '6', '0', '0', '3309.5075', '0'), ('1440', '7', '0', '0', '3309.5075', '0'), ('1440', '8', '0', '0', '3309.5075', '0'), ('1440', '9', '0', '0', '3309.5075', '0'), ('1440', '10', '0', '0', '3309.5075', '0'), ('1440', '11', '0', '0', '3309.5075', '0'), ('1440', '12', '0', '0', '3309.5075', '0'), ('1440', '13', '0', '0.75', '3309.5075', '0'), ('1440', '14', '0', '0', '3310.2575', '0'), ('1440', '15', '0', '0', '3309.5075', '0');
INSERT INTO `chartdetails` VALUES ('1440', '16', '0', '0', '3309.5075', '0'), ('1440', '17', '0', '0', '3309.5075', '0'), ('1440', '18', '0', '0', '3309.5075', '0'), ('1440', '19', '0', '0', '3309.5075', '0'), ('1440', '20', '0', '0', '3309.5075', '0'), ('1440', '21', '0', '0', '3309.5075', '0'), ('1440', '22', '0', '0', '3309.5075', '0'), ('1440', '23', '0', '0', '3309.5075', '0'), ('1440', '24', '0', '0', '3309.5075', '0'), ('1440', '25', '0', '0', '3309.5075', '0'), ('1440', '26', '0', '0', '3309.5075', '0'), ('1440', '27', '0', '0', '3309.5075', '0'), ('1440', '28', '0', '0', '3309.5075', '0'), ('1440', '29', '0', '0', '3309.5075', '0'), ('1440', '30', '0', '0', '3309.5075', '0'), ('1440', '31', '0', '0', '3309.5075', '0'), ('1440', '32', '0', '0', '3309.5075', '0'), ('1440', '33', '0', '0', '3309.5075', '0'), ('1440', '34', '0', '0', '3309.5075', '0'), ('1440', '35', '0', '0', '3309.5075', '0'), ('1440', '36', '0', '0', '3309.5075', '0'), ('1440', '37', '0', '0', '3309.5075', '0'), ('1460', '-11', '0', '0', '0', '0'), ('1460', '-10', '0', '0', '0', '0'), ('1460', '-9', '0', '0', '0', '0'), ('1460', '-8', '0', '0', '0', '0'), ('1460', '-7', '0', '0', '0', '0'), ('1460', '-6', '0', '0', '0', '0'), ('1460', '-5', '0', '0', '0', '0'), ('1460', '-4', '0', '0', '0', '0'), ('1460', '-3', '0', '0', '0', '0'), ('1460', '-2', '0', '0', '0', '0'), ('1460', '-1', '0', '0', '0', '0'), ('1460', '0', '0', '125.90325', '0', '0'), ('1460', '1', '0', '0', '125.90325', '0'), ('1460', '2', '0', '-28.91', '125.90325', '0'), ('1460', '3', '0', '14.19', '125.90325', '0'), ('1460', '4', '0', '0', '134.84325', '0'), ('1460', '5', '0', '0', '134.84325', '0'), ('1460', '6', '0', '0', '125.90325', '0'), ('1460', '7', '0', '0', '125.90325', '0'), ('1460', '8', '0', '0', '125.90325', '0'), ('1460', '9', '0', '0', '125.90325', '0'), ('1460', '10', '0', '0', '125.90325', '0'), ('1460', '11', '0', '0', '125.90325', '0'), ('1460', '12', '0', '0', '125.90325', '0'), ('1460', '13', '0', '0', '125.90325', '0'), ('1460', '14', '0', '0', '125.90325', '0'), ('1460', '15', '0', '0', '125.90325', '0'), ('1460', '16', '0', '0', '125.90325', '0'), ('1460', '17', '0', '0', '125.90325', '0'), ('1460', '18', '0', '0', '125.90325', '0'), ('1460', '19', '0', '0', '125.90325', '0'), ('1460', '20', '0', '0', '125.90325', '0'), ('1460', '21', '0', '637.25', '125.90325', '0'), ('1460', '22', '0', '0', '763.15325', '0'), ('1460', '23', '0', '0', '125.90325', '0'), ('1460', '24', '0', '0', '125.90325', '0'), ('1460', '25', '0', '0', '125.90325', '0'), ('1460', '26', '0', '0', '125.90325', '0'), ('1460', '27', '0', '0', '125.90325', '0'), ('1460', '28', '0', '0', '125.90325', '0'), ('1460', '29', '0', '0', '125.90325', '0'), ('1460', '30', '0', '0', '125.90325', '0'), ('1460', '31', '0', '0', '125.90325', '0'), ('1460', '32', '0', '0', '125.90325', '0'), ('1460', '33', '0', '0', '125.90325', '0'), ('1460', '34', '0', '0', '125.90325', '0'), ('1460', '35', '0', '0', '125.90325', '0'), ('1460', '36', '0', '0', '125.90325', '0'), ('1460', '37', '0', '0', '125.90325', '0'), ('1500', '-11', '0', '0', '0', '0'), ('1500', '-10', '0', '0', '0', '0'), ('1500', '-9', '0', '0', '0', '0'), ('1500', '-8', '0', '0', '0', '0'), ('1500', '-7', '0', '0', '0', '0'), ('1500', '-6', '0', '0', '0', '0'), ('1500', '-5', '0', '0', '0', '0'), ('1500', '-4', '0', '0', '0', '0'), ('1500', '-3', '0', '0', '0', '0'), ('1500', '-2', '0', '0', '0', '0'), ('1500', '-1', '0', '0', '0', '0'), ('1500', '0', '0', '0', '0', '0'), ('1500', '1', '0', '0', '0', '0'), ('1500', '2', '0', '0', '0', '0'), ('1500', '3', '0', '0', '0', '0'), ('1500', '4', '0', '0', '0', '0'), ('1500', '5', '0', '0', '0', '0'), ('1500', '6', '0', '0', '0', '0'), ('1500', '7', '0', '0', '0', '0'), ('1500', '8', '0', '0', '0', '0'), ('1500', '9', '0', '0', '0', '0'), ('1500', '10', '0', '0', '0', '0'), ('1500', '11', '0', '0', '0', '0'), ('1500', '12', '0', '0', '0', '0'), ('1500', '13', '0', '0', '0', '0'), ('1500', '14', '0', '0', '0', '0'), ('1500', '15', '0', '0', '0', '0'), ('1500', '16', '0', '0', '0', '0'), ('1500', '17', '0', '0', '0', '0'), ('1500', '18', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1500', '19', '0', '0', '0', '0'), ('1500', '20', '0', '0', '0', '0'), ('1500', '21', '0', '0', '0', '0'), ('1500', '22', '0', '0', '0', '0'), ('1500', '23', '0', '0', '0', '0'), ('1500', '24', '0', '0', '0', '0'), ('1500', '25', '0', '0', '0', '0'), ('1500', '26', '0', '0', '0', '0'), ('1500', '27', '0', '0', '0', '0'), ('1500', '28', '0', '0', '0', '0'), ('1500', '29', '0', '0', '0', '0'), ('1500', '30', '0', '0', '0', '0'), ('1500', '31', '0', '0', '0', '0'), ('1500', '32', '0', '0', '0', '0'), ('1500', '33', '0', '0', '0', '0'), ('1500', '34', '0', '0', '0', '0'), ('1500', '35', '0', '0', '0', '0'), ('1500', '36', '0', '0', '0', '0'), ('1500', '37', '0', '0', '0', '0'), ('1550', '-11', '0', '0', '0', '0'), ('1550', '-10', '0', '0', '0', '0'), ('1550', '-9', '0', '0', '0', '0'), ('1550', '-8', '0', '0', '0', '0'), ('1550', '-7', '0', '0', '0', '0'), ('1550', '-6', '0', '0', '0', '0'), ('1550', '-5', '0', '0', '0', '0'), ('1550', '-4', '0', '0', '0', '0'), ('1550', '-3', '0', '0', '0', '0'), ('1550', '-2', '0', '0', '0', '0'), ('1550', '-1', '0', '0', '0', '0'), ('1550', '0', '0', '0', '0', '0'), ('1550', '1', '0', '0', '0', '0'), ('1550', '2', '0', '0', '0', '0'), ('1550', '3', '0', '0', '0', '0'), ('1550', '4', '0', '0', '0', '0'), ('1550', '5', '0', '0', '0', '0'), ('1550', '6', '0', '0', '0', '0'), ('1550', '7', '0', '0', '0', '0'), ('1550', '8', '0', '0', '0', '0'), ('1550', '9', '0', '0', '0', '0'), ('1550', '10', '0', '0', '0', '0'), ('1550', '11', '0', '0', '0', '0'), ('1550', '12', '0', '0', '0', '0'), ('1550', '13', '0', '0', '0', '0'), ('1550', '14', '0', '0', '0', '0'), ('1550', '15', '0', '0', '0', '0'), ('1550', '16', '0', '0', '0', '0'), ('1550', '17', '0', '0', '0', '0'), ('1550', '18', '0', '0', '0', '0'), ('1550', '19', '0', '0', '0', '0'), ('1550', '20', '0', '0', '0', '0'), ('1550', '21', '0', '0', '0', '0'), ('1550', '22', '0', '0', '0', '0'), ('1550', '23', '0', '0', '0', '0'), ('1550', '24', '0', '0', '0', '0'), ('1550', '25', '0', '0', '0', '0'), ('1550', '26', '0', '0', '0', '0'), ('1550', '27', '0', '0', '0', '0'), ('1550', '28', '0', '0', '0', '0'), ('1550', '29', '0', '0', '0', '0'), ('1550', '30', '0', '0', '0', '0'), ('1550', '31', '0', '0', '0', '0'), ('1550', '32', '0', '0', '0', '0'), ('1550', '33', '0', '0', '0', '0'), ('1550', '34', '0', '0', '0', '0'), ('1550', '35', '0', '0', '0', '0'), ('1550', '36', '0', '0', '0', '0'), ('1550', '37', '0', '0', '0', '0'), ('1600', '-11', '0', '0', '0', '0'), ('1600', '-10', '0', '0', '0', '0'), ('1600', '-9', '0', '0', '0', '0'), ('1600', '-8', '0', '0', '0', '0'), ('1600', '-7', '0', '0', '0', '0'), ('1600', '-6', '0', '0', '0', '0'), ('1600', '-5', '0', '0', '0', '0'), ('1600', '-4', '0', '0', '0', '0'), ('1600', '-3', '0', '0', '0', '0'), ('1600', '-2', '0', '0', '0', '0'), ('1600', '-1', '0', '0', '0', '0'), ('1600', '0', '0', '0', '0', '0'), ('1600', '1', '0', '0', '0', '0'), ('1600', '2', '0', '0', '0', '0'), ('1600', '3', '0', '0', '0', '0'), ('1600', '4', '0', '0', '0', '0'), ('1600', '5', '0', '0', '0', '0'), ('1600', '6', '0', '0', '0', '0'), ('1600', '7', '0', '0', '0', '0'), ('1600', '8', '0', '0', '0', '0'), ('1600', '9', '0', '0', '0', '0'), ('1600', '10', '0', '0', '0', '0'), ('1600', '11', '0', '0', '0', '0'), ('1600', '12', '0', '0', '0', '0'), ('1600', '13', '0', '0', '0', '0'), ('1600', '14', '0', '0', '0', '0'), ('1600', '15', '0', '0', '0', '0'), ('1600', '16', '0', '0', '0', '0'), ('1600', '17', '0', '0', '0', '0'), ('1600', '18', '0', '0', '0', '0'), ('1600', '19', '0', '0', '0', '0'), ('1600', '20', '0', '0', '0', '0'), ('1600', '21', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1600', '22', '0', '0', '0', '0'), ('1600', '23', '0', '0', '0', '0'), ('1600', '24', '0', '0', '0', '0'), ('1600', '25', '0', '0', '0', '0'), ('1600', '26', '0', '0', '0', '0'), ('1600', '27', '0', '0', '0', '0'), ('1600', '28', '0', '0', '0', '0'), ('1600', '29', '0', '0', '0', '0'), ('1600', '30', '0', '0', '0', '0'), ('1600', '31', '0', '0', '0', '0'), ('1600', '32', '0', '0', '0', '0'), ('1600', '33', '0', '0', '0', '0'), ('1600', '34', '0', '0', '0', '0'), ('1600', '35', '0', '0', '0', '0'), ('1600', '36', '0', '0', '0', '0'), ('1600', '37', '0', '0', '0', '0'), ('1620', '-11', '0', '0', '0', '0'), ('1620', '-10', '0', '0', '0', '0'), ('1620', '-9', '0', '0', '0', '0'), ('1620', '-8', '0', '0', '0', '0'), ('1620', '-7', '0', '0', '0', '0'), ('1620', '-6', '0', '0', '0', '0'), ('1620', '-5', '0', '0', '0', '0'), ('1620', '-4', '0', '0', '0', '0'), ('1620', '-3', '0', '0', '0', '0'), ('1620', '-2', '0', '0', '0', '0'), ('1620', '-1', '0', '0', '0', '0'), ('1620', '0', '0', '0', '0', '0'), ('1620', '1', '0', '0', '0', '0'), ('1620', '2', '0', '0', '0', '0'), ('1620', '3', '0', '0', '0', '0'), ('1620', '4', '0', '0', '0', '0'), ('1620', '5', '0', '0', '0', '0'), ('1620', '6', '0', '0', '0', '0'), ('1620', '7', '0', '0', '0', '0'), ('1620', '8', '0', '0', '0', '0'), ('1620', '9', '0', '0', '0', '0'), ('1620', '10', '0', '0', '0', '0'), ('1620', '11', '0', '0', '0', '0'), ('1620', '12', '0', '0', '0', '0'), ('1620', '13', '0', '0', '0', '0'), ('1620', '14', '0', '0', '0', '0'), ('1620', '15', '0', '0', '0', '0'), ('1620', '16', '0', '0', '0', '0'), ('1620', '17', '0', '0', '0', '0'), ('1620', '18', '0', '0', '0', '0'), ('1620', '19', '0', '0', '0', '0'), ('1620', '20', '0', '0', '0', '0'), ('1620', '21', '0', '0', '0', '0'), ('1620', '22', '0', '0', '0', '0'), ('1620', '23', '0', '0', '0', '0'), ('1620', '24', '0', '0', '0', '0'), ('1620', '25', '0', '0', '0', '0'), ('1620', '26', '0', '0', '0', '0'), ('1620', '27', '0', '0', '0', '0'), ('1620', '28', '0', '0', '0', '0'), ('1620', '29', '0', '0', '0', '0'), ('1620', '30', '0', '0', '0', '0'), ('1620', '31', '0', '0', '0', '0'), ('1620', '32', '0', '0', '0', '0'), ('1620', '33', '0', '0', '0', '0'), ('1620', '34', '0', '0', '0', '0'), ('1620', '35', '0', '0', '0', '0'), ('1620', '36', '0', '0', '0', '0'), ('1620', '37', '0', '0', '0', '0'), ('1650', '-11', '0', '0', '0', '0'), ('1650', '-10', '0', '0', '0', '0'), ('1650', '-9', '0', '0', '0', '0'), ('1650', '-8', '0', '0', '0', '0'), ('1650', '-7', '0', '0', '0', '0'), ('1650', '-6', '0', '0', '0', '0'), ('1650', '-5', '0', '0', '0', '0'), ('1650', '-4', '0', '0', '0', '0'), ('1650', '-3', '0', '0', '0', '0'), ('1650', '-2', '0', '0', '0', '0'), ('1650', '-1', '0', '0', '0', '0'), ('1650', '0', '0', '0', '0', '0'), ('1650', '1', '0', '0', '0', '0'), ('1650', '2', '0', '0', '0', '0'), ('1650', '3', '0', '0', '0', '0'), ('1650', '4', '0', '0', '0', '0'), ('1650', '5', '0', '0', '0', '0'), ('1650', '6', '0', '0', '0', '0'), ('1650', '7', '0', '0', '0', '0'), ('1650', '8', '0', '0', '0', '0'), ('1650', '9', '0', '0', '0', '0'), ('1650', '10', '0', '0', '0', '0'), ('1650', '11', '0', '0', '0', '0'), ('1650', '12', '0', '0', '0', '0'), ('1650', '13', '0', '0', '0', '0'), ('1650', '14', '0', '0', '0', '0'), ('1650', '15', '0', '0', '0', '0'), ('1650', '16', '0', '0', '0', '0'), ('1650', '17', '0', '0', '0', '0'), ('1650', '18', '0', '0', '0', '0'), ('1650', '19', '0', '0', '0', '0'), ('1650', '20', '0', '0', '0', '0'), ('1650', '21', '0', '0', '0', '0'), ('1650', '22', '0', '0', '0', '0'), ('1650', '23', '0', '0', '0', '0'), ('1650', '24', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1650', '25', '0', '0', '0', '0'), ('1650', '26', '0', '0', '0', '0'), ('1650', '27', '0', '0', '0', '0'), ('1650', '28', '0', '0', '0', '0'), ('1650', '29', '0', '0', '0', '0'), ('1650', '30', '0', '0', '0', '0'), ('1650', '31', '0', '0', '0', '0'), ('1650', '32', '0', '0', '0', '0'), ('1650', '33', '0', '0', '0', '0'), ('1650', '34', '0', '0', '0', '0'), ('1650', '35', '0', '0', '0', '0'), ('1650', '36', '0', '0', '0', '0'), ('1650', '37', '0', '0', '0', '0'), ('1670', '-11', '0', '0', '0', '0'), ('1670', '-10', '0', '0', '0', '0'), ('1670', '-9', '0', '0', '0', '0'), ('1670', '-8', '0', '0', '0', '0'), ('1670', '-7', '0', '0', '0', '0'), ('1670', '-6', '0', '0', '0', '0'), ('1670', '-5', '0', '0', '0', '0'), ('1670', '-4', '0', '0', '0', '0'), ('1670', '-3', '0', '0', '0', '0'), ('1670', '-2', '0', '0', '0', '0'), ('1670', '-1', '0', '0', '0', '0'), ('1670', '0', '0', '0', '0', '0'), ('1670', '1', '0', '0', '0', '0'), ('1670', '2', '0', '0', '0', '0'), ('1670', '3', '0', '0', '0', '0'), ('1670', '4', '0', '0', '0', '0'), ('1670', '5', '0', '0', '0', '0'), ('1670', '6', '0', '0', '0', '0'), ('1670', '7', '0', '0', '0', '0'), ('1670', '8', '0', '0', '0', '0'), ('1670', '9', '0', '0', '0', '0'), ('1670', '10', '0', '0', '0', '0'), ('1670', '11', '0', '0', '0', '0'), ('1670', '12', '0', '0', '0', '0'), ('1670', '13', '0', '0', '0', '0'), ('1670', '14', '0', '0', '0', '0'), ('1670', '15', '0', '0', '0', '0'), ('1670', '16', '0', '0', '0', '0'), ('1670', '17', '0', '0', '0', '0'), ('1670', '18', '0', '0', '0', '0'), ('1670', '19', '0', '0', '0', '0'), ('1670', '20', '0', '0', '0', '0'), ('1670', '21', '0', '0', '0', '0'), ('1670', '22', '0', '0', '0', '0'), ('1670', '23', '0', '0', '0', '0'), ('1670', '24', '0', '0', '0', '0'), ('1670', '25', '0', '0', '0', '0'), ('1670', '26', '0', '0', '0', '0'), ('1670', '27', '0', '0', '0', '0'), ('1670', '28', '0', '0', '0', '0'), ('1670', '29', '0', '0', '0', '0'), ('1670', '30', '0', '0', '0', '0'), ('1670', '31', '0', '0', '0', '0'), ('1670', '32', '0', '0', '0', '0'), ('1670', '33', '0', '0', '0', '0'), ('1670', '34', '0', '0', '0', '0'), ('1670', '35', '0', '0', '0', '0'), ('1670', '36', '0', '0', '0', '0'), ('1670', '37', '0', '0', '0', '0'), ('1700', '-11', '0', '0', '0', '0'), ('1700', '-10', '0', '0', '0', '0'), ('1700', '-9', '0', '0', '0', '0'), ('1700', '-8', '0', '0', '0', '0'), ('1700', '-7', '0', '0', '0', '0'), ('1700', '-6', '0', '0', '0', '0'), ('1700', '-5', '0', '0', '0', '0'), ('1700', '-4', '0', '0', '0', '0'), ('1700', '-3', '0', '0', '0', '0'), ('1700', '-2', '0', '0', '0', '0'), ('1700', '-1', '0', '0', '0', '0'), ('1700', '0', '0', '0', '0', '0'), ('1700', '1', '0', '0', '0', '0'), ('1700', '2', '0', '0', '0', '0'), ('1700', '3', '0', '0', '0', '0'), ('1700', '4', '0', '0', '0', '0'), ('1700', '5', '0', '0', '0', '0'), ('1700', '6', '0', '0', '0', '0'), ('1700', '7', '0', '0', '0', '0'), ('1700', '8', '0', '0', '0', '0'), ('1700', '9', '0', '0', '0', '0'), ('1700', '10', '0', '0', '0', '0'), ('1700', '11', '0', '0', '0', '0'), ('1700', '12', '0', '0', '0', '0'), ('1700', '13', '0', '0', '0', '0'), ('1700', '14', '0', '0', '0', '0'), ('1700', '15', '0', '0', '0', '0'), ('1700', '16', '0', '0', '0', '0'), ('1700', '17', '0', '0', '0', '0'), ('1700', '18', '0', '0', '0', '0'), ('1700', '19', '0', '0', '0', '0'), ('1700', '20', '0', '0', '0', '0'), ('1700', '21', '0', '0', '0', '0'), ('1700', '22', '0', '0', '0', '0'), ('1700', '23', '0', '0', '0', '0'), ('1700', '24', '0', '0', '0', '0'), ('1700', '25', '0', '0', '0', '0'), ('1700', '26', '0', '0', '0', '0'), ('1700', '27', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1700', '28', '0', '0', '0', '0'), ('1700', '29', '0', '0', '0', '0'), ('1700', '30', '0', '0', '0', '0'), ('1700', '31', '0', '0', '0', '0'), ('1700', '32', '0', '0', '0', '0'), ('1700', '33', '0', '0', '0', '0'), ('1700', '34', '0', '0', '0', '0'), ('1700', '35', '0', '0', '0', '0'), ('1700', '36', '0', '0', '0', '0'), ('1700', '37', '0', '0', '0', '0'), ('1710', '-11', '0', '0', '0', '0'), ('1710', '-10', '0', '0', '0', '0'), ('1710', '-9', '0', '0', '0', '0'), ('1710', '-8', '0', '0', '0', '0'), ('1710', '-7', '0', '0', '0', '0'), ('1710', '-6', '0', '0', '0', '0'), ('1710', '-5', '0', '0', '0', '0'), ('1710', '-4', '0', '0', '0', '0'), ('1710', '-3', '0', '0', '0', '0'), ('1710', '-2', '0', '0', '0', '0'), ('1710', '-1', '0', '0', '0', '0'), ('1710', '0', '0', '0', '0', '0'), ('1710', '1', '0', '0', '0', '0'), ('1710', '2', '0', '0', '0', '0'), ('1710', '3', '0', '0', '0', '0'), ('1710', '4', '0', '0', '0', '0'), ('1710', '5', '0', '0', '0', '0'), ('1710', '6', '0', '0', '0', '0'), ('1710', '7', '0', '0', '0', '0'), ('1710', '8', '0', '0', '0', '0'), ('1710', '9', '0', '0', '0', '0'), ('1710', '10', '0', '0', '0', '0'), ('1710', '11', '0', '0', '0', '0'), ('1710', '12', '0', '0', '0', '0'), ('1710', '13', '0', '0', '0', '0'), ('1710', '14', '0', '0', '0', '0'), ('1710', '15', '0', '0', '0', '0'), ('1710', '16', '0', '0', '0', '0'), ('1710', '17', '0', '0', '0', '0'), ('1710', '18', '0', '0', '0', '0'), ('1710', '19', '0', '0', '0', '0'), ('1710', '20', '0', '0', '0', '0'), ('1710', '21', '0', '0', '0', '0'), ('1710', '22', '0', '0', '0', '0'), ('1710', '23', '0', '0', '0', '0'), ('1710', '24', '0', '0', '0', '0'), ('1710', '25', '0', '0', '0', '0'), ('1710', '26', '0', '0', '0', '0'), ('1710', '27', '0', '0', '0', '0'), ('1710', '28', '0', '0', '0', '0'), ('1710', '29', '0', '0', '0', '0'), ('1710', '30', '0', '0', '0', '0'), ('1710', '31', '0', '0', '0', '0'), ('1710', '32', '0', '0', '0', '0'), ('1710', '33', '0', '0', '0', '0'), ('1710', '34', '0', '0', '0', '0'), ('1710', '35', '0', '0', '0', '0'), ('1710', '36', '0', '0', '0', '0'), ('1710', '37', '0', '0', '0', '0'), ('1720', '-11', '0', '0', '0', '0'), ('1720', '-10', '0', '0', '0', '0'), ('1720', '-9', '0', '0', '0', '0'), ('1720', '-8', '0', '0', '0', '0'), ('1720', '-7', '0', '0', '0', '0'), ('1720', '-6', '0', '0', '0', '0'), ('1720', '-5', '0', '0', '0', '0'), ('1720', '-4', '0', '0', '0', '0'), ('1720', '-3', '0', '0', '0', '0'), ('1720', '-2', '0', '0', '0', '0'), ('1720', '-1', '0', '0', '0', '0'), ('1720', '0', '0', '0', '0', '0'), ('1720', '1', '0', '0', '0', '0'), ('1720', '2', '0', '0', '0', '0'), ('1720', '3', '0', '0', '0', '0'), ('1720', '4', '0', '0', '0', '0'), ('1720', '5', '0', '0', '0', '0'), ('1720', '6', '0', '0', '0', '0'), ('1720', '7', '0', '0', '0', '0'), ('1720', '8', '0', '0', '0', '0'), ('1720', '9', '0', '0', '0', '0'), ('1720', '10', '0', '0', '0', '0'), ('1720', '11', '0', '0', '0', '0'), ('1720', '12', '0', '0', '0', '0'), ('1720', '13', '0', '0', '0', '0'), ('1720', '14', '0', '0', '0', '0'), ('1720', '15', '0', '0', '0', '0'), ('1720', '16', '0', '0', '0', '0'), ('1720', '17', '0', '0', '0', '0'), ('1720', '18', '0', '0', '0', '0'), ('1720', '19', '0', '0', '0', '0'), ('1720', '20', '0', '0', '0', '0'), ('1720', '21', '0', '0', '0', '0'), ('1720', '22', '0', '0', '0', '0'), ('1720', '23', '0', '0', '0', '0'), ('1720', '24', '0', '0', '0', '0'), ('1720', '25', '0', '0', '0', '0'), ('1720', '26', '0', '0', '0', '0'), ('1720', '27', '0', '0', '0', '0'), ('1720', '28', '0', '0', '0', '0'), ('1720', '29', '0', '0', '0', '0'), ('1720', '30', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1720', '31', '0', '0', '0', '0'), ('1720', '32', '0', '0', '0', '0'), ('1720', '33', '0', '0', '0', '0'), ('1720', '34', '0', '0', '0', '0'), ('1720', '35', '0', '0', '0', '0'), ('1720', '36', '0', '0', '0', '0'), ('1720', '37', '0', '0', '0', '0'), ('1730', '-11', '0', '0', '0', '0'), ('1730', '-10', '0', '0', '0', '0'), ('1730', '-9', '0', '0', '0', '0'), ('1730', '-8', '0', '0', '0', '0'), ('1730', '-7', '0', '0', '0', '0'), ('1730', '-6', '0', '0', '0', '0'), ('1730', '-5', '0', '0', '0', '0'), ('1730', '-4', '0', '0', '0', '0'), ('1730', '-3', '0', '0', '0', '0'), ('1730', '-2', '0', '0', '0', '0'), ('1730', '-1', '0', '0', '0', '0'), ('1730', '0', '0', '0', '0', '0'), ('1730', '1', '0', '0', '0', '0'), ('1730', '2', '0', '0', '0', '0'), ('1730', '3', '0', '0', '0', '0'), ('1730', '4', '0', '0', '0', '0'), ('1730', '5', '0', '0', '0', '0'), ('1730', '6', '0', '0', '0', '0'), ('1730', '7', '0', '0', '0', '0'), ('1730', '8', '0', '0', '0', '0'), ('1730', '9', '0', '0', '0', '0'), ('1730', '10', '0', '0', '0', '0'), ('1730', '11', '0', '0', '0', '0'), ('1730', '12', '0', '0', '0', '0'), ('1730', '13', '0', '0', '0', '0'), ('1730', '14', '0', '0', '0', '0'), ('1730', '15', '0', '0', '0', '0'), ('1730', '16', '0', '0', '0', '0'), ('1730', '17', '0', '0', '0', '0'), ('1730', '18', '0', '0', '0', '0'), ('1730', '19', '0', '0', '0', '0'), ('1730', '20', '0', '0', '0', '0'), ('1730', '21', '0', '0', '0', '0'), ('1730', '22', '0', '0', '0', '0'), ('1730', '23', '0', '0', '0', '0'), ('1730', '24', '0', '0', '0', '0'), ('1730', '25', '0', '0', '0', '0'), ('1730', '26', '0', '0', '0', '0'), ('1730', '27', '0', '0', '0', '0'), ('1730', '28', '0', '0', '0', '0'), ('1730', '29', '0', '0', '0', '0'), ('1730', '30', '0', '0', '0', '0'), ('1730', '31', '0', '0', '0', '0'), ('1730', '32', '0', '0', '0', '0'), ('1730', '33', '0', '0', '0', '0'), ('1730', '34', '0', '0', '0', '0'), ('1730', '35', '0', '0', '0', '0'), ('1730', '36', '0', '0', '0', '0'), ('1730', '37', '0', '0', '0', '0'), ('1740', '-11', '0', '0', '0', '0'), ('1740', '-10', '0', '0', '0', '0'), ('1740', '-9', '0', '0', '0', '0'), ('1740', '-8', '0', '0', '0', '0'), ('1740', '-7', '0', '0', '0', '0'), ('1740', '-6', '0', '0', '0', '0'), ('1740', '-5', '0', '0', '0', '0'), ('1740', '-4', '0', '0', '0', '0'), ('1740', '-3', '0', '0', '0', '0'), ('1740', '-2', '0', '0', '0', '0'), ('1740', '-1', '0', '0', '0', '0'), ('1740', '0', '0', '0', '0', '0'), ('1740', '1', '0', '0', '0', '0'), ('1740', '2', '0', '0', '0', '0'), ('1740', '3', '0', '0', '0', '0'), ('1740', '4', '0', '0', '0', '0'), ('1740', '5', '0', '0', '0', '0'), ('1740', '6', '0', '0', '0', '0'), ('1740', '7', '0', '0', '0', '0'), ('1740', '8', '0', '0', '0', '0'), ('1740', '9', '0', '0', '0', '0'), ('1740', '10', '0', '0', '0', '0'), ('1740', '11', '0', '0', '0', '0'), ('1740', '12', '0', '0', '0', '0'), ('1740', '13', '0', '0', '0', '0'), ('1740', '14', '0', '0', '0', '0'), ('1740', '15', '0', '0', '0', '0'), ('1740', '16', '0', '0', '0', '0'), ('1740', '17', '0', '0', '0', '0'), ('1740', '18', '0', '0', '0', '0'), ('1740', '19', '0', '0', '0', '0'), ('1740', '20', '0', '0', '0', '0'), ('1740', '21', '0', '0', '0', '0'), ('1740', '22', '0', '0', '0', '0'), ('1740', '23', '0', '0', '0', '0'), ('1740', '24', '0', '0', '0', '0'), ('1740', '25', '0', '0', '0', '0'), ('1740', '26', '0', '0', '0', '0'), ('1740', '27', '0', '0', '0', '0'), ('1740', '28', '0', '0', '0', '0'), ('1740', '29', '0', '0', '0', '0'), ('1740', '30', '0', '0', '0', '0'), ('1740', '31', '0', '0', '0', '0'), ('1740', '32', '0', '0', '0', '0'), ('1740', '33', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1740', '34', '0', '0', '0', '0'), ('1740', '35', '0', '0', '0', '0'), ('1740', '36', '0', '0', '0', '0'), ('1740', '37', '0', '0', '0', '0'), ('1750', '-11', '0', '0', '0', '0'), ('1750', '-10', '0', '0', '0', '0'), ('1750', '-9', '0', '0', '0', '0'), ('1750', '-8', '0', '0', '0', '0'), ('1750', '-7', '0', '0', '0', '0'), ('1750', '-6', '0', '0', '0', '0'), ('1750', '-5', '0', '0', '0', '0'), ('1750', '-4', '0', '0', '0', '0'), ('1750', '-3', '0', '0', '0', '0'), ('1750', '-2', '0', '0', '0', '0'), ('1750', '-1', '0', '0', '0', '0'), ('1750', '0', '0', '0', '0', '0'), ('1750', '1', '0', '0', '0', '0'), ('1750', '2', '0', '0', '0', '0'), ('1750', '3', '0', '0', '0', '0'), ('1750', '4', '0', '0', '0', '0'), ('1750', '5', '0', '0', '0', '0'), ('1750', '6', '0', '0', '0', '0'), ('1750', '7', '0', '0', '0', '0'), ('1750', '8', '0', '0', '0', '0'), ('1750', '9', '0', '0', '0', '0'), ('1750', '10', '0', '0', '0', '0'), ('1750', '11', '0', '0', '0', '0'), ('1750', '12', '0', '0', '0', '0'), ('1750', '13', '0', '0', '0', '0'), ('1750', '14', '0', '0', '0', '0'), ('1750', '15', '0', '0', '0', '0'), ('1750', '16', '0', '0', '0', '0'), ('1750', '17', '0', '0', '0', '0'), ('1750', '18', '0', '0', '0', '0'), ('1750', '19', '0', '0', '0', '0'), ('1750', '20', '0', '0', '0', '0'), ('1750', '21', '0', '0', '0', '0'), ('1750', '22', '0', '0', '0', '0'), ('1750', '23', '0', '0', '0', '0'), ('1750', '24', '0', '0', '0', '0'), ('1750', '25', '0', '0', '0', '0'), ('1750', '26', '0', '0', '0', '0'), ('1750', '27', '0', '0', '0', '0'), ('1750', '28', '0', '0', '0', '0'), ('1750', '29', '0', '0', '0', '0'), ('1750', '30', '0', '0', '0', '0'), ('1750', '31', '0', '0', '0', '0'), ('1750', '32', '0', '0', '0', '0'), ('1750', '33', '0', '0', '0', '0'), ('1750', '34', '0', '0', '0', '0'), ('1750', '35', '0', '0', '0', '0'), ('1750', '36', '0', '0', '0', '0'), ('1750', '37', '0', '0', '0', '0'), ('1760', '-11', '0', '0', '0', '0'), ('1760', '-10', '0', '0', '0', '0'), ('1760', '-9', '0', '0', '0', '0'), ('1760', '-8', '0', '0', '0', '0'), ('1760', '-7', '0', '0', '0', '0'), ('1760', '-6', '0', '0', '0', '0'), ('1760', '-5', '0', '0', '0', '0'), ('1760', '-4', '0', '0', '0', '0'), ('1760', '-3', '0', '0', '0', '0'), ('1760', '-2', '0', '0', '0', '0'), ('1760', '-1', '0', '0', '0', '0'), ('1760', '0', '0', '0', '0', '0'), ('1760', '1', '0', '0', '0', '0'), ('1760', '2', '0', '0', '0', '0'), ('1760', '3', '0', '0', '0', '0'), ('1760', '4', '0', '0', '0', '0'), ('1760', '5', '0', '0', '0', '0'), ('1760', '6', '0', '0', '0', '0'), ('1760', '7', '0', '0', '0', '0'), ('1760', '8', '0', '0', '0', '0'), ('1760', '9', '0', '0', '0', '0'), ('1760', '10', '0', '0', '0', '0'), ('1760', '11', '0', '0', '0', '0'), ('1760', '12', '0', '0', '0', '0'), ('1760', '13', '0', '0', '0', '0'), ('1760', '14', '0', '0', '0', '0'), ('1760', '15', '0', '0', '0', '0'), ('1760', '16', '0', '0', '0', '0'), ('1760', '17', '0', '0', '0', '0'), ('1760', '18', '0', '0', '0', '0'), ('1760', '19', '0', '0', '0', '0'), ('1760', '20', '0', '0', '0', '0'), ('1760', '21', '0', '0', '0', '0'), ('1760', '22', '0', '0', '0', '0'), ('1760', '23', '0', '0', '0', '0'), ('1760', '24', '0', '0', '0', '0'), ('1760', '25', '0', '0', '0', '0'), ('1760', '26', '0', '0', '0', '0'), ('1760', '27', '0', '0', '0', '0'), ('1760', '28', '0', '0', '0', '0'), ('1760', '29', '0', '0', '0', '0'), ('1760', '30', '0', '0', '0', '0'), ('1760', '31', '0', '0', '0', '0'), ('1760', '32', '0', '0', '0', '0'), ('1760', '33', '0', '0', '0', '0'), ('1760', '34', '0', '0', '0', '0'), ('1760', '35', '0', '0', '0', '0'), ('1760', '36', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1760', '37', '0', '0', '0', '0'), ('1770', '-11', '0', '0', '0', '0'), ('1770', '-10', '0', '0', '0', '0'), ('1770', '-9', '0', '0', '0', '0'), ('1770', '-8', '0', '0', '0', '0'), ('1770', '-7', '0', '0', '0', '0'), ('1770', '-6', '0', '0', '0', '0'), ('1770', '-5', '0', '0', '0', '0'), ('1770', '-4', '0', '0', '0', '0'), ('1770', '-3', '0', '0', '0', '0'), ('1770', '-2', '0', '0', '0', '0'), ('1770', '-1', '0', '0', '0', '0'), ('1770', '0', '0', '0', '0', '0'), ('1770', '1', '0', '0', '0', '0'), ('1770', '2', '0', '0', '0', '0'), ('1770', '3', '0', '0', '0', '0'), ('1770', '4', '0', '0', '0', '0'), ('1770', '5', '0', '0', '0', '0'), ('1770', '6', '0', '0', '0', '0'), ('1770', '7', '0', '0', '0', '0'), ('1770', '8', '0', '0', '0', '0'), ('1770', '9', '0', '0', '0', '0'), ('1770', '10', '0', '0', '0', '0'), ('1770', '11', '0', '0', '0', '0'), ('1770', '12', '0', '0', '0', '0'), ('1770', '13', '0', '0', '0', '0'), ('1770', '14', '0', '0', '0', '0'), ('1770', '15', '0', '0', '0', '0'), ('1770', '16', '0', '0', '0', '0'), ('1770', '17', '0', '0', '0', '0'), ('1770', '18', '0', '0', '0', '0'), ('1770', '19', '0', '0', '0', '0'), ('1770', '20', '0', '0', '0', '0'), ('1770', '21', '0', '0', '0', '0'), ('1770', '22', '0', '0', '0', '0'), ('1770', '23', '0', '0', '0', '0'), ('1770', '24', '0', '0', '0', '0'), ('1770', '25', '0', '0', '0', '0'), ('1770', '26', '0', '0', '0', '0'), ('1770', '27', '0', '0', '0', '0'), ('1770', '28', '0', '0', '0', '0'), ('1770', '29', '0', '0', '0', '0'), ('1770', '30', '0', '0', '0', '0'), ('1770', '31', '0', '0', '0', '0'), ('1770', '32', '0', '0', '0', '0'), ('1770', '33', '0', '0', '0', '0'), ('1770', '34', '0', '0', '0', '0'), ('1770', '35', '0', '0', '0', '0'), ('1770', '36', '0', '0', '0', '0'), ('1770', '37', '0', '0', '0', '0'), ('1780', '-11', '0', '0', '0', '0'), ('1780', '-10', '0', '0', '0', '0'), ('1780', '-9', '0', '0', '0', '0'), ('1780', '-8', '0', '0', '0', '0'), ('1780', '-7', '0', '0', '0', '0'), ('1780', '-6', '0', '0', '0', '0'), ('1780', '-5', '0', '0', '0', '0'), ('1780', '-4', '0', '0', '0', '0'), ('1780', '-3', '0', '0', '0', '0'), ('1780', '-2', '0', '0', '0', '0'), ('1780', '-1', '0', '0', '0', '0'), ('1780', '0', '0', '0', '0', '0'), ('1780', '1', '0', '0', '0', '0'), ('1780', '2', '0', '0', '0', '0'), ('1780', '3', '0', '0', '0', '0'), ('1780', '4', '0', '0', '0', '0'), ('1780', '5', '0', '0', '0', '0'), ('1780', '6', '0', '0', '0', '0'), ('1780', '7', '0', '0', '0', '0'), ('1780', '8', '0', '0', '0', '0'), ('1780', '9', '0', '0', '0', '0'), ('1780', '10', '0', '0', '0', '0'), ('1780', '11', '0', '0', '0', '0'), ('1780', '12', '0', '0', '0', '0'), ('1780', '13', '0', '0', '0', '0'), ('1780', '14', '0', '0', '0', '0'), ('1780', '15', '0', '0', '0', '0'), ('1780', '16', '0', '0', '0', '0'), ('1780', '17', '0', '0', '0', '0'), ('1780', '18', '0', '0', '0', '0'), ('1780', '19', '0', '0', '0', '0'), ('1780', '20', '0', '0', '0', '0'), ('1780', '21', '0', '0', '0', '0'), ('1780', '22', '0', '0', '0', '0'), ('1780', '23', '0', '0', '0', '0'), ('1780', '24', '0', '0', '0', '0'), ('1780', '25', '0', '0', '0', '0'), ('1780', '26', '0', '0', '0', '0'), ('1780', '27', '0', '0', '0', '0'), ('1780', '28', '0', '0', '0', '0'), ('1780', '29', '0', '0', '0', '0'), ('1780', '30', '0', '0', '0', '0'), ('1780', '31', '0', '0', '0', '0'), ('1780', '32', '0', '0', '0', '0'), ('1780', '33', '0', '0', '0', '0'), ('1780', '34', '0', '0', '0', '0'), ('1780', '35', '0', '0', '0', '0'), ('1780', '36', '0', '0', '0', '0'), ('1780', '37', '0', '0', '0', '0'), ('1790', '-11', '0', '0', '0', '0'), ('1790', '-10', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1790', '-9', '0', '0', '0', '0'), ('1790', '-8', '0', '0', '0', '0'), ('1790', '-7', '0', '0', '0', '0'), ('1790', '-6', '0', '0', '0', '0'), ('1790', '-5', '0', '0', '0', '0'), ('1790', '-4', '0', '0', '0', '0'), ('1790', '-3', '0', '0', '0', '0'), ('1790', '-2', '0', '0', '0', '0'), ('1790', '-1', '0', '0', '0', '0'), ('1790', '0', '0', '0', '0', '0'), ('1790', '1', '0', '0', '0', '0'), ('1790', '2', '0', '0', '0', '0'), ('1790', '3', '0', '0', '0', '0'), ('1790', '4', '0', '0', '0', '0'), ('1790', '5', '0', '0', '0', '0'), ('1790', '6', '0', '0', '0', '0'), ('1790', '7', '0', '0', '0', '0'), ('1790', '8', '0', '0', '0', '0'), ('1790', '9', '0', '0', '0', '0'), ('1790', '10', '0', '0', '0', '0'), ('1790', '11', '0', '0', '0', '0'), ('1790', '12', '0', '0', '0', '0'), ('1790', '13', '0', '0', '0', '0'), ('1790', '14', '0', '0', '0', '0'), ('1790', '15', '0', '0', '0', '0'), ('1790', '16', '0', '0', '0', '0'), ('1790', '17', '0', '0', '0', '0'), ('1790', '18', '0', '0', '0', '0'), ('1790', '19', '0', '0', '0', '0'), ('1790', '20', '0', '0', '0', '0'), ('1790', '21', '0', '0', '0', '0'), ('1790', '22', '0', '0', '0', '0'), ('1790', '23', '0', '0', '0', '0'), ('1790', '24', '0', '0', '0', '0'), ('1790', '25', '0', '0', '0', '0'), ('1790', '26', '0', '0', '0', '0'), ('1790', '27', '0', '0', '0', '0'), ('1790', '28', '0', '0', '0', '0'), ('1790', '29', '0', '0', '0', '0'), ('1790', '30', '0', '0', '0', '0'), ('1790', '31', '0', '0', '0', '0'), ('1790', '32', '0', '0', '0', '0'), ('1790', '33', '0', '0', '0', '0'), ('1790', '34', '0', '0', '0', '0'), ('1790', '35', '0', '0', '0', '0'), ('1790', '36', '0', '0', '0', '0'), ('1790', '37', '0', '0', '0', '0'), ('1800', '-11', '0', '0', '0', '0'), ('1800', '-10', '0', '0', '0', '0'), ('1800', '-9', '0', '0', '0', '0'), ('1800', '-8', '0', '0', '0', '0'), ('1800', '-7', '0', '0', '0', '0'), ('1800', '-6', '0', '0', '0', '0'), ('1800', '-5', '0', '0', '0', '0'), ('1800', '-4', '0', '0', '0', '0'), ('1800', '-3', '0', '0', '0', '0'), ('1800', '-2', '0', '0', '0', '0'), ('1800', '-1', '0', '0', '0', '0'), ('1800', '0', '0', '0', '0', '0'), ('1800', '1', '0', '0', '0', '0'), ('1800', '2', '0', '0', '0', '0'), ('1800', '3', '0', '0', '0', '0'), ('1800', '4', '0', '0', '0', '0'), ('1800', '5', '0', '0', '0', '0'), ('1800', '6', '0', '0', '0', '0'), ('1800', '7', '0', '0', '0', '0'), ('1800', '8', '0', '0', '0', '0'), ('1800', '9', '0', '0', '0', '0'), ('1800', '10', '0', '0', '0', '0'), ('1800', '11', '0', '0', '0', '0'), ('1800', '12', '0', '0', '0', '0'), ('1800', '13', '0', '0', '0', '0'), ('1800', '14', '0', '0', '0', '0'), ('1800', '15', '0', '0', '0', '0'), ('1800', '16', '0', '0', '0', '0'), ('1800', '17', '0', '0', '0', '0'), ('1800', '18', '0', '0', '0', '0'), ('1800', '19', '0', '0', '0', '0'), ('1800', '20', '0', '0', '0', '0'), ('1800', '21', '0', '0', '0', '0'), ('1800', '22', '0', '0', '0', '0'), ('1800', '23', '0', '0', '0', '0'), ('1800', '24', '0', '0', '0', '0'), ('1800', '25', '0', '0', '0', '0'), ('1800', '26', '0', '0', '0', '0'), ('1800', '27', '0', '0', '0', '0'), ('1800', '28', '0', '0', '0', '0'), ('1800', '29', '0', '0', '0', '0'), ('1800', '30', '0', '0', '0', '0'), ('1800', '31', '0', '0', '0', '0'), ('1800', '32', '0', '0', '0', '0'), ('1800', '33', '0', '0', '0', '0'), ('1800', '34', '0', '0', '0', '0'), ('1800', '35', '0', '0', '0', '0'), ('1800', '36', '0', '0', '0', '0'), ('1800', '37', '0', '0', '0', '0'), ('1850', '-11', '0', '0', '0', '0'), ('1850', '-10', '0', '0', '0', '0'), ('1850', '-9', '0', '0', '0', '0'), ('1850', '-8', '0', '0', '0', '0'), ('1850', '-7', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('1850', '-6', '0', '0', '0', '0'), ('1850', '-5', '0', '0', '0', '0'), ('1850', '-4', '0', '0', '0', '0'), ('1850', '-3', '0', '0', '0', '0'), ('1850', '-2', '0', '0', '0', '0'), ('1850', '-1', '0', '0', '0', '0'), ('1850', '0', '0', '0', '0', '0'), ('1850', '1', '0', '0', '0', '0'), ('1850', '2', '0', '0', '0', '0'), ('1850', '3', '0', '0', '0', '0'), ('1850', '4', '0', '0', '0', '0'), ('1850', '5', '0', '0', '0', '0'), ('1850', '6', '0', '0', '0', '0'), ('1850', '7', '0', '0', '0', '0'), ('1850', '8', '0', '0', '0', '0'), ('1850', '9', '0', '0', '0', '0'), ('1850', '10', '0', '0', '0', '0'), ('1850', '11', '0', '0', '0', '0'), ('1850', '12', '0', '0', '0', '0'), ('1850', '13', '0', '0', '0', '0'), ('1850', '14', '0', '0', '0', '0'), ('1850', '15', '0', '0', '0', '0'), ('1850', '16', '0', '0', '0', '0'), ('1850', '17', '0', '0', '0', '0'), ('1850', '18', '0', '0', '0', '0'), ('1850', '19', '0', '0', '0', '0'), ('1850', '20', '0', '0', '0', '0'), ('1850', '21', '0', '0', '0', '0'), ('1850', '22', '0', '0', '0', '0'), ('1850', '23', '0', '0', '0', '0'), ('1850', '24', '0', '0', '0', '0'), ('1850', '25', '0', '0', '0', '0'), ('1850', '26', '0', '0', '0', '0'), ('1850', '27', '0', '0', '0', '0'), ('1850', '28', '0', '0', '0', '0'), ('1850', '29', '0', '0', '0', '0'), ('1850', '30', '0', '0', '0', '0'), ('1850', '31', '0', '0', '0', '0'), ('1850', '32', '0', '0', '0', '0'), ('1850', '33', '0', '0', '0', '0'), ('1850', '34', '0', '0', '0', '0'), ('1850', '35', '0', '0', '0', '0'), ('1850', '36', '0', '0', '0', '0'), ('1850', '37', '0', '0', '0', '0'), ('1900', '-11', '0', '0', '0', '0'), ('1900', '-10', '0', '0', '0', '0'), ('1900', '-9', '0', '0', '0', '0'), ('1900', '-8', '0', '0', '0', '0'), ('1900', '-7', '0', '0', '0', '0'), ('1900', '-6', '0', '0', '0', '0'), ('1900', '-5', '0', '0', '0', '0'), ('1900', '-4', '0', '0', '0', '0'), ('1900', '-3', '0', '0', '0', '0'), ('1900', '-2', '0', '0', '0', '0'), ('1900', '-1', '0', '0', '0', '0'), ('1900', '0', '0', '0', '0', '0'), ('1900', '1', '0', '0', '0', '0'), ('1900', '2', '0', '0', '0', '0'), ('1900', '3', '0', '0', '0', '0'), ('1900', '4', '0', '0', '0', '0'), ('1900', '5', '0', '0', '0', '0'), ('1900', '6', '0', '0', '0', '0'), ('1900', '7', '0', '0', '0', '0'), ('1900', '8', '0', '0', '0', '0'), ('1900', '9', '0', '0', '0', '0'), ('1900', '10', '0', '0', '0', '0'), ('1900', '11', '0', '0', '0', '0'), ('1900', '12', '0', '0', '0', '0'), ('1900', '13', '0', '0', '0', '0'), ('1900', '14', '0', '0', '0', '0'), ('1900', '15', '0', '0', '0', '0'), ('1900', '16', '0', '0', '0', '0'), ('1900', '17', '0', '0', '0', '0'), ('1900', '18', '0', '0', '0', '0'), ('1900', '19', '0', '0', '0', '0'), ('1900', '20', '0', '0', '0', '0'), ('1900', '21', '0', '0', '0', '0'), ('1900', '22', '0', '0', '0', '0'), ('1900', '23', '0', '0', '0', '0'), ('1900', '24', '0', '0', '0', '0'), ('1900', '25', '0', '0', '0', '0'), ('1900', '26', '0', '0', '0', '0'), ('1900', '27', '0', '0', '0', '0'), ('1900', '28', '0', '0', '0', '0'), ('1900', '29', '0', '0', '0', '0'), ('1900', '30', '0', '0', '0', '0'), ('1900', '31', '0', '0', '0', '0'), ('1900', '32', '0', '0', '0', '0'), ('1900', '33', '0', '0', '0', '0'), ('1900', '34', '0', '0', '0', '0'), ('1900', '35', '0', '0', '0', '0'), ('1900', '36', '0', '0', '0', '0'), ('1900', '37', '0', '0', '0', '0'), ('2010', '-11', '0', '0', '0', '0'), ('2010', '-10', '0', '0', '0', '0'), ('2010', '-9', '0', '0', '0', '0'), ('2010', '-8', '0', '0', '0', '0'), ('2010', '-7', '0', '0', '0', '0'), ('2010', '-6', '0', '0', '0', '0'), ('2010', '-5', '0', '0', '0', '0'), ('2010', '-4', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2010', '-3', '0', '0', '0', '0'), ('2010', '-2', '0', '0', '0', '0'), ('2010', '-1', '0', '0', '0', '0'), ('2010', '0', '0', '0', '0', '0'), ('2010', '1', '0', '0', '0', '0'), ('2010', '2', '0', '0', '0', '0'), ('2010', '3', '0', '0', '0', '0'), ('2010', '4', '0', '0', '0', '0'), ('2010', '5', '0', '0', '0', '0'), ('2010', '6', '0', '0', '0', '0'), ('2010', '7', '0', '0', '0', '0'), ('2010', '8', '0', '0', '0', '0'), ('2010', '9', '0', '0', '0', '0'), ('2010', '10', '0', '0', '0', '0'), ('2010', '11', '0', '0', '0', '0'), ('2010', '12', '0', '0', '0', '0'), ('2010', '13', '0', '0', '0', '0'), ('2010', '14', '0', '0', '0', '0'), ('2010', '15', '0', '0', '0', '0'), ('2010', '16', '0', '0', '0', '0'), ('2010', '17', '0', '0', '0', '0'), ('2010', '18', '0', '0', '0', '0'), ('2010', '19', '0', '0', '0', '0'), ('2010', '20', '0', '0', '0', '0'), ('2010', '21', '0', '0', '0', '0'), ('2010', '22', '0', '0', '0', '0'), ('2010', '23', '0', '0', '0', '0'), ('2010', '24', '0', '0', '0', '0'), ('2010', '25', '0', '0', '0', '0'), ('2010', '26', '0', '0', '0', '0'), ('2010', '27', '0', '0', '0', '0'), ('2010', '28', '0', '0', '0', '0'), ('2010', '29', '0', '0', '0', '0'), ('2010', '30', '0', '0', '0', '0'), ('2010', '31', '0', '0', '0', '0'), ('2010', '32', '0', '0', '0', '0'), ('2010', '33', '0', '0', '0', '0'), ('2010', '34', '0', '0', '0', '0'), ('2010', '35', '0', '0', '0', '0'), ('2010', '36', '0', '0', '0', '0'), ('2010', '37', '0', '0', '0', '0'), ('2020', '-11', '0', '0', '0', '0'), ('2020', '-10', '0', '0', '0', '0'), ('2020', '-9', '0', '0', '0', '0'), ('2020', '-8', '0', '0', '0', '0'), ('2020', '-7', '0', '0', '0', '0'), ('2020', '-6', '0', '0', '0', '0'), ('2020', '-5', '0', '0', '0', '0'), ('2020', '-4', '0', '0', '0', '0'), ('2020', '-3', '0', '0', '0', '0'), ('2020', '-2', '0', '0', '0', '0'), ('2020', '-1', '0', '0', '0', '0'), ('2020', '0', '0', '0', '0', '0'), ('2020', '1', '0', '0', '0', '0'), ('2020', '2', '0', '0', '0', '0'), ('2020', '3', '0', '0', '0', '0'), ('2020', '4', '0', '0', '0', '0'), ('2020', '5', '0', '0', '0', '0'), ('2020', '6', '0', '0', '0', '0'), ('2020', '7', '0', '0', '0', '0'), ('2020', '8', '0', '0', '0', '0'), ('2020', '9', '0', '0', '0', '0'), ('2020', '10', '0', '0', '0', '0'), ('2020', '11', '0', '0', '0', '0'), ('2020', '12', '0', '0', '0', '0'), ('2020', '13', '0', '0', '0', '0'), ('2020', '14', '0', '0', '0', '0'), ('2020', '15', '0', '0', '0', '0'), ('2020', '16', '0', '0', '0', '0'), ('2020', '17', '0', '0', '0', '0'), ('2020', '18', '0', '0', '0', '0'), ('2020', '19', '0', '0', '0', '0'), ('2020', '20', '0', '0', '0', '0'), ('2020', '21', '0', '0', '0', '0'), ('2020', '22', '0', '0', '0', '0'), ('2020', '23', '0', '0', '0', '0'), ('2020', '24', '0', '0', '0', '0'), ('2020', '25', '0', '0', '0', '0'), ('2020', '26', '0', '0', '0', '0'), ('2020', '27', '0', '0', '0', '0'), ('2020', '28', '0', '0', '0', '0'), ('2020', '29', '0', '0', '0', '0'), ('2020', '30', '0', '0', '0', '0'), ('2020', '31', '0', '0', '0', '0'), ('2020', '32', '0', '0', '0', '0'), ('2020', '33', '0', '0', '0', '0'), ('2020', '34', '0', '0', '0', '0'), ('2020', '35', '0', '0', '0', '0'), ('2020', '36', '0', '0', '0', '0'), ('2020', '37', '0', '0', '0', '0'), ('2050', '-11', '0', '0', '0', '0'), ('2050', '-10', '0', '0', '0', '0'), ('2050', '-9', '0', '0', '0', '0'), ('2050', '-8', '0', '0', '0', '0'), ('2050', '-7', '0', '0', '0', '0'), ('2050', '-6', '0', '0', '0', '0'), ('2050', '-5', '0', '0', '0', '0'), ('2050', '-4', '0', '0', '0', '0'), ('2050', '-3', '0', '0', '0', '0'), ('2050', '-2', '0', '0', '0', '0'), ('2050', '-1', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2050', '0', '0', '0', '0', '0'), ('2050', '1', '0', '0', '0', '0'), ('2050', '2', '0', '0', '0', '0'), ('2050', '3', '0', '0', '0', '0'), ('2050', '4', '0', '0', '0', '0'), ('2050', '5', '0', '0', '0', '0'), ('2050', '6', '0', '0', '0', '0'), ('2050', '7', '0', '0', '0', '0'), ('2050', '8', '0', '0', '0', '0'), ('2050', '9', '0', '0', '0', '0'), ('2050', '10', '0', '0', '0', '0'), ('2050', '11', '0', '0', '0', '0'), ('2050', '12', '0', '0', '0', '0'), ('2050', '13', '0', '0', '0', '0'), ('2050', '14', '0', '0', '0', '0'), ('2050', '15', '0', '0', '0', '0'), ('2050', '16', '0', '0', '0', '0'), ('2050', '17', '0', '0', '0', '0'), ('2050', '18', '0', '0', '0', '0'), ('2050', '19', '0', '0', '0', '0'), ('2050', '20', '0', '0', '0', '0'), ('2050', '21', '0', '0', '0', '0'), ('2050', '22', '0', '0', '0', '0'), ('2050', '23', '0', '0', '0', '0'), ('2050', '24', '0', '0', '0', '0'), ('2050', '25', '0', '0', '0', '0'), ('2050', '26', '0', '0', '0', '0'), ('2050', '27', '0', '0', '0', '0'), ('2050', '28', '0', '0', '0', '0'), ('2050', '29', '0', '0', '0', '0'), ('2050', '30', '0', '0', '0', '0'), ('2050', '31', '0', '0', '0', '0'), ('2050', '32', '0', '0', '0', '0'), ('2050', '33', '0', '0', '0', '0'), ('2050', '34', '0', '0', '0', '0'), ('2050', '35', '0', '0', '0', '0'), ('2050', '36', '0', '0', '0', '0'), ('2050', '37', '0', '0', '0', '0'), ('2100', '-11', '0', '0', '0', '0'), ('2100', '-10', '0', '0', '0', '0'), ('2100', '-9', '0', '0', '0', '0'), ('2100', '-8', '0', '0', '0', '0'), ('2100', '-7', '0', '0', '0', '0'), ('2100', '-6', '0', '0', '0', '0'), ('2100', '-5', '0', '0', '0', '0'), ('2100', '-4', '0', '0', '0', '0'), ('2100', '-3', '0', '0', '0', '0'), ('2100', '-2', '0', '0', '0', '0'), ('2100', '-1', '0', '0', '0', '0'), ('2100', '0', '0', '-1447.74', '0', '0'), ('2100', '1', '0', '0', '-1447.74', '0'), ('2100', '2', '0', '0', '-1447.74', '0'), ('2100', '3', '0', '0', '-1447.74', '0'), ('2100', '4', '0', '0', '-1447.74', '0'), ('2100', '5', '0', '0', '-1447.74', '0'), ('2100', '6', '0', '0', '-1447.74', '0'), ('2100', '7', '0', '0', '-1447.74', '0'), ('2100', '8', '0', '0', '-1447.74', '0'), ('2100', '9', '0', '0', '-1447.74', '0'), ('2100', '10', '0', '0', '-1447.74', '0'), ('2100', '11', '0', '0', '-1447.74', '0'), ('2100', '12', '0', '0', '-1447.74', '0'), ('2100', '13', '0', '0', '-1447.74', '0'), ('2100', '14', '0', '0', '-1447.74', '0'), ('2100', '15', '0', '0', '-1447.74', '0'), ('2100', '16', '0', '0', '-1447.74', '0'), ('2100', '17', '0', '0', '-1447.74', '0'), ('2100', '18', '0', '0', '-1447.74', '0'), ('2100', '19', '0', '0', '-1447.74', '0'), ('2100', '20', '0', '0', '-1447.74', '0'), ('2100', '21', '0', '0', '-1447.74', '0'), ('2100', '22', '0', '0', '-1447.74', '0'), ('2100', '23', '0', '0', '-1447.74', '0'), ('2100', '24', '0', '0', '-1447.74', '0'), ('2100', '25', '0', '0', '-1447.74', '0'), ('2100', '26', '0', '0', '-1447.74', '0'), ('2100', '27', '0', '0', '-1447.74', '0'), ('2100', '28', '0', '0', '-1447.74', '0'), ('2100', '29', '0', '0', '-1447.74', '0'), ('2100', '30', '0', '0', '-1447.74', '0'), ('2100', '31', '0', '0', '-1447.74', '0'), ('2100', '32', '0', '0', '-1447.74', '0'), ('2100', '33', '0', '0', '-1447.74', '0'), ('2100', '34', '0', '0', '-1447.74', '0'), ('2100', '35', '0', '0', '-1447.74', '0'), ('2100', '36', '0', '0', '-1447.74', '0'), ('2100', '37', '0', '0', '-1447.74', '0'), ('2150', '-11', '0', '0', '0', '0'), ('2150', '-10', '0', '0', '0', '0'), ('2150', '-9', '0', '0', '0', '0'), ('2150', '-8', '0', '0', '0', '0'), ('2150', '-7', '0', '0', '0', '0'), ('2150', '-6', '0', '0', '0', '0'), ('2150', '-5', '0', '0', '0', '0'), ('2150', '-4', '0', '0', '0', '0'), ('2150', '-3', '0', '0', '0', '0'), ('2150', '-2', '0', '0', '0', '0'), ('2150', '-1', '0', '0', '0', '0'), ('2150', '0', '0', '0', '0', '0'), ('2150', '1', '0', '0', '0', '0'), ('2150', '2', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2150', '3', '0', '0', '0', '0'), ('2150', '4', '0', '0', '0', '0'), ('2150', '5', '0', '0', '0', '0'), ('2150', '6', '0', '0', '0', '0'), ('2150', '7', '0', '0', '0', '0'), ('2150', '8', '0', '0', '0', '0'), ('2150', '9', '0', '0', '0', '0'), ('2150', '10', '0', '0', '0', '0'), ('2150', '11', '0', '0', '0', '0'), ('2150', '12', '0', '0', '0', '0'), ('2150', '13', '0', '0', '0', '0'), ('2150', '14', '0', '0', '0', '0'), ('2150', '15', '0', '0', '0', '0'), ('2150', '16', '0', '0', '0', '0'), ('2150', '17', '0', '0', '0', '0'), ('2150', '18', '0', '0', '0', '0'), ('2150', '19', '0', '0', '0', '0'), ('2150', '20', '0', '0', '0', '0'), ('2150', '21', '0', '-36.4', '0', '0'), ('2150', '22', '0', '0', '-36.4', '0'), ('2150', '23', '0', '0', '0', '0'), ('2150', '24', '0', '0', '0', '0'), ('2150', '25', '0', '0', '0', '0'), ('2150', '26', '0', '0', '0', '0'), ('2150', '27', '0', '0', '0', '0'), ('2150', '28', '0', '0', '0', '0'), ('2150', '29', '0', '0', '0', '0'), ('2150', '30', '0', '0', '0', '0'), ('2150', '31', '0', '0', '0', '0'), ('2150', '32', '0', '0', '0', '0'), ('2150', '33', '0', '0', '0', '0'), ('2150', '34', '0', '0', '0', '0'), ('2150', '35', '0', '0', '0', '0'), ('2150', '36', '0', '0', '0', '0'), ('2150', '37', '0', '0', '0', '0'), ('2200', '-11', '0', '0', '0', '0'), ('2200', '-10', '0', '0', '0', '0'), ('2200', '-9', '0', '0', '0', '0'), ('2200', '-8', '0', '0', '0', '0'), ('2200', '-7', '0', '0', '0', '0'), ('2200', '-6', '0', '0', '0', '0'), ('2200', '-5', '0', '0', '0', '0'), ('2200', '-4', '0', '0', '0', '0'), ('2200', '-3', '0', '0', '0', '0'), ('2200', '-2', '0', '0', '0', '0'), ('2200', '-1', '0', '0', '0', '0'), ('2200', '0', '0', '0', '0', '0'), ('2200', '1', '0', '0', '0', '0'), ('2200', '2', '0', '0', '0', '0'), ('2200', '3', '0', '0', '0', '0'), ('2200', '4', '0', '0', '0', '0'), ('2200', '5', '0', '0', '0', '0'), ('2200', '6', '0', '0', '0', '0'), ('2200', '7', '0', '0', '0', '0'), ('2200', '8', '0', '0', '0', '0'), ('2200', '9', '0', '0', '0', '0'), ('2200', '10', '0', '0', '0', '0'), ('2200', '11', '0', '0', '0', '0'), ('2200', '12', '0', '0', '0', '0'), ('2200', '13', '0', '0', '0', '0'), ('2200', '14', '0', '0', '0', '0'), ('2200', '15', '0', '0', '0', '0'), ('2200', '16', '0', '0', '0', '0'), ('2200', '17', '0', '0', '0', '0'), ('2200', '18', '0', '0', '0', '0'), ('2200', '19', '0', '0', '0', '0'), ('2200', '20', '0', '0', '0', '0'), ('2200', '21', '0', '0', '0', '0'), ('2200', '22', '0', '0', '0', '0'), ('2200', '23', '0', '0', '0', '0'), ('2200', '24', '0', '0', '0', '0'), ('2200', '25', '0', '0', '0', '0'), ('2200', '26', '0', '0', '0', '0'), ('2200', '27', '0', '0', '0', '0'), ('2200', '28', '0', '0', '0', '0'), ('2200', '29', '0', '0', '0', '0'), ('2200', '30', '0', '0', '0', '0'), ('2200', '31', '0', '0', '0', '0'), ('2200', '32', '0', '0', '0', '0'), ('2200', '33', '0', '0', '0', '0'), ('2200', '34', '0', '0', '0', '0'), ('2200', '35', '0', '0', '0', '0'), ('2200', '36', '0', '0', '0', '0'), ('2200', '37', '0', '0', '0', '0'), ('2230', '-11', '0', '0', '0', '0'), ('2230', '-10', '0', '0', '0', '0'), ('2230', '-9', '0', '0', '0', '0'), ('2230', '-8', '0', '0', '0', '0'), ('2230', '-7', '0', '0', '0', '0'), ('2230', '-6', '0', '0', '0', '0'), ('2230', '-5', '0', '0', '0', '0'), ('2230', '-4', '0', '0', '0', '0'), ('2230', '-3', '0', '0', '0', '0'), ('2230', '-2', '0', '0', '0', '0'), ('2230', '-1', '0', '0', '0', '0'), ('2230', '0', '0', '0', '0', '0'), ('2230', '1', '0', '0', '0', '0'), ('2230', '2', '0', '0', '0', '0'), ('2230', '3', '0', '0', '0', '0'), ('2230', '4', '0', '0', '0', '0'), ('2230', '5', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2230', '6', '0', '0', '0', '0'), ('2230', '7', '0', '0', '0', '0'), ('2230', '8', '0', '0', '0', '0'), ('2230', '9', '0', '0', '0', '0'), ('2230', '10', '0', '0', '0', '0'), ('2230', '11', '0', '0', '0', '0'), ('2230', '12', '0', '0', '0', '0'), ('2230', '13', '0', '0', '0', '0'), ('2230', '14', '0', '0', '0', '0'), ('2230', '15', '0', '0', '0', '0'), ('2230', '16', '0', '0', '0', '0'), ('2230', '17', '0', '0', '0', '0'), ('2230', '18', '0', '0', '0', '0'), ('2230', '19', '0', '0', '0', '0'), ('2230', '20', '0', '0', '0', '0'), ('2230', '21', '0', '0', '0', '0'), ('2230', '22', '0', '0', '0', '0'), ('2230', '23', '0', '0', '0', '0'), ('2230', '24', '0', '0', '0', '0'), ('2230', '25', '0', '0', '0', '0'), ('2230', '26', '0', '0', '0', '0'), ('2230', '27', '0', '0', '0', '0'), ('2230', '28', '0', '0', '0', '0'), ('2230', '29', '0', '0', '0', '0'), ('2230', '30', '0', '0', '0', '0'), ('2230', '31', '0', '0', '0', '0'), ('2230', '32', '0', '0', '0', '0'), ('2230', '33', '0', '0', '0', '0'), ('2230', '34', '0', '0', '0', '0'), ('2230', '35', '0', '0', '0', '0'), ('2230', '36', '0', '0', '0', '0'), ('2230', '37', '0', '0', '0', '0'), ('2250', '-11', '0', '0', '0', '0'), ('2250', '-10', '0', '0', '0', '0'), ('2250', '-9', '0', '0', '0', '0'), ('2250', '-8', '0', '0', '0', '0'), ('2250', '-7', '0', '0', '0', '0'), ('2250', '-6', '0', '0', '0', '0'), ('2250', '-5', '0', '0', '0', '0'), ('2250', '-4', '0', '0', '0', '0'), ('2250', '-3', '0', '0', '0', '0'), ('2250', '-2', '0', '0', '0', '0'), ('2250', '-1', '0', '0', '0', '0'), ('2250', '0', '0', '0', '0', '0'), ('2250', '1', '0', '0', '0', '0'), ('2250', '2', '0', '0', '0', '0'), ('2250', '3', '0', '0', '0', '0'), ('2250', '4', '0', '0', '0', '0'), ('2250', '5', '0', '0', '0', '0'), ('2250', '6', '0', '0', '0', '0'), ('2250', '7', '0', '0', '0', '0'), ('2250', '8', '0', '0', '0', '0'), ('2250', '9', '0', '0', '0', '0'), ('2250', '10', '0', '0', '0', '0'), ('2250', '11', '0', '0', '0', '0'), ('2250', '12', '0', '0', '0', '0'), ('2250', '13', '0', '0', '0', '0'), ('2250', '14', '0', '0', '0', '0'), ('2250', '15', '0', '0', '0', '0'), ('2250', '16', '0', '0', '0', '0'), ('2250', '17', '0', '0', '0', '0'), ('2250', '18', '0', '0', '0', '0'), ('2250', '19', '0', '0', '0', '0'), ('2250', '20', '0', '0', '0', '0'), ('2250', '21', '0', '0', '0', '0'), ('2250', '22', '0', '0', '0', '0'), ('2250', '23', '0', '0', '0', '0'), ('2250', '24', '0', '0', '0', '0'), ('2250', '25', '0', '0', '0', '0'), ('2250', '26', '0', '0', '0', '0'), ('2250', '27', '0', '0', '0', '0'), ('2250', '28', '0', '0', '0', '0'), ('2250', '29', '0', '0', '0', '0'), ('2250', '30', '0', '0', '0', '0'), ('2250', '31', '0', '0', '0', '0'), ('2250', '32', '0', '0', '0', '0'), ('2250', '33', '0', '0', '0', '0'), ('2250', '34', '0', '0', '0', '0'), ('2250', '35', '0', '0', '0', '0'), ('2250', '36', '0', '0', '0', '0'), ('2250', '37', '0', '0', '0', '0'), ('2300', '-11', '0', '0', '0', '0'), ('2300', '-10', '0', '0', '0', '0'), ('2300', '-9', '0', '0', '0', '0'), ('2300', '-8', '0', '0', '0', '0'), ('2300', '-7', '0', '0', '0', '0'), ('2300', '-6', '0', '0', '0', '0'), ('2300', '-5', '0', '0', '0', '0'), ('2300', '-4', '0', '0', '0', '0'), ('2300', '-3', '0', '0', '0', '0'), ('2300', '-2', '0', '0', '0', '0'), ('2300', '-1', '0', '0', '0', '0'), ('2300', '0', '0', '0', '0', '0'), ('2300', '1', '0', '0', '0', '0'), ('2300', '2', '0', '0', '0', '0'), ('2300', '3', '0', '0', '0', '0'), ('2300', '4', '0', '0', '0', '0'), ('2300', '5', '0', '0', '0', '0'), ('2300', '6', '0', '0', '0', '0'), ('2300', '7', '0', '0', '0', '0'), ('2300', '8', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2300', '9', '0', '0', '0', '0'), ('2300', '10', '0', '0', '0', '0'), ('2300', '11', '0', '0', '0', '0'), ('2300', '12', '0', '0', '0', '0'), ('2300', '13', '0', '0', '0', '0'), ('2300', '14', '0', '0', '0', '0'), ('2300', '15', '0', '0', '0', '0'), ('2300', '16', '0', '0', '0', '0'), ('2300', '17', '0', '0', '0', '0'), ('2300', '18', '0', '0', '0', '0'), ('2300', '19', '0', '0', '0', '0'), ('2300', '20', '0', '0', '0', '0'), ('2300', '21', '0', '0', '0', '0'), ('2300', '22', '0', '0', '0', '0'), ('2300', '23', '0', '0', '0', '0'), ('2300', '24', '0', '0', '0', '0'), ('2300', '25', '0', '0', '0', '0'), ('2300', '26', '0', '0', '0', '0'), ('2300', '27', '0', '0', '0', '0'), ('2300', '28', '0', '0', '0', '0'), ('2300', '29', '0', '0', '0', '0'), ('2300', '30', '0', '0', '0', '0'), ('2300', '31', '0', '0', '0', '0'), ('2300', '32', '0', '0', '0', '0'), ('2300', '33', '0', '0', '0', '0'), ('2300', '34', '0', '0', '0', '0'), ('2300', '35', '0', '0', '0', '0'), ('2300', '36', '0', '0', '0', '0'), ('2300', '37', '0', '0', '0', '0'), ('2310', '-11', '0', '0', '0', '0'), ('2310', '-10', '0', '0', '0', '0'), ('2310', '-9', '0', '0', '0', '0'), ('2310', '-8', '0', '0', '0', '0'), ('2310', '-7', '0', '0', '0', '0'), ('2310', '-6', '0', '0', '0', '0'), ('2310', '-5', '0', '0', '0', '0'), ('2310', '-4', '0', '0', '0', '0'), ('2310', '-3', '0', '0', '0', '0'), ('2310', '-2', '0', '0', '0', '0'), ('2310', '-1', '0', '0', '0', '0'), ('2310', '0', '0', '0', '0', '0'), ('2310', '1', '0', '0', '0', '0'), ('2310', '2', '0', '0', '0', '0'), ('2310', '3', '0', '0', '0', '0'), ('2310', '4', '0', '0', '0', '0'), ('2310', '5', '0', '0', '0', '0'), ('2310', '6', '0', '0', '0', '0'), ('2310', '7', '0', '0', '0', '0'), ('2310', '8', '0', '0', '0', '0'), ('2310', '9', '0', '0', '0', '0'), ('2310', '10', '0', '0', '0', '0'), ('2310', '11', '0', '0', '0', '0'), ('2310', '12', '0', '0', '0', '0'), ('2310', '13', '0', '0', '0', '0'), ('2310', '14', '0', '0', '0', '0'), ('2310', '15', '0', '0', '0', '0'), ('2310', '16', '0', '0', '0', '0'), ('2310', '17', '0', '0', '0', '0'), ('2310', '18', '0', '0', '0', '0'), ('2310', '19', '0', '0', '0', '0'), ('2310', '20', '0', '0', '0', '0'), ('2310', '21', '0', '0', '0', '0'), ('2310', '22', '0', '0', '0', '0'), ('2310', '23', '0', '0', '0', '0'), ('2310', '24', '0', '0', '0', '0'), ('2310', '25', '0', '0', '0', '0'), ('2310', '26', '0', '0', '0', '0'), ('2310', '27', '0', '0', '0', '0'), ('2310', '28', '0', '0', '0', '0'), ('2310', '29', '0', '0', '0', '0'), ('2310', '30', '0', '0', '0', '0'), ('2310', '31', '0', '0', '0', '0'), ('2310', '32', '0', '0', '0', '0'), ('2310', '33', '0', '0', '0', '0'), ('2310', '34', '0', '0', '0', '0'), ('2310', '35', '0', '0', '0', '0'), ('2310', '36', '0', '0', '0', '0'), ('2310', '37', '0', '0', '0', '0'), ('2320', '-11', '0', '0', '0', '0'), ('2320', '-10', '0', '0', '0', '0'), ('2320', '-9', '0', '0', '0', '0'), ('2320', '-8', '0', '0', '0', '0'), ('2320', '-7', '0', '0', '0', '0'), ('2320', '-6', '0', '0', '0', '0'), ('2320', '-5', '0', '0', '0', '0'), ('2320', '-4', '0', '0', '0', '0'), ('2320', '-3', '0', '0', '0', '0'), ('2320', '-2', '0', '0', '0', '0'), ('2320', '-1', '0', '0', '0', '0'), ('2320', '0', '0', '0', '0', '0'), ('2320', '1', '0', '0', '0', '0'), ('2320', '2', '0', '0', '0', '0'), ('2320', '3', '0', '0', '0', '0'), ('2320', '4', '0', '0', '0', '0'), ('2320', '5', '0', '0', '0', '0'), ('2320', '6', '0', '0', '0', '0'), ('2320', '7', '0', '0', '0', '0'), ('2320', '8', '0', '0', '0', '0'), ('2320', '9', '0', '0', '0', '0'), ('2320', '10', '0', '0', '0', '0'), ('2320', '11', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2320', '12', '0', '0', '0', '0'), ('2320', '13', '0', '0', '0', '0'), ('2320', '14', '0', '0', '0', '0'), ('2320', '15', '0', '0', '0', '0'), ('2320', '16', '0', '0', '0', '0'), ('2320', '17', '0', '0', '0', '0'), ('2320', '18', '0', '0', '0', '0'), ('2320', '19', '0', '0', '0', '0'), ('2320', '20', '0', '0', '0', '0'), ('2320', '21', '0', '0', '0', '0'), ('2320', '22', '0', '0', '0', '0'), ('2320', '23', '0', '0', '0', '0'), ('2320', '24', '0', '0', '0', '0'), ('2320', '25', '0', '0', '0', '0'), ('2320', '26', '0', '0', '0', '0'), ('2320', '27', '0', '0', '0', '0'), ('2320', '28', '0', '0', '0', '0'), ('2320', '29', '0', '0', '0', '0'), ('2320', '30', '0', '0', '0', '0'), ('2320', '31', '0', '0', '0', '0'), ('2320', '32', '0', '0', '0', '0'), ('2320', '33', '0', '0', '0', '0'), ('2320', '34', '0', '0', '0', '0'), ('2320', '35', '0', '0', '0', '0'), ('2320', '36', '0', '0', '0', '0'), ('2320', '37', '0', '0', '0', '0'), ('2330', '-11', '0', '0', '0', '0'), ('2330', '-10', '0', '0', '0', '0'), ('2330', '-9', '0', '0', '0', '0'), ('2330', '-8', '0', '0', '0', '0'), ('2330', '-7', '0', '0', '0', '0'), ('2330', '-6', '0', '0', '0', '0'), ('2330', '-5', '0', '0', '0', '0'), ('2330', '-4', '0', '0', '0', '0'), ('2330', '-3', '0', '0', '0', '0'), ('2330', '-2', '0', '0', '0', '0'), ('2330', '-1', '0', '0', '0', '0'), ('2330', '0', '0', '0', '0', '0'), ('2330', '1', '0', '0', '0', '0'), ('2330', '2', '0', '0', '0', '0'), ('2330', '3', '0', '0', '0', '0'), ('2330', '4', '0', '0', '0', '0'), ('2330', '5', '0', '0', '0', '0'), ('2330', '6', '0', '0', '0', '0'), ('2330', '7', '0', '0', '0', '0'), ('2330', '8', '0', '0', '0', '0'), ('2330', '9', '0', '0', '0', '0'), ('2330', '10', '0', '0', '0', '0'), ('2330', '11', '0', '0', '0', '0'), ('2330', '12', '0', '0', '0', '0'), ('2330', '13', '0', '0', '0', '0'), ('2330', '14', '0', '0', '0', '0'), ('2330', '15', '0', '0', '0', '0'), ('2330', '16', '0', '0', '0', '0'), ('2330', '17', '0', '0', '0', '0'), ('2330', '18', '0', '0', '0', '0'), ('2330', '19', '0', '0', '0', '0'), ('2330', '20', '0', '0', '0', '0'), ('2330', '21', '0', '0', '0', '0'), ('2330', '22', '0', '0', '0', '0'), ('2330', '23', '0', '0', '0', '0'), ('2330', '24', '0', '0', '0', '0'), ('2330', '25', '0', '0', '0', '0'), ('2330', '26', '0', '0', '0', '0'), ('2330', '27', '0', '0', '0', '0'), ('2330', '28', '0', '0', '0', '0'), ('2330', '29', '0', '0', '0', '0'), ('2330', '30', '0', '0', '0', '0'), ('2330', '31', '0', '0', '0', '0'), ('2330', '32', '0', '0', '0', '0'), ('2330', '33', '0', '0', '0', '0'), ('2330', '34', '0', '0', '0', '0'), ('2330', '35', '0', '0', '0', '0'), ('2330', '36', '0', '0', '0', '0'), ('2330', '37', '0', '0', '0', '0'), ('2340', '-11', '0', '0', '0', '0'), ('2340', '-10', '0', '0', '0', '0'), ('2340', '-9', '0', '0', '0', '0'), ('2340', '-8', '0', '0', '0', '0'), ('2340', '-7', '0', '0', '0', '0'), ('2340', '-6', '0', '0', '0', '0'), ('2340', '-5', '0', '0', '0', '0'), ('2340', '-4', '0', '0', '0', '0'), ('2340', '-3', '0', '0', '0', '0'), ('2340', '-2', '0', '0', '0', '0'), ('2340', '-1', '0', '0', '0', '0'), ('2340', '0', '0', '0', '0', '0'), ('2340', '1', '0', '0', '0', '0'), ('2340', '2', '0', '0', '0', '0'), ('2340', '3', '0', '0', '0', '0'), ('2340', '4', '0', '0', '0', '0'), ('2340', '5', '0', '0', '0', '0'), ('2340', '6', '0', '0', '0', '0'), ('2340', '7', '0', '0', '0', '0'), ('2340', '8', '0', '0', '0', '0'), ('2340', '9', '0', '0', '0', '0'), ('2340', '10', '0', '0', '0', '0'), ('2340', '11', '0', '0', '0', '0'), ('2340', '12', '0', '0', '0', '0'), ('2340', '13', '0', '0', '0', '0'), ('2340', '14', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2340', '15', '0', '0', '0', '0'), ('2340', '16', '0', '0', '0', '0'), ('2340', '17', '0', '0', '0', '0'), ('2340', '18', '0', '0', '0', '0'), ('2340', '19', '0', '0', '0', '0'), ('2340', '20', '0', '0', '0', '0'), ('2340', '21', '0', '0', '0', '0'), ('2340', '22', '0', '0', '0', '0'), ('2340', '23', '0', '0', '0', '0'), ('2340', '24', '0', '0', '0', '0'), ('2340', '25', '0', '0', '0', '0'), ('2340', '26', '0', '0', '0', '0'), ('2340', '27', '0', '0', '0', '0'), ('2340', '28', '0', '0', '0', '0'), ('2340', '29', '0', '0', '0', '0'), ('2340', '30', '0', '0', '0', '0'), ('2340', '31', '0', '0', '0', '0'), ('2340', '32', '0', '0', '0', '0'), ('2340', '33', '0', '0', '0', '0'), ('2340', '34', '0', '0', '0', '0'), ('2340', '35', '0', '0', '0', '0'), ('2340', '36', '0', '0', '0', '0'), ('2340', '37', '0', '0', '0', '0'), ('2350', '-11', '0', '0', '0', '0'), ('2350', '-10', '0', '0', '0', '0'), ('2350', '-9', '0', '0', '0', '0'), ('2350', '-8', '0', '0', '0', '0'), ('2350', '-7', '0', '0', '0', '0'), ('2350', '-6', '0', '0', '0', '0'), ('2350', '-5', '0', '0', '0', '0'), ('2350', '-4', '0', '0', '0', '0'), ('2350', '-3', '0', '0', '0', '0'), ('2350', '-2', '0', '0', '0', '0'), ('2350', '-1', '0', '0', '0', '0'), ('2350', '0', '0', '0', '0', '0'), ('2350', '1', '0', '0', '0', '0'), ('2350', '2', '0', '0', '0', '0'), ('2350', '3', '0', '0', '0', '0'), ('2350', '4', '0', '0', '0', '0'), ('2350', '5', '0', '0', '0', '0'), ('2350', '6', '0', '0', '0', '0'), ('2350', '7', '0', '0', '0', '0'), ('2350', '8', '0', '0', '0', '0'), ('2350', '9', '0', '0', '0', '0'), ('2350', '10', '0', '0', '0', '0'), ('2350', '11', '0', '0', '0', '0'), ('2350', '12', '0', '0', '0', '0'), ('2350', '13', '0', '0', '0', '0'), ('2350', '14', '0', '0', '0', '0'), ('2350', '15', '0', '0', '0', '0'), ('2350', '16', '0', '0', '0', '0'), ('2350', '17', '0', '0', '0', '0'), ('2350', '18', '0', '0', '0', '0'), ('2350', '19', '0', '0', '0', '0'), ('2350', '20', '0', '0', '0', '0'), ('2350', '21', '0', '0', '0', '0'), ('2350', '22', '0', '0', '0', '0'), ('2350', '23', '0', '0', '0', '0'), ('2350', '24', '0', '0', '0', '0'), ('2350', '25', '0', '0', '0', '0'), ('2350', '26', '0', '0', '0', '0'), ('2350', '27', '0', '0', '0', '0'), ('2350', '28', '0', '0', '0', '0'), ('2350', '29', '0', '0', '0', '0'), ('2350', '30', '0', '0', '0', '0'), ('2350', '31', '0', '0', '0', '0'), ('2350', '32', '0', '0', '0', '0'), ('2350', '33', '0', '0', '0', '0'), ('2350', '34', '0', '0', '0', '0'), ('2350', '35', '0', '0', '0', '0'), ('2350', '36', '0', '0', '0', '0'), ('2350', '37', '0', '0', '0', '0'), ('2360', '-11', '0', '0', '0', '0'), ('2360', '-10', '0', '0', '0', '0'), ('2360', '-9', '0', '0', '0', '0'), ('2360', '-8', '0', '0', '0', '0'), ('2360', '-7', '0', '0', '0', '0'), ('2360', '-6', '0', '0', '0', '0'), ('2360', '-5', '0', '0', '0', '0'), ('2360', '-4', '0', '0', '0', '0'), ('2360', '-3', '0', '0', '0', '0'), ('2360', '-2', '0', '0', '0', '0'), ('2360', '-1', '0', '0', '0', '0'), ('2360', '0', '0', '0', '0', '0'), ('2360', '1', '0', '0', '0', '0'), ('2360', '2', '0', '0', '0', '0'), ('2360', '3', '0', '0', '0', '0'), ('2360', '4', '0', '0', '0', '0'), ('2360', '5', '0', '0', '0', '0'), ('2360', '6', '0', '0', '0', '0'), ('2360', '7', '0', '0', '0', '0'), ('2360', '8', '0', '0', '0', '0'), ('2360', '9', '0', '0', '0', '0'), ('2360', '10', '0', '0', '0', '0'), ('2360', '11', '0', '0', '0', '0'), ('2360', '12', '0', '0', '0', '0'), ('2360', '13', '0', '0', '0', '0'), ('2360', '14', '0', '0', '0', '0'), ('2360', '15', '0', '0', '0', '0'), ('2360', '16', '0', '0', '0', '0'), ('2360', '17', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2360', '18', '0', '0', '0', '0'), ('2360', '19', '0', '0', '0', '0'), ('2360', '20', '0', '0', '0', '0'), ('2360', '21', '0', '0', '0', '0'), ('2360', '22', '0', '0', '0', '0'), ('2360', '23', '0', '0', '0', '0'), ('2360', '24', '0', '0', '0', '0'), ('2360', '25', '0', '0', '0', '0'), ('2360', '26', '0', '0', '0', '0'), ('2360', '27', '0', '0', '0', '0'), ('2360', '28', '0', '0', '0', '0'), ('2360', '29', '0', '0', '0', '0'), ('2360', '30', '0', '0', '0', '0'), ('2360', '31', '0', '0', '0', '0'), ('2360', '32', '0', '0', '0', '0'), ('2360', '33', '0', '0', '0', '0'), ('2360', '34', '0', '0', '0', '0'), ('2360', '35', '0', '0', '0', '0'), ('2360', '36', '0', '0', '0', '0'), ('2360', '37', '0', '0', '0', '0'), ('2400', '-11', '0', '0', '0', '0'), ('2400', '-10', '0', '0', '0', '0'), ('2400', '-9', '0', '0', '0', '0'), ('2400', '-8', '0', '0', '0', '0'), ('2400', '-7', '0', '0', '0', '0'), ('2400', '-6', '0', '0', '0', '0'), ('2400', '-5', '0', '0', '0', '0'), ('2400', '-4', '0', '0', '0', '0'), ('2400', '-3', '0', '0', '0', '0'), ('2400', '-2', '0', '0', '0', '0'), ('2400', '-1', '0', '0', '0', '0'), ('2400', '0', '0', '0', '0', '0'), ('2400', '1', '0', '0', '0', '0'), ('2400', '2', '0', '0', '0', '0'), ('2400', '3', '0', '0', '0', '0'), ('2400', '4', '0', '0', '0', '0'), ('2400', '5', '0', '0', '0', '0'), ('2400', '6', '0', '0', '0', '0'), ('2400', '7', '0', '0', '0', '0'), ('2400', '8', '0', '0', '0', '0'), ('2400', '9', '0', '0', '0', '0'), ('2400', '10', '0', '0', '0', '0'), ('2400', '11', '0', '0', '0', '0'), ('2400', '12', '0', '0', '0', '0'), ('2400', '13', '0', '0', '0', '0'), ('2400', '14', '0', '0', '0', '0'), ('2400', '15', '0', '0', '0', '0'), ('2400', '16', '0', '0', '0', '0'), ('2400', '17', '0', '0', '0', '0'), ('2400', '18', '0', '0', '0', '0'), ('2400', '19', '0', '0', '0', '0'), ('2400', '20', '0', '0', '0', '0'), ('2400', '21', '0', '0', '0', '0'), ('2400', '22', '0', '0', '0', '0'), ('2400', '23', '0', '0', '0', '0'), ('2400', '24', '0', '0', '0', '0'), ('2400', '25', '0', '0', '0', '0'), ('2400', '26', '0', '0', '0', '0'), ('2400', '27', '0', '0', '0', '0'), ('2400', '28', '0', '0', '0', '0'), ('2400', '29', '0', '0', '0', '0'), ('2400', '30', '0', '0', '0', '0'), ('2400', '31', '0', '0', '0', '0'), ('2400', '32', '0', '0', '0', '0'), ('2400', '33', '0', '0', '0', '0'), ('2400', '34', '0', '0', '0', '0'), ('2400', '35', '0', '0', '0', '0'), ('2400', '36', '0', '0', '0', '0'), ('2400', '37', '0', '0', '0', '0'), ('2410', '-11', '0', '0', '0', '0'), ('2410', '-10', '0', '0', '0', '0'), ('2410', '-9', '0', '0', '0', '0'), ('2410', '-8', '0', '0', '0', '0'), ('2410', '-7', '0', '0', '0', '0'), ('2410', '-6', '0', '0', '0', '0'), ('2410', '-5', '0', '0', '0', '0'), ('2410', '-4', '0', '0', '0', '0'), ('2410', '-3', '0', '0', '0', '0'), ('2410', '-2', '0', '0', '0', '0'), ('2410', '-1', '0', '0', '0', '0'), ('2410', '0', '0', '0', '0', '0'), ('2410', '1', '0', '0', '0', '0'), ('2410', '2', '0', '0', '0', '0'), ('2410', '3', '0', '0', '0', '0'), ('2410', '4', '0', '0', '0', '0'), ('2410', '5', '0', '0', '0', '0'), ('2410', '6', '0', '0', '0', '0'), ('2410', '7', '0', '0', '0', '0'), ('2410', '8', '0', '0', '0', '0'), ('2410', '9', '0', '0', '0', '0'), ('2410', '10', '0', '0', '0', '0'), ('2410', '11', '0', '0', '0', '0'), ('2410', '12', '0', '0', '0', '0'), ('2410', '13', '0', '0', '0', '0'), ('2410', '14', '0', '0', '0', '0'), ('2410', '15', '0', '0', '0', '0'), ('2410', '16', '0', '0', '0', '0'), ('2410', '17', '0', '0', '0', '0'), ('2410', '18', '0', '0', '0', '0'), ('2410', '19', '0', '0', '0', '0'), ('2410', '20', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2410', '21', '0', '0', '0', '0'), ('2410', '22', '0', '0', '0', '0'), ('2410', '23', '0', '0', '0', '0'), ('2410', '24', '0', '0', '0', '0'), ('2410', '25', '0', '0', '0', '0'), ('2410', '26', '0', '0', '0', '0'), ('2410', '27', '0', '0', '0', '0'), ('2410', '28', '0', '0', '0', '0'), ('2410', '29', '0', '0', '0', '0'), ('2410', '30', '0', '0', '0', '0'), ('2410', '31', '0', '0', '0', '0'), ('2410', '32', '0', '0', '0', '0'), ('2410', '33', '0', '0', '0', '0'), ('2410', '34', '0', '0', '0', '0'), ('2410', '35', '0', '0', '0', '0'), ('2410', '36', '0', '0', '0', '0'), ('2410', '37', '0', '0', '0', '0'), ('2420', '-11', '0', '0', '0', '0'), ('2420', '-10', '0', '0', '0', '0'), ('2420', '-9', '0', '0', '0', '0'), ('2420', '-8', '0', '0', '0', '0'), ('2420', '-7', '0', '0', '0', '0'), ('2420', '-6', '0', '0', '0', '0'), ('2420', '-5', '0', '0', '0', '0'), ('2420', '-4', '0', '0', '0', '0'), ('2420', '-3', '0', '0', '0', '0'), ('2420', '-2', '0', '0', '0', '0'), ('2420', '-1', '0', '0', '0', '0'), ('2420', '0', '0', '0', '0', '0'), ('2420', '1', '0', '0', '0', '0'), ('2420', '2', '0', '0', '0', '0'), ('2420', '3', '0', '0', '0', '0'), ('2420', '4', '0', '0', '0', '0'), ('2420', '5', '0', '0', '0', '0'), ('2420', '6', '0', '0', '0', '0'), ('2420', '7', '0', '0', '0', '0'), ('2420', '8', '0', '0', '0', '0'), ('2420', '9', '0', '0', '0', '0'), ('2420', '10', '0', '0', '0', '0'), ('2420', '11', '0', '0', '0', '0'), ('2420', '12', '0', '0', '0', '0'), ('2420', '13', '0', '0', '0', '0'), ('2420', '14', '0', '0', '0', '0'), ('2420', '15', '0', '0', '0', '0'), ('2420', '16', '0', '0', '0', '0'), ('2420', '17', '0', '0', '0', '0'), ('2420', '18', '0', '0', '0', '0'), ('2420', '19', '0', '0', '0', '0'), ('2420', '20', '0', '0', '0', '0'), ('2420', '21', '0', '0', '0', '0'), ('2420', '22', '0', '0', '0', '0'), ('2420', '23', '0', '0', '0', '0'), ('2420', '24', '0', '0', '0', '0'), ('2420', '25', '0', '0', '0', '0'), ('2420', '26', '0', '0', '0', '0'), ('2420', '27', '0', '0', '0', '0'), ('2420', '28', '0', '0', '0', '0'), ('2420', '29', '0', '0', '0', '0'), ('2420', '30', '0', '0', '0', '0'), ('2420', '31', '0', '0', '0', '0'), ('2420', '32', '0', '0', '0', '0'), ('2420', '33', '0', '0', '0', '0'), ('2420', '34', '0', '0', '0', '0'), ('2420', '35', '0', '0', '0', '0'), ('2420', '36', '0', '0', '0', '0'), ('2420', '37', '0', '0', '0', '0'), ('2450', '-11', '0', '0', '0', '0'), ('2450', '-10', '0', '0', '0', '0'), ('2450', '-9', '0', '0', '0', '0'), ('2450', '-8', '0', '0', '0', '0'), ('2450', '-7', '0', '0', '0', '0'), ('2450', '-6', '0', '0', '0', '0'), ('2450', '-5', '0', '0', '0', '0'), ('2450', '-4', '0', '0', '0', '0'), ('2450', '-3', '0', '0', '0', '0'), ('2450', '-2', '0', '0', '0', '0'), ('2450', '-1', '0', '0', '0', '0'), ('2450', '0', '0', '0', '0', '0'), ('2450', '1', '0', '0', '0', '0'), ('2450', '2', '0', '0', '0', '0'), ('2450', '3', '0', '0', '0', '0'), ('2450', '4', '0', '0', '0', '0'), ('2450', '5', '0', '0', '0', '0'), ('2450', '6', '0', '0', '0', '0'), ('2450', '7', '0', '0', '0', '0'), ('2450', '8', '0', '0', '0', '0'), ('2450', '9', '0', '0', '0', '0'), ('2450', '10', '0', '0', '0', '0'), ('2450', '11', '0', '0', '0', '0'), ('2450', '12', '0', '0', '0', '0'), ('2450', '13', '0', '0', '0', '0'), ('2450', '14', '0', '0', '0', '0'), ('2450', '15', '0', '0', '0', '0'), ('2450', '16', '0', '0', '0', '0'), ('2450', '17', '0', '0', '0', '0'), ('2450', '18', '0', '0', '0', '0'), ('2450', '19', '0', '0', '0', '0'), ('2450', '20', '0', '0', '0', '0'), ('2450', '21', '0', '0', '0', '0'), ('2450', '22', '0', '0', '0', '0'), ('2450', '23', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2450', '24', '0', '0', '0', '0'), ('2450', '25', '0', '0', '0', '0'), ('2450', '26', '0', '0', '0', '0'), ('2450', '27', '0', '0', '0', '0'), ('2450', '28', '0', '0', '0', '0'), ('2450', '29', '0', '0', '0', '0'), ('2450', '30', '0', '0', '0', '0'), ('2450', '31', '0', '0', '0', '0'), ('2450', '32', '0', '0', '0', '0'), ('2450', '33', '0', '0', '0', '0'), ('2450', '34', '0', '0', '0', '0'), ('2450', '35', '0', '0', '0', '0'), ('2450', '36', '0', '0', '0', '0'), ('2450', '37', '0', '0', '0', '0'), ('2460', '-11', '0', '0', '0', '0'), ('2460', '-10', '0', '0', '0', '0'), ('2460', '-9', '0', '0', '0', '0'), ('2460', '-8', '0', '0', '0', '0'), ('2460', '-7', '0', '0', '0', '0'), ('2460', '-6', '0', '0', '0', '0'), ('2460', '-5', '0', '0', '0', '0'), ('2460', '-4', '0', '0', '0', '0'), ('2460', '-3', '0', '0', '0', '0'), ('2460', '-2', '0', '0', '0', '0'), ('2460', '-1', '0', '0', '0', '0'), ('2460', '0', '0', '0', '0', '0'), ('2460', '1', '0', '0', '0', '0'), ('2460', '2', '0', '0', '0', '0'), ('2460', '3', '0', '0', '0', '0'), ('2460', '4', '0', '0', '0', '0'), ('2460', '5', '0', '0', '0', '0'), ('2460', '6', '0', '0', '0', '0'), ('2460', '7', '0', '0', '0', '0'), ('2460', '8', '0', '0', '0', '0'), ('2460', '9', '0', '0', '0', '0'), ('2460', '10', '0', '0', '0', '0'), ('2460', '11', '0', '0', '0', '0'), ('2460', '12', '0', '0', '0', '0'), ('2460', '13', '0', '0', '0', '0'), ('2460', '14', '0', '0', '0', '0'), ('2460', '15', '0', '0', '0', '0'), ('2460', '16', '0', '0', '0', '0'), ('2460', '17', '0', '0', '0', '0'), ('2460', '18', '0', '0', '0', '0'), ('2460', '19', '0', '0', '0', '0'), ('2460', '20', '0', '0', '0', '0'), ('2460', '21', '0', '0', '0', '0'), ('2460', '22', '0', '0', '0', '0'), ('2460', '23', '0', '0', '0', '0'), ('2460', '24', '0', '0', '0', '0'), ('2460', '25', '0', '0', '0', '0'), ('2460', '26', '0', '0', '0', '0'), ('2460', '27', '0', '0', '0', '0'), ('2460', '28', '0', '0', '0', '0'), ('2460', '29', '0', '0', '0', '0'), ('2460', '30', '0', '0', '0', '0'), ('2460', '31', '0', '0', '0', '0'), ('2460', '32', '0', '0', '0', '0'), ('2460', '33', '0', '0', '0', '0'), ('2460', '34', '0', '0', '0', '0'), ('2460', '35', '0', '0', '0', '0'), ('2460', '36', '0', '0', '0', '0'), ('2460', '37', '0', '0', '0', '0'), ('2470', '-11', '0', '0', '0', '0'), ('2470', '-10', '0', '0', '0', '0'), ('2470', '-9', '0', '0', '0', '0'), ('2470', '-8', '0', '0', '0', '0'), ('2470', '-7', '0', '0', '0', '0'), ('2470', '-6', '0', '0', '0', '0'), ('2470', '-5', '0', '0', '0', '0'), ('2470', '-4', '0', '0', '0', '0'), ('2470', '-3', '0', '0', '0', '0'), ('2470', '-2', '0', '0', '0', '0'), ('2470', '-1', '0', '0', '0', '0'), ('2470', '0', '0', '0', '0', '0'), ('2470', '1', '0', '0', '0', '0'), ('2470', '2', '0', '0', '0', '0'), ('2470', '3', '0', '0', '0', '0'), ('2470', '4', '0', '0', '0', '0'), ('2470', '5', '0', '0', '0', '0'), ('2470', '6', '0', '0', '0', '0'), ('2470', '7', '0', '0', '0', '0'), ('2470', '8', '0', '0', '0', '0'), ('2470', '9', '0', '0', '0', '0'), ('2470', '10', '0', '0', '0', '0'), ('2470', '11', '0', '0', '0', '0'), ('2470', '12', '0', '0', '0', '0'), ('2470', '13', '0', '0', '0', '0'), ('2470', '14', '0', '0', '0', '0'), ('2470', '15', '0', '0', '0', '0'), ('2470', '16', '0', '0', '0', '0'), ('2470', '17', '0', '0', '0', '0'), ('2470', '18', '0', '0', '0', '0'), ('2470', '19', '0', '0', '0', '0'), ('2470', '20', '0', '0', '0', '0'), ('2470', '21', '0', '0', '0', '0'), ('2470', '22', '0', '0', '0', '0'), ('2470', '23', '0', '0', '0', '0'), ('2470', '24', '0', '0', '0', '0'), ('2470', '25', '0', '0', '0', '0'), ('2470', '26', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2470', '27', '0', '0', '0', '0'), ('2470', '28', '0', '0', '0', '0'), ('2470', '29', '0', '0', '0', '0'), ('2470', '30', '0', '0', '0', '0'), ('2470', '31', '0', '0', '0', '0'), ('2470', '32', '0', '0', '0', '0'), ('2470', '33', '0', '0', '0', '0'), ('2470', '34', '0', '0', '0', '0'), ('2470', '35', '0', '0', '0', '0'), ('2470', '36', '0', '0', '0', '0'), ('2470', '37', '0', '0', '0', '0'), ('2480', '-11', '0', '0', '0', '0'), ('2480', '-10', '0', '0', '0', '0'), ('2480', '-9', '0', '0', '0', '0'), ('2480', '-8', '0', '0', '0', '0'), ('2480', '-7', '0', '0', '0', '0'), ('2480', '-6', '0', '0', '0', '0'), ('2480', '-5', '0', '0', '0', '0'), ('2480', '-4', '0', '0', '0', '0'), ('2480', '-3', '0', '0', '0', '0'), ('2480', '-2', '0', '0', '0', '0'), ('2480', '-1', '0', '0', '0', '0'), ('2480', '0', '0', '0', '0', '0'), ('2480', '1', '0', '0', '0', '0'), ('2480', '2', '0', '0', '0', '0'), ('2480', '3', '0', '0', '0', '0'), ('2480', '4', '0', '0', '0', '0'), ('2480', '5', '0', '0', '0', '0'), ('2480', '6', '0', '0', '0', '0'), ('2480', '7', '0', '0', '0', '0'), ('2480', '8', '0', '0', '0', '0'), ('2480', '9', '0', '0', '0', '0'), ('2480', '10', '0', '0', '0', '0'), ('2480', '11', '0', '0', '0', '0'), ('2480', '12', '0', '0', '0', '0'), ('2480', '13', '0', '0', '0', '0'), ('2480', '14', '0', '0', '0', '0'), ('2480', '15', '0', '0', '0', '0'), ('2480', '16', '0', '0', '0', '0'), ('2480', '17', '0', '0', '0', '0'), ('2480', '18', '0', '0', '0', '0'), ('2480', '19', '0', '0', '0', '0'), ('2480', '20', '0', '0', '0', '0'), ('2480', '21', '0', '0', '0', '0'), ('2480', '22', '0', '0', '0', '0'), ('2480', '23', '0', '0', '0', '0'), ('2480', '24', '0', '0', '0', '0'), ('2480', '25', '0', '0', '0', '0'), ('2480', '26', '0', '0', '0', '0'), ('2480', '27', '0', '0', '0', '0'), ('2480', '28', '0', '0', '0', '0'), ('2480', '29', '0', '0', '0', '0'), ('2480', '30', '0', '0', '0', '0'), ('2480', '31', '0', '0', '0', '0'), ('2480', '32', '0', '0', '0', '0'), ('2480', '33', '0', '0', '0', '0'), ('2480', '34', '0', '0', '0', '0'), ('2480', '35', '0', '0', '0', '0'), ('2480', '36', '0', '0', '0', '0'), ('2480', '37', '0', '0', '0', '0'), ('2500', '-11', '0', '0', '0', '0'), ('2500', '-10', '0', '0', '0', '0'), ('2500', '-9', '0', '0', '0', '0'), ('2500', '-8', '0', '0', '0', '0'), ('2500', '-7', '0', '0', '0', '0'), ('2500', '-6', '0', '0', '0', '0'), ('2500', '-5', '0', '0', '0', '0'), ('2500', '-4', '0', '0', '0', '0'), ('2500', '-3', '0', '0', '0', '0'), ('2500', '-2', '0', '0', '0', '0'), ('2500', '-1', '0', '0', '0', '0'), ('2500', '0', '0', '0', '0', '0'), ('2500', '1', '0', '0', '0', '0'), ('2500', '2', '0', '0', '0', '0'), ('2500', '3', '0', '0', '0', '0'), ('2500', '4', '0', '0', '0', '0'), ('2500', '5', '0', '0', '0', '0'), ('2500', '6', '0', '0', '0', '0'), ('2500', '7', '0', '0', '0', '0'), ('2500', '8', '0', '0', '0', '0'), ('2500', '9', '0', '0', '0', '0'), ('2500', '10', '0', '0', '0', '0'), ('2500', '11', '0', '0', '0', '0'), ('2500', '12', '0', '0', '0', '0'), ('2500', '13', '0', '0', '0', '0'), ('2500', '14', '0', '0', '0', '0'), ('2500', '15', '0', '0', '0', '0'), ('2500', '16', '0', '0', '0', '0'), ('2500', '17', '0', '0', '0', '0'), ('2500', '18', '0', '0', '0', '0'), ('2500', '19', '0', '0', '0', '0'), ('2500', '20', '0', '0', '0', '0'), ('2500', '21', '0', '0', '0', '0'), ('2500', '22', '0', '0', '0', '0'), ('2500', '23', '0', '0', '0', '0'), ('2500', '24', '0', '0', '0', '0'), ('2500', '25', '0', '0', '0', '0'), ('2500', '26', '0', '0', '0', '0'), ('2500', '27', '0', '0', '0', '0'), ('2500', '28', '0', '0', '0', '0'), ('2500', '29', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2500', '30', '0', '0', '0', '0'), ('2500', '31', '0', '0', '0', '0'), ('2500', '32', '0', '0', '0', '0'), ('2500', '33', '0', '0', '0', '0'), ('2500', '34', '0', '0', '0', '0'), ('2500', '35', '0', '0', '0', '0'), ('2500', '36', '0', '0', '0', '0'), ('2500', '37', '0', '0', '0', '0'), ('2550', '-11', '0', '0', '0', '0'), ('2550', '-10', '0', '0', '0', '0'), ('2550', '-9', '0', '0', '0', '0'), ('2550', '-8', '0', '0', '0', '0'), ('2550', '-7', '0', '0', '0', '0'), ('2550', '-6', '0', '0', '0', '0'), ('2550', '-5', '0', '0', '0', '0'), ('2550', '-4', '0', '0', '0', '0'), ('2550', '-3', '0', '0', '0', '0'), ('2550', '-2', '0', '0', '0', '0'), ('2550', '-1', '0', '0', '0', '0'), ('2550', '0', '0', '0', '0', '0'), ('2550', '1', '0', '0', '0', '0'), ('2550', '2', '0', '0', '0', '0'), ('2550', '3', '0', '0', '0', '0'), ('2550', '4', '0', '0', '0', '0'), ('2550', '5', '0', '0', '0', '0'), ('2550', '6', '0', '0', '0', '0'), ('2550', '7', '0', '0', '0', '0'), ('2550', '8', '0', '0', '0', '0'), ('2550', '9', '0', '0', '0', '0'), ('2550', '10', '0', '0', '0', '0'), ('2550', '11', '0', '0', '0', '0'), ('2550', '12', '0', '0', '0', '0'), ('2550', '13', '0', '0', '0', '0'), ('2550', '14', '0', '0', '0', '0'), ('2550', '15', '0', '0', '0', '0'), ('2550', '16', '0', '0', '0', '0'), ('2550', '17', '0', '0', '0', '0'), ('2550', '18', '0', '0', '0', '0'), ('2550', '19', '0', '0', '0', '0'), ('2550', '20', '0', '0', '0', '0'), ('2550', '21', '0', '0', '0', '0'), ('2550', '22', '0', '0', '0', '0'), ('2550', '23', '0', '0', '0', '0'), ('2550', '24', '0', '0', '0', '0'), ('2550', '25', '0', '0', '0', '0'), ('2550', '26', '0', '0', '0', '0'), ('2550', '27', '0', '0', '0', '0'), ('2550', '28', '0', '0', '0', '0'), ('2550', '29', '0', '0', '0', '0'), ('2550', '30', '0', '0', '0', '0'), ('2550', '31', '0', '0', '0', '0'), ('2550', '32', '0', '0', '0', '0'), ('2550', '33', '0', '0', '0', '0'), ('2550', '34', '0', '0', '0', '0'), ('2550', '35', '0', '0', '0', '0'), ('2550', '36', '0', '0', '0', '0'), ('2550', '37', '0', '0', '0', '0'), ('2560', '-11', '0', '0', '0', '0'), ('2560', '-10', '0', '0', '0', '0'), ('2560', '-9', '0', '0', '0', '0'), ('2560', '-8', '0', '0', '0', '0'), ('2560', '-7', '0', '0', '0', '0'), ('2560', '-6', '0', '0', '0', '0'), ('2560', '-5', '0', '0', '0', '0'), ('2560', '-4', '0', '0', '0', '0'), ('2560', '-3', '0', '0', '0', '0'), ('2560', '-2', '0', '0', '0', '0'), ('2560', '-1', '0', '0', '0', '0'), ('2560', '0', '0', '0', '0', '0'), ('2560', '1', '0', '0', '0', '0'), ('2560', '2', '0', '0', '0', '0'), ('2560', '3', '0', '0', '0', '0'), ('2560', '4', '0', '0', '0', '0'), ('2560', '5', '0', '0', '0', '0'), ('2560', '6', '0', '0', '0', '0'), ('2560', '7', '0', '0', '0', '0'), ('2560', '8', '0', '0', '0', '0'), ('2560', '9', '0', '0', '0', '0'), ('2560', '10', '0', '0', '0', '0'), ('2560', '11', '0', '0', '0', '0'), ('2560', '12', '0', '0', '0', '0'), ('2560', '13', '0', '0', '0', '0'), ('2560', '14', '0', '0', '0', '0'), ('2560', '15', '0', '0', '0', '0'), ('2560', '16', '0', '0', '0', '0'), ('2560', '17', '0', '0', '0', '0'), ('2560', '18', '0', '0', '0', '0'), ('2560', '19', '0', '0', '0', '0'), ('2560', '20', '0', '0', '0', '0'), ('2560', '21', '0', '0', '0', '0'), ('2560', '22', '0', '0', '0', '0'), ('2560', '23', '0', '0', '0', '0'), ('2560', '24', '0', '0', '0', '0'), ('2560', '25', '0', '0', '0', '0'), ('2560', '26', '0', '0', '0', '0'), ('2560', '27', '0', '0', '0', '0'), ('2560', '28', '0', '0', '0', '0'), ('2560', '29', '0', '0', '0', '0'), ('2560', '30', '0', '0', '0', '0'), ('2560', '31', '0', '0', '0', '0'), ('2560', '32', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2560', '33', '0', '0', '0', '0'), ('2560', '34', '0', '0', '0', '0'), ('2560', '35', '0', '0', '0', '0'), ('2560', '36', '0', '0', '0', '0'), ('2560', '37', '0', '0', '0', '0'), ('2600', '-11', '0', '0', '0', '0'), ('2600', '-10', '0', '0', '0', '0'), ('2600', '-9', '0', '0', '0', '0'), ('2600', '-8', '0', '0', '0', '0'), ('2600', '-7', '0', '0', '0', '0'), ('2600', '-6', '0', '0', '0', '0'), ('2600', '-5', '0', '0', '0', '0'), ('2600', '-4', '0', '0', '0', '0'), ('2600', '-3', '0', '0', '0', '0'), ('2600', '-2', '0', '0', '0', '0'), ('2600', '-1', '0', '0', '0', '0'), ('2600', '0', '0', '0', '0', '0'), ('2600', '1', '0', '0', '0', '0'), ('2600', '2', '0', '0', '0', '0'), ('2600', '3', '0', '0', '0', '0'), ('2600', '4', '0', '0', '0', '0'), ('2600', '5', '0', '0', '0', '0'), ('2600', '6', '0', '0', '0', '0'), ('2600', '7', '0', '0', '0', '0'), ('2600', '8', '0', '0', '0', '0'), ('2600', '9', '0', '0', '0', '0'), ('2600', '10', '0', '0', '0', '0'), ('2600', '11', '0', '0', '0', '0'), ('2600', '12', '0', '0', '0', '0'), ('2600', '13', '0', '0', '0', '0'), ('2600', '14', '0', '0', '0', '0'), ('2600', '15', '0', '0', '0', '0'), ('2600', '16', '0', '0', '0', '0'), ('2600', '17', '0', '0', '0', '0'), ('2600', '18', '0', '0', '0', '0'), ('2600', '19', '0', '0', '0', '0'), ('2600', '20', '0', '0', '0', '0'), ('2600', '21', '0', '0', '0', '0'), ('2600', '22', '0', '0', '0', '0'), ('2600', '23', '0', '0', '0', '0'), ('2600', '24', '0', '0', '0', '0'), ('2600', '25', '0', '0', '0', '0'), ('2600', '26', '0', '0', '0', '0'), ('2600', '27', '0', '0', '0', '0'), ('2600', '28', '0', '0', '0', '0'), ('2600', '29', '0', '0', '0', '0'), ('2600', '30', '0', '0', '0', '0'), ('2600', '31', '0', '0', '0', '0'), ('2600', '32', '0', '0', '0', '0'), ('2600', '33', '0', '0', '0', '0'), ('2600', '34', '0', '0', '0', '0'), ('2600', '35', '0', '0', '0', '0'), ('2600', '36', '0', '0', '0', '0'), ('2600', '37', '0', '0', '0', '0'), ('2700', '-11', '0', '0', '0', '0'), ('2700', '-10', '0', '0', '0', '0'), ('2700', '-9', '0', '0', '0', '0'), ('2700', '-8', '0', '0', '0', '0'), ('2700', '-7', '0', '0', '0', '0'), ('2700', '-6', '0', '0', '0', '0'), ('2700', '-5', '0', '0', '0', '0'), ('2700', '-4', '0', '0', '0', '0'), ('2700', '-3', '0', '0', '0', '0'), ('2700', '-2', '0', '0', '0', '0'), ('2700', '-1', '0', '0', '0', '0'), ('2700', '0', '0', '0', '0', '0'), ('2700', '1', '0', '0', '0', '0'), ('2700', '2', '0', '0', '0', '0'), ('2700', '3', '0', '0', '0', '0'), ('2700', '4', '0', '0', '0', '0'), ('2700', '5', '0', '0', '0', '0'), ('2700', '6', '0', '0', '0', '0'), ('2700', '7', '0', '0', '0', '0'), ('2700', '8', '0', '0', '0', '0'), ('2700', '9', '0', '0', '0', '0'), ('2700', '10', '0', '0', '0', '0'), ('2700', '11', '0', '0', '0', '0'), ('2700', '12', '0', '0', '0', '0'), ('2700', '13', '0', '0', '0', '0'), ('2700', '14', '0', '0', '0', '0'), ('2700', '15', '0', '0', '0', '0'), ('2700', '16', '0', '0', '0', '0'), ('2700', '17', '0', '0', '0', '0'), ('2700', '18', '0', '0', '0', '0'), ('2700', '19', '0', '0', '0', '0'), ('2700', '20', '0', '0', '0', '0'), ('2700', '21', '0', '0', '0', '0'), ('2700', '22', '0', '0', '0', '0'), ('2700', '23', '0', '0', '0', '0'), ('2700', '24', '0', '0', '0', '0'), ('2700', '25', '0', '0', '0', '0'), ('2700', '26', '0', '0', '0', '0'), ('2700', '27', '0', '0', '0', '0'), ('2700', '28', '0', '0', '0', '0'), ('2700', '29', '0', '0', '0', '0'), ('2700', '30', '0', '0', '0', '0'), ('2700', '31', '0', '0', '0', '0'), ('2700', '32', '0', '0', '0', '0'), ('2700', '33', '0', '0', '0', '0'), ('2700', '34', '0', '0', '0', '0'), ('2700', '35', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2700', '36', '0', '0', '0', '0'), ('2700', '37', '0', '0', '0', '0'), ('2720', '-11', '0', '0', '0', '0'), ('2720', '-10', '0', '0', '0', '0'), ('2720', '-9', '0', '0', '0', '0'), ('2720', '-8', '0', '0', '0', '0'), ('2720', '-7', '0', '0', '0', '0'), ('2720', '-6', '0', '0', '0', '0'), ('2720', '-5', '0', '0', '0', '0'), ('2720', '-4', '0', '0', '0', '0'), ('2720', '-3', '0', '0', '0', '0'), ('2720', '-2', '0', '0', '0', '0'), ('2720', '-1', '0', '0', '0', '0'), ('2720', '0', '0', '0', '0', '0'), ('2720', '1', '0', '0', '0', '0'), ('2720', '2', '0', '0', '0', '0'), ('2720', '3', '0', '0', '0', '0'), ('2720', '4', '0', '0', '0', '0'), ('2720', '5', '0', '0', '0', '0'), ('2720', '6', '0', '0', '0', '0'), ('2720', '7', '0', '0', '0', '0'), ('2720', '8', '0', '0', '0', '0'), ('2720', '9', '0', '0', '0', '0'), ('2720', '10', '0', '0', '0', '0'), ('2720', '11', '0', '0', '0', '0'), ('2720', '12', '0', '0', '0', '0'), ('2720', '13', '0', '0', '0', '0'), ('2720', '14', '0', '0', '0', '0'), ('2720', '15', '0', '0', '0', '0'), ('2720', '16', '0', '0', '0', '0'), ('2720', '17', '0', '0', '0', '0'), ('2720', '18', '0', '0', '0', '0'), ('2720', '19', '0', '0', '0', '0'), ('2720', '20', '0', '0', '0', '0'), ('2720', '21', '0', '0', '0', '0'), ('2720', '22', '0', '0', '0', '0'), ('2720', '23', '0', '0', '0', '0'), ('2720', '24', '0', '0', '0', '0'), ('2720', '25', '0', '0', '0', '0'), ('2720', '26', '0', '0', '0', '0'), ('2720', '27', '0', '0', '0', '0'), ('2720', '28', '0', '0', '0', '0'), ('2720', '29', '0', '0', '0', '0'), ('2720', '30', '0', '0', '0', '0'), ('2720', '31', '0', '0', '0', '0'), ('2720', '32', '0', '0', '0', '0'), ('2720', '33', '0', '0', '0', '0'), ('2720', '34', '0', '0', '0', '0'), ('2720', '35', '0', '0', '0', '0'), ('2720', '36', '0', '0', '0', '0'), ('2720', '37', '0', '0', '0', '0'), ('2740', '-11', '0', '0', '0', '0'), ('2740', '-10', '0', '0', '0', '0'), ('2740', '-9', '0', '0', '0', '0'), ('2740', '-8', '0', '0', '0', '0'), ('2740', '-7', '0', '0', '0', '0'), ('2740', '-6', '0', '0', '0', '0'), ('2740', '-5', '0', '0', '0', '0'), ('2740', '-4', '0', '0', '0', '0'), ('2740', '-3', '0', '0', '0', '0'), ('2740', '-2', '0', '0', '0', '0'), ('2740', '-1', '0', '0', '0', '0'), ('2740', '0', '0', '0', '0', '0'), ('2740', '1', '0', '0', '0', '0'), ('2740', '2', '0', '0', '0', '0'), ('2740', '3', '0', '0', '0', '0'), ('2740', '4', '0', '0', '0', '0'), ('2740', '5', '0', '0', '0', '0'), ('2740', '6', '0', '0', '0', '0'), ('2740', '7', '0', '0', '0', '0'), ('2740', '8', '0', '0', '0', '0'), ('2740', '9', '0', '0', '0', '0'), ('2740', '10', '0', '0', '0', '0'), ('2740', '11', '0', '0', '0', '0'), ('2740', '12', '0', '0', '0', '0'), ('2740', '13', '0', '0', '0', '0'), ('2740', '14', '0', '0', '0', '0'), ('2740', '15', '0', '0', '0', '0'), ('2740', '16', '0', '0', '0', '0'), ('2740', '17', '0', '0', '0', '0'), ('2740', '18', '0', '0', '0', '0'), ('2740', '19', '0', '0', '0', '0'), ('2740', '20', '0', '0', '0', '0'), ('2740', '21', '0', '0', '0', '0'), ('2740', '22', '0', '0', '0', '0'), ('2740', '23', '0', '0', '0', '0'), ('2740', '24', '0', '0', '0', '0'), ('2740', '25', '0', '0', '0', '0'), ('2740', '26', '0', '0', '0', '0'), ('2740', '27', '0', '0', '0', '0'), ('2740', '28', '0', '0', '0', '0'), ('2740', '29', '0', '0', '0', '0'), ('2740', '30', '0', '0', '0', '0'), ('2740', '31', '0', '0', '0', '0'), ('2740', '32', '0', '0', '0', '0'), ('2740', '33', '0', '0', '0', '0'), ('2740', '34', '0', '0', '0', '0'), ('2740', '35', '0', '0', '0', '0'), ('2740', '36', '0', '0', '0', '0'), ('2740', '37', '0', '0', '0', '0'), ('2760', '-11', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2760', '-10', '0', '0', '0', '0'), ('2760', '-9', '0', '0', '0', '0'), ('2760', '-8', '0', '0', '0', '0'), ('2760', '-7', '0', '0', '0', '0'), ('2760', '-6', '0', '0', '0', '0'), ('2760', '-5', '0', '0', '0', '0'), ('2760', '-4', '0', '0', '0', '0'), ('2760', '-3', '0', '0', '0', '0'), ('2760', '-2', '0', '0', '0', '0'), ('2760', '-1', '0', '0', '0', '0'), ('2760', '0', '0', '0', '0', '0'), ('2760', '1', '0', '0', '0', '0'), ('2760', '2', '0', '0', '0', '0'), ('2760', '3', '0', '0', '0', '0'), ('2760', '4', '0', '0', '0', '0'), ('2760', '5', '0', '0', '0', '0'), ('2760', '6', '0', '0', '0', '0'), ('2760', '7', '0', '0', '0', '0'), ('2760', '8', '0', '0', '0', '0'), ('2760', '9', '0', '0', '0', '0'), ('2760', '10', '0', '0', '0', '0'), ('2760', '11', '0', '0', '0', '0'), ('2760', '12', '0', '0', '0', '0'), ('2760', '13', '0', '0', '0', '0'), ('2760', '14', '0', '0', '0', '0'), ('2760', '15', '0', '0', '0', '0'), ('2760', '16', '0', '0', '0', '0'), ('2760', '17', '0', '0', '0', '0'), ('2760', '18', '0', '0', '0', '0'), ('2760', '19', '0', '0', '0', '0'), ('2760', '20', '0', '0', '0', '0'), ('2760', '21', '0', '0', '0', '0'), ('2760', '22', '0', '0', '0', '0'), ('2760', '23', '0', '0', '0', '0'), ('2760', '24', '0', '0', '0', '0'), ('2760', '25', '0', '0', '0', '0'), ('2760', '26', '0', '0', '0', '0'), ('2760', '27', '0', '0', '0', '0'), ('2760', '28', '0', '0', '0', '0'), ('2760', '29', '0', '0', '0', '0'), ('2760', '30', '0', '0', '0', '0'), ('2760', '31', '0', '0', '0', '0'), ('2760', '32', '0', '0', '0', '0'), ('2760', '33', '0', '0', '0', '0'), ('2760', '34', '0', '0', '0', '0'), ('2760', '35', '0', '0', '0', '0'), ('2760', '36', '0', '0', '0', '0'), ('2760', '37', '0', '0', '0', '0'), ('2800', '-11', '0', '0', '0', '0'), ('2800', '-10', '0', '0', '0', '0'), ('2800', '-9', '0', '0', '0', '0'), ('2800', '-8', '0', '0', '0', '0'), ('2800', '-7', '0', '0', '0', '0'), ('2800', '-6', '0', '0', '0', '0'), ('2800', '-5', '0', '0', '0', '0'), ('2800', '-4', '0', '0', '0', '0'), ('2800', '-3', '0', '0', '0', '0'), ('2800', '-2', '0', '0', '0', '0'), ('2800', '-1', '0', '0', '0', '0'), ('2800', '0', '0', '0', '0', '0'), ('2800', '1', '0', '0', '0', '0'), ('2800', '2', '0', '0', '0', '0'), ('2800', '3', '0', '0', '0', '0'), ('2800', '4', '0', '0', '0', '0'), ('2800', '5', '0', '0', '0', '0'), ('2800', '6', '0', '0', '0', '0'), ('2800', '7', '0', '0', '0', '0'), ('2800', '8', '0', '0', '0', '0'), ('2800', '9', '0', '0', '0', '0'), ('2800', '10', '0', '0', '0', '0'), ('2800', '11', '0', '0', '0', '0'), ('2800', '12', '0', '0', '0', '0'), ('2800', '13', '0', '0', '0', '0'), ('2800', '14', '0', '0', '0', '0'), ('2800', '15', '0', '0', '0', '0'), ('2800', '16', '0', '0', '0', '0'), ('2800', '17', '0', '0', '0', '0'), ('2800', '18', '0', '0', '0', '0'), ('2800', '19', '0', '0', '0', '0'), ('2800', '20', '0', '0', '0', '0'), ('2800', '21', '0', '0', '0', '0'), ('2800', '22', '0', '0', '0', '0'), ('2800', '23', '0', '0', '0', '0'), ('2800', '24', '0', '0', '0', '0'), ('2800', '25', '0', '0', '0', '0'), ('2800', '26', '0', '0', '0', '0'), ('2800', '27', '0', '0', '0', '0'), ('2800', '28', '0', '0', '0', '0'), ('2800', '29', '0', '0', '0', '0'), ('2800', '30', '0', '0', '0', '0'), ('2800', '31', '0', '0', '0', '0'), ('2800', '32', '0', '0', '0', '0'), ('2800', '33', '0', '0', '0', '0'), ('2800', '34', '0', '0', '0', '0'), ('2800', '35', '0', '0', '0', '0'), ('2800', '36', '0', '0', '0', '0'), ('2800', '37', '0', '0', '0', '0'), ('2900', '-11', '0', '0', '0', '0'), ('2900', '-10', '0', '0', '0', '0'), ('2900', '-9', '0', '0', '0', '0'), ('2900', '-8', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('2900', '-7', '0', '0', '0', '0'), ('2900', '-6', '0', '0', '0', '0'), ('2900', '-5', '0', '0', '0', '0'), ('2900', '-4', '0', '0', '0', '0'), ('2900', '-3', '0', '0', '0', '0'), ('2900', '-2', '0', '0', '0', '0'), ('2900', '-1', '0', '0', '0', '0'), ('2900', '0', '0', '0', '0', '0'), ('2900', '1', '0', '0', '0', '0'), ('2900', '2', '0', '0', '0', '0'), ('2900', '3', '0', '0', '0', '0'), ('2900', '4', '0', '0', '0', '0'), ('2900', '5', '0', '0', '0', '0'), ('2900', '6', '0', '0', '0', '0'), ('2900', '7', '0', '0', '0', '0'), ('2900', '8', '0', '0', '0', '0'), ('2900', '9', '0', '0', '0', '0'), ('2900', '10', '0', '0', '0', '0'), ('2900', '11', '0', '0', '0', '0'), ('2900', '12', '0', '0', '0', '0'), ('2900', '13', '0', '0', '0', '0'), ('2900', '14', '0', '0', '0', '0'), ('2900', '15', '0', '0', '0', '0'), ('2900', '16', '0', '0', '0', '0'), ('2900', '17', '0', '0', '0', '0'), ('2900', '18', '0', '0', '0', '0'), ('2900', '19', '0', '0', '0', '0'), ('2900', '20', '0', '0', '0', '0'), ('2900', '21', '0', '0', '0', '0'), ('2900', '22', '0', '0', '0', '0'), ('2900', '23', '0', '0', '0', '0'), ('2900', '24', '0', '0', '0', '0'), ('2900', '25', '0', '0', '0', '0'), ('2900', '26', '0', '0', '0', '0'), ('2900', '27', '0', '0', '0', '0'), ('2900', '28', '0', '0', '0', '0'), ('2900', '29', '0', '0', '0', '0'), ('2900', '30', '0', '0', '0', '0'), ('2900', '31', '0', '0', '0', '0'), ('2900', '32', '0', '0', '0', '0'), ('2900', '33', '0', '0', '0', '0'), ('2900', '34', '0', '0', '0', '0'), ('2900', '35', '0', '0', '0', '0'), ('2900', '36', '0', '0', '0', '0'), ('2900', '37', '0', '0', '0', '0'), ('3100', '-11', '0', '0', '0', '0'), ('3100', '-10', '0', '0', '0', '0'), ('3100', '-9', '0', '0', '0', '0'), ('3100', '-8', '0', '0', '0', '0'), ('3100', '-7', '0', '0', '0', '0'), ('3100', '-6', '0', '0', '0', '0'), ('3100', '-5', '0', '0', '0', '0'), ('3100', '-4', '0', '0', '0', '0'), ('3100', '-3', '0', '0', '0', '0'), ('3100', '-2', '0', '0', '0', '0'), ('3100', '-1', '0', '0', '0', '0'), ('3100', '0', '0', '0', '0', '0'), ('3100', '1', '0', '0', '0', '0'), ('3100', '2', '0', '0', '0', '0'), ('3100', '3', '0', '0', '0', '0'), ('3100', '4', '0', '0', '0', '0'), ('3100', '5', '0', '0', '0', '0'), ('3100', '6', '0', '0', '0', '0'), ('3100', '7', '0', '0', '0', '0'), ('3100', '8', '0', '0', '0', '0'), ('3100', '9', '0', '0', '0', '0'), ('3100', '10', '0', '0', '0', '0'), ('3100', '11', '0', '0', '0', '0'), ('3100', '12', '0', '0', '0', '0'), ('3100', '13', '0', '0', '0', '0'), ('3100', '14', '0', '0', '0', '0'), ('3100', '15', '0', '0', '0', '0'), ('3100', '16', '0', '0', '0', '0'), ('3100', '17', '0', '0', '0', '0'), ('3100', '18', '0', '0', '0', '0'), ('3100', '19', '0', '0', '0', '0'), ('3100', '20', '0', '0', '0', '0'), ('3100', '21', '0', '0', '0', '0'), ('3100', '22', '0', '0', '0', '0'), ('3100', '23', '0', '0', '0', '0'), ('3100', '24', '0', '0', '0', '0'), ('3100', '25', '0', '0', '0', '0'), ('3100', '26', '0', '0', '0', '0'), ('3100', '27', '0', '0', '0', '0'), ('3100', '28', '0', '0', '0', '0'), ('3100', '29', '0', '0', '0', '0'), ('3100', '30', '0', '0', '0', '0'), ('3100', '31', '0', '0', '0', '0'), ('3100', '32', '0', '0', '0', '0'), ('3100', '33', '0', '0', '0', '0'), ('3100', '34', '0', '0', '0', '0'), ('3100', '35', '0', '0', '0', '0'), ('3100', '36', '0', '0', '0', '0'), ('3100', '37', '0', '0', '0', '0'), ('3200', '-11', '0', '0', '0', '0'), ('3200', '-10', '0', '0', '0', '0'), ('3200', '-9', '0', '0', '0', '0'), ('3200', '-8', '0', '0', '0', '0'), ('3200', '-7', '0', '0', '0', '0'), ('3200', '-6', '0', '0', '0', '0'), ('3200', '-5', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('3200', '-4', '0', '0', '0', '0'), ('3200', '-3', '0', '0', '0', '0'), ('3200', '-2', '0', '0', '0', '0'), ('3200', '-1', '0', '0', '0', '0'), ('3200', '0', '0', '0', '0', '0'), ('3200', '1', '0', '0', '0', '0'), ('3200', '2', '0', '0', '0', '0'), ('3200', '3', '0', '0', '0', '0'), ('3200', '4', '0', '0', '0', '0'), ('3200', '5', '0', '0', '0', '0'), ('3200', '6', '0', '0', '0', '0'), ('3200', '7', '0', '0', '0', '0'), ('3200', '8', '0', '0', '0', '0'), ('3200', '9', '0', '0', '0', '0'), ('3200', '10', '0', '0', '0', '0'), ('3200', '11', '0', '0', '0', '0'), ('3200', '12', '0', '0', '0', '0'), ('3200', '13', '0', '0', '0', '0'), ('3200', '14', '0', '0', '0', '0'), ('3200', '15', '0', '0', '0', '0'), ('3200', '16', '0', '0', '0', '0'), ('3200', '17', '0', '0', '0', '0'), ('3200', '18', '0', '0', '0', '0'), ('3200', '19', '0', '0', '0', '0'), ('3200', '20', '0', '0', '0', '0'), ('3200', '21', '0', '0', '0', '0'), ('3200', '22', '0', '0', '0', '0'), ('3200', '23', '0', '0', '0', '0'), ('3200', '24', '0', '0', '0', '0'), ('3200', '25', '0', '0', '0', '0'), ('3200', '26', '0', '0', '0', '0'), ('3200', '27', '0', '0', '0', '0'), ('3200', '28', '0', '0', '0', '0'), ('3200', '29', '0', '0', '0', '0'), ('3200', '30', '0', '0', '0', '0'), ('3200', '31', '0', '0', '0', '0'), ('3200', '32', '0', '0', '0', '0'), ('3200', '33', '0', '0', '0', '0'), ('3200', '34', '0', '0', '0', '0'), ('3200', '35', '0', '0', '0', '0'), ('3200', '36', '0', '0', '0', '0'), ('3200', '37', '0', '0', '0', '0'), ('3300', '-11', '0', '0', '0', '0'), ('3300', '-10', '0', '0', '0', '0'), ('3300', '-9', '0', '0', '0', '0'), ('3300', '-8', '0', '0', '0', '0'), ('3300', '-7', '0', '0', '0', '0'), ('3300', '-6', '0', '0', '0', '0'), ('3300', '-5', '0', '0', '0', '0'), ('3300', '-4', '0', '0', '0', '0'), ('3300', '-3', '0', '0', '0', '0'), ('3300', '-2', '0', '0', '0', '0'), ('3300', '-1', '0', '0', '0', '0'), ('3300', '0', '0', '0', '0', '0'), ('3300', '1', '0', '0', '0', '0'), ('3300', '2', '0', '0', '0', '0'), ('3300', '3', '0', '0', '0', '0'), ('3300', '4', '0', '0', '0', '0'), ('3300', '5', '0', '0', '0', '0'), ('3300', '6', '0', '0', '0', '0'), ('3300', '7', '0', '0', '0', '0'), ('3300', '8', '0', '0', '0', '0'), ('3300', '9', '0', '0', '0', '0'), ('3300', '10', '0', '0', '0', '0'), ('3300', '11', '0', '0', '0', '0'), ('3300', '12', '0', '0', '0', '0'), ('3300', '13', '0', '0', '0', '0'), ('3300', '14', '0', '0', '0', '0'), ('3300', '15', '0', '0', '0', '0'), ('3300', '16', '0', '0', '0', '0'), ('3300', '17', '0', '0', '0', '0'), ('3300', '18', '0', '0', '0', '0'), ('3300', '19', '0', '0', '0', '0'), ('3300', '20', '0', '0', '0', '0'), ('3300', '21', '0', '0', '0', '0'), ('3300', '22', '0', '0', '0', '0'), ('3300', '23', '0', '0', '0', '0'), ('3300', '24', '0', '0', '0', '0'), ('3300', '25', '0', '0', '0', '0'), ('3300', '26', '0', '0', '0', '0'), ('3300', '27', '0', '0', '0', '0'), ('3300', '28', '0', '0', '0', '0'), ('3300', '29', '0', '0', '0', '0'), ('3300', '30', '0', '0', '0', '0'), ('3300', '31', '0', '0', '0', '0'), ('3300', '32', '0', '0', '0', '0'), ('3300', '33', '0', '0', '0', '0'), ('3300', '34', '0', '0', '0', '0'), ('3300', '35', '0', '0', '0', '0'), ('3300', '36', '0', '0', '0', '0'), ('3300', '37', '0', '0', '0', '0'), ('3400', '-11', '0', '0', '0', '0'), ('3400', '-10', '0', '0', '0', '0'), ('3400', '-9', '0', '0', '0', '0'), ('3400', '-8', '0', '0', '0', '0'), ('3400', '-7', '0', '0', '0', '0'), ('3400', '-6', '0', '0', '0', '0'), ('3400', '-5', '0', '0', '0', '0'), ('3400', '-4', '0', '0', '0', '0'), ('3400', '-3', '0', '0', '0', '0'), ('3400', '-2', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('3400', '-1', '0', '0', '0', '0'), ('3400', '0', '0', '0', '0', '0'), ('3400', '1', '0', '0', '0', '0'), ('3400', '2', '0', '0', '0', '0'), ('3400', '3', '0', '0', '0', '0'), ('3400', '4', '0', '0', '0', '0'), ('3400', '5', '0', '0', '0', '0'), ('3400', '6', '0', '0', '0', '0'), ('3400', '7', '0', '0', '0', '0'), ('3400', '8', '0', '0', '0', '0'), ('3400', '9', '0', '0', '0', '0'), ('3400', '10', '0', '0', '0', '0'), ('3400', '11', '0', '0', '0', '0'), ('3400', '12', '0', '0', '0', '0'), ('3400', '13', '0', '0', '0', '0'), ('3400', '14', '0', '0', '0', '0'), ('3400', '15', '0', '0', '0', '0'), ('3400', '16', '0', '0', '0', '0'), ('3400', '17', '0', '0', '0', '0'), ('3400', '18', '0', '0', '0', '0'), ('3400', '19', '0', '0', '0', '0'), ('3400', '20', '0', '0', '0', '0'), ('3400', '21', '0', '0', '0', '0'), ('3400', '22', '0', '0', '0', '0'), ('3400', '23', '0', '0', '0', '0'), ('3400', '24', '0', '0', '0', '0'), ('3400', '25', '0', '0', '0', '0'), ('3400', '26', '0', '0', '0', '0'), ('3400', '27', '0', '0', '0', '0'), ('3400', '28', '0', '0', '0', '0'), ('3400', '29', '0', '0', '0', '0'), ('3400', '30', '0', '0', '0', '0'), ('3400', '31', '0', '0', '0', '0'), ('3400', '32', '0', '0', '0', '0'), ('3400', '33', '0', '0', '0', '0'), ('3400', '34', '0', '0', '0', '0'), ('3400', '35', '0', '0', '0', '0'), ('3400', '36', '0', '0', '0', '0'), ('3400', '37', '0', '0', '0', '0'), ('3500', '-11', '0', '0', '0', '0'), ('3500', '-10', '0', '0', '0', '0'), ('3500', '-9', '0', '0', '0', '0'), ('3500', '-8', '0', '0', '0', '0'), ('3500', '-7', '0', '0', '0', '0'), ('3500', '-6', '0', '0', '0', '0'), ('3500', '-5', '0', '0', '0', '0'), ('3500', '-4', '0', '0', '0', '0'), ('3500', '-3', '0', '0', '0', '0'), ('3500', '-2', '0', '0', '0', '0'), ('3500', '-1', '0', '0', '0', '0'), ('3500', '0', '0', '0', '0', '0'), ('3500', '1', '0', '0', '0', '0'), ('3500', '2', '0', '0', '0', '0'), ('3500', '3', '0', '0', '0', '0'), ('3500', '4', '0', '0', '0', '0'), ('3500', '5', '0', '0', '0', '0'), ('3500', '6', '0', '0', '0', '0'), ('3500', '7', '0', '0', '0', '0'), ('3500', '8', '0', '0', '0', '0'), ('3500', '9', '0', '0', '0', '0'), ('3500', '10', '0', '0', '0', '0'), ('3500', '11', '0', '0', '0', '0'), ('3500', '12', '0', '0', '0', '0'), ('3500', '13', '0', '0', '0', '0'), ('3500', '14', '0', '0', '0', '0'), ('3500', '15', '0', '0', '0', '0'), ('3500', '16', '0', '0', '0', '0'), ('3500', '17', '0', '0', '0', '0'), ('3500', '18', '0', '0', '0', '0'), ('3500', '19', '0', '0', '0', '0'), ('3500', '20', '0', '0', '0', '0'), ('3500', '21', '0', '0', '0', '0'), ('3500', '22', '0', '0', '0', '0'), ('3500', '23', '0', '0', '0', '0'), ('3500', '24', '0', '0', '0', '0'), ('3500', '25', '0', '0', '0', '0'), ('3500', '26', '0', '0', '0', '0'), ('3500', '27', '0', '0', '0', '0'), ('3500', '28', '0', '0', '0', '0'), ('3500', '29', '0', '0', '0', '0'), ('3500', '30', '0', '0', '0', '0'), ('3500', '31', '0', '0', '0', '0'), ('3500', '32', '0', '0', '0', '0'), ('3500', '33', '0', '0', '0', '0'), ('3500', '34', '0', '0', '0', '0'), ('3500', '35', '0', '0', '0', '0'), ('3500', '36', '0', '0', '0', '0'), ('3500', '37', '0', '0', '0', '0'), ('4100', '-11', '0', '0', '0', '0'), ('4100', '-10', '0', '0', '0', '0'), ('4100', '-9', '0', '0', '0', '0'), ('4100', '-8', '0', '0', '0', '0'), ('4100', '-7', '0', '0', '0', '0'), ('4100', '-6', '0', '0', '0', '0'), ('4100', '-5', '0', '0', '0', '0'), ('4100', '-4', '0', '0', '0', '0'), ('4100', '-3', '0', '0', '0', '0'), ('4100', '-2', '0', '0', '0', '0'), ('4100', '-1', '0', '0', '0', '0'), ('4100', '0', '0', '0', '0', '0'), ('4100', '1', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('4100', '2', '0', '-46.4', '0', '0'), ('4100', '3', '0', '15.95', '0', '0'), ('4100', '4', '0', '0', '0', '0'), ('4100', '5', '0', '0', '0', '0'), ('4100', '6', '0', '0', '0', '0'), ('4100', '7', '0', '0', '0', '0'), ('4100', '8', '0', '0', '0', '0'), ('4100', '9', '0', '0', '0', '0'), ('4100', '10', '0', '0', '0', '0'), ('4100', '11', '0', '0', '0', '0'), ('4100', '12', '0', '0', '0', '0'), ('4100', '13', '0', '0', '0', '0'), ('4100', '14', '0', '0', '0', '0'), ('4100', '15', '0', '0', '0', '0'), ('4100', '16', '0', '0', '0', '0'), ('4100', '17', '0', '0', '0', '0'), ('4100', '18', '0', '0', '0', '0'), ('4100', '19', '0', '0', '0', '0'), ('4100', '20', '0', '0', '0', '0'), ('4100', '21', '0', '0', '0', '0'), ('4100', '22', '0', '0', '0', '0'), ('4100', '23', '0', '0', '0', '0'), ('4100', '24', '0', '0', '0', '0'), ('4100', '25', '0', '0', '0', '0'), ('4100', '26', '0', '0', '0', '0'), ('4100', '27', '0', '0', '0', '0'), ('4100', '28', '0', '0', '0', '0'), ('4100', '29', '0', '0', '0', '0'), ('4100', '30', '0', '0', '0', '0'), ('4100', '31', '0', '0', '0', '0'), ('4100', '32', '0', '0', '0', '0'), ('4100', '33', '0', '0', '0', '0'), ('4100', '34', '0', '0', '0', '0'), ('4100', '35', '0', '0', '0', '0'), ('4100', '36', '0', '0', '0', '0'), ('4100', '37', '0', '0', '0', '0'), ('4200', '-11', '0', '0', '0', '0'), ('4200', '-10', '0', '0', '0', '0'), ('4200', '-9', '0', '0', '0', '0'), ('4200', '-8', '0', '0', '0', '0'), ('4200', '-7', '0', '0', '0', '0'), ('4200', '-6', '0', '0', '0', '0'), ('4200', '-5', '0', '0', '0', '0'), ('4200', '-4', '0', '0', '0', '0'), ('4200', '-3', '0', '0', '0', '0'), ('4200', '-2', '0', '0', '0', '0'), ('4200', '-1', '0', '0', '0', '0'), ('4200', '0', '0', '0', '0', '0'), ('4200', '1', '0', '0', '0', '0'), ('4200', '2', '0', '0', '0', '0'), ('4200', '3', '0', '0', '0', '0'), ('4200', '4', '0', '0', '0', '0'), ('4200', '5', '0', '0', '0', '0'), ('4200', '6', '0', '0', '0', '0'), ('4200', '7', '0', '0', '0', '0'), ('4200', '8', '0', '0', '0', '0'), ('4200', '9', '0', '0', '0', '0'), ('4200', '10', '0', '0', '0', '0'), ('4200', '11', '0', '0', '0', '0'), ('4200', '12', '0', '0', '0', '0'), ('4200', '13', '0', '0', '0', '0'), ('4200', '14', '0', '0', '0', '0'), ('4200', '15', '0', '0', '0', '0'), ('4200', '16', '0', '0', '0', '0'), ('4200', '17', '0', '0', '0', '0'), ('4200', '18', '0', '0', '0', '0'), ('4200', '19', '0', '0', '0', '0'), ('4200', '20', '0', '0', '0', '0'), ('4200', '21', '0', '0', '0', '0'), ('4200', '22', '0', '0', '0', '0'), ('4200', '23', '0', '0', '0', '0'), ('4200', '24', '0', '0', '0', '0'), ('4200', '25', '0', '0', '0', '0'), ('4200', '26', '0', '0', '0', '0'), ('4200', '27', '0', '0', '0', '0'), ('4200', '28', '0', '0', '0', '0'), ('4200', '29', '0', '0', '0', '0'), ('4200', '30', '0', '0', '0', '0'), ('4200', '31', '0', '0', '0', '0'), ('4200', '32', '0', '0', '0', '0'), ('4200', '33', '0', '0', '0', '0'), ('4200', '34', '0', '0', '0', '0'), ('4200', '35', '0', '0', '0', '0'), ('4200', '36', '0', '0', '0', '0'), ('4200', '37', '0', '0', '0', '0'), ('4500', '-11', '0', '0', '0', '0'), ('4500', '-10', '0', '0', '0', '0'), ('4500', '-9', '0', '0', '0', '0'), ('4500', '-8', '0', '0', '0', '0'), ('4500', '-7', '0', '0', '0', '0'), ('4500', '-6', '0', '0', '0', '0'), ('4500', '-5', '0', '0', '0', '0'), ('4500', '-4', '0', '0', '0', '0'), ('4500', '-3', '0', '0', '0', '0'), ('4500', '-2', '0', '0', '0', '0'), ('4500', '-1', '0', '0', '0', '0'), ('4500', '0', '0', '0', '0', '0'), ('4500', '1', '0', '0', '0', '0'), ('4500', '2', '0', '0', '0', '0'), ('4500', '3', '0', '0', '0', '0'), ('4500', '4', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('4500', '5', '0', '0', '0', '0'), ('4500', '6', '0', '0', '0', '0'), ('4500', '7', '0', '0', '0', '0'), ('4500', '8', '0', '0', '0', '0'), ('4500', '9', '0', '0', '0', '0'), ('4500', '10', '0', '0', '0', '0'), ('4500', '11', '0', '0', '0', '0'), ('4500', '12', '0', '0', '0', '0'), ('4500', '13', '0', '0', '0', '0'), ('4500', '14', '0', '0', '0', '0'), ('4500', '15', '0', '0', '0', '0'), ('4500', '16', '0', '0', '0', '0'), ('4500', '17', '0', '0', '0', '0'), ('4500', '18', '0', '0', '0', '0'), ('4500', '19', '0', '0', '0', '0'), ('4500', '20', '0', '0', '0', '0'), ('4500', '21', '0', '0', '0', '0'), ('4500', '22', '0', '0', '0', '0'), ('4500', '23', '0', '0', '0', '0'), ('4500', '24', '0', '0', '0', '0'), ('4500', '25', '0', '0', '0', '0'), ('4500', '26', '0', '0', '0', '0'), ('4500', '27', '0', '0', '0', '0'), ('4500', '28', '0', '0', '0', '0'), ('4500', '29', '0', '0', '0', '0'), ('4500', '30', '0', '0', '0', '0'), ('4500', '31', '0', '0', '0', '0'), ('4500', '32', '0', '0', '0', '0'), ('4500', '33', '0', '0', '0', '0'), ('4500', '34', '0', '0', '0', '0'), ('4500', '35', '0', '0', '0', '0'), ('4500', '36', '0', '0', '0', '0'), ('4500', '37', '0', '0', '0', '0'), ('4600', '-11', '0', '0', '0', '0'), ('4600', '-10', '0', '0', '0', '0'), ('4600', '-9', '0', '0', '0', '0'), ('4600', '-8', '0', '0', '0', '0'), ('4600', '-7', '0', '0', '0', '0'), ('4600', '-6', '0', '0', '0', '0'), ('4600', '-5', '0', '0', '0', '0'), ('4600', '-4', '0', '0', '0', '0'), ('4600', '-3', '0', '0', '0', '0'), ('4600', '-2', '0', '0', '0', '0'), ('4600', '-1', '0', '0', '0', '0'), ('4600', '0', '0', '0', '0', '0'), ('4600', '1', '0', '0', '0', '0'), ('4600', '2', '0', '0', '0', '0'), ('4600', '3', '0', '0', '0', '0'), ('4600', '4', '0', '0', '0', '0'), ('4600', '5', '0', '0', '0', '0'), ('4600', '6', '0', '0', '0', '0'), ('4600', '7', '0', '0', '0', '0'), ('4600', '8', '0', '0', '0', '0'), ('4600', '9', '0', '0', '0', '0'), ('4600', '10', '0', '0', '0', '0'), ('4600', '11', '0', '0', '0', '0'), ('4600', '12', '0', '0', '0', '0'), ('4600', '13', '0', '0', '0', '0'), ('4600', '14', '0', '0', '0', '0'), ('4600', '15', '0', '0', '0', '0'), ('4600', '16', '0', '0', '0', '0'), ('4600', '17', '0', '0', '0', '0'), ('4600', '18', '0', '0', '0', '0'), ('4600', '19', '0', '0', '0', '0'), ('4600', '20', '0', '0', '0', '0'), ('4600', '21', '0', '0', '0', '0'), ('4600', '22', '0', '0', '0', '0'), ('4600', '23', '0', '0', '0', '0'), ('4600', '24', '0', '0', '0', '0'), ('4600', '25', '0', '0', '0', '0'), ('4600', '26', '0', '0', '0', '0'), ('4600', '27', '0', '0', '0', '0'), ('4600', '28', '0', '0', '0', '0'), ('4600', '29', '0', '0', '0', '0'), ('4600', '30', '0', '0', '0', '0'), ('4600', '31', '0', '0', '0', '0'), ('4600', '32', '0', '0', '0', '0'), ('4600', '33', '0', '0', '0', '0'), ('4600', '34', '0', '0', '0', '0'), ('4600', '35', '0', '0', '0', '0'), ('4600', '36', '0', '0', '0', '0'), ('4600', '37', '0', '0', '0', '0'), ('4700', '-11', '0', '0', '0', '0'), ('4700', '-10', '0', '0', '0', '0'), ('4700', '-9', '0', '0', '0', '0'), ('4700', '-8', '0', '0', '0', '0'), ('4700', '-7', '0', '0', '0', '0'), ('4700', '-6', '0', '0', '0', '0'), ('4700', '-5', '0', '0', '0', '0'), ('4700', '-4', '0', '0', '0', '0'), ('4700', '-3', '0', '0', '0', '0'), ('4700', '-2', '0', '0', '0', '0'), ('4700', '-1', '0', '0', '0', '0'), ('4700', '0', '0', '0', '0', '0'), ('4700', '1', '0', '0', '0', '0'), ('4700', '2', '0', '0', '0', '0'), ('4700', '3', '0', '0', '0', '0'), ('4700', '4', '0', '0', '0', '0'), ('4700', '5', '0', '0', '0', '0'), ('4700', '6', '0', '0', '0', '0'), ('4700', '7', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('4700', '8', '0', '0', '0', '0'), ('4700', '9', '0', '0', '0', '0'), ('4700', '10', '0', '0', '0', '0'), ('4700', '11', '0', '0', '0', '0'), ('4700', '12', '0', '0', '0', '0'), ('4700', '13', '0', '0', '0', '0'), ('4700', '14', '0', '0', '0', '0'), ('4700', '15', '0', '0', '0', '0'), ('4700', '16', '0', '0', '0', '0'), ('4700', '17', '0', '0', '0', '0'), ('4700', '18', '0', '0', '0', '0'), ('4700', '19', '0', '0', '0', '0'), ('4700', '20', '0', '0', '0', '0'), ('4700', '21', '0', '0', '0', '0'), ('4700', '22', '0', '0', '0', '0'), ('4700', '23', '0', '0', '0', '0'), ('4700', '24', '0', '0', '0', '0'), ('4700', '25', '0', '0', '0', '0'), ('4700', '26', '0', '0', '0', '0'), ('4700', '27', '0', '0', '0', '0'), ('4700', '28', '0', '0', '0', '0'), ('4700', '29', '0', '0', '0', '0'), ('4700', '30', '0', '0', '0', '0'), ('4700', '31', '0', '0', '0', '0'), ('4700', '32', '0', '0', '0', '0'), ('4700', '33', '0', '0', '0', '0'), ('4700', '34', '0', '0', '0', '0'), ('4700', '35', '0', '0', '0', '0'), ('4700', '36', '0', '0', '0', '0'), ('4700', '37', '0', '0', '0', '0'), ('4800', '-11', '0', '0', '0', '0'), ('4800', '-10', '0', '0', '0', '0'), ('4800', '-9', '0', '0', '0', '0'), ('4800', '-8', '0', '0', '0', '0'), ('4800', '-7', '0', '0', '0', '0'), ('4800', '-6', '0', '0', '0', '0'), ('4800', '-5', '0', '0', '0', '0'), ('4800', '-4', '0', '0', '0', '0'), ('4800', '-3', '0', '0', '0', '0'), ('4800', '-2', '0', '0', '0', '0'), ('4800', '-1', '0', '0', '0', '0'), ('4800', '0', '0', '0', '0', '0'), ('4800', '1', '0', '0', '0', '0'), ('4800', '2', '0', '0', '0', '0'), ('4800', '3', '0', '0', '0', '0'), ('4800', '4', '0', '0', '0', '0'), ('4800', '5', '0', '0', '0', '0'), ('4800', '6', '0', '0', '0', '0'), ('4800', '7', '0', '0', '0', '0'), ('4800', '8', '0', '0', '0', '0'), ('4800', '9', '0', '0', '0', '0'), ('4800', '10', '0', '0', '0', '0'), ('4800', '11', '0', '0', '0', '0'), ('4800', '12', '0', '0', '0', '0'), ('4800', '13', '0', '0', '0', '0'), ('4800', '14', '0', '0', '0', '0'), ('4800', '15', '0', '0', '0', '0'), ('4800', '16', '0', '0', '0', '0'), ('4800', '17', '0', '0', '0', '0'), ('4800', '18', '0', '0', '0', '0'), ('4800', '19', '0', '0', '0', '0'), ('4800', '20', '0', '0', '0', '0'), ('4800', '21', '0', '0', '0', '0'), ('4800', '22', '0', '0', '0', '0'), ('4800', '23', '0', '0', '0', '0'), ('4800', '24', '0', '0', '0', '0'), ('4800', '25', '0', '0', '0', '0'), ('4800', '26', '0', '0', '0', '0'), ('4800', '27', '0', '0', '0', '0'), ('4800', '28', '0', '0', '0', '0'), ('4800', '29', '0', '0', '0', '0'), ('4800', '30', '0', '0', '0', '0'), ('4800', '31', '0', '0', '0', '0'), ('4800', '32', '0', '0', '0', '0'), ('4800', '33', '0', '0', '0', '0'), ('4800', '34', '0', '0', '0', '0'), ('4800', '35', '0', '0', '0', '0'), ('4800', '36', '0', '0', '0', '0'), ('4800', '37', '0', '0', '0', '0'), ('4900', '-11', '0', '0', '0', '0'), ('4900', '-10', '0', '0', '0', '0'), ('4900', '-9', '0', '0', '0', '0'), ('4900', '-8', '0', '0', '0', '0'), ('4900', '-7', '0', '0', '0', '0'), ('4900', '-6', '0', '0', '0', '0'), ('4900', '-5', '0', '0', '0', '0'), ('4900', '-4', '0', '0', '0', '0'), ('4900', '-3', '0', '0', '0', '0'), ('4900', '-2', '0', '0', '0', '0'), ('4900', '-1', '0', '0', '0', '0'), ('4900', '0', '0', '0', '0', '0'), ('4900', '1', '0', '0', '0', '0'), ('4900', '2', '0', '0', '0', '0'), ('4900', '3', '0', '0', '0', '0'), ('4900', '4', '0', '0', '0', '0'), ('4900', '5', '0', '0', '0', '0'), ('4900', '6', '0', '0', '0', '0'), ('4900', '7', '0', '0', '0', '0'), ('4900', '8', '0', '0', '0', '0'), ('4900', '9', '0', '0', '0', '0'), ('4900', '10', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('4900', '11', '0', '0', '0', '0'), ('4900', '12', '0', '0', '0', '0'), ('4900', '13', '0', '0', '0', '0'), ('4900', '14', '0', '0', '0', '0'), ('4900', '15', '0', '0', '0', '0'), ('4900', '16', '0', '0', '0', '0'), ('4900', '17', '0', '0', '0', '0'), ('4900', '18', '0', '0', '0', '0'), ('4900', '19', '0', '0', '0', '0'), ('4900', '20', '0', '0', '0', '0'), ('4900', '21', '0', '0', '0', '0'), ('4900', '22', '0', '0', '0', '0'), ('4900', '23', '0', '0', '0', '0'), ('4900', '24', '0', '0', '0', '0'), ('4900', '25', '0', '0', '0', '0'), ('4900', '26', '0', '0', '0', '0'), ('4900', '27', '0', '0', '0', '0'), ('4900', '28', '0', '0', '0', '0'), ('4900', '29', '0', '0', '0', '0'), ('4900', '30', '0', '0', '0', '0'), ('4900', '31', '0', '0', '0', '0'), ('4900', '32', '0', '0', '0', '0'), ('4900', '33', '0', '0', '0', '0'), ('4900', '34', '0', '0', '0', '0'), ('4900', '35', '0', '0', '0', '0'), ('4900', '36', '0', '0', '0', '0'), ('4900', '37', '0', '0', '0', '0'), ('5000', '-11', '0', '0', '0', '0'), ('5000', '-10', '0', '0', '0', '0'), ('5000', '-9', '0', '0', '0', '0'), ('5000', '-8', '0', '0', '0', '0'), ('5000', '-7', '0', '0', '0', '0'), ('5000', '-6', '0', '0', '0', '0'), ('5000', '-5', '0', '0', '0', '0'), ('5000', '-4', '0', '0', '0', '0'), ('5000', '-3', '0', '0', '0', '0'), ('5000', '-2', '0', '0', '0', '0'), ('5000', '-1', '0', '0', '0', '0'), ('5000', '0', '0', '0', '0', '0'), ('5000', '1', '0', '-1883.917', '0', '0'), ('5000', '2', '0', '13.35', '-1883.917', '0'), ('5000', '3', '0', '-5.25', '-1883.917', '0'), ('5000', '4', '0', '0', '-1883.917', '0'), ('5000', '5', '0', '0', '-1883.917', '0'), ('5000', '6', '0', '0', '-1883.917', '0'), ('5000', '7', '0', '0', '-1883.917', '0'), ('5000', '8', '0', '0', '-1883.917', '0'), ('5000', '9', '0', '0', '-1883.917', '0'), ('5000', '10', '0', '0', '-1883.917', '0'), ('5000', '11', '0', '0', '-1883.917', '0'), ('5000', '12', '0', '0', '-1883.917', '0'), ('5000', '13', '0', '0', '-1883.917', '0'), ('5000', '14', '0', '0', '-1883.917', '0'), ('5000', '15', '0', '0', '-1883.917', '0'), ('5000', '16', '0', '0', '-1883.917', '0'), ('5000', '17', '0', '0', '-1883.917', '0'), ('5000', '18', '0', '0', '-1883.917', '0'), ('5000', '19', '0', '0', '-1883.917', '0'), ('5000', '20', '0', '0', '-1883.917', '0'), ('5000', '21', '0', '0', '-1883.917', '0'), ('5000', '22', '0', '0', '-1883.917', '0'), ('5000', '23', '0', '0', '-1883.917', '0'), ('5000', '24', '0', '0', '-1883.917', '0'), ('5000', '25', '0', '0', '-1883.917', '0'), ('5000', '26', '0', '0', '-1883.917', '0'), ('5000', '27', '0', '0', '-1883.917', '0'), ('5000', '28', '0', '0', '-1883.917', '0'), ('5000', '29', '0', '0', '-1883.917', '0'), ('5000', '30', '0', '0', '-1883.917', '0'), ('5000', '31', '0', '0', '-1883.917', '0'), ('5000', '32', '0', '0', '-1883.917', '0'), ('5000', '33', '0', '0', '-1883.917', '0'), ('5000', '34', '0', '0', '-1883.917', '0'), ('5000', '35', '0', '0', '-1883.917', '0'), ('5000', '36', '0', '0', '-1883.917', '0'), ('5000', '37', '0', '0', '-1883.917', '0'), ('5100', '-11', '0', '0', '0', '0'), ('5100', '-10', '0', '0', '0', '0'), ('5100', '-9', '0', '0', '0', '0'), ('5100', '-8', '0', '0', '0', '0'), ('5100', '-7', '0', '0', '0', '0'), ('5100', '-6', '0', '0', '0', '0'), ('5100', '-5', '0', '0', '0', '0'), ('5100', '-4', '0', '0', '0', '0'), ('5100', '-3', '0', '0', '0', '0'), ('5100', '-2', '0', '0', '0', '0'), ('5100', '-1', '0', '0', '0', '0'), ('5100', '0', '0', '0', '0', '0'), ('5100', '1', '0', '0', '0', '0'), ('5100', '2', '0', '0', '0', '0'), ('5100', '3', '0', '0', '0', '0'), ('5100', '4', '0', '0', '0', '0'), ('5100', '5', '0', '0', '0', '0'), ('5100', '6', '0', '0', '0', '0'), ('5100', '7', '0', '0', '0', '0'), ('5100', '8', '0', '0', '0', '0'), ('5100', '9', '0', '0', '0', '0'), ('5100', '10', '0', '0', '0', '0'), ('5100', '11', '0', '0', '0', '0'), ('5100', '12', '0', '0', '0', '0'), ('5100', '13', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('5100', '14', '0', '0', '0', '0'), ('5100', '15', '0', '0', '0', '0'), ('5100', '16', '0', '0', '0', '0'), ('5100', '17', '0', '0', '0', '0'), ('5100', '18', '0', '0', '0', '0'), ('5100', '19', '0', '0', '0', '0'), ('5100', '20', '0', '0', '0', '0'), ('5100', '21', '0', '0', '0', '0'), ('5100', '22', '0', '0', '0', '0'), ('5100', '23', '0', '0', '0', '0'), ('5100', '24', '0', '0', '0', '0'), ('5100', '25', '0', '0', '0', '0'), ('5100', '26', '0', '0', '0', '0'), ('5100', '27', '0', '0', '0', '0'), ('5100', '28', '0', '0', '0', '0'), ('5100', '29', '0', '0', '0', '0'), ('5100', '30', '0', '0', '0', '0'), ('5100', '31', '0', '0', '0', '0'), ('5100', '32', '0', '0', '0', '0'), ('5100', '33', '0', '0', '0', '0'), ('5100', '34', '0', '0', '0', '0'), ('5100', '35', '0', '0', '0', '0'), ('5100', '36', '0', '0', '0', '0'), ('5100', '37', '0', '0', '0', '0'), ('5200', '-11', '0', '0', '0', '0'), ('5200', '-10', '0', '0', '0', '0'), ('5200', '-9', '0', '0', '0', '0'), ('5200', '-8', '0', '0', '0', '0'), ('5200', '-7', '0', '0', '0', '0'), ('5200', '-6', '0', '0', '0', '0'), ('5200', '-5', '0', '0', '0', '0'), ('5200', '-4', '0', '0', '0', '0'), ('5200', '-3', '0', '0', '0', '0'), ('5200', '-2', '0', '0', '0', '0'), ('5200', '-1', '0', '0', '0', '0'), ('5200', '0', '0', '0', '0', '0'), ('5200', '1', '0', '0', '0', '0'), ('5200', '2', '0', '0', '0', '0'), ('5200', '3', '0', '0', '0', '0'), ('5200', '4', '0', '0', '0', '0'), ('5200', '5', '0', '0', '0', '0'), ('5200', '6', '0', '0', '0', '0'), ('5200', '7', '0', '0', '0', '0'), ('5200', '8', '0', '0', '0', '0'), ('5200', '9', '0', '0', '0', '0'), ('5200', '10', '0', '0', '0', '0'), ('5200', '11', '0', '0', '0', '0'), ('5200', '12', '0', '0', '0', '0'), ('5200', '13', '0', '0', '0', '0'), ('5200', '14', '0', '0', '0', '0'), ('5200', '15', '0', '0', '0', '0'), ('5200', '16', '0', '0', '0', '0'), ('5200', '17', '0', '0', '0', '0'), ('5200', '18', '0', '0', '0', '0'), ('5200', '19', '0', '0', '0', '0'), ('5200', '20', '0', '0', '0', '0'), ('5200', '21', '0', '0', '0', '0'), ('5200', '22', '0', '0', '0', '0'), ('5200', '23', '0', '0', '0', '0'), ('5200', '24', '0', '0', '0', '0'), ('5200', '25', '0', '0', '0', '0'), ('5200', '26', '0', '0', '0', '0'), ('5200', '27', '0', '0', '0', '0'), ('5200', '28', '0', '0', '0', '0'), ('5200', '29', '0', '0', '0', '0'), ('5200', '30', '0', '0', '0', '0'), ('5200', '31', '0', '0', '0', '0'), ('5200', '32', '0', '0', '0', '0'), ('5200', '33', '0', '0', '0', '0'), ('5200', '34', '0', '0', '0', '0'), ('5200', '35', '0', '0', '0', '0'), ('5200', '36', '0', '0', '0', '0'), ('5200', '37', '0', '0', '0', '0'), ('5500', '-11', '0', '0', '0', '0'), ('5500', '-10', '0', '0', '0', '0'), ('5500', '-9', '0', '0', '0', '0'), ('5500', '-8', '0', '0', '0', '0'), ('5500', '-7', '0', '0', '0', '0'), ('5500', '-6', '0', '0', '0', '0'), ('5500', '-5', '0', '0', '0', '0'), ('5500', '-4', '0', '0', '0', '0'), ('5500', '-3', '0', '0', '0', '0'), ('5500', '-2', '0', '0', '0', '0'), ('5500', '-1', '0', '0', '0', '0'), ('5500', '0', '0', '0', '0', '0'), ('5500', '1', '0', '0', '0', '0'), ('5500', '2', '0', '0', '0', '0'), ('5500', '3', '0', '0', '0', '0'), ('5500', '4', '0', '0', '0', '0'), ('5500', '5', '0', '0', '0', '0'), ('5500', '6', '0', '0', '0', '0'), ('5500', '7', '0', '0', '0', '0'), ('5500', '8', '0', '0', '0', '0'), ('5500', '9', '0', '0', '0', '0'), ('5500', '10', '0', '0', '0', '0'), ('5500', '11', '0', '0', '0', '0'), ('5500', '12', '0', '0', '0', '0'), ('5500', '13', '0', '0', '0', '0'), ('5500', '14', '0', '0', '0', '0'), ('5500', '15', '0', '0', '0', '0'), ('5500', '16', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('5500', '17', '0', '0', '0', '0'), ('5500', '18', '0', '0', '0', '0'), ('5500', '19', '0', '0', '0', '0'), ('5500', '20', '0', '0', '0', '0'), ('5500', '21', '0', '0', '0', '0'), ('5500', '22', '0', '0', '0', '0'), ('5500', '23', '0', '0', '0', '0'), ('5500', '24', '0', '0', '0', '0'), ('5500', '25', '0', '0', '0', '0'), ('5500', '26', '0', '0', '0', '0'), ('5500', '27', '0', '0', '0', '0'), ('5500', '28', '0', '0', '0', '0'), ('5500', '29', '0', '0', '0', '0'), ('5500', '30', '0', '0', '0', '0'), ('5500', '31', '0', '0', '0', '0'), ('5500', '32', '0', '0', '0', '0'), ('5500', '33', '0', '0', '0', '0'), ('5500', '34', '0', '0', '0', '0'), ('5500', '35', '0', '0', '0', '0'), ('5500', '36', '0', '0', '0', '0'), ('5500', '37', '0', '0', '0', '0'), ('5600', '-11', '0', '0', '0', '0'), ('5600', '-10', '0', '0', '0', '0'), ('5600', '-9', '0', '0', '0', '0'), ('5600', '-8', '0', '0', '0', '0'), ('5600', '-7', '0', '0', '0', '0'), ('5600', '-6', '0', '0', '0', '0'), ('5600', '-5', '0', '0', '0', '0'), ('5600', '-4', '0', '0', '0', '0'), ('5600', '-3', '0', '0', '0', '0'), ('5600', '-2', '0', '0', '0', '0'), ('5600', '-1', '0', '0', '0', '0'), ('5600', '0', '0', '0', '0', '0'), ('5600', '1', '0', '0', '0', '0'), ('5600', '2', '0', '0', '0', '0'), ('5600', '3', '0', '0', '0', '0'), ('5600', '4', '0', '0', '0', '0'), ('5600', '5', '0', '0', '0', '0'), ('5600', '6', '0', '0', '0', '0'), ('5600', '7', '0', '0', '0', '0'), ('5600', '8', '0', '0', '0', '0'), ('5600', '9', '0', '0', '0', '0'), ('5600', '10', '0', '0', '0', '0'), ('5600', '11', '0', '0', '0', '0'), ('5600', '12', '0', '0', '0', '0'), ('5600', '13', '0', '0', '0', '0'), ('5600', '14', '0', '0', '0', '0'), ('5600', '15', '0', '0', '0', '0'), ('5600', '16', '0', '0', '0', '0'), ('5600', '17', '0', '0', '0', '0'), ('5600', '18', '0', '0', '0', '0'), ('5600', '19', '0', '0', '0', '0'), ('5600', '20', '0', '0', '0', '0'), ('5600', '21', '0', '0', '0', '0'), ('5600', '22', '0', '0', '0', '0'), ('5600', '23', '0', '0', '0', '0'), ('5600', '24', '0', '0', '0', '0'), ('5600', '25', '0', '0', '0', '0'), ('5600', '26', '0', '0', '0', '0'), ('5600', '27', '0', '0', '0', '0'), ('5600', '28', '0', '0', '0', '0'), ('5600', '29', '0', '0', '0', '0'), ('5600', '30', '0', '0', '0', '0'), ('5600', '31', '0', '0', '0', '0'), ('5600', '32', '0', '0', '0', '0'), ('5600', '33', '0', '0', '0', '0'), ('5600', '34', '0', '0', '0', '0'), ('5600', '35', '0', '0', '0', '0'), ('5600', '36', '0', '0', '0', '0'), ('5600', '37', '0', '0', '0', '0'), ('5700', '-11', '0', '0', '0', '0'), ('5700', '-10', '0', '0', '0', '0'), ('5700', '-9', '0', '0', '0', '0'), ('5700', '-8', '0', '0', '0', '0'), ('5700', '-7', '0', '0', '0', '0'), ('5700', '-6', '0', '0', '0', '0'), ('5700', '-5', '0', '0', '0', '0'), ('5700', '-4', '0', '0', '0', '0'), ('5700', '-3', '0', '0', '0', '0'), ('5700', '-2', '0', '0', '0', '0'), ('5700', '-1', '0', '0', '0', '0'), ('5700', '0', '0', '-166.25', '0', '0'), ('5700', '1', '0', '0', '-166.25', '0'), ('5700', '2', '0', '0', '-166.25', '0'), ('5700', '3', '0', '-8.94', '-166.25', '0'), ('5700', '4', '0', '0', '-175.19', '0'), ('5700', '5', '0', '0', '-175.19', '0'), ('5700', '6', '0', '0', '-166.25', '0'), ('5700', '7', '0', '0', '-166.25', '0'), ('5700', '8', '0', '0', '-166.25', '0'), ('5700', '9', '0', '0', '-166.25', '0'), ('5700', '10', '0', '0', '-166.25', '0'), ('5700', '11', '0', '0', '-166.25', '0'), ('5700', '12', '0', '0', '-166.25', '0'), ('5700', '13', '0', '0', '-166.25', '0'), ('5700', '14', '0', '0', '-166.25', '0'), ('5700', '15', '0', '0', '-166.25', '0'), ('5700', '16', '0', '0', '-166.25', '0'), ('5700', '17', '0', '0', '-166.25', '0'), ('5700', '18', '0', '0', '-166.25', '0'), ('5700', '19', '0', '0', '-166.25', '0');
INSERT INTO `chartdetails` VALUES ('5700', '20', '0', '0', '-166.25', '0'), ('5700', '21', '0', '-600.85', '-166.25', '0'), ('5700', '22', '0', '0', '-767.1', '0'), ('5700', '23', '0', '0', '-166.25', '0'), ('5700', '24', '0', '0', '-166.25', '0'), ('5700', '25', '0', '0', '-166.25', '0'), ('5700', '26', '0', '0', '-166.25', '0'), ('5700', '27', '0', '0', '-166.25', '0'), ('5700', '28', '0', '0', '-166.25', '0'), ('5700', '29', '0', '0', '-166.25', '0'), ('5700', '30', '0', '0', '-166.25', '0'), ('5700', '31', '0', '0', '-166.25', '0'), ('5700', '32', '0', '0', '-166.25', '0'), ('5700', '33', '0', '0', '-166.25', '0'), ('5700', '34', '0', '0', '-166.25', '0'), ('5700', '35', '0', '0', '-166.25', '0'), ('5700', '36', '0', '0', '-166.25', '0'), ('5700', '37', '0', '0', '-166.25', '0'), ('5800', '-11', '0', '0', '0', '0'), ('5800', '-10', '0', '0', '0', '0'), ('5800', '-9', '0', '0', '0', '0'), ('5800', '-8', '0', '0', '0', '0'), ('5800', '-7', '0', '0', '0', '0'), ('5800', '-6', '0', '0', '0', '0'), ('5800', '-5', '0', '0', '0', '0'), ('5800', '-4', '0', '0', '0', '0'), ('5800', '-3', '0', '0', '0', '0'), ('5800', '-2', '0', '0', '0', '0'), ('5800', '-1', '0', '0', '0', '0'), ('5800', '0', '0', '0', '0', '0'), ('5800', '1', '0', '0', '0', '0'), ('5800', '2', '0', '0', '0', '0'), ('5800', '3', '0', '0', '0', '0'), ('5800', '4', '0', '0', '0', '0'), ('5800', '5', '0', '0', '0', '0'), ('5800', '6', '0', '0', '0', '0'), ('5800', '7', '0', '0', '0', '0'), ('5800', '8', '0', '0', '0', '0'), ('5800', '9', '0', '0', '0', '0'), ('5800', '10', '0', '0', '0', '0'), ('5800', '11', '0', '0', '0', '0'), ('5800', '12', '0', '0', '0', '0'), ('5800', '13', '0', '0', '0', '0'), ('5800', '14', '0', '0', '0', '0'), ('5800', '15', '0', '0', '0', '0'), ('5800', '16', '0', '0', '0', '0'), ('5800', '17', '0', '0', '0', '0'), ('5800', '18', '0', '0', '0', '0'), ('5800', '19', '0', '0', '0', '0'), ('5800', '20', '0', '0', '0', '0'), ('5800', '21', '0', '0', '0', '0'), ('5800', '22', '0', '0', '0', '0'), ('5800', '23', '0', '0', '0', '0'), ('5800', '24', '0', '0', '0', '0'), ('5800', '25', '0', '0', '0', '0'), ('5800', '26', '0', '0', '0', '0'), ('5800', '27', '0', '0', '0', '0'), ('5800', '28', '0', '0', '0', '0'), ('5800', '29', '0', '0', '0', '0'), ('5800', '30', '0', '0', '0', '0'), ('5800', '31', '0', '0', '0', '0'), ('5800', '32', '0', '0', '0', '0'), ('5800', '33', '0', '0', '0', '0'), ('5800', '34', '0', '0', '0', '0'), ('5800', '35', '0', '0', '0', '0'), ('5800', '36', '0', '0', '0', '0'), ('5800', '37', '0', '0', '0', '0'), ('5900', '-11', '0', '0', '0', '0'), ('5900', '-10', '0', '0', '0', '0'), ('5900', '-9', '0', '0', '0', '0'), ('5900', '-8', '0', '0', '0', '0'), ('5900', '-7', '0', '0', '0', '0'), ('5900', '-6', '0', '0', '0', '0'), ('5900', '-5', '0', '0', '0', '0'), ('5900', '-4', '0', '0', '0', '0'), ('5900', '-3', '0', '0', '0', '0'), ('5900', '-2', '0', '0', '0', '0'), ('5900', '-1', '0', '0', '0', '0'), ('5900', '0', '0', '0', '0', '0'), ('5900', '1', '0', '0', '0', '0'), ('5900', '2', '0', '0', '0', '0'), ('5900', '3', '0', '0', '0', '0'), ('5900', '4', '0', '0', '0', '0'), ('5900', '5', '0', '0', '0', '0'), ('5900', '6', '0', '0', '0', '0'), ('5900', '7', '0', '0', '0', '0'), ('5900', '8', '0', '0', '0', '0'), ('5900', '9', '0', '0', '0', '0'), ('5900', '10', '0', '0', '0', '0'), ('5900', '11', '0', '0', '0', '0'), ('5900', '12', '0', '0', '0', '0'), ('5900', '13', '0', '0', '0', '0'), ('5900', '14', '0', '0', '0', '0'), ('5900', '15', '0', '0', '0', '0'), ('5900', '16', '0', '0', '0', '0'), ('5900', '17', '0', '0', '0', '0'), ('5900', '18', '0', '0', '0', '0'), ('5900', '19', '0', '0', '0', '0'), ('5900', '20', '0', '0', '0', '0'), ('5900', '21', '0', '0', '0', '0'), ('5900', '22', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('5900', '23', '0', '0', '0', '0'), ('5900', '24', '0', '0', '0', '0'), ('5900', '25', '0', '0', '0', '0'), ('5900', '26', '0', '0', '0', '0'), ('5900', '27', '0', '0', '0', '0'), ('5900', '28', '0', '0', '0', '0'), ('5900', '29', '0', '0', '0', '0'), ('5900', '30', '0', '0', '0', '0'), ('5900', '31', '0', '0', '0', '0'), ('5900', '32', '0', '0', '0', '0'), ('5900', '33', '0', '0', '0', '0'), ('5900', '34', '0', '0', '0', '0'), ('5900', '35', '0', '0', '0', '0'), ('5900', '36', '0', '0', '0', '0'), ('5900', '37', '0', '0', '0', '0'), ('6100', '-11', '0', '0', '0', '0'), ('6100', '-10', '0', '0', '0', '0'), ('6100', '-9', '0', '0', '0', '0'), ('6100', '-8', '0', '0', '0', '0'), ('6100', '-7', '0', '0', '0', '0'), ('6100', '-6', '0', '0', '0', '0'), ('6100', '-5', '0', '0', '0', '0'), ('6100', '-4', '0', '0', '0', '0'), ('6100', '-3', '0', '0', '0', '0'), ('6100', '-2', '0', '0', '0', '0'), ('6100', '-1', '0', '0', '0', '0'), ('6100', '0', '0', '62.5', '0', '0'), ('6100', '1', '0', '0', '62.5', '0'), ('6100', '2', '0', '0', '62.5', '0'), ('6100', '3', '0', '0', '62.5', '0'), ('6100', '4', '0', '0', '62.5', '0'), ('6100', '5', '0', '-150', '62.5', '0'), ('6100', '6', '0', '0', '62.5', '0'), ('6100', '7', '0', '0', '62.5', '0'), ('6100', '8', '0', '0', '62.5', '0'), ('6100', '9', '0', '0', '62.5', '0'), ('6100', '10', '0', '0', '62.5', '0'), ('6100', '11', '0', '0', '62.5', '0'), ('6100', '12', '0', '0', '62.5', '0'), ('6100', '13', '0', '0', '62.5', '0'), ('6100', '14', '0', '0', '62.5', '0'), ('6100', '15', '0', '0', '62.5', '0'), ('6100', '16', '0', '0', '62.5', '0'), ('6100', '17', '0', '0', '62.5', '0'), ('6100', '18', '0', '0', '62.5', '0'), ('6100', '19', '0', '0', '62.5', '0'), ('6100', '20', '0', '0', '62.5', '0'), ('6100', '21', '0', '0', '62.5', '0'), ('6100', '22', '0', '0', '62.5', '0'), ('6100', '23', '0', '0', '62.5', '0'), ('6100', '24', '0', '0', '62.5', '0'), ('6100', '25', '0', '0', '62.5', '0'), ('6100', '26', '0', '0', '62.5', '0'), ('6100', '27', '0', '0', '62.5', '0'), ('6100', '28', '0', '0', '62.5', '0'), ('6100', '29', '0', '0', '62.5', '0'), ('6100', '30', '0', '0', '62.5', '0'), ('6100', '31', '0', '0', '62.5', '0'), ('6100', '32', '0', '0', '62.5', '0'), ('6100', '33', '0', '0', '62.5', '0'), ('6100', '34', '0', '0', '62.5', '0'), ('6100', '35', '0', '0', '62.5', '0'), ('6100', '36', '0', '0', '62.5', '0'), ('6100', '37', '0', '0', '62.5', '0'), ('6150', '-11', '0', '0', '0', '0'), ('6150', '-10', '0', '0', '0', '0'), ('6150', '-9', '0', '0', '0', '0'), ('6150', '-8', '0', '0', '0', '0'), ('6150', '-7', '0', '0', '0', '0'), ('6150', '-6', '0', '0', '0', '0'), ('6150', '-5', '0', '0', '0', '0'), ('6150', '-4', '0', '0', '0', '0'), ('6150', '-3', '0', '0', '0', '0'), ('6150', '-2', '0', '0', '0', '0'), ('6150', '-1', '0', '0', '0', '0'), ('6150', '0', '0', '0', '0', '0'), ('6150', '1', '0', '0', '0', '0'), ('6150', '2', '0', '0', '0', '0'), ('6150', '3', '0', '0', '0', '0'), ('6150', '4', '0', '0', '0', '0'), ('6150', '5', '0', '0', '0', '0'), ('6150', '6', '0', '0', '0', '0'), ('6150', '7', '0', '0', '0', '0'), ('6150', '8', '0', '0', '0', '0'), ('6150', '9', '0', '0', '0', '0'), ('6150', '10', '0', '0', '0', '0'), ('6150', '11', '0', '0', '0', '0'), ('6150', '12', '0', '0', '0', '0'), ('6150', '13', '0', '0', '0', '0'), ('6150', '14', '0', '0', '0', '0'), ('6150', '15', '0', '0', '0', '0'), ('6150', '16', '0', '0', '0', '0'), ('6150', '17', '0', '0', '0', '0'), ('6150', '18', '0', '0', '0', '0'), ('6150', '19', '0', '0', '0', '0'), ('6150', '20', '0', '0', '0', '0'), ('6150', '21', '0', '0', '0', '0'), ('6150', '22', '0', '0', '0', '0'), ('6150', '23', '0', '0', '0', '0'), ('6150', '24', '0', '0', '0', '0'), ('6150', '25', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('6150', '26', '0', '0', '0', '0'), ('6150', '27', '0', '0', '0', '0'), ('6150', '28', '0', '0', '0', '0'), ('6150', '29', '0', '0', '0', '0'), ('6150', '30', '0', '0', '0', '0'), ('6150', '31', '0', '0', '0', '0'), ('6150', '32', '0', '0', '0', '0'), ('6150', '33', '0', '0', '0', '0'), ('6150', '34', '0', '0', '0', '0'), ('6150', '35', '0', '0', '0', '0'), ('6150', '36', '0', '0', '0', '0'), ('6150', '37', '0', '0', '0', '0'), ('6200', '-11', '0', '0', '0', '0'), ('6200', '-10', '0', '0', '0', '0'), ('6200', '-9', '0', '0', '0', '0'), ('6200', '-8', '0', '0', '0', '0'), ('6200', '-7', '0', '0', '0', '0'), ('6200', '-6', '0', '0', '0', '0'), ('6200', '-5', '0', '0', '0', '0'), ('6200', '-4', '0', '0', '0', '0'), ('6200', '-3', '0', '0', '0', '0'), ('6200', '-2', '0', '0', '0', '0'), ('6200', '-1', '0', '0', '0', '0'), ('6200', '0', '0', '0', '0', '0'), ('6200', '1', '0', '0', '0', '0'), ('6200', '2', '0', '0', '0', '0'), ('6200', '3', '0', '0', '0', '0'), ('6200', '4', '0', '0', '0', '0'), ('6200', '5', '0', '0', '0', '0'), ('6200', '6', '0', '0', '0', '0'), ('6200', '7', '0', '0', '0', '0'), ('6200', '8', '0', '0', '0', '0'), ('6200', '9', '0', '0', '0', '0'), ('6200', '10', '0', '0', '0', '0'), ('6200', '11', '0', '0', '0', '0'), ('6200', '12', '0', '0', '0', '0'), ('6200', '13', '0', '0', '0', '0'), ('6200', '14', '0', '0', '0', '0'), ('6200', '15', '0', '0', '0', '0'), ('6200', '16', '0', '0', '0', '0'), ('6200', '17', '0', '0', '0', '0'), ('6200', '18', '0', '0', '0', '0'), ('6200', '19', '0', '0', '0', '0'), ('6200', '20', '0', '0', '0', '0'), ('6200', '21', '0', '0', '0', '0'), ('6200', '22', '0', '0', '0', '0'), ('6200', '23', '0', '0', '0', '0'), ('6200', '24', '0', '0', '0', '0'), ('6200', '25', '0', '0', '0', '0'), ('6200', '26', '0', '0', '0', '0'), ('6200', '27', '0', '0', '0', '0'), ('6200', '28', '0', '0', '0', '0'), ('6200', '29', '0', '0', '0', '0'), ('6200', '30', '0', '0', '0', '0'), ('6200', '31', '0', '0', '0', '0'), ('6200', '32', '0', '0', '0', '0'), ('6200', '33', '0', '0', '0', '0'), ('6200', '34', '0', '0', '0', '0'), ('6200', '35', '0', '0', '0', '0'), ('6200', '36', '0', '0', '0', '0'), ('6200', '37', '0', '0', '0', '0'), ('6250', '-11', '0', '0', '0', '0'), ('6250', '-10', '0', '0', '0', '0'), ('6250', '-9', '0', '0', '0', '0'), ('6250', '-8', '0', '0', '0', '0'), ('6250', '-7', '0', '0', '0', '0'), ('6250', '-6', '0', '0', '0', '0'), ('6250', '-5', '0', '0', '0', '0'), ('6250', '-4', '0', '0', '0', '0'), ('6250', '-3', '0', '0', '0', '0'), ('6250', '-2', '0', '0', '0', '0'), ('6250', '-1', '0', '0', '0', '0'), ('6250', '0', '0', '0', '0', '0'), ('6250', '1', '0', '0', '0', '0'), ('6250', '2', '0', '0', '0', '0'), ('6250', '3', '0', '0', '0', '0'), ('6250', '4', '0', '0', '0', '0'), ('6250', '5', '0', '0', '0', '0'), ('6250', '6', '0', '0', '0', '0'), ('6250', '7', '0', '0', '0', '0'), ('6250', '8', '0', '0', '0', '0'), ('6250', '9', '0', '0', '0', '0'), ('6250', '10', '0', '0', '0', '0'), ('6250', '11', '0', '0', '0', '0'), ('6250', '12', '0', '0', '0', '0'), ('6250', '13', '0', '0', '0', '0'), ('6250', '14', '0', '0', '0', '0'), ('6250', '15', '0', '0', '0', '0'), ('6250', '16', '0', '0', '0', '0'), ('6250', '17', '0', '0', '0', '0'), ('6250', '18', '0', '0', '0', '0'), ('6250', '19', '0', '0', '0', '0'), ('6250', '20', '0', '0', '0', '0'), ('6250', '21', '0', '0', '0', '0'), ('6250', '22', '0', '0', '0', '0'), ('6250', '23', '0', '0', '0', '0'), ('6250', '24', '0', '0', '0', '0'), ('6250', '25', '0', '0', '0', '0'), ('6250', '26', '0', '0', '0', '0'), ('6250', '27', '0', '0', '0', '0'), ('6250', '28', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('6250', '29', '0', '0', '0', '0'), ('6250', '30', '0', '0', '0', '0'), ('6250', '31', '0', '0', '0', '0'), ('6250', '32', '0', '0', '0', '0'), ('6250', '33', '0', '0', '0', '0'), ('6250', '34', '0', '0', '0', '0'), ('6250', '35', '0', '0', '0', '0'), ('6250', '36', '0', '0', '0', '0'), ('6250', '37', '0', '0', '0', '0'), ('6300', '-11', '0', '0', '0', '0'), ('6300', '-10', '0', '0', '0', '0'), ('6300', '-9', '0', '0', '0', '0'), ('6300', '-8', '0', '0', '0', '0'), ('6300', '-7', '0', '0', '0', '0'), ('6300', '-6', '0', '0', '0', '0'), ('6300', '-5', '0', '0', '0', '0'), ('6300', '-4', '0', '0', '0', '0'), ('6300', '-3', '0', '0', '0', '0'), ('6300', '-2', '0', '0', '0', '0'), ('6300', '-1', '0', '0', '0', '0'), ('6300', '0', '0', '0', '0', '0'), ('6300', '1', '0', '0', '0', '0'), ('6300', '2', '0', '0', '0', '0'), ('6300', '3', '0', '0', '0', '0'), ('6300', '4', '0', '0', '0', '0'), ('6300', '5', '0', '0', '0', '0'), ('6300', '6', '0', '0', '0', '0'), ('6300', '7', '0', '0', '0', '0'), ('6300', '8', '0', '0', '0', '0'), ('6300', '9', '0', '0', '0', '0'), ('6300', '10', '0', '0', '0', '0'), ('6300', '11', '0', '0', '0', '0'), ('6300', '12', '0', '0', '0', '0'), ('6300', '13', '0', '0', '0', '0'), ('6300', '14', '0', '0', '0', '0'), ('6300', '15', '0', '0', '0', '0'), ('6300', '16', '0', '0', '0', '0'), ('6300', '17', '0', '0', '0', '0'), ('6300', '18', '0', '0', '0', '0'), ('6300', '19', '0', '0', '0', '0'), ('6300', '20', '0', '0', '0', '0'), ('6300', '21', '0', '0', '0', '0'), ('6300', '22', '0', '0', '0', '0'), ('6300', '23', '0', '0', '0', '0'), ('6300', '24', '0', '0', '0', '0'), ('6300', '25', '0', '0', '0', '0'), ('6300', '26', '0', '0', '0', '0'), ('6300', '27', '0', '0', '0', '0'), ('6300', '28', '0', '0', '0', '0'), ('6300', '29', '0', '0', '0', '0'), ('6300', '30', '0', '0', '0', '0'), ('6300', '31', '0', '0', '0', '0'), ('6300', '32', '0', '0', '0', '0'), ('6300', '33', '0', '0', '0', '0'), ('6300', '34', '0', '0', '0', '0'), ('6300', '35', '0', '0', '0', '0'), ('6300', '36', '0', '0', '0', '0'), ('6300', '37', '0', '0', '0', '0'), ('6400', '-11', '0', '0', '0', '0'), ('6400', '-10', '0', '0', '0', '0'), ('6400', '-9', '0', '0', '0', '0'), ('6400', '-8', '0', '0', '0', '0'), ('6400', '-7', '0', '0', '0', '0'), ('6400', '-6', '0', '0', '0', '0'), ('6400', '-5', '0', '0', '0', '0'), ('6400', '-4', '0', '0', '0', '0'), ('6400', '-3', '0', '0', '0', '0'), ('6400', '-2', '0', '0', '0', '0'), ('6400', '-1', '0', '0', '0', '0'), ('6400', '0', '0', '0', '0', '0'), ('6400', '1', '0', '0', '0', '0'), ('6400', '2', '0', '0', '0', '0'), ('6400', '3', '0', '0', '0', '0'), ('6400', '4', '0', '0', '0', '0'), ('6400', '5', '0', '0', '0', '0'), ('6400', '6', '0', '0', '0', '0'), ('6400', '7', '0', '0', '0', '0'), ('6400', '8', '0', '0', '0', '0'), ('6400', '9', '0', '0', '0', '0'), ('6400', '10', '0', '0', '0', '0'), ('6400', '11', '0', '0', '0', '0'), ('6400', '12', '0', '0', '0', '0'), ('6400', '13', '0', '0', '0', '0'), ('6400', '14', '0', '0', '0', '0'), ('6400', '15', '0', '0', '0', '0'), ('6400', '16', '0', '0', '0', '0'), ('6400', '17', '0', '0', '0', '0'), ('6400', '18', '0', '0', '0', '0'), ('6400', '19', '0', '0', '0', '0'), ('6400', '20', '0', '0', '0', '0'), ('6400', '21', '0', '0', '0', '0'), ('6400', '22', '0', '0', '0', '0'), ('6400', '23', '0', '0', '0', '0'), ('6400', '24', '0', '0', '0', '0'), ('6400', '25', '0', '0', '0', '0'), ('6400', '26', '0', '0', '0', '0'), ('6400', '27', '0', '0', '0', '0'), ('6400', '28', '0', '0', '0', '0'), ('6400', '29', '0', '0', '0', '0'), ('6400', '30', '0', '0', '0', '0'), ('6400', '31', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('6400', '32', '0', '0', '0', '0'), ('6400', '33', '0', '0', '0', '0'), ('6400', '34', '0', '0', '0', '0'), ('6400', '35', '0', '0', '0', '0'), ('6400', '36', '0', '0', '0', '0'), ('6400', '37', '0', '0', '0', '0'), ('6500', '-11', '0', '0', '0', '0'), ('6500', '-10', '0', '0', '0', '0'), ('6500', '-9', '0', '0', '0', '0'), ('6500', '-8', '0', '0', '0', '0'), ('6500', '-7', '0', '0', '0', '0'), ('6500', '-6', '0', '0', '0', '0'), ('6500', '-5', '0', '0', '0', '0'), ('6500', '-4', '0', '0', '0', '0'), ('6500', '-3', '0', '0', '0', '0'), ('6500', '-2', '0', '0', '0', '0'), ('6500', '-1', '0', '0', '0', '0'), ('6500', '0', '0', '0', '0', '0'), ('6500', '1', '0', '0', '0', '0'), ('6500', '2', '0', '0', '0', '0'), ('6500', '3', '0', '0', '0', '0'), ('6500', '4', '0', '0', '0', '0'), ('6500', '5', '0', '0', '0', '0'), ('6500', '6', '0', '0', '0', '0'), ('6500', '7', '0', '0', '0', '0'), ('6500', '8', '0', '0', '0', '0'), ('6500', '9', '0', '0', '0', '0'), ('6500', '10', '0', '0', '0', '0'), ('6500', '11', '0', '0', '0', '0'), ('6500', '12', '0', '0', '0', '0'), ('6500', '13', '0', '0', '0', '0'), ('6500', '14', '0', '0', '0', '0'), ('6500', '15', '0', '0', '0', '0'), ('6500', '16', '0', '0', '0', '0'), ('6500', '17', '0', '0', '0', '0'), ('6500', '18', '0', '0', '0', '0'), ('6500', '19', '0', '0', '0', '0'), ('6500', '20', '0', '0', '0', '0'), ('6500', '21', '0', '0', '0', '0'), ('6500', '22', '0', '0', '0', '0'), ('6500', '23', '0', '0', '0', '0'), ('6500', '24', '0', '0', '0', '0'), ('6500', '25', '0', '0', '0', '0'), ('6500', '26', '0', '0', '0', '0'), ('6500', '27', '0', '0', '0', '0'), ('6500', '28', '0', '0', '0', '0'), ('6500', '29', '0', '0', '0', '0'), ('6500', '30', '0', '0', '0', '0'), ('6500', '31', '0', '0', '0', '0'), ('6500', '32', '0', '0', '0', '0'), ('6500', '33', '0', '0', '0', '0'), ('6500', '34', '0', '0', '0', '0'), ('6500', '35', '0', '0', '0', '0'), ('6500', '36', '0', '0', '0', '0'), ('6500', '37', '0', '0', '0', '0'), ('6550', '-11', '0', '0', '0', '0'), ('6550', '-10', '0', '0', '0', '0'), ('6550', '-9', '0', '0', '0', '0'), ('6550', '-8', '0', '0', '0', '0'), ('6550', '-7', '0', '0', '0', '0'), ('6550', '-6', '0', '0', '0', '0'), ('6550', '-5', '0', '0', '0', '0'), ('6550', '-4', '0', '0', '0', '0'), ('6550', '-3', '0', '0', '0', '0'), ('6550', '-2', '0', '0', '0', '0'), ('6550', '-1', '0', '0', '0', '0'), ('6550', '0', '0', '0', '0', '0'), ('6550', '1', '0', '0', '0', '0'), ('6550', '2', '0', '0', '0', '0'), ('6550', '3', '0', '0', '0', '0'), ('6550', '4', '0', '0', '0', '0'), ('6550', '5', '0', '0', '0', '0'), ('6550', '6', '0', '0', '0', '0'), ('6550', '7', '0', '0', '0', '0'), ('6550', '8', '0', '0', '0', '0'), ('6550', '9', '0', '0', '0', '0'), ('6550', '10', '0', '0', '0', '0'), ('6550', '11', '0', '0', '0', '0'), ('6550', '12', '0', '0', '0', '0'), ('6550', '13', '0', '0', '0', '0'), ('6550', '14', '0', '0', '0', '0'), ('6550', '15', '0', '0', '0', '0'), ('6550', '16', '0', '0', '0', '0'), ('6550', '17', '0', '0', '0', '0'), ('6550', '18', '0', '0', '0', '0'), ('6550', '19', '0', '0', '0', '0'), ('6550', '20', '0', '0', '0', '0'), ('6550', '21', '0', '0', '0', '0'), ('6550', '22', '0', '0', '0', '0'), ('6550', '23', '0', '0', '0', '0'), ('6550', '24', '0', '0', '0', '0'), ('6550', '25', '0', '0', '0', '0'), ('6550', '26', '0', '0', '0', '0'), ('6550', '27', '0', '0', '0', '0'), ('6550', '28', '0', '0', '0', '0'), ('6550', '29', '0', '0', '0', '0'), ('6550', '30', '0', '0', '0', '0'), ('6550', '31', '0', '0', '0', '0'), ('6550', '32', '0', '0', '0', '0'), ('6550', '33', '0', '0', '0', '0'), ('6550', '34', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('6550', '35', '0', '0', '0', '0'), ('6550', '36', '0', '0', '0', '0'), ('6550', '37', '0', '0', '0', '0'), ('6590', '-11', '0', '0', '0', '0'), ('6590', '-10', '0', '0', '0', '0'), ('6590', '-9', '0', '0', '0', '0'), ('6590', '-8', '0', '0', '0', '0'), ('6590', '-7', '0', '0', '0', '0'), ('6590', '-6', '0', '0', '0', '0'), ('6590', '-5', '0', '0', '0', '0'), ('6590', '-4', '0', '0', '0', '0'), ('6590', '-3', '0', '0', '0', '0'), ('6590', '-2', '0', '0', '0', '0'), ('6590', '-1', '0', '0', '0', '0'), ('6590', '0', '0', '0', '0', '0'), ('6590', '1', '0', '0', '0', '0'), ('6590', '2', '0', '0', '0', '0'), ('6590', '3', '0', '0', '0', '0'), ('6590', '4', '0', '0', '0', '0'), ('6590', '5', '0', '0', '0', '0'), ('6590', '6', '0', '0', '0', '0'), ('6590', '7', '0', '0', '0', '0'), ('6590', '8', '0', '0', '0', '0'), ('6590', '9', '0', '0', '0', '0'), ('6590', '10', '0', '0', '0', '0'), ('6590', '11', '0', '0', '0', '0'), ('6590', '12', '0', '0', '0', '0'), ('6590', '13', '0', '0', '0', '0'), ('6590', '14', '0', '0', '0', '0'), ('6590', '15', '0', '0', '0', '0'), ('6590', '16', '0', '0', '0', '0'), ('6590', '17', '0', '0', '0', '0'), ('6590', '18', '0', '0', '0', '0'), ('6590', '19', '0', '0', '0', '0'), ('6590', '20', '0', '0', '0', '0'), ('6590', '21', '0', '0', '0', '0'), ('6590', '22', '0', '0', '0', '0'), ('6590', '23', '0', '0', '0', '0'), ('6590', '24', '0', '0', '0', '0'), ('6590', '25', '0', '0', '0', '0'), ('6590', '26', '0', '0', '0', '0'), ('6590', '27', '0', '0', '0', '0'), ('6590', '28', '0', '0', '0', '0'), ('6590', '29', '0', '0', '0', '0'), ('6590', '30', '0', '0', '0', '0'), ('6590', '31', '0', '0', '0', '0'), ('6590', '32', '0', '0', '0', '0'), ('6590', '33', '0', '0', '0', '0'), ('6590', '34', '0', '0', '0', '0'), ('6590', '35', '0', '0', '0', '0'), ('6590', '36', '0', '0', '0', '0'), ('6590', '37', '0', '0', '0', '0'), ('6600', '-11', '0', '0', '0', '0'), ('6600', '-10', '0', '0', '0', '0'), ('6600', '-9', '0', '0', '0', '0'), ('6600', '-8', '0', '0', '0', '0'), ('6600', '-7', '0', '0', '0', '0'), ('6600', '-6', '0', '0', '0', '0'), ('6600', '-5', '0', '0', '0', '0'), ('6600', '-4', '0', '0', '0', '0'), ('6600', '-3', '0', '0', '0', '0'), ('6600', '-2', '0', '0', '0', '0'), ('6600', '-1', '0', '0', '0', '0'), ('6600', '0', '0', '0', '0', '0'), ('6600', '1', '0', '0', '0', '0'), ('6600', '2', '0', '0', '0', '0'), ('6600', '3', '0', '0', '0', '0'), ('6600', '4', '0', '0', '0', '0'), ('6600', '5', '0', '0', '0', '0'), ('6600', '6', '0', '0', '0', '0'), ('6600', '7', '0', '0', '0', '0'), ('6600', '8', '0', '0', '0', '0'), ('6600', '9', '0', '0', '0', '0'), ('6600', '10', '0', '0', '0', '0'), ('6600', '11', '0', '0', '0', '0'), ('6600', '12', '0', '0', '0', '0'), ('6600', '13', '0', '0', '0', '0'), ('6600', '14', '0', '0', '0', '0'), ('6600', '15', '0', '0', '0', '0'), ('6600', '16', '0', '0', '0', '0'), ('6600', '17', '0', '0', '0', '0'), ('6600', '18', '0', '0', '0', '0'), ('6600', '19', '0', '0', '0', '0'), ('6600', '20', '0', '0', '0', '0'), ('6600', '21', '0', '0', '0', '0'), ('6600', '22', '0', '0', '0', '0'), ('6600', '23', '0', '0', '0', '0'), ('6600', '24', '0', '0', '0', '0'), ('6600', '25', '0', '0', '0', '0'), ('6600', '26', '0', '0', '0', '0'), ('6600', '27', '0', '0', '0', '0'), ('6600', '28', '0', '0', '0', '0'), ('6600', '29', '0', '0', '0', '0'), ('6600', '30', '0', '0', '0', '0'), ('6600', '31', '0', '0', '0', '0'), ('6600', '32', '0', '0', '0', '0'), ('6600', '33', '0', '0', '0', '0'), ('6600', '34', '0', '0', '0', '0'), ('6600', '35', '0', '0', '0', '0'), ('6600', '36', '0', '0', '0', '0'), ('6600', '37', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('6700', '-11', '0', '0', '0', '0'), ('6700', '-10', '0', '0', '0', '0'), ('6700', '-9', '0', '0', '0', '0'), ('6700', '-8', '0', '0', '0', '0'), ('6700', '-7', '0', '0', '0', '0'), ('6700', '-6', '0', '0', '0', '0'), ('6700', '-5', '0', '0', '0', '0'), ('6700', '-4', '0', '0', '0', '0'), ('6700', '-3', '0', '0', '0', '0'), ('6700', '-2', '0', '0', '0', '0'), ('6700', '-1', '0', '0', '0', '0'), ('6700', '0', '0', '0', '0', '0'), ('6700', '1', '0', '0', '0', '0'), ('6700', '2', '0', '0', '0', '0'), ('6700', '3', '0', '0', '0', '0'), ('6700', '4', '0', '0', '0', '0'), ('6700', '5', '0', '0', '0', '0'), ('6700', '6', '0', '0', '0', '0'), ('6700', '7', '0', '0', '0', '0'), ('6700', '8', '0', '0', '0', '0'), ('6700', '9', '0', '0', '0', '0'), ('6700', '10', '0', '0', '0', '0'), ('6700', '11', '0', '0', '0', '0'), ('6700', '12', '0', '0', '0', '0'), ('6700', '13', '0', '0', '0', '0'), ('6700', '14', '0', '0', '0', '0'), ('6700', '15', '0', '0', '0', '0'), ('6700', '16', '0', '0', '0', '0'), ('6700', '17', '0', '0', '0', '0'), ('6700', '18', '0', '0', '0', '0'), ('6700', '19', '0', '0', '0', '0'), ('6700', '20', '0', '0', '0', '0'), ('6700', '21', '0', '0', '0', '0'), ('6700', '22', '0', '0', '0', '0'), ('6700', '23', '0', '0', '0', '0'), ('6700', '24', '0', '0', '0', '0'), ('6700', '25', '0', '0', '0', '0'), ('6700', '26', '0', '0', '0', '0'), ('6700', '27', '0', '0', '0', '0'), ('6700', '28', '0', '0', '0', '0'), ('6700', '29', '0', '0', '0', '0'), ('6700', '30', '0', '0', '0', '0'), ('6700', '31', '0', '0', '0', '0'), ('6700', '32', '0', '0', '0', '0'), ('6700', '33', '0', '0', '0', '0'), ('6700', '34', '0', '0', '0', '0'), ('6700', '35', '0', '0', '0', '0'), ('6700', '36', '0', '0', '0', '0'), ('6700', '37', '0', '0', '0', '0'), ('6800', '-11', '0', '0', '0', '0'), ('6800', '-10', '0', '0', '0', '0'), ('6800', '-9', '0', '0', '0', '0'), ('6800', '-8', '0', '0', '0', '0'), ('6800', '-7', '0', '0', '0', '0'), ('6800', '-6', '0', '0', '0', '0'), ('6800', '-5', '0', '0', '0', '0'), ('6800', '-4', '0', '0', '0', '0'), ('6800', '-3', '0', '0', '0', '0'), ('6800', '-2', '0', '0', '0', '0'), ('6800', '-1', '0', '0', '0', '0'), ('6800', '0', '0', '0', '0', '0'), ('6800', '1', '0', '0', '0', '0'), ('6800', '2', '0', '0', '0', '0'), ('6800', '3', '0', '0', '0', '0'), ('6800', '4', '0', '0', '0', '0'), ('6800', '5', '0', '0', '0', '0'), ('6800', '6', '0', '0', '0', '0'), ('6800', '7', '0', '0', '0', '0'), ('6800', '8', '0', '0', '0', '0'), ('6800', '9', '0', '0', '0', '0'), ('6800', '10', '0', '0', '0', '0'), ('6800', '11', '0', '0', '0', '0'), ('6800', '12', '0', '0', '0', '0'), ('6800', '13', '0', '0', '0', '0'), ('6800', '14', '0', '0', '0', '0'), ('6800', '15', '0', '0', '0', '0'), ('6800', '16', '0', '0', '0', '0'), ('6800', '17', '0', '0', '0', '0'), ('6800', '18', '0', '0', '0', '0'), ('6800', '19', '0', '0', '0', '0'), ('6800', '20', '0', '0', '0', '0'), ('6800', '21', '0', '0', '0', '0'), ('6800', '22', '0', '0', '0', '0'), ('6800', '23', '0', '0', '0', '0'), ('6800', '24', '0', '0', '0', '0'), ('6800', '25', '0', '0', '0', '0'), ('6800', '26', '0', '0', '0', '0'), ('6800', '27', '0', '0', '0', '0'), ('6800', '28', '0', '0', '0', '0'), ('6800', '29', '0', '0', '0', '0'), ('6800', '30', '0', '0', '0', '0'), ('6800', '31', '0', '0', '0', '0'), ('6800', '32', '0', '0', '0', '0'), ('6800', '33', '0', '0', '0', '0'), ('6800', '34', '0', '0', '0', '0'), ('6800', '35', '0', '0', '0', '0'), ('6800', '36', '0', '0', '0', '0'), ('6800', '37', '0', '0', '0', '0'), ('6900', '-11', '0', '0', '0', '0'), ('6900', '-10', '0', '0', '0', '0'), ('6900', '-9', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('6900', '-8', '0', '0', '0', '0'), ('6900', '-7', '0', '0', '0', '0'), ('6900', '-6', '0', '0', '0', '0'), ('6900', '-5', '0', '0', '0', '0'), ('6900', '-4', '0', '0', '0', '0'), ('6900', '-3', '0', '0', '0', '0'), ('6900', '-2', '0', '0', '0', '0'), ('6900', '-1', '0', '0', '0', '0'), ('6900', '0', '0', '0', '0', '0'), ('6900', '1', '0', '0', '0', '0'), ('6900', '2', '0', '0', '0', '0'), ('6900', '3', '0', '0', '0', '0'), ('6900', '4', '0', '0', '0', '0'), ('6900', '5', '0', '0', '0', '0'), ('6900', '6', '0', '0', '0', '0'), ('6900', '7', '0', '0', '0', '0'), ('6900', '8', '0', '0', '0', '0'), ('6900', '9', '0', '0', '0', '0'), ('6900', '10', '0', '0', '0', '0'), ('6900', '11', '0', '0', '0', '0'), ('6900', '12', '0', '0', '0', '0'), ('6900', '13', '0', '0', '0', '0'), ('6900', '14', '0', '0', '0', '0'), ('6900', '15', '0', '0', '0', '0'), ('6900', '16', '0', '0', '0', '0'), ('6900', '17', '0', '0', '0', '0'), ('6900', '18', '0', '0', '0', '0'), ('6900', '19', '0', '0', '0', '0'), ('6900', '20', '0', '0', '0', '0'), ('6900', '21', '0', '0', '0', '0'), ('6900', '22', '0', '0', '0', '0'), ('6900', '23', '0', '0', '0', '0'), ('6900', '24', '0', '0', '0', '0'), ('6900', '25', '0', '0', '0', '0'), ('6900', '26', '0', '0', '0', '0'), ('6900', '27', '0', '0', '0', '0'), ('6900', '28', '0', '0', '0', '0'), ('6900', '29', '0', '0', '0', '0'), ('6900', '30', '0', '0', '0', '0'), ('6900', '31', '0', '0', '0', '0'), ('6900', '32', '0', '0', '0', '0'), ('6900', '33', '0', '0', '0', '0'), ('6900', '34', '0', '0', '0', '0'), ('6900', '35', '0', '0', '0', '0'), ('6900', '36', '0', '0', '0', '0'), ('6900', '37', '0', '0', '0', '0'), ('7020', '-11', '0', '0', '0', '0'), ('7020', '-10', '0', '0', '0', '0'), ('7020', '-9', '0', '0', '0', '0'), ('7020', '-8', '0', '0', '0', '0'), ('7020', '-7', '0', '0', '0', '0'), ('7020', '-6', '0', '0', '0', '0'), ('7020', '-5', '0', '0', '0', '0'), ('7020', '-4', '0', '0', '0', '0'), ('7020', '-3', '0', '0', '0', '0'), ('7020', '-2', '0', '0', '0', '0'), ('7020', '-1', '0', '0', '0', '0'), ('7020', '0', '0', '0', '0', '0'), ('7020', '1', '0', '0', '0', '0'), ('7020', '2', '0', '0', '0', '0'), ('7020', '3', '0', '0', '0', '0'), ('7020', '4', '0', '0', '0', '0'), ('7020', '5', '0', '0', '0', '0'), ('7020', '6', '0', '0', '0', '0'), ('7020', '7', '0', '0', '0', '0'), ('7020', '8', '0', '0', '0', '0'), ('7020', '9', '0', '0', '0', '0'), ('7020', '10', '0', '0', '0', '0'), ('7020', '11', '0', '0', '0', '0'), ('7020', '12', '0', '0', '0', '0'), ('7020', '13', '0', '0', '0', '0'), ('7020', '14', '0', '0', '0', '0'), ('7020', '15', '0', '0', '0', '0'), ('7020', '16', '0', '0', '0', '0'), ('7020', '17', '0', '0', '0', '0'), ('7020', '18', '0', '0', '0', '0'), ('7020', '19', '0', '0', '0', '0'), ('7020', '20', '0', '0', '0', '0'), ('7020', '21', '0', '0', '0', '0'), ('7020', '22', '0', '0', '0', '0'), ('7020', '23', '0', '0', '0', '0'), ('7020', '24', '0', '0', '0', '0'), ('7020', '25', '0', '0', '0', '0'), ('7020', '26', '0', '0', '0', '0'), ('7020', '27', '0', '0', '0', '0'), ('7020', '28', '0', '0', '0', '0'), ('7020', '29', '0', '0', '0', '0'), ('7020', '30', '0', '0', '0', '0'), ('7020', '31', '0', '0', '0', '0'), ('7020', '32', '0', '0', '0', '0'), ('7020', '33', '0', '0', '0', '0'), ('7020', '34', '0', '0', '0', '0'), ('7020', '35', '0', '0', '0', '0'), ('7020', '36', '0', '0', '0', '0'), ('7020', '37', '0', '0', '0', '0'), ('7030', '-11', '0', '0', '0', '0'), ('7030', '-10', '0', '0', '0', '0'), ('7030', '-9', '0', '0', '0', '0'), ('7030', '-8', '0', '0', '0', '0'), ('7030', '-7', '0', '0', '0', '0'), ('7030', '-6', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7030', '-5', '0', '0', '0', '0'), ('7030', '-4', '0', '0', '0', '0'), ('7030', '-3', '0', '0', '0', '0'), ('7030', '-2', '0', '0', '0', '0'), ('7030', '-1', '0', '0', '0', '0'), ('7030', '0', '0', '0', '0', '0'), ('7030', '1', '0', '0', '0', '0'), ('7030', '2', '0', '0', '0', '0'), ('7030', '3', '0', '0', '0', '0'), ('7030', '4', '0', '0', '0', '0'), ('7030', '5', '0', '0', '0', '0'), ('7030', '6', '0', '0', '0', '0'), ('7030', '7', '0', '0', '0', '0'), ('7030', '8', '0', '0', '0', '0'), ('7030', '9', '0', '0', '0', '0'), ('7030', '10', '0', '0', '0', '0'), ('7030', '11', '0', '0', '0', '0'), ('7030', '12', '0', '0', '0', '0'), ('7030', '13', '0', '0', '0', '0'), ('7030', '14', '0', '0', '0', '0'), ('7030', '15', '0', '0', '0', '0'), ('7030', '16', '0', '0', '0', '0'), ('7030', '17', '0', '0', '0', '0'), ('7030', '18', '0', '0', '0', '0'), ('7030', '19', '0', '0', '0', '0'), ('7030', '20', '0', '0', '0', '0'), ('7030', '21', '0', '0', '0', '0'), ('7030', '22', '0', '0', '0', '0'), ('7030', '23', '0', '0', '0', '0'), ('7030', '24', '0', '0', '0', '0'), ('7030', '25', '0', '0', '0', '0'), ('7030', '26', '0', '0', '0', '0'), ('7030', '27', '0', '0', '0', '0'), ('7030', '28', '0', '0', '0', '0'), ('7030', '29', '0', '0', '0', '0'), ('7030', '30', '0', '0', '0', '0'), ('7030', '31', '0', '0', '0', '0'), ('7030', '32', '0', '0', '0', '0'), ('7030', '33', '0', '0', '0', '0'), ('7030', '34', '0', '0', '0', '0'), ('7030', '35', '0', '0', '0', '0'), ('7030', '36', '0', '0', '0', '0'), ('7030', '37', '0', '0', '0', '0'), ('7040', '-11', '0', '0', '0', '0'), ('7040', '-10', '0', '0', '0', '0'), ('7040', '-9', '0', '0', '0', '0'), ('7040', '-8', '0', '0', '0', '0'), ('7040', '-7', '0', '0', '0', '0'), ('7040', '-6', '0', '0', '0', '0'), ('7040', '-5', '0', '0', '0', '0'), ('7040', '-4', '0', '0', '0', '0'), ('7040', '-3', '0', '0', '0', '0'), ('7040', '-2', '0', '0', '0', '0'), ('7040', '-1', '0', '0', '0', '0'), ('7040', '0', '0', '0', '0', '0'), ('7040', '1', '0', '0', '0', '0'), ('7040', '2', '0', '0', '0', '0'), ('7040', '3', '0', '0', '0', '0'), ('7040', '4', '0', '0', '0', '0'), ('7040', '5', '0', '0', '0', '0'), ('7040', '6', '0', '0', '0', '0'), ('7040', '7', '0', '0', '0', '0'), ('7040', '8', '0', '0', '0', '0'), ('7040', '9', '0', '0', '0', '0'), ('7040', '10', '0', '0', '0', '0'), ('7040', '11', '0', '0', '0', '0'), ('7040', '12', '0', '0', '0', '0'), ('7040', '13', '0', '0', '0', '0'), ('7040', '14', '0', '0', '0', '0'), ('7040', '15', '0', '0', '0', '0'), ('7040', '16', '0', '0', '0', '0'), ('7040', '17', '0', '0', '0', '0'), ('7040', '18', '0', '0', '0', '0'), ('7040', '19', '0', '0', '0', '0'), ('7040', '20', '0', '0', '0', '0'), ('7040', '21', '0', '0', '0', '0'), ('7040', '22', '0', '0', '0', '0'), ('7040', '23', '0', '0', '0', '0'), ('7040', '24', '0', '0', '0', '0'), ('7040', '25', '0', '0', '0', '0'), ('7040', '26', '0', '0', '0', '0'), ('7040', '27', '0', '0', '0', '0'), ('7040', '28', '0', '0', '0', '0'), ('7040', '29', '0', '0', '0', '0'), ('7040', '30', '0', '0', '0', '0'), ('7040', '31', '0', '0', '0', '0'), ('7040', '32', '0', '0', '0', '0'), ('7040', '33', '0', '0', '0', '0'), ('7040', '34', '0', '0', '0', '0'), ('7040', '35', '0', '0', '0', '0'), ('7040', '36', '0', '0', '0', '0'), ('7040', '37', '0', '0', '0', '0'), ('7050', '-11', '0', '0', '0', '0'), ('7050', '-10', '0', '0', '0', '0'), ('7050', '-9', '0', '0', '0', '0'), ('7050', '-8', '0', '0', '0', '0'), ('7050', '-7', '0', '0', '0', '0'), ('7050', '-6', '0', '0', '0', '0'), ('7050', '-5', '0', '0', '0', '0'), ('7050', '-4', '0', '0', '0', '0'), ('7050', '-3', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7050', '-2', '0', '0', '0', '0'), ('7050', '-1', '0', '0', '0', '0'), ('7050', '0', '0', '0', '0', '0'), ('7050', '1', '0', '0', '0', '0'), ('7050', '2', '0', '0', '0', '0'), ('7050', '3', '0', '0', '0', '0'), ('7050', '4', '0', '0', '0', '0'), ('7050', '5', '0', '0', '0', '0'), ('7050', '6', '0', '0', '0', '0'), ('7050', '7', '0', '0', '0', '0'), ('7050', '8', '0', '0', '0', '0'), ('7050', '9', '0', '0', '0', '0'), ('7050', '10', '0', '0', '0', '0'), ('7050', '11', '0', '0', '0', '0'), ('7050', '12', '0', '0', '0', '0'), ('7050', '13', '0', '0', '0', '0'), ('7050', '14', '0', '0', '0', '0'), ('7050', '15', '0', '0', '0', '0'), ('7050', '16', '0', '0', '0', '0'), ('7050', '17', '0', '0', '0', '0'), ('7050', '18', '0', '0', '0', '0'), ('7050', '19', '0', '0', '0', '0'), ('7050', '20', '0', '0', '0', '0'), ('7050', '21', '0', '0', '0', '0'), ('7050', '22', '0', '0', '0', '0'), ('7050', '23', '0', '0', '0', '0'), ('7050', '24', '0', '0', '0', '0'), ('7050', '25', '0', '0', '0', '0'), ('7050', '26', '0', '0', '0', '0'), ('7050', '27', '0', '0', '0', '0'), ('7050', '28', '0', '0', '0', '0'), ('7050', '29', '0', '0', '0', '0'), ('7050', '30', '0', '0', '0', '0'), ('7050', '31', '0', '0', '0', '0'), ('7050', '32', '0', '0', '0', '0'), ('7050', '33', '0', '0', '0', '0'), ('7050', '34', '0', '0', '0', '0'), ('7050', '35', '0', '0', '0', '0'), ('7050', '36', '0', '0', '0', '0'), ('7050', '37', '0', '0', '0', '0'), ('7060', '-11', '0', '0', '0', '0'), ('7060', '-10', '0', '0', '0', '0'), ('7060', '-9', '0', '0', '0', '0'), ('7060', '-8', '0', '0', '0', '0'), ('7060', '-7', '0', '0', '0', '0'), ('7060', '-6', '0', '0', '0', '0'), ('7060', '-5', '0', '0', '0', '0'), ('7060', '-4', '0', '0', '0', '0'), ('7060', '-3', '0', '0', '0', '0'), ('7060', '-2', '0', '0', '0', '0'), ('7060', '-1', '0', '0', '0', '0'), ('7060', '0', '0', '0', '0', '0'), ('7060', '1', '0', '0', '0', '0'), ('7060', '2', '0', '0', '0', '0'), ('7060', '3', '0', '0', '0', '0'), ('7060', '4', '0', '0', '0', '0'), ('7060', '5', '0', '0', '0', '0'), ('7060', '6', '0', '0', '0', '0'), ('7060', '7', '0', '0', '0', '0'), ('7060', '8', '0', '0', '0', '0'), ('7060', '9', '0', '0', '0', '0'), ('7060', '10', '0', '0', '0', '0'), ('7060', '11', '0', '0', '0', '0'), ('7060', '12', '0', '0', '0', '0'), ('7060', '13', '0', '0', '0', '0'), ('7060', '14', '0', '0', '0', '0'), ('7060', '15', '0', '0', '0', '0'), ('7060', '16', '0', '0', '0', '0'), ('7060', '17', '0', '0', '0', '0'), ('7060', '18', '0', '0', '0', '0'), ('7060', '19', '0', '0', '0', '0'), ('7060', '20', '0', '0', '0', '0'), ('7060', '21', '0', '0', '0', '0'), ('7060', '22', '0', '0', '0', '0'), ('7060', '23', '0', '0', '0', '0'), ('7060', '24', '0', '0', '0', '0'), ('7060', '25', '0', '0', '0', '0'), ('7060', '26', '0', '0', '0', '0'), ('7060', '27', '0', '0', '0', '0'), ('7060', '28', '0', '0', '0', '0'), ('7060', '29', '0', '0', '0', '0'), ('7060', '30', '0', '0', '0', '0'), ('7060', '31', '0', '0', '0', '0'), ('7060', '32', '0', '0', '0', '0'), ('7060', '33', '0', '0', '0', '0'), ('7060', '34', '0', '0', '0', '0'), ('7060', '35', '0', '0', '0', '0'), ('7060', '36', '0', '0', '0', '0'), ('7060', '37', '0', '0', '0', '0'), ('7070', '-11', '0', '0', '0', '0'), ('7070', '-10', '0', '0', '0', '0'), ('7070', '-9', '0', '0', '0', '0'), ('7070', '-8', '0', '0', '0', '0'), ('7070', '-7', '0', '0', '0', '0'), ('7070', '-6', '0', '0', '0', '0'), ('7070', '-5', '0', '0', '0', '0'), ('7070', '-4', '0', '0', '0', '0'), ('7070', '-3', '0', '0', '0', '0'), ('7070', '-2', '0', '0', '0', '0'), ('7070', '-1', '0', '0', '0', '0'), ('7070', '0', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7070', '1', '0', '0', '0', '0'), ('7070', '2', '0', '0', '0', '0'), ('7070', '3', '0', '0', '0', '0'), ('7070', '4', '0', '0', '0', '0'), ('7070', '5', '0', '0', '0', '0'), ('7070', '6', '0', '0', '0', '0'), ('7070', '7', '0', '0', '0', '0'), ('7070', '8', '0', '0', '0', '0'), ('7070', '9', '0', '0', '0', '0'), ('7070', '10', '0', '0', '0', '0'), ('7070', '11', '0', '0', '0', '0'), ('7070', '12', '0', '0', '0', '0'), ('7070', '13', '0', '0', '0', '0'), ('7070', '14', '0', '0', '0', '0'), ('7070', '15', '0', '0', '0', '0'), ('7070', '16', '0', '0', '0', '0'), ('7070', '17', '0', '0', '0', '0'), ('7070', '18', '0', '0', '0', '0'), ('7070', '19', '0', '0', '0', '0'), ('7070', '20', '0', '0', '0', '0'), ('7070', '21', '0', '0', '0', '0'), ('7070', '22', '0', '0', '0', '0'), ('7070', '23', '0', '0', '0', '0'), ('7070', '24', '0', '0', '0', '0'), ('7070', '25', '0', '0', '0', '0'), ('7070', '26', '0', '0', '0', '0'), ('7070', '27', '0', '0', '0', '0'), ('7070', '28', '0', '0', '0', '0'), ('7070', '29', '0', '0', '0', '0'), ('7070', '30', '0', '0', '0', '0'), ('7070', '31', '0', '0', '0', '0'), ('7070', '32', '0', '0', '0', '0'), ('7070', '33', '0', '0', '0', '0'), ('7070', '34', '0', '0', '0', '0'), ('7070', '35', '0', '0', '0', '0'), ('7070', '36', '0', '0', '0', '0'), ('7070', '37', '0', '0', '0', '0'), ('7080', '-11', '0', '0', '0', '0'), ('7080', '-10', '0', '0', '0', '0'), ('7080', '-9', '0', '0', '0', '0'), ('7080', '-8', '0', '0', '0', '0'), ('7080', '-7', '0', '0', '0', '0'), ('7080', '-6', '0', '0', '0', '0'), ('7080', '-5', '0', '0', '0', '0'), ('7080', '-4', '0', '0', '0', '0'), ('7080', '-3', '0', '0', '0', '0'), ('7080', '-2', '0', '0', '0', '0'), ('7080', '-1', '0', '0', '0', '0'), ('7080', '0', '0', '0', '0', '0'), ('7080', '1', '0', '0', '0', '0'), ('7080', '2', '0', '0', '0', '0'), ('7080', '3', '0', '0', '0', '0'), ('7080', '4', '0', '0', '0', '0'), ('7080', '5', '0', '0', '0', '0'), ('7080', '6', '0', '0', '0', '0'), ('7080', '7', '0', '0', '0', '0'), ('7080', '8', '0', '0', '0', '0'), ('7080', '9', '0', '0', '0', '0'), ('7080', '10', '0', '0', '0', '0'), ('7080', '11', '0', '0', '0', '0'), ('7080', '12', '0', '0', '0', '0'), ('7080', '13', '0', '0', '0', '0'), ('7080', '14', '0', '0', '0', '0'), ('7080', '15', '0', '0', '0', '0'), ('7080', '16', '0', '0', '0', '0'), ('7080', '17', '0', '0', '0', '0'), ('7080', '18', '0', '0', '0', '0'), ('7080', '19', '0', '0', '0', '0'), ('7080', '20', '0', '0', '0', '0'), ('7080', '21', '0', '0', '0', '0'), ('7080', '22', '0', '0', '0', '0'), ('7080', '23', '0', '0', '0', '0'), ('7080', '24', '0', '0', '0', '0'), ('7080', '25', '0', '0', '0', '0'), ('7080', '26', '0', '0', '0', '0'), ('7080', '27', '0', '0', '0', '0'), ('7080', '28', '0', '0', '0', '0'), ('7080', '29', '0', '0', '0', '0'), ('7080', '30', '0', '0', '0', '0'), ('7080', '31', '0', '0', '0', '0'), ('7080', '32', '0', '0', '0', '0'), ('7080', '33', '0', '0', '0', '0'), ('7080', '34', '0', '0', '0', '0'), ('7080', '35', '0', '0', '0', '0'), ('7080', '36', '0', '0', '0', '0'), ('7080', '37', '0', '0', '0', '0'), ('7090', '-11', '0', '0', '0', '0'), ('7090', '-10', '0', '0', '0', '0'), ('7090', '-9', '0', '0', '0', '0'), ('7090', '-8', '0', '0', '0', '0'), ('7090', '-7', '0', '0', '0', '0'), ('7090', '-6', '0', '0', '0', '0'), ('7090', '-5', '0', '0', '0', '0'), ('7090', '-4', '0', '0', '0', '0'), ('7090', '-3', '0', '0', '0', '0'), ('7090', '-2', '0', '0', '0', '0'), ('7090', '-1', '0', '0', '0', '0'), ('7090', '0', '0', '0', '0', '0'), ('7090', '1', '0', '0', '0', '0'), ('7090', '2', '0', '0', '0', '0'), ('7090', '3', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7090', '4', '0', '0', '0', '0'), ('7090', '5', '0', '0', '0', '0'), ('7090', '6', '0', '0', '0', '0'), ('7090', '7', '0', '0', '0', '0'), ('7090', '8', '0', '0', '0', '0'), ('7090', '9', '0', '0', '0', '0'), ('7090', '10', '0', '0', '0', '0'), ('7090', '11', '0', '0', '0', '0'), ('7090', '12', '0', '0', '0', '0'), ('7090', '13', '0', '0', '0', '0'), ('7090', '14', '0', '0', '0', '0'), ('7090', '15', '0', '0', '0', '0'), ('7090', '16', '0', '0', '0', '0'), ('7090', '17', '0', '0', '0', '0'), ('7090', '18', '0', '0', '0', '0'), ('7090', '19', '0', '0', '0', '0'), ('7090', '20', '0', '0', '0', '0'), ('7090', '21', '0', '0', '0', '0'), ('7090', '22', '0', '0', '0', '0'), ('7090', '23', '0', '0', '0', '0'), ('7090', '24', '0', '0', '0', '0'), ('7090', '25', '0', '0', '0', '0'), ('7090', '26', '0', '0', '0', '0'), ('7090', '27', '0', '0', '0', '0'), ('7090', '28', '0', '0', '0', '0'), ('7090', '29', '0', '0', '0', '0'), ('7090', '30', '0', '0', '0', '0'), ('7090', '31', '0', '0', '0', '0'), ('7090', '32', '0', '0', '0', '0'), ('7090', '33', '0', '0', '0', '0'), ('7090', '34', '0', '0', '0', '0'), ('7090', '35', '0', '0', '0', '0'), ('7090', '36', '0', '0', '0', '0'), ('7090', '37', '0', '0', '0', '0'), ('7100', '-11', '0', '0', '0', '0'), ('7100', '-10', '0', '0', '0', '0'), ('7100', '-9', '0', '0', '0', '0'), ('7100', '-8', '0', '0', '0', '0'), ('7100', '-7', '0', '0', '0', '0'), ('7100', '-6', '0', '0', '0', '0'), ('7100', '-5', '0', '0', '0', '0'), ('7100', '-4', '0', '0', '0', '0'), ('7100', '-3', '0', '0', '0', '0'), ('7100', '-2', '0', '0', '0', '0'), ('7100', '-1', '0', '0', '0', '0'), ('7100', '0', '0', '0', '0', '0'), ('7100', '1', '0', '0', '0', '0'), ('7100', '2', '0', '0', '0', '0'), ('7100', '3', '0', '0', '0', '0'), ('7100', '4', '0', '0', '0', '0'), ('7100', '5', '0', '0', '0', '0'), ('7100', '6', '0', '0', '0', '0'), ('7100', '7', '0', '0', '0', '0'), ('7100', '8', '0', '0', '0', '0'), ('7100', '9', '0', '0', '0', '0'), ('7100', '10', '0', '0', '0', '0'), ('7100', '11', '0', '0', '0', '0'), ('7100', '12', '0', '0', '0', '0'), ('7100', '13', '0', '0', '0', '0'), ('7100', '14', '0', '0', '0', '0'), ('7100', '15', '0', '0', '0', '0'), ('7100', '16', '0', '0', '0', '0'), ('7100', '17', '0', '0', '0', '0'), ('7100', '18', '0', '0', '0', '0'), ('7100', '19', '0', '0', '0', '0'), ('7100', '20', '0', '0', '0', '0'), ('7100', '21', '0', '0', '0', '0'), ('7100', '22', '0', '0', '0', '0'), ('7100', '23', '0', '0', '0', '0'), ('7100', '24', '0', '0', '0', '0'), ('7100', '25', '0', '0', '0', '0'), ('7100', '26', '0', '0', '0', '0'), ('7100', '27', '0', '0', '0', '0'), ('7100', '28', '0', '0', '0', '0'), ('7100', '29', '0', '0', '0', '0'), ('7100', '30', '0', '0', '0', '0'), ('7100', '31', '0', '0', '0', '0'), ('7100', '32', '0', '0', '0', '0'), ('7100', '33', '0', '0', '0', '0'), ('7100', '34', '0', '0', '0', '0'), ('7100', '35', '0', '0', '0', '0'), ('7100', '36', '0', '0', '0', '0'), ('7100', '37', '0', '0', '0', '0'), ('7150', '-11', '0', '0', '0', '0'), ('7150', '-10', '0', '0', '0', '0'), ('7150', '-9', '0', '0', '0', '0'), ('7150', '-8', '0', '0', '0', '0'), ('7150', '-7', '0', '0', '0', '0'), ('7150', '-6', '0', '0', '0', '0'), ('7150', '-5', '0', '0', '0', '0'), ('7150', '-4', '0', '0', '0', '0'), ('7150', '-3', '0', '0', '0', '0'), ('7150', '-2', '0', '0', '0', '0'), ('7150', '-1', '0', '0', '0', '0'), ('7150', '0', '0', '0', '0', '0'), ('7150', '1', '0', '0', '0', '0'), ('7150', '2', '0', '0', '0', '0'), ('7150', '3', '0', '0', '0', '0'), ('7150', '4', '0', '0', '0', '0'), ('7150', '5', '0', '0', '0', '0'), ('7150', '6', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7150', '7', '0', '0', '0', '0'), ('7150', '8', '0', '0', '0', '0'), ('7150', '9', '0', '0', '0', '0'), ('7150', '10', '0', '0', '0', '0'), ('7150', '11', '0', '0', '0', '0'), ('7150', '12', '0', '0', '0', '0'), ('7150', '13', '0', '0', '0', '0'), ('7150', '14', '0', '0', '0', '0'), ('7150', '15', '0', '0', '0', '0'), ('7150', '16', '0', '0', '0', '0'), ('7150', '17', '0', '0', '0', '0'), ('7150', '18', '0', '0', '0', '0'), ('7150', '19', '0', '0', '0', '0'), ('7150', '20', '0', '0', '0', '0'), ('7150', '21', '0', '0', '0', '0'), ('7150', '22', '0', '0', '0', '0'), ('7150', '23', '0', '0', '0', '0'), ('7150', '24', '0', '0', '0', '0'), ('7150', '25', '0', '0', '0', '0'), ('7150', '26', '0', '0', '0', '0'), ('7150', '27', '0', '0', '0', '0'), ('7150', '28', '0', '0', '0', '0'), ('7150', '29', '0', '0', '0', '0'), ('7150', '30', '0', '0', '0', '0'), ('7150', '31', '0', '0', '0', '0'), ('7150', '32', '0', '0', '0', '0'), ('7150', '33', '0', '0', '0', '0'), ('7150', '34', '0', '0', '0', '0'), ('7150', '35', '0', '0', '0', '0'), ('7150', '36', '0', '0', '0', '0'), ('7150', '37', '0', '0', '0', '0'), ('7200', '-11', '0', '0', '0', '0'), ('7200', '-10', '0', '0', '0', '0'), ('7200', '-9', '0', '0', '0', '0'), ('7200', '-8', '0', '0', '0', '0'), ('7200', '-7', '0', '0', '0', '0'), ('7200', '-6', '0', '0', '0', '0'), ('7200', '-5', '0', '0', '0', '0'), ('7200', '-4', '0', '0', '0', '0'), ('7200', '-3', '0', '0', '0', '0'), ('7200', '-2', '0', '0', '0', '0'), ('7200', '-1', '0', '0', '0', '0'), ('7200', '0', '0', '0', '0', '0'), ('7200', '1', '0', '0', '0', '0'), ('7200', '2', '0', '0', '0', '0'), ('7200', '3', '0', '0', '0', '0'), ('7200', '4', '0', '0', '0', '0'), ('7200', '5', '0', '0', '0', '0'), ('7200', '6', '0', '0', '0', '0'), ('7200', '7', '0', '0', '0', '0'), ('7200', '8', '0', '0', '0', '0'), ('7200', '9', '0', '0', '0', '0'), ('7200', '10', '0', '0', '0', '0'), ('7200', '11', '0', '0', '0', '0'), ('7200', '12', '0', '0', '0', '0'), ('7200', '13', '0', '0', '0', '0'), ('7200', '14', '0', '0', '0', '0'), ('7200', '15', '0', '0', '0', '0'), ('7200', '16', '0', '0', '0', '0'), ('7200', '17', '0', '0', '0', '0'), ('7200', '18', '0', '0', '0', '0'), ('7200', '19', '0', '0', '0', '0'), ('7200', '20', '0', '0', '0', '0'), ('7200', '21', '0', '0', '0', '0'), ('7200', '22', '0', '0', '0', '0'), ('7200', '23', '0', '0', '0', '0'), ('7200', '24', '0', '0', '0', '0'), ('7200', '25', '0', '0', '0', '0'), ('7200', '26', '0', '0', '0', '0'), ('7200', '27', '0', '0', '0', '0'), ('7200', '28', '0', '0', '0', '0'), ('7200', '29', '0', '0', '0', '0'), ('7200', '30', '0', '0', '0', '0'), ('7200', '31', '0', '0', '0', '0'), ('7200', '32', '0', '0', '0', '0'), ('7200', '33', '0', '0', '0', '0'), ('7200', '34', '0', '0', '0', '0'), ('7200', '35', '0', '0', '0', '0'), ('7200', '36', '0', '0', '0', '0'), ('7200', '37', '0', '0', '0', '0'), ('7210', '-11', '0', '0', '0', '0'), ('7210', '-10', '0', '0', '0', '0'), ('7210', '-9', '0', '0', '0', '0'), ('7210', '-8', '0', '0', '0', '0'), ('7210', '-7', '0', '0', '0', '0'), ('7210', '-6', '0', '0', '0', '0'), ('7210', '-5', '0', '0', '0', '0'), ('7210', '-4', '0', '0', '0', '0'), ('7210', '-3', '0', '0', '0', '0'), ('7210', '-2', '0', '0', '0', '0'), ('7210', '-1', '0', '0', '0', '0'), ('7210', '0', '0', '0', '0', '0'), ('7210', '1', '0', '0', '0', '0'), ('7210', '2', '0', '0', '0', '0'), ('7210', '3', '0', '0', '0', '0'), ('7210', '4', '0', '0', '0', '0'), ('7210', '5', '0', '0', '0', '0'), ('7210', '6', '0', '0', '0', '0'), ('7210', '7', '0', '0', '0', '0'), ('7210', '8', '0', '0', '0', '0'), ('7210', '9', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7210', '10', '0', '0', '0', '0'), ('7210', '11', '0', '0', '0', '0'), ('7210', '12', '0', '0', '0', '0'), ('7210', '13', '0', '0', '0', '0'), ('7210', '14', '0', '0', '0', '0'), ('7210', '15', '0', '0', '0', '0'), ('7210', '16', '0', '0', '0', '0'), ('7210', '17', '0', '0', '0', '0'), ('7210', '18', '0', '0', '0', '0'), ('7210', '19', '0', '0', '0', '0'), ('7210', '20', '0', '0', '0', '0'), ('7210', '21', '0', '0', '0', '0'), ('7210', '22', '0', '0', '0', '0'), ('7210', '23', '0', '0', '0', '0'), ('7210', '24', '0', '0', '0', '0'), ('7210', '25', '0', '0', '0', '0'), ('7210', '26', '0', '0', '0', '0'), ('7210', '27', '0', '0', '0', '0'), ('7210', '28', '0', '0', '0', '0'), ('7210', '29', '0', '0', '0', '0'), ('7210', '30', '0', '0', '0', '0'), ('7210', '31', '0', '0', '0', '0'), ('7210', '32', '0', '0', '0', '0'), ('7210', '33', '0', '0', '0', '0'), ('7210', '34', '0', '0', '0', '0'), ('7210', '35', '0', '0', '0', '0'), ('7210', '36', '0', '0', '0', '0'), ('7210', '37', '0', '0', '0', '0'), ('7220', '-11', '0', '0', '0', '0'), ('7220', '-10', '0', '0', '0', '0'), ('7220', '-9', '0', '0', '0', '0'), ('7220', '-8', '0', '0', '0', '0'), ('7220', '-7', '0', '0', '0', '0'), ('7220', '-6', '0', '0', '0', '0'), ('7220', '-5', '0', '0', '0', '0'), ('7220', '-4', '0', '0', '0', '0'), ('7220', '-3', '0', '0', '0', '0'), ('7220', '-2', '0', '0', '0', '0'), ('7220', '-1', '0', '0', '0', '0'), ('7220', '0', '0', '0', '0', '0'), ('7220', '1', '0', '0', '0', '0'), ('7220', '2', '0', '0', '0', '0'), ('7220', '3', '0', '0', '0', '0'), ('7220', '4', '0', '0', '0', '0'), ('7220', '5', '0', '0', '0', '0'), ('7220', '6', '0', '0', '0', '0'), ('7220', '7', '0', '0', '0', '0'), ('7220', '8', '0', '0', '0', '0'), ('7220', '9', '0', '0', '0', '0'), ('7220', '10', '0', '0', '0', '0'), ('7220', '11', '0', '0', '0', '0'), ('7220', '12', '0', '0', '0', '0'), ('7220', '13', '0', '0', '0', '0'), ('7220', '14', '0', '0', '0', '0'), ('7220', '15', '0', '0', '0', '0'), ('7220', '16', '0', '0', '0', '0'), ('7220', '17', '0', '0', '0', '0'), ('7220', '18', '0', '0', '0', '0'), ('7220', '19', '0', '0', '0', '0'), ('7220', '20', '0', '0', '0', '0'), ('7220', '21', '0', '0', '0', '0'), ('7220', '22', '0', '0', '0', '0'), ('7220', '23', '0', '0', '0', '0'), ('7220', '24', '0', '0', '0', '0'), ('7220', '25', '0', '0', '0', '0'), ('7220', '26', '0', '0', '0', '0'), ('7220', '27', '0', '0', '0', '0'), ('7220', '28', '0', '0', '0', '0'), ('7220', '29', '0', '0', '0', '0'), ('7220', '30', '0', '0', '0', '0'), ('7220', '31', '0', '0', '0', '0'), ('7220', '32', '0', '0', '0', '0'), ('7220', '33', '0', '0', '0', '0'), ('7220', '34', '0', '0', '0', '0'), ('7220', '35', '0', '0', '0', '0'), ('7220', '36', '0', '0', '0', '0'), ('7220', '37', '0', '0', '0', '0'), ('7230', '-11', '0', '0', '0', '0'), ('7230', '-10', '0', '0', '0', '0'), ('7230', '-9', '0', '0', '0', '0'), ('7230', '-8', '0', '0', '0', '0'), ('7230', '-7', '0', '0', '0', '0'), ('7230', '-6', '0', '0', '0', '0'), ('7230', '-5', '0', '0', '0', '0'), ('7230', '-4', '0', '0', '0', '0'), ('7230', '-3', '0', '0', '0', '0'), ('7230', '-2', '0', '0', '0', '0'), ('7230', '-1', '0', '0', '0', '0'), ('7230', '0', '0', '0', '0', '0'), ('7230', '1', '0', '0', '0', '0'), ('7230', '2', '0', '0', '0', '0'), ('7230', '3', '0', '0', '0', '0'), ('7230', '4', '0', '0', '0', '0'), ('7230', '5', '0', '0', '0', '0'), ('7230', '6', '0', '0', '0', '0'), ('7230', '7', '0', '0', '0', '0'), ('7230', '8', '0', '0', '0', '0'), ('7230', '9', '0', '0', '0', '0'), ('7230', '10', '0', '0', '0', '0'), ('7230', '11', '0', '0', '0', '0'), ('7230', '12', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7230', '13', '0', '0', '0', '0'), ('7230', '14', '0', '0', '0', '0'), ('7230', '15', '0', '0', '0', '0'), ('7230', '16', '0', '0', '0', '0'), ('7230', '17', '0', '0', '0', '0'), ('7230', '18', '0', '0', '0', '0'), ('7230', '19', '0', '0', '0', '0'), ('7230', '20', '0', '0', '0', '0'), ('7230', '21', '0', '0', '0', '0'), ('7230', '22', '0', '0', '0', '0'), ('7230', '23', '0', '0', '0', '0'), ('7230', '24', '0', '0', '0', '0'), ('7230', '25', '0', '0', '0', '0'), ('7230', '26', '0', '0', '0', '0'), ('7230', '27', '0', '0', '0', '0'), ('7230', '28', '0', '0', '0', '0'), ('7230', '29', '0', '0', '0', '0'), ('7230', '30', '0', '0', '0', '0'), ('7230', '31', '0', '0', '0', '0'), ('7230', '32', '0', '0', '0', '0'), ('7230', '33', '0', '0', '0', '0'), ('7230', '34', '0', '0', '0', '0'), ('7230', '35', '0', '0', '0', '0'), ('7230', '36', '0', '0', '0', '0'), ('7230', '37', '0', '0', '0', '0'), ('7240', '-11', '0', '0', '0', '0'), ('7240', '-10', '0', '0', '0', '0'), ('7240', '-9', '0', '0', '0', '0'), ('7240', '-8', '0', '0', '0', '0'), ('7240', '-7', '0', '0', '0', '0'), ('7240', '-6', '0', '0', '0', '0'), ('7240', '-5', '0', '0', '0', '0'), ('7240', '-4', '0', '0', '0', '0'), ('7240', '-3', '0', '0', '0', '0'), ('7240', '-2', '0', '0', '0', '0'), ('7240', '-1', '0', '0', '0', '0'), ('7240', '0', '0', '0', '0', '0'), ('7240', '1', '0', '0', '0', '0'), ('7240', '2', '0', '0', '0', '0'), ('7240', '3', '0', '0', '0', '0'), ('7240', '4', '0', '0', '0', '0'), ('7240', '5', '0', '0', '0', '0'), ('7240', '6', '0', '0', '0', '0'), ('7240', '7', '0', '0', '0', '0'), ('7240', '8', '0', '0', '0', '0'), ('7240', '9', '0', '0', '0', '0'), ('7240', '10', '0', '0', '0', '0'), ('7240', '11', '0', '0', '0', '0'), ('7240', '12', '0', '0', '0', '0'), ('7240', '13', '0', '0', '0', '0'), ('7240', '14', '0', '0', '0', '0'), ('7240', '15', '0', '0', '0', '0'), ('7240', '16', '0', '0', '0', '0'), ('7240', '17', '0', '0', '0', '0'), ('7240', '18', '0', '0', '0', '0'), ('7240', '19', '0', '0', '0', '0'), ('7240', '20', '0', '0', '0', '0'), ('7240', '21', '0', '0', '0', '0'), ('7240', '22', '0', '0', '0', '0'), ('7240', '23', '0', '0', '0', '0'), ('7240', '24', '0', '0', '0', '0'), ('7240', '25', '0', '0', '0', '0'), ('7240', '26', '0', '0', '0', '0'), ('7240', '27', '0', '0', '0', '0'), ('7240', '28', '0', '0', '0', '0'), ('7240', '29', '0', '0', '0', '0'), ('7240', '30', '0', '0', '0', '0'), ('7240', '31', '0', '0', '0', '0'), ('7240', '32', '0', '0', '0', '0'), ('7240', '33', '0', '0', '0', '0'), ('7240', '34', '0', '0', '0', '0'), ('7240', '35', '0', '0', '0', '0'), ('7240', '36', '0', '0', '0', '0'), ('7240', '37', '0', '0', '0', '0'), ('7260', '-11', '0', '0', '0', '0'), ('7260', '-10', '0', '0', '0', '0'), ('7260', '-9', '0', '0', '0', '0'), ('7260', '-8', '0', '0', '0', '0'), ('7260', '-7', '0', '0', '0', '0'), ('7260', '-6', '0', '0', '0', '0'), ('7260', '-5', '0', '0', '0', '0'), ('7260', '-4', '0', '0', '0', '0'), ('7260', '-3', '0', '0', '0', '0'), ('7260', '-2', '0', '0', '0', '0'), ('7260', '-1', '0', '0', '0', '0'), ('7260', '0', '0', '0', '0', '0'), ('7260', '1', '0', '0', '0', '0'), ('7260', '2', '0', '0', '0', '0'), ('7260', '3', '0', '0', '0', '0'), ('7260', '4', '0', '0', '0', '0'), ('7260', '5', '0', '0', '0', '0'), ('7260', '6', '0', '0', '0', '0'), ('7260', '7', '0', '0', '0', '0'), ('7260', '8', '0', '0', '0', '0'), ('7260', '9', '0', '0', '0', '0'), ('7260', '10', '0', '0', '0', '0'), ('7260', '11', '0', '0', '0', '0'), ('7260', '12', '0', '0', '0', '0'), ('7260', '13', '0', '0', '0', '0'), ('7260', '14', '0', '0', '0', '0'), ('7260', '15', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7260', '16', '0', '0', '0', '0'), ('7260', '17', '0', '0', '0', '0'), ('7260', '18', '0', '0', '0', '0'), ('7260', '19', '0', '0', '0', '0'), ('7260', '20', '0', '0', '0', '0'), ('7260', '21', '0', '0', '0', '0'), ('7260', '22', '0', '0', '0', '0'), ('7260', '23', '0', '0', '0', '0'), ('7260', '24', '0', '0', '0', '0'), ('7260', '25', '0', '0', '0', '0'), ('7260', '26', '0', '0', '0', '0'), ('7260', '27', '0', '0', '0', '0'), ('7260', '28', '0', '0', '0', '0'), ('7260', '29', '0', '0', '0', '0'), ('7260', '30', '0', '0', '0', '0'), ('7260', '31', '0', '0', '0', '0'), ('7260', '32', '0', '0', '0', '0'), ('7260', '33', '0', '0', '0', '0'), ('7260', '34', '0', '0', '0', '0'), ('7260', '35', '0', '0', '0', '0'), ('7260', '36', '0', '0', '0', '0'), ('7260', '37', '0', '0', '0', '0'), ('7280', '-11', '0', '0', '0', '0'), ('7280', '-10', '0', '0', '0', '0'), ('7280', '-9', '0', '0', '0', '0'), ('7280', '-8', '0', '0', '0', '0'), ('7280', '-7', '0', '0', '0', '0'), ('7280', '-6', '0', '0', '0', '0'), ('7280', '-5', '0', '0', '0', '0'), ('7280', '-4', '0', '0', '0', '0'), ('7280', '-3', '0', '0', '0', '0'), ('7280', '-2', '0', '0', '0', '0'), ('7280', '-1', '0', '0', '0', '0'), ('7280', '0', '0', '0', '0', '0'), ('7280', '1', '0', '0', '0', '0'), ('7280', '2', '0', '0', '0', '0'), ('7280', '3', '0', '0', '0', '0'), ('7280', '4', '0', '0', '0', '0'), ('7280', '5', '0', '0', '0', '0'), ('7280', '6', '0', '0', '0', '0'), ('7280', '7', '0', '0', '0', '0'), ('7280', '8', '0', '0', '0', '0'), ('7280', '9', '0', '0', '0', '0'), ('7280', '10', '0', '0', '0', '0'), ('7280', '11', '0', '0', '0', '0'), ('7280', '12', '0', '0', '0', '0'), ('7280', '13', '0', '0', '0', '0'), ('7280', '14', '0', '0', '0', '0'), ('7280', '15', '0', '0', '0', '0'), ('7280', '16', '0', '0', '0', '0'), ('7280', '17', '0', '0', '0', '0'), ('7280', '18', '0', '0', '0', '0'), ('7280', '19', '0', '0', '0', '0'), ('7280', '20', '0', '0', '0', '0'), ('7280', '21', '0', '0', '0', '0'), ('7280', '22', '0', '0', '0', '0'), ('7280', '23', '0', '0', '0', '0'), ('7280', '24', '0', '0', '0', '0'), ('7280', '25', '0', '0', '0', '0'), ('7280', '26', '0', '0', '0', '0'), ('7280', '27', '0', '0', '0', '0'), ('7280', '28', '0', '0', '0', '0'), ('7280', '29', '0', '0', '0', '0'), ('7280', '30', '0', '0', '0', '0'), ('7280', '31', '0', '0', '0', '0'), ('7280', '32', '0', '0', '0', '0'), ('7280', '33', '0', '0', '0', '0'), ('7280', '34', '0', '0', '0', '0'), ('7280', '35', '0', '0', '0', '0'), ('7280', '36', '0', '0', '0', '0'), ('7280', '37', '0', '0', '0', '0'), ('7300', '-11', '0', '0', '0', '0'), ('7300', '-10', '0', '0', '0', '0'), ('7300', '-9', '0', '0', '0', '0'), ('7300', '-8', '0', '0', '0', '0'), ('7300', '-7', '0', '0', '0', '0'), ('7300', '-6', '0', '0', '0', '0'), ('7300', '-5', '0', '0', '0', '0'), ('7300', '-4', '0', '0', '0', '0'), ('7300', '-3', '0', '0', '0', '0'), ('7300', '-2', '0', '0', '0', '0'), ('7300', '-1', '0', '0', '0', '0'), ('7300', '0', '0', '0', '0', '0'), ('7300', '1', '0', '0', '0', '0'), ('7300', '2', '0', '0', '0', '0'), ('7300', '3', '0', '0', '0', '0'), ('7300', '4', '0', '0', '0', '0'), ('7300', '5', '0', '0', '0', '0'), ('7300', '6', '0', '0', '0', '0'), ('7300', '7', '0', '0', '0', '0'), ('7300', '8', '0', '0', '0', '0'), ('7300', '9', '0', '0', '0', '0'), ('7300', '10', '0', '0', '0', '0'), ('7300', '11', '0', '0', '0', '0'), ('7300', '12', '0', '0', '0', '0'), ('7300', '13', '0', '0', '0', '0'), ('7300', '14', '0', '0', '0', '0'), ('7300', '15', '0', '0', '0', '0'), ('7300', '16', '0', '0', '0', '0'), ('7300', '17', '0', '0', '0', '0'), ('7300', '18', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7300', '19', '0', '0', '0', '0'), ('7300', '20', '0', '0', '0', '0'), ('7300', '21', '0', '0', '0', '0'), ('7300', '22', '0', '0', '0', '0'), ('7300', '23', '0', '0', '0', '0'), ('7300', '24', '0', '0', '0', '0'), ('7300', '25', '0', '0', '0', '0'), ('7300', '26', '0', '0', '0', '0'), ('7300', '27', '0', '0', '0', '0'), ('7300', '28', '0', '0', '0', '0'), ('7300', '29', '0', '0', '0', '0'), ('7300', '30', '0', '0', '0', '0'), ('7300', '31', '0', '0', '0', '0'), ('7300', '32', '0', '0', '0', '0'), ('7300', '33', '0', '0', '0', '0'), ('7300', '34', '0', '0', '0', '0'), ('7300', '35', '0', '0', '0', '0'), ('7300', '36', '0', '0', '0', '0'), ('7300', '37', '0', '0', '0', '0'), ('7350', '-11', '0', '0', '0', '0'), ('7350', '-10', '0', '0', '0', '0'), ('7350', '-9', '0', '0', '0', '0'), ('7350', '-8', '0', '0', '0', '0'), ('7350', '-7', '0', '0', '0', '0'), ('7350', '-6', '0', '0', '0', '0'), ('7350', '-5', '0', '0', '0', '0'), ('7350', '-4', '0', '0', '0', '0'), ('7350', '-3', '0', '0', '0', '0'), ('7350', '-2', '0', '0', '0', '0'), ('7350', '-1', '0', '0', '0', '0'), ('7350', '0', '0', '0', '0', '0'), ('7350', '1', '0', '0', '0', '0'), ('7350', '2', '0', '0', '0', '0'), ('7350', '3', '0', '0', '0', '0'), ('7350', '4', '0', '0', '0', '0'), ('7350', '5', '0', '0', '0', '0'), ('7350', '6', '0', '0', '0', '0'), ('7350', '7', '0', '0', '0', '0'), ('7350', '8', '0', '0', '0', '0'), ('7350', '9', '0', '0', '0', '0'), ('7350', '10', '0', '0', '0', '0'), ('7350', '11', '0', '0', '0', '0'), ('7350', '12', '0', '0', '0', '0'), ('7350', '13', '0', '0', '0', '0'), ('7350', '14', '0', '0', '0', '0'), ('7350', '15', '0', '0', '0', '0'), ('7350', '16', '0', '0', '0', '0'), ('7350', '17', '0', '0', '0', '0'), ('7350', '18', '0', '0', '0', '0'), ('7350', '19', '0', '0', '0', '0'), ('7350', '20', '0', '0', '0', '0'), ('7350', '21', '0', '0', '0', '0'), ('7350', '22', '0', '0', '0', '0'), ('7350', '23', '0', '0', '0', '0'), ('7350', '24', '0', '0', '0', '0'), ('7350', '25', '0', '0', '0', '0'), ('7350', '26', '0', '0', '0', '0'), ('7350', '27', '0', '0', '0', '0'), ('7350', '28', '0', '0', '0', '0'), ('7350', '29', '0', '0', '0', '0'), ('7350', '30', '0', '0', '0', '0'), ('7350', '31', '0', '0', '0', '0'), ('7350', '32', '0', '0', '0', '0'), ('7350', '33', '0', '0', '0', '0'), ('7350', '34', '0', '0', '0', '0'), ('7350', '35', '0', '0', '0', '0'), ('7350', '36', '0', '0', '0', '0'), ('7350', '37', '0', '0', '0', '0'), ('7390', '-11', '0', '0', '0', '0'), ('7390', '-10', '0', '0', '0', '0'), ('7390', '-9', '0', '0', '0', '0'), ('7390', '-8', '0', '0', '0', '0'), ('7390', '-7', '0', '0', '0', '0'), ('7390', '-6', '0', '0', '0', '0'), ('7390', '-5', '0', '0', '0', '0'), ('7390', '-4', '0', '0', '0', '0'), ('7390', '-3', '0', '0', '0', '0'), ('7390', '-2', '0', '0', '0', '0'), ('7390', '-1', '0', '0', '0', '0'), ('7390', '0', '0', '0', '0', '0'), ('7390', '1', '0', '0', '0', '0'), ('7390', '2', '0', '0', '0', '0'), ('7390', '3', '0', '0', '0', '0'), ('7390', '4', '0', '0', '0', '0'), ('7390', '5', '0', '0', '0', '0'), ('7390', '6', '0', '0', '0', '0'), ('7390', '7', '0', '0', '0', '0'), ('7390', '8', '0', '0', '0', '0'), ('7390', '9', '0', '0', '0', '0'), ('7390', '10', '0', '0', '0', '0'), ('7390', '11', '0', '0', '0', '0'), ('7390', '12', '0', '0', '0', '0'), ('7390', '13', '0', '0', '0', '0'), ('7390', '14', '0', '0', '0', '0'), ('7390', '15', '0', '0', '0', '0'), ('7390', '16', '0', '0', '0', '0'), ('7390', '17', '0', '0', '0', '0'), ('7390', '18', '0', '0', '0', '0'), ('7390', '19', '0', '0', '0', '0'), ('7390', '20', '0', '0', '0', '0'), ('7390', '21', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7390', '22', '0', '0', '0', '0'), ('7390', '23', '0', '0', '0', '0'), ('7390', '24', '0', '0', '0', '0'), ('7390', '25', '0', '0', '0', '0'), ('7390', '26', '0', '0', '0', '0'), ('7390', '27', '0', '0', '0', '0'), ('7390', '28', '0', '0', '0', '0'), ('7390', '29', '0', '0', '0', '0'), ('7390', '30', '0', '0', '0', '0'), ('7390', '31', '0', '0', '0', '0'), ('7390', '32', '0', '0', '0', '0'), ('7390', '33', '0', '0', '0', '0'), ('7390', '34', '0', '0', '0', '0'), ('7390', '35', '0', '0', '0', '0'), ('7390', '36', '0', '0', '0', '0'), ('7390', '37', '0', '0', '0', '0'), ('7400', '-11', '0', '0', '0', '0'), ('7400', '-10', '0', '0', '0', '0'), ('7400', '-9', '0', '0', '0', '0'), ('7400', '-8', '0', '0', '0', '0'), ('7400', '-7', '0', '0', '0', '0'), ('7400', '-6', '0', '0', '0', '0'), ('7400', '-5', '0', '0', '0', '0'), ('7400', '-4', '0', '0', '0', '0'), ('7400', '-3', '0', '0', '0', '0'), ('7400', '-2', '0', '0', '0', '0'), ('7400', '-1', '0', '0', '0', '0'), ('7400', '0', '0', '0', '0', '0'), ('7400', '1', '0', '0', '0', '0'), ('7400', '2', '0', '0', '0', '0'), ('7400', '3', '0', '0', '0', '0'), ('7400', '4', '0', '0', '0', '0'), ('7400', '5', '0', '0', '0', '0'), ('7400', '6', '0', '0', '0', '0'), ('7400', '7', '0', '0', '0', '0'), ('7400', '8', '0', '0', '0', '0'), ('7400', '9', '0', '0', '0', '0'), ('7400', '10', '0', '0', '0', '0'), ('7400', '11', '0', '0', '0', '0'), ('7400', '12', '0', '0', '0', '0'), ('7400', '13', '0', '0', '0', '0'), ('7400', '14', '0', '0', '0', '0'), ('7400', '15', '0', '0', '0', '0'), ('7400', '16', '0', '0', '0', '0'), ('7400', '17', '0', '0', '0', '0'), ('7400', '18', '0', '0', '0', '0'), ('7400', '19', '0', '0', '0', '0'), ('7400', '20', '0', '0', '0', '0'), ('7400', '21', '0', '0', '0', '0'), ('7400', '22', '0', '0', '0', '0'), ('7400', '23', '0', '0', '0', '0'), ('7400', '24', '0', '0', '0', '0'), ('7400', '25', '0', '0', '0', '0'), ('7400', '26', '0', '0', '0', '0'), ('7400', '27', '0', '0', '0', '0'), ('7400', '28', '0', '0', '0', '0'), ('7400', '29', '0', '0', '0', '0'), ('7400', '30', '0', '0', '0', '0'), ('7400', '31', '0', '0', '0', '0'), ('7400', '32', '0', '0', '0', '0'), ('7400', '33', '0', '0', '0', '0'), ('7400', '34', '0', '0', '0', '0'), ('7400', '35', '0', '0', '0', '0'), ('7400', '36', '0', '0', '0', '0'), ('7400', '37', '0', '0', '0', '0'), ('7450', '-11', '0', '0', '0', '0'), ('7450', '-10', '0', '0', '0', '0'), ('7450', '-9', '0', '0', '0', '0'), ('7450', '-8', '0', '0', '0', '0'), ('7450', '-7', '0', '0', '0', '0'), ('7450', '-6', '0', '0', '0', '0'), ('7450', '-5', '0', '0', '0', '0'), ('7450', '-4', '0', '0', '0', '0'), ('7450', '-3', '0', '0', '0', '0'), ('7450', '-2', '0', '0', '0', '0'), ('7450', '-1', '0', '0', '0', '0'), ('7450', '0', '0', '0', '0', '0'), ('7450', '1', '0', '0', '0', '0'), ('7450', '2', '0', '0', '0', '0'), ('7450', '3', '0', '0', '0', '0'), ('7450', '4', '0', '0', '0', '0'), ('7450', '5', '0', '0', '0', '0'), ('7450', '6', '0', '0', '0', '0'), ('7450', '7', '0', '0', '0', '0'), ('7450', '8', '0', '0', '0', '0'), ('7450', '9', '0', '0', '0', '0'), ('7450', '10', '0', '0', '0', '0'), ('7450', '11', '0', '0', '0', '0'), ('7450', '12', '0', '0', '0', '0'), ('7450', '13', '0', '0', '0', '0'), ('7450', '14', '0', '0', '0', '0'), ('7450', '15', '0', '0', '0', '0'), ('7450', '16', '0', '0', '0', '0'), ('7450', '17', '0', '0', '0', '0'), ('7450', '18', '0', '0', '0', '0'), ('7450', '19', '0', '0', '0', '0'), ('7450', '20', '0', '0', '0', '0'), ('7450', '21', '0', '0', '0', '0'), ('7450', '22', '0', '0', '0', '0'), ('7450', '23', '0', '0', '0', '0'), ('7450', '24', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7450', '25', '0', '0', '0', '0'), ('7450', '26', '0', '0', '0', '0'), ('7450', '27', '0', '0', '0', '0'), ('7450', '28', '0', '0', '0', '0'), ('7450', '29', '0', '0', '0', '0'), ('7450', '30', '0', '0', '0', '0'), ('7450', '31', '0', '0', '0', '0'), ('7450', '32', '0', '0', '0', '0'), ('7450', '33', '0', '0', '0', '0'), ('7450', '34', '0', '0', '0', '0'), ('7450', '35', '0', '0', '0', '0'), ('7450', '36', '0', '0', '0', '0'), ('7450', '37', '0', '0', '0', '0'), ('7500', '-11', '0', '0', '0', '0'), ('7500', '-10', '0', '0', '0', '0'), ('7500', '-9', '0', '0', '0', '0'), ('7500', '-8', '0', '0', '0', '0'), ('7500', '-7', '0', '0', '0', '0'), ('7500', '-6', '0', '0', '0', '0'), ('7500', '-5', '0', '0', '0', '0'), ('7500', '-4', '0', '0', '0', '0'), ('7500', '-3', '0', '0', '0', '0'), ('7500', '-2', '0', '0', '0', '0'), ('7500', '-1', '0', '0', '0', '0'), ('7500', '0', '0', '0', '0', '0'), ('7500', '1', '0', '0', '0', '0'), ('7500', '2', '0', '0', '0', '0'), ('7500', '3', '0', '0', '0', '0'), ('7500', '4', '0', '0', '0', '0'), ('7500', '5', '0', '0', '0', '0'), ('7500', '6', '0', '0', '0', '0'), ('7500', '7', '0', '0', '0', '0'), ('7500', '8', '0', '0', '0', '0'), ('7500', '9', '0', '0', '0', '0'), ('7500', '10', '0', '0', '0', '0'), ('7500', '11', '0', '0', '0', '0'), ('7500', '12', '0', '0', '0', '0'), ('7500', '13', '0', '0', '0', '0'), ('7500', '14', '0', '0', '0', '0'), ('7500', '15', '0', '0', '0', '0'), ('7500', '16', '0', '0', '0', '0'), ('7500', '17', '0', '0', '0', '0'), ('7500', '18', '0', '0', '0', '0'), ('7500', '19', '0', '0', '0', '0'), ('7500', '20', '0', '0', '0', '0'), ('7500', '21', '0', '0', '0', '0'), ('7500', '22', '0', '0', '0', '0'), ('7500', '23', '0', '0', '0', '0'), ('7500', '24', '0', '0', '0', '0'), ('7500', '25', '0', '0', '0', '0'), ('7500', '26', '0', '0', '0', '0'), ('7500', '27', '0', '0', '0', '0'), ('7500', '28', '0', '0', '0', '0'), ('7500', '29', '0', '0', '0', '0'), ('7500', '30', '0', '0', '0', '0'), ('7500', '31', '0', '0', '0', '0'), ('7500', '32', '0', '0', '0', '0'), ('7500', '33', '0', '0', '0', '0'), ('7500', '34', '0', '0', '0', '0'), ('7500', '35', '0', '0', '0', '0'), ('7500', '36', '0', '0', '0', '0'), ('7500', '37', '0', '0', '0', '0'), ('7550', '-11', '0', '0', '0', '0'), ('7550', '-10', '0', '0', '0', '0'), ('7550', '-9', '0', '0', '0', '0'), ('7550', '-8', '0', '0', '0', '0'), ('7550', '-7', '0', '0', '0', '0'), ('7550', '-6', '0', '0', '0', '0'), ('7550', '-5', '0', '0', '0', '0'), ('7550', '-4', '0', '0', '0', '0'), ('7550', '-3', '0', '0', '0', '0'), ('7550', '-2', '0', '0', '0', '0'), ('7550', '-1', '0', '0', '0', '0'), ('7550', '0', '0', '0', '0', '0'), ('7550', '1', '0', '0', '0', '0'), ('7550', '2', '0', '0', '0', '0'), ('7550', '3', '0', '0', '0', '0'), ('7550', '4', '0', '0', '0', '0'), ('7550', '5', '0', '0', '0', '0'), ('7550', '6', '0', '0', '0', '0'), ('7550', '7', '0', '0', '0', '0'), ('7550', '8', '0', '0', '0', '0'), ('7550', '9', '0', '0', '0', '0'), ('7550', '10', '0', '0', '0', '0'), ('7550', '11', '0', '0', '0', '0'), ('7550', '12', '0', '0', '0', '0'), ('7550', '13', '0', '0', '0', '0'), ('7550', '14', '0', '0', '0', '0'), ('7550', '15', '0', '0', '0', '0'), ('7550', '16', '0', '0', '0', '0'), ('7550', '17', '0', '0', '0', '0'), ('7550', '18', '0', '0', '0', '0'), ('7550', '19', '0', '0', '0', '0'), ('7550', '20', '0', '0', '0', '0'), ('7550', '21', '0', '0', '0', '0'), ('7550', '22', '0', '0', '0', '0'), ('7550', '23', '0', '0', '0', '0'), ('7550', '24', '0', '0', '0', '0'), ('7550', '25', '0', '0', '0', '0'), ('7550', '26', '0', '0', '0', '0'), ('7550', '27', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7550', '28', '0', '0', '0', '0'), ('7550', '29', '0', '0', '0', '0'), ('7550', '30', '0', '0', '0', '0'), ('7550', '31', '0', '0', '0', '0'), ('7550', '32', '0', '0', '0', '0'), ('7550', '33', '0', '0', '0', '0'), ('7550', '34', '0', '0', '0', '0'), ('7550', '35', '0', '0', '0', '0'), ('7550', '36', '0', '0', '0', '0'), ('7550', '37', '0', '0', '0', '0'), ('7600', '-11', '0', '0', '0', '0'), ('7600', '-10', '0', '0', '0', '0'), ('7600', '-9', '0', '0', '0', '0'), ('7600', '-8', '0', '0', '0', '0'), ('7600', '-7', '0', '0', '0', '0'), ('7600', '-6', '0', '0', '0', '0'), ('7600', '-5', '0', '0', '0', '0'), ('7600', '-4', '0', '0', '0', '0'), ('7600', '-3', '0', '0', '0', '0'), ('7600', '-2', '0', '0', '0', '0'), ('7600', '-1', '0', '0', '0', '0'), ('7600', '0', '0', '0', '0', '0'), ('7600', '1', '0', '0', '0', '0'), ('7600', '2', '0', '0', '0', '0'), ('7600', '3', '0', '0', '0', '0'), ('7600', '4', '0', '0', '0', '0'), ('7600', '5', '0', '0', '0', '0'), ('7600', '6', '0', '0', '0', '0'), ('7600', '7', '0', '0', '0', '0'), ('7600', '8', '0', '0', '0', '0'), ('7600', '9', '0', '0', '0', '0'), ('7600', '10', '0', '0', '0', '0'), ('7600', '11', '0', '0', '0', '0'), ('7600', '12', '0', '0', '0', '0'), ('7600', '13', '0', '0', '0', '0'), ('7600', '14', '0', '0', '0', '0'), ('7600', '15', '0', '0', '0', '0'), ('7600', '16', '0', '0', '0', '0'), ('7600', '17', '0', '0', '0', '0'), ('7600', '18', '0', '0', '0', '0'), ('7600', '19', '0', '0', '0', '0'), ('7600', '20', '0', '0', '0', '0'), ('7600', '21', '0', '0', '0', '0'), ('7600', '22', '0', '0', '0', '0'), ('7600', '23', '0', '0', '0', '0'), ('7600', '24', '0', '0', '0', '0'), ('7600', '25', '0', '0', '0', '0'), ('7600', '26', '0', '0', '0', '0'), ('7600', '27', '0', '0', '0', '0'), ('7600', '28', '0', '0', '0', '0'), ('7600', '29', '0', '0', '0', '0'), ('7600', '30', '0', '0', '0', '0'), ('7600', '31', '0', '0', '0', '0'), ('7600', '32', '0', '0', '0', '0'), ('7600', '33', '0', '0', '0', '0'), ('7600', '34', '0', '0', '0', '0'), ('7600', '35', '0', '0', '0', '0'), ('7600', '36', '0', '0', '0', '0'), ('7600', '37', '0', '0', '0', '0'), ('7610', '-11', '0', '0', '0', '0'), ('7610', '-10', '0', '0', '0', '0'), ('7610', '-9', '0', '0', '0', '0'), ('7610', '-8', '0', '0', '0', '0'), ('7610', '-7', '0', '0', '0', '0'), ('7610', '-6', '0', '0', '0', '0'), ('7610', '-5', '0', '0', '0', '0'), ('7610', '-4', '0', '0', '0', '0'), ('7610', '-3', '0', '0', '0', '0'), ('7610', '-2', '0', '0', '0', '0'), ('7610', '-1', '0', '0', '0', '0'), ('7610', '0', '0', '0', '0', '0'), ('7610', '1', '0', '0', '0', '0'), ('7610', '2', '0', '0', '0', '0'), ('7610', '3', '0', '0', '0', '0'), ('7610', '4', '0', '0', '0', '0'), ('7610', '5', '0', '0', '0', '0'), ('7610', '6', '0', '0', '0', '0'), ('7610', '7', '0', '0', '0', '0'), ('7610', '8', '0', '0', '0', '0'), ('7610', '9', '0', '0', '0', '0'), ('7610', '10', '0', '0', '0', '0'), ('7610', '11', '0', '0', '0', '0'), ('7610', '12', '0', '0', '0', '0'), ('7610', '13', '0', '0', '0', '0'), ('7610', '14', '0', '0', '0', '0'), ('7610', '15', '0', '0', '0', '0'), ('7610', '16', '0', '0', '0', '0'), ('7610', '17', '0', '0', '0', '0'), ('7610', '18', '0', '0', '0', '0'), ('7610', '19', '0', '0', '0', '0'), ('7610', '20', '0', '0', '0', '0'), ('7610', '21', '0', '0', '0', '0'), ('7610', '22', '0', '0', '0', '0'), ('7610', '23', '0', '0', '0', '0'), ('7610', '24', '0', '0', '0', '0'), ('7610', '25', '0', '0', '0', '0'), ('7610', '26', '0', '0', '0', '0'), ('7610', '27', '0', '0', '0', '0'), ('7610', '28', '0', '0', '0', '0'), ('7610', '29', '0', '0', '0', '0'), ('7610', '30', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7610', '31', '0', '0', '0', '0'), ('7610', '32', '0', '0', '0', '0'), ('7610', '33', '0', '0', '0', '0'), ('7610', '34', '0', '0', '0', '0'), ('7610', '35', '0', '0', '0', '0'), ('7610', '36', '0', '0', '0', '0'), ('7610', '37', '0', '0', '0', '0'), ('7620', '-11', '0', '0', '0', '0'), ('7620', '-10', '0', '0', '0', '0'), ('7620', '-9', '0', '0', '0', '0'), ('7620', '-8', '0', '0', '0', '0'), ('7620', '-7', '0', '0', '0', '0'), ('7620', '-6', '0', '0', '0', '0'), ('7620', '-5', '0', '0', '0', '0'), ('7620', '-4', '0', '0', '0', '0'), ('7620', '-3', '0', '0', '0', '0'), ('7620', '-2', '0', '0', '0', '0'), ('7620', '-1', '0', '0', '0', '0'), ('7620', '0', '0', '0', '0', '0'), ('7620', '1', '0', '0', '0', '0'), ('7620', '2', '0', '0', '0', '0'), ('7620', '3', '0', '0', '0', '0'), ('7620', '4', '0', '0', '0', '0'), ('7620', '5', '0', '0', '0', '0'), ('7620', '6', '0', '0', '0', '0'), ('7620', '7', '0', '0', '0', '0'), ('7620', '8', '0', '0', '0', '0'), ('7620', '9', '0', '0', '0', '0'), ('7620', '10', '0', '0', '0', '0'), ('7620', '11', '0', '0', '0', '0'), ('7620', '12', '0', '0', '0', '0'), ('7620', '13', '0', '0', '0', '0'), ('7620', '14', '0', '0', '0', '0'), ('7620', '15', '0', '0', '0', '0'), ('7620', '16', '0', '0', '0', '0'), ('7620', '17', '0', '0', '0', '0'), ('7620', '18', '0', '0', '0', '0'), ('7620', '19', '0', '0', '0', '0'), ('7620', '20', '0', '0', '0', '0'), ('7620', '21', '0', '0', '0', '0'), ('7620', '22', '0', '0', '0', '0'), ('7620', '23', '0', '0', '0', '0'), ('7620', '24', '0', '0', '0', '0'), ('7620', '25', '0', '0', '0', '0'), ('7620', '26', '0', '0', '0', '0'), ('7620', '27', '0', '0', '0', '0'), ('7620', '28', '0', '0', '0', '0'), ('7620', '29', '0', '0', '0', '0'), ('7620', '30', '0', '0', '0', '0'), ('7620', '31', '0', '0', '0', '0'), ('7620', '32', '0', '0', '0', '0'), ('7620', '33', '0', '0', '0', '0'), ('7620', '34', '0', '0', '0', '0'), ('7620', '35', '0', '0', '0', '0'), ('7620', '36', '0', '0', '0', '0'), ('7620', '37', '0', '0', '0', '0'), ('7630', '-11', '0', '0', '0', '0'), ('7630', '-10', '0', '0', '0', '0'), ('7630', '-9', '0', '0', '0', '0'), ('7630', '-8', '0', '0', '0', '0'), ('7630', '-7', '0', '0', '0', '0'), ('7630', '-6', '0', '0', '0', '0'), ('7630', '-5', '0', '0', '0', '0'), ('7630', '-4', '0', '0', '0', '0'), ('7630', '-3', '0', '0', '0', '0'), ('7630', '-2', '0', '0', '0', '0'), ('7630', '-1', '0', '0', '0', '0'), ('7630', '0', '0', '0', '0', '0'), ('7630', '1', '0', '0', '0', '0'), ('7630', '2', '0', '0', '0', '0'), ('7630', '3', '0', '0', '0', '0'), ('7630', '4', '0', '0', '0', '0'), ('7630', '5', '0', '0', '0', '0'), ('7630', '6', '0', '0', '0', '0'), ('7630', '7', '0', '0', '0', '0'), ('7630', '8', '0', '0', '0', '0'), ('7630', '9', '0', '0', '0', '0'), ('7630', '10', '0', '0', '0', '0'), ('7630', '11', '0', '0', '0', '0'), ('7630', '12', '0', '0', '0', '0'), ('7630', '13', '0', '0', '0', '0'), ('7630', '14', '0', '0', '0', '0'), ('7630', '15', '0', '0', '0', '0'), ('7630', '16', '0', '0', '0', '0'), ('7630', '17', '0', '0', '0', '0'), ('7630', '18', '0', '0', '0', '0'), ('7630', '19', '0', '0', '0', '0'), ('7630', '20', '0', '0', '0', '0'), ('7630', '21', '0', '0', '0', '0'), ('7630', '22', '0', '0', '0', '0'), ('7630', '23', '0', '0', '0', '0'), ('7630', '24', '0', '0', '0', '0'), ('7630', '25', '0', '0', '0', '0'), ('7630', '26', '0', '0', '0', '0'), ('7630', '27', '0', '0', '0', '0'), ('7630', '28', '0', '0', '0', '0'), ('7630', '29', '0', '0', '0', '0'), ('7630', '30', '0', '0', '0', '0'), ('7630', '31', '0', '0', '0', '0'), ('7630', '32', '0', '0', '0', '0'), ('7630', '33', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7630', '34', '0', '0', '0', '0'), ('7630', '35', '0', '0', '0', '0'), ('7630', '36', '0', '0', '0', '0'), ('7630', '37', '0', '0', '0', '0'), ('7640', '-11', '0', '0', '0', '0'), ('7640', '-10', '0', '0', '0', '0'), ('7640', '-9', '0', '0', '0', '0'), ('7640', '-8', '0', '0', '0', '0'), ('7640', '-7', '0', '0', '0', '0'), ('7640', '-6', '0', '0', '0', '0'), ('7640', '-5', '0', '0', '0', '0'), ('7640', '-4', '0', '0', '0', '0'), ('7640', '-3', '0', '0', '0', '0'), ('7640', '-2', '0', '0', '0', '0'), ('7640', '-1', '0', '0', '0', '0'), ('7640', '0', '0', '0', '0', '0'), ('7640', '1', '0', '0', '0', '0'), ('7640', '2', '0', '0', '0', '0'), ('7640', '3', '0', '0', '0', '0'), ('7640', '4', '0', '0', '0', '0'), ('7640', '5', '0', '0', '0', '0'), ('7640', '6', '0', '0', '0', '0'), ('7640', '7', '0', '0', '0', '0'), ('7640', '8', '0', '0', '0', '0'), ('7640', '9', '0', '0', '0', '0'), ('7640', '10', '0', '0', '0', '0'), ('7640', '11', '0', '0', '0', '0'), ('7640', '12', '0', '0', '0', '0'), ('7640', '13', '0', '0', '0', '0'), ('7640', '14', '0', '0', '0', '0'), ('7640', '15', '0', '0', '0', '0'), ('7640', '16', '0', '0', '0', '0'), ('7640', '17', '0', '0', '0', '0'), ('7640', '18', '0', '0', '0', '0'), ('7640', '19', '0', '0', '0', '0'), ('7640', '20', '0', '0', '0', '0'), ('7640', '21', '0', '0', '0', '0'), ('7640', '22', '0', '0', '0', '0'), ('7640', '23', '0', '0', '0', '0'), ('7640', '24', '0', '0', '0', '0'), ('7640', '25', '0', '0', '0', '0'), ('7640', '26', '0', '0', '0', '0'), ('7640', '27', '0', '0', '0', '0'), ('7640', '28', '0', '0', '0', '0'), ('7640', '29', '0', '0', '0', '0'), ('7640', '30', '0', '0', '0', '0'), ('7640', '31', '0', '0', '0', '0'), ('7640', '32', '0', '0', '0', '0'), ('7640', '33', '0', '0', '0', '0'), ('7640', '34', '0', '0', '0', '0'), ('7640', '35', '0', '0', '0', '0'), ('7640', '36', '0', '0', '0', '0'), ('7640', '37', '0', '0', '0', '0'), ('7650', '-11', '0', '0', '0', '0'), ('7650', '-10', '0', '0', '0', '0'), ('7650', '-9', '0', '0', '0', '0'), ('7650', '-8', '0', '0', '0', '0'), ('7650', '-7', '0', '0', '0', '0'), ('7650', '-6', '0', '0', '0', '0'), ('7650', '-5', '0', '0', '0', '0'), ('7650', '-4', '0', '0', '0', '0'), ('7650', '-3', '0', '0', '0', '0'), ('7650', '-2', '0', '0', '0', '0'), ('7650', '-1', '0', '0', '0', '0'), ('7650', '0', '0', '0', '0', '0'), ('7650', '1', '0', '0', '0', '0'), ('7650', '2', '0', '0', '0', '0'), ('7650', '3', '0', '0', '0', '0'), ('7650', '4', '0', '0', '0', '0'), ('7650', '5', '0', '0', '0', '0'), ('7650', '6', '0', '0', '0', '0'), ('7650', '7', '0', '0', '0', '0'), ('7650', '8', '0', '0', '0', '0'), ('7650', '9', '0', '0', '0', '0'), ('7650', '10', '0', '0', '0', '0'), ('7650', '11', '0', '0', '0', '0'), ('7650', '12', '0', '0', '0', '0'), ('7650', '13', '0', '0', '0', '0'), ('7650', '14', '0', '0', '0', '0'), ('7650', '15', '0', '0', '0', '0'), ('7650', '16', '0', '0', '0', '0'), ('7650', '17', '0', '0', '0', '0'), ('7650', '18', '0', '0', '0', '0'), ('7650', '19', '0', '0', '0', '0'), ('7650', '20', '0', '0', '0', '0'), ('7650', '21', '0', '0', '0', '0'), ('7650', '22', '0', '0', '0', '0'), ('7650', '23', '0', '0', '0', '0'), ('7650', '24', '0', '0', '0', '0'), ('7650', '25', '0', '0', '0', '0'), ('7650', '26', '0', '0', '0', '0'), ('7650', '27', '0', '0', '0', '0'), ('7650', '28', '0', '0', '0', '0'), ('7650', '29', '0', '0', '0', '0'), ('7650', '30', '0', '0', '0', '0'), ('7650', '31', '0', '0', '0', '0'), ('7650', '32', '0', '0', '0', '0'), ('7650', '33', '0', '0', '0', '0'), ('7650', '34', '0', '0', '0', '0'), ('7650', '35', '0', '0', '0', '0'), ('7650', '36', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7650', '37', '0', '0', '0', '0'), ('7660', '-11', '0', '0', '0', '0'), ('7660', '-10', '0', '0', '0', '0'), ('7660', '-9', '0', '0', '0', '0'), ('7660', '-8', '0', '0', '0', '0'), ('7660', '-7', '0', '0', '0', '0'), ('7660', '-6', '0', '0', '0', '0'), ('7660', '-5', '0', '0', '0', '0'), ('7660', '-4', '0', '0', '0', '0'), ('7660', '-3', '0', '0', '0', '0'), ('7660', '-2', '0', '0', '0', '0'), ('7660', '-1', '0', '0', '0', '0'), ('7660', '0', '0', '0', '0', '0'), ('7660', '1', '0', '0', '0', '0'), ('7660', '2', '0', '0', '0', '0'), ('7660', '3', '0', '0', '0', '0'), ('7660', '4', '0', '0', '0', '0'), ('7660', '5', '0', '0', '0', '0'), ('7660', '6', '0', '0', '0', '0'), ('7660', '7', '0', '0', '0', '0'), ('7660', '8', '0', '0', '0', '0'), ('7660', '9', '0', '0', '0', '0'), ('7660', '10', '0', '0', '0', '0'), ('7660', '11', '0', '0', '0', '0'), ('7660', '12', '0', '0', '0', '0'), ('7660', '13', '0', '0', '0', '0'), ('7660', '14', '0', '0', '0', '0'), ('7660', '15', '0', '0', '0', '0'), ('7660', '16', '0', '0', '0', '0'), ('7660', '17', '0', '0', '0', '0'), ('7660', '18', '0', '0', '0', '0'), ('7660', '19', '0', '0', '0', '0'), ('7660', '20', '0', '0', '0', '0'), ('7660', '21', '0', '0', '0', '0'), ('7660', '22', '0', '0', '0', '0'), ('7660', '23', '0', '0', '0', '0'), ('7660', '24', '0', '0', '0', '0'), ('7660', '25', '0', '0', '0', '0'), ('7660', '26', '0', '0', '0', '0'), ('7660', '27', '0', '0', '0', '0'), ('7660', '28', '0', '0', '0', '0'), ('7660', '29', '0', '0', '0', '0'), ('7660', '30', '0', '0', '0', '0'), ('7660', '31', '0', '0', '0', '0'), ('7660', '32', '0', '0', '0', '0'), ('7660', '33', '0', '0', '0', '0'), ('7660', '34', '0', '0', '0', '0'), ('7660', '35', '0', '0', '0', '0'), ('7660', '36', '0', '0', '0', '0'), ('7660', '37', '0', '0', '0', '0'), ('7700', '-11', '0', '0', '0', '0'), ('7700', '-10', '0', '0', '0', '0'), ('7700', '-9', '0', '0', '0', '0'), ('7700', '-8', '0', '0', '0', '0'), ('7700', '-7', '0', '0', '0', '0'), ('7700', '-6', '0', '0', '0', '0'), ('7700', '-5', '0', '0', '0', '0'), ('7700', '-4', '0', '0', '0', '0'), ('7700', '-3', '0', '0', '0', '0'), ('7700', '-2', '0', '0', '0', '0'), ('7700', '-1', '0', '0', '0', '0'), ('7700', '0', '0', '0', '0', '0'), ('7700', '1', '0', '0', '0', '0'), ('7700', '2', '0', '0', '0', '0'), ('7700', '3', '0', '0', '0', '0'), ('7700', '4', '0', '0', '0', '0'), ('7700', '5', '0', '0', '0', '0'), ('7700', '6', '0', '0', '0', '0'), ('7700', '7', '0', '0', '0', '0'), ('7700', '8', '0', '0', '0', '0'), ('7700', '9', '0', '0', '0', '0'), ('7700', '10', '0', '0', '0', '0'), ('7700', '11', '0', '0', '0', '0'), ('7700', '12', '0', '0', '0', '0'), ('7700', '13', '0', '0', '0', '0'), ('7700', '14', '0', '0', '0', '0'), ('7700', '15', '0', '0', '0', '0'), ('7700', '16', '0', '0', '0', '0'), ('7700', '17', '0', '0', '0', '0'), ('7700', '18', '0', '0', '0', '0'), ('7700', '19', '0', '0', '0', '0'), ('7700', '20', '0', '0', '0', '0'), ('7700', '21', '0', '0', '0', '0'), ('7700', '22', '0', '0', '0', '0'), ('7700', '23', '0', '0', '0', '0'), ('7700', '24', '0', '0', '0', '0'), ('7700', '25', '0', '0', '0', '0'), ('7700', '26', '0', '0', '0', '0'), ('7700', '27', '0', '0', '0', '0'), ('7700', '28', '0', '0', '0', '0'), ('7700', '29', '0', '0', '0', '0'), ('7700', '30', '0', '0', '0', '0'), ('7700', '31', '0', '0', '0', '0'), ('7700', '32', '0', '0', '0', '0'), ('7700', '33', '0', '0', '0', '0'), ('7700', '34', '0', '0', '0', '0'), ('7700', '35', '0', '0', '0', '0'), ('7700', '36', '0', '0', '0', '0'), ('7700', '37', '0', '0', '0', '0'), ('7750', '-11', '0', '0', '0', '0'), ('7750', '-10', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7750', '-9', '0', '0', '0', '0'), ('7750', '-8', '0', '0', '0', '0'), ('7750', '-7', '0', '0', '0', '0'), ('7750', '-6', '0', '0', '0', '0'), ('7750', '-5', '0', '0', '0', '0'), ('7750', '-4', '0', '0', '0', '0'), ('7750', '-3', '0', '0', '0', '0'), ('7750', '-2', '0', '0', '0', '0'), ('7750', '-1', '0', '0', '0', '0'), ('7750', '0', '0', '0', '0', '0'), ('7750', '1', '0', '0', '0', '0'), ('7750', '2', '0', '0', '0', '0'), ('7750', '3', '0', '0', '0', '0'), ('7750', '4', '0', '0', '0', '0'), ('7750', '5', '0', '0', '0', '0'), ('7750', '6', '0', '0', '0', '0'), ('7750', '7', '0', '0', '0', '0'), ('7750', '8', '0', '0', '0', '0'), ('7750', '9', '0', '0', '0', '0'), ('7750', '10', '0', '0', '0', '0'), ('7750', '11', '0', '0', '0', '0'), ('7750', '12', '0', '0', '0', '0'), ('7750', '13', '0', '0', '0', '0'), ('7750', '14', '0', '0', '0', '0'), ('7750', '15', '0', '0', '0', '0'), ('7750', '16', '0', '0', '0', '0'), ('7750', '17', '0', '0', '0', '0'), ('7750', '18', '0', '0', '0', '0'), ('7750', '19', '0', '0', '0', '0'), ('7750', '20', '0', '0', '0', '0'), ('7750', '21', '0', '0', '0', '0'), ('7750', '22', '0', '0', '0', '0'), ('7750', '23', '0', '0', '0', '0'), ('7750', '24', '0', '0', '0', '0'), ('7750', '25', '0', '0', '0', '0'), ('7750', '26', '0', '0', '0', '0'), ('7750', '27', '0', '0', '0', '0'), ('7750', '28', '0', '0', '0', '0'), ('7750', '29', '0', '0', '0', '0'), ('7750', '30', '0', '0', '0', '0'), ('7750', '31', '0', '0', '0', '0'), ('7750', '32', '0', '0', '0', '0'), ('7750', '33', '0', '0', '0', '0'), ('7750', '34', '0', '0', '0', '0'), ('7750', '35', '0', '0', '0', '0'), ('7750', '36', '0', '0', '0', '0'), ('7750', '37', '0', '0', '0', '0'), ('7800', '-11', '0', '0', '0', '0'), ('7800', '-10', '0', '0', '0', '0'), ('7800', '-9', '0', '0', '0', '0'), ('7800', '-8', '0', '0', '0', '0'), ('7800', '-7', '0', '0', '0', '0'), ('7800', '-6', '0', '0', '0', '0'), ('7800', '-5', '0', '0', '0', '0'), ('7800', '-4', '0', '0', '0', '0'), ('7800', '-3', '0', '0', '0', '0'), ('7800', '-2', '0', '0', '0', '0'), ('7800', '-1', '0', '0', '0', '0'), ('7800', '0', '0', '0', '0', '0'), ('7800', '1', '0', '0', '0', '0'), ('7800', '2', '0', '0', '0', '0'), ('7800', '3', '0', '0', '0', '0'), ('7800', '4', '0', '0', '0', '0'), ('7800', '5', '0', '0', '0', '0'), ('7800', '6', '0', '0', '0', '0'), ('7800', '7', '0', '0', '0', '0'), ('7800', '8', '0', '0', '0', '0'), ('7800', '9', '0', '0', '0', '0'), ('7800', '10', '0', '0', '0', '0'), ('7800', '11', '0', '0', '0', '0'), ('7800', '12', '0', '0', '0', '0'), ('7800', '13', '0', '0', '0', '0'), ('7800', '14', '0', '0', '0', '0'), ('7800', '15', '0', '0', '0', '0'), ('7800', '16', '0', '0', '0', '0'), ('7800', '17', '0', '0', '0', '0'), ('7800', '18', '0', '0', '0', '0'), ('7800', '19', '0', '0', '0', '0'), ('7800', '20', '0', '0', '0', '0'), ('7800', '21', '0', '0', '0', '0'), ('7800', '22', '0', '0', '0', '0'), ('7800', '23', '0', '0', '0', '0'), ('7800', '24', '0', '0', '0', '0'), ('7800', '25', '0', '0', '0', '0'), ('7800', '26', '0', '0', '0', '0'), ('7800', '27', '0', '0', '0', '0'), ('7800', '28', '0', '0', '0', '0'), ('7800', '29', '0', '0', '0', '0'), ('7800', '30', '0', '0', '0', '0'), ('7800', '31', '0', '0', '0', '0'), ('7800', '32', '0', '0', '0', '0'), ('7800', '33', '0', '0', '0', '0'), ('7800', '34', '0', '0', '0', '0'), ('7800', '35', '0', '0', '0', '0'), ('7800', '36', '0', '0', '0', '0'), ('7800', '37', '0', '0', '0', '0'), ('7900', '-11', '0', '0', '0', '0'), ('7900', '-10', '0', '0', '0', '0'), ('7900', '-9', '0', '0', '0', '0'), ('7900', '-8', '0', '0', '0', '0'), ('7900', '-7', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('7900', '-6', '0', '0', '0', '0'), ('7900', '-5', '0', '0', '0', '0'), ('7900', '-4', '0', '0', '0', '0'), ('7900', '-3', '0', '0', '0', '0'), ('7900', '-2', '0', '0', '0', '0'), ('7900', '-1', '0', '0', '0', '0'), ('7900', '0', '0', '0', '0', '0'), ('7900', '1', '0', '0', '0', '0'), ('7900', '2', '0', '0', '0', '0'), ('7900', '3', '0', '0', '0', '0'), ('7900', '4', '0', '0', '0', '0'), ('7900', '5', '0', '0', '0', '0'), ('7900', '6', '0', '0', '0', '0'), ('7900', '7', '0', '0', '0', '0'), ('7900', '8', '0', '0', '0', '0'), ('7900', '9', '0', '0', '0', '0'), ('7900', '10', '0', '0', '0', '0'), ('7900', '11', '0', '0', '0', '0'), ('7900', '12', '0', '0', '0', '0'), ('7900', '13', '0', '0', '0', '0'), ('7900', '14', '0', '0', '0', '0'), ('7900', '15', '0', '0', '0', '0'), ('7900', '16', '0', '0', '0', '0'), ('7900', '17', '0', '0', '0', '0'), ('7900', '18', '0', '0', '0', '0'), ('7900', '19', '0', '0', '0', '0'), ('7900', '20', '0', '0', '0', '0'), ('7900', '21', '0', '0', '0', '0'), ('7900', '22', '0', '0', '0', '0'), ('7900', '23', '0', '0', '0', '0'), ('7900', '24', '0', '0', '0', '0'), ('7900', '25', '0', '0', '0', '0'), ('7900', '26', '0', '0', '0', '0'), ('7900', '27', '0', '0', '0', '0'), ('7900', '28', '0', '0', '0', '0'), ('7900', '29', '0', '0', '0', '0'), ('7900', '30', '0', '0', '0', '0'), ('7900', '31', '0', '0', '0', '0'), ('7900', '32', '0', '0', '0', '0'), ('7900', '33', '0', '0', '0', '0'), ('7900', '34', '0', '0', '0', '0'), ('7900', '35', '0', '0', '0', '0'), ('7900', '36', '0', '0', '0', '0'), ('7900', '37', '0', '0', '0', '0'), ('8100', '-11', '0', '0', '0', '0'), ('8100', '-10', '0', '0', '0', '0'), ('8100', '-9', '0', '0', '0', '0'), ('8100', '-8', '0', '0', '0', '0'), ('8100', '-7', '0', '0', '0', '0'), ('8100', '-6', '0', '0', '0', '0'), ('8100', '-5', '0', '0', '0', '0'), ('8100', '-4', '0', '0', '0', '0'), ('8100', '-3', '0', '0', '0', '0'), ('8100', '-2', '0', '0', '0', '0'), ('8100', '-1', '0', '0', '0', '0'), ('8100', '0', '0', '0', '0', '0'), ('8100', '1', '0', '0', '0', '0'), ('8100', '2', '0', '0', '0', '0'), ('8100', '3', '0', '0', '0', '0'), ('8100', '4', '0', '0', '0', '0'), ('8100', '5', '0', '0', '0', '0'), ('8100', '6', '0', '0', '0', '0'), ('8100', '7', '0', '0', '0', '0'), ('8100', '8', '0', '0', '0', '0'), ('8100', '9', '0', '0', '0', '0'), ('8100', '10', '0', '0', '0', '0'), ('8100', '11', '0', '0', '0', '0'), ('8100', '12', '0', '0', '0', '0'), ('8100', '13', '0', '0', '0', '0'), ('8100', '14', '0', '0', '0', '0'), ('8100', '15', '0', '0', '0', '0'), ('8100', '16', '0', '0', '0', '0'), ('8100', '17', '0', '0', '0', '0'), ('8100', '18', '0', '0', '0', '0'), ('8100', '19', '0', '0', '0', '0'), ('8100', '20', '0', '0', '0', '0'), ('8100', '21', '0', '0', '0', '0'), ('8100', '22', '0', '0', '0', '0'), ('8100', '23', '0', '0', '0', '0'), ('8100', '24', '0', '0', '0', '0'), ('8100', '25', '0', '0', '0', '0'), ('8100', '26', '0', '0', '0', '0'), ('8100', '27', '0', '0', '0', '0'), ('8100', '28', '0', '0', '0', '0'), ('8100', '29', '0', '0', '0', '0'), ('8100', '30', '0', '0', '0', '0'), ('8100', '31', '0', '0', '0', '0'), ('8100', '32', '0', '0', '0', '0'), ('8100', '33', '0', '0', '0', '0'), ('8100', '34', '0', '0', '0', '0'), ('8100', '35', '0', '0', '0', '0'), ('8100', '36', '0', '0', '0', '0'), ('8100', '37', '0', '0', '0', '0'), ('8200', '-11', '0', '0', '0', '0'), ('8200', '-10', '0', '0', '0', '0'), ('8200', '-9', '0', '0', '0', '0'), ('8200', '-8', '0', '0', '0', '0'), ('8200', '-7', '0', '0', '0', '0'), ('8200', '-6', '0', '0', '0', '0'), ('8200', '-5', '0', '0', '0', '0'), ('8200', '-4', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('8200', '-3', '0', '0', '0', '0'), ('8200', '-2', '0', '0', '0', '0'), ('8200', '-1', '0', '0', '0', '0'), ('8200', '0', '0', '0', '0', '0'), ('8200', '1', '0', '0', '0', '0'), ('8200', '2', '0', '0', '0', '0'), ('8200', '3', '0', '0', '0', '0'), ('8200', '4', '0', '0', '0', '0'), ('8200', '5', '0', '0', '0', '0'), ('8200', '6', '0', '0', '0', '0'), ('8200', '7', '0', '0', '0', '0'), ('8200', '8', '0', '0', '0', '0'), ('8200', '9', '0', '0', '0', '0'), ('8200', '10', '0', '0', '0', '0'), ('8200', '11', '0', '0', '0', '0'), ('8200', '12', '0', '0', '0', '0'), ('8200', '13', '0', '0', '0', '0'), ('8200', '14', '0', '0', '0', '0'), ('8200', '15', '0', '0', '0', '0'), ('8200', '16', '0', '0', '0', '0'), ('8200', '17', '0', '0', '0', '0'), ('8200', '18', '0', '0', '0', '0'), ('8200', '19', '0', '0', '0', '0'), ('8200', '20', '0', '0', '0', '0'), ('8200', '21', '0', '0', '0', '0'), ('8200', '22', '0', '0', '0', '0'), ('8200', '23', '0', '0', '0', '0'), ('8200', '24', '0', '0', '0', '0'), ('8200', '25', '0', '0', '0', '0'), ('8200', '26', '0', '0', '0', '0'), ('8200', '27', '0', '0', '0', '0'), ('8200', '28', '0', '0', '0', '0'), ('8200', '29', '0', '0', '0', '0'), ('8200', '30', '0', '0', '0', '0'), ('8200', '31', '0', '0', '0', '0'), ('8200', '32', '0', '0', '0', '0'), ('8200', '33', '0', '0', '0', '0'), ('8200', '34', '0', '0', '0', '0'), ('8200', '35', '0', '0', '0', '0'), ('8200', '36', '0', '0', '0', '0'), ('8200', '37', '0', '0', '0', '0'), ('8300', '-11', '0', '0', '0', '0'), ('8300', '-10', '0', '0', '0', '0'), ('8300', '-9', '0', '0', '0', '0'), ('8300', '-8', '0', '0', '0', '0'), ('8300', '-7', '0', '0', '0', '0'), ('8300', '-6', '0', '0', '0', '0'), ('8300', '-5', '0', '0', '0', '0'), ('8300', '-4', '0', '0', '0', '0'), ('8300', '-3', '0', '0', '0', '0'), ('8300', '-2', '0', '0', '0', '0'), ('8300', '-1', '0', '0', '0', '0'), ('8300', '0', '0', '0', '0', '0'), ('8300', '1', '0', '0', '0', '0'), ('8300', '2', '0', '0', '0', '0'), ('8300', '3', '0', '0', '0', '0'), ('8300', '4', '0', '0', '0', '0'), ('8300', '5', '0', '0', '0', '0'), ('8300', '6', '0', '0', '0', '0'), ('8300', '7', '0', '0', '0', '0'), ('8300', '8', '0', '0', '0', '0'), ('8300', '9', '0', '0', '0', '0'), ('8300', '10', '0', '0', '0', '0'), ('8300', '11', '0', '0', '0', '0'), ('8300', '12', '0', '0', '0', '0'), ('8300', '13', '0', '0', '0', '0'), ('8300', '14', '0', '0', '0', '0'), ('8300', '15', '0', '0', '0', '0'), ('8300', '16', '0', '0', '0', '0'), ('8300', '17', '0', '0', '0', '0'), ('8300', '18', '0', '0', '0', '0'), ('8300', '19', '0', '0', '0', '0'), ('8300', '20', '0', '0', '0', '0'), ('8300', '21', '0', '0', '0', '0'), ('8300', '22', '0', '0', '0', '0'), ('8300', '23', '0', '0', '0', '0'), ('8300', '24', '0', '0', '0', '0'), ('8300', '25', '0', '0', '0', '0'), ('8300', '26', '0', '0', '0', '0'), ('8300', '27', '0', '0', '0', '0'), ('8300', '28', '0', '0', '0', '0'), ('8300', '29', '0', '0', '0', '0'), ('8300', '30', '0', '0', '0', '0'), ('8300', '31', '0', '0', '0', '0'), ('8300', '32', '0', '0', '0', '0'), ('8300', '33', '0', '0', '0', '0'), ('8300', '34', '0', '0', '0', '0'), ('8300', '35', '0', '0', '0', '0'), ('8300', '36', '0', '0', '0', '0'), ('8300', '37', '0', '0', '0', '0'), ('8400', '-11', '0', '0', '0', '0'), ('8400', '-10', '0', '0', '0', '0'), ('8400', '-9', '0', '0', '0', '0'), ('8400', '-8', '0', '0', '0', '0'), ('8400', '-7', '0', '0', '0', '0'), ('8400', '-6', '0', '0', '0', '0'), ('8400', '-5', '0', '0', '0', '0'), ('8400', '-4', '0', '0', '0', '0'), ('8400', '-3', '0', '0', '0', '0'), ('8400', '-2', '0', '0', '0', '0'), ('8400', '-1', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('8400', '0', '0', '0', '0', '0'), ('8400', '1', '0', '0', '0', '0'), ('8400', '2', '0', '0', '0', '0'), ('8400', '3', '0', '0', '0', '0'), ('8400', '4', '0', '0', '0', '0'), ('8400', '5', '0', '0', '0', '0'), ('8400', '6', '0', '0', '0', '0'), ('8400', '7', '0', '0', '0', '0'), ('8400', '8', '0', '0', '0', '0'), ('8400', '9', '0', '0', '0', '0'), ('8400', '10', '0', '0', '0', '0'), ('8400', '11', '0', '0', '0', '0'), ('8400', '12', '0', '0', '0', '0'), ('8400', '13', '0', '0', '0', '0'), ('8400', '14', '0', '0', '0', '0'), ('8400', '15', '0', '0', '0', '0'), ('8400', '16', '0', '0', '0', '0'), ('8400', '17', '0', '0', '0', '0'), ('8400', '18', '0', '0', '0', '0'), ('8400', '19', '0', '0', '0', '0'), ('8400', '20', '0', '0', '0', '0'), ('8400', '21', '0', '0', '0', '0'), ('8400', '22', '0', '0', '0', '0'), ('8400', '23', '0', '0', '0', '0'), ('8400', '24', '0', '0', '0', '0'), ('8400', '25', '0', '0', '0', '0'), ('8400', '26', '0', '0', '0', '0'), ('8400', '27', '0', '0', '0', '0'), ('8400', '28', '0', '0', '0', '0'), ('8400', '29', '0', '0', '0', '0'), ('8400', '30', '0', '0', '0', '0'), ('8400', '31', '0', '0', '0', '0'), ('8400', '32', '0', '0', '0', '0'), ('8400', '33', '0', '0', '0', '0'), ('8400', '34', '0', '0', '0', '0'), ('8400', '35', '0', '0', '0', '0'), ('8400', '36', '0', '0', '0', '0'), ('8400', '37', '0', '0', '0', '0'), ('8500', '-11', '0', '0', '0', '0'), ('8500', '-10', '0', '0', '0', '0'), ('8500', '-9', '0', '0', '0', '0'), ('8500', '-8', '0', '0', '0', '0'), ('8500', '-7', '0', '0', '0', '0'), ('8500', '-6', '0', '0', '0', '0'), ('8500', '-5', '0', '0', '0', '0'), ('8500', '-4', '0', '0', '0', '0'), ('8500', '-3', '0', '0', '0', '0'), ('8500', '-2', '0', '0', '0', '0'), ('8500', '-1', '0', '0', '0', '0'), ('8500', '0', '0', '0', '0', '0'), ('8500', '1', '0', '0', '0', '0'), ('8500', '2', '0', '0', '0', '0'), ('8500', '3', '0', '0', '0', '0'), ('8500', '4', '0', '0', '0', '0'), ('8500', '5', '0', '0', '0', '0'), ('8500', '6', '0', '0', '0', '0'), ('8500', '7', '0', '0', '0', '0'), ('8500', '8', '0', '0', '0', '0'), ('8500', '9', '0', '0', '0', '0'), ('8500', '10', '0', '0', '0', '0'), ('8500', '11', '0', '0', '0', '0'), ('8500', '12', '0', '0', '0', '0'), ('8500', '13', '0', '0', '0', '0'), ('8500', '14', '0', '0', '0', '0'), ('8500', '15', '0', '0', '0', '0'), ('8500', '16', '0', '0', '0', '0'), ('8500', '17', '0', '0', '0', '0'), ('8500', '18', '0', '0', '0', '0'), ('8500', '19', '0', '0', '0', '0'), ('8500', '20', '0', '0', '0', '0'), ('8500', '21', '0', '0', '0', '0'), ('8500', '22', '0', '0', '0', '0'), ('8500', '23', '0', '0', '0', '0'), ('8500', '24', '0', '0', '0', '0'), ('8500', '25', '0', '0', '0', '0'), ('8500', '26', '0', '0', '0', '0'), ('8500', '27', '0', '0', '0', '0'), ('8500', '28', '0', '0', '0', '0'), ('8500', '29', '0', '0', '0', '0'), ('8500', '30', '0', '0', '0', '0'), ('8500', '31', '0', '0', '0', '0'), ('8500', '32', '0', '0', '0', '0'), ('8500', '33', '0', '0', '0', '0'), ('8500', '34', '0', '0', '0', '0'), ('8500', '35', '0', '0', '0', '0'), ('8500', '36', '0', '0', '0', '0'), ('8500', '37', '0', '0', '0', '0'), ('8600', '-11', '0', '0', '0', '0'), ('8600', '-10', '0', '0', '0', '0'), ('8600', '-9', '0', '0', '0', '0'), ('8600', '-8', '0', '0', '0', '0'), ('8600', '-7', '0', '0', '0', '0'), ('8600', '-6', '0', '0', '0', '0'), ('8600', '-5', '0', '0', '0', '0'), ('8600', '-4', '0', '0', '0', '0'), ('8600', '-3', '0', '0', '0', '0'), ('8600', '-2', '0', '0', '0', '0'), ('8600', '-1', '0', '0', '0', '0'), ('8600', '0', '0', '0', '0', '0'), ('8600', '1', '0', '0', '0', '0'), ('8600', '2', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('8600', '3', '0', '0', '0', '0'), ('8600', '4', '0', '0', '0', '0'), ('8600', '5', '0', '0', '0', '0'), ('8600', '6', '0', '0', '0', '0'), ('8600', '7', '0', '0', '0', '0'), ('8600', '8', '0', '0', '0', '0'), ('8600', '9', '0', '0', '0', '0'), ('8600', '10', '0', '0', '0', '0'), ('8600', '11', '0', '0', '0', '0'), ('8600', '12', '0', '0', '0', '0'), ('8600', '13', '0', '0', '0', '0'), ('8600', '14', '0', '0', '0', '0'), ('8600', '15', '0', '0', '0', '0'), ('8600', '16', '0', '0', '0', '0'), ('8600', '17', '0', '0', '0', '0'), ('8600', '18', '0', '0', '0', '0'), ('8600', '19', '0', '0', '0', '0'), ('8600', '20', '0', '0', '0', '0'), ('8600', '21', '0', '0', '0', '0'), ('8600', '22', '0', '0', '0', '0'), ('8600', '23', '0', '0', '0', '0'), ('8600', '24', '0', '0', '0', '0'), ('8600', '25', '0', '0', '0', '0'), ('8600', '26', '0', '0', '0', '0'), ('8600', '27', '0', '0', '0', '0'), ('8600', '28', '0', '0', '0', '0'), ('8600', '29', '0', '0', '0', '0'), ('8600', '30', '0', '0', '0', '0'), ('8600', '31', '0', '0', '0', '0'), ('8600', '32', '0', '0', '0', '0'), ('8600', '33', '0', '0', '0', '0'), ('8600', '34', '0', '0', '0', '0'), ('8600', '35', '0', '0', '0', '0'), ('8600', '36', '0', '0', '0', '0'), ('8600', '37', '0', '0', '0', '0'), ('8900', '-11', '0', '0', '0', '0'), ('8900', '-10', '0', '0', '0', '0'), ('8900', '-9', '0', '0', '0', '0'), ('8900', '-8', '0', '0', '0', '0'), ('8900', '-7', '0', '0', '0', '0'), ('8900', '-6', '0', '0', '0', '0'), ('8900', '-5', '0', '0', '0', '0'), ('8900', '-4', '0', '0', '0', '0'), ('8900', '-3', '0', '0', '0', '0'), ('8900', '-2', '0', '0', '0', '0'), ('8900', '-1', '0', '0', '0', '0'), ('8900', '0', '0', '0', '0', '0'), ('8900', '1', '0', '0', '0', '0'), ('8900', '2', '0', '0', '0', '0'), ('8900', '3', '0', '0', '0', '0'), ('8900', '4', '0', '0', '0', '0'), ('8900', '5', '0', '0', '0', '0'), ('8900', '6', '0', '0', '0', '0'), ('8900', '7', '0', '0', '0', '0'), ('8900', '8', '0', '0', '0', '0'), ('8900', '9', '0', '0', '0', '0'), ('8900', '10', '0', '0', '0', '0'), ('8900', '11', '0', '0', '0', '0'), ('8900', '12', '0', '0', '0', '0'), ('8900', '13', '0', '0', '0', '0'), ('8900', '14', '0', '0', '0', '0'), ('8900', '15', '0', '0', '0', '0'), ('8900', '16', '0', '0', '0', '0'), ('8900', '17', '0', '0', '0', '0'), ('8900', '18', '0', '0', '0', '0'), ('8900', '19', '0', '0', '0', '0'), ('8900', '20', '0', '0', '0', '0'), ('8900', '21', '0', '0', '0', '0'), ('8900', '22', '0', '0', '0', '0'), ('8900', '23', '0', '0', '0', '0'), ('8900', '24', '0', '0', '0', '0'), ('8900', '25', '0', '0', '0', '0'), ('8900', '26', '0', '0', '0', '0'), ('8900', '27', '0', '0', '0', '0'), ('8900', '28', '0', '0', '0', '0'), ('8900', '29', '0', '0', '0', '0'), ('8900', '30', '0', '0', '0', '0'), ('8900', '31', '0', '0', '0', '0'), ('8900', '32', '0', '0', '0', '0'), ('8900', '33', '0', '0', '0', '0'), ('8900', '34', '0', '0', '0', '0'), ('8900', '35', '0', '0', '0', '0'), ('8900', '36', '0', '0', '0', '0'), ('8900', '37', '0', '0', '0', '0'), ('9100', '-11', '0', '0', '0', '0'), ('9100', '-10', '0', '0', '0', '0'), ('9100', '-9', '0', '0', '0', '0'), ('9100', '-8', '0', '0', '0', '0'), ('9100', '-7', '0', '0', '0', '0'), ('9100', '-6', '0', '0', '0', '0'), ('9100', '-5', '0', '0', '0', '0'), ('9100', '-4', '0', '0', '0', '0'), ('9100', '-3', '0', '0', '0', '0'), ('9100', '-2', '0', '0', '0', '0'), ('9100', '-1', '0', '0', '0', '0'), ('9100', '0', '0', '0', '0', '0'), ('9100', '1', '0', '0', '0', '0'), ('9100', '2', '0', '0', '0', '0'), ('9100', '3', '0', '0', '0', '0'), ('9100', '4', '0', '0', '0', '0'), ('9100', '5', '0', '0', '0', '0');
INSERT INTO `chartdetails` VALUES ('9100', '6', '0', '0', '0', '0'), ('9100', '7', '0', '0', '0', '0'), ('9100', '8', '0', '0', '0', '0'), ('9100', '9', '0', '0', '0', '0'), ('9100', '10', '0', '0', '0', '0'), ('9100', '11', '0', '0', '0', '0'), ('9100', '12', '0', '0', '0', '0'), ('9100', '13', '0', '0', '0', '0'), ('9100', '14', '0', '0', '0', '0'), ('9100', '15', '0', '0', '0', '0'), ('9100', '16', '0', '0', '0', '0'), ('9100', '17', '0', '0', '0', '0'), ('9100', '18', '0', '0', '0', '0'), ('9100', '19', '0', '0', '0', '0'), ('9100', '20', '0', '0', '0', '0'), ('9100', '21', '0', '0', '0', '0'), ('9100', '22', '0', '0', '0', '0'), ('9100', '23', '0', '0', '0', '0'), ('9100', '24', '0', '0', '0', '0'), ('9100', '25', '0', '0', '0', '0'), ('9100', '26', '0', '0', '0', '0'), ('9100', '27', '0', '0', '0', '0'), ('9100', '28', '0', '0', '0', '0'), ('9100', '29', '0', '0', '0', '0'), ('9100', '30', '0', '0', '0', '0'), ('9100', '31', '0', '0', '0', '0'), ('9100', '32', '0', '0', '0', '0'), ('9100', '33', '0', '0', '0', '0'), ('9100', '34', '0', '0', '0', '0'), ('9100', '35', '0', '0', '0', '0'), ('9100', '36', '0', '0', '0', '0'), ('9100', '37', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `chartmaster`
-- ----------------------------
DROP TABLE IF EXISTS `chartmaster`;
CREATE TABLE `chartmaster` (
  `accountcode` int(11) NOT NULL default '0',
  `accountname` char(50) NOT NULL default '',
  `group_` char(30) NOT NULL default '',
  PRIMARY KEY  (`accountcode`),
  KEY `AccountName` (`accountname`),
  KEY `Group_` (`group_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of chartmaster
-- ----------------------------
INSERT INTO `chartmaster` VALUES ('1', 'Default Sales/Discounts', 'Sales'), ('1010', 'Petty Cash', 'Current Assets'), ('1020', 'Cash on Hand', 'Current Assets'), ('1030', 'Cheque Accounts', 'Current Assets'), ('1040', 'Savings Accounts', 'Current Assets'), ('1050', 'Payroll Accounts', 'Current Assets'), ('1060', 'Special Accounts', 'Current Assets'), ('1070', 'Money Market Investments', 'Current Assets'), ('1080', 'Short-Term Investments (< 90 days)', 'Current Assets'), ('1090', 'Interest Receivable', 'Current Assets'), ('1100', 'Accounts Receivable', 'Current Assets'), ('1150', 'Allowance for Doubtful Accounts', 'Current Assets'), ('1200', 'Notes Receivable', 'Current Assets'), ('1250', 'Income Tax Receivable', 'Current Assets'), ('1300', 'Prepaid Expenses', 'Current Assets'), ('1350', 'Advances', 'Current Assets'), ('1400', 'Supplies Inventory', 'Current Assets'), ('1420', 'Raw Material Inventory', 'Current Assets'), ('1440', 'Work in Progress Inventory', 'Current Assets'), ('1460', 'Finished Goods Inventory', 'Current Assets'), ('1500', 'Land', 'Fixed Assets'), ('1550', 'Bonds', 'Fixed Assets'), ('1600', 'Buildings', 'Fixed Assets'), ('1620', 'Accumulated Depreciation of Buildings', 'Fixed Assets'), ('1650', 'Equipment', 'Fixed Assets'), ('1670', 'Accumulated Depreciation of Equipment', 'Fixed Assets'), ('1700', 'Furniture & Fixtures', 'Fixed Assets'), ('1710', 'Accumulated Depreciation of Furniture & Fixtures', 'Fixed Assets'), ('1720', 'Office Equipment', 'Fixed Assets'), ('1730', 'Accumulated Depreciation of Office Equipment', 'Fixed Assets'), ('1740', 'Software', 'Fixed Assets'), ('1750', 'Accumulated Depreciation of Software', 'Fixed Assets'), ('1760', 'Vehicles', 'Fixed Assets'), ('1770', 'Accumulated Depreciation Vehicles', 'Fixed Assets'), ('1780', 'Other Depreciable Property', 'Fixed Assets'), ('1790', 'Accumulated Depreciation of Other Depreciable Prop', 'Fixed Assets'), ('1800', 'Patents', 'Fixed Assets'), ('1850', 'Goodwill', 'Fixed Assets'), ('1900', 'Future Income Tax Receivable', 'Current Assets'), ('2010', 'Bank Indedebtedness (overdraft)', 'Liabilities'), ('2020', 'Retainers or Advances on Work', 'Liabilities'), ('2050', 'Interest Payable', 'Liabilities'), ('2100', 'Accounts Payable', 'Liabilities'), ('2150', 'Goods Received Suspense', 'Liabilities'), ('2200', 'Short-Term Loan Payable', 'Liabilities'), ('2230', 'Current Portion of Long-Term Debt Payable', 'Liabilities'), ('2250', 'Income Tax Payable', 'Liabilities'), ('2300', 'GST Payable', 'Liabilities'), ('2310', 'GST Recoverable', 'Liabilities'), ('2320', 'PST Payable', 'Liabilities'), ('2330', 'PST Recoverable (commission)', 'Liabilities'), ('2340', 'Payroll Tax Payable', 'Liabilities'), ('2350', 'Withholding Income Tax Payable', 'Liabilities'), ('2360', 'Other Taxes Payable', 'Liabilities'), ('2400', 'Employee Salaries Payable', 'Liabilities'), ('2410', 'Management Salaries Payable', 'Liabilities'), ('2420', 'Director / Partner Fees Payable', 'Liabilities'), ('2450', 'Health Benefits Payable', 'Liabilities'), ('2460', 'Pension Benefits Payable', 'Liabilities'), ('2470', 'Canada Pension Plan Payable', 'Liabilities'), ('2480', 'Employment Insurance Premiums Payable', 'Liabilities'), ('2500', 'Land Payable', 'Liabilities'), ('2550', 'Long-Term Bank Loan', 'Liabilities'), ('2560', 'Notes Payable', 'Liabilities'), ('2600', 'Building & Equipment Payable', 'Liabilities'), ('2700', 'Furnishing & Fixture Payable', 'Liabilities'), ('2720', 'Office Equipment Payable', 'Liabilities'), ('2740', 'Vehicle Payable', 'Liabilities'), ('2760', 'Other Property Payable', 'Liabilities'), ('2800', 'Shareholder Loans', 'Liabilities'), ('2900', 'Suspense', 'Liabilities'), ('3100', 'Capital Stock', 'Equity'), ('3200', 'Capital Surplus / Dividends', 'Equity'), ('3300', 'Dividend Taxes Payable', 'Equity'), ('3400', 'Dividend Taxes Refundable', 'Equity'), ('3500', 'Retained Earnings', 'Equity'), ('4100', 'Product / Service Sales', 'Revenue'), ('4200', 'Sales Exchange Gains/Losses', 'Revenue'), ('4500', 'Consulting Services', 'Revenue'), ('4600', 'Rentals', 'Revenue'), ('4700', 'Finance Charge Income', 'Revenue'), ('4800', 'Sales Returns & Allowances', 'Revenue'), ('4900', 'Sales Discounts', 'Revenue'), ('5000', 'Cost of Sales', 'Cost of Goods Sold'), ('5100', 'Production Expenses', 'Cost of Goods Sold'), ('5200', 'Purchases Exchange Gains/Losses', 'Cost of Goods Sold'), ('5500', 'Direct Labour Costs', 'Cost of Goods Sold'), ('5600', 'Freight Charges', 'Outward Freight'), ('5700', 'Inventory Adjustment', 'Cost of Goods Sold'), ('5800', 'Purchase Returns & Allowances', 'Cost of Goods Sold'), ('5900', 'Purchase Discounts', 'Cost of Goods Sold'), ('6100', 'Advertising', 'Marketing Expenses'), ('6150', 'Promotion', 'Promotions'), ('6200', 'Communications', 'Marketing Expenses'), ('6250', 'Meeting Expenses', 'Marketing Expenses'), ('6300', 'Travelling Expenses', 'Marketing Expenses'), ('6400', 'Delivery Expenses', 'Marketing Expenses'), ('6500', 'Sales Salaries & Commission', 'Marketing Expenses'), ('6550', 'Sales Salaries & Commission Deductions', 'Marketing Expenses'), ('6590', 'Benefits', 'Marketing Expenses'), ('6600', 'Other Selling Expenses', 'Marketing Expenses');
INSERT INTO `chartmaster` VALUES ('6700', 'Permits, Licenses & License Fees', 'Marketing Expenses'), ('6800', 'Research & Development', 'Marketing Expenses'), ('6900', 'Professional Services', 'Marketing Expenses'), ('7020', 'Support Salaries & Wages', 'Operating Expenses'), ('7030', 'Support Salary & Wage Deductions', 'Operating Expenses'), ('7040', 'Management Salaries', 'Operating Expenses'), ('7050', 'Management Salary deductions', 'Operating Expenses'), ('7060', 'Director / Partner Fees', 'Operating Expenses'), ('7070', 'Director / Partner Deductions', 'Operating Expenses'), ('7080', 'Payroll Tax', 'Operating Expenses'), ('7090', 'Benefits', 'Operating Expenses'), ('7100', 'Training & Education Expenses', 'Operating Expenses'), ('7150', 'Dues & Subscriptions', 'Operating Expenses'), ('7200', 'Accounting Fees', 'Operating Expenses'), ('7210', 'Audit Fees', 'Operating Expenses'), ('7220', 'Banking Fees', 'Operating Expenses'), ('7230', 'Credit Card Fees', 'Operating Expenses'), ('7240', 'Consulting Fees', 'Operating Expenses'), ('7260', 'Legal Fees', 'Operating Expenses'), ('7280', 'Other Professional Fees', 'Operating Expenses'), ('7300', 'Business Tax', 'Operating Expenses'), ('7350', 'Property Tax', 'Operating Expenses'), ('7390', 'Corporation Capital Tax', 'Operating Expenses'), ('7400', 'Office Rent', 'Operating Expenses'), ('7450', 'Equipment Rental', 'Operating Expenses'), ('7500', 'Office Supplies', 'Operating Expenses'), ('7550', 'Office Repair & Maintenance', 'Operating Expenses'), ('7600', 'Automotive Expenses', 'Operating Expenses'), ('7610', 'Communication Expenses', 'Operating Expenses'), ('7620', 'Insurance Expenses', 'Operating Expenses'), ('7630', 'Postage & Courier Expenses', 'Operating Expenses'), ('7640', 'Miscellaneous Expenses', 'Operating Expenses'), ('7650', 'Travel Expenses', 'Operating Expenses'), ('7660', 'Utilities', 'Operating Expenses'), ('7700', 'Ammortization Expenses', 'Operating Expenses'), ('7750', 'Depreciation Expenses', 'Operating Expenses'), ('7800', 'Interest Expense', 'Operating Expenses'), ('7900', 'Bad Debt Expense', 'Operating Expenses'), ('8100', 'Gain on Sale of Assets', 'Other Revenue and Expenses'), ('8200', 'Interest Income', 'Other Revenue and Expenses'), ('8300', 'Recovery on Bad Debt', 'Other Revenue and Expenses'), ('8400', 'Other Revenue', 'Other Revenue and Expenses'), ('8500', 'Loss on Sale of Assets', 'Other Revenue and Expenses'), ('8600', 'Charitable Contributions', 'Other Revenue and Expenses'), ('8900', 'Other Expenses', 'Other Revenue and Expenses'), ('9100', 'Income Tax Provision', 'Income Tax');

-- ----------------------------
-- Table structure for `cogsglpostings`
-- ----------------------------
DROP TABLE IF EXISTS `cogsglpostings`;
CREATE TABLE `cogsglpostings` (
  `id` int(11) NOT NULL auto_increment,
  `area` char(3) NOT NULL default '',
  `stkcat` varchar(6) NOT NULL default '',
  `glcode` int(11) NOT NULL default '0',
  `salestype` char(2) NOT NULL default 'AN',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `Area_StkCat` (`area`,`stkcat`,`salestype`),
  KEY `Area` (`area`),
  KEY `StkCat` (`stkcat`),
  KEY `GLCode` (`glcode`),
  KEY `SalesType` (`salestype`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cogsglpostings
-- ----------------------------
INSERT INTO `cogsglpostings` VALUES ('3', 'AN', 'ANY', '5000', 'AN');

-- ----------------------------
-- Table structure for `companies`
-- ----------------------------
DROP TABLE IF EXISTS `companies`;
CREATE TABLE `companies` (
  `coycode` int(11) NOT NULL default '1',
  `coyname` varchar(50) NOT NULL default '',
  `gstno` varchar(20) NOT NULL default '',
  `companynumber` varchar(20) NOT NULL default '0',
  `regoffice1` varchar(40) NOT NULL default '',
  `regoffice2` varchar(40) NOT NULL default '',
  `regoffice3` varchar(40) NOT NULL default '',
  `regoffice4` varchar(40) NOT NULL default '',
  `regoffice5` varchar(20) NOT NULL default '',
  `regoffice6` varchar(15) NOT NULL default '',
  `telephone` varchar(25) NOT NULL default '',
  `fax` varchar(25) NOT NULL default '',
  `email` varchar(55) NOT NULL default '',
  `currencydefault` varchar(4) NOT NULL default '',
  `debtorsact` int(11) NOT NULL default '70000',
  `pytdiscountact` int(11) NOT NULL default '55000',
  `creditorsact` int(11) NOT NULL default '80000',
  `payrollact` int(11) NOT NULL default '84000',
  `grnact` int(11) NOT NULL default '72000',
  `exchangediffact` int(11) NOT NULL default '65000',
  `purchasesexchangediffact` int(11) NOT NULL default '0',
  `retainedearnings` int(11) NOT NULL default '90000',
  `gllink_debtors` tinyint(1) default '1',
  `gllink_creditors` tinyint(1) default '1',
  `gllink_stock` tinyint(1) default '1',
  `freightact` int(11) NOT NULL default '0',
  PRIMARY KEY  (`coycode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of companies
-- ----------------------------
INSERT INTO `companies` VALUES ('1', 'airadsfinance', 'not entered yet', '', '123 Web Way', 'PO Box 123', 'Queen Street', 'Melbourne', 'Victoria 3043', 'Australia', '+61 3 4567 8901', '+61 3 4567 8902', 'weberp@weberpdemo.com', 'AUD', '1100', '4900', '2100', '2400', '2150', '4200', '5200', '3500', '1', '1', '1', '5600');

-- ----------------------------
-- Table structure for `config`
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `confname` varchar(35) NOT NULL default '',
  `confvalue` text NOT NULL,
  PRIMARY KEY  (`confname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES ('AllowOrderLineItemNarrative', '1'), ('AllowSalesOfZeroCostItems', '0'), ('AutoCreateWOs', '1'), ('AutoDebtorNo', '0'), ('AutoIssue', '1'), ('CheckCreditLimits', '1'), ('Check_Price_Charged_vs_Order_Price', '1'), ('Check_Qty_Charged_vs_Del_Qty', '1'), ('CountryOfOperation', 'AUD'), ('CreditingControlledItems_MustExist', '0'), ('DB_Maintenance', '30'), ('DB_Maintenance_LastRun', '2011-06-17'), ('DefaultBlindPackNote', '1'), ('DefaultCreditLimit', '1000'), ('DefaultCustomerType', '1'), ('DefaultDateFormat', 'd/m/Y'), ('DefaultDisplayRecordsMax', '50'), ('DefaultFactoryLocation', 'MEL'), ('DefaultPriceList', 'DE'), ('DefaultSupplierType', '1'), ('DefaultTaxCategory', '1'), ('DefaultTheme', 'silverwolf'), ('Default_Shipper', '1'), ('DefineControlledOnWOEntry', '1'), ('DispatchCutOffTime', '14'), ('DoFreightCalc', '0'), ('EDIHeaderMsgId', 'D:01B:UN:EAN010'), ('EDIReference', 'WEBERP'), ('EDI_Incoming_Orders', 'companies/weberpdemo/EDI_Incoming_Orders'), ('EDI_MsgPending', 'companies/weberpdemo/EDI_MsgPending'), ('EDI_MsgSent', 'companies/weberpdemo/EDI_Sent'), ('Extended_CustomerInfo', '0'), ('Extended_SupplierInfo', '0'), ('FactoryManagerEmail', 'manager@company.com'), ('FreightChargeAppliesIfLessThan', '1000'), ('FreightTaxCategory', '1'), ('FrequentlyOrderedItems', '0'), ('geocode_integration', '0'), ('HTTPS_Only', '0'), ('InvoicePortraitFormat', '1'), ('LogPath', ''), ('LogSeverity', '0'), ('MaxImageSize', '300'), ('MonthsAuditTrail', '1'), ('NumberOfMonthMustBeShown', '6'), ('NumberOfPeriodsOfStockUsage', '12'), ('OverChargeProportion', '30'), ('OverReceiveProportion', '20'), ('PackNoteFormat', '1'), ('PageLength', '48'), ('part_pics_dir', 'companies/weberpdemo/part_pics'), ('PastDueDays1', '30'), ('PastDueDays2', '60'), ('PO_AllowSameItemMultipleTimes', '1'), ('ProhibitJournalsToControlAccounts', '1'), ('ProhibitNegativeStock', '1'), ('ProhibitPostingsBefore', '2010-09-30'), ('PurchasingManagerEmail', ''), ('QuickEntries', '10'), ('RadioBeaconFileCounter', '/home/RadioBeacon/FileCounter'), ('RadioBeaconFTP_user_name', 'RadioBeacon ftp server user name'), ('RadioBeaconHomeDir', '/home/RadioBeacon'), ('RadioBeaconStockLocation', 'BL'), ('RadioBraconFTP_server', '192.168.2.2'), ('RadioBreaconFilePrefix', 'ORDXX'), ('RadionBeaconFTP_user_pass', 'Radio Beacon remote ftp server password'), ('reports_dir', 'companies/weberpdemo/reportwriter'), ('RequirePickingNote', '0'), ('RomalpaClause', 'Ownership will not pass to the buyer until the goods have been paid for in full.'), ('ShowValueOnGRN', '1'), ('Show_Settled_LastMonth', '1'), ('SO_AllowSameItemMultipleTimes', '1'), ('TaxAuthorityReferenceName', 'Tax Ref'), ('UpdateCurrencyRatesDaily', '0'), ('VersionNumber', '4.00RC1'), ('WeightedAverageCosting', '1'), ('WikiApp', 'Disabled'), ('WikiPath', 'wiki'), ('YearEnd', '3');

-- ----------------------------
-- Table structure for `contractbom`
-- ----------------------------
DROP TABLE IF EXISTS `contractbom`;
CREATE TABLE `contractbom` (
  `contractref` varchar(20) NOT NULL default '0',
  `stockid` varchar(20) NOT NULL default '',
  `workcentreadded` char(5) NOT NULL default '',
  `quantity` double NOT NULL default '1',
  PRIMARY KEY  (`contractref`,`stockid`,`workcentreadded`),
  KEY `Stockid` (`stockid`),
  KEY `ContractRef` (`contractref`),
  KEY `WorkCentreAdded` (`workcentreadded`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contractbom
-- ----------------------------
INSERT INTO `contractbom` VALUES ('BIGEARS12', 'DVD-CASE', 'MEL', '100'), ('BirthdayCakeConstruc', 'BREAD', 'MEL', '5'), ('BirthdayCakeConstruc', 'DVD-CASE', 'MEL', '1'), ('BirthdayCakeConstruc', 'FLOUR', 'MEL', '200'), ('BirthdayCakeConstruc', 'SALT', 'MEL', '1.5'), ('BirthdayCakeConstruc', 'YEAST', 'MEL', '1.665'), ('Testing_231', 'BREAD', 'MEL', '2'), ('Testing_231', 'YEAST', 'MEL', '1');

-- ----------------------------
-- Table structure for `contractcharges`
-- ----------------------------
DROP TABLE IF EXISTS `contractcharges`;
CREATE TABLE `contractcharges` (
  `id` int(11) NOT NULL auto_increment,
  `contractref` varchar(20) NOT NULL,
  `transtype` smallint(6) NOT NULL default '20',
  `transno` int(11) NOT NULL default '0',
  `amount` double NOT NULL default '0',
  `narrative` text NOT NULL,
  `anticipated` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `contractref` (`contractref`,`transtype`,`transno`),
  KEY `contractcharges_ibfk_2` (`transtype`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contractcharges
-- ----------------------------
INSERT INTO `contractcharges` VALUES ('1', 'BirthdayCakeConstruc', '20', '20', '1569.0625', 'TEsting one two three', '0'), ('2', 'BirthdayCakeConstruc', '20', '21', '12.5', 'test 9844', '0'), ('3', 'BirthdayCakeConstruc', '20', '22', '125', 'te 9554788 great', '1'), ('4', 'BirthdayCakeConstruc', '20', '0', '-112.5', 'TEsting one two three', '1'), ('6', 'BirthdayCakeConstruc', '20', '0', '-125', 'if you think so', '0'), ('8', 'BirthdayCakeConstruc', '21', '7', '-122.7625', 'I hope so', '1'), ('9', 'BirthdayCakeConstruc', '21', '7', '-7.75', 'And this one too', '0');

-- ----------------------------
-- Table structure for `contractreqts`
-- ----------------------------
DROP TABLE IF EXISTS `contractreqts`;
CREATE TABLE `contractreqts` (
  `contractreqid` int(11) NOT NULL auto_increment,
  `contractref` varchar(20) NOT NULL default '0',
  `requirement` varchar(40) NOT NULL default '',
  `quantity` double NOT NULL default '1',
  `costperunit` double NOT NULL default '0',
  PRIMARY KEY  (`contractreqid`),
  KEY `ContractRef` (`contractref`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contractreqts
-- ----------------------------
INSERT INTO `contractreqts` VALUES ('16', 'BIGEARS12', 'Film', '200', '3.25'), ('17', 'BIGEARS12', 'Cast', '16', '35'), ('18', 'BIGEARS12', 'Director', '15', '150'), ('19', 'BirthdayCakeConstruc', 'Labour', '13', '25'), ('23', 'Testing_231', 'Foil', '2', '0.2'), ('24', 'Testing_231', 'Grease proof paper', '5', '0.1'), ('25', 'Testing_231', 'Travel', '2', '40');

-- ----------------------------
-- Table structure for `contracts`
-- ----------------------------
DROP TABLE IF EXISTS `contracts`;
CREATE TABLE `contracts` (
  `contractref` varchar(20) NOT NULL default '',
  `contractdescription` text NOT NULL,
  `debtorno` varchar(10) NOT NULL default '',
  `branchcode` varchar(10) NOT NULL default '',
  `loccode` varchar(5) NOT NULL default '',
  `status` tinyint(4) NOT NULL default '0',
  `categoryid` varchar(6) NOT NULL default '',
  `orderno` int(11) NOT NULL default '0',
  `customerref` varchar(20) NOT NULL default '',
  `margin` double NOT NULL default '1',
  `wo` int(11) NOT NULL default '0',
  `requireddate` date NOT NULL default '0000-00-00',
  `drawing` varchar(50) NOT NULL default '',
  `exrate` double NOT NULL default '1',
  PRIMARY KEY  (`contractref`),
  KEY `OrderNo` (`orderno`),
  KEY `CategoryID` (`categoryid`),
  KEY `Status` (`status`),
  KEY `WO` (`wo`),
  KEY `DebtorNo` (`debtorno`,`branchcode`),
  KEY `loccode` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contracts
-- ----------------------------
INSERT INTO `contracts` VALUES ('BIGEARS12', 'Big Ears and Noddy episodes on DVD', 'QUARTER', 'QUARTER', 'MEL', '2', 'DVD', '22', '89-OOPDS', '35', '13', '2010-10-15', '', '1'), ('BirthdayCakeConstruc', '12 foot birthday cake for wrestling tournament', 'DUMBLE', 'DUMBLE', 'MEL', '3', 'BAKE', '23', '', '33', '12', '2010-12-20', '', '0.8'), ('Testing_231', 'Some cooking  jobs', 'QUARTER', 'QUARTER', 'MEL', '0', 'FOOD', '0', '', '50', '0', '2010-09-15', '', '1');

-- ----------------------------
-- Table structure for `currencies`
-- ----------------------------
DROP TABLE IF EXISTS `currencies`;
CREATE TABLE `currencies` (
  `currency` char(20) NOT NULL default '',
  `currabrev` char(3) NOT NULL default '',
  `country` char(50) NOT NULL default '',
  `hundredsname` char(15) NOT NULL default 'Cents',
  `decimalplaces` tinyint(3) NOT NULL default '2',
  `rate` double NOT NULL default '1',
  PRIMARY KEY  (`currabrev`),
  KEY `Country` (`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of currencies
-- ----------------------------
INSERT INTO `currencies` VALUES ('Australian Dollars', 'AUD', 'Australia', 'cents', '2', '1'), ('Swiss Francs', 'CHF', 'Swizerland', 'centimes', '2', '1'), ('Euro', 'EUR', 'Euroland', 'cents', '2', '0.44'), ('Pounds', 'GBP', 'England', 'Pence', '2', '0.8'), ('US Dollars', 'USD', 'United States', 'Cents', '2', '0.85');

-- ----------------------------
-- Table structure for `custallocns`
-- ----------------------------
DROP TABLE IF EXISTS `custallocns`;
CREATE TABLE `custallocns` (
  `id` int(11) NOT NULL auto_increment,
  `amt` decimal(20,4) NOT NULL default '0.0000',
  `datealloc` date NOT NULL default '0000-00-00',
  `transid_allocfrom` int(11) NOT NULL default '0',
  `transid_allocto` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `DateAlloc` (`datealloc`),
  KEY `TransID_AllocFrom` (`transid_allocfrom`),
  KEY `TransID_AllocTo` (`transid_allocto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of custallocns
-- ----------------------------
INSERT INTO `custallocns` VALUES ('1', '15.9500', '2007-08-02', '2', '1'), ('2', '117.5000', '2010-05-31', '18', '17');

-- ----------------------------
-- Table structure for `custbranch`
-- ----------------------------
DROP TABLE IF EXISTS `custbranch`;
CREATE TABLE `custbranch` (
  `branchcode` varchar(10) NOT NULL default '',
  `debtorno` varchar(10) NOT NULL default '',
  `brname` varchar(40) NOT NULL default '',
  `braddress1` varchar(40) NOT NULL default '',
  `braddress2` varchar(40) NOT NULL default '',
  `braddress3` varchar(40) NOT NULL default '',
  `braddress4` varchar(50) NOT NULL default '',
  `braddress5` varchar(20) NOT NULL default '',
  `braddress6` varchar(15) NOT NULL default '',
  `lat` float(10,6) NOT NULL default '0.000000',
  `lng` float(10,6) NOT NULL default '0.000000',
  `estdeliverydays` smallint(6) NOT NULL default '1',
  `area` char(3) NOT NULL,
  `salesman` varchar(4) NOT NULL default '',
  `fwddate` smallint(6) NOT NULL default '0',
  `phoneno` varchar(20) NOT NULL default '',
  `faxno` varchar(20) NOT NULL default '',
  `contactname` varchar(30) NOT NULL default '',
  `email` varchar(55) NOT NULL default '',
  `defaultlocation` varchar(5) NOT NULL default '',
  `taxgroupid` tinyint(4) NOT NULL default '1',
  `defaultshipvia` int(11) NOT NULL default '1',
  `deliverblind` tinyint(1) default '1',
  `disabletrans` tinyint(4) NOT NULL default '0',
  `brpostaddr1` varchar(40) NOT NULL default '',
  `brpostaddr2` varchar(40) NOT NULL default '',
  `brpostaddr3` varchar(30) NOT NULL default '',
  `brpostaddr4` varchar(20) NOT NULL default '',
  `brpostaddr5` varchar(20) NOT NULL default '',
  `brpostaddr6` varchar(15) NOT NULL default '',
  `specialinstructions` text NOT NULL,
  `custbranchcode` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`branchcode`,`debtorno`),
  KEY `BrName` (`brname`),
  KEY `DebtorNo` (`debtorno`),
  KEY `Salesman` (`salesman`),
  KEY `Area` (`area`),
  KEY `DefaultLocation` (`defaultlocation`),
  KEY `DefaultShipVia` (`defaultshipvia`),
  KEY `taxgroupid` (`taxgroupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of custbranch
-- ----------------------------
INSERT INTO `custbranch` VALUES ('ANGRY', 'ANGRY', 'Angus Rouledge - Toronto', 'P O Box 671', 'Gowerbridge', 'Upperton', 'Toronto ', 'Canada', '', '0.000000', '0.000000', '3', 'TR', 'ERI', '0', '0422 2245 2213', '0422 2245 2215', 'Granville Thomas', 'graville@angry.com', 'TOR', '2', '1', '1', '0', '', '', '', '', '', '', '', ''), ('ANGRYFL', 'ANGRY', 'Angus Rouledge - Florida', '1821 Sunnyside', 'Ft Lauderdale', 'Florida', '42554', '', '', '0.000000', '0.000000', '3', 'FL', 'PHO', '0', '2445 2232 524', '2445 2232 522', 'Wendy Blowers', 'wendy@angry.com', 'TOR', '1', '1', '1', '0', '', '', '', '', '', '', 'Watch out can bite!', ''), ('DUMBLE', 'DUMBLE', 'Dumbledoor McGonagal & Co', 'Hogwarts castle', 'Platform 9.75', '', '', '', '', '0.000000', '0.000000', '1', 'TR', 'ERI', '0', 'Owls only', 'Owls only', 'Minerva McGonagal', 'mmgonagal@hogwarts.edu.uk', 'TOR', '3', '10', '1', '0', '', '', '', '', '', '', '', ''), ('JOLOMU', 'JOLOMU', 'Lorrima Productions Inc', '3215 Great Western Highway', 'Blubberhouses', 'Yorkshire', 'England', '', '', '0.000000', '0.000000', '20', 'FL', 'PHO', '0', '+44 812 211456', '+44 812 211 554', 'Jo Lomu', 'jolomu@lorrima.co.uk', 'TOR', '3', '1', '1', '0', '', '', '', '', '', '', '', ''), ('QUARTER', 'QUARTER', 'Quarter Back to Back', '1356 Union Drive', 'Holborn', 'England', '', '', '', '0.000000', '0.000000', '5', 'FL', 'ERI', '0', '123456', '1234567', '', '', 'TOR', '3', '1', '1', '0', '', '', '', '', '', '', '', ''), ('QUIC', 'QUICK', 'Quick Brown PLC', 'Fox Street', 'Jumped Over', 'The Lazy Dog', '', '', '', '0.000000', '0.000000', '1', 'FL', 'ERI', '0', '', '', '', '', 'TOR', '1', '1', '1', '0', '', '', '', '', '', '', '', ''), ('SLOW', 'QUICK', 'Slow Dog', 'Hunstman Road', 'Woofton', '', '', '', '', '0.000000', '0.000000', '1', 'TR', 'ERI', '0', '', '', 'Staffordshire Terrier', '', 'TOR', '2', '1', '1', '0', '', '', '', '', '', '', '', '');

-- ----------------------------
-- Table structure for `custcontacts`
-- ----------------------------
DROP TABLE IF EXISTS `custcontacts`;
CREATE TABLE `custcontacts` (
  `contid` int(11) NOT NULL auto_increment,
  `debtorno` varchar(10) NOT NULL,
  `contactname` varchar(40) NOT NULL,
  `role` varchar(40) NOT NULL,
  `phoneno` varchar(20) NOT NULL,
  `notes` varchar(255) NOT NULL,
  PRIMARY KEY  (`contid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of custcontacts
-- ----------------------------
INSERT INTO `custcontacts` VALUES ('2', 'ANGRY', 'Hamish McKay', 'CEO', '12334302', 'Whisky drinker single malt only'), ('3', 'ANGRY', 'Gavin McDonald', 'Purchasing', '12334990', 'Golfer, 5 handicap'), ('4', 'ANGRY', 'Bill (William) Wallace', 'Mover and ', '10292811', 'English hater!'), ('5', 'ANGRY', 'Bob (Robert) Bruce', 'Chairman', '10292811', '');

-- ----------------------------
-- Table structure for `custnotes`
-- ----------------------------
DROP TABLE IF EXISTS `custnotes`;
CREATE TABLE `custnotes` (
  `noteid` tinyint(4) NOT NULL auto_increment,
  `debtorno` varchar(10) NOT NULL default '0',
  `href` varchar(100) NOT NULL,
  `note` text NOT NULL,
  `date` date NOT NULL default '0000-00-00',
  `priority` varchar(20) NOT NULL,
  PRIMARY KEY  (`noteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of custnotes
-- ----------------------------

-- ----------------------------
-- Table structure for `debtorsmaster`
-- ----------------------------
DROP TABLE IF EXISTS `debtorsmaster`;
CREATE TABLE `debtorsmaster` (
  `debtorno` varchar(10) NOT NULL default '',
  `name` varchar(40) NOT NULL default '',
  `address1` varchar(40) NOT NULL default '',
  `address2` varchar(40) NOT NULL default '',
  `address3` varchar(40) NOT NULL default '',
  `address4` varchar(50) NOT NULL default '',
  `address5` varchar(20) NOT NULL default '',
  `address6` varchar(15) NOT NULL default '',
  `currcode` char(3) NOT NULL default '',
  `salestype` char(2) NOT NULL default '',
  `clientsince` datetime NOT NULL default '0000-00-00 00:00:00',
  `holdreason` smallint(6) NOT NULL default '0',
  `paymentterms` char(2) NOT NULL default 'f',
  `discount` double NOT NULL default '0',
  `pymtdiscount` double NOT NULL default '0',
  `lastpaid` double NOT NULL default '0',
  `lastpaiddate` datetime default NULL,
  `creditlimit` double NOT NULL default '1000',
  `invaddrbranch` tinyint(4) NOT NULL default '0',
  `discountcode` char(2) NOT NULL default '',
  `ediinvoices` tinyint(4) NOT NULL default '0',
  `ediorders` tinyint(4) NOT NULL default '0',
  `edireference` varchar(20) NOT NULL default '',
  `editransport` varchar(5) NOT NULL default 'email',
  `ediaddress` varchar(50) NOT NULL default '',
  `ediserveruser` varchar(20) NOT NULL default '',
  `ediserverpwd` varchar(20) NOT NULL default '',
  `taxref` varchar(20) NOT NULL default '',
  `customerpoline` tinyint(1) NOT NULL default '0',
  `typeid` tinyint(4) NOT NULL default '1',
  PRIMARY KEY  (`debtorno`),
  KEY `Currency` (`currcode`),
  KEY `HoldReason` (`holdreason`),
  KEY `Name` (`name`),
  KEY `PaymentTerms` (`paymentterms`),
  KEY `SalesType` (`salestype`),
  KEY `EDIInvoices` (`ediinvoices`),
  KEY `EDIOrders` (`ediorders`),
  KEY `debtorsmaster_ibfk_5` (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of debtorsmaster
-- ----------------------------
INSERT INTO `debtorsmaster` VALUES ('ANGRY', 'Angus Rouledge Younger &amp; Son', 'P O Box 67', 'Gowerbridge', 'Upperton', 'Michigan', '', '', 'USD', 'DE', '2005-04-30 00:00:00', '1', '7', '0', '0', '117.5', '2010-05-31 00:00:00', '5000', '0', '', '0', '0', '', 'email', '', '', '', '1344-654-112', '0', '1'), ('DUMBLE', 'Dumbledoor McGonagal & Co', 'Hogwarts castle', 'Platform 9.75', '', '', '', '', 'GBP', 'DE', '2005-06-18 00:00:00', '1', '30', '0', '0', '0', null, '1000', '0', '', '0', '0', '', 'email', '', '', '', '', '0', '1'), ('JOLOMU', 'Lorrima Productions Inc', '3215 Great Western Highway', 'Blubberhouses', 'Yorkshire', 'England', '', '', 'GBP', 'DE', '2005-06-15 00:00:00', '1', '30', '0', '0', '0', null, '1000', '0', '', '0', '0', '', 'email', '', '', '', '', '0', '1'), ('QUARTER', 'Quarter Back to Back', '1356 Union Drive', 'Holborn', 'England', '', '', '', 'CHF', 'DE', '2005-09-03 00:00:00', '1', '20', '0', '0', '0', null, '1000', '0', '', '0', '0', '', 'email', '', '', '', '', '0', '1'), ('QUICK', 'Quick Brown PLC', 'Fox Street', 'Jumped Over', 'The Lazy Dog', '', '', '', 'USD', 'DE', '2007-01-30 00:00:00', '1', '20', '0', '0', '0', null, '1000', '0', '', '0', '0', '', 'email', '', '', '', '', '0', '1');

-- ----------------------------
-- Table structure for `debtortrans`
-- ----------------------------
DROP TABLE IF EXISTS `debtortrans`;
CREATE TABLE `debtortrans` (
  `id` int(11) NOT NULL auto_increment,
  `transno` int(11) NOT NULL default '0',
  `type` smallint(6) NOT NULL default '0',
  `debtorno` varchar(10) NOT NULL default '',
  `branchcode` varchar(10) NOT NULL default '',
  `trandate` datetime NOT NULL default '0000-00-00 00:00:00',
  `inputdate` datetime NOT NULL,
  `prd` smallint(6) NOT NULL default '0',
  `settled` tinyint(4) NOT NULL default '0',
  `reference` varchar(20) NOT NULL default '',
  `tpe` char(2) NOT NULL default '',
  `order_` int(11) NOT NULL default '0',
  `rate` double NOT NULL default '0',
  `ovamount` double NOT NULL default '0',
  `ovgst` double NOT NULL default '0',
  `ovfreight` double NOT NULL default '0',
  `ovdiscount` double NOT NULL default '0',
  `diffonexch` double NOT NULL default '0',
  `alloc` double NOT NULL default '0',
  `invtext` text,
  `shipvia` int(11) NOT NULL default '0',
  `edisent` tinyint(4) NOT NULL default '0',
  `consignment` varchar(15) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `DebtorNo` (`debtorno`,`branchcode`),
  KEY `Order_` (`order_`),
  KEY `Prd` (`prd`),
  KEY `Tpe` (`tpe`),
  KEY `Type` (`type`),
  KEY `Settled` (`settled`),
  KEY `TranDate` (`trandate`),
  KEY `TransNo` (`transno`),
  KEY `Type_2` (`type`,`transno`),
  KEY `EDISent` (`edisent`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of debtortrans
-- ----------------------------
INSERT INTO `debtortrans` VALUES ('1', '1', '10', 'QUARTER', 'QUARTER', '2007-06-26 00:00:00', '0000-00-00 00:00:00', '2', '0', '', 'DE', '1', '1', '46.4', '0', '0', '0', '0', '15.95', 'Some narrative for testing the output on the printed invoice', '1', '0', ''), ('2', '1', '11', 'QUARTER', 'QUARTER', '2007-08-02 00:00:00', '0000-00-00 00:00:00', '3', '1', 'Inv-1', 'DE', '1', '1', '-15.95', '0', '0', '0', '0', '-15.95', '', '0', '0', ''), ('3', '2', '12', 'ANGRY', '', '2009-02-04 00:00:00', '0000-00-00 00:00:00', '21', '0', 'Cash ', '', '0', '1', '-99', '0', '0', '0', '0', '0', '', '0', '0', ''), ('5', '4', '10', 'ANGRY', 'ANGRY', '2010-05-31 00:00:00', '2010-05-31 12:02:42', '-11', '0', '', 'DE', '8', '1', '28.38', '0', '0', '0', '0', '0', 'Testing comments', '1', '0', ''), ('6', '5', '10', 'ANGRY', 'ANGRY', '2010-05-31 00:00:00', '2010-05-31 12:09:46', '-11', '0', '211547', 'DE', '9', '1', '26.40515', '0', '0', '0', '0', '0', '', '1', '0', ''), ('7', '6', '10', 'ANGRY', 'ANGRY', '2010-05-31 00:00:00', '2010-05-31 12:14:47', '-11', '0', '', 'DE', '10', '1', '24', '0', '0', '0', '0', '0', '', '1', '0', ''), ('8', '7', '10', 'ANGRY', 'ANGRY', '2010-05-31 00:00:00', '2010-05-31 12:53:46', '-11', '0', '', 'DE', '11', '1', '0', '0', '0', '0', '0', '0', '', '1', '0', ''), ('9', '2', '11', 'ANGRY', 'ANGRY', '2010-05-31 00:00:00', '2010-05-31 12:55:30', '36', '0', 'Inv-7', 'DE', '11', '1', '0', '0', '0', '0', '0', '0', '', '0', '0', ''), ('11', '9', '10', 'ANGRY', 'ANGRY', '2010-05-31 00:00:00', '2010-05-31 16:49:14', '-11', '0', '', 'DE', '13', '1', '50', '0', '0', '0', '0', '0', '', '1', '0', ''), ('12', '10', '10', 'ANGRY', 'ANGRY', '2010-05-31 00:00:00', '2010-05-31 16:50:53', '-11', '0', '', 'DE', '14', '1', '10.5', '0', '0', '0', '0', '0', '', '1', '0', ''), ('13', '11', '10', 'ANGRY', 'ANGRY', '2010-05-31 00:00:00', '2010-05-31 17:00:43', '-11', '0', '', 'DE', '15', '0.85', '5', '0', '0', '0', '0', '0', '', '1', '0', ''), ('14', '12', '10', 'ANGRY', 'ANGRY', '2010-05-31 00:00:00', '2010-05-31 17:01:30', '-11', '0', '', 'DE', '16', '0.85', '5', '0', '0', '0', '0', '0', '', '1', '0', ''), ('15', '13', '10', 'ANGRY', 'ANGRY', '2010-05-31 00:00:00', '2010-05-31 17:02:36', '-11', '0', '', 'DE', '17', '0.85', '5', '0', '0', '0', '0', '0', '', '1', '0', ''), ('16', '8', '12', 'ANGRY', '', '2010-05-31 00:00:00', '2010-05-31 17:02:36', '-11', '0', '13', '', '0', '0.85', '-5', '0', '0', '0', '0', '0', 'Melbourne Counter Sale', '0', '0', ''), ('17', '14', '10', 'ANGRY', 'ANGRY', '2010-05-31 00:00:00', '2010-05-31 17:20:14', '-11', '0', '', 'DE', '18', '0.85', '117.5', '0', '0', '0', '0', '117.5', '', '1', '0', ''), ('18', '9', '12', 'ANGRY', '', '2010-05-31 00:00:00', '2010-05-31 17:20:14', '-11', '0', '14', '', '0', '0.85', '-117.5', '0', '0', '0', '0', '-117.5', 'Melbourne Counter Sale', '0', '0', '');

-- ----------------------------
-- Table structure for `debtortranstaxes`
-- ----------------------------
DROP TABLE IF EXISTS `debtortranstaxes`;
CREATE TABLE `debtortranstaxes` (
  `debtortransid` int(11) NOT NULL default '0',
  `taxauthid` tinyint(4) NOT NULL default '0',
  `taxamount` double NOT NULL default '0',
  PRIMARY KEY  (`debtortransid`,`taxauthid`),
  KEY `taxauthid` (`taxauthid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of debtortranstaxes
-- ----------------------------
INSERT INTO `debtortranstaxes` VALUES ('1', '13', '0'), ('2', '13', '0'), ('5', '13', '0'), ('6', '13', '0'), ('7', '13', '0'), ('8', '13', '0'), ('9', '13', '0'), ('17', '13', '0');

-- ----------------------------
-- Table structure for `debtortype`
-- ----------------------------
DROP TABLE IF EXISTS `debtortype`;
CREATE TABLE `debtortype` (
  `typeid` tinyint(4) NOT NULL auto_increment,
  `typename` varchar(100) NOT NULL,
  PRIMARY KEY  (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of debtortype
-- ----------------------------
INSERT INTO `debtortype` VALUES ('1', 'Default');

-- ----------------------------
-- Table structure for `debtortypenotes`
-- ----------------------------
DROP TABLE IF EXISTS `debtortypenotes`;
CREATE TABLE `debtortypenotes` (
  `noteid` tinyint(4) NOT NULL auto_increment,
  `typeid` tinyint(4) NOT NULL default '0',
  `href` varchar(100) NOT NULL,
  `note` varchar(200) NOT NULL,
  `date` date NOT NULL default '0000-00-00',
  `priority` varchar(20) NOT NULL,
  PRIMARY KEY  (`noteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of debtortypenotes
-- ----------------------------

-- ----------------------------
-- Table structure for `deliverynotes`
-- ----------------------------
DROP TABLE IF EXISTS `deliverynotes`;
CREATE TABLE `deliverynotes` (
  `deliverynotenumber` int(11) NOT NULL,
  `deliverynotelineno` tinyint(4) NOT NULL,
  `salesorderno` int(11) NOT NULL,
  `salesorderlineno` int(11) NOT NULL,
  `qtydelivered` double NOT NULL default '0',
  `printed` tinyint(4) NOT NULL default '0',
  `invoiced` tinyint(4) NOT NULL default '0',
  `deliverydate` date NOT NULL default '0000-00-00',
  PRIMARY KEY  (`deliverynotenumber`,`deliverynotelineno`),
  KEY `deliverynotes_ibfk_2` (`salesorderno`,`salesorderlineno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of deliverynotes
-- ----------------------------

-- ----------------------------
-- Table structure for `discountmatrix`
-- ----------------------------
DROP TABLE IF EXISTS `discountmatrix`;
CREATE TABLE `discountmatrix` (
  `salestype` char(2) NOT NULL default '',
  `discountcategory` char(2) NOT NULL default '',
  `quantitybreak` int(11) NOT NULL default '1',
  `discountrate` double NOT NULL default '0',
  PRIMARY KEY  (`salestype`,`discountcategory`,`quantitybreak`),
  KEY `QuantityBreak` (`quantitybreak`),
  KEY `DiscountCategory` (`discountcategory`),
  KEY `SalesType` (`salestype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of discountmatrix
-- ----------------------------

-- ----------------------------
-- Table structure for `edi_orders_seg_groups`
-- ----------------------------
DROP TABLE IF EXISTS `edi_orders_seg_groups`;
CREATE TABLE `edi_orders_seg_groups` (
  `seggroupno` tinyint(4) NOT NULL default '0',
  `maxoccur` int(4) NOT NULL default '0',
  `parentseggroup` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`seggroupno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of edi_orders_seg_groups
-- ----------------------------
INSERT INTO `edi_orders_seg_groups` VALUES ('0', '1', '0'), ('1', '9999', '0'), ('2', '99', '0'), ('3', '99', '2'), ('5', '5', '2'), ('6', '5', '0'), ('7', '5', '0'), ('8', '10', '0'), ('9', '9999', '8'), ('10', '10', '0'), ('11', '10', '10'), ('12', '5', '0'), ('13', '99', '0'), ('14', '5', '13'), ('15', '10', '0'), ('19', '99', '0'), ('20', '1', '19'), ('21', '1', '19'), ('22', '2', '19'), ('23', '1', '19'), ('24', '5', '19'), ('28', '200000', '0'), ('32', '25', '28'), ('33', '9999', '28'), ('34', '99', '28'), ('36', '5', '34'), ('37', '9999', '28'), ('38', '10', '28'), ('39', '999', '28'), ('42', '5', '39'), ('43', '99', '28'), ('44', '1', '43'), ('45', '1', '43'), ('46', '2', '43'), ('47', '1', '43'), ('48', '5', '43'), ('49', '10', '28'), ('50', '1', '0');

-- ----------------------------
-- Table structure for `edi_orders_segs`
-- ----------------------------
DROP TABLE IF EXISTS `edi_orders_segs`;
CREATE TABLE `edi_orders_segs` (
  `id` int(11) NOT NULL auto_increment,
  `segtag` char(3) NOT NULL default '',
  `seggroup` tinyint(4) NOT NULL default '0',
  `maxoccur` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `SegTag` (`segtag`),
  KEY `SegNo` (`seggroup`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of edi_orders_segs
-- ----------------------------
INSERT INTO `edi_orders_segs` VALUES ('1', 'UNB', '0', '1'), ('2', 'UNH', '0', '1'), ('3', 'BGM', '0', '1'), ('4', 'DTM', '0', '35'), ('5', 'PAI', '0', '1'), ('6', 'ALI', '0', '5'), ('7', 'FTX', '0', '99'), ('8', 'RFF', '1', '1'), ('9', 'DTM', '1', '5'), ('10', 'NAD', '2', '1'), ('11', 'LOC', '2', '99'), ('12', 'FII', '2', '5'), ('13', 'RFF', '3', '1'), ('14', 'CTA', '5', '1'), ('15', 'COM', '5', '5'), ('16', 'TAX', '6', '1'), ('17', 'MOA', '6', '1'), ('18', 'CUX', '7', '1'), ('19', 'DTM', '7', '5'), ('20', 'PAT', '8', '1'), ('21', 'DTM', '8', '5'), ('22', 'PCD', '8', '1'), ('23', 'MOA', '9', '1'), ('24', 'TDT', '10', '1'), ('25', 'LOC', '11', '1'), ('26', 'DTM', '11', '5'), ('27', 'TOD', '12', '1'), ('28', 'LOC', '12', '2'), ('29', 'PAC', '13', '1'), ('30', 'PCI', '14', '1'), ('31', 'RFF', '14', '1'), ('32', 'DTM', '14', '5'), ('33', 'GIN', '14', '10'), ('34', 'EQD', '15', '1'), ('35', 'ALC', '19', '1'), ('36', 'ALI', '19', '5'), ('37', 'DTM', '19', '5'), ('38', 'QTY', '20', '1'), ('39', 'RNG', '20', '1'), ('40', 'PCD', '21', '1'), ('41', 'RNG', '21', '1'), ('42', 'MOA', '22', '1'), ('43', 'RNG', '22', '1'), ('44', 'RTE', '23', '1'), ('45', 'RNG', '23', '1'), ('46', 'TAX', '24', '1'), ('47', 'MOA', '24', '1'), ('48', 'LIN', '28', '1'), ('49', 'PIA', '28', '25'), ('50', 'IMD', '28', '99'), ('51', 'MEA', '28', '99'), ('52', 'QTY', '28', '99'), ('53', 'ALI', '28', '5'), ('54', 'DTM', '28', '35'), ('55', 'MOA', '28', '10'), ('56', 'GIN', '28', '127'), ('57', 'QVR', '28', '1'), ('58', 'FTX', '28', '99'), ('59', 'PRI', '32', '1'), ('60', 'CUX', '32', '1'), ('61', 'DTM', '32', '5'), ('62', 'RFF', '33', '1'), ('63', 'DTM', '33', '5'), ('64', 'PAC', '34', '1'), ('65', 'QTY', '34', '5'), ('66', 'PCI', '36', '1'), ('67', 'RFF', '36', '1'), ('68', 'DTM', '36', '5'), ('69', 'GIN', '36', '10'), ('70', 'LOC', '37', '1'), ('71', 'QTY', '37', '1'), ('72', 'DTM', '37', '5'), ('73', 'TAX', '38', '1'), ('74', 'MOA', '38', '1'), ('75', 'NAD', '39', '1'), ('76', 'CTA', '42', '1'), ('77', 'COM', '42', '5'), ('78', 'ALC', '43', '1'), ('79', 'ALI', '43', '5'), ('80', 'DTM', '43', '5'), ('81', 'QTY', '44', '1'), ('82', 'RNG', '44', '1'), ('83', 'PCD', '45', '1'), ('84', 'RNG', '45', '1'), ('85', 'MOA', '46', '1'), ('86', 'RNG', '46', '1'), ('87', 'RTE', '47', '1'), ('88', 'RNG', '47', '1'), ('89', 'TAX', '48', '1'), ('90', 'MOA', '48', '1'), ('91', 'TDT', '49', '1'), ('92', 'UNS', '50', '1'), ('93', 'MOA', '50', '1'), ('94', 'CNT', '50', '1'), ('95', 'UNT', '50', '1');

-- ----------------------------
-- Table structure for `ediitemmapping`
-- ----------------------------
DROP TABLE IF EXISTS `ediitemmapping`;
CREATE TABLE `ediitemmapping` (
  `supporcust` varchar(4) NOT NULL default '',
  `partnercode` varchar(10) NOT NULL default '',
  `stockid` varchar(20) NOT NULL default '',
  `partnerstockid` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`supporcust`,`partnercode`,`stockid`),
  KEY `PartnerCode` (`partnercode`),
  KEY `StockID` (`stockid`),
  KEY `PartnerStockID` (`partnerstockid`),
  KEY `SuppOrCust` (`supporcust`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ediitemmapping
-- ----------------------------

-- ----------------------------
-- Table structure for `edimessageformat`
-- ----------------------------
DROP TABLE IF EXISTS `edimessageformat`;
CREATE TABLE `edimessageformat` (
  `id` int(11) NOT NULL auto_increment,
  `partnercode` varchar(10) NOT NULL default '',
  `messagetype` varchar(6) NOT NULL default '',
  `section` varchar(7) NOT NULL default '',
  `sequenceno` int(11) NOT NULL default '0',
  `linetext` varchar(70) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `PartnerCode` (`partnercode`,`messagetype`,`sequenceno`),
  KEY `Section` (`section`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of edimessageformat
-- ----------------------------

-- ----------------------------
-- Table structure for `emailsettings`
-- ----------------------------
DROP TABLE IF EXISTS `emailsettings`;
CREATE TABLE `emailsettings` (
  `id` int(11) NOT NULL auto_increment,
  `host` varchar(30) NOT NULL,
  `port` char(5) NOT NULL,
  `heloaddress` varchar(20) NOT NULL,
  `username` varchar(30) default NULL,
  `password` varchar(30) default NULL,
  `timeout` int(11) default '5',
  `companyname` varchar(50) default NULL,
  `auth` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of emailsettings
-- ----------------------------
INSERT INTO `emailsettings` VALUES ('1', 'localhost', '25', 'helo', '', '', '5', '', '0');

-- ----------------------------
-- Table structure for `factorcompanies`
-- ----------------------------
DROP TABLE IF EXISTS `factorcompanies`;
CREATE TABLE `factorcompanies` (
  `id` int(11) NOT NULL auto_increment,
  `coyname` varchar(50) NOT NULL default '',
  `address1` varchar(40) NOT NULL default '',
  `address2` varchar(40) NOT NULL default '',
  `address3` varchar(40) NOT NULL default '',
  `address4` varchar(40) NOT NULL default '',
  `address5` varchar(20) NOT NULL default '',
  `address6` varchar(15) NOT NULL default '',
  `contact` varchar(25) NOT NULL default '',
  `telephone` varchar(25) NOT NULL default '',
  `fax` varchar(25) NOT NULL default '',
  `email` varchar(55) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `factor_name` (`coyname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of factorcompanies
-- ----------------------------

-- ----------------------------
-- Table structure for `fixedassetlocations`
-- ----------------------------
DROP TABLE IF EXISTS `fixedassetlocations`;
CREATE TABLE `fixedassetlocations` (
  `locationid` char(6) NOT NULL default '',
  `locationdescription` char(20) NOT NULL default '',
  `parentlocationid` char(6) default '',
  PRIMARY KEY  (`locationid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fixedassetlocations
-- ----------------------------
INSERT INTO `fixedassetlocations` VALUES ('HEADOF', 'Head Office', '');

-- ----------------------------
-- Table structure for `freightcosts`
-- ----------------------------
DROP TABLE IF EXISTS `freightcosts`;
CREATE TABLE `freightcosts` (
  `shipcostfromid` int(11) NOT NULL auto_increment,
  `locationfrom` varchar(5) NOT NULL default '',
  `destination` varchar(40) NOT NULL default '',
  `shipperid` int(11) NOT NULL default '0',
  `cubrate` double NOT NULL default '0',
  `kgrate` double NOT NULL default '0',
  `maxkgs` double NOT NULL default '999999',
  `maxcub` double NOT NULL default '999999',
  `fixedprice` double NOT NULL default '0',
  `minimumchg` double NOT NULL default '0',
  PRIMARY KEY  (`shipcostfromid`),
  KEY `Destination` (`destination`),
  KEY `LocationFrom` (`locationfrom`),
  KEY `ShipperID` (`shipperid`),
  KEY `Destination_2` (`destination`,`locationfrom`,`shipperid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of freightcosts
-- ----------------------------

-- ----------------------------
-- Table structure for `geocode_param`
-- ----------------------------
DROP TABLE IF EXISTS `geocode_param`;
CREATE TABLE `geocode_param` (
  `geocodeid` tinyint(4) NOT NULL auto_increment,
  `geocode_key` varchar(200) NOT NULL default '',
  `center_long` varchar(20) NOT NULL default '',
  `center_lat` varchar(20) NOT NULL default '',
  `map_height` varchar(10) NOT NULL default '',
  `map_width` varchar(10) NOT NULL default '',
  `map_host` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`geocodeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of geocode_param
-- ----------------------------

-- ----------------------------
-- Table structure for `gltrans`
-- ----------------------------
DROP TABLE IF EXISTS `gltrans`;
CREATE TABLE `gltrans` (
  `counterindex` int(11) NOT NULL auto_increment,
  `type` smallint(6) NOT NULL default '0',
  `typeno` bigint(16) NOT NULL default '1',
  `chequeno` int(11) NOT NULL default '0',
  `trandate` date NOT NULL default '0000-00-00',
  `periodno` smallint(6) NOT NULL default '0',
  `account` int(11) NOT NULL default '0',
  `narrative` varchar(200) NOT NULL default '',
  `amount` double NOT NULL default '0',
  `posted` tinyint(4) NOT NULL default '0',
  `jobref` varchar(20) NOT NULL default '',
  `tag` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`counterindex`),
  KEY `Account` (`account`),
  KEY `ChequeNo` (`chequeno`),
  KEY `PeriodNo` (`periodno`),
  KEY `Posted` (`posted`),
  KEY `TranDate` (`trandate`),
  KEY `TypeNo` (`typeno`),
  KEY `Type_and_Number` (`type`,`typeno`),
  KEY `JobRef` (`jobref`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of gltrans
-- ----------------------------
INSERT INTO `gltrans` VALUES ('3', '26', '1', '0', '2007-06-14', '2', '1460', '3 DVD-DHWV x 2 @ 5.25', '10.5', '1', '', '0'), ('4', '26', '1', '0', '2007-06-14', '2', '1460', '3 DVD-DHWV x 2 @ 5.25', '-10.5', '1', '', '0'), ('5', '28', '2', '0', '2007-06-18', '2', '1460', '3 DVD-TOPGUN x 1 @ 6.50', '6.5', '1', '', '0'), ('6', '28', '2', '0', '2007-06-18', '2', '1460', '3 DVD-TOPGUN x 1 @ 6.50', '-6.5', '1', '', '0'), ('7', '28', '3', '0', '2007-06-18', '2', '1460', '3 - DVD_ACTION Component: DVD-DHWV - 10 x 1 @ 5.25', '52.5', '1', '', '0'), ('8', '28', '3', '0', '2007-06-18', '2', '1460', '3 - DVD_ACTION -> DVD-DHWV - 10 x 1 @ 5.25', '-52.5', '1', '', '0'), ('9', '28', '3', '0', '2007-06-18', '2', '1460', '3 - DVD_ACTION Component: DVD-LTWP - 10 x 1 @ 2.85', '28.5', '1', '', '0'), ('10', '28', '3', '0', '2007-06-18', '2', '1460', '3 - DVD_ACTION -> DVD-LTWP - 10 x 1 @ 2.85', '-28.5', '1', '', '0'), ('11', '28', '3', '0', '2007-06-18', '2', '1460', '3 - DVD_ACTION Component: DVD-UNSG - 10 x 1 @ 5.00', '50', '1', '', '0'), ('12', '28', '3', '0', '2007-06-18', '2', '1460', '3 - DVD_ACTION -> DVD-UNSG - 10 x 1 @ 5.00', '-50', '1', '', '0'), ('13', '28', '3', '0', '2007-06-18', '2', '1460', '3 - DVD_ACTION Component: DVD-UNSG2 - 10 x 1 @ 5.00', '50', '1', '', '0'), ('14', '28', '3', '0', '2007-06-18', '2', '1460', '3 - DVD_ACTION -> DVD-UNSG2 - 10 x 1 @ 5.00', '-50', '1', '', '0'), ('15', '26', '2', '0', '2007-06-18', '2', '1460', '3 DVD_ACTION - Action Series Bundle x 10 @ 18.40', '184', '1', '', '0'), ('16', '26', '2', '0', '2007-06-18', '2', '1460', '3 DVD_ACTION - Action Series Bundle x 10 @ 18.40', '-184', '1', '', '0'), ('17', '29', '1', '0', '2007-06-18', '2', '1460', '3 - DVD_ACTION share of variance', '5', '1', '', '0'), ('18', '29', '1', '0', '2007-06-18', '2', '1460', '3 - DVD_ACTION share of variance', '-5', '1', '', '0'), ('19', '28', '4', '0', '2007-06-21', '2', '1440', '5 FLOUR x 4 @ 3.89', '15.56', '1', '', '0'), ('20', '28', '4', '0', '2007-06-21', '2', '1460', '5 FLOUR x 4 @ 3.89', '-15.56', '1', '', '0'), ('21', '10', '1', '0', '2007-06-26', '2', '5000', 'QUARTER - DVD-DHWV x 2 @ 5.2500', '10.5', '1', '', '0'), ('22', '10', '1', '0', '2007-06-26', '2', '1460', 'QUARTER - DVD-DHWV x 2 @ 5.2500', '-10.5', '1', '', '0'), ('23', '10', '1', '0', '2007-06-26', '2', '4100', 'QUARTER - DVD-DHWV x 2 @ 15.95', '-31.9', '1', '', '0'), ('24', '10', '1', '0', '2007-06-26', '2', '5000', 'QUARTER - DVD-LTWP x 1 @ 2.8500', '2.85', '1', '', '0'), ('25', '10', '1', '0', '2007-06-26', '2', '1460', 'QUARTER - DVD-LTWP x 1 @ 2.8500', '-2.85', '1', '', '0'), ('26', '10', '1', '0', '2007-06-26', '2', '4100', 'QUARTER - DVD-LTWP x 1 @ 14.5', '-14.5', '1', '', '0'), ('27', '10', '1', '0', '2007-06-26', '2', '1100', 'QUARTER', '46.4', '1', '', '0'), ('28', '11', '1', '0', '2007-08-02', '3', '5000', 'QUARTER - DVD-DHWV x 1 @ 5.2500', '-5.25', '1', '', '0'), ('29', '11', '1', '0', '2007-08-02', '3', '1460', 'QUARTER - DVD-DHWV x 1 @ 5.2500', '5.25', '1', '', '0'), ('30', '11', '1', '0', '2007-08-02', '3', '4100', 'QUARTER - DVD-DHWV x 1 @ 15.950', '15.95', '1', '', '0'), ('31', '11', '1', '0', '2007-08-02', '3', '1100', 'QUARTER', '-15.95', '1', '', '0'), ('32', '35', '3', '0', '2007-08-08', '3', '5700', 'DVD-LTWP cost was 2.85 changed to 2.65 x Quantity on hand of -11', '-2.2', '1', '', '0'), ('33', '35', '3', '0', '2007-08-08', '3', '1460', 'DVD-LTWP cost was 2.85 changed to 2.65 x Quantity on hand of -11', '2.2', '1', '', '0'), ('34', '35', '4', '0', '2007-08-08', '3', '5700', 'DVD-LTWP cost was 2.65 changed to 2.66 x Quantity on hand of -11', '0.11', '1', '', '0'), ('35', '35', '4', '0', '2007-08-08', '3', '1460', 'DVD-LTWP cost was 2.65 changed to 2.66 x Quantity on hand of -11', '-0.11', '1', '', '0'), ('36', '35', '5', '0', '2007-08-08', '3', '5700', 'DVD-LTWP cost was 2.66 changed to 2.7 x Quantity on hand of -11', '0.44', '1', '', '0'), ('37', '35', '5', '0', '2007-08-08', '3', '1460', 'DVD-LTWP cost was 2.66 changed to 2.7 x Quantity on hand of -11', '-0.44', '1', '', '0'), ('38', '35', '6', '0', '2007-08-08', '3', '5700', 'DVD_ACTION cost was 19.3000 changed to 19.15 x Quantity on hand of 10', '1.5', '1', '', '0'), ('39', '35', '6', '0', '2007-08-08', '3', '1460', 'DVD_ACTION cost was 19.3000 changed to 19.15 x Quantity on hand of 10', '-1.5', '1', '', '0'), ('40', '35', '7', '0', '2007-08-09', '3', '5700', 'DVD-DHWV cost was 5.25 changed to 5.3 x Quantity on hand of -13', '0.65', '1', '', '0'), ('41', '35', '7', '0', '2007-08-09', '3', '1460', 'DVD-DHWV cost was 5.25 changed to 5.3 x Quantity on hand of -13', '-0.65', '1', '', '0'), ('42', '35', '8', '0', '2007-08-09', '3', '5700', 'DVD_ACTION cost was 19.1500 changed to 19.2 x Quantity on hand of 10', '-0.50000000000001', '1', '', '0'), ('43', '35', '8', '0', '2007-08-09', '3', '1460', 'DVD_ACTION cost was 19.1500 changed to 19.2 x Quantity on hand of 10', '0.50000000000001', '1', '', '0'), ('44', '35', '9', '0', '2007-08-09', '3', '5700', 'DVD-DHWV cost was 5.3 changed to 5.35 x Quantity on hand of -13', '0.65', '1', '', '0'), ('45', '35', '9', '0', '2007-08-09', '3', '1460', 'DVD-DHWV cost was 5.3 changed to 5.35 x Quantity on hand of -13', '-0.65', '1', '', '0'), ('46', '35', '10', '0', '2007-08-09', '3', '5700', 'DVD_ACTION cost was 19.2000 changed to 19.25 x Quantity on hand of 10', '-0.50000000000001', '1', '', '0'), ('47', '35', '10', '0', '2007-08-09', '3', '1460', 'DVD_ACTION cost was 19.2000 changed to 19.25 x Quantity on hand of 10', '0.50000000000001', '1', '', '0'), ('48', '35', '11', '0', '2007-08-09', '3', '5700', 'DVD-DHWV cost was 5.35 changed to 5.5 x Quantity on hand of -13', '1.95', '1', '', '0'), ('49', '35', '11', '0', '2007-08-09', '3', '1460', 'DVD-DHWV cost was 5.35 changed to 5.5 x Quantity on hand of -13', '-1.95', '1', '', '0'), ('50', '35', '12', '0', '2007-08-09', '3', '5700', 'DVD_ACTION cost was 19.2500 changed to 19.4 x Quantity on hand of 10', '-1.5', '1', '', '0'), ('51', '35', '12', '0', '2007-08-09', '3', '1460', 'DVD_ACTION cost was 19.2500 changed to 19.4 x Quantity on hand of 10', '1.5', '1', '', '0'), ('52', '35', '13', '0', '2007-08-09', '3', '5700', 'DVD-DHWV cost was 5.5 changed to 2.32 x Quantity on hand of -13', '-41.34', '1', '', '0'), ('53', '35', '13', '0', '2007-08-09', '3', '1460', 'DVD-DHWV cost was 5.5 changed to 2.32 x Quantity on hand of -13', '41.34', '1', '', '0'), ('54', '35', '14', '0', '2007-08-09', '3', '5700', 'DVD_ACTION cost was 19.4000 changed to 16.22 x Quantity on hand of 10', '31.8', '1', '', '0'), ('55', '35', '14', '0', '2007-08-09', '3', '1460', 'DVD_ACTION cost was 19.4000 changed to 16.22 x Quantity on hand of 10', '-31.8', '1', '', '0'), ('56', '12', '1', '0', '2007-10-23', '5', '6100', 'test', '-150', '1', '', '0'), ('57', '12', '1', '0', '2007-10-23', '5', '1030', '', '150', '1', '', '0'), ('58', '28', '5', '0', '2008-06-27', '13', '1440', '5 - BREAD Component: SALT - 12 x 0.025 @ 2.50', '0.75', '1', '', '0'), ('59', '1', '2', '0', '2008-07-26', '14', '1350', 'testrg', '500', '1', '', '0'), ('60', '1', '2', '0', '2008-07-26', '14', '1030', '', '-500', '1', '', '0'), ('61', '12', '2', '0', '2009-02-04', '21', '1030', '', '99', '1', '', '0'), ('62', '12', '2', '0', '2009-02-04', '21', '1100', '', '-99', '1', '', '0'), ('63', '12', '3', '0', '2009-02-04', '21', '1420', '', '-299', '1', '', '0'), ('64', '12', '3', '0', '2009-02-04', '21', '1030', '', '299', '1', '', '0'), ('65', '35', '15', '0', '2009-02-04', '21', '5700', 'DVD_ACTION cost was 16.2200 changed to 16.22 x Quantity on hand of 10', '0', '1', '', '0'), ('66', '35', '15', '0', '2009-02-04', '21', '1460', 'DVD_ACTION cost was 16.2200 changed to 16.22 x Quantity on hand of 10', '0', '1', '', '0'), ('67', '35', '16', '0', '2009-02-04', '21', '5700', 'DVD_ACTION cost was 16.2200 changed to 16.22 x Quantity on hand of 10', '0', '1', '', '0'), ('68', '35', '16', '0', '2009-02-04', '21', '1460', 'DVD_ACTION cost was 16.2200 changed to 16.22 x Quantity on hand of 10', '0', '1', '', '0'), ('69', '35', '17', '0', '2009-02-04', '21', '5700', 'DVD_ACTION cost was 16.2200 changed to 16.22 x Quantity on hand of 10', '0', '1', '', '0'), ('70', '35', '17', '0', '2009-02-04', '21', '1460', 'DVD_ACTION cost was 16.2200 changed to 16.22 x Quantity on hand of 10', '0', '1', '', '0'), ('71', '25', '18', '0', '2009-02-04', '21', '1460', 'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70', '2.7', '1', '', '0'), ('72', '25', '18', '0', '2009-02-04', '21', '2150', 'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70', '-2.7', '1', '', '0'), ('73', '25', '19', '0', '2009-02-05', '21', '1460', 'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70', '2.7', '1', '', '0'), ('74', '25', '19', '0', '2009-02-05', '21', '2150', 'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70', '-2.7', '1', '', '0'), ('75', '25', '20', '0', '2009-02-05', '21', '1460', 'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70', '2.7', '1', '', '0'), ('76', '25', '20', '0', '2009-02-05', '21', '2150', 'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70', '-2.7', '1', '', '0'), ('77', '25', '21', '0', '2009-02-05', '21', '1460', 'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70', '2.7', '1', '', '0'), ('78', '25', '21', '0', '2009-02-05', '21', '2150', 'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70', '-2.7', '1', '', '0'), ('79', '25', '22', '0', '2009-02-05', '21', '1460', 'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70', '2.7', '1', '', '0'), ('80', '25', '22', '0', '2009-02-05', '21', '2150', 'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70', '-2.7', '1', '', '0'), ('81', '25', '23', '0', '2009-02-05', '21', '1460', 'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70', '2.7', '1', '', '0'), ('82', '25', '23', '0', '2009-02-05', '21', '2150', 'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70', '-2.7', '1', '', '0'), ('83', '25', '24', '0', '2009-02-05', '21', '1460', 'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70', '2.7', '1', '', '0'), ('84', '25', '24', '0', '2009-02-05', '21', '2150', 'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70', '-2.7', '1', '', '0'), ('85', '25', '25', '0', '2009-02-05', '21', '1460', 'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50', '2.5', '1', '', '0'), ('86', '25', '25', '0', '2009-02-05', '21', '2150', 'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50', '-2.5', '1', '', '0'), ('87', '25', '26', '0', '2009-02-05', '21', '1460', 'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50', '2.5', '1', '', '0'), ('88', '25', '26', '0', '2009-02-05', '21', '2150', 'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50', '-2.5', '1', '', '0'), ('89', '25', '27', '0', '2009-02-05', '21', '1460', 'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50', '2.5', '1', '', '0'), ('90', '25', '27', '0', '2009-02-05', '21', '2150', 'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50', '-2.5', '1', '', '0'), ('91', '25', '28', '0', '2009-02-05', '21', '1460', 'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50', '2.5', '1', '', '0'), ('92', '25', '28', '0', '2009-02-05', '21', '2150', 'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50', '-2.5', '1', '', '0'), ('93', '25', '29', '0', '2009-02-05', '21', '1460', 'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50', '2.5', '1', '', '0'), ('94', '25', '29', '0', '2009-02-05', '21', '2150', 'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50', '-2.5', '1', '', '0'), ('95', '25', '30', '0', '2009-02-05', '21', '1460', 'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50', '2.5', '1', '', '0'), ('96', '25', '30', '0', '2009-02-05', '21', '2150', 'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50', '-2.5', '1', '', '0'), ('97', '25', '31', '0', '2009-02-05', '21', '1460', 'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50', '2.5', '1', '', '0'), ('98', '25', '31', '0', '2009-02-05', '21', '2150', 'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50', '-2.5', '1', '', '0'), ('99', '17', '17', '0', '2009-02-05', '21', '5700', 'BREAD x 100 @ 6.0085 ', '-600.85', '1', '', '0'), ('100', '17', '17', '0', '2009-02-05', '21', '1460', 'BREAD x 100 @ 6.0085 ', '600.85', '1', '', '0'), ('101', '10', '4', '0', '2010-05-31', '-11', '5000', 'ANGRY - BREAD x 3 @ 6.0085', '18.0255', '0', '', '0'), ('102', '10', '4', '0', '2010-05-31', '-11', '1460', 'ANGRY - BREAD x 3 @ 6.0085', '-18.0255', '0', '', '0'), ('103', '10', '4', '0', '2010-05-31', '-11', '4100', 'ANGRY - BREAD x 3 @ 6.9', '-20.7', '0', '', '0');
INSERT INTO `gltrans` VALUES ('104', '10', '4', '0', '2010-05-31', '-11', '4900', 'ANGRY - BREAD @ 10%', '2.07', '0', '', '0'), ('105', '10', '4', '0', '2010-05-31', '-11', '5000', 'ANGRY - SALT x 3 @ 2.5000', '7.5', '0', '', '0'), ('106', '10', '4', '0', '2010-05-31', '-11', '1460', 'ANGRY - SALT x 3 @ 2.5000', '-7.5', '0', '', '0'), ('107', '10', '4', '0', '2010-05-31', '-11', '4100', 'ANGRY - SALT x 3 @ 3.25', '-9.75', '0', '', '0'), ('108', '10', '4', '0', '2010-05-31', '-11', '1100', 'ANGRY', '28.38', '0', '', '0'), ('109', '10', '5', '0', '2010-05-31', '-11', '5000', 'ANGRY - BREAD x 4 @ 6.0085', '24.034', '0', '', '0'), ('110', '10', '5', '0', '2010-05-31', '-11', '1460', 'ANGRY - BREAD x 4 @ 6.0085', '-24.034', '0', '', '0'), ('111', '10', '5', '0', '2010-05-31', '-11', '4100', 'ANGRY - BREAD x 4 @ 6.9', '-27.6', '0', '', '0'), ('112', '10', '5', '0', '2010-05-31', '-11', '4900', 'ANGRY - BREAD @ 15%', '4.14', '0', '', '0'), ('113', '10', '5', '0', '2010-05-31', '-11', '5000', 'ANGRY - SALT x 1 @ 2.5000', '2.5', '0', '', '0'), ('114', '10', '5', '0', '2010-05-31', '-11', '1460', 'ANGRY - SALT x 1 @ 2.5000', '-2.5', '0', '', '0'), ('115', '10', '5', '0', '2010-05-31', '-11', '4100', 'ANGRY - SALT x 1 @ 2.99', '-2.99', '0', '', '0'), ('116', '10', '5', '0', '2010-05-31', '-11', '4900', 'ANGRY - SALT @ 1.5%', '0.04485', '0', '', '0'), ('117', '10', '5', '0', '2010-05-31', '-11', '1100', 'ANGRY', '26.40515', '0', '', '0'), ('118', '10', '6', '0', '2010-05-31', '-11', '5000', 'ANGRY - BREAD x 2 @ 6.0085', '12.017', '0', '', '0'), ('119', '10', '6', '0', '2010-05-31', '-11', '1460', 'ANGRY - BREAD x 2 @ 6.0085', '-12.017', '0', '', '0'), ('120', '10', '6', '0', '2010-05-31', '-11', '4100', 'ANGRY - BREAD x 2 @ 12', '-24', '0', '', '0'), ('121', '10', '6', '0', '2010-05-31', '-11', '1100', 'ANGRY', '24', '0', '', '0'), ('122', '10', '7', '0', '2010-05-31', '-11', '5000', 'ANGRY - BREAD x 5 @ 6.0085', '30.0425', '0', '', '0'), ('123', '10', '7', '0', '2010-05-31', '-11', '1460', 'ANGRY - BREAD x 5 @ 6.0085', '-30.0425', '0', '', '0'), ('124', '11', '2', '0', '2010-05-31', '36', '5000', 'ANGRY - BREAD x 5 @ 6.0085', '-30.04', '0', '', '0'), ('125', '11', '2', '0', '2010-05-31', '36', '1460', 'ANGRY - BREAD x 5 @ 6.0085', '30.04', '0', '', '0'), ('130', '10', '9', '0', '2010-05-31', '-11', '5000', 'ANGRY - SALT x 2 @ 2.5000', '5', '0', '', '0'), ('131', '10', '9', '0', '2010-05-31', '-11', '1460', 'ANGRY - SALT x 2 @ 2.5000', '-5', '0', '', '0'), ('132', '10', '9', '0', '2010-05-31', '-11', '4100', 'ANGRY - SALT x 2 @ 25', '-50', '0', '', '0'), ('133', '10', '9', '0', '2010-05-31', '-11', '1100', 'ANGRY', '50', '0', '', '0'), ('136', '10', '10', '0', '2010-05-31', '-11', '5000', 'ANGRY - BREAD x 2 @ 6.0085', '12.017', '0', '', '0'), ('137', '10', '10', '0', '2010-05-31', '-11', '1460', 'ANGRY - BREAD x 2 @ 6.0085', '-12.017', '0', '', '0'), ('138', '10', '10', '0', '2010-05-31', '-11', '4100', 'ANGRY - BREAD x 2 @ 5.25', '-10.5', '0', '', '0'), ('139', '10', '10', '0', '2010-05-31', '-11', '1100', 'ANGRY', '10.5', '0', '', '0'), ('140', '12', '5', '0', '2010-05-31', '-11', '1040', 'Melbourne Counter Sale 10', '10.5', '0', '', '0'), ('141', '12', '5', '0', '2010-05-31', '-11', '1100', 'Melbourne Counter Sale 10', '-10.5', '0', '', '0'), ('142', '10', '11', '0', '2010-05-31', '-11', '5000', 'ANGRY - BREAD x 1 @ 6.0085', '6.0085', '0', '', '0'), ('143', '10', '11', '0', '2010-05-31', '-11', '1460', 'ANGRY - BREAD x 1 @ 6.0085', '-6.0085', '0', '', '0'), ('144', '10', '11', '0', '2010-05-31', '-11', '4100', 'ANGRY - BREAD x 1 @ 5', '-5.8823529411765', '0', '', '0'), ('145', '10', '11', '0', '2010-05-31', '-11', '1100', 'ANGRY', '5.8823529411765', '0', '', '0'), ('148', '10', '12', '0', '2010-05-31', '-11', '5000', 'ANGRY - BREAD x 1 @ 6.0085', '6.0085', '0', '', '0'), ('149', '10', '12', '0', '2010-05-31', '-11', '1460', 'ANGRY - BREAD x 1 @ 6.0085', '-6.0085', '0', '', '0'), ('150', '10', '12', '0', '2010-05-31', '-11', '4100', 'ANGRY - BREAD x 1 @ 5', '-5.8823529411765', '0', '', '0'), ('151', '10', '12', '0', '2010-05-31', '-11', '1100', 'ANGRY', '5.8823529411765', '0', '', '0'), ('154', '10', '13', '0', '2010-05-31', '-11', '5000', 'ANGRY - BREAD x 1 @ 6.0085', '6.0085', '0', '', '0'), ('155', '10', '13', '0', '2010-05-31', '-11', '1460', 'ANGRY - BREAD x 1 @ 6.0085', '-6.0085', '0', '', '0'), ('156', '10', '13', '0', '2010-05-31', '-11', '4100', 'ANGRY - BREAD x 1 @ 5', '-5.8823529411765', '0', '', '0'), ('157', '10', '13', '0', '2010-05-31', '-11', '1100', 'ANGRY', '5.8823529411765', '0', '', '0'), ('158', '12', '8', '0', '2010-05-31', '-11', '1030', 'Melbourne Counter Sale 13', '5.8823529411765', '0', '', '0'), ('159', '12', '8', '0', '2010-05-31', '-11', '1100', 'Melbourne Counter Sale 13', '-5.8823529411765', '0', '', '0'), ('160', '10', '14', '0', '2010-05-31', '-11', '5000', 'ANGRY - BREAD x 12 @ 6.0085', '72.102', '0', '', '0'), ('161', '10', '14', '0', '2010-05-31', '-11', '1460', 'ANGRY - BREAD x 12 @ 6.0085', '-72.102', '0', '', '0'), ('162', '10', '14', '0', '2010-05-31', '-11', '4100', 'ANGRY - BREAD x 12 @ 9.50', '-134.11764705882', '0', '', '0'), ('163', '10', '14', '0', '2010-05-31', '-11', '5000', 'ANGRY - SALT x .7 @ 2.5000', '1.75', '0', '', '0'), ('164', '10', '14', '0', '2010-05-31', '-11', '1460', 'ANGRY - SALT x .7 @ 2.5000', '-1.75', '0', '', '0'), ('165', '10', '14', '0', '2010-05-31', '-11', '4100', 'ANGRY - SALT x .7 @ 5', '-4.1176470588235', '0', '', '0'), ('166', '10', '14', '0', '2010-05-31', '-11', '1100', 'ANGRY', '138.23529411765', '0', '', '0'), ('167', '12', '9', '0', '2010-05-31', '-11', '1030', 'Melbourne Counter Sale 14', '138.23529411765', '0', '', '0'), ('168', '12', '9', '0', '2010-05-31', '-11', '1100', 'Melbourne Counter Sale 14', '-138.23529411765', '0', '', '0'), ('169', '20', '18', '0', '2010-08-13', '0', '6100', 'CRUISE ', '62.5', '1', '', '0'), ('170', '20', '18', '0', '2010-08-13', '0', '1440', 'CRUISE Contract charge against BirthdayCakeConstruc', '31.69375', '1', '', '0'), ('171', '20', '18', '0', '2010-08-13', '0', '1440', 'CRUISE Contract charge against BirthdayCakeConstruc', '15', '1', '', '0'), ('172', '20', '18', '0', '2010-08-13', '0', '2100', 'CRUISE - Inv assssa GBP50.00 @ a rate of 0.8', '-109.19', '1', '', '0'), ('175', '20', '20', '0', '2010-08-13', '0', '1440', 'CRUISE Contract charge against BirthdayCakeConstruc', '1569.0625', '1', '', '0'), ('176', '20', '20', '0', '2010-08-13', '0', '2100', 'CRUISE - Inv 21221-DFR GBP1,255.25 @ a rate of 0.8', '-1569.06', '1', '', '0'), ('177', '20', '21', '0', '2010-08-13', '0', '1440', 'CRUISE Contract charge against BirthdayCakeConstruc', '12.5', '1', '', '0'), ('178', '20', '21', '0', '2010-08-13', '0', '2100', 'CRUISE - Inv 9877 GBP10.00 @ a rate of 0.8', '-12.5', '1', '', '0'), ('179', '20', '22', '0', '2010-08-13', '0', '1440', 'CRUISE Contract charge against BirthdayCakeConstruc', '125', '1', '', '0'), ('180', '20', '22', '0', '2010-08-13', '0', '2100', 'CRUISE - Inv 9877-877 GBP100.00 @ a rate of 0.8', '-125', '1', '', '0'), ('181', '21', '5', '0', '0000-00-00', '0', '1440', 'CRUISE Contract charge against BirthdayCakeConstruc', '-112.5', '1', '', '0'), ('182', '21', '5', '0', '2010-08-13', '0', '2310', 'CRUISE - Credit note 30299 GBP0 @ a rate of 0.8', '0', '1', '', '0'), ('183', '21', '5', '0', '2010-08-13', '0', '2100', 'CRUISE - Credit Note 30299 GBP90.00 @ a rate of 0.8', '112.5', '1', '', '0'), ('184', '21', '6', '0', '0000-00-00', '0', '1440', 'CRUISE Contract charge against BirthdayCakeConstruc', '-125', '1', '', '0'), ('185', '21', '6', '0', '2010-08-13', '0', '2100', 'CRUISE - Credit Note 57748-OPP GBP100.00 @ a rate of 0.8', '125', '1', '', '0'), ('186', '21', '7', '0', '0000-00-00', '0', '1440', 'CRUISE Contract charge against BirthdayCakeConstruc', '-122.7625', '1', '', '0'), ('187', '21', '7', '0', '0000-00-00', '0', '1440', 'CRUISE Contract charge against BirthdayCakeConstruc', '-7.75', '1', '', '0'), ('188', '21', '7', '0', '2010-08-13', '0', '2100', 'CRUISE - Credit Note 9sjkja_099 GBP104.41 @ a rate of 0.8', '130.51', '1', '', '0'), ('189', '28', '6', '0', '2010-08-14', '0', '1440', '12 BREAD x 3.5 @ 6.01', '21.02975', '1', '', '0'), ('190', '28', '6', '0', '2010-08-14', '0', '1460', '12 BREAD x 3.5 @ 6.01', '-21.02975', '1', '', '0'), ('191', '28', '7', '0', '2010-08-15', '0', '1440', '12 BREAD x 2 @ 6.01', '12.017', '1', '', '0'), ('192', '28', '7', '0', '2010-08-15', '0', '1460', '12 BREAD x 2 @ 6.01', '-12.017', '1', '', '0'), ('193', '17', '18', '0', '2010-08-15', '0', '5700', 'DVD-CASE x 180 @ 0.3 ', '-54', '1', '', '0'), ('194', '17', '18', '0', '2010-08-15', '0', '1460', 'DVD-CASE x 180 @ 0.3 ', '54', '1', '', '0'), ('195', '28', '8', '0', '2010-08-15', '0', '1440', '12 DVD-CASE x 1 @ 0.30', '0.3', '1', '', '0'), ('196', '28', '8', '0', '2010-08-15', '0', '1460', '12 DVD-CASE x 1 @ 0.30', '-0.3', '1', '', '0'), ('197', '17', '19', '0', '2010-08-15', '0', '5700', 'YEAST x 9.95 @ 5 ', '-49.75', '1', '', '0'), ('198', '17', '19', '0', '2010-08-15', '0', '1460', 'YEAST x 9.95 @ 5 ', '49.75', '1', '', '0'), ('199', '28', '9', '0', '2010-08-15', '0', '1440', '12 YEAST x .75 @ 5.00', '3.75', '1', '', '0'), ('200', '28', '9', '0', '2010-08-15', '0', '1460', '12 YEAST x .75 @ 5.00', '-3.75', '1', '', '0'), ('201', '17', '20', '0', '2010-08-15', '0', '5700', 'SALT x 25 @ 2.5 ', '-62.5', '1', '', '0'), ('202', '17', '20', '0', '2010-08-15', '0', '1460', 'SALT x 25 @ 2.5 ', '62.5', '1', '', '0'), ('203', '28', '10', '0', '2010-08-15', '0', '1440', '12 SALT x 1.3 @ 2.50', '3.25', '1', '', '0'), ('204', '28', '10', '0', '2010-08-15', '0', '1460', '12 SALT x 1.3 @ 2.50', '-3.25', '1', '', '0'), ('205', '32', '2', '0', '2010-08-22', '1', '1440', 'Variance on contract BirthdayCakeConstruc', '470.97925', '1', '', '0'), ('206', '32', '2', '0', '2010-08-22', '1', '5000', 'Variance on contract BirthdayCakeConstruc', '-470.97925', '1', '', '0'), ('209', '32', '4', '0', '2010-08-22', '1', '1440', 'Variance on contract BirthdayCakeConstruc', '470.97925', '1', '', '0'), ('210', '32', '4', '0', '2010-08-22', '1', '5000', 'Variance on contract BirthdayCakeConstruc', '-470.97925', '1', '', '0'), ('213', '32', '5', '0', '2010-08-22', '1', '1440', 'Variance on contract BirthdayCakeConstruc', '470.97925', '1', '', '0'), ('214', '32', '5', '0', '2010-08-22', '1', '5000', 'Variance on contract BirthdayCakeConstruc', '-470.97925', '1', '', '0'), ('215', '32', '6', '0', '2010-08-22', '1', '1440', 'Variance on contract BirthdayCakeConstruc', '470.97925', '1', '', '0'), ('216', '32', '6', '0', '2010-08-22', '1', '5000', 'Variance on contract BirthdayCakeConstruc', '-470.97925', '1', '', '0');

-- ----------------------------
-- Table structure for `grns`
-- ----------------------------
DROP TABLE IF EXISTS `grns`;
CREATE TABLE `grns` (
  `grnbatch` smallint(6) NOT NULL default '0',
  `grnno` int(11) NOT NULL auto_increment,
  `podetailitem` int(11) NOT NULL default '0',
  `itemcode` varchar(20) NOT NULL default '',
  `deliverydate` date NOT NULL default '0000-00-00',
  `itemdescription` varchar(100) NOT NULL default '',
  `qtyrecd` double NOT NULL default '0',
  `quantityinv` double NOT NULL default '0',
  `supplierid` varchar(10) NOT NULL default '',
  `stdcostunit` double NOT NULL default '0',
  PRIMARY KEY  (`grnno`),
  KEY `DeliveryDate` (`deliverydate`),
  KEY `ItemCode` (`itemcode`),
  KEY `PODetailItem` (`podetailitem`),
  KEY `SupplierID` (`supplierid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grns
-- ----------------------------
INSERT INTO `grns` VALUES ('18', '1', '2', 'DVD-LTWP', '2009-02-04', 'Lethal Weapon Linked', '1', '0', 'CAMPBELL', '2.7'), ('19', '2', '2', 'DVD-LTWP', '2009-02-05', 'Lethal Weapon Linked', '1', '0', 'CAMPBELL', '2.7'), ('20', '3', '2', 'DVD-LTWP', '2009-02-05', 'Lethal Weapon Linked', '1', '0', 'CAMPBELL', '2.7'), ('21', '4', '2', 'DVD-LTWP', '2009-02-05', 'Lethal Weapon Linked', '1', '0', 'CAMPBELL', '2.7'), ('22', '5', '2', 'DVD-LTWP', '2009-02-05', 'Lethal Weapon Linked', '1', '0', 'CAMPBELL', '2.7'), ('23', '6', '2', 'DVD-LTWP', '2009-02-05', 'Lethal Weapon Linked', '1', '0', 'CAMPBELL', '2.7'), ('24', '7', '2', 'DVD-LTWP', '2009-02-05', 'Lethal Weapon Linked', '1', '0', 'CAMPBELL', '2.7'), ('25', '8', '3', 'SALT', '2009-02-05', 'Salt', '1', '0', 'GOTSTUFF', '2.5'), ('26', '9', '3', 'SALT', '2009-02-05', 'Salt', '1', '0', 'GOTSTUFF', '2.5'), ('27', '10', '3', 'SALT', '2009-02-05', 'Salt', '1', '0', 'GOTSTUFF', '2.5'), ('28', '11', '3', 'SALT', '2009-02-05', 'Salt', '1', '0', 'GOTSTUFF', '2.5'), ('29', '12', '3', 'SALT', '2009-02-05', 'Salt', '1', '0', 'GOTSTUFF', '2.5'), ('30', '13', '3', 'SALT', '2009-02-05', 'Salt', '1', '0', 'GOTSTUFF', '2.5'), ('31', '14', '3', 'SALT', '2009-02-05', 'Salt', '1', '0', 'GOTSTUFF', '2.5');

-- ----------------------------
-- Table structure for `holdreasons`
-- ----------------------------
DROP TABLE IF EXISTS `holdreasons`;
CREATE TABLE `holdreasons` (
  `reasoncode` smallint(6) NOT NULL default '1',
  `reasondescription` char(30) NOT NULL default '',
  `dissallowinvoices` tinyint(4) NOT NULL default '-1',
  PRIMARY KEY  (`reasoncode`),
  KEY `ReasonDescription` (`reasondescription`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of holdreasons
-- ----------------------------
INSERT INTO `holdreasons` VALUES ('1', 'Good History', '0'), ('20', 'Watch', '0'), ('51', 'In liquidation', '1');

-- ----------------------------
-- Table structure for `lastcostrollup`
-- ----------------------------
DROP TABLE IF EXISTS `lastcostrollup`;
CREATE TABLE `lastcostrollup` (
  `stockid` char(20) NOT NULL default '',
  `totalonhand` double NOT NULL default '0',
  `matcost` decimal(20,4) NOT NULL default '0.0000',
  `labcost` decimal(20,4) NOT NULL default '0.0000',
  `oheadcost` decimal(20,4) NOT NULL default '0.0000',
  `categoryid` char(6) NOT NULL default '',
  `stockact` int(11) NOT NULL default '0',
  `adjglact` int(11) NOT NULL default '0',
  `newmatcost` decimal(20,4) NOT NULL default '0.0000',
  `newlabcost` decimal(20,4) NOT NULL default '0.0000',
  `newoheadcost` decimal(20,4) NOT NULL default '0.0000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lastcostrollup
-- ----------------------------

-- ----------------------------
-- Table structure for `locations`
-- ----------------------------
DROP TABLE IF EXISTS `locations`;
CREATE TABLE `locations` (
  `loccode` varchar(5) NOT NULL default '',
  `locationname` varchar(50) NOT NULL default '',
  `deladd1` varchar(40) NOT NULL default '',
  `deladd2` varchar(40) NOT NULL default '',
  `deladd3` varchar(40) NOT NULL default '',
  `deladd4` varchar(40) NOT NULL default '',
  `deladd5` varchar(20) NOT NULL default '',
  `deladd6` varchar(15) NOT NULL default '',
  `tel` varchar(30) NOT NULL default '',
  `fax` varchar(30) NOT NULL default '',
  `email` varchar(55) NOT NULL default '',
  `contact` varchar(30) NOT NULL default '',
  `taxprovinceid` tinyint(4) NOT NULL default '1',
  `cashsalecustomer` varchar(21) NOT NULL,
  `managed` int(11) default '0',
  PRIMARY KEY  (`loccode`),
  KEY `taxprovinceid` (`taxprovinceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of locations
-- ----------------------------
INSERT INTO `locations` VALUES ('MEL', 'Melbourne', '1234 Collins Street', 'Melbourne', 'Victoria 2345', '', '', 'Australia', '+61 3 56789012', '+61 3 56789013', 'jacko@webdemo.com', 'Jack Roberts', '1', 'ANGRY-ANGRY', '0'), ('TOR', 'Toronto', 'Level 100 ', 'CN Tower', 'Toronto', '', '', '', '', '', '', 'Clive Contrary', '1', '', '1');

-- ----------------------------
-- Table structure for `locstock`
-- ----------------------------
DROP TABLE IF EXISTS `locstock`;
CREATE TABLE `locstock` (
  `loccode` varchar(5) NOT NULL default '',
  `stockid` varchar(20) NOT NULL default '',
  `quantity` double NOT NULL default '0',
  `reorderlevel` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`loccode`,`stockid`),
  KEY `StockID` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of locstock
-- ----------------------------
INSERT INTO `locstock` VALUES ('MEL', 'BIGEARS12', '0', '0'), ('MEL', 'BirthdayCakeConstruc', '0', '0'), ('MEL', 'BREAD', '62', '0'), ('MEL', 'DR_TUMMY', '0', '0'), ('MEL', 'DVD-CASE', '0', '0'), ('MEL', 'DVD-DHWV', '-12', '0'), ('MEL', 'DVD-LTWP', '-3', '0'), ('MEL', 'DVD-TOPGUN', '-1', '0'), ('MEL', 'DVD-UNSG', '-10', '0'), ('MEL', 'DVD-UNSG2', '-10', '0'), ('MEL', 'DVD_ACTION', '10', '0'), ('MEL', 'FLOUR', '-4', '0'), ('MEL', 'FUJI990101', '0', '0'), ('MEL', 'FUJI990102', '0', '0'), ('MEL', 'FUJI9901ASS', '0', '0'), ('MEL', 'HIT3042-4', '0', '0'), ('MEL', 'HIT3043-5', '0', '0'), ('MEL', 'SALT', '2.22044604925031e-016', '0'), ('MEL', 'SLICE', '0', '0'), ('MEL', 'YEAST', '0', '0'), ('TOR', 'BIGEARS12', '0', '0'), ('TOR', 'BirthdayCakeConstruc', '0', '0'), ('TOR', 'BREAD', '6.5', '0'), ('TOR', 'DR_TUMMY', '0', '0'), ('TOR', 'DVD-CASE', '179', '0'), ('TOR', 'DVD-DHWV', '-1', '0'), ('TOR', 'DVD-LTWP', '-1', '0'), ('TOR', 'DVD-TOPGUN', '0', '0'), ('TOR', 'DVD-UNSG', '0', '0'), ('TOR', 'DVD-UNSG2', '0', '0'), ('TOR', 'DVD_ACTION', '0', '0'), ('TOR', 'FLOUR', '0', '0'), ('TOR', 'FUJI990101', '0', '0'), ('TOR', 'FUJI990102', '0', '0'), ('TOR', 'FUJI9901ASS', '0', '0'), ('TOR', 'HIT3042-4', '0', '0'), ('TOR', 'HIT3043-5', '0', '0'), ('TOR', 'SALT', '23.7', '0'), ('TOR', 'SLICE', '0', '0'), ('TOR', 'YEAST', '9.2', '0');

-- ----------------------------
-- Table structure for `loctransfers`
-- ----------------------------
DROP TABLE IF EXISTS `loctransfers`;
CREATE TABLE `loctransfers` (
  `reference` int(11) NOT NULL default '0',
  `stockid` varchar(20) NOT NULL default '',
  `shipqty` double NOT NULL default '0',
  `recqty` double NOT NULL default '0',
  `shipdate` date NOT NULL default '0000-00-00',
  `recdate` date NOT NULL default '0000-00-00',
  `shiploc` varchar(7) NOT NULL default '',
  `recloc` varchar(7) NOT NULL default '',
  KEY `Reference` (`reference`,`stockid`),
  KEY `ShipLoc` (`shiploc`),
  KEY `RecLoc` (`recloc`),
  KEY `StockID` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores Shipments To And From Locations';

-- ----------------------------
-- Records of loctransfers
-- ----------------------------
INSERT INTO `loctransfers` VALUES ('13', 'BREAD', '10', '10', '2009-02-05', '2009-02-06', 'MEL', 'TOR'), ('18', 'BREAD', '1', '1', '2009-02-05', '2009-02-06', 'MEL', 'TOR'), ('19', 'BREAD', '1', '1', '2009-02-05', '2009-02-06', 'MEL', 'TOR'), ('20', 'BREAD', '1', '0', '2009-02-05', '0000-00-00', 'MEL', 'TOR'), ('21', 'BREAD', '1', '0', '2009-02-05', '0000-00-00', 'MEL', 'TOR'), ('22', 'BREAD', '1', '0', '2009-02-05', '0000-00-00', 'MEL', 'TOR'), ('13', 'BREAD', '10', '10', '2009-02-05', '2009-02-06', 'MEL', 'TOR'), ('18', 'BREAD', '1', '1', '2009-02-05', '2009-02-06', 'MEL', 'TOR'), ('19', 'BREAD', '1', '1', '2009-02-05', '2009-02-06', 'MEL', 'TOR'), ('20', 'BREAD', '1', '0', '2009-02-05', '0000-00-00', 'MEL', 'TOR'), ('21', 'BREAD', '1', '0', '2009-02-05', '0000-00-00', 'MEL', 'TOR'), ('22', 'BREAD', '1', '0', '2009-02-05', '0000-00-00', 'MEL', 'TOR');

-- ----------------------------
-- Table structure for `mrpcalendar`
-- ----------------------------
DROP TABLE IF EXISTS `mrpcalendar`;
CREATE TABLE `mrpcalendar` (
  `calendardate` date NOT NULL,
  `daynumber` int(6) NOT NULL,
  `manufacturingflag` smallint(6) NOT NULL default '1',
  PRIMARY KEY  (`calendardate`),
  KEY `daynumber` (`daynumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mrpcalendar
-- ----------------------------

-- ----------------------------
-- Table structure for `mrpdemands`
-- ----------------------------
DROP TABLE IF EXISTS `mrpdemands`;
CREATE TABLE `mrpdemands` (
  `demandid` int(11) NOT NULL auto_increment,
  `stockid` varchar(20) NOT NULL default '',
  `mrpdemandtype` varchar(6) NOT NULL default '',
  `quantity` double NOT NULL default '0',
  `duedate` date NOT NULL default '0000-00-00',
  PRIMARY KEY  (`demandid`),
  KEY `StockID` (`stockid`),
  KEY `mrpdemands_ibfk_1` (`mrpdemandtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mrpdemands
-- ----------------------------

-- ----------------------------
-- Table structure for `mrpdemandtypes`
-- ----------------------------
DROP TABLE IF EXISTS `mrpdemandtypes`;
CREATE TABLE `mrpdemandtypes` (
  `mrpdemandtype` varchar(6) NOT NULL default '',
  `description` char(30) NOT NULL default '',
  PRIMARY KEY  (`mrpdemandtype`),
  KEY `mrpdemandtype` (`mrpdemandtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mrpdemandtypes
-- ----------------------------
INSERT INTO `mrpdemandtypes` VALUES ('FOR', 'Forecast');

-- ----------------------------
-- Table structure for `offers`
-- ----------------------------
DROP TABLE IF EXISTS `offers`;
CREATE TABLE `offers` (
  `offerid` int(11) NOT NULL auto_increment,
  `tenderid` int(11) NOT NULL default '0',
  `supplierid` varchar(10) NOT NULL default '',
  `stockid` varchar(20) NOT NULL default '',
  `quantity` double NOT NULL default '0',
  `uom` varchar(15) NOT NULL default '',
  `price` double NOT NULL default '0',
  `expirydate` date NOT NULL default '0000-00-00',
  `currcode` char(3) NOT NULL default '',
  PRIMARY KEY  (`offerid`),
  KEY `offers_ibfk_1` (`supplierid`),
  KEY `offers_ibfk_2` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of offers
-- ----------------------------

-- ----------------------------
-- Table structure for `orderdeliverydifferenceslog`
-- ----------------------------
DROP TABLE IF EXISTS `orderdeliverydifferenceslog`;
CREATE TABLE `orderdeliverydifferenceslog` (
  `orderno` int(11) NOT NULL default '0',
  `invoiceno` int(11) NOT NULL default '0',
  `stockid` varchar(20) NOT NULL default '',
  `quantitydiff` double NOT NULL default '0',
  `debtorno` varchar(10) NOT NULL default '',
  `branch` varchar(10) NOT NULL default '',
  `can_or_bo` char(3) NOT NULL default 'CAN',
  KEY `StockID` (`stockid`),
  KEY `DebtorNo` (`debtorno`,`branch`),
  KEY `Can_or_BO` (`can_or_bo`),
  KEY `OrderNo` (`orderno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderdeliverydifferenceslog
-- ----------------------------

-- ----------------------------
-- Table structure for `paymentmethods`
-- ----------------------------
DROP TABLE IF EXISTS `paymentmethods`;
CREATE TABLE `paymentmethods` (
  `paymentid` tinyint(4) NOT NULL auto_increment,
  `paymentname` varchar(15) NOT NULL default '',
  `paymenttype` int(11) NOT NULL default '1',
  `receipttype` int(11) NOT NULL default '1',
  PRIMARY KEY  (`paymentid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of paymentmethods
-- ----------------------------
INSERT INTO `paymentmethods` VALUES ('1', 'Cheque', '1', '1'), ('2', 'Cash', '1', '1'), ('3', 'Direct Credit', '1', '1');

-- ----------------------------
-- Table structure for `paymentterms`
-- ----------------------------
DROP TABLE IF EXISTS `paymentterms`;
CREATE TABLE `paymentterms` (
  `termsindicator` char(2) NOT NULL default '',
  `terms` char(40) NOT NULL default '',
  `daysbeforedue` smallint(6) NOT NULL default '0',
  `dayinfollowingmonth` smallint(6) NOT NULL default '0',
  PRIMARY KEY  (`termsindicator`),
  KEY `DaysBeforeDue` (`daysbeforedue`),
  KEY `DayInFollowingMonth` (`dayinfollowingmonth`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of paymentterms
-- ----------------------------
INSERT INTO `paymentterms` VALUES ('20', 'Due 20th Of the Following Month', '0', '22'), ('30', 'Due By End Of The Following Month', '0', '30'), ('7', 'Payment due within 7 days', '7', '0'), ('CA', 'Cash Only', '2', '0');

-- ----------------------------
-- Table structure for `pcashdetails`
-- ----------------------------
DROP TABLE IF EXISTS `pcashdetails`;
CREATE TABLE `pcashdetails` (
  `counterindex` int(20) NOT NULL auto_increment,
  `tabcode` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `codeexpense` varchar(20) NOT NULL,
  `amount` double NOT NULL,
  `authorized` date NOT NULL COMMENT 'date cash assigment was revised and authorized by authorizer from tabs table',
  `posted` tinyint(4) NOT NULL COMMENT 'has (or has not) been posted into gltrans',
  `notes` text NOT NULL,
  `receipt` text COMMENT 'filename or path to scanned receipt or code of receipt to find physical receipt if tax guys or auditors show up',
  PRIMARY KEY  (`counterindex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pcashdetails
-- ----------------------------

-- ----------------------------
-- Table structure for `pcexpenses`
-- ----------------------------
DROP TABLE IF EXISTS `pcexpenses`;
CREATE TABLE `pcexpenses` (
  `codeexpense` varchar(20) NOT NULL COMMENT 'code for the group',
  `description` varchar(50) NOT NULL COMMENT 'text description, e.g. meals, train tickets, fuel, etc',
  `glaccount` int(11) NOT NULL COMMENT 'GL related account',
  PRIMARY KEY  (`codeexpense`),
  KEY `glaccount` (`glaccount`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pcexpenses
-- ----------------------------

-- ----------------------------
-- Table structure for `pctabexpenses`
-- ----------------------------
DROP TABLE IF EXISTS `pctabexpenses`;
CREATE TABLE `pctabexpenses` (
  `typetabcode` varchar(20) NOT NULL,
  `codeexpense` varchar(20) NOT NULL,
  KEY `typetabcode` (`typetabcode`),
  KEY `codeexpense` (`codeexpense`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pctabexpenses
-- ----------------------------

-- ----------------------------
-- Table structure for `pctabs`
-- ----------------------------
DROP TABLE IF EXISTS `pctabs`;
CREATE TABLE `pctabs` (
  `tabcode` varchar(20) NOT NULL,
  `usercode` varchar(20) NOT NULL COMMENT 'code of user employee from www_users',
  `typetabcode` varchar(20) NOT NULL,
  `currency` char(3) NOT NULL,
  `tablimit` double NOT NULL,
  `authorizer` varchar(20) NOT NULL COMMENT 'code of user from www_users',
  `glaccountassignment` int(11) NOT NULL COMMENT 'gl account where the money comes from',
  `glaccountpcash` int(11) NOT NULL,
  PRIMARY KEY  (`tabcode`),
  KEY `usercode` (`usercode`),
  KEY `typetabcode` (`typetabcode`),
  KEY `currency` (`currency`),
  KEY `authorizer` (`authorizer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pctabs
-- ----------------------------

-- ----------------------------
-- Table structure for `pctypetabs`
-- ----------------------------
DROP TABLE IF EXISTS `pctypetabs`;
CREATE TABLE `pctypetabs` (
  `typetabcode` varchar(20) NOT NULL COMMENT 'code for the type of petty cash tab',
  `typetabdescription` varchar(50) NOT NULL COMMENT 'text description, e.g. tab for CEO',
  PRIMARY KEY  (`typetabcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pctypetabs
-- ----------------------------

-- ----------------------------
-- Table structure for `periods`
-- ----------------------------
DROP TABLE IF EXISTS `periods`;
CREATE TABLE `periods` (
  `periodno` smallint(6) NOT NULL default '0',
  `lastdate_in_period` date NOT NULL default '0000-00-00',
  PRIMARY KEY  (`periodno`),
  KEY `LastDate_in_Period` (`lastdate_in_period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of periods
-- ----------------------------
INSERT INTO `periods` VALUES ('-4', '2010-04-30'), ('-3', '2010-05-31'), ('-2', '2010-06-30'), ('-1', '2010-07-31'), ('0', '2010-08-31'), ('1', '2010-09-30'), ('2', '2010-10-31'), ('3', '2010-11-30'), ('4', '2010-12-31'), ('5', '2011-01-31'), ('6', '2011-02-28'), ('7', '2011-03-31'), ('8', '2011-04-30'), ('9', '2011-05-31'), ('10', '2011-06-30'), ('11', '2011-07-31'), ('12', '2011-08-31'), ('13', '2011-09-30'), ('14', '2011-10-31'), ('15', '2011-11-30'), ('16', '2011-12-31'), ('17', '2012-01-31'), ('18', '2012-02-29'), ('19', '2012-03-31'), ('20', '2012-04-30'), ('21', '2012-05-31'), ('22', '2012-06-30'), ('23', '2012-07-31'), ('24', '2012-08-31'), ('25', '2012-09-30'), ('26', '2012-10-31'), ('27', '2012-11-30'), ('28', '2012-12-31'), ('29', '2013-01-31'), ('30', '2013-02-28'), ('31', '2013-03-31'), ('32', '2013-04-30'), ('33', '2013-05-31');

-- ----------------------------
-- Table structure for `pickinglistdetails`
-- ----------------------------
DROP TABLE IF EXISTS `pickinglistdetails`;
CREATE TABLE `pickinglistdetails` (
  `pickinglistno` int(11) NOT NULL default '0',
  `pickinglistlineno` int(11) NOT NULL default '0',
  `orderlineno` int(11) NOT NULL default '0',
  `qtyexpected` double NOT NULL default '0',
  `qtypicked` double NOT NULL default '0',
  PRIMARY KEY  (`pickinglistno`,`pickinglistlineno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pickinglistdetails
-- ----------------------------

-- ----------------------------
-- Table structure for `pickinglists`
-- ----------------------------
DROP TABLE IF EXISTS `pickinglists`;
CREATE TABLE `pickinglists` (
  `pickinglistno` int(11) NOT NULL default '0',
  `orderno` int(11) NOT NULL default '0',
  `pickinglistdate` date NOT NULL default '0000-00-00',
  `dateprinted` date NOT NULL default '0000-00-00',
  `deliverynotedate` date NOT NULL default '0000-00-00',
  PRIMARY KEY  (`pickinglistno`),
  KEY `pickinglists_ibfk_1` (`orderno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pickinglists
-- ----------------------------

-- ----------------------------
-- Table structure for `prices`
-- ----------------------------
DROP TABLE IF EXISTS `prices`;
CREATE TABLE `prices` (
  `stockid` varchar(20) NOT NULL default '',
  `typeabbrev` char(2) NOT NULL default '',
  `currabrev` char(3) NOT NULL default '',
  `debtorno` varchar(10) NOT NULL default '',
  `price` decimal(20,4) NOT NULL default '0.0000',
  `branchcode` varchar(10) NOT NULL default '',
  `startdate` date NOT NULL default '0000-00-00',
  `enddate` date NOT NULL default '9999-12-31',
  PRIMARY KEY  (`stockid`,`typeabbrev`,`currabrev`,`debtorno`,`branchcode`,`startdate`,`enddate`),
  KEY `CurrAbrev` (`currabrev`),
  KEY `DebtorNo` (`debtorno`),
  KEY `StockID` (`stockid`),
  KEY `TypeAbbrev` (`typeabbrev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of prices
-- ----------------------------
INSERT INTO `prices` VALUES ('BIGEARS12', 'DE', 'AUD', '', '4428.0000', '', '1999-01-01', '0000-00-00'), ('BirthdayCakeConstruc', 'DE', 'AUD', '', '1476.0000', '', '1999-01-01', '0000-00-00'), ('BREAD', 'DE', 'AUD', '', '123.0000', '', '1999-01-01', '0000-00-00'), ('DR_TUMMY', 'DE', 'AUD', '', '246.0000', '', '1999-01-01', '0000-00-00'), ('DVD-CASE', 'DE', 'AUD', '', '123.0000', '', '1999-01-01', '0000-00-00'), ('DVD-DHWV', 'DE', 'AUD', '', '123.0000', '', '1999-01-01', '0000-00-00'), ('DVD-LTWP', 'DE', 'AUD', '', '123.0000', '', '1999-01-01', '0000-00-00'), ('DVD-TOPGUN', 'DE', 'AUD', '', '123.0000', '', '1999-01-01', '0000-00-00'), ('DVD-UNSG', 'DE', 'AUD', '', '123.0000', '', '1999-01-01', '0000-00-00'), ('DVD-UNSG2', 'DE', 'AUD', '', '123.0000', '', '1999-01-01', '0000-00-00'), ('DVD_ACTION', 'DE', 'AUD', '', '123.0000', '', '1999-01-01', '0000-00-00'), ('FLOUR', 'DE', 'AUD', '', '123.0000', '', '1999-01-01', '0000-00-00'), ('FUJI990101', 'DE', 'AUD', '', '1353.0000', '', '1999-01-01', '0000-00-00'), ('FUJI990102', 'DE', 'AUD', '', '861.0000', '', '1999-01-01', '0000-00-00'), ('HIT3042-4', 'DE', 'AUD', '', '1107.0000', '', '1999-01-01', '0000-00-00'), ('HIT3043-5', 'DE', 'AUD', '', '1599.0000', '', '1999-01-01', '0000-00-00'), ('HIT3043-5', 'DE', 'USD', '', '2300.0000', '', '1999-01-01', '0000-00-00'), ('SALT', 'DE', 'AUD', '', '123.0000', '', '1999-01-01', '0000-00-00'), ('SLICE', 'DE', 'AUD', '', '123.0000', '', '1999-01-01', '0000-00-00'), ('YEAST', 'DE', 'AUD', '', '123.0000', '', '1999-01-01', '0000-00-00');

-- ----------------------------
-- Table structure for `purchdata`
-- ----------------------------
DROP TABLE IF EXISTS `purchdata`;
CREATE TABLE `purchdata` (
  `supplierno` char(10) NOT NULL default '',
  `stockid` char(20) NOT NULL default '',
  `price` decimal(20,4) NOT NULL default '0.0000',
  `suppliersuom` char(50) NOT NULL default '',
  `conversionfactor` double NOT NULL default '1',
  `supplierdescription` char(50) NOT NULL default '',
  `leadtime` smallint(6) NOT NULL default '1',
  `preferred` tinyint(4) NOT NULL default '0',
  `effectivefrom` date NOT NULL,
  `suppliers_partno` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`supplierno`,`stockid`,`effectivefrom`),
  KEY `StockID` (`stockid`),
  KEY `SupplierNo` (`supplierno`),
  KEY `Preferred` (`preferred`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of purchdata
-- ----------------------------
INSERT INTO `purchdata` VALUES ('BINGO', 'HIT3043-5', '1235.0000', '', '1', '', '5', '1', '2009-09-18', ''), ('CRUISE', 'DVD-UNSG2', '200.0000', '10 Pack', '10', '', '5', '1', '2009-09-18', '');

-- ----------------------------
-- Table structure for `purchorderauth`
-- ----------------------------
DROP TABLE IF EXISTS `purchorderauth`;
CREATE TABLE `purchorderauth` (
  `userid` varchar(20) NOT NULL default '',
  `currabrev` char(3) NOT NULL default '',
  `cancreate` smallint(2) NOT NULL default '0',
  `authlevel` int(11) NOT NULL default '0',
  `offhold` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`userid`,`currabrev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of purchorderauth
-- ----------------------------
INSERT INTO `purchorderauth` VALUES ('admin', 'AUD', '0', '999999999', '0'), ('admin', 'EUR', '0', '999999999', '0'), ('admin', 'GBP', '0', '9999999', '0'), ('admin', 'USD', '0', '9999999', '0');

-- ----------------------------
-- Table structure for `purchorderdetails`
-- ----------------------------
DROP TABLE IF EXISTS `purchorderdetails`;
CREATE TABLE `purchorderdetails` (
  `podetailitem` int(11) NOT NULL auto_increment,
  `orderno` int(11) NOT NULL default '0',
  `itemcode` varchar(20) NOT NULL default '',
  `deliverydate` date NOT NULL default '0000-00-00',
  `itemdescription` varchar(100) NOT NULL default '',
  `glcode` int(11) NOT NULL default '0',
  `qtyinvoiced` double NOT NULL default '0',
  `unitprice` double NOT NULL default '0',
  `actprice` double NOT NULL default '0',
  `stdcostunit` double NOT NULL default '0',
  `quantityord` double NOT NULL default '0',
  `quantityrecd` double NOT NULL default '0',
  `shiptref` int(11) NOT NULL default '0',
  `jobref` varchar(20) NOT NULL default '',
  `completed` tinyint(4) NOT NULL default '0',
  `itemno` varchar(50) NOT NULL default '',
  `uom` varchar(50) NOT NULL default '',
  `subtotal_amount` varchar(50) NOT NULL default '',
  `package` varchar(100) NOT NULL default '',
  `pcunit` varchar(50) NOT NULL default '',
  `nw` varchar(50) NOT NULL default '',
  `suppliers_partno` varchar(50) NOT NULL default '',
  `gw` varchar(50) NOT NULL default '',
  `cuft` varchar(50) NOT NULL default '',
  `total_quantity` varchar(50) NOT NULL default '',
  `total_amount` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`podetailitem`),
  KEY `DeliveryDate` (`deliverydate`),
  KEY `GLCode` (`glcode`),
  KEY `ItemCode` (`itemcode`),
  KEY `JobRef` (`jobref`),
  KEY `OrderNo` (`orderno`),
  KEY `ShiptRef` (`shiptref`),
  KEY `Completed` (`completed`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of purchorderdetails
-- ----------------------------
INSERT INTO `purchorderdetails` VALUES ('1', '1', 'DVD-CASE', '2007-06-25', 'webERP Demo DVD Case', '1460', '0', '0.23', '0', '0', '45', '0', '0', '', '0', '', '', '', '', '', '', '', '', '', '', ''), ('2', '1', 'DVD-LTWP', '2007-06-25', 'Lethal Weapon Linked', '1460', '0', '2.98', '0', '2.7', '7', '7', '0', '', '1', '', '', '', '', '', '', '', '', '', '', ''), ('3', '2', 'SALT', '2009-02-05', 'Salt', '1460', '0', '100', '0', '2.5', '20', '7', '0', '', '0', '', '', '', '', '', '', '', '', '', '', ''), ('4', '3', 'BREAD', '2010-08-14', 'Bread', '1460', '0', '0.25', '0', '0', '12', '0', '0', '0', '0', 'BREAD', 'each', '0', '', '0', '0', '', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `purchorders`
-- ----------------------------
DROP TABLE IF EXISTS `purchorders`;
CREATE TABLE `purchorders` (
  `orderno` int(11) NOT NULL auto_increment,
  `supplierno` varchar(10) NOT NULL default '',
  `comments` longblob,
  `orddate` datetime NOT NULL default '0000-00-00 00:00:00',
  `rate` double NOT NULL default '1',
  `dateprinted` datetime default NULL,
  `allowprint` tinyint(4) NOT NULL default '1',
  `initiator` varchar(10) default NULL,
  `requisitionno` varchar(15) default NULL,
  `intostocklocation` varchar(5) NOT NULL default '',
  `deladd1` varchar(40) NOT NULL default '',
  `deladd2` varchar(40) NOT NULL default '',
  `deladd3` varchar(40) NOT NULL default '',
  `deladd4` varchar(40) NOT NULL default '',
  `deladd5` varchar(20) NOT NULL default '',
  `deladd6` varchar(15) NOT NULL default '',
  `tel` varchar(15) NOT NULL default '',
  `suppdeladdress1` varchar(40) NOT NULL default '',
  `suppdeladdress2` varchar(40) NOT NULL default '',
  `suppdeladdress3` varchar(40) NOT NULL default '',
  `suppdeladdress4` varchar(40) NOT NULL default '',
  `suppdeladdress5` varchar(20) NOT NULL default '',
  `suppdeladdress6` varchar(15) NOT NULL default '',
  `suppliercontact` varchar(30) NOT NULL default '',
  `supptel` varchar(30) NOT NULL default '',
  `contact` varchar(30) NOT NULL default '',
  `version` decimal(3,2) NOT NULL default '1.00',
  `revised` date NOT NULL default '0000-00-00',
  `realorderno` varchar(16) NOT NULL default '',
  `deliveryby` varchar(100) NOT NULL default '',
  `deliverydate` date NOT NULL default '0000-00-00',
  `status` varchar(12) NOT NULL default '',
  `stat_comment` text NOT NULL,
  `paymentterms` char(2) NOT NULL default '',
  `port` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`orderno`),
  KEY `OrdDate` (`orddate`),
  KEY `SupplierNo` (`supplierno`),
  KEY `IntoStockLocation` (`intostocklocation`),
  KEY `AllowPrintPO` (`allowprint`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of purchorders
-- ----------------------------
INSERT INTO `purchorders` VALUES ('1', 'CAMPBELL', '', '2007-06-25 00:00:00', '1', '2007-06-25 00:00:00', '0', '', '', 'MEL', '1234 Collins Street', 'Melbourne', 'Victoria 2345', '', '', 'Australia', '', '', '', '', '', '', '', '', '', '', '1.00', '0000-00-00', '', '', '2007-06-25', 'Printed', '', '', ''), ('2', 'GOTSTUFF', '', '2009-02-05 00:00:00', '1', null, '1', '', '0', 'MEL', '1234 Collins Street', 'Melbourne', 'Victoria 2345', '', '', 'Australia', '', '', '', '', '', '', '', '', '', '', '1.00', '0000-00-00', '', '', '2009-02-05', 'Authorised', '', '', ''), ('3', 'BINGO', '', '2010-08-14 00:00:00', '0.85', '2010-08-14 00:00:00', '0', 'admin', '', 'MEL', '1234 Collins Street', 'Melbourne', 'Victoria 2345', '', '', 'Australia', '+61 3 56789012', 'Box 3499', 'Gardenier', 'San Fransisco', 'California 54424', '', '', '', '', 'Jack Roberts', '1.00', '2010-08-14', '', '1', '2010-08-14', 'Printed', '14/08/2010 - Printed by <a href=\"mailto:\">admin</a><br>14/08/2010 - Authorised by <a href=\"mailto:\">admin</a><br>14/08/2010 - Order Created by &lt;a href=&quot;mailto:&quot;&gt;admin&lt;/a&gt; - &lt;br&gt;', '30', '');

-- ----------------------------
-- Table structure for `recurringsalesorders`
-- ----------------------------
DROP TABLE IF EXISTS `recurringsalesorders`;
CREATE TABLE `recurringsalesorders` (
  `recurrorderno` int(11) NOT NULL auto_increment,
  `debtorno` varchar(10) NOT NULL default '',
  `branchcode` varchar(10) NOT NULL default '',
  `customerref` varchar(50) NOT NULL default '',
  `buyername` varchar(50) default NULL,
  `comments` longblob,
  `orddate` date NOT NULL default '0000-00-00',
  `ordertype` char(2) NOT NULL default '',
  `shipvia` int(11) NOT NULL default '0',
  `deladd1` varchar(40) NOT NULL default '',
  `deladd2` varchar(40) NOT NULL default '',
  `deladd3` varchar(40) NOT NULL default '',
  `deladd4` varchar(40) default NULL,
  `deladd5` varchar(20) NOT NULL default '',
  `deladd6` varchar(15) NOT NULL default '',
  `contactphone` varchar(25) default NULL,
  `contactemail` varchar(25) default NULL,
  `deliverto` varchar(40) NOT NULL default '',
  `freightcost` double NOT NULL default '0',
  `fromstkloc` varchar(5) NOT NULL default '',
  `lastrecurrence` date NOT NULL default '0000-00-00',
  `stopdate` date NOT NULL default '0000-00-00',
  `frequency` tinyint(4) NOT NULL default '1',
  `autoinvoice` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`recurrorderno`),
  KEY `debtorno` (`debtorno`),
  KEY `orddate` (`orddate`),
  KEY `ordertype` (`ordertype`),
  KEY `locationindex` (`fromstkloc`),
  KEY `branchcode` (`branchcode`,`debtorno`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of recurringsalesorders
-- ----------------------------
INSERT INTO `recurringsalesorders` VALUES ('3', 'ANGRY', 'ANGRY', '', null, null, '2007-01-01', 'DE', '1', '', '', '', '', '', '', '0422 2245 2213', 'graville@angry.com', 'Angus Rouledge - Toronto', '0', 'DEN', '2007-01-01', '2009-01-01', '6', '0'), ('4', 'ANGRY', 'ANGRY', '', null, null, '2007-01-02', 'DE', '1', '', '', '', '', '', '', '0422 2245 2213', 'graville@angry.com', 'Angus Rouledge - Toronto', '0', 'DEN', '2007-01-02', '2009-01-02', '6', '0'), ('5', 'ANGRY', 'ANGRY', '', null, null, '2007-02-01', 'DE', '1', '', '', '', '', '', '', '0422 2245 2213', 'graville@angry.com', 'Angus Rouledge - Toronto', '0', 'DEN', '2007-02-01', '2009-02-01', '6', '0'), ('6', 'ANGRY', 'ANGRY', '', null, null, '2007-03-01', 'DE', '1', '', '', '', '', '', '', '0422 2245 2213', 'graville@angry.com', 'Angus Rouledge - Toronto', '0', 'DEN', '2007-03-01', '2009-03-01', '6', '0'), ('7', 'ANGRY', 'ANGRY', '', null, null, '2007-04-01', 'DE', '1', '', '', '', '', '', '', '0422 2245 2213', 'graville@angry.com', 'Angus Rouledge - Toronto', '0', 'DEN', '2007-04-01', '2009-04-01', '6', '0');

-- ----------------------------
-- Table structure for `recurrsalesorderdetails`
-- ----------------------------
DROP TABLE IF EXISTS `recurrsalesorderdetails`;
CREATE TABLE `recurrsalesorderdetails` (
  `recurrorderno` int(11) NOT NULL default '0',
  `stkcode` varchar(20) NOT NULL default '',
  `unitprice` double NOT NULL default '0',
  `quantity` double NOT NULL default '0',
  `discountpercent` double NOT NULL default '0',
  `narrative` text NOT NULL,
  KEY `orderno` (`recurrorderno`),
  KEY `stkcode` (`stkcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of recurrsalesorderdetails
-- ----------------------------
INSERT INTO `recurrsalesorderdetails` VALUES ('3', 'DVD-DHWV', '50', '2', '0', ''), ('4', 'DVD-LTWP', '28', '3', '0', ''), ('5', 'DVD-UNSG2', '15', '5', '0', ''), ('6', 'DVD-UNSG', '17.5', '6', '0', ''), ('7', 'DVD-DHWV', '30', '1', '0', ''), ('3', 'DVD-DHWV', '50', '2', '0', ''), ('4', 'DVD-LTWP', '28', '3', '0', ''), ('5', 'DVD-UNSG2', '15', '5', '0', ''), ('6', 'DVD-UNSG', '17.5', '6', '0', ''), ('7', 'DVD-DHWV', '30', '1', '0', ''), ('3', 'DVD-DHWV', '50', '2', '0', ''), ('4', 'DVD-LTWP', '28', '3', '0', ''), ('5', 'DVD-UNSG2', '15', '5', '0', ''), ('6', 'DVD-UNSG', '17.5', '6', '0', ''), ('7', 'DVD-DHWV', '30', '1', '0', ''), ('3', 'DVD-DHWV', '50', '2', '0', ''), ('4', 'DVD-LTWP', '28', '3', '0', ''), ('5', 'DVD-UNSG2', '15', '5', '0', ''), ('6', 'DVD-UNSG', '17.5', '6', '0', ''), ('7', 'DVD-DHWV', '30', '1', '0', '');

-- ----------------------------
-- Table structure for `reportcolumns`
-- ----------------------------
DROP TABLE IF EXISTS `reportcolumns`;
CREATE TABLE `reportcolumns` (
  `reportid` smallint(6) NOT NULL default '0',
  `colno` smallint(6) NOT NULL default '0',
  `heading1` varchar(15) NOT NULL default '',
  `heading2` varchar(15) default NULL,
  `calculation` tinyint(1) NOT NULL default '0',
  `periodfrom` smallint(6) default NULL,
  `periodto` smallint(6) default NULL,
  `datatype` varchar(15) default NULL,
  `colnumerator` tinyint(4) default NULL,
  `coldenominator` tinyint(4) default NULL,
  `calcoperator` char(1) default NULL,
  `budgetoractual` tinyint(1) NOT NULL default '0',
  `valformat` char(1) NOT NULL default 'N',
  `constant` double NOT NULL default '0',
  PRIMARY KEY  (`reportid`,`colno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reportcolumns
-- ----------------------------
INSERT INTO `reportcolumns` VALUES ('1', '1', 'Value', '', '0', '1', '1', 'Net Value', '0', '0', '', '1', 'N', '0');

-- ----------------------------
-- Table structure for `reportfields`
-- ----------------------------
DROP TABLE IF EXISTS `reportfields`;
CREATE TABLE `reportfields` (
  `id` int(8) NOT NULL auto_increment,
  `reportid` int(5) NOT NULL default '0',
  `entrytype` varchar(15) NOT NULL default '',
  `seqnum` int(3) NOT NULL default '0',
  `fieldname` varchar(80) NOT NULL default '',
  `displaydesc` varchar(25) NOT NULL default '',
  `visible` enum('1','0') NOT NULL default '1',
  `columnbreak` enum('1','0') NOT NULL default '1',
  `params` text,
  PRIMARY KEY  (`id`),
  KEY `reportid` (`reportid`)
) ENGINE=MyISAM AUTO_INCREMENT=1805 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reportfields
-- ----------------------------
INSERT INTO `reportfields` VALUES ('1803', '135', 'critlist', '1', 'prices.currabrev', 'Currency', '0', '0', '0'), ('1802', '135', 'fieldlist', '4', 'prices.currabrev', 'Currency', '1', '1', '0'), ('1801', '135', 'fieldlist', '3', 'prices.typeabbrev', 'Price List', '1', '1', '0'), ('1800', '135', 'fieldlist', '2', 'prices.price', 'Price', '1', '1', '0'), ('1799', '135', 'fieldlist', '1', 'stockmaster.stockid', 'Item', '1', '1', '0'), ('1797', '135', 'trunclong', '0', '', '', '1', '1', '0'), ('1798', '135', 'dateselect', '0', '', '', '1', '1', 'a'), ('1804', '135', 'sortlist', '1', 'stockmaster.stockid', 'Item', '0', '0', '1');

-- ----------------------------
-- Table structure for `reportheaders`
-- ----------------------------
DROP TABLE IF EXISTS `reportheaders`;
CREATE TABLE `reportheaders` (
  `reportid` smallint(6) NOT NULL auto_increment,
  `reportheading` varchar(80) NOT NULL default '',
  `groupbydata1` varchar(15) NOT NULL default '',
  `newpageafter1` tinyint(1) NOT NULL default '0',
  `lower1` varchar(10) NOT NULL default '',
  `upper1` varchar(10) NOT NULL default '',
  `groupbydata2` varchar(15) default NULL,
  `newpageafter2` tinyint(1) NOT NULL default '0',
  `lower2` varchar(10) default NULL,
  `upper2` varchar(10) default NULL,
  `groupbydata3` varchar(15) default NULL,
  `newpageafter3` tinyint(1) NOT NULL default '0',
  `lower3` varchar(10) default NULL,
  `upper3` varchar(10) default NULL,
  `groupbydata4` varchar(15) NOT NULL default '',
  `newpageafter4` tinyint(1) NOT NULL default '0',
  `upper4` varchar(10) NOT NULL default '',
  `lower4` varchar(10) NOT NULL default '',
  PRIMARY KEY  (`reportid`),
  KEY `ReportHeading` (`reportheading`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reportheaders
-- ----------------------------
INSERT INTO `reportheaders` VALUES ('1', 'Test report', 'Sales Area', '0', '0', 'zzzzz', 'Customer Code', '0', '1', 'zzzzzzzzzz', 'Product Code', '0', '1', 'zzzzzzzzz', 'Not Used', '0', '', '');

-- ----------------------------
-- Table structure for `reportlinks`
-- ----------------------------
DROP TABLE IF EXISTS `reportlinks`;
CREATE TABLE `reportlinks` (
  `table1` varchar(25) NOT NULL default '',
  `table2` varchar(25) NOT NULL default '',
  `equation` varchar(75) NOT NULL default ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reportlinks
-- ----------------------------
INSERT INTO `reportlinks` VALUES ('accountgroups', 'accountsection', 'accountgroups.sectioninaccounts=accountsection.sectionid'), ('accountsection', 'accountgroups', 'accountsection.sectionid=accountgroups.sectioninaccounts'), ('bankaccounts', 'chartmaster', 'bankaccounts.accountcode=chartmaster.accountcode'), ('chartmaster', 'bankaccounts', 'chartmaster.accountcode=bankaccounts.accountcode'), ('banktrans', 'systypes', 'banktrans.type=systypes.typeid'), ('systypes', 'banktrans', 'systypes.typeid=banktrans.type'), ('banktrans', 'bankaccounts', 'banktrans.bankact=bankaccounts.accountcode'), ('bankaccounts', 'banktrans', 'bankaccounts.accountcode=banktrans.bankact'), ('bom', 'stockmaster', 'bom.parent=stockmaster.stockid'), ('stockmaster', 'bom', 'stockmaster.stockid=bom.parent'), ('bom', 'stockmaster', 'bom.component=stockmaster.stockid'), ('stockmaster', 'bom', 'stockmaster.stockid=bom.component'), ('bom', 'workcentres', 'bom.workcentreadded=workcentres.code'), ('workcentres', 'bom', 'workcentres.code=bom.workcentreadded'), ('bom', 'locations', 'bom.loccode=locations.loccode'), ('locations', 'bom', 'locations.loccode=bom.loccode'), ('buckets', 'workcentres', 'buckets.workcentre=workcentres.code'), ('workcentres', 'buckets', 'workcentres.code=buckets.workcentre'), ('chartdetails', 'chartmaster', 'chartdetails.accountcode=chartmaster.accountcode'), ('chartmaster', 'chartdetails', 'chartmaster.accountcode=chartdetails.accountcode'), ('chartdetails', 'periods', 'chartdetails.period=periods.periodno'), ('periods', 'chartdetails', 'periods.periodno=chartdetails.period'), ('chartmaster', 'accountgroups', 'chartmaster.group_=accountgroups.groupname'), ('accountgroups', 'chartmaster', 'accountgroups.groupname=chartmaster.group_'), ('contractbom', 'workcentres', 'contractbom.workcentreadded=workcentres.code'), ('workcentres', 'contractbom', 'workcentres.code=contractbom.workcentreadded'), ('contractbom', 'locations', 'contractbom.loccode=locations.loccode'), ('locations', 'contractbom', 'locations.loccode=contractbom.loccode'), ('contractbom', 'stockmaster', 'contractbom.component=stockmaster.stockid'), ('stockmaster', 'contractbom', 'stockmaster.stockid=contractbom.component'), ('contractreqts', 'contracts', 'contractreqts.contract=contracts.contractref'), ('contracts', 'contractreqts', 'contracts.contractref=contractreqts.contract'), ('contracts', 'custbranch', 'contracts.debtorno=custbranch.debtorno'), ('custbranch', 'contracts', 'custbranch.debtorno=contracts.debtorno'), ('contracts', 'stockcategory', 'contracts.branchcode=stockcategory.categoryid'), ('stockcategory', 'contracts', 'stockcategory.categoryid=contracts.branchcode'), ('contracts', 'salestypes', 'contracts.typeabbrev=salestypes.typeabbrev'), ('salestypes', 'contracts', 'salestypes.typeabbrev=contracts.typeabbrev'), ('custallocns', 'debtortrans', 'custallocns.transid_allocfrom=debtortrans.id'), ('debtortrans', 'custallocns', 'debtortrans.id=custallocns.transid_allocfrom'), ('custallocns', 'debtortrans', 'custallocns.transid_allocto=debtortrans.id'), ('debtortrans', 'custallocns', 'debtortrans.id=custallocns.transid_allocto'), ('custbranch', 'debtorsmaster', 'custbranch.debtorno=debtorsmaster.debtorno'), ('debtorsmaster', 'custbranch', 'debtorsmaster.debtorno=custbranch.debtorno'), ('custbranch', 'areas', 'custbranch.area=areas.areacode'), ('areas', 'custbranch', 'areas.areacode=custbranch.area'), ('custbranch', 'salesman', 'custbranch.salesman=salesman.salesmancode'), ('salesman', 'custbranch', 'salesman.salesmancode=custbranch.salesman'), ('custbranch', 'locations', 'custbranch.defaultlocation=locations.loccode'), ('locations', 'custbranch', 'locations.loccode=custbranch.defaultlocation'), ('custbranch', 'shippers', 'custbranch.defaultshipvia=shippers.shipper_id'), ('shippers', 'custbranch', 'shippers.shipper_id=custbranch.defaultshipvia'), ('debtorsmaster', 'holdreasons', 'debtorsmaster.holdreason=holdreasons.reasoncode'), ('holdreasons', 'debtorsmaster', 'holdreasons.reasoncode=debtorsmaster.holdreason'), ('debtorsmaster', 'currencies', 'debtorsmaster.currcode=currencies.currabrev'), ('currencies', 'debtorsmaster', 'currencies.currabrev=debtorsmaster.currcode'), ('debtorsmaster', 'paymentterms', 'debtorsmaster.paymentterms=paymentterms.termsindicator'), ('paymentterms', 'debtorsmaster', 'paymentterms.termsindicator=debtorsmaster.paymentterms'), ('debtorsmaster', 'salestypes', 'debtorsmaster.salestype=salestypes.typeabbrev'), ('salestypes', 'debtorsmaster', 'salestypes.typeabbrev=debtorsmaster.salestype'), ('debtortrans', 'custbranch', 'debtortrans.debtorno=custbranch.debtorno'), ('custbranch', 'debtortrans', 'custbranch.debtorno=debtortrans.debtorno'), ('debtortrans', 'systypes', 'debtortrans.type=systypes.typeid'), ('systypes', 'debtortrans', 'systypes.typeid=debtortrans.type'), ('debtortrans', 'periods', 'debtortrans.prd=periods.periodno'), ('periods', 'debtortrans', 'periods.periodno=debtortrans.prd'), ('debtortranstaxes', 'taxauthorities', 'debtortranstaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'debtortranstaxes', 'taxauthorities.taxid=debtortranstaxes.taxauthid'), ('debtortranstaxes', 'debtortrans', 'debtortranstaxes.debtortransid=debtortrans.id'), ('debtortrans', 'debtortranstaxes', 'debtortrans.id=debtortranstaxes.debtortransid'), ('discountmatrix', 'salestypes', 'discountmatrix.salestype=salestypes.typeabbrev'), ('salestypes', 'discountmatrix', 'salestypes.typeabbrev=discountmatrix.salestype'), ('freightcosts', 'locations', 'freightcosts.locationfrom=locations.loccode'), ('locations', 'freightcosts', 'locations.loccode=freightcosts.locationfrom'), ('freightcosts', 'shippers', 'freightcosts.shipperid=shippers.shipper_id'), ('shippers', 'freightcosts', 'shippers.shipper_id=freightcosts.shipperid'), ('gltrans', 'chartmaster', 'gltrans.account=chartmaster.accountcode'), ('chartmaster', 'gltrans', 'chartmaster.accountcode=gltrans.account'), ('gltrans', 'systypes', 'gltrans.type=systypes.typeid'), ('systypes', 'gltrans', 'systypes.typeid=gltrans.type'), ('gltrans', 'periods', 'gltrans.periodno=periods.periodno'), ('periods', 'gltrans', 'periods.periodno=gltrans.periodno'), ('grns', 'suppliers', 'grns.supplierid=suppliers.supplierid'), ('suppliers', 'grns', 'suppliers.supplierid=grns.supplierid'), ('grns', 'purchorderdetails', 'grns.podetailitem=purchorderdetails.podetailitem'), ('purchorderdetails', 'grns', 'purchorderdetails.podetailitem=grns.podetailitem'), ('locations', 'taxprovinces', 'locations.taxprovinceid=taxprovinces.taxprovinceid'), ('taxprovinces', 'locations', 'taxprovinces.taxprovinceid=locations.taxprovinceid'), ('locstock', 'locations', 'locstock.loccode=locations.loccode'), ('locations', 'locstock', 'locations.loccode=locstock.loccode'), ('locstock', 'stockmaster', 'locstock.stockid=stockmaster.stockid'), ('stockmaster', 'locstock', 'stockmaster.stockid=locstock.stockid'), ('loctransfers', 'locations', 'loctransfers.shiploc=locations.loccode'), ('locations', 'loctransfers', 'locations.loccode=loctransfers.shiploc'), ('loctransfers', 'locations', 'loctransfers.recloc=locations.loccode'), ('locations', 'loctransfers', 'locations.loccode=loctransfers.recloc'), ('loctransfers', 'stockmaster', 'loctransfers.stockid=stockmaster.stockid'), ('stockmaster', 'loctransfers', 'stockmaster.stockid=loctransfers.stockid'), ('orderdeliverydifferencesl', 'stockmaster', 'orderdeliverydifferenceslog.stockid=stockmaster.stockid'), ('stockmaster', 'orderdeliverydifferencesl', 'stockmaster.stockid=orderdeliverydifferenceslog.stockid'), ('orderdeliverydifferencesl', 'custbranch', 'orderdeliverydifferenceslog.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch', 'orderdeliverydifferencesl', 'custbranch.debtorno=orderdeliverydifferenceslog.debtorno'), ('orderdeliverydifferencesl', 'salesorders', 'orderdeliverydifferenceslog.branchcode=salesorders.orderno'), ('salesorders', 'orderdeliverydifferencesl', 'salesorders.orderno=orderdeliverydifferenceslog.branchcode'), ('prices', 'stockmaster', 'prices.stockid=stockmaster.stockid'), ('stockmaster', 'prices', 'stockmaster.stockid=prices.stockid'), ('prices', 'currencies', 'prices.currabrev=currencies.currabrev'), ('currencies', 'prices', 'currencies.currabrev=prices.currabrev'), ('prices', 'salestypes', 'prices.typeabbrev=salestypes.typeabbrev'), ('salestypes', 'prices', 'salestypes.typeabbrev=prices.typeabbrev'), ('purchdata', 'stockmaster', 'purchdata.stockid=stockmaster.stockid'), ('stockmaster', 'purchdata', 'stockmaster.stockid=purchdata.stockid'), ('purchdata', 'suppliers', 'purchdata.supplierno=suppliers.supplierid'), ('suppliers', 'purchdata', 'suppliers.supplierid=purchdata.supplierno'), ('purchorderdetails', 'purchorders', 'purchorderdetails.orderno=purchorders.orderno'), ('purchorders', 'purchorderdetails', 'purchorders.orderno=purchorderdetails.orderno'), ('purchorders', 'suppliers', 'purchorders.supplierno=suppliers.supplierid'), ('suppliers', 'purchorders', 'suppliers.supplierid=purchorders.supplierno'), ('purchorders', 'locations', 'purchorders.intostocklocation=locations.loccode'), ('locations', 'purchorders', 'locations.loccode=purchorders.intostocklocation'), ('recurringsalesorders', 'custbranch', 'recurringsalesorders.branchcode=custbranch.branchcode'), ('custbranch', 'recurringsalesorders', 'custbranch.branchcode=recurringsalesorders.branchcode'), ('recurrsalesorderdetails', 'recurringsalesorders', 'recurrsalesorderdetails.recurrorderno=recurringsalesorders.recurrorderno'), ('recurringsalesorders', 'recurrsalesorderdetails', 'recurringsalesorders.recurrorderno=recurrsalesorderdetails.recurrorderno'), ('recurrsalesorderdetails', 'stockmaster', 'recurrsalesorderdetails.stkcode=stockmaster.stockid'), ('stockmaster', 'recurrsalesorderdetails', 'stockmaster.stockid=recurrsalesorderdetails.stkcode'), ('reportcolumns', 'reportheaders', 'reportcolumns.reportid=reportheaders.reportid'), ('reportheaders', 'reportcolumns', 'reportheaders.reportid=reportcolumns.reportid'), ('salesanalysis', 'periods', 'salesanalysis.periodno=periods.periodno'), ('periods', 'salesanalysis', 'periods.periodno=salesanalysis.periodno'), ('salescatprod', 'stockmaster', 'salescatprod.stockid=stockmaster.stockid'), ('stockmaster', 'salescatprod', 'stockmaster.stockid=salescatprod.stockid'), ('salescatprod', 'salescat', 'salescatprod.salescatid=salescat.salescatid'), ('salescat', 'salescatprod', 'salescat.salescatid=salescatprod.salescatid'), ('salesorderdetails', 'salesorders', 'salesorderdetails.orderno=salesorders.orderno'), ('salesorders', 'salesorderdetails', 'salesorders.orderno=salesorderdetails.orderno'), ('salesorderdetails', 'stockmaster', 'salesorderdetails.stkcode=stockmaster.stockid'), ('stockmaster', 'salesorderdetails', 'stockmaster.stockid=salesorderdetails.stkcode'), ('salesorders', 'custbranch', 'salesorders.branchcode=custbranch.branchcode'), ('custbranch', 'salesorders', 'custbranch.branchcode=salesorders.branchcode'), ('salesorders', 'shippers', 'salesorders.debtorno=shippers.shipper_id'), ('shippers', 'salesorders', 'shippers.shipper_id=salesorders.debtorno'), ('salesorders', 'locations', 'salesorders.fromstkloc=locations.loccode'), ('locations', 'salesorders', 'locations.loccode=salesorders.fromstkloc'), ('securitygroups', 'securityroles', 'securitygroups.secroleid=securityroles.secroleid'), ('securityroles', 'securitygroups', 'securityroles.secroleid=securitygroups.secroleid'), ('securitygroups', 'securitytokens', 'securitygroups.tokenid=securitytokens.tokenid'), ('securitytokens', 'securitygroups', 'securitytokens.tokenid=securitygroups.tokenid'), ('shipmentcharges', 'shipments', 'shipmentcharges.shiptref=shipments.shiptref'), ('shipments', 'shipmentcharges', 'shipments.shiptref=shipmentcharges.shiptref'), ('shipmentcharges', 'systypes', 'shipmentcharges.transtype=systypes.typeid'), ('systypes', 'shipmentcharges', 'systypes.typeid=shipmentcharges.transtype'), ('shipments', 'suppliers', 'shipments.supplierid=suppliers.supplierid'), ('suppliers', 'shipments', 'suppliers.supplierid=shipments.supplierid'), ('stockcheckfreeze', 'stockmaster', 'stockcheckfreeze.stockid=stockmaster.stockid'), ('stockmaster', 'stockcheckfreeze', 'stockmaster.stockid=stockcheckfreeze.stockid'), ('stockcheckfreeze', 'locations', 'stockcheckfreeze.loccode=locations.loccode'), ('locations', 'stockcheckfreeze', 'locations.loccode=stockcheckfreeze.loccode'), ('stockcounts', 'stockmaster', 'stockcounts.stockid=stockmaster.stockid'), ('stockmaster', 'stockcounts', 'stockmaster.stockid=stockcounts.stockid'), ('stockcounts', 'locations', 'stockcounts.loccode=locations.loccode'), ('locations', 'stockcounts', 'locations.loccode=stockcounts.loccode'), ('stockmaster', 'stockcategory', 'stockmaster.categoryid=stockcategory.categoryid'), ('stockcategory', 'stockmaster', 'stockcategory.categoryid=stockmaster.categoryid'), ('stockmaster', 'taxcategories', 'stockmaster.taxcatid=taxcategories.taxcatid'), ('taxcategories', 'stockmaster', 'taxcategories.taxcatid=stockmaster.taxcatid'), ('stockmoves', 'stockmaster', 'stockmoves.stockid=stockmaster.stockid'), ('stockmaster', 'stockmoves', 'stockmaster.stockid=stockmoves.stockid'), ('stockmoves', 'systypes', 'stockmoves.type=systypes.typeid'), ('systypes', 'stockmoves', 'systypes.typeid=stockmoves.type'), ('stockmoves', 'locations', 'stockmoves.loccode=locations.loccode'), ('locations', 'stockmoves', 'locations.loccode=stockmoves.loccode'), ('stockmoves', 'periods', 'stockmoves.prd=periods.periodno'), ('periods', 'stockmoves', 'periods.periodno=stockmoves.prd'), ('stockmovestaxes', 'taxauthorities', 'stockmovestaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'stockmovestaxes', 'taxauthorities.taxid=stockmovestaxes.taxauthid'), ('stockserialitems', 'stockmaster', 'stockserialitems.stockid=stockmaster.stockid'), ('stockmaster', 'stockserialitems', 'stockmaster.stockid=stockserialitems.stockid'), ('stockserialitems', 'locations', 'stockserialitems.loccode=locations.loccode'), ('locations', 'stockserialitems', 'locations.loccode=stockserialitems.loccode'), ('stockserialmoves', 'stockmoves', 'stockserialmoves.stockmoveno=stockmoves.stkmoveno'), ('stockmoves', 'stockserialmoves', 'stockmoves.stkmoveno=stockserialmoves.stockmoveno'), ('stockserialmoves', 'stockserialitems', 'stockserialmoves.stockid=stockserialitems.stockid'), ('stockserialitems', 'stockserialmoves', 'stockserialitems.stockid=stockserialmoves.stockid'), ('suppallocs', 'supptrans', 'suppallocs.transid_allocfrom=supptrans.id'), ('supptrans', 'suppallocs', 'supptrans.id=suppallocs.transid_allocfrom'), ('suppallocs', 'supptrans', 'suppallocs.transid_allocto=supptrans.id'), ('supptrans', 'suppallocs', 'supptrans.id=suppallocs.transid_allocto'), ('suppliercontacts', 'suppliers', 'suppliercontacts.supplierid=suppliers.supplierid'), ('suppliers', 'suppliercontacts', 'suppliers.supplierid=suppliercontacts.supplierid'), ('suppliers', 'currencies', 'suppliers.currcode=currencies.currabrev'), ('currencies', 'suppliers', 'currencies.currabrev=suppliers.currcode'), ('suppliers', 'paymentterms', 'suppliers.paymentterms=paymentterms.termsindicator'), ('paymentterms', 'suppliers', 'paymentterms.termsindicator=suppliers.paymentterms'), ('suppliers', 'taxgroups', 'suppliers.taxgroupid=taxgroups.taxgroupid'), ('taxgroups', 'suppliers', 'taxgroups.taxgroupid=suppliers.taxgroupid'), ('supptrans', 'systypes', 'supptrans.type=systypes.typeid'), ('systypes', 'supptrans', 'systypes.typeid=supptrans.type'), ('supptrans', 'suppliers', 'supptrans.supplierno=suppliers.supplierid'), ('suppliers', 'supptrans', 'suppliers.supplierid=supptrans.supplierno'), ('supptranstaxes', 'taxauthorities', 'supptranstaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'supptranstaxes', 'taxauthorities.taxid=supptranstaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('supptranstaxes', 'supptrans', 'supptranstaxes.supptransid=supptrans.id'), ('supptrans', 'supptranstaxes', 'supptrans.id=supptranstaxes.supptransid'), ('taxauthorities', 'chartmaster', 'taxauthorities.taxglcode=chartmaster.accountcode'), ('chartmaster', 'taxauthorities', 'chartmaster.accountcode=taxauthorities.taxglcode'), ('taxauthorities', 'chartmaster', 'taxauthorities.purchtaxglaccount=chartmaster.accountcode'), ('chartmaster', 'taxauthorities', 'chartmaster.accountcode=taxauthorities.purchtaxglaccount'), ('taxauthrates', 'taxauthorities', 'taxauthrates.taxauthority=taxauthorities.taxid'), ('taxauthorities', 'taxauthrates', 'taxauthorities.taxid=taxauthrates.taxauthority'), ('taxauthrates', 'taxcategories', 'taxauthrates.taxcatid=taxcategories.taxcatid'), ('taxcategories', 'taxauthrates', 'taxcategories.taxcatid=taxauthrates.taxcatid'), ('taxauthrates', 'taxprovinces', 'taxauthrates.dispatchtaxprovince=taxprovinces.taxprovinceid'), ('taxprovinces', 'taxauthrates', 'taxprovinces.taxprovinceid=taxauthrates.dispatchtaxprovince'), ('taxgrouptaxes', 'taxgroups', 'taxgrouptaxes.taxgroupid=taxgroups.taxgroupid'), ('taxgroups', 'taxgrouptaxes', 'taxgroups.taxgroupid=taxgrouptaxes.taxgroupid'), ('taxgrouptaxes', 'taxauthorities', 'taxgrouptaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'taxgrouptaxes', 'taxauthorities.taxid=taxgrouptaxes.taxauthid'), ('workcentres', 'locations', 'workcentres.location=locations.loccode'), ('locations', 'workcentres', 'locations.loccode=workcentres.location'), ('worksorders', 'locations', 'worksorders.loccode=locations.loccode'), ('locations', 'worksorders', 'locations.loccode=worksorders.loccode'), ('worksorders', 'stockmaster', 'worksorders.stockid=stockmaster.stockid'), ('stockmaster', 'worksorders', 'stockmaster.stockid=worksorders.stockid'), ('www_users', 'locations', 'www_users.defaultlocation=locations.loccode'), ('locations', 'www_users', 'locations.loccode=www_users.defaultlocation'), ('accountgroups', 'accountsection', 'accountgroups.sectioninaccounts=accountsection.sectionid'), ('accountsection', 'accountgroups', 'accountsection.sectionid=accountgroups.sectioninaccounts'), ('bankaccounts', 'chartmaster', 'bankaccounts.accountcode=chartmaster.accountcode'), ('chartmaster', 'bankaccounts', 'chartmaster.accountcode=bankaccounts.accountcode'), ('banktrans', 'systypes', 'banktrans.type=systypes.typeid'), ('systypes', 'banktrans', 'systypes.typeid=banktrans.type'), ('banktrans', 'bankaccounts', 'banktrans.bankact=bankaccounts.accountcode'), ('bankaccounts', 'banktrans', 'bankaccounts.accountcode=banktrans.bankact'), ('bom', 'stockmaster', 'bom.parent=stockmaster.stockid'), ('stockmaster', 'bom', 'stockmaster.stockid=bom.parent'), ('bom', 'stockmaster', 'bom.component=stockmaster.stockid'), ('stockmaster', 'bom', 'stockmaster.stockid=bom.component'), ('bom', 'workcentres', 'bom.workcentreadded=workcentres.code'), ('workcentres', 'bom', 'workcentres.code=bom.workcentreadded'), ('bom', 'locations', 'bom.loccode=locations.loccode'), ('locations', 'bom', 'locations.loccode=bom.loccode'), ('buckets', 'workcentres', 'buckets.workcentre=workcentres.code'), ('workcentres', 'buckets', 'workcentres.code=buckets.workcentre'), ('chartdetails', 'chartmaster', 'chartdetails.accountcode=chartmaster.accountcode'), ('chartmaster', 'chartdetails', 'chartmaster.accountcode=chartdetails.accountcode'), ('chartdetails', 'periods', 'chartdetails.period=periods.periodno'), ('periods', 'chartdetails', 'periods.periodno=chartdetails.period'), ('chartmaster', 'accountgroups', 'chartmaster.group_=accountgroups.groupname'), ('accountgroups', 'chartmaster', 'accountgroups.groupname=chartmaster.group_'), ('contractbom', 'workcentres', 'contractbom.workcentreadded=workcentres.code'), ('workcentres', 'contractbom', 'workcentres.code=contractbom.workcentreadded'), ('contractbom', 'locations', 'contractbom.loccode=locations.loccode'), ('locations', 'contractbom', 'locations.loccode=contractbom.loccode'), ('contractbom', 'stockmaster', 'contractbom.component=stockmaster.stockid'), ('stockmaster', 'contractbom', 'stockmaster.stockid=contractbom.component'), ('contractreqts', 'contracts', 'contractreqts.contract=contracts.contractref'), ('contracts', 'contractreqts', 'contracts.contractref=contractreqts.contract'), ('contracts', 'custbranch', 'contracts.debtorno=custbranch.debtorno'), ('custbranch', 'contracts', 'custbranch.debtorno=contracts.debtorno'), ('contracts', 'stockcategory', 'contracts.branchcode=stockcategory.categoryid'), ('stockcategory', 'contracts', 'stockcategory.categoryid=contracts.branchcode'), ('contracts', 'salestypes', 'contracts.typeabbrev=salestypes.typeabbrev'), ('salestypes', 'contracts', 'salestypes.typeabbrev=contracts.typeabbrev'), ('custallocns', 'debtortrans', 'custallocns.transid_allocfrom=debtortrans.id'), ('debtortrans', 'custallocns', 'debtortrans.id=custallocns.transid_allocfrom'), ('custallocns', 'debtortrans', 'custallocns.transid_allocto=debtortrans.id'), ('debtortrans', 'custallocns', 'debtortrans.id=custallocns.transid_allocto'), ('custbranch', 'debtorsmaster', 'custbranch.debtorno=debtorsmaster.debtorno'), ('debtorsmaster', 'custbranch', 'debtorsmaster.debtorno=custbranch.debtorno'), ('custbranch', 'areas', 'custbranch.area=areas.areacode'), ('areas', 'custbranch', 'areas.areacode=custbranch.area'), ('custbranch', 'salesman', 'custbranch.salesman=salesman.salesmancode'), ('salesman', 'custbranch', 'salesman.salesmancode=custbranch.salesman'), ('custbranch', 'locations', 'custbranch.defaultlocation=locations.loccode'), ('locations', 'custbranch', 'locations.loccode=custbranch.defaultlocation'), ('custbranch', 'shippers', 'custbranch.defaultshipvia=shippers.shipper_id'), ('shippers', 'custbranch', 'shippers.shipper_id=custbranch.defaultshipvia'), ('debtorsmaster', 'holdreasons', 'debtorsmaster.holdreason=holdreasons.reasoncode'), ('holdreasons', 'debtorsmaster', 'holdreasons.reasoncode=debtorsmaster.holdreason'), ('debtorsmaster', 'currencies', 'debtorsmaster.currcode=currencies.currabrev'), ('currencies', 'debtorsmaster', 'currencies.currabrev=debtorsmaster.currcode'), ('debtorsmaster', 'paymentterms', 'debtorsmaster.paymentterms=paymentterms.termsindicator'), ('paymentterms', 'debtorsmaster', 'paymentterms.termsindicator=debtorsmaster.paymentterms'), ('debtorsmaster', 'salestypes', 'debtorsmaster.salestype=salestypes.typeabbrev'), ('salestypes', 'debtorsmaster', 'salestypes.typeabbrev=debtorsmaster.salestype'), ('debtortrans', 'custbranch', 'debtortrans.debtorno=custbranch.debtorno'), ('custbranch', 'debtortrans', 'custbranch.debtorno=debtortrans.debtorno'), ('debtortrans', 'systypes', 'debtortrans.type=systypes.typeid'), ('systypes', 'debtortrans', 'systypes.typeid=debtortrans.type'), ('debtortrans', 'periods', 'debtortrans.prd=periods.periodno'), ('periods', 'debtortrans', 'periods.periodno=debtortrans.prd'), ('debtortranstaxes', 'taxauthorities', 'debtortranstaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'debtortranstaxes', 'taxauthorities.taxid=debtortranstaxes.taxauthid'), ('debtortranstaxes', 'debtortrans', 'debtortranstaxes.debtortransid=debtortrans.id'), ('debtortrans', 'debtortranstaxes', 'debtortrans.id=debtortranstaxes.debtortransid'), ('discountmatrix', 'salestypes', 'discountmatrix.salestype=salestypes.typeabbrev'), ('salestypes', 'discountmatrix', 'salestypes.typeabbrev=discountmatrix.salestype'), ('freightcosts', 'locations', 'freightcosts.locationfrom=locations.loccode'), ('locations', 'freightcosts', 'locations.loccode=freightcosts.locationfrom'), ('freightcosts', 'shippers', 'freightcosts.shipperid=shippers.shipper_id'), ('shippers', 'freightcosts', 'shippers.shipper_id=freightcosts.shipperid'), ('gltrans', 'chartmaster', 'gltrans.account=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster', 'gltrans', 'chartmaster.accountcode=gltrans.account'), ('gltrans', 'systypes', 'gltrans.type=systypes.typeid'), ('systypes', 'gltrans', 'systypes.typeid=gltrans.type'), ('gltrans', 'periods', 'gltrans.periodno=periods.periodno'), ('periods', 'gltrans', 'periods.periodno=gltrans.periodno'), ('grns', 'suppliers', 'grns.supplierid=suppliers.supplierid'), ('suppliers', 'grns', 'suppliers.supplierid=grns.supplierid'), ('grns', 'purchorderdetails', 'grns.podetailitem=purchorderdetails.podetailitem'), ('purchorderdetails', 'grns', 'purchorderdetails.podetailitem=grns.podetailitem'), ('locations', 'taxprovinces', 'locations.taxprovinceid=taxprovinces.taxprovinceid'), ('taxprovinces', 'locations', 'taxprovinces.taxprovinceid=locations.taxprovinceid'), ('locstock', 'locations', 'locstock.loccode=locations.loccode'), ('locations', 'locstock', 'locations.loccode=locstock.loccode'), ('locstock', 'stockmaster', 'locstock.stockid=stockmaster.stockid'), ('stockmaster', 'locstock', 'stockmaster.stockid=locstock.stockid'), ('loctransfers', 'locations', 'loctransfers.shiploc=locations.loccode'), ('locations', 'loctransfers', 'locations.loccode=loctransfers.shiploc'), ('loctransfers', 'locations', 'loctransfers.recloc=locations.loccode'), ('locations', 'loctransfers', 'locations.loccode=loctransfers.recloc'), ('loctransfers', 'stockmaster', 'loctransfers.stockid=stockmaster.stockid'), ('stockmaster', 'loctransfers', 'stockmaster.stockid=loctransfers.stockid'), ('orderdeliverydifferencesl', 'stockmaster', 'orderdeliverydifferenceslog.stockid=stockmaster.stockid'), ('stockmaster', 'orderdeliverydifferencesl', 'stockmaster.stockid=orderdeliverydifferenceslog.stockid'), ('orderdeliverydifferencesl', 'custbranch', 'orderdeliverydifferenceslog.debtorno=custbranch.debtorno'), ('custbranch', 'orderdeliverydifferencesl', 'custbranch.debtorno=orderdeliverydifferenceslog.debtorno'), ('orderdeliverydifferencesl', 'salesorders', 'orderdeliverydifferenceslog.branchcode=salesorders.orderno'), ('salesorders', 'orderdeliverydifferencesl', 'salesorders.orderno=orderdeliverydifferenceslog.branchcode'), ('prices', 'stockmaster', 'prices.stockid=stockmaster.stockid'), ('stockmaster', 'prices', 'stockmaster.stockid=prices.stockid'), ('prices', 'currencies', 'prices.currabrev=currencies.currabrev'), ('currencies', 'prices', 'currencies.currabrev=prices.currabrev'), ('prices', 'salestypes', 'prices.typeabbrev=salestypes.typeabbrev'), ('salestypes', 'prices', 'salestypes.typeabbrev=prices.typeabbrev'), ('purchdata', 'stockmaster', 'purchdata.stockid=stockmaster.stockid'), ('stockmaster', 'purchdata', 'stockmaster.stockid=purchdata.stockid'), ('purchdata', 'suppliers', 'purchdata.supplierno=suppliers.supplierid'), ('suppliers', 'purchdata', 'suppliers.supplierid=purchdata.supplierno'), ('purchorderdetails', 'purchorders', 'purchorderdetails.orderno=purchorders.orderno'), ('purchorders', 'purchorderdetails', 'purchorders.orderno=purchorderdetails.orderno'), ('purchorders', 'suppliers', 'purchorders.supplierno=suppliers.supplierid'), ('suppliers', 'purchorders', 'suppliers.supplierid=purchorders.supplierno'), ('purchorders', 'locations', 'purchorders.intostocklocation=locations.loccode'), ('locations', 'purchorders', 'locations.loccode=purchorders.intostocklocation'), ('recurringsalesorders', 'custbranch', 'recurringsalesorders.branchcode=custbranch.branchcode'), ('custbranch', 'recurringsalesorders', 'custbranch.branchcode=recurringsalesorders.branchcode'), ('recurrsalesorderdetails', 'recurringsalesorders', 'recurrsalesorderdetails.recurrorderno=recurringsalesorders.recurrorderno'), ('recurringsalesorders', 'recurrsalesorderdetails', 'recurringsalesorders.recurrorderno=recurrsalesorderdetails.recurrorderno'), ('recurrsalesorderdetails', 'stockmaster', 'recurrsalesorderdetails.stkcode=stockmaster.stockid'), ('stockmaster', 'recurrsalesorderdetails', 'stockmaster.stockid=recurrsalesorderdetails.stkcode'), ('reportcolumns', 'reportheaders', 'reportcolumns.reportid=reportheaders.reportid'), ('reportheaders', 'reportcolumns', 'reportheaders.reportid=reportcolumns.reportid'), ('salesanalysis', 'periods', 'salesanalysis.periodno=periods.periodno'), ('periods', 'salesanalysis', 'periods.periodno=salesanalysis.periodno'), ('salescatprod', 'stockmaster', 'salescatprod.stockid=stockmaster.stockid'), ('stockmaster', 'salescatprod', 'stockmaster.stockid=salescatprod.stockid'), ('salescatprod', 'salescat', 'salescatprod.salescatid=salescat.salescatid'), ('salescat', 'salescatprod', 'salescat.salescatid=salescatprod.salescatid'), ('salesorderdetails', 'salesorders', 'salesorderdetails.orderno=salesorders.orderno'), ('salesorders', 'salesorderdetails', 'salesorders.orderno=salesorderdetails.orderno'), ('salesorderdetails', 'stockmaster', 'salesorderdetails.stkcode=stockmaster.stockid'), ('stockmaster', 'salesorderdetails', 'stockmaster.stockid=salesorderdetails.stkcode'), ('salesorders', 'custbranch', 'salesorders.branchcode=custbranch.branchcode'), ('custbranch', 'salesorders', 'custbranch.branchcode=salesorders.branchcode'), ('salesorders', 'shippers', 'salesorders.debtorno=shippers.shipper_id'), ('shippers', 'salesorders', 'shippers.shipper_id=salesorders.debtorno'), ('salesorders', 'locations', 'salesorders.fromstkloc=locations.loccode'), ('locations', 'salesorders', 'locations.loccode=salesorders.fromstkloc'), ('securitygroups', 'securityroles', 'securitygroups.secroleid=securityroles.secroleid'), ('securityroles', 'securitygroups', 'securityroles.secroleid=securitygroups.secroleid'), ('securitygroups', 'securitytokens', 'securitygroups.tokenid=securitytokens.tokenid'), ('securitytokens', 'securitygroups', 'securitytokens.tokenid=securitygroups.tokenid'), ('shipmentcharges', 'shipments', 'shipmentcharges.shiptref=shipments.shiptref'), ('shipments', 'shipmentcharges', 'shipments.shiptref=shipmentcharges.shiptref'), ('shipmentcharges', 'systypes', 'shipmentcharges.transtype=systypes.typeid'), ('systypes', 'shipmentcharges', 'systypes.typeid=shipmentcharges.transtype'), ('shipments', 'suppliers', 'shipments.supplierid=suppliers.supplierid'), ('suppliers', 'shipments', 'suppliers.supplierid=shipments.supplierid'), ('stockcheckfreeze', 'stockmaster', 'stockcheckfreeze.stockid=stockmaster.stockid'), ('stockmaster', 'stockcheckfreeze', 'stockmaster.stockid=stockcheckfreeze.stockid'), ('stockcheckfreeze', 'locations', 'stockcheckfreeze.loccode=locations.loccode'), ('locations', 'stockcheckfreeze', 'locations.loccode=stockcheckfreeze.loccode'), ('stockcounts', 'stockmaster', 'stockcounts.stockid=stockmaster.stockid'), ('stockmaster', 'stockcounts', 'stockmaster.stockid=stockcounts.stockid'), ('stockcounts', 'locations', 'stockcounts.loccode=locations.loccode'), ('locations', 'stockcounts', 'locations.loccode=stockcounts.loccode'), ('stockmaster', 'stockcategory', 'stockmaster.categoryid=stockcategory.categoryid'), ('stockcategory', 'stockmaster', 'stockcategory.categoryid=stockmaster.categoryid'), ('stockmaster', 'taxcategories', 'stockmaster.taxcatid=taxcategories.taxcatid'), ('taxcategories', 'stockmaster', 'taxcategories.taxcatid=stockmaster.taxcatid'), ('stockmoves', 'stockmaster', 'stockmoves.stockid=stockmaster.stockid'), ('stockmaster', 'stockmoves', 'stockmaster.stockid=stockmoves.stockid'), ('stockmoves', 'systypes', 'stockmoves.type=systypes.typeid'), ('systypes', 'stockmoves', 'systypes.typeid=stockmoves.type'), ('stockmoves', 'locations', 'stockmoves.loccode=locations.loccode'), ('locations', 'stockmoves', 'locations.loccode=stockmoves.loccode'), ('stockmoves', 'periods', 'stockmoves.prd=periods.periodno'), ('periods', 'stockmoves', 'periods.periodno=stockmoves.prd'), ('stockmovestaxes', 'taxauthorities', 'stockmovestaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'stockmovestaxes', 'taxauthorities.taxid=stockmovestaxes.taxauthid'), ('stockserialitems', 'stockmaster', 'stockserialitems.stockid=stockmaster.stockid'), ('stockmaster', 'stockserialitems', 'stockmaster.stockid=stockserialitems.stockid');
INSERT INTO `reportlinks` VALUES ('stockserialitems', 'locations', 'stockserialitems.loccode=locations.loccode'), ('locations', 'stockserialitems', 'locations.loccode=stockserialitems.loccode'), ('stockserialmoves', 'stockmoves', 'stockserialmoves.stockmoveno=stockmoves.stkmoveno'), ('stockmoves', 'stockserialmoves', 'stockmoves.stkmoveno=stockserialmoves.stockmoveno'), ('stockserialmoves', 'stockserialitems', 'stockserialmoves.stockid=stockserialitems.stockid'), ('stockserialitems', 'stockserialmoves', 'stockserialitems.stockid=stockserialmoves.stockid'), ('suppallocs', 'supptrans', 'suppallocs.transid_allocfrom=supptrans.id'), ('supptrans', 'suppallocs', 'supptrans.id=suppallocs.transid_allocfrom'), ('suppallocs', 'supptrans', 'suppallocs.transid_allocto=supptrans.id'), ('supptrans', 'suppallocs', 'supptrans.id=suppallocs.transid_allocto'), ('suppliercontacts', 'suppliers', 'suppliercontacts.supplierid=suppliers.supplierid'), ('suppliers', 'suppliercontacts', 'suppliers.supplierid=suppliercontacts.supplierid'), ('suppliers', 'currencies', 'suppliers.currcode=currencies.currabrev'), ('currencies', 'suppliers', 'currencies.currabrev=suppliers.currcode'), ('suppliers', 'paymentterms', 'suppliers.paymentterms=paymentterms.termsindicator'), ('paymentterms', 'suppliers', 'paymentterms.termsindicator=suppliers.paymentterms'), ('suppliers', 'taxgroups', 'suppliers.taxgroupid=taxgroups.taxgroupid'), ('taxgroups', 'suppliers', 'taxgroups.taxgroupid=suppliers.taxgroupid'), ('supptrans', 'systypes', 'supptrans.type=systypes.typeid'), ('systypes', 'supptrans', 'systypes.typeid=supptrans.type'), ('supptrans', 'suppliers', 'supptrans.supplierno=suppliers.supplierid'), ('suppliers', 'supptrans', 'suppliers.supplierid=supptrans.supplierno'), ('supptranstaxes', 'taxauthorities', 'supptranstaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'supptranstaxes', 'taxauthorities.taxid=supptranstaxes.taxauthid'), ('supptranstaxes', 'supptrans', 'supptranstaxes.supptransid=supptrans.id'), ('supptrans', 'supptranstaxes', 'supptrans.id=supptranstaxes.supptransid'), ('taxauthorities', 'chartmaster', 'taxauthorities.taxglcode=chartmaster.accountcode'), ('chartmaster', 'taxauthorities', 'chartmaster.accountcode=taxauthorities.taxglcode'), ('taxauthorities', 'chartmaster', 'taxauthorities.purchtaxglaccount=chartmaster.accountcode'), ('chartmaster', 'taxauthorities', 'chartmaster.accountcode=taxauthorities.purchtaxglaccount'), ('taxauthrates', 'taxauthorities', 'taxauthrates.taxauthority=taxauthorities.taxid'), ('taxauthorities', 'taxauthrates', 'taxauthorities.taxid=taxauthrates.taxauthority'), ('taxauthrates', 'taxcategories', 'taxauthrates.taxcatid=taxcategories.taxcatid'), ('taxcategories', 'taxauthrates', 'taxcategories.taxcatid=taxauthrates.taxcatid'), ('taxauthrates', 'taxprovinces', 'taxauthrates.dispatchtaxprovince=taxprovinces.taxprovinceid'), ('taxprovinces', 'taxauthrates', 'taxprovinces.taxprovinceid=taxauthrates.dispatchtaxprovince'), ('taxgrouptaxes', 'taxgroups', 'taxgrouptaxes.taxgroupid=taxgroups.taxgroupid'), ('taxgroups', 'taxgrouptaxes', 'taxgroups.taxgroupid=taxgrouptaxes.taxgroupid'), ('taxgrouptaxes', 'taxauthorities', 'taxgrouptaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'taxgrouptaxes', 'taxauthorities.taxid=taxgrouptaxes.taxauthid'), ('accountgroups', 'accountsection', 'accountgroups.sectioninaccounts=accountsection.sectionid'), ('accountsection', 'accountgroups', 'accountsection.sectionid=accountgroups.sectioninaccounts'), ('bankaccounts', 'chartmaster', 'bankaccounts.accountcode=chartmaster.accountcode'), ('chartmaster', 'bankaccounts', 'chartmaster.accountcode=bankaccounts.accountcode'), ('banktrans', 'systypes', 'banktrans.type=systypes.typeid'), ('systypes', 'banktrans', 'systypes.typeid=banktrans.type'), ('banktrans', 'bankaccounts', 'banktrans.bankact=bankaccounts.accountcode'), ('bankaccounts', 'banktrans', 'bankaccounts.accountcode=banktrans.bankact'), ('bom', 'stockmaster', 'bom.parent=stockmaster.stockid'), ('stockmaster', 'bom', 'stockmaster.stockid=bom.parent'), ('bom', 'stockmaster', 'bom.component=stockmaster.stockid'), ('stockmaster', 'bom', 'stockmaster.stockid=bom.component'), ('bom', 'workcentres', 'bom.workcentreadded=workcentres.code'), ('workcentres', 'bom', 'workcentres.code=bom.workcentreadded'), ('bom', 'locations', 'bom.loccode=locations.loccode'), ('locations', 'bom', 'locations.loccode=bom.loccode'), ('buckets', 'workcentres', 'buckets.workcentre=workcentres.code'), ('workcentres', 'buckets', 'workcentres.code=buckets.workcentre'), ('chartdetails', 'chartmaster', 'chartdetails.accountcode=chartmaster.accountcode'), ('chartmaster', 'chartdetails', 'chartmaster.accountcode=chartdetails.accountcode'), ('chartdetails', 'periods', 'chartdetails.period=periods.periodno'), ('periods', 'chartdetails', 'periods.periodno=chartdetails.period'), ('chartmaster', 'accountgroups', 'chartmaster.group_=accountgroups.groupname'), ('accountgroups', 'chartmaster', 'accountgroups.groupname=chartmaster.group_'), ('contractbom', 'workcentres', 'contractbom.workcentreadded=workcentres.code'), ('workcentres', 'contractbom', 'workcentres.code=contractbom.workcentreadded'), ('contractbom', 'locations', 'contractbom.loccode=locations.loccode'), ('locations', 'contractbom', 'locations.loccode=contractbom.loccode'), ('contractbom', 'stockmaster', 'contractbom.component=stockmaster.stockid'), ('stockmaster', 'contractbom', 'stockmaster.stockid=contractbom.component'), ('contractreqts', 'contracts', 'contractreqts.contract=contracts.contractref'), ('contracts', 'contractreqts', 'contracts.contractref=contractreqts.contract'), ('contracts', 'custbranch', 'contracts.debtorno=custbranch.debtorno'), ('custbranch', 'contracts', 'custbranch.debtorno=contracts.debtorno'), ('contracts', 'stockcategory', 'contracts.branchcode=stockcategory.categoryid'), ('stockcategory', 'contracts', 'stockcategory.categoryid=contracts.branchcode'), ('contracts', 'salestypes', 'contracts.typeabbrev=salestypes.typeabbrev'), ('salestypes', 'contracts', 'salestypes.typeabbrev=contracts.typeabbrev'), ('custallocns', 'debtortrans', 'custallocns.transid_allocfrom=debtortrans.id'), ('debtortrans', 'custallocns', 'debtortrans.id=custallocns.transid_allocfrom'), ('custallocns', 'debtortrans', 'custallocns.transid_allocto=debtortrans.id'), ('debtortrans', 'custallocns', 'debtortrans.id=custallocns.transid_allocto'), ('custbranch', 'debtorsmaster', 'custbranch.debtorno=debtorsmaster.debtorno'), ('debtorsmaster', 'custbranch', 'debtorsmaster.debtorno=custbranch.debtorno'), ('custbranch', 'areas', 'custbranch.area=areas.areacode'), ('areas', 'custbranch', 'areas.areacode=custbranch.area'), ('custbranch', 'salesman', 'custbranch.salesman=salesman.salesmancode'), ('salesman', 'custbranch', 'salesman.salesmancode=custbranch.salesman'), ('custbranch', 'locations', 'custbranch.defaultlocation=locations.loccode'), ('locations', 'custbranch', 'locations.loccode=custbranch.defaultlocation'), ('custbranch', 'shippers', 'custbranch.defaultshipvia=shippers.shipper_id'), ('shippers', 'custbranch', 'shippers.shipper_id=custbranch.defaultshipvia'), ('debtorsmaster', 'holdreasons', 'debtorsmaster.holdreason=holdreasons.reasoncode'), ('holdreasons', 'debtorsmaster', 'holdreasons.reasoncode=debtorsmaster.holdreason'), ('debtorsmaster', 'currencies', 'debtorsmaster.currcode=currencies.currabrev'), ('currencies', 'debtorsmaster', 'currencies.currabrev=debtorsmaster.currcode'), ('debtorsmaster', 'paymentterms', 'debtorsmaster.paymentterms=paymentterms.termsindicator'), ('paymentterms', 'debtorsmaster', 'paymentterms.termsindicator=debtorsmaster.paymentterms'), ('debtorsmaster', 'salestypes', 'debtorsmaster.salestype=salestypes.typeabbrev'), ('salestypes', 'debtorsmaster', 'salestypes.typeabbrev=debtorsmaster.salestype'), ('debtortrans', 'custbranch', 'debtortrans.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch', 'debtortrans', 'custbranch.debtorno=debtortrans.debtorno'), ('debtortrans', 'systypes', 'debtortrans.type=systypes.typeid'), ('systypes', 'debtortrans', 'systypes.typeid=debtortrans.type'), ('debtortrans', 'periods', 'debtortrans.prd=periods.periodno'), ('periods', 'debtortrans', 'periods.periodno=debtortrans.prd'), ('debtortranstaxes', 'taxauthorities', 'debtortranstaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'debtortranstaxes', 'taxauthorities.taxid=debtortranstaxes.taxauthid'), ('debtortranstaxes', 'debtortrans', 'debtortranstaxes.debtortransid=debtortrans.id'), ('debtortrans', 'debtortranstaxes', 'debtortrans.id=debtortranstaxes.debtortransid'), ('discountmatrix', 'salestypes', 'discountmatrix.salestype=salestypes.typeabbrev'), ('salestypes', 'discountmatrix', 'salestypes.typeabbrev=discountmatrix.salestype'), ('freightcosts', 'locations', 'freightcosts.locationfrom=locations.loccode'), ('locations', 'freightcosts', 'locations.loccode=freightcosts.locationfrom'), ('freightcosts', 'shippers', 'freightcosts.shipperid=shippers.shipper_id'), ('shippers', 'freightcosts', 'shippers.shipper_id=freightcosts.shipperid'), ('gltrans', 'chartmaster', 'gltrans.account=chartmaster.accountcode'), ('chartmaster', 'gltrans', 'chartmaster.accountcode=gltrans.account'), ('gltrans', 'systypes', 'gltrans.type=systypes.typeid'), ('systypes', 'gltrans', 'systypes.typeid=gltrans.type'), ('gltrans', 'periods', 'gltrans.periodno=periods.periodno'), ('periods', 'gltrans', 'periods.periodno=gltrans.periodno'), ('grns', 'suppliers', 'grns.supplierid=suppliers.supplierid'), ('suppliers', 'grns', 'suppliers.supplierid=grns.supplierid'), ('grns', 'purchorderdetails', 'grns.podetailitem=purchorderdetails.podetailitem'), ('purchorderdetails', 'grns', 'purchorderdetails.podetailitem=grns.podetailitem'), ('locations', 'taxprovinces', 'locations.taxprovinceid=taxprovinces.taxprovinceid'), ('taxprovinces', 'locations', 'taxprovinces.taxprovinceid=locations.taxprovinceid'), ('locstock', 'locations', 'locstock.loccode=locations.loccode'), ('locations', 'locstock', 'locations.loccode=locstock.loccode'), ('locstock', 'stockmaster', 'locstock.stockid=stockmaster.stockid'), ('stockmaster', 'locstock', 'stockmaster.stockid=locstock.stockid'), ('loctransfers', 'locations', 'loctransfers.shiploc=locations.loccode'), ('locations', 'loctransfers', 'locations.loccode=loctransfers.shiploc'), ('loctransfers', 'locations', 'loctransfers.recloc=locations.loccode'), ('locations', 'loctransfers', 'locations.loccode=loctransfers.recloc'), ('loctransfers', 'stockmaster', 'loctransfers.stockid=stockmaster.stockid'), ('stockmaster', 'loctransfers', 'stockmaster.stockid=loctransfers.stockid'), ('orderdeliverydifferencesl', 'stockmaster', 'orderdeliverydifferenceslog.stockid=stockmaster.stockid'), ('stockmaster', 'orderdeliverydifferencesl', 'stockmaster.stockid=orderdeliverydifferenceslog.stockid'), ('orderdeliverydifferencesl', 'custbranch', 'orderdeliverydifferenceslog.debtorno=custbranch.debtorno'), ('custbranch', 'orderdeliverydifferencesl', 'custbranch.debtorno=orderdeliverydifferenceslog.debtorno'), ('orderdeliverydifferencesl', 'salesorders', 'orderdeliverydifferenceslog.branchcode=salesorders.orderno'), ('salesorders', 'orderdeliverydifferencesl', 'salesorders.orderno=orderdeliverydifferenceslog.branchcode'), ('prices', 'stockmaster', 'prices.stockid=stockmaster.stockid'), ('stockmaster', 'prices', 'stockmaster.stockid=prices.stockid'), ('prices', 'currencies', 'prices.currabrev=currencies.currabrev'), ('currencies', 'prices', 'currencies.currabrev=prices.currabrev'), ('prices', 'salestypes', 'prices.typeabbrev=salestypes.typeabbrev'), ('salestypes', 'prices', 'salestypes.typeabbrev=prices.typeabbrev'), ('purchdata', 'stockmaster', 'purchdata.stockid=stockmaster.stockid'), ('stockmaster', 'purchdata', 'stockmaster.stockid=purchdata.stockid'), ('purchdata', 'suppliers', 'purchdata.supplierno=suppliers.supplierid'), ('suppliers', 'purchdata', 'suppliers.supplierid=purchdata.supplierno'), ('purchorderdetails', 'purchorders', 'purchorderdetails.orderno=purchorders.orderno'), ('purchorders', 'purchorderdetails', 'purchorders.orderno=purchorderdetails.orderno'), ('purchorders', 'suppliers', 'purchorders.supplierno=suppliers.supplierid'), ('suppliers', 'purchorders', 'suppliers.supplierid=purchorders.supplierno'), ('purchorders', 'locations', 'purchorders.intostocklocation=locations.loccode'), ('locations', 'purchorders', 'locations.loccode=purchorders.intostocklocation'), ('recurringsalesorders', 'custbranch', 'recurringsalesorders.branchcode=custbranch.branchcode'), ('custbranch', 'recurringsalesorders', 'custbranch.branchcode=recurringsalesorders.branchcode'), ('recurrsalesorderdetails', 'recurringsalesorders', 'recurrsalesorderdetails.recurrorderno=recurringsalesorders.recurrorderno'), ('recurringsalesorders', 'recurrsalesorderdetails', 'recurringsalesorders.recurrorderno=recurrsalesorderdetails.recurrorderno'), ('recurrsalesorderdetails', 'stockmaster', 'recurrsalesorderdetails.stkcode=stockmaster.stockid'), ('stockmaster', 'recurrsalesorderdetails', 'stockmaster.stockid=recurrsalesorderdetails.stkcode'), ('reportcolumns', 'reportheaders', 'reportcolumns.reportid=reportheaders.reportid'), ('reportheaders', 'reportcolumns', 'reportheaders.reportid=reportcolumns.reportid'), ('salesanalysis', 'periods', 'salesanalysis.periodno=periods.periodno'), ('periods', 'salesanalysis', 'periods.periodno=salesanalysis.periodno'), ('salescatprod', 'stockmaster', 'salescatprod.stockid=stockmaster.stockid'), ('stockmaster', 'salescatprod', 'stockmaster.stockid=salescatprod.stockid'), ('salescatprod', 'salescat', 'salescatprod.salescatid=salescat.salescatid'), ('salescat', 'salescatprod', 'salescat.salescatid=salescatprod.salescatid'), ('salesorderdetails', 'salesorders', 'salesorderdetails.orderno=salesorders.orderno'), ('salesorders', 'salesorderdetails', 'salesorders.orderno=salesorderdetails.orderno'), ('salesorderdetails', 'stockmaster', 'salesorderdetails.stkcode=stockmaster.stockid'), ('stockmaster', 'salesorderdetails', 'stockmaster.stockid=salesorderdetails.stkcode'), ('salesorders', 'custbranch', 'salesorders.branchcode=custbranch.branchcode'), ('custbranch', 'salesorders', 'custbranch.branchcode=salesorders.branchcode'), ('salesorders', 'shippers', 'salesorders.debtorno=shippers.shipper_id'), ('shippers', 'salesorders', 'shippers.shipper_id=salesorders.debtorno'), ('salesorders', 'locations', 'salesorders.fromstkloc=locations.loccode'), ('locations', 'salesorders', 'locations.loccode=salesorders.fromstkloc'), ('securitygroups', 'securityroles', 'securitygroups.secroleid=securityroles.secroleid'), ('securityroles', 'securitygroups', 'securityroles.secroleid=securitygroups.secroleid'), ('securitygroups', 'securitytokens', 'securitygroups.tokenid=securitytokens.tokenid'), ('securitytokens', 'securitygroups', 'securitytokens.tokenid=securitygroups.tokenid'), ('shipmentcharges', 'shipments', 'shipmentcharges.shiptref=shipments.shiptref'), ('shipments', 'shipmentcharges', 'shipments.shiptref=shipmentcharges.shiptref'), ('shipmentcharges', 'systypes', 'shipmentcharges.transtype=systypes.typeid'), ('systypes', 'shipmentcharges', 'systypes.typeid=shipmentcharges.transtype'), ('shipments', 'suppliers', 'shipments.supplierid=suppliers.supplierid'), ('suppliers', 'shipments', 'suppliers.supplierid=shipments.supplierid'), ('stockcheckfreeze', 'stockmaster', 'stockcheckfreeze.stockid=stockmaster.stockid'), ('stockmaster', 'stockcheckfreeze', 'stockmaster.stockid=stockcheckfreeze.stockid'), ('stockcheckfreeze', 'locations', 'stockcheckfreeze.loccode=locations.loccode'), ('locations', 'stockcheckfreeze', 'locations.loccode=stockcheckfreeze.loccode'), ('stockcounts', 'stockmaster', 'stockcounts.stockid=stockmaster.stockid'), ('stockmaster', 'stockcounts', 'stockmaster.stockid=stockcounts.stockid'), ('stockcounts', 'locations', 'stockcounts.loccode=locations.loccode'), ('locations', 'stockcounts', 'locations.loccode=stockcounts.loccode');
INSERT INTO `reportlinks` VALUES ('stockmaster', 'stockcategory', 'stockmaster.categoryid=stockcategory.categoryid'), ('stockcategory', 'stockmaster', 'stockcategory.categoryid=stockmaster.categoryid'), ('stockmaster', 'taxcategories', 'stockmaster.taxcatid=taxcategories.taxcatid'), ('taxcategories', 'stockmaster', 'taxcategories.taxcatid=stockmaster.taxcatid'), ('stockmoves', 'stockmaster', 'stockmoves.stockid=stockmaster.stockid'), ('stockmaster', 'stockmoves', 'stockmaster.stockid=stockmoves.stockid'), ('stockmoves', 'systypes', 'stockmoves.type=systypes.typeid'), ('systypes', 'stockmoves', 'systypes.typeid=stockmoves.type'), ('stockmoves', 'locations', 'stockmoves.loccode=locations.loccode'), ('locations', 'stockmoves', 'locations.loccode=stockmoves.loccode'), ('stockmoves', 'periods', 'stockmoves.prd=periods.periodno'), ('periods', 'stockmoves', 'periods.periodno=stockmoves.prd'), ('stockmovestaxes', 'taxauthorities', 'stockmovestaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'stockmovestaxes', 'taxauthorities.taxid=stockmovestaxes.taxauthid'), ('stockserialitems', 'stockmaster', 'stockserialitems.stockid=stockmaster.stockid'), ('stockmaster', 'stockserialitems', 'stockmaster.stockid=stockserialitems.stockid'), ('stockserialitems', 'locations', 'stockserialitems.loccode=locations.loccode'), ('locations', 'stockserialitems', 'locations.loccode=stockserialitems.loccode'), ('stockserialmoves', 'stockmoves', 'stockserialmoves.stockmoveno=stockmoves.stkmoveno'), ('stockmoves', 'stockserialmoves', 'stockmoves.stkmoveno=stockserialmoves.stockmoveno'), ('stockserialmoves', 'stockserialitems', 'stockserialmoves.stockid=stockserialitems.stockid'), ('stockserialitems', 'stockserialmoves', 'stockserialitems.stockid=stockserialmoves.stockid'), ('suppallocs', 'supptrans', 'suppallocs.transid_allocfrom=supptrans.id'), ('supptrans', 'suppallocs', 'supptrans.id=suppallocs.transid_allocfrom'), ('suppallocs', 'supptrans', 'suppallocs.transid_allocto=supptrans.id'), ('supptrans', 'suppallocs', 'supptrans.id=suppallocs.transid_allocto'), ('suppliercontacts', 'suppliers', 'suppliercontacts.supplierid=suppliers.supplierid'), ('suppliers', 'suppliercontacts', 'suppliers.supplierid=suppliercontacts.supplierid'), ('suppliers', 'currencies', 'suppliers.currcode=currencies.currabrev'), ('currencies', 'suppliers', 'currencies.currabrev=suppliers.currcode'), ('suppliers', 'paymentterms', 'suppliers.paymentterms=paymentterms.termsindicator'), ('paymentterms', 'suppliers', 'paymentterms.termsindicator=suppliers.paymentterms'), ('suppliers', 'taxgroups', 'suppliers.taxgroupid=taxgroups.taxgroupid'), ('taxgroups', 'suppliers', 'taxgroups.taxgroupid=suppliers.taxgroupid'), ('supptrans', 'systypes', 'supptrans.type=systypes.typeid'), ('systypes', 'supptrans', 'systypes.typeid=supptrans.type'), ('supptrans', 'suppliers', 'supptrans.supplierno=suppliers.supplierid'), ('suppliers', 'supptrans', 'suppliers.supplierid=supptrans.supplierno'), ('supptranstaxes', 'taxauthorities', 'supptranstaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'supptranstaxes', 'taxauthorities.taxid=supptranstaxes.taxauthid'), ('supptranstaxes', 'supptrans', 'supptranstaxes.supptransid=supptrans.id'), ('supptrans', 'supptranstaxes', 'supptrans.id=supptranstaxes.supptransid'), ('taxauthorities', 'chartmaster', 'taxauthorities.taxglcode=chartmaster.accountcode'), ('chartmaster', 'taxauthorities', 'chartmaster.accountcode=taxauthorities.taxglcode'), ('taxauthorities', 'chartmaster', 'taxauthorities.purchtaxglaccount=chartmaster.accountcode'), ('chartmaster', 'taxauthorities', 'chartmaster.accountcode=taxauthorities.purchtaxglaccount'), ('taxauthrates', 'taxauthorities', 'taxauthrates.taxauthority=taxauthorities.taxid'), ('taxauthorities', 'taxauthrates', 'taxauthorities.taxid=taxauthrates.taxauthority'), ('taxauthrates', 'taxcategories', 'taxauthrates.taxcatid=taxcategories.taxcatid'), ('taxcategories', 'taxauthrates', 'taxcategories.taxcatid=taxauthrates.taxcatid'), ('taxauthrates', 'taxprovinces', 'taxauthrates.dispatchtaxprovince=taxprovinces.taxprovinceid'), ('taxprovinces', 'taxauthrates', 'taxprovinces.taxprovinceid=taxauthrates.dispatchtaxprovince'), ('taxgrouptaxes', 'taxgroups', 'taxgrouptaxes.taxgroupid=taxgroups.taxgroupid'), ('taxgroups', 'taxgrouptaxes', 'taxgroups.taxgroupid=taxgrouptaxes.taxgroupid'), ('taxgrouptaxes', 'taxauthorities', 'taxgrouptaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'taxgrouptaxes', 'taxauthorities.taxid=taxgrouptaxes.taxauthid'), ('workcentres', 'locations', 'workcentres.location=locations.loccode'), ('locations', 'workcentres', 'locations.loccode=workcentres.location'), ('worksorders', 'locations', 'worksorders.loccode=locations.loccode'), ('locations', 'worksorders', 'locations.loccode=worksorders.loccode'), ('worksorders', 'stockmaster', 'worksorders.stockid=stockmaster.stockid'), ('stockmaster', 'worksorders', 'stockmaster.stockid=worksorders.stockid'), ('www_users', 'locations', 'www_users.defaultlocation=locations.loccode'), ('locations', 'www_users', 'locations.loccode=www_users.defaultlocation'), ('accountgroups', 'accountsection', 'accountgroups.sectioninaccounts=accountsection.sectionid'), ('accountsection', 'accountgroups', 'accountsection.sectionid=accountgroups.sectioninaccounts'), ('bankaccounts', 'chartmaster', 'bankaccounts.accountcode=chartmaster.accountcode'), ('chartmaster', 'bankaccounts', 'chartmaster.accountcode=bankaccounts.accountcode'), ('banktrans', 'systypes', 'banktrans.type=systypes.typeid'), ('systypes', 'banktrans', 'systypes.typeid=banktrans.type'), ('banktrans', 'bankaccounts', 'banktrans.bankact=bankaccounts.accountcode'), ('bankaccounts', 'banktrans', 'bankaccounts.accountcode=banktrans.bankact'), ('bom', 'stockmaster', 'bom.parent=stockmaster.stockid'), ('stockmaster', 'bom', 'stockmaster.stockid=bom.parent'), ('bom', 'stockmaster', 'bom.component=stockmaster.stockid'), ('stockmaster', 'bom', 'stockmaster.stockid=bom.component'), ('bom', 'workcentres', 'bom.workcentreadded=workcentres.code'), ('workcentres', 'bom', 'workcentres.code=bom.workcentreadded'), ('bom', 'locations', 'bom.loccode=locations.loccode'), ('locations', 'bom', 'locations.loccode=bom.loccode'), ('buckets', 'workcentres', 'buckets.workcentre=workcentres.code'), ('workcentres', 'buckets', 'workcentres.code=buckets.workcentre'), ('chartdetails', 'chartmaster', 'chartdetails.accountcode=chartmaster.accountcode'), ('chartmaster', 'chartdetails', 'chartmaster.accountcode=chartdetails.accountcode'), ('chartdetails', 'periods', 'chartdetails.period=periods.periodno'), ('periods', 'chartdetails', 'periods.periodno=chartdetails.period'), ('chartmaster', 'accountgroups', 'chartmaster.group_=accountgroups.groupname'), ('accountgroups', 'chartmaster', 'accountgroups.groupname=chartmaster.group_'), ('contractbom', 'workcentres', 'contractbom.workcentreadded=workcentres.code'), ('workcentres', 'contractbom', 'workcentres.code=contractbom.workcentreadded'), ('contractbom', 'locations', 'contractbom.loccode=locations.loccode'), ('locations', 'contractbom', 'locations.loccode=contractbom.loccode'), ('contractbom', 'stockmaster', 'contractbom.component=stockmaster.stockid'), ('stockmaster', 'contractbom', 'stockmaster.stockid=contractbom.component'), ('contractreqts', 'contracts', 'contractreqts.contract=contracts.contractref'), ('contracts', 'contractreqts', 'contracts.contractref=contractreqts.contract'), ('contracts', 'custbranch', 'contracts.debtorno=custbranch.debtorno'), ('custbranch', 'contracts', 'custbranch.debtorno=contracts.debtorno'), ('contracts', 'stockcategory', 'contracts.branchcode=stockcategory.categoryid'), ('stockcategory', 'contracts', 'stockcategory.categoryid=contracts.branchcode'), ('contracts', 'salestypes', 'contracts.typeabbrev=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes', 'contracts', 'salestypes.typeabbrev=contracts.typeabbrev'), ('custallocns', 'debtortrans', 'custallocns.transid_allocfrom=debtortrans.id'), ('debtortrans', 'custallocns', 'debtortrans.id=custallocns.transid_allocfrom'), ('custallocns', 'debtortrans', 'custallocns.transid_allocto=debtortrans.id'), ('debtortrans', 'custallocns', 'debtortrans.id=custallocns.transid_allocto'), ('custbranch', 'debtorsmaster', 'custbranch.debtorno=debtorsmaster.debtorno'), ('debtorsmaster', 'custbranch', 'debtorsmaster.debtorno=custbranch.debtorno'), ('custbranch', 'areas', 'custbranch.area=areas.areacode'), ('areas', 'custbranch', 'areas.areacode=custbranch.area'), ('custbranch', 'salesman', 'custbranch.salesman=salesman.salesmancode'), ('salesman', 'custbranch', 'salesman.salesmancode=custbranch.salesman'), ('custbranch', 'locations', 'custbranch.defaultlocation=locations.loccode'), ('locations', 'custbranch', 'locations.loccode=custbranch.defaultlocation'), ('custbranch', 'shippers', 'custbranch.defaultshipvia=shippers.shipper_id'), ('shippers', 'custbranch', 'shippers.shipper_id=custbranch.defaultshipvia'), ('debtorsmaster', 'holdreasons', 'debtorsmaster.holdreason=holdreasons.reasoncode'), ('holdreasons', 'debtorsmaster', 'holdreasons.reasoncode=debtorsmaster.holdreason'), ('debtorsmaster', 'currencies', 'debtorsmaster.currcode=currencies.currabrev'), ('currencies', 'debtorsmaster', 'currencies.currabrev=debtorsmaster.currcode'), ('debtorsmaster', 'paymentterms', 'debtorsmaster.paymentterms=paymentterms.termsindicator'), ('paymentterms', 'debtorsmaster', 'paymentterms.termsindicator=debtorsmaster.paymentterms'), ('debtorsmaster', 'salestypes', 'debtorsmaster.salestype=salestypes.typeabbrev'), ('salestypes', 'debtorsmaster', 'salestypes.typeabbrev=debtorsmaster.salestype'), ('debtortrans', 'custbranch', 'debtortrans.debtorno=custbranch.debtorno'), ('custbranch', 'debtortrans', 'custbranch.debtorno=debtortrans.debtorno'), ('debtortrans', 'systypes', 'debtortrans.type=systypes.typeid'), ('systypes', 'debtortrans', 'systypes.typeid=debtortrans.type'), ('debtortrans', 'periods', 'debtortrans.prd=periods.periodno'), ('periods', 'debtortrans', 'periods.periodno=debtortrans.prd'), ('debtortranstaxes', 'taxauthorities', 'debtortranstaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'debtortranstaxes', 'taxauthorities.taxid=debtortranstaxes.taxauthid'), ('debtortranstaxes', 'debtortrans', 'debtortranstaxes.debtortransid=debtortrans.id'), ('debtortrans', 'debtortranstaxes', 'debtortrans.id=debtortranstaxes.debtortransid'), ('discountmatrix', 'salestypes', 'discountmatrix.salestype=salestypes.typeabbrev'), ('salestypes', 'discountmatrix', 'salestypes.typeabbrev=discountmatrix.salestype'), ('freightcosts', 'locations', 'freightcosts.locationfrom=locations.loccode'), ('locations', 'freightcosts', 'locations.loccode=freightcosts.locationfrom'), ('freightcosts', 'shippers', 'freightcosts.shipperid=shippers.shipper_id'), ('shippers', 'freightcosts', 'shippers.shipper_id=freightcosts.shipperid'), ('gltrans', 'chartmaster', 'gltrans.account=chartmaster.accountcode'), ('chartmaster', 'gltrans', 'chartmaster.accountcode=gltrans.account'), ('gltrans', 'systypes', 'gltrans.type=systypes.typeid'), ('systypes', 'gltrans', 'systypes.typeid=gltrans.type'), ('gltrans', 'periods', 'gltrans.periodno=periods.periodno'), ('periods', 'gltrans', 'periods.periodno=gltrans.periodno'), ('grns', 'suppliers', 'grns.supplierid=suppliers.supplierid'), ('suppliers', 'grns', 'suppliers.supplierid=grns.supplierid'), ('grns', 'purchorderdetails', 'grns.podetailitem=purchorderdetails.podetailitem'), ('purchorderdetails', 'grns', 'purchorderdetails.podetailitem=grns.podetailitem'), ('locations', 'taxprovinces', 'locations.taxprovinceid=taxprovinces.taxprovinceid'), ('taxprovinces', 'locations', 'taxprovinces.taxprovinceid=locations.taxprovinceid'), ('locstock', 'locations', 'locstock.loccode=locations.loccode'), ('locations', 'locstock', 'locations.loccode=locstock.loccode'), ('locstock', 'stockmaster', 'locstock.stockid=stockmaster.stockid'), ('stockmaster', 'locstock', 'stockmaster.stockid=locstock.stockid'), ('loctransfers', 'locations', 'loctransfers.shiploc=locations.loccode'), ('locations', 'loctransfers', 'locations.loccode=loctransfers.shiploc'), ('loctransfers', 'locations', 'loctransfers.recloc=locations.loccode'), ('locations', 'loctransfers', 'locations.loccode=loctransfers.recloc'), ('loctransfers', 'stockmaster', 'loctransfers.stockid=stockmaster.stockid'), ('stockmaster', 'loctransfers', 'stockmaster.stockid=loctransfers.stockid'), ('orderdeliverydifferencesl', 'stockmaster', 'orderdeliverydifferenceslog.stockid=stockmaster.stockid'), ('stockmaster', 'orderdeliverydifferencesl', 'stockmaster.stockid=orderdeliverydifferenceslog.stockid'), ('orderdeliverydifferencesl', 'custbranch', 'orderdeliverydifferenceslog.debtorno=custbranch.debtorno'), ('custbranch', 'orderdeliverydifferencesl', 'custbranch.debtorno=orderdeliverydifferenceslog.debtorno'), ('orderdeliverydifferencesl', 'salesorders', 'orderdeliverydifferenceslog.branchcode=salesorders.orderno'), ('salesorders', 'orderdeliverydifferencesl', 'salesorders.orderno=orderdeliverydifferenceslog.branchcode'), ('prices', 'stockmaster', 'prices.stockid=stockmaster.stockid'), ('stockmaster', 'prices', 'stockmaster.stockid=prices.stockid'), ('prices', 'currencies', 'prices.currabrev=currencies.currabrev'), ('currencies', 'prices', 'currencies.currabrev=prices.currabrev'), ('prices', 'salestypes', 'prices.typeabbrev=salestypes.typeabbrev'), ('salestypes', 'prices', 'salestypes.typeabbrev=prices.typeabbrev'), ('purchdata', 'stockmaster', 'purchdata.stockid=stockmaster.stockid'), ('stockmaster', 'purchdata', 'stockmaster.stockid=purchdata.stockid'), ('purchdata', 'suppliers', 'purchdata.supplierno=suppliers.supplierid'), ('suppliers', 'purchdata', 'suppliers.supplierid=purchdata.supplierno'), ('purchorderdetails', 'purchorders', 'purchorderdetails.orderno=purchorders.orderno'), ('purchorders', 'purchorderdetails', 'purchorders.orderno=purchorderdetails.orderno'), ('purchorders', 'suppliers', 'purchorders.supplierno=suppliers.supplierid'), ('suppliers', 'purchorders', 'suppliers.supplierid=purchorders.supplierno'), ('purchorders', 'locations', 'purchorders.intostocklocation=locations.loccode'), ('locations', 'purchorders', 'locations.loccode=purchorders.intostocklocation'), ('recurringsalesorders', 'custbranch', 'recurringsalesorders.branchcode=custbranch.branchcode'), ('custbranch', 'recurringsalesorders', 'custbranch.branchcode=recurringsalesorders.branchcode'), ('recurrsalesorderdetails', 'recurringsalesorders', 'recurrsalesorderdetails.recurrorderno=recurringsalesorders.recurrorderno'), ('recurringsalesorders', 'recurrsalesorderdetails', 'recurringsalesorders.recurrorderno=recurrsalesorderdetails.recurrorderno'), ('recurrsalesorderdetails', 'stockmaster', 'recurrsalesorderdetails.stkcode=stockmaster.stockid'), ('stockmaster', 'recurrsalesorderdetails', 'stockmaster.stockid=recurrsalesorderdetails.stkcode'), ('reportcolumns', 'reportheaders', 'reportcolumns.reportid=reportheaders.reportid'), ('reportheaders', 'reportcolumns', 'reportheaders.reportid=reportcolumns.reportid'), ('salesanalysis', 'periods', 'salesanalysis.periodno=periods.periodno'), ('periods', 'salesanalysis', 'periods.periodno=salesanalysis.periodno'), ('salescatprod', 'stockmaster', 'salescatprod.stockid=stockmaster.stockid'), ('stockmaster', 'salescatprod', 'stockmaster.stockid=salescatprod.stockid'), ('salescatprod', 'salescat', 'salescatprod.salescatid=salescat.salescatid'), ('salescat', 'salescatprod', 'salescat.salescatid=salescatprod.salescatid'), ('salesorderdetails', 'salesorders', 'salesorderdetails.orderno=salesorders.orderno'), ('salesorders', 'salesorderdetails', 'salesorders.orderno=salesorderdetails.orderno'), ('salesorderdetails', 'stockmaster', 'salesorderdetails.stkcode=stockmaster.stockid'), ('stockmaster', 'salesorderdetails', 'stockmaster.stockid=salesorderdetails.stkcode');
INSERT INTO `reportlinks` VALUES ('salesorders', 'custbranch', 'salesorders.branchcode=custbranch.branchcode'), ('custbranch', 'salesorders', 'custbranch.branchcode=salesorders.branchcode'), ('salesorders', 'shippers', 'salesorders.debtorno=shippers.shipper_id'), ('shippers', 'salesorders', 'shippers.shipper_id=salesorders.debtorno'), ('salesorders', 'locations', 'salesorders.fromstkloc=locations.loccode'), ('locations', 'salesorders', 'locations.loccode=salesorders.fromstkloc'), ('securitygroups', 'securityroles', 'securitygroups.secroleid=securityroles.secroleid'), ('securityroles', 'securitygroups', 'securityroles.secroleid=securitygroups.secroleid'), ('securitygroups', 'securitytokens', 'securitygroups.tokenid=securitytokens.tokenid'), ('securitytokens', 'securitygroups', 'securitytokens.tokenid=securitygroups.tokenid'), ('shipmentcharges', 'shipments', 'shipmentcharges.shiptref=shipments.shiptref'), ('shipments', 'shipmentcharges', 'shipments.shiptref=shipmentcharges.shiptref'), ('shipmentcharges', 'systypes', 'shipmentcharges.transtype=systypes.typeid'), ('systypes', 'shipmentcharges', 'systypes.typeid=shipmentcharges.transtype'), ('shipments', 'suppliers', 'shipments.supplierid=suppliers.supplierid'), ('suppliers', 'shipments', 'suppliers.supplierid=shipments.supplierid'), ('stockcheckfreeze', 'stockmaster', 'stockcheckfreeze.stockid=stockmaster.stockid'), ('stockmaster', 'stockcheckfreeze', 'stockmaster.stockid=stockcheckfreeze.stockid'), ('stockcheckfreeze', 'locations', 'stockcheckfreeze.loccode=locations.loccode'), ('locations', 'stockcheckfreeze', 'locations.loccode=stockcheckfreeze.loccode'), ('stockcounts', 'stockmaster', 'stockcounts.stockid=stockmaster.stockid'), ('stockmaster', 'stockcounts', 'stockmaster.stockid=stockcounts.stockid'), ('stockcounts', 'locations', 'stockcounts.loccode=locations.loccode'), ('locations', 'stockcounts', 'locations.loccode=stockcounts.loccode'), ('stockmaster', 'stockcategory', 'stockmaster.categoryid=stockcategory.categoryid'), ('stockcategory', 'stockmaster', 'stockcategory.categoryid=stockmaster.categoryid'), ('stockmaster', 'taxcategories', 'stockmaster.taxcatid=taxcategories.taxcatid'), ('taxcategories', 'stockmaster', 'taxcategories.taxcatid=stockmaster.taxcatid'), ('stockmoves', 'stockmaster', 'stockmoves.stockid=stockmaster.stockid'), ('stockmaster', 'stockmoves', 'stockmaster.stockid=stockmoves.stockid'), ('stockmoves', 'systypes', 'stockmoves.type=systypes.typeid'), ('systypes', 'stockmoves', 'systypes.typeid=stockmoves.type'), ('stockmoves', 'locations', 'stockmoves.loccode=locations.loccode'), ('locations', 'stockmoves', 'locations.loccode=stockmoves.loccode'), ('stockmoves', 'periods', 'stockmoves.prd=periods.periodno'), ('periods', 'stockmoves', 'periods.periodno=stockmoves.prd'), ('stockmovestaxes', 'taxauthorities', 'stockmovestaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'stockmovestaxes', 'taxauthorities.taxid=stockmovestaxes.taxauthid'), ('stockserialitems', 'stockmaster', 'stockserialitems.stockid=stockmaster.stockid'), ('stockmaster', 'stockserialitems', 'stockmaster.stockid=stockserialitems.stockid'), ('stockserialitems', 'locations', 'stockserialitems.loccode=locations.loccode'), ('locations', 'stockserialitems', 'locations.loccode=stockserialitems.loccode'), ('stockserialmoves', 'stockmoves', 'stockserialmoves.stockmoveno=stockmoves.stkmoveno'), ('stockmoves', 'stockserialmoves', 'stockmoves.stkmoveno=stockserialmoves.stockmoveno'), ('stockserialmoves', 'stockserialitems', 'stockserialmoves.stockid=stockserialitems.stockid'), ('stockserialitems', 'stockserialmoves', 'stockserialitems.stockid=stockserialmoves.stockid'), ('suppallocs', 'supptrans', 'suppallocs.transid_allocfrom=supptrans.id'), ('supptrans', 'suppallocs', 'supptrans.id=suppallocs.transid_allocfrom'), ('suppallocs', 'supptrans', 'suppallocs.transid_allocto=supptrans.id'), ('supptrans', 'suppallocs', 'supptrans.id=suppallocs.transid_allocto'), ('suppliercontacts', 'suppliers', 'suppliercontacts.supplierid=suppliers.supplierid'), ('suppliers', 'suppliercontacts', 'suppliers.supplierid=suppliercontacts.supplierid'), ('suppliers', 'currencies', 'suppliers.currcode=currencies.currabrev'), ('currencies', 'suppliers', 'currencies.currabrev=suppliers.currcode'), ('suppliers', 'paymentterms', 'suppliers.paymentterms=paymentterms.termsindicator'), ('paymentterms', 'suppliers', 'paymentterms.termsindicator=suppliers.paymentterms'), ('suppliers', 'taxgroups', 'suppliers.taxgroupid=taxgroups.taxgroupid'), ('taxgroups', 'suppliers', 'taxgroups.taxgroupid=suppliers.taxgroupid'), ('supptrans', 'systypes', 'supptrans.type=systypes.typeid'), ('systypes', 'supptrans', 'systypes.typeid=supptrans.type'), ('supptrans', 'suppliers', 'supptrans.supplierno=suppliers.supplierid'), ('suppliers', 'supptrans', 'suppliers.supplierid=supptrans.supplierno'), ('supptranstaxes', 'taxauthorities', 'supptranstaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'supptranstaxes', 'taxauthorities.taxid=supptranstaxes.taxauthid'), ('supptranstaxes', 'supptrans', 'supptranstaxes.supptransid=supptrans.id'), ('supptrans', 'supptranstaxes', 'supptrans.id=supptranstaxes.supptransid'), ('taxauthorities', 'chartmaster', 'taxauthorities.taxglcode=chartmaster.accountcode'), ('chartmaster', 'taxauthorities', 'chartmaster.accountcode=taxauthorities.taxglcode'), ('taxauthorities', 'chartmaster', 'taxauthorities.purchtaxglaccount=chartmaster.accountcode'), ('chartmaster', 'taxauthorities', 'chartmaster.accountcode=taxauthorities.purchtaxglaccount'), ('taxauthrates', 'taxauthorities', 'taxauthrates.taxauthority=taxauthorities.taxid'), ('taxauthorities', 'taxauthrates', 'taxauthorities.taxid=taxauthrates.taxauthority'), ('taxauthrates', 'taxcategories', 'taxauthrates.taxcatid=taxcategories.taxcatid'), ('taxcategories', 'taxauthrates', 'taxcategories.taxcatid=taxauthrates.taxcatid'), ('taxauthrates', 'taxprovinces', 'taxauthrates.dispatchtaxprovince=taxprovinces.taxprovinceid'), ('taxprovinces', 'taxauthrates', 'taxprovinces.taxprovinceid=taxauthrates.dispatchtaxprovince'), ('taxgrouptaxes', 'taxgroups', 'taxgrouptaxes.taxgroupid=taxgroups.taxgroupid'), ('taxgroups', 'taxgrouptaxes', 'taxgroups.taxgroupid=taxgrouptaxes.taxgroupid'), ('taxgrouptaxes', 'taxauthorities', 'taxgrouptaxes.taxauthid=taxauthorities.taxid'), ('taxauthorities', 'taxgrouptaxes', 'taxauthorities.taxid=taxgrouptaxes.taxauthid'), ('workcentres', 'locations', 'workcentres.location=locations.loccode'), ('locations', 'workcentres', 'locations.loccode=workcentres.location'), ('worksorders', 'locations', 'worksorders.loccode=locations.loccode'), ('locations', 'worksorders', 'locations.loccode=worksorders.loccode'), ('worksorders', 'stockmaster', 'worksorders.stockid=stockmaster.stockid'), ('stockmaster', 'worksorders', 'stockmaster.stockid=worksorders.stockid'), ('www_users', 'locations', 'www_users.defaultlocation=locations.loccode'), ('locations', 'www_users', 'locations.loccode=www_users.defaultlocation');

-- ----------------------------
-- Table structure for `reports`
-- ----------------------------
DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports` (
  `id` int(5) NOT NULL auto_increment,
  `reportname` varchar(30) NOT NULL default '',
  `reporttype` char(3) NOT NULL default 'rpt',
  `groupname` varchar(9) NOT NULL default 'misc',
  `defaultreport` enum('1','0') NOT NULL default '0',
  `papersize` varchar(15) NOT NULL default 'A4,210,297',
  `paperorientation` enum('P','L') NOT NULL default 'P',
  `margintop` int(3) NOT NULL default '10',
  `marginbottom` int(3) NOT NULL default '10',
  `marginleft` int(3) NOT NULL default '10',
  `marginright` int(3) NOT NULL default '10',
  `coynamefont` varchar(20) NOT NULL default 'Helvetica',
  `coynamefontsize` int(3) NOT NULL default '12',
  `coynamefontcolor` varchar(11) NOT NULL default '0,0,0',
  `coynamealign` enum('L','C','R') NOT NULL default 'C',
  `coynameshow` enum('1','0') NOT NULL default '1',
  `title1desc` varchar(50) NOT NULL default '%reportname%',
  `title1font` varchar(20) NOT NULL default 'Helvetica',
  `title1fontsize` int(3) NOT NULL default '10',
  `title1fontcolor` varchar(11) NOT NULL default '0,0,0',
  `title1fontalign` enum('L','C','R') NOT NULL default 'C',
  `title1show` enum('1','0') NOT NULL default '1',
  `title2desc` varchar(50) NOT NULL default 'Report Generated %date%',
  `title2font` varchar(20) NOT NULL default 'Helvetica',
  `title2fontsize` int(3) NOT NULL default '10',
  `title2fontcolor` varchar(11) NOT NULL default '0,0,0',
  `title2fontalign` enum('L','C','R') NOT NULL default 'C',
  `title2show` enum('1','0') NOT NULL default '1',
  `filterfont` varchar(10) NOT NULL default 'Helvetica',
  `filterfontsize` int(3) NOT NULL default '8',
  `filterfontcolor` varchar(11) NOT NULL default '0,0,0',
  `filterfontalign` enum('L','C','R') NOT NULL default 'L',
  `datafont` varchar(10) NOT NULL default 'Helvetica',
  `datafontsize` int(3) NOT NULL default '10',
  `datafontcolor` varchar(10) NOT NULL default 'black',
  `datafontalign` enum('L','C','R') NOT NULL default 'L',
  `totalsfont` varchar(10) NOT NULL default 'Helvetica',
  `totalsfontsize` int(3) NOT NULL default '10',
  `totalsfontcolor` varchar(11) NOT NULL default '0,0,0',
  `totalsfontalign` enum('L','C','R') NOT NULL default 'L',
  `col1width` int(3) NOT NULL default '25',
  `col2width` int(3) NOT NULL default '25',
  `col3width` int(3) NOT NULL default '25',
  `col4width` int(3) NOT NULL default '25',
  `col5width` int(3) NOT NULL default '25',
  `col6width` int(3) NOT NULL default '25',
  `col7width` int(3) NOT NULL default '25',
  `col8width` int(3) NOT NULL default '25',
  `col9width` int(3) NOT NULL default '25',
  `col10width` int(3) NOT NULL default '25',
  `col11width` int(3) NOT NULL default '25',
  `col12width` int(3) NOT NULL default '25',
  `col13width` int(3) NOT NULL default '25',
  `col14width` int(3) NOT NULL default '25',
  `col15width` int(3) NOT NULL default '25',
  `col16width` int(3) NOT NULL default '25',
  `col17width` int(3) NOT NULL default '25',
  `col18width` int(3) NOT NULL default '25',
  `col19width` int(3) NOT NULL default '25',
  `col20width` int(3) NOT NULL default '25',
  `table1` varchar(25) NOT NULL default '',
  `table2` varchar(25) default NULL,
  `table2criteria` varchar(75) default NULL,
  `table3` varchar(25) default NULL,
  `table3criteria` varchar(75) default NULL,
  `table4` varchar(25) default NULL,
  `table4criteria` varchar(75) default NULL,
  `table5` varchar(25) default NULL,
  `table5criteria` varchar(75) default NULL,
  `table6` varchar(25) default NULL,
  `table6criteria` varchar(75) default NULL,
  PRIMARY KEY  (`id`),
  KEY `name` (`reportname`,`groupname`)
) ENGINE=MyISAM AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reports
-- ----------------------------
INSERT INTO `reports` VALUES ('135', 'Currency Price List', 'rpt', 'inv', '1', 'A4:210:297', 'P', '10', '10', '10', '10', 'helvetica', '12', '0:0:0', 'C', '1', '%reportname%', 'helvetica', '10', '0:0:0', 'C', '1', 'Report Generated %date%', 'helvetica', '10', '0:0:0', 'C', '1', 'helvetica', '8', '0:0:0', 'L', 'helvetica', '10', '0:0:0', 'L', 'helvetica', '10', '0:0:0', 'L', '25', '25', '25', '25', '25', '25', '25', '25', '25', '25', '25', '25', '25', '25', '25', '25', '25', '25', '25', '25', 'stockmaster', 'prices', 'stockmaster.stockid=prices.stockid', '', '', '', '', '', '', '', '');

-- ----------------------------
-- Table structure for `salesanalysis`
-- ----------------------------
DROP TABLE IF EXISTS `salesanalysis`;
CREATE TABLE `salesanalysis` (
  `typeabbrev` char(2) NOT NULL default '',
  `periodno` smallint(6) NOT NULL default '0',
  `amt` double NOT NULL default '0',
  `cost` double NOT NULL default '0',
  `cust` varchar(10) NOT NULL default '',
  `custbranch` varchar(10) NOT NULL default '',
  `qty` double NOT NULL default '0',
  `disc` double NOT NULL default '0',
  `stockid` varchar(20) NOT NULL default '',
  `area` varchar(3) NOT NULL,
  `budgetoractual` tinyint(1) NOT NULL default '0',
  `salesperson` char(3) NOT NULL default '',
  `stkcategory` varchar(6) NOT NULL default '',
  `id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id`),
  KEY `CustBranch` (`custbranch`),
  KEY `Cust` (`cust`),
  KEY `PeriodNo` (`periodno`),
  KEY `StkCategory` (`stkcategory`),
  KEY `StockID` (`stockid`),
  KEY `TypeAbbrev` (`typeabbrev`),
  KEY `Area` (`area`),
  KEY `BudgetOrActual` (`budgetoractual`),
  KEY `Salesperson` (`salesperson`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of salesanalysis
-- ----------------------------
INSERT INTO `salesanalysis` VALUES ('DE', '2', '31.9', '10.5', 'QUARTER', 'QUARTER', '2', '0', 'DVD-DHWV', 'FL', '1', 'ERI', 'DVD', '1'), ('DE', '2', '14.5', '2.85', 'QUARTER', 'QUARTER', '1', '0', 'DVD-LTWP', 'FL', '1', 'ERI', 'DVD', '2'), ('DE', '3', '-15.95', '-5.25', 'QUARTER', 'QUARTER', '-1', '0', 'DVD-DHWV', 'FL', '1', 'ERI', 'DVD', '3'), ('DE', '-11', '234.56470588235', '186.2635', 'ANGRY', 'ANGRY', '31', '6.21', 'BREAD', 'TR', '1', 'ERI', 'FOOD', '5'), ('DE', '-11', '66.8576470588235', '16.75', 'ANGRY', 'ANGRY', '6.7', '0.04485', 'SALT', 'TR', '1', 'ERI', 'BAKE', '6'), ('DE', '36', '0', '-30.0425', 'ANGRY', 'ANGRY', '-5', '0', 'BREAD', 'TR', '1', 'ERI', 'FOOD', '7');

-- ----------------------------
-- Table structure for `salescat`
-- ----------------------------
DROP TABLE IF EXISTS `salescat`;
CREATE TABLE `salescat` (
  `salescatid` tinyint(4) NOT NULL auto_increment,
  `parentcatid` tinyint(4) default NULL,
  `salescatname` varchar(30) default NULL,
  PRIMARY KEY  (`salescatid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of salescat
-- ----------------------------

-- ----------------------------
-- Table structure for `salescatprod`
-- ----------------------------
DROP TABLE IF EXISTS `salescatprod`;
CREATE TABLE `salescatprod` (
  `salescatid` tinyint(4) NOT NULL default '0',
  `stockid` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`salescatid`,`stockid`),
  KEY `salescatid` (`salescatid`),
  KEY `stockid` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of salescatprod
-- ----------------------------

-- ----------------------------
-- Table structure for `salesglpostings`
-- ----------------------------
DROP TABLE IF EXISTS `salesglpostings`;
CREATE TABLE `salesglpostings` (
  `id` int(11) NOT NULL auto_increment,
  `area` varchar(3) NOT NULL,
  `stkcat` varchar(6) NOT NULL default '',
  `discountglcode` int(11) NOT NULL default '0',
  `salesglcode` int(11) NOT NULL default '0',
  `salestype` char(2) NOT NULL default 'AN',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `Area_StkCat` (`area`,`stkcat`,`salestype`),
  KEY `Area` (`area`),
  KEY `StkCat` (`stkcat`),
  KEY `SalesType` (`salestype`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of salesglpostings
-- ----------------------------
INSERT INTO `salesglpostings` VALUES ('1', 'AN', 'ANY', '4900', '4100', 'AN'), ('2', 'AN', 'AIRCON', '5000', '4800', 'DE');

-- ----------------------------
-- Table structure for `salesman`
-- ----------------------------
DROP TABLE IF EXISTS `salesman`;
CREATE TABLE `salesman` (
  `salesmancode` char(3) NOT NULL default '',
  `salesmanname` char(30) NOT NULL default '',
  `smantel` char(20) NOT NULL default '',
  `smanfax` char(20) NOT NULL default '',
  `commissionrate1` double NOT NULL default '0',
  `breakpoint` decimal(10,0) NOT NULL default '0',
  `commissionrate2` double NOT NULL default '0',
  PRIMARY KEY  (`salesmancode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of salesman
-- ----------------------------
INSERT INTO `salesman` VALUES ('DE', 'Default Sales person', '', '', '0', '0', '0'), ('ERI', 'Eric Browlee', '', '', '0', '0', '0'), ('INT', 'Internet Shop', '', '', '0', '0', '0'), ('PHO', 'Phone Contact', '', '', '0', '0', '0');

-- ----------------------------
-- Table structure for `salesorderdetails`
-- ----------------------------
DROP TABLE IF EXISTS `salesorderdetails`;
CREATE TABLE `salesorderdetails` (
  `orderlineno` int(11) NOT NULL default '0',
  `orderno` int(11) NOT NULL default '0',
  `stkcode` varchar(20) NOT NULL default '',
  `qtyinvoiced` double NOT NULL default '0',
  `unitprice` double NOT NULL default '0',
  `quantity` double NOT NULL default '0',
  `estimate` tinyint(4) NOT NULL default '0',
  `discountpercent` double NOT NULL default '0',
  `actualdispatchdate` datetime NOT NULL default '0000-00-00 00:00:00',
  `completed` tinyint(1) NOT NULL default '0',
  `narrative` text,
  `itemdue` date default NULL COMMENT 'Due date for line item.  Some customers require \r\nacknowledgements with due dates by line item',
  `poline` varchar(10) default NULL COMMENT 'Some Customers require acknowledgements with a PO line number for each sales line',
  `commissionrate` double NOT NULL default '0',
  `commissionearned` double NOT NULL default '0',
  PRIMARY KEY  (`orderlineno`,`orderno`),
  KEY `OrderNo` (`orderno`),
  KEY `StkCode` (`stkcode`),
  KEY `Completed` (`completed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of salesorderdetails
-- ----------------------------
INSERT INTO `salesorderdetails` VALUES ('0', '6', 'BREAD', '3', '6.9', '3', '0', '0.1', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('0', '7', 'BREAD', '3', '6.9', '3', '0', '0.1', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('0', '8', 'BREAD', '3', '6.9', '3', '0', '0.1', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('0', '9', 'BREAD', '4', '6.9', '4', '0', '0.15', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('0', '10', 'BREAD', '2', '12', '2', '0', '0', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('0', '11', 'BREAD', '0', '0', '5', '0', '0', '2010-05-31 00:00:00', '0', '', '2010-05-31', null, '0', '0'), ('0', '12', 'SALT', '2', '25', '2', '0', '0', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('0', '13', 'SALT', '2', '25', '2', '0', '0', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('0', '15', 'BREAD', '1', '5', '1', '0', '0', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('0', '16', 'BREAD', '1', '5', '1', '0', '0', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('0', '17', 'BREAD', '1', '5', '1', '0', '0', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('0', '18', 'BREAD', '12', '9.5', '12', '0', '0', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('0', '22', 'BIGEARS12', '0', '5369.2307692308', '1', '0', '0', '0000-00-00 00:00:00', '0', '', '2010-10-15', '', '0', '0'), ('0', '23', 'BIRTHDAYCAKECONSTRUC', '0', '2500', '1', '0', '0', '0000-00-00 00:00:00', '0', '', '2010-08-15', '', '0', '0'), ('1', '6', 'SALT', '3', '3.25', '3', '0', '0', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('1', '7', 'SALT', '3', '3.25', '3', '0', '0', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('1', '8', 'SALT', '3', '3.25', '3', '0', '0', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('1', '9', 'SALT', '1', '2.99', '1', '0', '0.015', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('1', '14', 'BREAD', '2', '5.25', '2', '0', '0', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0'), ('1', '18', 'SALT', '0.7', '5', '0.7', '0', '0', '2010-05-31 00:00:00', '1', '', '2010-05-31', null, '0', '0');

-- ----------------------------
-- Table structure for `salesorders`
-- ----------------------------
DROP TABLE IF EXISTS `salesorders`;
CREATE TABLE `salesorders` (
  `orderno` int(11) NOT NULL,
  `debtorno` varchar(10) NOT NULL default '',
  `branchcode` varchar(10) NOT NULL default '',
  `customerref` varchar(50) NOT NULL default '',
  `buyername` varchar(50) default NULL,
  `comments` longblob,
  `orddate` date NOT NULL default '0000-00-00',
  `ordertype` char(2) NOT NULL default '',
  `shipvia` int(11) NOT NULL default '0',
  `deladd1` varchar(40) NOT NULL default '',
  `deladd2` varchar(40) NOT NULL default '',
  `deladd3` varchar(40) NOT NULL default '',
  `deladd4` varchar(40) default NULL,
  `deladd5` varchar(20) NOT NULL default '',
  `deladd6` varchar(15) NOT NULL default '',
  `contactphone` varchar(25) default NULL,
  `contactemail` varchar(40) default NULL,
  `deliverto` varchar(40) NOT NULL default '',
  `deliverblind` tinyint(1) default '1',
  `freightcost` double NOT NULL default '0',
  `fromstkloc` varchar(5) NOT NULL default '',
  `deliverydate` date NOT NULL default '0000-00-00',
  `confirmeddate` date NOT NULL default '0000-00-00',
  `printedpackingslip` tinyint(4) NOT NULL default '0',
  `datepackingslipprinted` date NOT NULL default '0000-00-00',
  `quotation` tinyint(4) NOT NULL default '0',
  `quotedate` date NOT NULL default '0000-00-00',
  PRIMARY KEY  (`orderno`),
  KEY `DebtorNo` (`debtorno`),
  KEY `OrdDate` (`orddate`),
  KEY `OrderType` (`ordertype`),
  KEY `LocationIndex` (`fromstkloc`),
  KEY `BranchCode` (`branchcode`,`debtorno`),
  KEY `ShipVia` (`shipvia`),
  KEY `quotation` (`quotation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of salesorders
-- ----------------------------
INSERT INTO `salesorders` VALUES ('6', 'ANGRY', 'ANGRY', '', null, 0x54657374696E6720636F6D6D656E7473, '2010-05-31', 'DE', '1', 'Counter Sale', '', '', null, '', '', '0422 2245 2213', 'graville@angry.com', '', '0', '0', 'MEL', '2010-05-31', '2010-05-31', '0', '0000-00-00', '0', '0000-00-00'), ('7', 'ANGRY', 'ANGRY', '', null, 0x54657374696E6720636F6D6D656E7473, '2010-05-31', 'DE', '1', 'Counter Sale', '', '', null, '', '', '0422 2245 2213', 'graville@angry.com', '', '0', '0', 'MEL', '2010-05-31', '2010-05-31', '0', '0000-00-00', '0', '0000-00-00'), ('8', 'ANGRY', 'ANGRY', '', null, 0x54657374696E6720636F6D6D656E747320496E766F6963653A2034, '2010-05-31', 'DE', '1', 'Counter Sale', '', '', null, '', '', '0422 2245 2213', 'graville@angry.com', '', '0', '0', 'MEL', '2010-05-31', '2010-05-31', '0', '0000-00-00', '0', '0000-00-00'), ('9', 'ANGRY', 'ANGRY', '211547', null, 0x20496E766F6963653A2035, '2010-05-31', 'DE', '1', 'Counter Sale', '', '', null, '', '', '0422 2245 2213', 'graville@angry.com', '', '0', '0', 'MEL', '2010-05-31', '2010-05-31', '0', '0000-00-00', '0', '0000-00-00'), ('10', 'ANGRY', 'ANGRY', '', null, 0x20496E766F6963653A2036, '2010-05-31', 'DE', '1', 'Counter Sale', '', '', null, '', '', '', '', '', '0', '0', 'MEL', '2010-05-31', '2010-05-31', '0', '0000-00-00', '0', '0000-00-00'), ('11', 'ANGRY', 'ANGRY', '', null, 0x20496E766F6963653A2037, '2010-05-31', 'DE', '1', 'Counter Sale', '', '', null, '', '', '', '', '', '0', '0', 'MEL', '2010-05-31', '2010-05-31', '0', '0000-00-00', '0', '0000-00-00'), ('12', 'ANGRY', 'ANGRY', '', null, '', '2010-05-31', 'DE', '1', 'Counter Sale', '', '', null, '', '', '', '', '', '0', '0', 'MEL', '2010-05-31', '2010-05-31', '0', '0000-00-00', '0', '0000-00-00'), ('13', 'ANGRY', 'ANGRY', '', null, 0x20496E766F6963653A2039, '2010-05-31', 'DE', '1', 'Counter Sale', '', '', null, '', '', '', '', '', '0', '0', 'MEL', '2010-05-31', '2010-05-31', '0', '0000-00-00', '0', '0000-00-00'), ('14', 'ANGRY', 'ANGRY', '', null, 0x20496E766F6963653A203130, '2010-05-31', 'DE', '1', 'Counter Sale', '', '', null, '', '', '', '', '', '0', '0', 'MEL', '2010-05-31', '2010-05-31', '0', '0000-00-00', '0', '0000-00-00'), ('15', 'ANGRY', 'ANGRY', '', null, 0x20496E766F6963653A203131, '2010-05-31', 'DE', '1', 'Counter Sale', '', '', null, '', '', '', '', '', '0', '0', 'MEL', '2010-05-31', '2010-05-31', '0', '0000-00-00', '0', '0000-00-00'), ('16', 'ANGRY', 'ANGRY', '', null, 0x20496E766F6963653A203132, '2010-05-31', 'DE', '1', 'Counter Sale', '', '', null, '', '', '', '', '', '0', '0', 'MEL', '2010-05-31', '2010-05-31', '0', '0000-00-00', '0', '0000-00-00'), ('17', 'ANGRY', 'ANGRY', '', null, 0x20496E766F6963653A203133, '2010-05-31', 'DE', '1', 'Counter Sale', '', '', null, '', '', '', '', '', '0', '0', 'MEL', '2010-05-31', '2010-05-31', '0', '0000-00-00', '0', '0000-00-00'), ('18', 'ANGRY', 'ANGRY', '', null, 0x20496E766F6963653A203134, '2010-05-31', 'DE', '1', 'Counter Sale', '', '', null, '', '', '', '', '', '0', '0', 'MEL', '2010-05-31', '2010-05-31', '0', '0000-00-00', '0', '0000-00-00'), ('19', 'DUMBLE', 'DUMBLE', '', null, null, '2010-08-08', 'DE', '10', 'Hogwarts castle', 'Platform 9.75', '', '', '', '', 'Owls only', 'mmgonagal@hogwarts.edu.uk', 'Dumbledoor McGonagal &amp; Co', '1', '0', 'TOR', '2010-09-08', '0000-00-00', '0', '0000-00-00', '1', '2010-08-08'), ('22', 'QUARTER', 'QUARTER', '89-OOPDS', null, '', '2010-08-08', 'DE', '1', '1356 Union Drive', 'Holborn', 'England', '', '', '', '123456', '', 'Quarter Back to Back', '1', '0', 'TOR', '2010-10-15', '2010-08-16', '0', '0000-00-00', '0', '2010-08-16'), ('23', 'DUMBLE', 'DUMBLE', '', null, '', '2010-08-08', 'DE', '10', 'Hogwarts castle', 'Platform 9.75', '', '', '', '', 'Owls only', 'mmgonagal@hogwarts.edu.uk', 'Dumbledoor McGonagal &amp;amp;amp; Co', '1', '0', 'TOR', '2010-12-20', '2010-08-16', '0', '0000-00-00', '0', '2010-08-16');

-- ----------------------------
-- Table structure for `salestypes`
-- ----------------------------
DROP TABLE IF EXISTS `salestypes`;
CREATE TABLE `salestypes` (
  `typeabbrev` char(2) NOT NULL default '',
  `sales_type` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`typeabbrev`),
  KEY `Sales_Type` (`sales_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of salestypes
-- ----------------------------
INSERT INTO `salestypes` VALUES ('DE', 'Default Price List');

-- ----------------------------
-- Table structure for `scripts`
-- ----------------------------
DROP TABLE IF EXISTS `scripts`;
CREATE TABLE `scripts` (
  `pageid` smallint(4) NOT NULL auto_increment,
  `filename` varchar(50) NOT NULL default '',
  `pagedescription` text NOT NULL,
  PRIMARY KEY  (`pageid`),
  KEY `FileName` (`filename`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8 COMMENT='Index of all scripts';

-- ----------------------------
-- Records of scripts
-- ----------------------------
INSERT INTO `scripts` VALUES ('1', 'AccountGroups.php', 'Defines the groupings of general ledger accounts'), ('2', 'AgedDebtors.php', 'Lists customer account balances in detail or summary in selected currency'), ('3', 'AgedSuppliers.php', 'Lists supplier account balances in detail or summary in selected currency'), ('4', 'Areas.php', 'Defines the sales areas - all customers must belong to a sales area for the purposes of sales analysis'), ('5', 'BOMInquiry.php', 'Displays the bill of material with cost information'), ('6', 'BOMListing.php', 'Lists the bills of material for a selected range of items'), ('7', 'BOMs.php', 'Administers the bills of material for a selected item'), ('8', 'BankAccounts.php', 'Defines the general ledger code for bank accounts and specifies that bank transactions be created for these accounts for the purposes of reconciliation'), ('9', 'BankMatching.php', 'Allows payments and receipts to be matched off against bank statements'), ('10', 'BankReconciliation.php', 'Displays the bank reconciliation for a selected bank account'), ('11', 'COGSGLPostings.php', 'Defines the general ledger account to be used for cost of sales entries'), ('12', 'CompanyPreferences.php', 'Defines the settings applicable for the company, including name, address, tax authority reference, whether GL integration used etc.'), ('13', 'ConfirmDispatchControlled_Invoice.php', 'Specifies the batch references/serial numbers of items dispatched that are being invoiced'), ('14', 'ConfirmDispatch_Invoice.php', 'Creates sales invoices from entered sales orders based on the quantities dispatched that can be modified'), ('15', 'CreditItemsControlled.php', 'Specifies the batch references/serial numbers of items being credited back into stock'), ('16', 'CreditStatus.php', 'Defines the credit status records. Each customer account is given a credit status from this table. Some credit status records can prohibit invoicing and new orders being entered.'), ('17', 'Credit_Invoice.php', 'Creates a credit note based on the details of an existing invoice'), ('18', 'Currencies.php', 'Defines the currencies available. Each customer and supplier must be defined as transacting in one of the currencies defined here.'), ('19', 'CustEDISetup.php', 'Allows the set up the customer specified EDI parameters for server, email or ftp.'), ('20', 'CustWhereAlloc.php', 'Shows to which invoices a receipt was allocated to'), ('21', 'CustomerAllocations.php', 'Allows customer receipts and credit notes to be allocated to sales invoices'), ('22', 'CustomerBranches.php', 'Defines the details of customer branches such as delivery address and contact details - also sales area, representative etc'), ('23', 'CustomerInquiry.php', 'Shows the customers account transactions with balances outstanding, links available to drill down to invoice/credit note or email invoices/credit notes'), ('24', 'CustomerReceipt.php', 'Entry of both customer receipts against accounts receivable and also general ledger or nominal receipts'), ('25', 'CustomerTransInquiry.php', 'Lists in html the sequence of customer transactions, invoices, credit notes or receipts by a user entered date range'), ('26', 'Customers.php', 'Defines the setup of a customer account, including payment terms, billing address, credit status, currency etc'), ('27', 'DeliveryDetails.php', 'Used during order entry to allow the entry of delivery addresses other than the defaulted branch delivery address and information about carrier/shipping method etc'), ('28', 'DiscountCategories.php', 'Defines the items belonging to a discount category. Discount Categories are used to allow discounts based on quantities across a range of producs'), ('29', 'DiscountMatrix.php', 'Defines the rates of discount applicable to discount categories and the customer groupings to which the rates are to apply'), ('30', 'EDIMessageFormat.php', 'Specifies the EDI message format used by a customer - administrator use only.'), ('31', 'EDIProcessOrders.php', 'Processes incoming EDI orders into sales orders'), ('32', 'EDISendInvoices.php', 'Processes invoiced EDI customer invoices into EDI messages and sends using the customers preferred method either ftp or email attachments.'), ('33', 'EmailCustTrans.php', 'Emails selected invoice or credit to the customer'), ('34', 'FTP_RadioBeacon.php', 'FTPs sales orders for dispatch to a radio beacon software enabled warehouse dispatching facility'), ('35', 'FreightCosts.php', 'Defines the setup of the freight cost using different shipping methods to different destinations. The system can use this information to calculate applicable freight if the items are defined with the correct kgs and cubic volume'), ('36', 'GLAccountInquiry.php', 'Shows the general ledger transactions for a specified account over a specified range of periods'), ('37', 'GLAccounts.php', 'Defines the general ledger accounts'), ('38', 'GLBalanceSheet.php', 'Shows the balance sheet for the company as at a specified date'), ('39', 'GLCodesInquiry.php', 'Shows the list of general ledger codes defined with account names and groupings'), ('40', 'GLJournal.php', 'Entry of general ledger journals, periods are calculated based on the date entered here'), ('41', 'GLProfit_Loss.php', 'Shows the profit and loss of the company for the range of periods entered'), ('42', 'GLTransInquiry.php', 'Shows the general ledger journal created for the sub ledger transaction specified'), ('43', 'GLTrialBalance.php', 'Shows the trial balance for the month and the for the period selected together with the budgeted trial balances'), ('44', 'GoodsReceived.php', 'Entry of items received against purchase orders'), ('45', 'GoodsReceivedControlled.php', 'Entry of the serial numbers or batch references for controlled items received against purchase orders'), ('46', 'InventoryPlanning.php', 'Creates a pdf report showing the last 4 months use of items including as a component of assemblies together with stock quantity on hand, current demand for the item and current quantity on sales order.'), ('47', 'InventoryValuation.php', 'Creates a pdf report showing the value of stock at standard cost for a range of product categories selected'), ('48', 'Locations.php', 'Defines the inventory stocking locations or warehouses'), ('49', 'Logout.php', 'Shows when the user logs out of webERP'), ('50', 'MailInventoryValuation.php', 'Meant to be run as a scheduled process to email the stock valuation off to a specified person. Creates the same stock valuation report as InventoryValuation.php'), ('51', 'MailSalesReport.php', 'Creates a sales analysis pdf report and emails it to the defined receipients. This script is meant to be run as a scheduled process for daily or weekly sales reporting'), ('52', 'MailSalesReport_csv.php', 'Creates a sales analysis report as a comma separated values (csv) file and emails it to the defined receipients. This script is meant to be run as a scheduled process for daily or weekly sales reporting'), ('53', 'OrderDetails.php', 'Shows the detail of a sales order'), ('54', 'OutstandingGRNs.php', 'Creates a pdf showing all GRNs for which there has been no purchase invoice matched off against.'), ('55', 'PDFBankingSummary.php', 'Creates a pdf showing the amounts entered as receipts on a specified date together with references for the purposes of banking'), ('56', 'PDFChequeListing.php', 'Creates a pdf showing all payments that have been made from a specified bank account over a specified period. This can be emailed to an email account defined in config.php - ie a financial controller'), ('57', 'PDFDeliveryDifferences.php', 'Creates a pdf report listing the delivery differences from what the customer requested as recorded in the order entry. The report calculates a percentage of order fill based on the number of orders filled in full on time'), ('58', 'PDFLowGP.php', 'Creates a pdf report showing the low gross profit sales made in the selected date range. The percentage of gp deemed acceptable can also be entered'), ('59', 'PDFPriceList.php', 'Creates a pdf of the price list applicable to a given sales type and customer. Also allows the listing of prices specific to a customer'), ('60', 'PDFStockCheckComparison.php', 'Creates a pdf comparing the quantites entered as counted at a given range of locations against the quantity stored as on hand as at the time a stock check was initiated.'), ('61', 'PDFStockLocTransfer.php', 'Creates a stock location transfer docket for the selected location transfer reference number'), ('62', 'PO_Chk_ShiptRef_JobRef.php', 'Checks the Shipment of JobReference number is correct during AP invoice entry'), ('63', 'PO_Header.php', 'Entry of a purchase order header record - date, references buyer etc'), ('64', 'PO_Items.php', 'Entry of a purchase order items - allows entry of items with lookup of currency cost from Purchasing Data previously entered also allows entry of nominal items against a general ledger code if the AP is integrated to the GL'), ('65', 'PO_OrderDetails.php', 'Purchase order inquiry shows the quantity received and invoiced of purchase order items as well as the header information'), ('66', 'PO_PDFPurchOrder.php', 'Creates a pdf of the selected purchase order for printing or email to one of the supplier contacts entered'), ('67', 'PO_SelectOSPurchOrder.php', 'Shows the outstanding purchase orders for selecting with links to receive or modify the purchase order header and items'), ('68', 'PO_SelectPurchOrder.php', 'Allows selection of any purchase order with links to the inquiry'), ('69', 'PaymentTerms.php', 'Defines the payment terms records, these can be expressed as either a number of days credit or a day in the following month. All customers and suppliers must have a corresponding payment term recorded against their account'), ('70', 'Payments.php', 'Entry of bank account payments either against an AP account or a general ledger payment - if the AP-GL link in company preferences is set'), ('71', 'PeriodsInquiry.php', 'Shows a list of all the system defined periods'), ('72', 'Prices.php', 'Entry of prices for a selected item also allows selection of sales type and currency for the price'), ('73', 'Prices_Customer.php', 'Entry of prices for a selected item and selected customer/branch. The currency and sales type is defaulted from the customer\'s record'), ('74', 'PrintCustOrder.php', 'Creates a pdf of the dispatch note - by default this is expected to be on two part pre-printed stationery to allow pickers to note discrepancies for the confirmer to update the dispatch at the time of invoicing'), ('75', 'PrintCustOrder_generic.php', 'Creates two copies of a laser printed dispatch note - both copies need to be written on by the pickers with any discrepancies to advise customer of any shortfall and on the office copy to ensure the correct quantites are invoiced'), ('76', 'PrintCustStatements.php', 'Creates a pdf for the customer statements in the selected range'), ('77', 'PrintCustTrans.php', 'Creates either a html invoice or credit note or a pdf. A range of invoices or credit notes can be selected also.'), ('78', 'PurchData.php', 'Entry of supplier purchasing data, the suppliers part reference and the suppliers currency cost of the item'), ('79', 'ReverseGRN.php', 'Reverses the entry of goods received - creating stock movements back out and necessary general ledger journals to effect the reversal'), ('80', 'SalesAnalReptCols.php', 'Entry of the definition of a sales analysis report\'s columns.'), ('81', 'SalesAnalRepts.php', 'Entry of the definition of a sales analysis report headers'), ('82', 'SalesAnalysis_UserDefined.php', 'Creates a pdf of a selected user defined sales analysis report'), ('83', 'SalesGLPostings.php', 'Defines the general ledger accounts used to post sales to based on product categories and sales areas'), ('84', 'SalesPeople.php', 'Defines the sales people of the business'), ('85', 'SalesTypes.php', 'Defines the sales types - prices are held against sales types they can be considered price lists. Sales analysis records are held by sales type too.'), ('86', 'SelectCompletedOrder.php', 'Allows the selection of completed sales orders for inquiries - choices to select by item code or customer'), ('87', 'SelectCreditItems.php', 'Entry of credit notes from scratch, selecting the items in either quick entry mode or searching for them manually'), ('88', 'SelectCustomer.php', 'Selection of customer - from where all customer related maintenance, transactions and inquiries start'), ('89', 'SelectGLAccount.php', 'Selection of general ledger account from where all general ledger account maintenance, or inquiries are initiated'), ('90', 'SelectOrderItems.php', 'Entry of sales order items with both quick entry and part search functions'), ('91', 'SelectProduct.php', 'Selection of items. All item maintenance, transactions and inquiries start with this script'), ('92', 'SelectSalesOrder.php', 'Selects a sales order irrespective of completed or not for inquiries'), ('93', 'SelectSupplier.php', 'Selects a supplier. A supplier is required to be selected before any AP transactions and before any maintenance or inquiry of the supplier'), ('94', 'ShipmentCosting.php', 'Shows the costing of a shipment with all the items invoice values and any shipment costs apportioned. Updating the shipment has an option to update standard costs of all items on the shipment and create any general ledger variance journals'), ('95', 'Shipments.php', 'Entry of shipments from outstanding purchase orders for a selected supplier - changes in the delivery date will cascade into the different purchase orders on the shipment'), ('96', 'Shippers.php', 'Defines the shipping methods available. Each customer branch has a default shipping method associated with it which must match a record from this table'), ('97', 'Shipt_Select.php', 'Selection of a shipment for displaying and modification or updating'), ('98', 'ShiptsList.php', 'Shows a list of all the open shipments for a selected supplier. Linked from POItems.php'), ('99', 'SpecialOrder.php', 'Allows for a sales order to be created and an indent order to be created on a supplier for a one off item that may never be purchased again. A dummy part is created based on the description and cost details given.'), ('100', 'StockAdjustments.php', 'Entry of quantity corrections to stocks in a selected location.'), ('101', 'StockAdjustmentsControlled.php', 'Entry of batch references or serial numbers on controlled stock items being adjusted');
INSERT INTO `scripts` VALUES ('102', 'StockCategories.php', 'Defines the stock categories. All items must refer to one of these categories. The category record also allows the specification of the general ledger codes where stock items are to be posted - the balance sheet account and the profit and loss effect of any adjustments and the profit and loss effect of any price variances'), ('103', 'StockCheck.php', 'Allows creation of a stock check file - copying the current quantites in stock for later comparison to the entered counts. Also produces a pdf for the count sheets.'), ('104', 'StockCostUpdate.php', 'Allows update of the standard cost of items producing general ledger journals if the company preferences stock GL interface is active'), ('105', 'StockCounts.php', 'Allows entry of stock counts'), ('106', 'StockLocMovements.php', 'Inquiry shows the Movements of all stock items for a specified location'), ('107', 'StockLocQties_csv.php', 'Makes a comma separated values (CSV)file of the stock item codes and quantities'), ('108', 'StockLocStatus.php', 'Shows the stock on hand together with outstanding sales orders and outstanding purchase orders by stock location for all items in the selected stock category'), ('109', 'StockLocTransfer.php', 'Entry of a bulk stock location transfer for many parts from one location to another.'), ('110', 'StockLocTransferReceive.php', 'Effects the transfer and creates the stock movements for a bulk stock location transfer initiated from StockLocTransfer.php'), ('111', 'StockMovements.php', 'Shows a list of all the stock movements for a selected item and stock location including the price at which they were sold in local currency and the price at which they were purchased for in local currency'), ('112', 'StockQties_csv.php', 'Makes a comma separated values (CSV)file of the stock item codes and quantities'), ('113', 'StockReorderLevel.php', 'Entry and review of the re-order level of items by stocking location'), ('114', 'StockSerialItems.php', 'Shows a list of the serial numbers or the batch references and quantities of controlled items. This inquiry is linked from the stock status inquiry'), ('115', 'StockStatus.php', 'Shows the stock on hand together with outstanding sales orders and outstanding purchase orders by stock location for a selected part. Has a link to show the serial numbers in stock at the location selected if the item is controlled'), ('116', 'StockTransferControlled.php', 'Entry of serial numbers/batch references for controlled items being received on a stock transfer. The script is used by both bulk transfers and point to point transfers'), ('117', 'StockTransfers.php', 'Entry of point to point stock location transfers of a single part'), ('118', 'StockUsage.php', 'Inquiry showing the quantity of stock used by period calculated from the sum of the stock movements over that period - by item and stock location. Also available over all locations'), ('119', 'Stocks.php', 'Defines an item - maintenance and addition of new parts'), ('120', 'SuppCreditGRNs.php', 'Entry of a supplier credit notes (debit notes) against existing GRN which have already been matched in full or in part'), ('121', 'SuppInvGRNs.php', 'Entry of supplier invoices against goods received'), ('122', 'SuppPaymentRun.php', 'Automatic creation of payment records based on calculated amounts due from AP invoices entered'), ('123', 'SuppShiptChgs.php', 'Entry of supplier invoices against shipments as charges against a shipment'), ('124', 'SuppTransGLAnalysis.php', 'Entry of supplier invoices against general ledger codes'), ('125', 'SupplierAllocations.php', 'Entry of allocations of supplier payments and credit notes to invoices'), ('126', 'SupplierContacts.php', 'Entry of supplier contacts and contact details including email addresses'), ('127', 'SupplierCredit.php', 'Entry of supplier credit notes (debit notes)'), ('128', 'SupplierInquiry.php', 'Inquiry showing invoices, credit notes and payments made to suppliers together with the amounts outstanding'), ('129', 'SupplierInvoice.php', 'Entry of supplier invoices'), ('130', 'Suppliers.php', 'Entry of new suppliers and maintenance of existing suppliers'), ('131', 'TaxAuthorities.php', 'Entry of tax authorities - the state intitutions that charge tax'), ('132', 'TaxAuthorityRates.php', 'Entry of the rates of tax applicable to the tax authority depending on the item tax level'), ('133', 'WWW_Users.php', 'Entry of users and security settings of users'), ('134', 'WhereUsedInquiry.php', 'Inquiry showing where an item is used ie all the parents where the item is a component of'), ('135', 'WorkCentres.php', 'Defines the various centres of work within a manufacturing company. Also the overhead and labour rates applicable to the work centre and its standard capacity'), ('136', 'WorkOrderEntry.php', 'Entry of new work orders'), ('137', 'WorkOrderIssue.php', 'Issue of materials to a work order'), ('138', 'Z_ChangeBranchCode.php', 'Utility to change the branch code of a customer that cascades the change through all the necessary tables'), ('139', 'Z_ChangeCustomerCode.php', 'Utility to change a customer code that cascades the change through all the necessary tables'), ('140', 'Z_ChangeStockCode.php', 'Utility to change an item code that cascades the change through all the necessary tables'), ('141', 'Z_CheckAllocationsFrom.php', ''), ('142', 'Z_CheckAllocs.php', ''), ('143', 'Z_CheckDebtorsControl.php', 'Inquiry that shows the total local currency (functional currency) balance of all customer accounts to reconcile with the general ledger debtors account'), ('144', 'Z_CreateChartDetails.php', 'Utility page to create chart detail records for all general ledger accounts and periods created - needs expert assistance in use'), ('145', 'Z_CreateCompany.php', 'Utility to insert company number 1 if not already there - actually only company 1 is used - the system is not multi-company'), ('146', 'Z_CurrencyDebtorsBalances.php', 'Inquiry that shows the total foreign currency together with the total local currency (functional currency) balances of all customer accounts to reconcile with the general ledger debtors account'), ('147', 'Z_CurrencySuppliersBalances.php', 'Inquiry that shows the total foreign currency amounts and also the local currency (functional currency) balances of all supplier accounts to reconcile with the general ledger creditors account'), ('148', 'Z_DeleteCreditNote.php', 'Utility to reverse a customer credit note - a desperate measure that should not be used except in extreme circumstances'), ('149', 'Z_DeleteInvoice.php', 'Utility to reverse a customer invoice - a desperate measure that should not be used except in extreme circumstances'), ('150', 'Z_DeleteSalesTransActions.php', 'Utility to delete all sales transactions, sales analysis the lot! Extreme care required!!!'), ('151', 'Z_MakeStockLocns.php', 'Utility to make LocStock records for all items and locations if not already set up.'), ('152', 'Z_PriceChanges.php', 'Utility to make bulk pricing alterations to selected sales type price lists or selected customer prices only'), ('153', 'Z_ReApplyCostToSA.php', 'Utility to allow the sales analysis table to be updated with the latest cost information - the sales analysis takes the cost at the time the sale was made to reconcile with the enteries made in the gl.'), ('154', 'Z_RePostGLFromPeriod.php', 'Utility to repost all general ledger transaction commencing from a specified period. This can take some time in busy environments. Normally GL transactions are posted automatically each time a trial balance or profit and loss account is run'), ('155', 'Z_ReverseSuppPaymentRun.php', 'Utility to reverse an entire Supplier payment run'), ('156', 'Z_UpdateChartDetailsBFwd.php', 'Utility to recalculate the ChartDetails table B/Fwd balances - extreme care!!'), ('157', 'Z_UploadForm.php', 'Utility to upload a file to a remote server'), ('158', 'Z_UploadResult.php', 'Utility to upload a file to a remote server'), ('159', 'Z_index.php', 'Utility menu page'), ('160', 'index.php', 'The main menu from where all functions available to the user are accessed by clicking on the links'), ('161', 'phpinfo.php', 'Details about PHP installation on the server'), ('162', 'UserSettings.php', 'Allows the user to change system wide defaults for the theme - appearance, the number of records to show in searches and the language to display messages in'), ('163', 'StockQuantityByDate.php', 'Shows the stock on hand for each item at a selected location and stock category as at a specified date'), ('164', 'PDFOrderStatus.php', 'Reports on sales order status by date range, by stock location and stock category - producing a pdf showing each line items and any quantites delivered'), ('165', 'Tax.php', 'Creates a report of the ad-valoerm tax - GST/VAT - for the period selected from accounts payable and accounts receivable data'), ('166', 'PDFCustomerList.php', 'Creates a report of the customer and branch information held. This report has options to print only customer branches in a specified sales area and sales person. Additional option allows to list only those customers with activity either under or over a specified amount, since a specified date.');

-- ----------------------------
-- Table structure for `securitygroups`
-- ----------------------------
DROP TABLE IF EXISTS `securitygroups`;
CREATE TABLE `securitygroups` (
  `secroleid` int(11) NOT NULL default '0',
  `tokenid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`secroleid`,`tokenid`),
  KEY `secroleid` (`secroleid`),
  KEY `tokenid` (`tokenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of securitygroups
-- ----------------------------
INSERT INTO `securitygroups` VALUES ('1', '1'), ('1', '2'), ('2', '1'), ('2', '2'), ('2', '11'), ('3', '1'), ('3', '2'), ('3', '3'), ('3', '4'), ('3', '5'), ('3', '11'), ('4', '1'), ('4', '2'), ('4', '5'), ('5', '1'), ('5', '2'), ('5', '3'), ('5', '11'), ('6', '1'), ('6', '2'), ('6', '3'), ('6', '4'), ('6', '5'), ('6', '6'), ('6', '7'), ('6', '8'), ('6', '9'), ('6', '10'), ('6', '11'), ('7', '1'), ('8', '1'), ('8', '2'), ('8', '3'), ('8', '4'), ('8', '5'), ('8', '6'), ('8', '7'), ('8', '8'), ('8', '9'), ('8', '10'), ('8', '11'), ('8', '12'), ('8', '13'), ('8', '14'), ('8', '15'), ('9', '9');

-- ----------------------------
-- Table structure for `securityroles`
-- ----------------------------
DROP TABLE IF EXISTS `securityroles`;
CREATE TABLE `securityroles` (
  `secroleid` int(11) NOT NULL auto_increment,
  `secrolename` text NOT NULL,
  PRIMARY KEY  (`secroleid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of securityroles
-- ----------------------------
INSERT INTO `securityroles` VALUES ('1', 'Inquiries/Order Entry'), ('2', 'Manufac/Stock Admin'), ('3', 'Purchasing Officer'), ('4', 'AP Clerk'), ('5', 'AR Clerk'), ('6', 'Accountant'), ('7', 'Customer Log On Only'), ('8', 'System Administrator'), ('9', 'Supplier Log On Only');

-- ----------------------------
-- Table structure for `securitytokens`
-- ----------------------------
DROP TABLE IF EXISTS `securitytokens`;
CREATE TABLE `securitytokens` (
  `tokenid` int(11) NOT NULL default '0',
  `tokenname` text NOT NULL,
  PRIMARY KEY  (`tokenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of securitytokens
-- ----------------------------
INSERT INTO `securitytokens` VALUES ('1', 'Order Entry/Inquiries customer access only'), ('2', 'Basic Reports and Inquiries with selection options'), ('3', 'Credit notes and AR management'), ('4', 'Purchasing data/PO Entry/Reorder Levels'), ('5', 'Accounts Payable'), ('6', 'Petty Cash'), ('7', 'Bank Reconciliations'), ('8', 'General ledger reports/inquiries'), ('9', 'Supplier centre - Supplier access only'), ('10', 'General Ledger Maintenance, stock valuation & Configuration'), ('11', 'Inventory Management and Pricing'), ('12', 'Prices Security'), ('13', 'Unknown'), ('14', 'Unknown'), ('15', 'User Management and System Administration');

-- ----------------------------
-- Table structure for `shipmentcharges`
-- ----------------------------
DROP TABLE IF EXISTS `shipmentcharges`;
CREATE TABLE `shipmentcharges` (
  `shiptchgid` int(11) NOT NULL auto_increment,
  `shiptref` int(11) NOT NULL default '0',
  `transtype` smallint(6) NOT NULL default '0',
  `transno` int(11) NOT NULL default '0',
  `stockid` varchar(20) NOT NULL default '',
  `value` double NOT NULL default '0',
  PRIMARY KEY  (`shiptchgid`),
  KEY `TransType` (`transtype`,`transno`),
  KEY `ShiptRef` (`shiptref`),
  KEY `StockID` (`stockid`),
  KEY `TransType_2` (`transtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shipmentcharges
-- ----------------------------

-- ----------------------------
-- Table structure for `shipments`
-- ----------------------------
DROP TABLE IF EXISTS `shipments`;
CREATE TABLE `shipments` (
  `shiptref` int(11) NOT NULL default '0',
  `voyageref` varchar(20) NOT NULL default '0',
  `vessel` varchar(50) NOT NULL default '',
  `eta` datetime NOT NULL default '0000-00-00 00:00:00',
  `accumvalue` double NOT NULL default '0',
  `supplierid` varchar(10) NOT NULL default '',
  `closed` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`shiptref`),
  KEY `ETA` (`eta`),
  KEY `SupplierID` (`supplierid`),
  KEY `ShipperRef` (`voyageref`),
  KEY `Vessel` (`vessel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shipments
-- ----------------------------

-- ----------------------------
-- Table structure for `shippers`
-- ----------------------------
DROP TABLE IF EXISTS `shippers`;
CREATE TABLE `shippers` (
  `shipper_id` int(11) NOT NULL auto_increment,
  `shippername` char(40) NOT NULL default '',
  `mincharge` double NOT NULL default '0',
  PRIMARY KEY  (`shipper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shippers
-- ----------------------------
INSERT INTO `shippers` VALUES ('1', 'DHL', '0'), ('8', 'UPS', '0'), ('10', 'Not Specified', '0');

-- ----------------------------
-- Table structure for `stockcategory`
-- ----------------------------
DROP TABLE IF EXISTS `stockcategory`;
CREATE TABLE `stockcategory` (
  `categoryid` char(6) NOT NULL default '',
  `categorydescription` char(20) NOT NULL default '',
  `stocktype` char(1) NOT NULL default 'F',
  `stockact` int(11) NOT NULL default '0',
  `adjglact` int(11) NOT NULL default '0',
  `purchpricevaract` int(11) NOT NULL default '80000',
  `materialuseagevarac` int(11) NOT NULL default '80000',
  `wipact` int(11) NOT NULL default '0',
  PRIMARY KEY  (`categoryid`),
  KEY `CategoryDescription` (`categorydescription`),
  KEY `StockType` (`stocktype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stockcategory
-- ----------------------------
INSERT INTO `stockcategory` VALUES ('AIRCON', 'Air Conditioning', 'F', '1460', '5700', '5200', '5100', '1440'), ('BAKE', 'Baking Ingredients', 'F', '1460', '5700', '5200', '5000', '1440'), ('DVD', 'DVDs', 'F', '1460', '5700', '5000', '5200', '1440'), ('FOOD', 'Food', 'F', '1460', '5700', '5200', '5000', '1440'), ('PLANT', 'Plant and Equipment', 'A', '1650', '7750', '80000', '1', '1670');

-- ----------------------------
-- Table structure for `stockcatproperties`
-- ----------------------------
DROP TABLE IF EXISTS `stockcatproperties`;
CREATE TABLE `stockcatproperties` (
  `stkcatpropid` int(11) NOT NULL auto_increment,
  `categoryid` char(6) NOT NULL,
  `label` text NOT NULL,
  `controltype` tinyint(4) NOT NULL default '0',
  `defaultvalue` varchar(100) NOT NULL default '''''',
  `reqatsalesorder` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`stkcatpropid`),
  KEY `categoryid` (`categoryid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stockcatproperties
-- ----------------------------
INSERT INTO `stockcatproperties` VALUES ('1', 'AIRCON', 'kw heating', '0', '', '0'), ('2', 'AIRCON', 'kw cooling', '0', '', '0'), ('3', 'AIRCON', 'inverter', '2', '', '0'), ('4', 'DVD', 'Genre', '1', 'Action,Thriller,Comedy,Romance,Kids,Adult', '0'), ('5', 'PLANT', 'Depreciation Type', '1', 'Straight Line,Reducing Balance', '0'), ('6', 'PLANT', 'Annual Depreciation Percentage', '0', '5', '0');

-- ----------------------------
-- Table structure for `stockcheckfreeze`
-- ----------------------------
DROP TABLE IF EXISTS `stockcheckfreeze`;
CREATE TABLE `stockcheckfreeze` (
  `stockid` varchar(20) NOT NULL default '',
  `loccode` varchar(5) NOT NULL default '',
  `qoh` double NOT NULL default '0',
  `stockcheckdate` date NOT NULL,
  PRIMARY KEY  (`stockid`,`loccode`),
  KEY `LocCode` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stockcheckfreeze
-- ----------------------------

-- ----------------------------
-- Table structure for `stockcounts`
-- ----------------------------
DROP TABLE IF EXISTS `stockcounts`;
CREATE TABLE `stockcounts` (
  `id` int(11) NOT NULL auto_increment,
  `stockid` varchar(20) NOT NULL default '',
  `loccode` varchar(5) NOT NULL default '',
  `qtycounted` double NOT NULL default '0',
  `reference` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `StockID` (`stockid`),
  KEY `LocCode` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stockcounts
-- ----------------------------

-- ----------------------------
-- Table structure for `stockitemproperties`
-- ----------------------------
DROP TABLE IF EXISTS `stockitemproperties`;
CREATE TABLE `stockitemproperties` (
  `stockid` varchar(20) NOT NULL,
  `stkcatpropid` int(11) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY  (`stockid`,`stkcatpropid`),
  KEY `stockid` (`stockid`),
  KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stockitemproperties
-- ----------------------------
INSERT INTO `stockitemproperties` VALUES ('DVD-CASE', '4', 'Action'), ('DVD-DHWV', '4', 'Action');

-- ----------------------------
-- Table structure for `stockmaster`
-- ----------------------------
DROP TABLE IF EXISTS `stockmaster`;
CREATE TABLE `stockmaster` (
  `stockid` varchar(20) NOT NULL default '',
  `categoryid` varchar(6) NOT NULL default '',
  `description` varchar(50) NOT NULL default '',
  `longdescription` text NOT NULL,
  `units` varchar(20) NOT NULL default 'each',
  `mbflag` char(1) NOT NULL default 'B',
  `lastcurcostdate` date NOT NULL default '1800-01-01',
  `actualcost` decimal(20,4) NOT NULL default '0.0000',
  `lastcost` decimal(20,4) NOT NULL default '0.0000',
  `materialcost` decimal(20,4) NOT NULL default '0.0000',
  `labourcost` decimal(20,4) NOT NULL default '0.0000',
  `overheadcost` decimal(20,4) NOT NULL default '0.0000',
  `lowestlevel` smallint(6) NOT NULL default '0',
  `discontinued` tinyint(4) NOT NULL default '0',
  `controlled` tinyint(4) NOT NULL default '0',
  `eoq` double NOT NULL default '0',
  `volume` decimal(20,4) NOT NULL default '0.0000',
  `kgs` decimal(20,4) NOT NULL default '0.0000',
  `barcode` varchar(50) NOT NULL default '',
  `discountcategory` char(2) NOT NULL default '',
  `taxcatid` tinyint(4) NOT NULL default '1',
  `serialised` tinyint(4) NOT NULL default '0',
  `appendfile` varchar(40) NOT NULL default 'none',
  `perishable` tinyint(1) NOT NULL default '0',
  `decimalplaces` tinyint(4) NOT NULL default '0',
  `pansize` double NOT NULL default '0',
  `shrinkfactor` double NOT NULL default '0',
  `nextserialno` bigint(20) NOT NULL default '0',
  `netweight` decimal(20,4) NOT NULL default '0.0000',
  PRIMARY KEY  (`stockid`),
  KEY `CategoryID` (`categoryid`),
  KEY `Description` (`description`),
  KEY `LastCurCostDate` (`lastcurcostdate`),
  KEY `MBflag` (`mbflag`),
  KEY `StockID` (`stockid`,`categoryid`),
  KEY `Controlled` (`controlled`),
  KEY `DiscountCategory` (`discountcategory`),
  KEY `taxcatid` (`taxcatid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stockmaster
-- ----------------------------
INSERT INTO `stockmaster` VALUES ('BIGEARS12', 'DVD', 'Big Ears and Noddy episodes on DVD', 'Big Ears and Noddy episodes on DVD', 'each', 'M', '1800-01-01', '0.0000', '0.0000', '3490.0000', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '0.0000', '', '', '1', '0', 'none', '0', '0', '0', '0', '0', '0.0000'), ('BirthdayCakeConstruc', 'BAKE', '12 foot birthday cake for wrestling tournament', '12 foot birthday cake for wrestling tournament', 'each', 'M', '1800-01-01', '0.0000', '0.0000', '1145.4175', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '0.0000', '', '', '1', '0', 'none', '0', '0', '0', '0', '0', '0.0000'), ('BREAD', 'FOOD', 'Bread', 'Bread', 'each', 'M', '1800-01-01', '0.0000', '8.8785', '6.0085', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '0.0000', '', '', '1', '0', 'none', '0', '0', '0', '0', '0', '0.0000'), ('DR_TUMMY', 'FOOD', 'Gastric exquisite diarrhea', 'Gastric exquisite diarrhea', 'each', 'M', '1800-01-01', '0.0000', '0.0000', '116.2250', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '0.0000', '', '', '1', '0', 'none', '0', '0', '0', '0', '0', '0.0000'), ('DVD-CASE', 'DVD', 'webERP Demo DVD Case', 'webERP Demo DVD Case', 'each', 'B', '1800-01-01', '0.0000', '0.0000', '0.3000', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '0.0000', '', '', '1', '0', '0', '0', '0', '0', '0', '0', '0.0000'), ('DVD-DHWV', 'DVD', 'Die Hard With A Vengeance Linked', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa). &lt;br /&gt;Languages: English, Deutsch. &lt;br /&gt;Subtitles: English, Deutsch, Spanish. &lt;br /&gt;Audio: Dolby Surround 5.1. &lt;br /&gt;Picture Format: 16:9 Wide-Screen. &lt;br /&gt;Length: (approx) 122 minutes. &lt;br /&gt;Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'each', 'B', '1800-01-01', '0.0000', '5.5000', '2.3200', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '7.0000', '', '', '1', '0', '0', '0', '0', '0', '0', '0', '0.0000'), ('DVD-LTWP', 'AIRCON', 'Lethal Weapon Linked', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r\n<br />\r\nLanguages: English, Deutsch.\r\n<br />\r\nSubtitles: English, Deutsch, Spanish.\r\n<br />\r\nAudio: Dolby Surround 5.1.\r\n<br />\r\nPicture Format: 16:9 Wide-Screen.\r\n<br />\r\nLength: (approx) 100 minutes.\r\n<br />\r\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'each', 'B', '1800-01-01', '0.0000', '2.6600', '2.7000', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '7.0000', '', '', '1', '0', 'none', '0', '0', '0', '0', '0', '0.0000'), ('DVD-TOPGUN', 'DVD', 'Top Gun DVD', 'Top Gun DVD', 'each', 'B', '1800-01-01', '0.0000', '0.0000', '6.5000', '0.0000', '0.0000', '0', '0', '1', '0', '0.0000', '0.0000', '', '', '1', '0', 'none', '0', '0', '0', '0', '0', '0.0000'), ('DVD-UNSG', 'DVD', 'Under Siege Linked', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa). <br />Languages: English, Deutsch. <br />Subtitles: English, Deutsch, Spanish. <br />Audio: Dolby Surround 5.1. <br />Picture Format: 16:9 Wide-Screen. <br />Length: (approx) 98 minutes. <br />Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'each', 'B', '1800-01-01', '0.0000', '0.0000', '5.0000', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '7.0000', '', '', '1', '0', 'none', '0', '0', '0', '0', '0', '0.0000'), ('DVD-UNSG2', 'DVD', 'Under Siege 2 - Dark Territory', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 98 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'each', 'B', '1800-01-01', '0.0000', '0.0000', '5.0000', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '7.0000', '', '', '1', '0', 'none', '0', '0', '0', '0', '0', '0.0000'), ('DVD_ACTION', 'DVD', 'Action Series Bundle', 'Under Seige I and Under Seige II\r\n', 'each', 'M', '1800-01-01', '0.0000', '0.0000', '16.2200', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '0.0000', '', '', '1', '0', 'none', '0', '0', '0', '0', '0', '0.0000'), ('FLOUR', 'AIRCON', 'High Grade Flour', 'High Grade Flour', 'kgs', 'B', '1800-01-01', '0.0000', '0.0000', '3.8900', '0.0000', '0.0000', '0', '0', '1', '0', '0.0000', '0.0000', '', '', '1', '0', 'none', '0', '1', '0', '0', '0', '0.0000'), ('FUJI990101', 'AIRCON', 'Fujitsu 990101 Split type Indoor Unit 3.5kw', 'Fujitsu 990101 Split type Indoor Unit 3.5kw Heat Pump with mounting screws and isolating switch', 'each', 'B', '1800-01-01', '0.0000', '995.7138', '1015.6105', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '0.0000', '', '', '1', '0', 'none', '0', '4', '0', '0', '0', '0.0000'), ('FUJI990102', 'AIRCON', 'Fujitsu 990102 split type A/C Outdoor unit 3.5kw', 'Fujitsu 990102 split type A/C Outdoor unit 3.5kw with 5m piping & insulation', 'each', 'B', '1800-01-01', '0.0000', '0.0000', '633.0000', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '0.0000', '', '', '1', '0', 'none', '0', '0', '0', '0', '0', '0.0000'), ('FUJI9901ASS', 'AIRCON', 'Fujitsu 990101 Split type A/C 3.5kw complete', 'Fujitsu 990101 Split type A/C 3.5kw complete with indoor and outdoor units 5m pipe and insulation isolating switch. 5 year warranty', 'each', 'A', '1800-01-01', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '0.0000', '', '', '1', '0', 'none', '0', '0', '0', '0', '0', '0.0000'), ('HIT3042-4', 'AIRCON', 'Hitachi Aircond Rev Cycle Split Type 6.5kw Indoor', 'Hitachi Aircond Rev Cycle Split Type 6.5kw Indoor Unit - wall hung complete with brackets and screws. 220V-240V AC\r\n5 year guaranttee', 'each', 'M', '1800-01-01', '0.0000', '0.0000', '853.0000', '0.0000', '0.0000', '0', '0', '1', '5', '0.4000', '7.8000', '', '', '1', '1', 'none', '0', '0', '0', '0', '0', '0.0000'), ('HIT3043-5', 'AIRCON', 'Hitachi Aircond Rev Cycle Split Type 6.5kw Outdoor', 'Hitachi Aircond Rev Cycle Split Type 6.5kw Outdoor unit - including 5m piping for fitting to HIT3042-4 indoor unit\r\n5 year guaranttee', 'each', 'B', '1800-01-01', '0.0000', '0.0000', '1235.0000', '0.0000', '0.0000', '0', '0', '1', '5', '0.8500', '16.0000', '', '', '1', '1', 'none', '0', '0', '0', '0', '0', '0.0000'), ('SALT', 'BAKE', 'Salt', 'Salt', 'kgs', 'B', '1800-01-01', '0.0000', '1.2000', '2.5000', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '0.0000', '', '', '1', '0', 'none', '0', '3', '0', '0', '0', '0.0000'), ('SLICE', 'FOOD', 'Slice Of Bread', 'Slice Of Bread', 'each', 'M', '1800-01-01', '0.0000', '0.0000', '0.6009', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '0.0000', '', '', '1', '0', 'none', '0', '0', '0', '0', '0', '0.0000'), ('YEAST', 'BAKE', 'Yeast', 'Yeast', 'kgs', 'B', '1800-01-01', '0.0000', '3.8500', '5.0000', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '0.0000', '', '', '1', '0', '0', '0', '3', '0', '0', '0', '0.0000');

-- ----------------------------
-- Table structure for `stockmoves`
-- ----------------------------
DROP TABLE IF EXISTS `stockmoves`;
CREATE TABLE `stockmoves` (
  `stkmoveno` int(11) NOT NULL auto_increment,
  `stockid` varchar(20) NOT NULL default '',
  `type` smallint(6) NOT NULL default '0',
  `transno` int(11) NOT NULL default '0',
  `loccode` varchar(5) NOT NULL default '',
  `trandate` date NOT NULL default '0000-00-00',
  `debtorno` varchar(10) NOT NULL default '',
  `branchcode` varchar(10) NOT NULL default '',
  `price` decimal(20,4) NOT NULL default '0.0000',
  `prd` smallint(6) NOT NULL default '0',
  `reference` varchar(40) NOT NULL default '',
  `qty` double NOT NULL default '1',
  `discountpercent` double NOT NULL default '0',
  `standardcost` double NOT NULL default '0',
  `show_on_inv_crds` tinyint(4) NOT NULL default '1',
  `newqoh` double NOT NULL default '0',
  `hidemovt` tinyint(4) NOT NULL default '0',
  `narrative` text,
  PRIMARY KEY  (`stkmoveno`),
  KEY `DebtorNo` (`debtorno`),
  KEY `LocCode` (`loccode`),
  KEY `Prd` (`prd`),
  KEY `StockID_2` (`stockid`),
  KEY `TranDate` (`trandate`),
  KEY `TransNo` (`transno`),
  KEY `Type` (`type`),
  KEY `Show_On_Inv_Crds` (`show_on_inv_crds`),
  KEY `Hide` (`hidemovt`),
  KEY `reference` (`reference`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stockmoves
-- ----------------------------
INSERT INTO `stockmoves` VALUES ('2', 'DVD-DHWV', '28', '1', 'MEL', '2007-06-14', '', '', '5.2500', '2', '3', '-2', '0', '5.25', '1', '-2', '0', null), ('3', 'DVD-TOPGUN', '28', '2', 'MEL', '2007-06-18', '', '', '6.5000', '2', '3', '-1', '0', '6.5', '1', '-1', '0', null), ('4', 'DVD-DHWV', '28', '3', 'MEL', '2007-06-18', '', '', '0.0000', '2', '3', '-10', '0', '5.25', '1', '-12', '0', null), ('5', 'DVD-LTWP', '28', '3', 'MEL', '2007-06-18', '', '', '0.0000', '2', '3', '-10', '0', '2.85', '1', '-10', '0', null), ('6', 'DVD-UNSG', '28', '3', 'MEL', '2007-06-18', '', '', '0.0000', '2', '3', '-10', '0', '5', '1', '-10', '0', null), ('7', 'DVD-UNSG2', '28', '3', 'MEL', '2007-06-18', '', '', '0.0000', '2', '3', '-10', '0', '5', '1', '-10', '0', null), ('8', 'DVD_ACTION', '26', '2', 'MEL', '2007-06-18', '', '', '18.4000', '2', '3', '10', '0', '18.4', '1', '10', '0', null), ('9', 'FLOUR', '28', '4', 'MEL', '2007-06-21', '', '', '3.8900', '2', '5', '-4', '0', '3.89', '1', '-4', '0', null), ('10', 'DVD-DHWV', '10', '1', 'TOR', '2007-06-26', 'QUARTER', 'QUARTER', '15.9500', '2', '1', '-2', '0', '5.25', '1', '-2', '0', ''), ('11', 'DVD-LTWP', '10', '1', 'TOR', '2007-06-26', 'QUARTER', 'QUARTER', '14.5000', '2', '1', '-1', '0', '2.85', '1', '-1', '0', ''), ('12', 'DVD-DHWV', '11', '1', 'TOR', '2007-08-02', 'QUARTER', 'QUARTER', '15.9500', '3', 'Ex Inv - 1', '1', '0', '5.25', '1', '-1', '0', ''), ('13', 'SALT', '28', '5', 'MEL', '2008-06-27', '', '', '0.0000', '13', '5', '-0.3', '0', '2.5', '1', '-0.3', '0', null), ('14', 'DVD-LTWP', '25', '18', 'MEL', '2009-02-04', '', '', '2.9800', '21', 'CAMPBELL (Campbell Roberts Inc) - 1', '1', '0', '2.7', '1', '-9', '0', null), ('15', 'DVD-LTWP', '25', '19', 'MEL', '2009-02-05', '', '', '2.9800', '21', 'CAMPBELL (Campbell Roberts Inc) - 1', '1', '0', '2.7', '1', '-8', '0', null), ('16', 'DVD-LTWP', '25', '20', 'MEL', '2009-02-05', '', '', '2.9800', '21', 'CAMPBELL (Campbell Roberts Inc) - 1', '1', '0', '2.7', '1', '-7', '0', null), ('17', 'DVD-LTWP', '25', '21', 'MEL', '2009-02-05', '', '', '2.9800', '21', 'CAMPBELL (Campbell Roberts Inc) - 1', '1', '0', '2.7', '1', '-6', '0', null), ('18', 'DVD-LTWP', '25', '22', 'MEL', '2009-02-05', '', '', '2.9800', '21', 'CAMPBELL (Campbell Roberts Inc) - 1', '1', '0', '2.7', '1', '-5', '0', null), ('19', 'DVD-LTWP', '25', '23', 'MEL', '2009-02-05', '', '', '2.9800', '21', 'CAMPBELL (Campbell Roberts Inc) - 1', '1', '0', '2.7', '1', '-4', '0', null), ('20', 'DVD-LTWP', '25', '24', 'MEL', '2009-02-05', '', '', '2.9800', '21', 'CAMPBELL (Campbell Roberts Inc) - 1', '1', '0', '2.7', '1', '-3', '0', null), ('21', 'SALT', '25', '25', 'MEL', '2009-02-05', '', '', '100.0000', '21', 'GOTSTUFF (We Got the Stuff Inc) - 2', '1', '0', '2.5', '1', '0.7', '0', null), ('22', 'SALT', '25', '26', 'MEL', '2009-02-05', '', '', '100.0000', '21', 'GOTSTUFF (We Got the Stuff Inc) - 2', '1', '0', '2.5', '1', '1.7', '0', null), ('23', 'SALT', '25', '27', 'MEL', '2009-02-05', '', '', '100.0000', '21', 'GOTSTUFF (We Got the Stuff Inc) - 2', '1', '0', '2.5', '1', '2.7', '0', null), ('24', 'SALT', '25', '28', 'MEL', '2009-02-05', '', '', '100.0000', '21', 'GOTSTUFF (We Got the Stuff Inc) - 2', '1', '0', '2.5', '1', '3.7', '0', null), ('25', 'SALT', '25', '29', 'MEL', '2009-02-05', '', '', '100.0000', '21', 'GOTSTUFF (We Got the Stuff Inc) - 2', '1', '0', '2.5', '1', '4.7', '0', null), ('26', 'SALT', '25', '30', 'MEL', '2009-02-05', '', '', '100.0000', '21', 'GOTSTUFF (We Got the Stuff Inc) - 2', '1', '0', '2.5', '1', '5.7', '0', null), ('27', 'SALT', '25', '31', 'MEL', '2009-02-05', '', '', '100.0000', '21', 'GOTSTUFF (We Got the Stuff Inc) - 2', '1', '0', '2.5', '1', '6.7', '0', null), ('28', 'BREAD', '17', '17', 'MEL', '2009-02-05', '', '', '0.0000', '21', '', '100', '0', '0', '1', '100', '0', null), ('29', 'BREAD', '16', '13', 'MEL', '2009-02-06', '', '', '0.0000', '21', 'To Toronto', '-10', '0', '0', '1', '90', '0', null), ('30', 'BREAD', '16', '13', 'TOR', '2009-02-06', '', '', '0.0000', '21', 'From Melbourne', '10', '0', '0', '1', '10', '0', null), ('31', 'BREAD', '16', '18', 'MEL', '2009-02-06', '', '', '0.0000', '21', 'To Toronto', '-1', '0', '0', '1', '89', '0', null), ('32', 'BREAD', '16', '18', 'TOR', '2009-02-06', '', '', '0.0000', '21', 'From Melbourne', '1', '0', '0', '1', '11', '0', null), ('33', 'BREAD', '16', '19', 'MEL', '2009-02-06', '', '', '0.0000', '21', 'To Toronto', '-1', '0', '0', '1', '88', '0', null), ('34', 'BREAD', '16', '19', 'TOR', '2009-02-06', '', '', '0.0000', '21', 'From Melbourne', '1', '0', '0', '1', '12', '0', null), ('36', 'BREAD', '10', '4', 'MEL', '2010-05-31', 'ANGRY', 'ANGRY', '6.9000', '-11', '8', '-3', '0.1', '6.0085', '1', '85', '0', ''), ('37', 'SALT', '10', '4', 'MEL', '2010-05-31', 'ANGRY', 'ANGRY', '3.2500', '-11', '8', '-3', '0', '2.5', '1', '3.7', '0', ''), ('38', 'BREAD', '10', '5', 'MEL', '2010-05-31', 'ANGRY', 'ANGRY', '6.9000', '-11', '9', '-4', '0.15', '6.0085', '1', '81', '0', ''), ('39', 'SALT', '10', '5', 'MEL', '2010-05-31', 'ANGRY', 'ANGRY', '2.9900', '-11', '9', '-1', '0.015', '2.5', '1', '2.7', '0', ''), ('40', 'BREAD', '10', '6', 'MEL', '2010-05-31', 'ANGRY', 'ANGRY', '12.0000', '-11', '10', '-2', '0', '6.0085', '1', '79', '0', ''), ('41', 'BREAD', '10', '7', 'MEL', '2010-05-31', 'ANGRY', 'ANGRY', '0.0000', '-11', '11', '-5', '0', '6.0085', '1', '74', '0', ''), ('42', 'BREAD', '11', '2', 'MEL', '2010-05-31', 'ANGRY', 'ANGRY', '0.0000', '36', 'Ex Inv - 7', '5', '0', '6.0085', '1', '79', '0', ''), ('44', 'SALT', '10', '9', 'MEL', '2010-05-31', 'ANGRY', 'ANGRY', '25.0000', '-11', '13', '-2', '0', '2.5', '1', '0.7', '0', ''), ('45', 'BREAD', '10', '10', 'MEL', '2010-05-31', 'ANGRY', 'ANGRY', '5.2500', '-11', '14', '-2', '0', '6.0085', '1', '77', '0', ''), ('46', 'BREAD', '10', '11', 'MEL', '2010-05-31', 'ANGRY', 'ANGRY', '5.8824', '-11', '15', '-1', '0', '6.0085', '1', '76', '0', ''), ('47', 'BREAD', '10', '12', 'MEL', '2010-05-31', 'ANGRY', 'ANGRY', '5.8824', '-11', '16', '-1', '0', '6.0085', '1', '75', '0', ''), ('48', 'BREAD', '10', '13', 'MEL', '2010-05-31', 'ANGRY', 'ANGRY', '5.8824', '-11', '17', '-1', '0', '6.0085', '1', '74', '0', ''), ('49', 'BREAD', '10', '14', 'MEL', '2010-05-31', 'ANGRY', 'ANGRY', '11.1765', '-11', '18', '-12', '0', '6.0085', '1', '62', '0', ''), ('50', 'SALT', '10', '14', 'MEL', '2010-05-31', 'ANGRY', 'ANGRY', '5.8824', '-11', '18', '-0.7', '0', '2.5', '1', '0', '0', ''), ('51', 'BREAD', '28', '6', 'TOR', '2010-08-14', '', '', '6.0085', '0', '12', '-3.5', '0', '6.0085', '1', '8.5', '0', null), ('52', 'BREAD', '28', '7', 'TOR', '2010-08-15', '', '', '6.0085', '0', '12', '-2', '0', '6.0085', '1', '6.5', '0', null), ('53', 'DVD-CASE', '17', '18', 'TOR', '2010-08-15', '', '', '0.0000', '0', '', '180', '0', '0', '1', '180', '0', null), ('54', 'DVD-CASE', '28', '8', 'TOR', '2010-08-15', '', '', '0.3000', '0', '12', '-1', '0', '0.3', '1', '179', '0', null), ('55', 'YEAST', '17', '19', 'TOR', '2010-08-15', '', '', '0.0000', '0', '', '9.95', '0', '0', '1', '9.95', '0', null), ('56', 'YEAST', '28', '9', 'TOR', '2010-08-15', '', '', '5.0000', '0', '12', '-0.75', '0', '5', '1', '9.2', '0', null), ('57', 'SALT', '17', '20', 'TOR', '2010-08-15', '', '', '0.0000', '0', '', '25', '0', '0', '1', '25', '0', null), ('58', 'SALT', '28', '10', 'TOR', '2010-08-15', '', '', '2.5000', '0', '12', '-1.3', '0', '2.5', '1', '23.7', '0', null);

-- ----------------------------
-- Table structure for `stockmovestaxes`
-- ----------------------------
DROP TABLE IF EXISTS `stockmovestaxes`;
CREATE TABLE `stockmovestaxes` (
  `stkmoveno` int(11) NOT NULL default '0',
  `taxauthid` tinyint(4) NOT NULL default '0',
  `taxrate` double NOT NULL default '0',
  `taxontax` tinyint(4) NOT NULL default '0',
  `taxcalculationorder` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`stkmoveno`,`taxauthid`),
  KEY `taxauthid` (`taxauthid`),
  KEY `calculationorder` (`taxcalculationorder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stockmovestaxes
-- ----------------------------
INSERT INTO `stockmovestaxes` VALUES ('10', '13', '0', '0', '0'), ('11', '13', '0', '0', '0'), ('12', '13', '0', '0', '0'), ('36', '13', '0', '0', '0'), ('37', '13', '0', '0', '0'), ('38', '13', '0', '0', '0'), ('39', '13', '0', '0', '0'), ('40', '13', '0', '0', '0'), ('41', '13', '0', '0', '0'), ('42', '13', '0', '0', '0'), ('50', '13', '0', '0', '0');

-- ----------------------------
-- Table structure for `stockserialitems`
-- ----------------------------
DROP TABLE IF EXISTS `stockserialitems`;
CREATE TABLE `stockserialitems` (
  `stockid` varchar(20) NOT NULL default '',
  `loccode` varchar(5) NOT NULL default '',
  `serialno` varchar(30) NOT NULL default '',
  `expirationdate` datetime NOT NULL default '0000-00-00 00:00:00',
  `quantity` double NOT NULL default '0',
  `qualitytext` text NOT NULL,
  PRIMARY KEY  (`stockid`,`serialno`,`loccode`),
  KEY `StockID` (`stockid`),
  KEY `LocCode` (`loccode`),
  KEY `serialno` (`serialno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stockserialitems
-- ----------------------------
INSERT INTO `stockserialitems` VALUES ('DVD-TOPGUN', 'MEL', '23', '0000-00-00 00:00:00', '-1', ''), ('FLOUR', 'MEL', '5433', '0000-00-00 00:00:00', '-4', '');

-- ----------------------------
-- Table structure for `stockserialmoves`
-- ----------------------------
DROP TABLE IF EXISTS `stockserialmoves`;
CREATE TABLE `stockserialmoves` (
  `stkitmmoveno` int(11) NOT NULL auto_increment,
  `stockmoveno` int(11) NOT NULL default '0',
  `stockid` varchar(20) NOT NULL default '',
  `serialno` varchar(30) NOT NULL default '',
  `moveqty` double NOT NULL default '0',
  PRIMARY KEY  (`stkitmmoveno`),
  KEY `StockMoveNo` (`stockmoveno`),
  KEY `StockID_SN` (`stockid`,`serialno`),
  KEY `serialno` (`serialno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stockserialmoves
-- ----------------------------
INSERT INTO `stockserialmoves` VALUES ('1', '3', 'DVD-TOPGUN', '23', '1'), ('2', '9', 'FLOUR', '5433', '4');

-- ----------------------------
-- Table structure for `suppallocs`
-- ----------------------------
DROP TABLE IF EXISTS `suppallocs`;
CREATE TABLE `suppallocs` (
  `id` int(11) NOT NULL auto_increment,
  `amt` double NOT NULL default '0',
  `datealloc` date NOT NULL default '0000-00-00',
  `transid_allocfrom` int(11) NOT NULL default '0',
  `transid_allocto` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `TransID_AllocFrom` (`transid_allocfrom`),
  KEY `TransID_AllocTo` (`transid_allocto`),
  KEY `DateAlloc` (`datealloc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of suppallocs
-- ----------------------------

-- ----------------------------
-- Table structure for `suppliercontacts`
-- ----------------------------
DROP TABLE IF EXISTS `suppliercontacts`;
CREATE TABLE `suppliercontacts` (
  `supplierid` varchar(10) NOT NULL default '',
  `contact` varchar(30) NOT NULL default '',
  `position` varchar(30) NOT NULL default '',
  `tel` varchar(30) NOT NULL default '',
  `fax` varchar(30) NOT NULL default '',
  `mobile` varchar(30) NOT NULL default '',
  `email` varchar(55) NOT NULL default '',
  `ordercontact` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`supplierid`,`contact`),
  KEY `Contact` (`contact`),
  KEY `SupplierID` (`supplierid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of suppliercontacts
-- ----------------------------
INSERT INTO `suppliercontacts` VALUES ('CRUISE', 'Barry Toad', 'Slips', '92827', '0204389', '', '', '0');

-- ----------------------------
-- Table structure for `suppliers`
-- ----------------------------
DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers` (
  `supplierid` varchar(10) NOT NULL default '',
  `suppname` varchar(40) NOT NULL default '',
  `address1` varchar(40) NOT NULL default '',
  `address2` varchar(40) NOT NULL default '',
  `address3` varchar(40) NOT NULL default '',
  `address4` varchar(50) NOT NULL default '',
  `address5` varchar(20) NOT NULL default '',
  `address6` varchar(15) NOT NULL default '',
  `supptype` tinyint(4) NOT NULL default '1',
  `lat` float(10,6) NOT NULL default '0.000000',
  `lng` float(10,6) NOT NULL default '0.000000',
  `currcode` char(3) NOT NULL default '',
  `suppliersince` date NOT NULL default '0000-00-00',
  `paymentterms` char(2) NOT NULL default '',
  `lastpaid` double NOT NULL default '0',
  `lastpaiddate` datetime default NULL,
  `bankact` varchar(30) NOT NULL default '',
  `bankref` varchar(12) NOT NULL default '',
  `bankpartics` varchar(12) NOT NULL default '',
  `remittance` tinyint(4) NOT NULL default '1',
  `taxgroupid` tinyint(4) NOT NULL default '1',
  `factorcompanyid` int(11) NOT NULL default '1',
  `taxref` varchar(20) NOT NULL default '',
  `phn` varchar(50) NOT NULL default '',
  `port` varchar(200) NOT NULL default '',
  `email` varchar(55) default NULL,
  `fax` varchar(25) default NULL,
  `telephone` varchar(25) default NULL,
  PRIMARY KEY  (`supplierid`),
  KEY `CurrCode` (`currcode`),
  KEY `PaymentTerms` (`paymentterms`),
  KEY `SuppName` (`suppname`),
  KEY `taxgroupid` (`taxgroupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of suppliers
-- ----------------------------
INSERT INTO `suppliers` VALUES ('BINGO', 'Binary Green Ocean Inc', 'Box 3499', 'Gardenier', 'San Fransisco', 'California 54424', '', '', '1', '0.000000', '0.000000', 'USD', '2003-03-01', '30', '12', '2007-04-26 00:00:00', '', '0', '', '0', '1', '0', '', '', '', null, null, null), ('CAMPBELL', 'Campbell Roberts Inc', 'Box 9882', 'Ottowa Rise', '', '', '', '', '1', '0.000000', '0.000000', 'USD', '2005-06-23', '30', '0', null, '', '0', '', '0', '2', '0', '', '', '', null, null, null), ('CRUISE', 'Cruise Company Inc', 'Box 2001', 'Ft Lauderdale, Florida', '', '', '', '', '1', '0.000000', '0.000000', 'GBP', '2005-06-23', '30', '0', null, '123456789012345678901234567890', '0', '', '0', '3', '0', '', '', '', null, null, null), ('GOTSTUFF', 'We Got the Stuff Inc', 'Test line 1', 'Test line 2', 'Test line 3', 'Test line 4 - editing', '', '', '1', '0.000000', '0.000000', 'USD', '2005-10-29', '20', '0', null, '', 'ok then', 'tell me abou', '0', '1', '0', '', '', '', null, null, null), ('REGNEW', 'Reg Newall Inc', 'P O 5432', 'Wichita', 'Wyoming', '', '', '', '1', '0.000000', '0.000000', 'USD', '2005-04-30', '30', '0', null, '', '0', '', '0', '1', '0', '', '', '', null, null, null);

-- ----------------------------
-- Table structure for `suppliertype`
-- ----------------------------
DROP TABLE IF EXISTS `suppliertype`;
CREATE TABLE `suppliertype` (
  `typeid` tinyint(4) NOT NULL auto_increment,
  `typename` varchar(100) NOT NULL,
  PRIMARY KEY  (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of suppliertype
-- ----------------------------
INSERT INTO `suppliertype` VALUES ('1', 'Default');

-- ----------------------------
-- Table structure for `supptrans`
-- ----------------------------
DROP TABLE IF EXISTS `supptrans`;
CREATE TABLE `supptrans` (
  `transno` int(11) NOT NULL default '0',
  `type` smallint(6) NOT NULL default '0',
  `supplierno` varchar(10) NOT NULL default '',
  `suppreference` varchar(20) NOT NULL default '',
  `trandate` date NOT NULL default '0000-00-00',
  `duedate` date NOT NULL default '0000-00-00',
  `inputdate` datetime NOT NULL,
  `settled` tinyint(4) NOT NULL default '0',
  `rate` double NOT NULL default '1',
  `ovamount` double NOT NULL default '0',
  `ovgst` double NOT NULL default '0',
  `diffonexch` double NOT NULL default '0',
  `alloc` double NOT NULL default '0',
  `transtext` text,
  `hold` tinyint(4) NOT NULL default '0',
  `id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `TypeTransNo` (`transno`,`type`),
  KEY `DueDate` (`duedate`),
  KEY `Hold` (`hold`),
  KEY `SupplierNo` (`supplierno`),
  KEY `Settled` (`settled`),
  KEY `SupplierNo_2` (`supplierno`,`suppreference`),
  KEY `SuppReference` (`suppreference`),
  KEY `TranDate` (`trandate`),
  KEY `TransNo` (`transno`),
  KEY `Type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of supptrans
-- ----------------------------
INSERT INTO `supptrans` VALUES ('18', '20', 'CRUISE', 'assssa', '2010-08-13', '2010-09-30', '2010-08-14 05:56:12', '0', '0.8', '50', '0', '0', '0', '', '0', '1'), ('20', '20', 'CRUISE', '21221-DFR', '2010-08-13', '2010-09-30', '2010-08-14 06:48:55', '0', '0.8', '1255.25', '0', '0', '0', '', '0', '3'), ('21', '20', 'CRUISE', '9877', '2010-08-13', '2010-09-30', '2010-08-14 06:51:30', '0', '0.8', '10', '0', '0', '0', '', '0', '4'), ('22', '20', 'CRUISE', '9877-877', '2010-08-13', '2010-09-30', '2010-08-14 06:54:23', '0', '0.8', '100', '0', '0', '0', '', '0', '5'), ('5', '21', 'CRUISE', '30299', '2010-08-13', '2010-09-30', '2010-08-14 07:16:10', '0', '0.8', '-90', '0', '0', '0', '', '0', '6'), ('6', '21', 'CRUISE', '57748-OPP', '2010-08-13', '2010-09-30', '2010-08-14 07:35:46', '0', '0.8', '-100', '0', '0', '0', '', '0', '7'), ('7', '21', 'CRUISE', '9sjkja_099', '2010-08-13', '2010-09-30', '2010-08-14 07:39:38', '0', '0.8', '-104.41', '0', '0', '0', '', '0', '8');

-- ----------------------------
-- Table structure for `supptranstaxes`
-- ----------------------------
DROP TABLE IF EXISTS `supptranstaxes`;
CREATE TABLE `supptranstaxes` (
  `supptransid` int(11) NOT NULL default '0',
  `taxauthid` tinyint(4) NOT NULL default '0',
  `taxamount` double NOT NULL default '0',
  PRIMARY KEY  (`supptransid`,`taxauthid`),
  KEY `taxauthid` (`taxauthid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of supptranstaxes
-- ----------------------------
INSERT INTO `supptranstaxes` VALUES ('1', '13', '0'), ('3', '13', '0'), ('4', '13', '0'), ('5', '13', '0'), ('6', '13', '0'), ('7', '13', '0'), ('8', '13', '0');

-- ----------------------------
-- Table structure for `systypes`
-- ----------------------------
DROP TABLE IF EXISTS `systypes`;
CREATE TABLE `systypes` (
  `typeid` smallint(6) NOT NULL default '0',
  `typename` char(50) NOT NULL default '',
  `typeno` int(11) NOT NULL default '1',
  PRIMARY KEY  (`typeid`),
  KEY `TypeNo` (`typeno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of systypes
-- ----------------------------
INSERT INTO `systypes` VALUES ('0', 'Journal - GL', '2'), ('1', 'Payment - GL', '2'), ('2', 'Receipt - GL', '0'), ('3', 'Standing Journal', '0'), ('10', 'Sales Invoice', '14'), ('11', 'Credit Note', '2'), ('12', 'Receipt', '9'), ('15', 'Journal - Debtors', '0'), ('16', 'Location Transfer', '22'), ('17', 'Stock Adjustment', '20'), ('18', 'Purchase Order', '3'), ('19', 'Picking List', '0'), ('20', 'Purchase Invoice', '22'), ('21', 'Debit Note', '7'), ('22', 'Creditors Payment', '4'), ('23', 'Creditors Journal', '0'), ('25', 'Purchase Order Delivery', '31'), ('26', 'Work Order Receipt', '4'), ('28', 'Work Order Issue', '10'), ('29', 'Work Order Variance', '1'), ('30', 'Sales Order', '24'), ('31', 'Shipment Close', '26'), ('32', 'Contract Close', '6'), ('35', 'Cost Update', '17'), ('36', 'Exchange Difference', '1'), ('40', 'Work Order', '13'), ('50', 'Opening Balance', '0'), ('500', 'Auto Debtor Number', '0');

-- ----------------------------
-- Table structure for `tags`
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `tagref` tinyint(4) NOT NULL auto_increment,
  `tagdescription` varchar(50) NOT NULL,
  PRIMARY KEY  (`tagref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tags
-- ----------------------------

-- ----------------------------
-- Table structure for `taxauthorities`
-- ----------------------------
DROP TABLE IF EXISTS `taxauthorities`;
CREATE TABLE `taxauthorities` (
  `taxid` tinyint(4) NOT NULL auto_increment,
  `description` varchar(20) NOT NULL default '',
  `taxglcode` int(11) NOT NULL default '0',
  `purchtaxglaccount` int(11) NOT NULL default '0',
  `bank` varchar(50) NOT NULL default '',
  `bankacctype` varchar(20) NOT NULL default '',
  `bankacc` varchar(50) NOT NULL default '',
  `bankswift` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`taxid`),
  KEY `TaxGLCode` (`taxglcode`),
  KEY `PurchTaxGLAccount` (`purchtaxglaccount`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of taxauthorities
-- ----------------------------
INSERT INTO `taxauthorities` VALUES ('1', 'Australian GST', '2300', '2310', '', '', '', ''), ('5', 'Sales Tax', '2300', '2310', '', '', '', ''), ('11', 'Canadian GST', '2300', '2310', '', '', '', ''), ('12', 'Ontario PST', '2300', '2310', '', '', '', ''), ('13', 'UK VAT', '2300', '2310', '', '', '', '');

-- ----------------------------
-- Table structure for `taxauthrates`
-- ----------------------------
DROP TABLE IF EXISTS `taxauthrates`;
CREATE TABLE `taxauthrates` (
  `taxauthority` tinyint(4) NOT NULL default '1',
  `dispatchtaxprovince` tinyint(4) NOT NULL default '1',
  `taxcatid` tinyint(4) NOT NULL default '0',
  `taxrate` double NOT NULL default '0',
  PRIMARY KEY  (`taxauthority`,`dispatchtaxprovince`,`taxcatid`),
  KEY `TaxAuthority` (`taxauthority`),
  KEY `dispatchtaxprovince` (`dispatchtaxprovince`),
  KEY `taxcatid` (`taxcatid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of taxauthrates
-- ----------------------------
INSERT INTO `taxauthrates` VALUES ('1', '1', '1', '0.1'), ('1', '1', '2', '0'), ('1', '1', '5', '0'), ('5', '1', '1', '0.2'), ('5', '1', '2', '0.35'), ('5', '1', '5', '0'), ('11', '1', '1', '0.07'), ('11', '1', '2', '0.12'), ('11', '1', '5', '0'), ('12', '1', '1', '0.05'), ('12', '1', '2', '0.075'), ('12', '1', '5', '0'), ('13', '1', '1', '0'), ('13', '1', '2', '0'), ('13', '1', '5', '0');

-- ----------------------------
-- Table structure for `taxcategories`
-- ----------------------------
DROP TABLE IF EXISTS `taxcategories`;
CREATE TABLE `taxcategories` (
  `taxcatid` tinyint(4) NOT NULL auto_increment,
  `taxcatname` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`taxcatid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of taxcategories
-- ----------------------------
INSERT INTO `taxcategories` VALUES ('1', 'Taxable supply'), ('2', 'Luxury Items'), ('4', 'Exempt'), ('5', 'Freight');

-- ----------------------------
-- Table structure for `taxgroups`
-- ----------------------------
DROP TABLE IF EXISTS `taxgroups`;
CREATE TABLE `taxgroups` (
  `taxgroupid` tinyint(4) NOT NULL auto_increment,
  `taxgroupdescription` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`taxgroupid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of taxgroups
-- ----------------------------
INSERT INTO `taxgroups` VALUES ('1', 'Default tax group'), ('2', 'Ontario'), ('3', 'UK Inland Revenue');

-- ----------------------------
-- Table structure for `taxgrouptaxes`
-- ----------------------------
DROP TABLE IF EXISTS `taxgrouptaxes`;
CREATE TABLE `taxgrouptaxes` (
  `taxgroupid` tinyint(4) NOT NULL default '0',
  `taxauthid` tinyint(4) NOT NULL default '0',
  `calculationorder` tinyint(4) NOT NULL default '0',
  `taxontax` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`taxgroupid`,`taxauthid`),
  KEY `taxgroupid` (`taxgroupid`),
  KEY `taxauthid` (`taxauthid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of taxgrouptaxes
-- ----------------------------
INSERT INTO `taxgrouptaxes` VALUES ('1', '1', '0', '0'), ('1', '5', '1', '1'), ('2', '11', '0', '0'), ('2', '13', '0', '0'), ('3', '13', '0', '0');

-- ----------------------------
-- Table structure for `taxprovinces`
-- ----------------------------
DROP TABLE IF EXISTS `taxprovinces`;
CREATE TABLE `taxprovinces` (
  `taxprovinceid` tinyint(4) NOT NULL auto_increment,
  `taxprovincename` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`taxprovinceid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of taxprovinces
-- ----------------------------
INSERT INTO `taxprovinces` VALUES ('1', 'Default Tax province');

-- ----------------------------
-- Table structure for `unitsofmeasure`
-- ----------------------------
DROP TABLE IF EXISTS `unitsofmeasure`;
CREATE TABLE `unitsofmeasure` (
  `unitid` tinyint(4) NOT NULL auto_increment,
  `unitname` varchar(15) NOT NULL default '',
  PRIMARY KEY  (`unitid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of unitsofmeasure
-- ----------------------------
INSERT INTO `unitsofmeasure` VALUES ('1', 'each'), ('2', 'metres'), ('3', 'kgs'), ('4', 'litres'), ('5', 'length'), ('6', 'pack');

-- ----------------------------
-- Table structure for `woitems`
-- ----------------------------
DROP TABLE IF EXISTS `woitems`;
CREATE TABLE `woitems` (
  `wo` int(11) NOT NULL,
  `stockid` char(20) NOT NULL default '',
  `qtyreqd` double NOT NULL default '1',
  `qtyrecd` double NOT NULL default '0',
  `stdcost` double NOT NULL,
  `nextlotsnref` varchar(20) default '',
  PRIMARY KEY  (`wo`,`stockid`),
  KEY `stockid` (`stockid`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of woitems
-- ----------------------------
INSERT INTO `woitems` VALUES ('3', 'DVD_ACTION', '10', '10', '18.4', ''), ('4', 'SLICE', '100', '0', '0', ''), ('5', 'BREAD', '12', '0', '11.39', ''), ('12', 'BirthdayCakeConstruc', '1', '0', '1145.4175', ''), ('13', 'BIGEARS12', '1', '0', '3490', '');

-- ----------------------------
-- Table structure for `worequirements`
-- ----------------------------
DROP TABLE IF EXISTS `worequirements`;
CREATE TABLE `worequirements` (
  `wo` int(11) NOT NULL,
  `parentstockid` varchar(20) NOT NULL,
  `stockid` varchar(20) NOT NULL,
  `qtypu` double NOT NULL default '1',
  `stdcost` double NOT NULL default '0',
  `autoissue` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`wo`,`parentstockid`,`stockid`),
  KEY `stockid` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of worequirements
-- ----------------------------
INSERT INTO `worequirements` VALUES ('3', 'DVD_ACTION', 'DVD-CASE', '4', '0.3', '0'), ('3', 'DVD_ACTION', 'DVD-DHWV', '1', '5.25', '1'), ('3', 'DVD_ACTION', 'DVD-LTWP', '1', '2.85', '1'), ('3', 'DVD_ACTION', 'DVD-UNSG', '1', '5', '1'), ('3', 'DVD_ACTION', 'DVD-UNSG2', '1', '5', '1'), ('4', 'SLICE', 'BREAD', '0.1', '0', '1'), ('5', 'BREAD', 'FLOUR', '1.4', '3.89', '0'), ('5', 'BREAD', 'SALT', '0.025', '2.5', '1'), ('5', 'BREAD', 'YEAST', '0.1', '5', '0'), ('12', 'BirthdayCakeConstruc', 'BREAD', '1', '6.0085', '0'), ('12', 'BirthdayCakeConstruc', 'DVD-CASE', '1', '0.3', '0'), ('12', 'BirthdayCakeConstruc', 'FLOUR', '1', '3.89', '0'), ('12', 'BirthdayCakeConstruc', 'SALT', '1', '2.5', '0'), ('12', 'BirthdayCakeConstruc', 'YEAST', '1', '5', '0'), ('13', 'BIGEARS12', 'DVD-CASE', '1', '0.3', '0');

-- ----------------------------
-- Table structure for `workcentres`
-- ----------------------------
DROP TABLE IF EXISTS `workcentres`;
CREATE TABLE `workcentres` (
  `code` char(5) NOT NULL default '',
  `location` char(5) NOT NULL default '',
  `description` char(20) NOT NULL default '',
  `capacity` double NOT NULL default '1',
  `overheadperhour` decimal(10,0) NOT NULL default '0',
  `overheadrecoveryact` int(11) NOT NULL default '0',
  `setuphrs` decimal(10,0) NOT NULL default '0',
  PRIMARY KEY  (`code`),
  KEY `Description` (`description`),
  KEY `Location` (`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of workcentres
-- ----------------------------
INSERT INTO `workcentres` VALUES ('ASS', 'TOR', 'Assembly', '1', '50', '1', '0'), ('MEL', 'MEL', 'Default for MEL', '1', '0', '1', '0');

-- ----------------------------
-- Table structure for `workorders`
-- ----------------------------
DROP TABLE IF EXISTS `workorders`;
CREATE TABLE `workorders` (
  `wo` int(11) NOT NULL,
  `loccode` char(5) NOT NULL default '',
  `requiredby` date NOT NULL default '0000-00-00',
  `startdate` date NOT NULL default '0000-00-00',
  `costissued` double NOT NULL default '0',
  `closed` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`wo`),
  KEY `LocCode` (`loccode`),
  KEY `StartDate` (`startdate`),
  KEY `RequiredBy` (`requiredby`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of workorders
-- ----------------------------
INSERT INTO `workorders` VALUES ('3', 'MEL', '2007-06-13', '2007-06-13', '198', '1'), ('4', 'MEL', '2007-06-21', '2007-06-21', '0', '0'), ('5', 'MEL', '2007-06-21', '2007-06-21', '16.31', '0'), ('6', 'MEL', '2007-07-15', '2007-07-15', '0', '0'), ('7', 'MEL', '2008-07-26', '2008-07-26', '0', '0'), ('8', 'MEL', '2008-07-26', '2008-07-26', '0', '0'), ('9', 'MEL', '2009-02-04', '2009-02-04', '0', '0'), ('12', 'TOR', '2010-12-20', '2010-08-14', '40.34675', '1'), ('13', 'TOR', '2010-10-15', '2010-08-14', '0', '0');

-- ----------------------------
-- Table structure for `woserialnos`
-- ----------------------------
DROP TABLE IF EXISTS `woserialnos`;
CREATE TABLE `woserialnos` (
  `wo` int(11) NOT NULL,
  `stockid` varchar(20) NOT NULL,
  `serialno` varchar(30) NOT NULL,
  `quantity` double NOT NULL default '1',
  `qualitytext` text NOT NULL,
  PRIMARY KEY  (`wo`,`stockid`,`serialno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of woserialnos
-- ----------------------------

-- ----------------------------
-- Table structure for `www_users`
-- ----------------------------
DROP TABLE IF EXISTS `www_users`;
CREATE TABLE `www_users` (
  `userid` varchar(20) NOT NULL default '',
  `password` text NOT NULL,
  `realname` varchar(35) NOT NULL default '',
  `customerid` varchar(10) NOT NULL default '',
  `supplierid` varchar(10) NOT NULL default '',
  `salesman` char(3) NOT NULL,
  `phone` varchar(30) NOT NULL default '',
  `email` varchar(55) default NULL,
  `defaultlocation` varchar(5) NOT NULL default '',
  `fullaccess` int(11) NOT NULL default '1',
  `lastvisitdate` datetime default NULL,
  `branchcode` varchar(10) NOT NULL default '',
  `pagesize` varchar(20) NOT NULL default 'A4',
  `modulesallowed` varchar(40) NOT NULL default '',
  `blocked` tinyint(4) NOT NULL default '0',
  `displayrecordsmax` int(11) NOT NULL default '0',
  `theme` varchar(30) NOT NULL default 'fresh',
  `language` varchar(10) NOT NULL default 'en_GB.utf8',
  `pdflanguage` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`userid`),
  KEY `CustomerID` (`customerid`),
  KEY `DefaultLocation` (`defaultlocation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of www_users
-- ----------------------------
INSERT INTO `www_users` VALUES ('admin', '006934b98d2d831da9ec4311e881b5ddea557cac', 'Elly Makuba', '', '', '', '', 'ellymakuba@gmail.com', 'MEL', '8', '2011-06-18 16:41:59', '', 'A4', '1,1,1,1,1,1,1,1,1,1,', '0', '50', 'professional', 'en_US.utf8', '0');
