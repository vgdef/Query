create table SATUSEHAT.organization
(
    id         char(36)                            null,
    ssehat_id  char(36)                            null,
    identifier json                                null,
    active     tinyint   default 1                 not null comment '1 true 0 false',
    type       json                                null,
    name       varchar(150)                        not null,
    alias      char(50)  default ''                not null,
    telecom    json                                null,
    address    json                                null,
    partOf     json                                null,
    refId      char(10)                            not null comment 'Id Ruangan',
    sendDate   timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    flag       tinyint   default 0                 not null,
    send       tinyint   default 1                 not null comment '1 kirim 0 tidak dikirm',
    constraint refid
        unique (refId)
)
    charset = latin1;

create index id
    on SATUSEHAT.organization (id);

create index kirim
    on SATUSEHAT.organization (send);
