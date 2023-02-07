/*

-- HD AWS to ran this on 12/06/20 with @report_month = '2020-05-01'
-- AA AWS to ran this on 19/06/20 with @report_month = '2020-05-01'
-- HD AWS to ran this on 24/06/20 with @report_month = '2020-05-01'
-- HD AWS to ran this on 09/07/20 with @report_month = '2020-06-01'
-- HD AWS to ran this on 07/08/20 with @report_month = '2020-06-01'
-- HD AWS to ran this on 10/08/20 with @report_month = '2020-07-01'
-- HD AWS to ran this on 09/09/20 with @report_month = '2020-08-01'
-- HD AWS to ran this on 07/10/20 with @report_month = '2020-09-01'
-- HD AWS to ran this on 06/11/20 with @report_month = '2020-10-01'
-- HD AWS to ran this on 04/12/20 with @report_month = '2020-11-01'
-- HD AWS to ran this on 07/12/20 with @report_month = '2020-11-01'
-- HD AWS to ran this on 08/01/21 with @report_month = '2020-12-01'
-- HD AWS to ran this on 05/02/21 with @report_month = '2021-01-01'
-- HD AWS to ran this on 05/03/21 with @report_month = '2021-02-01'
-- HD AWS to ran this on 10/03/21 with @report_month = '2021-02-01'
-- HD AWS to ran this on 09/04/21 with @report_month = '2021-03-01'
-- HD AWS to ran this on 08/05/21 with @report_month = '2021-04-01'
-- HD AWS to ran this on 12/05/21 with @report_month = '2021-04-01'
-- HD AWS to ran this on 07/06/21 with @report_month = '2021-05-01'
-- HD AWS to ran this on 08/07/21 with @report_month = '2021-06-01'
-- HD AWS to ran this on 06/08/21 with @report_month = '2021-07-01'
-- HD AWS to ran this on 07/09/21 with @report_month = '2021-08-01'
-- HD AWS to ran this on 08/10/21 with @report_month = '2021-09-01'
-- HD AWS to ran this on 05/11/21 with @report_month = '2021-10-01'
-- HD AWS to ran this on 03/12/21 with @report_month = '2021-10-01'
-- HD AWS to ran this on 13/12/21 with @report_month = '2021-11-01'
-- HD AWS to ran this on 10/01/22 with @report_month = '2021-12-01'
-- HD AWS to ran this on 14/02/22 with @report_month = '2022-01-01'
-- HD AWS to ran this on 15/02/22 with @report_month = '2022-01-01' OPSBI - 106
-- HD AWS to ran this on 11/03/22 with @report_month = '2022-02-01'
-- HD AWS to ran this on 07/04/22 with @report_month = '2022-03-01'
-- HD AWS to ran this on 27/04/22 with @report_month = '2022-03-01'
-- HD AWS to ran this on 10/05/22 with @report_month = '2022-04-01'
-- HD AWS to ran this on 10/06/22 with @report_month = '2022-05-01'
-- HD AWS to ran this on 13/07/22 with @report_month = '2022-06-01'
-- HD AWS to ran this on 09/08/22 with @report_month = '2022-07-01'
-- HD AWS to ran this on 12/09/22 with @report_month = '2022-08-01'
-- HD AWS to ran this on 12/10/22 with @report_month = '2022-09-01'
-- HD AWS to ran this on 09/11/22 with @report_month = '2022-10-01'
-- HD AWS to ran this on 08/12/22 with @report_month = '2022-11-01'
-- HD AWS to ran this on 11/01/23 with @report_month = '2022-12-01'
-- HD AWS to ran this on 13/01/23 with @report_month = '2022-12-01'
-- HD AWS to ran this on 31/01/23 with @report_month = '2022-11-01'
-- HD AWS to ran this on 07/02/23 with @report_month = '2023-01-01'
*/																	


/*****************************************
** Project ID	 :  DW - Amex - Step 3
** Author		 :	Hyun Sung Lee
** Last Mofified :	2015-09-09
******************************************/

USE amex_billing_db_va
GO


DECLARE @Numrecs	INT
DECLARE @conString NVARCHAR(500)
DECLARE @report_month AS DATE

SET @report_month = '2023-01-01'


SELECT * from amex_dw.dbo.factTblCIF WHERE [Report_Month_fk] = @report_month

-- build up data warehouse CIF tables
SET @NumRecs = (select count(*) from amex_dw.dbo.factTblCIF WHERE [Report_Month_fk] = @report_month)
SELECT @NumRecs
IF @NumRecs > 0
	BEGIN
		PRINT 'Data Exists for this month in Target: amex_dw.dbo.factTblCIF'
		DELETE from amex_dw.dbo.factTblCIF WHERE [Report_Month_fk] = @report_month
	END

BEGIN
	INSERT INTO amex_dw.dbo.factTblCIF
	([report_month_fk],[source_code_fk],[cards_in_force])  -- AE added these columns as the insert statement need to be specify due to new audit tables
	
	SELECT
		xx.report_month AS report_month_fk,
		xx.source_code_fk,
		xx.cards_in_force
		
	FROM
		(SELECT [Report Month] AS report_month,source_code AS source_code_fk,
		 SUM(CIF) AS cards_in_force
		 FROM amex_billing_db_va.dbo.tblCIFSummary
		 WHERE [Report Month] = @report_month
		 GROUP BY [Report Month], source_code
		 UNION
		 SELECT [Report Month] AS report_month,source_code as source_code_fk,
		 SUM(CIF) AS cards_in_force
		 FROM amex_associates_db.dbo.tblCardsInForce
		 WHERE [Report Month] = @report_month
		 GROUP BY [Report Month], source_code) AS xx

	ORDER BY
		xx.report_month,
		xx.source_code_fk,
		xx.cards_in_force
END
	


