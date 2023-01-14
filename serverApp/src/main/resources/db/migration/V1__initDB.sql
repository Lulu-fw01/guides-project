-- we don't know how to generate root <with-no-name> (class Root) :(

create type user_role as enum ('user', 'administrator', 'moderator');

alter type user_role owner to postgres;

create type report_reason as enum ('spam', 'violence', 'fraud');

alter type report_reason owner to postgres;

create type report_status as enum ('opened', 'rejected', 'resolved');

alter type report_status owner to postgres;

create table users
(
    email      text                      not null
        primary key,
    name       varchar(32)
        constraint username_check
            check (char_length((name)::text) >= 2),
    login      varchar(20)               not null
        unique
        constraint login_check
            check (char_length((login)::text) >= 2),
    password   text                      not null,
    birthday   date,
    role       varchar(20) default 'user'::user_role,
    is_blocked boolean     default false not null
);

alter table users
    owner to postgres;

create table guides
(
    id            bigserial
        primary key,
    creator_email text                  not null
        references users,
    title         varchar(50)           not null
        constraint title_check
            check (char_length((title)::text) >= 1),
    file_bytes    bytea                 not null,
    edit_date     timestamp,
    is_blocked    boolean default false not null
);

alter table guides
    owner to postgres;

create table categories
(
    category_name varchar(16) not null
        primary key
        constraint category_check
            check (char_length((category_name)::text) >= 2)
);

alter table categories
    owner to postgres;

create table tags
(
    guide_id      bigint not null
        references guides,
    category_name text   not null
        references categories,
    primary key (guide_id, category_name)
);

alter table tags
    owner to postgres;

create table interactions
(
    user_email text   not null
        references users,
    guide_id   bigint not null
        references guides,
    users_mark integer,
    view_date  timestamp,
    primary key (user_email, guide_id)
);

alter table interactions
    owner to postgres;

create table comments
(
    id         bigserial
        primary key,
    user_email text         not null
        references users,
    guide_id   bigint       not null
        references guides,
    edit_date  timestamp,
    content    varchar(256) not null
        constraint content_check
            check (char_length((content)::text) >= 1)
);

alter table comments
    owner to postgres;

create table favourites
(
    guide_id   bigint not null
        references guides,
    user_email text   not null
        references users,
    primary key (guide_id, user_email)
);

alter table favourites
    owner to postgres;

create table subscriptions
(
    user_email              text not null
        references users,
    subscription_user_email text not null
        references users,
    primary key (user_email, subscription_user_email)
);

alter table subscriptions
    owner to postgres;

create table user_reports
(
    id             bigserial
        primary key,
    reporter_email text                                          not null
        references users,
    violator_email text                                          not null
        references users,
    comment        varchar(256)
        constraint user_report_comment_check
            check (char_length((comment)::text) >= 1),
    category       report_reason                                 not null,
    status         report_status default 'opened'::report_status not null
);

alter table user_reports
    owner to postgres;

create table guide_reports
(
    id             bigserial
        primary key,
    reporter_email text                                          not null
        references users,
    guide_id       bigint                                        not null
        references guides,
    comment        varchar(256)
        constraint guide_report_comment_check
            check (char_length((comment)::text) >= 1),
    category       report_reason                                 not null,
    status         report_status default 'opened'::report_status not null
);

alter table guide_reports
    owner to postgres;
