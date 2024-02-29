
--Select Statement(Naredbe):
--*,Top,Distinct,Count,As,Max,Min,Avg 



SELECT * --Zvjezdica znaci all
FROM EmployeeDemographics 

SELECT Firstname, Lastname --Ili samo jedna kolona koja nam je potrebna
FROM EmployeeDemographics

SELECT TOP 5* --Prikazacemo samo 5 prvih redova
FROM EmployeeDemographics

SELECT DISTINCT(Gender) --Izbacice samo dva rezultata, Ova funkcija predstavlja koliko ima vrsta odgovora u sustini
FROM EmployeeDemographics

SELECT COUNT(Lastname) --Racuna koliko ima redova u toj koloni, medjutim pise No column name na izlazu to cemo ispraviti ovako
FROM EmployeeDemographics 

SELECT COUNT(Lastname) AS LastnameCount --Sada imamo naziv kolone
FROM EmployeeDemographics

SELECT MAX(Salary) AS MaxSalary --Na izlaz imamo maksimalnu platu
FROM EmployeeSalary

SELECT MIN(Salary) AS MinSalary
FROM EmployeeSalary

SELECT AVG(Salary) AS AvgSalary
FROM EmployeeSalary

--Kada bi prebacili na master koriscenje nijenda od ovih funkcija ne bi radila jer bi trebalo po pravilu da se poziva ovako
SELECT *
FROM [SQL Tutorijal].dbo.EmployeeSalary
