create
    definer = admin@`%` procedure master.getTarifRuangRawat(IN PKELAS tinyint, IN PRUANG_KAMAR_TIDUR smallint,
                                                            IN PTANGGAL datetime, OUT PTARIF_ID int, OUT PTARIF int)
BEGIN
	SELECT trr.ID, trr.TARIF INTO PTARIF_ID, PTARIF
	  FROM `master`.ruang_kamar_tidur rkt,
	  		 `master`.ruang_kamar rk,
	  		 `master`.tarif_ruang_rawat trr
	 WHERE rkt.ID = PRUANG_KAMAR_TIDUR
	   AND rk.ID = rkt.RUANG_KAMAR
	   AND trr.KELAS = rk.KELAS
	   AND trr.TANGGAL_SK <= PTANGGAL
	ORDER BY trr.TANGGAL DESC LIMIT 1;	 
	
	IF FOUND_ROWS() = 0 THEN 
		SELECT trr.ID, trr.TARIF INTO PTARIF_ID, PTARIF
		  FROM `master`.ruang_kamar_tidur rkt,
		  		 `master`.ruang_kamar rk,
		  		 `master`.tarif_ruang_rawat trr
		 WHERE rkt.ID = PRUANG_KAMAR_TIDUR
		   AND rk.ID = rkt.RUANG_KAMAR
		   AND trr.KELAS = rk.KELAS
		   AND trr.`STATUS` = 1
		ORDER BY trr.TANGGAL DESC LIMIT 1;
	END IF;
	 
	IF FOUND_ROWS() = 0 THEN
		SET PTARIF_ID = NULL;
		SET PTARIF = 0;
	END IF;
END;


