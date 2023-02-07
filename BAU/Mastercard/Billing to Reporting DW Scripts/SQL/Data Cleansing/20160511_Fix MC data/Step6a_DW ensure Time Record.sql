/*****************************************
** Project ID	 : DW - MC - Step 6a
** Description   : To ensure that there is a record in the [lounge_db].[dbo].[dimTblTime] table for this month
** Author		 : Greg McPhillips
** Last Mofified : 2016-03-23
** Amend History : GM 23/03/2016 Changes to ensure there is no data in target for this month in target importing this months data

** Run history   :	GM 17/03/2016 Ran successfully for month = 2016-02-01
					GM 19/04/2016 Ran successfully for month = 2016-03-01
	
******************************************/

DECLARE @report_month AS DATE
SET @report_month = '2016-03-01'
--SELECT COUNT(*) FROM [lounge_db].[dbo].[dimTblTime] where report_month_pk = @Report_Month

---------------------------------------------------------------------------------------------------------------------
-- Ensure that there is a record in the [lounge_db].[dbo].[dimTblTime] table for this month
---------------------------------------------------------------------------------------------------------------------
DECLARE @NumRecs	INT
SET @Numrecs = (SELECT COUNT(*) FROM [lounge_db].[dbo].[dimTblTime] where report_month_pk = @Report_Month)


IF @NumRecs > 0
	BEGIN
		PRINT 'A row for month '+ quotename(@Report_Month)+ ' already exists in [lounge_db].[dbo].[dimTblTime]'
	END
ELSE
	BEGIN
		INSERT INTO [lounge_db].[dbo].[dimTblTime]
		SELECT 
			CONVERT(VARCHAR(10),@Report_Month,126)																		AS [report_month_pk],
			substring(CONVERT(VARCHAR(11),@Report_Month,106),4,3)+'-'+right(CONVERT(VARCHAR(11),@Report_Month,106),4)	AS [month_name],
			CONVERT(VARCHAR(10),DATEADD(qq, DATEDIFF(qq, 0, @Report_Month), 0),126) 									AS [quarter],
			left(CONVERT(VARCHAR(10),@Report_Month,126),4)+ ' Q' + CONVERT(VARCHAR(1),DATEPART(QUARTER, @Report_Month)) AS [quarter_name],
			left(CONVERT(VARCHAR(10),@Report_Month,126),4)+ '-01-01'													AS [year],
			left(CONVERT(VARCHAR(10),@Report_Month,126),4)																AS [year_name],
			DATEPART(WEEK, @Report_Month)																				AS [week]
	END
	