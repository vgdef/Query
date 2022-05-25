
	SELECT
# 	inst.NAMA NAMAINST
# 	, inst.ALAMAT ALAMATINST
	 ib.NAMA NAMAOBAT
	, rr.DESKRIPSI RUANGAN
	, sod.MANUAL SSISTEM
	, DATE_FORMAT(so.`TANGGAL`,'%d-%m-%Y') TANGGAL
	, s.DESKRIPSI SATUAN
	, sod.MANUAL JUMLAH
	, p.NAMA PENYEDIA
	, pbd.NO_BATCH
	, DATE_FORMAT(pbd.`MASA_BERLAKU`,'%d-%m-%Y') MASA_BERLAKU
	, hb.HARGA_BELI
	, r.DESKRIPSI MERK

FROM inventory.stok_opname_detil sod
LEFT JOIN inventory.barang_ruangan br ON sod.BARANG_RUANGAN=br.ID
LEFT JOIN inventory.barang ib ON br.BARANG=ib.ID
LEFT JOIN inventory.penyedia p ON ib.PENYEDIA=p.ID
LEFT JOIN inventory.penerimaan_barang_detil pbd ON ib.ID=pbd.BARANG
LEFT JOIN inventory.harga_barang hb ON hb.BARANG=ib.ID
LEFT JOIN inventory.kategori k ON k.ID=ib.KATEGORI
LEFT JOIN `master`.referensi r ON r.ID = ib.MERK AND r.JENIS = 39
LEFT JOIN inventory.satuan s ON s.ID=ib.SATUAN
LEFT JOIN inventory.stok_opname so ON so.ID=sod.STOK_OPNAME
LEFT JOIN master.ruangan rr ON rr.ID=br.RUANGAN
	   , (SELECT mp.NAMA, ai.PPK, mp.ALAMAT
					FROM aplikasi.instansi ai
						, master.ppk mp
					WHERE ai.PPK=mp.ID) inst
	WHERE so.ID = 27
    GROUP BY br.BARANG