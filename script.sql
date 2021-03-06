USE [BookDb]
GO
/****** Object:  Table [dbo].[BookDetails]    Script Date: 06/09/2017 19:27:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BookDetails](
	[BookId] [int] IDENTITY(1,1) NOT NULL,
	[BookName] [varchar](100) NULL,
	[Author] [varchar](100) NULL,
	[Publisher] [varchar](200) NULL,
	[Price] [decimal](18, 2) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[UpdateBookRecord_SP]    Script Date: 06/09/2017 19:30:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateBookRecord_SP]
                @BookId                            INT,
                @BookName                    VARCHAR(100),
                @Author                             VARCHAR(100),
                @Publisher                        VARCHAR(200),
                @Price                                 DECIMAL(18,2)
AS
BEGIN
                UPDATE BookDetails SET
                                BookName=@BookName,
                                Author=@Author,
                                Publisher=@Publisher,
                                Price=@Price
                WHERE BookId=@BookId
END
GO
/****** Object:  StoredProcedure [dbo].[InsertBookDetails_SP]    Script Date: 06/09/2017 19:30:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertBookDetails_SP]
                @BookName                    VARCHAR(100),
                @Author                             VARCHAR(100),
                @Publisher                        VARCHAR(200),
                @Price                                 DECIMAL(18,2)
AS
BEGIN
                INSERT INTO BookDetails
                 (
                                BookName,Author,Publisher,Price
                  )
                VALUES
                 (
                                @BookName,@Author,@Publisher,@Price
                 )
END
GO
/****** Object:  StoredProcedure [dbo].[FetchBookRecords_Sp]    Script Date: 06/09/2017 19:30:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FetchBookRecords_Sp]
AS
BEGIN
                SELECT * FROM BookDetails
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteBookRecords_Sp]    Script Date: 06/09/2017 19:30:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteBookRecords_Sp]
                @BookId            INT
AS
BEGIN
                DELETE FROM BookDetails WHERE BookId=@BookId
END
GO
