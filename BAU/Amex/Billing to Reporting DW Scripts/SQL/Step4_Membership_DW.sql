
-- HD AWS to ran this successfully on 12/06/20 with @report_month = '2020-05-01'
-- AA AWS to ran this successfully on 19/06/20 with @report_month = '2020-05-01'
-- HD AWS to ran this successfully on 24/06/20 with @report_month = '2020-05-01'
-- HD AWS to ran this successfully on 09/07/20 with @report_month = '2020-06-01'
-- HD AWS to ran this successfully on 07/08/20 with @report_month = '2020-06-01'
-- HD AWS to ran this successfully on 10/08/20 with @report_month = '2020-07-01'
-- HD AWS to ran this successfully on 09/09/20 with @report_month = '2020-08-01'
-- HD AWS to ran this successfully on 07/10/20 with @report_month = '2020-09-01'
-- HD AWS to ran this successfully on 06/11/20 with @report_month = '2020-10-01'
-- HD AWS to ran this successfully on 04/12/20 with @report_month = '2020-11-01'
-- HD AWS to ran this successfully on 07/12/20 with @report_month = '2020-11-01'
-- HD AWS to ran this successfully on 08/01/21 with @report_month = '2020-12-01'
-- HD AWS to ran this successfully on 05/02/21 with @report_month = '2021-01-01'
-- HD AWS to ran this successfully on 05/03/21 with @report_month = '2021-02-01'
-- HD AWS to ran this successfully on 10/03/21 with @report_month = '2021-02-01' -- BIBAU-2734
-- HD AWS to ran this successfully on 09/04/21 with @report_month = '2021-03-01'
-- HD AWS to ran this successfully on 08/05/21 with @report_month = '2021-04-01'
-- HD AWS to ran this successfully on 12/05/21 with @report_month = '2021-04-01'
-- HD AWS to ran this successfully on 07/06/21 with @report_month = '2021-05-01'
-- HD AWS to ran this successfully on 08/07/21 with @report_month = '2021-06-01'
-- HD AWS to ran this successfully on 06/08/21 with @report_month = '2021-07-01'
-- HD AWS to ran this successfully on 07/09/21 with @report_month = '2021-08-01'
-- HD AWS to ran this successfully on 08/10/21 with @report_month = '2021-09-01'
-- HD AWS to ran this successfully on 05/11/21 with @report_month = '2021-10-01'
-- HD AWS to ran this successfully on 03/12/21 with @report_month = '2021-10-01' OPSBI - 96
-- HD AWS to ran this successfully on 13/12/21 with @report_month = '2021-11-01'
-- HD AWS to ran this successfully on 10/01/22 with @report_month = '2021-12-01'
-- HD AWS to ran this successfully on 14/02/22 with @report_month = '2022-01-01'
-- HD AWS to ran this successfully on 15/02/22 with @report_month = '2022-01-01' OPSBI - 106
-- HD AWS to ran this successfully on 11/03/22 with @report_month = '2022-02-01'
-- HD AWS to ran this successfully on 07/04/22 with @report_month = '2022-03-01'
-- HD AWS to ran this successfully on 27/04/22 with @report_month = '2022-03-01'
-- HD AWS to ran this successfully on 10/05/22 with @report_month = '2022-04-01'
-- HD AWS to ran this successfully on 10/06/22 with @report_month = '2022-05-01'
-- HD AWS to ran this successfully on 13/07/22 with @report_month = '2022-06-01'
-- HD AWS to ran this successfully on 09/08/22 with @report_month = '2022-07-01'
-- HD AWS to ran this successfully on 12/09/22 with @report_month = '2022-08-01'
-- HD AWS to ran this successfully on 12/10/22 with @report_month = '2022-09-01'
-- HD AWS to ran this successfully on 09/11/22 with @report_month = '2022-10-01'
-- HD AWS to ran this successfully on 08/12/22 with @report_month = '2022-11-01'
-- HD AWS to ran this successfully on 11/01/23 with @report_month = '2022-12-01'
-- HD AWS to ran this successfully on 13/01/23 with @report_month = '2022-12-01'
-- HD AWS to ran this successfully on 31/01/23 with @report_month = '2022-11-01'
-- HD AWS to ran this successfully on 07/02/23 with @report_month = '2023-01-01'

/*****************************************
** Project ID	 :  DW - Amex - Step 4
** Author		 :	Hyun Sung Lee
** Last Mofified :	2015-09-09
******************************************/

USE amex_billing_db_va
GO

DECLARE @report_month AS DATE

-- Set report month
SET @report_month = '2023-01-01'

SELECT * FROM amex_dw.dbo.factTblMemberships WHERE billing_month_fk = @report_month

DELETE  FROM amex_dw.dbo.factTblMemberships WHERE billing_month_fk = @report_month

INSERT INTO amex_dw.dbo.factTblMemberships
([billing_month_fk],[currency_code_fk],[membership_fee],
[source_code_fk],[membership_type_fk],[membership_count],[membership_total_fee],[membership_billed]) --ADDED THIS FIELDS 

SELECT
	report_month_fk,
	currency_code_fk,
	membership_fee,
	source_code_fk,
	membership_type,
	membership_count,
	membership_total_fee,
	membership_billed
	
FROM
	(
		(SELECT CAST(mb.report_month AS DATE) AS report_month_fk,cu.currency_id AS currency_code_fk,
				mb.Fee AS membership_fee,mb.purchase_source_code AS source_code_fk,mt.membership_type_pk AS membership_type,
				COUNT(*) AS membership_count,SUM(mb.Fee) AS membership_total_fee,1 AS membership_billed
		 FROM amex_billing_db_va.dbo.tblMemberships mb
		 LEFT JOIN lounge_db.dbo.dimTblCurrency cu ON cu.currency_code_iso = mb.Currency
		 LEFT JOIN amex_dw.dbo.dimTblMembershipType mt ON mt.membership_type = mb.type
		 WHERE report_month = @report_month
		 GROUP BY mb.report_month,cu.currency_id,mb.fee,mb.purchase_source_code,mt.membership_type_pk)
	 UNION
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
		 GROUP BY mb.report_month,cu.currency_id,mb.fee,mb.purchase_source_code,mt.membership_type_pk)
	) AS x

ORDER BY
	report_month_fk,
	currency_code_fk,
	membership_fee,
	source_code_fk,
	membership_type
	
	
/*
---------------------------------------------------------------------------------------------------------------------------------------
--- check script for missing records
---------------------------------------------------------------------------------------------------------------------------------------

DECLARE @report_month AS DATE
SET @report_month = '2016-04-01'

SELECT distinct
	--report_month_fk,currency_code_fk,membership_fee,source_code_fk,membership_type,membership_count,membership_total_fee,membership_billed
	source_code_fk	
FROM
	(
		(SELECT CAST(mb.report_month AS DATE) AS report_month_fk,cu.currency_id AS currency_code_fk,
				mb.Fee AS membership_fee,mb.purchase_source_code AS source_code_fk,mt.membership_type_pk AS membership_type,
				COUNT(*) AS membership_count,SUM(mb.Fee) AS membership_total_fee,1 AS membership_billed
		 FROM amex_billing_db_va.dbo.tblMemberships mb
		 LEFT JOIN lounge_db.dbo.dimTblCurrency cu ON cu.currency_code_iso = mb.Currency
		 LEFT JOIN amex_dw.dbo.dimTblMembershipType mt ON mt.membership_type = mb.type
		 WHERE report_month = @report_month
		 GROUP BY mb.report_month,cu.currency_id,mb.fee,mb.purchase_source_code,mt.membership_type_pk)
	 UNION
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
		 GROUP BY mb.report_month,cu.currency_id,mb.fee,mb.purchase_source_code,mt.membership_type_pk)
	) AS x
WHERE x.source_code_fk not in (SELECT [source_code_pk] FROM [amex_dw].[dbo].[dimTblSourceCodes])

---------------------------------------------------------------------------------------------------------------------------------------
--- check to insert missing records
---------------------------------------------------------------------------------------------------------------------------------------


-- script to insert missing record

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
Values
	( 
	'LXNCCED4BSALASA'
	,'AT'
	,'AMEXSAU'
	,'GNS'
	,'AX GNS Saudi Arabia Green Consumer Basic 1FV per annum' 
	,'Consumer'
	,'Green'
	,'Basic'
	,'L'
	,'Priority Pass'
	,'SAU'
	,'EMEA'
	,'Amex Saudi Arabia Ltd'
	)


SELECT * FROM [amex_dw].[dbo].[dimTblSourceCodes]
where source_code_pk = 'LXNCCED4BSALASA'

COMMIT	

----------------- SET deal_type -----------------------------------------
SELECT *  FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
WHERE source_code in ('HXPGCEB3BJPU')

UPDATE [amex_source_code_db].[dbo].[tblSourceCodeMaster]
SET deal_type = 'Amex / Wholesale Lite'
WHERE source_code ='HXPGCEB3BJPU'

--------------------- SET currency_code_fk --------------------------------
SELECT * FROM amex_dw.dbo.factTblMemberships 
WHERE billing_month_fk = '2016-03-01'
AND source_code_fk = 'HXPGCEB3BJPU'

update amex_dw.dbo.factTblMemberships 
SET currency_code_fk = 1
WHERE billing_month_fk = '2016-03-01'
AND source_code_fk = 'HXPGCEB3BJPU'
*/	