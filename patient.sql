create table SATUSEHAT.patient
(
    id                    char(36)                                             null,
    ssehat_id             varchar(50)                                          null,
    identifier            json                                                 null,
    active                tinyint                    default 1                 not null comment '1 : TRUE, 0: FALSE',
    address               json                                                 null,
    birthDate             date                                                 not null,
    communication         json                                                 null,
    deceasedBoolean       tinyint                    default 0                 not null comment '1 : TRUE, 0: FALSE (Menunjukkan apakah individu tersebut meninggal atau tidak)',
    extension             json                                                 null,
    gender                char(30)                   default ''                not null,
    maritalStatus         json                                                 null,
    meta                  json                                                 null,
    multipleBirthBoolean  tinyint                    default 0                 not null,
    name                  json                                                 null,
    telecom               json                                                 null,
    refId                 int                                                  not null
        primary key,
    nik                   varchar(16) charset latin1 default ''                not null,
    getDate               timestamp                  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    httpRequest           enum ('GET', 'POST')       default 'GET'             not null,
    statusRequest         tinyint(1)                 default 1                 not null,
    statusKelengkapanData int                        default 0                 not null comment '1 : Lengkap, 0 : Tidak Lengkap'
);

create index httpRequest
    on SATUSEHAT.patient (httpRequest);

create index id
    on SATUSEHAT.patient (id);

create index nik
    on SATUSEHAT.patient (nik);

create index ssehat_id
    on SATUSEHAT.patient (ssehat_id);

create index statusRequest
    on SATUSEHAT.patient (statusRequest);

