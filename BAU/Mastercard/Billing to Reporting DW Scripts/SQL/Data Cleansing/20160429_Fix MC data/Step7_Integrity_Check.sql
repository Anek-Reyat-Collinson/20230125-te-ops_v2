
/*------------------------------------ Run history -------------------------------------------------
--Run history:	17/03/2016	GM	Ran ok for 2016-02-01
				19/04/2016	GM	Ran ok for 2016-02-01

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

-- Check missing airports in fact tables
SELECT tb.*
FROM mastercard_db.dbo.tblLoungeVisits tb
LEFT JOIN lounge_db.dbo.dimTblLoungeData ld	ON ld.lounge_code = tb.LoungeCode
LEFT JOIN lounge_db.dbo.dimTblAirports ap ON ap.lounge_airport_code = ld.lounge_airport_code
WHERE ap.lounge_airport_code IS NULL