SELECT
    b.NAMA BARANG
     , hb.HARGA_BELI
     , hb.PPN
     , hb.HARGA_JUAL
FROM inventory.barang b
JOIN inventory.harga_barang hb ON hb.BARANG=b.ID
WHERE b.ID IN (6142,6140,6141)
AND hb.STATUS=1;

