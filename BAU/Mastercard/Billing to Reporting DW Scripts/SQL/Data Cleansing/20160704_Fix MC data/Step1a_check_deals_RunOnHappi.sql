use mastercard_db
/*
	STEP 1
	MasterCard CSV Billing Files
	Maintain Source Codes, across Deals & Billing tables
	
	Purpose
	
	Identify missing/incorrect deals in the deals table and align both tables (deals & billing)
		
	Created by:		Bilal Ahmed
	Date Created:	16-Jun-2015
	For Lifestyle Benefits, The Collinson Group
	
	-- PRIVATE AND CONFIDENTIAL --		
*/

SELECT 
	deals_billed.DataSet,
	deals_billed.[Source Code],	
	deals.billing_inclusion_memberships,
	deals.billing_inclusion_lounge_visits,
	deals.billing_inclusion_freight
FROM
(
	SELECT
		DISTINCT	
		'Indirect Associates Memberships' AS [DataSet],
		prefix AS [Source Code]
	FROM 
		dbo.tblMemberships

	UNION

	SELECT 
		DISTINCT
		'Indirect Associates LoungeVisits' AS [DataSet],	
		Associate_Prefix AS [Source Code]
	FROM 
		dbo.tblLoungeVisits

	UNION
	
		SELECT DISTINCT 
		'Memberships' AS [DataSet],
		prefix AS [Source Code] 
		FROM 
			mastercard_db.dbo.tblMemberships
	
	UNION

	SELECT
		DISTINCT
		'Wholesale Lite Memberships' AS [DataSet],
		client_id AS [Source Code]
	FROM
		dbo.tblWLMemberships

	UNION

	SELECT
		DISTINCT
		'Wholesale Lite LoungeVisits' AS [DataSet],
		Associate_Prefix AS [Source Code]
	FROM
		dbo.tblWSLoungeVisits
		
	UNION

	SELECT
		DISTINCT
		'LoungeKey CIF' AS [DataSet],
		client_id AS [Source Code]
	FROM
		dbo.tblLKCIF

	UNION

	SELECT
		DISTINCT
		'LoungeKey LoungeVisits' AS [DataSet],
		client_id AS [Source Code]
	FROM
		tblLKLoungeVisits
	) deals_billed
	
	LEFT JOIN deals_db.dbo.dimTblMCDeals deals ON deals.clientid = deals_billed.[Source Code]

WHERE
	deals.clientid IS NULL
ORDER BY 1,2	
	
	
-- select * from deals_db.dbo.dimTblMCDeals	