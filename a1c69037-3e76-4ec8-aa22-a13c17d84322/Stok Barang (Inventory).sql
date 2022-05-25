SELECT ru.DESKRIPSI RUANGAN, st.NAMA NAMA_BARANG ,st.STOK, st.KET
FROM (SELECT r.id, r.DESKRIPSI
    FROM master.ruangan r
    WHERE r.JENIS_KUNJUNGAN= 11 AND r.ID = 101120101) AS ru
LEFT JOIN (
    SELECT br.RUANGAN, b.id, b.NAMA, br.STOK,
           CASE WHEN br.STOK > 0 AND br.STATUS = 1 THEN 'STOK ADA, AKTIF'
                WHEN br.STOK < 0 AND br.STATUS = 1 THEN 'STOK MINUS, AKTIF'
                WHEN br.STOK > 0 AND br.STATUS = 0 THEN 'STOK ADA, NON-AKTIF'
                WHEN br.STOK < 0 AND br.STATUS = 0 THEN 'STOK MINUS, NON-AKTIF'
                WHEN br.STOK = 0 AND br.STATUS = 1 THEN 'STOK NOL, AKTIF'
                ELSE 'STOK NOL, NON-AKTIF' END AS KET
                   FROM inventory.barang_ruangan  br
    LEFT JOIN inventory.barang b ON b.ID=br.BARANG
#     WHERE br.STATUS = 1
    GROUP BY br.ID
    ) st ON st.RUANGAN=ru.ID
ORDER BY st.ID ASC
