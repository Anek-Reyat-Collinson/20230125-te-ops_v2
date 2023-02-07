
/*****************************************
** Project ID	 :  DW - Amex - Step 9
** Author        :	Abbas
** Last Mofified :	2018-10-09
** Last Mofified by :	
** Last Mofified description :	
******************************************/

--check missing lounges

USE amex_dw


SELECT DISTINCT(tb.lounge_code_fk)
FROM amex_dw.dbo.factTblLoungeVisits tb
LEFT JOIN lounge_db.dbo.dimTblLoungeData ld ON ld.lounge_code = tb.lounge_code_fk
WHERE ld.lounge_code IS NULL



SELECT DISTINCT
                cm_pays_gv_currency_fk AS Missing_key_value
            FROM amex_dw.dbo.factTblLoungeVisits tc
                LEFT JOIN amex_dw.dbo.dimTblCurrency tm
                    ON tc.cm_pays_gv_currency_fk = tm.currency_code
            WHERE tm.currency_code IS NULL
          
     
    --***amex check before cube processing 
SELECT * FROM 
 [amex_associates_db].[dbo].[tblLoungeVisits]
Where [Report Month]= '2023-01-01'
and  Currency in ('USD','GBP')

--IF yes USE the below scrips as per Anek
----commit

--Begin Trans
-- Update [amex_associates_db].[dbo].[tblLoungeVisits]
-- Set Currency = 'US' and [Report Month]= '2019-01-01'
-- Where Currency = 'USD'
----commit

--Begin Trans
-- Update [amex_associates_db].[dbo].[tblLoungeVisits]
-- Set Currency = 'LS'
-- where Currency = 'GBP' and [Report Month]= '2019-01-01'
----commit

----total records to be updated for 2019-01-01 = 56435 (edited) 
            


