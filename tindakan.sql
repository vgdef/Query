SELECT  p.NORM, `master`.getNamaLengkap(p.NORM)PASIEN,t.NAMA TINDAKAN, hl.HASIL, IBS.PERMINTAAN_TINDAKAN, IBS.ALASAN
     , if(IBS.TUJUAN=101070101 AND IBS.`STATUS`=2, 'kunjungan ibs', 'tidak ke ibs') STATUS_KONSULIBAS
from layanan.tindakan_medis tm
LEFT JOIN layanan.hasil_lab hl ON hl.TINDAKAN_MEDIS=tm.id
    LEFT JOIN `master`.tindakan t ON t.ID=tm.TINDAKAN
left join pendaftaran.kunjungan k on k.NOMOR=tm.KUNJUNGAN
    left join pendaftaran.pendaftaran p on p.NOMOR=k.NOPEN
left join (SELECT ko.PERMINTAAN_TINDAKAN,  ko.TUJUAN, ko.STATUS, kk.NOPEN, ko.ALASAN FROM pendaftaran.kunjungan kk
    left join pendaftaran.konsul ko on ko.NOMOR=kk.REF
    where  ko.TUJUAN=101070101) IBS on IBS.NOPEN=k.NOPEN
WHERE
    t.NAMA LIKE 'hbsag%' and hl.HASIL LIKE '%posi%' and
       p.TANGGAL BETWEEN '2023-01-01' AND '2023-05-01'group by p.NORM