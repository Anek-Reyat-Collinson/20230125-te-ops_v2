/*******************************************************************************************************************************
** Project ID	 : MasterCard Data check Step 5
** Author        : Hyun 2015-06-15
** Last Mofified : 2016-03-17
** Amend History : GM 17/03/2016 Changes to use 127.0.0.1,41331

** Run history   :	GM 17/03/2016 Ran successfully for Feb data
					GM 19/04/2016 Ran successfully for Mar data
					GM 16/05/2016 Ran successfully for Apr data
					GM 16/06/2016 Ran successfully for May data						

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