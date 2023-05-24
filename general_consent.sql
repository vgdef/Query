create table pendaftaran.general_consent
(
    ID                 int,
    NORM               int                                                null,
    SETUJU             int                                                null,
    EVENT_NAME         varchar(128)                                       not null,
    TANGGAL            datetime                                           not null,
    OLEH               int                                                null,

    primary key (ID) using hash,

    constraint general_consent_pk2
        unique (NORM)
);

alter table pendaftaran.general_consent
    modify ID int auto_increment;

