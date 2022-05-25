SELECT
       dr.ID,
      dr.NIP,
       p.NAMA,
       sm.SMF,
       p.ID,
       p.STATUS,
       dr.STATUS
FROM master.dokter dr
LEFT JOIN aplikasi.pengguna p ON  p.NIP=dr.NIP
LEFT JOIN master.dokter_smf sm ON sm.DOKTER=dr.ID
# WHERE dr.ID =  9
GROUP BY p.ID