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
  `PublicID` int NOT NULL PRIMARY KEY,
  `Email` varchar(20) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(50) NOT NULL,
  'FirstName' varchar(20) NOT NULL,
  'LastName' varchar(20) NOT NULL,
  `DOB` DATE NOT NULL,
  `ReportCount` int,
  `Authenticated` tinyint(1),
  `RegistrationDate` DATE NOT NULL,
  `VerificationCode` varchar(16),
) ENGINE=InnoDB;



CREATE TABLE `tbl_councilMember` (
  `MemberID` int NOT NULL PRIMARY KEY,
  `Email` varchar(20) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(50) NOT NULL,
  'FirstName' varchar(20) NOT NULL,
  'LastName' varchar(20) NOT NULL,
  `DOB` DATE NOT NULL,
  `RoleID` int NOT NULL,
  `Authenticated` tinyint(1),
  `RegistrationDate` DATE NOT NULL,
  `VerificationCode` varchar(16),
) ENGINE=InnoDB;


