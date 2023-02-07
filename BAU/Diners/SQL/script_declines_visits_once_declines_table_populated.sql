USE diners_billing_db

SELECT [Lounge ID], 
		[Lounge Name], 
		[Airport Code], 
		[Lounge City], 
		[Visit Date], 
		[Charge to Diners Currency], 
		[Amount Charged to CH Diners Card], 
		[Franchise Code], 
		[Card Number], 
		[Cardholder Name], 
		[Franchise Name], 
		[Franchise Issuing Country Code], 
		[Franchise Issuing Country], 
		[Diners Lounge ID], 
		[Airport Terminal], 
		[Country of Visit], 
		[Members Count], 
		[Guests Count], 
		[Total Visit Count], 
		Batch, 
		[Voucher Number], 
		[Guest Fee]/[Guests Count] as 'Guest Fee', 
		[Charge to Diners Amount], 
		[Original Billing Period], 
		[New Guest Billing Period], 
		[Reason for Refund] AS [Reason for CHARGE],
[Source Code]

FROM tblDinersDeclines
WHERE [New Guest Billing Period] =(SELECT CurrentMonth from tblSystem) and [Amount Charged to CH Diners Card] > 0 