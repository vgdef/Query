SELECT
*
FROM pembayaran.diskon d
LEFT JOIN aplikasi.pengguna p ON p.ID=d.OLEH
WHERE TAGIHAN  = 2109290038