--Delete selected record of the selected component
IF OBJECT_ID('bspDeleteRecordOfSelectedComponent', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspDeleteRecordOfSelectedComponent
END
GO
CREATE PROCEDURE bspDeleteRecordOfSelectedComponent
(
	@recordId VARCHAR(20),
	@componentType CHAR(1),
	@companyId INT
)
AS
SET NOCOUNT ON
BEGIN
	IF @componentType = 'B'
	BEGIN
		DELETE FROM budgets WHERE BudgetId = @recordId AND CompanyId = @companyId
	END
	ELSE IF @componentType = 'G'
	BEGIN
		DELETE FROM appUserGroups WHERE groupId = @recordId
	END
	ELSE IF @componentType = 'U'
	BEGIN		
		DELETE FROM appUserInformation WHERE UserId=@recordId
		UPDATE appCompany SET OwnedBy = NULL WHERE CompanyId = @companyId
		DELETE FROM appCompany WHERE CompanyId = @companyId
		DELETE FROM appUserPermissions WHERE userId=@recordId AND CompanyId = @companyId
		DELETE FROM appUsersCredentials WHERE UserId=@recordId AND CompanyId = @companyId
	END
	ELSE IF @componentType = 'C'
	BEGIN
		DELETE FROM budgetCategory WHERE CategoryId = @recordId AND CompanyId = @companyId
	END
	ELSE IF @componentType = 'E'
	BEGIN
		DELETE FROM appUsersIncludedInExpenditure WHERE ExpenseId = @recordId 
		DELETE FROM appExpenses WHERE ExpenseId = @recordId AND CompanyId = @companyId
	END
	ELSE IF @componentType = 'T'
	BEGIN
		--DELETE FROM appUsersIncludedInExpenditure WHERE ExpenseId = @recordId 
		DELETE FROM appTransactions WHERE TransactionId = @recordId AND CompanyId = @companyId
	END	
END
GO