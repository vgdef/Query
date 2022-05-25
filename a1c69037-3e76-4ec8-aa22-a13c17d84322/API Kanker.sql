SELECT
       p.NOMOR nopen
     , kip.NOMOR      nik
     , psn.NAMA       nama_pasien
     , psn.JENIS_KELAMIN  id_jenis_kelamin
     , psn.TANGGAL_LAHIR  tanggal_lahir
     , IF(kip.ALAMAT IS NULL,' ',kip.ALAMAT) alamat
     , SUBSTRING(kip.WILAYAH,1,8) as id_kelurahan
     , SUBSTRING(kip.WILAYAH,1,6) as id_kecamatan
     , SUBSTRING(kip.WILAYAH,1,4) as id_kab_kota
     , SUBSTRING(kip.WILAYAH,1,2) as id_propinsi
     , IF(psn.ALAMAT IS NULL,' ',psn.ALAMAT) alamat_tinggal
     , SUBSTRING(psn.WILAYAH,1,8) as id_kelurahan_tinggal
     , SUBSTRING(psn.WILAYAH,1,6) as id_kecamatan_tinggal
     , SUBSTRING(psn.WILAYAH,1,4) as id_kab_kota_tinggal
     , SUBSTRING(psn.WILAYAH,1,2) as id_provinsi_tinggal
     , IF(kp.NOMOR IS NULL,' ',kp.NOMOR) kontak_pasien
     , k.MASUK       tanggal_masuk
     , IF(srp.PPK = 0, 0 , 1) as id_cara_masuk_pasien
     , CASE WHEN ppk.JENIS =  2 THEN 1
            WHEN ppk.JENIS = 1 THEN 2
         ELSE 0 END as id_asal_rujukan_pasien
     , IF(ppk.JENIS = 2, 2, '') asal_rujukan_pasien_fasyankes_lainnya
     , dm.ICD id_diagnosa_masuk
     , CASE WHEN k.RUANGAN LIKE '10101%' THEN 1
         WHEN k.RUANGAN LIKE '10103%' THEN "2,1"
         WHEN k.RUANGAN = 101020107 THEN "3,2"
         WHEN k.RUANGAN = 101020102 THEN "3,3"
         WHEN k.RUANGAN = 101020103 THEN "3,4"
         WHEN k.RUANGAN = 101020101 THEN "3,5"
         WHEN k.RUANGAN IN (101020113,101020115,101020116) THEN "3,6"
         WHEN k.RUANGAN = 101020105 THEN "3,8"
         WHEN k.RUANGAN = 101020111 THEN "3,9"
         WHEN k.RUANGAN = 101020109 THEN "3,10"
         WHEN k.RUANGAN = 101020108 THEN "3,11"
         WHEN k.RUANGAN = 101020112 THEN "3,12"
         WHEN k.RUANGAN = 101020103 THEN "3,13"
         WHEN k.RUANGAN = 101020106 THEN "3,14"
         WHEN k.RUANGAN = 101020109 THEN "3,15"
         WHEN k.RUANGAN = 101020114 THEN "3,17"
         WHEN k.RUANGAN = 101060101 THEN "4,1"
         WHEN k.RUANGAN = 101050101 THEN "4,2"
         WHEN k.RUANGAN = 101050102 THEN "4,3"
         WHEN k.RUANGAN = 101080101 THEN "4,4"
         WHEN k.RUANGAN LIKE '1010401%' THEN "2,2"

         END as id_sub_instalasi_unit
     , IF(d.KODE IS NULL,'',d.KODE) id_diagnosa_utama
     , IF(d1.KODE IS NULL,'',d1.KODE) id_diagnosa_sekunder1
     , IF(d2.KODE IS NULL,'',d2.KODE) id_diagnosa_sekunder2
     , IF(d3.KODE IS NULL,'',d3.KODE) id_diagnosa_sekunder3
     , d.TANGGAL     tanggal_diagnosa
     , k.KELUAR      tanggal_keluar
     , CASE
         WHEN cr.ID = 1 THEN "1"
         WHEN cr.ID = 2 THEN "2"
         WHEN cr.ID = 3 THEN "3"
         WHEN cr.ID = 4 THEN "6"
         WHEN cr.ID = 5 THEN "4"
         WHEN cr.ID = 6 THEN "7"
         WHEN cr.ID = 7 THEN "8"
         ELSE "-" END as id_cara_keluar
     , CASE
         WHEN kd.ID = 2 THEN "3"
         WHEN kd.ID = 3 THEN "4"
         WHEN kd.ID = 4 THEN "5"
         WHEN kd.ID = 5 THEN "6"
         ELSE "7" END as id_keadaan_keluar
     , IF(pma.DIAGNOSA IS NULL,'-',pma.DIAGNOSA)  id_sebab_kematian_langsung_1a
     , IF(pmb.DIAGNOSA IS NULL,'-',pmb.DIAGNOSA)  id_sebab_kematian_langsung_1b
     , IF(pmc.DIAGNOSA IS NULL,'-',pmc.DIAGNOSA)  id_sebab_kematian_langsung_1c
     , IF(pmd.DIAGNOSA IS NULL,'-',pmd.DIAGNOSA)  id_sebab_kematian_langsung_1d
#      , CASE
# #          WHEN cb.ID = 1 THEN "1"
# #          WHEN cb.ID = 2 THEN "2"
# #          WHEN cb.ID IN (3,6) THEN "6"
# #          ELSE "-" END AS id_cara_bayar
     , IF(cb.ID IS NULL,'-',cb.ID) id_cara_bayar
     , IF(kap.NOMOR IS NULL,'-',kap.NOMOR) nomor_bpjs


		FROM pendaftaran.pendaftaran p
         LEFT JOIN medicalrecord.diagnosa d ON p.NOMOR = d.NOPEN AND d.UTAMA = 1
         LEFT JOIN medicalrecord.diagnosa d1 ON p.NOMOR = d1.NOPEN AND d1.UTAMA = 2
		 LEFT JOIN medicalrecord.diagnosa d2 ON p.NOMOR = d2.NOPEN AND d2.UTAMA = 2
		 LEFT JOIN medicalrecord.diagnosa d3 ON p.NOMOR = d3.NOPEN AND d3.UTAMA = 2
         LEFT JOIN master.pasien psn ON psn.NORM = p.NORM
         LEFT JOIN master.kartu_identitas_pasien kip ON kip.NORM = psn.NORM
         LEFT JOIN master.kontak_pasien kp ON kp.NORM = psn.NORM
         LEFT JOIN pendaftaran.kunjungan k ON k.NOPEN = p.NOMOR
         LEFT JOIN pendaftaran.penjamin pj ON p.NOMOR = pj.NOPEN
         LEFT JOIN master.referensi ref ON pj.JENIS = ref.ID AND ref.JENIS = 10
         LEFT JOIN layanan.pasien_pulang pp ON pp.NOPEN = p.NOMOR
         LEFT JOIN master.referensi cr ON cr.ID = pp.CARA AND cr.JENIS = 45
         LEFT JOIN master.referensi kd ON kd.ID = pp.KEADAAN AND kd.JENIS = 46
         LEFT JOIN pendaftaran.penjamin pnj ON pnj.NOPEN = p.NOMOR
         LEFT JOIN master.referensi cb ON cb.ID = pp.KEADAAN AND cb.JENIS = 10
         LEFT JOIN master.kartu_asuransi_pasien kap ON kap.NORM=p.NORM
         LEFT JOIN pendaftaran.surat_rujukan_pasien srp ON srp.NORM=p.NORM
         LEFT JOIN layanan.pasien_meninggal pma ON pma.KUNJUNGAN=k.NOMOR
		 LEFT JOIN layanan.pasien_meninggal pmb ON pmb.KUNJUNGAN=k.NOMOR
		 LEFT JOIN layanan.pasien_meninggal pmc ON pmc.KUNJUNGAN=k.NOMOR
		 LEFT JOIN layanan.pasien_meninggal pmd ON pmd.KUNJUNGAN=k.NOMOR
         LEFT JOIN master.diagnosa_masuk dm ON dm.ID=srp.DIAGNOSA_MASUK
         LEFT JOIN master.ppk ON ppk.ID=srp.PPK
         LEFT JOIN master.ruangan r ON k.RUANGAN = r.ID
		WHERE
     	   d.KODE BETWEEN 'C00' AND 'D48'

		GROUP BY p.NOMOR
		ORDER BY k.MASUK;