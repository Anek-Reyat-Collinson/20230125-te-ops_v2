/*
change date in the Expr1 to previous reporting month manually before running the script
*/


use diners_billing_db

/*Fanchises to Add*/
begin tran
INSERT INTO tblFranchises ( bin_number, card_type, franchise_code, franchise_name, issuing_country_code_numeric, issuing_country_name, franchise_joining_date, franchise_leaving_date, source_code )
SELECT 
tblTempBinRanges.[BIN NUMBER], 
tblTempBinRanges.[CARD TYPE], 
tblTempBinRanges.[FRANCHISE CODE], 
tblTempBinRanges.[FRANCHISE NAME], tblTempBinRanges.[FRANCHISE ISSUING COUNTRY CODE], 
tblTempBinRanges.[FRANCHISE ISSUING COUNTRY], 
'2023-01-01 00:00:00.000' AS Expr1,   --change date to previous reporting month
'2029-12-31 00:00:00.000' AS Expr2,
 tblTempBinRanges.[SOURCE CODE]
FROM tblFranchises RIGHT JOIN tblTempBinRanges ON tblFranchises.bin_number = tblTempBinRanges.[BIN NUMBER]
WHERE (((tblFranchises.bin_number) Is Null));--(6 rows affected)

--commit

/*Franchises to Update*/
select * into
Backups.bkup.diners_billing_db_dbo_tblFranchises_HD_02_02_2023
from tblFranchises--(4401 rows affected)



begin tran

UPDATE tblFranchises
SET source_code = tblTempBinRanges.[SOURCE CODE]
FROM tblTempBinRanges
WHERE tblTempBinRanges.[BIN NUMBER]=  tblFranchises.bin_number 
AND tblTempBinRanges.[SOURCE CODE] <> tblFranchises.source_code --0

--commit
