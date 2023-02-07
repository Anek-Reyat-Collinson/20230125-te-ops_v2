/*
	STEP 3
	MasterCard CSV Billing Files
	Execute Stored Procedures to generate CSV Billing Files
	
	Purpose	
		
	Created by:		Bilal Ahmed
	Date Created:	16-Jun-2015
	For Lifestyle Benefits, The Collinson Group
	
	-- PRIVATE AND CONFIDENTIAL --		
*/

USE mastercard_db
GO

DECLARE @FilePath varchar(255)
DECLARE @RunDate varchar(255)
DECLARE @NotificationEmail VARCHAR(255)

SET @FilePath				= 'E:\MasterCardReports\MasterCard\'
SET @RunDate				= '20150901'
SET @NotificationEmail		= 'bilal.ahmed@collinsongroup.com'

-- MasterCard Wholesale Lite Billing Files
EXECUTE  dbo.MCBillingFilesMembershipWholesaleLite @ReportMonth  = @RunDate, @FileDestination = @FilePath, @EmailAddress = @NotificationEmail
EXECUTE  dbo.MCBillingFilesLoungeVisitsWholesaleLite @ReportMonth = @RunDate, @FileDestination = @FilePath, @EmailAddress = @NotificationEmail

---- MasterCard LoungeKey Billing Files
EXECUTE  dbo.MCBillingFilesLoungeVisitsLoungeKeyAssociatesAssociatesPlus @ReportMonth  = @RunDate, @FileDestination = @FilePath, @EmailAddress = @NotificationEmail
EXECUTE  dbo.MCBillingFilesMembershipLoungeKey @ReportMonth  = @RunDate, @FileDestination = @FilePath, @EmailAddress = @NotificationEmail

---- MasterCard Associates Billing Files
EXECUTE  dbo.MCBillingFilesMembershipIndirectAssociates @ReportMonth  = @RunDate, @FileDestination = @FilePath, @EmailAddress = @NotificationEmail
EXECUTE  dbo.MCBillingFilesLoungeVisitsIndirectAssociate @ReportMonth  = @RunDate, @FileDestination = @FilePath, @EmailAddress = @NotificationEmail