-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: car_rental_db
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cars`
--

DROP TABLE IF EXISTS `cars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cars` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vin` varchar(17) NOT NULL,
  `model` varchar(255) NOT NULL,
  `mileage` int NOT NULL,
  `rental_price_per_day` decimal(10,2) NOT NULL,
  `status` enum('available','rented','maintenance') NOT NULL DEFAULT 'available',
  PRIMARY KEY (`id`),
  UNIQUE KEY `vin` (`vin`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cars`
--

LOCK TABLES `cars` WRITE;
/*!40000 ALTER TABLE `cars` DISABLE KEYS */;
INSERT INTO `cars` VALUES (4,'1HGCM82633A004352','Toyota Camry 2020',56555,50.00,'rented'),(5,'1N4AL11D75C109151','Nissan Altima 2019',61000,45.00,'rented'),(6,'WBA3A5C56DF586739','BMW 320i 2018',80000,80.00,'maintenance'),(7,'2C3KA63H46H239675','Chrysler 300 2021',31900,70.00,'available'),(8,'3FA6P0H73HR128830','Ford Fusion 2022',20000,55.00,'maintenance');
/*!40000 ALTER TABLE `cars` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `car_status` AFTER UPDATE ON `cars` FOR EACH ROW BEGIN
    
    IF OLD.status != NEW.status AND NEW.status = 'maintenance' THEN
        INSERT INTO change_logs (entity_id, old_value, new_value)
        VALUES (NEW.id, OLD.status, 'maintenance');
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `change_logs`
--

DROP TABLE IF EXISTS `change_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `change_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `car_id` int DEFAULT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` varchar(255) DEFAULT NULL,
  `change_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `entity_id` int DEFAULT NULL,
  `rental_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_change_logs_car` (`entity_id`),
  KEY `fk_change_logs_rental` (`rental_id`),
  CONSTRAINT `fk_change_logs_car` FOREIGN KEY (`entity_id`) REFERENCES `cars` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_change_logs_rental` FOREIGN KEY (`rental_id`) REFERENCES `rentals` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `change_logs`
--

LOCK TABLES `change_logs` WRITE;
/*!40000 ALTER TABLE `change_logs` DISABLE KEYS */;
INSERT INTO `change_logs` VALUES (1,4,'available','rented','2025-06-20 19:51:36',NULL,NULL),(2,4,'rented','available','2025-06-20 19:59:05',NULL,NULL),(3,4,'available','rented','2025-06-20 20:01:46',NULL,NULL),(4,4,'rented','available','2025-06-20 20:03:37',NULL,NULL),(5,1,'available','rented','2025-06-20 20:20:40',NULL,NULL),(6,7,'available','rented','2025-06-20 20:22:07',NULL,NULL),(7,8,'available','maintenance','2025-06-20 20:45:24',NULL,NULL),(8,7,'available','rented','2025-06-24 22:29:59',NULL,NULL),(9,7,'rented','available','2025-06-24 22:36:23',NULL,NULL),(10,NULL,'rented','available','2025-06-25 00:56:54',4,NULL),(11,NULL,'available','rented','2025-06-25 00:57:50',4,NULL),(12,NULL,'rented','available','2025-06-25 01:02:50',4,NULL),(13,NULL,'available','rented','2025-06-25 01:02:56',4,9);
/*!40000 ALTER TABLE `change_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `status` enum('active','blacklisted') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (4,'Алексей Иванов','+7-911-123-4567','active'),(6,'Игорь Петров','+7-931-222-3344','active'),(7,'Елена Кузнецова','+7-912-998-7766','blacklisted');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `managers`
--

DROP TABLE IF EXISTS `managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `managers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `commission_rate` decimal(5,2) NOT NULL DEFAULT '0.01',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managers`
--

LOCK TABLES `managers` WRITE;
/*!40000 ALTER TABLE `managers` DISABLE KEYS */;
INSERT INTO `managers` VALUES (1,'Ольга Никитина','+7-900-123-1111',0.02),(2,'Дмитрий Сидоров','+7-900-321-2222',0.15);
/*!40000 ALTER TABLE `managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `rental_summary_view`
--

DROP TABLE IF EXISTS `rental_summary_view`;
/*!50001 DROP VIEW IF EXISTS `rental_summary_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `rental_summary_view` AS SELECT 
 1 AS `rental_id`,
 1 AS `client_name`,
 1 AS `car_model`,
 1 AS `manager_name`,
 1 AS `rental_start`,
 1 AS `rental_end`,
 1 AS `total`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rentals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `car_id` int NOT NULL,
  `manager_id` int NOT NULL,
  `rental_start` datetime NOT NULL,
  `rental_end` datetime NOT NULL,
  `total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `car_id` (`car_id`),
  KEY `manager_id` (`manager_id`),
  CONSTRAINT `rentals_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `rentals_ibfk_2` FOREIGN KEY (`car_id`) REFERENCES `cars` (`id`),
  CONSTRAINT `rentals_ibfk_3` FOREIGN KEY (`manager_id`) REFERENCES `managers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentals`
--

LOCK TABLES `rentals` WRITE;
/*!40000 ALTER TABLE `rentals` DISABLE KEYS */;
INSERT INTO `rentals` VALUES (1,4,4,1,'2025-06-20 00:00:00','2025-06-25 11:00:00',250.00),(2,4,4,1,'2025-06-20 00:00:00','2025-06-24 00:00:00',200.00),(5,4,4,1,'2025-06-21 10:00:00','2025-06-25 10:00:00',200.00),(6,4,4,1,'2025-06-21 10:00:00','2025-06-25 00:00:00',200.00),(7,4,7,1,'2025-06-24 00:00:00','2025-06-25 00:00:00',70.00),(8,4,4,1,'2025-06-25 00:00:00','2025-06-25 00:00:00',50.00),(9,4,4,1,'2025-06-26 10:00:00','2025-06-29 10:00:00',150.00);
/*!40000 ALTER TABLE `rentals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'car_rental_db'
--

--
-- Dumping routines for database 'car_rental_db'
--
/*!50003 DROP FUNCTION IF EXISTS `calculate_rental_total` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_rental_total`(
    p_price_per_day DECIMAL(10,2),
    p_start DATETIME,
    p_end DATETIME
) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE v_days INT;
    DECLARE v_total DECIMAL(10,2);

    
    SET v_days = DATEDIFF(p_end, p_start);
    IF v_days < 1 THEN
        SET v_days = 1;
    END IF;

    
    SET v_total = p_price_per_day * v_days;
    RETURN v_total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `blacklist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `blacklist`(
    IN p_client_id INT
)
BEGIN
    DECLARE v_exists INT;

    SET v_exists = (SELECT COUNT(*) FROM clients WHERE id = p_client_id);

    IF v_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Клиент не найден';
    ELSE
        UPDATE clients
        SET status = 'blacklisted'
        WHERE id = p_client_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rent_car` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rent_car`(
    IN p_client_id INT,
    IN p_car_id INT,
    IN p_manager_id INT,
    IN p_rental_start DATETIME,
    IN p_rental_end DATETIME
)
BEGIN
    DECLARE n_client_id INT;
    DECLARE n_car_id INT;
    DECLARE n_manager_id INT;
    DECLARE status_car VARCHAR(255);
    DECLARE status_client VARCHAR(255);
    DECLARE price_per_day DECIMAL(10,2);
    DECLARE total DECIMAL(10,2);
    DECLARE days INT;
    DECLARE new_rental_id INT;

    START TRANSACTION;

    SET n_client_id = (SELECT id FROM clients WHERE id = p_client_id);
    SET n_car_id = (SELECT id FROM cars WHERE id = p_car_id);
    SET n_manager_id = (SELECT id FROM managers WHERE id = p_manager_id);

    IF (n_client_id IS NULL OR n_car_id IS NULL OR n_manager_id IS NULL) THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Клиент, автомобиль или менеджер не найдены';
    END IF;

    SET status_client = (SELECT status FROM clients WHERE id = p_client_id);
    IF status_client = 'blacklisted' THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Клиент находится в чёрном списке и не может арендовать автомобиль';
    END IF;

    SET status_car = (SELECT status FROM cars WHERE id = p_car_id);
    IF status_car != 'available' THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Автомобиль недоступен для аренды';
    END IF;

    SET days = DATEDIFF(p_rental_end, p_rental_start);
    IF days <= 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Некорректный период аренды';
    END IF;

    SET price_per_day = (SELECT rental_price_per_day FROM cars WHERE id = p_car_id);
    SET total = price_per_day * days;

    UPDATE cars
    SET status = 'rented'
    WHERE id = p_car_id;

    INSERT INTO rentals (client_id, car_id, manager_id, rental_start, rental_end, total)
    VALUES (p_client_id, p_car_id, p_manager_id, p_rental_start, p_rental_end, total);

    SET new_rental_id = LAST_INSERT_ID();

    INSERT INTO change_logs (entity_id, old_value, new_value, rental_id)
    VALUES (p_car_id, status_car, 'rented', new_rental_id);

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `return_car` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `return_car`(
    IN p_rental_id INT,
    IN p_actual_return DATETIME,
    IN p_new_mileage INT
)
BEGIN
    DECLARE v_car_id INT;
    DECLARE v_status VARCHAR(255);
    DECLARE v_old_end DATETIME;
    DECLARE v_price_per_day DECIMAL(10,2);
    DECLARE v_total DECIMAL(10,2);
    DECLARE v_days INT;
    DECLARE v_rental_start DATETIME;
    DECLARE v_current_mileage INT;

    START TRANSACTION;

    
    SELECT r.car_id, c.status, r.rental_start, r.rental_end, c.rental_price_per_day, c.mileage
    INTO v_car_id, v_status, v_rental_start, v_old_end, v_price_per_day, v_current_mileage
    FROM rentals r
    JOIN cars c ON r.car_id = c.id
    WHERE r.id = p_rental_id;

    
    IF v_car_id IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Аренда не найдена';
    END IF;

    
    IF v_status = 'available' THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Автомобиль уже возвращён';
    END IF;

    
    IF p_new_mileage <= v_current_mileage THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Неверный пробег: меньше или равен текущему';
    END IF;

    
    SET v_days = DATEDIFF(p_actual_return, v_rental_start);
    IF v_days <= 0 THEN
        SET v_days = 1; -- минимум 1 день
    END IF;

    SET v_total = v_days * v_price_per_day;

    
    UPDATE rentals
    SET rental_end = p_actual_return,
        total = v_total
    WHERE id = p_rental_id;

    
    UPDATE cars
    SET status = 'available',
        mileage = p_new_mileage
    WHERE id = v_car_id;

    
    INSERT INTO change_logs(entity_id, old_value, new_value)
    VALUES (v_car_id, v_status, 'available');

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `rental_summary_view`
--

/*!50001 DROP VIEW IF EXISTS `rental_summary_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rental_summary_view` AS select `r`.`id` AS `rental_id`,`cl`.`full_name` AS `client_name`,`c`.`model` AS `car_model`,`m`.`full_name` AS `manager_name`,`r`.`rental_start` AS `rental_start`,`r`.`rental_end` AS `rental_end`,`r`.`total` AS `total` from (((`rentals` `r` join `clients` `cl` on((`r`.`client_id` = `cl`.`id`))) join `cars` `c` on((`r`.`car_id` = `c`.`id`))) join `managers` `m` on((`r`.`manager_id` = `m`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-25  4:06:42
