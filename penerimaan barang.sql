SELECT b.ID, b.NAMA, pb.TANGGAL_PENERIMAAN, pb.FAKTUR, pbd.NO_BATCH, pbd.JUMLAH, b.TANGGAL
FROM inventory.barang b
right JOIN inventory.penerimaan_barang_detil pbd ON pbd.BARANG=b.ID
join inventory.penerimaan_barang pb ON pbd.PENERIMAAN=pb.ID
WHERE b.TANGGAL LIKE '2020%'
		AND pb.RUANGAN LIKE '1011201%'
		AND pb.TANGGAL_PENERIMAAN LIKE '2020%'
		AND pbd.STATUS=2;