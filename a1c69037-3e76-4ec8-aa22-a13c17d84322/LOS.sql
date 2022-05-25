SELECT
 SUM(LD)/SUM(DIPINDAHKAN+HIDUP+MATIKURANG48+MATILEBIH48) AVLOS
FROM (
    SELECT
           SUM(IF(pk.`STATUS` IN (1,2),1,0)) DIPINDAHKAN
             , SUM(IF(pd.CARA NOT IN (6,7),1,0)) HIDUP
                , SUM(DATEDIFF(pk.KELUAR, pk.MASUK)) LD
    ,SUM(IF(pd.CARA IN (6,7) AND HOUR(TIMEDIFF(pp.TANGGAL, pp.TANGGAL)) < 48,1,0)) MATIKURANG48
    ,SUM(IF(pd.CARA IN (6,7) AND HOUR(TIMEDIFF(pp.TANGGAL, pd.TANGGAL)) >= 48,1,0)) MATILEBIH48

						  FROM 	 layanan.pasien_pulang pd,
						       pendaftaran.kunjungan pk

						       LEFT JOIN master.ruang_kamar_tidur rkt ON pk.RUANG_KAMAR_TIDUR=rkt.ID
							    LEFT JOIN master.ruang_kamar rk ON rkt.RUANG_KAMAR=rk.ID
								 LEFT JOIN master.kelas_simrs_rl mapkls ON rk.KELAS=mapkls.KELAS
							  , master.ruangan r
							  , pendaftaran.pendaftaran pp
							    LEFT JOIN pendaftaran.penjamin pj ON pp.NOMOR=pj.NOPEN
							    LEFT JOIN pendaftaran.tujuan_pasien ptp ON pp.NOMOR=ptp.NOPEN
							    LEFT JOIN master.rl31_smf rlr ON ptp.SMF=rlr.ID
							    LEFT JOIN master.pasien p ON pp.NORM=p.NORM
							  , (SELECT TANGGAL TGL
									  FROM master.tanggal
									 WHERE TANGGAL BETWEEN '2021-05-30' AND '2021-05-31') bts
						 WHERE pk.RUANGAN=r.ID AND r.JENIS_KUNJUNGAN=3 AND pk.`STATUS` IN (1,2) AND pk.NOPEN=pp.NOMOR
						   AND DATE(pk.MASUK) < DATE_ADD(bts.TGL,INTERVAL 1 DAY)
							AND (DATE(pk.KELUAR) > bts.TGL OR pk.KELUAR IS NULL)
						) rl31