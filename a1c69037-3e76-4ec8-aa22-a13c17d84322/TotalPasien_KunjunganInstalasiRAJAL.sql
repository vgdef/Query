SELECT
       CASE WHEN TOTAL_PASIEN > 0 AND  TOTAL_PASIEN < 200 THEN 'PASIEN HARI INI'
           WHEN TOTAL_PASIEN > 100 AND TOTAL_PASIEN < 1000 THEN 'PASIEN BULAN INI'
           wHEN TOTAL_PASIEN > 1000  THEN 'PASIEN TAHUN INI' END AS ID,
       TOTAL_PASIEN
FROM (

SELECT COUNT(tk.NOMOR) TOTAL_PASIEN
          FROM pendaftaran.pendaftaran pd
          LEFT JOIN pendaftaran.penjamin pj ON pd.NOMOR=pj.NOPEN
          LEFT JOIN master.kartu_asuransi_pasien kap ON pd.NORM=kap.NORM AND pj.JENIS=kap.JENIS AND pj.JENIS=2
          LEFT JOIN bpjs.peserta bp ON pd.NORM=bp.norm AND pj.JENIS=2 AND kap.NOMOR=bp.noKartu
        , pendaftaran.kunjungan tk
        , master.ruangan su
          LEFT JOIN master.referensi jk ON su.JENIS_KUNJUNGAN=jk.ID AND jk.JENIS=15

       WHERE pd.NOMOR=tk.NOPEN AND pd.STATUS IN (1,2) AND tk.STATUS IN (1,2)
         AND tk.RUANGAN=su.ID AND su.JENIS=5 AND su.JENIS_KUNJUNGAN=1
         AND tk.MASUK BETWEEN DATE(NOW()) AND NOW()
UNION
SELECT  COUNT(tk.NOMOR) JUMLAHBULANINI
          FROM pendaftaran.pendaftaran pd
          LEFT JOIN pendaftaran.penjamin pj ON pd.NOMOR=pj.NOPEN
          LEFT JOIN master.kartu_asuransi_pasien kap ON pd.NORM=kap.NORM AND pj.JENIS=kap.JENIS AND pj.JENIS=2
          LEFT JOIN bpjs.peserta bp ON pd.NORM=bp.norm AND pj.JENIS=2 AND kap.NOMOR=bp.noKartu
        , pendaftaran.kunjungan tk
        , master.ruangan su
          LEFT JOIN master.referensi jk ON su.JENIS_KUNJUNGAN=jk.ID AND jk.JENIS=15

       WHERE pd.NOMOR=tk.NOPEN AND pd.STATUS IN (1,2) AND tk.STATUS IN (1,2)
         AND tk.RUANGAN=su.ID AND su.JENIS=5 AND su.JENIS_KUNJUNGAN=1
         AND tk.MASUK BETWEEN DATE_FORMAT(NOW(), "%Y-%m-01") AND  CONCAT(LAST_DAY(NOW())," 23:59:59")
UNION
SELECT COUNT(tk.NOMOR) JUMLAHTAHUNINI
     FROM pendaftaran.pendaftaran pd
         , pendaftaran.kunjungan tk
         , master.ruangan su
     LEFT JOIN master.referensi jk ON su.JENIS_KUNJUNGAN=jk.ID AND jk.JENIS=15
     WHERE pd.NOMOR=tk.NOPEN AND pd.STATUS IN (1, 2) AND tk.STATUS IN (1, 2)
     AND tk.RUANGAN=su.ID AND su.JENIS=5 AND su.JENIS_KUNJUNGAN=1
     AND tk.MASUK BETWEEN DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 1 YEAR), "%Y-01-01") AND DATE_FORMAT(NOW(), "%Y-12-31 23:59:59") ) AS TOTAL_PASIEN
