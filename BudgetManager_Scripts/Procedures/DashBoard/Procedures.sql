--Get Expense Details
IF OBJECT_ID('bspGetDashboardBudgetSummary', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetDashboardBudgetSummary
END
GO
Create PROCEDURE bspGetDashboardBudgetSummary
(
	@userId VARCHAR(20),
	@companyId INT	
)
AS
BEGIN
	DECLARE @BudgetCount INT 
	SELECT @BudgetCount = COUNT(DISTINCT BudgetID) FROM Budgets WHERE CompanyId = @companyId
	
	DECLARE @UserCount INT 
	SELECT @UserCount = COUNT(UserId) FROM appUsersCredentials WHERE CompanyId = @companyId
	
	DECLARE @GroupCount INT
	SELECT @GroupCount = COUNT(GroupId) FROM appUserGroups WHERE CompanyId = @companyId
	
	SELECT @BudgetCount AS BudgetCount, @UserCount AS UserCount, @GroupCount AS GroupCount
	
	--SELECT Name, (CAST(MinAmount AS VARCHAR) + ' / ' +CAST(MaxAmount AS VARCHAR)) AS BudgetAmount, '#68BC31' AS Color FROM budgets
	SELECT Name, CAST(MinAmount AS VARCHAR) AS BudgetAmount, '#68BC31' AS Color FROM budgets WHERE CompanyId = @companyId
	
END
GO





