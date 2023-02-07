------------------------------------ Run history -------------------------------------------------
--Run history: 17/03/2016	GM	Kevin ran this
 --11/11/2016	AE	 ran this FOR REPORT_MONTH =2016-10-01
 --13/12/2016	AE	 ran this FOR REPORT_MONTH =2016-11-01
 --13/01/2017	AE	 ran this FOR REPORT_MONTH =2016-12-01
  --13/02/2017	AE	 ran this FOR REPORT_MONTH =2017-01-01
--------------------------------------------------------------------------------------------------
/*
      STEP 2
      MasterCard CSV Billing Files
      Maintain 3 billing incusion columns in mastercard_dw, dimTblMCIDeals
      
      1, billing_inclusion_memberships
      2, billing_inclusion_loungevisits
      3, billing_inclusion_freight
      
      Any future changes will be added to this file and full script shall be executed
      
      Created by:       Bilal Ahmed
      Date Created:     14-May-2015
      Date Modified:    16-May-2016 (included '7500945182',       -- Adam and Co.)
      For Lifestyle Benefits, The Collinson Group
      
      -- PRIVATE AND CONFIDENTIAL --
            
*/
USE [deals_db]
GO
/*
      Changes made as per Laura Bayle's email
      RE: MC final Billing file Location
      Dated: Tue 10/03/2015 10:04
*/
-- SETP 1
-- Reset the lounge visits inclusion column and set everything to be included by default
UPDATE dbo.dimTblMCDeals SET billing_inclusion_lounge_visits = 'Y'

-- SETP 2
-- WHOLESALE LITE
-- Exclude all wholesale lite sourcecodes to be billed for lounge visits
-- except for the ones given below

UPDATE
      dbo.dimTblMCDeals 
      SET billing_inclusion_lounge_visits = 'N'
WHERE 
      account_type_fk IN (2)              -- Wholesale lite account type
      AND clientid NOT IN 
            (
                  'HXMCBWAUS14',          -- BankWest
                  'HXMCSCBINO14',         -- Standard Chartered Bank
                  'DACITA1410MCPP', -- Citibank
                  'DABANA1410MCPP',  -- BanACI
				  'MCCCBWL2014'		-- Central Cooperative Bank PLC (added to script Oct 2016 Billing Month)
            )

-- SETP 3
-- INDIRECT ASSOCIATES
-- Include all indirect associates clientids to be billed for lounge visits
-- except for the ones given below

UPDATE 
      dbo.dimTblMCDeals 
      SET billing_inclusion_lounge_visits = 'N' -- include only these Wholesale lite lounge visits
WHERE 
      account_type_fk IN (1,3)                  -- Indirect Associates account type
      AND clientid IN 
            (
                  '7000242182',           -- Barclays i24
                  '7000247799',           -- Barclays i24
                  '7500542182',           -- Barclays i24
                  '7000249505',           -- RBS Black
                  '7000719268',           -- NatWest Black
                  '7500549505',           -- RBS Black
                  '7500549268',           -- NatWest Black
                  '7000812906',           -- Coutts
                  '7500542906',           -- Coutts
                  '7000995182',           -- Adam and Co.
                  '7500945182',           -- Adam and Co.
                  '7500582906',           -- Coutts
                  '70012517111'           -- Banca Koper
            )

-- SETP 4
-- Reset the membership billing inclusion column and set everything to be included by default
UPDATE dbo.dimTblMCDeals SET billing_inclusion_memberships = 'Y'

-- SETP 5
-- Indirect Associate Memberships
-- Include all Indirect Associate clientids to be billed for memberships
-- except for the ones given below

UPDATE
      dbo.dimTblMCDeals 
      SET billing_inclusion_memberships = 'N'
WHERE 
      account_type_fk = 1                 -- Indirect Associates account type
      AND clientid IN 
            (
                  '7008073311',           -- Citibank Berhad
                  '7008071096',           -- Citibank Hong Kong
                  '7008079433',           -- BDO Unibank Inc.
                  '7008079445'            -- Bank of Shanghai                 
            )
      OR
            -- Russian Banks membership exclusion
            prefix IN
            (
                  '758824',
                  '758825',
                  '758034',
                  '758035',
                  '758054',
                  '758055'
            )

-- SETP 5
-- LoungeKey Memberships
-- Include all LoungeKey sourcecodes to be billed for memberships
-- except for the ones given below

UPDATE
      dbo.dimTblMCDeals 
      SET billing_inclusion_memberships = 'N'
WHERE 
      account_type_fk IN (5,6,7)    -- LoungeKey account type
      AND prefix IN 
            (
                  'LKMCMENA2014'
                  -- [BA] commenting below sourcecodes after a discussion with [JF] 12:00 16-Sep-2015
                  --'LKMCBRAUFV1501',
                  --'LKMCBRA0FV1501',
                  --'LKMCBRA2FV1501'
            )

-- STEP 6
-- Reset the freight billing inclusion column and set everything to be included by default
UPDATE dbo.dimTblMCDeals SET billing_inclusion_freight = 'Y'

-- add below any deals to be excluded form freight

