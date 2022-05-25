
		SELECT
		       -- lf.KUNJUNGAN, lf.TANGGAL, master.getNamaLengkapPegawai(mp.NIP) NAMADOKTER
		  -- , CONCAT('LAPORAN PELAYANAN ',UPPER(jk.DESKRIPSI),' PER OBAT') JENISLAPORAN
			-- , rg.DESKRIPSI RUANG, r.DESKRIPSI ASALPENGIRIM, master.getNamaLengkap(ps.NORM) NAMAPASIEN, DATE_FORMAT(ps.TANGGAL_LAHIR,'%d-%m-%Y') TGLLAHIR
			-- , ps.ALAMAT,LPAD(ps.NORM,8,'0') NORM
			-- , CONCAT('RESEP ',UPPER(jenisk.DESKRIPSI)) JENISRESEP, master.getHeaderKategoriBarang('0') KATEGORI
			 ib.NAMA NAMAOBAT, ppp.NAMA PENYEDIA, lf.JUMLAH, SUM(rt.JUMLAH) JMLOBAT, rt.TARIF, SUM(rt.JUMLAH * rt.TARIF) TOTAL,  CONCAT(lf.RACIKAN,lf.GROUP_RACIKAN) RACIKAN, lf.`STATUS` STATUSLAYANAN
			, IF(0=0,'Semua',(SELECT ref.DESKRIPSI FROM master.referensi ref WHERE ref.ID=0 AND ref.JENIS=10)) CARABAYARHEADER
		--	, master.getHeaderLaporan('101120101') INSTALASI
			, IF(0=0,'Semua',(SELECT br.NAMA FROM inventory.barang br WHERE br.ID=0)) BARANGHEADER
		   , (SELECT SUM(JUMLAH)
					  FROM inventory.transaksi_stok_ruangan tsr
					     , inventory.barang_ruangan br
					 WHERE tsr.JENIS IN (20, 21, 31, 32, 34)
					   AND tsr.TANGGAL BETWEEN '2020-09-01' AND '2021-10-14'
					   AND tsr.BARANG_RUANGAN=br.ID AND br.RUANGAN=pk.RUANGAN
					   AND br.BARANG=ib.ID) MASUK
			FROM layanan.farmasi lf
				  LEFT JOIN master.referensi ref ON lf.ATURAN_PAKAI=ref.ID AND ref.JENIS=41
				  LEFT JOIN pembayaran.rincian_tagihan rt ON lf.ID=rt.REF_ID AND rt.JENIS=4
				, pendaftaran.kunjungan pk
			     LEFT JOIN layanan.order_resep o ON o.NOMOR=pk.REF
			     LEFT JOIN master.dokter md ON o.DOKTER_DPJP=md.ID
				  LEFT JOIN master.pegawai mp ON md.NIP=mp.NIP
				  LEFT JOIN master.ruangan rg ON pk.RUANGAN=rg.ID AND rg.JENIS=5
				  LEFT JOIN master.referensi jk ON rg.JENIS_KUNJUNGAN=jk.ID AND jk.JENIS=15
				  LEFT JOIN pendaftaran.kunjungan asal ON o.KUNJUNGAN=asal.NOMOR
				  LEFT JOIN master.ruangan r ON asal.RUANGAN=r.ID AND r.JENIS=5
			     LEFT JOIN master.referensi jenisk ON r.JENIS_KUNJUNGAN=jenisk.ID AND jenisk.JENIS=15
			   , pendaftaran.pendaftaran pp
				  LEFT JOIN master.pasien ps ON pp.NORM=ps.NORM
				  LEFT JOIN pendaftaran.penjamin pj ON pp.NOMOR=pj.NOPEN
				, inventory.barang ib
				  LEFT JOIN inventory.kategori ik ON ib.KATEGORI=ik.ID
				  LEFT JOIN inventory.penyedia ppp ON ppp.ID=ib.PENYEDIA
				, (SELECT mp.NAMA, ai.PPK, mp.ALAMAT
					FROM aplikasi.instansi ai
						, master.ppk mp
					WHERE ai.PPK=mp.ID) inst
			WHERE  lf.`STATUS`=2 AND lf.KUNJUNGAN=pk.NOMOR AND pk.`STATUS` IN (1,2)
				AND pk.NOPEN=pp.NOMOR AND lf.FARMASI=ib.ID AND rg.JENIS_KUNJUNGAN=0
				AND lf.TANGGAL BETWEEN '2020-09-01' AND '2021-10-14'
				AND pk.RUANGAN = 101120101

			GROUP BY ib.ID
