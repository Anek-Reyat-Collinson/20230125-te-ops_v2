/*****************************************
** Project ID	 : DW - MC - Step 6a
** Author		 : Greg McPhillips

** Last Mofified : 2016-03-23
** Amend History : GM 23/03/2016 Changes to ensure there is no data in target for this month in target importing this months data
** Amend History : AE 13/09/2016 Added date range parameter
** Amend History : AE and LA 24/04/2017 changes made to accomodate MCAE project
					Update new columns to all lounge visit tables before inserting records into the fact lounge visits (factTblLoungeVisits) table
					(create default values to all tables apart from lounge key which hold airport experience records). 

** Run history   :	GM 17/03/2016 Ran successfully for month = 2016-02-01
					GM 16/05/2016 Ran successfully for month = 2016-04-01
					GM 16/06/2016 Ran successfully for May data	= 2016-05-01
					AE 14/07/2016 Ran successfully for June data = 2016-06-01						
					GM 04/08/2016 Ran successfully for month = 2015-04-01						
					GM 04/08/2016 Ran successfully for month = 2015-05-01
					GM 04/08/2016 Ran successfully for month = 2015-06-01
					GM 04/08/2016 Ran successfully for month = 2015-07-01
					GM 04/08/2016 Ran successfully for month = 2015-08-01
					GM 04/08/2016 Ran successfully for month = 2015-09-01
					GM 04/08/2016 Ran successfully for month = 2015-10-01
					GM 04/08/2016 Ran successfully for month = 2015-11-01
					GM 04/08/2016 Ran successfully for month = 2015-12-01
					GM 04/08/2016 Ran successfully for month = 2016-01-01
					GM 04/08/2016 Ran successfully for month = 2016-02-01
					AE 12/08/2016 Ran successfully for June data = 2016-07-01  re-run cif fact table due to missing cif by kevin 15-08-2016
					AE 20/10/2016 Ran successfully for Sep data =   re-run cif fact table due due to updates. ran for 2014-05-01 to 2016-09-01 and also fact lv for 2016-05-01
					GM 14/11/2016 Ran successfully for Oct data
					AE 15/12/2016 Ran successfully for Nov data  = re-run cif fact table from july 2016 to nov 2016 as requested by kl
					AE 16/01/2017 Ran successfully for Dec data
					AE 17/02/2017 Ran successfully for Jan data
					VP 17/03/2017 Ran successfully for Feb data
					AE 20/03/2017 Ran successfully for Feb data -- re -run only wholesale lite data for fact frequency
					AE 13/04/2017 Ran successfully for Mar data
					VP 12/05/2017 Ran successfully for Apr data
					AE 13/06/2017 Ran successfully for mAY data
					AE 14/07/2017 Ran successfully for jUNE data
					AE 14/07/2017 Ran successfully for jUly data
					VP 14/09/2017 Ran successfully for Aug data
					AA 13/10/2017 Ran successfully for Sep data
					AA 14/11/2017 Ran successfully for Oct data
					AA 13/12/2017 Ran successfully for Nov data
					AA 11/01/2018 Ran successfully for Dec data
					AA 12/02/2018 Ran successfully for Jan data
					AA 13/03/2018 Ran successfully for Feb data
					AA 13/04/2018 Ran successfully for mar data
					SS 25/03/2018 Ran successfully for Feb data (Re-Run BIBAU-2345)
					
**********************************************************************************************************************************************/
USE mastercard_dw
GO



DECLARE @cif_index AS BIGINT
DECLARE @NumRecs INT

----- Set report month
DECLARE @StartDate AS DATE =  '2014-01-01'--keep this date as constant
DECLARE @EndDate   AS DATE =  '2018-03-01'--update current report month for every run

SET @cif_index = (SELECT MAX(cif_index) FROM mastercard_dw.dbo.factTblCIF)

SELECT COUNT(*) FROM mastercard_dw.dbo.factTblCIF WHERE report_month BETWEEN  @StartDate AND @EndDate

------------------------------------------------------------------------------
-----	MasterCard Data Warehouse ----------------------------------------------
-----	Build CIF Fact Table ---------------------------------------------------
------------------------------------------------------------------------------
SET @NumRecs = (SELECT COUNT(*) FROM mastercard_dw.dbo.factTblCIF WHERE report_month BETWEEN  @StartDate AND @EndDate) 

IF @NumRecs > 0
	BEGIN;
		DISABLE TRIGGER [dbo].[trg_AutoAudit_factTblCIF] ON [dbo].factTblCIF; 
			DELETE FROM mastercard_dw.dbo.factTblCIF WHERE report_month BETWEEN  @StartDate AND @EndDate;
		ENABLE TRIGGER [dbo].[trg_AutoAudit_factTblCIF] ON [dbo].factTblCIF; 

	END

	BEGIN	
		INSERT INTO mastercard_dw.dbo.factTblCIF
		(cif_index
		,report_month
		,associate_prefix
		,total
		,account_type_fk
		)
		SELECT
			ROW_NUMBER() OVER (ORDER BY x.report_month,x.associate_prefix) + @cif_index AS cif_index,
			x.report_month,
			x.associate_prefix,	
			x.total,
			x.account_type_fk
			
		FROM
		(
			----- MasterCard InDirect Associate CIF -----
			SELECT
				report_month,
				CASE 
					WHEN associate_prefix = '7000247799' THEN '7500542182'
					WHEN associate_prefix = '7000249505' THEN '7500549505'
					WHEN associate_prefix = '7000719268' THEN '7500549268'
					WHEN associate_prefix = '7000242182' THEN '7500542182'
					WHEN associate_prefix = '7000243321' THEN '7500543321'
					WHEN associate_prefix = '7000249143' THEN '7500543728'
					WHEN associate_prefix = '7000812906' THEN '7500542906'
				ELSE associate_prefix END AS associate_prefix,
				SUM(total) AS total,
				1 AS account_type_fk
			FROM mastercard_db.dbo.tblCIF
			WHERE report_month BETWEEN  @StartDate AND @EndDate
			GROUP BY report_month,associate_prefix	
			
			UNION	
			
			----- MasterCard Wholesale Lite CIF -----
			SELECT
				report_month,
				associate_prefix,
				SUM(total) AS total,
				2 AS account_type_fk
			FROM mastercard_db.dbo.tblWLCIF
			WHERE report_month BETWEEN  @StartDate AND @EndDate
			GROUP BY report_month,associate_prefix
			
			UNION
			
			----- MasterCard Old World Signia CIF -----
			
			SELECT
				report_month,
				associate_prefix,
				SUM(total) AS total,
				3 AS account_type_fk
			FROM mastercard_db.dbo.tblWSCIF
			WHERE report_month BETWEEN  @StartDate AND @EndDate
			GROUP BY report_month, associate_prefix
			
			UNION
				
			----- MasterCard Direct Associate CIF -----
			
			SELECT		
				report_month,
				associate_prefix,		
				SUM(total) AS total,
				4 AS account_type_fk
			FROM mastercard_db.dbo.tblDACIF
			WHERE report_month BETWEEN  @StartDate AND @EndDate
			GROUP BY report_month,associate_prefix	
			
			UNION
			
			----- MasterCard LoungeKey CIF -----
			
			SELECT
				cf.report_month,
				cf.client_id AS associate_prefix,
				SUM(cf.total) AS total,
				dl.account_type_fk AS account_type_fk
			FROM mastercard_db.dbo.tblLKCIF cf
			LEFT JOIN mastercard_dw.dbo.dimTblMCIDeals dl ON cf.client_id = dl.clientid
			WHERE cf.report_month BETWEEN  @StartDate AND @EndDate
			GROUP BY cf.report_month,cf.client_id,dl.account_type_fk
						
		) AS x
	END;



	----BELOW  SCRIPTS HAS BEEN MOVED.. DO NOT RUN BELOW SCRIPT
--------------------------------------------------------------------------------
-------	MasterCard Data Warehouse
-------	Build LV Fact Table
-------	SELECT top 1 * FROM mastercard_dw.dbo.factTblLoungeVisits
--------------------------------------------------------------------------------
--SET @NumRecs = (SELECT COUNT(*) FROM mastercard_dw.dbo.factTblLoungeVisits WHERE billing_month_fk BETWEEN  @StartDate AND @EndDate) 

--IF @NumRecs > 0
--	BEGIN;
--		DISABLE TRIGGER [dbo].[trg_AutoAudit_factTblLoungeVisits] ON [dbo].factTblLoungeVisits; 
--			DELETE FROM mastercard_dw.dbo.factTblLoungeVisits WHERE billing_month_fk BETWEEN  @StartDate AND @EndDate;
--		ENABLE TRIGGER [dbo].[trg_AutoAudit_factTblLoungeVisits] ON [dbo].factTblLoungeVisits; 
			
--	END

--		BEGIN
--		----- Build LV Fact Table - InDirect Assocaite
--		INSERT INTO mastercard_dw.dbo.factTblLoungeVisits
--			([billing_month_fk]
--			,[associate_prefix_fk]
--			,[lounge_code_fk]
--			,[member_count]
--			,[guest_count]
--			,[total_visits_mg]
--			,[currency_code_fk]
--			,[member_fee]
--			,[guest_fee]
--			,[total_fee_mg]
--			,[free_guests]
--			,[free_guest_value]
--			,[chargeable_guests]
--			,[chargeable_guests_value]
--			,[domestic_international_fk]
--			,[account_type_fk]
--			,[experience_type_fk]
--			,experience_category_fk)
				
--		SELECT	
--			CAST(lv.BillingMonth AS DATE) AS billing_month_fk,
--			CASE 
--				WHEN lv.Associate_Prefix = '7000247799' THEN '7500542182'
--				WHEN lv.Associate_Prefix = '7000249505' THEN '7500549505'
--				WHEN lv.Associate_Prefix = '7000719268' THEN '7500549268'
--				WHEN lv.Associate_Prefix = '7000242182' THEN '7500542182'
--				WHEN lv.Associate_Prefix = '7000243321' THEN '7500543321'
--				WHEN lv.Associate_Prefix = '7000249143' THEN '7500543728'
--				WHEN lv.Associate_Prefix = '7000812906' THEN '7500542906'
--				WHEN lv.associate_prefix = '7000991990' THEN '7000994399'
--				ELSE lv.Associate_Prefix END AS associate_prefix_fk,
--			lv.LoungeCode AS lounge_code_fk,	
--			SUM(lv.MembersCount) AS member_count,
--			SUM(lv.GuestsCount) AS guest_count,
--			SUM(lv.TotalVisitCount) AS total_visits_mg,
--			c.currency_id AS currency_code_fk,
--			SUM(lv.FeePerMember) AS member_fee,
--			SUM(lv.FeePerGuest*lv.GuestsCount) AS guest_fee,
--			SUM(lv.TotalFee) AS total_fee_mg,
--			SUM(lv.TotalFreeGuests) AS free_guests,
--			SUM(lv.FreeGuestsValue) AS free_guest_value,
--			SUM(lv.TotalChargableGuests) AS chargable_guests,	
--			SUM(lv.ChargableGuestsValue) AS chargable_guests_value,
--			CASE WHEN deals.ppbo_country_of_issue_iso = ld.lounge_country_iso_3 THEN 1 ELSE 2 END AS domestic_international_fk,
--			1 AS account_type_fk, -- 1 for InDirect Associates
--			5 AS [experience_type_fk], ---- 5 default for lounge visit
--			4 AS [experience_category_fk] --- 4 default for visit

--		FROM mastercard_db.dbo.tblLoungeVisits lv
--			LEFT JOIN lounge_db.dbo.dimTblCurrency c ON RTRIM(LTRIM(lv.Currency)) = c.currency_letter
--			LEFT JOIN lounge_db.dbo.dimTblLoungeData ld ON ld.lounge_code = lv.LoungeCode	
--			LEFT JOIN mastercard_dw.dbo.dimTblMCIDeals deals ON lv.Associate_Prefix = deals.clientid
--		WHERE lv.BillingMonth BETWEEN  @StartDate AND @EndDate
--		GROUP BY
--			lv.BillingMonth,
--			lv.Associate_Prefix,
--			lv.LoungeCode,	
--			c.currency_id,
--			ld.lounge_country_iso_3,
--			deals.ppbo_country_of_issue_iso;
		
		
		
--			---	Build LV Fact Table - Wholesale Lite -----------------------------------
--		INSERT INTO mastercard_dw.dbo.factTblLoungeVisits
--			([billing_month_fk]
--			,[associate_prefix_fk]
--			,[lounge_code_fk]
--			,[member_count]
--			,[guest_count]
--			,[total_visits_mg]
--			,[currency_code_fk]
--			,[member_fee]
--			,[guest_fee]
--			,[total_fee_mg]
--			,[free_guests]
--			,[free_guest_value]
--			,[chargeable_guests]
--			,[chargeable_guests_value]
--			,[domestic_international_fk]
--			,[account_type_fk]
--			,[experience_type_fk]
--			,experience_category_fk)	
					
--		SELECT
--			t.report_month_pk AS billing_month_fk,
--			lv.source_code AS associate_prefix_fk,
--			lv.lounge_code AS lounge_code_fk,	
--			SUM(lv.total_member_visits) AS member_count,
--			SUM(lv.total_guest_visits) AS guest_count,
--			SUM(lv.total_member_visits + lv.total_guest_visits) AS total_visits_mg,
--			c.currency_id AS currency_code_fk,
--			SUM(lv.mc_pays_member_visit_fee + lv.cm_pays_member_visit_fee) AS member_fee,
--			SUM(lv.mc_pays_guest_visit_fee + lv.cm_pays_guest_visit_fee) AS guest_fee,
--			SUM(lv.mc_pays_member_visit_fee + lv.cm_pays_member_visit_fee +
--				lv.mc_pays_guest_visit_fee + lv.cm_pays_guest_visit_fee) AS total_fee_mg,
--			SUM(lv.complimentary_guest_visits + lv.lounge_offer_guest_visits) AS free_guests,
--			SUM(lv.complimentary_guest_visit_fee * lv.complimentary_guest_visits) AS free_guest_value,
--			SUM(lv.mc_pays_guest_visits + cm_pays_guest_visits) AS chargable_guests,	
--			SUM(lv.mc_pays_guest_visit_fee + lv.cm_pays_guest_visit_fee) as chargable_guests_value,
--			CASE WHEN deals.ppbo_country_of_issue_iso = ld.lounge_country_iso_3 THEN 1 ELSE 2 END AS domestic_international_fk,
--			2 AS account_type_fk, -- 2 for Wholesale Lite
--			5 AS [experience_type_fk], ---- 5 default for lounge visit
--			4 AS [experience_category_fk] --- 4 default for visit

--		FROM mastercard_db.dbo.tblWLLoungeVisits_VA lv
--			LEFT JOIN mastercard_dw.dbo.dimTblCurrency c ON lv.mc_pays_member_visit_currency = c.currency_code
--			LEFT JOIN lounge_db.dbo.dimTblLoungeData ld ON ld.lounge_code = lv.lounge_code
--			LEFT JOIN lounge_db.dbo.dimTblTime t ON t.report_month_pk = CONVERT(VARCHAR(10), lv.report_month, 121)
--			LEFT JOIN mastercard_dw.dbo.dimTblMCIDeals deals ON lv.source_code = deals.clientid
--		WHERE t.report_month_pk BETWEEN  @StartDate AND @EndDate
--		GROUP BY
--			t.report_month_pk,
--			lv.source_code,
--			lv.lounge_code,	
--			lv.mc_pays_member_visit_currency,
--			c.currency_id,
--			ld.lounge_country_iso_3,
--			deals.ppbo_country_of_issue_iso;


	
--			----- Build LV Fact Table - Old World Signia
--		INSERT INTO mastercard_dw.dbo.factTblLoungeVisits
--			([billing_month_fk]
--			,[associate_prefix_fk]
--			,[lounge_code_fk]
--			,[member_count]
--			,[guest_count]
--			,[total_visits_mg]
--			,[currency_code_fk]
--			,[member_fee]
--			,[guest_fee]
--			,[total_fee_mg]
--			,[free_guests]
--			,[free_guest_value]
--			,[chargeable_guests]
--			,[chargeable_guests_value]
--			,[domestic_international_fk]
--			,[account_type_fk]
--			,[experience_type_fk]
--			,experience_category_fk)
						
--		SELECT
--			cast(lv.BillingMonth as date) as billing_month_fk,
--			lv.Associate_Prefix as associate_prefix_fk,
--			lv.LoungeCode as lounge_code_fk,	
--			sum(lv.MembersCount) as member_count,
--			sum(lv.GuestsCount) as guest_count,
--			sum(lv.TotalVisitCount) as total_visits_mg,
--			c.currency_id as currency_code_fk,
--			sum(lv.FeePerMember) as member_fee,
--			sum(lv.FeePerGuest*lv.guestscount) as guest_fee,
--			sum(lv.TotalFee)as total_fee_mg,
--			sum(lv.TotalFreeGuests) as free_guests,
--			sum(lv.FreeGuestsValue) as free_guest_value,
--			sum(lv.TotalChargableGuests) as chargable_guests,	
--			sum(lv.ChargableGuestsValue) as chargable_guests_value,
--			case when deals.ppbo_country_of_issue_iso = ld.lounge_country_iso_3 then 1 else 2 end as domestic_international_fk,
--			3 as account_type_fk, -- 3 for WorldSignia
--			5 AS [experience_type_fk], ---- 5 default for lounge visit
--			4 AS [experience_category_fk] --- 4 default for visit

--		FROM mastercard_db.dbo.tblWSLoungeVisits lv
--			LEFT JOIN lounge_db.dbo.dimTblCurrency c on rtrim(ltrim(lv.Currency)) = c.currency_letter
--			LEFT JOIN lounge_db.dbo.dimTblLoungeData ld on ld.lounge_code = lv.LoungeCode	
--			LEFT JOIN mastercard_dw.dbo.dimTblMCIDeals deals on lv.Associate_Prefix = deals.clientid
--		WHERE lv.BillingMonth BETWEEN  @StartDate AND @EndDate
--		GROUP BY
--			lv.BillingMonth,
--			lv.Associate_Prefix,
--			lv.LoungeCode,	
--			c.currency_id,
--			ld.lounge_country_iso_3,
--			deals.ppbo_country_of_issue_iso;


	
--		----- Build LV Fact Table - Direct Associate
--		INSERT INTO mastercard_dw.dbo.factTblLoungeVisits
--			([billing_month_fk]
--			,[associate_prefix_fk]
--			,[lounge_code_fk]
--			,[member_count]
--			,[guest_count]
--			,[total_visits_mg]
--			,[currency_code_fk]
--			,[member_fee]
--			,[guest_fee]
--			,[total_fee_mg]
--			,[free_guests]
--			,[free_guest_value]
--			,[chargeable_guests]
--			,[chargeable_guests_value]
--			,[domestic_international_fk]
--			,[account_type_fk]
--			,[experience_type_fk]
--			,experience_category_fk)	
						
--		SELECT
--			CAST(lv.BillingMonth AS DATE) AS billing_month_fk,
--			AssociatePrefix as associate_prefix_fk,
--			lv.LoungeCode as lounge_code_fk,	
--			SUM(lv.MemberCount) as member_count,
--			SUM(lv.GuestCount) as guest_count,
--			SUM(lv.TotalVisitCount) as total_visits_mg,
--			c.currency_id as currency_code_fk,
--			SUM(lv.TotalMemberFee) as member_fee,
--			SUM(lv.TotalGuestFee*lv.GuestCount) as guest_fee,
--			SUM(lv.TotalMemberFee + (lv.TotalGuestFee*lv.GuestCount)) as total_fee_mg,
--			SUM(lv.TotalFreeGuest) as free_guests,
--			SUM(lv.FreeGuestValue) as free_guest_value,
--			SUM(lv.TotalChargeableGuest) as chargable_guests,	
--			SUM(lv.ChargeableGuestValue) as chargable_guests_value,
--			case when deals.ppbo_country_of_issue_iso = ld.lounge_country_iso_3 then 1 else 2 end as domestic_international_fk,
--			4 as account_type_fk, -- 4 for Direct Associates
--			5 AS [experience_type_fk], ---- 5 default for lounge visit
--			4 AS [experience_category_fk] --- 4 default for visit

--		FROM mastercard_db.dbo.tblDALoungeVisits lv
--			LEFT JOIN lounge_db.dbo.dimTblCurrency c on rtrim(ltrim(lv.Currency)) = c.currency_letter
--			LEFT JOIN lounge_db.dbo.dimTblLoungeData ld on ld.lounge_code = lv.LoungeCode	
--			LEFT JOIN mastercard_dw.dbo.dimTblMCIDeals deals on lv.AssociatePrefix = deals.clientid
--		WHERE lv.BillingMonth BETWEEN  @StartDate AND @EndDate
--		GROUP BY
--			lv.BillingMonth,
--			lv.AssociatePrefix,
--			lv.LoungeCode,	
--			c.currency_id,
--			ld.lounge_country_iso_3,
--			deals.ppbo_country_of_issue_iso;		
	
	

--	----- Build LV Fact Table - Lounge Key
--		INSERT INTO mastercard_dw.dbo.factTblLoungeVisits
--			([billing_month_fk]
--			,[associate_prefix_fk]
--			,[lounge_code_fk]
--			,[member_count]
--			,[guest_count]
--			,[total_visits_mg]
--			,[currency_code_fk]
--			,[member_fee]
--			,[guest_fee]
--			,[total_fee_mg]
--			,[free_guests]
--			,[free_guest_value]
--			,[chargeable_guests]
--			,[chargeable_guests_value]
--			,[domestic_international_fk]
--			,[account_type_fk]
--			,[experience_type_fk]
--			,experience_category_fk)	
					
--		SELECT
--			t.report_month_pk			AS billing_month_fk,
--			lv.client_id				AS associate_prefix_fk,
--			lv.lounge_code				AS lounge_code_fk,	
--			SUM(lv.total_member_visits) AS member_count,
--			SUM(lv.total_guest_visits)	AS guest_count,	
--			SUM(lv.total_member_visits + lv.total_guest_visits) AS total_visits_mg,
--			c.currency_id				AS currency_code_fk,
--			SUM(lv.mc_pays_member_visit_fee + lv.cm_pays_member_visit_fee) AS member_fee,
--			SUM(lv.mc_pays_guest_visit_fee + lv.cm_pays_guest_visit_fee) AS guest_fee,
--			SUM(lv.mc_pays_member_visit_fee + lv.cm_pays_member_visit_fee + lv.mc_pays_guest_visit_fee + lv.cm_pays_guest_visit_fee) AS total_fee_mg,
--			SUM(lv.complimentary_guest_visits + lounge_offer_guest_visits) AS free_guests,
--			SUM(lv.complimentary_guest_visit_fee) AS free_guest_value,
--			SUM(lv.mc_pays_guest_visits + cm_pays_guest_visits) AS chargable_guests,
--			SUM(lv.mc_pays_guest_visit_fee + lv.cm_pays_guest_visit_fee) AS chargable_guests_value,
--			CASE WHEN dl.ppbo_country_of_issue_iso = ld.lounge_country_iso_3 THEN 1 ELSE 2 END AS domestic_international_fk,
--			dl.account_type_fk		AS account_type_fk,
--			ty.experience_type_fk	AS experience_type_fk,
--			ca.experience_category_fk AS experience_category_fk
 
--		FROM mastercard_db.dbo.tblLKLoungeVisits lv
--			LEFT JOIN mastercard_dw.dbo.dimTblCurrency c ON lv.mc_pays_member_visit_currency = c.currency_code
--			LEFT JOIN lounge_db.dbo.dimTblLoungeData ld ON ld.lounge_code = lv.lounge_code
--			LEFT JOIN lounge_db.dbo.dimTblTime t ON t.report_month_pk = CONVERT(VARCHAR(10), lv.report_month, 121)
--			LEFT JOIN mastercard_dw.dbo.dimTblMCIDeals dl ON lv.client_id = dl.clientid
--			LEFT JOIN mastercard_dw.[dbo].[dimTblExperienceType] ty ON ty.experience_type = lv.experience_type
--			LEFT JOIN mastercard_dw.[dbo].[dimTblExperienceCategory] ca ON ca.[experience_category] =lv.experience_category


--		WHERE t.report_month_pk BETWEEN  @StartDate AND @EndDate
--		GROUP BY
--			t.report_month_pk,
--			lv.client_id,
--			lv.lounge_code,	
--			lv.mc_pays_member_visit_currency,
--			c.currency_id,
--			ld.lounge_country_iso_3,
--			dl.ppbo_country_of_issue_iso,
--			dl.account_type_fk,
--			ty.experience_type_fk,
--			ca.experience_category_fk
		
--	END;	


------------------------------------------------------------------------------
-- ----- MasterCard Data Warehouse 
-- ----- Build LV Frequencey Fact Table
-- ----- SELECT top 1 * FROM mastercard_dw.dbo.factTblLVFrequency
------------------------------------------------------------------------------
--SET @NumRecs = (SELECT COUNT(*) FROM mastercard_dw.dbo.factTblLVFrequency WHERE billing_month_fk BETWEEN  @StartDate AND @EndDate) 

--IF @NumRecs > 0
--	BEGIN;
--		DISABLE TRIGGER [dbo].[trg_AutoAudit_factTblLVFrequency] ON [dbo].factTblLVFrequency; 
--			DELETE FROM mastercard_dw.dbo.factTblLVFrequency WHERE billing_month_fk BETWEEN  @StartDate AND @EndDate;
--		DISABLE TRIGGER [dbo].[trg_AutoAudit_factTblLVFrequency] ON [dbo].factTblLVFrequency; 
--	END

--	BEGIN
--		INSERT INTO mastercard_dw.dbo.factTblLVFrequency
--			([billing_month_fk]
--			,[associate_code_fk]
--			,[prioritypass_id]
--			,[lounge_code_fk]
--			,[member_visits]
--			,[guest_visits]
--			,[total_member_guest_visits]
--			,account_type_fk)
--		SELECT
--			billing_month_fk,
--			associate_prefix_fk,
--			prioritypass_id,
--			lounge_code_fk,
--			member_visits,
--			guest_visits,
--			total_member_guest_visits,
--			account_type_fk
--		FROM
--		(
--			--- MasterCard InDirect Associate LV Frequency -----
--			SELECT
--				CAST(BillingMonth AS DATE) AS billing_month_fk,			
--				CASE
--					WHEN associate_prefix = '7000247799' THEN '7500542182'
--					WHEN associate_prefix = '7000249505' THEN '7500549505'
--					WHEN associate_prefix = '7000719268' THEN '7500549268'
--					WHEN associate_prefix = '7000242182' THEN '7500542182'
--					WHEN associate_prefix = '7000243321' THEN '7500543321'
--					WHEN associate_prefix = '7000249143' THEN '7500543728'
--					WHEN associate_prefix = '7000812906' THEN '7500542906'
--					WHEN associate_prefix = '7000991990' THEN '7000994399'
--					ELSE associate_prefix END AS associate_prefix_fk,
--				[Priority Pass Id] AS prioritypass_id,
--				LoungeCode AS lounge_code_fk,
--				SUM(MembersCount) AS member_visits,
--				SUM(GuestsCount) AS guest_visits,
--				SUM(TotalVisitCount) AS total_member_guest_visits,
--				1 AS account_type_fk
--			FROM mastercard_db.dbo.tblLoungeVisits		
--			GROUP BY BillingMonth,associate_prefix,[Priority Pass Id],LoungeCode
				
--		UNION
			
--			--- MasterCard Wholesale Lite LV Frequency -----
--			SELECT
--				CAST(BillingMonth AS DATE) AS billing_month_fk,
--				SourceCode AS associate_prefix_fk,
--				[Member No] AS prioritypass_id,
--				LoungeCode AS lounge_code_fk,
--				COUNT(*) AS member_visits,
--				SUM([Total Guests]) AS guest_visits,
--				COUNT(*) + SUM([Total Guests]) AS total_member_guest_visits,
--				2 AS account_type_fk
				
--			FROM mastercard_db.dbo.tblWLLoungeVisits
--			GROUP BY BillingMonth,SourceCOde,[Member No],LoungeCode
				
--		UNION
			
--			--- MasterCard Old World Signia LV Frequency -----
--			SELECT
--				CAST(BillingMonth AS DATE) AS billing_month_fk,
--				associate_prefix AS associate_prefix_fk,
--				[Priority Pass Id] AS prioritypass_id,
--				LoungeCode AS lounge_code_fk,
--				SUM(MembersCount) AS member_visits,
--				SUM(GuestsCount) AS guest_visits,
--				SUM(TotalVisitCount) AS total_member_guest_visits,
--				3 AS account_type_fk
--			FROM mastercard_db.dbo.tblWSLoungeVisits
--			GROUP BY BillingMonth,associate_prefix,[Priority Pass Id],LoungeCode
				
--		UNION
			
--			--- MasterCard Direct Associate LV Frequency -----
--			SELECT
--				CAST(BillingMonth AS DATE) AS billing_month_fk,
--				AssociatePrefix AS associate_prefix_fk,
--				PriorityPassID AS prioritypass_id,
--				LoungeCode AS lounge_code_fk,
--				SUM(MemberCount) AS member_visits,
--				SUM(GuestCount) AS guest_visits,
--				SUM(TotalVisitCount) AS total_member_guest_visits,
--				4 AS account_type_fk
--			FROM mastercard_db.dbo.tblDALoungeVisits
--			GROUP BY BillingMonth,AssociatePrefix,PriorityPassId,LoungeCode

--		UNION

--			--- MasterCard LoungeKey LV Frequency -----
--			SELECT
--				CAST(lv.report_month AS DATE) AS billing_month_fk,
--				lv.client_id AS associate_prefix_fk,
--				lv.consumer_no AS prioritypass_id,
--				lv.lounge_code AS lounge_code_fk,
--				SUM(lv.total_member_visits) AS member_visits,
--				SUM(lv.total_guest_visits) AS guest_visits,
--				SUM(lv.total_member_visits + lv.total_guest_visits) AS total_member_guest_visits,
--				dl.account_type_fk AS account_type_fk
--			FROM mastercard_db.dbo.tblLKLoungeVisits lv
--				LEFT JOIN mastercard_dw.dbo.dimTblMCIDeals dl ON lv.client_id = dl.clientid
--			GROUP BY lv.report_month,lv.client_id,lv.consumer_no,lv.lounge_code,dl.account_type_fk

--		) AS lvs

--		WHERE lvs.billing_month_fk BETWEEN  @StartDate AND @EndDate
--		ORDER BY
--			billing_month_fk,
--			associate_prefix_fk,
--			prioritypass_id,
--			lounge_code_fk,
--			member_visits,
--			guest_visits,		
--			account_type_fk
--	END;
--------------------------------------------------------------------------------
-------	MasterCard Data Warehouse ----------------------------------------------
-------	Build Unique LV Fact Table ---------------------------------------------
--------------------------------------------------------------------------------

--TRUNCATE TABLE mastercard_dw.dbo.factTblUniqueMembers

--INSERT INTO mastercard_dw.dbo.factTblUniqueMembers
--([billing_month_fk]
--      ,[prioritypass_id_pk]
--      ,[member_count]
--      ,[account_type_fk])
--SELECT 
--	x.billing_month_fk, 
--	x.prioritypass_id_pk,
--	1 AS member_count, 
--	account_type_fk 
--FROM
--(
--	SELECT		
--		prioritypass_id AS prioritypass_id_pk,
--		MIN(billing_month_fk) AS billing_month_fk,	
--		MIN(account_type_fk) AS account_type_fk
	
--	FROM mastercard_dw.dbo.factTblLVFrequency
	
--	GROUP BY prioritypass_id
--) AS x

--ORDER BY x.billing_month_fk,x.prioritypass_id_pk,account_type_fk



