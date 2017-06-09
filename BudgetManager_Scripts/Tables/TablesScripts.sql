EXEC DeleteConstraints 'FOREIGN KEY', 1
GO

EXEC DeleteConstraints 'PRIMARY KEY', 1, 0
GO
--All available application roles
IF OBJECT_ID('appRoles') IS NOT NULL
BEGIN
	DROP TABLE appRoles
END
GO
CREATE TABLE appRoles
(
	roleId INT PRIMARY KEY,
	roleName VARCHAR(30),
	roleDescription VARCHAR(200)
)
GO

--Email verification master
IF OBJECT_ID('appEmailVerificationMaster') IS NOT NULL
BEGIN
	DROP TABLE appEmailVerificationMaster
END
GO
CREATE TABLE appEmailVerificationMaster
(
	VerificationId INT IDENTITY PRIMARY KEY,
	[type] VARCHAR(20),
	[description] VARCHAR(200) 
)
GO

--Email Verification check
IF OBJECT_ID('appEmailVerificationCheck') IS NOT NULL
BEGIN
	DROP TABLE appEmailVerificationCheck
END
GO
CREATE TABLE appEmailVerificationCheck
(
	VerificationId INT,
	userId VARCHAR(20),
	isVerified BIT,
	CONSTRAINT FK_VERIFICATION_ID FOREIGN KEY (VerificationId) REFERENCES appEmailVerificationMaster(VerificationId) 
	ON DELETE CASCADE
	ON UPDATE CASCADE
)
GO

--User Company
IF OBJECT_ID('appCompany') IS NOT NULL
BEGIN
	DROP TABLE appCompany
END
GO
CREATE TABLE appCompany
(	
	CompanyId INT IDENTITY PRIMARY KEY,
	CompanyName VARCHAR(30),
	CompanyDescription VARCHAR(200),
	OwnedBy VARCHAR(20)
)
GO

--User credential information will be available
--Store the Passkey in the encrypted form always
IF OBJECT_ID('appUsersCredentials') IS NOT NULL
BEGIN	
	DROP TABLE appUsersCredentials
END
GO
CREATE TABLE appUsersCredentials
(
	UserId VARCHAR(20) PRIMARY KEY,
	PassKey NVARCHAR(100),
	Email VARCHAR(100),	
	IsEmailVerified BIT DEFAULT(0),
	CompanyId INT,
	CONSTRAINT FK_USER_COMPANY_ID FOREIGN KEY (CompanyId) REFERENCES appCompany(CompanyId)
)
GO

--User's information will be stored
IF OBJECT_ID('appUserInformation') IS NOT NULL
BEGIN
	DROP TABLE appUserInformation
END
GO
	CREATE TABLE appUserInformation
	(
		UserId VARCHAR(20),
		FirstName VARCHAR(30),
		MiddleName VARCHAR(30),
		LastName VARCHAR(30),		
		PetName VARCHAR(20),		
		ShowPetName BIT DEFAULT(1),
		DisplayName AS (CASE WHEN ShowPetName = 1 THEN PetName ELSE FirstName + ' ' + MiddleName + ' ' + LastName END),		
		AddressLine1 VARCHAR(30),
		AddressLine2 VARCHAR(30),
		City VARCHAR(30),
		DoB DATETIME,
		PinCode VARCHAR(10),
		Country VARCHAR(100),
		PhoneNumber VARCHAR(30),
		Mobile VARCHAR(15),
		Gender CHAR(1),
		SecretQuestion VARCHAR(150),
		SecretAnswer VARCHAR(50),
		CONSTRAINT FK_User_Id FOREIGN KEY(UserId) REFERENCES appUsersCredentials(UserId)
	)
GO

--Add a constraint to company after the user table has been created
ALTER TABLE appCompany ADD CONSTRAINT FK_COMPANY_USER_ID FOREIGN KEY (OwnedBy) REFERENCES appUsersCredentials(UserId)
GO

--Relation between users and assigned roles
IF OBJECT_ID('appUsersAndRoles') IS NOT NULL
BEGIN
	DROP TABLE appUsersAndRoles
END
GO
CREATE TABLE appUsersAndRoles
(
	UserId VARCHAR(20),
	RoleAssigned INT,
	CONSTRAINT FK_USER_ROLE FOREIGN KEY (roleAssigned) REFERENCES appRoles(roleId) ,
	CONSTRAINT FK_USERROLES_USER_ID FOREIGN KEY (UserId) REFERENCES appUsersCredentials(UserId)
)
GO

--User Permissions on accessing screens
IF OBJECT_ID('appScreens') IS NOT NULL
BEGIN
	DROP TABLE appScreens
END
GO
CREATE TABLE appScreens
(
	screenId INT IDENTITY PRIMARY KEY,
	screenName VARCHAR(200),
	menuTitle VARCHAR(100),
	screenActionName VARCHAR(400),
	screenControllerName VARCHAR(400),
	screenAreaName VARCHAR(400),
	defaultReadAccess BIT,
	defaultWriteAccess BIT,
	defaultDeleteAccess BIT,
	parentScreenId INT,
	linkOrder INT DEFAULT(100),
	linkIcon VARCHAR(100) DEFAULT('icon-tasks')
)
GO

IF OBJECT_ID('appDefaulPermisionScreens') IS NOT NULL
BEGIN
	DROP TABLE appDefaulPermisionScreens
END
GO
CREATE TABLE appDefaulPermisionScreens
(
	CompanyId INT,
	ScreenId INT,
	IsRead BIT,
	IsWrite BIT,
	canDelete BIT,
	parentScreenId INT,
	screenName VARCHAR(200),
	linkOrder INT DEFAULT(100),
	linkIcon VARCHAR(100) DEFAULT('icon-tasks')
	CONSTRAINT FK_DEFAULPERMISIONSCREENS_COMPANY_ID FOREIGN KEY (CompanyId) REFERENCES appCompany(CompanyId)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_DEFAULPERMISIONSCREENS_ScreenId FOREIGN KEY(ScreenId) REFERENCES appScreens(ScreenId)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
)
GO

--User Permissions on accessing screens
IF OBJECT_ID('appUserPermissions') IS NOT NULL
BEGIN
	DROP TABLE appUserPermissions
END
GO
CREATE TABLE appUserPermissions
(
	userId VARCHAR(20),
	screenId INT,
	isRead BIT,
	isWrite BIT,
	canDelete BIT,
	showInLink BIT,	
	parentScreenId INT DEFAULT(0),
	linkIcon VARCHAR(100) DEFAULT('icon-tasks'),
	linkOrder INT DEFAULT(0),
	CompanyId INT,
	CONSTRAINT FK_PERMISSIONS_COMPANY_ID FOREIGN KEY (CompanyId) REFERENCES appCompany(CompanyId),
	CONSTRAINT FK_PERMISSIONS_USER_ID FOREIGN KEY (userId) REFERENCES appUsersCredentials(userId)
)
GO


--People available for budget
IF OBJECT_ID('budgetPeople') IS NOT NULL
BEGIN
	DROP TABLE budgetPeople
END
GO
CREATE TABLE budgetPeople
(
	PersonId INT IDENTITY PRIMARY KEY,
	PersonName VARCHAR(150),
	IsActive BIT
)
GO

--Budget Category
IF OBJECT_ID('budgetCategory') IS NOT NULL
BEGIN
	DROP TABLE budgetCategory
END
GO
CREATE TABLE budgetCategory
(
	CategoryId INT IDENTITY PRIMARY KEY,
	CategoryName VARCHAR(200),
	CompanyId INT,
	CreatedBy VARCHAR(20),
	CONSTRAINT FK_BUDGETCATEGORY_CREATEDBY FOREIGN KEY(CreatedBy) REFERENCES appUsersCredentials(UserId)	
)

--Created / Existing budgets
IF OBJECT_ID('budgets') IS NOT NULL
BEGIN
	DROP TABLE budgets
END
GO
CREATE TABLE budgets
(
	BudgetId INT IDENTITY PRIMARY KEY,
	Name VARCHAR(100),
	[Description] VARCHAR(300),
	StartDate DATETIME,
	EndDate DATETIME,		
	MinAmount MONEY,
	MaxAmount MONEY,
	IsActive BIT,
	CreatedBy VARCHAR(20),
	CategoryId INT,
	IsExpired AS CAST((CASE WHEN GETDATE() > endDate THEN 1 ELSE 0 END) AS BIT),
	CompanyId INT,
	CONSTRAINT FK_BUDGETS_COMPANY_ID FOREIGN KEY (CompanyId) REFERENCES appCompany(CompanyId)
	ON DELETE CASCADE,
	CONSTRAINT FK_BUDGET_CREATEDBY FOREIGN KEY(CreatedBy) REFERENCES appUsersCredentials(UserId)
	ON DELETE CASCADE,
	CONSTRAINT FK_BUDGETS_CATEGORY_ID FOREIGN KEY (CategoryId) REFERENCES budgetCategory(CategoryId)
	ON DELETE CASCADE,
)
GO

--People assigned to budget
IF OBJECT_ID('peopleInBudget') IS NOT NULL
BEGIN
	DROP TABLE peopleInBudget
END
GO
CREATE TABLE peopleInBudget
(
	personId INT,
	budgetId INT,
	isActive BIT,
	CONSTRAINT FK_BUDGETPEOPLE_PERSIONID FOREIGN KEY(personId) REFERENCES budgetPeople(personId),
	CONSTRAINT FK_BUDGETS_BUDGETID FOREIGN KEY(personId) REFERENCES budgets(budgetId)
	ON DELETE CASCADE 
	ON UPDATE CASCADE
)
GO

 --Application Groups
IF OBJECT_ID('appUserGroups') IS NOT NULL
BEGIN
	DROP TABLE appUserGroups
END
GO
CREATE TABLE appUserGroups
(
	GroupId INT PRIMARY KEY IDENTITY,
	GroupName VARCHAR(300),
	IsActive bit ,
	CompanyId INT,
	CreatedBy VARCHAR(20),
	CONSTRAINT FK_USERGROUP_COMPANY_ID FOREIGN KEY (CompanyId) REFERENCES appCompany(CompanyId),	
	CONSTRAINT FK_USERGROUP_CREATED_BY FOREIGN KEY (CreatedBy) REFERENCES appUsersCredentials(userId)
)
GO

--Application Users in Groups
IF OBJECT_ID('appGroupedUsers') IS NOT NULL
BEGIN
	DROP TABLE appGroupedUsers
END
GO
CREATE TABLE appGroupedUsers
(
	userId VARCHAR(20),
	groupId INT,
	CompanyId INT,
	CONSTRAINT FK_GROUPEDUSER_USER_ID FOREIGN KEY (userId) REFERENCES appUsersCredentials(userId),
	CONSTRAINT FK_GROUPEDDUSER_GROUP_ID FOREIGN KEY (groupId) REFERENCES appUserGroups(groupId)
)
GO

IF OBJECT_ID('appBudgetGroups') IS NOT NULL
BEGIN
	DROP TABLE appBudgetGroups
END
GO
CREATE TABLE appBudgetGroups
(
	GroupId INT IDENTITY,
	GroupName VARCHAR(200),
	CompanyId INT,
	CONSTRAINT FK_BUDGETGROUPS_COMPANY_ID FOREIGN KEY (CompanyId) REFERENCES appCompany(CompanyId)
)
GO

--Expenses
IF OBJECT_ID('appExpenses') IS NOT NULL
BEGIN
	DROP TABLE appExpenses
END
GO
CREATE TABLE appExpenses
(
	ExpenseId INT IDENTITY PRIMARY KEY,
	BudgetId INT,
	SpentOn DATETIME,
	SpentBy VARCHAR(20),
	SpentAmount MONEY,
	CompanyId INT,
	CreatedBy VARCHAR(20),
	[Description] NVARCHAR(100),
	CONSTRAINT FK_EXPENSE_USER_ID FOREIGN KEY (SpentBy) REFERENCES appUsersCredentials(userId),
	CONSTRAINT FK_EXPENSE_COMPANY_ID FOREIGN KEY (CompanyId) REFERENCES appCompany(CompanyId),
	CONSTRAINT FK_EXPENSE_BUDGET_ID FOREIGN KEY (BudgetId) REFERENCES budgets(BudgetId)
	ON DELETE CASCADE 
	ON UPDATE CASCADE,
	CONSTRAINT FK_EXPENSE_CREATED_BY FOREIGN KEY (CreatedBy) REFERENCES appUsersCredentials(userId)
)
GO

--Users in Expenditure
IF OBJECT_ID('appUsersIncludedInExpenditure') IS NOT NULL
BEGIN
	DROP TABLE appUsersIncludedInExpenditure
END
GO
CREATE TABLE appUsersIncludedInExpenditure
(
	ExpenseId INT,
	IncludedUserId VARCHAR(20),
	ExcludedUserId VARCHAR(20),
	UserGroupId INT,
	CONSTRAINT FK_EXPENDITURE_EXPENSE_ID FOREIGN KEY (ExpenseId) REFERENCES appExpenses(ExpenseId)
	ON DELETE CASCADE
	ON UPDATE CASCADE,		
	CONSTRAINT FK_EXPENDITURE_GROUP_ID FOREIGN KEY (UserGroupId) REFERENCES appUserGroups(groupId),	
	CONSTRAINT FK_EXPENDITURE_INCLUDEDUSER_ID FOREIGN KEY (IncludedUserId) REFERENCES appUsersCredentials(userId),
	CONSTRAINT FK_EXPENDITURE_EXCLUDEDUSER_ID FOREIGN KEY (ExcludedUserId) REFERENCES appUsersCredentials(userId)	
)
GO

--Invitation Log
IF OBJECT_ID('appInvitationLog') IS NOT NULL
BEGIN
	DROP TABLE appInvitationLog
END
GO
CREATE TABLE appInvitationLog
(
	InvitationId INT IDENTITY PRIMARY KEY,
	InvitedUserID VARCHAR(20),
	InvitedBy VARCHAR(20),
	IsInvited BIT DEFAULT(1),
	IsAccepted BIT DEFAULT(0),
	InvitedCompanyId INT,
	InvitedByCompanyId INT,
	InvitedOn DATETIME DEFAULT(GETDATE()),
	InvitationStatus AS 
		CASE WHEN (IsInvited = 0 AND IsAccepted = 0) THEN 0 ELSE 
			CASE WHEN (IsInvited = 1 AND IsAccepted = 0) THEN 1 ELSE 
				CASE WHEN (IsInvited = 1 AND IsAccepted = 1) THEN 2 ELSE 0 
				END
			END
		END,
	CONSTRAINT FK_INVITATION_INVITED_USER_ID FOREIGN KEY (InvitedUserID) REFERENCES appUsersCredentials(userId),
	CONSTRAINT FK_INVITATION_INVITED_BY_USER_ID FOREIGN KEY (InvitedBy) REFERENCES appUsersCredentials(userId),	
	CONSTRAINT FK_INVITATION_INVITED_COMPANY_ID FOREIGN KEY (InvitedCompanyId) REFERENCES appCompany(CompanyId),	
	CONSTRAINT FK_INVITATION_INVITED_BY_COMPANY_ID FOREIGN KEY (InvitedByCompanyId) REFERENCES appCompany(CompanyId),	
)
GO

IF OBJECT_ID('appTransactions') IS NOT NULL
BEGIN
	DROP TABLE appTransactions
END
GO
CREATE TABLE appTransactions
(
	TransactionId INT IDENTITY PRIMARY KEY,
	Description VARCHAR(200),
	ExpenseId INT,	
	AmountReturned NUMERIC(12,2),
	ReturnedOn DATETIME,
	AmountReturnedBy VARCHAR(20),
	AmountReceivedBy VARCHAR(20),
	CompanyId INT,
	CONSTRAINT FK_TRANSACTION_AMOUNT_RETURNED_BY FOREIGN KEY (AmountReturnedBy) REFERENCES appUsersCredentials(userId),
	CONSTRAINT FK_TRANSACTION_AMOUNT_RECEIVED_BY FOREIGN KEY (AmountReceivedBy) REFERENCES appUsersCredentials(userId),	
	CONSTRAINT FK_TRANSACTION_COMPANY_ID FOREIGN KEY (CompanyId) REFERENCES appCompany(CompanyId),	
	CONSTRAINT FK_TRANSACTION_EXPENSE_ID FOREIGN KEY (ExpenseId) REFERENCES appExpenses(ExpenseId)
	ON DELETE CASCADE
	ON UPDATE CASCADE
)
GO