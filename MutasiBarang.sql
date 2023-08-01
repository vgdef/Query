SELECT
       ib.NAMA NAMAOBAT,
       jts.DESKRIPSI,
       DATE_FORMAT(tsr.TANGGAL,'%d-%m-%Y %H:%i:%s') TGLPELAYANAN,
       IF(jts.TAMBAH_ATAU_KURANG='+',tsr.JUMLAH,0) MASUK
	   , IF(jts.TAMBAH_ATAU_KURANG='-',tsr.JUMLAH,0) KELUAR
						, tsr.STOK
		
					
					FROM inventory.transaksi_stok_ruangan tsr
					     LEFT JOIN inventory.jenis_transaksi_stok jts ON tsr.JENIS=jts.ID
					     LEFT JOIN layanan.farmasi lf ON tsr.REF=lf.ID
					     LEFT JOIN pendaftaran.kunjungan pk ON lf.KUNJUNGAN=pk.NOMOR
					     LEFT JOIN layanan.order_resep o ON pk.REF=o.NOMOR
					     LEFT JOIN pendaftaran.kunjungan asal ON o.KUNJUNGAN=asal.NOMOR
					     LEFT JOIN master.ruangan ra ON asal.RUANGAN=ra.ID
					     LEFT JOIN pendaftaran.pendaftaran pp ON pk.NOPEN=pp.NOMOR
					     LEFT JOIN master.pasien ps ON pp.NORM=ps.NORM
						, inventory.barang_ruangan br
						, master.ruangan r
						  LEFT JOIN master.referensi jk ON r.JENIS_KUNJUNGAN=jk.ID AND jk.JENIS=15
						, inventory.barang ib
						  LEFT JOIN inventory.kategori ik ON ib.KATEGORI=ik.ID
						, (SELECT mp.NAMA, ai.PPK, mp.ALAMAT
											FROM aplikasi.instansi ai
												, master.ppk mp
											WHERE ai.PPK=mp.ID) inst
					WHERE tsr.BARANG_RUANGAN=br.ID AND br.RUANGAN=r.ID AND r.JENIS=5 AND br.BARANG=ib.ID
						 AND r.JENIS_KUNJUNGAN=0 AND tsr.TANGGAL BETWEEN '2023-01-01 00:00:00' AND '2023-07-21 00:00:00'
						 AND br.RUANGAN LIKE '10502%' AND ib.ID IN (6162,6751)


					ORDER BY tsr.BARANG_RUANGAN, tsr.TANGGAL;
