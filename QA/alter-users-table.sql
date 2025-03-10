--liquibase formatted sql

-- changeset benriley:002-add-columns
ALTER TABLE users ADD COLUMN phone VARCHAR(20);
ALTER TABLE users ADD COLUMN role VARCHAR(50) DEFAULT 'user';

--rollback ALTER TABLE users DROP COLUMN phone;
--rollback ALTER TABLE users DROP COLUMN role;
