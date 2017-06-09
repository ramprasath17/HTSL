--Add application user groups
IF OBJECT_ID('bspAddApplicationUserGroup', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspAddApplicationUserGroup
END
GO
Create PROCEDURE bspAddApplicationUserGroup
(
	@userId VARCHAR(200),
	@groupName VARCHAR(200),
	@companyId INT = NULL
)
AS
SET NOCOUNT ON
BEGIN
	INSERT INTO appUserGroups (GroupName, Isactive, CreatedBy, CompanyId) 
	VALUES(@userId, 1, @groupName, @companyId)
END
GO

--Get User Group
IF OBJECT_ID('bspGetUserGroup', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetUserGroup
END
GO
Create PROCEDURE bspGetUserGroup
(
	@companyId INT
)
AS
BEGIN
	SELECT GroupId, GroupName, IsActive FROM appUserGroups  where CompanyId = @companyId
	
	SELECT UG.GroupId, GU.UserId, UI.DisplayName AS UserName FROM appUserGroups AS UG INNER JOIN appGroupedUsers AS GU ON
	UG.GroupId = GU.groupId
	INNER JOIN appUserInformation UI ON GU.userId = UI.UserId
END

GO

--Delete selected record of the selected component
IF OBJECT_ID('bspDeleteRecordOfSelectedComponent', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspDeleteRecordOfSelectedComponent
END
GO
CREATE PROCEDURE bspDeleteRecordOfSelectedComponent
(
	@recordId VARCHAR(20),
	@componentType CHAR(1)
)
AS
SET NOCOUNT ON
BEGIN
	IF @componentType = 'B'
	BEGIN
		DELETE FROM budgets WHERE BudgetId = @recordId
	END
	ELSE IF @componentType = 'G'
	BEGIN
		DELETE FROM appUserGroups WHERE groupId = @recordId
	END
	ELSE IF @componentType = 'U'
	BEGIN		
		DELETE FROM appUserInformation WHERE UserId=@recordId
		UPDATE appCompany SET OwnedBy = NULL WHERE CompanyId = (SELECT CompanyId FROM appUsersCredentials WHERE UserId = @recordId)
		DELETE FROM appCompany WHERE CompanyId = (SELECT CompanyId FROM appUsersCredentials WHERE UserId=@recordId)
		DELETE FROM appUserPermissions WHERE userId=@recordId AND CompanyId=(SELECT CompanyId FROM appUsersCredentials WHERE UserId = @recordId)
		DELETE FROM appUsersCredentials WHERE UserId=@recordId AND CompanyId=(SELECT CompanyId FROM appUsersCredentials WHERE UserId = @recordId)	
	END
	ELSE IF @componentType = 'C'
	BEGIN
		DELETE FROM budgetCategory WHERE CategoryId = @recordId
	END
	ELSE IF @componentType = 'T'
	BEGIN
		DELETE FROM appTransactions WHERE TransactionId = @recordId
	END
END
GO

IF OBJECT_ID('bspGetUsersByUserName', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetUsersByUserName
END
GO
CREATE PROCEDURE bspGetUsersByUserName
(
	@userName VARCHAR(MAX) = NULL	
)
AS
SET NOCOUNT ON
BEGIN
	SELECT UC.UserId, ISNULL(UI.DisplayName, 'UnKnown') AS userName, UC.companyId, (SELECT companyName from appCompany where companyId = UC.companyId) AS CompanyName, CAST(1 AS BIT) AS IsActive FROM appUsersCredentials UC INNER JOIN appUserInformation UI ON UC.UserId = UI.UserId 
	WHERE UI.DisplayName LIKE @userName + '%' OR UC.UserId LIKE @userName + '%'
END
GO	

IF OBJECT_ID('bspUpdateSelectedUserRecord', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspUpdateSelectedUserRecord
END
GO
CREATE PROCEDURE bspUpdateSelectedUserRecord
(	
	@displayName VARCHAR(MAX),
	@firstName VARCHAR(MAX),	
	@middleName VARCHAR(MAX),
	@lastName NVARCHAR(MAX),
	@companyName VARCHAR(MAX),
	@isActive BIT,
	@userId VARCHAR(20),
	@userCompanyId INT,
	@companyId INT
)
AS
SET NOCOUNT ON
BEGIN
	UPDATE appUserInformation SET 
	PetName = @displayName,
	FirstName = @firstName, 
	LastName = @lastName,
	MiddleName = @middleName
	FROM appUserInformation UI INNER JOIN appusersCredentials UC ON UC.userId = UI.userId WHERE UC.userId = @userId AND companyId = @userCompanyId
	
	UPDATE appCompany SET
	CompanyName = @companyName
	WHERE companyId = @companyId
END
GO

IF OBJECT_ID('bspCreateUserGroup', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspCreateUserGroup
END
GO
CREATE PROCEDURE bspCreateUserGroup
(	
	@createdBy VARCHAR(20),
	@groupName VARCHAR(100),
	@users VARCHAR(MAX),
	@companyId INT	
)	
AS
BEGIN
	BEGIN TRANSACTION UserGroup
		INSERT INTO appUserGroups(GroupName, isActive, CompanyId, CreatedBy)
		SELECT @groupName, 1, @companyId, @createdBy
		
		INSERT INTO appGroupedUsers(GroupId, UserId, CompanyID)
		SELECT @@Identity, Items, @companyId FROM bfnSplitMultipleValues(@users, ',')
		IF @@error > 0
		BEGIN
			ROLLBACK TRANSACTION UserGroup
			RETURN @@error
		END
		ELSE
		BEGIN
			COMMIT TRANSACTION UserGroup
		END	
END	
GO	

-- Update Selected User Group
IF OBJECT_ID('bspUpdateSelectedGroupRecord', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspUpdateSelectedGroupRecord
END
GO
CREATE PROCEDURE bspUpdateSelectedGroupRecord
(			
	@groupName VARCHAR(100),
	@isActive BIT,
	@groupId INT,
	@companyId INT	
)	
AS
BEGIN
	UPDATE appUserGroups SET GroupName = @groupName, IsActive = @isActive WHERE GroupId = @groupId AND CompanyId = @companyId
END
GO

IF OBJECT_ID('bspCheckGroupAlreadyExists', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspCheckGroupAlreadyExists
END
GO
CREATE PROCEDURE bspCheckGroupAlreadyExists
(			
	@groupName VARCHAR(100),
	@companyId INT	
)	
AS
BEGIN
	SELECT 1 FROM appUserGroups WHERE groupName = @groupName AND CompanyId = @companyId
END
GO