USE 
   [Keys] 
SELECT Property.Name AS "Property Name", Owners.Id AS "Owners ID", (FirstName + ' ' + LastName) AS "Full Name",
CASE 
    WHEN TenantPaymentFrequencies.Name = 'Weekly' THEN ISNULL(PropertyRentalPayment.Amount, NULL)
	WHEN TenantPaymentFrequencies.Name = 'Fortnightly' THEN ISNULL(PropertyRentalPayment.Amount, NULL)/2
	WHEN TenantPaymentFrequencies.Name = 'Monthly' THEN ISNULL(PropertyRentalPayment.Amount, NULL)/4
	ELSE NULL
END AS "Weekly",
CASE 
    WHEN TenantPaymentFrequencies.Name = 'Weekly' THEN ISNULL(PropertyRentalPayment.Amount, NULL)*2
	WHEN TenantPaymentFrequencies.Name = 'Fortnightly' THEN ISNULL(PropertyRentalPayment.Amount, NULL)
	WHEN TenantPaymentFrequencies.Name = 'Monthly' THEN ISNULL(PropertyRentalPayment.Amount, NULL)/2
	ELSE NULL
END AS "Fortnightly",
CASE
	WHEN TenantPaymentFrequencies.Name = 'Weekly' THEN ISNULL(PropertyRentalPayment.Amount, NULL)*4
	WHEN TenantPaymentFrequencies.Name = 'Fortnightly' THEN ISNULL(PropertyRentalPayment.Amount, NULL)*2
	WHEN TenantPaymentFrequencies.Name = 'Monthly' THEN ISNULL(PropertyRentalPayment.Amount, NULL)
	ELSE NULL
END AS "Monthly"
FROM [dbo].[Person] 
INNER JOIN  [dbo].[OwnerProperty] ON Person.Id = OwnerProperty.Id
INNER JOIN [dbo].[Property] ON Property.Id = OwnerProperty.[PropertyId]
INNER JOIN [dbo].[Owners] ON  Owners.Id = OwnerProperty.OwnerId
INNER JOIN [dbo].[PropertyRentalPayment] ON PropertyRentalPayment.PropertyId = Property.Id
INNER JOIN [dbo].[TenantProperty] ON TenantProperty.PropertyId = PropertyRentalPayment.PropertyId
INNER JOIN [dbo].[TenantPaymentFrequencies] ON TenantPaymentFrequencies.Id = TenantProperty.PaymentFrequencyId
WHERE Owners.Id = 1426 
GROUP BY Property.Id, Owners.Id, Property.Name, Person.FirstName, Person.LastName, PropertyRentalPayment.Amount, TenantPaymentFrequencies.Name
ORDER BY Property.Id ASC