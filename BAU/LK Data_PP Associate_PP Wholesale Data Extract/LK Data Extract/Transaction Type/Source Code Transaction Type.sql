WITH CTE
AS (SELECT source_deal_config_id,
           TransactionTypeId,
           scfEnabled,
           scaEnabled
    FROM
    (
        SELECT sea.source_deal_config_id,
               sea.attr_key,
               sea.attr_value
        FROM source_extended_attributes sea WITH (NOLOCK)
        WHERE sea.attr_key IN ( 'TransactionTypeId', 'scaEnabled', 'scfEnabled' )
    ) d
   PIVOT
    (
        MAX(d.attr_value)
        FOR d.attr_key IN (scaEnabled, scfEnabled, TransactionTypeId)
    ) piv)

SELECT sdc.source_code,
       s.owner_product,
	   cm.consumer_model_name,
       CASE
           WHEN c.TransactionTypeId = 1 THEN 'MOTO'
           WHEN c.TransactionTypeId = 2 THEN 'ECOMM'
           WHEN c.TransactionTypeId = 3 THEN 'RECURRING'
       END AS 'TransactionType'
INTO #TEMP2
FROM CTE c
    INNER JOIN dbo.source_deal_config sdc WITH (NOLOCK)
        ON sdc.source_deal_config_id = c.source_deal_config_id
    INNER JOIN dbo.source s WITH (NOLOCK)
        ON s.source_code = sdc.source_code
    INNER JOIN dbo.consumer_model cm WITH (NOLOCK)
        ON cm.consumer_model_id = sdc.consumer_model_id
	WHERE S.owner_product = 'LK'

SELECT * FROM #TEMP2