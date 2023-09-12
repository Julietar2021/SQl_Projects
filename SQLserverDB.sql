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


