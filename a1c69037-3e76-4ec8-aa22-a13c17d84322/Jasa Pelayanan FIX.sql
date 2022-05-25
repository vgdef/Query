
SELECT
    ref.DESKRIPSI CARABAYAR
, pj.NOMOR NOMORSEP
# , tm.ID
,   pp.NORM
,   r.DESKRIPSI RUANGAN
,   t.NAMA TINDAKAN
,   rt.TARIF TARIF_TINDAKAN
,  IF(ptm.JENIS IN(1,2), master.getNamaLengkapPegawai(mp.NIP),master.getNamaLengkapPegawai(mp.NIP)) DOKTER
,  IF(ptm.JENIS IN (3,5),master.getNamaLengkapPegawai(prwt.NIP),master.getNamaLengkapPegawai(mpp.NIP)) PERAWAT
# ,  IF(ptm.JENIS IN (6),master.getNamaLengkapPegawai(mmpp.NIP),master.getNamaLengkapPegawai(mmpp.NIP))  ANALIS
# , IF(ptm.JENIS IN (8),master.getNamaLengkapPegawai(prwt.NIP),master.getNamaLengkapPegawai(mpp.NIP)) RADIOGRAFER
# , IF(ptm.JENIS IN (9),master.getNamaLengkapPegawai(prwt.NIP),master.getNamaLengkapPegawai(mpp.NIP)) FISIOTERAPIS
,   tm.TANGGAL
FROM pembayaran.rincian_tagihan rt
LEFT JOIN layanan.tindakan_medis tm ON tm.ID=rt.REF_ID
LEFT JOIN pendaftaran.kunjungan pk ON pk.NOMOR = tm.KUNJUNGAN
LEFT JOIN pendaftaran.pendaftaran pp ON pp.NOMOR = pk.NOPEN
LEFT JOIN master.tindakan t ON tm.TINDAKAN=t.ID
LEFT JOIN layanan.petugas_tindakan_medis ptm ON tm.ID=ptm.TINDAKAN_MEDIS
LEFT JOIN master.ruangan r ON pk.RUANGAN=r.ID
LEFT JOIN pendaftaran.penjamin pj ON pp.NOMOR=pj.NOPEN
LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
LEFT JOIN master.dokter dok1 ON ptm.MEDIS=dok1.ID AND ptm.JENIS IN (1,2)
LEFT JOIN master.pegawai mp ON dok1.NIP=mp.NIP
LEFT JOIN master.pegawai mpp ON mpp.ID=ptm.MEDIS AND ptm.JENIS NOT IN (1,2)
LEFT JOIN master.pegawai mmpp ON mmpp.ID=ptm.MEDIS AND ptm.JENIS = 6
LEFT JOIN master.pegawai ppp ON ppp.ID=ptm.MEDIS AND ptm.JENIS =  8
LEFT JOIN master.perawat prwt ON ptm.MEDIS=prwt.ID

WHERE pp.TANGGAL BETWEEN DATE_FORMAT(NOW(), "2022-04-01") AND DATE_FORMAT(NOW(), "2022-05-01")
     AND
   pk.RUANGAN
       LIKE '%1011001%'
#   IN (101010101,101010102,101010103)
  AND
      tm.STATUS = 1
  AND
      rt .JENIS = 3
#   AND
#       ptm.STATUS = 1
  AND
       pp.STATUS!=0
  AND rt.STATUS = 1
#   AND r.JENIS_KUNJUNGAN=1
  AND pj.JENIS= 1
# AND tm.TINDAKAN = 11107
# GROUP BY pk.NOMOR
# ORDER BY pp.NORM
# ORDER BY  pp.TANGGAL, tm.TANGGAL , ptm.JENIS, ptm.MEDIS