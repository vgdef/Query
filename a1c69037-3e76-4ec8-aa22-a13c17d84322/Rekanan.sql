SELECT
      -- b.ID,
      pbd.PENERIMAAN,
 b.NAMA NAMA_BARANG,
       pbd.JUMLAH,
       pbd.HARGA HARGA_BELI,
       hb.HARGA_JUAL,
       p.NAMA PENYEDIA,
       pb.TANGGAL_PENERIMAAN
FROM inventory.penerimaan_barang_detil pbd
LEFT JOIN inventory.penerimaan_barang pb ON pb.ID=pbd.PENERIMAAN
LEFT JOIN inventory.barang b ON b.ID=pbd.BARANG
    LEFT JOIN inventory.harga_barang hb ON hb.BARANG=b.ID
LEFT JOIN inventory.penyedia p ON p.ID=pb.REKANAN
LEFT JOIN inventory.kategori k ON k.ID=b.KATEGORI
WHERE pb.RUANGAN IN ( 101120101, 101120102)-- pbd.PENERIMAAN IN (32,33,34,114,115,144, 173,260,261,262,331,341,342)
 AND
pb.TANGGAL_PENERIMAAN > DATE_ADD(NOW(), INTERVAL -200 day )
GROUP BY b.ID