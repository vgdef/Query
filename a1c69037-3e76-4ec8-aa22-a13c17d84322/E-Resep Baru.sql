SELECT
  master.getNamaLengkapPegawai(p.NIP) DPJP
#   ,p.NIP
  , pgn.NAMA YGMERESEPKAN
#   ,pgn.NIP NIP_PENGGUNA
  , b.NAMA BARANG
  , pbd.JUMLAH BARANG_MASUK
  , odr.JUMLAH BARANG_KELUAR
  , rg.DESKRIPSI RUANGAN
  , rs.TANGGAL TGLRESEP
FROM layanan.order_detil_resep odr
LEFT JOIN layanan.order_resep rs ON rs.NOMOR = odr.ORDER_ID
LEFT JOIN aplikasi.pengguna pgn ON pgn.ID = rs.OLEH
LEFT JOIN master.dokter d ON d.ID = rs.DOKTER_DPJP
LEFT JOIN master.pegawai p ON p.NIP = d.NIP
LEFT JOIN inventory.barang b ON b.ID = odr.FARMASI
LEFT JOIN pendaftaran.kunjungan kjgn ON kjgn.NOMOR = rs.KUNJUNGAN
    LEFT JOIN pendaftaran.pendaftaran pp ON pp.NOMOR=kjgn.NOPEN
LEFT JOIN master.ruangan rg ON rg.ID = kjgn.RUANGAN
LEFT JOIN inventory.penerimaan_barang_detil pbd ON pbd.BARANG = b.ID

    WHERE pp.NORM = 14906 AND
          rs.TANGGAL
        BETWEEN DATE_FORMAT(NOW(), "%Y-03-01") AND DATE_FORMAT(NOW(), "%Y-04-01")
GROUP BY b.ID