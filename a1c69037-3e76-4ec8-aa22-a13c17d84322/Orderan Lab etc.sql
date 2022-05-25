SELECT*
# pp.NORM,
#        pp.NAMA,
#        ol.ALASAN DIAGNOSA,
#        ol.TANGGAL,
#     rr.DESKRIPSI ASAL,
#     r.DESKRIPSI TUJUAN'
FROM layanan.order_lab ol
LEFT JOIN pendaftaran.kunjungan k ON k.NOMOR=ol.KUNJUNGAN
LEFT JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
LEFT JOIN master.pasien pp ON pp.NORM=p.NORM
LEFT JOIN master.ruangan r ON r.ID=ol.TUJUAN
LEFT JOIN master.ruangan rr ON rr.ID=k.RUANGAN
WHERE ol.TANGGAL > DATE_ADD(NOW(), INTERVAL -25 DAY)
