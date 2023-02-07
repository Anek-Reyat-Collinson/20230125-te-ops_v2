-- GM ran this on 22/03/16 

-- HD AWS to ran this on 12/06/20 with @report_month = '2020-05-01': - sucessfully
-- AA AWS to ran this on 19/06/20 with @report_month = '2020-05-01': - sucessfully
-- HD AWS to ran this on 24/06/20 with @report_month = '2020-05-01': - sucessfully
-- HD AWS to ran this on 10/07/20 with @report_month = '2020-06-01': - sucessfully
-- HD AWS to ran this on 07/08/20 with @report_month = '2020-06-01': - sucessfully
-- HD AWS to ran this on 10/08/20 with @report_month = '2020-07-01': - sucessfully
-- HD AWS to ran this on 09/09/20 with @report_month = '2020-08-01': - sucessfully
-- HD AWS to ran this on 07/10/20 with @report_month = '2020-09-01': - sucessfully
-- HD AWS to ran this on 06/11/20 with @report_month = '2020-10-01': - sucessfully
-- HD AWS to ran this on 04/12/20 with @report_month = '2020-11-01': - sucessfully
-- HD AWS to ran this on 07/12/20 with @report_month = '2020-11-01': - sucessfully
-- HD AWS to ran this on 08/01/21 with @report_month = '2020-12-01': - sucessfully
-- HD AWS to ran this on 05/02/21 with @report_month = '2021-01-01': - sucessfully
-- HD AWS to ran this on 05/03/21 with @report_month = '2021-02-01': - sucessfully
-- HD AWS to ran this on 10/03/21 with @report_month = '2021-02-01': - sucessfully -- BIBAU-2734
-- HD AWS to ran this on 09/04/21 with @report_month = '2021-03-01': - sucessfully
-- HD AWS to ran this on 08/05/21 with @report_month = '2021-04-01': - sucessfully
-- HD AWS to ran this on 12/05/21 with @report_month = '2021-04-01': - sucessfully
-- HD AWS to ran this on 07/06/21 with @report_month = '2021-05-01': - sucessfully
-- HD AWS to ran this on 08/07/21 with @report_month = '2021-06-01': - sucessfully
-- HD AWS to ran this on 06/08/21 with @report_month = '2021-07-01': - sucessfully
-- HD AWS to ran this on 07/09/21 with @report_month = '2021-08-01': - sucessfully
-- HD AWS to ran this on 08/10/21 with @report_month = '2021-09-01': - sucessfully
-- HD AWS to ran this on 05/11/21 with @report_month = '2021-10-01': - sucessfully
-- HD AWS to ran this on 03/12/21 with @report_month = '2021-10-01': - sucessfully
-- HD AWS to ran this on 13/12/21 with @report_month = '2021-11-01': - sucessfully
-- HD AWS to ran this on 10/01/22 with @report_month = '2021-12-01': - sucessfully
-- HD AWS to ran this on 14/02/22 with @report_month = '2022-01-01': - sucessfully
-- HD AWS to ran this on 15/02/22 with @report_month = '2022-01-01': - sucessfully OPSBI - 106
-- HD AWS to ran this on 11/03/22 with @report_month = '2022-02-01': - sucessfully
-- HD AWS to ran this on 07/04/22 with @report_month = '2022-03-01': - sucessfully
-- HD AWS to ran this on 27/04/22 with @report_month = '2022-03-01': - sucessfully
-- HD AWS to ran this on 10/05/22 with @report_month = '2022-04-01': - sucessfully
-- HD AWS to ran this on 10/06/22 with @report_month = '2022-05-01': - sucessfully
-- HD AWS to ran this on 13/07/22 with @report_month = '2022-06-01': - sucessfully
-- HD AWS to ran this on 09/08/22 with @report_month = '2022-07-01': - sucessfully
-- HD AWS to ran this on 12/09/22 with @report_month = '2022-08-01': - sucessfully
-- HD AWS to ran this on 12/10/22 with @report_month = '2022-09-01': - sucessfully
-- HD AWS to ran this on 09/11/22 with @report_month = '2022-10-01': - sucessfully
-- HD AWS to ran this on 08/12/22 with @report_month = '2022-11-01': - sucessfully
-- HD AWS to ran this on 11/01/23 with @report_month = '2022-12-01': - sucessfully
-- HD AWS to ran this on 13/01/23 with @report_month = '2022-12-01': - sucessfully
-- HD AWS to ran this on 31/01/23 with @report_month = '2022-11-01': - sucessfully
-- HD AWS to ran this on 07/02/23 with @report_month = '2023-01-01': - sucessfully

/*****************************************
** Project ID	 :  DW - Amex - Step 7
** Author		 :	Hyun Sung Lee
** Last Mofified :	2016-06-13
** Last Mofified by :	Mahesh Chittigari
** Last Mofified description :	Introduced external_identifier as a part of Membership Extension project
******************************************/
DECLARE @report_month AS DATE

-- Set report month
SET @report_month = '2023-01-01'

DELETE FROM amex_dw.dbo.factTblLVFrequency WHERE billing_month_fk = @report_month
--SELECT * FROM  amex_dw.dbo.factTblLVFrequency WHERE billing_month_fk = @report_month order BY 5

INSERT INTO amex_dw.dbo.factTblLVFrequency
(	  [billing_month_fk]
      ,[source_code_fk]
      ,[lounge_code_fk]
      ,[consumer_no]
      ,[member_visits]
	  ,[external_identifier]
      )
SELECT 
	x.billing_month_fk,
	x.source_code_fk,	
	x.lounge_code_fk,
	x.consumer_no,
	SUM(x.member_visits) AS member_visits,
	[external_identifier]	
FROM	
	(SELECT CAST(report_month AS DATE) AS billing_month_fk,visit_source_code AS source_code_fk,lounge_code AS lounge_code_fk,
			CONVERT(VARCHAR(20),CONVERT(DECIMAL(20,0),consumer_no)) AS consumer_no,1 AS member_visits,[external_identifier]
	 FROM amex_billing_db_va.dbo.tblLoungeVisits
	 LEFT JOIN amex_dw.dbo.dimTblSourceCodes sc ON tblLoungeVisits.visit_source_code = sc.source_code_pk
	 WHERE sc.source_code_pk IS NOT NULL AND report_month = @report_month
	 GROUP BY report_month,visit_source_code,lounge_code,consumer_no,external_identifier			
	 UNION
	 SELECT CAST([Report Month] AS DATE) as billing_month_fk,[Source Code] AS source_code_fk,[Lounge Code] AS lounge_code_fk,
			CONVERT(VARCHAR(20),CONVERT(DECIMAL(20,0),[Member Id])) AS consumer_no,1 AS member_visits,[external_identifier]
	 FROM amex_associates_db.dbo.tblLoungeVisits
	 LEFT JOIN amex_dw.dbo.dimTblSourceCodes sc ON tblLoungeVisits.[Source Code] = sc.source_code_pk
	 WHERE sc.source_code_pk IS NOT NULL AND [Report Month] = @report_month
	 GROUP BY [Report Month],[Source Code],[Lounge Code],[Member Id],[external_identifier]) AS x

GROUP BY
	x.billing_month_fk,
	x.source_code_fk,	
	x.lounge_code_fk,
	x.consumer_no,
	x.[external_identifier]

ORDER BY
	x.billing_month_fk ASC,
	x.source_code_fk ASC,	
	x.lounge_code_fk ASC,
	x.consumer_no ASC,
	x.[external_identifier] ASC