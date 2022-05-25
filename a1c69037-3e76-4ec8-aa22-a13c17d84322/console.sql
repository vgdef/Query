
		SELECT CONCAT(IF(jk.ID=1,'Laporan Pengunjung ', IF(jk.ID=2,'Laporan Kunjungan ',IF(jk.ID=3,'Laporan Pasien Masuk ',''))), CONCAT(jk.DESKRIPSI,' Per Pasien')) JENISLAPORAN
				, p.NORM NORM, CONCAT(master.getNamaLengkap(p.NORM)) NAMALENGKAP
				, CONCAT(DATE_FORMAT(p.TANGGAL_LAHIR,'%d-%m-%Y'),' (',master.getCariUmur(pd.TANGGAL,p.TANGGAL_LAHIR),')') TGL_LAHIR
				, IF(p.JENIS_KELAMIN=1,'L','P') JENISKELAMIN
				, IF(DATE_FORMAT(p.TANGGAL,'%d-%m-%Y')=DATE_FORMAT(tk.MASUK,'%d-%m-%Y'),'Baru','Lama') STATUSPENGUNJUNG
				, pd.NOMOR NOPEN, DATE_FORMAT(pd.TANGGAL,'%d-%m-%Y %H:%i:%s') TGLREG, DATE_FORMAT(tk.MASUK,'%d-%m-%Y %H:%i:%s') TGLTERIMA
				, DATE_FORMAT(TIMEDIFF(tk.MASUK,pd.TANGGAL),'%H:%i:%s') SELISIH
				, ref.DESKRIPSI CARABAYAR
				, master.getHeaderLaporan('10102') INSTALASI
			   , IF(0=0,'Semua',(SELECT ref.DESKRIPSI FROM master.referensi ref WHERE ref.ID=0 AND ref.JENIS=10)) CARABAYARHEADER
				, pj.NOMOR NOMORSEP, kap.NOMOR NOMORKARTU, ppk.NAMA RUJUKAN, r.DESKRIPSI UNITPELAYANAN, srp.DOKTER
				, INST.NAMAINST, INST.ALAMATINST
				, master.getNamaLengkapPegawai(mp.NIP) PENGGUNA
				, master.getNamaLengkapPegawai(dok.NIP) DOKTER_REG
			FROM master.pasien p
				  LEFT JOIN master.referensi rjk ON p.JENIS_KELAMIN=rjk.ID AND rjk.JENIS=2
				, pendaftaran.pendaftaran pd
				  LEFT JOIN pendaftaran.penjamin pj ON pd.NOMOR=pj.NOPEN
				  LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
				  LEFT JOIN master.kartu_asuransi_pasien kap ON pd.NORM=kap.NORM AND ref.ID=kap.JENIS AND ref.JENIS=10
				  LEFT JOIN pendaftaran.surat_rujukan_pasien srp ON pd.RUJUKAN=srp.ID AND srp.`STATUS`!=0
				  LEFT JOIN master.ppk ppk ON srp.PPK=ppk.ID
				  LEFT JOIN aplikasi.pengguna us ON pd.OLEH=us.ID AND us.`STATUS`!=0
		        LEFT JOIN master.pegawai mp ON us.NIP=mp.NIP AND mp.`STATUS`!=0
				, pendaftaran.tujuan_pasien tp
				  LEFT JOIN master.ruangan r ON tp.RUANGAN=r.ID AND r.JENIS=5
				  LEFT JOIN master.dokter dok ON tp.DOKTER=dok.ID
				, pendaftaran.kunjungan tk
				, master.ruangan jkr
				  LEFT JOIN master.ruangan su ON su.ID=jkr.ID AND su.JENIS=5
				, (SELECT p.NAMA NAMAINST, p.ALAMAT ALAMATINST
					FROM aplikasi.instansi ai
						, master.ppk p
					WHERE ai.PPK=p.ID) INST
				, (SELECT ID, DESKRIPSI FROM master.referensi jk WHERE jk.ID=1 AND jk.JENIS=15) jk

			WHERE p.NORM=pd.NORM AND pd.NOMOR=tp.NOPEN  AND pd.NOMOR=tk.NOPEN AND tp.RUANGAN=tk.RUANGAN AND pd.STATUS IN (1,2) AND tk.REF IS NULL
					AND tk.RUANGAN=jkr.ID AND jkr.JENIS=5 AND tk.MASUK BETWEEN '2022-05-17 00:00:00' AND '2022-05-21 00:00:00' AND tk.STATUS IN (1,2)
					AND jkr.JENIS_KUNJUNGAN=1 AND tp.RUANGAN LIKE '10102%'

