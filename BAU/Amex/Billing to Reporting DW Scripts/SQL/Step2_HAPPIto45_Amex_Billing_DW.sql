
-- HD AWS ran on this on 12/06/20 with @billingmonth = '2020-05-01'
-- AA AWS ran on this on 19/06/20 with @billingmonth = '2020-05-01'
-- HD AWS ran on this on 24/06/20 with @billingmonth = '2020-05-01'
-- HD AWS ran on this on 09/07/20 with @billingmonth = '2020-06-01'
-- HD AWS ran on this on 07/08/20 with @billingmonth = '2020-06-01'
-- HD AWS ran on this on 10/08/20 with @billingmonth = '2020-07-01'
-- HD AWS ran on this on 09/09/20 with @billingmonth = '2020-08-01'
-- HD AWS ran on this on 07/10/20 with @billingmonth = '2020-09-01'
-- HD AWS ran on this on 06/11/20 with @billingmonth = '2020-10-01'
-- HD AWS ran on this on 04/12/20 with @billingmonth = '2020-11-01'
-- HD AWS ran on this on 07/12/20 with @billingmonth = '2020-11-01'
-- HD AWS ran on this on 08/01/21 with @billingmonth = '2020-12-01'
-- HD AWS ran on this on 05/02/21 with @billingmonth = '2021-01-01'
-- HD AWS ran on this on 05/03/21 with @billingmonth = '2021-02-01'
-- HD AWS ran on this on 10/03/21 with @billingmonth = '2021-02-01' -- BIBAU-2734
-- HD AWS ran on this on 09/04/21 with @billingmonth = '2021-03-01'
-- HD AWS ran on this on 08/05/21 with @billingmonth = '2021-04-01'
-- HD AWS ran on this on 12/05/21 with @billingmonth = '2021-04-01'
-- HD AWS ran on this on 07/06/21 with @billingmonth = '2021-05-01'
-- HD AWS ran on this on 08/07/21 with @billingmonth = '2021-06-01'
-- HD AWS ran on this on 06/08/21 with @billingmonth = '2021-07-01'
-- HD AWS ran on this on 07/09/21 with @billingmonth = '2021-08-01'
-- HD AWS ran on this on 08/10/21 with @billingmonth = '2021-09-01'
-- HD AWS ran on this on 05/11/21 with @billingmonth = '2021-10-01'
-- HD AWS ran on this on 03/12/21 with @billingmonth = '2021-10-01'--OPSBI 96
-- HD AWS ran on this on 13/12/21 with @billingmonth = '2021-11-01'
-- HD AWS ran on this on 10/01/22 with @billingmonth = '2021-12-01'
-- HD AWS ran on this on 14/02/22 with @billingmonth = '2022-01-01'
-- HD AWS ran on this on 15/02/22 with @billingmonth = '2022-01-01' - OPSBI 106
-- HD AWS ran on this on 07/04/22 with @billingmonth = '2022-03-01'
-- HD AWS ran on this on 27/04/22 with @billingmonth = '2022-03-01'
-- HD AWS ran on this on 10/05/22 with @billingmonth = '2022-04-01'
-- HD AWS ran on this on 10/06/22 with @billingmonth = '2022-05-01'
-- HD AWS ran on this on 13/07/22 with @billingmonth = '2022-06-01'
-- HD AWS ran on this on 09/08/22 with @billingmonth = '2022-07-01'
-- HD AWS ran on this on 12/09/22 with @billingmonth = '2022-08-01'
-- HD AWS ran on this on 12/10/22 with @billingmonth = '2022-09-01'
-- HD AWS ran on this on 09/11/22 with @billingmonth = '2022-10-01'
-- HD AWS ran on this on 08/12/22 with @billingmonth = '2022-11-01'
-- HD AWS ran on this on 11/01/23 with @billingmonth = '2022-12-01'
-- HD AWS ran on this on 13/01/23 with @billingmonth = '2022-12-01'
-- HD AWS ran on this on 31/01/23 with @billingmonth = '2022-11-01' - OPSBI 198
-- HD AWS ran on this on 07/02/23 with @billingmonth = '2023-01-01'

--------------------- Amex Billing Data Transfer from HAPPI to .45 --------------------------
-- Data transfer queries from HAPPI to .45
------------------------- System Configuration (to be excuted once) --------------------------
--EXEC sp_addlinkedserver [127.0.0.1,41331]
--EXEC sp_addlinkedsrvlogin '127.0.0.1,41331', 'false', NULL, 'hyun.sunglee', '01September'
----------------------------------- Query Configuration  -------------------------------------

/*****************************************
** Last Mofified :	2016-06-13
** Last Mofified by :	Mahesh Chittigari
** Last Mofified description :	Introduced external_identifier as a part of Membership Extension project
******************************************/
USE amex_billing_db_va;

DECLARE @NumRecs INT

DECLARE @billingmonth AS DATE
SET @billingmonth = '2023-01-01'

----------------------------------------------------------------------------------------------

----------------- (Add) tblCIFSummary -----------------
;DISABLE TRIGGER  dbo.trg_AutoAudit_tblCIFSummary ON dbo.tblCIFSummary;

DELETE from amex_billing_db_va.dbo.tblCIFSummary WHERE [Report Month] = @billingmonth

BEGIN
	SET IDENTITY_INSERT amex_billing_db_va.dbo.tblCIFSummary ON
	INSERT INTO amex_billing_db_va.dbo.tblCIFSummary
				([table_index],[Report Month],[Prop/GNS],[Enrolment Method],[source_code],
				 [Business Unit],[market_code],[Card],[Level],[member_type],[CIF])
	SELECT [table_index],[Report Month],[Prop/GNS],[Enrolment Method],[source_code],
		   [Business Unit],[market_code],[Card],[Level],[member_type],[CIF]
	FROM [10.204.200.112\OPSLIVEDB,49214].amex_billing_db_va.dbo.tblCIFSummary
	WHERE [Report Month] = @billingmonth
	SET IDENTITY_INSERT amex_billing_db_va.dbo.tblCIFSummary OFF
END;
ENABLE TRIGGER  dbo.trg_AutoAudit_tblCIFSummary ON dbo.tblCIFSummary;


------------------- (Add) tblLoungeVisits -----------------
DISABLE TRIGGER dbo.trg_AutoAudit_tblLoungeVisits ON dbo.tblLoungeVisits

DELETE from amex_billing_db_va.dbo.tblLoungeVisits WHERE [report_month] = @billingmonth

BEGIN
	SET IDENTITY_INSERT amex_billing_db_va.dbo.tblLoungeVisits ON
	INSERT INTO amex_billing_db_va.dbo.tblLoungeVisits
		([table_index],[report_month],[service_centre],[market_code],[prop_gns],
		 [member_type],[card_type],[business_unit],[card_level],[price_type],
		 [price_group],[billing_country],[consumer_no],[member_name],[current_ptd],
		 [current_status],[current_source],[visit_source_code],[visit_date],[visit_ptd],
		 [processed_date],[batch_no],[reference],[lounge_code],[lounge_name],[city],
		 [visit_country_code],[amex_pays_member_visits],[cm_pays_member_visits],
		 [complimentary_member_visits],[total_member_visits],[amex_pays_guest_visits],
		 [cm_pays_guest_visits],[lounge_offer_guest_visits],[complimentary_guest_visit],
		 [total_guest_visits],[amex_pays_member_visit_currency],[amex_pays_member_visit_fee],
		 [amex_pays_guest_visit_currency],[amex_pays_guest_visit_fee],
		 [cm_pays_member_visit_currency],[cm_pays_member_visit_fee],
		 [cm_pays_guest_visit_currency],[cm_pays_guest_visit_fee],[visit_status],
		 [void_visits],[external_identifier])--,[credit_card_number])                                                     -- blanked out cc by AE
	SELECT [table_index],[report_month],[service_centre],[market_code],[prop_gns],
		   [member_type],[card_type],[business_unit],[card_level],[price_type],
		   [price_group],[billing_country],[consumer_no],[member_name],[current_ptd],
		   [current_status],[current_source],[visit_source_code],[visit_date],[visit_ptd],
		   [processed_date],[batch_no],[reference],[lounge_code],[lounge_name],[city],
		   [visit_country_code],[amex_pays_member_visits],[cm_pays_member_visits],
		   [complimentary_member_visits],[total_member_visits],[amex_pays_guest_visits],
		   [cm_pays_guest_visits],[lounge_offer_guest_visits],[complimentary_guest_visit],
		   [total_guest_visits],[amex_pays_member_visit_currency],[amex_pays_member_visit_fee],
		   [amex_pays_guest_visit_currency],[amex_pays_guest_visit_fee],
		   [cm_pays_member_visit_currency],[cm_pays_member_visit_fee],
		   [cm_pays_guest_visit_currency],[cm_pays_guest_visit_fee],[visit_status],
		   [void_visits],[external_identifier]--,[credit_card_number]                                                              -- blanked out cc by AE
		FROM [10.204.200.112\OPSLIVEDB,49214].amex_billing_db_va.dbo.tblLoungeVisits
		WHERE [report_month] =@billingmonth
	SET IDENTITY_INSERT amex_billing_db_va.dbo.tblLoungeVisits OFF
END;
Enable TRIGGER dbo.trg_AutoAudit_tblLoungeVisits ON dbo.tblLoungeVisits;

------------------- (Add) tblLoungeVisits_Removed -----------------

DELETE from amex_billing_db_va.dbo.tblLoungeVisits_Removed WHERE [report_month] = @billingmonth

BEGIN
	SET IDENTITY_INSERT amex_billing_db_va.dbo.tblLoungeVisits_Removed ON
	INSERT INTO amex_billing_db_va.dbo.tblLoungeVisits_Removed
				([table_index],[report_month],[service_centre],[market_code],[prop_gns],
				 [member_type],[card_type],[business_unit],[card_level],[price_type],
				 [price_group],[billing_country],[consumer_no],[member_name],[current_ptd],
				 [current_status],[current_source],[visit_source_code],[visit_date],[visit_ptd],
				 [processed_date],[batch_no],[reference],[lounge_code],[lounge_name],[city],
				 [visit_country_code],[amex_pays_member_visits],[cm_pays_member_visits],
				 [complimentary_member_visits],[total_member_visits],[amex_pays_guest_visits],
				 [cm_pays_guest_visits],[lounge_offer_guest_visits],[complimentary_guest_visit],
				 [total_guest_visits],[amex_pays_member_visit_currency],[amex_pays_member_visit_fee],
				 [amex_pays_guest_visit_currency],[amex_pays_guest_visit_fee],
				 [cm_pays_member_visit_currency],[cm_pays_member_visit_fee],
				 [cm_pays_guest_visit_currency],[cm_pays_guest_visit_fee],[visit_status],
				 [void_visits],[cons_numb],[date_removed],[reason_removed],[external_identifier])
	SELECT [table_index],[report_month],[service_centre],[market_code],[prop_gns],
		   [member_type],[card_type],[business_unit],[card_level],[price_type],
		   [price_group],[billing_country],[consumer_no],[member_name],[current_ptd],
		   [current_status],[current_source],[visit_source_code],[visit_date],[visit_ptd],
		   [processed_date],[batch_no],[reference],[lounge_code],[lounge_name],[city],
		   [visit_country_code],[amex_pays_member_visits],[cm_pays_member_visits],
		   [complimentary_member_visits],[total_member_visits],[amex_pays_guest_visits],
		   [cm_pays_guest_visits],[lounge_offer_guest_visits],[complimentary_guest_visit],
		   [total_guest_visits],[amex_pays_member_visit_currency],[amex_pays_member_visit_fee],
		   [amex_pays_guest_visit_currency],[amex_pays_guest_visit_fee],
		   [cm_pays_member_visit_currency],[cm_pays_member_visit_fee],
		   [cm_pays_guest_visit_currency],[cm_pays_guest_visit_fee],[visit_status],
		   [void_visits],[cons_numb],[date_removed],[reason_removed],[external_identifier]
	FROM [10.204.200.112\OPSLIVEDB,49214].amex_billing_db_va.dbo.tblLoungeVisits_Removed
	WHERE [report_month] = @billingmonth
	SET IDENTITY_INSERT amex_billing_db_va.dbo.tblLoungeVisits_Removed OFF
END;

----------------------------------------------------------------------------------------------------------
-------------------------------------- (Add) tblMemberships ----------------------------------------------
----------------------------------------------------------------------------------------------------------

DISABLE TRIGGER  dbo.trg_AutoAudit_tblMemberships ON dbo.tblMemberships

DELETE from amex_billing_db_va.dbo.tblMemberships WHERE [report_month] = @billingmonth

BEGIN
	SET IDENTITY_INSERT amex_billing_db_va.dbo.tblMemberships ON
	INSERT INTO amex_billing_db_va.dbo.tblMemberships
				([table_index],[report_month],[service_centre],[prop_gns],[member_type],
				 [card_type],[business_unit],[card_level],[currency],[fee],[market_code],
				 [purchase_source_code],[consumer_number],[purchase_number],[pp_card_number],
				-- [credit_card_number],                                                        --- Blanked out cc
				 [credit_card_expiry],[surname],[forename],[type],
				 [paid_to_date],[current_source_code],[credit],[credit_comment],
				 [date_imported],[bill_to_amex],[external_identifier])
	SELECT [table_index],[report_month],[service_centre],[prop_gns],[member_type],
		   [card_type],[business_unit],[card_level],[currency],[fee],[market_code],
		   [purchase_source_code],[consumer_number],[purchase_number],[pp_card_number],
		   --[credit_card_number],                                                                  --- blanked out cc
		   [credit_card_expiry],[surname],[forename],[type],
		   [paid_to_date],[current_source_code],[credit],[credit_comment],
		   [date_imported],[bill_to_amex],[external_identifier]
	FROM [10.204.200.112\OPSLIVEDB,49214].amex_billing_db_va.dbo.tblMemberships
	WHERE [report_month] = @billingmonth
	SET IDENTITY_INSERT amex_billing_db_va.dbo.tblMemberships OFF
END;

Enable TRIGGER  dbo.trg_AutoAudit_tblMemberships ON dbo.tblMemberships
------------------- (Add) tblMemberships_Removed -----------------
DELETE from amex_billing_db_va.dbo.tblMemberships_Removed WHERE [report_month] = @billingmonth

BEGIN
	SET IDENTITY_INSERT amex_billing_db_va.dbo.tblMemberships_Removed ON
	INSERT INTO amex_billing_db_va.dbo.tblMemberships_Removed
				([tbl_index],[report_month],[service_centre],[member_type],[market_code],
				 [purchase_source_code],[consumer_number],[purchase_number],[pp_card_number],
			--	 [credit_card_number],                                                                -- blanked out cc
				 [credit_card_expiry],[surname],[forename],[type],
				 [paid_to_date],[current_source_code],[prop_gns],[card_type],[business_unit],
				 [card_level],[fee],[currency],[reason_removed],[date_removed],[external_identifier])		 
	SELECT [tbl_index],[report_month],[service_centre],[member_type],[market_code],
		   [purchase_source_code],[consumer_number],[purchase_number],[pp_card_number],
		  -- [credit_card_number],                                                                 -- balnked out cc
		   [credit_card_expiry],[surname],[forename],[type],
		   [paid_to_date],[current_source_code],[prop_gns],[card_type],[business_unit],
		   [card_level],[fee],[currency],[reason_removed],[date_removed], [external_identifier]	 
	FROM [10.204.200.112\OPSLIVEDB,49214].amex_billing_db_va.dbo.tblMemberships_Removed
	WHERE [report_month] = @billingmonth
	SET IDENTITY_INSERT amex_billing_db_va.dbo.tblMemberships_Removed OFF
END;

----------- (Add) amex_associates_db.dbo.tblcardsinforce ---------
USE amex_associates_db
;DISABLE TRIGGER dbo.trg_AutoAudit_tblCardsInForce ON dbo.tblCardsInForce

DELETE from amex_associates_db.dbo.tblcardsinforce WHERE [report month] = @billingmonth

BEGIN
	SET IDENTITY_INSERT amex_associates_db.dbo.tblcardsinforce ON
	INSERT INTO amex_associates_db.dbo.tblcardsinforce
				([pk_index],[Report Month],[source_code],[CIF])
	SELECT [pk_index],[Report Month],[source_code],[CIF]
	FROM [10.204.200.112\OPSLIVEDB,49214].amex_associates_db.dbo.tblcardsinforce
	WHERE [report month] = @billingmonth
	SET IDENTITY_INSERT amex_associates_db.dbo.tblcardsinforce OFF
END;

enable TRIGGER dbo.trg_AutoAudit_tblCardsInForce ON dbo.tblCardsInForce;

------------ (Add) amex_associates_db.dbo.tblMemberships ----------
DISABLE TRIGGER dbo.trg_AutoAudit_tblMemberships ON dbo.tblMemberships;

DELETE from amex_associates_db.dbo.tblMemberships WHERE [reportmonth] = @billingmonth

BEGIN
	SET IDENTITY_INSERT amex_associates_db.dbo.tblMemberships ON
	INSERT INTO amex_associates_db.dbo.tblMemberships
				([pk_index],[SoNo],[SoDate],[CardType],[ServiceCentre],[Prefix],[Bank],
				 [Country],[InvoiceNo],[DateSent],[InvoiceDate],[SalesType],[KitIncluded],
				 [Coe],[AxRegion],[Valid],[Remarks],[QtyBilled],[QtySent],[UnitCurrency],
				 [UnitPrice],[BillAmount],[BillFreight],[InvMonth],[BillTotal],[ReportMonth])
	SELECT [pk_index],[SoNo],[SoDate],[CardType],[ServiceCentre],[Prefix],[Bank],
		   [Country],[InvoiceNo],[DateSent],[InvoiceDate],[SalesType],[KitIncluded],
		   [Coe],[AxRegion],[Valid],[Remarks],[QtyBilled],[QtySent],[UnitCurrency],
		   [UnitPrice],[BillAmount],[BillFreight],[InvMonth],[BillTotal],[ReportMonth]
	FROM [10.204.200.112\OPSLIVEDB,49214].amex_associates_db.dbo.tblMemberships
	WHERE reportmonth = @billingmonth
	SET IDENTITY_INSERT amex_associates_db.dbo.tblMemberships OFF
END;

Enable TRIGGER dbo.trg_AutoAudit_tblMemberships ON dbo.tblMemberships;

----------- (Add) amex_associates_db.dbo.tblloungevisits ----------
DISABLE TRIGGER dbo.trg_AutoAudit_tblLoungeVisits ON dbo.tblLoungeVisits;

DELETE from amex_associates_db.dbo.tblloungevisits WHERE [report month] = @billingmonth

BEGIN
	SET IDENTITY_INSERT amex_associates_db.dbo.tblloungevisits ON
	INSERT INTO amex_associates_db.dbo.tblloungevisits
				([Report Month],[Source Code],[Portfolio],[Price Group],[Currency],
				 [Member Id],[Cardholder Name],[Visit Date],[Lounge Code],[Ctry],
				 [Total Guests],[Visit Fee],[Total Guest Fee],[Total Fee],[Batch No],
				 [Voucher No],[Total FREE Guests],[FREE Guests Value],[Total Chargeable Guests],
				 [CMGuestFee],[tbl_index],[external_identifier])		 
	SELECT [Report Month],[Source Code],[Portfolio],[Price Group],[Currency],
		   [Member Id],[Cardholder Name],[Visit Date],[Lounge Code],[Ctry],
		   [Total Guests],[Visit Fee],[Total Guest Fee],[Total Fee],[Batch No],
		   [Voucher No],[Total FREE Guests],[FREE Guests Value],[Total Chargeable Guests],
		   [CMGuestFee],[tbl_index], [external_identifier] 
	FROM [10.204.200.112\OPSLIVEDB,49214].amex_associates_db.dbo.tblloungevisits
	WHERE [Report Month] = @billingmonth
	SET IDENTITY_INSERT amex_associates_db.dbo.tblloungevisits OFF
END;

enable TRIGGER dbo.trg_AutoAudit_tblLoungeVisits ON dbo.tblLoungeVisits;