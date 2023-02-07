/*****************************************************************************************************************************************************
** Project ID	 :  DW - Amex - Step 5 
** Description   :	Popultate amex_dw.dbo.factTblLoungeVisits from tblLoungeVisits AND
** Author		 :	Hyun Sung Lee
** Last Mofified :	2015-09-09
					2016-06-21 GM moved insert for GNS associates into this step (this was previously done as a seperate step called STEP6)
** Run History   :	GM ran this on 22/03/16
					
					HD AWS to ran this on 12/06/20 successfully (no problems) @report_month = '2020-05-01'
					AA AWS to ran this on 19/06/20 successfully (no problems) @report_month = '2020-05-01'
					HD AWS to ran this on 24/06/20 successfully (no problems) @report_month = '2020-05-01'
					HD AWS to ran this on 09/07/20 successfully (no problems) @report_month = '2020-06-01'
					HD AWS to ran this on 07/08/20 successfully (no problems) @report_month = '2020-06-01'
					HD AWS to ran this on 10/08/20 successfully (no problems) @report_month = '2020-07-01'
					HD AWS to ran this on 09/09/20 successfully (no problems) @report_month = '2020-08-01'
					HD AWS to ran this on 07/10/20 successfully (no problems) @report_month = '2020-09-01'
					HD AWS to ran this on 06/11/20 successfully (no problems) @report_month = '2020-10-01'
					HD AWS to ran this on 04/12/20 successfully (no problems) @report_month = '2020-11-01'
					HD AWS to ran this on 07/12/20 successfully (no problems) @report_month = '2020-11-01'
					HD AWS to ran this on 08/01/21 successfully (no problems) @report_month = '2020-12-01'
					HD AWS to ran this on 05/02/21 successfully (no problems) @report_month = '2021-01-01'
					HD AWS to ran this on 05/03/21 successfully (no problems) @report_month = '2021-02-01'
					HD AWS to ran this on 10/03/21 successfully (no problems) @report_month = '2021-02-01' -- BIBAU-2734
					HD AWS to ran this on 09/04/21 successfully (no problems) @report_month = '2021-03-01'
					HD AWS to ran this on 08/05/21 successfully (no problems) @report_month = '2021-04-01'
					HD AWS to ran this on 12/05/21 successfully (no problems) @report_month = '2021-04-01'
					HD AWS to ran this on 07/06/21 successfully (no problems) @report_month = '2021-05-01'
					HD AWS to ran this on 08/07/21 successfully (no problems) @report_month = '2021-06-01'
					HD AWS to ran this on 06/08/21 successfully (no problems) @report_month = '2021-07-01'
					HD AWS to ran this on 07/09/21 successfully (no problems) @report_month = '2021-08-01'
					HD AWS to ran this on 08/10/21 successfully (no problems) @report_month = '2021-09-01'
					HD AWS to ran this on 05/11/21 successfully (no problems) @report_month = '2021-10-01'
					HD AWS to ran this on 03/12/21 successfully (no problems) @report_month = '2021-10-01'
					HD AWS to ran this on 13/12/21 successfully (no problems) @report_month = '2021-11-01'
					HD AWS to ran this on 10/01/22 successfully (no problems) @report_month = '2021-12-01'
					HD AWS to ran this on 14/02/22 successfully (no problems) @report_month = '2022-01-01'
					HD AWS to ran this on 15/02/22 successfully (no problems) @report_month = '2022-01-01' OPSBI - 106
					HD AWS to ran this on 11/03/22 successfully (no problems) @report_month = '2022-02-01'
					HD AWS to ran this on 07/04/22 successfully (no problems) @report_month = '2022-03-01'
					HD AWS to ran this on 27/04/22 successfully (no problems) @report_month = '2022-03-01'
					HD AWS to ran this on 10/05/22 successfully (no problems) @report_month = '2022-04-01'
					HD AWS to ran this on 10/06/22 successfully (no problems) @report_month = '2022-05-01'
					HD AWS to ran this on 13/07/22 successfully (no problems) @report_month = '2022-06-01'
					HD AWS to ran this on 09/08/22 successfully (no problems) @report_month = '2022-07-01'
					HD AWS to ran this on 12/09/22 successfully (no problems) @report_month = '2022-08-01'
					HD AWS to ran this on 12/10/22 successfully (no problems) @report_month = '2022-09-01'
					HD AWS to ran this on 09/11/22 successfully (no problems) @report_month = '2022-10-01'
					HD AWS to ran this on 08/12/22 successfully (no problems) @report_month = '2022-11-01'
					HD AWS to ran this on 11/01/23 successfully (no problems) @report_month = '2022-12-01'
					HD AWS to ran this on 13/01/23 successfully (no problems) @report_month = '2022-12-01'
					HD AWS to ran this on 31/01/23 successfully (no problems) @report_month = '2022-11-01'
					HD AWS to ran this on 07/02/23 successfully (no problems) @report_month = '2023-01-01'
					
*********************************************************************************************************************************************************/
USE amex_billing_db_va


DECLARE @report_month AS DATE
DECLARE @NumRecs		INT


-- Set report month
SET @report_month = '2023-01-01'

--If data exists for this month delete it and then reload
SET @NumRecs = (SELECT COUNT(*) FROM amex_dw.dbo.factTblLoungeVisits WHERE billing_month_fk = @report_month)
SELECT @NumRecs

IF @NumRecs>0
	BEGIN
		PRINT 'Data exists for this month so delete it and reload'
		DELETE FROM amex_dw.dbo.factTblLoungeVisits WHERE billing_month_fk = @report_month
	END	

-------------------------------------------------------------------------------------------------------------------------------------------
-- Insert LV (amex_billing_db_va.dbo.tblLoungeVisits lv)
-------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO amex_dw.dbo.factTblLoungeVisits
( [billing_month_fk]
      ,[source_code_fk]
      ,[lounge_code_fk]
      ,[member_visits_amex_pays]
      ,[guest_visits_amex_pays]
      ,[total_visits_mg_amex_pays]
      ,[currency_fk]
      ,[visit_fee_fk]
      ,[total_member_fee_ax_pays]
      ,[total_guest_fee_ax_pays]
      ,[total_fee_member_guest_ax_pays]
      ,[member_visits_cm_pays]
      ,[guest_visits_cm_pays]
      ,[total_visits_mg_cm_pays]
      ,[member_fee_cm_pays_fk]
      ,[cm_pays_gv_currency_fk]
      ,[total_member_fee_cm_pays]
      ,[total_guest_visit_fee_cm_pays]
      ,[total_fee_cm_pays]
      ,[total_member_visits]
      ,[total_guest_visits]
      ,[total_member_guest_visits]
      ,[domestic_international_fk]
      )
SELECT	
	lv.report_month AS billing_month_fk,
	lv.visit_source_code AS source_code_fk,
	lv.lounge_code AS lounge_code_fk,	
	
	-- Amex paying
	SUM(lv.amex_pays_member_visits) AS member_visits_amex_pays,
	SUM(lv.amex_pays_guest_visits) AS guest_visits_amex_pays,
	SUM(lv.amex_pays_member_visits + lv.amex_pays_guest_visits) AS total_visits_mg_amex_pays,

	lv.amex_pays_member_visit_currency AS currency_fk,
	lv.amex_pays_member_visit_fee AS visit_fee_fk,
	SUM(lv.amex_pays_member_visit_fee * lv.amex_pays_member_visits) AS total_member_fee_ax_pays,
	SUM(lv.amex_pays_guest_visit_fee * lv.amex_pays_guest_visits) AS total_guest_fee_ax_pays,
	SUM((lv.amex_pays_member_visit_fee * lv.amex_pays_member_visits) + (lv.amex_pays_guest_visit_fee * lv.amex_pays_guest_visits)) AS total_fee_member_guest_ax_pays,

	-- Cardmember paying
	SUM(lv.cm_pays_member_visits) AS member_visits_cm_pays,
	SUM(lv.cm_pays_guest_visits) AS guest_visits_cm_pays,
	SUM(lv.cm_pays_member_visits + lv.cm_pays_guest_visits) AS total_visits_mg_cm_pays,

	lv.cm_pays_member_visit_fee AS member_fee_cm_pays,
	lv.cm_pays_guest_visit_currency AS cm_pays_gv_currency_fk,
	SUM(lv.cm_pays_member_visit_fee * lv.cm_pays_member_visits) AS total_member_fee_cm_pays,
		
	SUM(lv.cm_pays_guest_visit_fee * lv.cm_pays_guest_visits)AS total_guest_visit_fee_cm_pays,
	SUM((lv.cm_pays_member_visit_fee * lv.cm_pays_member_visits)+(lv.cm_pays_guest_visit_fee * lv.cm_pays_guest_visits))AS total_fee_cm_pays,

	-- Total visits
	SUM(lv.total_member_visits) AS total_member_visits,
	SUM(lv.total_guest_visits) AS total_guest_visits,
	SUM(lv.total_member_visits + lv.total_guest_visits) AS total_mg_visits,
	
	CASE
		WHEN con_visit.country_iso_code_3 = con_issue.country_iso_code_3 THEN 1 /*Domestic*/ ELSE 2 /*International*/
	END AS domestic_international_fk			
	
FROM amex_billing_db_va.dbo.tblLoungeVisits lv

LEFT JOIN amex_dw.dbo.dimTblSourceCodes sc ON sc.source_code_pk = lv.visit_source_code
LEFT JOIN lounge_db.dbo.dimTblCountries con_issue ON con_issue.country_iso_code_3 = sc.issuing_country_iso_3
LEFT JOIN lounge_db.dbo.dimTblLoungeData ldata ON lv.lounge_code = ldata.lounge_code
LEFT JOIN lounge_db.dbo.dimTblCountries con_visit ON con_visit.country_iso_code_3 = ldata.lounge_country_iso_3
	
WHERE sc.source_code_pk IS NOT NULL AND report_month = @report_month

GROUP BY
	lv.report_month,
	lv.amex_pays_member_visit_currency,
	lv.visit_source_code,			
	con_visit.country_iso_code_3,
	con_issue.country_iso_code_3,
	lv.lounge_code,			
	lv.cm_pays_guest_visit_currency,
	lv.cm_pays_member_visit_fee,
	lv.amex_pays_member_visit_fee


-------------------------------------------------------------------------------------------------------------------------------------------
-- Insert GNS Associates LV (amex_associates_db.dbo.tblLoungeVisits lv)
-------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO amex_dw.dbo.factTblLoungeVisits
([billing_month_fk]
      ,[source_code_fk]
      ,[lounge_code_fk]
      ,[member_visits_amex_pays]
      ,[guest_visits_amex_pays]
      ,[total_visits_mg_amex_pays]
      ,[currency_fk]
      ,[visit_fee_fk]
      ,[total_member_fee_ax_pays]
      ,[total_guest_fee_ax_pays]
      ,[total_fee_member_guest_ax_pays]
      ,[member_visits_cm_pays]
      ,[guest_visits_cm_pays]
      ,[total_visits_mg_cm_pays]
      ,[member_fee_cm_pays_fk]
      ,[cm_pays_gv_currency_fk]
      ,[total_member_fee_cm_pays]
      ,[total_guest_visit_fee_cm_pays]
      ,[total_fee_cm_pays]
      ,[total_member_visits]
      ,[total_guest_visits]
      ,[total_member_guest_visits]
      ,[domestic_international_fk]
)
SELECT
	lv.[Report Month] AS billing_month_fk,
	lv.[Source Code] AS source_code_fk,
	lv.[Lounge Code] AS lounge_code_fk,
	
	-- Amex paying
	COUNT(*) AS member_visits_amex_pays,
	0 AS guest_visits_amex_pays,
	COUNT(*) + 0 AS total_visits_mg_amex_pays,

	lv.Currency as currency_code_fk,
	lv.[Visit Fee] as visit_fee_fk,

	SUM(lv.[Visit Fee]) AS total_member_fee_ax_pays,
	0 AS total_guest_fee_ax_pays,
	SUM(lv.[Visit Fee]) + 0 AS total_fee_member_guest_ax_pays,

	-- Cardmember paying
	0 AS member_visits_cm_pays,
	SUM(lv.[Total Guests]) AS guest_visits_cm_pays,
	SUM(lv.[Total Guests])+ 0 AS total_visits_mg_cm_pays,
	
	0 AS member_fee_cm_pays_fk,
	lv.Currency AS cm_pays_gv_currency_fk,

	0 AS total_member_fee_cm_pays,
	SUM(lv.[Total Guest Fee]) AS total_guest_visit_fee_cm_pays,
	0 + SUM(lv.[Total Guest Fee]) AS total_fee_cm_pays,

	-- Total visits
	COUNT(*) AS total_member_visits,
	SUM(lv.[Total Guests]) AS total_guest_visits,
	SUM(lv.[Total Guests]+1) AS total_member_guest_visits,
	CASE WHEN sc.issuing_country_iso_3 = ld.lounge_country_iso_3 THEN 1 ELSE 2 END AS domestic_international_fk		

FROM amex_associates_db.dbo.tblLoungeVisits lv

LEFT JOIN lounge_db.dbo.dimTblLoungeData ld ON ld.lounge_code = lv.[Lounge Code]	
LEFT JOIN amex_dw.dbo.dimTblSourceCodes sc ON sc.source_code_pk = lv.[Source Code]	

WHERE lv.[Source Code] IS NOT NULL AND lv.[Report Month] = @report_month 

GROUP BY
	lv.[Report Month],
	lv.[Source Code],
	sc.Market,
	lv.[Lounge Code],
	lv.Currency,
	lv.[Visit Fee],	
	sc.issuing_country_iso_3,
	ld.lounge_country_iso_3

