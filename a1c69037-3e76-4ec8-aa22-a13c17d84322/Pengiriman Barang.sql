SELECT
DISTINCT  b.NAMA NAMA_BARANG,
pdd.JUMLAH PERMINTAAN,
pd.JUMLAH PENGIRIMAN,
       p.TANGGAL TGL_KIRIM,
                r.DESKRIPSI RUANGAN_PNGIRIM,
                rrr.DESKRIPSI RUANGAN_PNRIMA
FROM inventory.pengiriman_detil pd
LEFT JOIN inventory.permintaan_detil pdd ON pdd.ID=pd.PERMINTAAN_BARANG_DETIL
    LEFT JOIN inventory.pengiriman p ON p.NOMOR=pd.PENGIRIMAN
LEFT JOIN inventory.barang b ON b.ID=pdd.BARANG
LEFT JOIN master.ruangan r ON r.ID=p.ASAL
LEFT JOIN master.ruangan rrr ON rrr.ID=p.TUJUAN
WHERE  pdd.BARANG  IN (2987)
   -- AND
  -- p.TANGGAL < DATE_ADD(CURDATE(), INTERVAL - 1 DAY)
AND
      p.ASAL = 105020201
ORDER BY p.TANGGAL DESC
# LIMIT 10;
