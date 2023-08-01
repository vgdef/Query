SELECT
CONCAT(IF(rk.KELAS=0, 'NON KELAS',
         IF(rk.KELAS=1, 'KELAS III',
            IF(rk.KELAS=2, 'KELAS II',
                IF(rk.KELAS=3, 'KELAS I',
                    IF(rk.KELAS=4, 'VIP',
                        IF(rk.KELAS=5, 'VVIP',
                            IF(rk.KELAS=6, 'HCU/ISOLASI',
                                IF(rk.KELAS=7, 'INTENSIF',
                                    IF(rk.KELAS=8, 'Isolasi NICU',
                                        IF(rk.KELAS=9, 'Gawat Darurat',
                                            IF(rk.KELAS=10, 'Kamar Bersalin',
                                                IF(rk.KELAS=11, 'NICU',
                                                    IF(rk.KELAS=12, 'Isolasi PICU',
                                                        IF(rk.KELAS=13,'PICU',""))))))))))))))) KELAS,
 (COUNT(rk.ID) - COUNT(case when rkt.STATUS = 0 then 1 END) )SEMUA,
    (COUNT(rk.ID) - COUNT(case when rkt.STATUS IN (2,3) then 1 END) )TERSEDIA,
      (COUNT(rk.ID) - COUNT(case when rkt.STATUS =  1 then 1 END) )TERISI
FROM master.ruang_kamar_tidur rkt
LEFT JOIN master.ruang_kamar rk ON rk.ID=rkt.RUANG_KAMAR
WHERE rk.STATUS !=0 AND rkt.STATUS!=0 AND rk.KELAS IN (1,2,3,4,5,11,7,8,6,12,13)
GROUP BY rk.KELAS
ORDER BY rk.KELAS