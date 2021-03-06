USE [BudgetManager]
GO
/****** Object:  Table [dbo].[appUsersCredentials]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appUsersCredentials](
	[UserId] [varchar](20) NOT NULL,
	[PassKey] [nvarchar](100) NULL,
	[Email] [varchar](100) NULL,
	[IsEmailVerified] [bit] NULL,
	[CompanyId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[budgetCategory]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[budgetCategory](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](200) NULL,
	[CompanyId] [int] NULL,
	[CreatedBy] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[appCompany]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appCompany](
	[CompanyId] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [varchar](30) NULL,
	[CompanyDescription] [varchar](200) NULL,
	[OwnedBy] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[budgets]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[budgets](
	[BudgetId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[Description] [varchar](300) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[MinAmount] [money] NULL,
	[MaxAmount] [money] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [varchar](20) NULL,
	[CategoryId] [int] NULL,
	[IsExpired]  AS (CONVERT([bit],case when getdate()>[endDate] then (1) else (0) end,0)),
	[CompanyId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[BudgetId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[bspCreateBudget]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspCreateBudget]
(
	@BudgetName VARCHAR(100),
	@Description VARCHAR(100) = NULL,
	@minAmount MONEY,
	@maxAmount MONEY,
	@startDate DATETIME,
	@endDate DATETIME,
	@createdby VARCHAR(100),
	@category VARCHAR(20) = NULL,
	@companyId INT = NULL
)
AS
SET NOCOUNT ON
BEGIN
	INSERT INTO budgets(Name, Description, MinAmount, MaxAmount, StartDate, EndDate, CompanyId, createdBy, CategoryId, IsActive)
	SELECT @budgetName, @description, @minAmount, @maxAmount, @startDate, @endDate, @companyId, @createdby, @category, 1	
END
GO
/****** Object:  StoredProcedure [dbo].[bspCheckBudgetAlreadyExists]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspCheckBudgetAlreadyExists]  
(
	@budgetName VARCHAR(200),
	@companyId INT
)
AS
BEGIN
	SELECT 1 FROM Budgets WHERE Name = @budgetName AND CompanyId = @companyId
END
GO
/****** Object:  StoredProcedure [dbo].[bspCreateMyCompany]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspCreateMyCompany]
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
/****** Object:  Table [dbo].[appBudgetGroups]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appBudgetGroups](
	[GroupId] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [varchar](200) NULL,
	[CompanyId] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[appExpenses]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appExpenses](
	[ExpenseId] [int] IDENTITY(1,1) NOT NULL,
	[BudgetId] [int] NULL,
	[SpentOn] [datetime] NULL,
	[SpentBy] [varchar](20) NULL,
	[SpentAmount] [money] NULL,
	[CompanyId] [int] NULL,
	[CreatedBy] [varchar](20) NULL,
	[Description] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ExpenseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[bspGetAllMyExpenses]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetAllMyExpenses]
(
	@companyId INT
)
AS
SET NOCOUNT ON
BEGIN
	SELECT DISTINCT ExpenseId, Description FROM appExpenses WHERE CompanyId = @companyId
END
GO
/****** Object:  StoredProcedure [dbo].[bspCreateBudgetCategory]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspCreateBudgetCategory]  
(  
	@categoryName VARCHAR(100),
	@createdBy VARCHAR(20),
	@companyId INT
)  
AS  
SET NOCOUNT ON  
BEGIN  
 INSERT INTO budgetCategory(CategoryName, CompanyId, CreatedBy)  
 SELECT @categoryName, @companyId, @createdBy
END
GO
/****** Object:  StoredProcedure [dbo].[bspCheckCategoryExists]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspCheckCategoryExists]  
(
	@categoryName VARCHAR(200),
	@companyId INT
)
AS
BEGIN
	SELECT 1 FROM budgetCategory WHERE CategoryName = @categoryName AND CompanyId = @companyId
END
GO
/****** Object:  StoredProcedure [dbo].[bspViewBudget]    Script Date: 06/09/2017 22:33:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspViewBudget]
(
	@userId VARCHAR(20) = NULL,
	@companyId INT = NULL
)
AS
SET NOCOUNT ON
BEGIN
	IF @userId IS NULL
	BEGIN
		SELECT BudgetId, [Name], [Description], StartDate, EndDate, MinAmount, MaxAmount, IsActive, B.CreatedBy, IsExpired, ISNULL(BC.CategoryName, '') AS Category, CAST(0 AS BIT) AS CanExceedMaximumAmount 
		FROM budgets B LEFT JOIN
		budgetCategory BC ON B.CategoryId = BC.CategoryId
		WHERE B.CompanyId = @companyId
		
		SELECT CategoryId, CategoryName FROM budgetCategory		
	END
	ELSE
	BEGIN
		SELECT BudgetId, [Name], [Description], StartDate, EndDate, MinAmount, MaxAmount, IsActive, B.CreatedBy, IsExpired, ISNULL(BC.CategoryName, '') AS Category, CAST(0 AS BIT) AS CanExceedMaximumAmount  
		FROM budgets B LEFT JOIN budgetCategory BC 
		ON B.CategoryId = BC.CategoryId
		WHERE B.CompanyId = @companyId --WHERE CreatedBy = @userId
		
		SELECT CategoryId, CategoryName FROM budgetCategory
	END
END
GO
/****** Object:  StoredProcedure [dbo].[bspUpdateSelectedBudgetRecord]    Script Date: 06/09/2017 22:33:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspUpdateSelectedBudgetRecord]
(
	@budgetName VARCHAR(200),
	@startDate VARCHAR(200),
	@endDate VARCHAR(200),	
	@minAmount NUMERIC(12,2),
	@maxAmount NUMERIC(12,2),
	@isActive BIT,
	@category INT = NULL,
	@budgetId INT,
	@companyId INT
)
AS
SET NOCOUNT ON
SET DATEFORMAT dmy
BEGIN	
	UPDATE budgets SET 
	Name = @budgetName,	
	StartDate = CAST(@startDate AS DATETIME),
	EndDate = CAST(@endDate AS DATETIME),
	MinAmount = @minAmount,
	MaxAmount = @maxAmount,
	IsActive = @isActive,	
	CategoryId = @category	
	WHERE budgetId = @budgetId AND companyId = @companyId
END
GO
/****** Object:  StoredProcedure [dbo].[bspUpdateSelectedBudgetCategoryRecord]    Script Date: 06/09/2017 22:33:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspUpdateSelectedBudgetCategoryRecord]  
(	
	@categoryName VARCHAR(200),
	@categoryId INT,
	@companyId INT
)
AS
BEGIN
	UPDATE budgetCategory SET CategoryName = @categoryName WHERE CategoryId = @categoryId AND CompanyId = @companyId
END
GO
/****** Object:  StoredProcedure [dbo].[bspUpdateExpenditures]    Script Date: 06/09/2017 22:33:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[bspUpdateExpenditures]
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
/****** Object:  Table [dbo].[appInvitationLog]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appInvitationLog](
	[InvitationId] [int] IDENTITY(1,1) NOT NULL,
	[InvitedUserID] [varchar](20) NULL,
	[InvitedBy] [varchar](20) NULL,
	[IsInvited] [bit] NULL,
	[IsAccepted] [bit] NULL,
	[InvitedCompanyId] [int] NULL,
	[InvitedByCompanyId] [int] NULL,
	[InvitedOn] [datetime] NULL,
	[InvitationStatus]  AS (case when [IsInvited]=(0) AND [IsAccepted]=(0) then (0) else case when [IsInvited]=(1) AND [IsAccepted]=(0) then (1) else case when [IsInvited]=(1) AND [IsAccepted]=(1) then (2) else (0) end end end),
PRIMARY KEY CLUSTERED 
(
	[InvitationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[bspLogInvitation]    Script Date: 06/09/2017 22:33:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspLogInvitation]
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
/****** Object:  Table [dbo].[appTransactions]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appTransactions](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](200) NULL,
	[ExpenseId] [int] NULL,
	[AmountReturned] [numeric](12, 2) NULL,
	[ReturnedOn] [datetime] NULL,
	[AmountReturnedBy] [varchar](20) NULL,
	[AmountReceivedBy] [varchar](20) NULL,
	[CompanyId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[appUserGroups]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appUserGroups](
	[GroupId] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [varchar](300) NULL,
	[IsActive] [bit] NULL,
	[CompanyId] [int] NULL,
	[CreatedBy] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[appUsersIncludedInExpenditure]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appUsersIncludedInExpenditure](
	[ExpenseId] [int] NULL,
	[IncludedUserId] [varchar](20) NULL,
	[ExcludedUserId] [varchar](20) NULL,
	[UserGroupId] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[appUserInformation]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appUserInformation](
	[UserId] [varchar](20) NULL,
	[FirstName] [varchar](30) NULL,
	[MiddleName] [varchar](30) NULL,
	[LastName] [varchar](30) NULL,
	[PetName] [varchar](20) NULL,
	[ShowPetName] [bit] NULL,
	[DisplayName]  AS (case when [ShowPetName]=(1) then [PetName] else ((([FirstName]+' ')+[MiddleName])+' ')+[LastName] end),
	[AddressLine1] [varchar](30) NULL,
	[AddressLine2] [varchar](30) NULL,
	[City] [varchar](30) NULL,
	[DoB] [datetime] NULL,
	[PinCode] [varchar](10) NULL,
	[Country] [varchar](100) NULL,
	[PhoneNumber] [varchar](30) NULL,
	[Mobile] [varchar](15) NULL,
	[Gender] [char](1) NULL,
	[SecretQuestion] [varchar](150) NULL,
	[SecretAnswer] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[appGroupedUsers]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appGroupedUsers](
	[userId] [varchar](20) NULL,
	[groupId] [int] NULL,
	[CompanyId] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[bfnGetUsersInExpennditureInAllGroups]    Script Date: 06/09/2017 22:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[bfnGetUsersInExpennditureInAllGroups]
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
/****** Object:  StoredProcedure [dbo].[bspGetOverallExpenses]    Script Date: 06/09/2017 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[bspGetOverallExpenses]
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
/****** Object:  StoredProcedure [dbo].[bspCheckAmountBeyondLevel]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspCheckAmountBeyondLevel]  
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
/****** Object:  StoredProcedure [dbo].[bspGetBudgetSummary]    Script Date: 06/09/2017 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetBudgetSummary]  
(	
	@companyId INT
)
AS
	SET NOCOUNT ON
	BEGIN
		SELECT Name, Description, BC.CategoryName AS Category, StartDate, EndDate, MaxAmount, SpentAmount, 
		(CASE WHEN SpentAmount > MaxAmount THEN 2 WHEN SpentAmount = MaxAmount THEN 0 ELSE 1 END) AS Level, 
		(CASE WHEN IsExpired = 1 THEN 2 WHEN IsActive = 1 THEN 1 ELSE 0 END) AS Status FROM Budgets B
		LEFT JOIN	
		(SELECT E.BudgetId, SUM(E.SpentAmount) AS SpentAmount FROM budgets B INNER JOIN appExpenses E ON B.BudgetId = E.BudgetId GROUP BY E.budgetId) AS BS
		ON B.BudgetId = BS.BudgetId	AND B.CompanyId = @companyId 	
		INNER JOIN BudgetCategory BC 
		ON BC.CategoryId = B.CategoryId AND BC.CompanyId = @companyId
	END
GO
/****** Object:  StoredProcedure [dbo].[bspGetAvailableBudgetCategory]    Script Date: 06/09/2017 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetAvailableBudgetCategory]  
(
	@companyId INT  
)
AS
BEGIN
	SELECT CategoryId, CategoryName, CreatedBy FROM budgetCategory WHERE CompanyId = @companyId
END
GO
/****** Object:  StoredProcedure [dbo].[bspGetExpenseDetailsLookUps]    Script Date: 06/09/2017 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[bspGetExpenseDetailsLookUps]
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
/****** Object:  StoredProcedure [dbo].[bspGetExpenses]    Script Date: 06/09/2017 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[bspGetExpenses]
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
/****** Object:  StoredProcedure [dbo].[bspVerifyEmail]    Script Date: 06/09/2017 22:33:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspVerifyEmail]
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
/****** Object:  StoredProcedure [dbo].[bspCheckUserNameOrEmailIsExists]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspCheckUserNameOrEmailIsExists]
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
/****** Object:  StoredProcedure [dbo].[bspCheckIsValidPassword]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspCheckIsValidPassword]
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
/****** Object:  StoredProcedure [dbo].[bspChangeOrForgotPassword]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspChangeOrForgotPassword]
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
/****** Object:  Table [dbo].[appUserPermissions]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appUserPermissions](
	[userId] [varchar](20) NULL,
	[screenId] [int] NULL,
	[isRead] [bit] NULL,
	[isWrite] [bit] NULL,
	[canDelete] [bit] NULL,
	[showInLink] [bit] NULL,
	[parentScreenId] [int] NULL,
	[linkIcon] [varchar](100) NULL,
	[linkOrder] [int] NULL,
	[CompanyId] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[bspRevokeAllPermissionByUser]    Script Date: 06/09/2017 22:33:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspRevokeAllPermissionByUser]
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
/****** Object:  StoredProcedure [dbo].[bspAcceptInvitation]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspAcceptInvitation]
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
/****** Object:  Table [dbo].[appScreens]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appScreens](
	[screenId] [int] IDENTITY(1,1) NOT NULL,
	[screenName] [varchar](200) NULL,
	[menuTitle] [varchar](100) NULL,
	[screenActionName] [varchar](400) NULL,
	[screenControllerName] [varchar](400) NULL,
	[screenAreaName] [varchar](400) NULL,
	[defaultReadAccess] [bit] NULL,
	[defaultWriteAccess] [bit] NULL,
	[defaultDeleteAccess] [bit] NULL,
	[parentScreenId] [int] NULL,
	[linkOrder] [int] NULL,
	[linkIcon] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[screenId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[appScreens] ON
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (1, N'View Budget', N'Budget management', N'ViewBudget', N'BudgetManagementController', N'BudgetManagement', 0, 0, 0, NULL, 100, N'icon-tasks')
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (2, N'Manage budget category', N'Budget management', N'ManageBudgetCategory', N'BudgetManagementController', N'BudgetManagement', 0, 0, 0, NULL, 100, N'icon-tasks')
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (3, N'Create budget', N'Budget management', N'CreateBudget', N'BudgetManagementController', N'BudgetManagement', 0, 0, 0, NULL, 100, N'icon-tasks')
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (4, N'Summary', N'Budget management', N'Summary', N'BudgetManagementController', N'BudgetManagement', 0, 0, 0, NULL, 100, N'icon-tasks')
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (5, N'Add my expense', N'User expenses', N'AddMyExpense', N'ExpenseController', N'Expenses', 0, 0, 0, NULL, 100, N'icon-tasks')
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (6, N'Manage expense', N'User expenses', N'ManageExpenses', N'ExpenseController', N'Expenses', 0, 0, 0, NULL, 100, N'icon-tasks')
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (7, N'Overall expenses', N'User expenses', N'OverallExpenses', N'ExpenseController', N'Expenses', 0, 0, 0, NULL, 100, N'icon-tasks')
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (8, N'Create', N'User transactions', N'Create', N'TransactionController', N'Expenses', 0, 0, 0, NULL, 100, N'icon-tasks')
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (9, N'Edit', N'User transactions', N'Edit', N'TransactionController', N'Expenses', 0, 0, 0, NULL, 100, N'icon-tasks')
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (10, N'Money Flow', N'User transactions', N'Analysis', N'TransactionController', N'Expenses', 0, 0, 0, NULL, 100, N'icon-tasks')
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (11, N'Invite a friend', N'Invitations', N'InviteAFriend', N'InviteFriendsController', N'InviteFriends', 0, 0, 0, NULL, 100, N'icon-tasks')
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (12, N'Dashboard', N'User permissions', N'DashBoard', N'UserPermissionController', N'UserPermission', 1, 0, 0, NULL, 100, N'icon-tasks')
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (13, N'User permissions', N'User permissions', N'UserPermissions', N'UserPermissionController', N'UserPermission', 1, 1, 1, NULL, 100, N'icon-tasks')
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (14, N'Manage groups', N'Users & Groups', N'ManageGroups', N'ManageGroupController', N'UserAndGroupManagement', 0, 0, 0, NULL, 100, N'icon-tasks')
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (15, N'Manage users', N'Users & Groups', N'ManageUsers', N'ManageGroupController', N'UserAndGroupManagement', 0, 0, 0, NULL, 100, N'icon-tasks')
INSERT [dbo].[appScreens] ([screenId], [screenName], [menuTitle], [screenActionName], [screenControllerName], [screenAreaName], [defaultReadAccess], [defaultWriteAccess], [defaultDeleteAccess], [parentScreenId], [linkOrder], [linkIcon]) VALUES (16, N'Create user group', N'Users & Groups', N'CreateUserGroup', N'ManageGroupController', N'UserAndGroupManagement', 0, 0, 0, NULL, 100, N'icon-tasks')
SET IDENTITY_INSERT [dbo].[appScreens] OFF
/****** Object:  Table [dbo].[appDefaulPermisionScreens]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appDefaulPermisionScreens](
	[CompanyId] [int] NULL,
	[ScreenId] [int] NULL,
	[IsRead] [bit] NULL,
	[IsWrite] [bit] NULL,
	[canDelete] [bit] NULL,
	[parentScreenId] [int] NULL,
	[screenName] [varchar](200) NULL,
	[linkOrder] [int] NULL,
	[linkIcon] [varchar](100) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[bspUpdateUserPermission]    Script Date: 06/09/2017 22:33:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspUpdateUserPermission]
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
/****** Object:  StoredProcedure [dbo].[bspUpdateScreenData]    Script Date: 06/09/2017 22:33:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspUpdateScreenData]
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
/****** Object:  StoredProcedure [dbo].[bspUpdateSelectedUserRecord]    Script Date: 06/09/2017 22:33:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspUpdateSelectedUserRecord]
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
/****** Object:  StoredProcedure [dbo].[bspUpdateAccountSettingsData]    Script Date: 06/09/2017 22:33:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspUpdateAccountSettingsData]
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
/****** Object:  StoredProcedure [dbo].[bspResetPassword]    Script Date: 06/09/2017 22:33:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspResetPassword]
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
/****** Object:  StoredProcedure [dbo].[bspGetUsersByUserName]    Script Date: 06/09/2017 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetUsersByUserName]
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
/****** Object:  StoredProcedure [dbo].[bspGetAllScreensWithPermisssion]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetAllScreensWithPermisssion]
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
/****** Object:  StoredProcedure [dbo].[bspGetUserPermissions]    Script Date: 06/09/2017 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetUserPermissions]
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
/****** Object:  StoredProcedure [dbo].[bspGetUserDetailsForFriendInvitation]    Script Date: 06/09/2017 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetUserDetailsForFriendInvitation]
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
/****** Object:  StoredProcedure [dbo].[bspGetTransactionLookUpData]    Script Date: 06/09/2017 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetTransactionLookUpData]
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
/****** Object:  StoredProcedure [dbo].[bspGetApplicationUsers]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetApplicationUsers]
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
/****** Object:  StoredProcedure [dbo].[bspGetAccountSettingsData]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetAccountSettingsData]
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
/****** Object:  StoredProcedure [dbo].[bspAuthorizeUserLogIn]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspAuthorizeUserLogIn]
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
/****** Object:  StoredProcedure [dbo].[bspAddUser]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspAddUser]
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
/****** Object:  UserDefinedFunction [dbo].[bfnGetUsersInExpenditure]    Script Date: 06/09/2017 22:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[bspUpdateSelectedGroupRecord]    Script Date: 06/09/2017 22:33:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspUpdateSelectedGroupRecord]
(			
	@groupName VARCHAR(100),
	@isActive BIT,
	@groupId INT,
	@companyId INT	
)	
AS
BEGIN
	UPDATE appUserGroups SET GroupName = @groupName, IsActive = @isActive WHERE GroupId = @groupId AND CompanyId = @companyId
END
GO
/****** Object:  StoredProcedure [dbo].[bspGetUserGroup]    Script Date: 06/09/2017 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[bspGetUserGroup]
(
	@companyId INT
)
AS
BEGIN
	SELECT GroupId, GroupName, IsActive FROM appUserGroups  where CompanyId = @companyId
	
	SELECT UG.GroupId, GU.UserId, UI.DisplayName AS UserName FROM appUserGroups AS UG INNER JOIN appGroupedUsers AS GU ON
	UG.GroupId = GU.groupId
	INNER JOIN appUserInformation UI ON GU.userId = UI.UserId
END
GO
/****** Object:  StoredProcedure [dbo].[bspGetDashboardBudgetSummary]    Script Date: 06/09/2017 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[bspGetDashboardBudgetSummary]
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
/****** Object:  StoredProcedure [dbo].[bspGetAnalysisLookUps]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetAnalysisLookUps]  
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
/****** Object:  StoredProcedure [dbo].[bspCheckGroupAlreadyExists]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspCheckGroupAlreadyExists]
(			
	@groupName VARCHAR(100),
	@companyId INT	
)	
AS
BEGIN
	SELECT 1 FROM appUserGroups WHERE groupName = @groupName AND CompanyId = @companyId
END
GO
/****** Object:  StoredProcedure [dbo].[bspAddApplicationUserGroup]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[bspAddApplicationUserGroup]
(
	@userId VARCHAR(200),
	@groupName VARCHAR(200),
	@companyId INT = NULL
)
AS
SET NOCOUNT ON
BEGIN
	INSERT INTO appUserGroups (GroupName, Isactive, CreatedBy, CompanyId) 
	VALUES(@userId, 1, @groupName, @companyId)
END
GO
/****** Object:  StoredProcedure [dbo].[bspUpdateTransactions]    Script Date: 06/09/2017 22:33:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspUpdateTransactions]  
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
/****** Object:  StoredProcedure [dbo].[bspGetExpenseByGroup]    Script Date: 06/09/2017 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[bspGetExpenseByGroup]
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
/****** Object:  StoredProcedure [dbo].[bspGetAnalysisDataByUsers]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetAnalysisDataByUsers]  
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
/****** Object:  StoredProcedure [dbo].[bspGetAllMyTransactions]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetAllMyTransactions]
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
/****** Object:  StoredProcedure [dbo].[bspDeleteRecordOfSelectedComponent]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspDeleteRecordOfSelectedComponent]
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
		DELETE FROM appUserInformation WHERE UserId=@recordId
		UPDATE appCompany SET OwnedBy = NULL WHERE CompanyId = (SELECT CompanyId FROM appUsersCredentials WHERE UserId = @recordId)
		DELETE FROM appCompany WHERE CompanyId = (SELECT CompanyId FROM appUsersCredentials WHERE UserId=@recordId)
		DELETE FROM appUserPermissions WHERE userId=@recordId AND CompanyId=(SELECT CompanyId FROM appUsersCredentials WHERE UserId = @recordId)
		DELETE FROM appUsersCredentials WHERE UserId=@recordId AND CompanyId=(SELECT CompanyId FROM appUsersCredentials WHERE UserId = @recordId)	
	END
	ELSE IF @componentType = 'C'
	BEGIN
		DELETE FROM budgetCategory WHERE CategoryId = @recordId
	END
	ELSE IF @componentType = 'T'
	BEGIN
		DELETE FROM appTransactions WHERE TransactionId = @recordId
	END
END
GO
/****** Object:  StoredProcedure [dbo].[bspCreateTransaction]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspCreateTransaction]
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
/****** Object:  StoredProcedure [dbo].[bspIsUserHasAccess]    Script Date: 06/09/2017 22:33:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspIsUserHasAccess]
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
/****** Object:  StoredProcedure [dbo].[bspGetUserScreens]    Script Date: 06/09/2017 22:33:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetUserScreens]
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
/****** Object:  Table [dbo].[appRoles]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appRoles](
	[roleId] [int] NOT NULL,
	[roleName] [varchar](30) NULL,
	[roleDescription] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[roleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[appUsersAndRoles]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appUsersAndRoles](
	[UserId] [varchar](20) NULL,
	[RoleAssigned] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[bspGetCurrentUserRole]    Script Date: 06/09/2017 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetCurrentUserRole]
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
/****** Object:  StoredProcedure [dbo].[bspAssignRoleToUser]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspAssignRoleToUser]
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
/****** Object:  StoredProcedure [dbo].[bspGetAnalysisData]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetAnalysisData]  
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
/****** Object:  Table [dbo].[appEmailVerificationMaster]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appEmailVerificationMaster](
	[VerificationId] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](20) NULL,
	[description] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[VerificationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[budgetPeople]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[budgetPeople](
	[PersonId] [int] IDENTITY(1,1) NOT NULL,
	[PersonName] [varchar](150) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[peopleInBudget]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[peopleInBudget](
	[personId] [int] NULL,
	[budgetId] [int] NULL,
	[isActive] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[DeleteConstraints]    Script Date: 06/09/2017 22:33:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteConstraints]
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
/****** Object:  UserDefinedFunction [dbo].[bfnSplitMultipleValues]    Script Date: 06/09/2017 22:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[bfnSplitMultipleValues]
(
	@String VARCHAR(MAX), 
	@Delimiter CHAR(1)
)       
RETURNS @temptable TABLE 
(
	items VARCHAR(MAX)
)       
AS       
BEGIN      
    DECLARE @idx int       
    DECLARE @slice varchar(8000)       

    SELECT @idx = 1       
        IF LEN(@String)<1 OR @String IS NULL  RETURN       

    WHILE @idx!= 0       
    BEGIN       
        SET @idx = CHARINDEX(@Delimiter,@String)       
        IF @idx!=0       
            SET @slice = LEFT(@String,@idx - 1)       
        ELSE       
            SET @slice = @String       

        IF(LEN(@slice)>0)  
            INSERT INTO @temptable(Items) VALUES(@slice)       

        SET @String = RIGHT(@String,LEN(@String) - @idx)       
        IF LEN(@String) = 0 BREAK       
    END   
RETURN 
END;
GO
/****** Object:  StoredProcedure [dbo].[bspCreateUserGroup]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspCreateUserGroup]
(	
	@createdBy VARCHAR(20),
	@groupName VARCHAR(100),
	@users VARCHAR(MAX),
	@companyId INT	
)	
AS
BEGIN
	BEGIN TRANSACTION UserGroup
		INSERT INTO appUserGroups(GroupName, isActive, CompanyId, CreatedBy)
		SELECT @groupName, 1, @companyId, @createdBy
		
		INSERT INTO appGroupedUsers(GroupId, UserId, CompanyID)
		SELECT @@Identity, Items, @companyId FROM bfnSplitMultipleValues(@users, ',')
		IF @@error > 0
		BEGIN
			ROLLBACK TRANSACTION UserGroup
			RETURN @@error
		END
		ELSE
		BEGIN
			COMMIT TRANSACTION UserGroup
		END	
END
GO
/****** Object:  StoredProcedure [dbo].[bspGetAllAvailableScreens]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetAllAvailableScreens]
AS
BEGIN
	SELECT DISTINCT screenActionName, ISNULL(screenName, screenActionName) AS ScreenName, screenControllerName, screenAreaName FROM appScreens
END
GO
/****** Object:  StoredProcedure [dbo].[bspGetAllAvailableRoles]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspGetAllAvailableRoles]
AS
SET NOCOUNT ON
BEGIN
	SELECT DISTINCT roleName FROM appRoles
END
GO
/****** Object:  StoredProcedure [dbo].[bspAddApplicationScreens]    Script Date: 06/09/2017 22:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bspAddApplicationScreens]
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
/****** Object:  Table [dbo].[appEmailVerificationCheck]    Script Date: 06/09/2017 22:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appEmailVerificationCheck](
	[VerificationId] [int] NULL,
	[userId] [varchar](20) NULL,
	[isVerified] [bit] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Default [DF__appDefaul__linkO__4A8310C6]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appDefaulPermisionScreens] ADD  DEFAULT ((100)) FOR [linkOrder]
GO
/****** Object:  Default [DF__appDefaul__linkI__4B7734FF]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appDefaulPermisionScreens] ADD  DEFAULT ('icon-tasks') FOR [linkIcon]
GO
/****** Object:  Default [DF__appInvita__IsInv__00DF2177]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appInvitationLog] ADD  DEFAULT ((1)) FOR [IsInvited]
GO
/****** Object:  Default [DF__appInvita__IsAcc__01D345B0]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appInvitationLog] ADD  DEFAULT ((0)) FOR [IsAccepted]
GO
/****** Object:  Default [DF__appInvita__Invit__02C769E9]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appInvitationLog] ADD  DEFAULT (getdate()) FOR [InvitedOn]
GO
/****** Object:  Default [DF__appScreen__linkO__47A6A41B]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appScreens] ADD  DEFAULT ((100)) FOR [linkOrder]
GO
/****** Object:  Default [DF__appScreen__linkI__489AC854]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appScreens] ADD  DEFAULT ('icon-tasks') FOR [linkIcon]
GO
/****** Object:  Default [DF__appUserIn__ShowP__3E1D39E1]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUserInformation] ADD  DEFAULT ((1)) FOR [ShowPetName]
GO
/****** Object:  Default [DF__appUserPe__paren__4F47C5E3]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUserPermissions] ADD  DEFAULT ((0)) FOR [parentScreenId]
GO
/****** Object:  Default [DF__appUserPe__linkI__503BEA1C]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUserPermissions] ADD  DEFAULT ('icon-tasks') FOR [linkIcon]
GO
/****** Object:  Default [DF__appUserPe__linkO__51300E55]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUserPermissions] ADD  DEFAULT ((0)) FOR [linkOrder]
GO
/****** Object:  Default [DF__appUsersC__IsEma__3B40CD36]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUsersCredentials] ADD  DEFAULT ((0)) FOR [IsEmailVerified]
GO
/****** Object:  ForeignKey [FK_BUDGETGROUPS_COMPANY_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appBudgetGroups]  WITH CHECK ADD  CONSTRAINT [FK_BUDGETGROUPS_COMPANY_ID] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[appCompany] ([CompanyId])
GO
ALTER TABLE [dbo].[appBudgetGroups] CHECK CONSTRAINT [FK_BUDGETGROUPS_COMPANY_ID]
GO
/****** Object:  ForeignKey [FK_COMPANY_USER_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appCompany]  WITH CHECK ADD  CONSTRAINT [FK_COMPANY_USER_ID] FOREIGN KEY([OwnedBy])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
GO
ALTER TABLE [dbo].[appCompany] CHECK CONSTRAINT [FK_COMPANY_USER_ID]
GO
/****** Object:  ForeignKey [FK_DEFAULPERMISIONSCREENS_COMPANY_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appDefaulPermisionScreens]  WITH CHECK ADD  CONSTRAINT [FK_DEFAULPERMISIONSCREENS_COMPANY_ID] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[appCompany] ([CompanyId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[appDefaulPermisionScreens] CHECK CONSTRAINT [FK_DEFAULPERMISIONSCREENS_COMPANY_ID]
GO
/****** Object:  ForeignKey [FK_DEFAULPERMISIONSCREENS_ScreenId]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appDefaulPermisionScreens]  WITH CHECK ADD  CONSTRAINT [FK_DEFAULPERMISIONSCREENS_ScreenId] FOREIGN KEY([ScreenId])
REFERENCES [dbo].[appScreens] ([screenId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[appDefaulPermisionScreens] CHECK CONSTRAINT [FK_DEFAULPERMISIONSCREENS_ScreenId]
GO
/****** Object:  ForeignKey [FK_VERIFICATION_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appEmailVerificationCheck]  WITH CHECK ADD  CONSTRAINT [FK_VERIFICATION_ID] FOREIGN KEY([VerificationId])
REFERENCES [dbo].[appEmailVerificationMaster] ([VerificationId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[appEmailVerificationCheck] CHECK CONSTRAINT [FK_VERIFICATION_ID]
GO
/****** Object:  ForeignKey [FK_EXPENSE_BUDGET_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appExpenses]  WITH CHECK ADD  CONSTRAINT [FK_EXPENSE_BUDGET_ID] FOREIGN KEY([BudgetId])
REFERENCES [dbo].[budgets] ([BudgetId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[appExpenses] CHECK CONSTRAINT [FK_EXPENSE_BUDGET_ID]
GO
/****** Object:  ForeignKey [FK_EXPENSE_COMPANY_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appExpenses]  WITH CHECK ADD  CONSTRAINT [FK_EXPENSE_COMPANY_ID] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[appCompany] ([CompanyId])
GO
ALTER TABLE [dbo].[appExpenses] CHECK CONSTRAINT [FK_EXPENSE_COMPANY_ID]
GO
/****** Object:  ForeignKey [FK_EXPENSE_CREATED_BY]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appExpenses]  WITH CHECK ADD  CONSTRAINT [FK_EXPENSE_CREATED_BY] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
GO
ALTER TABLE [dbo].[appExpenses] CHECK CONSTRAINT [FK_EXPENSE_CREATED_BY]
GO
/****** Object:  ForeignKey [FK_EXPENSE_USER_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appExpenses]  WITH CHECK ADD  CONSTRAINT [FK_EXPENSE_USER_ID] FOREIGN KEY([SpentBy])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
GO
ALTER TABLE [dbo].[appExpenses] CHECK CONSTRAINT [FK_EXPENSE_USER_ID]
GO
/****** Object:  ForeignKey [FK_GROUPEDDUSER_GROUP_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appGroupedUsers]  WITH CHECK ADD  CONSTRAINT [FK_GROUPEDDUSER_GROUP_ID] FOREIGN KEY([groupId])
REFERENCES [dbo].[appUserGroups] ([GroupId])
GO
ALTER TABLE [dbo].[appGroupedUsers] CHECK CONSTRAINT [FK_GROUPEDDUSER_GROUP_ID]
GO
/****** Object:  ForeignKey [FK_GROUPEDUSER_USER_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appGroupedUsers]  WITH CHECK ADD  CONSTRAINT [FK_GROUPEDUSER_USER_ID] FOREIGN KEY([userId])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
GO
ALTER TABLE [dbo].[appGroupedUsers] CHECK CONSTRAINT [FK_GROUPEDUSER_USER_ID]
GO
/****** Object:  ForeignKey [FK_INVITATION_INVITED_BY_COMPANY_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appInvitationLog]  WITH CHECK ADD  CONSTRAINT [FK_INVITATION_INVITED_BY_COMPANY_ID] FOREIGN KEY([InvitedByCompanyId])
REFERENCES [dbo].[appCompany] ([CompanyId])
GO
ALTER TABLE [dbo].[appInvitationLog] CHECK CONSTRAINT [FK_INVITATION_INVITED_BY_COMPANY_ID]
GO
/****** Object:  ForeignKey [FK_INVITATION_INVITED_BY_USER_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appInvitationLog]  WITH CHECK ADD  CONSTRAINT [FK_INVITATION_INVITED_BY_USER_ID] FOREIGN KEY([InvitedBy])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
GO
ALTER TABLE [dbo].[appInvitationLog] CHECK CONSTRAINT [FK_INVITATION_INVITED_BY_USER_ID]
GO
/****** Object:  ForeignKey [FK_INVITATION_INVITED_COMPANY_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appInvitationLog]  WITH CHECK ADD  CONSTRAINT [FK_INVITATION_INVITED_COMPANY_ID] FOREIGN KEY([InvitedCompanyId])
REFERENCES [dbo].[appCompany] ([CompanyId])
GO
ALTER TABLE [dbo].[appInvitationLog] CHECK CONSTRAINT [FK_INVITATION_INVITED_COMPANY_ID]
GO
/****** Object:  ForeignKey [FK_INVITATION_INVITED_USER_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appInvitationLog]  WITH CHECK ADD  CONSTRAINT [FK_INVITATION_INVITED_USER_ID] FOREIGN KEY([InvitedUserID])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
GO
ALTER TABLE [dbo].[appInvitationLog] CHECK CONSTRAINT [FK_INVITATION_INVITED_USER_ID]
GO
/****** Object:  ForeignKey [FK_TRANSACTION_AMOUNT_RECEIVED_BY]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appTransactions]  WITH CHECK ADD  CONSTRAINT [FK_TRANSACTION_AMOUNT_RECEIVED_BY] FOREIGN KEY([AmountReceivedBy])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
GO
ALTER TABLE [dbo].[appTransactions] CHECK CONSTRAINT [FK_TRANSACTION_AMOUNT_RECEIVED_BY]
GO
/****** Object:  ForeignKey [FK_TRANSACTION_AMOUNT_RETURNED_BY]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appTransactions]  WITH CHECK ADD  CONSTRAINT [FK_TRANSACTION_AMOUNT_RETURNED_BY] FOREIGN KEY([AmountReturnedBy])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
GO
ALTER TABLE [dbo].[appTransactions] CHECK CONSTRAINT [FK_TRANSACTION_AMOUNT_RETURNED_BY]
GO
/****** Object:  ForeignKey [FK_TRANSACTION_COMPANY_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appTransactions]  WITH CHECK ADD  CONSTRAINT [FK_TRANSACTION_COMPANY_ID] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[appCompany] ([CompanyId])
GO
ALTER TABLE [dbo].[appTransactions] CHECK CONSTRAINT [FK_TRANSACTION_COMPANY_ID]
GO
/****** Object:  ForeignKey [FK_TRANSACTION_EXPENSE_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appTransactions]  WITH CHECK ADD  CONSTRAINT [FK_TRANSACTION_EXPENSE_ID] FOREIGN KEY([ExpenseId])
REFERENCES [dbo].[appExpenses] ([ExpenseId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[appTransactions] CHECK CONSTRAINT [FK_TRANSACTION_EXPENSE_ID]
GO
/****** Object:  ForeignKey [FK_USERGROUP_COMPANY_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUserGroups]  WITH CHECK ADD  CONSTRAINT [FK_USERGROUP_COMPANY_ID] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[appCompany] ([CompanyId])
GO
ALTER TABLE [dbo].[appUserGroups] CHECK CONSTRAINT [FK_USERGROUP_COMPANY_ID]
GO
/****** Object:  ForeignKey [FK_USERGROUP_CREATED_BY]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUserGroups]  WITH CHECK ADD  CONSTRAINT [FK_USERGROUP_CREATED_BY] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
GO
ALTER TABLE [dbo].[appUserGroups] CHECK CONSTRAINT [FK_USERGROUP_CREATED_BY]
GO
/****** Object:  ForeignKey [FK_User_Id]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUserInformation]  WITH CHECK ADD  CONSTRAINT [FK_User_Id] FOREIGN KEY([UserId])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
GO
ALTER TABLE [dbo].[appUserInformation] CHECK CONSTRAINT [FK_User_Id]
GO
/****** Object:  ForeignKey [FK_PERMISSIONS_COMPANY_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUserPermissions]  WITH CHECK ADD  CONSTRAINT [FK_PERMISSIONS_COMPANY_ID] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[appCompany] ([CompanyId])
GO
ALTER TABLE [dbo].[appUserPermissions] CHECK CONSTRAINT [FK_PERMISSIONS_COMPANY_ID]
GO
/****** Object:  ForeignKey [FK_PERMISSIONS_USER_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUserPermissions]  WITH CHECK ADD  CONSTRAINT [FK_PERMISSIONS_USER_ID] FOREIGN KEY([userId])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
GO
ALTER TABLE [dbo].[appUserPermissions] CHECK CONSTRAINT [FK_PERMISSIONS_USER_ID]
GO
/****** Object:  ForeignKey [FK_USER_ROLE]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUsersAndRoles]  WITH CHECK ADD  CONSTRAINT [FK_USER_ROLE] FOREIGN KEY([RoleAssigned])
REFERENCES [dbo].[appRoles] ([roleId])
GO
ALTER TABLE [dbo].[appUsersAndRoles] CHECK CONSTRAINT [FK_USER_ROLE]
GO
/****** Object:  ForeignKey [FK_USERROLES_USER_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUsersAndRoles]  WITH CHECK ADD  CONSTRAINT [FK_USERROLES_USER_ID] FOREIGN KEY([UserId])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
GO
ALTER TABLE [dbo].[appUsersAndRoles] CHECK CONSTRAINT [FK_USERROLES_USER_ID]
GO
/****** Object:  ForeignKey [FK_USER_COMPANY_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUsersCredentials]  WITH CHECK ADD  CONSTRAINT [FK_USER_COMPANY_ID] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[appCompany] ([CompanyId])
GO
ALTER TABLE [dbo].[appUsersCredentials] CHECK CONSTRAINT [FK_USER_COMPANY_ID]
GO
/****** Object:  ForeignKey [FK_EXPENDITURE_EXCLUDEDUSER_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUsersIncludedInExpenditure]  WITH CHECK ADD  CONSTRAINT [FK_EXPENDITURE_EXCLUDEDUSER_ID] FOREIGN KEY([ExcludedUserId])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
GO
ALTER TABLE [dbo].[appUsersIncludedInExpenditure] CHECK CONSTRAINT [FK_EXPENDITURE_EXCLUDEDUSER_ID]
GO
/****** Object:  ForeignKey [FK_EXPENDITURE_EXPENSE_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUsersIncludedInExpenditure]  WITH CHECK ADD  CONSTRAINT [FK_EXPENDITURE_EXPENSE_ID] FOREIGN KEY([ExpenseId])
REFERENCES [dbo].[appExpenses] ([ExpenseId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[appUsersIncludedInExpenditure] CHECK CONSTRAINT [FK_EXPENDITURE_EXPENSE_ID]
GO
/****** Object:  ForeignKey [FK_EXPENDITURE_GROUP_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUsersIncludedInExpenditure]  WITH CHECK ADD  CONSTRAINT [FK_EXPENDITURE_GROUP_ID] FOREIGN KEY([UserGroupId])
REFERENCES [dbo].[appUserGroups] ([GroupId])
GO
ALTER TABLE [dbo].[appUsersIncludedInExpenditure] CHECK CONSTRAINT [FK_EXPENDITURE_GROUP_ID]
GO
/****** Object:  ForeignKey [FK_EXPENDITURE_INCLUDEDUSER_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[appUsersIncludedInExpenditure]  WITH CHECK ADD  CONSTRAINT [FK_EXPENDITURE_INCLUDEDUSER_ID] FOREIGN KEY([IncludedUserId])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
GO
ALTER TABLE [dbo].[appUsersIncludedInExpenditure] CHECK CONSTRAINT [FK_EXPENDITURE_INCLUDEDUSER_ID]
GO
/****** Object:  ForeignKey [FK_BUDGETCATEGORY_CREATEDBY]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[budgetCategory]  WITH CHECK ADD  CONSTRAINT [FK_BUDGETCATEGORY_CREATEDBY] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
GO
ALTER TABLE [dbo].[budgetCategory] CHECK CONSTRAINT [FK_BUDGETCATEGORY_CREATEDBY]
GO
/****** Object:  ForeignKey [FK_BUDGET_CREATEDBY]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[budgets]  WITH CHECK ADD  CONSTRAINT [FK_BUDGET_CREATEDBY] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[appUsersCredentials] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[budgets] CHECK CONSTRAINT [FK_BUDGET_CREATEDBY]
GO
/****** Object:  ForeignKey [FK_BUDGETS_CATEGORY_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[budgets]  WITH CHECK ADD  CONSTRAINT [FK_BUDGETS_CATEGORY_ID] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[budgetCategory] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[budgets] CHECK CONSTRAINT [FK_BUDGETS_CATEGORY_ID]
GO
/****** Object:  ForeignKey [FK_BUDGETS_COMPANY_ID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[budgets]  WITH CHECK ADD  CONSTRAINT [FK_BUDGETS_COMPANY_ID] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[appCompany] ([CompanyId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[budgets] CHECK CONSTRAINT [FK_BUDGETS_COMPANY_ID]
GO
/****** Object:  ForeignKey [FK_BUDGETPEOPLE_PERSIONID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[peopleInBudget]  WITH CHECK ADD  CONSTRAINT [FK_BUDGETPEOPLE_PERSIONID] FOREIGN KEY([personId])
REFERENCES [dbo].[budgetPeople] ([PersonId])
GO
ALTER TABLE [dbo].[peopleInBudget] CHECK CONSTRAINT [FK_BUDGETPEOPLE_PERSIONID]
GO
/****** Object:  ForeignKey [FK_BUDGETS_BUDGETID]    Script Date: 06/09/2017 22:33:15 ******/
ALTER TABLE [dbo].[peopleInBudget]  WITH CHECK ADD  CONSTRAINT [FK_BUDGETS_BUDGETID] FOREIGN KEY([personId])
REFERENCES [dbo].[budgets] ([BudgetId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[peopleInBudget] CHECK CONSTRAINT [FK_BUDGETS_BUDGETID]
GO
/****** Object:  UserDefinedTableType [dbo].[ExpenseIdCollection]    Script Date: 06/09/2017 22:33:41 ******/
CREATE TYPE [dbo].[ExpenseIdCollection] AS TABLE(
	[ExpenseId] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[GroupDataType]    Script Date: 06/09/2017 22:33:41 ******/
CREATE TYPE [dbo].[GroupDataType] AS TABLE(
	[GroupID] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[UserCollectionDataType]    Script Date: 06/09/2017 22:33:41 ******/
CREATE TYPE [dbo].[UserCollectionDataType] AS TABLE(
	[UserId] [nvarchar](20) NULL
)
GO
