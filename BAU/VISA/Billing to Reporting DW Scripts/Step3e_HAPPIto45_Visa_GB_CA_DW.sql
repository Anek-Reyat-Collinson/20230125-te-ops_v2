/*******************************************************************************************************************************
** Project ID	 : Step 1b Visa Deals Data Transfer from HAPPI to .45 
** Author        : Hyun
** Amend History : GM 23/03/2016 Changes to 127.0.0.1,41331

** Run history   :	
					HD 20/07/2020 Ran successfully for Jun 2020
					HD 17/08/2020 Ran successfully for Jul 2020
					HD 17/09/2020 Ran successfully for Aug 2020
					HD 16/10/2020 Ran successfully for Sep 2020
					HD 17/11/2020 Ran successfully for Oct 2020
					HD 15/12/2020 Ran successfully for Nov 2020
					HD 18/01/2021 Ran successfully for Nov 2020  -- DI-907
					HD 18/01/2021 Ran successfully for Dec 2020
					HD 16/02/2021 Ran successfully for Jan 2021
					HD 15/03/2021 Ran successfully for Feb 2021
					HD 15/03/2021 Ran successfully for Feb 2020- Nov 20 BIBAU-2735
					HD 15/03/2021 Ran successfully for Dec 2020- Dec 20 BIBAU-2735
					HD 16/04/2021 Ran successfully for Mar 2021
					HD 14/05/2021 Ran successfully for Apr 2021
					HD 17/05/2021 Ran successfully for Jan 2021 - OPSBI-12
					HD 17/05/2021 Ran successfully for Feb 2021 - OPSBI-12
					HD 18/06/2021 Ran successfully for May 2021
					HD 19/07/2021 Ran successfully for Jun 2021
					HD 19/07/2021 Ran successfully for Apr 2021 - OPSBI-62
					HD 19/07/2021 Ran successfully for May 2021 - OPSBI-62
					HD 13/08/2021 Ran successfully for Jul 2021
					HD 25/08/2021 Ran successfully for Jun 2021 - OPSBI-69
					HD 15/09/2021 Ran successfully for Aug 2021
					HD 18/10/2021 Ran successfully for Sep 2021
					HD 12/11/2021 Ran successfully for Oct 2021
					HD 16/12/2021 Ran successfully for Nov 2021
					HD 19/01/2022 Ran successfully for Dec 2021
					HD 16/02/2022 Ran successfully for Jan 2022
					HD 18/03/2022 Ran successfully for Feb 2022
					HD 20/04/2022 Ran successfully for Mar 2022
					HD 20/04/2022 Ran successfully for Dec 2021 - OPSBI-118
					HD 20/04/2022 Ran successfully for Jan 2022 - OPSBI-118
					HD 17/05/2022 Ran successfully for Apr 2022
					HD 18/05/2022 Ran successfully for Oct 2021 - OPSBI-118
					HD 18/05/2022 Ran successfully for Nov 2021 - OPSBI-118
					HD 20/06/2022 Ran successfully for May 2022
					HD 15/07/2022 Ran successfully for Jun 2022
					HD 15/07/2022 Ran successfully for Sep 2021 OPSBI-118
					HD 17/08/2022 Ran successfully for Jul 2022
					HD 19/08/2022 Ran successfully for Jul 2022
					HD 19/08/2022 Ran successfully for Feb 2022
					HD 20/09/2022 Ran successfully for Aug 2022
					HD 17/10/2022 Ran successfully for Sep 2022
					HD 07/11/2022 Ran successfully for Mar 2022 OPSBI-145
					HD 07/11/2022 Ran successfully for Apr 2022 OPSBI-145
					HD 09/11/2022 Ran successfully for May 2022 OPSBI-145
					HD 09/11/2022 Ran successfully for Jun 2022 OPSBI-145
					HD 09/11/2022 Ran successfully for Jul 2022 OPSBI-145
					HD 09/11/2022 Ran successfully for Aug 2022 OPSBI-145
					HD 09/11/2022 Ran successfully for Sep 2022 OPSBI-145
					HD 17/11/2022 Ran successfully for Oct 2022
					HD 18/12/2022 Ran successfully for Nov 2022
					
Problems: LKVSINF2014441180 duplicated

********************************************************************************************************************************/
USE visa_dw
GO

----- (Add New Client ID) visa_dw.dbo.dimTblDeals -----
SET IDENTITY_INSERT visa_dw.dbo.dimTblDeals ON;

	INSERT INTO visa_dw.dbo.dimTblDeals
		([clientid],[prefix],[ica],[bin],[issuer],[unique_issuer_name],
		[country_of_issue_iso],[vs_region_of_issue],[vs_sub_region_of_issue],[card_type],
		[sub_card_type],[payment_type],[deal_start_date],[status],[account_type],
		[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[tbl_index],[cif_grouping_id])
	SELECT 
		Happi.[clientid],Happi.[prefix],Happi.[ica],Happi.[bin],Happi.[issuer],Happi.[unique_issuer_name],
		Happi.[country_of_issue_iso],Happi.[vs_region_of_issue],Happi.[vs_sub_region_of_issue],Happi.[card_type],
		Happi.[sub_card_type],Happi.[payment_type],Happi.[deal_start_date],Happi.[status],Happi.[account_type],
		Happi.[CreatedDate],Happi.[CreatedBy],Happi.[UpdatedDate],Happi.[UpdatedBy],Happi.[tbl_index],Happi.[cif_grouping_id]		
	FROM [10.204.200.112\OPSLIVEDB,49214].deals_db.dbo.dimTblVSDeals happi
		LEFT JOIN visa_dw.dbo.dimTblDeals tt ON happi.clientid = tt.clientid
	WHERE tt.clientid IS NULL

SET IDENTITY_INSERT visa_dw.dbo.dimTblDeals OFF;


---- (Update Source Codes Details) visa_dw.dbo.dimTblDeals ----
DISABLE TRIGGER [dbo].[trg_AutoAudit_dimTblDeals] ON [dbo].dimTblDeals;

	UPDATE visa_dw.dbo.dimTblDeals
	SET [prefix] = happi.[prefix],
		[ica] = happi.[ica],
		[bin] = happi.[bin],
		[issuer] = happi.[issuer],
		[unique_issuer_name] = happi.[unique_issuer_name],
		[country_of_issue_iso] = happi.[country_of_issue_iso],
		[vs_region_of_issue] = happi.[vs_region_of_issue],
		[vs_sub_region_of_issue] = happi.[vs_sub_region_of_issue],
		[card_type] = happi.[card_type],
		[sub_card_type] = happi.[sub_card_type],
		[payment_type] = happi.[payment_type],
		[deal_start_date] = happi.[deal_start_date],
		[status] = happi.[status],
		[account_type] = happi.[account_type],
		[cif_grouping_id] = happi.[cif_grouping_id]

	FROM [10.204.200.112\OPSLIVEDB,49214].deals_db.dbo.dimTblVSDeals happi
	INNER JOIN visa_dw.dbo.dimTblDeals tt ON happi.clientid = tt.clientid;

ENABLE TRIGGER [dbo].[trg_AutoAudit_dimTblDeals] ON [dbo].dimTblDeals;
	