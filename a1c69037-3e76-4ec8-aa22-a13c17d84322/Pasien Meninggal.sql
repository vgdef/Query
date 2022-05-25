

	SELECT

		pp.NORM,
	       ps.NAMA PASIEN,
	       rr.DESKRIPSI JK,
	       cr.DESKRIPSI CARAKELUAR,
	       kd.DESKRIPSI KEADAANKELUAR
	FROM layanan.pasien_pulang lpp
		  LEFT JOIN master.referensi cr ON lpp.CARA=cr.ID AND cr.JENIS=45
		  LEFT JOIN master.referensi kd ON lpp.KEADAAN=kd.ID AND kd.JENIS=46,
		  pendaftaran.kunjungan pk
		  LEFT JOIN master.ruangan r ON pk.RUANGAN=r.ID AND r.JENIS=5,
		  pendaftaran.pendaftaran pp
		  LEFT JOIN master.pasien ps ON pp.NORM=ps.NORM
          LEFT JOIN `master`.referensi rr ON rr.ID=ps.JENIS_KELAMIN AND rr.JENIS=2
		  LEFT JOIN pendaftaran.penjamin pj ON pp.NOMOR=pj.NOPEN
		  LEFT JOIN master.referensi crbyr ON pj.JENIS=crbyr.ID AND crbyr.JENIS=10
		  LEFT JOIN master.ikatan_kerja_sama iks ON crbyr.ID=iks.ID AND crbyr.JENIS=10,
		  (SELECT DESKRIPSI FROM master.referensi jk WHERE jk.ID=0 AND jk.JENIS=15) jk,
		  (SELECT p.NAMA NAMAINST, p.ALAMAT ALAMATINST
				FROM aplikasi.instansi ai
					, master.ppk p
				WHERE ai.PPK=p.ID) INST
	WHERE lpp.KUNJUNGAN=pk.NOMOR AND lpp.`STATUS`=1 
		AND pk.RUANGAN LIKE '1010301%' AND r.JENIS_KUNJUNGAN='3'
		AND pk.STATUS IN(1,2)
	    AND pk.REF IS NULL
		AND pk.NOPEN=pp.NOMOR AND lpp.TANGGAL BETWEEN DATE_FORMAT(NOW(), "2021-01-01") AND DATE_FORMAT(NOW(), "2022-01-01")
	GROUP BY pp.NORM
	