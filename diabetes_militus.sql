SELECT
p.NOMOR NOPEN
, p.NORM, master.getNamaLengkap(p.NORM) PASIEN
, master.getDiagnosaPasien(p.NOMOR) DIAGNOSA
, t.NAMA TINDAKAN_MEDIS
, r.DESKRIPSI RUANGAN
# , CONCAT(
#     FLOOR(HOUR(TIMEDIFF(ora.TANGGAL, k.MASUK)) / 24), ' Hr ',
#     MOD(HOUR(TIMEDIFF(ora.TANGGAL, k.MASUK)), 24), ' Jam ',
#     MINUTE(TIMEDIFF(ora.TANGGAL, k.MASUK)), ' Mnt ') AS SELISIH1
, k.MASUK TGLMASUK
FROM pendaftaran.pendaftaran p
JOIN pendaftaran.tujuan_pasien tp ON tp.NOPEN=p.NOMOR
JOIN master.ruangan r On r.ID =tp.RUANGAN
JOIN pendaftaran.kunjungan k ON k.NOPEN=p.NOMOR
JOIN medicalrecord.diagnosa d ON d.NOPEN=p.NOMOR
JOIN layanan.order_lab ora ON ora.NOMOR=k.REF
JOIN layanan.order_detil_lab odr ON odr.ORDER_ID=ora.NOMOR
JOIN master.tindakan t ON t.ID=odr.TINDAKAN
JOIN layanan.tindakan_medis tm ON tm.ID=odr.REF

WHERE
    ora.STATUS = 2 AND odr.TINDAKAN =12902
 AND (d.KODE LIKE 'E10%'
   OR d.KODE LIKE 'E11%' OR d.KODE LIKE 'E12%'
   OR d.KODE LIKE 'E13%' OR d.KODE LIKE 'E14%')
AND k.MASUK >= NOW() - INTERVAL 6 MONTH
# GROUP BY p.NOMOR
ORDER BY k.MASUK;

SELECT
p.NOMOR NOPEN
, p.NORM, master.getNamaLengkap(p.NORM) PASIEN
, master.getDiagnosaPasien(p.NOMOR) DIAGNOSA
, t.NAMA TINDAKAN_MEDIS
, hl.HASIL HASIL
, r.DESKRIPSI RUANGAN
, k.MASUK TGLMASUK
, tm.ID
FROM pendaftaran.pendaftaran p
JOIN pendaftaran.tujuan_pasien tp ON tp.NOPEN=p.NOMOR
JOIN master.ruangan r On r.ID =tp.RUANGAN
JOIN pendaftaran.kunjungan k ON k.NOPEN=p.NOMOR
JOIN medicalrecord.diagnosa d ON d.NOPEN=p.NOMOR
JOIN layanan.order_lab ora ON ora.NOMOR=k.REF
JOIN layanan.order_detil_lab odr ON odr.ORDER_ID=ora.NOMOR
JOIN master.tindakan t ON t.ID=odr.TINDAKAN
JOIN layanan.hasil_lab hl ON hl.TINDAKAN_MEDIS=odr.REF
JOIN layanan.tindakan_medis tm ON tm.ID=hl.TINDAKAN_MEDIS
WHERE
    ora.STATUS = 2 AND odr.TINDAKAN =12902
 AND (d.KODE LIKE 'E10%'
   OR d.KODE LIKE 'E11%' OR d.KODE LIKE 'E12%'
   OR d.KODE LIKE 'E13%' OR d.KODE LIKE 'E14%')
AND k.MASUK >= NOW() - INTERVAL 6 MONTH
AND hl.HASIL <= 7
ORDER BY k.MASUK;#HDL

SELECT
p.NOMOR NOPEN
, p.NORM, master.getNamaLengkap(p.NORM) PASIEN
, master.getDiagnosaPasien(p.NOMOR) DIAGNOSA
, t.NAMA TINDAKAN_MEDIS
, hl.HASIL HASIL
, r.DESKRIPSI RUANGAN
, k.MASUK TGLMASUK
, tm.ID
FROM pendaftaran.pendaftaran p
JOIN pendaftaran.tujuan_pasien tp ON tp.NOPEN=p.NOMOR
JOIN master.ruangan r On r.ID =tp.RUANGAN
JOIN pendaftaran.kunjungan k ON k.NOPEN=p.NOMOR
JOIN medicalrecord.diagnosa d ON d.NOPEN=p.NOMOR
JOIN layanan.order_lab ora ON ora.NOMOR=k.REF
JOIN layanan.order_detil_lab odr ON odr.ORDER_ID=ora.NOMOR
JOIN master.tindakan t ON t.ID=odr.TINDAKAN
JOIN layanan.hasil_lab hl ON hl.TINDAKAN_MEDIS=odr.REF
JOIN layanan.tindakan_medis tm ON tm.ID=hl.TINDAKAN_MEDIS
WHERE
    ora.STATUS = 2 AND odr.TINDAKAN =11347
 AND (d.KODE LIKE 'E10%'
   OR d.KODE LIKE 'E11%' OR d.KODE LIKE 'E12%'
   OR d.KODE LIKE 'E13%' OR d.KODE LIKE 'E14%')
AND k.MASUK >= NOW() - INTERVAL 6 MONTH
# AND hl.HASIL <= 100
ORDER BY k.MASUK;#LDL

SELECT
p.NOMOR NOPEN
, p.NORM, master.getNamaLengkap(p.NORM) PASIEN
, master.getDiagnosaPasien(p.NOMOR) DIAGNOSA
, tv.SISTOLIK
, tv.DISTOLIK
, r.DESKRIPSI RUANGAN
, k.MASUK TGLMASUK

FROM pendaftaran.pendaftaran p
JOIN pendaftaran.tujuan_pasien tp ON tp.NOPEN=p.NOMOR
JOIN master.ruangan r On r.ID =tp.RUANGAN
JOIN pendaftaran.kunjungan k ON k.NOPEN=p.NOMOR
JOIN medicalrecord.diagnosa d ON d.NOPEN=p.NOMOR
JOIN medicalrecord.tanda_vital tv ON tv.KUNJUNGAN=k.NOMOR

WHERE
    (d.KODE LIKE 'E10%'
   OR d.KODE LIKE 'E11%' OR d.KODE LIKE 'E12%'
   OR d.KODE LIKE 'E13%' OR d.KODE LIKE 'E14%')
AND k.MASUK >= NOW() - INTERVAL 6 MONTH
# AND tv.SISTOLIK < 130 AND tv.DISTOLIK < 80
ORDER BY k.MASUK; #TekananDarah

SELECT
p.NOMOR NOPEN
, p.NORM, master.getNamaLengkap(p.NORM) PASIEN
, master.getDiagnosaPasien(p.NOMOR) DIAGNOSA
, t.NAMA TINDAKAN
, r.DESKRIPSI RUANGAN
, k.MASUK TGLMASUK

FROM pendaftaran.pendaftaran p
JOIN pendaftaran.tujuan_pasien tp ON tp.NOPEN=p.NOMOR
JOIN master.ruangan r On r.ID =tp.RUANGAN
JOIN pendaftaran.kunjungan k ON k.NOPEN=p.NOMOR
JOIN medicalrecord.diagnosa d ON d.NOPEN=p.NOMOR
JOIN layanan.tindakan_medis tm ON tm.KUNJUNGAN=k.NOMOR
JOIN master.tindakan t ON t.ID=tm.TINDAKAN

WHERE
    tm.TINDAKAN=15015
#    AND (d.KODE LIKE 'H44.0%'
#    OR d.KODE LIKE 'H44.1%' OR d.KODE LIKE 'H45.1%%')
AND k.MASUK >= NOW() - INTERVAL 6 MONTH
# AND tv.SISTOLIK < 130 AND tv.DISTOLIK < 80
ORDER BY k.MASUK; #MATA