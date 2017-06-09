IF TYPE_ID(N'dbo.UserCollectionDataType') IS NOT NULL
BEGIN 
	DROP TYPE dbo.UserCollectionDataType 
END
GO
CREATE TYPE dbo.UserCollectionDataType AS TABLE
		( UserId NVARCHAR(20) )
GO
		    
IF TYPE_ID(N'dbo.GroupDataType') IS NOT NULL
BEGIN     
	DROP TYPE dbo.GroupDataType 
END
GO            
CREATE TYPE dbo.GroupDataType AS TABLE
	( GroupID INT )
GO		

--Expense Id Collection table data type
IF TYPE_ID(N'ExpenseIdCollection') IS NOT NULL
BEGIN 
	DROP TYPE dbo.ExpenseIdCollection 
END
GO
CREATE TYPE dbo.ExpenseIdCollection AS TABLE
		( ExpenseId INT )
GO
		    	
