SELECT
    r.DESKRIPSI CARAPULANG,
    COUNT(k.NOMOR)
FROM pendaftaran.kunjungan k
JOIN layanan.pasien_pulang pp ON pp.KUNJUNGAN=k.NOMOR
JOIN master.referensi r ON r.ID=pp.CARA AND r.JENIS=46
JOIN master.ruangan rgn ON rgn.ID=k.RUANGAN
WHERE k.MASUK BETWEEN '2023-01-01' AND '2023-03-31' AND rgn.JENIS_KUNJUNGAN=3
GROUP BY r.ID;