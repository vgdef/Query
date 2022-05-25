SELECT
       master.getNamaLengkap(pp.NORM) Nama,
       timestampdiff(year, pp.TANGGAL_LAHIR, curdate()) as Umur,
       r.DESKRIPSI Sex,
       UPPER((master.getDiagnosa(p.NOMOR,1))) Diagnosa,
       UPPER((master.getDiagnosa(p.NOMOR,2))) Komorbid,
#        rgn.DESKRIPSI Ruangan,
       k.MASUK Tgl_Masuk,
       k.KELUAR Tgl_Keluar,
       cr.DESKRIPSI Cara_Keluar,
       kd.DESKRIPSI Keadaan_Keluar,
       (SELECT GROUP_CONCAT(DISTINCT(ib.NAMA))
					FROM layanan.farmasi lf
						  LEFT JOIN master.referensi ref ON ref.ID=lf.ATURAN_PAKAI AND ref.JENIS=41
						, pendaftaran.kunjungan pk
					     LEFT JOIN layanan.order_resep o ON o.NOMOR=pk.REF
					     LEFT JOIN master.dokter md ON o.DOKTER_DPJP=md.ID
						  LEFT JOIN master.pegawai mp ON md.NIP=mp.NIP
						  LEFT JOIN pendaftaran.kunjungan asal ON o.KUNJUNGAN=asal.NOMOR
						  LEFT JOIN master.ruangan r ON asal.RUANGAN=r.ID AND r.JENIS=5
					     LEFT JOIN master.referensi jenisk ON r.JENIS_KUNJUNGAN=jenisk.ID AND jenisk.JENIS=15
					   , pendaftaran.pendaftaran pp
						  LEFT JOIN master.pasien ps ON pp.NORM=ps.NORM
						, inventory.barang ib
						, pembayaran.rincian_tagihan rt
					WHERE  lf.`STATUS`=2 AND lf.KUNJUNGAN=pk.NOMOR AND pk.`STATUS` IN (1,2)
						AND pk.NOPEN=pp.NOMOR AND lf.FARMASI=ib.ID
						AND pk.NOPEN=p.NOMOR AND o.RESEP_PASIEN_PULANG!=1
						AND lf.ID=rt.REF_ID AND rt.JENIS=4 AND LEFT(ib.KATEGORI,3)='101') OBATRS
FROM pendaftaran.pendaftaran p
LEFT JOIN master.pasien pp ON pp.NORM=p.NORM
LEFT JOIN pendaftaran.kunjungan k ON k.NOPEN=p.NOMOR
LEFT JOIN medicalrecord.diagnosa d ON d.NOPEN=k.NOPEN
LEFT JOIN `master`.referensi r ON r.ID=pp.JENIS_KELAMIN AND r.JENIS=2
LEFT JOIN layanan.pasien_pulang pl ON p.NOMOR=pl.NOPEN AND pl.`STATUS`=1
LEFT JOIN master.referensi kd ON pl.KEADAAN=kd.ID AND kd.JENIS=46
LEFT JOIN master.referensi cr ON pl.CARA=cr.ID AND cr.JENIS=45
LEFT JOIN master.ruangan rgn ON rgn.ID=k.RUANGAN
LEFT JOIN layanan.farmasi f ON f.KUNJUNGAN=k.NOMOR
LEFT JOIN inventory.barang b ON b.ID=f.FARMASI
WHERE pp.NORM = 14906
# AND k.MASUK BETWEEN DATE_FORMAT(NOW(), "2021-01-01") AND DATE_FORMAT(NOW(), "2022-01-01")
# AND k.RUANGAN IN ('101030102','101030103','101030108','101030109') AND p.STATUS IN(1,2)
GROUP BY p.NOMOR