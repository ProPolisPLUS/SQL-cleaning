-- CTEs
--CTE naredba sluzi za kompresiju koda i za lakse manipulisanje istim
--Ne cuva se u bazi podataka i koristi se u jednoj radnoj sestiji da olaksa rad

WITH CTE_Employee AS
(SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender,
AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM [SQL Tutorijal].dbo.EmployeeDemographics AS demo
JOIN [SQL Tutorijal].dbo.EmployeeSalary as sal
	ON demo.EmployeeID = sal.EmployeedID
WHERE Salary > '45000'
)

SELECT *
FROM CTE_Employee
