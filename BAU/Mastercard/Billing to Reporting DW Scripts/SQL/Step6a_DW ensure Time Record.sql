/*******************************************************************************************************************
** Project ID	 : DW - MC - Step 6a
** Description   : To ensure that there is a record in the [lounge_db].[dbo].[dimTblTime] table for this month
** Author		 : Greg McPhillips
** Last Mofified : 2016-03-23
** Amend History : GM 23/03/2016 Changes to ensure there is no data in target for this month in target importing this months data

** Run history   :	GM 17/03/2016 Ran successfully for month = 2016-02-01
					GM 19/04/2016 Ran successfully for month = 2016-03-01
					GM 16/05/2016 Ran successfully for month = 2016-04-01 (Apr data)
					GM 16/06/2016 Ran successfully for May data	
					AE 14/07/2016 Ran successfully for June data	
					AE 20/10/2016 Ran successfully for Sep data
					GM 14/11/2016 Ran successfully for Oct data
					GM 15/12/2016 Ran successfully for Nov data
				    AE 16/01/2016 Ran successfully for Dec data
					AE 17/02/2017 Ran successfully for Jan data
					VP 17/03/2017 Ran successfully for Feb data
					AE 13/04/2017 Ran successfully for Mar data
					VP 12/05/2017 Ran successfully for Apr data
					AE 13/06/2017 Ran successfully for May data
					AE 14/07/2017 Ran successfully for June data
					AE 11/08/2017 Ran successfully for July data
					VP 14/09/2017 Ran successfully for Aug data
					AA 13/10/2017 Ran successfully for Sep data
					AA 14/11/2017 Ran successfully for Oct data
					AA 13/12/2017 Ran successfully for Nov data
					AA 11/01/2018 Ran successfully for Dec data
					AA 13/02/2018 Ran successfully for Jan data
					AA 13/03/2018 Ran successfully for Feb data
					AA 13/04/2018 Ran successfully for mar data
**********************************************************************************************************************/

DECLARE @report_month AS DATE
SET @report_month = '2018-03-01'


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
			([report_month_pk]
			,[month_name]
			,[quarter]
			,[quarter_name]
			,[year]
			,[year_name]
			,[week])
		SELECT 
			CONVERT(VARCHAR(10),@Report_Month,126)																		AS [report_month_pk],
			substring(CONVERT(VARCHAR(11),@Report_Month,106),4,3)+'-'+right(CONVERT(VARCHAR(11),@Report_Month,106),4)	AS [month_name],
			CONVERT(VARCHAR(10),DATEADD(qq, DATEDIFF(qq, 0, @Report_Month), 0),126) 									AS [quarter],
			left(CONVERT(VARCHAR(10),@Report_Month,126),4)+ ' Q' + CONVERT(VARCHAR(1),DATEPART(QUARTER, @Report_Month)) AS [quarter_name],
			left(CONVERT(VARCHAR(10),@Report_Month,126),4)+ '-01-01'													AS [year],
			left(CONVERT(VARCHAR(10),@Report_Month,126),4)																AS [year_name],
			DATEPART(WEEK, @Report_Month)																				AS [week]

	END
	
