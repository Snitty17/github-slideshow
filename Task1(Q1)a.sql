USE 
   [Keys] 
SELECT Property.Id AS "Property ID" ,Owners.Id AS "Owner ID", Property.Name AS "Property Name"
FROM  [dbo].[Property]  
INNER JOIN  [dbo].[OwnerProperty] ON Property.Id = OwnerProperty.[PropertyId]
INNER JOIN [dbo].[Owners] ON  Owners.Id = OwnerProperty.OwnerId
WHERE Owners.[Id] = 1426 
ORDER BY Property.ID ASC