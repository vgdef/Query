SELECT rt.JUMLAH,
       rt.TARIF,
       rt.JUMLAH*rt.TARIF as total,
       rt.TARIF_ID
FROM pembayaran.rincian_tagihan rt