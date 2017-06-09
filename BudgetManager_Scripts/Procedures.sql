IF OBJECT_ID('DeleteConstraints', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE DeleteConstraints
END
GO
CREATE PROCEDURE DeleteConstraints
(
	@constraintType VARCHAR(50),		
	@showMessage BIT = 0,
	@showQuery BIT = 0
)
AS
SET NOCOUNT ON
BEGIN
	--Remove Constraints from a DB
	DECLARE @intConstraintCount BIGINT
	DECLARE @intInitialContraintCount BIGINT
	DECLARE @strConstraintName VARCHAR(200) 
	DECLARE @strConstraintType VARCHAR(200)
	DECLARE @strQryRemoveConst NVARCHAR(MAX)
	DECLARE @strTableName VARCHAR(500)
	SET @intConstraintCount = 0
	SET @intInitialContraintCount = 0
	SET @strConstraintName = ''
	SET @strConstraintType = @constraintType
	SET @strQryRemoveConst = '' 
	SET @strTableName = ''
	SELECT @intConstraintCount = COUNT(1) FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_type = @strConstraintType
	SET @intInitialContraintCount = @intConstraintCount
	WHILE @intConstraintCount > 0
	BEGIN
		SELECT @strConstraintName = constraint_name, @strTableName = Table_Name FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_type = @strConstraintType
		SET @strQryRemoveConst = 'ALTER TABLE '+ @strTableName + ' DROP CONSTRAINT '+ @strConstraintName		
		IF @showQuery = 1
		BEGIN
			PRINT @strQryRemoveConst	
		END
		EXEC(@strQryRemoveConst)
		SELECT @intConstraintCount = COUNT(1) FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_type = @strConstraintType
	END
	IF @showMessage = 1
	BEGIN 
		PRINT CAST(@intInitialContraintCount AS VARCHAR) + ' ' + @constraintType + '(S) REMOVED.'
	END
	
END
GO

--Remove COntraints if any
--EXEC DeleteConstraints 'FOREIGN KEY', 1
--GO

--EXEC DeleteConstraints 'PRIMARY KEY', 1, 0
--GO

IF OBJECT_ID(N'bspAuthorizeUserLogIn') IS NOT NULL
BEGIN
DROP PROC bspAuthorizeUserLogIn
END
GO
CREATE PROCEDURE bspAuthorizeUserLogIn
(
	@userId VARCHAR(20),
	@passKey VARCHAR(100)
)
AS
BEGIN	
	IF EXISTS(SELECT UserId FROM appUsersCredentials WHERE UserId = @userId AND PassKey = @passKey AND isEmailVerified = 1)
	BEGIN
		SELECT UC.UserId, UI.DisplayName AS DisplayName, UC.CompanyId FROM appUsersCredentials UC LEFT JOIN appUserInformation UI ON UC.UserId = UI.UserId
		WHERE UC.UserId = @userId
	END
END
GO

IF OBJECT_ID('bspCreateMyCompany', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspCreateMyCompany
END
GO
CREATE PROCEDURE bspCreateMyCompany
(
	@userId VARCHAR(20),
	@companyName VARCHAR(30),
	@companyDescription VARCHAR(200)
)
AS
SET NOCOUNT ON
BEGIN
	IF NOT EXISTS(SELECT 1 FROM appCompany WHERE CompanyName = @companyName)
	BEGIN	
		INSERT INTO appCompany(CompanyName, CompanyDescription, OwnedBy)
		SELECT @companyName, @companyDescription, @userId  
	END
END
GO

IF OBJECT_ID(N'bspAddUser') IS NOT NULL
BEGIN
DROP PROC bspAddUser
END
GO
CREATE PROCEDURE bspAddUser
(
	@userName VARCHAR(30),
	@password VARCHAR(300),
	@email VARCHAR(100),
	@displayName VARCHAR(20)	
)
AS 
SET NOCOUNT ON
BEGIN
	INSERT INTO appUsersCredentials(UserId, PassKey, Email)
	SELECT @userName, @password, @email
	
	INSERT INTO appUserInformation (UserId, PetName, ShowPetName)
	SELECT @userName, @displayName, 1 FROM appUsersCredentials WHERE UserId = @userName
	
	DECLARE @defaultDescription VARCHAR(100)
	SELECT @defaultDescription = @userName+'''s default company.'
	EXEC bspCreateMyCompany @userName, @userName, @defaultDescription 
	
	UPDATE appUsersCredentials SET CompanyId = (select companyId from appCompany where companyName = @userName) WHERE userId = @userName
	SELECT 	@userName 
END
GO

IF OBJECT_ID(N'bspCheckUserNameOrEmailIsExists') IS NOT NULL
BEGIN
DROP PROC bspCheckUserNameOrEmailIsExists
END
GO
CREATE PROCEDURE bspCheckUserNameOrEmailIsExists
(
	@validateField VARCHAR(100),
	@fieldType VARCHAR(30)
)
AS
SET NOCOUNT ON
BEGIN
IF LOWER(@fieldType) = 'name'
BEGIN
	IF EXISTS(SELECT 1 FROM appUsersCredentials WHERE UserId = @validateField)
	BEGIN
		SELECT @validateField
	END
END
ELSE IF LOWER(@fieldType) = 'email'
BEGIN
	IF EXISTS(SELECT 1 FROM appUsersCredentials WHERE Email = @validateField)
	BEGIN
		SELECT @validateField
	END	
END
END
GO

IF OBJECT_ID(N'bspGetAllAvailableRoles') IS NOT NULL
BEGIN
DROP PROC bspGetAllAvailableRoles
END
GO
CREATE PROCEDURE bspGetAllAvailableRoles
AS
SET NOCOUNT ON
BEGIN
	SELECT DISTINCT roleName FROM appRoles
END
GO

IF OBJECT_ID(N'bspGetCurrentUserRole') IS NOT NULL
BEGIN
DROP PROC bspGetCurrentUserRole
END
GO
CREATE PROCEDURE bspGetCurrentUserRole
(
	@userName VARCHAR(30)
)
AS
SET NOCOUNT ON
BEGIN
	SELECT DISTINCT roleName FROM appUsersCredentials UC INNER JOIN appUsersAndRoles UR ON UC.UserId = UR.UserId 
	INNER JOIN appRoles R ON UR.RoleAssigned = R.roleId WHERE UC.UserId = @userName
END
GO

IF OBJECT_ID(N'bspVerifyEmail') IS NOT NULL
BEGIN
DROP PROC bspVerifyEmail
END
GO
CREATE PROCEDURE bspVerifyEmail
(
	@userName VARCHAR(30),
	@emailId VARCHAR(100)
)
AS
SET NOCOUNT ON
BEGIN
	IF EXISTS(SELECT isEmailVerified FROM appUsersCredentials WHERE UserId = @userName AND Email = @emailId AND isEmailVerified = 0)
	BEGIN
		UPDATE appUsersCredentials SET isEmailVerified = 1 WHERE UserId = @userName AND Email = @emailId
		SELECT CAST(1 AS BIT) AS verified
	END
	ELSE
	BEGIN
		SELECT CAST(0 AS BIT) AS verified
	END
END
GO

IF OBJECT_ID(N'bspChangeOrForgotPassword') IS NOT NULL
BEGIN
DROP PROC bspChangeOrForgotPassword
END
GO
CREATE PROCEDURE bspChangeOrForgotPassword
(
	@userId VARCHAR(30),
	@newPassword VARCHAR(100),	
	@oldPassword VARCHAR(100) = NULL
)
AS
SET NOCOUNT ON
BEGIN
	DECLARE @isSuccess BIT
	SET @isSuccess = 0
	IF @oldPassword IS NULL
	BEGIN
		UPDATE appUsersCredentials SET PassKey = @newPassword WHERE UserId = @userId
		SET @isSuccess = 1
	END
	ELSE
	BEGIN
		UPDATE appUsersCredentials SET PassKey = @newPassword WHERE UserId = (SELECT UserId FROM appUsersCredentials WHERE UserId = @userId AND PassKey = @oldPassword)
	END
	RETURN @isSuccess
END
GO

IF OBJECT_ID(N'bspAssignRoleToUser') IS NOT NULL
BEGIN
DROP PROC bspAssignRoleToUser
END
GO
CREATE PROCEDURE bspAssignRoleToUser
(
	@userId VARCHAR(30),
	@roleId	INT
)
AS
SET NOCOUNT ON
BEGIN
	IF EXISTS(SELECT 1 FROM appUsersCredentials UC LEFT JOIN appUsersAndRoles UR ON UC.UserId = UR.UserId INNER JOIN appRoles R ON UR.roleAssigned = R.roleId WHERE UC.UserId = @userId AND UR.roleAssigned <> @roleId AND R.roleId = @roleId)
	BEGIN
		INSERT INTO appUsersAndRoles (UserId, roleAssigned)
		SELECT @userId, @roleId
	END
END
GO

IF OBJECT_ID(N'bspGetForgottenPassword') IS NOT NULL
BEGIN
DROP PROC bspGetForgottenPassword
END
GO
CREATE PROCEDURE bspGetForgottenPassword
(
	@emailId VARCHAR(200)		
)
AS
SET NOCOUNT ON
BEGIN
	IF EXISTS(SELECT 1 FROM appUsersCredentials WHERE Email = @emailId)
	BEGIN
		SELECT UC.PassKey, UI.DisplayName FROM appUsersCredentials UC INNER JOIN appUserInformation UI ON UC.UserId = UI.UserId WHERE UC.Email = @emailId
	END
END
GO

IF OBJECT_ID(N'bspGetAllAvailableScreens') IS NOT NULL
BEGIN
DROP PROC bspGetAllAvailableScreens
END
GO
CREATE PROCEDURE bspGetAllAvailableScreens
AS
BEGIN
	SELECT DISTINCT screenActionName, ISNULL(screenName, screenActionName) AS ScreenName, screenControllerName, screenAreaName FROM appScreens
END
GO

IF OBJECT_ID(N'bspAddApplicationScreens') IS NOT NULL
BEGIN
DROP PROC bspAddApplicationScreens
END
GO
CREATE PROCEDURE bspAddApplicationScreens
(
	@screenActionName VARCHAR(200),
	@screenControllerName VARCHAR(200),
	@screenAreaName VARCHAR(200)
)
AS
SET NOCOUNT ON
BEGIN
	IF NOT EXISTS(SELECT 1 FROM appScreens WHERE screenActionName = @screenActionName AND screenControllerName = @screenControllerName AND screenAreaName = @screenAreaName)
	BEGIN
		INSERT INTO appScreens (screenActionName, screenControllerName, screenAreaName)
		SELECT @screenActionName, @screenControllerName, @screenAreaName
	END
END
GO

IF OBJECT_ID(N'bspIsUserHasAccess') IS NOT NULL
BEGIN
DROP PROC bspIsUserHasAccess
END
GO
CREATE PROCEDURE bspIsUserHasAccess
(
	@userId VARCHAR(20) = NULL,
	@screenActionName VARCHAR(200),
	@screenControllerName VARCHAR(200),
	@screenAreaName VARCHAR(200),
	@companyId INT = NULL
)
AS
SET NOCOUNT ON
BEGIN
	IF(@userId IS NOT NULL)	
	BEGIN
		DECLARE @screenId INT;
		SELECT @screenId = screenId FROM appScreens WHERE screenActionName = @screenActionName AND screenControllerName = @screenControllerName AND screenAreaName = @screenAreaName
		IF EXISTS(SELECT 1 FROM appUserPermissions WHERE userId = @userId AND screenId = @screenId )
		BEGIN
			SELECT isRead, isWrite, canDelete AS isDelete FROM appUserPermissions WHERE userId = (SELECT userId FROM appUsersCredentials WHERE userId = @userid AND CompanyId = @companyId)  AND screenId = @screenId			
		END
		ELSE
		BEGIN
			SELECT DISTINCT SCR.screenId, SCR.screenActionName, ISNULL(DP.screenName, SCR.screenActionName) AS ScreenName, CAST(ISNULL(DP.isRead, 0) AS BIT) AS isRead, CAST(ISNULL(DP.isWrite, 0) AS BIT) AS isWrite, CAST(ISNULL(DP.canDelete,0) AS BIT) AS isDelete, DP.parentScreenId AS parentScreenId, DP.linkIcon AS linkIcon, DP.linkOrder AS linkOrder  FROM appDefaulPermisionScreens DP
			INNER JOIN appScreens SCR ON DP.screenId = SCR.screenId WHERE CompanyId = @companyId AND DP.screenId = @screenId					
		END
	END
	ELSE
	BEGIN
		SELECT CAST(0 AS BIT) AS isRead, CAST(0 AS BIT) AS isWrite, CAST(0 AS BIT) AS isDelete
	END
END
GO


IF OBJECT_ID(N'bspGetAllScreensWithPermisssion') IS NOT NULL
BEGIN
DROP PROC bspGetAllScreensWithPermisssion
END
GO
CREATE PROCEDURE bspGetAllScreensWithPermisssion
(
	@userid VARCHAR(20),
	@companyId INT = NULL
)
AS
SET NOCOUNT ON
BEGIN
	DECLARE @tblUserpermissions TABLE
	(
		screenId	INT,
		screenName	VARCHAR(200),
		screenActionName	VARCHAR(200),
		isRead BIT,
		isWrite BIT,
		canDelete BIT,
		parentScreenId INT,
		linkIcon VARCHAR(100),
		linkOrder INT
	)
	
	IF LOWER(@userId) <> 'all Users'
	BEGIN
		IF EXISTS (SELECT userId FROM appUsersCredentials WHERE userId = @userid AND CompanyId = @companyId)
		BEGIN
			INSERT INTO @tblUserpermissions (screenId, screenActionName, screenName, isRead, isWrite, canDelete, parentScreenId, linkIcon, linkOrder) 
			SELECT DISTINCT ASCR.screenId, ASCR.screenActionName, ISNULL(ASCR.screenName, ASCR.screenActionName) AS ScreenName, ISNULL(AUP.isRead,0) AS isRead, ISNULL(AUP.isWrite,0) AS isWrite, ISNULL(AUP.canDelete,0) AS canDelete, AUP.parentScreenId AS parentScreenId, AUP.linkIcon AS linkIcon, AUP.linkOrder AS linkOrder FROM appScreens ASCR
			INNER JOIN appUserPermissions AUP ON ASCR.screenId = AUP.screenId WHERE AUP.userId = @userId AND AUP.CompanyId = @companyId			
		END

		SELECT screenId, screenActionName, screenName, isRead, isWrite, canDelete, parentScreenId, linkIcon, linkOrder FROM @tblUserpermissions
		UNION
		SELECT DISTINCT SCR.screenId, SCR.screenActionName, ISNULL(DP.screenName, SCR.screenActionName) AS ScreenName, CAST(ISNULL(DP.isRead, 0) AS BIT) AS isRead, CAST(ISNULL(DP.isWrite, 0) AS BIT) AS isWrite, CAST(ISNULL(DP.canDelete,0) AS BIT) AS canDelete, DP.parentScreenId AS parentScreenId, DP.linkIcon AS linkIcon, DP.linkOrder AS linkOrder  FROM appDefaulPermisionScreens DP
		RIGHT JOIN appScreens SCR ON DP.screenId = SCR.screenId	AND DP.CompanyId = @companyId WHERE SCR.screenId NOT IN (SELECT DISTINCT screenId FROM @tblUserpermissions) --AND CompanyId = @companyId		
	END
	ELSE
	BEGIN
		SELECT DISTINCT SCR.screenId, SCR.screenActionName, ISNULL(DP.screenName, SCR.screenActionName) AS ScreenName, CAST(ISNULL(DP.isRead, 0) AS BIT) AS isRead, CAST(ISNULL(DP.isWrite, 0) AS BIT) AS isWrite, CAST(ISNULL(DP.canDelete,0) AS BIT) AS canDelete, DP.parentScreenId AS parentScreenId, DP.linkIcon AS linkIcon, DP.linkOrder AS linkOrder  FROM appDefaulPermisionScreens DP		
		RIGHT JOIN appScreens SCR ON DP.screenId = SCR.screenId AND DP.CompanyId = @companyId
		--WHERE screenId NOT IN (SELECT DISTINCT ASCR.screenId FROM appScreens ASCR
		--INNER JOIN appUserPermissions AUP ON ASCR.screenId = AUP.screenId WHERE AUP.userId = @userid )		
	END	
END
GO

IF OBJECT_ID(N'bspGetApplicationUsers') IS NOT NULL
BEGIN
	DROP PROC bspGetApplicationUsers
END
GO
CREATE PROCEDURE bspGetApplicationUsers
(
	@companyId INT = NULL
)
AS
SET NOCOUNT ON
BEGIN
	SELECT DISTINCT UC.UserId, ISNULL(UI.DisplayName, 'UnKnown') AS DisplayName,ISNULL(UI.FirstName, ISNULL(UI.DisplayName, 'UnKnown')) AS FirstName,UI.MiddleName,UI.LastName,
	UC.companyId AS CompanyId, (SELECT companyName from appCompany where companyId = UC.companyId) AS CompanyName
	FROM appUsersCredentials UC LEFT JOIN appUserInformation UI ON UC.UserId = UI.UserId WHERE UC.CompanyId = @companyId
END
GO

IF OBJECT_ID(N'bspGetUserPermissions') IS NOT NULL
BEGIN
DROP PROC bspGetUserPermissions
END
GO
CREATE PROCEDURE bspGetUserPermissions
(
	@userId VARCHAR(20),
	@showUserList BIT,
	@companyId INT = NULL
)
AS
SET NOCOUNT ON
BEGIN
	IF @showUserList = 1
	BEGIN
		SELECT UC.UserId, ISNULL(UI.DisplayName, 'UnKnown') AS DisplayName FROM appUsersCredentials UC LEFT JOIN appUserInformation UI ON UC.UserId = UI.UserId
		WHERE UC.CompanyId = @companyId
		UNION
		SELECT NULL, 'All Users' AS DisplayName 
	END
	EXEC bspGetAllScreensWithPermisssion @userId, @companyId					
END
GO

IF OBJECT_ID(N'bspUpdateUserPermission') IS NOT NULL
BEGIN
DROP PROC bspUpdateUserPermission
END
GO
CREATE PROCEDURE bspUpdateUserPermission
(
	@screenId INT,
	@actionType CHAR(1),
	@isAllowed BIT,
	@userId VARCHAR(200) = NULL,
	@companyId INT = NULL	
)
AS
SET NOCOUNT ON
BEGIN
	IF @actionType = 'R'
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM appUserPermissions WHERE screenId = @screenId AND userId = @userId AND CompanyId = @companyId AND @userId <> 'all users')
		BEGIN
			INSERT INTO appUserPermissions(userId, screenId, isRead, CompanyId) 
			SELECT @userId, @screenId, @isAllowed, @companyId 			
		END
		IF LOWER(@userId) <> 'all Users'
		BEGIN
			UPDATE appUserPermissions SET isRead = @isAllowed WHERE screenId = @screenId AND userId = @userId
		END
		ELSE
		BEGIN 
			UPDATE appUserPermissions SET isRead = @isAllowed WHERE screenId = @screenId 
			IF NOT EXISTS(SELECT 1 FROM appDefaulPermisionScreens WHERE CompanyId = @companyId AND screenId = @screenId)
			BEGIN
				INSERT INTO appDefaulPermisionScreens (CompanyId, ScreenId, isRead)
				SELECT @companyId, @screenId, @isAllowed
			END
			UPDATE appDefaulPermisionScreens SET isRead = @isAllowed WHERE CompanyId = @companyId AND screenId = @screenId 
		END
	END
	ELSE IF @actionType = 'W'
		BEGIN 
			IF NOT EXISTS(SELECT 1 FROM appUserPermissions WHERE screenId = @screenId AND userId = @userId AND CompanyId = @companyId AND @userId <> 'all users')
			BEGIN
				INSERT INTO appUserPermissions(userId, screenId, isRead, CompanyId) 
				SELECT @userId, @screenId, @isAllowed, @companyId 			
			END
			IF LOWER(@userId) <> 'all Users'
			BEGIN
				UPDATE appUserPermissions SET isWrite = @isAllowed, isRead = (CASE WHEN @isAllowed = 1 THEN @isAllowed ELSE isRead END) WHERE screenId = @screenId AND userId = @userId
			END
			ELSE
			BEGIN 
				UPDATE appUserPermissions SET isWrite = @isAllowed, isRead = (CASE WHEN @isAllowed = 1 THEN @isAllowed ELSE isRead END) WHERE screenId = @screenId
				IF NOT EXISTS(SELECT 1 FROM appDefaulPermisionScreens WHERE CompanyId = @companyId AND screenId = @screenId)
				BEGIN
					INSERT INTO appDefaulPermisionScreens (CompanyId, ScreenId, isWrite)
					SELECT @companyId, @screenId, @isAllowed
				END
				ELSE
				BEGIN
					UPDATE appDefaulPermisionScreens SET isWrite = @isAllowed WHERE CompanyId = @companyId AND screenId = @screenId
				END
			END	
	END	
	ELSE IF @actionType = 'D'
		BEGIN 
			IF NOT EXISTS(SELECT 1 FROM appUserPermissions WHERE screenId = @screenId AND userId = @userId AND CompanyId = @companyId AND @userId <> 'all users')
			BEGIN
				INSERT INTO appUserPermissions(userId, screenId, isRead, CompanyId) 
				SELECT @userId, @screenId, @isAllowed, @companyId 			
			END
			IF LOWER(@userId) <> 'all Users'
			BEGIN
				UPDATE appUserPermissions SET canDelete = @isAllowed, isRead = (CASE WHEN @isAllowed = 1 THEN @isAllowed ELSE isRead END) WHERE screenId = @screenId AND userId = @userId
			END
			ELSE
			BEGIN 
				UPDATE appUserPermissions SET canDelete = @isAllowed, isRead = (CASE WHEN @isAllowed = 1 THEN @isAllowed ELSE isRead END) WHERE screenId = @screenId
				IF NOT EXISTS(SELECT 1 FROM appDefaulPermisionScreens WHERE CompanyId = @companyId AND screenId = @screenId)
				BEGIN
					INSERT INTO appDefaulPermisionScreens (CompanyId, ScreenId, canDelete)
					SELECT @companyId, @screenId, @isAllowed
				END
				ELSE
				BEGIN
					UPDATE appDefaulPermisionScreens SET canDelete = @isAllowed WHERE CompanyId = @companyId AND screenId = @screenId
				END
			END	
	END
END
GO

IF OBJECT_ID(N'bspGetUserScreens') IS NOT NULL
BEGIN
DROP PROC bspGetUserScreens
END
GO
CREATE PROCEDURE bspGetUserScreens
(
	@userId VARCHAR(200),
	@companyId INT = NULL
)
AS
SET NOCOUNT ON
BEGIN
	DECLARE @userScreens TABLE
	(
		screenId INT,
		linkOrder INT,		
		ActionLinkText VARCHAR(200),
		ActionName VARCHAR(200),
		ControllerName VARCHAR(200),
		AreaName VARCHAR(200),
		linkOrderId INT,
		linkIcon VARCHAR(200)	
	)
	INSERT INTO @userScreens(screenId, linkOrder, ActionLinkText, ActionName, ControllerName, AreaName, linkIcon)
	SELECT DISTINCT S.screenId, UP.linkOrder, ISNULL(S.screenName, S.screenActionName) AS ActionLinkText, S.screenActionName AS ActionName, S.screenControllerName AS ControllerName, S.screenAreaName AS AreaName, UP.linkIcon AS LinkIcon 
	FROM appScreens S INNER JOIN appUserPermissions UP ON S.screenId = UP.screenId 
	WHERE userId = (SELECT userId FROM appUsersCredentials WHERE userId = @userid AND CompanyId = @companyId) AND (isRead = 1 OR isWrite =1 OR canDelete = 1) ORDER BY UP.linkOrder ASC
		
	SELECT * FROM (
	SELECT screenId, ActionLinkText, ActionName, ControllerName, AreaName, linkIcon, linkOrder AS linkOrderId FROM @userScreens 
	UNION
	SELECT SCR.screenId, ISNULL(DP.screenName, SCR.screenActionName) AS ActionLinkText, SCR.screenActionName AS ActionName, SCR.screenControllerName AS ControllerName, SCR.screenAreaName AS AreaName, DP.linkIcon, DP.linkOrder AS linkOrderId FROM appDefaulPermisionScreens DP 
	INNER JOIN appScreens SCR ON DP.screenId = SCR.screenId WHERE (DP.isRead = 1 OR DP.isWrite = 1 OR DP.canDelete = 1) AND SCR.screenId NOT IN (SELECT screenId FROM @userScreens) AND CompanyId = @companyId 	
	) AS UserScreens ORDER BY linkOrderId
END
GO

IF OBJECT_ID(N'bspUpdateScreenData') IS NOT NULL
BEGIN
DROP PROC bspUpdateScreenData
END
GO
CREATE PROCEDURE bspUpdateScreenData
(
	@userId VARCHAR(200),
	@companyId INT = NULL,
	@screenId INT,
	@updateParam VARCHAR(200),
	@type CHAR	
)
AS
SET NOCOUNT ON
BEGIN
	IF @type = 'I'
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM appUserPermissions WHERE screenId = @screenId AND userId = (SELECT userId FROM appUsersCredentials WHERE userId = @userid AND CompanyId = @companyId) AND @userId <> 'all users')
		BEGIN
			INSERT INTO appUserPermissions(userId, screenId, linkIcon) 
			SELECT @userId, @screenId, @updateParam 
		END	
		IF @userId = 'all users'
		BEGIN			
			IF NOT EXISTS(SELECT 1 FROM appDefaulPermisionScreens WHERE CompanyId = @companyId AND screenId = @screenId)
			BEGIN
				INSERT INTO appDefaulPermisionScreens (CompanyId, ScreenId, canDelete)
				SELECT @companyId, @screenId, @updateParam
			END
			ELSE
			BEGIN
				UPDATE appDefaulPermisionScreens SET linkIcon = @updateParam WHERE CompanyId = @companyId AND screenId = @screenId
			END					
			UPDATE appUserPermissions SET linkIcon = @updateParam WHERE screenId = @screenId
		END
		ELSE
		BEGIN
			UPDATE appUserPermissions SET linkIcon = @updateParam WHERE screenId = @screenId AND userId = @userId
		END
		END
	ELSE IF @type = 'L'
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM appUserPermissions WHERE screenId = @screenId AND userId = (SELECT userId FROM appUsersCredentials WHERE userId = @userid AND CompanyId = @companyId) AND @userId <> 'all users')
		BEGIN
			INSERT INTO appUserPermissions(userId, screenId, linkOrder, CompanyId) 
			SELECT @userId, @screenId, @updateParam, @companyId 
		END		
		IF @userId = 'all users'
		BEGIN				
			IF NOT EXISTS(SELECT 1 FROM appDefaulPermisionScreens WHERE CompanyId = @companyId AND screenId = @screenId)
			BEGIN
				INSERT INTO appDefaulPermisionScreens (ScreenId, linkOrder, CompanyId)
				SELECT @screenId, @updateParam, @companyId
			END
			ELSE
			BEGIN
				UPDATE appDefaulPermisionScreens SET linkOrder = @updateParam WHERE CompanyId = @companyId AND screenId = @screenId
			END	
			UPDATE appUserPermissions SET linkOrder = @updateParam WHERE screenId = @screenId AND userId = @userId
		END
		ELSE
		BEGIN
			UPDATE appUserPermissions SET linkOrder = @updateParam WHERE screenId = @screenId AND userId = @userId
		END
	END
END
GO

IF OBJECT_ID('bspCreateBudget', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspCreateBudget
END
GO
CREATE PROCEDURE bspCreateBudget
(
	@BudgetName VARCHAR(100),
	@Description VARCHAR(100) = NULL,
	@minAmount MONEY,
	@maxAmount MONEY,
	@startDate DATETIME,
	@endDate DATETIME,	
--@createdby varchar(100),		
	@createdby VARCHAR(100),
	@companyId INT = NULL,
	@category VARCHAR(20) = NULL
)
AS
SET NOCOUNT ON
BEGIN
--	INSERT INTO budgets(Name, Description, Category, MinAmount, MaxAmount,StartDate,EndDate)
--	SELECT @budgetName, @description, @Category, @minAmount, @maxAmount, @startDate, @endDate	

	INSERT INTO budgets(Name, Description, MinAmount, MaxAmount, StartDate, EndDate, CompanyId, createdBy,Category)
	SELECT @budgetName, @description, @minAmount, @maxAmount, @startDate, @endDate, @companyId, @createdby, @Category	

END
GO

IF OBJECT_ID('bspViewBudget', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspViewBudget
END
GO
CREATE PROCEDURE bspViewBudget
(
	@userId VARCHAR(20) = NULL,
	@companyId INT = NULL
)
AS
SET NOCOUNT ON
BEGIN
	IF @userId IS NULL
	BEGIN
<<<<<<< .mine
		SELECT BudgetId, [Name], [Description], StartDate, EndDate, MinAmount, MaxAmount, IsActive, CreatedBy, IsExpired, '' AS Category, CanExceedMaxAmount FROM budgets
=======
		SELECT BudgetId, [Name], [Description], StartDate, EndDate, MinAmount, MaxAmount, IsActive, CreatedBy, IsExpired, '' AS Category, CAST(0 AS BIT) AS CanExceedMaximumAmount FROM budgets WHERE CompanyId = @companyId
>>>>>>> .r113
	END
	ELSE
	BEGIN
<<<<<<< .mine
		SELECT BudgetId, [Name], [Description], StartDate, EndDate, MinAmount, MaxAmount, IsActive, CreatedBy, IsExpired, '' AS Category, CanExceedMaxAmount  FROM budgets --WHERE CreatedBy = @userId
=======
		SELECT BudgetId, [Name], [Description], StartDate, EndDate, MinAmount, MaxAmount, IsActive, CreatedBy, IsExpired, '' AS Category, CAST(0 AS BIT) AS CanExceedMaximumAmount  FROM budgets WHERE CompanyId = @companyId --WHERE CreatedBy = @userId
>>>>>>> .r113
	END
END
GO

--Add application user groups
IF OBJECT_ID('bspAddApplicationUserGroup', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspAddApplicationUserGroup
END
GO
Create PROCEDURE bspAddApplicationUserGroup
(
	@createdBy VARCHAR(200),
	@groupName VARCHAR(200),
	@companyId INT = NULL
)
AS
SET NOCOUNT ON
BEGIN
	INSERT INTO appUserGroups (CreatedBy,isactive, groupName, CompanyId) 
	VALUES(@createdBy, 1, @groupName, @companyId)
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
	@createdBy VARCHAR(200)
)
AS
BEGIN
	SELECT * FROM appUserGroups  where CreatedBy = @createdBy
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
		  delete from appUserInformation where UserId=@recordId
		  update appCompany set OwnedBy=null where CompanyId=(select CompanyId from appUsersCredentials where UserId=@recordId)
		   delete from appCompany where CompanyId=(select CompanyId from appUsersCredentials where UserId=@recordId)
		  delete from appUserPermissions where userId=@recordId and CompanyId=(select CompanyId from appUsersCredentials where UserId=@recordId)
         delete from appUsersCredentials where  UserId=@recordId and CompanyId=(select CompanyId from appUsersCredentials where UserId=@recordId)	
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

IF OBJECT_ID('bspGetUserDetailsForFriendInvitation', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetUserDetailsForFriendInvitation
END
GO
CREATE PROCEDURE bspGetUserDetailsForFriendInvitation
(
	@userId VARCHAR(MAX) = NULL	
)
AS
SET NOCOUNT ON
BEGIN
		SELECT UC.UserId, ISNULL(UI.DisplayName, 'UnKnown') AS userName, UC.companyId AS CompanyId, (SELECT companyName from appCompany where companyId = UC.companyId) AS CompanyName, UC.Email AS EmailId FROM appUsersCredentials UC INNER JOIN appUserInformation UI ON UC.UserId = UI.UserId 
		WHERE UC.UserId = @userId
END
GO

IF OBJECT_ID('bspAcceptInvitation', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspAcceptInvitation
END
GO
CREATE PROCEDURE bspAcceptInvitation
(
	@companyId INT,
	@userId VARCHAR(MAX) = NULL,
	@invitationType CHAR
)
AS
BEGIN
	UPDATE appUsersCredentials SET companyId = (SELECT companyid FROM appcompany WHERE companyId = @companyId) WHERE userid = @userId
END
GO

IF OBJECT_ID('bspUpdateSelectedBudgetRecord', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspUpdateSelectedBudgetRecord
END
GO
CREATE PROCEDURE bspUpdateSelectedBudgetRecord
(
	@budgetName VARCHAR(200),
	@startDate VARCHAR(200),
	@endDate VARCHAR(100),
	@maxAmount NUMERIC(12,2),
	@minAmount NUMERIC(12,2),
	@isActive BIT,
	@category VARCHAR(100),
	@budgetId INT,
	@companyId VARCHAR(200)
)
AS
SET NOCOUNT ON
BEGIN	
	UPDATE budgets SET 
	Name = @budgetName,	
	StartDate = @startDate,
	EndDate = @endDate,
	MinAmount = @minAmount,
	MaxAmount = @maxAmount,
	IsActive = @isActive,	
	CategoryId = @category	
	WHERE budgetId = @budgetId AND companyId = @companyId
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

	
	
	