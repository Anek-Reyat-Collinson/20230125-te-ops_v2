/*******************************************************************************************************************************
** Project ID	 : MasterCard Memberships Data Transfer from HAPPI to .45 Step 4
** Author        : Hyun
** Last Mofified : 2016-03-17
** Amend History : GM 17/03/2016 Changes to use 127.0.0.1,41331

** Run history   :	GM 17/03/2016 Ran successfully for Feb data
					GM 19/04/2016 Ran successfully for Mar data
					GM 16/05/2016 Ran successfully for Apr data
					GM 16/06/2016 Ran successfully for May data					
*******************************************************************************************************************************/

----------------------------------- Query Configuration  -------------------------------------
DECLARE @NumRecs INT
DECLARE @startMonth AS DATE
SET @startMonth = '2016-03-01'

DECLARE @endMonth AS DATE
SET @endMonth = '2016-03-01'
--select count(*) from mastercard_db.dbo.tblMemberships WHERE [billing_month] BETWEEN @startMonth AND @endMonth

----------------------------------------------------------------------------------------------

----------------- (Add) tblMemberships -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblMemberships WHERE [billing_month] BETWEEN @startMonth AND @endMonth)
select @NumRecs AS tblMemberships
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblMemberships'
		DELETE from mastercard_db.dbo.tblMemberships WHERE [billing_month] BETWEEN @startMonth AND @endMonth
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblMemberships ON
	INSERT INTO mastercard_db.dbo.tblMemberships
				([table_index],[billing_month],[po_number],[so_no],[deal_type],[prefix],
				 [bank],[invoice_no],[invoice_date],[sales_type],[kit_includes],[membership_pricing],
				 [validity],[current_validity_year],[quantity_billed],[unit_currency],[unit_price],
				 [bill_amount],[bill_freight],[bill_total],[country],[mci_region]) 
	SELECT [table_index],[billing_month],[po_number],[so_no],[deal_type],[prefix],
		   [bank],[invoice_no],[invoice_date],[sales_type],[kit_includes],[membership_pricing],
		   [validity],[current_validity_year],[quantity_billed],[unit_currency],[unit_price],
		   [bill_amount],[bill_freight],[bill_total],[country],[mci_region]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblMemberships
	WHERE [billing_month] BETWEEN @startMonth AND @endMonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblMemberships OFF
END

----------------- (Add) tblDAMembership -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblDAMembership WHERE [billing_month] BETWEEN @startMonth AND @endMonth)
select @NumRecs AS tblDAMembership
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblDAMembership'
		DELETE from mastercard_db.dbo.tblDAMembership WHERE [billing_month] BETWEEN @startMonth AND @endMonth
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblDAMembership ON
	INSERT INTO mastercard_db.dbo.tblDAMembership
				([billing_month],[so_no],[deal_type],[prefix],[bank],[invoice_no],
				 [invoice_date],[sales_type],[kit_includes],[membership_pricing],
				 [validity],[quantity_billed],[unit_currency],[unit_price],
				 [bill_amount],[bill_freight],[bill_total],[tbl_index])
	SELECT [billing_month],[so_no],[deal_type],[prefix],[bank],[invoice_no],
		   [invoice_date],[sales_type],[kit_includes],[membership_pricing],
		   [validity],[quantity_billed],[unit_currency],[unit_price],
		   [bill_amount],[bill_freight],[bill_total],[tbl_index]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblDAMembership
	WHERE [billing_month] BETWEEN @startMonth AND @endMonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblDAMembership OFF
END
----------------- (Add) tblWLMemberships -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblWLMemberships WHERE [billing_month] BETWEEN @startMonth AND @endMonth)
select @NumRecs AS tblWLMembership
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblWLMemberships'
		DELETE from mastercard_db.dbo.tblWLMemberships WHERE [billing_month] BETWEEN @startMonth AND @endMonth
	END

BEGIN
	SET IDENTITY_INSERT mastercard_db.dbo.tblWLMemberships ON
	INSERT INTO mastercard_db.dbo.tblWLMemberships
				([billing_month],[client_id],[consumer_no],[activity_code],[currency],
				 [amount],[validity],[current_validity_year],[cost_centre],[group_code],
				 [vendor_code],[user_invitation_code],[tbl_index])
	SELECT [billing_month],[client_id],[consumer_no],[activity_code],[currency],
		   [amount],[validity],[current_validity_year],[cost_centre],[group_code],
		   [vendor_code],[user_invitation_code],[tbl_index] 
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblWLMemberships
	WHERE [billing_month] BETWEEN @startMonth AND @endMonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblWLMemberships OFF
END
----------------- (Add) tblLKMemberships -----------------
set @NumRecs = (select count(*) from mastercard_db.dbo.tblLKMemberships WHERE [report_month] BETWEEN @startMonth AND @endMonth)
select @NumRecs AS tblLKMembership
IF @NumRecs > 0
	BEGIN
		--PRINT 'Data Exists for this month in Target: mastercard_db.dbo.tblLKMemberships'
		DELETE from mastercard_db.dbo.tblLKMemberships WHERE [report_month] BETWEEN @startMonth AND @endMonth
	END

BEGIN		
	SET IDENTITY_INSERT mastercard_db.dbo.tblLKMemberships ON
	INSERT INTO mastercard_db.dbo.tblLKMemberships
				([report_month],[billing_month],[client_id],[source_code],[bin],
				 [currency],[quantity],[unit_price],[total],[tbl_index])
	SELECT [report_month],[billing_month],[client_id],[source_code],[bin],
		   [currency],[quantity],[unit_price],[total],[tbl_index]
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblLKMemberships
	WHERE [report_month] BETWEEN @startMonth AND @endMonth
	SET IDENTITY_INSERT mastercard_db.dbo.tblLKMemberships OFF
END	