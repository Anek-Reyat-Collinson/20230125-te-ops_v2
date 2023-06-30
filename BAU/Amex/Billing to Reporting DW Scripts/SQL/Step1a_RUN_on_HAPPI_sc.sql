

-- HD AWS Run on ran this succesfully on 12/06/2020 - (897 rows affected)
-- AA AWS Run on ran this succesfully on 19/06/2020 - (897 rows affected)
-- HD AWS Run on ran this succesfully on 24/06/2020 - (897 rows affected)
-- HD AWS Run on ran this succesfully on 09/07/2020 - (897 rows affected)
-- HD AWS Run on ran this succesfully on 07/08/2020 - (897 rows affected)
-- HD AWS Run on ran this succesfully on 10/08/2020 - (897 rows affected)
-- HD AWS Run on ran this succesfully on 09/09/2020 - (897 rows affected)
-- HD AWS Run on ran this succesfully on 07/10/2020 - (897 rows affected)
-- HD AWS Run on ran this succesfully on 06/11/2020 - (908 rows affected)
-- HD AWS Run on ran this succesfully on 04/12/2020 - (910 rows affected)
-- HD AWS Run on ran this succesfully on 07/12/2020 - (914 rows affected)
-- HD AWS Run on ran this succesfully on 08/01/2021 - (914 rows affected)
-- HD AWS Run on ran this succesfully on 05/02/2021 - (916 rows affected)
-- HD AWS Run on ran this succesfully on 05/03/2021 - (916 rows affected)
-- HD AWS Run on ran this succesfully on 10/03/2021 - (922 rows affected) -- BIBAU-2734
-- HD AWS Run on ran this succesfully on 09/04/2021 - (928 rows affected)
-- HD AWS Run on ran this succesfully on 08/05/2021 - (931 rows affected)
-- HD AWS Run on ran this succesfully on 12/05/2021 - (939 rows affected) -- Rerun due to Amex GNS LV
-- HD AWS Run on ran this succesfully on 07/06/2021 - (939 rows affected)
-- HD AWS Run on ran this succesfully on 08/07/2021 - (944 rows affected)
-- HD AWS Run on ran this succesfully on 06/08/2021 - (949 rows affected)
-- HD AWS Run on ran this succesfully on 07/09/2021 - (949 rows affected)
-- HD AWS Run on ran this succesfully on 08/10/2021 - (949 rows affected)
-- HD AWS Run on ran this succesfully on 05/11/2021 - (949 rows affected)
-- HD AWS Run on ran this succesfully on 01/12/2021 - (949 rows affected)
-- HD AWS Run on ran this succesfully on 03/12/2021 - (949 rows affected)
-- HD AWS Run on ran this succesfully on 13/12/2021 - (949 rows affected)
-- HD AWS Run on ran this succesfully on 10/01/2022 - (949 rows affected)
-- HD AWS Run on ran this succesfully on 14/02/2022 - (955 rows affected)
-- HD AWS Run on ran this succesfully on 15/02/2022 - (955 rows affected) - OPSBI - 106
-- HD AWS Run on ran this succesfully on 10/03/2022 - (955 rows affected)
-- HD AWS Run on ran this succesfully on 07/04/2022 - (956 rows affected)
-- HD AWS Run on ran this succesfully on 27/04/2022 - (957 rows affected)
-- HD AWS Run on ran this succesfully on 10/05/2022 - (957 rows affected)
-- HD AWS Run on ran this succesfully on 10/06/2022 - (957 rows affected)
-- HD AWS Run on ran this succesfully on 13/07/2022 - (957 rows affected)
-- HD AWS Run on ran this succesfully on 09/08/2022 - (957 rows affected)
-- HD AWS Run on ran this succesfully on 12/09/2022 - (961 rows affected)
-- HD AWS Run on ran this succesfully on 12/10/2022 - (967 rows affected)
-- HD AWS Run on ran this succesfully on 09/11/2022 - (967 rows affected)
-- HD AWS Run on ran this succesfully on 08/12/2022 - (967 rows affected)
-- HD AWS Run on ran this succesfully on 11/01/2023 - (967 rows affected)
-- HD AWS Run on ran this succesfully on 13/01/2023 - (967 rows affected)
-- HD AWS Run on ran this succesfully on 31/01/2023 - (970 rows affected) - OPSBI-198
-- HD AWS Run on ran this succesfully on 07/02/2023 - (970 rows affected)

BEGIN tran
UPDATE amex_dw.dbo.dimTblSourceCodes 
SET
	[member_type]			= happi.[member_type],
    [market]				= happi.market_code,
    [prop_gns]				= happi.[prop_gns],
    [sourcecode_comments]	= happi.deal_details,
    [business_unit]			= happi.[business_unit],
    [card_type]				= happi.[card_type],
    [card_level]			= happi.[card_level],
    [service_center]		= happi.service_centre,
    [lounge_program]		= CASE WHEN happi.deal_type ='affinity' THEN happi.lounge_program +' - ' + happi.deal_type ELSE happi.lounge_program END,
    [issuing_country_iso_3] = happi.country_of_issue_iso_3,
    [amex_region]			= happi.[amex_region],
    [gns_bank_name]			= happi.[gns_bank_name]
FROM 
 [amex_source_code_db].[dbo].[tblSourceCodeMaster] happi
 JOIN amex_dw.dbo.dimTblSourceCodes tt ON happi.source_code = tt.source_code_pk

commit
--rollback

/************************************************************************************
-- script to insert any missing source codes into the DW

**************************************************************************************/


/* include missing source codes from the [amex_source_code_db].[dbo].[tblSourceCodeMaster] table */
USE [amex_dw]
GO

BEGIN tran
INSERT INTO [dbo].[dimTblSourceCodes]
           ([source_code_pk]
           ,[member_type]
           ,[market]
           ,[prop_gns]
           ,[sourcecode_comments]
           ,[business_unit]
           ,[card_type]
           ,[card_level]
           ,[service_center]
           ,[lounge_program]
           ,[issuing_country_iso_3]
           ,[amex_region]
           ,[gns_bank_name])
SELECT      happi.source_code
           ,happi.[member_type]
           ,happi.market_code
           ,happi.[prop_gns]
           ,happi.deal_details
           ,happi.[business_unit]
           ,happi.[card_type]
           ,happi.[card_level]
           ,happi.service_centre
           ,CASE WHEN happi.deal_type ='affinity' THEN happi.lounge_program +' - ' + happi.deal_type ELSE happi.lounge_program END
           ,happi.country_of_issue_iso_3
           ,happi.[amex_region]
           ,happi.[gns_bank_name]
		    FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster] happi
            LEFT JOIN amex_dw.dbo.dimTblSourceCodes tt ON happi.source_code = tt.source_code_pk
            WHERE tt.source_code_pk IS null
GO

commit
--rollback


------------------------------------------------------------------------------------
--old script
--begin tran

--insert into [amex_dw].[dbo].[dimTblSourceCodes]
--	(
--	[source_code_pk]
--	,[member_type]
--	,[market]
--	,[prop_gns]
--	,[sourcecode_comments]
--	,[business_unit]
--	,[card_type]
--	,[card_level]
--	,[service_center]
--	,[lounge_program]
--	,[issuing_country_iso_3]
--	,[amex_region]
--	,[gns_bank_name]
--	)

--SELECT 
--	source_code AS [source_code_pk]
--	,member_type AS [member_type]
--	,market_code AS [market]
--	,prop_gns AS [prop_gns]
--	,deal_details AS [sourcecode_comments]
--	,business_unit AS [business_unit]
--	,card_type AS [card_type]
--	,card_level AS [card_level]
--	,service_centre AS [service_center]
--	,lounge_program AS [lounge_program]
--	,country_of_issue_iso_3 AS [issuing_country_iso_3]
--	,amex_region AS [amex_region]
--	,gns_bank_name AS [gns_bank_name]

--FROM [amex_source_code_db].[dbo].[tblSourceCodeMaster]
--WHERE source_code IN 
--		( 'LCWCCDD4BNLG',
--'LXPCCEB2SBHNAME',
--'LCWCCDD4BNLG',
--'LXPCCEB2SBHNAME')
----commit
