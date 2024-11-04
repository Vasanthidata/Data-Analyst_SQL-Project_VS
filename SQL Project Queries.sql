----SQL PROJECT  

-- Create the Employee table
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Emp_FName VARCHAR(50),
    Emp_LName VARCHAR(50),
    Emp_Sal DECIMAL(10, 2),
    Dept_ID INT,
    Emp_Addr1 VARCHAR(100),
    Emp_City VARCHAR(50),
    Emp_Zip VARCHAR(10)
);

-- Create the Department table
CREATE TABLE Emp_Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50),
    Dept_City VARCHAR(50)
);

-- Create the Employee_Details table
CREATE TABLE Employee_Details (
    Emp_ID INT,
    Location_ID INT,
    FOREIGN KEY (Emp_ID) REFERENCES Employee(Employee_ID)
);


-- Create the Location_Details table
CREATE TABLE Location_Details (
    Location_ID INT PRIMARY KEY,
    Zip_Code VARCHAR(10)
);

-- Insert sample data into the Employee table
INSERT INTO Employee (Employee_ID, Emp_FName, Emp_LName, Emp_Sal, Dept_ID, Emp_Addr1, Emp_City, Emp_Zip) VALUES
(1, 'John', 'Doe', 12000.00, 1, '123 Elm St', 'Brentwood', '88160'),
(2, 'Jane', 'Smith', 8000.00, 1, '456 Oak St', 'Brentwood', '88160'),
(3, 'Jim', 'Brown', 9500.00, 2, '789 Pine St', 'Nashville', '37201'),
(4, 'Jake', 'White', 11000.00, 2, '321 Maple St', 'Brentwood', '88160'),
(5, 'Jill', 'Green', 5000.00, 3, '654 Cedar St', 'Brentwood', '88160');


-- Insert sample data into the Emp_Department table
INSERT INTO Emp_Department (Dept_ID, Dept_Name, Dept_City) VALUES
(1, 'HR&Training and Compliance', 'Brentwood'),
(2, 'Sales', 'Nashville'),
(3, 'IT', 'Brentwood');

-- Insert sample data into the Employee_Details table
INSERT INTO Employee_Details (Emp_ID, Location_ID) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 1),
(5, 1);

-- Insert sample data into the Location_Details table
INSERT INTO Location_Details (Location_ID, Zip_Code) VALUES
(1, '88160'),
(2, '37201');

------Select top 10 records from Employee table where Emp_Sal > 10000
SELECT Top 10 *
  FROM Employee
  WHERE Emp_Sal > 10000
  ORDER BY Emp_Sal DESC;

------Retrieve Emp_Id, Emp_FName, Emp_Addr1, Emp_City, Emp_Zip, Dept_Name, Dept_City From Employee whose Department City is Brentwood. Use Table Alias      
SELECT E.Employee_ID, E.Emp_FName, E.Emp_Addr1, E.Emp_City, E.Emp_Zip, D.Dept_Name, D.Dept_City
       FROM Employee E
       JOIN Emp_Department D ON E.Dept_ID = D.Dept_ID
       WHERE D.Dept_City = 'Brentwood';

------Retrieve Emp_ID, Emp_Fname, Emp_Zip from Employee who are all working in department HR&Training and Compliance. Use embedded SQL statements
SELECT Employee_ID, Emp_Fname, Emp_Zip
       FROM Employee
       WHERE Dept_ID IN
      (SELECT Dept_ID
       FROM Emp_Department
       WHERE Dept_name = 'HR&Training and Compliance');

------Retrieve Sum(Emp_Sal) and Dept_Name From Employee and Emp_Department by Dept_Name (Group By)
SELECT D.Dept_Name, SUM(E.Emp_Sal) 
       FROM Employee E
       JOIN Emp_Department D ON E.Dept_ID = D.Dept_ID
       GROUP BY D.Dept_Name;

-------Select 2nd highest sal from Employee table
SELECT MAX(Emp_sal) AS second_highest_sal
       FROM Employee
       WHERE Emp_sal < (SELECT MAX(Emp_sal) FROM Employee); 

-----Retrieve Emp_Id, Emp_FName, Emp_LName for location Zip_Code 88160 (use all three Employee tables) Use Embedded sql statements
SELECT Employee_Id, Emp_FName, Emp_LName
       FROM Employee
       WHERE Employee_Id IN
      (SELECT Emp_Id 
       FROM Employee_Details
       WHERE Location_ID IN
      (SELECT Location_ID
       FROM Location_Details
       WHERE Zip_Code = '88160'));   
	   
------Write a query using Right Outer join to retrieve the data from Employee and Emp_Department table
SELECT *
      FROM Employee
      RIGHT OUTER JOIN Emp_Department
      ON Employee.Dept_ID = Emp_Department.Dept_ID;


------Write a query using Full Outer join to retrieve the data from Employee and Emp_Department tables
SELECT *
     FROM Employee
     FULL OUTER JOIN Emp_Department
     ON Employee.Dept_ID = Emp_Department.Dept_ID;


-------Create Person table and data
------Create the Person table
CREATE TABLE Person (
    Person_ID INT PRIMARY KEY,
    Person_Name VARCHAR(50),
    Age INT,
    Gender VARCHAR(10)
);

-----Insert sample data into the Person table
INSERT INTO Person (Person_ID, Person_Name, Age, Gender) VALUES
(1, 'Alice', 30, 'Female'),
(2, 'Bob', 25, 'Male'),
(3, 'Charlie', 35, 'Male');

----Rename a column Person_Name to P_Name in the table Person
EXEC sp_rename 'Person.Person_Name', 'P_Name', 'COLUMN';