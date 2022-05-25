SELECT
       SUM(HP) HP
       , @JMLTT:=(SELECT COUNT(TEMPAT_TIDUR)
									FROM master.ruang_kamar_tidur rkt
										, master.ruang_kamar rk
									WHERE rkt.`STATUS`!=0 AND rkt.RUANG_KAMAR=rk.ID AND rk.STATUS!=0 AND
									      rk.KELAS IN(4,5)) JMLTT ,


IF(SUM(HP)=0 OR @JMLTT=0,0,ROUND((SUM(HP) * 100) / (@JMLTT * (DATEDIFF('2021-10-31', '2021-10-01')+1)),2)) BOR
FROM (
    SELECT
							   SUM(IF(pk.`STATUS` IN (1,2),1,0)) HP

						  FROM pendaftaran.kunjungan pk
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
									 WHERE TANGGAL BETWEEN '2021-10-01' AND '2021-10-31') bts
						 WHERE pk.RUANGAN=r.ID AND rk.KELAS IN (4,5) AND r.JENIS_KUNJUNGAN=3 AND pk.`STATUS` IN (1,2) AND pk.NOPEN=pp.NOMOR
						   AND DATE(pk.MASUK) < DATE_ADD(bts.TGL,INTERVAL 1 DAY)
							AND (DATE(pk.KELUAR) > bts.TGL OR pk.KELUAR IS NULL)
						) rl31