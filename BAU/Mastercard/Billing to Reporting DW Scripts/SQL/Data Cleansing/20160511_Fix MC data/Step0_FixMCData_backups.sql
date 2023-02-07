------------------------------------------------------------------------------------------------------------
-- Backups
------------------------------------------------------------------------------------------------------------
/*

USE mastercard_dw
GO

--on 45
SELECT * INTO mastercard_dw.bkup.mastercard_dw_factTblCIF_20160429_1035GM 
	FROM mastercard_dw.dbo.factTblCIF with (nolock)

SELECT * INTO mastercard_dw.bkup.mastercard_dw_dimTblMCIDeals_20160429_1035_GM 
	FROM mastercard_dw.dbo.dimTblMCIDeals with (nolock)

-- on Happi
SELECT * INTO [127.0.0.1,41331].[Backups].bkup.mastercard_db_tblLKCIF_20160429_1042_GM 
	FROM [127.0.0.1,41331].mastercard_db.dbo.tblLKCIF with (nolock)
	
*/	






