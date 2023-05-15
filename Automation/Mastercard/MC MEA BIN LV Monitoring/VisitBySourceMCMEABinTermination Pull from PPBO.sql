
DECLARE @var_startDate VARCHAR(10)
DECLARE @var_endDate VARCHAR(10)

SET @var_startDate= cast(cast(dateadd(dd,-1,getdate()) as date) as varchar(10))
SET @var_endDate= cast(cast(getdate() as date) as varchar(10))


IF OBJECT_ID('tempdb..#sourcecodelist') IS NOT NULL
	DROP TABLE #sourcecodelist

Create table #sourcecodelist(sourcecode varchar(50))
Insert into #sourcecodelist
select 'LKMCCCENMBTZ19'
UNION ALL SELECT 'LKMCCITIWEPRE15'
UNION ALL SELECT 'LKMCCITIWPLUS15'
UNION ALL SELECT 'LKMCCPLTMEL18'
UNION ALL SELECT 'LKMCCPTUML0FV18'
UNION ALL SELECT 'LKMCCTIMEL22'
UNION ALL SELECT 'LKMCMASHCORP15'
UNION ALL SELECT 'LKMCMASHPT15'
UNION ALL SELECT 'LKMCMEAWAP15'
UNION ALL SELECT 'LKMCMEAWEAP15'
UNION ALL SELECT 'LKMCNBAD2015'
UNION ALL SELECT 'LKMCNBOPLTOM17'
UNION ALL SELECT 'LKMCOCECIMMU19'
UNION ALL SELECT 'LKMCOCERAKAE19'
UNION ALL SELECT 'LKMCOCOIMBRW20'
UNION ALL SELECT 'LKMCOGLDSCBKE19'
UNION ALL SELECT 'LKMCOGOECOGH17'
UNION ALL SELECT 'LKMCONBPLTPS18'
UNION ALL SELECT 'LKMCOPLBOGNG20'
UNION ALL SELECT 'LKMCOPLDTBKE19'
UNION ALL SELECT 'LKMCOPLECOGH19'
UNION ALL SELECT 'LKMCOPLFABAE19'
UNION ALL SELECT 'LKMCOPLIMBRW19'
UNION ALL SELECT 'LKMCOPLTSWASZ17'
UNION ALL SELECT 'LKMCOPLUBNNG20'
UNION ALL SELECT 'LKMCOPTADCB16'
UNION ALL SELECT 'LKMCOPTMASHAE17'
UNION ALL SELECT 'LKMCOPTNIZOM18'
UNION ALL SELECT 'LKMCOPTPROVNG17'
UNION ALL SELECT 'LKMCOPTSAMBA16'
UNION ALL SELECT 'LKMCOPTUBAAF18'
UNION ALL SELECT 'LKMCOPTZENGH18'
UNION ALL SELECT 'LKMCOTIAFMU19'
UNION ALL SELECT 'LKMCOWAAMU19'
UNION ALL SELECT 'LKMCOWCITIUAE16'
UNION ALL SELECT 'LKMCOWNMBTZ19'
UNION ALL SELECT 'LKMCOWRDTBKE18'
UNION ALL SELECT 'LKMCRAK2015'
UNION ALL SELECT 'LKMCRAKELITE16'
UNION ALL SELECT 'LKMCUBAGLDNG17'
UNION ALL SELECT 'LKMCWRMEA2014'
UNION ALL SELECT 'LKMCZENGONG18'
UNION ALL SELECT 'LKMCZENPTNG18'




IF OBJECT_ID('tempdb..##temptable') IS NOT NULL
	DROP TABLE ##temptable

CREATE TABLE ##temptable (
		source_code 		varchar(20),
		consumer_no 		INT NOT NULL,
		external_identifier BIGINT NULL,
		membership_no 		BIGINT NULL,
		purchase_no 		INT NOT NULL,
		track_seq 			INT NOT NULL,
		title 				varchar(20),
		forename 			varchar(50),
		surname 			varchar(50),
		fullname 			varchar(120),
		source_desc 		varchar(255),
		product_version 	varchar(20),
		paid_to_date 		date,
		subs_issue_date 	date,
		subs_status 		varchar(5),
		track_start 		datetime,
		track_guests 		INT,
		track_from 			varchar(20),
		track_value 		FLOAT,
		creation_date 		date,
		lounge_name			varchar(100),
		airport 			varchar(100),
		trans_ccard_number 	varchar(100),
		external_ref 		varchar(100),
		track_batch 		INT,
		old_system_ref 		varchar(100),
		campaign_code 		varchar(100),
		lounge_code			varchar(20),
		city 				varchar(100),
		country 				varchar(100),
		vendor_tracking_code 	varchar(100),
		user_invitation_code 	varchar(100),
		remaining_mem_cli_count int,
		remaining_mem_cli2_count int,
		remaining_mem_pp_count 	int,
		remaining_gue_cli_count int,
		remaining_gue_cli2_count int,
		remaining_gue_pp_count 	int,
		remaining_mgu_cli_count int,
		remaining_mgu_cli2_count int,
		remaining_mgu_pp_count 	int,
		remaining_mgu_comp_count int,
		
		experience_category 	varchar(100),
		experience_type 		varchar(100),
		airport_terminal_name  varchar(100),
		airport_terminal_type  varchar(100),
		visit_type_id SMALLINT,
		visit_type	INT,
		ccard_type VARCHAR(100),
		effective_date DATETIME2,
		report_month date

);


INSERT INTO ##temptable(	
	source_code,
	consumer_no,
	external_identifier,
	membership_no,
	purchase_no,
	track_seq,
	title,
	forename,
	surname,
	fullname,
	source_desc,
	product_version,
	paid_to_date,
	subs_issue_date,
	subs_status,
	track_start,
	track_guests,
	track_from,
	track_value,
	creation_date,
	lounge_name,
	airport,
	trans_ccard_number,
	external_ref,
	track_batch,
	old_system_ref,
	campaign_code,
	lounge_code,
	city,
	country,
	vendor_tracking_code,
	user_invitation_code,
	remaining_mem_cli_count,
	remaining_mem_cli2_count,
	remaining_mem_pp_count,
	remaining_gue_cli_count,
	remaining_gue_cli2_count,
	remaining_gue_pp_count,
	remaining_mgu_cli_count,
	remaining_mgu_cli2_count,
	remaining_mgu_pp_count,
	remaining_mgu_comp_count,
	
	experience_category,
	experience_type,
	airport_terminal_name,
	airport_terminal_type,
	visit_type_id,
	ccard_type, 
	effective_date,
	report_month

	 )
SELECT	s.source_code,
		c.consumer_no,
		c.external_identifier,
		c.membership_no,
		p.purchase_no,
		t.track_seq,
		c.title,
		c.forename,
		c.surname,
		LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(c.forename + ' ' + c.surname,' ',' |'),'| ',''),'|',''))) AS fullname,
		s.source_desc,
		p.product_version,
		p.paid_to_date,
		p.subs_issue_date,
		p.subs_status,
		t.track_start_full,
		t.track_guests,
		t.track_from,
		t.track_value,
		t.creation_date,
		l.lounge_name,
		a.pp_short_name AS airport,
		p.trans_ccard_number,
		t.external_ref,
		t.track_batch,
		p.old_system_ref,
		s.campaign_code,
		l.lounge_code,
		a.airport_city AS city,
		cou.code_desc AS country,
		siv.vendor_tracking_code,
		siv.user_invitation_code,
		0 AS remaining_mem_cli_count,
		0 AS remaining_mem_cli2_count,
 		0 AS remaining_mem_pp_count,
 		0 AS remaining_gue_cli_count,
 		0 AS remaining_gue_cli2_count,
 		0 AS remaining_gue_pp_count,
 		0 AS remaining_mgu_cli_count,
 		0 AS remaining_mgu_cli2_count,
 		0 AS remaining_mgu_pp_count,
 		0 AS remaining_mgu_comp_count,
 		
		'Lounge' as experience_category,
		'Lounge' as experience_type,
		ate.terminal_name as airport_terminal_name,
		CASE
			WHEN l.lounge_type = 'I' THEN 'I'
			WHEN l.lounge_type = 'D' THEN 'D'
			ELSE 'U'
		  END	as airport_terminal_type,
		t.visit_type_id,
		p.ccard_type,
		p.effective_date,
		CAST(DATEADD(MONTH, DATEDIFF(MONTH, 0, t.[creation_date]), 0) AS DATE)      AS 	report_month

--INTO ##temptable
FROM
		PPass.dbo.source_deal_config AS sdc WITH (NOLOCK)
		INNER JOIN PPass.dbo.source AS s WITH (NOLOCK) ON sdc.source_code = s.source_code
		INNER JOIN PPass.dbo.source_subscription AS ss WITH (NOLOCK) ON sdc.source_deal_config_id = ss.source_deal_config_id
		INNER JOIN PPass.dbo.purchase_subscription_link AS psl WITH (NOLOCK) ON ss.source_subscription_id = psl.source_subscription_id
		INNER JOIN PPass.dbo.purchase AS p WITH (NOLOCK) ON psl.purchase_no = p.purchase_no
		INNER JOIN PPass.dbo.consumer AS c WITH (NOLOCK) ON p.consumer_no = c.consumer_no
		INNER JOIN PPass.dbo.tracking AS t WITH (NOLOCK) ON p.purchase_no = t.purchase_no
		INNER JOIN PPass.dbo.lounge AS l WITH (NOLOCK) ON l.lounge_code = t.track_from
		INNER JOIN PPass.dbo.airport AS a WITH (NOLOCK) ON a.iso_airport_code = l.airport
		LEFT OUTER JOIN PPass.dbo.airport_terminal AS ate WITH (NOLOCK) ON l.airport_terminal_id = ate.airport_terminal_id
		LEFT OUTER JOIN PPass.dbo.code AS COU  WITH (NOLOCK) ON COU.code = l.country_code AND COU.codetype = 'CTRY'
		
		LEFT OUTER JOIN PPass.dbo.source_invitation_validation siv WITH (NOLOCK) ON siv.consumer_no = c.consumer_no
	WHERE
t.creation_date >= @var_startDate AND t.creation_date < DATEADD(d,1,@var_endDate)
 AND t.track_status <> 'NA' 
AND p.isDeleted = 0 
AND s.source_code in ( SELECT DISTINCT sourcecode from #sourcecodelist )
--AND (p.consumer_no='1427229223' or c.membership_no='1427229223')
/* Load in the reedemed offers data */

INSERT INTO ##temptable (	
	source_code,
	consumer_no,
	external_identifier,
	membership_no,
	purchase_no,
	track_seq,
	title,
	forename,
	surname,
	fullname,
	source_desc,
	product_version,
	paid_to_date,
	subs_issue_date,
	subs_status,
	track_start,
	track_guests,
	track_from,
	track_value,
	creation_date,
	lounge_name,
	airport,
	trans_ccard_number,
	external_ref,
	track_batch,
	old_system_ref,
	campaign_code,
	lounge_code,
	city,
	country,
	vendor_tracking_code,
	user_invitation_code,
	remaining_mem_cli_count,
	remaining_mem_cli2_count,
	remaining_mem_pp_count,
	remaining_gue_cli_count,
	remaining_gue_cli2_count,
	remaining_gue_pp_count,
	remaining_mgu_cli_count,
	remaining_mgu_cli2_count,
	remaining_mgu_pp_count,
	remaining_mgu_comp_count,
	experience_category,
	experience_type,
	airport_terminal_name,
	airport_terminal_type,
	visit_type_id,
	report_month

	 )
SELECT
	s.source_code,
	c.consumer_no,
	c.external_identifier,
	c.membership_no,
	p.purchase_no,
	t.track_seq,
	c.title,
	c.forename,
	c.surname,
	LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(c.forename + ' ' + c.surname,' ',' |'),'| ',''),'|',''))) AS fullname,
	s.source_desc,
	p.product_version,
	p.paid_to_date,
	p.subs_issue_date,
	p.subs_status,
	t.track_start_full,
	t.track_guests,
	t.track_from,
	t.track_value,
	t.creation_date,
	ord.outlet_name as lounge_name,
	a.pp_short_name AS airport,
	p.trans_ccard_number,
	t.external_ref,
	t.track_batch,
	p.old_system_ref,
	s.campaign_code,
	t.track_from as lounge_code,
	a.airport_city AS city,
	cou.code_desc AS country,
	siv.vendor_tracking_code,
	siv.user_invitation_code,
	0 AS remaining_mem_cli_count , 
	0 AS remaining_mem_cli2_count , 
	0 AS remaining_mem_pp_count , 
	0 AS remaining_gue_cli_count , 
	0 AS remaining_gue_cli2_count , 
	0 AS remaining_gue_pp_count , 
	0 AS remaining_mgu_cli_count , 
	0 AS remaining_mgu_cli2_count , 
	0 AS remaining_mgu_pp_count , 
	0 AS remaining_mgu_comp_count,
	
	ord.offer_category as experience_category,
		ord.offer_type as experience_type,
	ISNULL(ate.terminal_name, 'Unknown' ) as airport_terminal_name,
	'U' as airport_terminal_type,
	t.visit_type_id,
	CAST(DATEADD(MONTH, DATEDIFF(MONTH, 0, t.[creation_date]), 0) AS DATE)      AS 	report_month
FROM
	PPass.dbo.source_deal_config AS sdc WITH (NOLOCK)
	INNER JOIN PPass.dbo.source AS s WITH (NOLOCK) ON sdc.source_code = s.source_code
	INNER JOIN PPass.dbo.source_subscription AS ss WITH (NOLOCK) ON sdc.source_deal_config_id = ss.source_deal_config_id
	INNER JOIN PPass.dbo.purchase_subscription_link AS psl WITH (NOLOCK) ON ss.source_subscription_id = psl.source_subscription_id
	INNER JOIN PPass.dbo.purchase AS p WITH (NOLOCK) ON psl.purchase_no = p.purchase_no
	INNER JOIN PPass.dbo.consumer AS c WITH (NOLOCK) ON p.consumer_no = c.consumer_no
	INNER JOIN PPass.dbo.tracking AS t WITH (NOLOCK) ON p.purchase_no = t.purchase_no
	INNER JOIN PPass.dbo.offer_redemption_details AS ord WITH (NOLOCK) ON ord.consumer_no = c.consumer_no AND ord.track_seq = t.track_seq
	INNER JOIN PPass.dbo.airport AS a WITH (NOLOCK) ON a.iso_airport_code = ord.airport_iso_code
	LEFT JOIN PPass.dbo.outlet_airport_terminal AS oat WITH (NOLOCK) ON ord.outlet_id = oat.outlet_id
	LEFT JOIN PPass.dbo.airport_terminal AS ate WITH (NOLOCK) ON oat.airport_terminal_id = ate.airport_terminal_id
	LEFT OUTER JOIN PPass.dbo.code AS COU WITH (NOLOCK) ON cou.alpha_1 = a.iso_country_code
		AND cou.codetype = 'CTRY2'
		AND cou.alpha_5 <> ''
	LEFT OUTER JOIN PPass.dbo.source_invitation_validation siv WITH (NOLOCK) ON siv.consumer_no = c.consumer_no
	
WHERE
t.creation_date >= @var_startDate AND t.creation_date < DATEADD(d,1,@var_endDate)
 AND t.track_status <> 'NA' 
AND p.isDeleted = 0 
AND s.source_code in (SELECT DISTINCT sourcecode from #sourcecodelist)
--AND (p.consumer_no='1427229223' or c.membership_no='1427229223')
/* update the temp table with an index */
--ALTER TABLE ##temptable 
--ADD CONSTRAINT PK_##temptable 
--PRIMARY KEY NONCLUSTERED (purchase_no, track_seq)
--			CREATE NONCLUSTERED INDEX ##temptable_idx1 ON ##temptable (source_code, consumer_no, fullname, track_start, lounge_name, external_ref) 
--			WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]

--Select * from ##temptable

		/*  MEM PPAYVISIT  */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 1
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
           
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva  WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 21
					AND pva.visitor_type_id = 1
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MEM_PP_count = calculated_visit_allocation.visit_number
				
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no;

	/* MEM CPAYVISIT */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 1
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 22
					AND pva.visitor_type_id = 1
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MEM_CLI_count = calculated_visit_allocation.visit_number
			FROM
				##temptable ##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no;

				/* MEM CPAYVISIT2 */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 1
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 25
					AND pva.visitor_type_id = 1
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MEM_CLI2_count = calculated_visit_allocation.visit_number
				
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no

/* GUE PPAYVISIT */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 2
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 21
					AND pva.visitor_type_id = 2
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_GUE_PP_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no

/* GUE CPAYLIST */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 2
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 22
					AND pva.visitor_type_id = 2
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_GUE_CLI_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no

/* GUE CPAYVISIT2 */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 2
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 25
					AND pva.visitor_type_id = 2
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_GUE_CLI2_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no

/*MGU PPAYVISIT */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 3
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 21
					AND pva.visitor_type_id = 3
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MGU_PP_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no
/* MGU CPAYVISIT */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 3
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 22
					AND pva.visitor_type_id = 3
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MGU_CLI_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no

/* MGU CPAYVISIT2 */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 3
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 25
					AND pva.visitor_type_id = 3
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MGU_CLI2_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no

/* SHAREDMEM PPAYVISIT */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 8
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 21
					AND pva.visitor_type_id = 8
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MEM_PP_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no

/* SHAREDMEM CPAYVISIT */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 8
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 22
					AND pva.visitor_type_id = 8
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MEM_CLI_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no
/* SHAREDMEM CPAYVISIT2 */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 8
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 25
					AND pva.visitor_type_id = 8
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MEM_CLI2_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no

/* SHAREDGUE PPAYVISIT */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 9
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 21
					AND pva.visitor_type_id = 9
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_GUE_PP_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no

/* SHAREDGUE CPAYVISIT */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 9
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 22
					AND pva.visitor_type_id = 9
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_GUE_CLI_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no

/* SHAREDGUE CPAYVISIT2 */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 9
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 25
					AND pva.visitor_type_id = 9
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_GUE_CLI2_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no
/* SHAREDMGU PPAYVISIT */

		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 10
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 21
					AND pva.visitor_type_id = 10
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MGU_PP_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no
				/* SHAREDMGU CPAYVISIT */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 10
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 22
					AND pva.visitor_type_id = 10
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MGU_CLI_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no
				/*SHAREDMGU CPAYVISIT2 */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 10
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 25
					AND pva.visitor_type_id = 10
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MGU_CLI2_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no
/*OFFERMEM PPAYVISIT */
;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 6
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 21
					AND pva.visitor_type_id = 6
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MEM_PP_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no
		/* OFFERMEMCPAYLIST */
		;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 6
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 22
					AND pva.visitor_type_id = 6
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MEM_CLI_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no
		/* OFFERMEMCPAYLIST2 */
;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 6
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 25
					AND pva.visitor_type_id = 6
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MEM_CLI2_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no
		/* OFFERGUEPPAYLIST */
;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 5
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 21
					AND pva.visitor_type_id = 5
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_GUE_PP_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no
		/* OFFERGUECPAYLIST */
;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 5
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 22
					AND pva.visitor_type_id = 5
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_GUE_CLI_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no
		/* OFFERGUECPAYLIST2 */
;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 5
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 25
					AND pva.visitor_type_id = 5
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_GUE_CLI2_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no
		/* OFFERMGUPPAYLIST */
;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 7
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 21
					AND pva.visitor_type_id = 7
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MGU_PP_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no
		/* OFFERMGUCPAYLIST */
;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 7
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 22
					AND pva.visitor_type_id = 7
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MGU_CLI_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no
		/* OFFERMGUCPAYLIST2 */
;WITH used_visit_allocations AS (
            	SELECT
					COUNT(1) AS used_visit_count,
					pvah2.purchase_visit_allocation_id
				FROM
					PPass.dbo.purchase_visit_allocation_his AS pvah2 WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation pva2 WITH (NOLOCK) ON pvah2.purchase_visit_allocation_id = pva2.purchase_visit_allocation_id
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval2 WITH (NOLOCK) ON pva2.purchase_visit_allocation_grp_id = pval2.purchase_visit_allocation_grp_id
					LEFT OUTER JOIN PPass.dbo.source_visit_allocation_mem_gue_link salg WITH (NOLOCK) ON pva2.source_visit_allocation_id = salg.guest_source_visit_allocation_id
				WHERE
						EXISTS (
							SELECT
								1
							FROM
								##temptable temp2
							WHERE
								temp2.purchase_no = pval2.purchase_no
						)
					AND pvah2.isdeleted = 0
					AND pva2.visitor_type_id = 7
					AND salg.guest_source_visit_allocation_id is NULL
				GROUP BY
					pvah2.purchase_visit_allocation_id
			),
			derived_visit_allocation AS (
				SELECT
					pva.visit_count_from,
					pva.visit_count_to,
					pva.visit_validity_type_id,
					CASE
						WHEN pva.visit_count_to = 9999
							THEN 9999
						WHEN pva.visit_count_from = 0
							THEN	(pva.visit_count_to - pva.visit_count_from)
						ELSE (pva.visit_count_to - pva.visit_count_from) + 1
					END AS allocated_visit_count,
					ISNULL(used_visit_allocations.used_visit_count, 0) AS used_visit_count,
					pur.purchase_no
				FROM
					PPass.dbo.purchase pur WITH (NOLOCK)
					INNER JOIN PPass.dbo.purchase_visit_allocation_link pval WITH (NOLOCK) ON pval.purchase_no = pur.purchase_no
					INNER JOIN PPass.dbo.purchase_visit_allocation_grp pvag WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
					INNER JOIN PPass.dbo.purchase_visit_allocation pva WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
					AND pva.charge_owner_id = 25
					AND pva.visitor_type_id = 7
					AND pva.visit_allocation_type_id NOT IN (3,4)
					AND pur.isDeleted = 0
					LEFT JOIN used_visit_allocations ON pva.purchase_visit_allocation_id = used_visit_allocations.purchase_visit_allocation_id
               	WHERE
						(
							(	pva.valid_from <= getdate()
								AND pva.valid_to >= getdate()
							)
							OR pva.visit_validity_type_id = 2
						)
			),
			calculated_visit_allocation AS
			(
				SELECT
					CASE WHEN derived_visit_allocation.visit_count_to = 9999 THEN
						9999
					ELSE
						CASE WHEN derived_visit_allocation.visit_validity_type_id = 2 THEN
							CASE
								WHEN derived_visit_allocation.visit_count_to = 9999
									THEN 9999
								WHEN derived_visit_allocation.visit_count_from = 0
									THEN	(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from)
								ELSE
									(derived_visit_allocation.visit_count_to - derived_visit_allocation.visit_count_from) + 1
							END
						ELSE
							(derived_visit_allocation.allocated_visit_count - derived_visit_allocation.used_visit_count)
						END
					END AS visit_number,
					derived_visit_allocation.used_visit_count AS used_visit_number,
					derived_visit_allocation.purchase_no
				FROM derived_visit_allocation
			)

			UPDATE
				##temptable
			SET
				remaining_MGU_CLI2_count = calculated_visit_allocation.visit_number
			FROM
				##temptable
				INNER JOIN calculated_visit_allocation ON ##temptable.purchase_no = calculated_visit_allocation.purchase_no
		;WITH derived_credit_data AS (
			SELECT
				ISNULL(SUM(CASE WHEN vch.purchase_visit_allocation_his_id IS NULL THEN 1 ELSE 0 END),0) AS unused_visit,
				ISNULL(SUM(CASE WHEN vch.purchase_visit_allocation_his_id IS NOT NULL THEN 1 ELSE 0 END),0) AS used_visit,
				pval.purchase_no
			FROM
				PPass.dbo.visit_credit_his AS vch WITH (NOLOCK)
				INNER JOIN PPass.dbo.visit_credit AS vc WITH (NOLOCK) ON vch.visit_credit_id = vc.visit_credit_id
				INNER JOIN PPass.dbo.visit_credit_purchase_allocation AS vcpa WITH (NOLOCK) ON vch.visit_credit_his_id = vcpa.visit_credit_his_id
				INNER JOIN PPass.dbo.purchase_visit_allocation AS pva WITH (NOLOCK) ON vcpa.purchase_visit_allocation_id = pva.purchase_visit_allocation_id
				INNER JOIN PPass.dbo.purchase_visit_allocation_grp AS pvag WITH (NOLOCK) ON pva.purchase_visit_allocation_grp_id = pvag.purchase_visit_allocation_grp_id
				INNER JOIN PPass.dbo.purchase_visit_allocation_link AS pval WITH (NOLOCK) ON pvag.purchase_visit_allocation_grp_id = pval.purchase_visit_allocation_grp_id
			WHERE
				vch.isdeleted = 0
				AND vch.expiry_date >= getdate()
				AND vc.visit_credit_type_id = 1
				AND vc.visitor_type_id = 3
			GROUP BY pval.purchase_no
		)
		UPDATE
			##temptable
		SET
			REMAINING_MGU_COMP_COUNT = derived_credit_data.unused_visit
		FROM
			##temptable
			INNER JOIN derived_credit_data ON ##temptable.purchase_no = derived_credit_data.purchase_no
			