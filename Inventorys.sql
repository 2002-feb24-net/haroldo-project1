/*
   Sunday, March 22, 20209:02:07 PM
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
ALTER TABLE dbo.Products SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Inventorys ADD CONSTRAINT
	FK_PRODUCTS_PRODUCTID FOREIGN KEY
	(
	ProductID
	) REFERENCES dbo.Products
	(
	ProductID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Inventorys SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
