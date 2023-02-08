SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id,
sdc.is_access_on_payment_card
INTO #TEMP
FROM source AS s
INNER JOIN source_deal_config AS sdc
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas
ON vas.source_deal_config_id = sdc.source_deal_config_id --AND vas.subscription_level_id=3
INNER join source_visit_allocation_grp g
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND s.source_media = 'D' OR s.source_media = 'DD' OR s.source_media = 'DM' 
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';


-- 1st year only is 1 

-- Standard Member

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP1
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from = 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP2
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from = 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP3
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from <> 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP4
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from <> 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- Guest

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP5
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP6
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP7
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP8
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- Member/Guest

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP9
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP10
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP11
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP12
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';


-- Where First Year only is 0

-- Standard

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP49
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from = 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP50
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from = 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP51
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from <> 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP52
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from <> 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- Guest

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP53
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP54
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP55
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP56
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- Member/Guest

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP57
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP58
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP59
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP60
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=1
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

--Standard Plus


SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP61
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=2
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from = 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP62
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=2
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from = 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP63
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=2
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from <> 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP64
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=2
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from <> 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- Guest

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP65
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=2
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP66
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=2
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP67
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=2
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP68
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=2
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- Member/Guest

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP69
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=2
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP70
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=2
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP71
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=2
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Standard Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP72
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=2
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Standard Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- Prestige

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP73
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=3
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from = 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Prestige'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP74
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=3
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from = 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Prestige'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP75
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=3
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from <> 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Prestige'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP76
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=3
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member'
AND sva.visit_count_from <> 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Prestige'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- Guest

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP77
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=3
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Prestige'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP78
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=3
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Prestige'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP79
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=3
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Prestige'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP80
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=3
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Prestige'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- Member/Guest

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP81
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=3
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Prestige'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP82
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=3
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from = 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Prestige'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP83
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=3
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to <> 9999
AND sl.subscription_level_desc = 'Prestige'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
s.source_code,
s.source_desc,
s.owner_product,
sva.first_year_only,
S.source_media,
sl.subscription_level_desc,
vt.visitor_type_desc,
sva.visit_count_from,
sva.visit_count_to,
vvt.visit_validity_type_desc,
co.charge_owner_desc,
vft.visit_fee_type_desc,
sva.visit_allocation_type_id
INTO #TEMP84
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=3
INNER join source_visit_allocation_grp g WITH (NOLOCK)
ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
INNER JOIN source_visit_allocation sva WITH (NOLOCK)
ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id AND sva.visit_allocation_type_id<>3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
ON vft.visit_fee_type_id = sva.visit_fee_type_id
INNER JOIN visitor_type AS vt WITH (NOLOCK)
ON vt.visitor_type_id = sva.visitor_type_id
INNER join dbo.charge_owner co WITH (NOLOCK)
ON co.charge_owner_id = sva.charge_owner_id AND sva.visit_allocation_type_id <> 3 AND sva.visit_allocation_type_id<>4
INNER JOIN visit_validity_type vvt WITH (NOLOCK)
ON vvt.visit_validity_type_id = sva.visit_validity_type_id
INNER JOIN source_visit_allocation_set AS SVAS
ON SVAS.source_deal_config_id = SDC.source_deal_config_id
INNER JOIN subscription_level sl
ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE
vas.isdeleted = 0
AND s.owner_product = 'PP'
AND vt.visitor_type_desc = 'Member/Guest'
AND sva.visit_count_from <> 0 and sva.visit_count_to = 9999
AND sl.subscription_level_desc = 'Prestige'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

SELECT DISTINCT
T.source_code,
T.source_desc,
T.owner_product,
T.source_media,
T.is_access_on_payment_card,
CONCAT(COALESCE(T2.visitor_type_desc,'50'),', ',COALESCE(T2.visit_count_from,'50'),', ',COALESCE(T2.visit_count_to,'50'),', ', COALESCE(T2.visit_validity_type_desc,'50'),', ',COALESCE(T2.charge_owner_desc,'50'),', ',COALESCE(T2.visit_fee_type_desc,'50'),'| ',
COALESCE(T3.visitor_type_desc,'50'),', ',COALESCE(T3.visit_count_from,'50'),', ',COALESCE(T3.visit_count_to,'50'),', ', COALESCE(T3.visit_validity_type_desc,'50'),', ',COALESCE(T3.charge_owner_desc,'50'),', ',COALESCE(T3.visit_fee_type_desc,'50'),'| ',
COALESCE(T4.visitor_type_desc,'50'),', ',COALESCE(T4.visit_count_from,'50'),', ',COALESCE(T4.visit_count_to,'50'),', ', COALESCE(T4.visit_validity_type_desc,'50'),', ',COALESCE(T4.charge_owner_desc,'50'),', ',COALESCE(T4.visit_fee_type_desc,'50'),'| ',
COALESCE(T5.visitor_type_desc,'50'),', ',COALESCE(T5.visit_count_from,'50'),', ',COALESCE(T5.visit_count_to,'50'),', ', COALESCE(T5.visit_validity_type_desc,'50'),', ',COALESCE(T5.charge_owner_desc,'50'),', ',COALESCE(T5.visit_fee_type_desc,'50'),'| ',
COALESCE(T6.visitor_type_desc,'50'),', ',COALESCE(T6.visit_count_from,'50'),', ',COALESCE(T6.visit_count_to,'50'),', ', COALESCE(T6.visit_validity_type_desc,'50'),', ',COALESCE(T6.charge_owner_desc,'50'),', ',COALESCE(T6.visit_fee_type_desc,'50'),'| ',
COALESCE(T7.visitor_type_desc,'50'),', ',COALESCE(T7.visit_count_from,'50'),', ',COALESCE(T7.visit_count_to,'50'),', ', COALESCE(T7.visit_validity_type_desc,'50'),', ',COALESCE(T7.charge_owner_desc,'50'),', ',COALESCE(T7.visit_fee_type_desc,'50'),'| ',
COALESCE(T8.visitor_type_desc,'50'),', ',COALESCE(T8.visit_count_from,'50'),', ',COALESCE(T8.visit_count_to,'50'),', ', COALESCE(T8.visit_validity_type_desc,'50'),', ',COALESCE(T8.charge_owner_desc,'50'),', ',COALESCE(T8.visit_fee_type_desc,'50'),'| ',
COALESCE(T9.visitor_type_desc,'50'),', ',COALESCE(T9.visit_count_from,'50'),', ',COALESCE(T9.visit_count_to,'50'),', ', COALESCE(T9.visit_validity_type_desc,'50'),', ',COALESCE(T9.charge_owner_desc,'50'),', ',COALESCE(T9.visit_fee_type_desc,'50'),'| ',
COALESCE(T10.visitor_type_desc,'50'),', ',COALESCE(T10.visit_count_from,'50'),', ',COALESCE(T10.visit_count_to,'50'),', ', COALESCE(T10.visit_validity_type_desc,'50'),', ',COALESCE(T10.charge_owner_desc,'50'),', ',COALESCE(T10.visit_fee_type_desc,'50'),'| ',
COALESCE(T11.visitor_type_desc,'50'),', ',COALESCE(T11.visit_count_from,'50'),', ',COALESCE(T11.visit_count_to,'50'),', ', COALESCE(T11.visit_validity_type_desc,'50'),', ',COALESCE(T11.charge_owner_desc,'50'),', ',COALESCE(T11.visit_fee_type_desc,'50'),'| ',
COALESCE(T12.visitor_type_desc,'50'),', ',COALESCE(T12.visit_count_from,'50'),', ',COALESCE(T12.visit_count_to,'50'),', ', COALESCE(T12.visit_validity_type_desc,'50'),', ',COALESCE(T12.charge_owner_desc,'50'),', ',COALESCE(T12.visit_fee_type_desc,'50'),'| ',
COALESCE(T13.visitor_type_desc,'50'),', ',COALESCE(T13.visit_count_from,'50'),', ',COALESCE(T13.visit_count_to,'50'),', ', COALESCE(T13.visit_validity_type_desc,'50'),', ',COALESCE(T13.charge_owner_desc,'50'),', ',COALESCE(T13.visit_fee_type_desc,'50')) AS 'First Year Entitlement Method Standard',
CONCAT(COALESCE(T50.visitor_type_desc,'50'),', ',COALESCE(T50.visit_count_from,'50'),', ',COALESCE(T50.visit_count_to,'50'),', ', COALESCE(T50.visit_validity_type_desc,'50'),', ',COALESCE(T50.charge_owner_desc,'50'),', ',COALESCE(T50.visit_fee_type_desc,'50'),'| ',
COALESCE(T51.visitor_type_desc,'50'),', ',COALESCE(T51.visit_count_from,'50'),', ',COALESCE(T51.visit_count_to,'50'),', ', COALESCE(T51.visit_validity_type_desc,'50'),', ',COALESCE(T51.charge_owner_desc,'50'),', ',COALESCE(T51.visit_fee_type_desc,'50'),'| ',
COALESCE(T52.visitor_type_desc,'50'),', ',COALESCE(T52.visit_count_from,'50'),', ',COALESCE(T52.visit_count_to,'50'),', ', COALESCE(T52.visit_validity_type_desc,'50'),', ',COALESCE(T52.charge_owner_desc,'50'),', ',COALESCE(T52.visit_fee_type_desc,'50'),'| ',
COALESCE(T53.visitor_type_desc,'50'),', ',COALESCE(T53.visit_count_from,'50'),', ',COALESCE(T53.visit_count_to,'50'),', ', COALESCE(T53.visit_validity_type_desc,'50'),', ',COALESCE(T53.charge_owner_desc,'50'),', ',COALESCE(T53.visit_fee_type_desc,'50'),'| ',
COALESCE(T54.visitor_type_desc,'50'),', ',COALESCE(T54.visit_count_from,'50'),', ',COALESCE(T54.visit_count_to,'50'),', ', COALESCE(T54.visit_validity_type_desc,'50'),', ',COALESCE(T54.charge_owner_desc,'50'),', ',COALESCE(T54.visit_fee_type_desc,'50'),'| ',
COALESCE(T55.visitor_type_desc,'50'),', ',COALESCE(T55.visit_count_from,'50'),', ',COALESCE(T55.visit_count_to,'50'),', ', COALESCE(T55.visit_validity_type_desc,'50'),', ',COALESCE(T55.charge_owner_desc,'50'),', ',COALESCE(T55.visit_fee_type_desc,'50'),'| ',
COALESCE(T56.visitor_type_desc,'50'),', ',COALESCE(T56.visit_count_from,'50'),', ',COALESCE(T56.visit_count_to,'50'),', ', COALESCE(T56.visit_validity_type_desc,'50'),', ',COALESCE(T56.charge_owner_desc,'50'),', ',COALESCE(T56.visit_fee_type_desc,'50'),'| ',
COALESCE(T57.visitor_type_desc,'50'),', ',COALESCE(T57.visit_count_from,'50'),', ',COALESCE(T57.visit_count_to,'50'),', ', COALESCE(T57.visit_validity_type_desc,'50'),', ',COALESCE(T57.charge_owner_desc,'50'),', ',COALESCE(T57.visit_fee_type_desc,'50'),'| ',
COALESCE(T58.visitor_type_desc,'50'),', ',COALESCE(T58.visit_count_from,'50'),', ',COALESCE(T58.visit_count_to,'50'),', ', COALESCE(T58.visit_validity_type_desc,'50'),', ',COALESCE(T58.charge_owner_desc,'50'),', ',COALESCE(T58.visit_fee_type_desc,'50'),'| ',
COALESCE(T59.visitor_type_desc,'50'),', ',COALESCE(T59.visit_count_from,'50'),', ',COALESCE(T59.visit_count_to,'50'),', ', COALESCE(T59.visit_validity_type_desc,'50'),', ',COALESCE(T59.charge_owner_desc,'50'),', ',COALESCE(T59.visit_fee_type_desc,'50'),'| ',
COALESCE(T60.visitor_type_desc,'50'),', ',COALESCE(T60.visit_count_from,'50'),', ',COALESCE(T60.visit_count_to,'50'),', ', COALESCE(T60.visit_validity_type_desc,'50'),', ',COALESCE(T60.charge_owner_desc,'50'),', ',COALESCE(T60.visit_fee_type_desc,'50'),'| ',
COALESCE(T61.visitor_type_desc,'50'),', ',COALESCE(T61.visit_count_from,'50'),', ',COALESCE(T61.visit_count_to,'50'),', ', COALESCE(T61.visit_validity_type_desc,'50'),', ',COALESCE(T61.charge_owner_desc,'50'),', ',COALESCE(T61.visit_fee_type_desc,'50')) AS 'Entitlement Method Standard',
CONCAT(COALESCE(T62.visitor_type_desc,'50'),', ',COALESCE(T62.visit_count_from,'50'),', ',COALESCE(T62.visit_count_to,'50'),', ', COALESCE(T62.visit_validity_type_desc,'50'),', ',COALESCE(T62.charge_owner_desc,'50'),', ',COALESCE(T62.visit_fee_type_desc,'50'),'| ',
COALESCE(T63.visitor_type_desc,'50'),', ',COALESCE(T63.visit_count_from,'50'),', ',COALESCE(T63.visit_count_to,'50'),', ', COALESCE(T63.visit_validity_type_desc,'50'),', ',COALESCE(T63.charge_owner_desc,'50'),', ',COALESCE(T63.visit_fee_type_desc,'50'),'| ',
COALESCE(T64.visitor_type_desc,'50'),', ',COALESCE(T64.visit_count_from,'50'),', ',COALESCE(T64.visit_count_to,'50'),', ', COALESCE(T64.visit_validity_type_desc,'50'),', ',COALESCE(T64.charge_owner_desc,'50'),', ',COALESCE(T64.visit_fee_type_desc,'50'),'| ',
COALESCE(T65.visitor_type_desc,'50'),', ',COALESCE(T65.visit_count_from,'50'),', ',COALESCE(T65.visit_count_to,'50'),', ', COALESCE(T65.visit_validity_type_desc,'50'),', ',COALESCE(T65.charge_owner_desc,'50'),', ',COALESCE(T65.visit_fee_type_desc,'50'),'| ',
COALESCE(T66.visitor_type_desc,'50'),', ',COALESCE(T66.visit_count_from,'50'),', ',COALESCE(T66.visit_count_to,'50'),', ', COALESCE(T66.visit_validity_type_desc,'50'),', ',COALESCE(T66.charge_owner_desc,'50'),', ',COALESCE(T66.visit_fee_type_desc,'50'),'| ',
COALESCE(T67.visitor_type_desc,'50'),', ',COALESCE(T67.visit_count_from,'50'),', ',COALESCE(T67.visit_count_to,'50'),', ', COALESCE(T67.visit_validity_type_desc,'50'),', ',COALESCE(T67.charge_owner_desc,'50'),', ',COALESCE(T67.visit_fee_type_desc,'50'),'| ',
COALESCE(T68.visitor_type_desc,'50'),', ',COALESCE(T68.visit_count_from,'50'),', ',COALESCE(T68.visit_count_to,'50'),', ', COALESCE(T68.visit_validity_type_desc,'50'),', ',COALESCE(T68.charge_owner_desc,'50'),', ',COALESCE(T68.visit_fee_type_desc,'50'),'| ',
COALESCE(T69.visitor_type_desc,'50'),', ',COALESCE(T69.visit_count_from,'50'),', ',COALESCE(T69.visit_count_to,'50'),', ', COALESCE(T69.visit_validity_type_desc,'50'),', ',COALESCE(T69.charge_owner_desc,'50'),', ',COALESCE(T69.visit_fee_type_desc,'50'),'| ',
COALESCE(T70.visitor_type_desc,'50'),', ',COALESCE(T70.visit_count_from,'50'),', ',COALESCE(T70.visit_count_to,'50'),', ', COALESCE(T70.visit_validity_type_desc,'50'),', ',COALESCE(T70.charge_owner_desc,'50'),', ',COALESCE(T70.visit_fee_type_desc,'50'),'| ',
COALESCE(T71.visitor_type_desc,'50'),', ',COALESCE(T71.visit_count_from,'50'),', ',COALESCE(T71.visit_count_to,'50'),', ', COALESCE(T71.visit_validity_type_desc,'50'),', ',COALESCE(T71.charge_owner_desc,'50'),', ',COALESCE(T71.visit_fee_type_desc,'50'),'| ',
COALESCE(T72.visitor_type_desc,'50'),', ',COALESCE(T72.visit_count_from,'50'),', ',COALESCE(T72.visit_count_to,'50'),', ', COALESCE(T72.visit_validity_type_desc,'50'),', ',COALESCE(T72.charge_owner_desc,'50'),', ',COALESCE(T72.visit_fee_type_desc,'50'),'| ',
COALESCE(T73.visitor_type_desc,'50'),', ',COALESCE(T73.visit_count_from,'50'),', ',COALESCE(T73.visit_count_to,'50'),', ', COALESCE(T73.visit_validity_type_desc,'50'),', ',COALESCE(T73.charge_owner_desc,'50'),', ',COALESCE(T73.visit_fee_type_desc,'50')) AS 'Entitlement Method Standard Plus',
CONCAT(COALESCE(T74.visitor_type_desc,'50'),', ',COALESCE(T74.visit_count_from,'50'),', ',COALESCE(T74.visit_count_to,'50'),', ', COALESCE(T74.visit_validity_type_desc,'50'),', ',COALESCE(T74.charge_owner_desc,'50'),', ',COALESCE(T74.visit_fee_type_desc,'50'),'| ',
COALESCE(T75.visitor_type_desc,'50'),', ',COALESCE(T75.visit_count_from,'50'),', ',COALESCE(T75.visit_count_to,'50'),', ', COALESCE(T75.visit_validity_type_desc,'50'),', ',COALESCE(T75.charge_owner_desc,'50'),', ',COALESCE(T75.visit_fee_type_desc,'50'),'| ',
COALESCE(T76.visitor_type_desc,'50'),', ',COALESCE(T76.visit_count_from,'50'),', ',COALESCE(T76.visit_count_to,'50'),', ', COALESCE(T76.visit_validity_type_desc,'50'),', ',COALESCE(T76.charge_owner_desc,'50'),', ',COALESCE(T76.visit_fee_type_desc,'50'),'| ',
COALESCE(T77.visitor_type_desc,'50'),', ',COALESCE(T77.visit_count_from,'50'),', ',COALESCE(T77.visit_count_to,'50'),', ', COALESCE(T77.visit_validity_type_desc,'50'),', ',COALESCE(T77.charge_owner_desc,'50'),', ',COALESCE(T77.visit_fee_type_desc,'50'),'| ',
COALESCE(T78.visitor_type_desc,'50'),', ',COALESCE(T78.visit_count_from,'50'),', ',COALESCE(T78.visit_count_to,'50'),', ', COALESCE(T78.visit_validity_type_desc,'50'),', ',COALESCE(T78.charge_owner_desc,'50'),', ',COALESCE(T78.visit_fee_type_desc,'50'),'| ',
COALESCE(T79.visitor_type_desc,'50'),', ',COALESCE(T79.visit_count_from,'50'),', ',COALESCE(T79.visit_count_to,'50'),', ', COALESCE(T79.visit_validity_type_desc,'50'),', ',COALESCE(T79.charge_owner_desc,'50'),', ',COALESCE(T79.visit_fee_type_desc,'50'),'| ',
COALESCE(T80.visitor_type_desc,'50'),', ',COALESCE(T80.visit_count_from,'50'),', ',COALESCE(T80.visit_count_to,'50'),', ', COALESCE(T80.visit_validity_type_desc,'50'),', ',COALESCE(T80.charge_owner_desc,'50'),', ',COALESCE(T80.visit_fee_type_desc,'50'),'| ',
COALESCE(T81.visitor_type_desc,'50'),', ',COALESCE(T81.visit_count_from,'50'),', ',COALESCE(T81.visit_count_to,'50'),', ', COALESCE(T81.visit_validity_type_desc,'50'),', ',COALESCE(T81.charge_owner_desc,'50'),', ',COALESCE(T81.visit_fee_type_desc,'50'),'| ',
COALESCE(T82.visitor_type_desc,'50'),', ',COALESCE(T82.visit_count_from,'50'),', ',COALESCE(T82.visit_count_to,'50'),', ', COALESCE(T82.visit_validity_type_desc,'50'),', ',COALESCE(T82.charge_owner_desc,'50'),', ',COALESCE(T82.visit_fee_type_desc,'50'),'| ',
COALESCE(T83.visitor_type_desc,'50'),', ',COALESCE(T83.visit_count_from,'50'),', ',COALESCE(T83.visit_count_to,'50'),', ', COALESCE(T83.visit_validity_type_desc,'50'),', ',COALESCE(T83.charge_owner_desc,'50'),', ',COALESCE(T83.visit_fee_type_desc,'50'),'| ',
COALESCE(T84.visitor_type_desc,'50'),', ',COALESCE(T84.visit_count_from,'50'),', ',COALESCE(T84.visit_count_to,'50'),', ', COALESCE(T84.visit_validity_type_desc,'50'),', ',COALESCE(T84.charge_owner_desc,'50'),', ',COALESCE(T84.visit_fee_type_desc,'50'),'| ',
COALESCE(T85.visitor_type_desc,'50'),', ',COALESCE(T85.visit_count_from,'50'),', ',COALESCE(T85.visit_count_to,'50'),', ', COALESCE(T85.visit_validity_type_desc,'50'),', ',COALESCE(T85.charge_owner_desc,'50'),', ',COALESCE(T85.visit_fee_type_desc,'50')) AS 'Entitlement Method Prestige'
from #temp AS T
	LEFT JOIN #temp1 AS T2 WITH (NOLOCK)
	ON T2.source_code = T.source_code
	LEFT JOIN #temp2 AS T3 WITH (NOLOCK)
	ON T3.source_code = T.source_code
	LEFT JOIN #temp3 AS T4 WITH (NOLOCK)
	ON T4.source_code = T.source_code
	LEFT JOIN #temp4 AS T5 WITH (NOLOCK)
	ON T5.source_code = T.source_code
	LEFT JOIN #temp5 AS T6 WITH (NOLOCK)
	ON T6.source_code = T.source_code
	LEFT JOIN #temp6 AS T7 WITH (NOLOCK)
	ON T7.source_code = T.source_code
	LEFT JOIN #temp7 AS T8 WITH (NOLOCK)
	ON T8.source_code = T.source_code
	LEFT JOIN #temp8 AS T9 WITH (NOLOCK)
	ON T9.source_code = T.source_code
	LEFT JOIN #temp9 AS T10 WITH (NOLOCK)
	ON T10.source_code = T.source_code
	LEFT JOIN #temp10 AS T11 WITH (NOLOCK)
	ON T11.source_code = T.source_code
	LEFT JOIN #temp11 AS T12 WITH (NOLOCK)
	ON T12.source_code = T.source_code
	LEFT JOIN #temp12 AS T13 WITH (NOLOCK)
	ON T13.source_code = T.source_code
	LEFT JOIN #temp49 AS T50 WITH (NOLOCK)
	ON T50.source_code = T.source_code
	LEFT JOIN #temp50 AS T51 WITH (NOLOCK)
	ON T51.source_code = T.source_code
	LEFT JOIN #temp51 AS T52 WITH (NOLOCK)
	ON T52.source_code = T.source_code
	LEFT JOIN #temp52 AS T53 WITH (NOLOCK)
	ON T53.source_code = T.source_code
	LEFT JOIN #temp53 AS T54 WITH (NOLOCK)
	ON T54.source_code = T.source_code
	LEFT JOIN #temp54 AS T55 WITH (NOLOCK)
	ON T55.source_code = T.source_code
	LEFT JOIN #temp55 AS T56 WITH (NOLOCK)
	ON T56.source_code = T.source_code
	LEFT JOIN #temp56 AS T57 WITH (NOLOCK)
	ON T57.source_code = T.source_code
	LEFT JOIN #temp57 AS T58 WITH (NOLOCK)
	ON T58.source_code = T.source_code
	LEFT JOIN #temp58 AS T59 WITH (NOLOCK)
	ON T59.source_code = T.source_code
	LEFT JOIN #temp59 AS T60 WITH (NOLOCK)
	ON T60.source_code = T.source_code
	LEFT JOIN #temp60 AS T61 WITH (NOLOCK)
	ON T61.source_code = T.source_code
	LEFT JOIN #temp61 AS T62 WITH (NOLOCK)
	ON T62.source_code = T.source_code
	LEFT JOIN #temp62 AS T63 WITH (NOLOCK)
	ON T63.source_code = T.source_code
	LEFT JOIN #temp63 AS T64 WITH (NOLOCK)
	ON T64.source_code = T.source_code
	LEFT JOIN #temp64 AS T65 WITH (NOLOCK)
	ON T65.source_code = T.source_code
	LEFT JOIN #temp65 AS T66 WITH (NOLOCK)
	ON T66.source_code = T.source_code
	LEFT JOIN #temp66 AS T67 WITH (NOLOCK)
	ON T67.source_code = T.source_code
	LEFT JOIN #temp67 AS T68 WITH (NOLOCK)
	ON T68.source_code = T.source_code
	LEFT JOIN #temp68 AS T69 WITH (NOLOCK)
	ON T69.source_code = T.source_code
	LEFT JOIN #temp69 AS T70 WITH (NOLOCK)
	ON T70.source_code = T.source_code
	LEFT JOIN #temp70 AS T71 WITH (NOLOCK)
	ON T71.source_code = T.source_code
	LEFT JOIN #temp71 AS T72 WITH (NOLOCK)
	ON T72.source_code = T.source_code
	LEFT JOIN #temp72 AS T73 WITH (NOLOCK)
	ON T73.source_code = T.source_code
	LEFT JOIN #temp73 AS T74 WITH (NOLOCK)
	ON T74.source_code = T.source_code
	LEFT JOIN #temp74 AS T75 WITH (NOLOCK)
	ON T75.source_code = T.source_code
	LEFT JOIN #temp75 AS T76 WITH (NOLOCK)
	ON T76.source_code = T.source_code
	LEFT JOIN #temp76 AS T77 WITH (NOLOCK)
	ON T77.source_code = T.source_code
	LEFT JOIN #temp77 AS T78 WITH (NOLOCK)
	ON T78.source_code = T.source_code
	LEFT JOIN #temp78 AS T79 WITH (NOLOCK)
	ON T79.source_code = T.source_code
	LEFT JOIN #temp79 AS T80 WITH (NOLOCK)
	ON T80.source_code = T.source_code
	LEFT JOIN #temp80 AS T81 WITH (NOLOCK)
	ON T81.source_code = T.source_code
	LEFT JOIN #temp81 AS T82 WITH (NOLOCK)
	ON T82.source_code = T.source_code
	LEFT JOIN #temp82 AS T83 WITH (NOLOCK)
	ON T83.source_code = T.source_code
	LEFT JOIN #temp83 AS T84 WITH (NOLOCK)
	ON T84.source_code = T.source_code
	LEFT JOIN #temp84 AS T85 WITH (NOLOCK)
	ON T85.source_code = T.source_code