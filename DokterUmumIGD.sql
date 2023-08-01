SELECT
    pj.NOMOR SEP,
      master.getNamaLengkap(p.NORM) PASIEN,
    master.getNamaLengkapPegawai(d.NIP) DPJPIGD,
    r.DESKRIPSI RUANGAN,
    k.MASUK,
    k.KELUAR

FROM pendaftaran.kunjungan k
JOIN master.dokter d ON d.ID=k.DPJP
JOIN master.dokter_smf ds ON ds.DOKTER=d.ID
JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
JOIN pendaftaran.penjamin pj ON pj.NOPEN=p.NOMOR
JOIN master.ruangan r ON k.RUANGAN = r.ID
WHERE k.KELUAR BETWEEN '2023-02-01' AND '2023-03-01' AND  ds.SMF= 31
AND pj.JENIS=2
AND k.RUANGAN LIKE '1010101%'
GROUP BY k.NOMOR