/*
Triggers
*/

/*
After Trigger
INSERTED
	1) Newly Inserted Record
	2) Aftre Update With New value Records 
DELETED
	1) Deleted Records 
	2) Before Update With old Value
*/

CREATE TABLE EmployeeMain_Audit
(
AuditID INT IDENTITY(1,1),
EMPID INT,
EMPName VARCHAR(100),
Salary MONEY,
AuditType VARCHAR(100),
AuditActionDate DATETIME
)

SELECT * FROM [dbo].[Employee_Main]

CREATE TRIGGER TrAfterInsertEmployeeMain
ON dbo.Employee_Main
AFTER INSERT
AS
BEGIN
INSERT INTO EmployeeMain_Audit(EMPID,EMPName,Salary,AuditType,AuditActionDate)
SELECT I.EMPID,I.EMPName,I.Salary,'AFTER INSERT',GETDATE()
FROM inserted I
END

SELECT * FROM [dbo].[Employee_Main]
SELECT * FROM EmployeeMain_Audit

INSERT INTO [Employee_Main]([EMPID], [EMPName], [Salary], [InsertedDate], [UPdatedDate])
VALUES(8,'Abhidunnisha',64800,GETDATE(),NULL)


ALTER TRIGGER TrAfterInsertEmployeeMain
ON dbo.Employee_Main
AFTER INSERT,UPDATE
AS
BEGIN
INSERT INTO EmployeeMain_Audit(EMPID,EMPName,Salary,AuditType,AuditActionDate)
SELECT I.EMPID,I.EMPName,I.Salary,'AFTER INSERT',GETDATE()
FROM inserted I
LEFT JOIN [Employee_Main] M ON I.EMPID=M.EMPID
WHERE M.EMPID IS NULL
UNION ALL
SELECT I.EMPID,I.EMPName,I.Salary,'AFTER UPDATE',GETDATE()
FROM inserted I
INNER JOIN [Employee_Main] M ON I.EMPID=M.EMPID
END

INSERT INTO [Employee_Main]([EMPID], [EMPName], [Salary], [InsertedDate], [UPdatedDate])
VALUES(9,'Nani',65800,GETDATE(),NULL)

UPDATE [Employee_Main]
SET Salary='64500'
WHERE EMPID=2

SELECT * FROM [dbo].[Employee_Main]
SELECT * FROM EmployeeMain_Audit

ALTER TRIGGER TrAfterInsertEmployeeMain
ON dbo.Employee_Main
AFTER INSERT,UPDATE,DELETE
AS
BEGIN
INSERT INTO EmployeeMain_Audit(EMPID,EMPName,Salary,AuditType,AuditActionDate)
SELECT I.EMPID,I.EMPName,I.Salary,'AFTER INSERT',GETDATE()
FROM inserted I
LEFT JOIN [Employee_Main] M ON I.EMPID=M.EMPID
WHERE M.EMPID IS NULL
UNION ALL
SELECT I.EMPID,I.EMPName,I.Salary,'AFTER UPDATE',GETDATE()
FROM inserted I
INNER JOIN [Employee_Main] M ON I.EMPID=M.EMPID
UNION ALL
SELECT D.EMPID,D.EMPName,D.Salary,'AFTER DELETE',GETDATE()
FROM deleted D
END

DELETE FROM [Employee_Main]
WHERE EMPID=2


SELECT * FROM [dbo].[Employee_Main]
SELECT * FROM EmployeeMain_Audit

/*
Instead Of Triggers
*/


CREATE TABLE tblEmployee 
(  
 Id int Primary Key,  
 Name nvarchar(30),  
 Gender nvarchar(10),  
 DepartmentId int  
) 
CREATE TABLE tblDepartment
(  
 DeptId int Primary Key,  
 DeptName nvarchar(20)  
) 

Insert into tblDepartment values (1,'Blog')  
Insert into tblDepartment values (2,'Article')  
Insert into tblDepartment values (3,'Resource')  
Insert into tblDepartment values (4,'Book') 
Insert into tblEmployee values (1,'Satya1', 'Male', 3)  
Insert into tblEmployee values (2,'Satya2', 'Male', 2)  
Insert into tblEmployee values (3,'Satya3', 'Female', 1)  
Insert into tblEmployee values (4,'Satya4', 'Male', 4)  
Insert into tblEmployee values (5,'Satya5', 'Female', 1)  
Insert into tblEmployee values (6,'Satya6', 'Male', 3) 


SELECT * FROM tblDepartment
SELECT * FROM tblEmployee

Create view VwEmployeeDetails  
as  
Select Id, Name, Gender, DeptName  
from tblEmployee 
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId 


SELECT * FROM tblDepartment
SELECT * FROM tblEmployee
SELECT * FROM VwEmployeeDetails


6	Kiran	Male	IT

On View DML

CREATE TRIGGER Tr_InsteaOfTriggerOfVwEmployeeDetails
ON VwEmployeeDetails
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @DeptID INT
	SELECT @DeptID=D.Deptid
	FROM inserted I
	JOIN tblDepartment D ON I.DeptName=D.DeptName
	IF (@DeptID IS NULL)
	BEGIN
		RAISERROR('Departemtn Name Is Not Valid',16,1)
		RETURN
	END
	ELSE
	BEGIN
		INSERT INTO tblEmployee(ID,Name,Gender,DepartmentID)
		SELECT Id, Name, Gender,@DeptID
		FROM inserted
	END
END


INSERT INTO VwEmployeeDetails(Id
,Name
,Gender
,DeptName)
VALUES(6,'Kiran','Male','IT')


ALTER TRIGGER Tr_InsteaOfTriggerOfVwEmployeeDetails
ON VwEmployeeDetails
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @DeptID INT,@DeptName VARCHAR(100)
	SELECT @DeptID=D.Deptid,@DeptName=I.DeptName
	FROM inserted I
	LEFT JOIN tblDepartment D ON I.DeptName=D.DeptName
	IF (@DeptID IS NULL)
	BEGIN
		DECLARE @MaxDeptID INT
		SELECT @MaxDeptID=MAX(DeptId)+1 FROM tblDepartment
		INSERT INTO tblDepartment(DeptId,DeptName)
		VALUES(@MaxDeptID,@DeptName)
		INSERT INTO tblEmployee(ID,Name,Gender,DepartmentID)
		SELECT Id, Name, Gender,@MaxDeptID
		FROM inserted

		PRINT 'New Deprtment Is Inserted and ID Produced'
	END
	ELSE
	BEGIN
		INSERT INTO tblEmployee(ID,Name,Gender,DepartmentID)
		SELECT Id, Name, Gender,@DeptID
		FROM inserted
	END
END

SELECT * FROM tblDepartment
SELECT * FROM tblEmployee
SELECT * FROM VwEmployeeDetails
INSERT INTO VwEmployeeDetails(Id
,Name
,Gender
,DeptName)
VALUES(8,'Nani','Male','Sales')


CREATE TRIGGER Tr_InstedOfUpdate_VwEmployeeDetails
ON VwEmployeeDetails
INSTEAD OF UPDATE
AS
BEGIN
DECLARE @ID INT,@Name VARCHAR(100),@Gender VARCHAR(10)

SELECT @ID=ID,@Name=Name,@Gender=Gender
FROM inserted 

IF UPDATE(ID)
BEGIN
	RAISERROR('Employee ID Can not be Updated',16,1)
	ROLLBACK
END
IF UPDATE(Gender)
BEGIN
	RAISERROR('Gender Can not be Updated',16,1)
	ROLLBACK
END
END

SELECT * FROM VwEmployeeDetails


UPDATE VwEmployeeDetails
SET Gender='FeMale'
WHERE ID=3


UPDATE VwEmployeeDetails
SET Name ='Ravindra'
WHERE ID=3
