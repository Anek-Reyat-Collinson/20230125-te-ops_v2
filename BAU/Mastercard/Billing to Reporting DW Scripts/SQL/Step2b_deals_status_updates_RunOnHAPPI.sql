

--- Run successfully for Aug 2017
	--was run by AA on 12-10-2017 as a part of https://jira.ptgmis.com/browse/BIBAU-293 using the updated script
	--was run by AA on 14-11-2017 as a part of https://jira.ptgmis.com/browse/BIBAU-390 using the updated script
	--was run by AA on 12-12-2017 as a part of https://jira.ptgmis.com/browse/BIBAU-495 using the updated script
	--was run by AA on 12-01-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-600 using the updated script
	--was run by AA on 12-02-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-712 using the updated script--(18 row(s) affected)
	--was run by AA on 13-03-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-813 using the updated script--(81 row(s) affected)
	--was run by AA on 12-04-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-933 using the updated script--(11 row(s) affected)
	--was run by MC on 15-06-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-1227 using the updated script--(6 row(s) affected)
	--was run by MC on 15-06-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-1370 using the updated script--(113 row(s) affected)
	--was run by MC on 24-07-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-1489 using the updated script--(1 row(s) affected)
	--was run by MC on 27-07-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-1493 using the updated script--(8 row(s) affected)
	--was run by MC on 14-08-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-1546 using the updated script--(18 row(s) affected)
	--was run by MC on 14-08-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-1546 using the updated script--(271 row(s) affected)
	--was run by MC on 15-08-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-1546 using the updated script--(259 row(s) affected)
	--was run by MC on 15-08-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-1546 using the updated script--(723 row(s) affected)
	--was run by MC on 15-08-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-1546 using the updated script--(117 row(s) affected)
	--was run by MC on 17-08-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-1546 using the updated script--(35 row(s) affected)
	--was run by AA on 12-09-2018 as a part of  using the updated script
	--was run by MC on 15-10-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-1721 using the updated script--(31 rows affected)
	--was run by MC on 15-10-2018 as a part of https://jira.ptgmis.com/browse/BIBAU-1721 using the updated script--(133 rows affected)
	--was run by MC on 15-11-2018 as per Anek's request using the updated script--(55 rows affected)
	--was run by MC on 17-12-2018 as per Anek's request using the updated script--(14 rows affected)
	--was run by AA on 11-01-2019 as per Kevins request --(79 rows affected)
	--was run by AA on 14-01-2019 as per Anek's request --(51 rows affected)
	--was run by AA on 15-01-2019 as per Kev's request --(277 rows affected)
	--was run by AA on 14-02-2019 as per Kev's request --(41 rows affected)
	--was run by MC on 19-02-2019 as per Kev's request --(3 rows affected)
	--was run by MC on 19-02-2019 as per Kev's request --(2 rows affected)
	--was run by AA on 12-03-2019 as per Kev's request --(19 rows affected)
	--was run by AA on 18-03-2019 as per Kev's request --(2 rows affected) https://jira.ptgmis.com/browse/BIBAU-653
	--was run by AA on 09-04-2019 as per Kev's request --52
	--was run by AA on 12-04-2019 as per Kev's request --44
	--was run by AA on 09-05-2019 as per Anek's request --18
	--was run by AA on 13-06-2019 as per Kevin's request --84
	--was run by AA on 13-06-2019 as per Kevin's request --84
	--was run by AA on 13-06-2019 as per Kevin's request --84
	--was run by AA on 11-07-2019 as per Kevin's request --11
	--was run by SS on 12-08-2019 as per Anek's request --1
	--was run by SS on 12-08-2019 as per Anek's request --1 (again)	

USE deals_db

---check for duplicates before starting the query
--------------------------------
SELECT  clientid,count(1) as total
  FROM [deals_db].[dbo].[stg_deals_status_change] WHERE [Update_marker] IS null
  group by clientid
  having count(1)>1 -- 18
  
--BEGIN TRAN 

--UPDATE t1
--SET [deal_cancellation_date] = t2.[Cancellation Date]
--FROM  deals_db.dbo.dimTblMCDeals t1 
--INNER JOIN mastercard_db.[dbo].[staging_mc_deals_cancellation_date_update] t2 ON t1.clientid = t2.clientid
--WHERE  t1.[deal_cancellation_date] IS NULL

--COMMIT

--UPDATED QUERY
---------------
/*update existing empty values to NULL in staging table*/
  ;BEGIN TRAN
  UPDATE T SET
       t.[clientid]                                = case when t.[clientid]                                ='' then NULL            else t.[clientid]                                END                                               
      ,t.[status]                              	 	=case when t.[status]                              	 	='' then NULL  			else t.[status]                           	  END
      ,t.[deal_cancellation_date]					 	=case when t.[deal_cancellation_date]					 	='' then NULL  	else t.[deal_cancellation_date]				  END
      ,t.[prefix]									 	=case when t.[prefix]									 	='' then NULL  	else t.[prefix]								  END
      ,t.[ica]									 	=case when t.[ica]									 	='' then NULL  			else t.[ica]									  END
      ,t.[bin]									 	=case when t.[bin]									 	='' then NULL  			else t.[bin]									  END
      ,t.[issuer_group]							 	=case when t.[issuer_group]							 	='' then NULL  			else t.[issuer_group]							  END
      ,t.[issuer_name]							 	=case when t.[issuer_name]							 	='' then NULL  			else t.[issuer_name]							  END
      ,t.[unique_issuer_name]						 	=case when t.[unique_issuer_name]						 	='' then NULL  	else t.[unique_issuer_name]					  END
      ,t.[pp_region]								 	=case when t.[pp_region]								 	='' then NULL  	else t.[pp_region]							  END
      ,t.[ppbo_country_of_issue_iso]				 	=case when t.[ppbo_country_of_issue_iso]				 	='' then NULL  	else t.[ppbo_country_of_issue_iso]			  END
      ,t.[mc_region_of_issue]						 	=case when t.[mc_region_of_issue]						 	='' then NULL  	else t.[mc_region_of_issue]					  END
      ,t.[old_mc_region_of_issue]					 	=case when t.[old_mc_region_of_issue]					 	='' then NULL  	else t.[old_mc_region_of_issue]				  END
      ,t.[selected_non_selected]					 	=case when t.[selected_non_selected]					 	='' then NULL  	else t.[selected_non_selected]				  END
      ,t.[card_type_code]							 	=case when t.[card_type_code]							 	='' then NULL  	else t.[card_type_code]						  END
      ,t.[card_type] 								 	=case when t.[card_type] 								 	='' then NULL  	else t.[card_type] 							  END
      ,t.[price_type]								 	=case when t.[price_type]								 	='' then NULL  	else t.[price_type]							  END
      ,t.[lounge_programme]						 	=case when t.[lounge_programme]						 	='' then NULL  			else t.[lounge_programme]						  END
      ,t.[po_charge_type]							 	=case when t.[po_charge_type]							 	='' then NULL  	else t.[po_charge_type]						  END
      ,t.[enrolment_method]						 	=case when t.[enrolment_method]						 	='' then NULL  			else t.[enrolment_method]						  END
      ,t.[charge_rate]							 	=case when t.[charge_rate]							 	='' then NULL  			else t.[charge_rate]							  END
      ,t.[billing_channel]						 	=case when t.[billing_channel]						 	='' then NULL  			else t.[billing_channel]						  END
      ,t.[deal_start_date]						 	=case when t.[deal_start_date]						 	='' then NULL  			else t.[deal_start_date]						  END
      ,t.[context]								 	=case when t.[context]								 	='' then NULL  			else t.[context]								  END
      ,t.[billing_inclusion_lounge_visits]		 	=case when t.[billing_inclusion_lounge_visits]		 	='' then NULL  			else t.[billing_inclusion_lounge_visits]		  END
      ,t.[billing_inclusion_memberships]			 	=case when t.[billing_inclusion_memberships]			 	='' then NULL  	else t.[billing_inclusion_memberships]		  END
      ,t.[billing_inclusion_freight]				 	=case when t.[billing_inclusion_freight]				 	='' then NULL  	else t.[billing_inclusion_freight]			  END
      ,t.[account_type_fk]						 	=case when t.[account_type_fk]						 	='' then NULL  			else t.[account_type_fk]						  END
      ,t.[mc_ica]									 	=case when t.[mc_ica]									 	='' then NULL  	else t.[mc_ica]								  END
      ,t.[client_service_centre]					 	=case when t.[client_service_centre]					 	='' then NULL  	else t.[client_service_centre]				  END
   FROM [deals_db].[dbo].[stg_deals_status_change] T  WHERE Update_marker IS NULL
   --rollback
   --commit


/*roll up by client id to avoid duplicates in staging table*/

IF OBJECT_ID('tempdb..#temp_stg_deals_status_change') IS NOT NULL
    DROP TABLE #temp_stg_deals_status_change

SELECT 
      max([clientid]) AS [clientid]
      ,max([status]) [status]
      ,max([deal_cancellation_date]) [deal_cancellation_date]
      ,max([prefix]) [prefix]
      ,max([ica]) [ica]
      ,max([bin]) [bin]
      ,max([issuer_group]) [issuer_group]
      ,max([issuer_name]) [issuer_name]
      ,max([unique_issuer_name]) [unique_issuer_name]
      ,max([pp_region]) [pp_region]
      ,max([ppbo_country_of_issue_iso]) [ppbo_country_of_issue_iso]
      ,max([mc_region_of_issue]) [mc_region_of_issue]
      ,max([old_mc_region_of_issue]) [old_mc_region_of_issue]
      ,max([selected_non_selected]) [selected_non_selected]
      ,max([card_type_code]) [card_type_code]
      ,max([card_type]) [card_type]
      ,max([price_type]) [price_type]
      ,max([lounge_programme]) [lounge_programme]
      ,max([po_charge_type]) [po_charge_type]
      ,max([enrolment_method]) [enrolment_method]
      ,max([charge_rate]) [charge_rate]
      ,max([billing_channel]) [billing_channel]
      ,max([deal_start_date]) [deal_start_date]
      ,max([context]) [context]
      ,max([billing_inclusion_lounge_visits]) [billing_inclusion_lounge_visits]
      ,max([billing_inclusion_memberships]) [billing_inclusion_memberships]
      ,max([billing_inclusion_freight]) [billing_inclusion_freight]
      ,max([account_type_fk]) [account_type_fk]
      ,max([mc_ica]) [mc_ica]
      ,max([client_service_centre]) [client_service_centre]
      ,max([CreatedDate]) [CreatedDate]
      ,max([CreatedBy]) [CreatedBy]
      ,max([Update_marker]) [Update_marker]
	  INTO #temp_stg_deals_status_change
  FROM [deals_db].[dbo].[stg_deals_status_change] WHERE [Update_marker] IS null
  group by [clientid]


 
update #temp_stg_deals_status_change
set [deal_cancellation_date]= null
where [status] = 'Active'


/*back up deals*/

--USE [deals_db]
----back up
----SELECT * INTO Backups.bkup.dealsdb_dimtblMCdeals_updates_23052018V2_MC from [deals_db].[dbo].[dimTblMCDeals] --2326 rows
--SELECT t.*
-- FROM 
-- (SELECT * FROM #temp_stg_deals_status_change WHERE Update_marker IS  NULL)S JOIN [deals_db].[dbo].[dimTblMCDeals] t
--ON t.clientid = s.clientid ORDER BY tbl_index asc

USE [deals_db]
SELECT t.* 	 
into Backups.bkup.dealsdb_dimtblMCdeals_20190812_SS_2
FROM [deals_db].[dbo].[dimTblMCDeals] t--(3450 rows affected)


--final update

BEGIN tran
UPDATE t 
SET 
t.[status] =CASE WHEN (s.[status] IS NOT NULL or s.[status]<>'')  THEN s.[status] ELSE t.[status] END,
t.[deal_cancellation_date] =CASE WHEN s.[deal_cancellation_date] IS NOT NULL THEN s.[deal_cancellation_date] ELSE t.[deal_cancellation_date] END,
t.[prefix] =CASE WHEN s.[prefix] IS NOT NULL THEN s.[prefix] ELSE t.[prefix] END,
t.[ica] =CASE WHEN s.[ica] IS NOT NULL THEN s.[ica] ELSE t.[ica] END,
t.[bin] =CASE WHEN s.[bin] IS NOT NULL THEN s.[bin] ELSE t.[bin] END,
t.[issuer_group] =CASE WHEN s.[issuer_group] IS NOT NULL THEN s.[issuer_group] ELSE t.[issuer_group] END,
t.[issuer_name] =CASE WHEN s.[issuer_name] IS NOT NULL THEN s.[issuer_name] ELSE t.[issuer_name] END,
t.[unique_issuer_name] =CASE WHEN s.[unique_issuer_name] IS NOT NULL THEN s.[unique_issuer_name] ELSE t.[unique_issuer_name] END,
t.[pp_region] =CASE WHEN s.[pp_region] IS NOT NULL THEN s.[pp_region] ELSE t.[pp_region] END,
t.[ppbo_country_of_issue_iso] =CASE WHEN s.[ppbo_country_of_issue_iso] IS NOT NULL THEN s.[ppbo_country_of_issue_iso] ELSE t.[ppbo_country_of_issue_iso] END,
t.[mc_region_of_issue] =CASE WHEN s.[mc_region_of_issue] IS NOT NULL THEN s.[mc_region_of_issue] ELSE t.[mc_region_of_issue] END,
t.[old_mc_region_of_issue] =CASE WHEN s.[old_mc_region_of_issue] IS NOT NULL THEN s.[old_mc_region_of_issue] ELSE t.[old_mc_region_of_issue] END,
t.[selected_non_selected] =CASE WHEN s.[selected_non_selected] IS NOT NULL THEN s.[selected_non_selected] ELSE t.[selected_non_selected] END,
t.[card_type_code] =CASE WHEN s.[card_type_code] IS NOT NULL THEN s.[card_type_code] ELSE t.[card_type_code] END,
t.[card_type] =CASE WHEN s.[card_type] IS NOT NULL THEN s.[card_type] ELSE t.[card_type] END,
t.[price_type] =CASE WHEN s.[price_type] IS NOT NULL THEN s.[price_type] ELSE t.[price_type] END,
t.[lounge_programme] =CASE WHEN s.[lounge_programme] IS NOT NULL THEN s.[lounge_programme] ELSE t.[lounge_programme] END,
t.[po_charge_type] =CASE WHEN s.[po_charge_type] IS NOT NULL THEN s.[po_charge_type] ELSE t.[po_charge_type] END,
t.[enrolment_method] =CASE WHEN s.[enrolment_method] IS NOT NULL THEN s.[enrolment_method] ELSE t.[enrolment_method] END,
t.[charge_rate] =CASE WHEN s.[charge_rate] IS NOT NULL THEN s.[charge_rate] ELSE t.[charge_rate] END,
t.[billing_channel] =CASE WHEN s.[billing_channel] IS NOT NULL THEN s.[billing_channel] ELSE t.[billing_channel] END,
t.[deal_start_date] =CASE WHEN s.[deal_start_date] IS NOT NULL THEN s.[deal_start_date] ELSE t.[deal_start_date] END,
t.[context] =CASE WHEN s.[context] IS NOT NULL THEN s.[context] ELSE t.[context] END,
t.[billing_inclusion_lounge_visits] =CASE WHEN s.[billing_inclusion_lounge_visits] IS NOT NULL THEN s.[billing_inclusion_lounge_visits] ELSE t.[billing_inclusion_lounge_visits] END,
t.[billing_inclusion_memberships] =CASE WHEN s.[billing_inclusion_memberships] IS NOT NULL THEN s.[billing_inclusion_memberships] ELSE t.[billing_inclusion_memberships] END,
t.[billing_inclusion_freight] =CASE WHEN s.[billing_inclusion_freight] IS NOT NULL THEN s.[billing_inclusion_freight] ELSE t.[billing_inclusion_freight] END,
t.[account_type_fk] =CASE WHEN s.[account_type_fk] IS NOT NULL THEN s.[account_type_fk] ELSE t.[account_type_fk] END,
t.[mc_ica] =CASE WHEN s.[mc_ica] IS NOT NULL THEN s.[mc_ica] ELSE t.[mc_ica] END,
t.[client_service_centre] =CASE WHEN s.[client_service_centre] IS NOT NULL THEN s.[client_service_centre] ELSE t.[client_service_centre] END  
FROM (SELECT * FROM #temp_stg_deals_status_change WHERE Update_marker IS  NULL)S JOIN [deals_db].[dbo].[dimTblMCDeals] t
ON t.clientid = s.clientid

--commit
--rollback

--updated records marked with status Y denoting completion

UPDATE deals_db.dbo.stg_deals_status_change SET Update_marker='Y' WHERE Update_marker IS NULL
