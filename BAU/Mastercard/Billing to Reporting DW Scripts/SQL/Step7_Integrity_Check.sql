
/*------------------------------------ Run history -------------------------------------------------
--Run history:	17/03/2016	GM	Ran ok 
				19/04/2016	GM	Ran ok 
				16/05/2016	GM	Ran ok 
				16/06/2016	GM	Ran ok 
				14/11/2016	GM	Ran ok 
				16/01/2017	AE	Ran ok 
				17/02/2017	AE	Ran ok
				17/03/2017	VP	Ran ok
				13/04/2017	AE	Ran ok
				25/04/2017	VP	Ran ok -- Re run BI -384
				12/05/2017	VP	Ran ok 
				14/06/2017	AE	Ran ok
				14/07/2017	AE	Ran ok
				11/08/2017	AE	Ran ok
				14/09/2017	vp	Ran ok
				13/10/2017	AA	Missing record in dimTblLoungeData- lounge_code ='SJO2'-Kevin updated the rec in Happi and AA moved to 45 and DW
				14/11/2017	AA Ran ok--added check missing experience_category_fk and experience_type_fk--fixed as a part of https://jira.ptgmis.com/browse/BIBAU-447
				14/12/2017	AA Ran ok
				11/01/2018	AA Ran ok
				13/02/2018	AA Ran ok
				13/03/2018	AA Ran ok
--------------------------------------------------------------------------------------------------*/
/*****************************************
** Project ID	 :  DW - MCI - Step 7
** Author		 :	Hyun Sung Lee
** Last Mofified :	2015-05-28
******************************************/

-- Check missing deals in fact tables
SELECT tb.*
FROM (SELECT DISTINCT associate_prefix, 'CF' AS [account] FROM mastercard_dw.dbo.factTblCIF
	  UNION ALL
	  SELECT DISTINCT associate_code_fk, 'Frequency' AS [account] FROM mastercard_dw.dbo.factTblLVFrequency
	  UNION ALL
	  SELECT DISTINCT associate_code_fk, 'Frequency' AS [account] FROM mastercard_dw.dbo.factTblLVFrequency
	 ) tb
LEFT JOIN mastercard_dw.dbo.dimTblMCIDeals dl ON dl.clientid = tb.associate_prefix
WHERE dl.clientid IS NULL
ORDER BY tb.account,tb.associate_prefix

-- Check missing lounges in fact tables
SELECT DISTINCT(tb.lounge_code_fk)
FROM mastercard_dw.dbo.factTblLoungeVisits tb
LEFT JOIN lounge_db.dbo.dimTblLoungeData ld ON ld.lounge_code = tb.lounge_code_fk
WHERE ld.lounge_code IS NULL

-- Check missing airports in fact tables/*<AA,20/11/17>-commenting out the code as the check needs to be done factTblLoungeVisits*/
--SELECT tb.
--FROM mastercard_db.dbo.tblLoungeVisits tb
--LEFT JOIN lounge_db.dbo.dimTblLoungeData ld	ON ld.lounge_code = tb.LoungeCode
--LEFT JOIN lounge_db.dbo.dimTblAirports ap ON ap.lounge_airport_code = ld.lounge_airport_code
--WHERE ap.lounge_airport_code IS NULL


SELECT tb.*
FROM mastercard_dw.dbo.factTblLoungeVisits tb
LEFT JOIN lounge_db.dbo.dimTblLoungeData ld	ON ld.lounge_code = tb.Lounge_Code_fk
LEFT JOIN lounge_db.dbo.dimTblAirports ap ON ap.lounge_airport_code = ld.lounge_airport_code
WHERE ap.lounge_airport_code IS NULL

---check missing experience_category_fk and experience_type_fk


SELECT DISTINCT  LV.experience_category_fk FROM mastercard_dw.dbo.factTblLoungeVisits LV 
LEFT JOIN mastercard_dw.dbo.dimTblExperienceCategory EC ON EC.experience_category_fk = LV.experience_category_fk
WHERE EC.experience_category_fk IS null

SELECT DISTINCT  LV.experience_type_fk FROM mastercard_dw.dbo.factTblLoungeVisits LV 
LEFT JOIN mastercard_dw.dbo.dimTblExperienceType EC  ON EC.experience_type_fk = LV.experience_type_fk
WHERE EC.experience_type_fk IS NULL



