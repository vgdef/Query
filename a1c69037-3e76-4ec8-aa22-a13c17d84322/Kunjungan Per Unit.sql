
	SELECT su.DESKRIPSI SUBUNIT
			, COUNT(pd.NOMOR) JUMLAH
			, SUM(IF(ref.ID=1,1,0)) UMUM
			, SUM(IF(ref.ID=2,1,0)) JKN
			, SUM(IF(ref.ID=3,1,0)) INHEALTH
			, SUM(IF(ref.ID=4,0,0)) JKD
			, SUM(IF(iks.ID IS NOT NULL,1,0)) IKS
			, SUM(IF(p.JENIS_KELAMIN=1,1,0)) LAKILAKI
			, SUM(IF(p.JENIS_KELAMIN=2,1,0)) PEREMPUAN
			, SUM(IF(tk.BARU=1,1,0)) BARU
			, SUM(IF(tk.BARU=0,1,0)) LAMA
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
			  LEFT JOIN master.ruangan su ON su.ID=jkr.ID AND su.JENIS=5
			, (SELECT p.NAMA NAMAINST, p.ALAMAT ALAMATINST
				FROM aplikasi.instansi ai
					, master.ppk p
				WHERE ai.PPK=p.ID) INST
			  , (SELECT DESKRIPSI FROM master.referensi jk WHERE jk.ID=2 AND jk.JENIS=15) jk
		WHERE p.NORM=pd.NORM AND pd.NOMOR=tk.NOPEN AND pd.STATUS IN (1,2) AND tk.STATUS IN (1,2)
				AND tk.RUANGAN=jkr.ID AND jkr.JENIS=5 AND jkr.JENIS_KUNJUNGAN=1
				AND tk.MASUK BETWEEN '2022-05-13 00:00:00' AND '2022-05-21 00:00:00'
				AND tk.RUANGAN LIKE '%10102%'

		GROUP BY tk.RUANGAN