SELECT
#        p.NORM,
t.NAMA NAMATINDAKAN,
     r.DESKRIPSI RUANGAN,
       rk.KAMAR,
       rf.DESKRIPSI KELAS
#        tm.TANGGAL
FROM pendaftaran.kunjungan k
LEFT JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
LEFT JOIN master.tindakan t ON t.ID=tm.TINDAKAN
LEFT JOIN master.ruang_kamar_tidur rkt ON rkt.ID=k.RUANG_KAMAR_TIDUR
LEFT JOIN master.ruang_kamar rk ON rk.ID = rkt.RUANG_KAMAR
LEFT JOIN master.ruangan r ON r.ID=k.RUANGAN
LEFT JOIN master.referensi rf ON rf.ID=rk.KELAS AND rf.JENIS = 19
WHERE tm.TINDAKAN = 11101 AND tm.STATUS = 1