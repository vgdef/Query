SELECT

p.NORM,
`master`.getNamaLengkap(p.NORM) NAMAPASIEN,
`master`.getNamaLengkapPegawai(pg.NIP) DPJP,
r.DESKRIPSI RUANGAN,
p.TANGGAL TGLDAFTAR

FROM pendaftaran.pendaftaran p
LEFT JOIN pendaftaran.tujuan_pasien tp ON tp.NOPEN=p.NOMOR
LEFT JOIN master.dokter  dok2 ON tp.DOKTER=dok2.ID
LEFT JOIN `master`.pegawai pg ON pg.NIP=dok2.NIP
LEFT JOIN `master`.ruangan r ON r.ID=tp.RUANGAN
WHERE tp.DOKTER =4 AND p.TANGGAL BETWEEN '2022-01-01' AND '2023-01-01'
AND p.`STATUS`!=0;

SELECT
p.NORM,
`master`.getNamaLengkap(p.NORM) NAMAPASIEN,
t.NAMA TINDAKAN,
`master`.getNamaLengkapPegawai(pg.NIP) DOKTERRABER,
`master`.getNamaLengkapPegawai(mmp.NIP) DPJP,
r.DESKRIPSI RUANGAN,
tm.TANGGAL TGLTINDAKAN

FROM layanan.tindakan_medis tm
LEFT JOIN layanan.petugas_tindakan_medis ptm ON ptm.TINDAKAN_MEDIS=tm.ID
LEFT JOIN master.tindakan t ON tm.TINDAKAN=t.ID
LEFT JOIN master.dokter dok1 ON ptm.MEDIS=dok1.ID AND ptm.JENIS IN (1,2)
LEFT JOIN `master`.pegawai pg ON pg.NIP=dok1.NIP
LEFT JOIN pendaftaran.kunjungan k ON k.NOMOR=tm.KUNJUNGAN
LEFT JOIN pendaftaran.pendaftaran p ON p.NOMOR=k.NOPEN
LEFT JOIN master.dokter  dok2 ON k.DPJP=dok2.ID
LEFT JOIN master.pegawai mmp ON dok2.NIP=mmp.NIP
LEFT JOIN `master`.ruangan r ON r.ID=k.RUANGAN
WHERE ptm.MEDIS =4 AND p.TANGGAL BETWEEN '2022-01-01' AND '2023-01-01'
AND p.`STATUS`!=0
#   AND t.ID IN(11101,11107)
  AND k.`STATUS`=2 AND tm.`STATUS`=1;