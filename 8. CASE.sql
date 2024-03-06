--Case naredba
--Case naredba nam omogucava da u slucaju neceg izvrsimo nesto
--Na primjer zilimo radnicima iz razlicitih resora da damo povisicu

SELECT FirstName, LastName, Age, Gender, JobTitle, Salary,
CASE
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10) --Povecavamo platu za 10%
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05) --Povecavamo platu za 5%
	WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001) --Povecavamo platu za 000001%
	ELSE Salary + (Salary * .03) --Svim ostalim za 3%
END AS CalculatedSalaryRaise
FROM [SQL Tutorijal].dbo.FULLEmployeeDemographics
JOIN [SQL Tutorijal].dbo.FULLEmployeeSalary --JOIN Se moze koristiti umjersto Inner Join
	ON FULLEmployeeDemographics.EmployeeID = FULLEmployeeSalary.EmployeeID