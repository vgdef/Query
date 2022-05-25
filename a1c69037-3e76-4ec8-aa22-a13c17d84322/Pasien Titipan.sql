SELECT
p.NORM,
       pp.NAMA NAMAPASIEN,
       CASE WHEN k.TITIPAN_KELAS = 1 THEN 'Titipan Kelas III'
       WHEN k.TITIPAN_KELAS = 2 THEN 'Titipan Kelas II'
       WHEN k.TITIPAN_KELAS = 3 THEN 'Titipan Kelas I'
       ELSE 'Tidak diTitipkan' END as KELAS,
       k.MASUK TGLMASUK
FROM pendaftaran.kunjungan k
LEFT JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
LEFT JOIN master.pasien pp ON pp.NORM=p.NORM
WHERE k.RUANGAN = 101030109 AND
k.MASUK BETWEEN DATE_FORMAT(NOW(), "%Y-02-01") AND DATE_FORMAT(NOW(), "%Y-02-09")
