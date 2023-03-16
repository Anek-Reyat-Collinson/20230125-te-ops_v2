
/*
-- -------------------------------------------------------------------
--		Modified date	: 05/11/2018
--		Author			: 
--		Jira Number		: BI-1252
--		Description		: AMEX - Report for Activity Code DACOURIERB
-- -------------------------------------------------------------------
-- Copy the block below for every update to the code

--		Modified date	: 
--		Author			: 
--		Jira Number		: 
--		Description		: 
-------------------------------------------------------------------
-- ==============================================
*/

--HD ran for Sep on Oct 2
--HD ran for Nov on Dec 2
--HD ran for Sep on Oct 2
--HD ran for Oct on Nov 1
--HD ran for Oct on Dec 1
--HD ran for Oct on Jan 2
--HD ran for Oct on Feb 2
--HD ran for Oct on Mar 1

USE PPass;
GO

set transaction isolation level read uncommitted


IF OBJECT_ID('tempdb..#SourceMedia') IS NOT NULL
    DROP TABLE #SourceMedia;

CREATE TABLE #SourceMedia
    (
        [source_media]  VARCHAR(2)
      , [Description]   VARCHAR(100)
      , [business_type] VARCHAR(100)
    );


INSERT INTO #SourceMedia
    (
        [source_media]
      , [Description]
      , [business_type]
    )
VALUES
    (
        'A', 'Affiliate', 'Retail'
    )
  , (
        'B', 'Amex', 'Amex'
    )
  --       ('C', 'Complimentary Members', 'Exclude'),
  , (
        'C', 'Complimentary Members', 'Complimentary'
    )
  , (
        'D', 'Wholesale', 'Wholesale'
    )
  , (
        'DD', 'Wholesale Lite', 'Wholesale'
    )
  , (
        'DM', 'Mastercard Wholesale Lite', 'Wholesale'
    )
  , (
        'E', 'Direct Mail / Lists', 'Retail'
    )
  , (
        'F', 'Membership Upgrade', 'Retail'
    )
  , (
        'G', 'Corporate Groups', 'Corporate'
    )
  , (
        'H', 'Affinity', 'Retail'
    )
  , (
        'I', 'Inserts', 'Retail'
    )
  , (
        'J', 'Space Ads', 'Retail'
    )
  , (
        'K', 'PR / Press misc', 'Retail'
    )
  , (
        'L', 'Other clubs inclusive', 'Retail'
    )
  , (
        'M', 'MGMs', 'Retail'
    )
  , (
        'N', 'MGPs', 'Retail'
    )
  , (
        'O', 'Referrals', 'Retail'
    )
  , (
        'P', 'PPC', 'Retail'
    )
  , (
        'Q', 'Take-ones', 'Retail'
    )
  , (
        'R', 'Group Digital', 'Retail'
    )
  , (
        'S', 'eDM', 'Retail'
    )
  , (
        'T', 'Telemarketing', 'Retail'
    )
  , (
        'U', 'Unknowns', 'Retail'
    )
  , (
        'V', 'Group Inserts', 'Retail'
    )
  , (
        'W', 'Worldwide Web', 'Retail'
    )
  , (
        'X', 'Associate Plus', 'Associate'
    )
  , (
        'XA', 'Authenticated Assoc. Plus.', 'Associate'
    )
  , (
        'Y', 'Other digital', 'Retail'
    )
  , (
        'Z', 'Associate', 'Associate'
    )
  , (
        'ZA', 'Authenticated Assoc', 'Associate'
    );



-- Create the list for source codes 
IF OBJECT_ID('tempdb..#SourceCodes') IS NOT NULL
    DROP TABLE #SourceCodes;

-- Get the data out 
IF OBJECT_ID('tempdb..#temp') IS NOT NULL
    DROP TABLE #temp;

SELECT *
INTO   #temp
  FROM (   SELECT		      

                             con.membership_no As [Membership No],
							 (LTRIM(RTRIM(con.title))) AS [Title],
                             (LTRIM(RTRIM(con.forename))) AS [First name],
                             (LTRIM(RTRIM(con.surname))) AS [Last name],
                             (LTRIM(RTRIM(con.salutation))) AS [salutation],
							 src.activity_code AS [Source Activity Code],  -- From Source Table
							 acc.activity_code AS [Account Activity Code],  -- From Account Line 
                             coalesce(src.source_code,pur.source_code) AS [Source code],
							 acc.amount,
							pur.group_code As [Group Code],
                            con.consumer_no AS [Consumer number],

							smd.business_type As [Business Type],

							adr1.company,
							adr1.addline1,
							adr1.addline2,
							adr1.addline3,
							adr1.city,
							adr1.province,
							adr1.us_state,
							adr1.postcode,
							ctry2.code_desc AS Country,
							adr1.phone1 As [Telephone 1],
							adr1.phone2 As [Telephone 2],
							con.service_centre AS [Consumer Service Centre],
							src.market_code ,
							src.market_code + case when cd6.code_desc is null then '' else ' - ' + cd6.code_desc end AS [Market Code],
							acc.creation_date,
							acc.posted_date,
							
							 ROW_NUMBER() OVER(PARTITION BY pur.consumer_no
								ORDER BY pur.purchase_date DESC, 
                                  pur.paid_to_date DESC, 
                                  pur.creation_date DESC, 
                                  CASE WHEN pur.purchase_no > 0 THEN 0 ELSE 1 END DESC,  -- Puts the -ves on top and the +ves below
                                  abs(pur.purchase_no) DESC -- Makes all purchase_no +ve
                        )   AS latest_purchase_seq	
             FROM            [dbo].[consumer] con WITH (NOLOCK)

            INNER JOIN       [dbo].[purchase] pur WITH (NOLOCK)
               ON con.[consumer_no]          = pur.[consumer_no] -- join to get the Purchase number
			INNER JOIN [dbo].[account_line] acc WITH (NOLOCK) ON acc.purchase_no = pur.purchase_no
            INNER JOIN       [dbo].[consumer_type] ctp WITH (NOLOCK)
               ON ctp.consumer_type_id       = con.consumer_type_id

			-- Find latest address
			LEFT JOIN       (   SELECT t.*
                                   FROM (   SELECT *,
                                                   --ROW_NUMBER() OVER (PARTITION BY consumer_no ORDER BY address_sequence DESC) AS address_seq
												   --ROW_NUMBER() OVER (PARTITION BY consumer_no ORDER BY amendment_date DESC, creation_date DESC) AS address_seq
												   --ROW_NUMBER() OVER (PARTITION BY consumer_no ORDER BY COALESCE(amendment_date, creation_date) DESC) AS address_seq 
												   ROW_NUMBER() OVER (PARTITION BY consumer_no order by isnull(amendment_date, creation_date) desc, creation_date desc, address_sequence desc) AS address_seq
                                              FROM dbo.[address] WITH (NOLOCK) 
													 ) t  
                                  WHERE t.address_seq = 1) adr1
				ON pur.consumer_no            = adr1.consumer_no 

			LEFT JOIN       dbo.code ctry2 WITH (NOLOCK)
               ON adr1.country_code           = ctry2.code
              AND ctry2.codetype              = 'CTRY'
            LEFT  JOIN dbo.purchase_subscription_link psl WITH (NOLOCK) 
				ON psl.purchase_no = pur.purchase_no
			LEFT  JOIN dbo.source_subscription ssb WITH (NOLOCK) 
				ON ssb.source_subscription_id = psl.source_subscription_id
			LEFT  JOIN dbo.source_deal_config sdc WITH (NOLOCK) 
				ON sdc.source_deal_config_id = ssb.source_deal_config_id
			LEFT  JOIN dbo.source src WITH (NOLOCK) 
				ON src.source_code = sdc.source_code
			LEFT  JOIN dbo.subscription_level scl WITH (NOLOCK) 
				ON scl.subscription_level_id = ssb.subscription_level_id


             LEFT JOIN       [dbo].[code] cd6 WITH (NOLOCK)
               ON cd6.code                   = src.market_code
              AND cd6.codetype               = 'MARKAX' -- Translate Market Code

             LEFT JOIN       #SourceMedia smd
               ON smd.source_media           = src.source_media


            WHERE pur.isdeleted               = 0    
			--AND            pur.product_code            = 'pp' -- Acceptance Criteria 4

			AND acc.account_line_type = 'I'	-- Invoiced 
			AND acc.activity_code IN (
										'DACOURIERB'
									   )
			
			AND smd.source_media IN 
				(
						'B' -- Amex Only
					)
			

			   ) rs
 WHERE 
	-- Acceptance Criteria 2
	latest_purchase_seq = 1 
--AND 
--	market_code
--	IN 
--	(
--	'AMEXCA',
--	'AMEXCAA',
--	'AMEXCAB',
--	'AMEXCAC',
--	'AMEXCAI'
--	)
	and cast(creation_date as date) between '2023-02-01' and '2023-02-28'  -- For Oct 2018, Change for the time period needed.

-- Final Output 
SELECT 
	
	[Membership No],

	[Title],
	[First name],
	[Last name],
	[salutation],
	[Source Activity Code],
	[Account Activity Code],
	market_code AS [Market Code],
	[Source code],
	amount,
	--[Group Code],
	--[Consumer number],


	company,
	addline1,
	addline2,
	addline3,
	city,
	province,
	us_state,
	postcode,
	Country,
	[Telephone 1],
	[Telephone 2],
	[Consumer Service Centre]

FROM #temp
 