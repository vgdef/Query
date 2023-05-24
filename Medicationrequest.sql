select
    k.NOMOR as KUNJUNGAN,
                master.getNamaLengkap(p.NORM) NAMAPASIEN,
                p.NORM,
                f.FARMASI as ID_BARANG,
                ors.JUMLAH as JUMLAH_ORDER,
                f.JUMLAH as JUMLAH_DIBERIKAN,
                f.ALASAN_TIDAK_TERLAYANI,
                f.ATURAN_PAKAI,
                f.KETERANGAN,
                f.TANGGAL as TGL_DILAYANI,
                ore.DOKTER_DPJP,
                pp.ID REQUESTER,
#                 master.getNamaLengkapPegawai(pp.NIP) REQUESTERNAMA,
                k.NOPEN
            FROM layanan.order_detil_resep ors
            left join layanan.order_resep ore ON  ore.NOMOR = ORDER_ID
            join pendaftaran.kunjungan k ON  k.NOMOR = ore.KUNJUNGAN
            join pendaftaran.pendaftaran p ON  p.NOMOR = k.NOPEN
            join inventory.barang  b ON b.ID = ors.FARMASI
            join layanan.farmasi as f ON f.ID = ors.REF
            JOIN aplikasi.pengguna pgn ON pgn.ID=ore.OLEH
            JOIN master.dokter d ON d.NIP=pgn.NIP
            JOIN master.pegawai pp ON pp.NIP=d.NIP
            where f.STATUS = 2 and p.NORM=20217 AND k.MASUK BETWEEN '2023-03-06' AND '2023-03-07';

