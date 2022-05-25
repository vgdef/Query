SELECT
# -- rt.TAGIHAN,
#        rt.STATUS,
#        tt.STATUS,
# ref.ID,
pp.NORM,
pp.NAMA,
# ref.DESKRIPSI CARABAYAR,
t.NAMA                                                TINDAKAN,
b.NAMA                                                OBAT,
CONCAT(IF(rt.JENIS = 1, 'Administrasi',
          IF(rt.JENIS = 3, 'Tindakan',
             IF(rt.JENIS = 4, 'Obat',
                IF(rt.JENIS = 2, 'Akomodasi', ""))))) LAYANAN,
rt.JUMLAH,
kp.TANGGAL,
IF(r.DESKRIPSI IS NULL, '-', r.DESKRIPSI)             RUANGAN,
rt.TARIF,
rt.JUMLAH * rt.TARIF AS                               TOTAL#         dd.SARANA_NON_AKOMODASI diskon , pppp.NAMA KASIR
FROM pembayaran.rincian_tagihan rt

         LEFT JOIN pembayaran.tagihan_pendaftaran ptp ON rt.TAGIHAN = ptp.TAGIHAN AND ptp.STATUS = 1 AND ptp.UTAMA = 1
         LEFT JOIN pendaftaran.pendaftaran p ON ptp.PENDAFTARAN = p.NOMOR
         LEFT JOIN pendaftaran.penjamin pj ON p.NOMOR = pj.NOPEN
         LEFT JOIN master.pasien pp ON p.NORM = pp.NORM
         LEFT JOIN pendaftaran.tujuan_pasien tp ON p.NOMOR = tp.NOPEN
         LEFT JOIN master.ruangan r ON tp.RUANGAN = r.ID AND r.JENIS = 5
         LEFT JOIN layanan.tindakan_medis tm ON tm.ID = rt.REF_ID AND rt.JENIS = 3
         LEFT JOIN master.tindakan t ON t.ID = tm.TINDAKAN
         LEFT JOIN master.tarif_administrasi tadm ON tadm.ID = rt.TARIF_ID AND rt.JENIS = 1
         LEFT JOIN master.administrasi adm ON adm.ID = tadm.ADMINISTRASI
         RIGHT JOIN pembayaran.pembayaran_tagihan kp ON kp.TAGIHAN = rt.TAGIHAN
         LEFT JOIN layanan.farmasi f ON f.ID = rt.REF_ID AND rt.JENIS = 4
         LEFT JOIN inventory.barang b ON b.ID = f.FARMASI
         LEFT JOIN pembayaran.tagihan tt ON tt.ID = rt.TAGIHAN
         LEFT JOIN master.referensi ref ON pj.JENIS = ref.ID AND ref.JENIS = 10
#     LEFT JOIN pembayaran.diskon dd ON dd.TAGIHAN=rt.TAGIHAN
#     LEFT JOIN aplikasi.pengguna pppp ON pppp.ID=dd.OLEH
WHERE rt.STATUS = 1
  AND
  -- rt.TAGIHAN = 2105100023
  -- AND
    kp.TANGGAL  BETWEEN DATE_FORMAT(NOW(), "2022-05-24") AND DATE_FORMAT(NOW(), "2022-05-25");

#          BETWEEN DATE_FORMAT(NOW(), "%Y-01-01") AND DATE_FORMAT(NOW(), "%Y-11-04")



