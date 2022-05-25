SELECT
*
FROM pembayaran.rincian_tagihan rt
LEFT JOIN pembayaran.tagihan_pendaftaran ptp ON rt.TAGIHAN = ptp.TAGIHAN AND ptp.STATUS = 1 AND ptp.UTAMA = 1
LEFT JOIN pendaftaran.pendaftaran p ON p.NOMOR=ptp.PENDAFTARAN
