SELECT
       CONCAT(IF(t.NAMA LIKE '%Rawat Jalan%', 'Rawat Jalan (IRJ)',
                IF(t.NAMA LIKE '%Rawat Inap%','Rawat Inap (IRNA)',
                    IF(t.NAMA LIKE '%IGD%', 'Rawat Darurat (IGD)',
                        IF(t.NAMA LIKE '%Poli%','Rawat Jalan (IRJ)',
                            IF(t.NAMA LIKE '%Instalasi Gawat Darurat%','Rawat Darurat (IGD)',"")))))) as instalasi_induk,
        r.DESKRIPSI  as instalasi_pelaksana,
       t.NAMA detail_tindakan,
       tt.SARANA TARIF_TINDAKAN
           FROM master.tindakan t
LEFT JOIN master.tarif_tindakan tt ON tt.TINDAKAN=t.ID
LEFT JOIN master.tindakan_ruangan tr ON tr.TINDAKAN=t.ID
LEFT JOIN master.ruangan r ON r.ID=tr.RUANGAN
WHERE t.STATUS = 1 AND tt.STATUS=1
GROUP BY t.ID