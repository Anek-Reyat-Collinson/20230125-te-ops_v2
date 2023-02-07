/*****************************************
** Project ID	 : DW - MC - Step 6a
** Author		 : Greg McPhillips
** Last Mofified : 2016-03-23
** Amend History : GM 23/03/2016 Changes to ensure there is no data in target for this month in target importing this months data

** Run history   :	GM 17/03/2016 Ran successfully for month = 2016-02-01
					GM 16/05/2016 Ran successfully for month = 2016-04-01
					GM 16/06/2016 Ran successfully for May data						
	
******************************************/

DECLARE @report_month AS DATE
DECLARE @cif_index AS BIGINT
DECLARE @NumRecs INT

-- Set report month
SET @report_month = '2014-09-01'



--------------------------------------------------------------------------------
--	MasterCard Data Warehouse
--	Build LV Fact Table
-- SELECT top 1 * FROM mastercard_dw.dbo.factTblLoungeVisits
--------------------------------------------------------------------------------
SET @NumRecs = (SELECT COUNT(*) FROM mastercard_dw.dbo.factTblLoungeVisits WHERE billing_month_fk = @report_month) 

IF @NumRecs > 0
	BEGIN
		--PRINT 'Data already exists in mastercard_dw.dbo.factTblLoungeVisits for this month'
		DELETE FROM mastercard_dw.dbo.factTblLoungeVisits WHERE billing_month_fk = @report_month

	END

	BEGIN
		-- Build LV Fact Table - InDirect Assocaite
		INSERT INTO mastercard_dw.dbo.factTblLoungeVisits
		SELECT	
			CAST(lv.BillingMonth AS DATE) AS billing_month_fk,
			CASE 
				WHEN lv.Associate_Prefix = '7000247799' THEN '7500542182'
				WHEN lv.Associate_Prefix = '7000249505' THEN '7500549505'
				WHEN lv.Associate_Prefix = '7000719268' THEN '7500549268'
				WHEN lv.Associate_Prefix = '7000242182' THEN '7500542182'
				WHEN lv.Associate_Prefix = '7000243321' THEN '7500543321'
				WHEN lv.Associate_Prefix = '7000249143' THEN '7500543728'
				WHEN lv.Associate_Prefix = '7000812906' THEN '7500542906'
				WHEN lv.associate_prefix = '7000991990' THEN '7000994399'
				ELSE lv.Associate_Prefix END AS associate_prefix_fk,
			lv.LoungeCode AS lounge_code_fk,	
			SUM(lv.MembersCount) AS member_count,
			SUM(lv.GuestsCount) AS guest_count,
			SUM(lv.TotalVisitCount) AS total_visits_mg,
			c.currency_id AS currency_code_fk,
			SUM(lv.FeePerMember) AS member_fee,
			SUM(lv.FeePerGuest*lv.GuestsCount) AS guest_fee,
			SUM(lv.TotalFee) AS total_fee_mg,
			SUM(lv.TotalFreeGuests) AS free_guests,
			SUM(lv.FreeGuestsValue) AS free_guest_value,
			SUM(lv.TotalChargableGuests) AS chargable_guests,	
			SUM(lv.ChargableGuestsValue) AS chargable_guests_value,
			CASE WHEN deals.ppbo_country_of_issue_iso = ld.lounge_country_iso_3 THEN 1 ELSE 2 END AS domestic_international_fk,
			1 AS account_type_fk -- 1 for InDirect Associates
		FROM mastercard_db.dbo.tblLoungeVisits lv
			LEFT JOIN lounge_db.dbo.dimTblCurrency c ON RTRIM(LTRIM(lv.Currency)) = c.currency_letter
			LEFT JOIN lounge_db.dbo.dimTblLoungeData ld ON ld.lounge_code = lv.LoungeCode	
			LEFT JOIN mastercard_dw.dbo.dimTblMCIDeals deals ON lv.Associate_Prefix = deals.clientid
		WHERE lv.BillingMonth = @report_month
		GROUP BY
			lv.BillingMonth,
			lv.Associate_Prefix,
			lv.LoungeCode,	
			c.currency_id,
			ld.lounge_country_iso_3,
			deals.ppbo_country_of_issue_iso
		

		-------	Build LV Fact Table - Wholesale Lite -----------------------------------
		INSERT INTO mastercard_dw.dbo.factTblLoungeVisits
		SELECT
			t.report_month_pk AS billing_month_fk,
			lv.source_code AS associate_prefix_fk,
			lv.lounge_code AS lounge_code_fk,	
			SUM(lv.total_member_visits) AS member_count,
			SUM(lv.total_guest_visits) AS guest_count,
			SUM(lv.total_member_visits + lv.total_guest_visits) AS total_visits_mg,
			c.currency_id AS currency_code_fk,
			SUM(lv.mc_pays_member_visit_fee + lv.cm_pays_member_visit_fee) AS member_fee,
			SUM(lv.mc_pays_guest_visit_fee + lv.cm_pays_guest_visit_fee) AS guest_fee,
			SUM(lv.mc_pays_member_visit_fee + lv.cm_pays_member_visit_fee +
				lv.mc_pays_guest_visit_fee + lv.cm_pays_guest_visit_fee) AS total_fee_mg,
			SUM(lv.complimentary_guest_visits + lv.lounge_offer_guest_visits) AS free_guests,
			SUM(lv.complimentary_guest_visit_fee * lv.complimentary_guest_visits) AS free_guest_value,
			SUM(lv.mc_pays_guest_visits + cm_pays_guest_visits) AS chargable_guests,	
			SUM(lv.mc_pays_guest_visit_fee + lv.cm_pays_guest_visit_fee) as chargable_guests_value,
			CASE WHEN deals.ppbo_country_of_issue_iso = ld.lounge_country_iso_3 THEN 1 ELSE 2 END AS domestic_international_fk,
			2 AS account_type_fk -- 2 for Wholesale Lite
		FROM mastercard_db.dbo.tblWLLoungeVisits_VA lv
			LEFT JOIN mastercard_dw.dbo.dimTblCurrency c ON lv.mc_pays_member_visit_currency = c.currency_code
			LEFT JOIN lounge_db.dbo.dimTblLoungeData ld ON ld.lounge_code = lv.lounge_code
			LEFT JOIN lounge_db.dbo.dimTblTime t ON t.report_month_pk = CONVERT(VARCHAR(10), lv.report_month, 121)
			LEFT JOIN mastercard_dw.dbo.dimTblMCIDeals deals ON lv.source_code = deals.clientid
		WHERE t.report_month_pk = @report_month
		GROUP BY
			t.report_month_pk,
			lv.source_code,
			lv.lounge_code,	
			lv.mc_pays_member_visit_currency,
			c.currency_id,
			ld.lounge_country_iso_3,
			deals.ppbo_country_of_issue_iso
			

		-- Build LV Fact Table - Old World Signia
		INSERT INTO mastercard_dw.dbo.factTblLoungeVisits
		SELECT
			cast(lv.BillingMonth as date) as billing_month_fk,
			lv.Associate_Prefix as associate_prefix_fk,
			lv.LoungeCode as lounge_code_fk,	
			sum(lv.MembersCount) as member_count,
			sum(lv.GuestsCount) as guest_count,
			sum(lv.TotalVisitCount) as total_visits_mg,
			c.currency_id as currency_code_fk,
			sum(lv.FeePerMember) as member_fee,
			sum(lv.FeePerGuest*lv.guestscount) as guest_fee,
			sum(lv.TotalFee)as total_fee_mg,
			sum(lv.TotalFreeGuests) as free_guests,
			sum(lv.FreeGuestsValue) as free_guest_value,
			sum(lv.TotalChargableGuests) as chargable_guests,	
			sum(lv.ChargableGuestsValue) as chargable_guests_value,
			case when deals.ppbo_country_of_issue_iso = ld.lounge_country_iso_3 then 1 else 2 end as domestic_international_fk,
			3 as account_type_fk -- 3 for WorldSignia
		FROM mastercard_db.dbo.tblWSLoungeVisits lv
			LEFT JOIN lounge_db.dbo.dimTblCurrency c on rtrim(ltrim(lv.Currency)) = c.currency_letter
			LEFT JOIN lounge_db.dbo.dimTblLoungeData ld on ld.lounge_code = lv.LoungeCode	
			LEFT JOIN mastercard_dw.dbo.dimTblMCIDeals deals on lv.Associate_Prefix = deals.clientid
		WHERE lv.BillingMonth = @report_month
		GROUP BY
			lv.BillingMonth,
			lv.Associate_Prefix,
			lv.LoungeCode,	
			c.currency_id,
			ld.lounge_country_iso_3,
			deals.ppbo_country_of_issue_iso	
			

		-- Build LV Fact Table - Direct Associate
		INSERT INTO mastercard_dw.dbo.factTblLoungeVisits
		SELECT
			CAST(lv.BillingMonth AS DATE) AS billing_month_fk,
			AssociatePrefix as associate_prefix_fk,
			lv.LoungeCode as lounge_code_fk,	
			SUM(lv.MemberCount) as member_count,
			SUM(lv.GuestCount) as guest_count,
			SUM(lv.TotalVisitCount) as total_visits_mg,
			c.currency_id as currency_code_fk,
			SUM(lv.TotalMemberFee) as member_fee,
			SUM(lv.TotalGuestFee*lv.GuestCount) as guest_fee,
			SUM(lv.TotalMemberFee + (lv.TotalGuestFee*lv.GuestCount)) as total_fee_mg,
			SUM(lv.TotalFreeGuest) as free_guests,
			SUM(lv.FreeGuestValue) as free_guest_value,
			SUM(lv.TotalChargeableGuest) as chargable_guests,	
			SUM(lv.ChargeableGuestValue) as chargable_guests_value,
			case when deals.ppbo_country_of_issue_iso = ld.lounge_country_iso_3 then 1 else 2 end as domestic_international_fk,
			4 as account_type_fk -- 4 for Direct Associates
		FROM mastercard_db.dbo.tblDALoungeVisits lv
			LEFT JOIN lounge_db.dbo.dimTblCurrency c on rtrim(ltrim(lv.Currency)) = c.currency_letter
			LEFT JOIN lounge_db.dbo.dimTblLoungeData ld on ld.lounge_code = lv.LoungeCode	
			LEFT JOIN mastercard_dw.dbo.dimTblMCIDeals deals on lv.AssociatePrefix = deals.clientid
		WHERE lv.BillingMonth = @report_month
		GROUP BY
			lv.BillingMonth,
			lv.AssociatePrefix,
			lv.LoungeCode,	
			c.currency_id,
			ld.lounge_country_iso_3,
			deals.ppbo_country_of_issue_iso		
			

		-- Build LV Fact Table - Lounge Key
		INSERT INTO mastercard_dw.dbo.factTblLoungeVisits
		SELECT
			t.report_month_pk AS billing_month_fk,
			lv.client_id AS associate_prefix_fk,
			lv.lounge_code AS lounge_code_fk,	
			SUM(lv.total_member_visits) AS member_count,
			SUM(lv.total_guest_visits) AS guest_count,	
			SUM(lv.total_member_visits + lv.total_guest_visits) AS total_visits_mg,
			c.currency_id AS currency_code_fk,
			SUM(lv.mc_pays_member_visit_fee + lv.cm_pays_member_visit_fee) AS member_fee,
			SUM(lv.mc_pays_guest_visit_fee + lv.cm_pays_guest_visit_fee) AS guest_fee,
			SUM(lv.mc_pays_member_visit_fee + lv.cm_pays_member_visit_fee + lv.mc_pays_guest_visit_fee + lv.cm_pays_guest_visit_fee) AS total_fee_mg,
			SUM(lv.complimentary_guest_visits + lounge_offer_guest_visits) AS free_guests,
			SUM(lv.complimentary_guest_visit_fee) AS free_guest_value,
			SUM(lv.mc_pays_guest_visits + cm_pays_guest_visits) AS chargable_guests,
			SUM(lv.mc_pays_guest_visit_fee + lv.cm_pays_guest_visit_fee) AS chargable_guests_value,
			CASE WHEN dl.ppbo_country_of_issue_iso = ld.lounge_country_iso_3 THEN 1 ELSE 2 END AS domestic_international_fk,
			dl.account_type_fk AS account_type_fk
		FROM mastercard_db.dbo.tblLKLoungeVisits lv
			LEFT JOIN mastercard_dw.dbo.dimTblCurrency c ON lv.mc_pays_member_visit_currency = c.currency_code
			LEFT JOIN lounge_db.dbo.dimTblLoungeData ld ON ld.lounge_code = lv.lounge_code
			LEFT JOIN lounge_db.dbo.dimTblTime t ON t.report_month_pk = CONVERT(VARCHAR(10), lv.report_month, 121)
			LEFT JOIN mastercard_dw.dbo.dimTblMCIDeals dl ON lv.client_id = dl.clientid
		WHERE t.report_month_pk = @report_month
		GROUP BY
			t.report_month_pk,
			lv.client_id,
			lv.lounge_code,	
			lv.mc_pays_member_visit_currency,
			c.currency_id,
			ld.lounge_country_iso_3,
			dl.ppbo_country_of_issue_iso,
			dl.account_type_fk
	END		



--------------------------------------------------------------------------------
-- MasterCard Data Warehouse 
-- Build LV Frequencey Fact Table
-- SELECT top 1 * FROM mastercard_dw.dbo.factTblLVFrequency
--------------------------------------------------------------------------------
SET @NumRecs = (SELECT COUNT(*) FROM mastercard_dw.dbo.factTblLVFrequency WHERE billing_month_fk = @report_month) 

IF @NumRecs > 0
	BEGIN
		--PRINT 'Data already exists in mastercard_dw.dbo.factTblLVFrequency for this month'
		DELETE FROM mastercard_dw.dbo.factTblLVFrequency WHERE billing_month_fk = @report_month
	END
	
	
	BEGIN
		INSERT INTO mastercard_dw.dbo.factTblLVFrequency
		SELECT
			billing_month_fk,
			associate_prefix_fk,
			prioritypass_id,
			lounge_code_fk,
			member_visits,
			guest_visits,
			total_member_guest_visits,
			account_type_fk
		FROM
		(
			----- MasterCard InDirect Associate LV Frequency -----
			SELECT
				CAST(BillingMonth AS DATE) AS billing_month_fk,			
				CASE
					WHEN associate_prefix = '7000247799' THEN '7500542182'
					WHEN associate_prefix = '7000249505' THEN '7500549505'
					WHEN associate_prefix = '7000719268' THEN '7500549268'
					WHEN associate_prefix = '7000242182' THEN '7500542182'
					WHEN associate_prefix = '7000243321' THEN '7500543321'
					WHEN associate_prefix = '7000249143' THEN '7500543728'
					WHEN associate_prefix = '7000812906' THEN '7500542906'
					WHEN associate_prefix = '7000991990' THEN '7000994399'
					ELSE associate_prefix END AS associate_prefix_fk,
				[Priority Pass Id] AS prioritypass_id,
				LoungeCode AS lounge_code_fk,
				SUM(MembersCount) AS member_visits,
				SUM(GuestsCount) AS guest_visits,
				SUM(TotalVisitCount) AS total_member_guest_visits,
				1 AS account_type_fk
			FROM mastercard_db.dbo.tblLoungeVisits		
			GROUP BY BillingMonth,associate_prefix,[Priority Pass Id],LoungeCode
				
		UNION
			
			----- MasterCard Wholesale Lite LV Frequency -----
			SELECT
				CAST(BillingMonth AS DATE) AS billing_month_fk,
				SourceCode AS associate_prefix_fk,
				[Member No] AS prioritypass_id,
				LoungeCode AS lounge_code_fk,
				COUNT(*) AS member_visits,
				SUM([Total Guests]) AS guest_visits,
				COUNT(*) + SUM([Total Guests]) AS total_member_guest_visits,
				2 AS account_type_fk
				
			FROM mastercard_db.dbo.tblWLLoungeVisits
			GROUP BY BillingMonth,SourceCOde,[Member No],LoungeCode
				
		UNION
			
			----- MasterCard Old World Signia LV Frequency -----
			SELECT
				CAST(BillingMonth AS DATE) AS billing_month_fk,
				associate_prefix AS associate_prefix_fk,
				[Priority Pass Id] AS prioritypass_id,
				LoungeCode AS lounge_code_fk,
				SUM(MembersCount) AS member_visits,
				SUM(GuestsCount) AS guest_visits,
				SUM(TotalVisitCount) AS total_member_guest_visits,
				3 AS account_type_fk
			FROM mastercard_db.dbo.tblWSLoungeVisits
			GROUP BY BillingMonth,associate_prefix,[Priority Pass Id],LoungeCode
				
		UNION
			
			----- MasterCard Direct Associate LV Frequency -----
			SELECT
				CAST(BillingMonth AS DATE) AS billing_month_fk,
				AssociatePrefix AS associate_prefix_fk,
				PriorityPassID AS prioritypass_id,
				LoungeCode AS lounge_code_fk,
				SUM(MemberCount) AS member_visits,
				SUM(GuestCount) AS guest_visits,
				SUM(TotalVisitCount) AS total_member_guest_visits,
				4 AS account_type_fk
			FROM mastercard_db.dbo.tblDALoungeVisits
			GROUP BY BillingMonth,AssociatePrefix,PriorityPassId,LoungeCode

		UNION

			----- MasterCard LoungeKey LV Frequency -----
			SELECT
				CAST(lv.report_month AS DATE) AS billing_month_fk,
				lv.client_id AS associate_prefix_fk,
				lv.consumer_no AS prioritypass_id,
				lv.lounge_code AS lounge_code_fk,
				SUM(lv.total_member_visits) AS member_visits,
				SUM(lv.total_guest_visits) AS guest_visits,
				SUM(lv.total_member_visits + lv.total_guest_visits) AS total_member_guest_visits,
				dl.account_type_fk AS account_type_fk
			FROM mastercard_db.dbo.tblLKLoungeVisits lv
				LEFT JOIN mastercard_dw.dbo.dimTblMCIDeals dl ON lv.client_id = dl.clientid
			GROUP BY lv.report_month,lv.client_id,lv.consumer_no,lv.lounge_code,dl.account_type_fk

		) AS lvs

		WHERE lvs.billing_month_fk = @report_month
		ORDER BY
			billing_month_fk,
			associate_prefix_fk,
			prioritypass_id,
			lounge_code_fk,
			member_visits,
			guest_visits,		
			account_type_fk
	END
--------------------------------------------------------------------------------
-------	MasterCard Data Warehouse ----------------------------------------------
-------	Build Unique LV Fact Table ---------------------------------------------
--------------------------------------------------------------------------------

TRUNCATE TABLE mastercard_dw.dbo.factTblUniqueMembers

INSERT INTO mastercard_dw.dbo.factTblUniqueMembers

SELECT x.billing_month_fk, x.prioritypass_id_pk,1 AS member_count, account_type_fk FROM
(
	SELECT		
		prioritypass_id AS prioritypass_id_pk,
		MIN(billing_month_fk) AS billing_month_fk,	
		MIN(account_type_fk) AS account_type_fk
	
	FROM mastercard_dw.dbo.factTblLVFrequency
	
	GROUP BY prioritypass_id
) AS x

ORDER BY x.billing_month_fk,x.prioritypass_id_pk,account_type_fk
	