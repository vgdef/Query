SELECT
 `master`.getNamaLengkapPegawai(d.NIP) DPJP
     , d.NIP
     ,smf.ID
 , smf.DESKRIPSI SMF
 , COUNT(*) KUNJUNGAN
 
FROM pendaftaran.kunjungan k
JOIN `master`.dokter d ON d.ID=k.DPJP
JOIN `master`.dokter_smf ds ON ds.DOKTER=d.ID
JOIN `master`.referensi smf ON smf.ID=ds.SMF AND smf.JENIS=26
WHERE k.MASUK BETWEEN '2023-01-01' AND '2023-03-31'
AND ds.STATUS!=0 AND d.STATUS=1 AND ds.SMF!=31 AND smf.STATUS=1
GROUP BY d.ID
ORDER BY KUNJUNGAN DESC