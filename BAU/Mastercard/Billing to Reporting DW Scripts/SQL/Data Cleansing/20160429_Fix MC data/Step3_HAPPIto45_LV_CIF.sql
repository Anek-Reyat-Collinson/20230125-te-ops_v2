/*******************************************************************************************************************************
** Project ID	 : MasterCard CIF Data Transfer from HAPPI to .45 Step 3
** Author        : Hyun
** Last Mofified : 2016-03-17
** Amend History : GM 17/03/2016 Changes to use 127.0.0.1,41331

** Run history   :	GM 17/03/2016 Ran successfully for Feb data
					GM 19/04/2016 Ran successfully for Mar data
*******************************************************************************************************************************/



----------------------------------- Query Configuration  -----------------------------------------
DECLARE @NumRecs INT
DECLARE @billingmonth AS DATE
SET @billingmonth = '2016-03-01'

/*

DECLARE @NumRecs INT
DECLARE @billingmonth AS DATE
SET @billingmonth = '2016-03-01'

select count(*) from mastercard_db.dbo.tblCIF WHERE [Report_Month] = @billingmonth
select count(*) from mastercard_db.dbo.tblLoungeVisits WHERE [BillingMonth] = @billingmonth
select count(*) from mastercard_db.dbo.tblLoungeVisits_Removed WHERE [BillingMonth] = @billingmonth
select count(*) from mastercard_db.dbo.tblDACIF WHERE [report_month] = @billingmonth
select count(*) from mastercard_db.dbo.tblDALoungeVisits WHERE [BillingMonth] = @billingmonth
select count(*) from mastercard_db.dbo.tblWLCIF WHERE [report_month] = @billingmonth
select count(*) from mastercard_db.dbo.tblWLLoungeVisits WHERE [BillingMonth] = @billingmonth
select count(*) from mastercard_db.dbo.tblWLLoungeVisits_VA WHERE [report_month] = @billingmonth
select count(*) from mastercard_db.dbo.tblWSCIF WHERE [report_month] = @billingmonth
select count(*) from mastercard_db.dbo.tblWSLoungeVisits WHERE [BillingMonth] = @billingmonth
select count(*) from mastercard_db.dbo.tblLKCIF WHERE [report_month] = @billingmonth
select count(*) from mastercard_db.dbo.tblLKLoungeVisits WHERE [report_month] = @billingmonth
*/


--------------------------------------------------------------------------------------------------

----------------- (Add) tblCIF -----------------
SET @NumRecs = (select count(*) from mastercard_db.dbo.tblCIF WHERE [Report_Month] = @billingmonth)
--select @NumRecs
IF @NumRecs > 0
	BEGIN
		DELETE from mastercard_db.dbo.tblCIF WHERE [Report_Month] = @billingmonth
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblCIF'
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblCIF ON
	INSERT INTO mastercard_db.dbo.tblCIF
				([report_month],[mci_region],[country],[bank],[associate_prefix],
				 [deal_type],[total],[tbl_index])
	SELECT [report_month],[mci_region],[country],[bank],[associate_prefix],
		   [deal_type],[total],[tbl_index]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblCIF
	WHERE [report_month] = @billingmonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblCIF OFF
END

----------------- (Add) tblLoungeVisits -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblLoungeVisits WHERE [BillingMonth] = @billingmonth)
--select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblLoungeVisits'
		DELETE from mastercard_db.dbo.tblLoungeVisits WHERE [BillingMonth] = @billingmonth
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblLoungeVisits ON
	INSERT INTO mastercard_db.dbo.tblLoungeVisits
				([BillingMonth],[Item],[Bank],[Deal Type],[Associate_Prefix],[AssociateCode],
				 [ICA],[Priority Pass Id],[Cardholder Name],[Visit],[Lounge Name],[LoungeCode],
				 [DomesticInt],[ISO Country],[VisitCountryISO],[MembersCount],[GuestsCount],
				 [TotalVisitCount],[Batch],[Voucher Number],[MCBillingRegionofIssue],[Currency],
				 [FeePerMember],[FeePerGuest],[TotalFee],[TotalFreeGuests],[FreeGuestsValue],
				 [TotalChargableGuests],[ChargableGuestsValue],[ActualBillingRegion],[tbl_index])
	SELECT [BillingMonth],[Item],[Bank],[Deal Type],[Associate_Prefix],[AssociateCode],
		   [ICA],[Priority Pass Id],[Cardholder Name],[Visit],[Lounge Name],[LoungeCode],
		   [DomesticInt],[ISO Country],[VisitCountryISO],[MembersCount],[GuestsCount],
		   [TotalVisitCount],[Batch],[Voucher Number],[MCBillingRegionofIssue],[Currency],
		   [FeePerMember],[FeePerGuest],[TotalFee],[TotalFreeGuests],[FreeGuestsValue],
		   [TotalChargableGuests],[ChargableGuestsValue],[ActualBillingRegion],[tbl_index]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblLoungeVisits
	WHERE [BillingMonth] = @billingmonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblLoungeVisits OFF
END

----------------- (Add) tblLoungeVisits_Removed -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblLoungeVisits_Removed WHERE [BillingMonth] = @billingmonth)
--select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblLoungeVisits_Removed'
		DELETE from mastercard_db.dbo.tblLoungeVisits_Removed WHERE [BillingMonth] = @billingmonth

	END

BEGIN		
	SET IDENTITY_INSERT mastercard_db.dbo.tblLoungeVisits_Removed ON
	INSERT INTO mastercard_db.dbo.tblLoungeVisits_Removed
				([BillingMonth],[Item],[Bank],[Deal Type],[Associate_Prefix],[AssociateCode],
				 [ICA],[Priority Pass Id],[Cardholder Name],[Visit],[Lounge Name],[LoungeCode],
				 [DomesticInt],[ISO Country],[VisitCountryISO],[MembersCount],[GuestsCount],
				 [TotalVisitCount],[Batch],[Voucher Number],[MCBillingRegionofIssue],[Currency],
				 [FeePerMember],[FeePerGuest],[TotalFee],[TotalFreeGuests],[FreeGuestsValue],
				 [TotalChargableGuests],[ChargableGuestsValue],[ActualBillingRegion],[tbl_index])
	SELECT [BillingMonth],[Item],[Bank],[Deal Type],[Associate_Prefix],[AssociateCode],
		   [ICA],[Priority Pass Id],[Cardholder Name],[Visit],[Lounge Name],[LoungeCode],
		   [DomesticInt],[ISO Country],[VisitCountryISO],[MembersCount],[GuestsCount],
		   [TotalVisitCount],[Batch],[Voucher Number],[MCBillingRegionofIssue],[Currency],
		   [FeePerMember],[FeePerGuest],[TotalFee],[TotalFreeGuests],[FreeGuestsValue],
		   [TotalChargableGuests],[ChargableGuestsValue],[ActualBillingRegion],[tbl_index] 
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblLoungeVisits_Removed
	WHERE [BillingMonth] = @billingmonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblLoungeVisits_Removed OFF
END

----------------- (Add) tblDACIF -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblDACIF WHERE [report_month] = @billingmonth)
--select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblDACIF'
		DELETE from mastercard_db.dbo.tblDACIF WHERE [report_month] = @billingmonth

	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblDACIF ON
	INSERT INTO mastercard_db.dbo.tblDACIF
				([report_month],[mci_region],[country],[bank],
				 [associate_prefix],[deal_type],[total],[tbl_index])	 
	SELECT [report_month],[mci_region],[country],[bank],
		   [associate_prefix],[deal_type],[total],[tbl_index]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblDACIF
	WHERE [report_month] = @billingmonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblDACIF OFF
END	

----------------- (Add) tblDALoungeVisits -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblDALoungeVisits WHERE [BillingMonth] = @billingmonth)
--select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblDALoungeVisits'
		DELETE from mastercard_db.dbo.tblDALoungeVisits WHERE [BillingMonth] = @billingmonth

	END

BEGIN		
	SET IDENTITY_INSERT mastercard_db.dbo.tblDALoungeVisits ON
	INSERT INTO mastercard_db.dbo.tblDALoungeVisits
				([BillingMonth],[Bank],[AssociatePrefix],[AssociateCode],[ICA],
				 [PriorityPassID],[CardholderName],[VisitDate],[LoungeName],[LoungeCode],
				 [ISOCountry],[MemberCount],[GuestCount],[TotalVisitCount],[Batch],
				 [VoucherNumber],[Currency],[TotalMemberFee],[TotalGuestFee],[TotalChargeableFee],
				 [TotalFreeGuest],[FreeGuestValue],[TotalChargeableGuest],[ChargeableGuestValue],[tbl_index])
	SELECT [BillingMonth],[Bank],[AssociatePrefix],[AssociateCode],[ICA],
		   [PriorityPassID],[CardholderName],[VisitDate],[LoungeName],[LoungeCode],
		   [ISOCountry],[MemberCount],[GuestCount],[TotalVisitCount],[Batch],
		   [VoucherNumber],[Currency],[TotalMemberFee],[TotalGuestFee],[TotalChargeableFee],
		   [TotalFreeGuest],[FreeGuestValue],[TotalChargeableGuest],[ChargeableGuestValue],[tbl_index]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblDALoungeVisits
	WHERE [BillingMonth] = @billingmonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblDALoungeVisits OFF
END	

----------------- (Add) tblWLCIF -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblWLCIF WHERE [report_month] = @billingmonth)
--select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblWLCIF'
		DELETE from mastercard_db.dbo.tblWLCIF WHERE [report_month] = @billingmonth

	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblWLCIF ON
	INSERT INTO mastercard_db.dbo.tblWLCIF
				([report_month],[mci_region],[country],[bank],[associate_prefix],
				 [deal_type],[total],[tbl_index])
	SELECT [report_month],[mci_region],[country],[bank],[associate_prefix],
		   [deal_type],[total],[tbl_index] 
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblWLCIF
	WHERE [report_month] = @billingmonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblWLCIF OFF
END	

----------------- (Add) tblWLLoungeVisits -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblWLLoungeVisits WHERE [BillingMonth] = @billingmonth)
--select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblWLLoungeVisits'
		DELETE from mastercard_db.dbo.tblWLLoungeVisits WHERE [BillingMonth] = @billingmonth

	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblWLLoungeVisits ON
	INSERT INTO mastercard_db.dbo.tblWLLoungeVisits
				([BillingMonth],[Member No],[Cardholder Name],[Tier],[Paid To Date],
				 [Visit Date],[Date Processed],[Total Guests],[Visit Fees],[Batch No],
				 [Reference],[Member Status],[LoungeCode],[Lounge],[Airport],[Cost Centre],
				 [Campaign Code],[Total FREE Guests],[FREE Guests Value],[Total Chargeable Guests],
				 [Chargeable Guest Value],[Vendor Code],[User Invitation Code],[Currency],
				 [SourceCode],[tbl_index])
	SELECT [BillingMonth],[Member No],[Cardholder Name],[Tier],[Paid To Date],
		   [Visit Date],[Date Processed],[Total Guests],[Visit Fees],[Batch No],
		   [Reference],[Member Status],[LoungeCode],[Lounge],[Airport],[Cost Centre],
		   [Campaign Code],[Total FREE Guests],[FREE Guests Value],[Total Chargeable Guests],
		   [Chargeable Guest Value],[Vendor Code],[User Invitation Code],[Currency],
		   [SourceCode],[tbl_index]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblWLLoungeVisits
	WHERE [BillingMonth] = @billingmonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblWLLoungeVisits OFF
END	

----------------- (Add) tblWLLoungeVisits_VA -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblWLLoungeVisits_VA WHERE [report_month] = @billingmonth)
--select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblWLLoungeVisits_VA'
		DELETE from mastercard_db.dbo.tblWLLoungeVisits_VA WHERE [report_month] = @billingmonth
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblWLLoungeVisits_VA ON
	INSERT INTO mastercard_db.dbo.tblWLLoungeVisits_VA
				([report_month],[source_code],[consumer_no],[member_name],[membership],
				 [current_status],[ptd],[visit_date],[batch_no],[reference],[lounge_code],
				 [lounge_name],[visit_city],[visit_country],[mc_pays_member_visits],
				 [cm_pays_member_visits],[complimentary_member_visits],[total_member_visits],
				 [mc_pays_guest_visits],[cm_pays_guest_visits],[lounge_offer_guest_visits],
				 [complimentary_guest_visits],[total_guest_visits],[mc_pays_member_visit_currency],
				 [mc_pays_member_visit_fee],[mc_pays_guest_visit_currency],[mc_pays_guest_visit_fee],
				 [cm_pays_member_visit_currency],[cm_pays_member_visit_fee],[cm_pays_guest_visit_currency],
				 [cm_pays_guest_visit_fee],[complimentary_member_visit_currency],[complimentary_member_visit_fee],
				 [complimentary_guest_visit_currency],[complimentary_guest_visit_fee],[cost_centre],
				 [campaign_code],[vendor_code],[user_invitation_code],[tbl_index])
	SELECT [report_month],[source_code],[consumer_no],[member_name],[membership],
		   [current_status],[ptd],[visit_date],[batch_no],[reference],[lounge_code],
		   [lounge_name],[visit_city],[visit_country],[mc_pays_member_visits],
		   [cm_pays_member_visits],[complimentary_member_visits],[total_member_visits],
		   [mc_pays_guest_visits],[cm_pays_guest_visits],[lounge_offer_guest_visits],
		   [complimentary_guest_visits],[total_guest_visits],[mc_pays_member_visit_currency],
		   [mc_pays_member_visit_fee],[mc_pays_guest_visit_currency],[mc_pays_guest_visit_fee],
		   [cm_pays_member_visit_currency],[cm_pays_member_visit_fee],[cm_pays_guest_visit_currency],
		   [cm_pays_guest_visit_fee],[complimentary_member_visit_currency],[complimentary_member_visit_fee],
		   [complimentary_guest_visit_currency],[complimentary_guest_visit_fee],[cost_centre],
		   [campaign_code],[vendor_code],[user_invitation_code],[tbl_index]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblWLLoungeVisits_VA
	WHERE [report_month] = @billingmonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblWLLoungeVisits_VA OFF
END	

----------------- (Add) tblWSCIF -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblWSCIF WHERE [report_month] = @billingmonth)
--select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblWSCIF'
		DELETE from mastercard_db.dbo.tblWSCIF WHERE [report_month] = @billingmonth
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblWSCIF ON
	INSERT INTO mastercard_db.dbo.tblWSCIF
				([report_month],[mci_region],[country],[bank],[associate_prefix],
				 [deal_type],[total],[tbl_index])
	SELECT [report_month],[mci_region],[country],[bank],[associate_prefix],
		   [deal_type],[total],[tbl_index]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblWSCIF
	WHERE [report_month] = @billingmonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblWSCIF OFF
END	

----------------- (Add) tblWSLoungeVisits -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblWSLoungeVisits WHERE [BillingMonth] = @billingmonth)
--select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblWSLoungeVisits'
		DELETE from mastercard_db.dbo.tblWSLoungeVisits WHERE [BillingMonth] = @billingmonth
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblWSLoungeVisits ON
	INSERT INTO mastercard_db.dbo.tblWSLoungeVisits
				([tbl_index],[BillingMonth],[Item],[Bank],[Deal Type],[Associate_Prefix],
				 [AssociateCode],[ICA],[Priority Pass Id],[Cardholder Name],[Visit],
				 [Lounge Name],[LoungeCode],[DomesticInt],[ISO Country],[VisitCountryISO],
				 [MembersCount],[GuestsCount],[TotalVisitCount],[Batch],[Voucher Number],
				 [MCBillingRegionofIssue],[Currency],[FeePerMember],[FeePerGuest],[TotalFee],
				 [TotalFreeGuests],[FreeGuestsValue],[TotalChargableGuests],[ChargableGuestsValue],
				 [ActualBillingRegion],[BankInvoiceCurrency],[BankInvoiceFee],[CardMemberInvoiceCurrency])
	SELECT [tbl_index],[BillingMonth],[Item],[Bank],[Deal Type],[Associate_Prefix],
		   [AssociateCode],[ICA],[Priority Pass Id],[Cardholder Name],[Visit],
		   [Lounge Name],[LoungeCode],[DomesticInt],[ISO Country],[VisitCountryISO],
		   [MembersCount],[GuestsCount],[TotalVisitCount],[Batch],[Voucher Number],
		   [MCBillingRegionofIssue],[Currency],[FeePerMember],[FeePerGuest],[TotalFee],
		   [TotalFreeGuests],[FreeGuestsValue],[TotalChargableGuests],[ChargableGuestsValue],
		   [ActualBillingRegion],[BankInvoiceCurrency],[BankInvoiceFee],[CardMemberInvoiceCurrency]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblWSLoungeVisits
	WHERE [BillingMonth] = @billingmonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblWSLoungeVisits OFF
END	

----------------- (Add) tblLKCIF -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblLKCIF WHERE [report_month] = @billingmonth)
--select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblLKCIF'
		DELETE from mastercard_db.dbo.tblLKCIF WHERE [report_month] = @billingmonth
	END

BEGIN		
	SET IDENTITY_INSERT mastercard_db.dbo.tblLKCIF ON
	INSERT INTO mastercard_db.dbo.tblLKCIF
				([report_month],[billing_month],[client_id],[source_code],[bin],
				 [currency],[monthly_unit_price],[total],[tbl_index])
	SELECT [report_month],[billing_month],[client_id],[source_code],[bin],
		   [currency],[monthly_unit_price],[total],[tbl_index]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblLKCIF
	WHERE [report_month] = @billingmonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblLKCIF OFF
END	

----------------- (Add) tblLKLoungeVisits -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblLKLoungeVisits WHERE [report_month] = @billingmonth)
--select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblLKLoungeVisits'
		DELETE from mastercard_db.dbo.tblLKLoungeVisits WHERE [report_month] = @billingmonth
	END
	
BEGIN	
	SET IDENTITY_INSERT mastercard_db.dbo.tblLKLoungeVisits ON
	INSERT INTO mastercard_db.dbo.tblLKLoungeVisits
				([report_month],[client_id],[source_code],[bin_number],[consumer_no],[title],
				 [first_name],[last_name],[ptd],[visit_date],[process_date],[membership],
				 [current_status],[batch_no],[reference],[lounge_code],[lounge_name],[City],
				 [Country],[mc_pays_member_visits],[inclusive_member_visits],[complimentary_member_visits],
				 [cm_pays_member_visits],[total_member_visits],[mc_pays_guest_visits],
				 [inclusive_guest_visits],[complimentary_guest_visits],[cm_pays_guest_visits],
				 [lounge_offer_guest_visits],[total_guest_visits],[mc_pays_member_visit_currency],
				 [mc_pays_member_visit_fee],[mc_pays_guest_visit_currency],[mc_pays_guest_visit_fee],
				 [cm_pays_member_visit_currency],[cm_pays_member_visit_fee],[cm_pays_guest_visit_currency],
				 [cm_pays_guest_visit_fee],[complimentary_member_visit_currency],[complimentary_member_visit_fee],
				 [complimentary_guest_visit_currency],[complimentary_guest_visit_fee],[cost_centre],
				 [campaign_code],[vendor_code],[user_invitation_code],[credit_card_number],[tbl_index])
	SELECT [report_month],[client_id],[source_code],[bin_number],[consumer_no],[title],
		   [first_name],[last_name],[ptd],[visit_date],[process_date],[membership],
		   [current_status],[batch_no],[reference],[lounge_code],[lounge_name],[City],
		   [Country],[mc_pays_member_visits],[inclusive_member_visits],[complimentary_member_visits],
		   [cm_pays_member_visits],[total_member_visits],[mc_pays_guest_visits],
		   [inclusive_guest_visits],[complimentary_guest_visits],[cm_pays_guest_visits],
		   [lounge_offer_guest_visits],[total_guest_visits],[mc_pays_member_visit_currency],
		   [mc_pays_member_visit_fee],[mc_pays_guest_visit_currency],[mc_pays_guest_visit_fee],
		   [cm_pays_member_visit_currency],[cm_pays_member_visit_fee],[cm_pays_guest_visit_currency],
		   [cm_pays_guest_visit_fee],[complimentary_member_visit_currency],[complimentary_member_visit_fee],
		   [complimentary_guest_visit_currency],[complimentary_guest_visit_fee],[cost_centre],
		   [campaign_code],[vendor_code],[user_invitation_code],[credit_card_number],[tbl_index]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblLKLoungeVisits
	WHERE [report_month] = @billingmonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblLKLoungeVisits OFF
END	