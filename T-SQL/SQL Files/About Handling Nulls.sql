--IS NULL
SELECT * FROM Person.Person
WHERE Title IS NULL AND MiddleName IS NULL

--ISNULL
SELECT [BusinessEntityID], [PersonType], [NameStyle],[Title], ISNULL([Title],'NA'), [FirstName], [MiddleName], [LastName], [Suffix], [EmailPromotion], [AdditionalContactInfo]
FROM Person.Person

--COLAESCE

SELECT  [MiddleName],[FirstName], [LastName],COALESCE([MiddleName],[FirstName], [LastName])
FROM Person.Person
