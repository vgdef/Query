SELECT
pp.NAMA PASIEN,
       r.DESKRIPSI RUANGAN,
       CONCAT(IF(rk.KELAS=0, 'NON KELAS',
         IF(rk.KELAS=1, 'KELAS III',
            IF(rk.KELAS=2, 'KELAS II',
                IF(rk.KELAS=3, 'KELAS I',
                    IF(rk.KELAS=4, 'VIP',
                        IF(rk.KELAS=5, 'VVIP', ""))))))) KELASRUANGAN,
       ref.DESKRIPSI CARABAYAR,
       k.MASUK TGLMASUK
FROM pendaftaran.pendaftaran p
LEFT JOIN pendaftaran.tujuan_pasien tp ON tp.NOPEN=p.NOMOR
LEFT JOIN pendaftaran.kunjungan k ON k.NOPEN =p.NOMOR AND k.STATUS IN (1,2)
LEFT JOIN master.pasien pp ON pp.NORM=p.NORM
LEFT JOIN master.ruang_kamar_tidur rkt ON rkt.ID=k.RUANG_KAMAR_TIDUR
LEFT JOIN master.ruang_kamar rk ON rk.ID=rkt.RUANG_KAMAR
LEFT JOIN master.ruangan r ON r.ID=rk.RUANGAN
LEFT JOIN pendaftaran.penjamin pnj ON pnj.NOPEN=p.NOMOR
LEFT JOIN master.referensi ref ON pnj.JENIS=ref.ID AND ref.JENIS=10
WHERE k.MASUK BETWEEN DATE_FORMAT(NOW(), "2022-01-01") AND DATE_FORMAT(NOW(), "2022-04-30")
AND tp.RUANGAN = 101030105
AND pnj.JENIS  IN ('1','3','6','7','8','9')
AND rk.KELAS IN ('4','5')
GROUP BY p.NOMOR