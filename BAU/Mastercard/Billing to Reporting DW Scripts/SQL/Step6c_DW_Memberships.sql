/*********************************************************************************************************************
** Project ID	 : Datawarehous - MasterCard - Step 6c
** Author		 : Austine Esemiteye
** Last Mofified : 2016-09-13
** Amend History : Added date range parameter

run successfully for September data.
GM	14/11/2016 run successfully for October data.
AE	15/12/2016 run successfully for Nov data.
AE	16/01/2017 run successfully for Dec data.
AE	17/02/2017 run successfully for Jan data.
VP	17/03/2017 run successfully for Feb data.
AE	13/04/2017 run successfully for MAR data.
VP	25/04/2017 run successfully for MAR data. -- Rerun https://jira.ptgmis.com/browse/BI-384
VP	03/05/2017 run successfully for MAR data. -- Rerun https://jira.ptgmis.com/browse/BI-411
VP	12/05/2017 run successfully for Apr data. 
AE	13/06/2017 run successfully for May data.
AE	14/07/2017 run successfully for june data.
AE	11/08/2017 run successfully for July data.
VP 14/08/2017 Ran successfully for Aug data 
AA 13/10/2017 Ran successfully for SEP data 
AA 14/11/2017 Ran successfully for Oct data 
AA 14/12/2017 Ran successfully for Nov data 
AA 11/01/2018 Ran successfully for Dec data 
AA 13/02/2018 Ran successfully for Jan 2018 data 
AA 13/03/2018 Ran successfully for Feb 2018 data 
AA 13/04/2018 Ran successfully for Mar 2018 data 

**********************************************************************************************************************/

DECLARE @NumRecs		AS BIGINT
DECLARE @RecsImported	AS BIGINT
DECLARE @RecsInserted	AS BIGINT
DECLARE @MetricImported	AS BIGINT
DECLARE @MetricInserted	AS BIGINT
DECLARE @RecsExist		AS SQL_VARIANT

DECLARE @StartDate	AS DATE
DECLARE @EndDate	AS DATE

-- Set Report Month range
SET @StartDate = '2018-03-01'
SET @EndDate   = '2018-03-01'

SET NOCOUNT OFF

-----------------------------------------------------------------------------------------------------------------------
---------------------------------------------- MasterCard Data Warehouse    -------------------------------------------
---------------------------------------------- Build Memberships Fact Table -------------------------------------------
-----------------------------------------------------------------------------------------------------------------------

----SET @NumRecs = (SELECT COUNT(*) FROM mastercard_dw.dbo.factTblMembership WHERE [billing_month_fk] BETWEEN @start_month AND @end_month)

SET @RecsExist = (SELECT TOP 1 [billing_month_fk] FROM mastercard_dw.dbo.factTblMembership WHERE [billing_month_fk] BETWEEN  @StartDate AND @EndDate)

IF @RecsExist IS NOT NULL
	BEGIN
		DELETE FROM mastercard_dw.dbo.factTblMembership WHERE [billing_month_fk] BETWEEN  @StartDate AND @EndDate
	END;

BEGIN
	INSERT INTO mastercard_dw.dbo.factTblMembership
	(   billing_month_fk,
		clientid,
		account_type_fk,
		New_membership_count
	)
		
	SELECT 
		billing_month_fk,
		clientid,
		account_type_fk,
		New_membership_count
	FROM 
		(

		/*
			WHOLESALE LITE - RBSG is typically contained here 
		*/
		SELECT
			CAST(wl.[billing_month] AS DATE)	AS billing_month_fk,
			wl.[client_id]						AS clientid,
			dl.[account_type_fk]				AS account_type_fk,
			CASE WHEN wl.activity_code = 'REFUND'	  THEN -1 
				 WHEN wl.activity_code = 'NEWMCWLITE' THEN 1 
			END									AS New_membership_count
		FROM 
			[mastercard_db].[dbo].[tblWLMemberships]		  wl
			INNER JOIN [mastercard_dw].[dbo].[dimTblMCIDeals] dl ON dl.clientid = wl.[client_id]
		WHERE 
			wl.[billing_month] BETWEEN  @StartDate AND @EndDate AND
			wl.activity_code IN ('REFUND','NEWMCWLITE')


		--UNION


		--/*
		--	WHOLESALE
		--*/
		--SELECT
		--	CAST(ws.[billing_month] AS DATE)	AS billing_month_fk,
		--	ws.[prefix]							AS clientid,
		--	dl.[account_type_fk]				AS account_type_fk,
		--	1									AS New_membership_count
		--FROM 
		--	[mastercard_db].[dbo].[tblMemberships]			  ws
		--	INNER JOIN [mastercard_dw].[dbo].[dimTblMCIDeals] dl ON dl.clientid = ws.[prefix]
		--WHERE 
		--	ws.[billing_month] BETWEEN  @StartDate AND @EndDate AND
		--	ws.sales_type = 'New' AND 
		--	ws.kit_includes = 'Membership'


		--UNION


		--/*
		--	LOUNGE KEY
		--*/
		--SELECT 
		--	CAST(lk.[report_month] AS DATE)		AS billing_month_fk,
		--	lk.client_id						AS clientid,
		--	dl.[account_type_fk]				AS account_type_fk,
		--	1									AS New_membership_count
		--FROM 
		--	[mastercard_db].[dbo].[tblLKMemberships]		  lk
		--	INNER JOIN [mastercard_dw].[dbo].[dimTblMCIDeals] dl ON dl.clientid = lk.client_id
		--WHERE
		--	lk.[report_month] BETWEEN  @StartDate AND @EndDate


		--UNION


		--/*
		--	DIRECT ASSOCIATES
		--*/
		--SELECT
		--	CAST(da.[billing_month] AS DATE)	AS billing_month_fk,
		--	da.prefix							AS clientid,
		--	dl.[account_type_fk]				AS account_type_fk,
		--	1									AS New_membership_count
		--FROM 
		--	[mastercard_db].[dbo].[tblDAMembership]			  da
		--	INNER JOIN [mastercard_dw].[dbo].[dimTblMCIDeals] dl ON dl.clientid = Da.prefix
		--WHERE
		--	da.[billing_month] BETWEEN  @StartDate AND @EndDate AND
		--	da.sales_type ='New' AND 
		--	da.kit_includes ='Membership'

		) memberships
END;


/*
	Validation
*/
---- Imported From
--SELECT 
--	@RecsImported	= COUNT(*),
--	@MetricImported = SUM(CASE WHEN wl.activity_code = 'REFUND'		THEN -1 
--							   WHEN wl.activity_code = 'NEWMCWLITE' THEN 1 
--						  END)
--FROM 
--	[mastercard_db].[dbo].[tblWLMemberships]		  wl
--	INNER JOIN [mastercard_dw].[dbo].[dimTblMCIDeals] dl ON dl.clientid = wl.[client_id]
--WHERE 
--	wl.[billing_month] BETWEEN  @StartDate AND @EndDate AND
--	wl.activity_code IN ('REFUND','NEWMCWLITE')


---- Loaded Into
--SELECT 
--	@RecsInserted	= COUNT(*),
--	@MetricInserted = SUM(New_membership_count)
--FROM 
--	mastercard_dw.dbo.factTblMembership 
--WHERE 
--	[billing_month_fk] BETWEEN  @StartDate AND @EndDate


--PRINT 'Number of Records copied from 45   = ' + CONVERT(NVARCHAR(20), @RecsImported)
--PRINT 'Number of Records inserted into DW = ' + CONVERT(NVARCHAR(20), @RecsInserted)
--PRINT 'Total CIF copied from 45   = ' + CONVERT(NVARCHAR(20), @MetricImported)
--PRINT 'Total CIF inserted into DW = ' + CONVERT(NVARCHAR(20), @MetricInserted)