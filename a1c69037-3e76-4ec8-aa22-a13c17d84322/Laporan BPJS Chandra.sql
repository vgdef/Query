SELECT
 ref.DESKRIPSI CARABAYAR,
p.NORM,
       pp.NAMA NAMA_PASIEN,
       pj.NOMOR SEP,
       t.TOTAL,
       r.DESKRIPSI RUANGAN,
       t.TANGGAL
FROM pembayaran.tagihan t
    LEFT JOIN pembayaran.tagihan_pendaftaran ptp ON t.ID=ptp.TAGIHAN AND ptp.STATUS=1 AND ptp.UTAMA = 1
    LEFT JOIN pendaftaran.pendaftaran p ON ptp.PENDAFTARAN=p.NOMOR
    LEFT JOIN pendaftaran.penjamin pj ON p.NOMOR=pj.NOPEN
    LEFT JOIN master.pasien pp ON p.NORM=pp.NORM
    LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
    LEFT JOIN pendaftaran.tujuan_pasien tp ON tp.NOPEN=p.NOMOR
    LEFT JOIN master.ruangan r ON r.ID=tp.RUANGAN
WHERE ref.ID=2
AND t.TANGGAL > DATE_ADD(NOW(), INTERVAL -3 day )