--liquibase formatted sql

-- changeset benriley:002-add-columns
-- Add a new column `date_of_birth` to the customers table
ALTER TABLE dvdrental.customers ADD COLUMN date_of_birth DATE;

-- Add a new column `country` to the addresses table
ALTER TABLE dvdrental.addresses ADD COLUMN country VARCHAR(50);

-- Add a new column `payment_method` to the rental_history table
ALTER TABLE dvdrental.rental_history ADD COLUMN payment_method VARCHAR(50);

--rollback ALTER TABLE users DROP COLUMN phone;
--rollback ALTER TABLE users DROP COLUMN role;
