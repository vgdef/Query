SELECT
    CASE WHEN TOTAL_PASIEN = TOTAL_PASIEN THEN 'TOTAL PASIEN HARI INI' END AS ID,
       TOTAL_PASIEN

 FROM (
   SELECT COUNT(tk.NOMOR) TOTAL_PASIEN

        FROM pendaftaran.pendaftaran pd
           LEFT JOIN pendaftaran.penjamin pj ON pd.NOMOR=pj.NOPEN
           LEFT JOIN master.kartu_asuransi_pasien kap ON pd.NORM=kap.NORM AND pj.JENIS=kap.JENIS AND pj.JENIS=2
           LEFT JOIN bpjs.peserta bp ON pd.NORM=bp.norm AND pj.JENIS=2 AND kap.NOMOR=bp.noKartu
           LEFT JOIN master.referensi cr ON pj.JENIS=cr.ID AND cr.JENIS=10
           LEFT JOIN master.pasien p ON pd.NORM=p.NORM
         , pendaftaran.kunjungan tk
         , master.ruangan su
           LEFT JOIN master.referensi jk ON su.JENIS_KUNJUNGAN=jk.ID AND jk.JENIS=15
        WHERE pd.NOMOR=tk.NOPEN AND pd.STATUS IN (1,2) AND tk.STATUS IN (1,2)
          AND tk.RUANGAN=su.ID AND su.JENIS=5 AND su.JENIS_KUNJUNGAN=4
          AND tk.MASUK BETWEEN DATE(NOW()) AND NOW()) AS TOTAL_PASIEN