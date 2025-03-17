--liquibase formatted sql

--changeset Ben.Riley:2 labels:example-label context:example-context
--comment: Creating Tables for Demo
create table person (
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback DROP TABLE person;


--changeset Ben.Riley:3 labels:example-label context:example-context
--comment: Creating Tables for Demo
create table company (
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback DROP TABLE company;


--changeset Ben.Riley:4 labels:example-label context:example-context
--comment: Modifying column for Demo
alter table person add column country varchar(2)
--rollback ALTER TABLE person DROP COLUMN country;

