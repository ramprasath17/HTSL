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
	@screenAreaName VARCHAR(200),
	@screenName VARCHAR(300) = NULL,
	@groupMenuTitle VARCHAR(100) = NULL,
	@read BIT = 0,
	@write BIT = 0,
	@delete BIT = 0	
)
AS
SET NOCOUNT ON
BEGIN
	IF NOT EXISTS(SELECT 1 FROM appScreens WHERE screenActionName = @screenActionName AND screenControllerName = @screenControllerName AND screenAreaName = @screenAreaName)
	BEGIN
		INSERT INTO appScreens (screenActionName, screenControllerName, screenAreaName, screenName, menuTitle, defaultReadAccess, defaultWriteAccess, defaultDeleteAccess)
		SELECT @screenActionName, @screenControllerName, @screenAreaName, @screenName, @groupMenuTitle, @read, @write, @delete
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
			SELECT * FROM (
				SELECT DISTINCT SCR.screenId, SCR.screenActionName, ISNULL(DP.screenName, SCR.screenActionName) AS ScreenName, 
				CAST(ISNULL(DP.isRead, ISNULL(SCR.defaultReadAccess, 0)) AS BIT) AS isRead, CAST(ISNULL(DP.isWrite, ISNULL(SCR.defaultWriteAccess, 0)) AS BIT) AS isWrite, 
				CAST(ISNULL(DP.canDelete, ISNULL(SCR.defaultDeleteAccess, 0)) AS BIT) AS isDelete,
				DP.parentScreenId AS parentScreenId, DP.linkIcon AS linkIcon, DP.linkOrder AS linkOrder  FROM appDefaulPermisionScreens DP
				RIGHT JOIN appScreens SCR ON DP.screenId = SCR.screenId 
			) AS A
			WHERE A.screenId = @screenId 						
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
		linkOrder INT,
		groupMenuTitle VARCHAR(200)
	)
	
	IF LOWER(@userId) <> 'all Users'
	BEGIN
		IF EXISTS (SELECT userId FROM appUsersCredentials WHERE userId = @userid AND CompanyId = @companyId)
		BEGIN
			INSERT INTO @tblUserpermissions (screenId, screenActionName, screenName, isRead, isWrite, canDelete, parentScreenId, linkIcon, linkOrder, groupMenuTitle) 
			SELECT DISTINCT ASCR.screenId, ASCR.screenActionName, ISNULL(ASCR.screenName, ASCR.screenActionName) AS ScreenName, ISNULL(AUP.isRead,0) AS isRead, 
			ISNULL(AUP.isWrite,0) AS isWrite, ISNULL(AUP.canDelete,0) AS canDelete, AUP.parentScreenId AS parentScreenId, AUP.linkIcon AS linkIcon, 
			AUP.linkOrder, ASCR.menuTitle AS linkOrder FROM appScreens ASCR
			INNER JOIN appUserPermissions AUP ON ASCR.screenId = AUP.screenId WHERE AUP.userId = @userId AND AUP.CompanyId = @companyId			
		END

		SELECT screenId, screenActionName, screenName + ' ('+ groupMenuTitle +')' AS screenName, isRead, isWrite, canDelete, parentScreenId, linkIcon, linkOrder FROM @tblUserpermissions
		UNION
		SELECT DISTINCT SCR.screenId, SCR.screenActionName, ISNULL(SCR.screenName, SCR.screenActionName) + ' ('+ SCR.menuTitle +')' AS ScreenName, CAST(ISNULL(DP.isRead, 0) AS BIT) AS isRead, CAST(ISNULL(DP.isWrite, 0) AS BIT) AS isWrite, CAST(ISNULL(DP.canDelete,0) AS BIT) AS canDelete, DP.parentScreenId AS parentScreenId, DP.linkIcon AS linkIcon, DP.linkOrder AS linkOrder  FROM appDefaulPermisionScreens DP
		RIGHT JOIN appScreens SCR ON DP.screenId = SCR.screenId	AND DP.CompanyId = @companyId WHERE SCR.screenId NOT IN (SELECT DISTINCT screenId FROM @tblUserpermissions) --AND CompanyId = @companyId		
	END
	ELSE
	BEGIN
		SELECT DISTINCT SCR.screenId, SCR.screenActionName, ISNULL(SCR.screenName, SCR.screenActionName) AS ScreenName, CAST(ISNULL(DP.isRead, 0) AS BIT) AS isRead, CAST(ISNULL(DP.isWrite, 0) AS BIT) AS isWrite, CAST(ISNULL(DP.canDelete,0) AS BIT) AS canDelete, DP.parentScreenId AS parentScreenId, DP.linkIcon AS linkIcon, DP.linkOrder AS linkOrder  FROM appDefaulPermisionScreens DP		
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
		groupMenuTitle VARCHAR(100),
		linkOrderId INT,
		linkIcon VARCHAR(200)	
	)
	INSERT INTO @userScreens(screenId, linkOrder, ActionLinkText, ActionName, ControllerName, AreaName, linkIcon, groupMenuTitle)
	SELECT DISTINCT S.screenId, UP.linkOrder, ISNULL(S.screenName, S.screenActionName) AS ActionLinkText, S.screenActionName AS ActionName, S.screenControllerName AS ControllerName, 
	S.screenAreaName AS AreaName, UP.linkIcon AS LinkIcon, S.menuTitle   
	FROM appScreens S INNER JOIN appUserPermissions UP ON S.screenId = UP.screenId 	
	INNER JOIN appUsersCredentials UC ON UC.userId = UP.userId	 
	AND UC.CompanyId = UP.CompanyId
	WHERE (isRead = 1 OR isWrite =1 OR canDelete = 1) AND UP.userId = @userId AND UP.CompanyId = @companyId ORDER BY UP.linkOrder ASC	

	SELECT DISTINCT ControllerName, linkOrderId, ISNULL(GroupMenuTitle, ControllerName) AS GroupMenuTitle FROM (
	SELECT screenId, ActionLinkText, ActionName, ControllerName, AreaName, linkIcon, linkOrder AS linkOrderId, GroupMenuTitle FROM @userScreens 
	UNION
	SELECT screenId, ActionLinkText, ActionName, ControllerName, AreaName, linkIcon, ISNULL(linkOrder, 0) AS linkOrderId, GroupMenuTitle FROM (
				SELECT SCR.screenId, ISNULL(SCR.screenName, SCR.screenActionName) AS ActionLinkText, SCR.screenActionName AS ActionName, 
				SCR.screenControllerName AS ControllerName, SCR.screenAreaName AS AreaName,
				CAST(ISNULL(DP.isRead, ISNULL(SCR.defaultReadAccess, 0)) AS BIT) AS isRead, CAST(ISNULL(DP.isWrite, ISNULL(SCR.defaultWriteAccess, 0)) AS BIT) AS isWrite, 
				CAST(ISNULL(DP.canDelete, ISNULL(SCR.defaultDeleteAccess, 0)) AS BIT) AS isDelete,				
				DP.parentScreenId AS parentScreenId, DP.linkIcon AS linkIcon, DP.linkOrder AS linkOrder, SCR.menuTitle AS GroupMenuTitle  FROM appDefaulPermisionScreens DP
				RIGHT JOIN appScreens SCR ON DP.screenId = SCR.screenId 
			) 
			AS DEFPER
			WHERE (isRead = 1 OR isWrite = 1 OR isDelete = 1)
			AND DEFPER.screenId NOT IN (SELECT screenId FROM appUserPermissions WHERE userId = @userId AND companyId = @companyId)
	) AS UserScreens ORDER BY linkOrderId
			
	SELECT screenId, ActionLinkText, ActionName, ControllerName, AreaName, ISNULL(linkIcon, '') AS linkIcon, ISNULL(linkOrder, 0) AS linkOrderId, GroupMenuTitle 
	FROM @userScreens 
	UNION	
			SELECT screenId, ActionLinkText, ActionName, ControllerName, AreaName, ISNULL(linkIcon, 'icon-tasks') AS linkIcon, ISNULL(linkOrder, 0) AS linkOrderId, GroupMenuTitle FROM (
			SELECT SCR.screenId, ISNULL(SCR.screenName, SCR.screenActionName) AS ActionLinkText, SCR.screenActionName AS ActionName, 
			SCR.screenControllerName AS ControllerName, SCR.screenAreaName AS AreaName,
			CAST(ISNULL(DP.isRead, ISNULL(SCR.defaultReadAccess, 0)) AS BIT) AS isRead, CAST(ISNULL(DP.isWrite, ISNULL(SCR.defaultWriteAccess, 0)) AS BIT) AS isWrite, 
			CAST(ISNULL(DP.canDelete, ISNULL(SCR.defaultDeleteAccess, 0)) AS BIT) AS isDelete,				
			DP.parentScreenId AS parentScreenId, DP.linkIcon AS linkIcon, DP.linkOrder AS linkOrder, SCR.menuTitle AS GroupMenuTitle  FROM appDefaulPermisionScreens DP
			RIGHT JOIN appScreens SCR ON DP.screenId = SCR.screenId 
			) 
			AS DEFPER
			WHERE (isRead = 1 OR isWrite = 1 OR isDelete = 1)
			AND DEFPER.screenId NOT IN (SELECT screenId FROM appUserPermissions WHERE userId = @userId AND companyId = @companyId)
	ORDER BY linkOrderId
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
			INSERT INTO appUserPermissions(userId, screenId, linkIcon, CompanyId) 
			SELECT @userId, @screenId, @updateParam, @companyId
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
			UPDATE appUserPermissions SET linkIcon = @updateParam WHERE screenId = @screenId AND CompanyId = @companyId 
		END
		ELSE
		BEGIN
			UPDATE appUserPermissions SET linkIcon = @updateParam WHERE screenId = @screenId AND userId = @userId AND CompanyId = @companyId 
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
			UPDATE appUserPermissions SET linkOrder = @updateParam WHERE screenId = @screenId AND userId = @userId AND CompanyId = @companyId 
		END
		ELSE
		BEGIN
			UPDATE appUserPermissions SET linkOrder = @updateParam WHERE screenId = @screenId AND userId = @userId AND CompanyId = @companyId 
		END
	END
END
GO

--Revoke the existing permissions for selected user
IF OBJECT_ID(N'bspRevokeAllPermissionByUser') IS NOT NULL
BEGIN
DROP PROC bspRevokeAllPermissionByUser
END
GO
CREATE PROCEDURE bspRevokeAllPermissionByUser
(
	@userId VARCHAR(200),
	@companyId INT = NULL
)
AS
BEGIN
	UPDATE appUserPermissions SET isRead = 0,
								  isWrite = 0,									
								  canDelete = 0
	WHERE UserId = @userId AND CompanyId = @companyId
END
GO