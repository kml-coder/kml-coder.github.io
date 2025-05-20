CREATE DATABASE  IF NOT EXISTS `dbFinal` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dbFinal`;
-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: localhost    Database: dbFinal
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `account_associates`
--

DROP TABLE IF EXISTS `account_associates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_associates` (
  `acc_id` varchar(50) NOT NULL,
  PRIMARY KEY (`acc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_associates`
--

LOCK TABLES `account_associates` WRITE;
/*!40000 ALTER TABLE `account_associates` DISABLE KEYS */;
INSERT INTO `account_associates` VALUES ('1'),('1234'),('4567'),('7890');
/*!40000 ALTER TABLE `account_associates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `acc_id` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`acc_id`,`username`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`acc_id`) REFERENCES `account_associates` (`acc_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('1','admin','admin');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft` (
  `aircraft_id` varchar(50) NOT NULL,
  `num_seats` int DEFAULT NULL,
  PRIMARY KEY (`aircraft_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
INSERT INTO `aircraft` VALUES ('1',100),('101',1),('111',1),('222',2),('444',5);
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airline_company`
--

DROP TABLE IF EXISTS `airline_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airline_company` (
  `two_letter_id` char(2) NOT NULL,
  `num_aircrafts` int DEFAULT NULL,
  `num_airports` int DEFAULT NULL,
  PRIMARY KEY (`two_letter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline_company`
--

LOCK TABLES `airline_company` WRITE;
/*!40000 ALTER TABLE `airline_company` DISABLE KEYS */;
INSERT INTO `airline_company` VALUES ('12',NULL,NULL),('AB',NULL,NULL),('BC',NULL,NULL);
/*!40000 ALTER TABLE `airline_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport` (
  `three_letter_id` char(3) NOT NULL,
  PRIMARY KEY (`three_letter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
INSERT INTO `airport` VALUES ('cdg'),('EWR'),('JFK');
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `acc_id` varchar(50) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`username`),
  KEY `acc_id` (`acc_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`acc_id`) REFERENCES `account_associates` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('14','customer','customer');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_rep`
--

DROP TABLE IF EXISTS `customer_rep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_rep` (
  `acc_id` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`acc_id`,`username`),
  CONSTRAINT `customer_rep_ibfk_1` FOREIGN KEY (`acc_id`) REFERENCES `account_associates` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_rep`
--

LOCK TABLES `customer_rep` WRITE;
/*!40000 ALTER TABLE `customer_rep` DISABLE KEYS */;
INSERT INTO `customer_rep` VALUES ('15','rep','rep');
/*!40000 ALTER TABLE `customer_rep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight_search_operated_by`
--

DROP TABLE IF EXISTS `flight_search_operated_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight_search_operated_by` (
  `flight_num` varchar(50) NOT NULL,
  `two_letter_id` char(2) NOT NULL,
  `acc_id` varchar(50) DEFAULT NULL,
  `arrival_time` time DEFAULT NULL,
  `departure_time` time DEFAULT NULL,
  `arrival_date` date DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `aircraft_id` varchar(50) DEFAULT NULL,
  `days_of_operation` varchar(10) DEFAULT NULL,
  `is_domestic` tinyint(1) DEFAULT NULL,
  `departure_airport` varchar(50) DEFAULT NULL,
  `destination_airport` varchar(50) DEFAULT NULL,
  `is_flexible` tinyint(1) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `num_of_stops` int DEFAULT NULL,
  PRIMARY KEY (`flight_num`,`two_letter_id`),
  KEY `two_letter_id` (`two_letter_id`),
  KEY `acc_id` (`acc_id`),
  KEY `departure_airport` (`departure_airport`),
  KEY `destination_airport` (`destination_airport`),
  KEY `aircraft_id` (`aircraft_id`),
  CONSTRAINT `flight_search_operated_by_ibfk_1` FOREIGN KEY (`two_letter_id`) REFERENCES `airline_company` (`two_letter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `flight_search_operated_by_ibfk_2` FOREIGN KEY (`acc_id`) REFERENCES `account_associates` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `flight_search_operated_by_ibfk_3` FOREIGN KEY (`departure_airport`) REFERENCES `airport` (`three_letter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `flight_search_operated_by_ibfk_4` FOREIGN KEY (`destination_airport`) REFERENCES `airport` (`three_letter_id`) ON DELETE CASCADE,
  CONSTRAINT `flight_search_operated_by_ibfk_5` FOREIGN KEY (`aircraft_id`) REFERENCES `aircraft` (`aircraft_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_search_operated_by`
--

LOCK TABLES `flight_search_operated_by` WRITE;
/*!40000 ALTER TABLE `flight_search_operated_by` DISABLE KEYS */;
INSERT INTO `flight_search_operated_by` VALUES ('10','BC','4567','03:52:00','23:17:00','2023-12-12','2023-12-01','101','MWF',0,'cdg','jfk',1,3500,2),('11','AB','4567','14:35:00','19:42:00','2023-12-12','2023-12-10','101','MWF',0,'cdg','jfk',1,3500,0),('12','AB','4567','17:22:00','13:23:00','2023-12-20','2023-12-12','444','MWF',0,'cdg','jfk',1,3500,2),('13','BC','4567','09:14:00','02:12:00','2023-12-12','2023-12-11','444','MWF',0,'cdg','jfk',1,3500,2),('14','AB','4567','12:00:00','14:16:00','2023-12-13','2023-12-01','444','MWF',0,'cdg','jfk',1,490,0),('15','BC','4567','15:20:00','13:00:00','2023-12-13','2023-12-13','444','MWF',0,'cdg','jfk',1,1120,1),('16','AB','4567','11:14:00','08:10:00','2023-12-14','2023-12-12','444','MWF',0,'cdg','jfk',1,3500,2),('16','BC','4567','00:00:00','22:15:00','2023-12-21','2023-12-20','444','MWF',0,'jfk','cdg',1,700,1),('17','AB','1234','01:32:00','16:05:00','2023-12-23','2023-12-22','444','MWF',0,'jfk','cdg',1,3500,0),('18','BC','4567','05:28:00','13:04:00','2023-12-14','2023-12-13','444','MWF',0,'jfk','cdg',1,475,2),('3','AB','1234','23:00:00','21:00:00','2023-12-02','2023-12-01','444','MWF',0,'jfk','cdg',1,3500,1),('4','AB','4567','23:00:00','21:00:00','2023-12-02','2023-12-01','444','MWF',0,'jfk','cdg',1,3500,2),('5','AB','1234','23:00:00','21:00:00','2023-12-12','2023-12-10','444','MWF',0,'jfk','cdg',1,3500,1),('6','AB','4567','23:00:00','21:00:00','2023-12-12','2023-12-10','444','MWF',0,'jfk','cdg',1,3500,2),('7','AB','1234','20:00:00','21:00:00','2023-12-12','2023-12-10','444','MWF',0,'cdg','jfk',1,3900,1),('8','BC','4567','14:00:00','23:00:00','2023-12-12','2023-12-10','444','MWF',0,'cdg','jfk',1,3500,2),('9','AB','1234','20:00:00','21:05:00','2023-12-12','2023-12-10','111','MWF',0,'cdg','jfk',1,3900,1);
/*!40000 ALTER TABLE `flight_search_operated_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `username` varchar(50) NOT NULL,
  `question` varchar(500) NOT NULL,
  PRIMARY KEY (`username`,`question`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`username`) REFERENCES `customer` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reply`
--

DROP TABLE IF EXISTS `reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reply` (
  `reply` varchar(500) DEFAULT NULL,
  `question` varchar(500) NOT NULL,
  PRIMARY KEY (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply`
--

LOCK TABLES `reply` WRITE;
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_economy_business_first_changes_buys`
--

DROP TABLE IF EXISTS `ticket_economy_business_first_changes_buys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_economy_business_first_changes_buys` (
  `ticket_number` varchar(50) NOT NULL,
  `acc_id` varchar(50) DEFAULT NULL,
  `total_fare` int DEFAULT NULL,
  `id_number` varchar(50) DEFAULT NULL,
  `passenger_first` varchar(50) DEFAULT NULL,
  `passenger_last` varchar(50) DEFAULT NULL,
  `purchase_date_time` datetime DEFAULT NULL,
  `booking_fee` float DEFAULT NULL,
  `change_ticket_fee` float DEFAULT NULL,
  `seat_number` varchar(10) DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `flight_num` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ticket_number`),
  KEY `acc_id` (`acc_id`),
  KEY `flight_num` (`flight_num`),
  CONSTRAINT `ticket_economy_business_first_changes_buys_ibfk_1` FOREIGN KEY (`acc_id`) REFERENCES `account_associates` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ticket_economy_business_first_changes_buys_ibfk_2` FOREIGN KEY (`flight_num`) REFERENCES `flight_search_operated_by` (`flight_num`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_economy_business_first_changes_buys`
--

LOCK TABLES `ticket_economy_business_first_changes_buys` WRITE;
/*!40000 ALTER TABLE `ticket_economy_business_first_changes_buys` DISABLE KEYS */;
INSERT INTO `ticket_economy_business_first_changes_buys` VALUES ('0101','1234',560,'AB','King','Lion','2023-12-01 21:00:00',30,0,'5','economy','3'),('0202','4567',560,'AB','Jeff','Bezos','2023-12-01 21:00:00',30,0,'6','economy','3'),('0303','7890',560,'AB','George','Santos',NULL,30,0,'7','economy','4'),('0404','4567',560,'AB','Nun','Ya','2023-12-01 21:00:00',30,0,'10','economy','3'),('0505','4567',560,'AB','Lady','Gaga','2023-12-01 21:00:00',30,0,'10','economy','10'),('0606','4567',560,'AB','Tony','Stark','2023-12-01 21:00:00',30,0,'1','economy','11');
/*!40000 ALTER TABLE `ticket_economy_business_first_changes_buys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waiting_list`
--

DROP TABLE IF EXISTS `waiting_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `waiting_list` (
  `acc_id` varchar(50) NOT NULL,
  `flight_num` varchar(50) NOT NULL,
  PRIMARY KEY (`acc_id`,`flight_num`),
  KEY `flight_num` (`flight_num`),
  CONSTRAINT `waiting_list_ibfk_1` FOREIGN KEY (`acc_id`) REFERENCES `customer` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `waiting_list_ibfk_2` FOREIGN KEY (`flight_num`) REFERENCES `flight_search_operated_by` (`flight_num`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waiting_list`
--

LOCK TABLES `waiting_list` WRITE;
/*!40000 ALTER TABLE `waiting_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `waiting_list` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-17 18:01:09
