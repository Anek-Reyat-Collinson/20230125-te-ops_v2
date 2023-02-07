/*******************************************************************************************************************************
** Project ID	 : MasterCard Deal Data Transfer from HAPPI to .45 Step 2
** Author        : Hyun
** Last Mofified : 2016-03-17
** Amend History : GM 17/03/2016 Changes to use 127.0.0.1,41331

** Run history   :	GM 17/03/2016 Ran successfully for Jab & Feb data
					GM 19/04/2016 Ran successfully for Mar data



-- Quick check for duplicates before trying to import from HAPPI
SELECT COUNT([clientid]),[clientid]
FROM [127.0.0.1,41331].deals_db.dbo.dimTblMCDeals
 --WHERE clientid = 'LKMCCITIWPLUS155291200'
 GROUP BY [clientid]
 HAVING COUNT([clientid])>1

*******************************************************************************************************************************/


	
------------------- (Replace) dimTblMCIDeals -------------------
DELETE FROM mastercard_dw.dbo.dimTblMCIDeals
INSERT INTO mastercard_dw.dbo.dimTblMCIDeals
SELECT * FROM [127.0.0.1,41331].deals_db.dbo.dimTblMCDeals

