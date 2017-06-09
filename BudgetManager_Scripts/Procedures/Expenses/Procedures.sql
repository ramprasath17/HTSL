--Get Expense Details
IF OBJECT_ID('bspGetExpenseDetailsLookUps', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetExpenseDetailsLookUps
END
GO
Create PROCEDURE bspGetExpenseDetailsLookUps
(
	@companyId INT	
)
AS
BEGIN
	--User list
	SELECT DISTINCT UC.UserId AS [Value], ISNULL(UI.DisplayName, 'UnKnown') AS [Text]
	FROM appUsersCredentials UC LEFT JOIN appUserInformation UI ON UC.UserId = UI.UserId WHERE UC.CompanyId = @companyId
	
	-- Group List
	SELECT DISTINCT GroupId AS [Value], GroupName AS [Text] FROM appUserGroups WHERE CompanyId = @companyId AND IsActive = 1
	
	-- Budget List
	SELECT DISTINCT BudgetId AS [Value], Name AS [Text] FROM Budgets WHERE CompanyId = @companyId AND IsActive = 1 --AND IsExpired = 0		
END
GO

IF OBJECT_ID('bspAddExpenses', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspAddExpenses
END
GO
Create PROCEDURE bspAddExpenses
(	
	@Description NVARCHAR(50),
	@BudgetCategoryId INT,
	@SpentOn DATETIME,
	@SpentBy VARCHAR(20),
	@SpentAmount MONEY,
	@GroupIds dbo.GroupDataType READONLY,
	@UserIds dbo.UserCollectionDataType READONLY,
	@CreatedBy VARCHAR(20),
	@CompanyId INT		
)
AS
BEGIN
	INSERT INTO appExpenses(BudgetId, SpentOn, SpentBy, SpentAmount, CompanyId, CreatedBy, [Description])
	SELECT @BudgetCategoryId, @SpentOn, @SpentBy, @SpentAmount, @CompanyId, @CreatedBy, @Description
	
	DECLARE @expenseId INT 
	SET @expenseId = @@IDENTITY
	
	INSERT INTO appUsersIncludedInExpenditure(ExpenseId, ExcludedUserId)
	SELECT @expenseId, UserId FROM @UserIds
	
	INSERT INTO appUsersIncludedInExpenditure(ExpenseId, UserGroupId)
	SELECT @expenseId, GroupID FROM @GroupIds
END
GO

IF OBJECT_ID('bspGetExpenses', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetExpenses
END
GO
Create PROCEDURE bspGetExpenses
(
	@CompanyId INT	
)
AS
BEGIN
	SELECT * FROM (
	SELECT ISNULL(UIE.UserGroupId, 0) AS GroupId, E.ExpenseId, B.Name AS BudgetName, C.CategoryName, SpentOn, SpentBy, SpentAmount, E.[Description] 
	FROM appExpenses E INNER JOIN Budgets B 
	ON E.BudgetId = B.BudgetId AND 
	E.CompanyId = B.CompanyId
	INNER JOIN budgetCategory C
	ON B.CategoryId = C.CategoryId
	INNER JOIN appUsersIncludedInExpenditure UIE 
	ON UIE.ExpenseID = E.ExpenseId	
	WHERE UIE.UserGroupId IS NOT NULL AND E.CompanyId = @CompanyId
	) AS EXPENSEDETAILS
	
	SELECT * FROM bfnGetUsersInExpennditureInAllGroups(@CompanyId)
	
	--Look ups
	EXEC bspGetExpenseDetailsLookUps @CompanyId
END
GO

IF OBJECT_ID('bspUpdateExpenditures', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspUpdateExpenditures
END
GO
Create PROCEDURE bspUpdateExpenditures
(
	@Description VARCHAR(200),
	@SpentAmount MONEY,
	@SpentDate DATETIME,
	@BudgeId INT,
	@SpentBy VARCHAR(20),
	@ExpenseId INT,	
	@CompanyId INT	
)
AS
BEGIN
	UPDATE appExpenses SET  budgetId	= @BudgeId,
							SpentAmount	= @SpentAmount,
							SpentOn		= @SpentDate,
							SpentBy		= @SpentBy,
							[Description] = @Description
	WHERE ExpenseId = @ExpenseId AND CompanyId = @CompanyId
END
GO

IF OBJECT_ID('bspGetOverallExpenses', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetOverallExpenses
END
GO
Create PROCEDURE bspGetOverallExpenses
(
	@companyId INT
)
AS
SET NOCOUNT ON
BEGIN 
IF OBJECT_ID(N'tempdb.dbo.#tblUsersInExpense') IS NOT NULL
DROP TABLE #tblUsersInExpense

	SELECT * INTO #tblUsersInExpense FROM bfnGetUsersInExpennditureInAllGroups(@companyId)
	
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
		ON E.ExpenseId = UIE.ExpenseId INNER JOIN #tblUsersInExpense TUIE ON UIE.ExpenseId = TUIE.ExpenseId WHERE E.CompanyId = @companyId
	) AS Expense
	GROUP BY ExpenseId, Spentby, UserId, BudgetId) AS T1
	
	LEFT JOIN
	
	(Select expenseId, AmountReturnedBy, AmountReceivedBy, CompanyId, ISNULL(SUM(AmountReturned), 0) AS AmountReturned FROM appTransactions 
	GROUP BY expenseId, AmountReturnedBy, AmountReceivedBy, CompanyId) AS T2	
	ON T1.ExpenseId = T2.ExpenseId AND (T1.userId = T2.AmountReturnedBy OR T1.SpentBy = T1.userId)
)	AS OVERALLEXPENSE ORDER BY ExpenseId
END
GO

IF OBJECT_ID('bspGetMatchingExpenses', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetMatchingExpenses
END
GO
CREATE PROCEDURE bspGetMatchingExpenses
(
	@expenseIdCollection dbo.ExpenseIdCollection READONLY
)
AS
SET NOCOUNT ON
BEGIN 
IF OBJECT_ID(N'tempdb.dbo.#tblUsersInExpense') IS NOT NULL
DROP TABLE #tblUsersInExpense

DECLARE @CompanyId INT
SET @CompanyId = 1
	SELECT * INTO #tblUsersInExpense FROM bfnGetUsersInExpennditureInAllGroups(@companyId)
	
SELECT userId, SUM(SpentAmount), SUM(AmountInReturn) 
FROM (
		SELECT ExpenseId, userId, SUM(spentamountBySpendee) AS spentAmount, SpentBy,
		(SUM(spentamountBySpendee) - SUM(spentAmount)/(SELECT COUNT(userId) FROM #tblUsersInExpense TUE WHERE TUE.expenseId = Expense.ExpenseId)) AS AmountInReturn
		FROM (
				SELECT DISTINCT userId, spentby, (CASE WHEN spentby = userId THEN spentamount ELSE 0 END) AS spentamountBySpendee , 
				spentamount, UIE.expenseId FROM appExpenses E INNER JOIN appUsersIncludedInExpenditure UIE 
				ON E.ExpenseId = UIE.ExpenseId INNER JOIN #tblUsersInExpense TUIE ON UIE.ExpenseId = TUIE.ExpenseId
  			  ) AS Expense 
  		GROUP BY expenseId, spentby, userId
	  ) AS ExpenseByExpenseId 
GROUP BY UserId 
END
GO

IF OBJECT_ID('bspGetExpensesByUserCriteria', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetExpensesByUserCriteria
END
GO
CREATE PROCEDURE bspGetExpensesByUserCriteria
(
	@criteria CHAR(1),
	@fromDate DATETIME = NULL,
	@endDate DATETIME = NULL,
	@expenseId dbo.ExpenseIdCollection READONLY,
	@budgetId INT = NULL,
	@companyId INT
)
AS
SET NOCOUNT ON
BEGIN 
	DECLARE @expenseIdCollection dbo.ExpenseIdCollection 

	IF @criteria = 'D'
	BEGIN
		INSERT INTO @expenseIdCollection(ExpenseId)
		SELECT ExpenseId FROM appExpenses WHERE SpentOn BETWEEN @fromDate AND @endDate
		EXEC bspGetMatchingExpenses @expenseIdCollection
	END
	ELSE IF @criteria = 'E'
	BEGIN
		EXEC bspGetMatchingExpenses @expenseId
	END
	ELSE IF @criteria = 'B'
	BEGIN
		INSERT INTO @expenseIdCollection(ExpenseId)
		SELECT ExpenseId FROM appExpenses WHERE BudgetId = @budgetId
		EXEC bspGetMatchingExpenses @expenseIdCollection	
	END
END
GO

IF OBJECT_ID('bspGetAllMyExpenses', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetAllMyExpenses
END
GO
CREATE PROCEDURE bspGetAllMyExpenses
(
	@companyId INT
)
AS
SET NOCOUNT ON
BEGIN
	SELECT DISTINCT ExpenseId, Description FROM appExpenses WHERE CompanyId = @companyId
END
GO
IF OBJECT_ID('bspGetExpenseByGroup', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetExpenseByGroup
END
GO
Create PROCEDURE bspGetExpenseByGroup
(
	@groupId INT,
	@companyId INT
)
AS
SET NOCOUNT ON
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
			WHERE CompanyId = @companyId AND UIE.UserGroupId IS NULL) AND GU.groupId = @groupId	
			
	) AS USERSINEXPENSE ORDER BY ExpenseId, GroupId
	
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
		ON E.ExpenseId = UIE.ExpenseId INNER JOIN #tblUsersInExpense TUIE ON UIE.ExpenseId = TUIE.ExpenseId WHERE E.CompanyId = @companyId
	) AS Expense
	GROUP BY ExpenseId, Spentby, UserId, BudgetId) AS T1
	
	LEFT JOIN
	
	(Select expenseId, AmountReturnedBy, AmountReceivedBy, CompanyId, ISNULL(SUM(AmountReturned), 0) AS AmountReturned FROM appTransactions 
	GROUP BY expenseId, AmountReturnedBy, AmountReceivedBy, CompanyId) AS T2	
	ON T1.ExpenseId = T2.ExpenseId
)	AS OVERALLEXPENSE ORDER BY ExpenseId
END
GO

-- Check whether user inputted/remittance amount is greater than actual amount if so restrict
IF OBJECT_ID('bspCheckAmountBeyondLevel', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspCheckAmountBeyondLevel
END
GO
CREATE PROCEDURE bspCheckAmountBeyondLevel  
( 
	@expenseId INT,
	@amountReturned MONEY,
	@companyId INT,
	@amountReturnedBy VARCHAR(20),
	@amountReceivedBy VARCHAR(20) = NULL
)
AS
SET NOCOUNT ON
BEGIN
	
	IF OBJECT_ID('tempdb.dbo.#overallExpenses', 'U') IS NOT NULL
	BEGIN
		DROP TABLE #overallExpenses
	END

	CREATE TABLE #overallExpenses
	(
		ExpenseId INT,
		[Description] VARCHAR(200),
		SpentOn datetime,
		userName VaRCHAR(20),
		SpentAmount MONEY,
		AmountInReturn MONEY,
		AmountToShare MONEY,
		BudgetGroup VARCHAR(200),
		Remittance BIT,
		SpentBy VARCHAR(20)
	)
	INSERT INTO #overallExpenses 
	EXEC dbo.bspGetOverallExpenses @companyId

	SELECT 1 FROM #overallExpenses WHERE ExpenseId = @expenseId AND @amountReturned > AmountInReturn AND userName = @amountReturnedBy
END
GO