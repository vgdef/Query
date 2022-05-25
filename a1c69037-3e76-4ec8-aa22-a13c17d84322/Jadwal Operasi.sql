SELECT

rr.DESKRIPSI JENIS_PELAYANAN_OPERASI,
pgn.NAMA DOKTER,
jo.TINDAKAN,

r.DESKRIPSI RUANG_TINDAKAN,
rk.KAMAR,
DATE_FORMAT(jo.TANGGAL, "%d %M %Y")JADWAL_OPERASI


FROM jadwal_operasi.request_jadwal_operasi jo
LEFT JOIN `master`.ruangan r ON r.ID=jo.RUANGAN
LEFT JOIN `master`.dokter d ON d.ID=jo.DOKTER
LEFT JOIN aplikasi.pengguna pgn ON pgn.NIP=d.NIP
LEFT JOIN pendaftaran.kunjungan k ON k.NOMOR=jo.KUNJUNGAN
LEFT JOIN jadwal_operasi.jadwal_operasi joo ON joo.KODE=jo.KODE
LEFT JOIN `master`.ruang_kamar rk ON rk.ID=joo.KAMAR
LEFT JOIN `master`.dokter_smf ds ON ds.DOKTER=d.ID
LEFT JOIN `master`.smf_ruangan sr ON sr.ID=ds.SMF
LEFT JOIN `master`.referensi rr ON rr.ID=sr.ID AND rr.JENIS = 26
