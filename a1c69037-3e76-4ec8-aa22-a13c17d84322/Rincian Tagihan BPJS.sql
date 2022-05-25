SELECT
#        ref.ID,
       ref.DESKRIPSI CARABAYAR,
#        rt.STATUS,
# rt.TAGIHAN,

    pp.NAMA,
    pp.NORM,
       t.NAMA TINDAKAN,
       b.NAMA OBAT,
       CONCAT(IF(rt.JENIS=1,'Administrasi',
                IF(rt.JENIS=3,'Tindakan',
                    IF(rt.JENIS=4, 'Obat',
                        IF(rt.JENIS=2,'Akomodasi', ""))))) LAYANAN,
       rt.JUMLAH,
       IF(r.DESKRIPSI IS NULL,'-',r.DESKRIPSI) RUANGAN,
      rt.TARIF,

        rt.JUMLAH*rt.TARIF AS TOTAL,
       p.TANGGAL TGL_MASUK
FROM pembayaran.rincian_tagihan rt
 LEFT JOIN master.referensi jb ON rt.JENIS=jb.ID AND jb.JENIS= 5
LEFT JOIN pembayaran.tagihan_pendaftaran ptp ON rt.TAGIHAN=ptp.TAGIHAN AND ptp.STATUS=1 AND ptp.UTAMA = 1
    LEFT JOIN pendaftaran.pendaftaran p ON ptp.PENDAFTARAN=p.NOMOR
    LEFT JOIN pendaftaran.penjamin pj ON p.NOMOR=pj.NOPEN
    LEFT JOIN master.pasien pp ON p.NORM=pp.NORM
    LEFT JOIN pendaftaran.tujuan_pasien tp ON p.NOMOR=tp.NOPEN
    LEFT JOIN master.ruangan r ON tp.RUANGAN=r.ID AND r.JENIS=5
    LEFT JOIN layanan.tindakan_medis tm ON tm.ID = rt.REF_ID AND rt.JENIS = 3
    LEFT JOIN master.tindakan t ON t.ID = tm.TINDAKAN
    LEFT JOIN master.tarif_administrasi tadm ON tadm.ID = rt.TARIF_ID AND rt.JENIS=  1
    LEFT JOIN master.administrasi adm ON adm.ID = tadm.ADMINISTRASI
    LEFT JOIN layanan.farmasi f ON f.ID = rt.REF_ID AND rt.JENIS = 4
    LEFT JOIN inventory.barang b ON b.ID = f.FARMASI
 LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
    WHERE ref.ID=2
#           rt.TAGIHAN = 2011060018 AND rt.STATUS = 1

# ORDER BY ref.JENIS





