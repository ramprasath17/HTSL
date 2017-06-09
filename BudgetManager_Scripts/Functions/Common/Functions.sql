IF OBJECT_ID('bfnSplitMultipleValues', 'TF') IS NOT NULL
BEGIN
DROP FUNCTION bfnSplitMultipleValues
END
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