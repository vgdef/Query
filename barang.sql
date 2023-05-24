SELECT b.ID, b.NAMA BARANG
FROM  inventory.barang b
GROUP BY b.ID
ORDER BY b.ID;

