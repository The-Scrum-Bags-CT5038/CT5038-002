--
-- Build user tables
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
