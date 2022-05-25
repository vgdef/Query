
	SELECT CONCAT('LAPORAN KUNJUNGAN ',UPPER(jk.DESKRIPSI),' PER PASIEN') JENISLAPORAN, INSERT(INSERT(LPAD(p.NORM,6,'0'),3,0,'-'),6,0,'-') NORM, master.getNamaLengkap(p.NORM) NAMALENGKAP
		, CONCAT(DATE_FORMAT(p.TANGGAL_LAHIR,'%d-%m-%Y'),' (',master.getCariUmur(pd.TANGGAL,TANGGAL_LAHIR),')') TGL_LAHIR
		, rjk.DESKRIPSI JENISKELAMIN
		, IF(DATE_FORMAT(p.TANGGAL,'%d-%m-%Y')=DATE_FORMAT(pd.TANGGAL,'%d-%m-%Y'),'Baru','Lama') STATUSPENGUNJUNG
		, pd.NOMOR NOPEN, DATE_FORMAT(pd.TANGGAL,'%d-%m-%Y %H:%i:%s') TGLREG
		, ref.DESKRIPSI CARABAYAR
		, IF(0=0,'Semua',(SELECT ref.DESKRIPSI FROM master.referensi ref WHERE ref.ID=0 AND ref.JENIS=10)) CARABAYARHEADER
		, pj.NOMOR NOMORSEP, kap.NOMOR NOMORKARTU, ppk.NAMA RUJUKAN, su.DESKRIPSI UNITPELAYANAN
		, INST.NAMAINST, INST.ALAMATINST
		, master.getHeaderLaporan('10102') INSTALASI
	FROM master.pasien p
		  LEFT JOIN master.referensi rjk ON p.JENIS_KELAMIN=rjk.ID AND rjk.JENIS=2
		, pendaftaran.pendaftaran pd
		  LEFT JOIN pendaftaran.penjamin pj ON pd.NOMOR=pj.NOPEN
		  LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
		  LEFT JOIN master.kartu_asuransi_pasien kap ON pd.NORM=kap.NORM AND ref.ID=kap.JENIS AND ref.JENIS=10
		  LEFT JOIN pendaftaran.surat_rujukan_pasien srp ON pd.RUJUKAN=srp.ID AND srp.`STATUS`!=0
		  LEFT JOIN master.ppk ppk ON srp.PPK=ppk.ID
		, pendaftaran.kunjungan tk
		, master.ruangan jkr
		  LEFT JOIN master.ruangan su ON su.ID=jkr.ID AND su.JENIS=5
		, (SELECT p.NAMA NAMAINST, p.ALAMAT ALAMATINST
			FROM aplikasi.instansi ai
				, master.ppk p
			WHERE ai.PPK=p.ID) INST
		, (SELECT DESKRIPSI FROM master.referensi jk WHERE jk.ID=1 AND jk.JENIS=15) jk
	WHERE p.NORM=pd.NORM AND pd.NOMOR=tk.NOPEN  AND tk.RUANGAN=jkr.ID AND jkr.JENIS=5 AND jkr.JENIS_KUNJUNGAN=1
			AND tk.MASUK BETWEEN '2022-05-13 00:00:00' AND '2022-05-21 00:00:00' AND pd.STATUS IN (1,2) AND tk.STATUS IN (1,2)
			AND tk.RUANGAN LIKE '10102%'
			
			ORDER BY pd.TANGGAL ASC
