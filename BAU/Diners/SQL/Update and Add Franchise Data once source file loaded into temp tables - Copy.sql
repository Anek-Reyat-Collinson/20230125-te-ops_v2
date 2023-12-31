
/*Fanchises to Add*/
INSERT INTO tblFranchises ( bin_number, card_type, franchise_code, franchise_name, issuing_country_code_numeric, issuing_country_name, franchise_joining_date, franchise_leaving_date, source_code )
SELECT 
tblTempBinRanges.[BIN NUMBER], 
tblTempBinRanges.[CARD TYPE], 
tblTempBinRanges.[FRANCHISE CODE], 
tblTempBinRanges.[FRANCHISE NAME], tblTempBinRanges.[FRANCHISE ISSUING COUNTRY CODE], 
tblTempBinRanges.[FRANCHISE ISSUING COUNTRY], 
DateSerial(Year(Date()),Month(Date()),1) AS Expr1, 
/31/2029# AS Expr2, tblTempBinRanges.[SOURCE CODE]
FROM tblFranchises RIGHT JOIN tblTempBinRanges ON tblFranchises.bin_number = tblTempBinRanges.[BIN NUMBER]
WHERE (((tblFranchises.bin_number) Is Null));

/*Franchises to Update*/
UPDATE tblFranchises
SET source_code = tblTempBinRanges.[SOURCE CODE]
FROM tblTempBinRanges
WHERE tblTempBinRanges.[BIN NUMBER]=  tblFranchises.bin_number 
AND tblTempBinRanges.[SOURCE CODE] <> tblFranchises.source_code