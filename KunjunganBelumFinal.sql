SELECT master.getNamaLengkap(p.NORM) PASIEN,
       r.DESKRIPSI RUANGAN,
       k.MASUK TGLMASUK,
       k.KELUAR TGLKELUAR,
       IF(k.STATUS=1,'Belum Final/Belum Terima Kunjungan','') STATUS
FROM pendaftaran.kunjungan k
JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
JOIN master.ruangan r ON r.ID=k.RUANGAN
WHERE k.STATUS=1