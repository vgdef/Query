#BERKUNJUNG
SELECT
p.NOMOR AS NOPEN
, p.NORM
, TIME (DATE_ADD(p.TANGGAL, INTERVAL -20 MINUTE))  TASK1
, TIME (DATE_ADD(p.TANGGAL, INTERVAL -10 MINUTE))  TASK2
, TIME_FORMAT(p.TANGGAL,'%H:%i:%s') TASK3
, TIME_FORMAT(k.MASUK,'%H:%i:%s')  TASK4
, TIME_FORMAT(ors.TANGGAL,'%H:%i:%s') TASK5
, TIME_FORMAT(k2.MASUK,'%H:%i:%s') TASK6
, TIME_FORMAT(k2.KELUAR, '%H:%i:%s') TASK7
FROM pendaftaran.kunjungan k
LEFT JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
LEFT JOIN (SELECT k2.NOPEN, k2.MASUK, k2.KELUAR
           FROM pendaftaran.kunjungan k2
           WHERE k2.RUANGAN LIKE '1011201%') k2 ON p.NOMOR=k2.NOPEN
LEFT JOIN regonline.reservasi r ON r.NORM=p.NORM AND r.STATUS=2
LEFT JOIN (SELECT ors.KUNJUNGAN, ors.TANGGAL
           FROM layanan.order_resep ors
           WHERE ors.STATUS!=0) ors ON ors.KUNJUNGAN=k.NOMOR
WHERE p.TANGGAL BETWEEN '2023-05-29' AND '2023-05-31'
AND k.RUANGAN LIKE '1010201%'
AND k.STATUS = 2
GROUP BY k.NOMOR;
#TAKBERKUNJUNG
SELECT
p.NOMOR AS NOPEN
, p.NORM
, TIME (DATE_ADD(p.TANGGAL, INTERVAL -20 MINUTE))  TASK1
, TIME (DATE_ADD(p.TANGGAL, INTERVAL -10 MINUTE))  TASK2
, TIME_FORMAT(p.TANGGAL,'%H:%i:%s') TASK3
, TIME_FORMAT(k.MASUK,'%H:%i:%s')  TASK4
, ors.TANGGAL TASK5
, IF(k.STATUS=0,NULL,TIME_FORMAT(k2.MASUK,'%H:%i:%s')) TASK6
, IF(k.STATUS=0,NULL,TIME_FORMAT(k2.KELUAR,'%H:%i:%s')) TASK7
, pal.TANGGAL TASK99
FROM pendaftaran.kunjungan k
LEFT JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
LEFT JOIN (SELECT k2.NOPEN, k2.MASUK, k2.KELUAR
           FROM pendaftaran.kunjungan k2
           WHERE k2.RUANGAN LIKE '1011201%') k2 ON p.NOMOR=k2.NOPEN
LEFT JOIN regonline.reservasi r ON r.NORM=p.NORM AND r.STATUS=2
LEFT JOIN logs.pengguna_akses_log pal ON pal.REF=k.NOMOR AND pal.AKSI='U'
LEFT JOIN (SELECT ors.NOMOR, ors.TANGGAL
           FROM layanan.order_resep ors
           WHERE ors.STATUS!=0) ors ON ors.NOMOR=k.REF
WHERE p.TANGGAL BETWEEN '2023-05-29' AND '2023-05-31'
AND k.RUANGAN LIKE '1010201%'
AND k.KELUAR IS NULL AND k.STATUS=0
GROUP BY k.NOMOR;