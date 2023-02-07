/*******************************************************************************************************************************
** Project ID	 : MasterCard quick check for duplicates before trying to import Deals from HAPPI
** Author        : Greg
** Last Mofified : 2016-03-17
** Amend History : GM 17/03/2016 Changes to use 127.0.0.1,41331

** Run history   :	GM 17/03/2016 Ran successfully for Jab & Feb data
					GM 19/04/2016 Ran successfully for Mar data
					GM 05/05/2016 Ran successfully for Apr data
					GM 16/06/2016 Ran successfully for May data
					AE 14/07/2016 Ran successfully for June data
					AE 12/08/2016 Ran successfully for July data
					AE 22/09/2016 Ran successfully for August data
					AE 20/10/2016 Ran successfully for September data
					GM 14/11/2016 Ran successfully for October data
					AE 15/12/2016 Ran successfully for November data
					AE 16/01/2017 Ran successfully for December data
					AE 17/02/2017 Ran successfully for Jan data
					VP 17/03/2017 Ran successfully for Feb data
					AE 17/04/2017 Ran successfully for Mar data
					VP 12/05/2017 Ran successfully for Apr data
					AE 13/06/2017 Ran successfully for May data
					AE 14/07/2017 Ran successfully for Jun data
					AE 11/08/2017 Ran successfully for JuL data
					AA 13/10/2017 Ran successfully for SEP data--no duplicates
					AA 14/11/2017 Ran successfully for OCT data--no duplicates
					AA 12/12/2017 Ran successfully for NOV data--no duplicates
					AA 11/01/2018 Ran successfully for DEC data--no duplicates
					AA 12/02/2018 Ran successfully for Jan data--no duplicates
					AA 13/03/2018 Ran successfully for Feb data--no duplicates
					AA 13/04/2018 Ran successfully for Mar data--no duplicates
					AA 23/05/2018 Ran successfully for Apr data--no duplicates
					
*******************************************************************************************************************************/

-- Quick check for duplicates before trying to import from HAPPI
SELECT 
	COUNT([clientid]),
	[clientid]
FROM deals_db.dbo.dimTblMCDeals
GROUP BY [clientid]
HAVING COUNT([clientid])>1




