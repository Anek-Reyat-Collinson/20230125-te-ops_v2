/*******************************************************************************************************************************
** Project ID	 : MasterCard Memberships Data Transfer from HAPPI to .45 Step 4
** Author        : Hyun
** Last Mofified : 2016-03-17
** Amend History : GM 17/03/2016 Changes to use 127.0.0.1,41331
** Amend History : AE 13/09/2016 Added date range parameter
				   AE 11/04/2017 Added new columms to all memberships tables and added new script for tblWSMemberships

** Run history   :	GM 17/03/2016 Ran successfully for Feb data
					GM 19/04/2016 Ran successfully for Mar data
					GM 16/05/2016 Ran successfully for Apr data
					GM 16/06/2016 Ran successfully for May data		
					GM 14/07/2016 Ran successfully for June data
					AE 12/08/2016 Ran successfully for July data	
					AE 22/09/2016 Ran successfully for August data	
					AE 20/10/2016 Ran successfully for September data					
					GM 14/11/2016 Ran successfully for October data	
					AE 15/12/2016 Ran successfully for November data
					AE 16/01/2017 Ran successfully for December data
					AE 17/02/2017 Ran successfully for Jan data
					AE 23/02/2017 ----- AE added new column callled Kit_includes to LK_Membership	
					VP 17/03/2017 Ran successfully for Feb data
					AE 22/03/2017 Ran successfully for Jan data - Re-Run tblmembership data for Jan 2017
					AE 13/04/2017 Ran successfully for Mar 2017 data
					VP 25/04/2017 Ran successfully for Mar 2017 data - Re - Run BI - 384
					VP 12/05/2017 Ran successfully for Apr 2017 data
					AE 13/06/2017 Ran successfully for May 2017 data
					AE 14/07/2017 Ran successfully for June 2017 data
					AE 11/08/2017 Ran successfully for July 2017 data
					VP 14/09/2017 Ran successfully for August 2017 data
					AA 13/10/2017 Ran successfully for September 2017 data
					AA 14/11/2017 Ran successfully for October 2017 data
					AA 12/12/2017 Ran successfully for November 2017 data
					AA 11/01/2018 Ran successfully for December 2017 data
					AA 12/02/2018 Ran successfully for Jan 2018 data
					AA 13/03/2018 Ran successfully for Feb 2018 data
					AA 13/04/2018 Ran successfully for mar 2018 data
*******************************************************************************************************************************/

----------------------------------- Query Configuration  -------------------------------------
USE mastercard_db
GO


DECLARE @NumRecs INT
DECLARE @StartDate AS DATE = '2018-03-01'
DECLARE @EndDate   AS DATE = '2018-03-01';

--select count(*) from mastercard_db.dbo.tblMemberships WHERE [billing_month] = @billingmonth
----------------------------------------------------------------------------------------------

------------- (Add) tblMemberships -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblMemberships WHERE [billing_month] BETWEEN  @StartDate AND @EndDate)
select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblMemberships'
		DELETE from mastercard_db.dbo.tblMemberships WHERE [billing_month] BETWEEN  @StartDate AND @EndDate
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblMemberships ON
	INSERT INTO mastercard_db.dbo.tblMemberships
				([table_index],[billing_month],[po_number],[so_no],[so_date],[deal_type],[prefix],
				 [bank],[invoice_no],[invoice_date],[sales_type],[kit_includes],[membership_pricing],
				 [validity],[current_validity_year],[quantity_billed],[unit_currency],[unit_price],
				 [bill_amount],[bill_freight],[bill_total],[remarks],[country],[mci_region],
				 [CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy]) 
	SELECT [table_index],[billing_month],[po_number],[so_no],[so_date],[deal_type],[prefix],
		   [bank],[invoice_no],[invoice_date],[sales_type],[kit_includes],[membership_pricing],
		   [validity],[current_validity_year],[quantity_billed],[unit_currency],[unit_price],
		   [bill_amount],[bill_freight],[bill_total],[remarks],[country],[mci_region],
		   [CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblMemberships
	WHERE [billing_month] BETWEEN  @StartDate AND @EndDate
	SET IDENTITY_INSERT mastercard_db.dbo.tblMemberships OFF
END;

----------------- (Add) tblDAMembership -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblDAMembership WHERE [billing_month] BETWEEN  @StartDate AND @EndDate)
select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblDAMembership'
		DELETE from mastercard_db.dbo.tblDAMembership WHERE [billing_month] BETWEEN  @StartDate AND @EndDate
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblDAMembership ON
	INSERT INTO mastercard_db.dbo.tblDAMembership
				([billing_month],[po_number],[so_no],[so_date],[deal_type],[prefix],[bank],[invoice_no],
				 [invoice_date],[sales_type],[kit_includes],[membership_pricing],
				 [validity],[current_membership_year],[quantity_billed],[unit_currency],[unit_price],
				 [bill_amount],[bill_freight],[bill_total],[remarks]
				 ,[tbl_index],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy])
	SELECT [billing_month],[po_number],[so_no],[so_date],[deal_type],[prefix],[bank],[invoice_no],
		   [invoice_date],[sales_type],[kit_includes],[membership_pricing],
		   [validity],[current_membership_year],[quantity_billed],[unit_currency],[unit_price],
		   [bill_amount],[bill_freight],[bill_total],[remarks]
		   ,[tbl_index],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblDAMembership
	WHERE [billing_month] BETWEEN  @StartDate AND @EndDate
	SET IDENTITY_INSERT mastercard_db.dbo.tblDAMembership OFF
END;
------------------- (Add) tblWLMemberships -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblWLMemberships WHERE [billing_month] BETWEEN  @StartDate AND @EndDate)
select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblWLMemberships'
		DELETE from mastercard_db.dbo.tblWLMemberships WHERE [billing_month] BETWEEN  @StartDate AND @EndDate
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblWLMemberships ON
	INSERT INTO mastercard_db.dbo.tblWLMemberships
				([billing_month],[client_id],[consumer_no],[activity_code],[currency],
				 [amount],[validity],[current_validity_year],[cost_centre],[group_code],
				 [vendor_code],[user_invitation_code],
				 [tbl_index],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],
				 [po_number],[glac_code],[type_code],[remarks] )
	SELECT [billing_month],[client_id],[consumer_no],[activity_code],[currency],
		   [amount],[validity],[current_validity_year],[cost_centre],[group_code],
		   [vendor_code],[user_invitation_code],
		   [tbl_index],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],
		   [po_number],[glac_code],[type_code],[remarks] 
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblWLMemberships
	WHERE [billing_month] BETWEEN  @StartDate AND @EndDate
	SET IDENTITY_INSERT mastercard_db.dbo.tblWLMemberships OFF
END;

------------------------AE 23/02/2017 ----- AE added new column callled Kit_includes to LK_Membership--------
----------------- (Add) tblLKMemberships -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblLKMemberships WHERE [billing_month] BETWEEN  @StartDate AND @EndDate)
select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblLKMemberships'
		DELETE from mastercard_db.dbo.tblLKMemberships WHERE [billing_month] BETWEEN  @StartDate AND @EndDate
	END

BEGIN		
	SET IDENTITY_INSERT mastercard_db.dbo.tblLKMemberships ON
	INSERT INTO mastercard_db.dbo.tblLKMemberships
				([report_month],[billing_month],[client_id],[source_code],[bin],
				 [so_no],[so_date],[invoice_no],[invoice_date],[sales_type],
				 [currency],[quantity],[unit_price],[total],[remarks],[kit_includes],
				 [tbl_index],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy])
	SELECT [report_month],[billing_month],[client_id],[source_code],[bin],
		   [so_no],[so_date],[invoice_no],[invoice_date],[sales_type],
		   [currency],[quantity],[unit_price],[total],[remarks],[kit_includes],
		   [tbl_index],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblLKMemberships
	WHERE [billing_month] BETWEEN  @StartDate AND @EndDate
	SET IDENTITY_INSERT mastercard_db.dbo.tblLKMemberships OFF
END	



----------------- (Add) tblWSMemberships -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblWSMemberships WHERE [billing_month] BETWEEN  @StartDate AND @EndDate)
select @NumRecs
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblWSMemberships'
		DELETE from mastercard_db.dbo.tblWSMemberships WHERE [billing_month] BETWEEN  @StartDate AND @EndDate
	END

BEGIN		
	SET IDENTITY_INSERT mastercard_db.dbo.tblWSMemberships ON
	INSERT INTO mastercard_db.dbo.tblWSMemberships
				([billing_month],[po_number],[so_no],[so_date],[prefix],[bank]
				,[invoice_no],[invoice_date],[date_sent],[sales_type],[kit_includes]
				,[coe],[validity],[current_validity_year],[invoice_to],[unit_currency]
				,[quantity_billed],[quantity_sent],[unit_price],[bill_amount],[bill_freight]
				,[bill_total],[remarks]
				,[tbl_index],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy])
	SELECT [billing_month],[po_number],[so_no],[so_date],[prefix],[bank]
		  ,[invoice_no],[invoice_date],[date_sent],[sales_type],[kit_includes]
		  ,[coe],[validity],[current_validity_year],[invoice_to],[unit_currency]
		  ,[quantity_billed],[quantity_sent],[unit_price],[bill_amount],[bill_freight]
		  ,[bill_total],[remarks]
		  ,[tbl_index],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblWSMemberships
	WHERE [billing_month] BETWEEN  @StartDate AND @EndDate
	SET IDENTITY_INSERT mastercard_db.dbo.tblWSMemberships OFF
END	


