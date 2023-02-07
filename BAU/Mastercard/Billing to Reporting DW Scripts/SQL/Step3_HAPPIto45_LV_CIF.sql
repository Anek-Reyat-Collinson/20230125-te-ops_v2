/*******************************************************************************************************************************
** Project ID	 : MasterCard CIF Data Transfer from HAPPI to .45 Step 3
** Author        : Hyun
                 : AE added the prepaid script
** Last Mofified : 2016-11-17
** Amend History : GM 26/07/2016 Changes to work with Audit Triggers
** Amend History : AE 13/09/2016 Added date range parameters
				   AE LA 24/04/2017 added four new columns  [Terminal],[International Or Domestic], [Experience Type],[Experience Category])
				   from MCAE project
** Amend History : LA 01/06/2017 Renamed column name in world Singia from "FeePerGuest" to "TotalGuestFee" in tblWSLoungeVisits table for
**                               https://jira.ptgmis.com/browse/BI-278 
**                  LA 05/06/2017 uncommented set identity_insert for mastercard_db.dbo.tblWSLoungeVisits and added tbl_index to query
				    AA 14/11/2017 remode the deletion of the tblLKCIF and replaced by truncation of the table and removed LKCIF DATE RANGE
** Run history   :	AE Ran script on 12/08/2016 sucessfully for July 2016 data
                    AE Ran script on 20/10/2016 sucessfully for September 2016 data --- also ran the LKCIF from 2014-05-01 and 2016-09-01.
                    GM Ran script on 14/11/2016 sucessfully for October 2016 data
					AE Ran script on 15/12/2016 sucessfully for November 2016 data
                    AE Ran script on 16/01/2016 sucessfully for December 2016 data
					AE Ran script on 17/02/2017 sucessfully for Jan 2017 data
					VP Ran script on 17/03/2017 sucessfully for Feb 2017 data
					AE Ran script on 13/04/2017 sucessfully for Mar 2017 data
					AE Ran script on 13/04/2017 sucessfully for Mar 2017 data
					VP Ran script on 12/05/2017 sucessfully for Apr 2017 data
					AE Ran script on 13/06/2017 sucessfully for May 2017 data
					AE Ran script on 14/07/2017 sucessfully for June 2017 data
					AE Ran script on 11/08/2017 sucessfully for July 2017 data
					vp Ran script on 14/09/2017 sucessfully for Aug 2017 data
					AA Ran script on 13/10/2017 sucessfully for Sep 2017 data
					AA Ran script on 13/11/2017 sucessfully for OCT 2017 data
					AA Ran script on 12/12/2017 sucessfully for Nov 2017 data
					AA Ran script on 11/01/2018 sucessfully for Dec 2017 data
					AA Ran script on 12/02/2018 sucessfully for Jan 2018 data
					AA Ran script on 13/03/2018 sucessfully for Feb 2018 data
					AA Ran script on 13/04/2018 sucessfully for Mar 2018 data
					
*******************************************************************************************************************************/
USE mastercard_db
GO
--********this script does not have external identified colum---include this column when running manually for tables
------------------------------- Query Configuration  -----------------------------------------
DECLARE @NumRecs INT
DECLARE @StartDate AS DATE = '2018-03-01'  -- ENTER THE REPORT MONTH
DECLARE @EndDate   AS DATE = '2018-03-01'; --- ENTER REPORT MONTH

------------- (Add) tblCIF -----------------
SET @NumRecs = (select count(*) from mastercard_db.dbo.tblCIF WHERE [Report_Month] BETWEEN  @StartDate AND @EndDate)
IF @NumRecs > 0
	BEGIN;
		DISABLE TRIGGER [dbo].[trg_AutoAudit_tblCIF] ON [dbo].[tblCIF]; 
			DELETE from mastercard_db.dbo.tblCIF WHERE [Report_Month] BETWEEN  @StartDate AND @EndDate;
		ENABLE TRIGGER [dbo].[trg_AutoAudit_tblCIF] ON [dbo].[tblCIF]; 
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblCIF ON
	
	INSERT INTO mastercard_db.dbo.tblCIF
				 ([report_month],[mci_region],[country],[bank],[associate_prefix],[deal_type],
				 [total],[tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy]
    			 )
	SELECT  [report_month],[mci_region],[country],[bank],[associate_prefix],[deal_type],
			[total],[tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy]			
   FROM [127.0.0.1,41331].mastercard_db.dbo.tblCIF
   WHERE [report_month] BETWEEN  @StartDate AND @EndDate
		
	SET IDENTITY_INSERT mastercard_db.dbo.tblCIF OFF
END;

----------- (Add) tblLoungeVisits -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblLoungeVisits WHERE [BillingMonth] BETWEEN  @StartDate AND @EndDate)
IF @NumRecs > 0
	BEGIN;
		DISABLE TRIGGER [dbo].[trg_AutoAudit_tblLoungeVisits] ON [dbo].tblLoungeVisits; 
			DELETE from mastercard_db.dbo.tblLoungeVisits WHERE [BillingMonth] BETWEEN  @StartDate AND @EndDate;
		ENABLE TRIGGER [dbo].[trg_AutoAudit_tblLoungeVisits] ON [dbo].tblLoungeVisits; 
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblLoungeVisits ON
	INSERT INTO mastercard_db.dbo.tblLoungeVisits
				([BillingMonth],[Item],[Bank],[Deal Type],[Associate_Prefix],[AssociateCode],
				 [ICA],[Priority Pass Id],[Cardholder Name],[Visit],[Lounge Name],[LoungeCode],
				 [DomesticInt],[ISO Country],[VisitCountryISO],[MembersCount],[GuestsCount],
				 [TotalVisitCount],[Batch],[Voucher Number],[MCBillingRegionofIssue],[Currency],
				 [FeePerMember],[FeePerGuest],[TotalFee],[TotalFreeGuests],[FreeGuestsValue],
				 [TotalChargableGuests],[ChargableGuestsValue],[ActualBillingRegion],
				 [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy])
	SELECT [BillingMonth],[Item],[Bank],[Deal Type],[Associate_Prefix],[AssociateCode],
		   [ICA],[Priority Pass Id],[Cardholder Name],[Visit],[Lounge Name],[LoungeCode],
		   [DomesticInt],[ISO Country],[VisitCountryISO],[MembersCount],[GuestsCount],
		   [TotalVisitCount],[Batch],[Voucher Number],[MCBillingRegionofIssue],[Currency],
		   [FeePerMember],[FeePerGuest],[TotalFee],[TotalFreeGuests],[FreeGuestsValue],
		   [TotalChargableGuests],[ChargableGuestsValue],[ActualBillingRegion],
		   [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblLoungeVisits
	WHERE [BillingMonth] BETWEEN  @StartDate AND @EndDate
	SET IDENTITY_INSERT mastercard_db.dbo.tblLoungeVisits OFF
END;

----------- (Add) tblLoungeVisits_Removed -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblLoungeVisits_Removed WHERE [BillingMonth] BETWEEN  @StartDate AND @EndDate)
IF @NumRecs > 0
	BEGIN;
		DISABLE TRIGGER [dbo].[trg_AutoAudit_tblLoungeVisits_Removed] ON [dbo].tblLoungeVisits_Removed; 
			DELETE from mastercard_db.dbo.tblLoungeVisits_Removed WHERE [BillingMonth] BETWEEN  @StartDate AND @EndDate;
		ENABLE TRIGGER [dbo].[trg_AutoAudit_tblLoungeVisits_Removed] ON [dbo].tblLoungeVisits_Removed; 
	END

BEGIN		
	SET IDENTITY_INSERT mastercard_db.dbo.tblLoungeVisits_Removed ON
	INSERT INTO mastercard_db.dbo.tblLoungeVisits_Removed
				([BillingMonth],[Item],[Bank],[Deal Type],[Associate_Prefix],[AssociateCode],
				 [ICA],[Priority Pass Id],[Cardholder Name],[Visit],[Lounge Name],[LoungeCode],
				 [DomesticInt],[ISO Country],[VisitCountryISO],[MembersCount],[GuestsCount],
				 [TotalVisitCount],[Batch],[Voucher Number],[MCBillingRegionofIssue],[Currency],
				 [FeePerMember],[FeePerGuest],[TotalFee],[TotalFreeGuests],[FreeGuestsValue],
				 [TotalChargableGuests],[ChargableGuestsValue],[ActualBillingRegion],
				 [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy])
	SELECT [BillingMonth],[Item],[Bank],[Deal Type],[Associate_Prefix],[AssociateCode],
		   [ICA],[Priority Pass Id],[Cardholder Name],[Visit],[Lounge Name],[LoungeCode],
		   [DomesticInt],[ISO Country],[VisitCountryISO],[MembersCount],[GuestsCount],
		   [TotalVisitCount],[Batch],[Voucher Number],[MCBillingRegionofIssue],[Currency],
		   [FeePerMember],[FeePerGuest],[TotalFee],[TotalFreeGuests],[FreeGuestsValue],
		   [TotalChargableGuests],[ChargableGuestsValue],[ActualBillingRegion],
		   [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy] 
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblLoungeVisits_Removed
	WHERE [BillingMonth] BETWEEN  @StartDate AND @EndDate
	SET IDENTITY_INSERT mastercard_db.dbo.tblLoungeVisits_Removed OFF
END;

----------- (Add) tblDACIF -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblDACIF WHERE [report_month] BETWEEN  @StartDate AND @EndDate)
IF @NumRecs > 0
	BEGIN;
		DISABLE TRIGGER [dbo].[trg_AutoAudit_tblDACIF] ON [dbo].tblDACIF; 
			DELETE from mastercard_db.dbo.tblDACIF WHERE [report_month] BETWEEN  @StartDate AND @EndDate;
		ENABLE TRIGGER [dbo].[trg_AutoAudit_tblDACIF] ON [dbo].tblDACIF; 
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblDACIF ON
	INSERT INTO mastercard_db.dbo.tblDACIF
				([report_month],[mci_region],[country],[bank],
				 [associate_prefix],[deal_type],[total],
				 [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy])	 
	SELECT [report_month],[mci_region],[country],[bank],
		   [associate_prefix],[deal_type],[total],
		   [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblDACIF
	WHERE [report_month] BETWEEN  @StartDate AND @EndDate
	SET IDENTITY_INSERT mastercard_db.dbo.tblDACIF OFF
END;

----------- (Add) tblDALoungeVisits -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblDALoungeVisits WHERE [BillingMonth] BETWEEN  @StartDate AND @EndDate)
IF @NumRecs > 0
	BEGIN;
		DISABLE TRIGGER [dbo].[trg_AutoAudit_tblDALoungeVisits] ON [dbo].tblDALoungeVisits; 
			DELETE from mastercard_db.dbo.tblDALoungeVisits WHERE [BillingMonth] BETWEEN  @StartDate AND @EndDate;
		ENABLE TRIGGER [dbo].[trg_AutoAudit_tblDALoungeVisits] ON [dbo].tblDALoungeVisits; 
	END

BEGIN		
	SET IDENTITY_INSERT mastercard_db.dbo.tblDALoungeVisits ON
	INSERT INTO mastercard_db.dbo.tblDALoungeVisits
				([BillingMonth],[Bank],[AssociatePrefix],[AssociateCode],[ICA],
				 [PriorityPassID],[CardholderName],[VisitDate],[LoungeName],[LoungeCode],
				 [ISOCountry],[MemberCount],[GuestCount],[TotalVisitCount],[Batch],
				 [VoucherNumber],[Currency],[TotalMemberFee],[TotalGuestFee],[TotalChargeableFee],
				 [TotalFreeGuest],[FreeGuestValue],[TotalChargeableGuest],[ChargeableGuestValue],
				 [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy])
	SELECT [BillingMonth],[Bank],[AssociatePrefix],[AssociateCode],[ICA],
		   [PriorityPassID],[CardholderName],[VisitDate],[LoungeName],[LoungeCode],
		   [ISOCountry],[MemberCount],[GuestCount],[TotalVisitCount],[Batch],
		   [VoucherNumber],[Currency],[TotalMemberFee],[TotalGuestFee],[TotalChargeableFee],
		   [TotalFreeGuest],[FreeGuestValue],[TotalChargeableGuest],[ChargeableGuestValue],
		   [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblDALoungeVisits
	WHERE [BillingMonth] BETWEEN  @StartDate AND @EndDate
	SET IDENTITY_INSERT mastercard_db.dbo.tblDALoungeVisits OFF
END;

----------- (Add) tblWLCIF -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblWLCIF WHERE [report_month] BETWEEN  @StartDate AND @EndDate)
IF @NumRecs > 0
	BEGIN;
		DISABLE TRIGGER [dbo].[trg_AutoAudit_tblWLCIF] ON [dbo].tblWLCIF; 
			DELETE from mastercard_db.dbo.tblWLCIF WHERE [report_month] BETWEEN  @StartDate AND @EndDate;
		ENABLE TRIGGER [dbo].[trg_AutoAudit_tblWLCIF] ON [dbo].tblWLCIF; 
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblWLCIF ON
	INSERT INTO mastercard_db.dbo.tblWLCIF
				([report_month],[mci_region],[country],[bank],[associate_prefix],
				 [deal_type],[total],
				 [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy])
	SELECT [report_month],[mci_region],[country],[bank],[associate_prefix],
		   [deal_type],[total],
		   [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy] 
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblWLCIF
	WHERE [report_month] BETWEEN  @StartDate AND @EndDate
	SET IDENTITY_INSERT mastercard_db.dbo.tblWLCIF OFF
END;

----------- (Add) tblWLLoungeVisits -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblWLLoungeVisits WHERE [BillingMonth] BETWEEN  @StartDate AND @EndDate)
IF @NumRecs > 0
	BEGIN;
		DISABLE TRIGGER [dbo].[trg_AutoAudit_tblWLLoungeVisits] ON [dbo].tblWLLoungeVisits; 
			DELETE from mastercard_db.dbo.tblWLLoungeVisits WHERE [BillingMonth] BETWEEN  @StartDate AND @EndDate;
		ENABLE TRIGGER [dbo].[trg_AutoAudit_tblWLLoungeVisits] ON [dbo].tblWLLoungeVisits; 
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblWLLoungeVisits ON
	INSERT INTO mastercard_db.dbo.tblWLLoungeVisits
				([BillingMonth],[Member No],[Cardholder Name],[Tier],[Paid To Date],
				 [Visit Date],[Date Processed],[Total Guests],[Visit Fees],[Batch No],
				 [Reference],[Member Status],[LoungeCode],[Lounge],[Airport],[Cost Centre],
				 [Campaign Code],[Total FREE Guests],[FREE Guests Value],[Total Chargeable Guests],
				 [Chargeable Guest Value],[Vendor Code],[User Invitation Code],[Currency],[SourceCode],
				 [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy])
	SELECT [BillingMonth],[Member No],[Cardholder Name],[Tier],[Paid To Date],
		   [Visit Date],[Date Processed],[Total Guests],[Visit Fees],[Batch No],
		   [Reference],[Member Status],[LoungeCode],[Lounge],[Airport],[Cost Centre],
		   [Campaign Code],[Total FREE Guests],[FREE Guests Value],[Total Chargeable Guests],
		   [Chargeable Guest Value],[Vendor Code],[User Invitation Code],[Currency],[SourceCode],
		   [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblWLLoungeVisits
	WHERE [BillingMonth] BETWEEN  @StartDate AND @EndDate
	SET IDENTITY_INSERT mastercard_db.dbo.tblWLLoungeVisits OFF
END;	

------------- (Add) tblWLLoungeVisits_VA -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblWLLoungeVisits_VA WHERE [report_month] BETWEEN  @StartDate AND @EndDate)
IF @NumRecs > 0
	BEGIN;
		DISABLE TRIGGER [dbo].[trg_AutoAudit_tblWLLoungeVisits_VA] ON [dbo].tblWLLoungeVisits_VA; 
			DELETE from mastercard_db.dbo.tblWLLoungeVisits_VA WHERE [report_month] BETWEEN  @StartDate AND @EndDate;
		ENABLE TRIGGER [dbo].[trg_AutoAudit_tblWLLoungeVisits_VA] ON [dbo].tblWLLoungeVisits_VA; 
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
				 [campaign_code],[vendor_code],[user_invitation_code],
				 [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy])
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
		   [campaign_code],[vendor_code],[user_invitation_code],
		   [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblWLLoungeVisits_VA
	WHERE [report_month] BETWEEN  @StartDate AND @EndDate
	SET IDENTITY_INSERT mastercard_db.dbo.tblWLLoungeVisits_VA OFF
END;	

----------- (Add) tblWSCIF -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblWSCIF WHERE [report_month] BETWEEN  @StartDate AND @EndDate)
IF @NumRecs > 0
	BEGIN;
		DISABLE TRIGGER [dbo].[trg_AutoAudit_tblWSCIF] ON [dbo].tblWSCIF; 
			DELETE from mastercard_db.dbo.tblWSCIF WHERE [report_month] BETWEEN  @StartDate AND @EndDate;
		ENABLE TRIGGER [dbo].[trg_AutoAudit_tblWSCIF] ON [dbo].tblWSCIF; 
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblWSCIF ON
	INSERT INTO mastercard_db.dbo.tblWSCIF
				([report_month],[mci_region],[country],[bank],[associate_prefix],
				 [deal_type],[total],
				 [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy])
	SELECT [report_month],[mci_region],[country],[bank],[associate_prefix],
		   [deal_type],[total],
		   [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblWSCIF
	WHERE [report_month] BETWEEN  @StartDate AND @EndDate
	SET IDENTITY_INSERT mastercard_db.dbo.tblWSCIF OFF
END;	

----- (Add) tblWSLoungeVisits -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblWSLoungeVisits WHERE [BillingMonth] BETWEEN  @StartDate AND @EndDate)
IF @NumRecs > 0
	BEGIN;
		DISABLE TRIGGER [dbo].[trg_AutoAudit_tblWSLoungeVisits] ON [dbo].tblWSLoungeVisits; 
			DELETE from mastercard_db.dbo.tblWSLoungeVisits WHERE [BillingMonth] BETWEEN  @StartDate AND @EndDate;
		ENABLE TRIGGER [dbo].[trg_AutoAudit_tblWSLoungeVisits] ON [dbo].tblWSLoungeVisits; 
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblWSLoungeVisits ON;
	INSERT INTO mastercard_db.dbo.tblWSLoungeVisits
				([tbl_index], [BillingMonth],[Item],[Bank],[Deal Type],[Associate_Prefix],
				 [AssociateCode],[ICA],[Priority Pass Id],[Cardholder Name],[Visit],
				 [Lounge Name],[LoungeCode],[DomesticInt],[ISO Country],[VisitCountryISO],
				 [MembersCount],[GuestsCount],[TotalVisitCount],[Batch],[Voucher Number],
				 [MCBillingRegionofIssue],[Currency],[FeePerMember],[TotalGuestFee],[TotalFee],
				 [TotalFreeGuests],[FreeGuestsValue],[TotalChargableGuests],[ChargableGuestsValue],
				 [ActualBillingRegion],[BankInvoiceCurrency],[BankInvoiceFee],[CardMemberInvoiceCurrency]
				 ,[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy])
	SELECT [tbl_index],[BillingMonth],[Item],[Bank],[Deal Type],[Associate_Prefix],
		   [AssociateCode],[ICA],[Priority Pass Id],[Cardholder Name],[Visit],
		   [Lounge Name],[LoungeCode],[DomesticInt],[ISO Country],[VisitCountryISO],
		   [MembersCount],[GuestsCount],[TotalVisitCount],[Batch],[Voucher Number],
		   [MCBillingRegionofIssue],[Currency],[FeePerMember],[TotalGuestFee],[TotalFee],
		   [TotalFreeGuests],[FreeGuestsValue],[TotalChargableGuests],[ChargableGuestsValue],
		   [ActualBillingRegion],[BankInvoiceCurrency],[BankInvoiceFee],[CardMemberInvoiceCurrency],
		   [UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblWSLoungeVisits
	WHERE [BillingMonth] BETWEEN  @StartDate AND @EndDate
	SET IDENTITY_INSERT mastercard_db.dbo.tblWSLoungeVisits OFF
END;	

----------- (Add) tblLKCIF ----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblLKCIF)
IF @NumRecs > 0
	BEGIN;
		DISABLE TRIGGER [dbo].[trg_AutoAudit_tblLKCIF] ON [dbo].tblLKCIF; 
			TRUNCATE TABLE mastercard_db.dbo.tblLKCIF;
		ENABLE TRIGGER [dbo].[trg_AutoAudit_tblLKCIF] ON [dbo].tblLKCIF;			
	END

BEGIN		
	SET IDENTITY_INSERT mastercard_db.dbo.tblLKCIF ON
	INSERT INTO mastercard_db.dbo.tblLKCIF
				([report_month],[billing_month],[client_id],[source_code],[bin],
				 [currency],[monthly_unit_price],[total],
				 [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy])
	SELECT [report_month],[billing_month],[client_id],[source_code],[bin],
		   [currency],[monthly_unit_price],[total],
		   [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblLKCIF
	SET IDENTITY_INSERT mastercard_db.dbo.tblLKCIF OFF
END;	




--------------- (Add) tblLKLoungeVisits -----------------
SET @NumRecs = (select count(*) from mastercard_db.dbo.tblLKLoungeVisits WHERE [report_month] BETWEEN  @StartDate AND @EndDate)
IF @NumRecs > 0
	BEGIN;
		DISABLE TRIGGER [dbo].[trg_AutoAudit_tblLKLoungeVisits] ON [dbo].tblLKLoungeVisits; 
			DELETE from mastercard_db.dbo.tblLKLoungeVisits WHERE [report_month] BETWEEN  @StartDate AND @EndDate;
		ENABLE TRIGGER [dbo].[trg_AutoAudit_tblLKLoungeVisits] ON [dbo].tblLKLoungeVisits; 
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
				 [campaign_code],[vendor_code],[user_invitation_code],--[credit_card_number],                -- blanked out cc
				 [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy],
				 [Terminal], [international_or_domestic], [experience_type], [experience_category])
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
		   [campaign_code],[vendor_code],[user_invitation_code],--[credit_card_number],              -- Blanked out cc
		   [tbl_index],[UpdatedDate],[UpdatedBy],[CreatedDate],[CreatedBy],
		   [Terminal], [international_or_domestic], [experience_type], [experience_category]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblLKLoungeVisits
	WHERE [report_month] BETWEEN  @StartDate AND @EndDate
	SET IDENTITY_INSERT mastercard_db.dbo.tblLKLoungeVisits OFF

END;

--------------- (Add)[tblWLMemberships_Prepaid]  -----------------

SET @NumRecs = (select count(*) from [mastercard_db].[dbo].[tblWLMemberships_Prepaid] WHERE [billing_month] BETWEEN  @StartDate AND @EndDate)
IF @NumRecs > 0
	BEGIN;
		--DISABLE TRIGGER [trg_AutoAudit_tblWLMemberships_Prepaid] ON [dbo].[tblWLMemberships_Prepaid]; 
			DELETE from [mastercard_db].[dbo].[tblWLMemberships_Prepaid] WHERE [billing_month] BETWEEN  @StartDate AND @EndDate;
		--ENABLE TRIGGER [trg_AutoAudit_tblWLMemberships_Prepaid] ON [dbo].[tblWLMemberships_Prepaid]; 
	END
	
BEGIN	
	SET IDENTITY_INSERT [mastercard_db].[dbo].[tblWLMemberships_Prepaid] ON

	INSERT INTO [mastercard_db].[dbo].[tblWLMemberships_Prepaid]
				([tbl_index],[billing_month],[client_id],[source_code],[mc_ica],[activity_code],
				[po_number],[glac_code],[type_code_fk],[validity],[current_validity_year],[service_centre],
				[currency],[unit_price],[prepaid_quantity],[amount_billed],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy])
	SELECT	[tbl_index],[billing_month],[client_id],[source_code],[mc_ica],[activity_code],[po_number]
			,[glac_code],[type_code_fk],[validity],[current_validity_year],[service_centre],[currency]
			,[unit_price],[prepaid_quantity],[amount_billed],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy]
   FROM [127.0.0.1,41331].[mastercard_db].[dbo].[tblWLMemberships_Prepaid]
   WHERE [billing_month] BETWEEN @StartDate AND @EndDate
  SET IDENTITY_INSERT [mastercard_db].[dbo].[tblWLMemberships_Prepaid] OFF
END;
