SELECT
		k.NOMOR
		,`master`.getNamaLengkap(p.NORM) PASIEN
, IFNULL(IF(ptm.JENIS IN (1,2),master.getNamaLengkapPegawai(mp.NIP)
    , IF(ptm.JENIS IN (3,5),master.getNamaLengkapPegawai(prwt.NIP)
    , IF(ptm.JENIS IN (8), master.getNamaLengkapPegawai(rads.NIP)
, master.getNamaLengkapPegawai(mpp.NIP)))),'-') PETUGAS
#     , (SELECT  GROUP_CONCAT(CONCAT(b.NAMA," (",ores.JUMLAH,")"))FROM layanan.order_resep ore
# 	 LEFT JOIN layanan.order_detil_resep ores ON ores.ORDER_ID=ore.NOMOR
# 	 left JOIN inventory.barang b ON b.ID=ores.FARMASI
# 	 WHERE  ore.KUNJUNGAN=k.NOMOR AND ore.`STATUS`=2 ) BARANG
    , t.NAMA TINDAKAN
    , k.MASUK tgl_masuk
FROM pendaftaran.kunjungan k
LEFT JOIN layanan.tindakan_medis tm ON tm.KUNJUNGAN=k.NOMOR
LEFT JOIN layanan.petugas_tindakan_medis ptm ON ptm.TINDAKAN_MEDIS=tm.ID
LEFT JOIN master.dokter dok1 ON ptm.MEDIS=dok1.ID AND ptm.JENIS IN (1,2)
LEFT JOIN master.pegawai mp ON dok1.NIP=mp.NIP
LEFT JOIN master.pegawai mpp ON mpp.ID=ptm.MEDIS AND ptm.JENIS NOT IN  (1,2,3,5,8)
LEFT JOIN `master`.tindakan t ON t.ID=tm.TINDAKAN
LEFT JOIN master.pegawai rad ON rad.ID=ptm.MEDIS AND ptm.JENIS =  8
LEFT JOIN master.perawat prwt ON ptm.MEDIS=prwt.ID
LEFT JOIN master.pegawai prw ON prw.NIP=prwt.NIP
LEFT JOIN master.pegawai rads ON rads.NIP=prwt.NIP
LEFT JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN

WHERE
 k.RUANGAN LIKE '101020108%'
  AND k.MASUK BETWEEN '2022-01-01' AND '2023-01-01'
	AND tm.`STATUS`=1
	AND ptm.`STATUS`!=0
		GROUP BY tm.ID