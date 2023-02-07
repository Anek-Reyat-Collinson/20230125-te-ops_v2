/************************************************************************
Project ID	 :  0057
Author		 :	Hyun Sung Lee
Last Mofified :	2016-11-10
              : 2016-09-13  --- AE added date range parameter 
			  : 2018-06-14  -- Added External Identifier as a pert of Membership Extension project Jira --BI-1075

Run History:

24/06/2020	HD Ran successfully for @StartDate = '2020-05-01' as per Anek's request in Teams
12/08/2020	HD Ran successfully for @StartDate = '2020-07-01' as per Anek's request in Teams
12/10/2020	HD Ran successfully for @StartDate = '2020-08-01' as per Anek's request in Teams
10/11/2020	HD Ran successfully for @StartDate = '2020-10-01' as per Anek's request in Teams
09/12/2020	HD Ran successfully for @StartDate = '2020-11-01' as per Anek's request in Teams
13/01/2021	HD Ran successfully for @StartDate = '2020-12-01' as per Anek's request in Teams
09/02/2021	HD Ran successfully for @StartDate = '2021-01-01' as per Anek's request in Teams
09/03/2021	HD Ran successfully for @StartDate = '2021-02-01' as per Anek's request in Teams
14/04/2021	HD Ran successfully for @StartDate = '2021-03-01' as per Anek's request in Teams
11/05/2021	HD Ran successfully for @StartDate = '2021-04-01' as per Anek's request in Teams
10/06/2021	HD Ran successfully for @StartDate = '2021-05-01' as per Anek's request in Teams
12/07/2021	HD Ran successfully for @StartDate = '2021-06-01' as per Anek's request in Teams
10/08/2021	HD Ran successfully for @StartDate = '2021-07-01' as per Anek's request in Teams
10/09/2021	HD Ran successfully for @StartDate = '2021-08-01' as per Anek's request in Teams
11/10/2021	HD Ran successfully for @StartDate = '2021-09-01' as per Anek's request in Teams
09/11/2021	HD Ran successfully for @StartDate = '2021-10-01' as per Anek's request in Teams
09/12/2021	HD Ran successfully for @StartDate = '2021-11-01' as per Anek's request in Teams
13/01/2022	HD Ran successfully for @StartDate = '2021-12-01' as per Anek's request in Teams
10/02/2022	HD Ran successfully for @StartDate = '2022-01-01' as per Anek's request in Teams
10/03/2022	HD Ran successfully for @StartDate = '2022-02-01' as per Anek's request in Teams
13/04/2022	HD Ran successfully for @StartDate = '2022-03-01' as per Anek's request in Teams
12/05/2022	HD Ran successfully for @StartDate = '2022-04-01' as per Anek's request in Teams
14/06/2022	HD Ran successfully for @StartDate = '2022-05-01' as per Anek's request in Teams
11/07/2022	HD Ran successfully for @StartDate = '2022-06-01' as per Anek's request in Teams
10/08/2022	HD Ran successfully for @StartDate = '2022-07-01' as per Anek's request in Teams
13/09/2022	HD Ran successfully for @StartDate = '2022-08-01' as per Anek's request in Teams
11/10/2022	HD Ran successfully for @StartDate = '2022-09-01' as per Anek's request in Teams
10/11/2022	HD Ran successfully for @StartDate = '2022-10-01' as per Anek's request in Teams
12/12/2022	HD Ran successfully for @StartDate = '2022-11-01' as per Anek's request in Teams
13/01/2023	HD Ran successfully for @StartDate = '2022-12-01' as per Anek's request in Teams
************************************************************************/

USE mastercard_db

DECLARE @StartDate AS DATE = '2022-12-01'
DECLARE @EndDate   AS DATE = '2022-12-31';


DISABLE TRIGGER dbo.trg_AutoAudit_tblWLLoungeVisits ON dbo.tblWLLoungeVisits; 
	DELETE FROM dbo.tblWLLoungeVisits WHERE BillingMonth BETWEEN  @StartDate AND @EndDate;
ENABLE TRIGGER dbo.trg_AutoAudit_tblWLLoungeVisits ON dbo.tblWLLoungeVisits; 

SET IDENTITY_INSERT mastercard_db.dbo.tblWLLoungeVisits ON;

INSERT INTO tblWLLoungeVisits
			([BillingMonth],[Member No],[Cardholder Name],[Tier],[Paid To Date],[Visit Date],[Date Processed]
			,[Total Guests],[Visit Fees],[Batch No],[Reference],[Member Status],[LoungeCode],[Lounge],[Airport],[Cost Centre]
			,[Campaign Code],[Total FREE Guests],[FREE Guests Value],[Total Chargeable Guests],[Chargeable Guest Value]
			,[Vendor Code],[User Invitation Code],[Currency],[SourceCode],[tbl_index],[CreatedDate],[CreatedBy],[UpdatedDate],[UpdatedBy],[external_identifier])
	SELECT
		lv.report_month AS 'BillingMonth',
		lv.consumer_no AS 'Member No',
		lv.member_name AS 'Cardholder Name',
		lv.membership AS 'Tier',
		lv.ptd AS 'Paid To date',
		lv.visit_date AS 'Visit Date',
		-----------@ReportDate AS 'Date Processed', --- using the parameter date below
		@EndDate AS 'Date Processed',
		(lv.mc_pays_guest_visits + lv.cm_pays_guest_visits + lv.complimentary_guest_visits + lv.lounge_offer_guest_visits) AS 'Total Guests',
		(lv.mc_pays_guest_visit_fee + lv.cm_pays_guest_visit_fee) AS 'Visit Fees',
		lv.batch_no AS 'Batch No',
		lv.reference AS 'Reference',
		lv.current_status AS 'Member Status',
		lv.lounge_code AS 'LoungeCode',
		lv.lounge_name AS 'Lounge',
		lg.lounge_airport_name AS 'Airport',
		lv.cost_centre AS 'Cost Centre',
		lv.campaign_code AS 'Campaign Code',
		(lv.complimentary_guest_visits + lv.lounge_offer_guest_visits) AS 'Total FREE Guests',
		lv.complimentary_guest_visit_fee AS 'FREE Guests Value',
		(lv.mc_pays_guest_visits + lv.cm_pays_guest_visits) AS 'Total Chargeable Guests',
		(lv.mc_pays_guest_visit_fee + lv.cm_pays_guest_visit_fee) AS 'Chargeable Guest Value',
		lv.vendor_code AS 'Vendor Code',
		lv.user_invitation_code AS 'User Invitation Code',
		lv.mc_pays_member_visit_currency AS 'Currency',
		lv.source_code AS 'SourceCode',
		lv.[tbl_index],
		lv.[CreatedDate],
		lv.[CreatedBy],
		lv.[UpdatedDate],
		lv.[UpdatedBy],
		[external_identifier]
	FROM tblWLLoungeVisits_VA lv
		LEFT JOIN lounge_db.dbo.viewLounges lg ON lv.lounge_code = lg.lounge_code
	WHERE lv.report_month BETWEEN  @StartDate AND @EndDate

SET IDENTITY_INSERT mastercard_db.dbo.tblWLLoungeVisits OFF;


