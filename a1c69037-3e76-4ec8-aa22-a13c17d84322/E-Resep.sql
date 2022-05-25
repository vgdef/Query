SELECT
       master.getNamaLengkapPegawai(p.NIP) DPJP,
#        master.getNamaLengkap(pp.NORM) PASIEN,
       pgn.NAMA                            YANG_MERESEPKAN,
       --  p.NIP,
       pp.NORM,
       b.NAMA                              NAMA_OBAT,
       pbd.JUMLAH                          BARANG_MASUK,
       odr.JUMLAH                          BARANG_KELUAR,
       pd.NAMA                             PENYEDIA,
       pbd.NO_BATCH,
       pbd.MASA_BERLAKU,
       rg.DESKRIPSI                        RUANGAN,
       pbd.HARGA                           HARGA_BELI,
       hb.HARGA_JUAL,
       ors.TANGGAL                         TGL_KELUAR
#        br.STATUS
       -- , SUM(odr.JUMLAH)
       -- ppp.NAMA NAMA_PASIEN
       --  pppp.NAMA APOTEKER
FROM layanan.order_detil_resep odr
         LEFT JOIN inventory.barang b ON b.ID = odr.FARMASI
         LEFT JOIN layanan.order_resep ors ON ors.NOMOR = odr.ORDER_ID
         LEFT JOIN aplikasi.pengguna pgn ON pgn.ID = ors.OLEH
         LEFT JOIN master.dokter d ON d.ID = ors.DOKTER_DPJP
         LEFT JOIN master.pegawai p ON p.NIP = d.NIP
         LEFT JOIN pendaftaran.kunjungan kjgn ON kjgn.NOMOR = ors.KUNJUNGAN
         LEFT JOIN master.ruangan rg ON rg.ID = kjgn.RUANGAN
         LEFT JOIN pendaftaran.pendaftaran pp ON kjgn.NOPEN = pp.NOMOR
         LEFT JOIN master.pasien ppp ON pp.NORM = ppp.NORM
         LEFT JOIN inventory.penyedia pd ON pd.ID = b.PENYEDIA
         LEFT JOIN inventory.penerimaan_barang_detil pbd ON pbd.BARANG = b.ID
         LEFT JOIN inventory.penerimaan_barang pb ON pb.ID = pbd.PENERIMAAN
         LEFT JOIN inventory.harga_barang hb ON hb.BARANG = b.ID
         LEFT JOIN inventory.barang_ruangan br ON br.BARANG = b.ID

WHERE
# pp.NORM = 11123
    --  b.ID = 5

# IN (434,693,571,1162)
#  -- AND
  ors.TANGGAL  BETWEEN DATE_FORMAT(NOW(), "%Y-02-01") AND DATE_FORMAT(NOW(), "%Y-02-28")


-- AND ors.NOMOR = 141010101012105200008
GROUP BY b.ID
# ORDER BY ors.TANGGAL ASC
