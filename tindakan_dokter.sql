SELECT
  pn.NOMOR SEP
#    , IFNULL(IF(ptm.JENIS IN (1,2),mp.ID
# 	, IF(ptm.JENIS IN (3,5),prw.ID
# 		, IF(ptm.JENIS IN (8),rads.ID
# 			, IF(ptm.JENIS = 9,fts.ID, mpp.ID)))),'0') PETUGAS,
    ,`master`.getNamaLengkapPegawai(mp.NIP),
    t.NAMA TINDAKAN,
    tm.TANGGAL TGLTINDAKAN,
    master.getNamaLengkap(p.NORM) PASIEN,
    rr.DESKRIPSI LAYANAN,
    tt.SARANA TARIFTINDAKAN,
    DATE_FORMAT(k.MASUK, '%M %Y') TGLMASUK,
    cb.DESKRIPSI CARABAYAR,
    mp.NIP

FROM layanan.tindakan_medis tm
JOIN master.tindakan t ON t.ID=tm.TINDAKAN
JOIN pendaftaran.kunjungan k ON k.NOMOR=tm.KUNJUNGAN
JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
JOIN pendaftaran.penjamin pn ON pn.NOPEN=p.NOMOR
JOIN master.referensi cb ON cb.ID=pn.JENIS AND cb.JENIS=10
JOIN layanan.petugas_tindakan_medis ptm ON ptm.TINDAKAN_MEDIS=tm.ID
LEFT JOIN master.tarif_tindakan tt ON tt.TINDAKAN=t.ID
JOIN master.dokter d ON d.ID=ptm.MEDIS AND ptm.JENIS=1 #DRKONSUL
JOIN master.dokter dpjp ON dpjp.ID=k.DPJP
JOIN master.pegawai mp ON d.NIP=mp.NIP
    LEFT JOIN master.pegawai mpp ON mpp.ID=ptm.MEDIS AND ptm.JENIS NOT IN  (1,2,3,5,8,9,12)
LEFT JOIN master.perawat prwt ON ptm.MEDIS=prwt.ID
LEFT JOIN master.pegawai prw ON prw.NIP=prwt.NIP
LEFT JOIN master.pegawai rads ON rads.NIP=prwt.NIP
    LEFT JOIN master.pegawai fts ON fts.NIP=prwt.NIP
JOIN master.ruangan rr ON rr.ID=k.RUANGAN
WHERE p.TANGGAL BETWEEN '2023-01-01' AND '2023-04-30'
    AND ptm.STATUS=1
    AND tm.STATUS != 0
#     AND t.ID IN(11101,11107) #DRKONSUL
    #AND k.RUANGAN = 101080101
    AND k.STATUS=2

GROUP BY tm.ID;
