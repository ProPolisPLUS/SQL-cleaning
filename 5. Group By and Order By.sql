-- Group By, Order By


SELECT DISTINCT(Gender)
FROM EmployeeDemographics
-- Dobijamo dvije vrste odgovora

SELECT Gender
FROM EmployeeDemographics
GROUP BY Gender
--Sada trazimo kolonu gender ali gupisemo odgovore
--Dobicemo dva odgovora ali u oba reda(Odgovori) imamo sve ljude koji su dali jedan od odgovora
--Sto se moze primjetiti iz sledece naredbe

SELECT Gender, COUNT(Gender)
FROM EmployeeDemographics
GROUP BY Gender
--Dobijamo Broj ljudi koji su dali koji odgovor, Sto kod DISTINCT funkcije ne mozemo


--Tako na primjer mozemo da filtriramo podatke
--Zekuni da vidmo koliko ima muskaraca i zena starijih od 31 godinu
SELECT Gender, COUNT(Gender)
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender

SELECT Gender, COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY CountGender ASC
--ORDER BY naredba se u ovom slucaju koristi za sortiranje
--Po deafult-u je od najmanje ka najvecoj vrijednosti, ASCENDING (ASC)
--Tako da iako maknemo ASC na isti nacin ce sortirati novu kolonu
--Ako zelimo sortirati vrijednosti u suprotnom smjeru, koristicemo funkciju DESCENDING(DESC)
--Sto se moze vidjeti u sledecoj narebi

SELECT Gender, COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY CountGender DESC
--Sada imamo sortiranje oda najvece ka najmanjoj vrijednosti
  

--Hajde sada da probamo isto ali na kolonu sa godinama
SELECT *
FROM EmployeeDemographics
ORDER BY Age ASC
--Ici ce od namanje ka najcevoj vrijednosti

SELECT *
FROM EmployeeDemographics
ORDER BY Age DESC
--Sada ce ici od najvece ka najmanjoj

--Mozemo ORDER BY funkciju da koristimo i za sortiranje vise kolona
SELECT *
FROM EmployeeDemographics
ORDER BY Age, Gender 
--Sada su nam prioritet godine, od najmladje do nasttarije osobe i ako moze da se uklopi gender prvo zensko pa musko

SELECT *
FROM EmployeeDemographics
ORDER BY Age DESC, Gender DESC
--Moze i obratno

--Takodje umjesto imena kolona mozemo koristiti brojeve
SELECT *
FROM EmployeeDemographics
ORDER BY 4 DESC, 5 DESC