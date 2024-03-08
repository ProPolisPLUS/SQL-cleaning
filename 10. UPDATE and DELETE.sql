-- Updating/Deleting data

SELECT *
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics

/*
UPDATE [SQL Tutorijal].dbo.FULLEmployeeDemographics
SET EmployeeID = 1012, Age = 31, Gender = 'Female'
WHERE FirstName = 'Holly' AND LastName = 'Flax'  
*/
-- Ovo da pokrenemo promjenile bi se NULL celije, ali ne pokrecem jer se ova tabela koristi za ostale lekcije
--Na taj nacin mozemo i mijenjati podatke


/*
DELETE 
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics
WHERE EmployeeID = 1005
*/
-- Na ovaj nacin brisemo redove iz kolona
--Kad se jednom izbrise, nema nazad
