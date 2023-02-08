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
ON vas.source_deal_config_id = sdc.source_deal_config_id
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
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';


-- First Year Only is 1

--Where subscription level is standard, visitor type description is Member and the visit count is equal to 0 and is equal to 9999

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

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Member and the visit count is equal to 0 and is not equal to 9999

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

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Member and the visit count is not equal to 0 and is not equal to 9999

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

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Member and the visit count is not equal to 0 and is equal to 9999

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

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Guest and the visit count is equal to 0 and is equal to 9999

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

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Guest and the visit count is equal to 0 and is not equal to 9999

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

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Guest and the visit count is not equal to 0 and is not equal to 9999

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

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Guest and the visit count is not equal to 0 and is equal to 9999

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

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Member/Guest and the visit count is equal to 0 and is equal to 9999

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

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Member/Guest and the visit count is equal to 0 and is not equal to 9999

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

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Member/Guest and the visit count is not equal to 0 and is not equal to 9999

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

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Member/Guest and the visit count is not equal to 0 and is equal to 9999

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

-- First Year Only is 1

--Where subscription level is Standard Plus, visitor type description is Member and the visit count is equal to 0 and is equal to 9999

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
INTO #TEMP13
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Standard Plus, visitor type description is Member and the visit count is equal to 0 and is not equal to 9999

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
INTO #TEMP14
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Standard Plus, visitor type description is Member and the visit count is not equal to 0 and is not equal to 9999

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
INTO #TEMP15
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Standard Plus, visitor type description is Member and the visit count is not equal to 0 and is equal to 9999

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
INTO #TEMP16
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Standard Plus, visitor type description is Guest and the visit count is equal to 0 and is equal to 9999

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
INTO #TEMP17
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Standard Plus, visitor type description is Guest and the visit count is equal to 0 and is not equal to 9999

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
INTO #TEMP18
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Standard Plus, visitor type description is Guest and the visit count is not equal to 0 and is not equal to 9999

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
INTO #TEMP19
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Standard Plus, visitor type description is Guest and the visit count is not equal to 0 and is equal to 9999

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
INTO #TEMP20
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Standard Plus, visitor type description is Member/Guest and the visit count is equal to 0 and is equal to 9999

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
INTO #TEMP21
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Standard Plus, visitor type description is Member/Guest and the visit count is equal to 0 and is not equal to 9999

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
INTO #TEMP22
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Standard Plus, visitor type description is Member/Guest and the visit count is not equal to 0 and is not equal to 9999

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
INTO #TEMP23
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Standard Plus, visitor type description is Member/Guest and the visit count is not equal to 0 and is equal to 9999

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
INTO #TEMP24
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige, visitor type description is Member and the visit count is equal to 0 and is equal to 9999

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
INTO #TEMP25
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige, visitor type description is Member and the visit count is equal to 0 and is not equal to 9999

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
INTO #TEMP26
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige, visitor type description is Member and the visit count is not equal to 0 and is not equal to 9999

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
INTO #TEMP27
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige, visitor type description is Member and the visit count is not equal to 0 and is equal to 9999

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
INTO #TEMP28
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige, visitor type description is Guest and the visit count is equal to 0 and is equal to 9999

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
INTO #TEMP29
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige, visitor type description is Guest and the visit count is equal to 0 and is not equal to 9999

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
INTO #TEMP30
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige, visitor type description is Guest and the visit count is not equal to 0 and is not equal to 9999

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
INTO #TEMP31
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige, visitor type description is Guest and the visit count is not equal to 0 and is equal to 9999

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
INTO #TEMP32
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige, visitor type description is Member/Guest and the visit count is equal to 0 and is equal to 9999

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
INTO #TEMP33
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige, visitor type description is Member/Guest and the visit count is equal to 0 and is not equal to 9999

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
INTO #TEMP34
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige, visitor type description is Member/Guest and the visit count is not equal to 0 and is not equal to 9999

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
INTO #TEMP35
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige, visitor type description is Member/Guest and the visit count is not equal to 0 and is equal to 9999

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
INTO #TEMP36
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
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige Plus, visitor type description is Member and the visit count is equal to 0 and is equal to 9999

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
INTO #TEMP37
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige Plus, visitor type description is Member and the visit count is equal to 0 and is not equal to 9999

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
INTO #TEMP38
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige Plus, visitor type description is Member and the visit count is not equal to 0 and is not equal to 9999

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
INTO #TEMP39
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige Plus, visitor type description is Member and the visit count is not equal to 0 and is equal to 9999

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
INTO #TEMP40
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige Plus, visitor type description is Guest and the visit count is equal to 0 and is equal to 9999

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
INTO #TEMP41
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige Plus, visitor type description is Guest and the visit count is equal to 0 and is not equal to 9999

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
INTO #TEMP42
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige Plus, visitor type description is Guest and the visit count is not equal to 0 and is not equal to 9999

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
INTO #TEMP43
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige Plus, visitor type description is Guest and the visit count is not equal to 0 and is equal to 9999

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
INTO #TEMP44
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige Plus, visitor type description is Member/Guest and the visit count is equal to 0 and is equal to 9999

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
INTO #TEMP45
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige Plus, visitor type description is Member/Guest and the visit count is equal to 0 and is not equal to 9999

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
INTO #TEMP46
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige Plus, visitor type description is Member/Guest and the visit count is not equal to 0 and is not equal to 9999

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
INTO #TEMP47
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 1

--Where subscription level is Prestige Plus, visitor type description is Member/Guest and the visit count is not equal to 0 and is equal to 9999

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
INTO #TEMP48
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 1
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';


-- First Year Only is 0

--Where subscription level is Standard, visitor type description is Member and the visit count is equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard, visitor type description is Member and the visit count is equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard, visitor type description is Member and the visit count is not equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard, visitor type description is Member and the visit count is not equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard, visitor type description is Guest and the visit count is equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard, visitor type description is Guest and the visit count is equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard, visitor type description is Guest and the visit count is not equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard, visitor type description is Guest and the visit count is not equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard, visitor type description is Member/Guest and the visit count is equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard, visitor type description is Member/Guest and the visit count is equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard, visitor type description is Member/Guest and the visit count is not equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard, visitor type description is Member/Guest and the visit count is not equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard Plus, visitor type description is Member and the visit count is equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard Plus, visitor type description is Member and the visit count is equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard Plus, visitor type description is Member and the visit count is not equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard Plus, visitor type description is Member and the visit count is not equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard Plus, visitor type description is Guest and the visit count is equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard Plus, visitor type description is Guest and the visit count is equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard Plus, visitor type description is Guest and the visit count is not equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard Plus, visitor type description is Guest and the visit count is not equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard Plus, visitor type description is Member/Guest and the visit count is equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard Plus, visitor type description is Member/Guest and the visit count is equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard Plus, visitor type description is Member/Guest and the visit count is not equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Standard Plus, visitor type description is Member/Guest and the visit count is not equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Prestige, visitor type description is Member and the visit count is equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Prestige, visitor type description is Member and the visit count is equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Prestige, visitor type description is Member and the visit count is not equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Prestige, visitor type description is Member and the visit count is not equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Prestige, visitor type description is Guest and the visit count is equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Prestige, visitor type description is Guest and the visit count is equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Prestige, visitor type description is Guest and the visit count is not equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Prestige, visitor type description is Guest and the visit count is not equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Prestige, visitor type description is Member/Guest and the visit count is equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Prestige, visitor type description is Member/Guest and the visit count is equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Prestige, visitor type description is Member/Guest and the visit count is not equal to 0 and is not equal to 9999

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

-- First Year Only is 0

--Where subscription level is Prestige, visitor type description is Member/Guest and the visit count is not equal to 0 and is equal to 9999

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

-- First Year Only is 0

--Where subscription level is Prestige Plus, visitor type description is Member/Guest and the visit count is equal to 0 and is equal to 9999

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
INTO #TEMP85
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 0

--Where subscription level is Prestige Plus, visitor type description is Member and the visit count is equal to 0 and is not equal to 9999

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
INTO #TEMP86
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 0

--Where subscription level is Prestige Plus, visitor type description is Member and the visit count is not equal to 0 and is not equal to 9999

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
INTO #TEMP87
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 0

--Where subscription level is Prestige Plus, visitor type description is Member and the visit count is not equal to 0 and is equal to 9999

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
INTO #TEMP88
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 0

--Where subscription level is Prestige Plus, visitor type description is Guest and the visit count is equal to 0 and is equal to 9999

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
INTO #TEMP89
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 0

--Where subscription level is Prestige Plus, visitor type description is Guest and the visit count is equal to 0 and is not equal to 9999

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
INTO #TEMP90
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 0

--Where subscription level is Prestige Plus, visitor type description is Guest and the visit count is not equal to 0 and is not equal to 9999

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
INTO #TEMP91
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 0

--Where subscription level is Prestige Plus, visitor type description is Guest and the visit count is not equal to 0 and is equal to 9999

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
INTO #TEMP92
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 0

--Where subscription level is Prestige Plus, visitor type description is Member/Guest and the visit count is equal to 0 and is equal to 9999

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
INTO #TEMP93
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 0

--Where subscription level is Prestige Plus, visitor type description is Member/Guest and the visit count is equal to 0 and is not equal to 9999

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
INTO #TEMP94
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 0

--Where subscription level is Prestige Plus, visitor type description is Member/Guest and the visit count is not equal to 0 and is not equal to 9999

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
INTO #TEMP95
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- First Year Only is 0

--Where subscription level is Prestige Plus, visitor type description is Member/Guest and the visit count is not equal to 0 and is equal to 9999

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
INTO #TEMP96
FROM source AS s
INNER JOIN source_deal_config AS sdc WITH (NOLOCK)
ON sdc.source_code = s.source_code
INNER join source_visit_allocation_set as vas WITH (NOLOCK)
ON vas.source_deal_config_id = sdc.source_deal_config_id AND vas.subscription_level_id=4
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
AND sl.subscription_level_desc = 'Prestige Plus'
AND sva.first_year_only = 0
AND	s.source_desc NOT LIKE '%demo%' AND s.source_desc NOT LIKE '%temp%' AND s.source_desc NOT LIKE '%Do No%' AND s.source_desc NOT LIKE '%test%' AND s.source_desc NOT LIKE '%error%' AND s.source_desc NOT LIKE '%use%';

-- Now when we have isolated all the separate areas of interest in the entitlement we have to concatenate them all together

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
CONCAT(COALESCE(T14.visitor_type_desc,'50'),', ',COALESCE(T14.visit_count_from,'50'),', ',COALESCE(T14.visit_count_to,'50'),', ', COALESCE(T14.visit_validity_type_desc,'50'),', ',COALESCE(T14.charge_owner_desc,'50'),', ',COALESCE(T14.visit_fee_type_desc,'50'),'| ',
COALESCE(T15.visitor_type_desc,'50'),', ',COALESCE(T15.visit_count_from,'50'),', ',COALESCE(T15.visit_count_to,'50'),', ', COALESCE(T15.visit_validity_type_desc,'50'),', ',COALESCE(T15.charge_owner_desc,'50'),', ',COALESCE(T15.visit_fee_type_desc,'50'),'| ',
COALESCE(T16.visitor_type_desc,'50'),', ',COALESCE(T16.visit_count_from,'50'),', ',COALESCE(T16.visit_count_to,'50'),', ', COALESCE(T16.visit_validity_type_desc,'50'),', ',COALESCE(T16.charge_owner_desc,'50'),', ',COALESCE(T16.visit_fee_type_desc,'50'),'| ',
COALESCE(T17.visitor_type_desc,'50'),', ',COALESCE(T17.visit_count_from,'50'),', ',COALESCE(T17.visit_count_to,'50'),', ', COALESCE(T17.visit_validity_type_desc,'50'),', ',COALESCE(T17.charge_owner_desc,'50'),', ',COALESCE(T17.visit_fee_type_desc,'50'),'| ',
COALESCE(T18.visitor_type_desc,'50'),', ',COALESCE(T18.visit_count_from,'50'),', ',COALESCE(T18.visit_count_to,'50'),', ', COALESCE(T18.visit_validity_type_desc,'50'),', ',COALESCE(T18.charge_owner_desc,'50'),', ',COALESCE(T18.visit_fee_type_desc,'50'),'| ',
COALESCE(T19.visitor_type_desc,'50'),', ',COALESCE(T19.visit_count_from,'50'),', ',COALESCE(T19.visit_count_to,'50'),', ', COALESCE(T19.visit_validity_type_desc,'50'),', ',COALESCE(T19.charge_owner_desc,'50'),', ',COALESCE(T19.visit_fee_type_desc,'50'),'| ',
COALESCE(T20.visitor_type_desc,'50'),', ',COALESCE(T20.visit_count_from,'50'),', ',COALESCE(T20.visit_count_to,'50'),', ', COALESCE(T20.visit_validity_type_desc,'50'),', ',COALESCE(T20.charge_owner_desc,'50'),', ',COALESCE(T20.visit_fee_type_desc,'50'),'| ',
COALESCE(T21.visitor_type_desc,'50'),', ',COALESCE(T21.visit_count_from,'50'),', ',COALESCE(T21.visit_count_to,'50'),', ', COALESCE(T21.visit_validity_type_desc,'50'),', ',COALESCE(T21.charge_owner_desc,'50'),', ',COALESCE(T21.visit_fee_type_desc,'50'),'| ',
COALESCE(T22.visitor_type_desc,'50'),', ',COALESCE(T22.visit_count_from,'50'),', ',COALESCE(T22.visit_count_to,'50'),', ', COALESCE(T22.visit_validity_type_desc,'50'),', ',COALESCE(T22.charge_owner_desc,'50'),', ',COALESCE(T22.visit_fee_type_desc,'50'),'| ',
COALESCE(T23.visitor_type_desc,'50'),', ',COALESCE(T23.visit_count_from,'50'),', ',COALESCE(T23.visit_count_to,'50'),', ', COALESCE(T23.visit_validity_type_desc,'50'),', ',COALESCE(T23.charge_owner_desc,'50'),', ',COALESCE(T23.visit_fee_type_desc,'50'),'| ',
COALESCE(T24.visitor_type_desc,'50'),', ',COALESCE(T24.visit_count_from,'50'),', ',COALESCE(T24.visit_count_to,'50'),', ', COALESCE(T24.visit_validity_type_desc,'50'),', ',COALESCE(T24.charge_owner_desc,'50'),', ',COALESCE(T24.visit_fee_type_desc,'50'),'| ',
COALESCE(T25.visitor_type_desc,'50'),', ',COALESCE(T25.visit_count_from,'50'),', ',COALESCE(T25.visit_count_to,'50'),', ', COALESCE(T25.visit_validity_type_desc,'50'),', ',COALESCE(T25.charge_owner_desc,'50'),', ',COALESCE(T25.visit_fee_type_desc,'50')) AS 'First Year Entitlement Method Standard Plus',
CONCAT(COALESCE(T26.visitor_type_desc,'50'),', ',COALESCE(T26.visit_count_from,'50'),', ',COALESCE(T26.visit_count_to,'50'),', ', COALESCE(T26.visit_validity_type_desc,'50'),', ',COALESCE(T26.charge_owner_desc,'50'),', ',COALESCE(T26.visit_fee_type_desc,'50'),'| ',
COALESCE(T27.visitor_type_desc,'50'),', ',COALESCE(T27.visit_count_from,'50'),', ',COALESCE(T27.visit_count_to,'50'),', ', COALESCE(T27.visit_validity_type_desc,'50'),', ',COALESCE(T27.charge_owner_desc,'50'),', ',COALESCE(T27.visit_fee_type_desc,'50'),'| ',
COALESCE(T28.visitor_type_desc,'50'),', ',COALESCE(T28.visit_count_from,'50'),', ',COALESCE(T28.visit_count_to,'50'),', ', COALESCE(T28.visit_validity_type_desc,'50'),', ',COALESCE(T28.charge_owner_desc,'50'),', ',COALESCE(T28.visit_fee_type_desc,'50'),'| ',
COALESCE(T29.visitor_type_desc,'50'),', ',COALESCE(T29.visit_count_from,'50'),', ',COALESCE(T29.visit_count_to,'50'),', ', COALESCE(T29.visit_validity_type_desc,'50'),', ',COALESCE(T29.charge_owner_desc,'50'),', ',COALESCE(T29.visit_fee_type_desc,'50'),'| ',
COALESCE(T30.visitor_type_desc,'50'),', ',COALESCE(T30.visit_count_from,'50'),', ',COALESCE(T30.visit_count_to,'50'),', ', COALESCE(T30.visit_validity_type_desc,'50'),', ',COALESCE(T30.charge_owner_desc,'50'),', ',COALESCE(T30.visit_fee_type_desc,'50'),'| ',
COALESCE(T31.visitor_type_desc,'50'),', ',COALESCE(T31.visit_count_from,'50'),', ',COALESCE(T31.visit_count_to,'50'),', ', COALESCE(T31.visit_validity_type_desc,'50'),', ',COALESCE(T31.charge_owner_desc,'50'),', ',COALESCE(T31.visit_fee_type_desc,'50'),'| ',
COALESCE(T32.visitor_type_desc,'50'),', ',COALESCE(T32.visit_count_from,'50'),', ',COALESCE(T32.visit_count_to,'50'),', ', COALESCE(T32.visit_validity_type_desc,'50'),', ',COALESCE(T32.charge_owner_desc,'50'),', ',COALESCE(T32.visit_fee_type_desc,'50'),'| ',
COALESCE(T33.visitor_type_desc,'50'),', ',COALESCE(T33.visit_count_from,'50'),', ',COALESCE(T33.visit_count_to,'50'),', ', COALESCE(T33.visit_validity_type_desc,'50'),', ',COALESCE(T33.charge_owner_desc,'50'),', ',COALESCE(T33.visit_fee_type_desc,'50'),'| ',
COALESCE(T34.visitor_type_desc,'50'),', ',COALESCE(T34.visit_count_from,'50'),', ',COALESCE(T34.visit_count_to,'50'),', ', COALESCE(T34.visit_validity_type_desc,'50'),', ',COALESCE(T34.charge_owner_desc,'50'),', ',COALESCE(T34.visit_fee_type_desc,'50'),'| ',
COALESCE(T35.visitor_type_desc,'50'),', ',COALESCE(T35.visit_count_from,'50'),', ',COALESCE(T35.visit_count_to,'50'),', ', COALESCE(T35.visit_validity_type_desc,'50'),', ',COALESCE(T35.charge_owner_desc,'50'),', ',COALESCE(T35.visit_fee_type_desc,'50'),'| ',
COALESCE(T36.visitor_type_desc,'50'),', ',COALESCE(T36.visit_count_from,'50'),', ',COALESCE(T36.visit_count_to,'50'),', ', COALESCE(T36.visit_validity_type_desc,'50'),', ',COALESCE(T36.charge_owner_desc,'50'),', ',COALESCE(T36.visit_fee_type_desc,'50'),'| ',
COALESCE(T37.visitor_type_desc,'50'),', ',COALESCE(T37.visit_count_from,'50'),', ',COALESCE(T37.visit_count_to,'50'),', ', COALESCE(T37.visit_validity_type_desc,'50'),', ',COALESCE(T37.charge_owner_desc,'50'),', ',COALESCE(T37.visit_fee_type_desc,'50')) AS 'First Year Entitlement Method Prestige',
CONCAT(COALESCE(T38.visitor_type_desc,'50'),', ',COALESCE(T38.visit_count_from,'50'),', ',COALESCE(T38.visit_count_to,'50'),', ', COALESCE(T38.visit_validity_type_desc,'50'),', ',COALESCE(T38.charge_owner_desc,'50'),', ',COALESCE(T38.visit_fee_type_desc,'50'),'| ',
COALESCE(T39.visitor_type_desc,'50'),', ',COALESCE(T39.visit_count_from,'50'),', ',COALESCE(T39.visit_count_to,'50'),', ', COALESCE(T39.visit_validity_type_desc,'50'),', ',COALESCE(T39.charge_owner_desc,'50'),', ',COALESCE(T39.visit_fee_type_desc,'50'),'| ',
COALESCE(T40.visitor_type_desc,'50'),', ',COALESCE(T40.visit_count_from,'50'),', ',COALESCE(T40.visit_count_to,'50'),', ', COALESCE(T40.visit_validity_type_desc,'50'),', ',COALESCE(T40.charge_owner_desc,'50'),', ',COALESCE(T40.visit_fee_type_desc,'50'),'| ',
COALESCE(T41.visitor_type_desc,'50'),', ',COALESCE(T41.visit_count_from,'50'),', ',COALESCE(T41.visit_count_to,'50'),', ', COALESCE(T41.visit_validity_type_desc,'50'),', ',COALESCE(T41.charge_owner_desc,'50'),', ',COALESCE(T41.visit_fee_type_desc,'50'),'| ',
COALESCE(T42.visitor_type_desc,'50'),', ',COALESCE(T42.visit_count_from,'50'),', ',COALESCE(T42.visit_count_to,'50'),', ', COALESCE(T42.visit_validity_type_desc,'50'),', ',COALESCE(T42.charge_owner_desc,'50'),', ',COALESCE(T42.visit_fee_type_desc,'50'),'| ',
COALESCE(T43.visitor_type_desc,'50'),', ',COALESCE(T43.visit_count_from,'50'),', ',COALESCE(T43.visit_count_to,'50'),', ', COALESCE(T43.visit_validity_type_desc,'50'),', ',COALESCE(T43.charge_owner_desc,'50'),', ',COALESCE(T43.visit_fee_type_desc,'50'),'| ',
COALESCE(T44.visitor_type_desc,'50'),', ',COALESCE(T44.visit_count_from,'50'),', ',COALESCE(T44.visit_count_to,'50'),', ', COALESCE(T44.visit_validity_type_desc,'50'),', ',COALESCE(T44.charge_owner_desc,'50'),', ',COALESCE(T44.visit_fee_type_desc,'50'),'| ',
COALESCE(T45.visitor_type_desc,'50'),', ',COALESCE(T45.visit_count_from,'50'),', ',COALESCE(T45.visit_count_to,'50'),', ', COALESCE(T45.visit_validity_type_desc,'50'),', ',COALESCE(T45.charge_owner_desc,'50'),', ',COALESCE(T45.visit_fee_type_desc,'50'),'| ',
COALESCE(T46.visitor_type_desc,'50'),', ',COALESCE(T46.visit_count_from,'50'),', ',COALESCE(T46.visit_count_to,'50'),', ', COALESCE(T46.visit_validity_type_desc,'50'),', ',COALESCE(T46.charge_owner_desc,'50'),', ',COALESCE(T46.visit_fee_type_desc,'50'),'| ',
COALESCE(T47.visitor_type_desc,'50'),', ',COALESCE(T47.visit_count_from,'50'),', ',COALESCE(T47.visit_count_to,'50'),', ', COALESCE(T47.visit_validity_type_desc,'50'),', ',COALESCE(T47.charge_owner_desc,'50'),', ',COALESCE(T47.visit_fee_type_desc,'50'),'| ',
COALESCE(T48.visitor_type_desc,'50'),', ',COALESCE(T48.visit_count_from,'50'),', ',COALESCE(T48.visit_count_to,'50'),', ', COALESCE(T48.visit_validity_type_desc,'50'),', ',COALESCE(T48.charge_owner_desc,'50'),', ',COALESCE(T48.visit_fee_type_desc,'50'),'| ',
COALESCE(T49.visitor_type_desc,'50'),', ',COALESCE(T49.visit_count_from,'50'),', ',COALESCE(T49.visit_count_to,'50'),', ', COALESCE(T49.visit_validity_type_desc,'50'),', ',COALESCE(T49.charge_owner_desc,'50'),', ',COALESCE(T49.visit_fee_type_desc,'50')) AS 'First Year Entitlement Method Prestige Plus',
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
COALESCE(T85.visitor_type_desc,'50'),', ',COALESCE(T85.visit_count_from,'50'),', ',COALESCE(T85.visit_count_to,'50'),', ', COALESCE(T85.visit_validity_type_desc,'50'),', ',COALESCE(T85.charge_owner_desc,'50'),', ',COALESCE(T85.visit_fee_type_desc,'50')) AS 'Entitlement Method Prestige',
CONCAT(COALESCE(T86.visitor_type_desc,'50'),', ',COALESCE(T86.visit_count_from,'50'),', ',COALESCE(T86.visit_count_to,'50'),', ', COALESCE(T86.visit_validity_type_desc,'50'),', ',COALESCE(T86.charge_owner_desc,'50'),', ',COALESCE(T86.visit_fee_type_desc,'50'),'| ',
COALESCE(T87.visitor_type_desc,'50'),', ',COALESCE(T87.visit_count_from,'50'),', ',COALESCE(T87.visit_count_to,'50'),', ', COALESCE(T87.visit_validity_type_desc,'50'),', ',COALESCE(T87.charge_owner_desc,'50'),', ',COALESCE(T87.visit_fee_type_desc,'50'),'| ',
COALESCE(T88.visitor_type_desc,'50'),', ',COALESCE(T88.visit_count_from,'50'),', ',COALESCE(T88.visit_count_to,'50'),', ', COALESCE(T88.visit_validity_type_desc,'50'),', ',COALESCE(T88.charge_owner_desc,'50'),', ',COALESCE(T88.visit_fee_type_desc,'50'),'| ',
COALESCE(T89.visitor_type_desc,'50'),', ',COALESCE(T89.visit_count_from,'50'),', ',COALESCE(T89.visit_count_to,'50'),', ', COALESCE(T89.visit_validity_type_desc,'50'),', ',COALESCE(T89.charge_owner_desc,'50'),', ',COALESCE(T89.visit_fee_type_desc,'50'),'| ',
COALESCE(T90.visitor_type_desc,'50'),', ',COALESCE(T90.visit_count_from,'50'),', ',COALESCE(T90.visit_count_to,'50'),', ', COALESCE(T90.visit_validity_type_desc,'50'),', ',COALESCE(T90.charge_owner_desc,'50'),', ',COALESCE(T90.visit_fee_type_desc,'50'),'| ',
COALESCE(T91.visitor_type_desc,'50'),', ',COALESCE(T91.visit_count_from,'50'),', ',COALESCE(T91.visit_count_to,'50'),', ', COALESCE(T91.visit_validity_type_desc,'50'),', ',COALESCE(T91.charge_owner_desc,'50'),', ',COALESCE(T91.visit_fee_type_desc,'50'),'| ',
COALESCE(T92.visitor_type_desc,'50'),', ',COALESCE(T92.visit_count_from,'50'),', ',COALESCE(T92.visit_count_to,'50'),', ', COALESCE(T92.visit_validity_type_desc,'50'),', ',COALESCE(T92.charge_owner_desc,'50'),', ',COALESCE(T92.visit_fee_type_desc,'50'),'| ',
COALESCE(T93.visitor_type_desc,'50'),', ',COALESCE(T93.visit_count_from,'50'),', ',COALESCE(T93.visit_count_to,'50'),', ', COALESCE(T93.visit_validity_type_desc,'50'),', ',COALESCE(T93.charge_owner_desc,'50'),', ',COALESCE(T93.visit_fee_type_desc,'50'),'| ',
COALESCE(T94.visitor_type_desc,'50'),', ',COALESCE(T94.visit_count_from,'50'),', ',COALESCE(T94.visit_count_to,'50'),', ', COALESCE(T94.visit_validity_type_desc,'50'),', ',COALESCE(T94.charge_owner_desc,'50'),', ',COALESCE(T94.visit_fee_type_desc,'50'),'| ',
COALESCE(T95.visitor_type_desc,'50'),', ',COALESCE(T95.visit_count_from,'50'),', ',COALESCE(T95.visit_count_to,'50'),', ', COALESCE(T95.visit_validity_type_desc,'50'),', ',COALESCE(T95.charge_owner_desc,'50'),', ',COALESCE(T95.visit_fee_type_desc,'50'),'| ',
COALESCE(T96.visitor_type_desc,'50'),', ',COALESCE(T96.visit_count_from,'50'),', ',COALESCE(T96.visit_count_to,'50'),', ', COALESCE(T96.visit_validity_type_desc,'50'),', ',COALESCE(T96.charge_owner_desc,'50'),', ',COALESCE(T96.visit_fee_type_desc,'50'),'| ',
COALESCE(T97.visitor_type_desc,'50'),', ',COALESCE(T97.visit_count_from,'50'),', ',COALESCE(T97.visit_count_to,'50'),', ', COALESCE(T97.visit_validity_type_desc,'50'),', ',COALESCE(T97.charge_owner_desc,'50'),', ',COALESCE(T97.visit_fee_type_desc,'50')) AS 'Entitlement Method Prestige Plus'
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
	LEFT JOIN #temp13 AS T14 WITH (NOLOCK)
	ON T14.source_code = T.source_code
	LEFT JOIN #temp14 AS T15 WITH (NOLOCK)
	ON T15.source_code = T.source_code
	LEFT JOIN #temp15 AS T16 WITH (NOLOCK)
	ON T16.source_code = T.source_code
	LEFT JOIN #temp16 AS T17 WITH (NOLOCK)
	ON T17.source_code = T.source_code
	LEFT JOIN #temp17 AS T18 WITH (NOLOCK)
	ON T18.source_code = T.source_code
	LEFT JOIN #temp18 AS T19 WITH (NOLOCK)
	ON T19.source_code = T.source_code
	LEFT JOIN #temp19 AS T20 WITH (NOLOCK)
	ON T20.source_code = T.source_code
	LEFT JOIN #temp20 AS T21 WITH (NOLOCK)
	ON T21.source_code = T.source_code
	LEFT JOIN #temp21 AS T22 WITH (NOLOCK)
	ON T22.source_code = T.source_code
	LEFT JOIN #temp22 AS T23 WITH (NOLOCK)
	ON T23.source_code = T.source_code
	LEFT JOIN #temp23 AS T24 WITH (NOLOCK)
	ON T24.source_code = T.source_code
	LEFT JOIN #temp24 AS T25 WITH (NOLOCK)
	ON T25.source_code = T.source_code
	LEFT JOIN #temp25 AS T26 WITH (NOLOCK)
	ON T26.source_code = T.source_code
	LEFT JOIN #temp26 AS T27 WITH (NOLOCK)
	ON T27.source_code = T.source_code
	LEFT JOIN #temp27 AS T28 WITH (NOLOCK)
	ON T28.source_code = T.source_code
	LEFT JOIN #temp28 AS T29 WITH (NOLOCK)
	ON T29.source_code = T.source_code
	LEFT JOIN #temp29 AS T30 WITH (NOLOCK)
	ON T30.source_code = T.source_code
	LEFT JOIN #temp30 AS T31 WITH (NOLOCK)
	ON T31.source_code = T.source_code
	LEFT JOIN #temp31 AS T32 WITH (NOLOCK)
	ON T32.source_code = T.source_code
	LEFT JOIN #temp32 AS T33 WITH (NOLOCK)
	ON T33.source_code = T.source_code
	LEFT JOIN #temp33 AS T34 WITH (NOLOCK)
	ON T34.source_code = T.source_code
	LEFT JOIN #temp34 AS T35 WITH (NOLOCK)
	ON T35.source_code = T.source_code
	LEFT JOIN #temp35 AS T36 WITH (NOLOCK)
	ON T36.source_code = T.source_code
	LEFT JOIN #temp36 AS T37 WITH (NOLOCK)
	ON T37.source_code = T.source_code
	LEFT JOIN #temp37 AS T38 WITH (NOLOCK)
	ON T38.source_code = T.source_code
	LEFT JOIN #temp38 AS T39 WITH (NOLOCK)
	ON T39.source_code = T.source_code
	LEFT JOIN #temp39 AS T40 WITH (NOLOCK)
	ON T40.source_code = T.source_code
	LEFT JOIN #temp40 AS T41 WITH (NOLOCK)
	ON T41.source_code = T.source_code
	LEFT JOIN #temp41 AS T42 WITH (NOLOCK)
	ON T42.source_code = T.source_code
	LEFT JOIN #temp42 AS T43 WITH (NOLOCK)
	ON T43.source_code = T.source_code
	LEFT JOIN #temp43 AS T44 WITH (NOLOCK)
	ON T44.source_code = T.source_code
	LEFT JOIN #temp44 AS T45 WITH (NOLOCK)
	ON T45.source_code = T.source_code
	LEFT JOIN #temp45 AS T46 WITH (NOLOCK)
	ON T46.source_code = T.source_code
	LEFT JOIN #temp46 AS T47 WITH (NOLOCK)
	ON T47.source_code = T.source_code
	LEFT JOIN #temp47 AS T48 WITH (NOLOCK)
	ON T48.source_code = T.source_code
	LEFT JOIN #temp48 AS T49 WITH (NOLOCK)
	ON T49.source_code = T.source_code
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
	LEFT JOIN #temp85 AS T86 WITH (NOLOCK)
	ON T86.source_code = T.source_code
	LEFT JOIN #temp86 AS T87 WITH (NOLOCK)
	ON T87.source_code = T.source_code
	LEFT JOIN #temp87 AS T88 WITH (NOLOCK)
	ON T88.source_code = T.source_code
	LEFT JOIN #temp88 AS T89 WITH (NOLOCK)
	ON T89.source_code = T.source_code
	LEFT JOIN #temp89 AS T90 WITH (NOLOCK)
	ON T90.source_code = T.source_code
	LEFT JOIN #temp90 AS T91 WITH (NOLOCK)
	ON T91.source_code = T.source_code
	LEFT JOIN #temp91 AS T92 WITH (NOLOCK)
	ON T92.source_code = T.source_code
	LEFT JOIN #temp92 AS T93 WITH (NOLOCK)
	ON T93.source_code = T.source_code
	LEFT JOIN #temp93 AS T94 WITH (NOLOCK)
	ON T94.source_code = T.source_code
	LEFT JOIN #temp94 AS T95 WITH (NOLOCK)
	ON T95.source_code = T.source_code
	LEFT JOIN #temp95 AS T96 WITH (NOLOCK)
	ON T96.source_code = T.source_code
	LEFT JOIN #temp96 AS T97 WITH (NOLOCK)
	ON T97.source_code = T.source_code
WHERE T.source_media = 'D' OR T.source_media = 'DD' OR T.source_media = 'DM' OR T.source_media = 'B' OR T.source_media = 'G' OR T.source_media = 'Z'