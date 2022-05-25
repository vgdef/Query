SELECT
b.NAMA NAMA_BARANG,
       pd.JUMLAH PERMINTAAN,
       pdd.JUMLAH PENGIRIMAN,
       r.DESKRIPSI ASAL,
       rr.DESKRIPSI TUJUAN,
       p.TANGGAL TGL_PERMINTAAN,
       pp.TANGGAL TGL_KIRIM
FROM inventory.permintaan p
LEFT JOIN inventory.permintaan_detil pd ON pd.PERMINTAAN=p.NOMOR
LEFT JOIN inventory.pengiriman pp ON pp.PERMINTAAN=p.NOMOR
LEFT JOIN inventory.pengiriman_detil pdd ON pdd.PENGIRIMAN=pp.NOMOR
LEFT JOIN inventory.barang b ON b.ID=pd.BARANG
LEFT JOIN master.ruangan r ON r.ID=p.ASAL
LEFT JOIN master.ruangan rr ON rr.ID=p.TUJUAN
WHERE p.TANGGAL > DATE_ADD(NOW(), INTERVAL -31  day )
# WHERE b.ID IN(1316,2239,2757,2758)