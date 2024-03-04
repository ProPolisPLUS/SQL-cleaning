-- Inner Joins, Full/Left/Right Outer Joins

SELECT *
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics

SELECT *
FROM [SQL Tutorijal].dbo.FULLEmployeeSalary

--Mozemo primijetiti da obije dabele imaju istu kolonu, ID
--Sada cemo spjiti oboje kolone na osnovu EmployeeID

SELECT *
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics
Inner Join [SQL Tutorijal].dbo.FULLEmployeeSalary
	ON FULLEmployeeDemographics.EmployeeID = FULLEmployeeSalary.EmployeeID
--Inner Join,Spajamo ih na temelju unije skupova
--Zamislimo dva kruga koji ulaze malo jedan u drugi...E mi spajamo tabele na osnovu zajednickog polja EmployeeID
--Prikazuje samoredove za koje prepoznaje podatke

SELECT *
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics
Full Outer Join [SQL Tutorijal].dbo.FULLEmployeeSalary
	ON FULLEmployeeDemographics.EmployeeID = FULLEmployeeSalary.EmployeeID
--Full Outer Join, sada spajamo svu prvu sa svom drugom tablicom, bez obzira na njihovu uniju
--Sada imamo ID kojih im u jednu a nema u drugu i obratno, sto znaci da ce ostala polja ostati prazna
--Jer se podaci ne mogu pronaci u drugoj tabeli

SELECT *
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics --Left
Left Outer Join [SQL Tutorijal].dbo.FULLEmployeeSalary --Right
	ON FULLEmployeeDemographics.EmployeeID = FULLEmployeeSalary.EmployeeID
--U ovom slucaju prikazace se podaci ali samo radnika ciji je ID prisutan u Lijevoj tabeli
--U slucaju da tog ID nema u desnoj tabeli, polja ce se popuniti sa NULL

SELECT *
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics --Left
Right Outer Join [SQL Tutorijal].dbo.FULLEmployeeSalary --Right
	ON FULLEmployeeDemographics.EmployeeID = FULLEmployeeSalary.EmployeeID
--Sada ce prikazati samo radnike ciji se ID nalazi u desnoj tabeli

SELECT FULLEmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics 
Full Outer Join [SQL Tutorijal].dbo.FULLEmployeeSalary 
	ON FULLEmployeeDemographics.EmployeeID = FULLEmployeeSalary.EmployeeID

--Kako bi selektovali odredjene kolone moramo navesi koji EmployeeID zelimo
--U ovom slucaju smo odabrali ID iz lijevog skupa podataka


--Sada npr zelimo da povecamo platu Michael - u a oduzmemo od plate najplacenijem radniku ne racunajuci Michela
SELECT FULLEmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics 
 Inner Join [SQL Tutorijal].dbo.FULLEmployeeSalary 
	ON FULLEmployeeDemographics.EmployeeID = FULLEmployeeSalary.EmployeeID
WHERE FirstName<>'Michael'
ORDER BY Salary DESC


SELECT  JobTitle, AVG(Salary) AS AVGSalary
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics 
 Inner Join [SQL Tutorijal].dbo.FULLEmployeeSalary 
	ON FULLEmployeeDemographics.EmployeeID = FULLEmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle --Grupisali smo sve plate grupu nazvanu JobTitle
-- A na pocetku smo stavili da od te gupe podataka izracuna srednju platu
