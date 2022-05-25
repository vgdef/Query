SELECT

t.NAMA AS TINDAKAN,
tt.SARANA AS TARIF_TINDAKAN,
       t.STATUS

FROM master.tindakan t
LEFT JOIN master.tarif_tindakan tt ON tt.TINDAKAN = t.ID
WHERE tt.`STATUS` = 1 AND t.STATUS=1
GROUP by t.ID
ORDER BY t.ID