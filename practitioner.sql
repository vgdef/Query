create table SATUSEHAT.practitioner
(
    ID             int           not null
        primary key,
    ID_SSEHAT      varchar(50)   null,
    NIP            varchar(20)   not null,
    NAMA           varchar(37)   not null,
    GELAR_DEPAN    varchar(12)   null,
    GELAR_BELAKANG varchar(25)   null,
    NIK            varchar(16)   null,
    TEMPAT_LAHIR   varchar(25)   null,
    TANGGAL_LAHIR  varchar(19)   not null,
    AGAMA          int           not null,
    JENIS_KELAMIN  int           not null,
    PROFESI        int           not null,
    SMF            int           not null,
    ALAMAT         varchar(86)   null,
    RT             varchar(3)    null,
    RW             varchar(3)    null,
    KODEPOS        varchar(5)    null,
    WILAYAH        varchar(10)   null,
    STATUS         int default 0 not null comment '2 = NIK tidak ada, 1 = NIK ada dan terdaftara SS, 3 = NIK ada tapi tidak terdaftar SS'
);

