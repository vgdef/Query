SELECT
    *
fROM regonline.reservasi r
WHERE r.JENIS_APLIKASI IN (2)
AND r.TANGGALKUNJUNGAN BETWEEN "2023-06-01" AND "2023-08-01"
AND r.CARABAYAR IN (2)