USE diners_billing_db

SELECT pp_lounge_id AS [Lounge ID], 
		lounge_name AS [Lounge Name], 
		airport_code AS [Airport Code], 
		lounge_city AS [Lounge City], 
		visit_date AS [Visit Date], 
		diners_currency AS [Charge to Diners Currency], 
		member_fee AS [Visit Fee], 
		CASE WHEN s.ch_pays_member_visit = 1 THEN 0 ELSE member_fee END AS [Charge to Diners Amount], 
		franchise_code AS [Franchise Code], 
		card_number AS [Card Number], 
		cardholder_name AS [Cardholder name], 
		franchise_name AS [Franchise Name], 
		franchise_issuing_country_code_numeric AS [Franchise Issuing Country Code],
		franchise_issuing_country AS [Franchise Issuing Country], 
		diners_lounge_id AS [Diners Lounge ID], 
		airport_terminal AS [Airport Terminal], 
		country_of_visit AS [Country of Visit], 
		members_count AS [Members Count], 
		guests_count AS [Guests Count], 
		total_visits_count AS [Total Visit Count], 
		batch AS Batch, 
		voucher_number AS [Voucher Number], 
		CASE WHEN s.ch_pays_member_visit = 1 THEN [guests_count]*[guest_fee] + member_fee else [guests_count]*[guest_fee] end AS [Amount Charged to CH Diners Card], 
		billing_period AS BillingPeriod,
LV.source_code as [Source Code]

FROM tblLoungeVisits lv LEFT JOIN tblSourceCodes S ON LV.source_code = S.source_code

WHERE billing_period=(SELECT CurrentMonth from tblSystem) AND bill_to_diners= 1