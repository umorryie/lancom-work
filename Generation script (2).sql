
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fruit](
	[ID_Fruit] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Quantity] [int] NOT NULL,
	[LastChanged] [datetime] NOT NULL,
 CONSTRAINT [PK_Fruit] PRIMARY KEY CLUSTERED 
(
	[ID_Fruit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FruitSupplier](
	[ID_FruitSupplier] [int] IDENTITY(1,1) NOT NULL,
	[ID_Fruit] [int] NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[MonthQuantity] [int] NOT NULL,
 CONSTRAINT [PK_FruitSupplier] PRIMARY KEY CLUSTERED 
(
	[ID_FruitSupplier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FruitSupplier]  WITH CHECK ADD  CONSTRAINT [FK_FruitSupplier_MD_Product] FOREIGN KEY([ID_Fruit])
REFERENCES [dbo].[Fruit] ([ID_Fruit])
GO
ALTER TABLE [dbo].[FruitSupplier] CHECK CONSTRAINT [FK_FruitSupplier_MD_Product]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Fruit_Delete]
	@FruitId int
AS
BEGIN
	DELETE FROM [dbo].[FruitSupplier] WHERE ID_Fruit = @FruitId
	DELETE FROM [dbo].[Fruit] WHERE ID_Fruit = @FruitId
END

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Fruit_Insert]
	@FruitId int,
	@Name NVARCHAR(256),
	@Quantity DECIMAL(18,2),
	@LastChanged DATETIME2
AS
BEGIN
	INSERT INTO [dbo].[Fruit] (ID_Fruit, Name, Quantity, LastChanged)
	VALUES (@FruitId, @Name, @Quantity, @LastChanged)
END

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Fruit_Select]
	@FruitId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM [dbo].[Fruit] WHERE ID_Fruit = @FruitId;
END

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Fruit_SelectByPage]
	@PageNumber INT,
	@RecordCount INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
		*
	FROM [dbo].[Fruit]
	ORDER BY LastChanged ASC
	OFFSET @PageNumber * @RecordCount ROWS FETCH NEXT @RecordCount ROWS ONLY
END

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Fruit_SelectLastUpdated]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 10 * FROM [dbo].[Fruit] ORDER BY LastChanged DESC
END

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Fruit_Update]
	@FruitId int,
	@Name NVARCHAR(256),
	@Quantity DECIMAL(18,2),
	@LastChanged DATETIME2
AS
BEGIN
	UPDATE [dbo].[Fruit]
	SET [Name] = @Name, Quantity = @Quantity, LastChanged = @LastChanged
	WHERE ID_Fruit = @FruitId
END

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FruitSupplier_SelectByFruitId]
	@FruitId int
AS
BEGIN
	SET NOCOUNT ON;
	Select * FROM [dbo].[FruitSupplier] WHERE ID_Fruit = @FruitId ORDER BY [Name] DESC
END
GO

INSERT INTO [dbo].[Fruit] 
SELECT 'Mango', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION  ALL
SELECT 'Orange', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION  ALL
SELECT 'Apple', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION  ALL
SELECT 'Strawberry', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION  ALL
SELECT 'Pineapple', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION  ALL
SELECT 'Apricot', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION  ALL
SELECT 'Acerola', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION  ALL
SELECT 'Coconut', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION  ALL
SELECT 'Guava', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION ALL 
SELECT 'Lemon', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION ALL
SELECT 'Pear', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION ALL
SELECT 'Banana', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION ALL
SELECT 'Plum', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION ALL
SELECT 'Tangerine', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION ALL
SELECT 'Watermelon', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION ALL
SELECT 'Peach', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION ALL
SELECT 'Mandarin', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION ALL
SELECT 'Nectarine', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION ALL
SELECT 'Grape', FLOOR(RAND()*(1000-500+1)+500), GETDATE() UNION ALL
SELECT 'Clementine', FLOOR(RAND()*(1000-500+1)+500), GETDATE()

GO


INSERT INTO [dbo].[FruitSupplier]
SELECT FLOOR(RAND()*(20-1+1)+1), 'Laverne Thresher', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Ralph Rusek', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Dwayne Chavarin', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Dia Erben', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Ashlie Kearns', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Kenny Paulding', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Daniella Hessel', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Jong Carwell', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Shane Divis', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Cora Reaper', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Gaylene Manes', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Breanna Padgett', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Gino Hyde', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Winford Delvalle', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Lourie Paredes', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Dalila Gan', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Maisha Morais', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Violet Duppstadt', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Lyndsey Copes', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Franchesca Anthony', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Alonso Kerstetter', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Cayla Marquart', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Yasmine Kilpatrick', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Marva Rondon', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Fransisca Leppert', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Carmelia Helmers', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Antionette Poissant', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Bong Ferdinand', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Tanja Babbitt', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Kelvin Sells', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Rick Torrence', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Robin Denham', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Tamra Fearn', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Na Mizrahi', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Elza Shell', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Ila Madonia', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Nathaniel Foland', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Ingeborg Wieczorek', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Gertie Truett', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Letha Semien', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Adele Scotti', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Mayme Vaughn', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Francie Cockett', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Branden Labree', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Carletta Giampaolo', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Clayton Davin', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Cinthia Shaner', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Sherril Swiney', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Ayesha Grover', FLOOR(RAND()*(100-50+1)+50) UNION
SELECT FLOOR(RAND()*(20-1+1)+1), 'Freeda Alcantara', FLOOR(RAND()*(100-50+1)+50)
GO

-- LETS TEST PROCEDURES
EXEC Fruit_Delete @FruitId = 1
GO
SET IDENTITY_INSERT dbo.Fruit ON
GO
EXEC Fruit_Insert @FruitId = 21, @Name = 'Matej', @Quantity = 100, @LastChanged = '2020-11-04 23:05:07.220'
GO
EXEC Fruit_Select @FruitId = 15
GO
EXEC Fruit_SelectByPage @PageNumber = 3, @RecordCount = 4
GO
EXEC Fruit_SelectLastUpdated
GO
EXEC Fruit_Update 	@FruitId = 20, @Name = 'Matej', @Quantity = 100, @LastChanged = '2020-11-04 23:05:07.220'
GO
EXEC FruitSupplier_SelectByFruitId @FruitId = 1
GO