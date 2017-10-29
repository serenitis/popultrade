
    drop table if exists pgnclientsschedule cascade;

    drop sequence popultrade_seq;

    create table pgnclientsschedule (
        id int8 not null,
        id_pgnclientssh int8 not null,
        offline0 varchar(1),
        offline1 varchar(1),
        offline2 varchar(1),
        offline3 varchar(1),
        offline4 varchar(1),
        offline5 varchar(1),
        offline6 varchar(1),
        time_from0 varchar(5),
        time_from1 varchar(5),
        time_from2 varchar(5),
        time_from3 varchar(5),
        time_from4 varchar(5),
        time_from5 varchar(5),
        time_from6 varchar(5),
        time_to0 varchar(5),
        time_to1 varchar(5),
        time_to2 varchar(5),
        time_to3 varchar(5),
        time_to4 varchar(5),
        time_to5 varchar(5),
        time_to6 varchar(5),
        primary key (id)
    );

    create index id_pgnclientsshi on pgnclientsschedule (id_pgnclientssh);

    create sequence popultrade_seq;
