DROP TABLE IF EXISTS academic_year_remarks;

CREATE TABLE `academic_year_remarks` (
  `id` int(11) NOT NULL auto_increment,
  `student_id` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL,
  `academic_year_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO academic_year_remarks VALUES


DROP TABLE IF EXISTS accountgroups;

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

INSERT INTO accountgroups VALUES("BBQs","5","1","6000","Promotions"),("Current Assets","20","0","1000",""),("Equity","50","0","3000",""),("Fixed Assets","10","0","500",""),("Giveaways","5","1","6000","Promotions"),("Income Tax","5","1","9000",""),("Invoices","1","1","10",""),("Liabilities","30","0","2000",""),("Marketing Expenses","5","1","6000",""),("Operating Expenses","5","1","7000",""),("Other Revenue and Expenses","5","1","8000",""),("Promotions","5","1","6000","Marketing Expenses"),("Revenue","1","1","4000","");



DROP TABLE IF EXISTS accountsection;

CREATE TABLE `accountsection` (
  `sectionid` int(11) NOT NULL default '0',
  `sectionname` text NOT NULL,
  PRIMARY KEY  (`sectionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO accountsection VALUES("1","Income"),("5","Overheads"),("10","Fixed Assets"),("20","Amounts Receivable"),("30","Amounts Payable"),("50","Financed By");



DROP TABLE IF EXISTS annual_ranks;

CREATE TABLE `annual_ranks` (
  `id` int(11) NOT NULL auto_increment,
  `class_id` int(11) NOT NULL,
  `academic_year_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `total` decimal(10,0) NOT NULL,
  `rank` int(11) NOT NULL,
  `rolled` int(1) NOT NULL,
  `unrolled` int(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO annual_ranks VALUES


DROP TABLE IF EXISTS areas;

CREATE TABLE `areas` (
  `areacode` char(3) NOT NULL,
  `areadescription` varchar(25) NOT NULL default '',
  PRIMARY KEY  (`areacode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO areas VALUES("DE","Default");



DROP TABLE IF EXISTS assetmanager;

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

INSERT INTO assetmanager VALUES


DROP TABLE IF EXISTS audittrail;

CREATE TABLE `audittrail` (
  `transactiondate` datetime NOT NULL default '0000-00-00 00:00:00',
  `userid` varchar(20) NOT NULL default '',
  `querystring` text,
  KEY `UserID` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO audittrail VALUES("2012-09-03 10:29:52","admin","UPDATE config
