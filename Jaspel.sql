SELECT
  pk.NOMOR
, kp.TANGGAL   TGL_BAYAR
, tm.TANGGAL TGL_TINDAKAN
, tm.TINDAKAN
# , t.NAMA NAMATINDAKAN
# , tt.SARANA TARIFTINDAKAN
, r.ID RUANGAN
# , r.DESKRIPSI RUANGAN
, IFNULL(pk.RUANG_KAMAR_TIDUR, '0') RUANG_KAMAR
# , pj.NOMOR SEP
, ref.ID CARA_BAYAR
# , ref.DESKRIPSI CARA_BAYAR
, IFNULL(ptm.JENIS,'0') JNS_PETUGAS
, IFNULL(IF(ptm.JENIS IN (1,2),mp.ID
	, IF(ptm.JENIS IN (3,5),prw.ID
		, IF(ptm.JENIS IN (8),rads.ID
			, IF(ptm.JENIS = 9,fts.ID, mpp.ID)))),'0') PETUGAS

# , IFNULL(IF(ptm.JENIS IN (1,2),master.getNamaLengkapPegawai(mp.NIP)
#     , IF(ptm.JENIS IN (3,5),master.getNamaLengkapPegawai(prwt.NIP)
#     , IF(ptm.JENIS IN (8), master.getNamaLengkapPegawai(rads.NIP)
#         ,IF(ptm.JENIS IN (9), master.getNamaLengkapPegawai(fts.NIP)
# , master.getNamaLengkapPegawai(mpp.NIP))))),'-') PETUGAS
, pp.NORM
, master.getNamaLengkap(pp.NORM) PASIEN
,IFNULL(mmp.ID,IFNULL(olp.ID,orp.ID)) DPJP
, ROW_NUMBER()OVER(ORDER BY pk.NOMOR ,  tm.TANGGAL, tm.TINDAKAN, r.ID, pk.RUANG_KAMAR_TIDUR,pp.NORM, ptm.ID) NOURUT

FROM pembayaran.rincian_tagihan rt
LEFT JOIN layanan.tindakan_medis tm ON tm.ID=rt.REF_ID AND rt.JENIS=3
LEFT JOIN pendaftaran.kunjungan pk ON pk.NOMOR = tm.KUNJUNGAN
LEFT JOIN pendaftaran.pendaftaran pp ON pp.NOMOR = pk.NOPEN and pp.STATUS!=0
LEFT JOIN master.tindakan t ON tm.TINDAKAN=t.ID
LEFT JOIN layanan.petugas_tindakan_medis ptm ON tm.ID=ptm.TINDAKAN_MEDIS and  ptm.STATUS = 1
LEFT JOIN master.ruangan r ON pk.RUANGAN=r.ID
RIGHT JOIN pembayaran.pembayaran_tagihan kp ON kp.TAGIHAN = rt.TAGIHAN
LEFT JOIN pembayaran.tagihan_pendaftaran ptp ON rt.TAGIHAN = ptp.TAGIHAN AND ptp.STATUS = 1 AND ptp.UTAMA = 1
INNER JOIN pendaftaran.penjamin pj ON pp.NOMOR=pj.NOPEN
#                                           AND pj.JENIS= 1
LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
LEFT JOIN master.dokter dok1 ON ptm.MEDIS=dok1.ID AND ptm.JENIS IN (1,2)
LEFT JOIN master.dokter  dok2 ON pk.DPJP=dok2.ID
LEFT JOIN layanan.order_lab ol ON ol.NOMOR=pk.REF
LEFT JOIN layanan.order_rad orr ON orr.NOMOR=pk.REF
LEFT JOIN master.dokter  drol ON ol.DOKTER_ASAL=drol.ID
LEFT JOIN master.dokter  dror ON orr.DOKTER_ASAL=dror.ID
LEFT JOIN master.pegawai olp ON drol.NIP=olp.NIP
LEFT JOIN master.pegawai orp ON dror.NIP=orp.NIP
LEFT JOIN master.pegawai mmp ON dok2.NIP=mmp.NIP
LEFT JOIN master.pegawai mp ON dok1.NIP=mp.NIP
LEFT JOIN master.pegawai mpp ON mpp.ID=ptm.MEDIS AND ptm.JENIS NOT IN  (1,2,3,5,8,9,12)
LEFT JOIN master.pegawai rad ON rad.ID=ptm.MEDIS AND ptm.JENIS =  8
LEFT JOIN master.pegawai ft ON ft.ID=ptm.MEDIS AND ptm.JENIS =  9
LEFT JOIN master.pegawai ot ON ot.ID=ptm.MEDIS AND ptm.JENIS =  12
LEFT JOIN master.perawat prwt ON ptm.MEDIS=prwt.ID
LEFT JOIN master.pegawai prw ON prw.NIP=prwt.NIP
LEFT JOIN master.pegawai rads ON rads.NIP=prwt.NIP
LEFT JOIN master.pegawai fts ON fts.NIP=prwt.NIP
LEFT JOIN master.pegawai ots ON ots.NIP=prwt.NIP
LEFT JOIN pembayaran.tagihan tg ON tg.ID=rt.TAGIHAN
# LEFT JOIN master.tarif_tindakan tt ON tt.TINDAKAN=t.ID AND tt.STATUS=1

WHERE
-- CONCAT(MONTH(tg.TANGGAL),'-',YEAR(tg.TANGGAL)) = CONCAT(MONTH(NOW())-1,'-',YEAR(NOW()))
 --  AND
#  tm.TANGGAL BETWEEN DATE_FORMAT(NOW(), "2023-03-01") AND DATE_FORMAT(NOW(), "2023-04-01")
#  AND
    kp.TANGGAL BETWEEN DATE_FORMAT(NOW(), "2023-04-01") AND DATE_FORMAT(NOW(), "2023-05-01")
#  AND pk.RUANGAN LIKE '1010501%'

AND tm.STATUS = 1
 AND t.ID  NOT IN(15073, 15074, 14803, 14804, 12745,12747,12749,12748,12744,12746,12750,12751,15108,15118,15227,15225,15226)


# AND kp.STATUS=2
AND rt.STATUS = 1
AND pj.JENIS=1
#  AND ptm.JENIS IN (1)
#  AND pp.NORM=25023
#  AND rads.ID = 276

ORDER BY  pp.TANGGAL, tm.TANGGAL , ptm.JENIS, ptm.ID;