/*******************************************************************************************************************************
** Project ID	 : MasterCard quick check for duplicates before trying to import Deals from HAPPI
** Author        : Greg
** Last Mofified : 2016-03-17
** Amend History : GM 17/03/2016 Changes to use 127.0.0.1,41331

** Run history   :	GM 17/03/2016 Ran successfully for Jab & Feb data
					GM 19/04/2016 Ran successfully for Mar data
*******************************************************************************************************************************/

-- Quick check for duplicates before trying to import from HAPPI
SELECT 
	COUNT([clientid]),
	[clientid]
FROM [127.0.0.1,41331].deals_db.dbo.dimTblMCDeals
GROUP BY [clientid]
HAVING COUNT([clientid])>1




