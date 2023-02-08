SELECT DISTINCT
       sdc.source_code,
       s.owner_product,
       cm.consumer_model_name,
	   scv_lk.card_transaction_type_id,
       cvt.card_validation_type_desc,
       cvt.card_validation_type_code
INTO #temp1
FROM dbo.source s WITH (NOLOCK)
    INNER JOIN dbo.source_deal_config sdc WITH (NOLOCK)
        ON sdc.source_code = s.source_code
    INNER JOIN dbo.consumer_model cm WITH (NOLOCK)
        ON cm.consumer_model_id = sdc.consumer_model_id
    INNER JOIN source_card_validation_type_lk scv_lk WITH (NOLOCK)
        ON scv_lk.source_code = s.source_code
    INNER JOIN dbo.card_validation_type cvt WITH (NOLOCK)
        ON cvt.card_validation_type_id = scv_lk.card_validation_type_id
WHERE CVT.card_validation_type_code LIKE 'BLACK%';


SELECT DISTINCT
       sdc.source_code,
       s.owner_product,
       cm.consumer_model_name,
	   scv_lk.card_transaction_type_id,
       cvt.card_validation_type_desc,
       cvt.card_validation_type_code
INTO #temp2
FROM dbo.source s WITH (NOLOCK)
    INNER JOIN dbo.source_deal_config sdc WITH (NOLOCK)
        ON sdc.source_code = s.source_code
    INNER JOIN dbo.consumer_model cm WITH (NOLOCK)
        ON cm.consumer_model_id = sdc.consumer_model_id
    INNER JOIN source_card_validation_type_lk scv_lk WITH (NOLOCK)
        ON scv_lk.source_code = s.source_code
    INNER JOIN dbo.card_validation_type cvt WITH (NOLOCK)
        ON cvt.card_validation_type_id = scv_lk.card_validation_type_id
WHERE CVT.card_validation_type_code LIKE 'genpre%';


SELECT DISTINCT
       sdc.source_code,
       s.owner_product,
       cm.consumer_model_name,
	   scv_lk.card_transaction_type_id,
       cvt.card_validation_type_desc,
       cvt.card_validation_type_code
INTO #temp3
FROM dbo.source s WITH (NOLOCK)
    INNER JOIN dbo.source_deal_config sdc WITH (NOLOCK)
        ON sdc.source_code = s.source_code
    INNER JOIN dbo.consumer_model cm WITH (NOLOCK)
        ON cm.consumer_model_id = sdc.consumer_model_id
    INNER JOIN source_card_validation_type_lk scv_lk WITH (NOLOCK)
        ON scv_lk.source_code = s.source_code
    INNER JOIN dbo.card_validation_type cvt WITH (NOLOCK)
        ON cvt.card_validation_type_id = scv_lk.card_validation_type_id
WHERE CVT.card_validation_type_code LIKE 'preauth%' and scv_lk.card_transaction_type_id = '2';

SELECT DISTINCT
       sdc.source_code,
       s.owner_product,
       cm.consumer_model_name,
	   scv_lk.card_transaction_type_id,
       cvt.card_validation_type_desc,
       cvt.card_validation_type_code
INTO #temp4
FROM dbo.source s WITH (NOLOCK)
    INNER JOIN dbo.source_deal_config sdc WITH (NOLOCK)
        ON sdc.source_code = s.source_code
    INNER JOIN dbo.consumer_model cm WITH (NOLOCK)
        ON cm.consumer_model_id = sdc.consumer_model_id
    INNER JOIN source_card_validation_type_lk scv_lk WITH (NOLOCK)
        ON scv_lk.source_code = s.source_code
    INNER JOIN dbo.card_validation_type cvt WITH (NOLOCK)
        ON cvt.card_validation_type_id = scv_lk.card_validation_type_id
WHERE CVT.card_validation_type_code LIKE 'preauth%' and scv_lk.card_transaction_type_id = '3';

SELECT DISTINCT
       sdc.source_code,
       s.owner_product,
       cm.consumer_model_name,
	   scv_lk.card_transaction_type_id,
       cvt.card_validation_type_desc,
       cvt.card_validation_type_code
INTO #temp5
FROM dbo.source s WITH (NOLOCK)
    INNER JOIN dbo.source_deal_config sdc WITH (NOLOCK)
        ON sdc.source_code = s.source_code
    INNER JOIN dbo.consumer_model cm WITH (NOLOCK)
        ON cm.consumer_model_id = sdc.consumer_model_id
    INNER JOIN source_card_validation_type_lk scv_lk WITH (NOLOCK)
        ON scv_lk.source_code = s.source_code
    INNER JOIN dbo.card_validation_type cvt WITH (NOLOCK)
        ON cvt.card_validation_type_id = scv_lk.card_validation_type_id
WHERE CVT.card_validation_type_code LIKE 'preauth%' and scv_lk.card_transaction_type_id = '4';


SELECT DISTINCT
       sdc.source_code,
       s.owner_product,
       cm.consumer_model_name,
	   scv_lk.card_transaction_type_id,
       cvt.card_validation_type_desc,
       cvt.card_validation_type_code
INTO #temp6
FROM dbo.source s WITH (NOLOCK)
    INNER JOIN dbo.source_deal_config sdc WITH (NOLOCK)
        ON sdc.source_code = s.source_code
    INNER JOIN dbo.consumer_model cm WITH (NOLOCK)
        ON cm.consumer_model_id = sdc.consumer_model_id
    INNER JOIN source_card_validation_type_lk scv_lk WITH (NOLOCK)
        ON scv_lk.source_code = s.source_code
    INNER JOIN dbo.card_validation_type cvt WITH (NOLOCK)
        ON cvt.card_validation_type_id = scv_lk.card_validation_type_id
WHERE CVT.card_validation_type_code LIKE 'VISA%' and scv_lk.card_transaction_type_id = '3';


SELECT DISTINCT
       sdc.source_code,
       s.owner_product,
       cm.consumer_model_name,
	   scv_lk.card_transaction_type_id,
       cvt.card_validation_type_desc,
       cvt.card_validation_type_code
INTO #temp7
FROM dbo.source s WITH (NOLOCK)
    INNER JOIN dbo.source_deal_config sdc WITH (NOLOCK)
        ON sdc.source_code = s.source_code
    INNER JOIN dbo.consumer_model cm WITH (NOLOCK)
        ON cm.consumer_model_id = sdc.consumer_model_id
    INNER JOIN source_card_validation_type_lk scv_lk WITH (NOLOCK)
        ON scv_lk.source_code = s.source_code
    INNER JOIN dbo.card_validation_type cvt WITH (NOLOCK)
        ON cvt.card_validation_type_id = scv_lk.card_validation_type_id
WHERE CVT.card_validation_type_code LIKE 'VISA%' and scv_lk.card_transaction_type_id = '4';


SELECT DISTINCT
       sdc.source_code,
       s.owner_product,
       cm.consumer_model_name,
       scv_lk.card_transaction_type_id,
	   cvt.card_validation_type_desc,
       cvt.card_validation_type_code
INTO #temp8
FROM dbo.source s WITH (NOLOCK)
    INNER JOIN dbo.source_deal_config sdc WITH (NOLOCK)
        ON sdc.source_code = s.source_code
    INNER JOIN dbo.consumer_model cm WITH (NOLOCK)
        ON cm.consumer_model_id = sdc.consumer_model_id
    INNER JOIN source_card_validation_type_lk scv_lk WITH (NOLOCK)
        ON scv_lk.source_code = s.source_code
    INNER JOIN dbo.card_validation_type cvt WITH (NOLOCK)
        ON cvt.card_validation_type_id = scv_lk.card_validation_type_id
WHERE CVT.card_validation_type_code LIKE 'white%' and scv_lk.card_transaction_type_id = '3';


SELECT DISTINCT
       sdc.source_code,
       s.owner_product,
       cm.consumer_model_name,
       scv_lk.card_transaction_type_id,
	   cvt.card_validation_type_desc,
       cvt.card_validation_type_code
INTO #temp9
FROM dbo.source s WITH (NOLOCK)
    INNER JOIN dbo.source_deal_config sdc WITH (NOLOCK)
        ON sdc.source_code = s.source_code
    INNER JOIN dbo.consumer_model cm WITH (NOLOCK)
        ON cm.consumer_model_id = sdc.consumer_model_id
    INNER JOIN source_card_validation_type_lk scv_lk WITH (NOLOCK)
        ON scv_lk.source_code = s.source_code
    INNER JOIN dbo.card_validation_type cvt WITH (NOLOCK)
        ON cvt.card_validation_type_id = scv_lk.card_validation_type_id
WHERE CVT.card_validation_type_code LIKE 'white%' and scv_lk.card_transaction_type_id = '4';


SELECT DISTINCT
       sdc.source_code,
       s.owner_product,
       cm.consumer_model_name,
	   scv_lk.card_transaction_type_id,
       cvt.card_validation_type_desc,
       cvt.card_validation_type_code
INTO #temp10
FROM dbo.source s WITH (NOLOCK)
    INNER JOIN dbo.source_deal_config sdc WITH (NOLOCK)
        ON sdc.source_code = s.source_code
    INNER JOIN dbo.consumer_model cm WITH (NOLOCK)
        ON cm.consumer_model_id = sdc.consumer_model_id
    INNER JOIN source_card_validation_type_lk scv_lk WITH (NOLOCK)
        ON scv_lk.source_code = s.source_code
    INNER JOIN dbo.card_validation_type cvt WITH (NOLOCK)
        ON cvt.card_validation_type_id = scv_lk.card_validation_type_id
WHERE CVT.card_validation_type_code LIKE 'zeropre%' and scv_lk.card_transaction_type_id = '2';


SELECT DISTINCT
       sdc.source_code,
       s.owner_product,
       cm.consumer_model_name,
	   scv_lk.card_transaction_type_id,
       cvt.card_validation_type_desc,
       cvt.card_validation_type_code
INTO #temp11
FROM dbo.source s WITH (NOLOCK)
    INNER JOIN dbo.source_deal_config sdc WITH (NOLOCK)
        ON sdc.source_code = s.source_code
    INNER JOIN dbo.consumer_model cm WITH (NOLOCK)
        ON cm.consumer_model_id = sdc.consumer_model_id
    INNER JOIN source_card_validation_type_lk scv_lk WITH (NOLOCK)
        ON scv_lk.source_code = s.source_code
    INNER JOIN dbo.card_validation_type cvt WITH (NOLOCK)
        ON cvt.card_validation_type_id = scv_lk.card_validation_type_id
WHERE CVT.card_validation_type_code LIKE 'zeropre%' and scv_lk.card_transaction_type_id = '3';


SELECT DISTINCT
       sdc.source_code,
       s.owner_product,
       cm.consumer_model_name,
	   scv_lk.card_transaction_type_id,
       cvt.card_validation_type_desc,
       cvt.card_validation_type_code
INTO #temp12
FROM dbo.source s WITH (NOLOCK)
    INNER JOIN dbo.source_deal_config sdc WITH (NOLOCK)
        ON sdc.source_code = s.source_code
    INNER JOIN dbo.consumer_model cm WITH (NOLOCK)
        ON cm.consumer_model_id = sdc.consumer_model_id
    INNER JOIN source_card_validation_type_lk scv_lk WITH (NOLOCK)
        ON scv_lk.source_code = s.source_code
    INNER JOIN dbo.card_validation_type cvt WITH (NOLOCK)
        ON cvt.card_validation_type_id = scv_lk.card_validation_type_id
WHERE CVT.card_validation_type_code LIKE 'zeropre%' and scv_lk.card_transaction_type_id = '4';


SELECT
#temp1.source_code AS 'Source Code',
#temp1.owner_product AS 'Owner Product',
#temp1.consumer_model_name AS 'Consumer Model Name',
#temp1.card_validation_type_desc AS 'Blacklist Visit Description',
coalesce(#temp2.card_validation_type_desc, '') + coalesce(#temp3.card_validation_type_desc, '') + coalesce(#temp10.card_validation_type_desc,'') AS 'Visit Description',
coalesce(#temp5.card_validation_type_desc, '') + coalesce(#temp9.card_validation_type_desc, '') + coalesce(#temp7.card_validation_type_desc,'') + coalesce(#temp12.card_validation_type_desc,'') AS 'SignUp Description',
coalesce(#temp4.card_validation_type_desc, '') + coalesce(#temp8.card_validation_type_desc, '') + coalesce(#temp6.card_validation_type_desc,'') + coalesce(#temp11.card_validation_type_desc,'') AS 'Update Description'
FROM #temp1
	LEFT JOIN #temp2
	ON #temp1.SOURCE_CODE = #temp2.SOURCE_CODE
	LEFT JOIN #temp3
	ON #temp1.SOURCE_CODE = #temp3.SOURCE_CODE
	LEFT JOIN #temp4
	ON #temp1.SOURCE_CODE = #temp4.SOURCE_CODE
	LEFT JOIN #temp5
	ON #temp1.SOURCE_CODE = #temp5.SOURCE_CODE
	LEFT JOIN #temp6
	ON #temp1.SOURCE_CODE = #temp6.SOURCE_CODE
	LEFT JOIN #temp7
	ON #temp1.SOURCE_CODE = #temp7.SOURCE_CODE
	LEFT JOIN #temp8
	ON #temp1.SOURCE_CODE = #temp8.SOURCE_CODE
	LEFT JOIN #temp9
	ON #temp1.SOURCE_CODE = #temp9.SOURCE_CODE
	LEFT JOIN #temp10
	ON #temp1.SOURCE_CODE = #temp10.SOURCE_CODE
	LEFT JOIN #temp11
	ON #temp1.SOURCE_CODE = #temp11.SOURCE_CODE
	LEFT JOIN #temp12
	ON #temp1.SOURCE_CODE = #temp12.SOURCE_CODE
WHERE #temp1.owner_product = 'LK'