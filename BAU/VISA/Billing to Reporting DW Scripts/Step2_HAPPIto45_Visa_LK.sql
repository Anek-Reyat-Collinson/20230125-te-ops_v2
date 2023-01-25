/*******************************************************************************************************************************
** Project ID	 : Step 2 LK
** Author        : Hyun
** Amend History : GM 23/03/2016 Changes to 127.0.0.1,41331
				 : Mahesh Chittigari 19/06/2018 Added External Identifier 
				 : Mahesh Chittigari 18/02/2018 Client2Pay columns -- BIBAU-2240
** Run history   :	
					HD 20/07/2020 Ran successfully for month = 2020-06-01
					HD 17/08/2020 Ran successfully for month = 2020-07-01
					HD 17/09/2020 Ran successfully for month = 2020-08-01
					HD 16/10/2020 Ran successfully for month = 2020-09-01
					HD 17/11/2020 Ran successfully for month = 2020-10-01
					HD 15/12/2020 Ran successfully for month = 2020-11-01
					HD 18/01/2021 Ran successfully for month = 2020-11-01   ---DI-907
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
					HD 15/07/2022 Ran successfully for month = 2021-09-01 OPSBI-118
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

----------------------------------------------------------------------------------------------

----------------- (Add New Records) tblLKCIFRaw ----------------- 09;
DISABLE TRIGGER [dbo].[trg_AutoAudit_tblLKCIFRaw] ON [dbo].tblLKCIFRaw;
	DELETE FROM visa_db.dbo.tblLKCIFRaw WHERE [ReportMonth] = @billingmonth;
ENABLE TRIGGER [dbo].[trg_AutoAudit_tblLKCIFRaw] ON [dbo].tblLKCIFRaw;

--SET IDENTITY_INSERT visa_db.dbo.tblLKCIFRaw ON;

	INSERT INTO visa_db.dbo.tblLKCIFRaw
		([ReportMonth],[ClientID],[SourceCode],[ConsumerNo],[PTD],--[CreditCardNo], blank cc
		[Title],[FirstName],[LastName],
		[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[external_identifier])
	SELECT 
		[ReportMonth],[ClientID],[SourceCode],[ConsumerNo],[PTD],--[CreditCardNo], blank cc
		[Title],[FirstName],[LastName],
		[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[external_identifier]
	FROM [10.204.200.112\OPSLIVEDB,49214].visa_db.dbo.tblLKCIFRaw
	WHERE  [ReportMonth] = @billingmonth;

--SET IDENTITY_INSERT visa_db.dbo.tblLKCIFRaw OFF;


----------------- (Add New Records) tblLKLoungeVisits -----------------
DISABLE TRIGGER [dbo].[trg_AutoAudit_tblLKLoungeVisits] ON [dbo].tblLKLoungeVisits;
	DELETE FROM visa_db.dbo.tblLKLoungeVisits WHERE [ReportMonth] = @billingmonth;
ENABLE TRIGGER [dbo].[trg_AutoAudit_tblLKLoungeVisits] ON [dbo].tblLKLoungeVisits;

--SET IDENTITY_INSERT visa_db.dbo.tblLKLoungeVisits ON;

	INSERT INTO visa_db.dbo.tblLKLoungeVisits
		([ReportMonth],[ClientID],[ConsumerNo],[Title],[FirstName],[LastName],[CurrentPTD],
		 [CurrentStatus],[SourceCode],[VisitDate],[ProcessedDate],[Batch],[Reference],[LoungeCode],
		 [LoungeName],[LoungeCity],[LoungeCountry],[ClientPayMemberVisit],[CMPayMemberVisit],
		 [ComplimentaryMemberVisit],[TotalMemberVisit],[ClientPayGuestVisit],[CMPayGuestVisit],
		 [LoungeOfferGuestVisit],[ComplimentaryGuestVisit],[TotalGuestVisit],[ClientPayMemberVisitCurrency],
		 [ClientPayMemberVisitFre],[ClientPayGuestVisitCurrency],[ClientPayGuestVisitFee],
		 [CMPayMemberVisitCurrency],[CMPayMemberVisitFee],[CMPayGuestVisitCurrency],[CMPayGuestVisitFee],
		 [CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[InclusivePPMemberVisit],[InclusivePPGuestVisit],[external_identifier],
		 [Client2PayMemberVisit],[Client2PayGuestVisit],[Client2PayMemberVisitCurrency],[Client2PayMemberVisitFee],
		 [Client2PayGuestVisitCurrency],[Client2PayGuestVisitFee])
	SELECT [ReportMonth],[ClientID],[ConsumerNo],[Title],[FirstName],[LastName],[CurrentPTD],
		[CurrentStatus],[SourceCode],[VisitDate],[ProcessedDate],[Batch],[Reference],[LoungeCode],
		[LoungeName],[LoungeCity],[LoungeCountry],[ClientPayMemberVisit],[CMPayMemberVisit],
		[ComplimentaryMemberVisit],[TotalMemberVisit],[ClientPayGuestVisit],[CMPayGuestVisit],
		[LoungeOfferGuestVisit],[ComplimentaryGuestVisit],[TotalGuestVisit],[ClientPayMemberVisitCurrency],
		[ClientPayMemberVisitFre],[ClientPayGuestVisitCurrency],[ClientPayGuestVisitFee],
		[CMPayMemberVisitCurrency],[CMPayMemberVisitFee],[CMPayGuestVisitCurrency],[CMPayGuestVisitFee],
		[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[InclusivePPMemberVisit],[InclusivePPGuestVisit],[external_identifier],
		[Client2PayMemberVisit],[Client2PayGuestVisit],[Client2PayMemberVisitCurrency],[Client2PayMemberVisitFee],
		[Client2PayGuestVisitCurrency],[Client2PayGuestVisitFee]
	FROM [10.204.200.112\OPSLIVEDB,49214].visa_db.dbo.tblLKLoungeVisits
	WHERE  [ReportMonth] = @billingmonth;

--SET IDENTITY_INSERT visa_db.dbo.tblLKLoungeVisits OFF;


----------------- (Add New Records) tblLKMembership -----------------
DISABLE TRIGGER [dbo].[trg_AutoAudit_tblLKMembership] ON [dbo].tblLKMembership;
	DELETE FROM visa_db.dbo.tblLKMembership WHERE [ReportMonth] = @billingmonth;
ENABLE TRIGGER [dbo].[trg_AutoAudit_tblLKMembership] ON [dbo].tblLKMembership;

--SET IDENTITY_INSERT visa_db.dbo.tblLKMembership ON;

	INSERT INTO visa_db.dbo.tblLKMembership
		([ReportMonth],[ClientID],[SourceCode],[ConsumerNo],--[CreditCardNo], blank cc
		[Title],
		[FirstName],[LastName],[ActivityCode],[Amount],
		[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[external_identifier])
	SELECT 
		[ReportMonth],[ClientID],[SourceCode],[ConsumerNo],--[CreditCardNo], blank cc
		[Title],
		[FirstName],[LastName],[ActivityCode],[Amount],
		[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[external_identifier]
	FROM [10.204.200.112\OPSLIVEDB,49214].visa_db.dbo.tblLKMembership
	WHERE  [ReportMonth] = @billingmonth

--SET IDENTITY_INSERT visa_db.dbo.tblLKMembership OFF;
