--liquibase formatted sql

-- changeset benriley:002-add-columns-rollback
-- Rollback: Drop the `date_of_birth` column from customers table
ALTER TABLE customers
DROP COLUMN IF EXISTS date_of_birth;

-- Rollback: Drop the `country` column from addresses table
ALTER TABLE addresses
DROP COLUMN IF EXISTS country;

-- Rollback: Drop the `payment_method` column from rental_history table
ALTER TABLE rental_history
DROP COLUMN IF EXISTS payment_method;
