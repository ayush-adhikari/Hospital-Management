CREATE TABLE physician
(  
    employeeID int Primary Key,
    Name text NOT NULL,  
    position text,
    ssn int Unique,
    );