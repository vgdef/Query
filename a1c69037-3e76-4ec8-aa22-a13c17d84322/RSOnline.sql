SELECT
pp.kewarganegaraanId,
       pp.PANGGILAN noPassport,
       pp.PANGGILAN asalPasienId,
kip.NOMOR nik,
p.NORM noRM,
pp.namaLengkapPasien,
pp.namaInisialPasien,
DATE_FORMAT(pp.tanggalLahir, "%Y-%m-%d") tanggalLahir,
        pp.PANGGILAN email,
kp.NOMOR noTelp,
SUBSTRING(jk.DESKRIPSI, 1,1) jenisKelaminId,
SUBSTRING(kip.WILAYAH,1,6) as domisiliKecamatanId,
SUBSTRING(kip.WILAYAH,1,4) as domisiliKabKotaId,
SUBSTRING(kip.WILAYAH,1,2) as domisiliProvinsiId,
pp.pekerjaanId,
DATE_FORMAT(k.MASUK, "%Y-%m-%d") tanggalMasuk,
r.JENIS_KUNJUNGAN jenisPasienId,
       pp.PANGGILAN varianCovidId,
     CASE WHEN dgs.DIAGNOSIS LIKE '%antigen%' THEN '1'
       WHEN dgs.DIAGNOSIS LIKE '%PCR%' THEN '3'
       ELSE ' ' END AS statusPasienId ,
       pp.PANGGILAN statusCoInsidenId,
CASE
	WHEN k.RUANGAN = 101030108 THEN '26'
	WHEN k.RUANGAN IN ('101030109','101030102','101030103') THEN '29'
	WHEN k.RUANGAN = 101010102 THEN '32'
	ELSE '0' END AS  statusRawatId,
       pp.PANGGILAN alatOksigenId,
       CASE WHEN ps.CARA = 1 THEN '1'
           WHEN ps.CARA IN(7,6) THEN '0'
           ELSE '' END as penyintasId,
#        CASE WHEN dgs.DIAGNOSIS LIKE ('%gejala sedang%') THEN dgs.TANGGAL
#            WHEN dgs.DIAGNOSIS  LIKE ('%tidak ada gejala %')
       CONCAT(IF(dgs.DIAGNOSIS LIKE ('%gejala sedang+%'),dgs.TANGGAL, '')) tanggalOnsetGejala,
       pp.PANGGILAN kelompokGejalaId,
       pp.PANGGILAN gejala,
       CASE WHEN a.DESKRIPSI LIKE ('%demam disangkal%') THEN '1'
            WHEN a.DESKRIPSI LIKE ('%demam disangkal%') THEN '0'
            ELSE '' END as demamId,
       CONCAT(IF(a.DESKRIPSI LIKE ('%batuk kering%'),'1', '0'))batukId,
       CONCAT(IF(a.DESKRIPSI LIKE ('%pilek+%'),'1', '0')) pilekId,
       pp.PANGGILAN sakitTenggorokanId,
       pp.PANGGILAN sesakNapasId,
       pp.PANGGILAN lemasId,
       pp.PANGGILAN nyeriOtotId,
       CONCAT(IF(a.DESKRIPSI LIKE ('%muntah +%'),'1', '0')) mualMuntahId,
       pp.PANGGILAN diareId,
       pp.PANGGILAN anosmiaId,
       pp.PANGGILAN napasCepatId,
       pp.PANGGILAN frekNapas30KaliPerMenitId,
       pp.PANGGILAN distresPernapasanBeratId,
       pp.PANGGILAN lainnyaId


FROM pendaftaran.kunjungan k
LEFT JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
LEFT JOIN (SELECT
                  pp.PANGGILAN,
  pp.NORM,
  pp.NAMA namaLengkapPasien,
  pp.TANGGAL_LAHIR tanggalLahir,
  pp.JENIS_KELAMIN jenisKelaminId,
  CONCAT_WS(' ',
    SUBSTRING(pp.NAMA, 1,1),
    CASE WHEN LENGTH(pp.NAMA)-LENGTH(REPLACE(pp.NAMA,' ',''))>2 THEN
      CONCAT(LEFT(SUBSTRING_INDEX(pp.NAMA,' ', -3), 1), '')
    END,
    CASE WHEN LENGTH(pp.NAMA)-LENGTH(REPLACE(pp.NAMA,' ',''))>1 THEN
      CONCAT(LEFT(SUBSTRING_INDEX(pp.NAMA,' ', -2), 1), '')
    END,
    CASE WHEN LENGTH(pp.NAMA)-LENGTH(REPLACE(pp.NAMA,' ',''))>0 THEN
      CONCAT(LEFT(SUBSTRING_INDEX(pp.NAMA,' ', -1), 1), '')
    END) namaInisialPasien,
    pp.PEKERJAAN pekerjaanId,
    pp.KEWARGANEGARAAN kewarganegaraanId
FROM
  `master`.pasien pp) AS pp ON pp.NORM=p.NORM
LEFT JOIN `master`.referensi jk ON jk.ID=pp.jenisKelaminId AND jk.JENIS=2
LEFT JOIN master.kartu_identitas_pasien kip ON kip.NORM = pp.NORM
LEFT JOIN `master`.wilayah kec ON kec.ID=kip.WILAYAH AND kec.JENIS=3
LEFT JOIN `master`.kontak_pasien kp ON kp.NORM=pp.NORM
LEFT JOIN `master`.ruangan r ON k.RUANGAN=r.ID
LEFT JOIN medicalrecord.diagnosis dgs ON dgs.KUNJUNGAN=k.NOMOR
LEFT JOIN layanan.pasien_pulang ps ON ps.KUNJUNGAN=k.NOMOR
LEFT JOIN master.referensi pspl ON pspl.ID=ps.CARA AND pspl.JENIS =45
LEFT JOIN medicalrecord.anamnesis a ON a.KUNJUNGAN=k.NOMOR
LEFT JOIN medicalrecord.cppt ON cppt.KUNJUNGAN=k.NOMOR
WHERE k.RUANGAN IN ('101010102','101030103','101030102','101030109','101030108')
AND k.MASUK BETWEEN DATE_FORMAT(NOW(), "2022-01-01") AND DATE_FORMAT(NOW(), "2022-03-01")
GROUP BY k.NOMOR
ORDER BY p.NORM;

