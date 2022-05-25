SELECT
       p.NORM,
       pp.NAMA NAMA_PASIEN,
       tt.NAMA TINDAKAN,
       b.NAMA OBAT,
       r.DESKRIPSI,
 CONCAT(IF(rt.JENIS=1,'Administrasi',
                IF(rt.JENIS=3,'Tindakan',
                    IF(rt.JENIS=4, 'Obat',
                        IF(rt.JENIS=2,'Akomodasi', ""))))) LAYANAN,
       rt.JUMLAH,
         rt.TARIF,
        rt.JUMLAH*rt.TARIF AS TOTAL,
        t.TANGGAL
FROM pembayaran.rincian_tagihan rt
    LEFT JOIN pembayaran.tagihan t ON t.ID=rt.TAGIHAN
    LEFT JOIN pembayaran.tagihan_pendaftaran tp ON tp.TAGIHAN=rt.TAGIHAN AND  tp.STATUS=1 AND tp.UTAMA = 1
    LEFT JOIN pendaftaran.pendaftaran p ON p.NOMOR=tp.PENDAFTARAN
    LEFT JOIN master.pasien pp ON p.NORM=pp.NORM
    LEFT JOIN pendaftaran.tujuan_pasien tp ON p.NOMOR=tp.NOPEN
    LEFT JOIN master.ruangan r ON tp.RUANGAN=r.ID AND r.JENIS=5
    LEFT JOIN layanan.tindakan_medis tm ON tm.ID=rt.REF_ID  AND rt.JENIS = 3
    LEFT JOIN master.tindakan tt ON tt.ID=tm.TINDAKAN
    LEFT JOIN layanan.farmasi f ON f.ID=rt.REF_ID  AND rt.JENIS = 4
    LEFT JOIN inventory.barang b ON b.ID=f.FARMASI
    LEFT JOIN pendaftaran.kunjungan k ON k.NOPEN=p.NOMOR AND rt.JENIS = 5
    LEFT JOIN master.ruang_kamar_tidur rkt ON rkt.ID=k.RUANG_KAMAR_TIDUR
    LEFT JOIN master.ruang_kamar rk ON rk.ID = rkt.RUANG_KAMAR
WHERE rt.TAGIHAN = 2107060070
