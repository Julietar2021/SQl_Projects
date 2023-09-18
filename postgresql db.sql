-- create a superuser jegbule and also a demouser with ony login access.
	CREATE ROLE jegbule WITH
	LOGIN
	PASSWORD 'enterpassword'
	SUPERUSER
	CREATEROLE
	CREATEDB
	INHERIT
	CONNECTION LIMIT -1
	REPLICATION;

-- CREATE A USER CALL DEMOUSER AND GRANT ONLY LOGIN PRIVILEGE
	CREATE ROLE demouser WITH LOGIN PASSWORD 'password2468';

-- CREATE ANOTHER SCHEMA UNDER dvdrental DATABASE.
	CREATE SCHEMA cd
    AUTHORIZATION jegbule;
-- CREATE TWO TABLES IN CD SCHEMA. you can copy two tables from public schema to new cd schema
	CREATE TABLE cd.films AS
	SELECT * FROM public.film;

	CREATE TABLE cd.actor AS
	SELECT * FROM public.actor;
	
--CREATE DATABASE dvdrental AND RESTORE DVDRENTAL DATABASE.jegbule as DB owner
	CREATE DATABASE dvdrenta OWNER jegbule;
	
-- Rename the database dvdrenta to dvdrental 
	ALTER DATABASE dvdrenta RENAME TO dvdrental;
	
-- GRANT & REVOKE DEMOUSER ACCESS TO A DATABASE
	GRANT  CONNECT ON DATABASE dvdrental TO demouser;
	REVOKE CONNECT ON DATABASE dvdrental FROM demouser;

-- ALTER USER ACCOUNT To BE ABLE TO CREATE A DB
	ALTER ROLE demouser CREATEDB;

-- Remove demouser createdb role
	ALTER ROLE demouser NOCREATEDB;

-- DROP THE SCHEMA cd
	DROP SCHEMA IF EXISTS cd;

-- to impersonate a user or group's role
	SET ROLE demouser;
	
	SET ROLE jegbule;
	
-- to reset role
	RESET ROLE
	
-- grant demouser read only on all tables in cd schema
	GRANT USAGE ON SCHEMA cd TO demouser;
	GRANT SELECT ON ALL TABLES IN SCHEMA cd TO demouser;

--Revoke demouser select access on all tables in cd schema.
	RESET ROLE
	REVOKE SELECT ON ALL TABLES IN SCHEMA cd FROM demouser;
	REVOKE USAGE ON SCHEMA cd FROM demouser;
		
-- grant demouser update and delete control all tables in cd schema
	GRANT USAGE ON SCHEMA cd TO demouser;
	GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA cd TO demouser;
	
	RESET ROLE
	SET ROLE demouser;
	

-- user demouser to insert into cd.actor's table
	INSERT INTO cd.actor values (203,'Juliet','Jackson',current_timestamp),(204,'Marc','Mitchels',current_timestamp)

-- select the table to confirm if the table was updated by demouser
	SELECT * FROM cd.actor order by actor_id desc;

-- try to update as well for confirmation
	UPDATE cd.actor set last_update = CURRENT_TIMESTAMP
	WHERE actor_id in (201,202)


-- try to update on films' table as well for confirmation
	UPDATE cd.films set title = 'Legend of the seeker'
	WHERE film_id = 1000

-- select the table to confirm if the table was updated by demouser
	SELECT * FROM cd.films WHERE film_id = 100;

-- revoke demouser update and delete control all tables in cd schema
	RESET ROLE
	REVOKE INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA cd FROM demouser;
	REVOKE USAGE ON SCHEMA cd FROM  demouser;

--Grant demouser all privileges on all tables in cd schema
	RESET ROLE
	GRANT USAGE ON SCHEMA cd TO demouser;
	GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA cd TO demouser;
	SET ROLE demouser;

	INSERT INTO cd.actor 
	VALUES (203, 'Juliet','Egbule',CURRENT_TIMESTAMP)
	
	UPDATE cd.actor set first_name = 'Nwaka'
	WHERE actor_id = 203
	
	SELECT * FROM cd.actor order by actor_id desc;
	
	DELETE FROM cd.actor 
	WHERE actor_id = 203

--Revoke demouser all privileges on all tables in cd schema
	RESET ROLE
	REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA cd FROM demouser;
	REVOKE USAGE ON SCHEMA cd FROM demouser;
	SET ROLE demouser;


-- grant demouser read only access on cd.actor table only
	RESET ROLE
	GRANT SELECT ON TABLE cd.actor TO demouser;
	SET ROLE demouser;
-- select can be replaced with update or insert or all or delete or truncate
-- view list of roles in the database
select * from pg_roles

-- view list of users that has access to the server
select * from pg_user
where rolname = 'demouser'

-- check demousers roles
select * from information_schema.role_table_grants where grantee = 'demouser'

select grantee as Users, grantor AS Assignee, table_schema as schema,
table_catalog as table_name, privilege_type, is_grantable as roles_granted
from information_schema.role_table_grants where grantee = 'demouser'


-- kill a database pid to be able to drop a database
-- view a database pid
SELECT * FROM pg_stat_activity
WHERE datname = 'dvdrenta'


-- create a store procedure to update cd.workers table

CREATE PROCEDURE update_data(integer, varchar(200), TIMESTAMP)
LANGUAGE'plpgsql'
AS $$
BEGIN
INSERT INTO cd.workers values($1,$2,$3);
COMMIT;
END
$$;

CALL update_data(6,'Gifto Samson',CURRENT_DATE)

-- retrive all data for confirmation
SELECT * FROM cd.workers;

-- add new column as company name and set juliechan as the default company name
ALTER TABLE cd.workers
ADD CompanyName VARCHAR(200) DEFAULT 'JulieChan'

-- update the update_data procedure in order to add the new column.
CREATE OR REPLACE PROCEDURE insert_data(integer, varchar(200), timestamp, varchar(200))
LANGUAGE'plpgsql'
AS $$
BEGIN
INSERT INTO cd.workers values($1,$2,$3,$4);
COMMIT;
END
$$;

-- add new employee details to the cd.worker tables

CALL update_data (6,'Jobe Ben',current_date)

-- retrive all data for confirmation
SELECT * FROM cd.workers;


-- kill a database pid to be able to drop a database
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE pid IN  (12648 , 21324)





