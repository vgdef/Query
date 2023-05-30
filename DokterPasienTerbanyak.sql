SELECT
 `master`.getNamaLengkapPegawai(d.NIP) DPJP
 , smf.DESKRIPSI SMF
 , COUNT(*) KUNJUNGAN
 
FROM pendaftaran.kunjungan k
JOIN `master`.dokter d ON d.ID=k.DPJP
JOIN `master`.dokter_smf ds ON ds.DOKTER=d.ID
JOIN `master`.referensi smf ON smf.ID=ds.SMF AND smf.JENIS=26
WHERE k.MASUK BETWEEN '2023-01-01' AND '2023-01-31'
GROUP BY d.ID
ORDER BY KUNJUNGAN DESC