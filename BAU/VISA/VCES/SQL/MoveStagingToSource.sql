--Move staging over to source.

--Move over bin list
INSERT INTO Billing_Automation.[source].TBL_BIN_LIST1
SELECT * FROM Billing_Automation.[staging].TBL_BIN_LIST;
---(2974653 rows affected)

--Move over tbl_ppbo_declines with a masked card number
INSERT INTO Billing_Automation.[source].tbl_ppbo_declines
SELECT
	deal_type,
	external_identifier,
	track_seq,
	consumer_no,
	left(credit_card_number,9) + '***' + right(credit_card_number,4) as credit_card_number,
	credit_card_expiry_date,
	service_centre,
	account_line_sequence,
	account_line_status,
	acccount_line_description,
	account_line_type,
	activity_code,
	batch_no,
	purchase_no,
	glac_code,
	amount,
	us_amount,
	currency,
	rate,
	cc_card_type,
	charge_back_code,
	posted_date,
	transaction_id,
	source_code,
	paid_to_date,
	member_type,
	source_desc,
	source_type,
	product,
	market_code,
	member_status,
	glac_description,
	country_of_residence,
	lounge_code,
	country_code,
	country_of_visit,
	visit_date,
	track_mbr,
	track_guests,
	recharge,
	[process_date>ptd],
	[process_date>cc_expiry_date],
	voucher_ref,
	experience_type,
	brand_category,
	accountline_created_by,
	accountline_creation_date,
	accountline_amended_by,
	accountline_amendment_date,
	created_by,
	creation_date,
	dataloadworkflowid,
	report_month
FROM
	Billing_Automation.staging.tbl_ppbo_declines


--Move over tbl_ppbo_declines_with_bin with a masked card number
INSERT INTO Billing_Automation.[source].tbl_ppbo_declines_with_bin
SELECT
	[Consumer No],
	BIN,
	[BIN Lower Range],
	[BIN Upper Range],
	BID,
	[Issuer Name],
	[Country Of Issue],
	left([credit card number],9) + '***' + right([credit card number],4) as [credit card number],
	null as [Credit Card expiry],
	[Account line description],
	[US amount],
	Currency,
	[CC card type],
	[Source code],
	[Country of residence],
	[Lounge code],
	Airport,
	City,
	[Country of visit],
	[Visit date],
	[Track mbr],
	[Track guests],
	[Voucher ref],
	[Creation date],
	[Reason for Charge],
	report_month,
	region,
	created_date
FROM
	Billing_Automation.staging.tbl_ppbo_declines_with_bin;

--Move over tbl_ppbo_members with a masked card number
INSERT INTO Billing_Automation.[source].tbl_ppbo_members
SELECT
	report_month,
	consumer_no,
	bin,
	left([pan],9) + '***' + right([pan],4) as [pan],
	issuer,
	country,
	source_code,
	forename,
	surname,
	date_of_registration,
	expiry_date,
	isMembershipActive,
	sent_to_visa,
	created_date,
	created_by,
	dataloadworkflowid
FROM
	Billing_Automation.staging.tbl_ppbo_members

--Move over tbl_ppbo_visits with a masked card number
INSERT INTO Billing_Automation.source.tbl_ppbo_visits
SELECT
	[Source Code],
	[Member No],
	left([CCard No],9) + '***' + right([CCard No],4) as [CCard No],
	Title,
	[First Name],
	[Last Name],
	[Membership Plan],
	[Member Status],
	[Paid To Date],
	[Experience Transaction Date],
	[Date Processed],
	[Guests Visits],
	[Batch No],
	Reference,
	[Lounge Codde],
	Lounge,
	Airport,
	City,
	Country,
	[Client 1 Pays Member Visit],
	[Client 2 Pays Member Visit],
	[Inclusive PP Member Visit],
	[Complimentary Member Visit],
	[Cardholder Pays Member Visit],
	[Client 1 Pays Guest Activity],
	[Client 2 Pays Guest Activity],
	[Inclusive PP Guest Visit],
	[Complimentary Guest Visit],
	[Cardholder Pays Guest Visit],
	[Lounge Visit Offer],
	[Client 1 Member],
	[Client 2 Member],
	[Inclusive PP Member],
	[Client 1 Guest],
	[Client 2 Guest],
	[Inclusive PP Guest],
	[Client 1 Member/Guest],
	[Client 2 Member/Guest],
	[Inclusive PP Member/Guest],
	[Complimentary Member/Guest],
	[Client 1 Visit Currency Member],
	[Client 1 Visit Amount Member],
	[Client 1 Visit Currency Guest],
	[Client 1 Visit Amount Guest],
	[Total Client 1 Amount Currency],
	[Total Client 1 Amount],
	[Client 2 Visit Currency Member],
	[Client 2 Visit Amount Member],
	[Client 2 Visit Currency Guest],
	[Client 2 Visit Amount Guest],
	[Total Client 2 Amount Currency],
	[Total Client 2 Amount],
	[Cardholder Visit Currency Member],
	[Cardholder Visit Amount Member],
	[Cardholder Visit Currency Guest],
	[Cardholder Visit Amount Guest],
	[Total Cardholder Amount Currency],
	[Total Cardholder Amount],
	[Cost Centre],
	[Campaign Code],
	[Vendor Code],
	[User Invitation Code],
	[lounge type],
	creation_date,
	created_by,
	track_seq,
	consumer_no,
	report_month,
	dataloadworkflowid,
	[CCard No Expiry Date]
FROM
	Billing_Automation.staging.tbl_ppbo_visits

--Move over tbl_ppbo_visits_with_bin with a masked card number
INSERT INTO Billing_Automation.source.tbl_ppbo_visits_with_bin
SELECT
	source_code,
	external_identifier,
	[bin(9)],
	[bin(6)],
	bin_upper_range,
	bin_lower_range,
	issuer,
	issuer_country,
	bid,
	funding_source,
	deal_type,
	product_sub_type,
	ccard_no_mask as ccard_no,
	ccard_no_mask,
	visit_date,
	date_processed,
	reference,
	lounge_code,
	lounge_type,
	lounge,
	airport,
	city,
	country,
	visa_pays_member_visit,
	issuer_pays_member_visit,
	inclusive_pp_member_visit,
	complimentary_member_visit,
	cardholder_pays_member_visit,
	visa_pays_guest_visit,
	issuer_pays_guest_visit,
	inclusive_pp_guest_visit,
	complimentary_guest_visit,
	cardholder_pays_guest_visit,
	lounge_visit_offer,
	visa_visit_currency_member,
	visa_visit_amount_member,
	visa_visit_currency_guest,
	visa_visit_amount_guest,
	total_visa_amount_currency,
	total_visa_amount,
	issuer_currency_member,
	issuer_amount_member,
	issuer_amount_member_discounted,
	issuer_currency_guest,
	issuer_amount_guest,
	total_issuer_amount_currency,
	issuer_amount_guest_discounted,
	total_issuer_amount,
	total_issuer_amount_discounted,
	difference,
	cardholder_visit_currency_member,
	cardholder_visit_amount_member,
	cardholder_visit_currency_guest,
	cardholder_visit_amount_guest,
	total_cardholder_amount_currency,
	total_cardholder_amount,
	cost_centre,
	campaign_code,
	vendor_code,
	user_invitation_code,
	avg_visa_pays,
	report_month,
	NULL unit_price,
	ccard_no_expiry_date
FROM
	Billing_Automation.staging.tbl_ppbo_visits_with_bin;

TRUNCATE TABLE Billing_Automation.staging.tbl_ppbo_visits_with_bin;
TRUNCATE TABLE Billing_Automation.staging.tbl_ppbo_visits;
TRUNCATE TABLE Billing_Automation.staging.tbl_ppbo_members;
TRUNCATE TABLE Billing_Automation.staging.tbl_ppbo_members_with_bin;
TRUNCATE TABLE Billing_Automation.staging.tbl_ppbo_declines_with_bin;
TRUNCATE TABLE Billing_Automation.staging.tbl_ppbo_declines;
TRUNCATE TABLE Billing_Automation.[staging].tbl_bin_List;

SELECT COUNT(1) FROM Billing_Automation.staging.tbl_ppbo_visits_with_bin;
SELECT COUNT(1) FROM Billing_Automation.staging.tbl_ppbo_visits;
SELECT COUNT(1) FROM Billing_Automation.staging.tbl_ppbo_members;
SELECT COUNT(1) FROM Billing_Automation.staging.tbl_ppbo_members_with_bin;
SELECT COUNT(1) FROM Billing_Automation.staging.tbl_ppbo_declines_with_bin;
SELECT COUNT(1) FROM Billing_Automation.staging.tbl_ppbo_declines;
SELECT COUNT(1) FROM Billing_Automation.[staging].tbl_bin_List;