
--HD ran 20/07/2020 NO records retrieved
--HD ran 17/08/2020 NO records retrieved
--HD ran 17/09/2020 NO records retrieved
--HD ran 16/10/2020 NO records retrieved
--HD ran 17/11/2020 NO records retrieved
--HD ran 15/12/2020 NO records retrieved
--HD ran 18/01/2021 NO records retrieved  -- DI-907
--HD ran 18/01/2021 NO records retrieved
--HD ran 16/02/2021 NO records retrieved
--HD ran 15/03/2021 NO records retrieved
--HD ran 15/03/2021 NO records retrieved- Nov 20 BIBAU-2735
--HD ran 15/03/2021 NO records retrieved- Dec 20 BIBAU-2735
--HD ran 16/04/2021 NO records retrieved
--HD ran 14/05/2021 NO records retrieved
--HD ran 17/05/2021 NO records retrieved - Jan 21 OPSBI-12
--HD ran 17/05/2021 NO records retrieved - Feb 21 OPSBI-12
--HD ran 18/06/2021 NO records retrieved
--HD ran 19/07/2021 NO records retrieved
--HD ran 19/07/2021 NO records retrieved - Apr 21 OPSBI-62
--HD ran 19/07/2021 NO records retrieved - May 21 OPSBI-62
--HD ran 13/08/2021 NO records retrieved
--HD ran 25/08/2021 NO records retrieved - OPSBI-69
--HD ran 15/09/2021 NO records retrieved
--HD ran 18/10/2021 NO records retrieved
--HD ran 12/11/2021 NO records retrieved
--HD ran 16/12/2021 NO records retrieved
--HD ran 19/01/2022 NO records retrieved
--HD ran 16/02/2022 NO records retrieved
--HD ran 18/03/2022 NO records retrieved
--HD ran 20/04/2022 NO records retrieved
--HD ran 20/04/2022 NO records retrieved OPSBI-118
--HD ran 20/04/2022 NO records retrieved OPSBI-118
--HD ran 17/05/2022 NO records retrieved
--HD ran 18/05/2022 NO records retrieved OPSBI-118
--HD ran 18/05/2022 NO records retrieved OPSBI-118
--HD ran 20/06/2022 NO records retrieved
--HD ran 15/07/2022 NO records retrieved
--HD ran 15/07/2022 NO records retrieved OPSBI-118
--HD ran 17/08/2022 NO records retrieved
--HD ran 19/08/2022 NO records retrieved
--HD ran 19/08/2022 NO records retrieved
--HD ran 20/09/2022 NO records retrieved
--HD ran 17/10/2022 NO records retrieved
--HD ran 07/11/2022 NO records retrieved OPSBI-145
--HD ran 07/11/2022 NO records retrieved Apr 22 OPSBI-145
--HD ran 09/11/2022 NO records retrieved May 22 OPSBI-145
--HD ran 09/11/2022 NO records retrieved Jun 22 OPSBI-145
--HD ran 09/11/2022 NO records retrieved Jul 22 OPSBI-145
--HD ran 09/11/2022 NO records retrieved Aug 22 OPSBI-145
--HD ran 09/11/2022 NO records retrieved Sep 22 OPSBI-145
--HD ran 17/11/2022 NO records retrieved
--HD ran 18/12/2022 NO records retrieved

USE visa_dw
GO

SELECT DISTINCT V.billing_month_fk,V.associate_prefix, D.clientid 
FROM tblfactLoungeVisits V
	LEFT JOIN dbo.dimTblDeals D
		ON V.associate_prefix=D.clientid
WHERE 1=1
	AND D.clientid IS NULL
	--AND V.associate_prefix = '436526'
ORDER BY 1,2 DESC