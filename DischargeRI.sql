
	SELECT 
		DATE_FORMAT(lpp.TANGGAL, '%M') AS BULAN
	
		, COUNT(*) PPULANG
	FROM layanan.pasien_pulang lpp
		  LEFT JOIN master.referensi cr ON lpp.CARA=cr.ID AND cr.JENIS=45
		  LEFT JOIN master.referensi kd ON lpp.KEADAAN=kd.ID AND kd.JENIS=46,
		  pendaftaran.kunjungan pk
		  LEFT JOIN master.ruangan r ON pk.RUANGAN=r.ID AND r.JENIS=5,
		  pendaftaran.pendaftaran pp
		  LEFT JOIN master.pasien ps ON pp.NORM=ps.NORM
		  LEFT JOIN master.referensi rjk ON ps.JENIS_KELAMIN=rjk.ID AND rjk.JENIS=2
		  LEFT JOIN pendaftaran.penjamin pj ON pp.NOMOR=pj.NOPEN
		  LEFT JOIN master.referensi crbyr ON pj.JENIS=crbyr.ID AND crbyr.JENIS=10,
		  (SELECT DESKRIPSI FROM master.referensi jk WHERE jk.ID=3 AND jk.JENIS=15) jk,
		  (SELECT p.NAMA NAMAINST, p.ALAMAT ALAMATINST
				FROM aplikasi.instansi ai
					, master.ppk p
				WHERE ai.PPK=p.ID) INST
	WHERE lpp.KUNJUNGAN=pk.NOMOR AND lpp.`STATUS`=1 
		AND r.JENIS_KUNJUNGAN='3'
		
		AND pk.NOPEN=pp.NOMOR AND lpp.TANGGAL BETWEEN '2023-01-01 00:00:00' AND '2023-05-29 00:00:00'
		GROUP BY DATE_FORMAT(lpp.TANGGAL, '%M')
	