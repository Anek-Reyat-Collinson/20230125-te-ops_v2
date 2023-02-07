---------------------------------------------------------------------------------------------------------------------------------------
--- check script for missing records in dimTblSourceCodes


   -- HD AWS ran on 12/06/2020 for @report_month = '2020-05-01'
   -- AA AWS ran on 19/06/2020 for @report_month = '2020-05-01'
   -- HD AWS ran on 24/06/2020 for @report_month = '2020-05-01'
   -- HD AWS ran on 09/07/2020 for @report_month = '2020-06-01'
   -- HD AWS ran on 07/08/2020 for @report_month = '2020-06-01'
   -- HD AWS ran on 10/08/2020 for @report_month = '2020-07-01'
   -- HD AWS ran on 09/09/2020 for @report_month = '2020-08-01'
   -- HD AWS ran on 07/10/2020 for @report_month = '2020-09-01'
   -- HD AWS ran on 06/11/2020 for @report_month = '2020-10-01'
   -- HD AWS ran on 04/12/2020 for @report_month = '2020-11-01'
   -- HD AWS ran on 07/12/2020 for @report_month = '2020-11-01'
   -- HD AWS ran on 08/01/2021 for @report_month = '2020-12-01'
   -- HD AWS ran on 05/02/2021 for @report_month = '2021-01-01'
   -- HD AWS ran on 05/03/2021 for @report_month = '2021-02-01'
   -- HD AWS ran on 10/03/2021 for @report_month = '2021-02-01'
   -- HD AWS ran on 09/04/2021 for @report_month = '2021-03-01'
   -- HD AWS ran on 08/05/2021 for @report_month = '2021-04-01'
   -- HD AWS ran on 12/05/2021 for @report_month = '2021-04-01'
   -- HD AWS ran on 07/06/2021 for @report_month = '2021-05-01'
   -- HD AWS ran on 08/07/2021 for @report_month = '2021-06-01'
   -- HD AWS ran on 06/08/2021 for @report_month = '2021-07-01'
   -- HD AWS ran on 07/09/2021 for @report_month = '2021-08-01'
   -- HD AWS ran on 08/10/2021 for @report_month = '2021-09-01'
   -- HD AWS ran on 05/11/2021 for @report_month = '2021-10-01'
   -- HD AWS ran on 03/12/2021 for @report_month = '2021-10-01' - OPSBI - 96
   -- HD AWS ran on 13/12/2021 for @report_month = '2021-11-01'
   -- HD AWS ran on 10/01/2022 for @report_month = '2021-12-01'
   -- HD AWS ran on 14/02/2022 for @report_month = '2022-01-01'
   -- HD AWS ran on 15/02/2022 for @report_month = '2022-01-01' - OPSBI - 106
   -- HD AWS ran on 10/03/2022 for @report_month = '2022-02-01'
   -- HD AWS ran on 07/04/2022 for @report_month = '2022-03-01'
   -- HD AWS ran on 27/04/2022 for @report_month = '2022-03-01'
   -- HD AWS ran on 10/05/2022 for @report_month = '2022-04-01'
   -- HD AWS ran on 10/06/2022 for @report_month = '2022-05-01'
   -- HD AWS ran on 13/07/2022 for @report_month = '2022-06-01'
   -- HD AWS ran on 09/08/2022 for @report_month = '2022-07-01'
   -- HD AWS ran on 12/09/2022 for @report_month = '2022-08-01'
   -- HD AWS ran on 12/10/2022 for @report_month = '2022-09-01'
   -- HD AWS ran on 09/11/2022 for @report_month = '2022-10-01'
   -- HD AWS ran on 08/12/2022 for @report_month = '2022-11-01'
   -- HD AWS ran on 11/01/2023 for @report_month = '2022-12-01'
   -- HD AWS ran on 13/01/2023 for @report_month = '2022-12-01'
   -- HD AWS ran on 31/01/2023 for @report_month = '2022-11-01'
   -- HD AWS ran on 07/02/2023 for @report_month = '2023-01-01'

---------------------------------------------------------------------------------------------------------------------------------------

-- if the script below returns records then use the script below (commented)to insert 
   --the recods in the [amex_dw].[dbo].[dimTblSourceCodes] from [amex_source_code_db].[dbo].[tblSourceCodeMaster]
-- first check if the source codes exists
-- script to insert any missing source codes into the DW

--after the updates are done in both Happi and .45 rerun step 1 b
--------------------------------------------------------------------------------------------------------------------------------
DECLARE @report_month AS DATE
SET @report_month = '2023-01-01'

SELECT distinct
	'amex_billing_db_va.dbo.tblMemberships' AS ParentTable,source_code_fk	
FROM
	(SELECT CAST(mb.report_month AS DATE) AS report_month_fk,cu.currency_id AS currency_code_fk,
		mb.Fee AS membership_fee,mb.purchase_source_code AS source_code_fk,mt.membership_type_pk AS membership_type,
		COUNT(*) AS membership_count,SUM(mb.Fee) AS membership_total_fee,1 AS membership_billed
	FROM amex_billing_db_va.dbo.tblMemberships mb
		LEFT JOIN lounge_db.dbo.dimTblCurrency cu ON cu.currency_code_iso = mb.Currency
		LEFT JOIN amex_dw.dbo.dimTblMembershipType mt ON mt.membership_type = mb.type
	WHERE report_month = @report_month
	GROUP BY mb.report_month,cu.currency_id,mb.fee,mb.purchase_source_code,mt.membership_type_pk) AS x
WHERE x.source_code_fk NOT IN (SELECT [source_code_pk] FROM [amex_dw].[dbo].[dimTblSourceCodes])

UNION ALL

SELECT distinct
	'amex_billing_db_va.dbo.tblMemberships_Removed ' AS ParentTable,source_code_fk	
FROM
	(SELECT CAST(mb.report_month AS DATE) AS report_month_fk,
		CASE WHEN cu.currency_id IS NULL THEN 1 ELSE cu.currency_id END AS currency_code_fk,		
		CASE WHEN mt.membership_type_pk NOT IN (1,2) THEN 0 ELSE CASE WHEN mb.fee IS NULL THEN 99 ELSE mb.fee END END AS membership_fee,				
		mb.purchase_source_code AS source_code_fk,mt.membership_type_pk AS membership_type,
		COUNT(*) AS membership_count,0 AS membership_total_fee,2 AS membership_billed
	FROM amex_billing_db_va.dbo.tblMemberships_Removed mb	
		INNER JOIN(SELECT * FROM amex_source_code_db.dbo.tblFulfilmentPricing WHERE end_date > @report_month) mp ON mb.purchase_source_code = mp.source_code
		LEFT JOIN lounge_db.dbo.dimTblCurrency cu ON cu.currency_code_iso = mp.fulfilment_currency
		LEFT JOIN amex_dw.dbo.dimTblMembershipType mt ON mt.membership_type = mb.type	 
	WHERE report_month = @report_month
	GROUP BY mb.report_month,cu.currency_id,mb.fee,mb.purchase_source_code,mt.membership_type_pk) AS x
WHERE x.source_code_fk NOT IN (SELECT [source_code_pk] FROM [amex_dw].[dbo].[dimTblSourceCodes])

UNION ALL

SELECT
	'amex_billing_db_va.dbo.tblCIFSummary' AS ParentTable,xx.source_code_fk
FROM
	(SELECT [Report Month] AS report_month,source_code AS source_code_fk,SUM(CIF) AS cards_in_force
	FROM amex_billing_db_va.dbo.tblCIFSummary
	WHERE [Report Month] = @report_month
	GROUP BY [Report Month], source_code) AS xx
WHERE xx.source_code_fk NOT IN (SELECT [source_code_pk] FROM [amex_dw].[dbo].[dimTblSourceCodes])

UNION ALL

SELECT
	'amex_associates_db.dbo.tblCardsInForce' AS ParentTable,xx.source_code_fk
FROM
	(SELECT [Report Month] AS report_month,source_code AS source_code_fk,SUM(CIF) AS cards_in_force
	FROM amex_associates_db.dbo.tblCardsInForce
	WHERE [Report Month] = @report_month
	GROUP BY [Report Month], source_code) AS xx
WHERE xx.source_code_fk NOT IN (SELECT [source_code_pk] FROM [amex_dw].[dbo].[dimTblSourceCodes])

UNION all
SELECT
	'amex_associates_db.dbo.tblLoungeVisits' AS ParentTable,xx.source_code_fk
FROM
	(SELECT [Report Month] AS report_month,[Source Code] AS source_code_fk
	FROM amex_associates_db.dbo.tblLoungeVisits
	WHERE [Report Month] = @report_month
	GROUP BY [Report Month], [Source Code]) AS xx
WHERE xx.source_code_fk NOT IN (SELECT [source_code_pk] FROM [amex_dw].[dbo].[dimTblSourceCodes])


------check USD,GBP

select * from  [amex_associates_db].[dbo].[tblLoungeVisits]
 where  Currency in  ('USD', 'GBP')

-- if yes refer https://jira.ptgmis.com/browse/BIBAU-1963

------------------------------------------------------
/*
-- if the script above returns records then use the script below to insert 
-- the recods in the [amex_dw].[dbo].[dimTblSourceCodes] from [amex_source_code_db].[dbo].[tblSourceCodeMaster]
-- first check if the source codes exists
-- script to insert any missing source codes into the DW

begin tran

insert into [amex_dw].[dbo].[dimTblSourceCodes]
	(
	[source_code_pk]    
	,[member_type]
	,[market]
	,[prop_gns]
	,[sourcecode_comments]
	,[business_unit]
	,[card_type]
	,[card_level]
	,[service_center]
	,[lounge_program]
	,[issuing_country_iso_3]
	,[amex_region]
	,[gns_bank_name]
	)

SELECT 
	source_code AS [source_code_pk]
	,member_type AS [member_type]
	,market_code AS [market]
	,prop_gns AS [prop_gns]
	,deal_details AS [sourcecode_comments]
	,business_unit AS [business_unit]
	,card_type AS [card_type]
	,card_level AS [card_level]
	,service_centre AS [service_center]
	,lounge_program AS [lounge_program]
	,country_of_issue_iso_3 AS [issuing_country_iso_3]
	,amex_region AS [amex_region]
	,gns_bank_name AS [gns_bank_name]

FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
WHERE source_code IN 
		( 
'DXUCCPC4BBRUJHS',
'HXPGCED4BMYUMAY')

*/
--commit



--Run on 08/12/17 TO UPDATE 7 rows
--begin tran

--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name]
--	)

--SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]

--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN 
--('LXCCCEA4BBHMAME',
--'LXGCCED4BBHMAME',
--'LXGCRED4BBHMAME',
--'LXNGCED4BBHMAME',
--'LXPCRED4BBHMAME',
--'LXCCCEA4BBHMAME',
--'LXGCRED4BBHMAME',
--'LXGCCED4BBHMAME',
--'LXPCRED4BBHMAME',
--'LXNGCED4BBHMAME')--(5 row(s) affected)
----commit






/****************
Run on 09/10/17 to update below missing src code with opubo's assistance
BEGIN TRANSACTION
INSERT INTO [AMEX_DW].[DBO].[DIMTBLSOURCECODES]
	(
	[source_code_pk]      
	,[member_type]    
	,[market]    
	,[prop_gns]   
	,[sourcecode_comments]  
	,[business_unit]   
	,[card_type]   
	,[card_level]  
	,[service_center]  
	,[lounge_program] 
	,[issuing_country_iso_3]
	,[amex_region]  
	,[gns_bank_name]  
	) VALUES (7800018021,'M','China','GNS Associates','ICBC, China - Centurion','Consumer','Centurion','Basic','H','Priority Pass','CHN','JAPA','ICBC')--replicated from 7800018005
	commit
	
	SELECT * FROM [AMEX_DW].[DBO].[DIMTBLSOURCECODES] WHERE source_code_pk IN ('7800018005','7800018021') 

--//****************/
--Run on 09/10/17 TO UPDATE 5 rows
--begin tran

--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name]
--	)

--SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]

--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN 
--		( 'DXGGCSD4BARN', 'DXPRCSD4BMXG', 'DXCSWSC4BCLUSDR','DXPSWSC4BCLUSDR', 'DXPCBEA4BCAG')--(5 row(s) affected)
--commit*/

------


--Run on 08/12/17 TO UPDATE 7 rows
--begin tran

--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name]
--	)

--SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]

--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN ( 'HXGGCEC4BPKUALF','DXSCBED4BUSE','DXSACED4BUSE','LXPCCDB3BBEPALP','DXSASEA4BUSE','DXGCCSD4BARU','LXPCCDB3SBEPALP')--(7 row(s) affected)
--commit



------------------

--Run on 08/01/18 TO UPDATE 11 rows
--BEGIN tran

--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name]
--	)
--SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]

--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN ( 'DXPPCSA3BIDCLAP','DXPPCSA3SIDCLAP','HXWCCED1BKPUSAM','DXPCBEA4SCAG','DXPCBFA4BCAG','HXPCCEA4BMYNMAY','DXPCCSA4BCLUSDR','DXPCBFA4SCAG','DXPGCEA4BCAE','DXPGCFA4BCAE','HXPCCEB4SMYNMAY')--(11 row(s) affected)

--COMMIT
---------------------------------

--Run on 08/01/18 TO UPDATE 11 rows
--BEGIN tran

--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name])
--SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]

--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN ( 'LCGCRED4BGBG')--(1 row(s) affected)
--COMMIT

--------------------------------
----Run on 06/04/18 TO UPDATE 2 rows
--BEGIN tran
--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name])
--SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]

--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN ( 'LXGCCID4BITG','DXPCCSB3BARU','LXGCCID4BITG')--((2 row(s) affected))

----commit


--------------------------------
----Run on 14/05/18 TO UPDATE 9 rows
--BEGIN tran
--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name])
--SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]

--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN ('DXPCCSB3SARU',
--'HXGCCED3STWP',
--'HXPCRED3STWP',
--'LXGCRWD4SSEG',
--'LXPCRWA4SSEG',
--'LXGCRWD4BSEP',
--'LXGCRWD4SSEP',
--'LXPCRWA4BSEP',
--'LXPCRWA4SSEP')--((9 row(s) affected))

----commit


--------------------------------
--Run on 11/07/18 TO UPDATE 1 rows
--BEGIN tran
--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name])
--SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]

--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN ('LXUSMGD3BCHLSWI')--(1 row(s) affected)

----commit


--------------------------------
--Run on 13/08/18 TO UPDATE 3 rows
--BEGIN tran
--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name])
--SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]

--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code  IN ('DXUSTEA4BUSE','LXPCBEA4BGBG','LXPCBEA4SGBG')--(3 row(s) affected)

--commit

----------------------------------------------------------------
------------------------------------
----Run on 13/09/18 TO UPDATE 3 rows
--BEGIN tran
--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name])
--SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]

--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN ( 'LXUSMED3BCHLSWI','LXUSMFD3BCHLSWI','LXUSMID3BCHLSWI')--((3 row(s) affected))

----commit


--------


----Run on 09/10/18 TO UPDATE 2 rows
--BEGIN tran
--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name])
--SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]

--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN ( 'LXPCCEA4BBHMAME','LXPCCEA4SBHMAME')--((2 row(s) affected))

----commit

--------


----Run on 13/11/18 TO UPDATE 5 rows
--BEGIN tran
--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name])
--SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]

--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN ( 'LXPKRED4BKWMAME','DXGGCSD4BMXN','7800018033','7800038033','7800028033')--((5 row(s) affected))


--BEGIN TRANSACTION
--INSERT INTO [AMEX_DW].[DBO].[DIMTBLSOURCECODES]
--	(
--	[source_code_pk]      
--	,[member_type]    
--	,[market]    
--	,[prop_gns]   
--	,[sourcecode_comments]  
--	,[business_unit]   
--	,[card_type]   
--	,[card_level]  
--	,[service_center]  
--	,[lounge_program] 
--	,[issuing_country_iso_3]
--	,[amex_region]  
--	,[gns_bank_name]  
--	) VALUES
--( 7800018033,'M','Russia','GNS Associates','Russian Standard Bank Centurion','Consumer','Centurion','Basic','L','Priority Pass','','London','Russian Standard Bank')
--,
--(7800038033,'M','Russia','GNS Associates','Russian Standard Bank Gold','Consumer','Gold','Basic','L','Priority Pass','London','','Russian Standard Bank')
--,
--(7800028033,'M','Russia','GNS Associates','Russian Standard Bank Platinum','Consumer','Platinum','Basic','L','Priority Pass','','London','Russian Standard Bank')
--commit

--BEGIN TRAN
--UPDATE T SET  amex_region='EMEA',issuing_country_iso_3='RUS'
--FROM [AMEX_DW].[DBO].[DIMTBLSOURCECODES] t
--WHERE amex_region='London'
--commit
----


--Run on 13/02/19 TO UPDATE 4 rows
--BEGIN tran
--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name])
--SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]

--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN ('DXZCCSA4SMXUSDR','LXGURED4BAEMAME','LXPQRED4BQAMAME','DXPCCSA3UIDCLAP')--((2 row(s) affected))

--commit

--BEGIN TRAN
--INSERT INTO [AMEX_DW].[DBO].[DIMTBLSOURCECODES]
--	(
--	[source_code_pk]      
--	,[member_type]    
--	,[market]    
--	,[prop_gns]   
--	,[sourcecode_comments]  
--	,[business_unit]   
--	,[card_type]   
--	,[card_level]  
--	,[service_center]  
--	,[lounge_program] 
--	,[issuing_country_iso_3]
--	,[amex_region]  
--	,[gns_bank_name]  
--	) VALUES 
--	(7800068032,'M','Sri Lanka','GNS Associates','Nations Trust Bank, Sri Lanka - Platinum','Consumer','Platinum','Basic','H','Priority Pass','LKA','JAPA','Nations Trust Bank'),
--	(7800038007,'M','Bangladesh','GNS Associates','GNS City Bank, Bangladesh  - Gold Cards','Consumer','Gold','Basic','H','Priority Pass','BGD','JAPA','City Bank, Bangladesh')
	
--	COMMIT
	
	
--Run on 12/03/19 TO UPDATE 6 rows	
--	BEGIN tran
--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name])
--	SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]
--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN ('LXCCCEA4SBHMAME','DXGGCSD4BARU','LXGBRED4BBHMAME','DXPGCSB4BARU','LXGDRED4BQAMAME','LXPCCEA4BNOP')--((6 row(s) affected))
--commit	

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
----Run on 10/04/19 TO UPDATE 3 rows	
--	BEGIN tran
--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name])
--	SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]
--	FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster] 
--	WHERE source_code IN ('LXGCCED4BNOP','LXGCBID4BITP','LXHCCDB4BNLG')--((3 row(s) affected))
	
--	commit 
	
--------------------------------------------------------------------------------------------------------------------
----Run on 15/05/19 TO UPDATE 16 rows	
--	BEGIN tran
--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name])
--	SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]
--	FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster] 
--WHERE source_code IN ('DXDCCS54BECUBDG','DXPCCS54BECUBDG','LXGBRED4SBHMAME','LXGCCED4SBHMAME','LXGCRED4SBHMAME','LXGDRED4SQAMAME','LXGGCEB3BIDCEUP','LXGURED4SAEMAME','LXPCCDB4BBEP','LXPCCDB4SBEP','LXPCCFB4BBEP','LXPKRED4SKWMAME','LXPQRED4SQAMAME','DXGCCSD4BMXG','DXPRCSD4BMXP','LXGMEID4BITP')
	
--	commit 


-----

--Run on 10/06/19 TO UPDATE 5 rows	
--	BEGIN tran
--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name])
--	SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]
--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN ('LXPCBIA4BITP','LXPCBIA4SITP','LXPCCFB4SBEP','LXPCCIA4BITP','LXPCCIA4SITP')--((5 row(s) affected))
--commit	

-----

--Run on 14/10/19 TO UPDATE 2 rows	
--	BEGIN tran
--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]    
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name])
--	SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]
--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN ('DXPCCSD4BUYUBNS','DXPCCSD4SUYUBNS')--((2 row(s) affected))
--commit	




