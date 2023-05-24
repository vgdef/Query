#IGD
SELECT
  pj.NOMOR SEP,
    master.getNamaLengkapPegawai(mp.NIP) DOKTER,
#    IFNULL(IF(ptm.JENIS IN (1,2),master.getNamaLengkapPegawai(mp.NIP)
#     , IF(ptm.JENIS IN (3,5),master.getNamaLengkapPegawai(prwt.NIP)
#     , IF(ptm.JENIS IN (8), master.getNamaLengkapPegawai(rads.NIP)
# , master.getNamaLengkapPegawai(mpp.NIP)))),'-') PETUGAS,
#     t.NAMA TINDAKAN,
#     tm.TANGGAL TGLTINDAKAN,
    master.getNamaLengkap(p.NORM) PASIEN,
    rf.DESKRIPSI JENIS_KUNJUNGAN,
    tt.SARANA TARIFTINDAKAN,
    DATE_FORMAT(k.MASUK, '%M %Y') TGLMASUK,
    ref.DESKRIPSI CARABAYAR

FROM pendaftaran.kunjungan k
JOIN pendaftaran.pendaftaran p ON p.NOMOR=k. NOPEN
JOIN pendaftaran.tujuan_pasien tp ON tp.NOPEN=p.NOMOR
JOIN layanan.tindakan_medis tm ON tm.KUNJUNGAN=k.NOMOR
LEFT JOIN master.tindakan t ON t.ID=tm.TINDAKAN
LEFT JOIN layanan.petugas_tindakan_medis ptm ON tm.ID=ptm.TINDAKAN_MEDIS
# LEFT JOIN master.dokter dok ON ptm.MEDIS=dok.ID
#      LEFT JOIN master.pegawai mp ON dok.NIP=mp.NIP
LEFT JOIN master.tarif_tindakan tt ON tt.TINDAKAN=t.ID
JOIN pendaftaran.penjamin pj ON p.NOMOR=pj.NOPEN
LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
    LEFT JOIN master.ruangan r ON k.RUANGAN = r.ID
    LEFT JOIN master.dokter dok1 ON ptm.MEDIS=dok1.ID AND ptm.JENIS IN (1)
    LEFT JOIN master.pegawai mp ON dok1.NIP=mp.NIP
    LEFT JOIN master.pegawai mpp ON mpp.ID=ptm.MEDIS AND ptm.JENIS NOT IN  (1,2,3,5,8,9,12)
LEFT JOIN master.perawat prwt ON ptm.MEDIS=prwt.ID
LEFT JOIN master.pegawai prw ON prw.NIP=prwt.NIP
LEFT JOIN master.pegawai rads ON rads.NIP=prwt.NIP
    LEFT JOIN master.pegawai fts ON fts.NIP=prwt.NIP
    LEFT JOIN master.referensi rf ON r.JENIS_KUNJUNGAN = rf.ID AND rf.JENIS = 15
WHERE k.MASUK BETWEEN '2022-08-01' AND '2023-01-01'
 AND k.RUANGAN LIKE '1010101%'
  AND k.`STATUS`=2
  AND tm.`STATUS` !=0 AND ptm.STATUS=1
# AND  dok1.ID=99
GROUP BY ptm.ID
ORDER BY  p.TANGGAL, tm.TANGGAL , ptm.JENIS, ptm.ID;