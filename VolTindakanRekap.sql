SELECT  r.DESKRIPSI UNITPELAYANAN
		, master.getHeaderLaporan(''',RUANGAN,''') INSTALASI
		, DATE_FORMAT(tm.TANGGAL,''%d-%m-%Y %H:%i:%s'') TANGGALTINDAKAN
		, t.NAMA NAMATINDAKAN, COUNT(tm.TINDAKAN) JUMLAH
		, INST.NAMAINST, INST.ALAMATINST
		, IF(',CARABAYAR,'=0,''Semua'',ref.DESKRIPSI) CARABAYARHEADER
		, IF(',DOKTER,'=0,''Semua'',master.getNamaLengkapPegawai(mp.NIP)) DOKTERHEADER
		, IF(',TINDAKAN,'=0,''Semua'',t.NAMA) TINDAKANHEADER
	FROM layanan.tindakan_medis tm
			LEFT JOIN master.tindakan t ON tm.TINDAKAN=t.ID
			LEFT JOIN layanan.petugas_tindakan_medis ptm ON tm.ID=ptm.TINDAKAN_MEDIS AND ptm.JENIS=1 AND KE=1
			LEFT JOIN master.dokter dok ON ptm.MEDIS=dok.ID
			LEFT JOIN master.pegawai mp ON dok.NIP=mp.NIP
		, pendaftaran.pendaftaran pp
		  LEFT JOIN pendaftaran.penjamin pj ON pp.NOMOR=pj.NOPEN
		  LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
		, pendaftaran.kunjungan pk
		  LEFT JOIN master.ruangan r ON pk.RUANGAN=r.ID AND r.JENIS=5
		, master.pasien p
		, (SELECT p.NAMA NAMAINST, p.ALAMAT ALAMATINST
						FROM aplikasi.instansi ai
							, master.ppk p
						WHERE ai.PPK=p.ID) INST
	WHERE tm.`STATUS` IN (1,2) AND pk.NOPEN=pp.NOMOR AND pp.NORM=p.NORM AND tm.KUNJUNGAN=pk.NOMOR
		AND tm.TANGGAL BETWEEN ''',TGLAWAL,''' AND ''',TGLAKHIR,'''
		AND pk.RUANGAN LIKE ''',vRUANGAN,'''
		',IF(CARABAYAR=0,'',CONCAT(' AND pj.JENIS=',CARABAYAR)),'
		',IF(DOKTER=0,'',CONCAT(' AND ptm.MEDIS=',DOKTER)),'
		',IF(TINDAKAN = 0,'' , CONCAT(' AND tm.TINDAKAN =',TINDAKAN )),'
	GROUP BY tm.TINDAKAN