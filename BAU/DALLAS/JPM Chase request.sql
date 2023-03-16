/*
-- =============================================================================================
--		Author		: SS
--		Create date	: 26/04/2019
--		Jira Number	: BIBAU-2404
--		Description	: Active Members Data for Chase Sapphire Reserve (CSR) Program - Rdu2 PPASS Report

		Base Query: SQL_Query_amended_by_Mahesh(BIBAU-2206)
-- -------------------------------------------------------------------
-- Copy the block below for every update to the script

--		Modified date	: 
--		Author			: 
--		Jira Number		: 
--		Description		: 
-------------------------------------------------------------------
-- ==============================================
--AA-run for september 2019
--AA-run for Nov 2019 on Dec 02 2019
--HD-run for Feb 2020 on Mar 03 2020
--HD-run for Jun 2020 on Jul 01 2020
--HD-run for Jul 2020 on Aug 03 2020
--HD-run for Aug 2020 on Sep 01 2020
--HD-run for Sep 2020 on Oct 01 2020
--HD-run for Oct 2020 on Nov 01 2020
--HD-run for Nov 2020 on Dec 01 2020
--HD-run for Dec 2020 on Jan 03 2021
--HD-run for Jan 2021 on Feb 01 2021
--HD-run for Feb 2021 on Mar 01 2021
--HD-run for Mar 2021 on Apr 01 2021
--HD-run for Apr 2021 on May 01 2021
--HD-run for May 2021 on Jun 01 2021
--HD-run for Jun 2021 on Jul 01 2021
--HD-run for Jul 2021 on Aug 02 2021
--HD-run for Aug 2021 on Sep 01 2021
--HD-run for Sep 2021 on Oct 01 2021
--HD-run for Oct 2021 on Nov 01 2021
--HD-run for Nov 2021 on Dec 01 2021
--HD-run for Dec 2021 on Jan 02 2022
--HD-run for Jan 2022 on Feb 02 2022
--HD-run for Feb 2022 on Mar 01 2022
--HD-run for Mar 2022 on Apr 01 2022
--HD-run for Apr 2022 on May 03 2022
--HD-run for May 2022 on Jun 01 2022
--HD-run for Jun 2022 on Jul 01 2022
--HD-run for Jul 2022 on Aug 01 2022
--HD-run for Aug 2022 on Sep 01 2022
--HD-run for Sep 2022 on Oct 03 2022
--HD-run for Oct 2022 on Nov 01 2022
--HD-run for Nov 2022 on Dec 01 2022
--HD-run for Dec 2022 on Jan 02 2023
--HD-run for Dec 2022 on Feb 01 2023
--HD-run for Dec 2022 on Mar 01 2023
*/
USE [PPass]
GO

IF OBJECT_ID('tempdb..#temp') IS NOT NULL
	DROP TABLE #temp 

SELECT 
	c.external_identifier AS [Member No],
	LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(ISNULL(c.title,'') + ' ' + ISNULL(c.forename,'') + ' ' + ISNULL(c.surname,''),' ',' |'),'| ',''),'|',''))) AS [Member Name],
	p.paid_to_date AS [Paid To Date],
	p.subs_issue_date AS [Issue Date],
	p.subs_status AS [Member Status],
	sdc.source_code AS [Source Code],
	CAST(NULL AS VARCHAR(100)) AS [Report Month]
	INTO #temp
FROM
	dbo.consumer c WITH(NOLOCK)
	INNER JOIN dbo.purchase_summary ps WITH(NOLOCK) ON c.consumer_no = ps.consumer_no
	INNER JOIN dbo.purchase p WITH(NOLOCK) ON ps.purchase_no = p.purchase_no
	INNER JOIN dbo.purchase_subscription_link psl WITH(NOLOCK) ON p.purchase_no = psl.purchase_no
	INNER JOIN dbo.source_subscription ss WITH(NOLOCK) ON psl.source_subscription_id = ss.source_subscription_id
	INNER JOIN dbo.source_deal_config sdc WITH(NOLOCK) ON ss.source_deal_config_id = sdc.source_deal_config_id
	INNER JOIN dbo.source s WITH(NOLOCK) ON sdc.source_code = s.source_code
WHERE
	1 = 1
		AND sdc.source_code IN (
								 'DACBSC1707DMC',
								 'DACBSD1707DMC',
								 'DACBSA1707DMC'
								 )
	AND p.isDeleted = 0
	AND cast(p.paid_to_date as date) > cast('2018-12-31' as date)
--ORDER BY
--	c.consumer_no ASC

DECLARE @FromDate DATETIME = '2019-01-01'
DECLARE @ToDate DATETIME = '2023-03-01'
DECLARE @LoopDate DATETIME

SET @LoopDate = @FromDate
DECLARE @Year INT, @Month INT, @ReportMonth VARCHAR(100)

WHILE @LoopDate <= @ToDate
BEGIN
	SET @Year = YEAR(@LoopDate)
	SET @Month = MONTH(@LoopDate)

	SET @ReportMonth = DATENAME(month, @LoopDate) + SPACE(1) + CAST(@Year AS VARCHAR(4))
	PRINT @ReportMonth
	UPDATE t
		SET [Report Month] = @ReportMonth
		FROM #temp t
		WHERE 
			MONTH([Paid To Date])  = @Month
			AND YEAR([Paid To Date]) > @Year

	SET @LoopDate = DATEADD(MONTH,1,@LoopDate)

END ;

SELECT DISTINCT [Report Month] FROM #temp
	WHERE [Report Month] IS NOT NULL
/*
April 2019
February 2019
January 2019
March 2019
May 2019
June 2019
August 2019 AA
'September 2019'
*/
  SELECT * FROM #temp WHERE [Report Month] = 'February 2023'
