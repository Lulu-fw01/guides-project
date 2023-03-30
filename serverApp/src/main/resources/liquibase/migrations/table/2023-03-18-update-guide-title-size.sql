--liquibase formatted sql

--changeset Luka:guides-title_length_update
alter table public.guides alter column title type varchar(84)