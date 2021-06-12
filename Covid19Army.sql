-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;
-- SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS; 
-- SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `activitylog`;



-- ************************************** `ActivityLog`

CREATE TABLE IF NOT EXISTS `activitylog`
(
 `activitylogid`  bigint unsigned NOT NULL AUTO_INCREMENT ,
 `from_userid`    bigint NOT NULL ,
 `to_userid`      bigint NOT NULL ,
 `activitytypeid` int NOT NULL ,
 `entitytype`     varchar(8) NOT NULL ,
 `entityid`       bigint NOT NULL ,
 `date_created`   datetime NOT NULL ,
 `clientip`		  varchar(32) NOT NULL,

PRIMARY KEY (`activitylogid`)
);

-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `activitytype`;



-- ************************************** `ActivityType`

CREATE TABLE IF NOT EXISTS `activitytype`
(
 `activitytypeid` int NOT NULL ,
 `name`           varchar(64) NOT NULL ,
 `activitytext`   varchar(256) NOT NULL ,

PRIMARY KEY (`activitytypeid`),
UNIQUE KEY `uq_activity_name` (`name`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `entitytypes`;
 


-- ************************************** `EntityTypes`

CREATE TABLE IF NOT EXISTS `entitytypes`
(
 `entitytypeid` int NOT NULL ,
 `name`         varchar(64) NOT NULL ,

PRIMARY KEY (`entitytypeid`),
UNIQUE KEY `uq_entitytype_name` (`name`)
);

DROP TABLE IF EXISTS `users`;



-- ************************************** `users`

CREATE TABLE IF NOT EXISTS `users`
(
 `userid`                      bigint unsigned NOT NULL AUTO_INCREMENT ,
 `mobilenumber`                varchar(16) NOT NULL ,
 `name`                        varchar(256) NULL ,
 `ismobileverified`            bit NOT NULL ,
 `date_created`                datetime NOT NULL ,
 `date_lastlogin`              datetime NULL ,
 `isactive`                    bit NOT NULL ,
 `countrycode`                 int NOT NULL ,
 `isvolunteer`                 bit NOT NULL ,
 `date_notification_last_seen` datetime NOT NULL ,
 `clientip`			 		   varchar(32) NOT NULL,

PRIMARY KEY (`userid`),
UNIQUE KEY `uq_users_mobilenumber` (`mobilenumber`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `volunteers`;



-- ************************************** `Volunteers`

CREATE TABLE IF NOT EXISTS `volunteers`
(
 `volunteerid`       bigint unsigned NOT NULL AUTO_INCREMENT ,
 `userid`            bigint unsigned NOT NULL ,
 `type`              int NOT NULL ,
 `name`              varchar(256) NOT NULL ,
 `contactname`       varchar(256) NOT NULL ,
 `contactnumber`     varchar(16) NOT NULL ,
 `countrycode`       int NOT NULL ,
 `iscontactverified` bit NOT NULL ,
 `state`             varchar(256) NOT NULL ,
 `district`          varchar(256) NOT NULL ,
 `pincode`           varchar(256) NOT NULL ,
 `date_created`      datetime NOT NULL ,
 `isdelete`          bit NOT NULL ,
 `isactive`          bit NOT NULL ,
 `date_updated`      datetime NOT NULL , 

PRIMARY KEY (`volunteerid`),
KEY `fkIdx_81` (`userid`),
CONSTRAINT `FK_80` FOREIGN KEY `fkIdx_81` (`userid`) REFERENCES `users` (`userid`)
);


-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `helprequests`;



-- ************************************** `HelpRequests`

CREATE TABLE IF NOT EXISTS `helprequests`
(
 `requestid`               bigint unsigned NOT NULL AUTO_INCREMENT ,
 `userid`                  bigint unsigned NOT NULL ,
 `recipientname`             varchar(256) NOT NULL ,
 `iscovidpositive`         bit NOT NULL ,
 `srfid`                   bigint NULL ,
 `age`                     int NOT NULL ,
 `state`                   varchar(256) NOT NULL ,
 `district`                varchar(256) NOT NULL ,
 `pincode`                 varchar(45) NOT NULL ,
 `contactnumber`           varchar(16) NOT NULL ,
 `countrycode`             int NOT NULL ,
 `pre_existing_conditions` varchar(1024) NULL ,
 `comments`                varchar(1024) NULL ,
 `date_created`            datetime NOT NULL ,
 `status`                  int NOT NULL ,
 `isdeleted`               bit NOT NULL ,
 `iscontactverified`       bit NOT NULL ,

PRIMARY KEY (`requestid`),
KEY `fkIdx_16` (`userid`),
CONSTRAINT `FK_15` FOREIGN KEY `fkIdx_16` (`userid`) REFERENCES `users` (`userid`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `messages`;



-- ************************************** `Messages`

CREATE TABLE IF NOT EXISTS `messages`
(
 `messageid`    bigint unsigned NOT NULL AUTO_INCREMENT ,
 `from_userid`  bigint unsigned NOT NULL ,
 `to_userid`    bigint unsigned NOT NULL ,
 `requestid`    bigint unsigned NULL ,
 `volunteerid`  bigint unsigned NULL ,
 `message`      varchar(2048) NOT NULL ,
 `date_created` datetime NOT NULL ,

PRIMARY KEY (`messageid`),
KEY `fkIdx_122` (`volunteerid`),
CONSTRAINT `FK_121` FOREIGN KEY `fkIdx_122` (`volunteerid`) REFERENCES `volunteers` (`volunteerid`),
KEY `fkIdx_45` (`from_userid`),
CONSTRAINT `FK_44` FOREIGN KEY `fkIdx_45` (`from_userid`) REFERENCES `users` (`userid`),
KEY `fkIdx_48` (`to_userid`),
CONSTRAINT `FK_47` FOREIGN KEY `fkIdx_48` (`to_userid`) REFERENCES `users` (`userid`),
KEY `fkIdx_51` (`requestid`),
CONSTRAINT `FK_50` FOREIGN KEY `fkIdx_51` (`requestid`) REFERENCES `helprequests` (`requestid`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `needs`;



-- ************************************** `needs`

CREATE TABLE IF NOT EXISTS `needs`
(
 `needid` int NOT NULL ,
 `name`   varchar(256) NOT NULL ,

PRIMARY KEY (`needid`),
UNIQUE KEY `uq_needs_name` (`name`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `requestactions`;



-- ************************************** `requestactions`

CREATE TABLE IF NOT EXISTS `requestactions`
(
 `requestionactionid` bigint unsigned NOT NULL AUTO_INCREMENT ,
 `requestid`          bigint unsigned NOT NULL ,
 `userid`             bigint unsigned NOT NULL ,
 `volunteerid`        bigint unsigned NOT NULL ,
 `action`             varchar(2048) NOT NULL ,
 `date_created`       datetime NOT NULL ,

PRIMARY KEY (`requestionactionid`),
KEY `fkIdx_119` (`volunteerid`),
CONSTRAINT `FK_118` FOREIGN KEY `fkIdx_119` (`volunteerid`) REFERENCES `volunteers` (`volunteerid`),
KEY `fkIdx_60` (`requestid`),
CONSTRAINT `FK_59` FOREIGN KEY `fkIdx_60` (`requestid`) REFERENCES `helprequests` (`requestid`),
KEY `fkIdx_65` (`userid`),
CONSTRAINT `FK_64` FOREIGN KEY `fkIdx_65` (`userid`) REFERENCES `users` (`userid`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `requestneeds`;



-- ************************************** `requestneeds`

CREATE TABLE IF NOT EXISTS `requestneeds`
(
 `requestneedid` bigint unsigned NOT NULL AUTO_INCREMENT ,
 `requestid`     bigint unsigned NOT NULL ,
 `needid`        int NOT NULL ,

PRIMARY KEY (`requestneedid`),
KEY `fkIdx_46` (`requestid`),
CONSTRAINT `FK_45` FOREIGN KEY `fkIdx_46` (`requestid`) REFERENCES `helprequests` (`requestid`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `requestvolunteer`;



-- ************************************** `requestvolunteer`

CREATE TABLE IF NOT EXISTS `requestvolunteer`
(
 `requestvolunteerid`                  bigint unsigned NOT NULL AUTO_INCREMENT ,
 `requestid`                           bigint unsigned NOT NULL ,
 `volunteerid`                         bigint unsigned NOT NULL ,
 `isactive`                            bit NOT NULL ,
 `date_created`                        datetime NOT NULL ,
 `isrejected`                          bit NOT NULL ,
 `rejectreason`                        varchar(512) NOT NULL ,
 `date_message_last_seen_by_volunteer` datetime NOT NULL ,

PRIMARY KEY (`requestvolunteerid`),
KEY `fkIdx_108` (`requestid`),
CONSTRAINT `FK_107` FOREIGN KEY `fkIdx_108` (`requestid`) REFERENCES `helprequests` (`requestid`),
KEY `fkIdx_112` (`volunteerid`),
CONSTRAINT `FK_111` FOREIGN KEY `fkIdx_112` (`volunteerid`) REFERENCES `volunteers` (`volunteerid`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;



DROP TABLE IF EXISTS `volunteerareas`;



-- ************************************** `volunteerareas`

CREATE TABLE IF NOT EXISTS `volunteerareas`
(
 `volunteerareaid`       bigint unsigned NOT NULL AUTO_INCREMENT ,
 `volunteerid`           bigint unsigned NOT NULL ,
 `state`                 varchar(256) NOT NULL ,
 `district`              varchar(256) NOT NULL ,
 `availability_pincodes` varchar(2048) NOT NULL ,
 `date_created`          datetime NOT NULL ,
 `date_updated`          datetime NOT NULL ,

PRIMARY KEY (`volunteerareaid`),
KEY `fkIdx_85` (`volunteerid`),
CONSTRAINT `FK_84` FOREIGN KEY `fkIdx_85` (`volunteerid`) REFERENCES `volunteers` (`volunteerid`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `volunteerprovidedneeds`;



-- ************************************** `volunteerprovidedneeds`

CREATE TABLE IF NOT EXISTS `volunteerprovidedneeds`
(
 `volunterprovidedneedid` bigint unsigned NOT NULL AUTO_INCREMENT ,
 `volunteerid`            bigint unsigned NOT NULL ,
 `needid`                 int NOT NULL ,

PRIMARY KEY (`volunterprovidedneedid`),
KEY `fkIdx_100` (`volunteerid`),
CONSTRAINT `FK_99` FOREIGN KEY `fkIdx_100` (`volunteerid`) REFERENCES `volunteers` (`volunteerid`)
);



-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `mobileverificationqueue`;



-- ************************************** `mobileverificationqueue`

CREATE TABLE IF NOT EXISTS `mobileverificationqueue`
(
 `itemid`       bigint unsigned NOT NULL AUTO_INCREMENT ,
 `mobilenumber` varchar(16) NOT NULL ,
 `otp`          int NOT NULL ,
 `date_created` datetime NOT NULL ,
 `date_expiry`  datetime NOT NULL ,
 `entityid`     bigint NOT NULL ,
 `entitytype`   varchar(8) NOT NULL ,
 `isprocessed`  bit not null,

PRIMARY KEY (`itemid`),
UNIQUE KEY `uq_mobilequeue_mobile_otp` (`mobilenumber`, `otp`)
);

-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `newrequestwaitingqueue`;



-- ************************************** `newrequestwaitingqueue`

CREATE TABLE IF NOT EXISTS `newrequestwaitingqueue`
(
 `itemid`      bigint unsigned NOT NULL AUTO_INCREMENT ,
 `requestid`   bigint NOT NULL ,
 `volunteerid` bigint NOT NULL ,
 `date_created` datetime not null,

PRIMARY KEY (`itemid`)
);
DROP TABLE IF EXISTS `PROPERTIES`;

create table PROPERTIES 
(
id integer not null auto_increment,
 CREATED_ON datetime ,
 APPLICATION varchar(255), 
 PROFILE varchar(255), 
 LABEL varchar(255),
 PROP_KEY varchar(255), 
 VALUE varchar(255), 
 primary key (id));

-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;