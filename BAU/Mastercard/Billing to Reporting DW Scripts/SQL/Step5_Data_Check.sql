/*******************************************************************************************************************************
** Project ID	 : MasterCard Data check Step 5
** Author        : Hyun 2015-06-15
** Last Mofified : 2016-03-17
** Amend History : GM 17/03/2016 Changes to use 127.0.0.1,41331

** Run history   :	GM 17/03/2016 Ran successfully for Feb data
					GM 19/04/2016 Ran successfully for Mar data
					GM 16/05/2016 Ran successfully for Apr data
					GM 16/06/2016 Ran successfully for May data	
					GM 14/07/2016 Ran successfully for June data
					AE 12/08/2016 Ran successfully for July data
					AE 22/09/2016 Ran successfully for August data	
					AE 20/10/2016 Ran successfully for September data						
					GM 14/11/2016 Ran successfully for October data	
					AE 15/12/2016 Ran successfully for November data
					AE 16/02/2017 Ran successfully for Jan data							
					VP 17/03/2017 Ran successfully for Feb data	
					AE 13/04/2017 Ran successfully for mAR data	
					VP 12/05/2017 Ran successfully for Apr data	
					AE 13/06/2017 Ran successfully for May data	
					AE 14/07/2017 Ran successfully for June data	
					AE 11/08/2017 Ran successfully for July data
					VP 14/09/2017 Ran successfully for Aug data
					AA 13/10/2017 Ran successfully for Sep data--no records retrieved
					AA 14/11/2017 Ran successfully for OCT data--no records retrieved
					AA 12/12/2017 Ran successfully for Nov data--no records retrieved
					AA 11/01/2018 Ran successfully for Dec data--no records retrieved
					AA 13/02/2018 Ran successfully for jan data--no records retrieved
					AA 13/03/2018 Ran successfully for jFevdata--no records retrieved
					AA 13/04/2018 Ran successfully for mar data--no records retrieved
					
*******************************************************************************************************************************/

SELECT tb.*

FROM (SELECT DISTINCT associate_prefix, 'CF - IA' AS [account] FROM mastercard_db.dbo.tblCIF
	  UNION ALL
	  SELECT DISTINCT associate_prefix, 'CF - DA' AS [account] FROM mastercard_db.dbo.tblDACIF
	  UNION ALL
	  SELECT DISTINCT SourceCode, 'CF - WL' AS [account] FROM mastercard_db.dbo.tblWLLoungeVisits
	  UNION ALL	
	  SELECT DISTINCT associate_prefix, 'CF - WS' AS [account] FROM mastercard_db.dbo.tblWSCIF
	  UNION ALL
	  SELECT DISTINCT client_id, 'CF - LK' AS [account] FROM mastercard_db.dbo.tblLKCIF
	  UNION ALL
	  SELECT DISTINCT associate_prefix, 'LV - IA' AS [account] FROM mastercard_db.dbo.tblLoungeVisits
	  UNION ALL
	  SELECT DISTINCT associateprefix, 'LV - DA' AS [account] FROM mastercard_db.dbo.tblDALoungeVisits
	  UNION ALL
	  SELECT DISTINCT SourceCode, 'LV - WL' AS [account] FROM mastercard_db.dbo.tblWLLoungeVisits
	  UNION ALL	
	  SELECT DISTINCT associate_prefix, 'LV - WS' AS [account] FROM mastercard_db.dbo.tblWSLoungeVisits
	  UNION ALL
	  SELECT DISTINCT client_id, 'LV - LK' AS [account] FROM mastercard_db.dbo.tblLKLoungeVisits
	  UNION ALL
	  SELECT DISTINCT client_id, 'MB - WL' AS [account] FROM mastercard_db.dbo.tblWLMemberships
	) tb
	
LEFT JOIN mastercard_dw.dbo.dimTblMCIDeals dl ON dl.clientid = tb.associate_prefix
	
WHERE dl.clientid IS NULL
	
ORDER BY tb.account,tb.associate_prefix