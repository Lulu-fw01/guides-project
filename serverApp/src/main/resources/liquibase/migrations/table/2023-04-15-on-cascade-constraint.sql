--liquibase formatted sql

--changeset goofyahh:oncascadedelete_favorites
--preconditions onFail:HALT onError:HALT
alter table "GUIDE_DB".public.favorites
    drop constraint favorites_guide_id_fkey,
    add constraint favorites_guide_id_fkey
        foreign key(guide_id)
            references guides
            on delete cascade;

--changeset goofyahh:oncascadedelete_tags_1
--preconditions onFail:HALT onError:HALT
alter table "GUIDE_DB".public.tags
    drop constraint tags_guide_id_fkey,
    add constraint tags_guide_id_fkey
        foreign key(guide_id)
            references guides
            on delete cascade;

--changeset goofyahh:oncascadedelete_interactions
--preconditions onFail:HALT onError:HALT
alter table "GUIDE_DB".public.interactions
    drop constraint interactions_guide_id_fkey,
    add constraint interactions_guide_id_fkey
        foreign key(guide_id)
            references guides
            on delete cascade;

--changeset goofyahh:oncascadedelete_comments
--preconditions onFail:HALT onError:HALT
alter table "GUIDE_DB".public.comments
    drop constraint comments_guide_id_fkey,
    add constraint comments_guide_id_fkey
        foreign key(guide_id)
            references guides
            on delete cascade;

--changeset goofyahh:oncascadedelete_guide_reports
--preconditions onFail:HALT onError:HALT
alter table "GUIDE_DB".public.guide_reports
    drop constraint guide_reports_guide_id_fkey,
    add constraint guide_reports_guide_id_fkey
        foreign key(guide_id)
            references guides
            on delete cascade;

--changeset goofyahh:oncascadedelete_tags_2
--preconditions onFail:HALT onError:HALT
alter table "GUIDE_DB".public.tags
    drop constraint tags_category_name_fkey,
    add constraint tags_category_name_fkey
        foreign key(category_name)
            references categories
            on delete cascade;

