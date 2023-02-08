IF OBJECT_ID('tempdb..#temp') IS NOT NULL
    DROP TABLE #temp

SELECT 
        dls.[client_region_of_issue] as [Client Region],
        dls.[source_code] as [Source Code],
        dls.[client_id] as [Client ID],
        config.[Authenticated Source Code],
        dls.[lounge_programme] as [Lounge Programme],
        dls.[deal_type] as [Deal Type],
        dls.[country_of_issue] as [Country Of Issue],
        cnt.[eea] as [EEA Country Y/N],
        dls.[client] as [Client],
        dls.[issuer_name] as [Issuer Name],
        mci.[enrolment_method] as [Enrolment Method], --awaiting linked server permission
        Case When cif.[cif] is null Then 0 Else cif.[cif] End as [CIF],
        Case When vst.[Active Members] is null Then 0 Else vst.[Active Members] End as [Active Members],
        Case When vst2.[Total Visits] is null Then 0 Else vst2.[Total Visits] End as [Visit Volume],    
        CASE WHEN ctt.card_transaction_type_code='VISIT' then cvt.card_validation_type_desc END AS Visit_card_validation_type_desc,
		CASE WHEN ctt.card_transaction_type_code='VISIT' then ctt.card_transaction_type_code END AS Visit_card_transaction_type_code,
		 config.DMC AS 'DMC',
		CASE WHEN ctt.card_transaction_type_code='SIGNUP' then cvt.card_validation_type_desc END AS SignUp_card_validation_type_desc,
		CASE WHEN ctt.card_transaction_type_code='SIGNUP' then ctt.card_transaction_type_code END AS SignUp_card_transaction_type_code
  INTO #temp
  FROM [global_dw].[whs].[vwDeals] dls with (nolock)
  Left Join [global_ods].[ods].[tblCountriesRegions] cnt with (nolock) on dls.[country_of_issue_iso] = cnt.country_iso_code
  Left Join [DI_Sandbox].[temp].[vwGlobalMemberReach] cif with (nolock) on dls.client_id = cif.client_id and cif.report_month = '2020-12-01'
  Left Join (    Select [client_id],
                Count(distinct [consumer_no]) as [Active Members]
                FROM [global_dw].[whs].[vwVisits] with (nolock)
                Where [report_month_key] between 20220101 and 20230131
                Group By [client_id]
            ) vst on dls.client_id = vst.client_id
  Left Join (    Select [client_id],
                Sum([total_visits]) as [Total Visits]
                From [global_dw].[whs].[vwVisits] with (nolock)
                Where [report_month_key] between 20220101 and 20230131
                Group By [client_id]
                ) vst2 on dls.client_id = vst2.client_id
  Left Join [global_ods].[source].[vwMastercardDeals] mci on dls.[client_id] = mci.[clientid] --awaiting linked server permission
  Left Join (    SELECT    sdc.source_code
                        ,case when src.source_media = 'XA' then 'Authenticated Associate Plus'
                        when src.source_media = 'ZA' then 'Authenticated Associate'
                        when src.source_media = 'Z' then 'Associate'
                        when src.source_media = 'X' then 'Associate Plus'
                        when src.source_media = 'B' then 'AMEX'
                        when src.source_media = 'G' then 'Corporate Groups'
                        when src.source_media = 'H' then 'Affinity'
                        when src.source_media = 'A' then 'Affiliate'
                        when src.source_media = 'D' then 'Wholesale'
                        when src.source_media = 'DD' then 'Wholesale Lite'
                        when src.source_media = 'DM' then 'MC Wholesale Lite'
                        else null end as [Authenticated Source Code]
                        ,sdc.is_dmc_allowed AS 'DMC'
                        FROM 
                        global_ods.source.tblPPasssourcedealconfig sdc WITH (NOLOCK) 
                        LEFT JOIN global_ods.[source].[tblPpassDeals] src WITH (NOLOCK) 
                        ON src.source_code = sdc.source_code
                        --where
                        --src.source_media in ('XA','ZA')
            ) config on dls.source_code = config.source_code
    LEFT JOIN [global_ods].ods.PSD2_source_card_validation_type_lk scv_lk WITH (NOLOCK)
        ON scv_lk.source_code = config.source_code
    LEFT JOIN ods.PSD2_card_validation_type cvt WITH (NOLOCK)
        ON cvt.card_validation_type_id = scv_lk.card_validation_type_id

    LEFT JOIN ods.PSD2_card_transaction_type ctt WITH (NOLOCK)
        ON ctt.card_transaction_type_id = scv_lk.card_transaction_type_id
	WHERE 1=1
	---ctt.card_transaction_type_code IN ('VISIT','SIGNUP') 
	---AND dls.client_id IN ('LKDCELOMPA20655004')
	--AND dls.client_region_of_issue='Americas'

	SELECT 	
	t1.[Client Region],
	t1.[Source Code]
	,t1.[Client ID]
	,t1.[Authenticated Source Code]
	,t1.[Lounge Programme]
	,t1.[Deal Type]
	,t1.[Country Of Issue]
	,t1.[EEA Country Y/N]
	,t1.[Client]
	,t1.[Issuer Name]
	,t1.[Enrolment Method]
	,t1.[CIF]
	,t1.[Active Members]
	,t1.[Visit Volume]
	,Visit_card_transaction_type_code
,Visit_card_validation_type_desc=STUFF  
(  
     (  
       SELECT DISTINCT ', ' + CAST(Visit_card_validation_type_desc AS VARCHAR(MAX))  
       FROM #temp t2   
       WHERE t2.[Client ID] = t1.[Client ID] AND t2.Visit_card_transaction_type_code='VISIT'   
       FOR XML PATH('')  
     ),1,1,''  
)  
,SignUp_card_validation_type_desc=STUFF  
(  
     (  
       SELECT DISTINCT ', ' + CAST(t2.SignUp_card_validation_type_desc AS VARCHAR(MAX)) 
       FROM #temp t2   
       WHERE t2.[Client ID] = t1.[Client ID] AND t2.SignUp_card_transaction_type_code='SIGNUP'   
       FOR XML PATH('')  
     ),1,1,''  
) 
,SignUp_card_transaction_type_code=STUFF  
(  
     (  
       SELECT DISTINCT ',' + CAST(t2.SignUp_card_transaction_type_code AS VARCHAR(MAX)) 
       FROM #temp t2   
       WHERE t2.[Client ID] = t1.[Client ID] AND t2.SignUp_card_transaction_type_code='SIGNUP'   
       FOR XML PATH('')  
     ),1,1,''  
)
FROM #temp t1
WHERE 
(Visit_card_transaction_type_code IS NOT NULL OR t1.[Lounge Programme]='Priority Pass')

GROUP BY 
				[Client ID],
				[Client Region],
				[Source Code]				
				,Visit_card_transaction_type_code,SignUp_card_transaction_type_code
				,t1.[Authenticated Source Code]
				,t1.[Lounge Programme]
	,t1.[Deal Type]
	,t1.[Country Of Issue]
	,t1.[EEA Country Y/N]
	,t1.[Client]
	,t1.[Issuer Name]
	,t1.[Enrolment Method]
	,t1.[CIF]
	,t1.[Active Members]
	,t1.[Visit Volume]
ORDER BY 3 ASC

