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

DROP VIEW IF EXISTS `view_report_categories`
DROP VIEW IF EXISTS `view_my_reports`

DROP TABLE IF EXISTS `tbl_outcomeImages`;
DROP  TABLE IF EXISTS `tbl_reportImages`;
DROP TABLE IF EXISTS `tbl_update`;
DROP  TABLE IF EXISTS `tbl_outcome`;
DROP  TABLE IF EXISTS `tbl_councilMember`;
DROP TABLE IF EXISTS `tbl_report`;
DROP TABLE IF EXISTS `tbl_public`;
DROP TABLE IF EXISTS `tbl_categories`;
DROP TABLE IF EXISTS `tbl_roles`;



-- Tables concering accounts

CREATE TABLE `tbl_public` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `email` varchar(254) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `dob` DATE,
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
  `password` varchar(100) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `dob` DATE,
  `RoleID` int,
  `authenticated` tinyint(1),
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `verificationCode` varchar(16)
) ENGINE=InnoDB;


CREATE TABLE `tbl_roles` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `title` varchar(20) NOT NULL,
  `description` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)ENGINE=InnoDB;


-- Tables concerning incident reports

CREATE TABLE `tbl_report` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `publicID` int,
  `title` varchar(50) NOT NULL,
  `desc` varchar(254) NOT NULL,
  `categoryID` int,
  `severity` int,
  `urgency` int,
  `locationLat` point,
  `locationLng` point,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE `tbl_categories` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `title` varchar(50) NOT NULL,
  `description` varchar(200),
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)ENGINE=InnoDB;

CREATE TABLE `tbl_reportImages` (
  `id` int PRIMARY KEY,
  `imageID` varchar(30),
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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
  `date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB;


CREATE TABLE `tbl_outcome` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `memberID` int,
  `reportID` int,
  `title` varchar(50) NOT NULL,
  `desc` varchar(254) NOT NULL,
  `progress` int,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE `tbl_outcomeImages` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `outcomeID` int,
  `imageName` varchar(50),
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- Foreign Keys

ALTER TABLE `tbl_report`
  ADD FOREIGN KEY (`publicID`) REFERENCES `tbl_public` (`id`);

 ALTER TABLE `tbl_report`
  ADD FOREIGN KEY (`categoryID`) REFERENCES `tbl_categories` (`id`);

ALTER TABLE `tbl_reportImages`
  ADD FOREIGN KEY (`id`) REFERENCES `tbl_report` (`id`);

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
  ADD FOREIGN KEY (`RoleID`) REFERENCES `tbl_roles` (`id`);
  
ALTER TABLE `tbl_outcomeImages`
  ADD FOREIGN KEY (`outcomeID`) REFERENCES `tbl_outcome` (`id`);


-- View build

CREATE OR REPLACE VIEW view_report_categories (id, category, title, description, severity, urgency, locationLat, locationLng, created_at) AS
  SELECT tbl_report.id, tbl_categories.title, tbl_report.title, tbl_report.desc, tbl_report.severity, tbl_report.urgency, tbl_report.locationLat, tbl_report.locationLng, tbl_report.created_at

FROM tbl_report
LEFT JOIN tbl_categories
ON tbl_report.categoryID = tbl_categories.id
GROUP BY tbl_report.id, tbl_report.title;


-- view build
-- builds view_my_reports

CREATE OR REPLACE VIEW view_my_reports (reportID, updateID, title, progress, created_at) AS
SELECT tbl_report.id, tbl_update.id, tbl_report.title, tbl_update.progress, tbl_report.created_at

FROM tbl_report
LEFT JOIN tbl_update
ON tbl_report.id = tbl_update.reportID


-- Sample data

INSERT INTO tbl_categories (title, description)
VALUES ('Graffiti', 'Writing or drawings on a wall or other surface in public view');

INSERT INTO tbl_categories (title, description)
VALUES ('Pothole', 'Depression in a road surface');


INSERT INTO tbl_categories (title, description)
VALUES ('Flooding', 'Overflow of water that submerges land that is usually dry');


-- Roles data

INSERT INTO tbl_roles (id, title, description)
VALUES ('1', 'Public', 'A member of the public looking to view and report issues');

INSERT INTO tbl_roles (id, title, description)
VALUES ('2', 'Council', 'An employee of the council');

INSERT INTO tbl_roles (id, title, description)
VALUES ('3', 'Admin', 'Administrator role');


-- Triggers

DROP TRIGGER IF EXISTS trigger_outcome_log;
DELIMITER //
create trigger trigger_outcome_log 
AFTER INSERT
ON `tbl_outcome`
FOR EACH ROW
BEGIN

    INSERT INTO tbl_update (`reportID`, `outcomeID`, `title`, `desc`, `progress`, `date`) 
    VALUES (NEW.reportID, NEW.id, NEW.title, NEW.desc, NEW.progress, NEW.created_at);


END; //

DELIMITER ;

DROP TRIGGER IF EXISTS trigger_outcome_update_log;
DELIMITER //
create trigger trigger_outcome_update_log 
AFTER UPDATE
ON `tbl_outcome`
FOR EACH ROW
BEGIN

    INSERT INTO tbl_update (`reportID`, `outcomeID`, `title`, `desc`, `progress`, `date`) 
    VALUES (NEW.reportID, NEW.id, NEW.title, NEW.desc, NEW.progress, NEW.updated_at);


END; //

DELIMITER ;
