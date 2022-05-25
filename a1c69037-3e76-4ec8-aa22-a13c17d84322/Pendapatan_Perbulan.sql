SELECT CASE WHEN TOTAL = TOTAL THEN 'PENDAPATAN BULAN OKTOBER' END AS ID,
       SUM(TOTAL)                                                     PENDAPATAN
FROM pembayaran.pembayaran_tagihan pt
WHERE pt.TANGGAL BETWEEN DATE_FORMAT(NOW(), "%Y-%m-01") AND CONCAT(LAST_DAY(NOW()), " 23:59:59")
UNION
SELECT CASE WHEN TOTAL = TOTAL THEN 'PENDAPATAN BULAN SEPTEMBER' END AS ID,
       SUM(TOTAL)                                                       PENDAPATANBLN09
FROM pembayaran.pembayaran_tagihan pt
WHERE pt.TANGGAL BETWEEN DATE_FORMAT(NOW(), "%Y-09-01") AND DATE_FORMAT(NOW(), "%Y-10-01")
UNION
SELECT CASE WHEN TOTAL = TOTAL THEN 'PENDAPATAN BULAN AGUSTUS' END AS ID,
       SUM(TOTAL)                                                     PENDAPATANBLN08
FROM pembayaran.pembayaran_tagihan pt
# WHERE pt.TANGGAL BETWEEN DATE_FORMAT(NOW(), "%Y-03-01") AND DATE_FORMAT(NOW(), "%Y-04-01");
