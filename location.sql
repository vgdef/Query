create table SATUSEHAT.location
(
    ID                           int                 not null
        primary key,
    ID_SIMRS                     char(50) default '' not null,
    ID_LOCATION                  char(20)            null,
    IDENTIFIER                   varchar(30)         null,
    STATUS                       int      default 0  not null comment 'Referensi
2: Location.status',
    OPERASIONAL_STATUS           varchar(1)          not null,
    NAME                         varchar(78)         not null,
    ALIAS                        varchar(1)          not null,
    DESCRIPTION                  varchar(1)          not null,
    MODE                         varchar(1)          not null,
    TYPE                         varchar(1)          not null,
    TELECOM                      varchar(1)          not null,
    ADDRESS                      varchar(47)         not null,
    PHYSICAL_TYPE                varchar(3)          not null,
    POSITION                     varchar(1)          not null,
    MANAGING_ORGANIZATION        varchar(36)         null,
    MANAGE_ORGANIZATION_ID_SIMRS varchar(36)         null,
    HOURS_OF_OPERATION           varchar(1)          not null,
    PARTOF                       varchar(36)         null,
    REF_ID                       varchar(36)         not null,
    SEND_DATE                    varchar(30)         null,
    SEND                         tinyint  default 0  not null
);
