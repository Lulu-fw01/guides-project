--liquibase formatted sql

--changeset goofyahh:drop1
--preconditions onFail:HALT onError:HALT
drop table "GUIDE_DB".public.favourites