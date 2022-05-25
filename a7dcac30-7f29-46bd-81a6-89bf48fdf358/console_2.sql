SELECT

       COUNT(*) dirawat
FROM pendaftaran.kunjungan k
WHERE k.RUANGAN = 101030103 AND
k.STATUS = 1