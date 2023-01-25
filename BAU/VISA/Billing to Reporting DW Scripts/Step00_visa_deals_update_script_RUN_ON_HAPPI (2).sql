
/************************************************************************

project aim: to update the VISA deals fields from staging table where there is change

created by: Mahesh Chittigari

created date : 20 September 2018

*************************************************************************/

--- Script execution history

--was run by HD on 16-07-2020
--was run by HD on 14-08-2020	
--was run by HD on 17-08-2020
--was run by HD on 15-09-2020
--was run by HD on 17-09-2020
--was run by HD on 14-10-2020
--was run by HD on 16-10-2020
--was run by HD on 16-11-2020
--was run by HD on 17-11-2020
--was run by HD on 14-12-2020
--was run by HD on 14-12-2020v1
--was run by HD on 15-12-2020
--was run by HD on 15-01-2021
--was run by HD on 18-01-2021   ---DI-907
--was run by HD on 18-01-2021
--was run by HD on 12-02-2021
--was run by HD on 16-02-2021
--was run by HD on 11-03-2021
--was run by HD on 15-03-2021
--was run by HD on 15-03-2021 - Nov 20 BIBAU-2735
--was run by HD on 15-03-2021 - Dec 20 BIBAU-2735
--was run by HD on 09-04-2021
--was run by HD on 16-04-2021
--was run by HD on 13-05-2021
--was run by HD on 14-05-2021
--was run by HD on 17-05-2021-Jan 21 - OPSBI-12
--was run by HD on 17-05-2021-Feb 21 - OPSBI-12
--was run by HD on 15-06-2021
--was run by HD on 18-06-2021
--was run by HD on 14-07-2021
--was run by HD on 14-07-2021v1
--was run by HD on 19-07-2021
--was run by HD on 19-07-2021-Apr 21 - OPSBI-62
--was run by HD on 19-07-2021-May 21 - OPSBI-62
--was run by HD on 12-08-2021
--was run by HD on 13-08-2021
--was run by HD on 25-08-2021 - June 21 - OPSBI-69
--was run by HD on 10-09-2021
--was run by HD on 15-09-2021
--was run by HD on 14-10-2021
--was run by HD on 18-10-2021
--was run by HD on 10-11-2021
--was run by HD on 12-11-2021
--was run by HD on 13-12-2021
--was run by HD on 16-12-2021
--was run by HD on 13-01-2022
--was run by HD on 19-01-2022
--was run by HD on 14-02-2022
--was run by HD on 16-02-2022
--was run by HD on 16-03-2022
--was run by HD on 18-03-2022
--was run by HD on 13-04-2022
--was run by HD on 20-04-2022
--was run by HD on 20-04-2022- Dec 21 -OPSBI-118
--was run by HD on 20-04-2022- Jan 22 -OPSBI-118
--was run by HD on 16-05-2022
--was run by HD on 17-05-2022
--was run by HD on 18-05-2022- Oct 21 -OPSBI-118
--was run by HD on 18-05-2022- Nov 21 -OPSBI-118
--was run by HD on 16-06-2022
--was run by HD on 20-06-2022
--was run by HD on 13-07-2022
--was run by HD on 15-07-2022
--was run by HD on 15-07-2022 - OPSBI-118
--was run by HD on 12-08-2022
--was run by HD on 16-08-2022
--was run by HD on 19-08-2022
--was run by HD on 19-08-2022 - Feb 22
--was run by HD on 15-09-2022
--was run by HD on 20-09-2022
--was run by HD on 13-10-2022
--was run by HD on 17-10-2022
--was run by HD on 07-11-2022 - Mar-22 OPSBI-145
--was run by HD on 07-11-2022 - Apr-22 OPSBI-145
--was run by HD on 09-11-2022 - May-22 OPSBI-145
--was run by HD on 09-11-2022 - Jun-22 OPSBI-145
--was run by HD on 09-11-2022 - Jul-22 OPSBI-145
--was run by HD on 09-11-2022 - Aug-22 OPSBI-145
--was run by HD on 09-11-2022 - Sep-22 OPSBI-145
--was run by HD on 14-11-2022 - Oct-22
--was run by HD on 17-11-2022 - Oct-22
--was run by HD on 14-12-2022 - Nov-22
--was run by HD on 16-01-2023 - Dec-22

USE [deals_db]
--back up

SELECT * INTO Backups.bkup.dealsdb_dimTblVSDeals_20230116 FROM [deals_db].[dbo].[dimTblVSDeals]--((4334 rows affected) rows affected)


--Check records needs to be updated
SELECT t.*
FROM (SELECT * FROM [deals_db].[dbo].[stg_visa_deals_amend] WHERE Update_marker IS  NULL)S JOIN [deals_db].[dbo].[dimTblVSDeals] t
ON t.clientid = s.clientid --3


BEGIN tran
UPDATE t 
SET 
t.[prefix] =CASE WHEN s.[prefix] IS NOT NULL THEN s.[prefix] ELSE t.[prefix] END,
t.[ica] =CASE WHEN s.[ica] IS NOT NULL THEN s.[ica] ELSE t.[ica] END,
t.[bin] =CASE WHEN s.[bin] IS NOT NULL THEN s.[bin] ELSE t.[bin] END,
t.[issuer] =CASE WHEN s.[issuer] IS NOT NULL THEN s.[issuer] ELSE t.[issuer] END,
t.[unique_issuer_name] =CASE WHEN s.[unique_issuer_name] IS NOT NULL THEN s.[unique_issuer_name] ELSE t.[unique_issuer_name] END,
t.[country_of_issue_iso] =CASE WHEN s.[country_of_issue_iso] IS NOT NULL THEN s.[country_of_issue_iso] ELSE t.[country_of_issue_iso] END,
t.[vs_region_of_issue] =CASE WHEN s.[vs_region_of_issue] IS NOT NULL THEN s.[vs_region_of_issue] ELSE t.[vs_region_of_issue] END,
t.[vs_sub_region_of_issue] =CASE WHEN s.[vs_sub_region_of_issue] IS NOT NULL THEN s.[vs_sub_region_of_issue] ELSE t.[vs_sub_region_of_issue] END,
t.[card_type] =CASE WHEN s.[card_type] IS NOT NULL THEN s.[card_type] ELSE t.[card_type] END,
t.[sub_card_type] =CASE WHEN s.[sub_card_type] IS NOT NULL THEN s.[sub_card_type] ELSE t.[sub_card_type] END,
t.[payment_type] =CASE WHEN s.[payment_type] IS NOT NULL THEN s.[payment_type] ELSE t.[payment_type] END,
t.[deal_start_date] =CASE WHEN s.[deal_start_date] IS NOT NULL THEN s.[deal_start_date] ELSE t.[deal_start_date] END,
t.[status] =CASE WHEN s.[status] IS NOT NULL THEN s.[status] ELSE t.[status] END,
t.[account_type] =CASE WHEN s.[account_type] IS NOT NULL THEN s.[account_type] ELSE t.[account_type] END,
t.[cif_grouping_id] =CASE WHEN s.[cif_grouping_id] IS NOT NULL THEN s.[cif_grouping_id] ELSE t.[cif_grouping_id] END
FROM (SELECT * FROM [deals_db].[dbo].[stg_visa_deals_amend] WHERE Update_marker IS  NULL)S JOIN [deals_db].[dbo].[dimTblVSDeals] t
ON t.clientid = s.clientid --1

commit
--rollback

UPDATE deals_db.dbo.stg_visa_deals_amend SET Update_marker='Y' WHERE Update_marker IS NULL--1

--select * from deals_db.dbo.stg_visa_deals_amend order by CreatedDate desc

