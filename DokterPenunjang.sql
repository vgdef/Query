#LABPK
SELECT
 ref.DESKRIPSI CARA_BAYAR
, pj.NOMOR SEP
, `master`.getNamaLengkap(p.NORM) PASIEN
, t.NAMA TINDAKAN
, `master`.getNamaLengkapPegawai(dok1.NIP) DOKTERLAB
 , ol.DOKTER_ASAL PERUJUK
, k.MASUK
, k.KELUAR
FROM pendaftaran.kunjungan k
LEFT JOIN layanan.order_lab ol ON ol.NOMOR=k.REF
LEFT JOIN layanan.order_detil_lab odl ON odl.REF=ol.NOMOR
LEFT JOIN layanan.tindakan_medis tm ON tm.KUNJUNGAN=k.NOMOR
LEFT JOIN layanan.hasil_lab hl ON hl.TINDAKAN_MEDIS=tm.ID
LEFT JOIN `master`.tindakan t ON t.ID=tm.TINDAKAN
JOIN layanan.catatan_hasil_lab chl ON chl.KUNJUNGAN=k.NOMOR
JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
LEFT JOIN master.dokter dok1 ON dok1.ID=chl.DOKTER
INNER JOIN pendaftaran.penjamin pj ON p.NOMOR=pj.NOPEN  AND pj.JENIS= 2
LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
WHERE k.MASUK BETWEEN '2022-09-01' AND '2022-12-31' AND ol.`STATUS`=2
AND tm.`STATUS`=1 AND k.`STATUS`=2;

#RADIOLOGI
SELECT
 ref.DESKRIPSI CARA_BAYAR
, pj.NOMOR SEP
, `master`.getNamaLengkap(p.NORM) PASIEN
, t.NAMA TINDAKAN
, `master`.getNamaLengkapPegawai(dok1.NIP) DOKTERRAD
, k.MASUK
, k.KELUAR
FROM pendaftaran.kunjungan k
LEFT JOIN layanan.order_rad ol ON ol.NOMOR=k.REF
LEFT JOIN layanan.order_detil_rad odl ON odl.REF=ol.NOMOR
LEFT JOIN layanan.tindakan_medis tm ON tm.KUNJUNGAN=k.NOMOR
LEFT JOIN layanan.hasil_rad hl ON hl.TINDAKAN_MEDIS=tm.ID
LEFT JOIN `master`.tindakan t ON t.ID=tm.TINDAKAN
JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
LEFT JOIN master.dokter dok1 ON dok1.ID=hl.DOKTER
INNER JOIN pendaftaran.penjamin pj ON p.NOMOR=pj.NOPEN  AND pj.JENIS= 2
LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
WHERE k.MASUK BETWEEN '2022-09-01' AND '2022-12-31' AND ol.`STATUS`=2
AND tm.`STATUS`=1 AND k.`STATUS`=2;

#LABPA
SELECT
 ref.DESKRIPSI CARA_BAYAR
, pj.NOMOR SEP
, `master`.getNamaLengkap(p.NORM) PASIEN
, t.NAMA TINDAKAN
, `master`.getNamaLengkapPegawai(dok1.NIP) DOKTERLAB
, k.MASUK
, k.KELUAR
, hl.KUNJUNGAN
FROM pendaftaran.kunjungan k
LEFT JOIN layanan.order_lab ol ON ol.NOMOR=k.REF
LEFT JOIN layanan.hasil_pa hl ON hl.KUNJUNGAN=k.NOMOR
LEFT JOIN layanan.order_detil_lab odl ON odl.ORDER_ID=ol.NOMOR
LEFT JOIN `master`.tindakan t ON t.ID=odl.TINDAKAN
JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
LEFT JOIN master.dokter dok1 ON dok1.ID=hl.DOKTER
INNER JOIN pendaftaran.penjamin pj ON p.NOMOR=pj.NOPEN  AND pj.JENIS= 2
LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
WHERE k.MASUK BETWEEN '2022-09-01' AND '2022-12-31' AND ol.`STATUS`=2
AND ol.TUJUAN=101050102 AND k.`STATUS`=2;)