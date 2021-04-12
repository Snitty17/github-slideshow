USE 
   [Keys] 

SELECT Property.Id AS "Property ID", Owners.Id AS "Owners ID", Property.Name AS "Property Name", TenantPaymentFrequencies.Name AS "Payment Frequencies", TenantProperty.StartDate, TenantProperty.EndDate,
CASE 
   WHEN TenantPaymentFrequencies.Name = 'Weekly' THEN ISNULL(PropertyRentalPayment.Amount, NULL)*ISNULL(DATEDIFF(WEEK, TenantProperty.[StartDate], TenantProperty.[EndDate]), NULL)
   WHEN TenantPaymentFrequencies.Name = 'Fortnightly' THEN ISNULL(PropertyRentalPayment.Amount, NULL)*ISNULL(DATEDIFF(WEEK, TenantProperty.[StartDate], TenantProperty.[EndDate]), NULL)/2
   WHEN TenantPaymentFrequencies.Name = 'Monthly' THEN ISNULL(PropertyRentalPayment.Amount, NULL)*ISNULL(DATEDIFF(MONTH,
     TenantProperty.[StartDate], TenantProperty.[EndDate]), NULL)
   ELSE NULL
END AS "Total Payment"
FROM  [dbo].[Property]
INNER JOIN  [dbo].[OwnerProperty] ON Property.Id = OwnerProperty.[PropertyId]
INNER JOIN [dbo].[Owners] ON  Owners.Id = OwnerProperty.OwnerId
INNER JOIN [dbo].[PropertyRentalPayment] ON PropertyRentalPayment.PropertyId = Property.Id
INNER JOIN [dbo].[TenantProperty] ON TenantProperty.PropertyId = PropertyRentalPayment.PropertyId
INNER JOIN [dbo].[TenantPaymentFrequencies] ON TenantPaymentFrequencies.Id = TenantProperty.PaymentFrequencyId
WHERE Owners.Id = 1426
GROUP BY Property.Id, Owners.Id, Property.Name, TenantPaymentFrequencies.Name, TenantProperty.StartDate, TenantProperty.EndDate, PropertyRentalPayment.Amount
ORDER BY Property.Id ASC
