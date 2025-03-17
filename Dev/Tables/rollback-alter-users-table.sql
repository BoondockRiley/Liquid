--liquibase formatted sql

-- changeset benriley:002-add-columns-rollback
ALTER TABLE users DROP COLUMN phone;
ALTER TABLE users DROP COLUMN role;
