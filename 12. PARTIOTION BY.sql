--Partition by
--Ova funkcija se primjenjuje uz funkciju OVER (Preko)
--OVER se koristi da bi se definisali segmenti podataka na koje ce se izvrsiti analiza
-- (Naredba) + OVER + (PARTITION BY (Kolona)) AS xxxxx
--Sto znaci:
--Primijeni narednu na  koloni i sacuvaj rezultat u kolonu xxxx


--Zelimo da dobijemo tabelu dje ce za svaki ID pisat koliko ima zena i muskaraca ukupno
SELECT Gender, COUNT(Gender) AS CountGender
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics AS dem
JOIN [SQL Tutorijal].dbo.FULLEmployeeSalary AS sal
	ON dem.EmployeeID = sal.EmployeeID
GROUP BY Gender

--Medjutim mi zelimo da za svakog radnika dodamo kolonu dje se nalazi broj ukupnog broja zena ako je ranik zena
--Odnosno, ako je radnik muskarac da pise koliko ima ukupno muskaraca

SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) As TotalGender
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics AS dem
JOIN [SQL Tutorijal].dbo.FULLEmployeeSalary AS sal
	ON dem.EmployeeID = sal.EmployeeID

--Partition by koristimo da bi naredili programu iz koje kolone da uzima podatke koje ce da dijeli po redova
--Rekli smo mu da Primijeni count funkciju za podatke iz kolone gender i da rezultate zapise u novu kolonu


