SELECT
 master.getNamaLengkap(pp.NORM) PASIEN,
       k.MASUK TGLMASUK,
       k.KELUAR TGLKELUAR,
       DATEDIFF(k.KELUAR,k.MASUK) LAMARAWAT,
        master.getNamaLengkapPegawai(mp.NIP) DPJP,
       cppt.SUBYEKTIF,
#        CONCAT(IF(k.TITIPAN_KELAS = 1, 'Kelas III',
#                 IF(k.TITIPAN_KELAS =  2, 'Kelas II',
#                     IF(k.TITIPAN_KELAS =  3, 'Kelas I',
#                         IF(k.TITIPAN_KELAS = 0, 'Kelas pasien tidak diketahui karena tidak dititipkan', ''))))) as KELAS,
       ref.DESKRIPSI PENJAMIN
FROM pendaftaran.kunjungan k
LEFT JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
LEFT JOIN master.pasien pp ON pp.NORM=p.NORM
LEFT JOIN pendaftaran.penjamin pj ON p.NOMOR=pj.NOPEN
LEFT JOIN master.referensi ref ON pj.JENIS=ref.ID AND ref.JENIS=10
LEFT JOIN master.dokter dok1 ON k.DPJP=dok1.ID
LEFT JOIN master.pegawai mp ON dok1.NIP=mp.NIP
LEFT JOIN medicalrecord.cppt ON cppt.KUNJUNGAN=k.NOMOR
WHERE k.RUANGAN = 101010101
  AND k.MASUK BETWEEN DATE_FORMAT(NOW(), "2022-01-01") AND DATE_FORMAT(NOW(), "2022-02-01")
and p.STATUS IN(1,2)
AND cppt.SUBYEKTIF LIKE '%konsul%'
AND cppt.SUBYEKTIF LIKE '%Ikhsan%'
# AND k.REF IS NULL
ORDER BY TGLMASUK;