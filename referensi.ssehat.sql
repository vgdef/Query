create table SATUSEHAT.referensi
(
    JENIS     int default 0 not null comment '1: Organization.type
2: Location.status
3: Location.physicalType
4: Encounter.status
5: Observation.category
6: Max Sistolik, Min Sistolik, Normal Distolik
7: Observation.code
8: Observation.interpretation
9: Min Max Suhu Tubuh
10: Composition.section.code
11: Procedure.status
12: Composition.section.text.status
13: Medication.status
14: Medication.extension:medicationType
15: MedicationRequest.status
16: MedicationRequest.intent
17: MedicationRequest.category
18: Observation Lab & Diagnostic Report.Status
19: Observation Lab.Category
20: ServiceRequest.Status
21: ServiceRequest.Intent
22: Permintaan/Hasil Tindakan Lab
23: Tipe Hasil Pemeriksaan Tindakan Lab
',
    ID        int           not null,
    DESKRIPSI text          null,
    CODE      varchar(32)   null,
    STATUS    int default 0 not null,
    primary key (JENIS, ID)
);

