SELECT * FROM (

			SELECT INST.*, 'January' BULAN, '2023' TAHUN, md.KODE KODEICD10,
					(SELECT ms.STR FROM master.mrconso ms WHERE ms.SAB='ICD10_1998' AND TTY IN ('PX', 'PT') AND ms.CODE=md.KODE LIMIT 1) DIAGNOSA, 
					 COUNT(md.KODE) JUMLAH, SUM(IF(ps.JENIS_KELAMIN=1 AND lpp.CARA NOT IN (6,7),1,0)) LAKIHIDUP, SUM(IF(ps.JENIS_KELAMIN=2 AND lpp.CARA NOT IN (6,7),1,0)) WANITAHIDUP,
					 SUM(IF(ps.JENIS_KELAMIN=1 AND lpp.CARA IN (6,7),1,0)) LAKIMATI, SUM(IF(ps.JENIS_KELAMIN=2 AND lpp.CARA IN (6,7),1,0)) WANITAMATI,
					 SUM(IF(ps.JENIS_KELAMIN=1,1,0)) JMLLAKI, 
					 SUM(IF(ps.JENIS_KELAMIN=2,1,0)) JMLWANITA, 
					 SUM(IF(lpp.CARA IN (6,7),1,0)) JMLMATI,
					 SUM(IF(ps.JENIS_KELAMIN=1 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=1,1,0)) KLP1LAKI,
					 SUM(IF(ps.JENIS_KELAMIN=2 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=1,1,0)) KLP1WANITA,
					 SUM(IF(ps.JENIS_KELAMIN=1 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=2,1,0)) KLP2LAKI,
					 SUM(IF(ps.JENIS_KELAMIN=2 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=2,1,0)) KLP2WANITA,
					 SUM(IF(ps.JENIS_KELAMIN=1 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=3,1,0)) KLP3LAKI,
					 SUM(IF(ps.JENIS_KELAMIN=2 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=3,1,0)) KLP3WANITA,
					 SUM(IF(ps.JENIS_KELAMIN=1 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=4,1,0)) KLP4LAKI,
					 SUM(IF(ps.JENIS_KELAMIN=2 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=4,1,0)) KLP4WANITA,
					 SUM(IF(ps.JENIS_KELAMIN=1 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=5,1,0)) KLP5LAKI,
					 SUM(IF(ps.JENIS_KELAMIN=2 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=5,1,0)) KLP5WANITA,
					 SUM(IF(ps.JENIS_KELAMIN=1 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=6,1,0)) KLP6LAKI,
					 SUM(IF(ps.JENIS_KELAMIN=2 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=6,1,0)) KLP6WANITA,
					 SUM(IF(ps.JENIS_KELAMIN=1 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=7,1,0)) KLP7LAKI,
					 SUM(IF(ps.JENIS_KELAMIN=2 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=7,1,0)) KLP7WANITA,
					 SUM(IF(ps.JENIS_KELAMIN=1 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=8,1,0)) KLP8LAKI,
					 SUM(IF(ps.JENIS_KELAMIN=2 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=8,1,0)) KLP8WANITA,
					 SUM(IF(ps.JENIS_KELAMIN=1 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=9,1,0)) KLP9LAKI,
					 SUM(IF(ps.JENIS_KELAMIN=2 AND master.getKelompokUmur(pp.TANGGAL, ps.TANGGAL_LAHIR)=9,1,0)) KLP9WANITA
			FROM pendaftaran.kunjungan pk
				  LEFT JOIN master.ruangan r ON pk.RUANGAN=r.ID AND r.JENIS=5
				  LEFT JOIN layanan.pasien_pulang lpp ON lpp.KUNJUNGAN=pk.NOMOR AND lpp.`STATUS`=1
				  LEFT JOIN master.referensi cr ON lpp.CARA=cr.ID AND cr.JENIS=45
				  LEFT JOIN master.referensi kd ON lpp.KEADAAN=kd.ID AND kd.JENIS=46,
				  pendaftaran.pendaftaran pp
				  LEFT JOIN master.pasien ps ON pp.NORM=ps.NORM
				  LEFT JOIN pendaftaran.penjamin pj ON pp.NOMOR=pj.NOPEN
				  LEFT JOIN master.referensi crbyr ON pj.JENIS=crbyr.ID AND crbyr.JENIS=10,
				  medicalrecord.diagnosa md,
				  pendaftaran.tujuan_pasien tp,
				  (SELECT p.KODE KODERS, p.NAMA NAMAINST, p.WILAYAH KODEPROP, w.DESKRIPSI KOTA
								FROM aplikasi.instansi ai
									, master.ppk p
									, master.wilayah w
								WHERE ai.PPK=p.ID AND p.WILAYAH=w.ID) INST
			WHERE  pk.NOPEN=md.NOPEN AND md.STATUS=1 AND md.INA_GROUPER=0 AND pp.NOMOR=tp.NOPEN AND pk.RUANGAN=tp.RUANGAN
				AND r.JENIS_KUNJUNGAN=3
				AND pk.NOPEN=pp.NOMOR AND lpp.TANGGAL BETWEEN '2023-01-01 00:00:00' AND '2023-01-31 00:00:00'
				AND LEFT(md.KODE,1) NOT IN ('Z','O','','R','V','W','Y')
			GROUP BY md.KODE) c
			
		ORDER BY JUMLAH DESC
		LIMIT 10
	