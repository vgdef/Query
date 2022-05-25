SELECT
     p.NORM,
        JK,
       psn.TANGGAL_LAHIR,
       KODE
FROM medicalrecord.diagnosa d
LEFT JOIN pendaftaran.pendaftaran p ON p.NOMOR = d.NOPEN
LEFT JOIN (
        SELECT
               pp.NORM,
               pp.TANGGAL_LAHIR,
               pp.JENIS_KELAMIN
        FROM master.pasien pp)  as psn ON psn.NORM=p.NORM
LEFT JOIN (
        SELECT r.ID,
           r.DESKRIPSI JK
        FROM master.referensi r
        WHERE r.JENIS = 2)  as jk ON jk.ID=psn.JENIS_KELAMIN
LEFT JOIN pendaftaran.kunjungan k ON k.NOPEN = p.NOMOR
WHERE d.KODE = 'I10'
#           IN ('G44.2','J18.8','C71.9','E10.7','E11.0','H81.1','I10','I50.0','I62.0','I63.3')
AND p.TANGGAL BETWEEN DATE_FORMAT(NOW(), "2021-01-01") AND DATE_FORMAT(NOW(), "2021-12-31")
AND d.STATUS = 1
AND k.RUANGAN LIKE '1010301%'
GROUP BY p.NORM