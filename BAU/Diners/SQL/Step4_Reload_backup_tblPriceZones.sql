--check with BAU reporting team before proceeding with truncating and relading the below table
--check 

TRUNCATE table [diners_billing_db].[dbo].[tblPriceZones]

begin tran
INSERT INTO [diners_billing_db].[dbo].[tblPriceZones]
([zone_id]
,[deal_type]
,[client_id]
,[price_group]
,[currency]
,[member_fee]
,[guest_fee]
,[start_date]
,[end_date]
,[pricing_sequence])
select [zone_id]
,[deal_type]
,[client_id]
,[price_group]
,[currency]
,[member_fee]
,[guest_fee]
,[start_date]
,[end_date]
,[pricing_sequence] FROM Backups.bkup.diners_billing_db_dbo_tblPriceZones_20200703---back up of the pricing table taken from step 2 --20190502_AA changes every month

COMMIT

