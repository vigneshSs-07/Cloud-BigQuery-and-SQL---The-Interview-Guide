-- #Created database
use dummy;

-- Create table
CREATE TABLE Employe (name varchar(10), salary int);


-- Insert values into table
INSERT INTO Employe VALUES ('Rick', 3000); 
INSERT INTO Employe VALUES ('John', 4000); 
INSERT INTO Employe VALUES ('Shane', 3000);
INSERT INTO Employe VALUES ('Peter', 5000); 
INSERT INTO Employe VALUES ('Jackob', 7000);

-- Querey for finding nth highest salary
-- Using CTE 
with result as (
    select salary, DENSE_RANK() over(order by salary desc) as rownumber
    from Employe
)
select top 1 salary from result where rownumber = 3


-- replace 3 with other values in order to find that particular salary value in table.(n is 1,2,3.....) 