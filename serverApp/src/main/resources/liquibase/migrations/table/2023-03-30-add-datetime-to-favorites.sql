--liquibase formatted sql

--changeset Luka:favorites-add-column-add-datetime
--preconditions onFail:HALT onError:HALT
alter table public.favorites
add column add_date_time timestamp default now();