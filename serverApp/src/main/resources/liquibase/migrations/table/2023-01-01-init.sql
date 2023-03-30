--liquibase formatted sql

--changeset Luka:users
create table if not exists public.users
(
    email      text                      not null
        primary key,
    login      varchar(20)               not null
        unique
        constraint login_check
            check (char_length((login)::text) >= 2),
    password   text                      not null,
    birthday   date,
    role       varchar(20) default 'USER'::character varying,
    is_blocked boolean     default false not null
);

alter table public.users
    owner to postgres;

--changeset Luka:guides-title_length_update
create table if not exists public.guides
(
    id            bigserial
        primary key,
    creator_email text                  not null
        references public.users,
    title         varchar(84)           not null
        constraint title_check
            check (char_length((title)::text) >= 1),
    file_bytes    text                  not null,
    edit_date     timestamp,
    is_blocked    boolean default false not null
);

alter table public.guides
    owner to postgres;

--changeset Luka:categories
create table if not exists public.categories
(
    category_name varchar(16) not null
        primary key
        constraint category_check
            check (char_length((category_name)::text) >= 2)
);

alter table public.categories
    owner to postgres;

--changeset Luka:tags
create table if not exists public.tags
(
    guide_id      bigint not null
        references public.guides,
    category_name text   not null
        references public.categories,
    primary key (guide_id, category_name)
);

alter table public.tags
    owner to postgres;

--changeset Luka:interactions
create table if not exists public.interactions
(
    user_email text   not null
        references public.users,
    guide_id   bigint not null
        references public.guides,
    users_mark integer,
    view_date  timestamp,
    primary key (user_email, guide_id)
);

alter table public.interactions
    owner to postgres;

--changeset Luka:comments
create table if not exists public.comments
(
    id         bigserial
        primary key,
    user_email text         not null
        references public.users,
    guide_id   bigint       not null
        references public.guides,
    edit_date  timestamp,
    content    varchar(256) not null
        constraint content_check
            check (char_length((content)::text) >= 1)
);

alter table public.comments
    owner to postgres;

--changeset Luka:favorites
create table if not exists public.favorites
(
    guide_id   bigint not null
        references public.guides,
    user_email text   not null
        references public.users,
    primary key (guide_id, user_email)
);

alter table public.favorites
    owner to postgres;

--changeset Luka:subscriptions
create table if not exists public.subscriptions
(
    user_email              text not null
        references public.users,
    subscription_user_email text not null
        references public.users,
    primary key (user_email, subscription_user_email)
);

alter table public.subscriptions
    owner to postgres;

--changeset Luka:user_reports
create table if not exists public.user_reports
(
    id             bigserial
        primary key,
    reporter_email text                                            not null
        references public.users,
    violator_email text                                            not null
        references public.users,
    comment        varchar(256)
        constraint user_report_comment_check
            check (char_length((comment)::text) >= 1),
    category       varchar(20)                                     not null,
    status         varchar(20) default 'OPENED'::character varying not null
);


alter table public.user_reports
    owner to postgres;

--changeset Luka:guide_reports
create table if not exists public.guide_reports
(
    id             bigserial
        primary key,
    reporter_email text                                            not null
        references public.users,
    guide_id       bigint                                          not null
        references public.guides,
    comment        varchar(256)
        constraint guide_report_comment_check
            check (char_length((comment)::text) >= 1),
    category       varchar(20)                                     not null,
    status         varchar(20) default 'OPENED'::character varying not null
);

alter table public.guide_reports
    owner to postgres;

--changeset Luka:users_table_comment_2
COMMENT ON TABLE public.users IS 'Пользователи';
