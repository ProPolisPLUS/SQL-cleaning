-- Where naredba
-- =, <>, <, >, And, Or, Like, Null, Not Null, In

SELECT *
FROM EmployeeDemographics
WHERE Firstname = 'Jim' --Dobili smo samo redak dje je ime Jim

SELECT *
FROM EmployeeDemographics
WHERE Firstname <> 'Jim' -- <> znaci da nije jednako
-- Sto znaci da ce prikazati sve osim reda dje je ime Jim

SELECT *
FROM EmployeeDemographics
WHERE Age >= 30 --Samo ljude koijm je broj godina veci ili jednako od 30
--Naravno moze da stoji ili samo vece ili samo jednako

SELECT *
FROM EmployeeDemographics
WHERE Age < 32 --Dobijamo readove gdje je broj godina manji od 32

SELECT *
FROM EmployeeDemographics
WHERE Age <= 32 AND Gender='Male'
--Sad smo iskoristili naredbu and i dodali jos jedan uslov kako bi filtrirali podatke

SELECT *
FROM EmployeeDemographics
WHERE Age <= 32 OR Gender='Male'
--Bilo koji uslov od ova dva da se ispuni, dodace taj red u tabelu

SELECT *
FROM EmployeeDemographics
WHERE Lastname LIKE 'S%'
--Ovo znaci da mi da redove gdje prezime ispitanika pocinje sa slovom S

SELECT *
FROM EmployeeDemographics
WHERE Lastname LIKE '%S%'
--Medjutim, sad imamo naredbu da mi prikaze redove ispitanika cije prezime u sebi ima slovo S
--Mogu razne uslovi da budu npr:
-- 'S%o%', da prezome pocinje sa S i negdje u sebi ima o
-- Like se moze koristiti i za numericke podatke

SELECT *
FROM EmployeeDemographics
WHERE Firstname is NULL
--Trazimo red dje nema prezimena
--Kako takvog reda nema dobicemo praznu tabelu

SELECT *
FROM EmployeeDemographics
WHERE Firstname is NOT NULL
--Sada trazimo redove dje je celija sa prezimenom popunjena
--Sto znaci da cemo dobiti cijelu tabelu

SELECT *
FROM EmployeeDemographics
WHERE Firstname = 'Jim' OR Firstname = 'Pam'
--And nece readiti jer bi to znacilo da ime bude istovremeno jednako i jim i pam sto je nemoguce
--Tako da ce posluziti Or, medjutim postoji i laksi nacin

SELECT *
FROM EmployeeDemographics
WHERE Firstname IN ('Jim','Pam')
-- In naredba se koristi slicno kao i naredba jednako