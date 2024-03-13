--Temp tabele
/*
Privremene tabele: Podaci u privremenim tabelama postoje samo dok traje sesija
korisnika ili dok se eksplicitno ne obrišu. Nakon završetka sesije, privremene tabele se automatski brišu.

Privremene tabele: Mogu biti brže jer se obično drže u radnoj memoriji (ako je moguće)
i imaju kraće trajanje, što može smanjiti opterećenje baze podataka.

U mnogim slučajevima, privremene tabele se koriste za pomoć pri privremenim operacijama, filtriranju 
podataka ili organizaciji rezultata upita unutar sesije. Obične tabele se koriste za trajno skladištenje 
podataka koje su potrebne na dulji rok. Važno je razumjeti
kontekst i zahtjeve vašeg projekta kako biste odabrali pravu vrstu tablica za vaše potrebe.
*/

--Napravicemo jednu temp tabelu
DROP TABLE IF EXISTS #TempEmployee --Ovi komanda se koristi da se ne bi dobijao eror ponovnim pokretanjem
--Omogucava nam da ne dobijamo poruku da tempEmployee vec postoji.. Komanda ukloni tabelu ako vec postoji
CREATE TABLE #TempEmployee (
EmployeeID int,
JobTitle varchar(100),
Salary int
)

INSERT INTO #TempEmployee VALUES (
'1001', 'HR', '45000'
)

SELECT *
FROM #TempEmployee

--Napravili smo privremenu tabeleu. One su prakticne jer sad mogu da vrlo jednostavno na ovu tabelu nadogradim drugu

INSERT INTO #TempEmployee
SELECT *
FROM [SQL Tutorijal].dbo.EmployeeSalary

SELECT *
FROM #TempEmployee

--Sad malo komplikovaniji primejr
DROP TABLE IF EXISTS #TempEmployee2
CREATE TABLE #TempEmployee2 (
JobTitle varchar(50),
EmployeePerJob int,
AvgAGE int,
AvgSalary int)

INSERT INTO #TempEmployee2
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM [SQL Tutorijal].dbo.EmployeeDemographics AS demo
JOIN [SQL Tutorijal].dbo.EmployeeSalary AS sal
	ON demo.EmployeeID = sal.EmployeedID
GROUP BY JobTitle

SELECT *
FROM #TempEmployee2 --Dobili smo novu tabelu koja ce da sadrzi neke obradjene podatke iz yabele EployeeDemographic i Employee Salary





