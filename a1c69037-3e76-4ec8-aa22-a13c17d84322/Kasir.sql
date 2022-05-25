SELECT
       ppt.TAGIHAN,
       IF(p.NORM IS NULL, '-', p.NORM)           NORM,
       IF(p.NAMA IS NULL, '-', p.NAMA)           NAMA,
       IF(r.DESKRIPSI IS NULL, '-', r.DESKRIPSI) RUANGAN,
       ppt.TANGGAL,
       pt.TOTAL,
       k.NAMA KASIR

FROM pembayaran.pembayaran_tagihan pt
         LEFT JOIN master.referensi jb ON pt.JENIS = jb.ID AND jb.JENIS = 50
         LEFT JOIN pembayaran.tagihan_pendaftaran ptp ON pt.TAGIHAN = ptp.TAGIHAN AND ptp.STATUS = 1 AND ptp.UTAMA = 1
         LEFT JOIN pendaftaran.pendaftaran pp ON ptp.PENDAFTARAN = pp.NOMOR
         LEFT JOIN pendaftaran.penjamin pj ON pp.NOMOR = pj.NOPEN
         LEFT JOIN master.referensi crbyr ON pj.JENIS = crbyr.ID AND crbyr.JENIS = 10
         LEFT JOIN master.pasien p ON pp.NORM = p.NORM
         LEFT JOIN pendaftaran.tujuan_pasien tp ON pp.NOMOR = tp.NOPEN
         LEFT JOIN master.ruangan r ON tp.RUANGAN = r.ID AND r.JENIS = 5
         LEFT JOIN master.referensi rf ON r.JENIS_KUNJUNGAN = rf.ID AND rf.JENIS = 15
         LEFT JOIN pembayaran.tagihan tg ON pt.TAGIHAN = tg.ID
         LEFT JOIN pembayaran.pembayaran_tagihan ppt ON pt.TAGIHAN = ppt.TAGIHAN
         LEFT JOIN pembayaran.kasir k ON k.ID = pt.OLEH
         RIGHT JOIN pembayaran.pembayaran_tagihan ptt ON ptt.TAGIHAN = pt.TAGIHAN
         WHERE pt.TANGGAL BETWEEN DATE_FORMAT(NOW(), "2022-05-24") AND DATE_FORMAT(NOW(), "2022-05-25");