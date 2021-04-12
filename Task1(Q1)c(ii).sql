USE 
   [Keys] 
SELECT Property.Id AS "Property ID", Owners.Id AS "Owner ID", Property.Name AS "Property Name", PropertyFinance.Yield
FROM  [dbo].[Property]  
INNER JOIN  [dbo].[OwnerProperty] ON Property.Id = OwnerProperty.PropertyId 
INNER JOIN [dbo].[Owners] Owners ON  Owners.Id = OwnerProperty.OwnerId
INNER JOIN [dbo].[PropertyFinance] PropertyFinance ON PropertyFinance.PropertyId =Property.Id
WHERE Owners.[Id] = 1426 
ORDER BY Property.Id