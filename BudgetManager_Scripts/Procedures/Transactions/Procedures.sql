
IF OBJECT_ID('bspCreateTransaction', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspCreateTransaction
END
GO
CREATE PROCEDURE bspCreateTransaction
(
	@ExpenseId INT,
	@AmountReturned NUMERIC(12, 0),
	@ReturnedOn DATETIME,
	@AmountReturnedBy VARCHAR(20),
	@AmountReceivedBy VARCHAR(20),
	@Description VARCHAR(300),
	@CompanyId INT	
)
AS 
SET NOCOUNT ON
BEGIN
	INSERT INTO appTransactions(ExpenseId, AmountReturned, ReturnedOn, AmountReturnedBy, AmountReceivedBy, [Description], CompanyId)
	SELECT @ExpenseId, @AmountReturned, @ReturnedOn, @AmountReturnedBy, @AmountReceivedBy, @Description, @CompanyId
END
GO

IF OBJECT_ID('bspGetTransactionLookUpData', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetTransactionLookUpData
END
GO
CREATE PROCEDURE bspGetTransactionLookUpData
(
	@lookupType CHAR(1),
	@lookUpCondition VARCHAR(20),
	@companyId INT
)
AS 
SET NOCOUNT ON
BEGIN
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
			WHERE CompanyId = @companyId AND UIE.UserGroupId IS NULL AND E.ExpenseId = @lookUpCondition) 
END
GO


IF OBJECT_ID('bspGetAllMyTransactions', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetAllMyTransactions
END
GO
CREATE PROCEDURE bspGetAllMyTransactions
(
	@companyId INT
)
AS
SET NOCOUNT ON
BEGIN
	SELECT DISTINCT T.TransactionId, T.ExpenseId, E.Description AS Expense, T.AmountReturned, T.ReturnedOn,
					T.ReturnedOn, T.AmountReturnedBy, T.AmountReceivedBy, T.Description 
	FROM appTransactions T INNER JOIN	
	appExpenses E ON T.ExpenseId = E.ExpenseId	
	WHERE T.CompanyId = @companyId

	SELECT DISTINCT ExpenseId AS Value, Description AS Text FROM appExpenses WHERE CompanyId = @companyId	
	
	SELECT DISTINCT  GU.UserId AS Value, ISNULL(UIF.DisplayName, 'UnKnown') AS Text
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
	
END
GO

IF OBJECT_ID('bspUpdateTransactions', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspUpdateTransactions
END
GO
CREATE PROCEDURE bspUpdateTransactions  
(  
	 @Description VARCHAR(200),  
	 @AmountReturned MONEY,  
	 @AmountReturnedOn DATETIME,  
	 @SelectedExpenseName VARCHAR(50),  
	 @TransactionId INT,   
	 @CompanyId INT   
)  
AS  
SET NOCOUNT ON
BEGIN  
	UPDATE appTransactions SET  Description = @Description,
								AmountReturned = @AmountReturned,
								ReturnedOn = @AmountReturnedOn,
								ExpenseId = @SelectedExpenseName 
	WHERE CompanyId  = @CompanyId AND TransactionId = @TransactionId

END  
GO


IF OBJECT_ID('bspGetAnalysisLookUps', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetAnalysisLookUps
END
GO
CREATE PROCEDURE bspGetAnalysisLookUps  
( 
	@companyId INT
)
AS
SET NOCOUNT ON
BEGIN
	SELECT DISTINCT UC.UserId, ISNULL(UI.DisplayName, 'UnKnown') AS DisplayName
	FROM appUsersCredentials UC LEFT JOIN appUserInformation UI ON UC.UserId = UI.UserId WHERE UC.CompanyId = @companyId
	
	SELECT DISTINCT GroupId, GroupName FROM appUserGroups WHERE CompanyId = @companyId
	
	SELECT DISTINCT ExpenseId, [Description] FROM appExpenses 
END
GO

IF OBJECT_ID('bspGetAnalysisDataByUsers', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetAnalysisDataByUsers
END
GO
CREATE PROCEDURE bspGetAnalysisDataByUsers  
( 
	@amountReturnedBy VARCHAR(20),
	@amountReceivedBy VARCHAR(20),
	@companyId INT
)
AS 
BEGIN
	IF OBJECT_ID(N'tempdb.dbo.#tblUsersInExpense') IS NOT NULL
DROP TABLE #tblUsersInExpense
SELECT * INTO #tblUsersInExpense FROM (
			SELECT DISTINCT  GU.UserId, ISNULL(UIF.DisplayName, 'UnKnown') AS DisplayName, E.ExpenseId, GU.GroupId, B.Name AS BudgetName
			FROM appUsersIncludedInExpenditure UI 
			INNER JOIN appExpenses E 
			ON UI.ExpenseId = E.ExpenseId
			INNER JOIN budgets B ON E.budgetId = B.BudgetId
			LEFT JOIN appGroupedUsers GU 
			ON UI.UserGroupId = GU.GroupId AND GU.CompanyId = E.CompanyId
			INNER JOIN appUserInformation UIF ON GU.UserId = UIF.UserId
			WHERE GU.UserId NOT IN (
			SELECT UIE.ExcludedUserId FROM appGroupedUsers GU 
			INNER JOIN 
			appUsersIncludedInExpenditure UIE 
			ON UIE.ExpenseId = E.ExpenseId
			WHERE CompanyId = @companyId AND UIE.UserGroupId IS NULL)	
			
	) AS USERSINEXPENSE ORDER BY ExpenseId, GroupId
	
	SELECT SUM(AmountInReturn) TotalAmountInReturn, UserName, SpentBy FROM(
	SELECT ExpenseId, (SELECT [Description] FROM appExpenses WHERE ExpenseId = OVERALLEXPENSE.ExpenseId) AS [Description], 
	(SELECT TOP 1 SpentOn FROM appExpenses WHERE ExpenseId = OVERALLEXPENSE.ExpenseId) AS SpentOn,
	UserId AS UserName, SpentAmount, (CASE WHEN AmountInReturn < 0 THEN AmountInReturn*-1 ELSE AmountInReturn END) AS AmountInReturn, AmountToShare,
	(SELECT Name FROM budgets WHERE BudgetId = OVERALLEXPENSE.budgetId ) AS BudgetGroup,
	CAST((CASE WHEN AmountInReturn < 0 THEN 1 ELSE 0 END) AS BIT) AS IsRemittance, Spentby FROM (
	SELECT T1.ExpenseId, T1.UserId, T1.SpentAmount, (CASE WHEN AmountInReturn > 0 THEN T1.AmountInReturn - ISNULL(T2.AmountReturned, 0) ELSE T1.AmountInReturn + ISNULL(T2.AmountReturned, 0) END) AS AmountInReturn,
	T1.Spentby, T1.BudgetId, AmountToShare
	FROM 
	(SELECT ExpenseId, UserId, SUM(AmountBySpendee) AS SpentAmount,
	SUM(SpentAmount) / (SELECT COUNT(userId) FROM #tblUsersInExpense TUE WHERE TUE.expenseId = Expense.ExpenseId) As AmountToShare,
	ISNULL((SUM(AmountBySpendee) - SUM(SpentAmount)/(SELECT COUNT(userId) FROM #tblUsersInExpense TUE WHERE TUE.expenseId =  Expense.ExpenseId)), 0) AS AmountInReturn,		
	Spentby, BudgetId
	FROM 
	(
		SELECT DISTINCT UserId, Spentby, (CASE WHEN Spentby = UserId THEN Spentamount ELSE 0 END) AS AmountBySpendee, BudgetId,
		Spentamount, UIE.expenseId FROM appExpenses E INNER JOIN appUsersIncludedInExpenditure UIE 
		ON E.ExpenseId = UIE.ExpenseId INNER JOIN #tblUsersInExpense TUIE ON UIE.ExpenseId = TUIE.ExpenseId WHERE E.CompanyId = @companyId AND userId = @amountReturnedBy AND SpentBy = @amountReceivedBy
	) AS Expense
	GROUP BY ExpenseId, Spentby, UserId, BudgetId) AS T1
	
	LEFT JOIN
	
	(Select expenseId, AmountReturnedBy, AmountReceivedBy, CompanyId, ISNULL(SUM(AmountReturned), 0) AS AmountReturned FROM appTransactions 
	WHERE AmountReturnedBy = @amountReturnedBy AND AmountReceivedBy = @amountReceivedBy GROUP BY expenseId, AmountReturnedBy, AmountReceivedBy, CompanyId) AS T2	
	ON T1.ExpenseId = T2.ExpenseId
)	AS OVERALLEXPENSE
) AS A
GROUP BY UserName, SpentBy
END
GO

IF OBJECT_ID('bspGetAnalysisData', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetAnalysisData
END
GO
CREATE PROCEDURE bspGetAnalysisData  
( 
	@user1 VARCHAR(20),
	@user2 VARCHAR(20),
	@groupId INT = NULL,
	@expenseId INT = NULL,
	@from DATETIME = NULL,
	@to DATETIME = NULL,
	@action INT,
	@companyId INT
)
AS
SET NOCOUNT ON
BEGIN
	DECLARE @userChangeTemp VARCHAR(20)
	IF @action = 1
	BEGIN
		SET @userChangeTemp = @user1
		SET @user1 = @user2
		SET @user2 = @userChangeTemp
	END

DECLARE @conditionalClause NVARCHAR(MAX)
	DECLARE @conditionalClause1 NVARCHAR(MAX)
	SET @conditionalClause = CASE WHEN @expenseId IS NOT NULL THEN 'AND E.ExpenseId = ' + CAST(@expenseId AS VARCHAR) ELSE '' END
	IF @groupId IS NOT NULL
	BEGIN
		SET @conditionalClause = @conditionalClause + ' AND GU.GroupId = '+ CAST(@groupId AS VARCHAR)
	END
DECLARE @tempTable NVARCHAR(MAX)
SET @tempTable = '
IF OBJECT_ID(N''tempdb.dbo.#tblUsersInExpense'') IS NOT NULL
DROP TABLE #tblUsersInExpense
SELECT * INTO #tblUsersInExpense FROM (
			SELECT DISTINCT  GU.UserId, ISNULL(UIF.DisplayName, ''UnKnown'') AS DisplayName, E.ExpenseId, GU.GroupId, B.Name AS BudgetName
			FROM appUsersIncludedInExpenditure UI 
			INNER JOIN appExpenses E 
			ON UI.ExpenseId = E.ExpenseId
			INNER JOIN budgets B ON E.budgetId = B.BudgetId
			LEFT JOIN appGroupedUsers GU 
			ON UI.UserGroupId = GU.GroupId AND GU.CompanyId = E.CompanyId ' + @conditionalClause + '
			INNER JOIN appUserInformation UIF ON GU.UserId = UIF.UserId
			WHERE GU.UserId NOT IN (
			SELECT UIE.ExcludedUserId FROM appGroupedUsers GU 
			INNER JOIN 
			appUsersIncludedInExpenditure UIE 
			ON UIE.ExpenseId = E.ExpenseId
			WHERE CompanyId = '+ CAST(@companyId AS VARCHAR)+' AND UIE.UserGroupId IS NULL)
			
	) AS USERSINEXPENSE ORDER BY ExpenseId, GroupId'
	
	SET @conditionalClause = 'AND userId ='''+ @user1 +''' AND SpentBy = '''+ @user2 + ''''
	SET @conditionalClause1 = 'AmountReturnedBy = ''' + @user1 + ''' AND AmountReceivedBy = '''+ @user2 + ''''
	DECLARE @analysisQuery NVARCHAR(MAX)
	SET @analysisQuery = '	
	SELECT SUM(AmountInReturn) TotalAmountInReturn, UserName, SpentBy FROM(
	SELECT * FROM (
	SELECT ExpenseId, (SELECT [Description] FROM appExpenses WHERE ExpenseId = OVERALLEXPENSE.ExpenseId) AS [Description], 
	(SELECT TOP 1 SpentOn FROM appExpenses WHERE ExpenseId = OVERALLEXPENSE.ExpenseId) AS SpentOn,
	UserId AS UserName, SpentAmount, (CASE WHEN AmountInReturn < 0 THEN AmountInReturn*-1 ELSE AmountInReturn END) AS AmountInReturn, AmountToShare,
	(SELECT Name FROM budgets WHERE BudgetId = OVERALLEXPENSE.budgetId ) AS BudgetGroup,
	CAST((CASE WHEN AmountInReturn < 0 THEN 1 ELSE 0 END) AS BIT) AS IsRemittance, Spentby FROM (
	SELECT T1.ExpenseId, T1.UserId, T1.SpentAmount, (CASE WHEN AmountInReturn > 0 THEN T1.AmountInReturn - ISNULL(T2.AmountReturned, 0) ELSE T1.AmountInReturn + ISNULL(T2.AmountReturned, 0) END) AS AmountInReturn,
	T1.Spentby, T1.BudgetId, AmountToShare
	FROM 
	(SELECT ExpenseId, UserId, SUM(AmountBySpendee) AS SpentAmount,
	SUM(SpentAmount) / (SELECT COUNT(userId) FROM #tblUsersInExpense TUE WHERE TUE.expenseId = Expense.ExpenseId) As AmountToShare,
	ISNULL((SUM(AmountBySpendee) - SUM(SpentAmount)/(SELECT COUNT(userId) FROM #tblUsersInExpense TUE WHERE TUE.expenseId =  Expense.ExpenseId)), 0) AS AmountInReturn,		
	Spentby, BudgetId
	FROM 
	(
		SELECT DISTINCT UserId, Spentby, (CASE WHEN Spentby = UserId THEN Spentamount ELSE 0 END) AS AmountBySpendee, BudgetId,
		Spentamount, UIE.expenseId FROM appExpenses E INNER JOIN appUsersIncludedInExpenditure UIE 
		ON E.ExpenseId = UIE.ExpenseId INNER JOIN #tblUsersInExpense TUIE ON UIE.ExpenseId = TUIE.ExpenseId WHERE E.CompanyId = '+ CAST(@companyId AS VARCHAR) + @conditionalClause + '
	) AS Expense
	GROUP BY ExpenseId, Spentby, UserId, BudgetId) AS T1
	
	LEFT JOIN
	
	(Select expenseId, AmountReturnedBy, AmountReceivedBy, CompanyId, ISNULL(SUM(AmountReturned), 0) AS AmountReturned FROM appTransactions 
	WHERE ' + @conditionalClause1 + ' GROUP BY expenseId, AmountReturnedBy, AmountReceivedBy, CompanyId) AS T2	
	ON T1.ExpenseId = T2.ExpenseId AND (T1.userId = T2.AmountReturnedBy OR T1.SpentBy = T1.userId)
)	AS OVERALLEXPENSE
) AS A
WHERE A.IsRemittance = CASE WHEN '+ CAST(@action AS VARCHAR)+ ' = 1 THEN 1 ELSE 0 END
) AS B
GROUP BY UserName, SpentBy'

SET @tempTable = @tempTable + @analysisQuery
PRINT @tempTable
 EXEC sp_executesql @tempTable
END
GO
