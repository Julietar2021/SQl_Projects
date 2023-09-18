--SQL SERVER DATA SECURITY AND CONTROL

-- grant read only access to all schemas in Employees database
GRANT SELECT ON DATABASE :: Employees TO demouser;

-- Revoke read only access to all schemas in Employees database
REVOKE SELECT ON DATABASE :: Employees TO demouser;
-- select can be replaced with insert, update or delete 

-- Grant demouser read only access on a scehma know as cd
GRANT SELECT ON SCHEMA :: cd TO demouser;

-- REVOKE demouser read only access on a scehma know as cd
REVOKE SELECT ON SCHEMA :: cd TO demouser;

-- Grant demouser insert permsission to be able to add new role
GRANT INSERT ON SCHEMA :: cd TO demouser;

-- revoke the insert permission
REVOKE INSERT ON SCHEMA :: cd TO demouser;

-- Grant a user read only access on cd.work table only
GRANT SELECT ON cd.work TO demouser;

-- removea user read only access on cd.work table only
REVOKE SELECT ON cd.work TO demouser;

USE  AdventureWorks2019
GO

--create a login for jegbule
CREATE LOGIN jegbule WITH  PASSWORD='root' MUST_CHANGE, CHECK_EXPIRATION=ON

-- try to login with jegbule by creating a new connection

-- creata user jegbule under adventureworks database for the login to have access
CREATE USER jegbule FOR LOGIN jegbule
-- grant jegbule read only access in all tables in adventure db

ALTER ROLE db_datareader ADD MEMBER jegbule

-- remove the role 
ALTER ROLE db_datareader DROP MEMBER jegbule

DROP LOGIN jegbule

-- kill the user session_id if it cant be drop

SELECT session_id
from sys.dm_exec_sessions
WHERE login_name = 'jegbule'

kill 61
KILL 66

DROP LOGIN jegbule

