SELECT
    b.NAMA NAMABARANG,
    hb.HARGA_JUAL HARGAJUAL,
    r.DESKRIPSI RUANGAN,
    IF(br.STATUS=1,'AKTIF','TIDAK AKTIF') STATUS

FROM inventory.barang b
JOIN inventory.harga_barang hb ON hb.BARANG=b.ID
JOIN inventory.barang_ruangan br ON br.BARANG=b.ID
JOIN master.ruangan r On r.ID=br.RUANGAN
WHERE br.RUANGAN LIKE '1011201%' AND b.STATUS!=0 AND br.STATUS!=0 AND hb.STATUS!=0
GROUP BY b.ID;

SELECT
    t.NAMA TINDAKAN,
    tt.SARANA TARIF,
    tt.NOMOR_SK,
    IF(t.STATUS=1,'AKTIF','TIDAK AKTIF') STATUS
FROM master.tindakan t
JOIN master.tarif_tindakan tt ON tt.TINDAKAN=t.ID
WHERE t.STATUS!=0 AND tt.STATUS!=0
GROUP BY t.ID;