
				SELECT RAND() IDX, olb.NOMOR, olb.KUNJUNGAN, olb.TANGGAL TGL_ORDER, r.DESKRIPSI RUANGAN, k.MASUK TGL_TERIMA, ra.DESKRIPSI RUANGAN_AWAL, hl.TANGGAL TGL_HASIL
					   , CONCAT(
							FLOOR(HOUR(TIMEDIFF(k.MASUK,olb.TANGGAL)) / 24), ' Hr ',
							MOD(HOUR(TIMEDIFF(k.MASUK,olb.TANGGAL)), 24), ' Jam ',
							MINUTE(TIMEDIFF(k.MASUK,olb.TANGGAL)), ' Mnt ') AS SELISIH1
						, CONCAT(
 							FLOOR(HOUR(TIMEDIFF(hl.TANGGAL,k.MASUK)) / 24), ' Hr ',
 							MOD(HOUR(TIMEDIFF(hl.TANGGAL,k.MASUK)), 24), ' Jam ',
 							MINUTE(TIMEDIFF(hl.TANGGAL,k.MASUK)), ' Mnt ') AS SELISIH2
						, CONCAT(
 							FLOOR(HOUR(TIMEDIFF(hl.TANGGAL,olb.TANGGAL)) / 24), ' Hr ',
 							MOD(HOUR(TIMEDIFF(hl.TANGGAL,olb.TANGGAL)), 24), ' Jam ',
 							MINUTE(TIMEDIFF(hl.TANGGAL,olb.TANGGAL)), ' Mnt ') AS SELISIH3
 						, TIMEDIFF(k.MASUK,olb.TANGGAL)AS RSELISIH1
     					, TIMEDIFF(hl.TANGGAL,k.MASUK)AS RSELISIH2
      				, TIMEDIFF(hl.TANGGAL,olb.TANGGAL)AS RSELISIH3
						, master.getHeaderLaporan('101060101') INSTALASI
						, IF(0=0,'Semua',ref.DESKRIPSI) CARABAYARHEADER
						, IF(0=0,'Semua',master.getNamaLengkapPegawai(dok.NIP)) DOKTERHEADER
						, IF(11549=0,'Semua',t.NAMA) TINDAKANHEADER
						, INST.NAMAINST, INST.ALAMATINST
						, p.NORM, master.getNamaLengkap(p.NORM) NAMALENGKAP
						, master.getCariUmur(pp.TANGGAL,p.TANGGAL_LAHIR) TGL_LAHIR
						, IF(p.JENIS_KELAMIN=1,'L','P') JENISKELAMIN
						, ref.DESKRIPSI CARABAYAR
					FROM layanan.order_rad olb
					     LEFT JOIN pendaftaran.kunjungan a ON olb.KUNJUNGAN=a.NOMOR AND a.`STATUS`!=0
					     LEFT JOIN master.ruangan ra ON a.RUANGAN=ra.ID
						, pendaftaran.kunjungan k
						  LEFT JOIN layanan.tindakan_medis tm ON k.NOMOR=tm.KUNJUNGAN AND tm.`STATUS`!=0
						  LEFT JOIN master.tindakan t ON tm.TINDAKAN=t.ID
						  LEFT JOIN layanan.petugas_tindakan_medis ptm ON tm.ID=ptm.TINDAKAN_MEDIS AND ptm.JENIS=1 AND KE=1
						  LEFT JOIN master.dokter dok ON ptm.MEDIS=dok.ID
						  LEFT JOIN layanan.hasil_rad hl ON tm.ID=hl.TINDAKAN_MEDIS AND k.FINAL_HASIL=1
						  LEFT JOIN pendaftaran.pendaftaran pp ON k.NOPEN=pp.NOMOR AND pp.`STATUS`!=0
						  LEFT JOIN pendaftaran.penjamin pj ON pp.NOMOR=pj.NOPEN
						  LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
						  LEFT JOIN master.pasien p ON pp.NORM=p.NORM
						, master.ruangan r
						, (SELECT p.NAMA NAMAINST, p.ALAMAT ALAMATINST
										FROM aplikasi.instansi ai
											, master.ppk p
										WHERE ai.PPK=p.ID) INST
					WHERE olb.TANGGAL BETWEEN '2023-04-01 00:00:00' AND '2023-05-01 00:00:00' AND olb.`STATUS`!=0
					 AND olb.NOMOR=k.REF AND k.RUANGAN=r.ID AND k.`STATUS`!=0
					 AND k.RUANGAN LIKE '101060101%'


						 AND tm.TINDAKAN  IN (11549
				  GROUP BY olb.NOMOR
