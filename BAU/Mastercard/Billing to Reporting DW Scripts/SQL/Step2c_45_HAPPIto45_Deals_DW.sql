/*******************************************************************************************************************************
** Project ID	 : MasterCard Deal Data Transfer from HAPPI to .45 Step 2
** Author        : Hyun
** Last Mofified : 2016-03-17
** Amend History : GM 17/03/2016 Changes to use 127.0.0.1,41331
				   AE 11/04/2017 Added 3 new columns i.e. [po_charge_type],[enrolment_method],[deal_cancellation_date]
				   AE 20/04/2017 Added 1 new column i.e. card_type_code
				   AE 24/04/2017 Added 2 new column i.e. charge_rate, billing_channel

** Run history   :	GM 17/03/2016 Ran successfully for Jab & Feb data
					GM 19/04/2016 Ran successfully for Mar data
					GM 05/05/2016 Ran successfully for Apr data
					GM 16/06/2016 Ran successfully for May data
					AE 14/07/2016 Ran successfully for june data
					AE 12/08/2016 Ran successfully for July data
					AE 22/09/2016 Ran successfully for August data
					AE 20/10/2016 Ran successfully for September data
					GM 14/11/2016 Ran successfully for October data
					AE 15/12/2016 Ran successfully for November data
					AE 16/01/2017 Ran successfully for December data
					AE 17/02/2017 Ran successfully for Jan data
					VP 17/03/2017 Ran successfully for Feb data
					AE 13/04/2017 Ran successfully for Mar data
					AE 24/04/2017 Ran successfully for arp data --- re-run to update deals made by opubo
					VP 12/05/2017 Ran successfully for Apr data
					AE 13/06/2017 Ran successfully for May data
					AE 22/06/2017 Ran successfully for May data -- re run https://jira.ptgmis.com/browse/RDP-1061
					AE 17/07/2017 Ran successfully for Jun data
					AE 11/08/2017 Ran successfully for July data
					LA 05/09/2017 Ran successfully for https://jira.ptgmis.com/browse/BI-642
					VP 14/09/2017 Ran successfully for Aug data
					VP 28/09/2017 Ran successfully for Aug data
					AA 13/10/2017 Ran successfully for SEP data
					AA 14/11/2017 Ran successfully for OCT data--reran as a part of Jira:https://jira.ptgmis.com/browse/BIBAU-464 on 30/11/2017
					AA 12/12/2017 Ran successfully for Nov data
					AA 12/01/2018 Ran successfully for Dec data
					AA 12/02/2018 Ran successfully for Jan data in Dev
					AA 13/03/2018 Ran successfully for Feb data in Dev
					AA 13/04/2018 Ran successfully for mar data in Dev
					MC 18/05/2018 Ran successfully for Apr data in Live
					MC 23/05/2018 Ran successfully for Apr data in Live
					MC 19/06/2018 Ran successfully for May data in Live
					MC 18/07/2018 Ran successfully for June data in Live
					MC 24/07/2018 Ran successfully for June data in Live
					MC 27/07/2018 Ran successfully for June data in Live--https://jira.ptgmis.com/browse/BIBAU-1493
					MC 14/08/2018 Ran successfully for July data in Live--https://jira.ptgmis.com/browse/BIBAU-1657
					MC 15/10/2018 Ran successfully for September data in Live--https://jira.ptgmis.com/browse/BIBAU-1721
					MC 15/11/2018 Ran successfully in Live as per Anek's request
					MC 21/11/2018 Ran successfully in Live as per Kevin's request
					MC 21/11/2018 Re-Ran successfully in Live as per Anek's request
					MC 06/12/2018 Re-Ran successfully in Live as per https://jira.ptgmis.com/browse/BIBAU-2056
					MC 07/12/2018 Re-Ran successfully in Live as per https://jira.ptgmis.com/browse/BIBAU-2061
					AA 17/12/2018 Re-Ran successfully in Live as per Anek's request
					AA 30/04/2019 Re-Ran successfully in Live as per Anek's request on 30-04-2019 in Teams
					AA 22/05/2019 Re-Ran successfully in Live as per Kev's request https://jira.ptgmis.com/browse/BIBAU-2461
                    AA 14/06/2019 Re-Ran successfully in Live as per Aneks's request https://jira.ptgmis.com/browse/BIBAU-2471
                    AA 29/11/2019 Ran successfully in Live as per Aneks's request in teams
                    AA 21/01/2020 Ran successfully in Live as per Kevs's request in teams
                    AA 28/01/2020 Ran successfully in Live as per Aneks's request in teams
-- Quick check for duplicates before trying to import from HAPPI
SELECT COUNT([clientid]),[clientid]
FROM [127.0.0.1,41331].deals_db.dbo.dimTblMCDeals
 --WHERE clientid = 'LKMCCITIWPLUS155291200'
 GROUP BY [clientid]
 HAVING COUNT([clientid])>1
 
-- =============================================================================================
-- -----------------------------------------------------------------
-- Copy the block below for every update to the stored procedure

--		Modified date	: 5th September 2017
--		Author			: Lanre Alabede
--		Jira Number		: https://jira.ptgmis.com/browse/BI-642
--		Description		: Added client_service_centre column
-- -----------------------------------------------------------------
-- =============================================================================================
 


*******************************************************************************************************************************/
USE mastercard_dw
GO

	
------------------- (Replace) dimTblMCIDeals -------------------

DISABLE TRIGGER [dbo].[trg_AutoAudit_dimTblMCIDeals] ON [dbo].[dimTblMCIDeals]; 
	DELETE FROM mastercard_dw.dbo.dimTblMCIDeals;
ENABLE TRIGGER [dbo].[trg_AutoAudit_dimTblMCIDeals] ON [dbo].[dimTblMCIDeals]; 
	

SET IDENTITY_INSERT mastercard_dw.dbo.dimTblMCIDeals ON;
	
	INSERT INTO mastercard_dw.dbo.dimTblMCIDeals
		(
		[clientid],
		[prefix],
		[ica],
		[bin],
		[issuer_group],
		[issuer_name],
		[unique_issuer_name],
		[pp_region],
		[ppbo_country_of_issue_iso],
		[mc_region_of_issue],
		[old_mc_region_of_issue],
		[selected_non_selected],
		[card_type_code],
		[card_type],
		[price_type],
		[lounge_programme],
		[po_charge_type],
		[enrolment_method],
		[charge_rate],
		[billing_channel],
		[deal_start_date],
		[context],
		[billing_inclusion_lounge_visits],
		[billing_inclusion_memberships],
		[billing_inclusion_freight],
		[status],
		[deal_cancellation_date],
		[account_type_fk],
		[mc_ica],
		[client_service_centre],
		[CreatedDate],
		[CreatedBy],
		[UpdatedDate],
		[UpdatedBy],
		[tbl_index]
		)
	SELECT 
		[clientid],
		[prefix],
		[ica],[bin],
		[issuer_group],
		[issuer_name],
		[unique_issuer_name],
		[pp_region],
		[ppbo_country_of_issue_iso],
		[mc_region_of_issue],
		[old_mc_region_of_issue],
		[selected_non_selected],
		[card_type_code],
		[card_type],
		[price_type],
		[lounge_programme],
		[po_charge_type],
		[enrolment_method],
		[charge_rate],
		[billing_channel],
		[deal_start_date],
		[context],
		[billing_inclusion_lounge_visits],
		[billing_inclusion_memberships],
		[billing_inclusion_freight],
		[status],
		[deal_cancellation_date],
		[account_type_fk],
		[mc_ica],
		[client_service_centre],
		[CreatedDate],
		[CreatedBy],
		[UpdatedDate],
		[UpdatedBy],
		[tbl_index]
	FROM [127.0.0.1,41331].deals_db.dbo.dimTblMCDeals

SET IDENTITY_INSERT mastercard_dw.dbo.dimTblMCIDeals OFF;



