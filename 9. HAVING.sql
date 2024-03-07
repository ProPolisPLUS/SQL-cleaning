--Heaving naredba
--Koristi se za filtriranje podataka nakon funkcije GROUP BY
-- A WHERE smo koristili prije GROUP BY funkcije


SELECT JobTitle, COUNT(JobTitle) as CountJobTitle
FROM [SQL Tutorijal].dbo.EmployeeDemographics
JOIN [SQL Tutorijal].dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeedID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1 --Ovdje WHERE ne bi radilo, uz Group By se koristi having za filtriranje


--Evo jos jednog primjera
SELECT JobTitle, AVG(Salary) as AvgSalary
FROM [SQL Tutorijal].dbo.EmployeeDemographics
JOIN [SQL Tutorijal].dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeedID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000