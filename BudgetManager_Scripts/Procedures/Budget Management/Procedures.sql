IF OBJECT_ID('bspCreateBudget', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspCreateBudget
END
GO
CREATE PROCEDURE bspCreateBudget
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

IF OBJECT_ID('bspViewBudget', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspViewBudget
END
GO
CREATE PROCEDURE bspViewBudget
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

IF OBJECT_ID('bspUpdateSelectedBudgetRecord', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspUpdateSelectedBudgetRecord
END
GO
CREATE PROCEDURE bspUpdateSelectedBudgetRecord
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

--Creating Budget Category
IF OBJECT_ID('bspCreateBudgetCategory', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspCreateBudgetCategory
END
GO
CREATE PROCEDURE bspCreateBudgetCategory  
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

IF OBJECT_ID('bspGetAvailableBudgetCategory', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetAvailableBudgetCategory
END
GO
CREATE PROCEDURE bspGetAvailableBudgetCategory  
(
	@companyId INT  
)
AS
BEGIN
	SELECT CategoryId, CategoryName, CreatedBy FROM budgetCategory WHERE CompanyId = @companyId
END
GO

IF OBJECT_ID('bspCheckBudgetAlreadyExists', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspCheckBudgetAlreadyExists
END
GO
CREATE PROCEDURE bspCheckBudgetAlreadyExists  
(
	@budgetName VARCHAR(200),
	@companyId INT
)
AS
BEGIN
	SELECT 1 FROM Budgets WHERE Name = @budgetName AND CompanyId = @companyId
END
GO

IF OBJECT_ID('bspCheckCategoryExists', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspCheckCategoryExists
END
GO
CREATE PROCEDURE bspCheckCategoryExists  
(
	@categoryName VARCHAR(200),
	@companyId INT
)
AS
BEGIN
	SELECT 1 FROM budgetCategory WHERE CategoryName = @categoryName AND CompanyId = @companyId
END
GO

IF OBJECT_ID('bspUpdateSelectedBudgetCategoryRecord', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspUpdateSelectedBudgetCategoryRecord
END
GO
CREATE PROCEDURE bspUpdateSelectedBudgetCategoryRecord  
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

IF OBJECT_ID('bspGetBudgetSummary', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE bspGetBudgetSummary
END
GO
CREATE PROCEDURE bspGetBudgetSummary  
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
