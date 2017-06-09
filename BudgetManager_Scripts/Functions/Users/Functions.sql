IF OBJECT_ID('bfnGetUsersInExpenditure', 'IF') IS NOT NULL
BEGIN
	DROP FUNCTION bfnGetUsersInExpenditure
END
GO
CREATE FUNCTION [dbo].[bfnGetUsersInExpenditure]
(
	@companyId INT
)
RETURNS TABLE 
AS
RETURN
(
	SELECT DISTINCT  GU.UserId AS Value, ISNULL(UIF.DisplayName, 'UnKnown') AS [Text]
			FROM appUsersIncludedInExpenditure UI 
			INNER JOIN appExpenses E 
			ON UI.ExpenseId = E.ExpenseId
			INNER JOIN budgets B ON E.budgetId = B.BudgetId
			LEFT JOIN appGroupedUsers GU 
			ON UI.UserGroupId = GU.GroupId AND GU.CompanyId = @CompanyId
			INNER JOIN appUserInformation UIF ON GU.UserId = UIF.UserId
			WHERE GU.UserId NOT IN (
			SELECT UIE.ExcludedUserId FROM appGroupedUsers GU 
			INNER JOIN 
			appUsersIncludedInExpenditure UIE 
			ON UIE.ExpenseId = E.ExpenseId
			WHERE CompanyId = @CompanyId AND UIE.UserGroupId IS NULL)
)
GO

IF OBJECT_ID('bfnGetUsersInExpennditureInAllGroups', 'TF') IS NOT NULL
BEGIN
	DROP FUNCTION bfnGetUsersInExpennditureInAllGroups
END
GO
CREATE FUNCTION bfnGetUsersInExpennditureInAllGroups
(
	@CompanyId INT
)
RETURNS @usersInGroup TABLE(
	UserId VARCHAR(20),
	DisplayName VARCHAR(200),
	ExpenseId INT,
	GroupId INT,
	BudgetName VARCHAR(200)
)
AS
BEGIN
	INSERT INTO @usersInGroup (UserId, DisplayName, ExpenseId, GroupId, BudgetName)
	SELECT userId, DisplayName, ExpenseId, groupId, BudgetName FROM (
			SELECT DISTINCT  GU.UserId, ISNULL(UIF.DisplayName, 'UnKnown') AS DisplayName, E.ExpenseId, GU.GroupId, B.Name AS BudgetName
			FROM appUsersIncludedInExpenditure UI 
			INNER JOIN appExpenses E 
			ON UI.ExpenseId = E.ExpenseId
			INNER JOIN budgets B ON E.budgetId = B.BudgetId
			LEFT JOIN appGroupedUsers GU 
			ON UI.UserGroupId = GU.GroupId AND GU.CompanyId = @CompanyId
			INNER JOIN appUserInformation UIF ON GU.UserId = UIF.UserId
			WHERE GU.UserId NOT IN (
			SELECT UIE.ExcludedUserId FROM appGroupedUsers GU 
			INNER JOIN 
			appUsersIncludedInExpenditure UIE 
			ON UIE.ExpenseId = E.ExpenseId
			WHERE CompanyId = @CompanyId AND UIE.UserGroupId IS NULL)	
	) AS USERSINEXPENSE ORDER BY ExpenseId, GroupId
	
	RETURN
END
GO
