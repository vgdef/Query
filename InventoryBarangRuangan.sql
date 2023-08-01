SELECT b.NAMA NAMABARANG,
       r.DESKRIPSI RUANGANYGMINTA,
       rR.DESKRIPSI RUANGANGUDANG,
       pn.TANGGAL TGLPERMINTAAN,
       pgd.JUMLAH
FROM
    inventory.permintaan_detil pdl
    JOIN inventory.permintaan pn ON pn.NOMOR=pdl.PERMINTAAN
    JOIN inventory.barang b ON b.ID=pdl.BARANG
    JOIN master.ruangan r ON r.ID=pn.ASAL
    JOIN master.ruangan rR ON rR.ID=pn.TUJUAN
    JOIN inventory.pengiriman pg ON pg.PERMINTAAN=pn.NOMOR
JOIN pengiriman_detil pgd ON pgd.PENGIRIMAN=pg.NOMOR
WHERE b.ID IN (6162,6751) AND pg.STATUS!=0 AND pn.STATUS!=0 AND pdl.STATUS!=0
GROUP BY pdl.PERMINTAAN

