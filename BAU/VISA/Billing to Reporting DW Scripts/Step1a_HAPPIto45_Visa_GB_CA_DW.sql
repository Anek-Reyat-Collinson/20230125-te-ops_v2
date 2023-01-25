/*******************************************************************************************************************************
** Project ID	 : Step 1 Visa Data (Global and Approved) Transfer from HAPPI to .45 
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
					HD 18/01/2021 Ran successfully for month = 2020-11-01  --DI-907
					HD 18/01/2021 Ran successfully for month = 2020-12-01
					HD 16/02/2021 Ran successfully for month = 2021-01-01
					HD 15/03/2021 Ran successfully for month = 2021-02-01
					HD 15/03/2021 Ran successfully for month = 2020-02-01- Nov 20 BIBAU-2735
					HD 15/03/2021 Ran successfully for month = 2020-03-01- Dec 20 BIBAU-2735
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


----------------- (Replace) tblsalesorders -----------------
DISABLE TRIGGER [dbo].[trg_AutoAudit_tblsalesorders] ON [dbo].tblsalesorders;
	DELETE FROM visa_db.dbo.tblsalesorders;
ENABLE TRIGGER [dbo].[trg_AutoAudit_tblsalesorders] ON [dbo].tblsalesorders;
	
SET IDENTITY_INSERT visa_db.dbo.tblsalesorders ON;

	INSERT INTO visa_db.dbo.tblsalesorders
		([client_id],[sales_order_number],[sales_order_date],[card_type],[card_sub_type],[bank],[invoice_number]
		,[status],[invoice_date],[stock_sent_date],[sales_type],[free_visit_allocation],[validity],[remarks]
		,[quantity_billed],[quantity_sent],[currency],[unit_price],[freight],[bill_amount],[invoice_month]
		,[budget_month_year],[region],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[tbl_index])
	SELECT 
		[client_id],[sales_order_number],[sales_order_date],[card_type],[card_sub_type],[bank],[invoice_number]
		,[status],[invoice_date],[stock_sent_date],[sales_type],[free_visit_allocation],[validity],[remarks]
		,[quantity_billed],[quantity_sent],[currency],[unit_price],[freight],[bill_amount],[invoice_month]
		,[budget_month_year],[region],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[tbl_index]
	FROM [10.204.200.112\OPSLIVEDB,49214].visa_db.dbo.tblsalesorders;

SET IDENTITY_INSERT visa_db.dbo.tblsalesorders OFF;

----------------- (Add New Records) tblfva -----------------
DISABLE TRIGGER [dbo].[trg_AutoAudit_tblfva] ON [dbo].tblfva;
	DELETE FROM visa_db.dbo.tblfva WHERE report_month = @billingmonth;
ENABLE TRIGGER [dbo].[trg_AutoAudit_tblfva] ON [dbo].tblfva;
	
SET IDENTITY_INSERT visa_db.dbo.tblfva ON;

	INSERT INTO visa_db.dbo.tblfva
		([report_month],[client_id],[so_no],[bank],[stock_sent_date],[fva_expiry_date],[memberships],[fva_allowed]
		,[used_fva],[valid_fva],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[tbl_index])
	SELECT 
		[report_month],[client_id],[so_no],[bank],[stock_sent_date],[fva_expiry_date],[memberships],[fva_allowed]
		,[used_fva],[valid_fva],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[tbl_index]	
	FROM [10.204.200.112\OPSLIVEDB,49214].visa_db.dbo.tblfva 
	WHERE report_month = @billingmonth;

SET IDENTITY_INSERT visa_db.dbo.tblfva OFF;

----------------- (Add New Records) tblcif -----------------
DISABLE TRIGGER [dbo].[trg_AutoAudit_tblcif] ON [dbo].tblcif;
	DELETE FROM visa_db.dbo.tblcif WHERE reportmonth = @billingmonth;
ENABLE TRIGGER [dbo].[trg_AutoAudit_tblcif] ON [dbo].tblcif;

SET IDENTITY_INSERT visa_db.dbo.tblcif ON;

	INSERT INTO visa_db.dbo.tblcif
		([ReportMonth],[Region],[Prefix],[Country],[Bank],[CardType],[CIF]
		,[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[tbl_index])
	SELECT 
		[ReportMonth],[Region],[Prefix],[Country],[Bank],[CardType],[CIF]
		,[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[tbl_index]
	FROM [10.204.200.112\OPSLIVEDB,49214].visa_db.dbo.tblcif 
	WHERE reportmonth = @billingmonth;

SET IDENTITY_INSERT visa_db.dbo.tblcif OFF;
	

----------------- (Add New Records) tblcacif -----------------
DISABLE TRIGGER [dbo].[trg_AutoAudit_tblcacif] ON [dbo].tblcacif;
	DELETE FROM visa_db.dbo.tblcacif WHERE reportmonth = @billingmonth;
ENABLE TRIGGER [dbo].[trg_AutoAudit_tblcacif] ON [dbo].tblcacif;

SET IDENTITY_INSERT visa_db.dbo.tblcacif  ON;

	INSERT INTO visa_db.dbo.tblcacif 
		([ReportMonth],Region,[Prefix],[CIF],[CreatedDate],[CreatedBy]
		,[UpdatedDate],[UpdatedBy],[tbl_index])
	SELECT 
		[ReportMonth],Region,[Prefix],[CIF],[CreatedDate],[CreatedBy]
		,[UpdatedDate],[UpdatedBy],[tbl_index]
	FROM [10.204.200.112\OPSLIVEDB,49214].visa_db.dbo.tblcacif 
	WHERE reportmonth = @billingmonth;

SET IDENTITY_INSERT visa_db.dbo.tblcacif  OFF;

----------------- (Add New Records) tblloungevisits -----------------
DISABLE TRIGGER [dbo].[trg_AutoAudit_tblloungevisits] ON [dbo].tblloungevisits;
	DELETE FROM visa_db.dbo.tblloungevisits WHERE  report_month = @billingmonth;
ENABLE TRIGGER [dbo].[trg_AutoAudit_tblloungevisits] ON [dbo].tblloungevisits;

--SET IDENTITY_INSERT visa_db.dbo.tblloungevisits ON;

	INSERT INTO visa_db.dbo.tblloungevisits
		([clientid],[report_month],[item],[priority_pass_id],[cardholder_name],[visit_date]
		,[lounge_code],[lounge_name],[country],[member],[guests],[total],[fva],[fva_value],[member_fee]
		,[guest_fee],[total_fee],[batch],[voucher_number],[free_guests],[free_guests_value],[total_chargeable_guests]
		,[chargeable_guest_value],[region],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[external_identifier])
	SELECT 
		[clientid],[report_month],[item],[priority_pass_id],[cardholder_name],[visit_date]
		,[lounge_code],[lounge_name],[country],[member],[guests],[total],[fva],[fva_value],[member_fee]
		,[guest_fee],[total_fee],[batch],[voucher_number],[free_guests],[free_guests_value],[total_chargeable_guests]
		,[chargeable_guest_value],[region],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[external_identifier]		 
	FROM [10.204.200.112\OPSLIVEDB,49214].visa_db.dbo.tblloungevisits
	WHERE  report_month = @billingmonth;

--SET IDENTITY_INSERT visa_db.dbo.tblloungevisits OFF;

----------------- (Add New Records) tblcaloungevisits -----------------
DISABLE TRIGGER [dbo].[trg_AutoAudit_tblcaloungevisits] ON [dbo].tblcaloungevisits;
	DELETE FROM visa_db.dbo.tblcaloungevisits WHERE  report_month = @billingmonth;
ENABLE TRIGGER [dbo].[trg_AutoAudit_tblcaloungevisits] ON [dbo].tblcaloungevisits;

--SET IDENTITY_INSERT visa_db.dbo.tblcaloungevisits ON;

	INSERT INTO visa_db.dbo.tblcaloungevisits
		([report_month],[clientid],[item],[priority_pass_id],[cardholder_name],[visit_date],[lounge_code]
		,[lounge_name],[country],[member],[guests],[total],[member_fee],[guest_fee],[total_fee],[batch]
		,[voucher_number],[free_guests],[free_guests_value],[total_chargeable_guests],[chargeable_guest_value],Region
		,[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[external_identifier])
	SELECT 
		[report_month],[clientid],[item],[priority_pass_id],[cardholder_name],[visit_date],[lounge_code]
		,[lounge_name],[country],[member],[guests],[total],[member_fee],[guest_fee],[total_fee],[batch]
		,[voucher_number],[free_guests],[free_guests_value],[total_chargeable_guests],[chargeable_guest_value],Region
		,[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[external_identifier]
	FROM [10.204.200.112\OPSLIVEDB,49214].visa_db.dbo.tblcaloungevisits
	WHERE  report_month = @billingmonth;

--SET IDENTITY_INSERT visa_db.dbo.tblcaloungevisits OFF;
	

