/*******************************************************************************************************************************
** Project ID	 :  Step 4 VISA DW - Lounge Visits Import Query
** Author        : Bilal Ahmed 11-Feb-2016
** Amend History : GM 23-03-2016 Changes to 127.0.0.1,41331

** Run history   :	
					HD 20/07/2020 Ran successfully for @start_date = '2020-06-01' & @end_date = '2020-06-30'
					HD 17/08/2020 Ran successfully for @start_date = '2020-07-01' & @end_date = '2020-07-31'
					HD 17/09/2020 Ran successfully for @start_date = '2020-08-01' & @end_date = '2020-08-31'
					HD 16/10/2020 Ran successfully for @start_date = '2020-09-01' & @end_date = '2020-09-30'
					HD 17/11/2020 Ran successfully for @start_date = '2020-10-01' & @end_date = '2020-10-31'
					HD 15/12/2020 Ran successfully for @start_date = '2020-11-01' & @end_date = '2020-11-30'
					HD 18/01/2021 Ran successfully for @start_date = '2020-11-01' & @end_date = '2020-11-30'  -- DI-907
					HD 18/01/2021 Ran successfully for @start_date = '2020-12-01' & @end_date = '2020-12-31'
					HD 16/02/2021 Ran successfully for @start_date = '2021-01-01' & @end_date = '2021-01-31'
					HD 15/03/2021 Ran successfully for @start_date = '2021-02-01' & @end_date = '2021-02-28'
					HD 15/03/2021 Ran successfully for @start_date = '2020-11-01' & @end_date = '2020-11-30'- Nov 20 BIBAU-2735
					HD 15/03/2021 Ran successfully for @start_date = '2020-12-01' & @end_date = '2020-12-31'- Dec 20 BIBAU-2735
					HD 16/04/2021 Ran successfully for @start_date = '2021-03-01' & @end_date = '2021-03-31'
					HD 14/05/2021 Ran successfully for @start_date = '2021-04-01' & @end_date = '2021-04-30'
					HD 17/05/2021 Ran successfully for @start_date = '2021-01-01' & @end_date = '2021-01-31' - OPSBI-12
					HD 17/05/2021 Ran successfully for @start_date = '2021-02-01' & @end_date = '2021-02-28' - OPSBI-12
					HD 18/06/2021 Ran successfully for @start_date = '2021-05-01' & @end_date = '2021-05-31'
					HD 19/07/2021 Ran successfully for @start_date = '2021-06-01' & @end_date = '2021-06-30'					
					HD 19/07/2021 Ran successfully for @start_date = '2021-04-01' & @end_date = '2021-04-30' - OPSBI-62
					HD 19/07/2021 Ran successfully for @start_date = '2021-05-01' & @end_date = '2021-05-31' - OPSBI-62
					HD 13/08/2021 Ran successfully for @start_date = '2021-07-01' & @end_date = '2021-07-31'
					HD 25/08/2021 Ran successfully for @start_date = '2021-06-01' & @end_date = '2021-06-30'
					HD 15/09/2021 Ran successfully for @start_date = '2021-08-01' & @end_date = '2021-08-31'
					HD 15/09/2021 Ran successfully for @start_date = '2021-09-01' & @end_date = '2021-09-30'
					HD 12/11/2021 Ran successfully for @start_date = '2021-10-01' & @end_date = '2021-10-31'
					HD 16/12/2021 Ran successfully for @start_date = '2021-11-01' & @end_date = '2021-11-30'
					HD 19/01/2022 Ran successfully for @start_date = '2021-12-01' & @end_date = '2021-12-31'
					HD 16/02/2022 Ran successfully for @start_date = '2022-01-01' & @end_date = '2022-01-31'
					HD 18/03/2022 Ran successfully for @start_date = '2022-02-01' & @end_date = '2022-02-28'
					HD 20/04/2022 Ran successfully for @start_date = '2022-03-01' & @end_date = '2022-03-31'
					HD 20/04/2022 Ran successfully for @start_date = '2021-12-01' & @end_date = '2021-12-31'
					HD 20/04/2022 Ran successfully for @start_date = '2022-01-01' & @end_date = '2022-01-31'
					HD 17/05/2022 Ran successfully for @start_date = '2022-04-01' & @end_date = '2022-04-30'
					HD 18/05/2022 Ran successfully for @start_date = '2021-10-01' & @end_date = '2021-10-31'
					HD 18/05/2022 Ran successfully for @start_date = '2021-11-01' & @end_date = '2021-11-30'
					HD 20/06/2022 Ran successfully for @start_date = '2022-05-01' & @end_date = '2022-05-31'
					HD 15/07/2022 Ran successfully for @start_date = '2022-06-01' & @end_date = '2022-06-30'
					HD 15/07/2022 Ran successfully for @start_date = '2021-09-01' & @end_date = '2021-09-30' OPSBI-118
					HD 17/08/2022 Ran successfully for @start_date = '2022-07-01' & @end_date = '2022-07-31'
					HD 19/08/2022 Ran successfully for @start_date = '2022-07-01' & @end_date = '2022-07-31'
					HD 19/08/2022 Ran successfully for @start_date = '2022-02-01' & @end_date = '2022-02-28'
					HD 20/09/2022 Ran successfully for @start_date = '2022-08-01' & @end_date = '2022-08-31'
					HD 17/10/2022 Ran successfully for @start_date = '2022-09-01' & @end_date = '2022-09-30'
					HD 07/11/2022 Ran successfully for @start_date = '2022-03-01' & @end_date = '2022-03-31' OPSBI-145
					HD 07/11/2022 Ran successfully for @start_date = '2022-04-01' & @end_date = '2022-04-30' OPSBI-145
					HD 09/11/2022 Ran successfully for @start_date = '2022-05-01' & @end_date = '2022-05-31' OPSBI-145
					HD 09/11/2022 Ran successfully for @start_date = '2022-06-01' & @end_date = '2022-06-30' OPSBI-145
					HD 09/11/2022 Ran successfully for @start_date = '2022-07-01' & @end_date = '2022-07-31' OPSBI-145
					HD 09/11/2022 Ran successfully for @start_date = '2022-08-01' & @end_date = '2022-08-31' OPSBI-145
					HD 09/11/2022 Ran successfully for @start_date = '2022-09-01' & @end_date = '2022-09-30' OPSBI-145
					HD 17/11/2022 Ran successfully for @start_date = '2022-10-01' & @end_date = '2022-10-31'
					HD 18/12/2022 Ran successfully for @start_date = '2022-11-01' & @end_date = '2022-11-30'
	
********************************************************************************************************************************/
USE visa_dw
GO

DECLARE @start_date AS DATE
DECLARE @end_date AS DATE

SET @start_date = '2022-11-01'
SET @end_date	= '2022-11-30'

--SELECT * FROM [visa_dw].[dbo].[tblfactLoungeVisits] 
--WHERE billing_month_fk BETWEEN @start_date AND @end_date

--------delete existing data from TABLE [visa_dw].[dbo].[tblfactLoungeVisits]

DELETE FROM [visa_dw].[dbo].[tblfactLoungeVisits] WHERE billing_month_fk BETWEEN  @start_date AND @end_date;--(239433 rows affected)

BEGIN TRAN

INSERT INTO [visa_dw].[dbo].[tblfactLoungeVisits]
(
	billing_month_fk
	,[account_type_id]
	,[associate_prefix]
	,[lounge_code]
	,[issuer]
	,[member_visits]
	,[guest_visits]
	,[member_fee]
	,[guest_fee]
	,[currency_id]
	,[country_of_issue]
	,[visa_region]
)
           
SELECT * FROM
(     ----- *************************  the two comment table are no longer in use in our cube *******************
	----AP
	--SELECT 
	--	billing_month AS billing_month_fk,
	--	1 AS account_type_id,
	--	CAST(associate_prefix AS VARCHAR(25)) AS associate_prefix,
	--	lounge_code,
	--	issuer, 
	--	member_visits,
	--	guest_visits,
	--	member_fee,
	--	guest_fee,
	--	c.currency_id,
	--	country_of_issue,
	--	visa_region
	--FROM 
	--	visa_db.dbo.tblAPLoungeVisits a LEFT JOIN 
	--	lounge_db.dbo.dimTblCurrency c ON c.currency_code = a.currency
	--WHERE
	--	a.Billing_month BETWEEN @start_date AND @end_date		

	--UNION ALL

	----LAC
	--SELECT 
	--	billing_month AS billing_month_fk,
	--	1 AS account_type_id,
	--	CAST(associate_prefix AS VARCHAR(25)) AS associate_prefix,
	--	lounge_code,
	--	deal_name issuer,
	--	member_visits,
	--	guest_visits,
	--	memberfee member_fee,
	--	guestfee guest_fee,
	--	c.currency_id,
	--	country country_of_issue,
	--	CAST('LAC' AS VARCHAR(50)) AS visa_region
	--FROM 
	--	visa_db.dbo.tblLACLoungeVisits a
	--	LEFT JOIN lounge_db.dbo.dimTblCurrency c ON c.currency_code_iso = a.currency
	--WHERE
	--	a.billing_month BETWEEN @start_date AND @end_date

	--UNION ALL

	--CA
	SELECT 
		a.report_month AS billing_month_fk,
		2 AS account_type_id,
		a.clientid AS associate_prefix,
		lounge_code ,
		b.issuer,
		member AS member_visits,
		guests AS guest_visits,
		member_fee ,
		guest_fee ,
		cu.currency_id,
		c.country_name AS country_of_issue,
		b.vs_region_of_issue AS visa_region
	FROM 
		visa_db.dbo.tblCALoungeVisits a
		LEFT JOIN visa_dw.dbo.dimTblDeals b ON b.clientid = a.ClientID
		LEFT JOIN lounge_db.dbo.dimTblCountries c ON c.country_iso_code_3 = b.country_of_issue_iso
		LEFT JOIN lounge_db.dbo.dimTblCurrency cu ON cu.currency_code_iso = 'USD'
	WHERE
		a.report_month BETWEEN @start_date AND @end_date

	UNION ALL

	--LK
	SELECT 
		ReportMonth AS billing_month_fk,
		3 AS account_type_id,
		a.ClientID associate_prefix,
		LoungeCode ,
		b.issuer,
		TotalMemberVisit member_visits,
		TotalGuestVisit guest_visits,
		CASE WHEN ClientPayMemberVisit > 0 THEN ClientPayMemberVisitFre ELSE CMPayMemberVisitFee END member_fee,
		CASE WHEN ClientPayGuestVisitFee > 0 THEN ClientPayGuestVisitFee ELSE CMPayGuestVisitFee END guest_fee,
		cu.currency_id,
		c.country_name country_of_issue,
		b.vs_region_of_issue visa_region
		
	FROM 
		visa_db.dbo.tblLKLoungeVisits a
		LEFT JOIN visa_dw.dbo.dimTblDeals  b ON b.clientid = a.ClientID
		LEFT JOIN lounge_db.dbo.dimTblCountries c ON c.country_iso_code_3 = b.country_of_issue_iso
		LEFT JOIN lounge_db.dbo.dimTblCurrency cu ON cu.currency_code = CASE WHEN ClientPayMemberVisit > 0 THEN ClientPayMemberVisitCurrency ELSE CMPayMemberVisitCurrency END
	WHERE 
		a.ReportMonth BETWEEN @start_date AND @end_date

	UNION ALL

	--Global
	SELECT 
		report_month AS billing_month_fk,
		1 AS account_type_id,
		a.clientid AS associate_prefix,
		a.lounge_code ,
		b.issuer,
		a.member AS member_visits,
		a.guests AS guest_visits,
		a.member_fee ,
		a.guest_fee ,
		cu.currency_id,
		c.country_name AS country_of_issue,
		b.vs_region_of_issue AS visa_region
	FROM 
		visa_db.dbo.tblLoungeVisits a
		LEFT JOIN visa_dw.dbo.dimTblDeals b ON b.clientid = a.ClientID
		LEFT JOIN lounge_db.dbo.dimTblCountries c ON c.country_iso_code_3 = b.country_of_issue_iso
		LEFT JOIN lounge_db.dbo.dimTblCurrency cu ON cu.currency_code_iso = 
			(
				CASE 
					WHEN b.vs_region_of_issue = 'CEMEA' THEN 'USD' 
					ELSE 'EUR' 
				END
			)
	
	WHERE 
		a.report_month BETWEEN @start_date AND @end_date
	 
	UNION ALL
	
	SELECT 
		a.BillingMonth,
		6 AS account_type_id,
		a.SourceCode AS associate_prefix,
		a.LoungeCode AS lounge_code,
		b.issuer,
		a.ClientPaysMemberVisit + a.CardholderPaysMemberVisit AS member_visits,
		a.ClinetPaysGuestVisit + a.CardholderPaysGuestVisit + a.ComplimentaryGuestVisit + a.LoungeVisitOffer AS guest_vist,
		CASE WHEN a.ClientVisitAmountMember > 0 THEN a.ClientVisitAmountMember	ELSE a.CardholderVisitAmountMember END AS member_fee,
		CASE WHEN a.ClientVisitAmountGuest > 0 THEN a.ClientVisitAmountGuest ELSE a.CardholderVisitAmountGuest END AS guest_fee,
		cu.currency_id,
		c.country_name AS country_of_issue,
		b.vs_region_of_issue AS visa_region
	FROM 
		visa_db.dbo.tblWLLoungeVisits a
		LEFT JOIN visa_dw.dbo.dimTblDeals b ON b.clientid = CAST(a.SourceCode AS VARCHAR(25))
		LEFT JOIN lounge_db.dbo.dimTblCountries c ON c.country_iso_code_3 = b.country_of_issue_iso
		LEFT JOIN lounge_db.dbo.dimTblCurrency cu ON cu.currency_code = 
					CASE 
						WHEN a.ClientPaysMemberVisit > 0 THEN a.ClientVisitCurrencyMember
						WHEN a.ClinetPaysGuestVisit > 0 THEN a.ClientVisitCurrencyGuest
						WHEN a.CardholderPaysMemberVisit > 0 THEN a.CardholderVisitCurrencyMember
						WHEN a.CardholderPaysGuestVisit > 0 THEN a.CardholderVisitCurrencyGuest
						ELSE 'US'
					END
	WHERE 
		a.BillingMonth between @start_date and @end_date
) xx;


--DISABLE TRIGGER [dbo].[trg_AutoAudit_tblfactLoungeVisits] ON dbo.tblfactLoungeVisits; 

	UPDATE visa_dw.dbo.tblfactLoungeVisits SET lounge_code = 'SFO10' WHERE lounge_code = 'SFO1'
	UPDATE visa_dw.dbo.tblfactLoungeVisits SET country_of_issue = 'Korea, Republic of' WHERE country_of_issue = 'Korea'
	UPDATE visa_dw.dbo.tblfactLoungeVisits SET country_of_issue = 'Venezuela, Bolivarian Republic of' WHERE country_of_issue = 'Venezuela'
	UPDATE visa_dw.dbo.tblfactLoungeVisits SET country_of_issue = 'Taiwan, Province of China' WHERE country_of_issue = 'Taiwan'
	UPDATE visa_dw.dbo.tblfactLoungeVisits SET country_of_issue = 'Viet Nam' WHERE country_of_issue = 'Vietnam'
	UPDATE visa_dw.dbo.tblfactLoungeVisits SET country_of_issue = 'Bolivia, Plurinational State of' WHERE country_of_issue = 'Bolivia'
	UPDATE visa_dw.dbo.tblfactLoungeVisits SET country_of_issue = 'Trinidad and Tobago' WHERE country_of_issue = 'Trinidad & Tobago'
	UPDATE visa_dw.dbo.tblfactLoungeVisits SET country_of_issue = 'Brunei Darussalam' WHERE country_of_issue = 'Brunei';

--ENABLE TRIGGER [dbo].[trg_AutoAudit_tblfactLoungeVisits] ON dbo.tblfactLoungeVisits; 


--SELECT COUNT(*) FROM [visa_dw].[dbo].[tblfactLoungeVisits] WHERE billing_month_fk ='2016-03-01'
--SELECT COUNT(*) FROM [visa_dw].[dbo].[tblfactLoungeVisits] WHERE billing_month_fk ='2016-04-01'

commit
--ROLLBACK