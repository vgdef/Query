SELECT
       master.getNamaLengkapPegawai(p.NIP) DPJP,
       pgn.NAMA YG_MERESEPKAN,
b.NAMA BARANG,
       f.JUMLAH JML_KELUAR,
       pd.NAMA PENYEDIA,
              pbd.NO_BATCH,
       pbd.MASA_BERLAKU,
       rg.DESKRIPSI                        RUANGAN,
       hb.HARGA_JUAL,
       f.TANGGAL

FROM layanan.farmasi f
LEFT JOIN pendaftaran.kunjungan k ON k.NOMOR=f.KUNJUNGAN
LEFT JOIN layanan.order_resep ors ON ors.NOMOR=k.REF
LEFT JOIN layanan.order_detil_resep odr ON odr.ORDER_ID=ors.NOMOR
LEFT JOIN inventory.barang b ON b.ID=odr.FARMASI
        LEFT JOIN aplikasi.pengguna pgn ON pgn.ID = ors.OLEH
         LEFT JOIN master.dokter d ON d.ID = ors.DOKTER_DPJP
         LEFT JOIN master.pegawai p ON p.NIP = d.NIP
     LEFT JOIN inventory.penyedia pd ON pd.ID = b.PENYEDIA
      LEFT JOIN master.ruangan rg ON rg.ID = k.RUANGAN
         LEFT JOIN pendaftaran.pendaftaran pp ON k.NOPEN = pp.NOMOR
LEFT JOIN inventory.penerimaan_barang_detil pbd ON pbd.BARANG = b.ID
         LEFT JOIN inventory.penerimaan_barang pb ON pb.ID = pbd.PENERIMAAN
 LEFT JOIN inventory.harga_barang hb ON hb.BARANG = b.ID
--  MASUKAN ID_OBAT 341 ADA DI FILE EXCEL (CARI SATUPERSATU)
WHERE odr.FARMASI = 693

-- JANGAN DIHAPUS
   AND f.TANGGAL > DATE_ADD(NOW(), INTERVAL -7 DAY)
GROUP BY ors.TANGGAL