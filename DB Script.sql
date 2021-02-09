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



CREATE TABLE `tbl_public` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `Email` varchar(254) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `FirstName` varchar(20) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `DOB` DATE NOT NULL,
  `ReportCount` int,
  `Authenticated` tinyint(1),
  `CreatedAT` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `UpdateAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMPT ON UPDATE CURRENT_TIMESTAMP,
  `VerificationCode` varchar(16)
) ENGINE=InnoDB;



CREATE TABLE `tbl_councilMember` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `Email` varchar(254) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `FirstName` varchar(20) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `DOB` DATE NOT NULL,
  `RoleID` int NOT NULL,
  `Authenticated` tinyint(1),
  `CreatedAT` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `UpdateAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMPT ON UPDATE CURRENT_TIMESTAMP,
  `VerificationCode` varchar(16)
) ENGINE=InnoDB;


CREATE TABLE `tbl_Roles` (
  `id` int NOT NULL PRIMARY KEY,
  `Title` varchar(20) NOT NULL,
  `Description` varchar(200) NOT NULL,
  `CreatedAT` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `UpdateAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMPT ON UPDATE CURRENT_TIMESTAMP
)ENGINE=InnoDB;

ALTER TABLE `tbl_councilMember`
  ADD FOREIGN KEY (`RoleID`) REFERENCES `tbl_Roles` (`id`);
