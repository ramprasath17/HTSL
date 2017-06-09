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
		SELECT UC.UserId, ISNULL(UI.DisplayName, 'UnKnown') AS userName, ISNULL(UC.companyId, 0) AS CompanyId, 
		ISNULL((SELECT companyName FROM appCompany WHERE companyId = UC.companyId), 'Not Asssigned') AS CompanyName, 
		'' AS InviteStatus, '' AS ShowToInvite,
		UC.Email AS EmailId
		FROM appUsersCredentials UC 
		INNER JOIN appUserInformation UI ON UC.UserId = UI.UserId 
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
	@invitationType CHAR,
	@invitationId INT = NULL
)
AS
BEGIN
	UPDATE appUsersCredentials SET companyId = (SELECT companyid FROM appcompany WHERE companyId = @companyId) WHERE userid = @userId
	
	EXEC bspRevokeAllPermissionByUser @userId, @companyId	
	
	UPDATE appInvitationLog SET IsAccepted = 1 WHERE InvitationId = @invitationId 	
END
GO

IF OBJECT_ID('bspGetUsersByUserName', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetUsersByUserName
END
GO
CREATE PROCEDURE bspGetUsersByUserName  
(  
	@userName VARCHAR(MAX) = NULL,
	@loggedInUser VARCHAR(20),
	@companyId INT   
)  
AS  
SET NOCOUNT ON  
BEGIN  
 SELECT UC.UserId, ISNULL(UI.DisplayName, 'UnKnown') AS userName,
 (SELECT companyName from appCompany WHERE companyId = UC.companyId) AS CompanyName, CAST(1 AS BIT) AS IsActive,
 CAST((CASE WHEN UC.CompanyId = @companyId THEN 0 ELSE 1 END) AS BIT) AS ShowToInvite, ISNULL(IL.InvitationStatus, 0) AS InviteStatus
 FROM appUsersCredentials UC 
 INNER JOIN appUserInformation UI ON UC.UserId = UI.UserId
 LEFT JOIN appInvitationLog IL ON IL.InvitedUserID = UC.UserId AND IL.InvitedBy = @loggedInUser 
 WHERE UI.DisplayName LIKE @userName + '%' OR UC.UserId LIKE @userName + '%'
END  
GO

IF OBJECT_ID('bspLogInvitation', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspLogInvitation
END
GO
CREATE PROCEDURE bspLogInvitation
(
	@InvitedUserId VARCHAR(20),
	@InvitedByUserId VARCHAR(20),
	@InvitedCompanyId INT,
	@InvitedByCompanyID INT
)
AS
BEGIN
	INSERT INTO appInvitationLog (InvitedUserID, InvitedBy, InvitedCompanyId, InvitedByCompanyId)
	SELECT @InvitedUserId, @InvitedByUserId, @InvitedCompanyId, @InvitedByCompanyID
END
GO