-- Liquibase ChangeLog
-- Changes for dvdrental schema

-- ChangeSet to alter the users table
-- ChangeSet ID should be unique per change
-- Author: Ben Riley

-- Add a new column
--liquibase formatted sql
--changeset benriley:001
ALTER TABLE customers ADD COLUMN last_login TIMESTAMP;
--rollback ALTER TABLE dvdrental.users DROP COLUMN last_login;

-- Modify a column
--changeset benriley:002
ALTER TABLE customers ALTER COLUMN email TYPE VARCHAR(255);
--rollback ALTER TABLE dvdrental.users ALTER COLUMN email TYPE VARCHAR(100);