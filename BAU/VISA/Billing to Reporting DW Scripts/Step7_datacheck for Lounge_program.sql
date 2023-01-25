
--HD ran 20/07/2020 NO records retrieved --example
--HD ran 17/08/2020 NO records retrieved --example
--HD ran 17/09/2020 NO records retrieved --example
--HD ran 16/10/2020 NO records retrieved --example
--HD ran 17/11/2020 NO records retrieved --example
--HD ran 15/12/2020 NO records retrieved --example
--HD ran 18/01/2021 NO records retrieved --example  -- DI-907
--HD ran 18/01/2021 NO records retrieved --example
--HD ran 16/02/2021 NO records retrieved --example
--HD ran 15/03/2021 NO records retrieved --example
--HD ran 15/03/2021 NO records retrieved --example- Nov 20 BIBAU-2735
--HD ran 15/03/2021 NO records retrieved --example- Dec 20 BIBAU-2735
--HD ran 16/04/2021 NO records retrieved --example
--HD ran 14/05/2021 NO records retrieved --example
--HD ran 17/05/2021 NO records retrieved --example - Jan 21 OPSBI-12
--HD ran 17/05/2021 NO records retrieved --example - Feb 21 OPSBI-12
--HD ran 18/06/2021 NO records retrieved --example
--HD ran 19/07/2021 NO records retrieved --example
--HD ran 19/07/2021 NO records retrieved --example - Apr 21 OPSBI-62
--HD ran 19/07/2021 NO records retrieved --example - May 21 OPSBI-62
--HD ran 13/08/2021 NO records retrieved --example
--HD ran 25/08/2021 NO records retrieved --example
--HD ran 15/09/2021 NO records retrieved --example
--HD ran 18/10/2021 NO records retrieved --example
--HD ran 12/11/2021 NO records retrieved --example
--HD ran 16/12/2021 NO records retrieved --example
--HD ran 19/01/2022 NO records retrieved --example
--HD ran 16/02/2022 NO records retrieved --example
--HD ran 18/03/2022 NO records retrieved --example
--HD ran 20/04/2022 NO records retrieved --example
--HD ran 20/04/2022 NO records retrieved --example - OPSBI-118
--HD ran 20/04/2022 NO records retrieved --example - OPSBI-118
--HD ran 17/05/2022 NO records retrieved --example
--HD ran 18/05/2022 NO records retrieved --example - OPSBI-118
--HD ran 18/05/2022 NO records retrieved --example - OPSBI-118
--HD ran 20/06/2022 NO records retrieved --example
--HD ran 15/07/2022 NO records retrieved --example
--HD ran 15/07/2022 NO records retrieved --example OPSBI-118
--HD ran 17/08/2022 NO records retrieved --example
--HD ran 19/08/2022 NO records retrieved --example
--HD ran 19/08/2022 NO records retrieved --example
--HD ran 20/09/2022 NO records retrieved --example
--HD ran 17/10/2022 NO records retrieved --example
--HD ran 07/11/2022 NO records retrieved --example OPSBI-145
--HD ran 07/11/2022 NO records retrieved --example Apr 22 OPSBI-145
--HD ran 09/11/2022 NO records retrieved --example May 22 OPSBI-145
--HD ran 09/11/2022 NO records retrieved --example Jun 22 OPSBI-145
--HD ran 09/11/2022 NO records retrieved --example Jul 22 OPSBI-145
--HD ran 09/11/2022 NO records retrieved --example Aug 22 OPSBI-145
--HD ran 09/11/2022 NO records retrieved --example Sep 22 OPSBI-145
--HD ran 17/11/2022 NO records retrieved --example
--HD ran 18/12/2022 NO records retrieved --example


--checks in visa dw to ensure correct Lounge program is updated ref: https://jira.ptgmis.com/browse/BI-1713



--check for 2 digit program names as all programs should be in full form

USE visa_dw
GO
SELECT * FROM [visa_dw].[dbo].[dimTblAccountType] WHERE LEN(program_name)=2

-------
--check the program names are distinct--3

SELECT DISTINCT program_name FROM [visa_dw].[dbo].[dimTblAccountType]--4  



---check record counts match in happi and .45

SELECT * FROM [visa_dw].[dbo].[dimTblAccountType]--124 rows

SELECT * FROM  [10.204.200.112\OPSLIVEDB,49214].[deals_db].[dbo].[dimTblVSAccountType]  --124 rows

