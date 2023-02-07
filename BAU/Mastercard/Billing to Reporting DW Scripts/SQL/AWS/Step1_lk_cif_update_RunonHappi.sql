
/*******************************************************************************************************************************
	Project ID	  : 1597_MC_LK_CIF_Retrospective_Updates_and_Snapshot_month
					Retrospective updates to MC Lounge Key CIF totals and snapshot of the current month
	Author		  : Opubo Brown
	Date Created  : 2016-10-31
	Last Mofified : 2016-11-11	Added this comments header
								Changed DB name to HAPPI table
					2017-06-08	Added steps to cater for Migrated Deals
								i. Migrate CIF for old deal into new deal where a CIF doesn't already exist
								ii. Delete overlapping migrated CIF records for migrated deals and CIFs after cancellation date
					2017-11-14	Added DELETE clause to MERGE statement to delete records with a CIF total of 0
	Notes		  :	


** Run history   :	OB along with AA 14/11/2017  ran this updated process as per changes mentioned in https://jira.ptgmis.com/browse/BIBAU-289
								  
								   HD 09/06/2020  ran this updated process for reporting month 2020-05-01 as per Anek's request
								   AA 24/06/2020  ran this updated process for reporting month 2020-05-01 as per Anek's request on AWS
								   AA 10/07/2020  ran this updated process for reporting month 2020-06-01 as per Anek's request on AWS
								   HD 10/09/2020  ran this updated process for reporting month 2020-08-01 as per Anek's request on AWS
								   HD 09/10/2020  ran this updated process for reporting month 2020-09-01 as per Anek's request on AWS
								   HD 10/11/2020  ran this updated process for reporting month 2020-10-01 as per Anek's request on AWS
								   HD 08/12/2020  ran this updated process for reporting month 2020-11-01 as per Anek's request on AWS
								   HD 12/01/2021  ran this updated process for reporting month 2020-12-01 as per Anek's request on AWS
								   HD 08/02/2021  ran this updated process for reporting month 2021-01-01 as per Anek's request on AWS
								   HD 08/03/2021  ran this updated process for reporting month 2021-02-01 as per Anek's request on AWS
								   HD 12/04/2021  ran this updated process for reporting month 2021-03-01 as per Anek's request on AWS
								   HD 10/05/2021  ran this updated process for reporting month 2021-04-01 as per Anek's request on AWS
								   HD 09/06/2021  ran this updated process for reporting month 2021-05-01 as per Anek's request on AWS
								   HD 09/07/2021  ran this updated process for reporting month 2021-06-01 as per Anek's request on AWS
								   HD 08/09/2021  ran this updated process for reporting month 2021-07-01 as per Anek's request on AWS
								   HD 08/09/2021  ran this updated process for reporting month 2021-08-01 as per Anek's request on AWS
								   HD 11/10/2021  ran this updated process for reporting month 2021-09-01 as per Anek's request on AWS
								   HD 08/11/2021  ran this updated process for reporting month 2021-10-01 as per Anek's request on AWS
								   HD 09/12/2021  ran this updated process for reporting month 2021-11-01 as per Anek's request on AWS
								   HD 11/01/2022  ran this updated process for reporting month 2021-12-01 as per Anek's request on AWS
     							   HD 09/02/2022  ran this updated process for reporting month 2022-01-01 as per Anek's request on AWS
								   HD 08/03/2022  ran this updated process for reporting month 2022-02-01 as per Anek's request on AWS
								   HD 11/03/2022  ran this updated process for reporting month 2022-02-01 as per Anek's request on AWS
								   HD 15/03/2022  ran this updated process for reporting month 2022-02-01 as per Anek's request on AWS - OPSBI 116
								   HD 09/05/2022  ran this updated process for reporting month 2022-04-01 as per Anek's request on AWS
								   HD 13/06/2022  ran this updated process for reporting month 2022-05-01 as per Anek's request on AWS
								   HD 08/07/2022  ran this updated process for reporting month 2022-06-01 as per Anek's request on AWS
								   HD 08/07/2022  ran this updated process for reporting month 2022-06-01 as per Anek's request on AWS
								   HD 08/08/2022  ran this updated process for reporting month 2022-07-01 as per Anek's request on AWS
								   HD 13/09/2022  ran this updated process for reporting month 2022-08-01 as per Anek's request on AWS
								   HD 10/10/2022  ran this updated process for reporting month 2022-09-01 as per Anek's request on AWS
								   HD 08/11/2022  ran this updated process for reporting month 2022-10-01 as per Anek's request on AWS
								   HD 09/12/2022  ran this updated process for reporting month 2022-11-01 as per Anek's request on AWS
								   HD 13/01/2023  ran this updated process for reporting month 2022-12-01 as per Anek's request on AWS
********************************************************************************************************************************/



-- ENTER the report month
USE mastercard_db
GO

DECLARE @Report_Month		AS DATE	= '2022-12-01'


DECLARE @StartDate			AS DATE	= (SELECT MIN(report_month) AS start_date FROM [dbo].[vw_lk_cif_update_source])
DECLARE @EndDate			AS DATE	= @Report_Month

BEGIN TRAN

/*
	STEP 1: Tidy up the source table.
			* Trim the relevant columns and derive the client_id
			* Delete membership and admin records
*/
UPDATE  [dbo].[vw_lk_cif_update_source]
SET		source_code			= REPLACE(REPLACE(REPLACE((source_code), CHAR(10), ''), CHAR(13), ''),' ',''),
		bin					= REPLACE(REPLACE(REPLACE((bin),CHAR(10),''), CHAR(13), ''),' ',''),
		currency			= LTRIM(RTRIM(currency)),
		monthly_unit_price	= CONVERT(DECIMAL(10,2), ROUND(monthly_unit_price, 2, 1)),
		order_type			= REPLACE(REPLACE(LTRIM(RTRIM(order_type)),CHAR(10), ''), CHAR(13), ''),
		client_id			= REPLACE(REPLACE(REPLACE(source_code, CHAR(10), ''), CHAR(13), ''),' ','')
							  + REPLACE(REPLACE(REPLACE(bin, CHAR(10), ''), CHAR(13), ''),' ','');

-- COMMIT
-- ROLLBACK
--BEGIN TRAN

--below process already done in Alteryx by Kev,so may retrieve 0 rows.

DELETE FROM [dbo].[vw_lk_cif_update_source]
WHERE order_type NOT LIKE 'CIF%';


-- COMMIT
-- ROLLBACK
--BEGIN TRAN

/*-----------------------------------------------------------------------------------------------------------------
	STEP 1.1: 
	        *run the script located in the below path to update the staginfg table
			 O:\17. Production\Dataloads_47to45_DW\AFTER Audit\MasterCard\DataWarehousing\Data Cleansing\Script_to_remove_spaces_and_CR_from_MC_LK_tables.sql

			In the query run the select statement and if the select retrieves any rows **then only** run the below update statement in each table(there are many tables/columns in the script)
			                                                                                             
*/------------------------------------------------------------------------------------------------------------------




/*
	STEP 2: For migrated deals, migrate the CIF for old deal to new deal where a CIF exist.
			* Update client_id of the old deal with client_id of the new deal
*/

DECLARE @Report_Month		AS DATE	= '2022-12-01'
DECLARE @StartDate			AS DATE	= (SELECT MIN(report_month) AS start_date FROM [dbo].[vw_lk_cif_update_source])
DECLARE @EndDate			AS DATE	= @Report_Month

BEGIN TRAN

UPDATE sc
SET sc.client_id = lg.nd_client_id,
	sc.source_code = lg.nd_sourcecode_prefix
FROM [dbo].[vw_lk_cif_update_source] sc
	 -- Get the latest report month for old deals
	 INNER JOIN [deals_db].[dbo].[vwMCMigrationsLog] lg
			 ON lg.od_client_id = sc.client_id AND
				lg.migration_month <= sc.report_month AND
				lg.od_sourcecode_prefix <> lg.nd_sourcecode_prefix
	 LEFT JOIN [dbo].[vw_lk_cif_update_source] ex
			ON ex.client_id = lg.nd_client_id AND
			   ex.report_month = sc.report_month
WHERE sc.report_month BETWEEN @StartDate AND @EndDate AND
	  ex.client_id IS NULL;

--((59 rows affected)
-- COMMIT
-- ROLLBACK
--BEGIN TRAN

/*
	STEP 3: For migrated deals, migrate the CIF from old deal to new deal where a CIF does not exist.
			* Use the record from old deal and create a record for the new deal if the new deal doesn't have CIF for that month
			* The most recent CIF record is used to create the new CIF record based on the migration month
*/

DECLARE @Report_Month		AS DATE	= '2022-12-01'

DECLARE @StartDate			AS DATE	= (SELECT MIN(report_month) AS start_date FROM [dbo].[vw_lk_cif_update_source])
DECLARE @EndDate			AS DATE	= @Report_Month

BEGIN TRAN
INSERT INTO [dbo].[vw_lk_cif_update_source]
(	report_month,
	client_id,
	source_code,
	bin,
	currency,
	monthly_unit_price,
	total
)
SELECT sc.report_month,
	   sc.client_id,
	   sc.source_code,
	   sc.bin,
	   sc.currency,
	   sc.monthly_unit_price,
	   sc.total
FROM (	-- Get the latest CIF record for the old migrated deals
		SELECT lg.migration_month		AS report_month,
			   lg.nd_client_id			AS client_id,
			   lg.nd_sourcecode_prefix	AS source_code,
			   sc.bin,
			   sc.currency,
			   sc.monthly_unit_price,
			   sc.total,
			   ROW_NUMBER() OVER(PARTITION BY lg.od_client_id ORDER BY sc.report_month DESC)
										AS seq
		FROM [dbo].[vw_lk_cif_update_source] sc 
				INNER JOIN [deals_db].[dbo].[vwMCMigrationsLog] lg ON sc.client_id = lg.od_client_id AND
																	sc.report_month <= lg.od_cancellation_month
		WHERE lg.od_cancellation_date >= lg.migration_date AND
			  lg.od_sourcecode_prefix <> lg.nd_sourcecode_prefix AND
			  sc.report_month BETWEEN @StartDate AND @EndDate
	)	sc
	LEFT JOIN [dbo].[vw_lk_cif_update_source] ex ON ex.client_id = sc.client_id AND
													ex.report_month = sc.report_month
WHERE seq = 1 AND ex.client_id IS NULL;
--(39 rows affected)
-- COMMIT
-- ROLLBACK
--BEGIN TRAN

/*
	STEP 4: Perform the update, insert or delete on target.
			* Update - Update CIF totals that are different
			* Insert - Insert records that don't exist
			[fn_lk_cif_source_combined] parameters:	@StartDate	- Min date from Source table
													@EndDate	- Current report month
*/

/*   ************** check before running **************
SELECT client_id,[Report/CIF Month],COUNT(1) FROM 
[dbo].[tbl_lk_cif_update_source_staging]
GROUP BY client_id,[Report/CIF Month]
HAVING COUNT(1)>1   
order by 1 

if dupes check with the BAU team to update the errors in the ops spread sheet 
--if no work around found use script in below location and discuss with BAU team:
O:\17. Production\Dataloads_47to45_DW\AFTER Audit\MasterCard\DataWarehousing\Data Cleansing\Script_to_remove_designated_dupes_tvl_lk_cif_update_source_staging.sql


*/

DECLARE @Report_Month		AS DATE	= '2022-12-01'


DECLARE @StartDate			AS DATE	= (SELECT MIN(report_month) AS start_date FROM [dbo].[vw_lk_cif_update_source])
DECLARE @EndDate			AS DATE	= @Report_Month

BEGIN TRAN

MERGE	[dbo].[tblLKCIF] t
USING	[dbo].[fn_lk_cif_update_source_combined] (@StartDate, @EndDate)	s
ON		(t.client_id = s.client_id AND t.report_month = s.report_month)
		
		-- Update CIF totals that are different
		WHEN MATCHED AND t.total <> s.total THEN
			 UPDATE
			 SET t.total = s.total
		
		-- Insert records that don't exist
		WHEN NOT MATCHED BY TARGET THEN
			 INSERT (report_month,
					 billing_month,
					 client_id,
					 source_code,
					 bin,
					 currency,
					 monthly_unit_price,
					 total)
			 VALUES (s.report_month,
					 s.billing_month,
					 s.client_id,
					 s.source_code,
					 s.bin,
					 s.currency,
					 s.monthly_unit_price,
					 s.total);
					 --(10071 rows affected)
--(11757 rows affected)--new july 2019
--((9055 rows affected) rows affected)-Aug
--((18167 rows affected) rows affected)-Jan 2020
--((15548+177 rows affected) rows affected)-Feb 2020
--((17051 rows affected) rows affected)-Mar 2020
--((17064 rows affected) rows affected)-Apr 2020
--((22825 rows affected) rows affected)-May 2020
--(23097 rows affected)-June 2020
--(19472 rows affected)-July 2020
--(24463 rows affected)-Aug 2020
--(22815 rows affected)-Sep 2020
--(25472 rows affected)-Oct 2020
--(27888 rows affected)-Nov 2020
--(26752 rows affected)-Dec 2020
--(28524 rows affected)-Jan 2021
--(28958 rows affected)-Feb 2021
--(30480 rows affected)-Mar 2021
--(30955 rows affected)-Apr 2021
--(32128 rows affected)-May 2021
--(35709 rows affected)-Jun 2021
--(33189 rows affected)-Jul 2021
--(34080 rows affected)-Jul 2021
--(35700 rows affected)-Aug 2021
--(38102 rows affected)-Sep 2021
--(39498 rows affected)-Oct 2021
--(41498 rows affected)-Nov 2021
--(41833 rows affected)-Dec 2021
--(44304 rows affected)-Jan 2022
--(44577 rows affected)-Feb 2022
--(43726 rows affected)-Feb 2022v1
--(44302 rows affected)-Feb 2022v2
--(43867 rows affected)-Feb 2022 - OPSBI 116
--(49442 rows affected)-Mar 2022
--(49329 rows affected)-Apr 2022
--(52000 rows affected)-May 2022
--(52137 rows affected)-Jun 2022
--(53281 rows affected)-Jul 2022
--(57455 rows affected)-Aug 2022
--(57032 rows affected)-Sep 2022
--(58741 rows affected)-Oct 2022
--(60518 rows affected)-Nov 2022
--(65454 rows affected)-Dec 2022
-- COMMIT
-- ROLLBACK
--BEGIN TRAN

/*
	STEP 5: Delete overlapping migrated CIF records for migrated deals and CIFs after cancellation date
			Show the deleted data to Benedict in Ops
*/


DECLARE @Report_Month		AS DATE	= '2022-12-01'


DECLARE @StartDate			AS DATE	= (SELECT MIN(report_month) AS start_date FROM [dbo].[vw_lk_cif_update_source])
DECLARE @EndDate			AS DATE	= @Report_Month

BEGIN TRAN


DELETE t
FROM [dbo].[tblLKCIF] t
	 LEFT JOIN [deals_db].[dbo].[vwMCMigrationsLog] l
			ON (t.client_id = l.od_client_id AND t.report_month > l.od_cancellation_month)
			   OR
			   (t.client_id = l.nd_client_id AND t.report_month < l.migration_month)
	 LEFT JOIN [deals_db].[dbo].[dimTblMCDeals] d
			 ON	t.client_id = d.clientid AND 
				d.[status] = 'Cancelled' AND 
				t.report_month > DATEADD(DAY, -(DAY(d.deal_cancellation_date) - 1), d.deal_cancellation_date)
WHERE t.report_month BETWEEN @StartDate AND @EndDate AND
	  (((ISNULL(l.nd_client_id, l.od_client_id) IS NOT NULL OR d.clientid IS NOT NULL) AND
	  l.od_client_id <> l.nd_client_id) OR t.total=0);


-- COMMIT
-- ROLLBACK



--SELECT * FROM [dbo].[vw_lk_cif_update_source] WHERE report_month='2017-04-01' AND source_code like '%LKMCAZTRK%' AND bin='521367'


--SELECT * FROM [dbo].[vw_lk_cif_update_source] WHERE report_month='2017-04-01' AND source_code like '%LKMCOWCITIUK16%'
--(LKMCAZTRK2015521367, 2017-04-01)

