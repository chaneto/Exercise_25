CREATE DATABASE personal;

CREATE TABLE employees(
id serial PRIMARY KEY,
name VARCHAR(100) NOT NULL,
manager_id INT,
salary DECIMAL(19,2) NOT NULL DEFAULT 0,
team_id INT);

INSERT INTO employees (name, manager_id, salary, team_id)
VALUES
       ( 'Michael', NULL, 8000, NULL),
       ( 'George', 1, 6000, 1),
       ( 'Greg', 1, 5000, 1),
       ( 'Peter', 2 , 2000, 2),
       ( 'John', 2, 3500, 3),
       ( 'Hans', 2, 3000, 2),
       ( 'Jack', 2, 3000, 4),
       ( 'Hugh', 3, 1500, 5);


/*Query_1*/
SELECT *
FROM employees
WHERE manager_id IS NULL;	

/*Query_2*/
SELECT E.name, (SELECT name FROM employees WHERE id = E.manager_id) AS manager_name
FROM employees AS E
WHERE E.manager_id IS NOT NULL;

/* Query_3*/
SELECT E.*
FROM employees AS E
WHERE E.id NOT IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL)
ORDER BY E.salary DESC LIMIT 1 OFFSET 1;

/* Query_4 */
SELECT E.*
FROM employees AS E
where E.manager_id IS NOT  NULL
ORDER BY E.salary DESC LIMIT 1 OFFSET 1;

/* Query_5 */
SELECT sum(E.salary) AS salary_sum
FROM employees AS E
WHERE E.id NOT IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL);


/* Query_6 */
SELECT sum(E.salary) AS salary_sum
FROM employees AS E
WHERE E.id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) AND E.manager_id IS NOT NULL;

/* Query_7 */
SELECT E.team_id , (SELECT COUNT(id) FROM employees WHERE E.id =team_id) AS count
FROM employees AS E
WHERE E.salary > 2500;

/* Query_8 */
CREATE TYPE archived AS ENUM ('0', '1');
ALTER TABLE employees 
ADD archived archived default '0' NOT NULL ;

/* Query_9 */
CREATE TABLE company(
id serial PRIMARY KEY,
name VARCHAR(100) NOT NULL);

ALTER TABLE employees
ADD company_id INT,
ADD CONSTRAINT fk_employees_company
FOREIGN KEY (company_id)
REFERENCES company(id);

/* Query_10 */
UPDATE employees SET salary = salary + '200'
WHERE manager_id = 1;


/* Query_11 */
DELETE FROM employees
WHERE id IN (SELECT id FROM (SELECT E.id FROM employees AS E WHERE E.manager_id = 3) AS D);
DELETE from employees
WHERE id = 3;

/* Query_12 */
ALTER TABLE employees
DROP CONSTRAINT fk_employees_company;
ALTER TABLE employees
DROP COLUMN company_id;
DROP tABLE company;






	   
	   
