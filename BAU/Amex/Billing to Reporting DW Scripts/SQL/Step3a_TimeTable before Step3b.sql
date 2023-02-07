/*
RUN  HISTORY
============

HD AWS to run on 12/06/2020 Ran successfully with @ReportMonth	= '2020-05-01'
AA AWS to run on 19/06/2020 Ran successfully with @ReportMonth	= '2020-05-01'
AA AWS to run on 24/06/2020 Ran successfully with @ReportMonth	= '2020-05-01'
HD AWS to run on 09/07/2020 Ran successfully with @ReportMonth	= '2020-06-01'
HD AWS to run on 07/08/2020 Ran successfully with @ReportMonth	= '2020-06-01'
HD AWS to run on 10/08/2020 Ran successfully with @ReportMonth	= '2020-07-01'
HD AWS to run on 09/09/2020 Ran successfully with @ReportMonth	= '2020-08-01'
HD AWS to run on 07/10/2020 Ran successfully with @ReportMonth	= '2020-09-01'
HD AWS to run on 06/11/2020 Ran successfully with @ReportMonth	= '2020-10-01'
HD AWS to run on 04/12/2020 Ran successfully with @ReportMonth	= '2020-11-01'
HD AWS to run on 07/12/2020 Ran successfully with @ReportMonth	= '2020-11-01'
HD AWS to run on 08/01/2021 Ran successfully with @ReportMonth	= '2020-12-01'
HD AWS to run on 05/02/2021 Ran successfully with @ReportMonth	= '2021-01-01'
HD AWS to run on 05/03/2021 Ran successfully with @ReportMonth	= '2021-02-01'
HD AWS to run on 10/03/2021 Ran successfully with @ReportMonth	= '2021-02-01'
HD AWS to run on 09/04/2021 Ran successfully with @ReportMonth	= '2021-03-01'
HD AWS to run on 08/05/2021 Ran successfully with @ReportMonth	= '2021-04-01'
HD AWS to run on 12/05/2021 Ran successfully with @ReportMonth	= '2021-04-01'
HD AWS to run on 12/05/2021 Ran successfully with @ReportMonth	= '2021-05-01'
HD AWS to run on 08/07/2021 Ran successfully with @ReportMonth	= '2021-06-01'
HD AWS to run on 06/08/2021 Ran successfully with @ReportMonth	= '2021-07-01'
HD AWS to run on 07/09/2021 Ran successfully with @ReportMonth	= '2021-08-01'
HD AWS to run on 08/10/2021 Ran successfully with @ReportMonth	= '2021-09-01'
HD AWS to run on 05/11/2021 Ran successfully with @ReportMonth	= '2021-10-01'
HD AWS to run on 03/12/2021 Ran successfully with @ReportMonth	= '2021-10-01' - OPSBI - 96
HD AWS to run on 13/12/2021 Ran successfully with @ReportMonth	= '2021-11-01'
HD AWS to run on 10/01/2022 Ran successfully with @ReportMonth	= '2021-12-01'
HD AWS to run on 14/02/2022 Ran successfully with @ReportMonth	= '2022-01-01'
HD AWS to run on 15/02/2022 Ran successfully with @ReportMonth	= '2022-01-01' - OPSBI - 106
HD AWS to run on 11/03/2022 Ran successfully with @ReportMonth	= '2022-02-01'
HD AWS to run on 07/04/2022 Ran successfully with @ReportMonth	= '2022-03-01'
HD AWS to run on 27/04/2022 Ran successfully with @ReportMonth	= '2022-03-01'
HD AWS to run on 10/05/2022 Ran successfully with @ReportMonth	= '2022-04-01'
HD AWS to run on 10/06/2022 Ran successfully with @ReportMonth	= '2022-05-01'
HD AWS to run on 13/07/2022 Ran successfully with @ReportMonth	= '2022-06-01'
HD AWS to run on 09/08/2022 Ran successfully with @ReportMonth	= '2022-07-01'
HD AWS to run on 12/09/2022 Ran successfully with @ReportMonth	= '2022-08-01'
HD AWS to run on 12/10/2022 Ran successfully with @ReportMonth	= '2022-09-01'
HD AWS to run on 09/11/2022 Ran successfully with @ReportMonth	= '2022-10-01'
HD AWS to run on 08/12/2022 Ran successfully with @ReportMonth	= '2022-11-01'
HD AWS to run on 11/01/2023 Ran successfully with @ReportMonth	= '2022-12-01'
HD AWS to run on 13/01/2023 Ran successfully with @ReportMonth	= '2022-12-01'
HD AWS to run on 31/01/2023 Ran successfully with @ReportMonth	= '2022-11-01'
HD AWS to run on 07/02/2023 Ran successfully with @ReportMonth	= '2023-01-01'
*/

-- SELECT * FROM [amex_dw].[dbo].[Time] WHERE PK_Date='2016-03-01'

DECLARE @ReportMonth	DATE
DECLARE @Year			INT
DECLARE @Month			INT
DECLARE @NumRecs		INT

SET @ReportMonth	= '2023-01-01'	-- set this value
SET @Year			= YEAR(@ReportMonth)
SET @Month			= MONTH(@ReportMonth)

--SELECT * FROM [amex_dw].[dbo].[Time] WHERE YEAR(PK_Date) = @Year AND MONTH(PK_Date) = @Month

SET @NumRecs		= (SELECT COUNT(*) FROM [amex_dw].[dbo].[Time] WHERE YEAR(PK_Date) = @Year AND MONTH(PK_Date) = @Month)

--SELECT @ReportMonth,@Year,@Month,@NumRecs

IF @NumRecs>0
	BEGIN
		PRINT 'Data exists for this month so delete it and reload'
		--DELETE FROM [amex_dw].[dbo].[Time] WHERE YEAR(PK_Date) = @Year AND MONTH(PK_Date) = @Month
	END
ELSE
	BEGIN
		INSERT INTO [amex_dw].[dbo].[Time] 
			(
			[PK_Date],[Date_Name],[Year],[Year_Name],[Quarter],[Quarter_Name],[Month],[Month_Name]
			,[Week],[Week_Name],[Day_Of_Year],[Day_Of_Year_Name],[Day_Of_Quarter],[Day_Of_Quarter_Name]
			,[Day_Of_Month],[Day_Of_Month_Name],[Day_Of_Week],[Day_Of_Week_Name],[Week_Of_Year]
			,[Week_Of_Year_Name],[Month_Of_Year],[Month_Of_Year_Name],[Month_Of_Quarter],[Month_Of_Quarter_Name]
			,[Quarter_Of_Year],[Quarter_Of_Year_Name]
			) 
		SELECT 
			[Date] AS PK_Date,[PK_Date] AS Date_Name,[Year],[Year_Name],[Quarter],[Quarter_Name],[Month],[Month_Name]
			,[Week],[Week_Name],[Day_Of_Year],[Day_Of_Year_Name]
			,DATEDIFF(d, DATEADD(qq, DATEDIFF(qq, 0, [DATE]), 0), [DATE]) + 1 AS [Day_Of_Quarter]
			,'Day '+CONVERT(VARCHAR(2),(DATEDIFF(d, DATEADD(qq, DATEDIFF(qq, 0, [DATE]), 0), [DATE]) + 1))   AS [Day_Of_Quarter_Name]
			,[Day_Of_Month],[Day_Of_Month_Name],[Day_Of_Week],[Day_Of_Week_Name],[Week_Of_Year],[Week_Of_Year_Name],[Month_Of_Year]
			,[Month_Of_Year_Name],[Month_Of_Quarter],[Month_Of_Quarter_Name],[Quarter_Of_Year],[Quarter_Of_Year_Name]
		FROM [visa_dw].[dbo].[dimTblTime] 
		WHERE YEAR([Date]) = @Year AND  MONTH([Date]) = @Month 
		ORDER BY date_id DESC
	END








--SELECT TOP 170 * FROM [amex_dw].[dbo].[Time] ORDER BY 1 desc


--SELECT * 
--FROM [amex_dw].[dbo].[Time] 
--WHERE YEAR(PK_Date) = @Year AND MONTH(PK_Date) = @Month
--ORDER BY PK_Date


	