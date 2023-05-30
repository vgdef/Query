SELECT
		ps.ID
		,pen.NORM
     ,k.NOMOR
		, `master`.getNamaLengkap(pen.NORM) PASIEN
# 		,re.DESKRIPSI diagnosis
# 		, ree.DESKRIPSI riwayat_jatuh
		, ref.DESKRIPSI alat_bantu
# 		, refe.DESKRIPSI Heparin
# 		, r.DESKRIPSI gaya_berjalan
# 		, reff.DESKRIPSI kesadaran
		, `master`.getNamaLengkapPegawai(per.NIP) OLEH
		, ru.DESKRIPSI RUANGAN
		, ref.SCORING skor_diagnosis
        , IF(ps.DIAGNOSIS = 0 OR ps.RIWAYAT_JATUH OR ps.HEPARIN=0, ree.SCORING+ref.SCORING+r.SCORING+reff.SCORING,0 )  reffskor_diagnosis

FROM medicalrecord.penilaian_skala_morse ps
LEFT JOIN pendaftaran.kunjungan k ON k.NOMOR=ps.KUNJUNGAN
# LEFT JOIN `master`.referensi re ON re.ID=ps.DIAGNOSIS AND re.JENIS=48
LEFT JOIN `master`.referensi ree ON ree.ID=ps.RIWAYAT_JATUH AND ree.JENIS=48
LEFT JOIN `master`.referensi ref ON ref.ID=ps.ALAT_BANTU AND ref.JENIS=188
LEFT JOIN `master`.referensi refe ON refe.ID=ps.HEPARIN AND refe.JENIS=48
LEFT JOIN `master`.referensi r ON r.ID=ps.GAYA_BERJALAN AND r.JENIS=190
LEFT JOIN `master`.referensi reff ON r.ID=ps.KESADARAN AND reff.JENIS=191
LEFT JOIN master.pegawai p ON ps.OLEH=p.ID
LEFT JOIN `master`.perawat per ON per.ID=ps.OLEH
LEFT JOIN pendaftaran.pendaftaran pen ON pen.NOMOR=k.NOPEN
LEFT JOIN `master`.ruangan ru on ru.ID=k.RUANGAN
WHERE ps.`STATUS`=1
#   AND pen.NORM=2