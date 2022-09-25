-- find the highest salary earner 
SELECT * FROM employees
ORDER BY Salary Desc
Limit 1

-- find the lowest salary earner
SELECT * FROM employees
ORDER BY Salary ASC
Limit 1

-- list out all workers in IT
SELECT * 
FROM employees
WHERE Department IN ('IT')

-- what is the total number of workers in Bauchi state
SELECT COUNT(*)
FROM employees
WHERE State = 'Bauchi'

SELECT State, COUNT(State)
FROM employees
group by 1

-- count the numbers of every employees in each state

SELECT State, COUNT(State)
FROM employees
group by 1

-- which state has workers shortage 

SELECT State, COUNT(State)
FROM employees
GROUP BY 1
ORDER BY 2
limit 1


-- when was the last hiring d

SELECT MAX(HireDate)
FROM employees

-- what was the total salary and bonus paid to every department
SELECT Department,SUM(Salary),SUM(Bonus)
FROM employees
GROUP BY 1

-- get the total income by adding salary and bonus
SELECT Department, (Salary + Bonus) AS TotalIncome
FROM employees

-- calculate the bonus percentage

SELECT as BonusPercentage
FROM employees

-- get the list of all employees that earns above 5million

SELECT * 
FROM employees
WHERE Salary > 5000000

-- how many employees in Lagos state earn more than 5million
SELECT COUNT(*) 
FROM employees
WHERE Salary > 5000000
AND State = 'Lagos'

-- get the workers in IT Department and in Lagos state that earn below 5 million

SELECT *
FROM employees
WHERE State = 'Lagos' 
AND Department = 'IT'

-- get the list of employees that joined the company in 1998

SELECT *
FROM employees
WHERE EXTRACT(YEAR from HireDate) = '1998'

-- get the highest and the lowest salary paid in all state
SELECT
State, MAX(Salary) AS Highest , MIN(Salary) AS Lowest
FROM employees
Group by 1

-- create a new column as Company, then insert JulieChan.AG in all rows 

ALTER TABLE employees
ADD Company varchar(20)

UPDATE employees
SET Company = 'Juliechan.com'


-- how many male and female workers do we have?

6SELECT
Gender, COUNT(Gender)
FROM employees
GROUP BY 1

-- create a new column showing employee status. all employees below 61 as active while those above 60 as retired
 
 SELECT Age,
 CASE
 WHEN Age < 61 THEN 'Active Worker'
 ELSE 'Retired'
 END AS EmployeeStatus
 FROM employees



 -- How many countries 
 SELECT COUNT(DISTINCT Nationality) FROM employees

-- list all the the unique countries 

SELECT Nationality, COUNT(Nationality)
 FROM employees
 GROUP BY 1

-- women conference is taking place next week and we need to reach out to all female workers
-- get all female workers phone number
SELECT PhoneNumber
FROM workers
WHERE Gender = 'Female'