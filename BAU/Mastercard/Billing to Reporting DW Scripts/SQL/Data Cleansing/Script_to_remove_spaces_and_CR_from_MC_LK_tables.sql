--*********************************************************--
--[mastercard_db].[dbo].[tbl_lk_cif_update_source_staging] 
--*********************************************************--

--Taking the back up of tbl_lk_cif_update_source_staging table 

--SELECT * INTO Backups.bkup.mastercard_db_tbl_lk_cif_update_source_staging_20181213_MC FROM [mastercard_db].[dbo].[tbl_lk_cif_update_source_staging] 

--[Associate Source Code] validation
SELECT
[Associate Source Code],
LEN([Associate Source Code]),
RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([Associate Source Code], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ','')),
LEN(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([Associate Source Code], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))) 
FROM [mastercard_db].[dbo].[tbl_lk_cif_update_source_staging] 
WHERE [Associate Source Code] LIKE '%' + CHAR(13) + '%' OR [Associate Source Code] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [Associate Source Code] LIKE '% %'-- check for spaces
OR [Associate Source Code] LIKE '% %' --ASCII Character (ascii no : 160)


----[Associate Source Code] Update
BEGIN tran
UPDATE [mastercard_db].[dbo].[tbl_lk_cif_update_source_staging]
SET [Associate Source Code]=RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([Associate Source Code], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))
WHERE [Associate Source Code] LIKE '%' + CHAR(13) + '%' OR [Associate Source Code] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [Associate Source Code] LIKE '% %'-- check for spaces
OR [Associate Source Code] LIKE '% %' --ASCII Character (ascii no : 160)
--COMMIT
--ROLLBACK

--------------
--[client_id] validation
SELECT
[client_id],
LEN([client_id]),
RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([client_id], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ','')),
LEN(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([client_id], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))) 
FROM [mastercard_db].[dbo].[tbl_lk_cif_update_source_staging] 
WHERE [client_id] LIKE '%' + CHAR(13) + '%' OR [Associate Source Code] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [client_id] LIKE '% %'-- check for spaces
OR [client_id] LIKE '% %' --ASCII Character (ascii no : 160)


----[client_id] Update
BEGIN tran
UPDATE [mastercard_db].[dbo].[tbl_lk_cif_update_source_staging]
SET [client_id]=RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([client_id], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))
WHERE [client_id] LIKE '%' + CHAR(13) + '%' OR [client_id] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [client_id] LIKE '% %'-- check for spaces
OR [client_id] LIKE '% %' --ASCII Character (ascii no : 160)
--COMMIT
--ROLLBACK

--BIN validation
SELECT
[BIN],
LEN([BIN]),
RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([BIN], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ','')),
LEN(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([BIN], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))) ,*
FROM [mastercard_db].[dbo].[tbl_lk_cif_update_source_staging] 
where  [BIN] LIKE '%' + CHAR(13) + '%' OR [BIN] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [BIN] LIKE '% %'--Spaces
OR [BIN] LIKE '% %'--ASCII Character (ascii no : 160)


--BIN Update
BEGIN TRAN
UPDATE
[mastercard_db].[dbo].[tbl_lk_cif_update_source_staging] 
SET [BIN]=RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([BIN], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))
where  [BIN] LIKE '%' + CHAR(13) + '%' OR [BIN] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [BIN] LIKE '% %'--Spaces
OR [BIN] LIKE '% %'--ASCII Character (ascii no : 160)
--COMMIT
--ROLLBACK
------------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-----------[mastercard_db].[dbo].[tblLKCIF]--------------------------------------
---------------------------------------------------------------------------------

SELECT
client_id,
LEN(client_id),
RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(client_id, CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ','')),
LEN(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(client_id, CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))) 
FROM [mastercard_db].[dbo].[tblLKCIF]
WHERE client_id LIKE '%' + CHAR(13) + '%' OR client_id LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR client_id LIKE '% %'-- check for spaces
OR client_id LIKE '% %' --ASCII Character (ascii no : 160)


BEGIN tran
UPDATE [mastercard_db].[dbo].[tblLKCIF]
SET client_id=RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(client_id, CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))
WHERE client_id LIKE '%' + CHAR(13) + '%' OR client_id LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR client_id LIKE '% %'-- check for spaces
OR client_id LIKE '% %' --ASCII Character (ascii no : 160)
--COMMIT
--ROLLBACK


---------------------------------------

SELECT
source_code,
LEN(source_code),
RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(source_code, CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ','')),
LEN(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(source_code, CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))) 
FROM [mastercard_db].[dbo].[tblLKCIF]
WHERE source_code LIKE '%' + CHAR(13) + '%' OR source_code LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR source_code LIKE '% %'-- check for spaces
OR source_code LIKE '% %' --ASCII Character (ascii no : 160)



BEGIN tran
UPDATE [mastercard_db].[dbo].[tblLKCIF]
SET source_code=RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(source_code, CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))
WHERE source_code LIKE '%' + CHAR(13) + '%' OR source_code LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR source_code LIKE '% %'-- check for spaces
OR source_code LIKE '% %' --ASCII Character (ascii no : 160)
--COMMIT
--ROLLBACK
---



---------------------------------

SELECT
bin,
LEN(bin),
RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(bin, CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ','')),
LEN(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(bin, CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))) 
FROM [mastercard_db].[dbo].[tblLKCIF]
WHERE bin LIKE '%' + CHAR(13) + '%' OR bin LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR bin LIKE '% %'-- check for spaces
OR bin LIKE '% %' --ASCII Character (ascii no : 160)


BEGIN tran
UPDATE [mastercard_db].[dbo].[tblLKCIF]
SET bin=RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(bin, CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))
WHERE bin LIKE '%' + CHAR(13) + '%' OR bin LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR bin LIKE '% %'-- check for spaces
OR bin LIKE '% %' --ASCII Character (ascii no : 160)

--COMMIT
--ROLLBACK
---

---------------------------------------------------------------------------


--************************************--
--[mastercard_db].[dbo].[tblLKMemberships]
--************************************--

--Taking the back up of [mastercard_db].[dbo].[tblLKMemberships] table 

--SELECT * INTO Backups.bkup.mastercard_db_tblLKMemberships_20181213_MC FROM  [mastercard_db].[dbo].[tblLKMemberships]

--[client_id] validation
SELECT 
[client_id] 
FROM
[mastercard_db].[dbo].[tblLKMemberships] where --[billing_month] = '2018-11-01'
 ([client_id] LIKE '%' + CHAR(13) + '%' OR [client_id] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [client_id] LIKE '% %'--Spaces
OR [client_id] LIKE '% %'--ASCII Character (ascii no : 160)
)

--[client_id] Update
BEGIN TRAN
UPDATE
[mastercard_db].[dbo].[tblLKMemberships]
SET [client_id]=RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([client_id], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))
where --[billing_month] = '2018-09-01'
 [client_id] LIKE '%' + CHAR(13) + '%' OR [client_id] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [client_id] LIKE '% %'--Spaces
OR [client_id] LIKE '% %'--ASCII Character (ascii no : 160)
--COMMIT
--ROLLBACK



--[source_code] validation 
SELECT 
[source_code] 
FROM
[mastercard_db].[dbo].[tblLKMemberships] where --[billing_month] = '2018-09-01'
 ([source_code] LIKE '%' + CHAR(13) + '%' OR [source_code] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [source_code] LIKE '% %'--Spaces
OR [source_code] LIKE '% %'--ASCII Character (ascii no : 160)
)


--[source_code] Update
BEGIN TRAN
UPDATE
[mastercard_db].[dbo].[tblLKMemberships]
SET [source_code]=RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([source_code], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))
where --[billing_month] = '2018-09-01'
 [source_code] LIKE '%' + CHAR(13) + '%' OR [source_code] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [source_code] LIKE '% %'--Spaces
OR [source_code] LIKE '% %'--ASCII Character (ascii no : 160)
--COMMIT
--ROLLBACK


--[BIN] validation 
SELECT 
[BIN] 
FROM
[mastercard_db].[dbo].[tblLKMemberships] WHERE --[billing_month] = '2018-11-01' and
 ([BIN] LIKE '%' + CHAR(13) + '%' OR [BIN] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [BIN] LIKE '% %'--Spaces
OR [BIN] LIKE '% %'--ASCII Character (ascii no : 160)
)

--[BIN] Update
BEGIN TRAN
UPDATE
[mastercard_db].[dbo].[tblLKMemberships]
SET [BIN]=RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([BIN], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))
where [billing_month] = '2018-09-01'
AND [BIN] LIKE '%' + CHAR(13) + '%' OR [BIN] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [BIN] LIKE '% %'--Spaces
OR [BIN] LIKE '% %'--ASCII Character (ascii no : 160)
--COMMIT
--ROLLBACK




--*********************************************************--
--[deals_db].[dbo].[dimTblMCMigrationsLog]
--*********************************************************--

--Taking the back up of tbl_lk_cif_update_source_staging table 

--SELECT * INTO Backups.bkup.mastercard_db_tbl_lk_cif_update_source_staging_20181213_MC FROM [mastercard_db].[dbo].[tbl_lk_cif_update_source_staging] 

--[nd_client_id] validation
SELECT
[nd_client_id],
LEN([nd_client_id]),
RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([nd_client_id], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ','')),
LEN(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([nd_client_id], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))) 
FROM [deals_db].[dbo].[dimTblMCMigrationsLog]
WHERE [nd_client_id] LIKE '%' + CHAR(13) + '%' OR [nd_client_id] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [nd_client_id] LIKE '% %'-- check for spaces
OR [nd_client_id] LIKE '% %' --ASCII Character (ascii no : 160)


----[nd_client_id] Update
BEGIN tran
UPDATE [deals_db].[dbo].[dimTblMCMigrationsLog]
SET [nd_client_id]=RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([nd_client_id], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))
WHERE [nd_client_id] LIKE '%' + CHAR(13) + '%' OR [nd_client_id] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [nd_client_id] LIKE '% %'-- check for spaces
OR [nd_client_id] LIKE '% %' --ASCII Character (ascii no : 160)
--COMMIT
--ROLLBACK



--[nd_sourcecode_prefix] validation
SELECT
[nd_sourcecode_prefix],
LEN([nd_sourcecode_prefix]),
RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([nd_sourcecode_prefix], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ','')),
LEN(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([nd_sourcecode_prefix], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))) 
FROM [deals_db].[dbo].[dimTblMCMigrationsLog]
WHERE [nd_sourcecode_prefix] LIKE '%' + CHAR(13) + '%' OR [nd_sourcecode_prefix] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [nd_sourcecode_prefix] LIKE '% %'-- check for spaces
OR [nd_sourcecode_prefix] LIKE '% %' --ASCII Character (ascii no : 160)


----[nd_client_id] Update
BEGIN tran
UPDATE [deals_db].[dbo].[dimTblMCMigrationsLog]
SET [nd_sourcecode_prefix]=RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([nd_sourcecode_prefix], CHAR(13), ''), CHAR(10), ''),'  ',''),' ',''),' ',''))
WHERE [nd_sourcecode_prefix] LIKE '%' + CHAR(13) + '%' OR [nd_sourcecode_prefix] LIKE '%' + CHAR(10) + '%' --chech for tab and carriage returns
OR [nd_sourcecode_prefix] LIKE '% %'-- check for spaces
OR [nd_sourcecode_prefix] LIKE '% %' --ASCII Character (ascii no : 160)
--COMMIT
--ROLLBACK


