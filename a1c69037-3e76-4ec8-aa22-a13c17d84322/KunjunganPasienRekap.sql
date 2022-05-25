SELECT
*
FROM pendaftaran.kunjungan k
WHERE RUANGAN = 101030109
	SELECT ref.*, a.*,
	       INST.NAMAINST,
	       INST.ALAMATINST,
	       CONCAT('LAPORAN REKAP KUNJUNGAN ',UPPER(jk.DESKRIPSI)) JENISLAPORAN
			, master.getHeaderLaporan('') INSTALASI
			, IF(0=0,'Semua',(SELECT ref.DESKRIPSI FROM master.referensi ref WHERE ref.ID=0 AND ref.JENIS=10)) CARABAYARHEADER 
		FROM master.referensi ref
			  LEFT JOIN (
								SELECT IF(tk.BARU=1,1,2) IDSTATUSKUNJUNGAN
										, COUNT(pd.NOMOR) JUMLAH
										, SUM(IF(ref.ID=1,1,0)) UMUM
										, SUM(IF(ref.ID=2,1,0)) JKN
										, SUM(IF(ref.ID=3,0,0)) INHEALTH
										, SUM(IF(ref.ID=4,0,0)) JKD
										, SUM(IF(iks.ID IS NOT NULL,1,0)) IKS
										, SUM(IF(p.JENIS_KELAMIN=1,1,0)) LAKILAKI
										, SUM(IF(p.JENIS_KELAMIN=2,1,0)) PEREMPUAN
									FROM master.pasien p
										, pendaftaran.pendaftaran pd
										  LEFT JOIN pendaftaran.penjamin pj ON pd.NOMOR=pj.NOPEN
										  LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
										  LEFT JOIN master.ikatan_kerja_sama iks ON ref.ID=iks.ID AND ref.JENIS=10
										  LEFT JOIN master.kartu_asuransi_pasien kap ON pd.NORM=kap.NORM AND ref.ID=kap.JENIS AND ref.JENIS=10
										  LEFT JOIN pendaftaran.surat_rujukan_pasien srp ON pd.RUJUKAN=srp.ID AND srp.`STATUS`!=0
										  LEFT JOIN master.ppk ppk ON srp.PPK=ppk.ID
										, pendaftaran.kunjungan tk
										, master.ruangan jkr
									WHERE p.NORM=pd.NORM AND pd.NOMOR=tk.NOPEN  AND tk.RUANGAN=jkr.ID AND jkr.JENIS=5 AND jkr.JENIS_KUNJUNGAN=0
											AND tk.MASUK BETWEEN '0000-00-00 00:00:00' AND '0000-00-00 00:00:00' AND pd.STATUS IN (1,2) AND tk.STATUS IN (1,2)
											AND tk.RUANGAN LIKE '%'
											
									GROUP BY IF(tk.BARU=1,1,2) ) a ON a.IDSTATUSKUNJUNGAN=ref.ID
			, (SELECT p.NAMA NAMAINST, p.ALAMAT ALAMATINST
				FROM aplikasi.instansi ai
					, master.ppk p
				WHERE ai.PPK=p.ID) INST
			, (SELECT DESKRIPSI FROM master.referensi jk WHERE jk.ID=0 AND jk.JENIS=15) jk
		   
		WHERE ref.JENIS=22
		GROUP BY ID
		