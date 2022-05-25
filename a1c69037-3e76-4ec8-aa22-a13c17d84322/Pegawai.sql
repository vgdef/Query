SELECT
master.getNamaLengkapPegawai(p.NIP) PERAWAT

FROM master.perawat p
LEFT JOIN master.pegawai pp ON pp.NIP=p.NIP
WHERE pp.STATUS =1