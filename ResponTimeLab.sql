SELECT pp.NORM,p.NAMA, t.NAMA TINDAKAN,r.DESKRIPSI RUANGAN,
       olb.TANGGAL TGL_ORDER, k.MASUK TGL_TERIMA,
       hl.TANGGAL TGL_HASIL,ra.DESKRIPSI RUANGAN_AWAL,               --  , CONCAT(
               FLOOR(HOUR(TIMEDIFF(k.MASUK,olb.TANGGAL)) / 24) selisih_hari1, 'Hr',
               MOD(HOUR(TIMEDIFF(k.MASUK,olb.TANGGAL)), 24)selisih_jam1, 'Jam',
                  MINUTE(TIMEDIFF(k.MASUK,olb.TANGGAL))selisih_menit1, 'Mnt'                  ,
                     FLOOR(HOUR(TIMEDIFF(hl.TANGGAL,k.MASUK)) / 24)selisih_hari2, 'Hr',
                     MOD(HOUR(TIMEDIFF(hl.TANGGAL,k.MASUK)), 24)selisih_jam2, 'Jam',
                     MINUTE(TIMEDIFF(hl.TANGGAL,k.MASUK))selisih_menit2, 'Mnt'                  ,
                     FLOOR(HOUR(TIMEDIFF(hl.TANGGAL,olb.TANGGAL)) / 24)selisih_hari3, 'Hr',
                     MOD(HOUR(TIMEDIFF(hl.TANGGAL,olb.TANGGAL)), 24)selisih_jam3, 'Jam',
                     MINUTE(TIMEDIFF(hl.TANGGAL,olb.TANGGAL))selisih_menit3, 'Mnt'
FROM layanan.order_lab olb
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
                WHERE olb.TANGGAL BETWEEN '2023-04-30' AND '2023-05-07' AND olb.`STATUS`!=0
                   AND olb.NOMOR=k.REF AND k.RUANGAN=r.ID AND k.`STATUS`!=0
                   AND k.RUANGAN LIKE '101050101'
                   AND t.NAMA like 'darah rutin%'
                   GROUP BY olb.NOMOR