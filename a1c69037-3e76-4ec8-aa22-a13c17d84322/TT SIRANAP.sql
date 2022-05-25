SELECT
CONCAT(IF(rk.KELAS=0, 'Isolasi Tanpa Tekanan Negatif',"")) RUANGAN,
 (COUNT(rkt.ID))SEMUA,
       COUNT(rkt.ID)SEMUAAA,
    (COUNT(case when rkt.STATUS = 1 then 1 END) )TERSEDIA,
      (COUNT(case when rkt.STATUS =  3 then 1 END) )TERISI
FROM master.ruang_kamar_tidur rkt
LEFT JOIN master.ruang_kamar rk ON rk.ID=rkt.RUANG_KAMAR AND rk.STATUS=1
WHERE rk.RUANGAN=101030103
UNION
SELECT
CONCAT(IF(rk.KELAS=0, 'ICU Isolasi Tanpa Tekanan Negatif',"")) RUANGAN,
 (COUNT(rkt.ID)) SEMUA,
    (COUNT(case when rkt.STATUS = 1 then 1 END))TERSEDIA,
      ( COUNT(case when rkt.STATUS =  3 then 1 END))TERISI
FROM master.ruang_kamar_tidur rkt
LEFT JOIN master.ruang_kamar rk ON rk.ID=rkt.RUANG_KAMAR AND rk.STATUS=1
WHERE rk.RUANGAN=101030108


