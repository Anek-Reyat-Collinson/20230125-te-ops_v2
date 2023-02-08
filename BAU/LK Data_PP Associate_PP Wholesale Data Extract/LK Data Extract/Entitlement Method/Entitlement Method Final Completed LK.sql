SELECT DISTINCT sdc.source_code,
s.source_desc,
s.owner_product,
cm.consumer_model_name,
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
	INTO #TEMP
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
		left join dbo.consumer_model as cm
			on cm.consumer_model_id = sdc.consumer_model_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE();

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Member and the visit count is from 0 to 9999 

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP1
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Member' and visit_count_from = 0 and visit_count_to = 9999 and subscription_level_desc = 'Standard'  and first_year_only = 1;

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Member and the visit count is equal to 0 is not equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP2
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Member' and visit_count_from = 0 and visit_count_to <> 9999 and subscription_level_desc = 'Standard'  and sva.first_year_only = 1;

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Member and the visit count is not equal to 0 and is equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP3
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Member' and visit_count_from <> 0 and visit_count_to = 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 1

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Member and the visit count is not equal to 0 is not equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP4
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Member' and visit_count_from <> 0 and visit_count_to <> 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 1

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Guest and the visit count is from 0 to 9999 

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP5
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Guest' and visit_count_from = 0 and visit_count_to = 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 1

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Guest and the visit count is equal to 0 is not equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP6
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Guest' and visit_count_from = 0 and visit_count_to <> 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 1

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Guest and the visit count is not equal to 0 and is equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP7
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Guest' and visit_count_from <> 0 and visit_count_to = 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 1

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Guest and the visit count is not equal to 0 and is not equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP8
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Guest' and visit_count_from <> 0 and visit_count_to <> 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 1

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Member/Guest and the visit count is from 0 to 9999 

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP9
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Member/Guest' and visit_count_from = 0 and visit_count_to = 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 1

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Guest and the visit count is equal to 0 and is not equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP10
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Member/Guest' and visit_count_from = 0 and visit_count_to <> 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 1

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Member/Guest and the visit count is not equal to 0 and is equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP11
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Member/Guest' and visit_count_from <> 0 and visit_count_to = 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 1

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Member/Guest and the visit count is not equal to 0 and is not equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP12
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Member/Guest' and visit_count_from <> 0 and visit_count_to <> 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 1

-- First Year Only is 1

--Where subscription level is standard, visitor type description is Offer Member/Guest and the visit count is from 0 to 9999 

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP13
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Offer Member/Guest' and visit_count_from = 0 and visit_count_to = 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 1

-- First Year Only is 0

--Where subscription level is standard, visitor type description is Member and the visit count is from 0 to 9999 

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP53
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Member' and visit_count_from = 0 and visit_count_to = 9999 and subscription_level_desc = 'Standard'  and sva.first_year_only = 0;

-- First Year Only is 0

--Where subscription level is standard, visitor type description is Member and the visit count is equal to 0 is not equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP54
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Member' and visit_count_from = 0 and visit_count_to <> 9999 and subscription_level_desc = 'Standard'  and sva.first_year_only = 0;

-- First Year Only is 0

--Where subscription level is standard, visitor type description is Member and the visit count is not equal to 0 is equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP55
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Member' and visit_count_from <> 0 and visit_count_to = 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 0

-- First Year Only is 0

--Where subscription level is standard, visitor type description is Member and the visit count is not equal to 0 and is not equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP56
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Member' and visit_count_from <> 0 and visit_count_to <> 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 0

-- First Year Only is 0

--Where subscription level is standard, visitor type description is Guest and the visit count is from 0 to 9999 

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP57
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Guest' and visit_count_from = 0 and visit_count_to = 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 0

-- First Year Only is 0

--Where subscription level is standard, visitor type description is Guest and the visit count is equal to 0 and is not equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP58
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Guest' and visit_count_from = 0 and visit_count_to <> 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 0

-- First Year Only is 0

--Where subscription level is standard, visitor type description is Guest and the visit count is not equal to 0 and is equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP59
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Guest' and visit_count_from <> 0 and visit_count_to = 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 0

-- First Year Only is 0

--Where subscription level is standard, visitor type description is Guest and the visit count is not equal to 0 and is not equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP60
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Guest' and visit_count_from <> 0 and visit_count_to <> 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 0

-- First Year Only is 0

--Where subscription level is standard, visitor type description is Member/Guest and the visit count is from 0 to 9999 

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
INTO #temp61
FROM source AS s
	INNER JOIN source_deal_config AS sdc
		ON sdc.source_code = s.source_code
	INNER join source_visit_allocation_set as vas
		ON vas.source_deal_config_id = sdc.source_deal_config_id
	INNER join source_visit_allocation_grp g
       ON vas.source_visit_allocation_set_id = g.source_visit_allocation_set_id
    INNER JOIN source_visit_allocation sva WITH (NOLOCK)
        ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
    INNER JOIN visit_fee_type AS vft WITH (NOLOCK)
        ON vft.visit_fee_type_id = sva.visit_fee_type_id
    INNER JOIN visitor_type AS vt WITH (NOLOCK)
        ON vt.visitor_type_id = sva.visitor_type_id
    inner join dbo.charge_owner co WITH (NOLOCK)
        ON co.charge_owner_id = sva.charge_owner_id
    INNER JOIN visit_validity_type vvt WITH (NOLOCK)
        ON vvt.visit_validity_type_id = sva.visit_validity_type_id
	INNER JOIN source_visit_allocation_set AS SVAS
		ON SVAS.source_deal_config_id = SDC.source_deal_config_id
    INNER JOIN subscription_level sl
        ON sl.subscription_level_id = SVAS.subscription_level_id
WHERE sva.visit_allocation_type_id != 3 and sva.visit_allocation_type_id != 4  and s.owner_product = 'LK' and visitor_type_desc = 'Member/Guest' and visit_count_from = 0 and visit_count_to = 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 0 and vas.isdeleted = 0

-- First Year Only is 0

--Where subscription level is standard, visitor type description is Member/Guest and the visit count is equal to 0 and is not equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP62
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Member/Guest' and visit_count_from = 0 and visit_count_to <> 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 0

-- First Year Only is 0

--Where subscription level is standard, visitor type description is Member/Guest and the visit count is not equal to 0 and is equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP63
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Member/Guest' and visit_count_from <> 0 and visit_count_to = 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 0

-- First Year Only is 0

--Where subscription level is standard, visitor type description is Member/Guest and the visit count is not equal to 0 and is not equal to 9999

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP64
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Member/Guest' and visit_count_from <> 0 and visit_count_to <> 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 0

-- First Year Only is 0

--Where subscription level is standard, visitor type description is Offer Member/Guest and the visit count is from 0 to 9999 

SELECT DISTINCT sdc.source_code,
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
vft.visit_fee_type_desc
	INTO #TEMP65
    FROM source_visit_allocation_set visit_set
        INNER JOIN source_visit_allocation_grp g
            ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
        INNER JOIN subscription_level sl
            ON sl.subscription_level_id = visit_set.subscription_level_id
        INNER JOIN
        (
            SELECT MAX(source_visit_allocation_grp_id) AS max_id,
                   sl.subscription_level_id,
                   sdc.source_code
            FROM source_visit_allocation_set visit_set WITH (NOLOCK)
                inner JOIN source_visit_allocation_grp g WITH (NOLOCK)
                    ON visit_set.source_visit_allocation_set_id = g.source_visit_allocation_set_id
                INNER JOIN source_deal_config sdc WITH (NOLOCK)
                    ON visit_set.source_deal_config_id = sdc.source_deal_config_id
                INNER JOIN subscription_level sl
                    ON sl.subscription_level_id = visit_set.subscription_level_id
				INNER JOIN dbo.source as S
					ON s.source_code = sdc.source_code
           WHERE s.owner_product = 'LK' --and sdc.source_code IN ( 'DXPCCSB3BARP' ) AND visit_set.isdeleted=1
            GROUP BY sdc.source_code,
                     sl.subscription_level_id
        ) AS sub
            ON sub.max_id = g.source_visit_allocation_grp_id
        LEFT JOIN dbo.source s WITH (NOLOCK)
            ON s.source_code = sub.source_code
        LEFT JOIN dbo.source_deal_config sdc WITH (NOLOCK)
            ON sdc.source_code = s.source_code
        LEFT JOIN source_visit_allocation sva WITH (NOLOCK)
            ON sva.source_visit_allocation_grp_id = g.source_visit_allocation_grp_id
        LEFT JOIN source_visit_allocation_price_lk sva_plk WITH (NOLOCK)
            ON sva_plk.source_visit_allocation_id = sva.source_visit_allocation_id
        LEFT JOIN visit_fee_type AS vft WITH (NOLOCK)
            ON vft.visit_fee_type_id = sva.visit_fee_type_id
        LEFT JOIN visitor_type AS vt WITH (NOLOCK)
            ON vt.visitor_type_id = sva.visitor_type_id
        LEFT JOIN dbo.charge_owner co WITH (NOLOCK)
            ON co.charge_owner_id = sva.charge_owner_id
        LEFT JOIN visit_validity_type vvt WITH (NOLOCK)
            ON vvt.visit_validity_type_id = sva.visit_validity_type_id
        LEFT JOIN visit_allocation_type vat WITH (NOLOCK)
            ON vat.visit_allocation_type_id = sva.visit_allocation_type_id
        LEFT JOIN visit_price_grp vpg WITH (NOLOCK)
            ON vpg.visit_price_grp_id = sva_plk.visit_price_grp_id
        LEFT JOIN dbo.visit_price_line vpl WITH (NOLOCK)
            ON vpl.visit_price_grp_id = vpg.visit_price_grp_id
               AND vpl.valid_to > GETDATE()
		WHERE visitor_type_desc = 'Offer Member/Guest' and visit_count_from = 0 and visit_count_to = 9999 and subscription_level_desc = 'Standard' and SVA.first_year_only = 0

-- Now when we have isolated all the separate areas of interest in the entitlement we have to concatenate them all together

SELECT
T.source_code,
t.source_desc,
t.consumer_model_name,
T.owner_product,
CONCAT(COALESCE(T2.visitor_type_desc,'50'),', ',COALESCE(T2.visit_count_from,'50'),', ',COALESCE(T2.visit_count_to,'50'),', ', COALESCE(T2.visit_validity_type_desc,'50'),', ',COALESCE(T2.charge_owner_desc,'50'),', ',COALESCE(T2.visit_fee_type_desc,'50'),'| ',
COALESCE(T3.visitor_type_desc,'50'),', ',COALESCE(T3.visit_count_from,'50'),', ',COALESCE(T3.visit_count_to,'50'),', ', COALESCE(T3.visit_validity_type_desc,'50'),', ',COALESCE(T3.charge_owner_desc,'50'),', ',COALESCE(T3.visit_fee_type_desc,'50'),'| ',
COALESCE(T5.visitor_type_desc,'50'),', ',COALESCE(T5.visit_count_from,'50'),', ',COALESCE(T5.visit_count_to,'50'),', ', COALESCE(T5.visit_validity_type_desc,'50'),', ',COALESCE(T5.charge_owner_desc,'50'),', ',COALESCE(T5.visit_fee_type_desc,'50'),'| ',
COALESCE(T4.visitor_type_desc,'50'),', ',COALESCE(T4.visit_count_from,'50'),', ',COALESCE(T4.visit_count_to,'50'),', ', COALESCE(T4.visit_validity_type_desc,'50'),', ',COALESCE(T4.charge_owner_desc,'50'),', ',COALESCE(T4.visit_fee_type_desc,'50'),'| ',
COALESCE(T6.visitor_type_desc,'50'),', ',COALESCE(T6.visit_count_from,'50'),', ',COALESCE(T6.visit_count_to,'50'),', ', COALESCE(T6.visit_validity_type_desc,'50'),', ',COALESCE(T6.charge_owner_desc,'50'),', ',COALESCE(T6.visit_fee_type_desc,'50'),'| ',
COALESCE(T7.visitor_type_desc,'50'),', ',COALESCE(T7.visit_count_from,'50'),', ',COALESCE(T7.visit_count_to,'50'),', ', COALESCE(T7.visit_validity_type_desc,'50'),', ',COALESCE(T7.charge_owner_desc,'50'),', ',COALESCE(T7.visit_fee_type_desc,'50'),'| ',
COALESCE(T9.visitor_type_desc,'50'),', ',COALESCE(T9.visit_count_from,'50'),', ',COALESCE(T9.visit_count_to,'50'),', ', COALESCE(T9.visit_validity_type_desc,'50'),', ',COALESCE(T9.charge_owner_desc,'50'),', ',COALESCE(T9.visit_fee_type_desc,'50'),'| ',
COALESCE(T8.visitor_type_desc,'50'),', ',COALESCE(T8.visit_count_from,'50'),', ',COALESCE(T8.visit_count_to,'50'),', ', COALESCE(T8.visit_validity_type_desc,'50'),', ',COALESCE(T8.charge_owner_desc,'50'),', ',COALESCE(T8.visit_fee_type_desc,'50'),'| ',
COALESCE(T10.visitor_type_desc,'50'),', ',COALESCE(T10.visit_count_from,'50'),', ',COALESCE(T10.visit_count_to,'50'),', ', COALESCE(T10.visit_validity_type_desc,'50'),', ',COALESCE(T10.charge_owner_desc,'50'),', ',COALESCE(T10.visit_fee_type_desc,'50'),'| ',
COALESCE(T11.visitor_type_desc,'50'),', ',COALESCE(T11.visit_count_from,'50'),', ',COALESCE(T11.visit_count_to,'50'),', ', COALESCE(T11.visit_validity_type_desc,'50'),', ',COALESCE(T11.charge_owner_desc,'50'),', ',COALESCE(T11.visit_fee_type_desc,'50'),'| ',
COALESCE(T13.visitor_type_desc,'50'),', ',COALESCE(T13.visit_count_from,'50'),', ',COALESCE(T13.visit_count_to,'50'),', ', COALESCE(T13.visit_validity_type_desc,'50'),', ',COALESCE(T13.charge_owner_desc,'50'),', ',COALESCE(T13.visit_fee_type_desc,'50'),'| ',
COALESCE(T12.visitor_type_desc,'50'),', ',COALESCE(T12.visit_count_from,'50'),', ',COALESCE(T12.visit_count_to,'50'),', ', COALESCE(T12.visit_validity_type_desc,'50'),', ',COALESCE(T12.charge_owner_desc,'50'),', ',COALESCE(T12.visit_fee_type_desc,'50'),'| ',
COALESCE(T14.visitor_type_desc,'50'),', ',COALESCE(T14.visit_count_from,'50'),', ',COALESCE(T14.visit_count_to,'50'),', ', COALESCE(T14.visit_validity_type_desc,'50'),', ',COALESCE(T14.charge_owner_desc,'50'),', ',COALESCE(T14.visit_fee_type_desc,'50')) AS 'First Year Entitlement Method Standard',
CONCAT(COALESCE(T54.visitor_type_desc,'50'),', ',COALESCE(T54.visit_count_from,'50'),', ',COALESCE(T54.visit_count_to,'50'),', ', COALESCE(T54.visit_validity_type_desc,'50'),', ',COALESCE(T54.charge_owner_desc,'50'),', ',COALESCE(T54.visit_fee_type_desc,'50'),'| ',
COALESCE(T55.visitor_type_desc,'50'),', ',COALESCE(T55.visit_count_from,'50'),', ',COALESCE(T55.visit_count_to,'50'),', ', COALESCE(T55.visit_validity_type_desc,'50'),', ',COALESCE(T55.charge_owner_desc,'50'),', ',COALESCE(T55.visit_fee_type_desc,'50'),'| ',
COALESCE(T57.visitor_type_desc,'50'),', ',COALESCE(T57.visit_count_from,'50'),', ',COALESCE(T57.visit_count_to,'50'),', ', COALESCE(T57.visit_validity_type_desc,'50'),', ',COALESCE(T57.charge_owner_desc,'50'),', ',COALESCE(T57.visit_fee_type_desc,'50'),'| ',
COALESCE(T56.visitor_type_desc,'50'),', ',COALESCE(T56.visit_count_from,'50'),', ',COALESCE(T56.visit_count_to,'50'),', ', COALESCE(T56.visit_validity_type_desc,'50'),', ',COALESCE(T56.charge_owner_desc,'50'),', ',COALESCE(T56.visit_fee_type_desc,'50'),'| ',
COALESCE(T58.visitor_type_desc,'50'),', ',COALESCE(T58.visit_count_from,'50'),', ',COALESCE(T58.visit_count_to,'50'),', ', COALESCE(T58.visit_validity_type_desc,'50'),', ',COALESCE(T58.charge_owner_desc,'50'),', ',COALESCE(T58.visit_fee_type_desc,'50'),'| ',
COALESCE(T59.visitor_type_desc,'50'),', ',COALESCE(T59.visit_count_from,'50'),', ',COALESCE(T59.visit_count_to,'50'),', ', COALESCE(T59.visit_validity_type_desc,'50'),', ',COALESCE(T59.charge_owner_desc,'50'),', ',COALESCE(T59.visit_fee_type_desc,'50'),'| ',
COALESCE(T61.visitor_type_desc,'50'),', ',COALESCE(T61.visit_count_from,'50'),', ',COALESCE(T61.visit_count_to,'50'),', ', COALESCE(T61.visit_validity_type_desc,'50'),', ',COALESCE(T61.charge_owner_desc,'50'),', ',COALESCE(T61.visit_fee_type_desc,'50'),'| ',
COALESCE(T60.visitor_type_desc,'50'),', ',COALESCE(T60.visit_count_from,'50'),', ',COALESCE(T60.visit_count_to,'50'),', ', COALESCE(T60.visit_validity_type_desc,'50'),', ',COALESCE(T60.charge_owner_desc,'50'),', ',COALESCE(T60.visit_fee_type_desc,'50'),'| ',
COALESCE(T62.visitor_type_desc,'50'),', ',COALESCE(T62.visit_count_from,'50'),', ',COALESCE(T62.visit_count_to,'50'),', ', COALESCE(T62.visit_validity_type_desc,'50'),', ',COALESCE(T62.charge_owner_desc,'50'),', ',COALESCE(T62.visit_fee_type_desc,'50'),'| ',
COALESCE(T63.visitor_type_desc,'50'),', ',COALESCE(T63.visit_count_from,'50'),', ',COALESCE(T63.visit_count_to,'50'),', ', COALESCE(T63.visit_validity_type_desc,'50'),', ',COALESCE(T63.charge_owner_desc,'50'),', ',COALESCE(T63.visit_fee_type_desc,'50'),'| ',
COALESCE(T65.visitor_type_desc,'50'),', ',COALESCE(T65.visit_count_from,'50'),', ',COALESCE(T65.visit_count_to,'50'),', ', COALESCE(T65.visit_validity_type_desc,'50'),', ',COALESCE(T65.charge_owner_desc,'50'),', ',COALESCE(T65.visit_fee_type_desc,'50'),'| ',
COALESCE(T64.visitor_type_desc,'50'),', ',COALESCE(T64.visit_count_from,'50'),', ',COALESCE(T64.visit_count_to,'50'),', ', COALESCE(T64.visit_validity_type_desc,'50'),', ',COALESCE(T64.charge_owner_desc,'50'),', ',COALESCE(T64.visit_fee_type_desc,'50'),'| ',
COALESCE(T66.visitor_type_desc,'50'),', ',COALESCE(T66.visit_count_from,'50'),', ',COALESCE(T66.visit_count_to,'50'),', ', COALESCE(T66.visit_validity_type_desc,'50'),', ',COALESCE(T66.charge_owner_desc,'50'),', ',COALESCE(T66.visit_fee_type_desc,'50')) AS 'Entitlement Method Standard'
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
	WHERE t.source_desc not like '%demo%' and t.source_desc not like '%temp%' and t.source_desc not like '%Do No%' and t.source_desc not like '%test%' and t.source_desc not like '%error%' and t.source_desc not like '%use%'