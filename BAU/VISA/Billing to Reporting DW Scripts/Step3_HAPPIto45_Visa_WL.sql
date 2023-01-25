/*******************************************************************************************************************************
** Project ID	 :  Step 3 Visa Data (Wholesale) Transfer from HAPPI to .45
** Author        : Hyun
** Amend History : GM 23/03/2016 Changes to 127.0.0.1,41331
				 : Mahesh Chittigari 19/06/2018 Added External Identifier 
** Run history   :	
					HD 20/07/2020 Ran successfully for month = 2020-06-01
					HD 17/08/2020 Ran successfully for month = 2020-07-01
					HD 17/09/2020 Ran successfully for month = 2020-08-01
					HD 16/10/2020 Ran successfully for month = 2020-09-01
					HD 17/11/2020 Ran successfully for month = 2020-10-01
					HD 15/12/2020 Ran successfully for month = 2020-11-01
					HD 18/01/2021 Ran successfully for month = 2020-11-01   --- DI-907
					HD 18/01/2021 Ran successfully for month = 2020-12-01
					HD 16/02/2021 Ran successfully for month = 2021-01-01
					HD 15/03/2021 Ran successfully for month = 2021-02-01
					HD 15/03/2021 Ran successfully for month = 2020-11-01- Nov 20 BIBAU-2735
					HD 15/03/2021 Ran successfully for month = 2020-12-01- Dec 20 BIBAU-2735
					HD 16/04/2021 Ran successfully for month = 2021-03-01
					HD 14/05/2021 Ran successfully for month = 2021-04-01
					HD 17/05/2021 Ran successfully for month = 2021-01-01 - OPSBI-12
					HD 17/05/2021 Ran successfully for month = 2021-02-01 - OPSBI-12
					HD 18/06/2021 Ran successfully for month = 2021-05-01
					HD 19/07/2021 Ran successfully for month = 2021-06-01
					HD 19/07/2021 Ran successfully for month = 2021-04-01 - OPSBI-62
					HD 19/07/2021 Ran successfully for month = 2021-05-01 - OPSBI-62
					HD 13/08/2021 Ran successfully for month = 2021-07-01
					HD 25/08/2021 Ran successfully for month = 2021-06-01 - OPSBI-69
					HD 15/09/2021 Ran successfully for month = 2021-08-01
					HD 18/10/2021 Ran successfully for month = 2021-09-01
					HD 12/11/2021 Ran successfully for month = 2021-10-01
					HD 16/12/2021 Ran successfully for month = 2021-11-01
					HD 19/01/2022 Ran successfully for month = 2021-12-01
					HD 16/02/2022 Ran successfully for month = 2022-01-01
					HD 18/03/2022 Ran successfully for month = 2022-02-01
					HD 20/04/2022 Ran successfully for month = 2022-03-01
					HD 20/04/2022 Ran successfully for month = 2021-12-01 - OPSBI-118
					HD 20/04/2022 Ran successfully for month = 2022-01-01 - OPSBI-118
					HD 17/05/2022 Ran successfully for month = 2022-04-01
					HD 18/05/2022 Ran successfully for month = 2021-10-01 - OPSBI-118
					HD 18/05/2022 Ran successfully for month = 2021-11-01 - OPSBI-118
					HD 20/06/2022 Ran successfully for month = 2022-05-01
					HD 15/07/2022 Ran successfully for month = 2022-06-01
					HD 15/07/2022 Ran successfully for month = 2021-09-01 - OPSBI-118
					HD 17/08/2022 Ran successfully for month = 2022-07-01
					HD 19/08/2022 Ran successfully for month = 2022-07-01
					HD 19/08/2022 Ran successfully for month = 2022-02-01
					HD 20/09/2022 Ran successfully for month = 2022-08-01
					HD 17/10/2022 Ran successfully for month = 2022-09-01
					HD 07/11/2022 Ran successfully for month = 2022-03-01 OPSBI-145
					HD 07/11/2022 Ran successfully for month = 2022-04-01 OPSBI-145
					HD 09/11/2022 Ran successfully for month = 2022-05-01 OPSBI-145
					HD 09/11/2022 Ran successfully for month = 2022-06-01 OPSBI-145
					HD 09/11/2022 Ran successfully for month = 2022-07-01 OPSBI-145
					HD 09/11/2022 Ran successfully for month = 2022-08-01 OPSBI-145
					HD 09/11/2022 Ran successfully for month = 2022-09-01 OPSBI-145
					HD 17/11/2022 Ran successfully for month = 2022-10-01
					HD 18/12/2022 Ran successfully for month = 2022-11-01
					
********************************************************************************************************************************/

----------------------------------- Query Configuration  -------------------------------------
USE visa_db
GO

DECLARE @billingmonth AS DATE
SET @billingmonth = '2022-11-01';

--SELECT * FROM visa_db.dbo.tblWLCIF WHERE  [ReportMonth] = @billingmonth
--SELECT * FROM [visa_db].[dbo].[tblWLLoungeVisits] WHERE  [BillingMonth] = @billingmonth

----------------------------------------------------------------------------------------------

----------------- (Add New Records) tblWLCIF -----------------

DISABLE TRIGGER [dbo].[trg_AutoAudit_tblWLCIF] ON [dbo].tblWLCIF; 
	DELETE FROM [visa_db].[dbo].[tblWLCIF] WHERE ReportMonth = @billingmonth;
ENABLE TRIGGER [dbo].[trg_AutoAudit_tblWLCIF] ON [dbo].tblWLCIF; 	

--SET IDENTITY_INSERT visa_db.dbo.tblWLCIF ON;

	INSERT INTO visa_db.dbo.tblWLCIF
		([ReportMonth],[Region],[Prefix],[Country],[Bank],[CIF],
		[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy])
	SELECT 
		[ReportMonth],[Region],[Prefix],[Country],[Bank],[CIF],
		[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy]
	FROM [10.204.200.112\OPSLIVEDB,49214].visa_db.dbo.tblWLCIF
	WHERE  [ReportMonth] = @billingmonth;

--SET IDENTITY_INSERT visa_db.dbo.tblWLCIF OFF;


----------------- (Add New Records) tblWLLoungeVisits -----------------
DISABLE TRIGGER [dbo].[trg_AutoAudit_tblWLLoungeVisits] ON [dbo].tblWLLoungeVisits; 
	DELETE FROM [visa_db].[dbo].[tblWLLoungeVisits] WHERE BillingMonth = @billingmonth;
ENABLE TRIGGER [dbo].[trg_AutoAudit_tblWLLoungeVisits] ON [dbo].tblWLLoungeVisits; 
	
--SET IDENTITY_INSERT [visa_db].[dbo].[tblWLLoungeVisits] ON;

	INSERT INTO [visa_db].[dbo].[tblWLLoungeVisits]
		([BillingMonth],[SourceCode],[MemberNo],[Title],[FirstName],[LastName],[MembershipPlan],[MemberStatus],[PaidToDate]
		,[VisitDate],[DateProcessed],[GuestVisits],[BatchNo],[Reference],[LoungeCode],[Lounge],[Airport],[City],[Country]
		,[ClientPaysMemberVisit],[InclusivePPMemberVisit],[ComplimentaryMemberVisit],[CardholderPaysMemberVisit]
		,[ClinetPaysGuestVisit],[InclusivePPGuestVisit],[ComplimentaryGuestVisit],[CardholderPaysGuestVisit]
		,[LoungeVisitOffer],[ClientVisitCurrencyMember],[ClientVisitAmountMember],[ClientVisitCurrencyGuest]
		,[ClientVisitAmountGuest],[TotalClientAmountCurrency],[TotalClientAmount],[CardholderVisitCurrencyMember]
		,[CardholderVisitAmountMember],[CardholderVisitCurrencyGuest],[CardholderVisitAmountGuest],[TotalCardholderAmountCurrency]
		,[TotalCardholderAmount],[CostCentre],[CampaignCode],[VendorCode],[UserInvitationCode]
		,[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[external_identifier])
	SELECT 
		[BillingMonth],[SourceCode],[MemberNo],[Title],[FirstName],[LastName],[MembershipPlan],[MemberStatus],[PaidToDate]
		,[VisitDate],[DateProcessed],[GuestVisits],[BatchNo],[Reference],[LoungeCode],[Lounge],[Airport],[City],[Country]
		,[ClientPaysMemberVisit],[InclusivePPMemberVisit],[ComplimentaryMemberVisit],[CardholderPaysMemberVisit]
		,[ClinetPaysGuestVisit],[InclusivePPGuestVisit],[ComplimentaryGuestVisit],[CardholderPaysGuestVisit]
		,[LoungeVisitOffer],[ClientVisitCurrencyMember],[ClientVisitAmountMember],[ClientVisitCurrencyGuest]
		,[ClientVisitAmountGuest],[TotalClientAmountCurrency],[TotalClientAmount],[CardholderVisitCurrencyMember]
		,[CardholderVisitAmountMember],[CardholderVisitCurrencyGuest],[CardholderVisitAmountGuest],[TotalCardholderAmountCurrency]
		,[TotalCardholderAmount],[CostCentre],[CampaignCode],[VendorCode],[UserInvitationCode]
		,[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[external_identifier]
	FROM [10.204.200.112\OPSLIVEDB,49214].[visa_db].[dbo].[tblWLLoungeVisits]
	WHERE BillingMonth = @billingmonth

--SET IDENTITY_INSERT [visa_db].[dbo].[tblWLLoungeVisits] OFF;
	