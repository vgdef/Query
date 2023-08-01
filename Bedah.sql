SELECT
pj.NOMOR SEP,
       p.NORM,
       r.DESKRIPSI RUANG_PERAWATAN,
       t.NAMA TINDAKAN,
#        master.getNamaLengkapPegawai(pgn.NIP) DPJP,
#        master.getNamaLengkapPegawai(dok1.NIP) DOKTERRABER,
#        master.getNamaLengkapPegawai(dok2.NIP) DOKTEROPERASI,
       master.getNamaLengkapPegawai(dok3.NIP) DOKTERIBS,
       tm.TANGGAL TGLTINDKAN,
       DATE_FORMAT(k.MASUK, "%d-%m-%Y") TGL_MASUK,
       DATE_FORMAT(k.KELUAR, "%d-%m-%Y") TGL_KELUAR

FROM pendaftaran.kunjungan k
LEFT JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
LEFT JOIN pendaftaran.penjamin pj ON pj.NOPEN=p.NOMOR
LEFT JOIN master.ruangan r ON r.ID=k.RUANGAN
LEFT JOIN master.dokter dr ON dr.ID=k.DPJP
LEFT JOIN aplikasi.pengguna pgn ON pgn.NIP=dr.NIP
LEFT JOIN layanan.tindakan_medis tm ON tm.KUNJUNGAN=k.NOMOR
LEFT JOIN master.tindakan t ON tm.TINDAKAN=t.ID
LEFT JOIN layanan.petugas_tindakan_medis ptm ON tm.ID=ptm.TINDAKAN_MEDIS
LEFT JOIN master.dokter dok1 ON ptm.MEDIS=dok1.ID AND ptm.JENIS IN (1,2)
LEFT JOIN master.dokter_smf ds ON dok1.ID=ds.DOKTER
LEFT JOIN medicalrecord.operasi o ON o.KUNJUNGAN=k.NOMOR
LEFT JOIN master.dokter dok2 ON dok2.ID=o.DOKTER
LEFT JOIN master.dokter dok3 ON dok3.ID=ptm.MEDIS AND ptm.JENIS=1

WHERE k.KELUAR BETWEEN DATE_FORMAT(NOW(), "2023-03-01") AND DATE_FORMAT(NOW(), "2023-04-01")
AND pj.JENIS =2
AND k.STATUS IN (1,2)
AND ptm.STATUS!=0
AND ptm.JENIS=1
-- # AND r.JENIS_KUNJUNGAN IN(3,6)
# AND tm.TINDAKAN in(11101,11107)
# AND ds.SMF NOT IN (31)
-- # AND pj.NOMOR LIKE '%0359R0181121V000069%'
AND k.RUANGAN LIKE '1010701%'
ORDER BY p.NORM