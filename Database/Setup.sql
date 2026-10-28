USE master;
GO
IF DB_ID(N'PlacementPractical9') IS NULL
    CREATE DATABASE PlacementPractical9;
GO
USE PlacementPractical9;
GO
IF OBJECT_ID(N'dbo.Students', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Students (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Enrollment NVARCHAR(12) NOT NULL UNIQUE,
        StudentName NVARCHAR(80) NOT NULL,
        Department NVARCHAR(10) NOT NULL,
        Email NVARCHAR(100) NOT NULL,
        Company NVARCHAR(80) NULL,
        PackageLpa DECIMAL(6,2) NULL,
        Status NVARCHAR(10) NOT NULL,
        CONSTRAINT CK_Placement CHECK (
            (Status='Placed' AND Company IS NOT NULL AND
             PackageLpa IS NOT NULL AND PackageLpa>0) OR
            (Status='Pending' AND Company IS NULL AND PackageLpa IS NULL))
    );
    -- Fictional sample records for the lab demonstration.
    INSERT INTO dbo.Students
        (Enrollment,StudentName,Department,Email,Company,PackageLpa,Status)
    VALUES
    ('92400103460','Ayush Sharma','CE','ayush@example.com','TCS',7.00,'Placed'),
    ('92400103461','Ankit Patel','IT','ankit@example.com','Infosys',6.50,'Placed'),
    ('92400103462','Riya Shah','CE','riya@example.com','Accenture',12.50,'Placed'),
    ('92400103463','Rahul Mehta','EC','rahul@example.com',NULL,NULL,'Pending'),
    ('92400103464','Neha Joshi','IT','neha@example.com','Wipro',5.50,'Placed'),
    ('92400103465','Aman Verma','CE','aman@example.com',NULL,NULL,'Pending'),
    ('92400103466','Priya Desai','EC','priya@example.com','TCS',7.00,'Placed'),
    ('92400103467','Karan Shah','IT','karan@example.com','Accenture',10.00,'Placed'),
    ('92400103468','Sneha Patel','CE','sneha@example.com','Infosys',6.50,'Placed'),
    ('92400103469','Dev Shah','EC','dev@example.com','Wipro',5.50,'Placed'),
    ('92400103470','Isha Mehta','IT','isha@example.com',NULL,NULL,'Pending'),
    ('92400103471','Jay Patel','CE','jay@example.com',NULL,NULL,'Pending');
END;
GO
