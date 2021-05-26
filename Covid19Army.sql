-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `ActivityLog`;



-- ************************************** `ActivityLog`

CREATE TABLE IF NOT EXISTS `ActivityLog`
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

DROP TABLE IF EXISTS `ActivityType`;



-- ************************************** `ActivityType`

CREATE TABLE IF NOT EXISTS `ActivityType`
(
 `activitytypeid` int NOT NULL ,
 `name`           varchar(64) NOT NULL ,
 `activitytext`   varchar(256) NOT NULL ,

PRIMARY KEY (`activitytypeid`),
UNIQUE KEY `uq_activity_name` (`name`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `EntityTypes`;
 


-- ************************************** `EntityTypes`

CREATE TABLE IF NOT EXISTS `EntityTypes`
(
 `entitytypeid` int NOT NULL ,
 `name`         varchar(64) NOT NULL ,

PRIMARY KEY (`entitytypeid`),
UNIQUE KEY `uq_entitytype_name` (`name`)
);

DROP TABLE IF EXISTS `Users`;



-- ************************************** `users`

CREATE TABLE IF NOT EXISTS `Users`
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

DROP TABLE IF EXISTS `Volunteers`;



-- ************************************** `Volunteers`

CREATE TABLE IF NOT EXISTS `Volunteers`
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

DROP TABLE IF EXISTS `HelpRequests`;



-- ************************************** `HelpRequests`

CREATE TABLE IF NOT EXISTS `HelpRequests`
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

DROP TABLE IF EXISTS `Messages`;



-- ************************************** `Messages`

CREATE TABLE IF NOT EXISTS `Messages`
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
CONSTRAINT `FK_121` FOREIGN KEY `fkIdx_122` (`volunteerid`) REFERENCES `Volunteers` (`volunteerid`),
KEY `fkIdx_45` (`from_userid`),
CONSTRAINT `FK_44` FOREIGN KEY `fkIdx_45` (`from_userid`) REFERENCES `users` (`userid`),
KEY `fkIdx_48` (`to_userid`),
CONSTRAINT `FK_47` FOREIGN KEY `fkIdx_48` (`to_userid`) REFERENCES `users` (`userid`),
KEY `fkIdx_51` (`requestid`),
CONSTRAINT `FK_50` FOREIGN KEY `fkIdx_51` (`requestid`) REFERENCES `HelpRequests` (`requestid`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `Needs`;



-- ************************************** `needs`

CREATE TABLE IF NOT EXISTS `Needs`
(
 `needid` int NOT NULL ,
 `name`   varchar(256) NOT NULL ,

PRIMARY KEY (`needid`),
UNIQUE KEY `uq_needs_name` (`name`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `RequestActions`;



-- ************************************** `RequestActions`

CREATE TABLE IF NOT EXISTS `RequestActions`
(
 `requestionactionid` bigint unsigned NOT NULL AUTO_INCREMENT ,
 `requestid`          bigint unsigned NOT NULL ,
 `userid`             bigint unsigned NOT NULL ,
 `volunteerid`        bigint unsigned NOT NULL ,
 `action`             varchar(2048) NOT NULL ,
 `date_created`       datetime NOT NULL ,

PRIMARY KEY (`requestionactionid`),
KEY `fkIdx_119` (`volunteerid`),
CONSTRAINT `FK_118` FOREIGN KEY `fkIdx_119` (`volunteerid`) REFERENCES `Volunteers` (`volunteerid`),
KEY `fkIdx_60` (`requestid`),
CONSTRAINT `FK_59` FOREIGN KEY `fkIdx_60` (`requestid`) REFERENCES `HelpRequests` (`requestid`),
KEY `fkIdx_65` (`userid`),
CONSTRAINT `FK_64` FOREIGN KEY `fkIdx_65` (`userid`) REFERENCES `users` (`userid`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `RequestNeeds`;



-- ************************************** `RequestNeeds`

CREATE TABLE IF NOT EXISTS `RequestNeeds`
(
 `requestneedid` bigint unsigned NOT NULL AUTO_INCREMENT ,
 `requestid`     bigint unsigned NOT NULL ,
 `needid`        int NOT NULL ,

PRIMARY KEY (`requestneedid`),
KEY `fkIdx_46` (`requestid`),
CONSTRAINT `FK_45` FOREIGN KEY `fkIdx_46` (`requestid`) REFERENCES `HelpRequests` (`requestid`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `RequestVolunteer`;



-- ************************************** `RequestVolunteer`

CREATE TABLE IF NOT EXISTS `RequestVolunteer`
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
CONSTRAINT `FK_107` FOREIGN KEY `fkIdx_108` (`requestid`) REFERENCES `HelpRequests` (`requestid`),
KEY `fkIdx_112` (`volunteerid`),
CONSTRAINT `FK_111` FOREIGN KEY `fkIdx_112` (`volunteerid`) REFERENCES `Volunteers` (`volunteerid`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;



DROP TABLE IF EXISTS `VolunteerAreas`;



-- ************************************** `VolunteerAreas`

CREATE TABLE IF NOT EXISTS `VolunteerAreas`
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
CONSTRAINT `FK_84` FOREIGN KEY `fkIdx_85` (`volunteerid`) REFERENCES `Volunteers` (`volunteerid`)
);
-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `VolunteerProvidedNeeds`;



-- ************************************** `VolunteerProvidedNeeds`

CREATE TABLE IF NOT EXISTS `VolunteerProvidedNeeds`
(
 `volunterprovidedneedid` bigint unsigned NOT NULL AUTO_INCREMENT ,
 `volunteerid`            bigint unsigned NOT NULL ,
 `needid`                 int NOT NULL ,

PRIMARY KEY (`volunterprovidedneedid`),
KEY `fkIdx_100` (`volunteerid`),
CONSTRAINT `FK_99` FOREIGN KEY `fkIdx_100` (`volunteerid`) REFERENCES `Volunteers` (`volunteerid`)
);



-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `MobileVerificationQueue`;



-- ************************************** `MobileVerificationQueue`

CREATE TABLE IF NOT EXISTS `MobileVerificationQueue`
(
 `itemid`       bigint unsigned NOT NULL AUTO_INCREMENT ,
 `mobilenumber` varchar(16) NOT NULL ,
 `otp`          int NOT NULL ,
 `date_created` datetime NOT NULL ,
 `date_expiry`  datetime NOT NULL ,
 `entityid`     bigint NOT NULL ,
 `entitytype`   varchar(8) NOT NULL ,

PRIMARY KEY (`itemid`),
UNIQUE KEY `uq_mobilequeue_mobile_otp` (`mobilenumber`, `otp`)
);

-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

DROP TABLE IF EXISTS `NewRequestWaitingQueue`;



-- ************************************** `NewRequestWaitingQueue`

CREATE TABLE IF NOT EXISTS `NewRequestWaitingQueue`
(
 `itemid`      bigint unsigned NOT NULL AUTO_INCREMENT ,
 `requestid`   bigint NOT NULL ,
 `volunteerid` bigint NOT NULL ,
 `date_created` datetime not null,

PRIMARY KEY (`itemid`)
);

