SELECT
	   ru.DESKRIPSI RUANGAN
        , b.NAMA NAMA_BARANG
		, s.DESKRIPSI SATUAN
		, merk.DESKRIPSI PABRIK
		, p.NAMA PENYEDIA
	 	, br.STOK
		, pbd.NO_BATCH
		, DATE_FORMAT(pbd.`MASA_BERLAKU`,"%d-%m-%Y") MASA_BERLAKU
			, DATE_FORMAT(br.TANGGAL,"%Y-%m-%d %h:%i:%s") TANGGAL_UPDATE
			, pbd.HARGA  HARGA_BELI
			, pbd.HARGA*br.STOK AS TOTAL


	FROM aplikasi.instansi ai , master.ppk mp , inventory.barang_ruangan br
	LEFT JOIN `master`.ruangan ru ON ru.ID = br.RUANGAN
	LEFT JOIN inventory.barang b ON b.ID = br.BARANG
	LEFT JOIN inventory.kategori k ON k.ID = b.KATEGORI
	LEFT JOIN inventory.penyedia p ON b.PENYEDIA=p.ID
	LEFT JOIN inventory.satuan s ON s.ID = b.SATUAN
	LEFT JOIN inventory.penerimaan_barang_detil pbd ON b.ID=pbd.BARANG
	LEFT JOIN inventory.harga_barang hb ON hb.BARANG=b.ID
	LEFT JOIN `master`.referensi merk ON merk.ID = b.MERK AND merk.JENIS = 39
	WHERE ai.PPK=mp.ID AND
	      br.STATUS = 1
	     -- AND b.KATEGORI in (20101,20102)
	      AND br.RUANGAN = 105020201
	      -- ,'101120102','101120103')
	GROUP BY br.BARANG