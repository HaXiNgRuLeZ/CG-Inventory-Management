CREATE TABLE Users (
	ID int IDENTITY(1,1),
	UserID VARCHAR(255) NOT NULL PRIMARY KEY,
	UserPass NVARCHAR(100) NOT NULL,
	Name VARCHAR(255) NOT NULL,
	Email NVARCHAR(320) UNIQUE,
	UserGroup VARCHAR(255)NOT NULL,
	UserLevel int NOT NULL,
	Status BIT NOT NULL
);

INSERT INTO Users (UserID, UserPass, Name, Email, UserGroup, UserLevel, Status)
VALUES('CG0201', HASHBYTES('SHA2_256','Asd123@sd'), 'Muhammad Hanif Firdaus', 'hanifstore.cg@gmail.com', 'STORE', 2, 1),
('admin', HASHBYTES('SHA2_256','admin'), 'CG', 'admin@cgglobalprofastex.com', 'ADMINISTRATOR', 3 , 1),
('testuser', HASHBYTES('SHA2_256','testuser'), 'TEST', 'testuser@cgglobalprofastex.com', 'TEST USER', 1 , 0);

CREATE TABLE PartManagement (
	ID int IDENTITY(1,1),
	PartNumber VARCHAR(255) NOT NULL PRIMARY KEY,
	PartType VARCHAR(255),
	CGCode VARCHAR(255),
	PN_Desc NVARCHAR(320),
	QtyPerPart int,
	UpdateTime DATETIME,
	Updater VARCHAR(255) FOREIGN KEY REFERENCES Users(UserID)
);

INSERT INTO PartManagement (PartNumber, PartType, CGCode, PN_Desc, QtyPerPart, UpdateTime, Updater)
VALUES('PARTNUMBER1', 'RESISTOR_TEST', 'TEST0001', 'THIS IS FOR TESTING ONLY!', 5000, GETDATE(), 'CG0201');

CREATE TABLE Rack (
	ID int IDENTITY(1,1),
	RackName NVARCHAR(255) NOT NULL PRIMARY KEY,
	UpdateTime DATETIME,
	Updater VARCHAR(255) FOREIGN KEY REFERENCES Users(UserID)
);

INSERT INTO Rack(RackName, UpdateTime, Updater)
VALUES('RACK1', GETDATE(), 'CG0201'),	('RACK2', GETDATE(), 'CG0201'),('RACK3', GETDATE(), 'CG0201'),
('RACK4', GETDATE(), 'CG0201'),('RACK5', GETDATE(), 'CG0201');

CREATE TABLE Inventory (
	ID int IDENTITY(1,1),
	CGID NVARCHAR(320) NOT NULL PRIMARY KEY,
	PartNumber VARCHAR(255) FOREIGN KEY REFERENCES PartManagement(PartNumber),
	Rack VARCHAR(255) FOREIGN KEY REFERENCES Rack(RackName),
	DateCode DATE,
	Qty int NOT NULL,
	GRN NVARCHAR(200) NOT NULL,
	UpdateTime DATETIME,
	Updater VARCHAR(255) FOREIGN KEY REFERENCES Users(UserID),
	State int NOT NULL,
	Remark NVARCHAR(320)
);

INSERT INTO Inventory (CGID, PartNumber, Rack, DateCode, Qty, GRN, UpdateTime, Updater, State, Remark)
VALUES('CGID-2210-0001', 'PARTNUMBER1', 'RACK1', '2022-10-10', '3000', 'GRN/000/2022', GETDATE(), 'CG0201', 0, ''),
('CGID-2210-0002', 'PARTNUMBER1', 'RACK1', '2022-10-10', '5000', 'GRN/000/2022', GETDATE(), 'CG0201', 0, '');

CREATE TABLE PartLog (
	ID int IDENTITY(1,1) PRIMARY KEY,
	RecordTime DATETIME,
	PartNumber VARCHAR(255),
	CGID NVARCHAR(320),
	Qty int NOT NULL,
	QtyOut int NOT NULL,
	Rack NVARCHAR(255),
	MTFNumber NVARCHAR(200),
	Type int NOT NULL,
	Updater VARCHAR(255),
	Remark NVARCHAR(320)
);

CREATE TABLE PrintedCode (
	PrintCode NVARCHAR(320) NOT NULL,
	CGID NVARCHAR(320),
	PartNumber VARCHAR(255),
	DateCode DATE,
	CGCode VARCHAR(255),
	Qty int NOT NULL,
	GRN NVARCHAR(200) NOT NULL,
	Remark NVARCHAR(320)
);

CREATE TABLE PartOut (
	ID int IDENTITY(1,1),
	PrintCode NVARCHAR(320),
	CGID NVARCHAR(320),
	PartNumber VARCHAR(255),
	Rack VARCHAR(255) FOREIGN KEY REFERENCES Rack(RackName),
	MTFNumber NVARCHAR(200),
	Type VARCHAR(255) NOT NULL,
	DateCode DATE,
	Qty int NOT NULL,
	GRN NVARCHAR(200) NOT NULL,
	UpdateTime DATETIME,
	Updater VARCHAR(255) FOREIGN KEY REFERENCES Users(UserID),
	State int NOT NULL,
	Remark NVARCHAR(320)
);

CREATE TABLE CGIDNum (
	CGIDNo int NOT NULL,
	CGIDYYMM NVARCHAR(50),
);

INSERT INTO CGIDNum (CGIDNo, CGIDYYMM) VALUES (1, 'yyMM');