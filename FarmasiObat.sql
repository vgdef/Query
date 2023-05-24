SELECT
    ref.DESKRIPSI CARABAYAR,
    pj.NOMOR SEP,
      master.getNamaLengkapPegawai(dror.NIP) DPJP,
    master.getNamaLengkap(p.NORM) PASIEN,
    b.NAMA BARANG,
    f.JUMLAH,
    hb.HARGA_JUAL,
    master.getNamaLengkapPegawai(pgn.NIP) YGORDER,
    r.DESKRIPSI RUANGANTUJUAN,
    f.TANGGAL TGLFARMASI,
    (SELECT TANGGAL FROM pembayaran.pembayaran_tagihan WHERE TAGIHAN = rt.TAGIHAN AND STATUS=1)   TGL_BAYAR



FROM layanan.farmasi f
JOIN pendaftaran.kunjungan k ON k.NOMOR=f.KUNJUNGAN
JOIN inventory.barang b ON b.ID=f.FARMASI
JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
LEFT JOIN pendaftaran.penjamin pj ON p.NOMOR = pj.NOPEN
LEFT JOIN master.referensi ref ON pj.JENIS = ref.ID AND ref.JENIS = 10
LEFT JOIN master.ruangan r ON k.RUANGAN = r.ID
JOIN layanan.order_resep ors ON ors.NOMOR=k.REF
JOIN aplikasi.pengguna pgn ON pgn.ID=ors.OLEH
LEFT JOIN master.dokter  dror ON ors.DOKTER_DPJP=dror.ID
JOIN aplikasi.pengguna pgnn ON pgnn.NIP=dror.NIP
JOIN pembayaran.rincian_tagihan rt ON rt.TAGIHAN=p.NOMOR
JOIN inventory.harga_barang hb ON hb.BARANG=f.FARMASI AND hb.STATUS=1



WHERE f.TANGGAL BETWEEN DATE_FORMAT(NOW(), '2022-01-01') AND DATE_FORMAT(NOW(), '2023-01-01')
AND f.STATUS=2
AND k.STATUS=2
GROUP BY f.ID;