/*******************************************************************************************************************************
** Project ID	 : Step 0b Visa Data Check prior to loading
** Author        : Greg
** Amend History : GM 20/04/2016 Initial version

** Run history   :	GM 20/04/2016 Ran successfully 
					
					HD 20/07/2020 Ran successfully -run for Jun 2020
					HD 17/08/2020 Ran successfully -run for Jul 2020
					HD 17/09/2020 Ran successfully -run for Aug 2020
					HD 16/10/2020 Ran successfully -run for Sep 2020
					HD 17/11/2020 Ran successfully -run for Oct 2020
					HD 15/12/2020 Ran successfully -run for Nov 2020
					HD 18/01/2021 Ran successfully -run for Nov 2020   ---DI-907
					HD 18/01/2021 Ran successfully -run for Dec 2020
					HD 16/02/2021 Ran successfully -run for Jan 2021
					HD 15/03/2021 Ran successfully -run for Feb 2021
					HD 15/03/2021 Ran successfully -run for Feb 2020- Nov 20 BIBAU-2735
					HD 15/03/2021 Ran successfully -run for Mar 2020- Dec 20 BIBAU-2735
					HD 16/04/2021 Ran successfully -run for Mar 2021
					HD 14/05/2021 Ran successfully -run for Apr 2021
					HD 17/05/2021 Ran successfully -run for Jan 2021 - OPSBI-12
					HD 17/05/2021 Ran successfully -run for Feb 2021 - OPSBI-12
					HD 18/06/2021 Ran successfully -run for May 2021
					HD 19/07/2021 Ran successfully -run for Jun 2021
					HD 19/07/2021 Ran successfully -run for Apr 2021 - OPSBI-62
					HD 19/07/2021 Ran successfully -run for May 2021 - OPSBI-62
					HD 13/08/2021 Ran successfully -run for Jul 2021
					HD 25/08/2021 Ran successfully -run for Jun 2021
					HD 15/09/2021 Ran successfully -run for Aug 2021
					HD 18/10/2021 Ran successfully -run for Sep 2021
					HD 12/11/2021 Ran successfully -run for Oct 2021
					HD 16/12/2021 Ran successfully -run for Nov 2021
					HD 19/01/2022 Ran successfully -run for Dec 2021
					HD 16/02/2022 Ran successfully -run for Jan 2022
					HD 18/03/2022 Ran successfully -run for Feb 2022
					HD 20/04/2022 Ran successfully -run for Mar 2022
					HD 20/04/2022 Ran successfully -run for Dec 2021 - OPSBI-118
					HD 20/04/2022 Ran successfully -run for Jan 2022 - OPSBI-118
					HD 17/05/2022 Ran successfully -run for Apr 2022
					HD 18/05/2022 Ran successfully -run for Oct 2021 - OPSBI-118
					HD 18/05/2022 Ran successfully -run for Nov 2021 - OPSBI-118
					HD 20/06/2022 Ran successfully -run for May 2022
					HD 15/07/2022 Ran successfully -run for Jun 2022
					HD 15/07/2022 Ran successfully -run for Sep 2021 OPSBI-118
					HD 16/08/2022 Ran successfully -run for Jul 2022
					HD 19/08/2022 Ran successfully -run for Jul 2022
					HD 19/08/2022 Ran successfully -run for Feb 2022
					HD 20/09/2022 Ran successfully -run for Aug 2022
					HD 17/10/2022 Ran successfully -run for Sep 2022
					HD 07/11/2022 Ran successfully -run for Mar 2022 OPSBI-145
					HD 07/11/2022 Ran successfully -run for Apr 2022 OPSBI-145
					HD 09/11/2022 Ran successfully -run for May 2022 OPSBI-145
					HD 09/11/2022 Ran successfully -run for Jun 2022 OPSBI-145
					HD 09/11/2022 Ran successfully -run for Jul 2022 OPSBI-145
					HD 09/11/2022 Ran successfully -run for Aug 2022 OPSBI-145
					HD 09/11/2022 Ran successfully -run for Sep 2022 OPSBI-145
					HD 17/11/2022 Ran successfully -run for Oct 2022
					HD 17/11/2022 Ran successfully -run for Nov 2022
********************************************************************************************************************************/

SELECT * FROM [10.204.200.112\OPSLIVEDB,49214].deals_db.dbo.dimTblVSDeals D
WHERE D.ClientID IN 
	(
		SELECT xx.clientid from
			(
				SELECT clientid,COUNT(clientid) AS Cnt 
				FROM [10.204.200.112\OPSLIVEDB,49214].deals_db.dbo.dimTblVSDeals 
				GROUP BY clientid
				HAVING COUNT(clientid) >1
			) AS xx
	)ORDER BY D.clientid
	

/*

SELECT * FROM [127.0.0.1,41331].deals_db.dbo.dimTblVSDeals WHERE clientid = 'LKVSINF2014441180'
SELECT * FROM visa_dw.dbo.dimTblDeals WHERE clientid = 'LKVSINF2014441180'

*/
