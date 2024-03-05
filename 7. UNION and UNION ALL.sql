

--Operatori: Union, Union All


--Zelimo dvije tabele sa istiom podacima da smjestimo u jednu, na osnovu toga sto imaju ista podatke
SELECT *
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics
UNION --Unija
SELECT *
FROM [SQL Tutorijal].dbo.WareHouseEmployeeDemographics
--Ova funkcija ce odstraniti duplikate

SELECT *
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics
UNION ALL --Unija
SELECT *
FROM [SQL Tutorijal].dbo.WareHouseEmployeeDemographics
ORDER BY EmployeeID
--Dok ce nam UNION ALL prikazati sve podatke
--ORDER BY koristimo da bi soritrali ID i lakse uocili duplikata


--Sadacemo probati da spojimo tabele koje nemaju iste kolone
SELECT EmployeeID, Firstname, Age
FROM [SQL Tutorijal].dbo.EmployeeDemographics
UNION  --Unija
SELECT EmployeedID, JobTitle, Salary
FROM [SQL Tutorijal].dbo.EmployeeSalary
ORDER BY EmployeeID
--Dobicemo prikaz na ovaj nacin
--Stim da smo morali poklopiti vrste kolona, int sa intom, string sa stringom