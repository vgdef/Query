SELECT

p.NORM,
	pp.NAMA,
		d.KODE,
			d.DIAGNOSA,
				d.TANGGAL,
					r.DESKRIPSI ruangan,
						rk.KAMAR,
							rkt.TEMPAT_TIDUR

FROM medicalrecord.diagnosa d
LEFT JOIN pendaftaran.pendaftaran p ON d.NOPEN=p.NOMOR
LEFT JOIN `master`.pasien pp ON p.NORM=pp.NORm
LEFT JOIN pendaftaran.kunjungan k ON p.NOMOR=k.NOPEN
RIGHT JOIN `master`.ruangan r ON k.RUANGAN=r.ID
RIGHT JOIN pendaftaran.tujuan_pasien tp ON p.NOMOR=tp.NOPEN
LEFT JOIN pendaftaran.reservasi rr ON tp.RESERVASI=rr.NOMOR
LEFT JOIN `master`.ruang_kamar_tidur rkt ON rr.RUANG_KAMAR_TIDUR=rkt.ID
LEFT JOIN `master`.ruang_kamar rk ON rkt.RUANG_KAMAR=rk.ID
LEFT JOIN `master`.rl4_icd10 rl ON d.KODE=rl.KODE
WHERE k.RUANGAN LIKE '%101030103%'
-- WHERE rl.ID LIKE '%36125%' AND k.RUANGAN LIKE '%101030102%'
# WHERE rl.ID LIKE '%36125%'OR rl.ID LIKE '%509%'