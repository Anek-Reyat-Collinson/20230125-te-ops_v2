SELECT
* 
INTO #TEMP
FROM client_id
where source_code IS NULL

select 
t.client_id as 'Client ID',
C.NUMERIC_1 as 'Consumer Number',
c.alpha_4 as 'Card Prefix',
c.code_effective,
ps.purchase_no,
t.ica,
p.source_code,
is_card_blocked
INTO #TEMP1
from dbo.code AS C
LEFT JOIN #TEMP AS T
ON T.client_id = c.code
inner join dbo.purchase_summary as ps
on c.numeric_1 = ps.consumer_no
inner join dbo.purchase as p
on p.purchase_no = ps.purchase_no
left join dbo.consumer as con
on con.consumer_no = ps.consumer_no
where codetype = 'Associate' 

SELECT DISTINCT
T1.[Client ID],
sdc.is_dmc_allowed,
sdc.is_digital_optional,
c.consumer_no,
T1.[Card Prefix],
T1.ica,
ps.purchase_no,
sdc.source_code,
T1.is_card_blocked,
CAST(T1.code_effective AS date) AS 'code_effective'
FROM purchase AS p
INNER JOIN purchase_summary AS ps ON ps.purchase_no = p.purchase_no
INNER JOIN consumer AS c ON c.consumer_no = p.consumer_no
INNER JOIN purchase_subscription_link AS psl ON psl.purchase_no = p.purchase_no
INNER JOIN source_subscription AS ss ON ss.source_subscription_id = psl.source_subscription_id
INNER JOIN source_deal_config AS sdc ON sdc.source_deal_config_id = ss.source_deal_config_id
INNER JOIN #TEMP1 AS T1 ON T1.purchase_no = P.purchase_no
where sdc.source_code  not like 'lk%'