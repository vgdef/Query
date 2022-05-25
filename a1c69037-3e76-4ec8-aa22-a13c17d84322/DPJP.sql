SELECT
    ref.DESKRIPSI CARA_BAYAR,
       psn.NORM,
       psn.NAMA NAMA_PASIEN,
       dd.DIAGNOSIS,
    master.getNamaLengkapPegawai(p.NIP) DOKTER,
       r.DESKRIPSI RUANGAN,
       pp.TANGGAL
#        tp.STATUS

FROM pendaftaran.tujuan_pasien tp
LEFT JOIN master.dokter d ON d.ID=tp.DOKTER
LEFT JOIN aplikasi.pengguna p ON d.NIP=p.NIP
LEFT JOIN pendaftaran.pendaftaran pp ON pp.NOMOR=tp.NOPEN
LEFT JOIN master.pasien psn ON psn.NORM=pp.NORM
LEFT JOIN master.ruangan r ON r.ID=tp.RUANGAN
LEFT JOIN pendaftaran.penjamin pj ON pp.NOMOR=pj.NOPEN
LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
# LEFT JOIN medicalrecord.diagnosa dd ON dd.NOPEN=pp.NOMOR
#                                            AND dd.UTAMA =1
LEFT JOIN pendaftaran.kunjungan k ON k.NOPEN=pp.NOMOR
LEFT JOIN medicalrecord.diagnosis dd ON dd.KUNJUNGAN=k.NOMOR

WHERE tp.DOKTER IN ('55')
AND tp.STATUS = 2
AND k.RUANGAN = 101030103
# AND ref.ID=2
AND pp.TANGGAL BETWEEN DATE_FORMAT(NOW(), "2022-01-01") AND DATE_FORMAT(NOW(), "2022-12-31")
GROUP BY pp.NORM
ORDER BY pp.TANGGAL ASC;