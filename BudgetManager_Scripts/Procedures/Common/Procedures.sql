IF OBJECT_ID('DeleteConstraints', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE DeleteConstraints
END
GO
CREATE PROCEDURE DeleteConstraints
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