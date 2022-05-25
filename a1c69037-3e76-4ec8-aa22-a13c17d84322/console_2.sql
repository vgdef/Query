SELECT
b.NAMA NAMABARANG,
       py1.NAMA PENYEDIA,
       s1.NAMA SATUAN,
       ik1.NAMA KATEGORI,
       br.STOK,
      IF(br.STATUS = 0,'Nonaktif','Aktif') STATUS,
       pbd.MASA_BERLAKU
FROM inventory.barang b
LEFT JOIN inventory.barang_ruangan br ON br.BARANG=b.ID
LEFT JOIN inventory.penerimaan_barang_detil pbd ON pbd.BARANG=br.BARANG
LEFT JOIN inventory.penerimaan_barang pb ON pb.ID=pbd.PENERIMAAN
LEFT JOIN inventory.penyedia py1 ON pb.REKANAN=py1.ID
LEFT JOIN inventory.satuan s1 ON b.SATUAN=s1.ID
LEFT JOIN inventory.kategori ik1 ON b.KATEGORI=ik1.ID
WHERE br.RUANGAN = 101120102
GROUP BY br.BARANG