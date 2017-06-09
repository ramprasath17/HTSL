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

IF OBJECT_ID(N'bspResetPassword') IS NOT NULL
BEGIN
	DROP PROC bspResetPassword
END
GO
CREATE PROCEDURE bspResetPassword
(
	@emailId VARCHAR(200),
	@newKey VARCHAR(100)		
)
AS
SET NOCOUNT ON
BEGIN
	UPDATE appUsersCredentials SET PassKey = @newKey WHERE Email = @emailId
	SELECT UC.PassKey, UI.DisplayName FROM appUsersCredentials UC INNER JOIN appUserInformation UI ON UC.UserId = UI.UserId WHERE UC.Email = @emailId
END
GO

IF OBJECT_ID(N'bspGetAccountSettingsData') IS NOT NULL
BEGIN
	DROP PROC bspGetAccountSettingsData
END
GO
CREATE PROCEDURE bspGetAccountSettingsData
(
	@userId VARCHAR(20),
	@companyId VARCHAR(100)
)
AS
SET NOCOUNT ON
BEGIN
	SELECT DISTINCT UC.UserId AS UserName, ISNULL(UI.DisplayName, 'UnKnown') AS DisplayName,ISNULL(UI.FirstName, ISNULL(UI.DisplayName, 'UnKnown')) AS FirstName, UI.MiddleName, UI.LastName,
	PassKey AS CurrentPassword, CAST(1 AS BIT) AS AllowInvites,
	UI.DoB AS DateOfBirth, UI.PhoneNumber AS Phone, UI.Gender, UI.PetName AS PetName,
	UC.Email, UI.Country, UI.Mobile,
	UI.AddressLine1, UI.AddressLine2, UI.City, UI.PinCode,
	UC.companyId AS CompanyId, (SELECT companyName FROM appCompany WHERE companyId = UC.companyId) AS CompanyName
	FROM appUsersCredentials UC LEFT JOIN appUserInformation UI 
	ON UC.UserId = UI.UserId 
	WHERE UC.UserId = @userId AND UC.CompanyId = @companyId	
END
GO

IF OBJECT_ID(N'bspUpdateAccountSettingsData') IS NOT NULL
BEGIN
	DROP PROC bspUpdateAccountSettingsData
END
GO
CREATE PROCEDURE bspUpdateAccountSettingsData
(
	@userId VARCHAR(20),
	@FirstName	VARCHAR(30) = NULL,
	@MiddleName	VARCHAR(30) = NULL,
	@LastName	VARCHAR(30) = NULL,
	@PetName	VARCHAR(20) = NULL,	
	@AddressLine1	VARCHAR(30) = NULL,
	@AddressLine2	VARCHAR(30) = NULL,
	@City	VARCHAR(30) = NULL,
	@DoB	DATETIME = NULL,
	@PinCode	VARCHAR(10) = NULL,
	@Country	VARCHAR(100) = NULL,
	@PhoneNumber	VARCHAR(30) = NULL,
	@Mobile	VARCHAR(15) = NULL,
	@Gender	CHAR = NULL,
	@SecretQuestion	VARCHAR(150) = NULL,
	@SecretAnswer	VARCHAR(50) = NULL,
	@OldPassword VARCHAR(100) = NULL,
	@NewPassword VARCHAR(100) = NULL,	
	@ShowPetName	BIT = 0,
	@companyId VARCHAR(100) = NULL
)
AS
SET NOCOUNT ON
BEGIN
	--Update user information
	UPDATE appUserInformation SET DoB = @DoB,
							PhoneNumber = @PhoneNumber,
							Gender = @Gender,
							AddressLine1 = @AddressLine1,
							AddressLine2 = @AddressLine2,
							City = @City,
							PinCode = @PinCode,
							Country = @Country,
							Mobile = @Mobile,
							FirstName = @FirstName,
							MiddleName = @MiddleName,
							LastName = @LastName,
							UserId = @userId							
							FROM appUserInformation UI INNER JOIN
							appUsersCredentials UC ON UI.UserId = UC.UserId 
	WHERE UC.UserId = @userId AND UC.CompanyId = @companyId
	
	--Update password
	IF((@OldPassword IS NOT NULL AND @OldPassword <> '') AND (@NewPassword IS NOT NULL AND @NewPassword <> ''))
	BEGIN
		UPDATE appUsersCredentials SET PassKey = @NewPassword
		WHERE PassKey = @OldPassword AND UserId = @userId AND CompanyId = @companyId
	END
END
GO

IF OBJECT_ID(N'bspCheckIsValidPassword') IS NOT NULL
BEGIN
	DROP PROC bspCheckIsValidPassword
END
GO
CREATE PROCEDURE bspCheckIsValidPassword
(
	@userId VARCHAR(20),
	@companyId VARCHAR(100),
	@currentPassword VARCHAR(100)
)
AS
SET NOCOUNT ON
BEGIN
	SELECT 1 FROM appUsersCredentials WHERE UserId = @userId AND CompanyId = @companyId AND PassKey = @currentPassword AND IsEmailVerified = 1
END
GO