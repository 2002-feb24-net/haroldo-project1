/*
   Sunday, March 22, 20209:19:21 PM
   User: haroldo
   Server: 2002-training-altamirano.database.windows.net
   Database: DbRestaurant
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Inventorys SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_Stores
	(
	[Street Address] nvarchar(50) NULL,
	InventoryID int NULL,
	StoreID int NOT NULL IDENTITY (1, 1),
	City nchar(50) NULL,
	State nchar(50) NULL,
	Zipcode char(5) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Stores SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_Stores ON
GO
IF EXISTS(SELECT * FROM dbo.Stores)
	 EXEC('INSERT INTO dbo.Tmp_Stores ([Street Address], InventoryID, StoreID)
		SELECT Address, InventoryID, StoreID FROM dbo.Stores WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_Stores OFF
GO
ALTER TABLE dbo.Orders
	DROP CONSTRAINT FK_STORE_STOREID
GO
DROP TABLE dbo.Stores
GO
EXECUTE sp_rename N'dbo.Tmp_Stores', N'Stores', 'OBJECT' 
GO
ALTER TABLE dbo.Stores ADD CONSTRAINT
	PK__Stores__3B82F0E1FB793EE3 PRIMARY KEY CLUSTERED 
	(
	StoreID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Stores ADD CONSTRAINT
	INVENTORYS_INVENTORYID FOREIGN KEY
	(
	InventoryID
	) REFERENCES dbo.Inventorys
	(
	InventoryID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Orders ADD CONSTRAINT
	FK_STORE_STOREID FOREIGN KEY
	(
	StoreID
	) REFERENCES dbo.Stores
	(
	StoreID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Orders SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
