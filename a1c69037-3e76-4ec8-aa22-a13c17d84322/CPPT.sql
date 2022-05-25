SELECT
pp.NORM,
       ref.DESKRIPSI CARABAYAR,
       pj.NOMOR SEP,
       cppt.SUBYEKTIF,
       cppt.OBYEKTIF,
cppt.ASSESMENT,
       cppt.PLANNING,
      master.getNamaLengkapPegawai(p.NIP) PPA,
       master.getNamaLengkapPegawai(pgn.NIP) DPJP,
       cppt.TANGGAL,
       r.DESKRIPSI RUANGAN

FROM medicalrecord.cppt
LEFT JOIN aplikasi.pengguna p ON p.ID=cppt.OLEH
LEFT JOIN pendaftaran.kunjungan k ON k.NOMOR=cppt.KUNJUNGAN
LEFT JOIN master.dokter d ON d.ID=k.DPJP
LEFT JOIN pendaftaran.pendaftaran pp ON pp.NOMOR=k.NOPEN
LEFT JOIN aplikasi.pengguna pgn ON pgn.NIP=d.NIP
LEFT JOIN master.ruangan r ON r.ID=k.RUANGAN
LEFT JOIN pendaftaran.penjamin pj ON pp.NOMOR=pj.NOPEN
LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10

WHERE cppt.TANGGAL BETWEEN DATE_FORMAT(NOW(), "%Y-08-01") AND DATE_FORMAT(NOW(), "%Y-12-22")
AND ref.ID=2
# AND cppt.JENIS=2
# AND rr.ID = 2

# ORDER BY pp.NORM
