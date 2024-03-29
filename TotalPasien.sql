SELECT
    DATE_FORMAT(p.TANGGAL, '%M') TANGGGAL,
    COUNT(p.NORM) JUMLAH
FROM pendaftaran.pendaftaran p
WHERE p.TANGGAL BETWEEN '2023-01-01' AND '2023-05-31'
GROUP BY DATE_FORMAT(p.TANGGAL, '%M')