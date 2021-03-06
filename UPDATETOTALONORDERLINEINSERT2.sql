/****** Object:  Trigger [dbo].[OrderTotalOnOrderlinesInsert]    Script Date: 4/5/2020 5:25:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[OrderTotalOnOrderlinesInsert]
       ON [dbo].[Orderlines]
AFTER INSERT
AS
BEGIN
       SET NOCOUNT ON;
 
       DECLARE @OrderlineCost MONEY
	   DECLARE @OrderlineQuantity INT
	   DECLARE @ProductId INT
	   Declare @ProductCost MONEY
	   Declare @OrderlineOrderId INT
 
       SELECT @ProductId = INSERTED.ProductID       
       FROM INSERTED

	   SELECT @ProductCost = Cost
	   FROM Products
	   WHERE ProductID = @ProductId

	   SELECT @OrderlineQuantity = INSERTED.Quantity       
       FROM INSERTED

	   SELECT @OrderlineOrderId = INSERTED.OrderID       
       FROM INSERTED

	   SELECT @OrderlineCost = (@orderlineQuantity * @ProductCost)

	   UPDATE Orders
	   SET Total = coalesce(@OrderlineCost + Total, @OrderlineCost, Total, 0)
	   
	   WHERE OrderID = @OrderlineOrderId




 
END
