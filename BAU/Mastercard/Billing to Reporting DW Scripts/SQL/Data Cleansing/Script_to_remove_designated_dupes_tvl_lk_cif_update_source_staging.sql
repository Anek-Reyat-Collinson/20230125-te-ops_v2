--to select the records which are duplicates and order them by serial number.

select ROW_NUMBER() over (partition by [client_id],[Report/CIF Month] order by tbl_index) as sno ,* from [dbo].[tbl_lk_cif_update_source_staging]
where [client_id]+cast([Report/CIF Month] as varchar(50)) in 
(select distinct [client_id]+cast([Report/CIF Month] as varchar(50)) as cmd from
(SELECT client_id,[Report/CIF Month],COUNT(1) as cnt FROM 
[dbo].[tbl_lk_cif_update_source_staging]
GROUP BY client_id,[Report/CIF Month]
HAVING COUNT(1)>1 )a)
order by client_id,[Report/CIF Month],tbl_index asc

--take back up of [dbo].[tbl_lk_cif_update_source_staging]

select * into Backups.bkup.mastercard_db_cif_update_source_staging_15_01_19_AA
from [dbo].[tbl_lk_cif_update_source_staging]--13536


---delete records with serial number 1 as they have the lower tbl index
begin tran
--select *
delete from [dbo].[tbl_lk_cif_update_source_staging] where tbl_index in( 
select tbl_index from(
select ROW_NUMBER() over (partition by [client_id],[Report/CIF Month] order by tbl_index) as sno ,* from [dbo].[tbl_lk_cif_update_source_staging]
where [client_id]+cast([Report/CIF Month] as varchar(50)) in 
(select distinct [client_id]+cast([Report/CIF Month] as varchar(50)) as cmd from
(SELECT client_id,[Report/CIF Month],COUNT(1) as cnt FROM 
[dbo].[tbl_lk_cif_update_source_staging]
GROUP BY client_id,[Report/CIF Month]
HAVING COUNT(1)>1 )a)
--order by client_id,[Report/CIF Month],tbl_index asc
)c where sno=1)--969

commit


---final check for dupes
SELECT client_id,[Report/CIF Month],COUNT(1) as cnt FROM 
[dbo].[tbl_lk_cif_update_source_staging]
GROUP BY client_id,[Report/CIF Month]
HAVING COUNT(1)>1 --0





