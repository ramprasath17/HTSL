exec bspAuthorizeUserLogIn 'venkat', 'FK+2FmWv17Yz5xq8JsL1Gw=='

select UserId FROM appUsersCredentials WHERE UserId = 'venkat' AND PassKey = 'FK+2FmWv17Yz5xq8JsL1Gw=='



--passWord
INSERT INTO appRoles(roleId, roleName, roleDescription)
SELECT 1, 'Governor', 'These users can assign roles and can access the entire data available in the application.'
INSERT INTO appRoles(roleId, roleName, roleDescription)
SELECT 2, 'Creator', 'These users can create and edit the budgets created by them.'
INSERT INTO appRoles(roleId, roleName, roleDescription)
SELECT 3, 'Viewers', 'These users only can view the budget data.'

select * from appRoles

INSERT INTO appUsersCredentials(UserId, PassKey)
VALUES ('venkat', 'FK+2FmWv17Yz5xq8JsL1Gw==')

SELECT * FROM appUsersCredentials

INSERT INTO appUserInformation (UserId, FirstName, MiddleName, LastName, PetName, ShowPetName)
SELECT 'venkat', 'Venkatesh', 'Navaneetha', 'Krishnan', 'VenuKat', 1

SELECT * FROM appUserInformation



exec bspAuthorizeUserLogIn 'venkatesh', 'aZABLJJlzi5QwhxRAUIFvw=='

SELECT UserId FROM appUsersCredentials WHERE UserId = 'venkatesh' AND PassKey = 'aZABLJJlzi5QwhxRAUIFvw=='