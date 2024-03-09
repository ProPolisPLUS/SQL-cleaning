-- Aliasing (Dodjela Imena)


SELECT FirstName + ' ' + LastName AS FullName
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics 
--Ovo je jedan od primjera kombinovanja kolona

--Na isti nacin mozemo da dodajemo imena tabela kako bi omogucili lakse rukovanje istim
SELECT Demo.EmployeeID, Sal.Salary
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics AS Demo --Imenovali smo jednu tabelu
JOIN [SQL Tutorijal].dbo.FULLEmployeeSalary AS Sal --Imenovali smo drugu tabelu
	ON Demo.EmployeeID = Sal.EmployeeID
--Tako vise ne moramo koristiti cijelo ime tabele, vec nametnuti nadimak
--Na ovaj nacin se dobijana preglednosti