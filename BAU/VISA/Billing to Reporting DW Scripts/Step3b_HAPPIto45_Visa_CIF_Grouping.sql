   
   
  /*******************************************************************************************************************************
** Project ID	 :  Step 3b Visa Data (Grouping ID) Transfer from HAPPI to .45
** Author        : Austine
** Amend History : AE 08/06/2017 

** Run history   :	
					HD 20/07/2020 Ran successfully
					HD 17/08/2020 Ran successfully
					HD 17/09/2020 Ran successfully
					HD 16/10/2020 Ran successfully
					HD 17/11/2020 Ran successfully
					HD 15/12/2020 Ran successfully
					HD 18/01/2021 Ran successfully --  DI-907  
					HD 18/01/2021 Ran successfully
					HD 16/02/2021 Ran successfully
					HD 15/03/2021 Ran successfully
					HD 15/03/2021 Ran successfully- Nov 20 BIBAU-2735
					HD 15/03/2021 Ran successfully- Dec 20 BIBAU-2735
					HD 16/04/2021 Ran successfully
					HD 14/05/2021 Ran successfully
					HD 17/05/2021 Ran successfully
					HD 17/05/2021 Ran successfully
					HD 18/06/2021 Ran successfully
					HD 19/07/2021 Ran successfully
					HD 19/07/2021 Ran successfully- Apr 21 OPSBI-62
					HD 19/07/2021 Ran successfully- May 21 OPSBI-62
					HD 13/08/2021 Ran successfully
					HD 25/08/2021 Ran successfully
					HD 15/09/2021 Ran successfully
					HD 18/10/2021 Ran successfully
					HD 12/11/2021 Ran successfully
					HD 16/12/2021 Ran successfully
					HD 19/01/2022 Ran successfully
					HD 16/02/2022 Ran successfully
					HD 18/03/2022 Ran successfully
					HD 20/04/2022 Ran successfully
					HD 20/04/2022 Ran successfully - OPSBI-118
					HD 20/04/2022 Ran successfully - OPSBI-118
					HD 17/05/2022 Ran successfully
					HD 18/05/2022 Ran successfully - OPSBI-118
					HD 18/05/2022 Ran successfully - OPSBI-118
					HD 20/06/2022 Ran successfully
					HD 15/07/2022 Ran successfully
					HD 15/07/2022 Ran successfully - OPSBI-118
					HD 17/08/2022 Ran successfully
					HD 19/08/2022 Ran successfully
					HD 19/08/2022 Ran successfully - Feb 22
					HD 20/09/2022 Ran successfully
					HD 17/10/2022 Ran successfully
					HD 07/11/2022 Ran successfully
					HD 07/11/2022 Ran successfully -Apr 22 OPSBI-145
					HD 09/11/2022 Ran successfully -May 22 OPSBI-145
					HD 09/11/2022 Ran successfully -Jun 22 OPSBI-145
					HD 09/11/2022 Ran successfully -Jul 22 OPSBI-145
					HD 09/11/2022 Ran successfully -Aug 22 OPSBI-145
					HD 09/11/2022 Ran successfully -Sep 22 OPSBI-145
					HD 17/11/2022 Ran successfully
					HD 18/12/2022 Ran successfully
					
********************************************************************************************************************************/

----------------------------------- Query Configuration  -------------------------------------
USE visa_db
GO 
   
   BEGIN TRAN 
   
   TRUNCATE TABLE [visa_db].[dbo].[tblLKCIFRawGrouped];

   SET IDENTITY_INSERT [visa_db].[dbo].[tblLKCIFRawGrouped] ON
	INSERT INTO [visa_db].[dbo].[tblLKCIFRawGrouped]
		([tbl_index],[report_month],[cif_grouping_id],[total])
		
	SELECT 
		[tbl_index],[report_month],[cif_grouping_id],[total]
	FROM [10.204.200.112\OPSLIVEDB,49214].[visa_db].[dbo].[tblLKCIFRawGrouped]
	
	SET IDENTITY_INSERT [visa_db].[dbo].[tblLKCIFRawGrouped] OFF

	COMMIT
	