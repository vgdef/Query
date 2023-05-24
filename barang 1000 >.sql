SELECT b.ID, b.NAMA NAMA_BARANG, s.NAMA SATUAN
FROM inventory.barang b
JOIN inventory.satuan s On s.ID=b.SATUAN
WHERE b.ID >1000 AND b.KATEGORI LIKE '101%';

SELECT master.getNamaLengkapPegawai(p.NIP)
FROM master.dokter_smf ds
JOIN master.dokter d ON d.ID=ds.DOKTER
JOIN master.pegawai p ON p.NIP=d.NIP
WHERE ds.SMF IN(27,28,32) AND ds.STATUS=1;
