SELECT
b.NAMA BARANG,
# p.NAMA PENYEDIA,
hb.HARGA_BELI,
hb.HARGA_JUAL,
s.NAMA SATUAN,
r.DESKRIPSI RUANGAN
FROM inventory.barang_ruangan br
JOIN inventory.barang b On b.ID=br.BARANG
JOIN inventory.harga_barang hb ON hb.BARANG=br.BARANG
JOIN master.ruangan r ON r.ID=br.RUANGAN
JOIN inventory.penyedia p ON p.ID=b.PENYEDIA
JOIN inventory.satuan s ON s.ID=b.SATUAN
WHERE br.STATUS!=0
  AND br.RUANGAN IN (101120102,105020201,105020202)
AND b.STATUS=1
AND hb.STATUS!=0
