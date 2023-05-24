create table barangbackup

(
    ID                            int          not null
        primary key,
    ID_SIMRS                      int          not null,
    Nama                          varchar(70)  not null,
    Satuan                        varchar(4)   null,
    Satuan_Klinis                 varchar(12)  null,
    Satuan_Besar                  varchar(12)  null,
    Formulat                      varchar(135) null,
    Kode_KFA_Varian_Aktual        varchar(56)  null,
    Display_KFA_Varian_Aktual_POA varchar(138) null,
    Kode_KFA_Varian_Template      int          null,
    Display_KFA_Varian_Template   varchar(124) null,
    Kode_KFA_Ingredients          int          null,
    Display_KFA_Ingredients       varchar(35)  null,
    Dosis_KFA_Ingredients         varchar(9)   null,
    Satuan_KFA_Ingredients        varchar(4)   null,
    Kode_Medication_form          varchar(6)   null,
    Display_Medication_form       varchar(23)  null,
    Kode_Orderable                varchar(7)   null,
    Kode_Medication_Route         varchar(19)  null,
    Display_Medication_Route      varchar(23)  null,
    Manufacture                   varchar(30)  null
);

create index ID_BARANG
    on barang (ID_SIMRS);

