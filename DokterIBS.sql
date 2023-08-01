SELECT
    pj.NOMOR SEP,
    master.getNamaLengkapPegawai(mp.NIP) DOKTEROPERATOR,
    t.NAMA TINDAKANN,
    tm.TANGGAL TGLTINDAKAN,
    master.getNamaLengkap(pp.NORM) PASIEN,
    tt.SARANA TARIFTINDAKAN,
    DATE_FORMAT(k.MASUK, '%M %Y') TGLMASUK,
    ref.DESKRIPSI CARABAYAR

FROM layanan.tindakan_medis tm
    LEFT JOIN pendaftaran.kunjungan k ON k.NOMOR=tm.KUNJUNGAN
    LEFT JOIN master.tindakan t ON t.ID=tm.TINDAKAN
    LEFT JOIN layanan.petugas_tindakan_medis ptm ON tm.ID=ptm.TINDAKAN_MEDIS AND ptm.JENIS=1 AND KE=1
    LEFT JOIN master.dokter dok ON ptm.MEDIS=dok.ID
    LEFT JOIN master.pegawai mp ON dok.NIP=mp.NIP
    LEFT JOIN master.tarif_tindakan tt ON tt.TINDAKAN=t.ID
    LEFT JOIN pendaftaran.pendaftaran pp ON pp.NOMOR=k.NOPEN
	LEFT JOIN pendaftaran.penjamin pj ON pp.NOMOR=pj.NOPEN
	LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
    LEFT JOIN pembayaran.rincian_tagihan rt ON tm.ID=rt.REF_ID AND rt.JENIS=3
WHERE
 k.RUANGAN LIKE '1010201%' AND
  k.STATUS=2 AND
  k.MASUK BETWEEN '2023-01-01' AND NOW() AND
  tm.`STATUS` IN (1,2) AND ptm.STATUS=1
--   AND dok.ID=109
GROUP BY tm.ID
ORDER BY k.MASUK,tm.TANGGAL