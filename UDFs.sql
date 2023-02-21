USE [VendyDB]
GO
/****** Object:  UserDefinedFunction [dbo].[udfMostTransactionOnDatePerVmachine]    Script Date: 21/02/2023 08:37:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER function [dbo].[udfMostTransactionOnDatePerVmachine](

)
returns table
as
return
-- get the most used days along with transaction amount per vending machine 
SELECT i.Vmachine_ID, t.Transaction_date, COUNT(t.Transaction_date) AS total_transactions
FROM transactions t
left join Item i
on i.Item_ID = t.Item_ID
GROUP BY i.Vmachine_ID, t.Transaction_date
HAVING count(t.Transaction_date) = (
    SELECT MAX(count_transactions) 
    FROM (
        SELECT COUNT(*) AS count_transactions , i.Vmachine_ID
        FROM transactions t
		left join Item i
		on i.Item_ID = t.Item_ID
        GROUP BY i.Vmachine_ID, transaction_date
    ) AS subtable 
    WHERE subtable.Vmachine_ID = i.Vmachine_ID
)
