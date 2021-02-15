--
-- Build user tables
--

--
-- NOTES
-- WASNT SURE WHETHER TO ADD AUTO INCREMENT TO PublicID/MemberID
-- BUT LOOKED AT CT4009 OO2 WORK AND THAT WASNT IMPLEMENTED
-- IT WAS DONE IN THE PHP FILE. IF THAT MAKES SENSE
--
-- DB FOR ROLES NEEDS SOME WORK ON. IT IS LINKED TO THE REPORT DB IN ERD
-- SHOULD THIS BE CONNECTED TO COUNCIL MEMBERS INSTEAD?
--


DROP TABLE IF EXISTS `tbl_Roles`;
DROP TABLE IF EXISTS `tbl_public`;
DROP  TABLE IF EXISTS `tbl_councilMember`;

CREATE TABLE `tbl_public` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `email` varchar(254) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `dob` DATE NOT NULL,
  `reportCount` int(11),
  `authenticated` tinyint(1),
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `verificationCode` varchar(16)
) ENGINE=InnoDB;



CREATE TABLE `tbl_councilMember` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `email` varchar(254) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `dob` DATE NOT NULL,
  `RoleID` int NOT NULL,
  `authenticated` tinyint(1),
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `verificationCode` varchar(16)
) ENGINE=InnoDB;


CREATE TABLE `tbl_Roles` (
  `id` int NOT NULL PRIMARY KEY,
  `title` varchar(20) NOT NULL,
  `description` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)ENGINE=InnoDB;


DROP TABLE IF EXISTS `tbl_report`;
DROP TABLE IF EXISTS `tbl_update`;
DROP  TABLE IF EXISTS `tbl_outcome`;

CREATE TABLE `tbl_report` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `publicID` int,
  `title` varchar(50) NOT NULL,
  `desc` varchar(254) NOT NULL,
  `date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00', 
  `category` varchar(50),
  `severity` int,
  `urgency` int,
  `locationLat` point,
  `locationLng` point
) ENGINE=InnoDB;


CREATE TABLE `tbl_update` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `reportID` int,
  `outcomeID` int,
  `memberID` int,
  `title` varchar(50) NOT NULL,
  `desc` varchar(254) NOT NULL,
  `progress` int,
  `comment` varchar(254),
  `date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00', 
) ENGINE=InnoDB;


CREATE TABLE `tbl_outcome` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `memberID` int,
  `reportID` int,
  `title` varchar(50) NOT NULL,
  `desc` varchar(254) NOT NULL,
  `progress` int,
  `date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB;


ALTER TABLE `tbl_report`
  ADD FOREIGN KEY (`publicID`) REFERENCES `tbl_public` (`id`);

ALTER TABLE `tbl_update`
  ADD FOREIGN KEY (`reportID`) REFERENCES `tbl_report` (`id`);

ALTER TABLE `tbl_update`
  ADD FOREIGN KEY (`outcomeID`) REFERENCES `tbl_outcome` (`id`);

ALTER TABLE `tbl_update`
  ADD FOREIGN KEY (`memberID`) REFERENCES `tbl_councilMember` (`id`);

ALTER TABLE `tbl_outcome`
  ADD FOREIGN KEY (`memberID`) REFERENCES `tbl_councilMember` (`id`);

ALTER TABLE `tbl_outcome`
  ADD FOREIGN KEY (`reportID`) REFERENCES `tbl_report` (`id`);


ALTER TABLE `tbl_councilMember`
  ADD FOREIGN KEY (`RoleID`) REFERENCES `tbl_Roles` (`id`);

