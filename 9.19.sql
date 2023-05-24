SELECT master.getTarifRuangRawat('0', '2023-03-14');

-- --------------------------------------------------------
-- Host:                         192.168.23.129
-- Server version:               8.0.11 - MySQL Community Server - GPL
-- Server OS:                    Linux
-- HeidiSQL Version:             12.1.0.6557
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for master
CREATE DATABASE IF NOT EXISTS master /*!40100 DEFAULT CHARACTER SET latin1 */;
USE master;

-- Dumping structure for function master.getTarifRuangRawat
DROP FUNCTION IF EXISTS getTarifRuangRawat;
DELIMITER //
CREATE FUNCTION getTarifRuangRawat(
  PKELAS TINYINT,
  PTANGGAL DATETIME

) RETURNS int(11)
    DETERMINISTIC
BEGIN
  DECLARE VTARIF INT;
  SELECT trr.TARIF INTO VTARIF
    FROM master.tarif_ruang_rawat trr
   WHERE trr.KELAS = PKELAS
     AND trr.TANGGAL_SK <= PTANGGAL
  ORDER BY trr.TANGGAL DESC LIMIT 1;

  IF FOUND_ROWS() = 0 THEN
    SELECT trr.TARIF INTO VTARIF
      FROM master.tarif_ruang_rawat trr
     WHERE trr.KELAS = PKELAS
       AND trr.STATUS = 1
    ORDER BY trr.TANGGAL DESC LIMIT 1;

    IF FOUND_ROWS() = 0 THEN
      SET VTARIF = 0;
    END IF;
  END IF;

  RETURN VTARIF;
END//
DELIMITER ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
