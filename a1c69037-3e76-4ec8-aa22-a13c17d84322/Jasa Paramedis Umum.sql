
SELECT
       r.DESKRIPSI RUANGAN,
t.NAMA TINDAKAN,
       tt.SARANA TARIF_TINDAKAN,
       ptm.JENIS,
   --    IF(',CARABAYAR,'=1,'',ref.DESKRIPSI) CARABAYAR,
#     IF(ptm.JENIS IN(1,2), master.getNamaLengkapPegawai(mp.NIP),master.getNamaLengkapPegawai(mp.NIP)) DOKTER,

  -- IF(ptm.JENIS IN (1,2),master.getNamaLengkapPegawai(mp.NIP),IF(ptm.JENIS IN (3,5),master.getNamaLengkapPegawai(prwt.NIP),master.getNamaLengkapPegawai(mpp.NIP))) PEGAWAI,
#    IF(ptm.JENIS IN (3,5),master.getNamaLengkapPegawai(prwt.NIP),master.getNamaLengkapPegawai(mpp.NIP)) PERAWAT,
#
#        IF(ptm.JENIS IN (6),master.getNamaLengkapPegawai(mmpp.NIP),master.getNamaLengkapPegawai(mmpp.NIP))  RADIOGRAFER,
#     IF(ptm.JENIS IN (6),master.getNamaLengkapPegawai(mmpp.NIP),master.getNamaLengkapPegawai(mmpp.NIP))  ANALIS,
      --  IF(ptm.JENIS IN (4,6),master.getNamaLengkapPegawai(prwt.NIP),master.getNamaLengkapPegawai(mpp.NIP)) RADIOGRAFER,

              tm.TANGGAL

FROM layanan.tindakan_medis tm
LEFT JOIN master.tindakan t ON tm.TINDAKAN = t.ID
LEFT JOIN pendaftaran.kunjungan k ON k.NOMOR=tm.KUNJUNGAN
LEFT JOIN master.ruangan r ON r.ID = k.RUANGAN
LEFT JOIN layanan.petugas_tindakan_medis ptm ON ptm.TINDAKAN_MEDIS = tm.ID
LEFT JOIN master.dokter d ON d.ID=tm.OLEH
  LEFT JOIN master.dokter dok1 ON ptm.MEDIS=dok1.ID AND ptm.JENIS IN (1,2)
		  LEFT JOIN master.pegawai mp ON dok1.NIP=mp.NIP
		  LEFT JOIN master.pegawai mpp ON mpp.ID=ptm.MEDIS AND ptm.JENIS NOT IN (1,2)
LEFT JOIN master.pegawai mmpp ON mmpp.ID=ptm.MEDIS AND ptm.JENIS IN (6)
		  LEFT JOIN master.perawat prwt ON ptm.MEDIS=prwt.ID
LEFT JOIN master.tarif_tindakan tt ON tt.TINDAKAN = t.ID
    	  LEFT JOIN pendaftaran.pendaftaran pp ON pp.NOMOR = k.NOPEN

WHERE tm.TANGGAL BETWEEN DATE_FORMAT(NOW(), "%Y-03-01") AND DATE_FORMAT(NOW(), "%Y-04-01")
    AND k.RUANGAN LIKE  '101050101%' AND tm.STATUS = 1

#
GROUP BY tm.TANGGAL
ORDER BY tm.TINDAKAN
