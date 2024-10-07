Use master
Go
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'CutNowDB')
BEGIN
    DROP DATABASE CutNowDB;
END
Go
Create Database CutNowDB
Go
Use CutNowDB
Go
Create Table AppUsers
(
	Id int Primary Key Identity,
	UserName nvarchar(50) Not Null,
	UserLastName nvarchar(50) Not Null,
	UserEmail nvarchar(50) Unique Not Null,
	UserPassword nvarchar(50) Not Null,
	IsManager bit Not Null Default 0
)
-- Create a login for the admin user
CREATE LOGIN [CutNowAdminLogin] WITH PASSWORD = 'thePassword';
Go

-- Create a user in the YourProjectNameDB database for the login
CREATE USER [CutNowAdminUser] FOR LOGIN [CutNowAdminLogin];
Go

-- Add the user to the db_owner role to grant admin privileges
ALTER ROLE db_owner ADD MEMBER [CutNowAdminUser];
Go
/*
scaffold-DbContext "Server = (localdb)\MSSQLLocalDB;Initial Catalog=CutNowDB;User ID=CutNowAdminLogin;Password=thePassword;" Microsoft.EntityFrameworkCore.SqlServer -OutPutDir Models -Context CutNowDbContext -DataAnnotations –force
*/