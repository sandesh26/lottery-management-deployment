-- MySQL dump 10.13  Distrib 8.0.46, for macos26.6 (arm64)
--
-- Host: localhost    Database: LotteryManagement
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Bet`
--

DROP TABLE IF EXISTS `Bet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Bet` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ticketId` int NOT NULL,
  `gameId` int NOT NULL,
  `selectedNumber` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `betType` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `multiplier` double NOT NULL DEFAULT '90',
  `potentialPayout` double NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `hasRedeemed` tinyint(1) NOT NULL DEFAULT '0',
  `close` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `open` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'BOTH',
  `redeemedAmount` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `Bet_ticketId_idx` (`ticketId`),
  KEY `Bet_gameId_idx` (`gameId`),
  KEY `Bet_selectedNumber_idx` (`selectedNumber`),
  KEY `Bet_open_idx` (`open`),
  KEY `Bet_close_idx` (`close`),
  CONSTRAINT `Bet_gameId_fkey` FOREIGN KEY (`gameId`) REFERENCES `Game` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Bet_ticketId_fkey` FOREIGN KEY (`ticketId`) REFERENCES `Ticket` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bet`
--

LOCK TABLES `Bet` WRITE;
/*!40000 ALTER TABLE `Bet` DISABLE KEYS */;
INSERT INTO `Bet` VALUES (109,88,2026111417,'6','Close Digit Bet',2500,7,17500,'2026-11-14 12:08:22.129',0,'6',NULL,'CLOSE',0),(110,89,2026111418,'9','Open Digit Bet',2500,7,17500,'2026-11-14 12:54:40.680',0,NULL,'9','OPEN',0);
/*!40000 ALTER TABLE `Bet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cage`
--

DROP TABLE IF EXISTS `Cage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cageCode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CAGE-01',
  `stationName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Cage Desk #01',
  `operatorId` int DEFAULT NULL,
  `openingFloat` double NOT NULL DEFAULT '100000',
  `currentBalance` double NOT NULL DEFAULT '100000',
  `totalPayout` double NOT NULL DEFAULT '0',
  `todayPaidCount` int NOT NULL DEFAULT '0',
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'OPEN',
  `openedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `closedAt` datetime(3) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Cage_cageCode_key` (`cageCode`),
  KEY `Cage_operatorId_idx` (`operatorId`),
  KEY `Cage_status_idx` (`status`),
  CONSTRAINT `Cage_operatorId_fkey` FOREIGN KEY (`operatorId`) REFERENCES `Employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cage`
--

LOCK TABLES `Cage` WRITE;
/*!40000 ALTER TABLE `Cage` DISABLE KEYS */;
INSERT INTO `Cage` VALUES (8,'CAGE-01','Cage Desk #01',NULL,100000,100000,0,0,'OPEN','2026-11-14 08:22:17.819',NULL,'2026-11-14 08:22:17.819','2026-11-14 08:22:17.820');
/*!40000 ALTER TABLE `Cage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DowntimeIncident`
--

DROP TABLE IF EXISTS `DowntimeIncident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DowntimeIncident` (
  `id` int NOT NULL AUTO_INCREMENT,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CLIENT',
  `deviceId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employeeId` int DEFAULT NULL,
  `serviceUrl` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `startedAt` datetime(3) NOT NULL,
  `endedAt` datetime(3) NOT NULL,
  `durationSeconds` int NOT NULL,
  `reason` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `failedRequests` int NOT NULL DEFAULT '0',
  `details` text COLLATE utf8mb4_unicode_ci,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  KEY `DowntimeIncident_source_idx` (`source`),
  KEY `DowntimeIncident_deviceId_idx` (`deviceId`),
  KEY `DowntimeIncident_startedAt_idx` (`startedAt`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DowntimeIncident`
--

LOCK TABLES `DowntimeIncident` WRITE;
/*!40000 ALTER TABLE `DowntimeIncident` DISABLE KEYS */;
INSERT INTO `DowntimeIncident` VALUES (1,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-23 15:20:02.769','2026-10-23 15:22:26.254',143,'Failed to fetch',473,'{\"failedEndpoints\":[\"/api/admin/game-analytics?startDate=2026-10-23&endDate=2026-10-23\",\"/api/transactions?limit=1000&startDate=2026-10-23&endDate=2026-10-23\",\"/api/health\",\"/api/admin/metrics\",\"/api/games?\",\"/api/payout-rules\",\"/api/employees?\",\"/api/results?limit=100\",\"/api/terminal-config\",\"/api/tablets\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\"}','2026-10-23 15:22:26.645'),(2,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-23 18:18:04.884','2026-10-23 18:18:06.659',2,'Failed to fetch',11,'{\"failedEndpoints\":[\"/api/admin/game-analytics?startDate=2026-10-23&endDate=2026-10-23\",\"/api/tablets\",\"/api/health\",\"/api/transactions?limit=1000&startDate=2026-10-23&endDate=2026-10-23\",\"/api/employees?\",\"/api/payout-rules\",\"/api/results?limit=100\",\"/api/admin/metrics\",\"/api/games?\",\"/api/terminal-config\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\"}','2026-10-23 18:18:07.143'),(3,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-23 18:24:31.440','2026-10-23 18:24:33.828',2,'Failed to fetch',11,'{\"failedEndpoints\":[\"/api/payout-rules\",\"/api/admin/metrics\",\"/api/admin/game-analytics?startDate=2026-10-23&endDate=2026-10-23\",\"/api/tablets\",\"/api/employees?\",\"/api/games?\",\"/api/games?status=true\",\"/api/results?limit=100\",\"/api/terminal-config\",\"/api/transactions?limit=1000&startDate=2026-10-23&endDate=2026-10-23\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\"}','2026-10-23 18:24:34.476'),(4,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-23 18:24:45.968','2026-10-23 18:24:47.565',2,'Failed to fetch',1,'{\"failedEndpoints\":[\"/api/games?status=true\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\"}','2026-10-23 18:24:48.123'),(5,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-23 18:31:44.896','2026-10-23 18:31:52.199',7,'signal is aborted without reason',4,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\"}','2026-10-23 18:31:52.683'),(6,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 04:29:06.966','2026-10-24 04:29:10.241',3,'signal is aborted without reason',1,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\"}','2026-10-24 04:29:10.436'),(7,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 05:06:17.590','2026-10-24 05:06:19.724',2,'Failed to fetch',1,'{\"failedEndpoints\":[\"/api/tickets?limit=20\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\"}','2026-10-24 05:06:19.851'),(8,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 05:46:18.147','2026-10-24 05:46:20.155',2,'Failed to fetch',1,'{\"failedEndpoints\":[\"/api/games?status=true\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\"}','2026-10-24 05:46:20.171'),(9,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 06:14:51.634','2026-10-24 06:15:15.422',24,'signal is aborted without reason',4,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 06:15:46.818'),(10,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 06:15:20.218','2026-10-24 06:15:45.231',25,'signal is aborted without reason',4,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 06:15:47.152'),(11,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 06:40:23.634','2026-10-24 06:40:27.453',4,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/verify\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 06:40:27.539'),(12,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 06:41:15.109','2026-10-24 06:41:18.062',3,'Failed to fetch',2,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 06:41:18.120'),(13,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 06:41:15.666','2026-10-24 06:41:17.802',2,'Failed to fetch',1,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 06:41:19.359'),(14,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 06:41:28.790','2026-10-24 06:41:31.402',3,'Failed to fetch',1,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 06:41:33.013'),(15,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 06:41:30.351','2026-10-24 06:41:32.538',2,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/health\",\"/api/tablets/verify\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 06:41:32.611'),(16,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 06:41:45.284','2026-10-24 06:41:47.306',2,'Failed to fetch',1,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 06:41:47.334'),(17,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 06:41:50.437','2026-10-24 06:41:52.486',2,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/health\",\"/api/tablets/verify\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 06:41:52.500'),(18,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 07:38:10.181','2026-10-24 07:38:29.019',19,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/verify\",\"/api/tickets?limit=20\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 07:38:31.155'),(19,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 08:19:07.270','2026-10-24 08:19:10.588',3,'Failed to fetch',1,'{\"failedEndpoints\":[\"/api/games?status=true\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 08:19:10.732'),(20,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 08:20:41.654','2026-10-24 08:20:59.006',17,'Failed to fetch',2,'{\"failedEndpoints\":[\"/api/tablets/verify\",\"/api/tickets?limit=20\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 08:20:59.276'),(21,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 08:21:18.648','2026-10-24 08:21:22.490',4,'signal is aborted without reason',1,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 08:21:24.568'),(22,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 08:21:39.790','2026-10-24 08:21:44.510',5,'Failed to fetch',1,'{\"failedEndpoints\":[\"/api/tablets/verify\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 08:21:44.743'),(23,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 08:23:05.971','2026-10-24 08:23:09.401',3,'Failed to fetch',2,'{\"failedEndpoints\":[\"/api/tablets/verify\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 08:23:09.593'),(24,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 08:23:05.971','2026-10-24 08:23:09.401',3,'Failed to fetch',2,'{\"failedEndpoints\":[\"/api/tablets/verify\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 08:23:24.281'),(25,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 08:23:11.829','2026-10-24 08:23:23.149',11,'Failed to fetch',3,'{\"failedEndpoints\":[\"/api/games?status=true\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 08:23:26.280'),(26,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 08:23:33.368','2026-10-24 08:23:39.350',6,'Failed to fetch',1,'{\"failedEndpoints\":[\"/api/tablets/verify\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 08:23:39.598'),(27,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 08:24:10.707','2026-10-24 08:24:15.618',5,'Failed to fetch',2,'{\"failedEndpoints\":[\"/api/games?status=true\",\"/api/tablets/verify\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 08:24:15.756'),(28,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 08:25:50.437','2026-10-24 08:25:52.631',2,'Failed to fetch',1,'{\"failedEndpoints\":[\"/api/tablets/verify\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 08:25:52.712'),(29,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 10:58:47.049','2026-10-24 10:58:49.159',2,'signal is aborted without reason',2,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (iPad; CPU OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1\"}','2026-10-24 10:58:49.206'),(30,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:00:35.694','2026-10-24 11:03:38.284',183,'signal is aborted without reason',31,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:04:16.418'),(31,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:03:41.098','2026-10-24 11:04:14.901',34,'signal is aborted without reason',5,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:04:16.822'),(32,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:04:16.596','2026-10-24 11:04:18.593',2,'signal is aborted without reason',1,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:04:20.845'),(33,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:04:35.394','2026-10-24 11:04:49.227',14,'signal is aborted without reason',5,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:04:50.794'),(34,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:07:55.156','2026-10-24 11:08:56.894',62,'Failed to fetch',30,'{\"failedEndpoints\":[\"/api/tickets?gameId=2026102416&limit=150\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:08:58.430'),(35,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:12:12.706','2026-10-24 11:12:20.081',7,'Failed to fetch',6,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:12:46.909'),(36,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 11:19:13.208','2026-10-24 11:19:15.254',2,'Failed to fetch',28,'{\"failedEndpoints\":[\"/api/transactions?limit=1000&startDate=2026-10-24&endDate=2026-10-24\",\"/api/admin/game-analytics?startDate=2026-10-24&endDate=2026-10-24\",\"/api/admin/metrics\",\"/api/games?\",\"/api/payout-rules\",\"/api/employees?\",\"/api/results?limit=100\",\"/api/terminal-config\",\"/api/tablets\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\"}','2026-10-24 11:19:15.874'),(37,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 11:19:39.068','2026-10-24 11:19:43.207',4,'Failed to fetch',41,'{\"failedEndpoints\":[\"/api/transactions?limit=1000&startDate=2026-10-24&endDate=2026-10-24\",\"/api/admin/game-analytics?startDate=2026-10-24&endDate=2026-10-24\",\"/api/admin/metrics\",\"/api/games?\",\"/api/payout-rules\",\"/api/employees?\",\"/api/results?limit=100\",\"/api/terminal-config\",\"/api/tablets\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\"}','2026-10-24 11:19:43.708'),(38,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 11:20:00.782','2026-10-24 11:20:05.038',4,'Failed to fetch',41,'{\"failedEndpoints\":[\"/api/transactions?limit=1000&startDate=2026-10-24&endDate=2026-10-24\",\"/api/admin/game-analytics?startDate=2026-10-24&endDate=2026-10-24\",\"/api/admin/metrics\",\"/api/games?\",\"/api/payout-rules\",\"/api/employees?\",\"/api/results?limit=100\",\"/api/terminal-config\",\"/api/tablets\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\"}','2026-10-24 11:20:05.533'),(39,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:14:49.822','2026-10-24 11:14:58.733',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:21:55.742'),(40,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:15:00.190','2026-10-24 11:15:09.130',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:21:55.872'),(41,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:15:10.707','2026-10-24 11:15:19.247',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:21:55.975'),(42,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:09:54.421','2026-10-24 11:11:59.320',125,'signal is aborted without reason',94,'{\"failedEndpoints\":[\"/api/health\",\"/api/games?status=true\",\"/api/terminal-config\",\"/api/tickets?limit=20\",\"/api/payout-rules\",\"/api/employees?\",\"/api/shift-audits/current?employeeId=2\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:29.847'),(43,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:12:02.385','2026-10-24 11:12:09.647',7,'Failed to fetch',6,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.033'),(44,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:12:12.706','2026-10-24 11:12:20.081',7,'Failed to fetch',6,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.186'),(45,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:12:23.160','2026-10-24 11:12:30.660',8,'Failed to fetch',6,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.270'),(46,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:12:33.742','2026-10-24 11:12:41.409',8,'Failed to fetch',7,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.331'),(47,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:13:10.997','2026-10-24 11:13:15.245',4,'Failed to fetch',10,'{\"failedEndpoints\":[\"/api/tickets?gameId=2026102416&limit=150\",\"/api/tickets?gameId=2026102503&limit=150\",\"/api/games?status=true\",\"/api/terminal-config\",\"/api/tickets?limit=20\",\"/api/payout-rules\",\"/api/employees?\",\"/api/shift-audits/current?employeeId=2\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.382'),(48,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:13:19.800','2026-10-24 11:13:25.550',6,'Failed to fetch',5,'{\"failedEndpoints\":[\"/api/tickets?gameId=2026102503&limit=150\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.440'),(49,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:13:37.405','2026-10-24 11:13:46.158',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.492'),(50,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:13:47.737','2026-10-24 11:13:56.450',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.552'),(51,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:13:58.048','2026-10-24 11:14:06.596',9,'Failed to fetch',6,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.606'),(52,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:14:08.205','2026-10-24 11:14:16.877',9,'Failed to fetch',5,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.656'),(53,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:14:18.477','2026-10-24 11:14:27.544',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.705'),(54,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:14:29.046','2026-10-24 11:14:37.841',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/health\",\"/api/tablets/TAB-01\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.753'),(55,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:14:39.317','2026-10-24 11:14:48.357',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.800'),(56,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:15:20.840','2026-10-24 11:15:29.598',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.847'),(57,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:15:31.098','2026-10-24 11:15:39.884',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.892'),(58,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:15:41.431','2026-10-24 11:15:50.173',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.938'),(59,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:15:51.732','2026-10-24 11:16:00.454',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:30.988'),(60,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:16:02.058','2026-10-24 11:16:30.930',29,'Failed to fetch',14,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.037'),(61,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:16:32.467','2026-10-24 11:16:41.149',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.086'),(62,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:16:42.712','2026-10-24 11:16:51.448',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.151'),(63,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:16:53.018','2026-10-24 11:17:02.025',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.197'),(64,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:17:03.461','2026-10-24 11:17:12.226',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.242'),(65,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:17:13.648','2026-10-24 11:17:43.741',30,'Failed to fetch',9,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.290'),(66,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:17:45.287','2026-10-24 11:17:53.762',8,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.339'),(67,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:17:55.346','2026-10-24 11:18:04.088',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.383'),(68,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:18:05.646','2026-10-24 11:18:14.438',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.434'),(69,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:18:15.987','2026-10-24 11:18:24.680',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.478'),(70,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:18:26.245','2026-10-24 11:18:35.015',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.522'),(71,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:18:36.549','2026-10-24 11:18:45.272',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.568'),(72,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:18:50.420','2026-10-24 11:18:55.662',5,'signal is aborted without reason',4,'{\"failedEndpoints\":[\"/api/health\",\"/api/tablets/TAB-01\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.613'),(73,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:18:57.199','2026-10-24 11:19:06.877',10,'Failed to fetch',5,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.661'),(74,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:19:08.428','2026-10-24 11:19:16.998',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.711'),(75,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:19:18.581','2026-10-24 11:19:27.475',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.757'),(76,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:19:29.005','2026-10-24 11:19:37.900',9,'Failed to fetch',5,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.809'),(77,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:19:39.454','2026-10-24 11:19:48.314',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.857'),(78,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:19:49.899','2026-10-24 11:19:58.886',9,'Failed to fetch',5,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.902'),(79,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:20:00.479','2026-10-24 11:20:09.105',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.940'),(80,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:20:10.690','2026-10-24 11:20:19.453',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:31.977'),(81,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:20:20.984','2026-10-24 11:20:30.727',10,'Failed to fetch',5,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.012'),(82,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:20:32.325','2026-10-24 11:20:40.976',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.054'),(83,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:20:42.525','2026-10-24 11:20:51.266',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.096'),(84,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:20:52.798','2026-10-24 11:21:01.596',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.143'),(85,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:21:03.151','2026-10-24 11:21:11.884',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.189'),(86,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:21:13.431','2026-10-24 11:21:22.291',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.233'),(87,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:21:27.238','2026-10-24 11:21:32.601',5,'signal is aborted without reason',4,'{\"failedEndpoints\":[\"/api/health\",\"/api/tablets/TAB-01\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.278'),(88,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:21:34.168','2026-10-24 11:22:02.828',29,'Failed to fetch',9,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.320'),(89,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:22:04.369','2026-10-24 11:22:13.415',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.363'),(90,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:22:14.972','2026-10-24 11:22:24.041',9,'Failed to fetch',5,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.408'),(91,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:22:25.593','2026-10-24 11:22:34.362',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.455'),(92,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:22:35.904','2026-10-24 11:22:44.717',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.505'),(93,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:22:46.286','2026-10-24 11:22:55.241',9,'Failed to fetch',5,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.549'),(94,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:22:56.790','2026-10-24 11:23:05.573',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.600'),(95,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:23:07.119','2026-10-24 11:23:38.342',31,'Failed to fetch',15,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.642'),(96,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:23:39.897','2026-10-24 11:23:48.657',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.685'),(97,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:23:50.197','2026-10-24 11:23:59.156',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.725'),(98,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:24:01.555','2026-10-24 11:24:09.661',8,'signal is aborted without reason',4,'{\"failedEndpoints\":[\"/api/health\",\"/api/tablets/TAB-01\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.769'),(99,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:24:25.132','2026-10-24 11:24:30.758',6,'signal is aborted without reason',4,'{\"failedEndpoints\":[\"/api/health\",\"/api/tablets/TAB-01\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.812'),(100,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:24:32.313','2026-10-24 11:24:41.281',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.854'),(101,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:24:42.743','2026-10-24 11:24:52.819',10,'Failed to fetch',5,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.890'),(102,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:25:00.528','2026-10-24 11:25:09.323',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.927'),(103,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:25:21.197','2026-10-24 11:25:30.146',9,'Failed to fetch',5,'{\"failedEndpoints\":[\"/api/health\",\"/api/tablets/TAB-01\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:32.963'),(104,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:25:42.014','2026-10-24 11:25:51.000',9,'Failed to fetch',4,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:33.003'),(105,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:26:06.514','2026-10-24 11:26:12.982',6,'signal is aborted without reason',5,'{\"failedEndpoints\":[\"/api/health\",\"/api/tablets/TAB-01\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:33.046'),(106,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:26:24.818','2026-10-24 11:26:34.074',9,'Failed to fetch',5,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:33.100'),(107,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 11:26:35.629','2026-10-24 11:32:27.394',352,'Failed to fetch',3,'{\"failedEndpoints\":[\"/api/tablets/TAB-01\",\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 11:32:33.140'),(108,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 13:10:05.415','2026-10-24 13:10:49.772',44,'Failed to fetch',14,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 13:10:51.544'),(109,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-24 13:10:06.979','2026-10-24 13:10:52.616',46,'Failed to fetch',16,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\"}','2026-10-24 13:10:52.632'),(110,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 13:40:21.182','2026-10-24 13:55:31.274',910,'signal is aborted without reason',70,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 13:55:33.771'),(111,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 13:56:27.764','2026-10-24 14:11:38.071',910,'signal is aborted without reason',70,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 14:11:40.248'),(112,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 14:23:45.020','2026-10-24 14:24:40.428',55,'signal is aborted without reason',5,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 14:24:42.357'),(113,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 14:45:04.764','2026-10-24 14:45:40.821',36,'signal is aborted without reason',5,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 14:45:42.449'),(114,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 14:54:51.922','2026-10-24 14:55:21.182',29,'signal is aborted without reason',4,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 14:55:22.746'),(115,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 14:56:26.922','2026-10-24 17:20:07.647',8621,'signal is aborted without reason',27,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 17:20:11.823'),(116,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 17:21:29.761','2026-10-24 17:22:07.954',38,'signal is aborted without reason',17,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 17:22:09.524'),(117,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 17:23:11.239','2026-10-24 17:31:31.933',501,'signal is aborted without reason',3,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 17:31:33.442'),(118,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 17:46:15.600','2026-10-24 18:01:51.612',936,'Failed to fetch',1,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-10-24 18:01:53.137'),(119,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-10-25 19:20:44.991','2026-11-03 10:50:05.961',746961,'Failed to fetch',1366,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\"}','2026-11-03 10:50:06.056'),(120,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-11-14 07:05:33.799','2026-11-14 07:11:21.730',348,'Failed to fetch',161,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36\"}','2026-11-14 07:11:23.032'),(121,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-11-14 07:05:33.799','2026-11-14 07:11:21.731',348,'Failed to fetch',161,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36\"}','2026-11-14 07:11:23.126'),(122,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-11-14 07:37:49.591','2026-11-14 07:38:10.638',21,'Failed to fetch',6,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36\"}','2026-11-14 07:38:14.588'),(123,'CLIENT','TAB-01',NULL,'http://localhost:5001','2026-11-14 07:37:49.591','2026-11-14 07:38:10.638',21,'Failed to fetch',6,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36\"}','2026-11-14 07:38:14.378'),(124,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-10-24 20:50:52.464','2026-11-14 10:38:23.106',1777651,'signal is aborted without reason',31,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-11-14 10:42:37.212'),(125,'CLIENT','TAB-01',NULL,'http://192.168.1.67:5001','2026-11-14 10:38:30.690','2026-11-14 10:42:30.775',240,'signal is aborted without reason',78,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-11-14 10:42:37.504'),(126,'CLIENT','TAB-01',NULL,'http://192.168.0.116:5001','2026-11-14 11:51:13.318','2026-11-14 11:54:54.932',222,'signal is aborted without reason',45,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-11-14 11:54:56.049'),(127,'CLIENT','TAB-01',NULL,'http://192.168.0.116:5001','2026-11-14 12:22:11.971','2026-11-14 12:25:22.295',190,'signal is aborted without reason',87,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Linux; Android 9; Lenovo TB-X605L Build/PKQ1.190319.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Safari/537.36\"}','2026-11-14 12:25:23.279'),(128,'CLIENT',NULL,NULL,'http://localhost:5001','2026-11-15 02:32:43.296','2026-11-15 03:41:30.986',4128,'Fetch is aborted',25,'{\"failedEndpoints\":[\"/api/health\"],\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6 Safari/605.1.15\"}','2026-11-15 03:41:31.380');
/*!40000 ALTER TABLE `DowntimeIncident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `badgeId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pin` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` enum('ADMIN','OPERATOR','CAGE_OPERATOR') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `rfid` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Employee_badgeId_key` (`badgeId`),
  UNIQUE KEY `Employee_phone_key` (`phone`),
  UNIQUE KEY `Employee_rfid_key` (`rfid`),
  UNIQUE KEY `Employee_username_key` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES (1,'Sarah Connor','ADM-1001','1001','+91 98200 11001','ADMIN',1,'2026-09-28 15:18:05.807','2026-10-22 19:47:18.035','RFID000333','Lottery@123','admin.sarah'),(2,'Marcus Vance','OP-9042','9042','+91 98200 90420','OPERATOR',1,'2026-09-28 15:18:05.921','2026-10-04 13:27:13.768','RFID000111',NULL,NULL),(3,'Elena Rostova','CAGE-3011','3011','+91 98200 77310','CAGE_OPERATOR',1,'2026-09-28 15:18:05.924','2026-10-22 19:47:18.035','RFID000222','Lottery@123','cage.elena'),(4,'Sandesh','CAGE-3012','2626',NULL,'CAGE_OPERATOR',1,'2026-10-08 02:17:17.359','2026-10-23 07:09:30.001','RFID000444','Lottery@123','cage.sandesh');
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Game`
--

DROP TABLE IF EXISTS `Game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Game` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `openTime` datetime(3) NOT NULL,
  `closeTime` datetime(3) NOT NULL,
  `resultTime` datetime(3) NOT NULL,
  `baseMultiplier` double NOT NULL DEFAULT '90',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `isLocked` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `closeResultTime` datetime(3) DEFAULT NULL,
  `openResultTime` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Game_code_key` (`code`),
  KEY `Game_status_idx` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2026111601 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Game`
--

LOCK TABLES `Game` WRITE;
/*!40000 ALTER TABLE `Game` DISABLE KEYS */;
INSERT INTO `Game` VALUES (2026111413,'Hourly Draw (13:00 IST)','2026111413','2026-11-14 07:30:00.000','2026-11-14 08:30:00.000','2026-11-14 08:25:00.187',70,1,1,'2026-11-14 08:22:17.856','2026-11-14 08:25:00.194','2026-11-14 08:30:00.000','2026-11-14 08:00:00.000'),(2026111414,'Hourly Draw (14:00 IST)','2026111414','2026-11-14 08:30:00.000','2026-11-14 09:30:00.000','2026-11-14 09:25:00.923',70,1,1,'2026-11-14 08:22:17.870','2026-11-14 09:25:00.966','2026-11-14 09:30:00.000','2026-11-14 09:00:00.000'),(2026111415,'Hourly Draw (15:00 IST)','2026111415','2026-11-14 09:30:00.000','2026-11-14 10:30:00.000','2026-11-14 10:25:00.981',70,1,1,'2026-11-14 08:22:17.881','2026-11-14 10:25:01.015','2026-11-14 10:30:00.000','2026-11-14 10:00:00.000'),(2026111416,'Hourly Draw (16:00 IST)','2026111416','2026-11-14 10:30:00.000','2026-11-14 11:30:00.000','2026-11-14 11:25:00.294',70,1,1,'2026-11-14 08:22:17.902','2026-11-14 11:25:00.312','2026-11-14 11:30:00.000','2026-11-14 11:00:00.000'),(2026111417,'Hourly Draw (17:00 IST)','2026111417','2026-11-14 11:30:00.000','2026-11-14 12:30:00.000','2026-11-14 12:25:22.013',70,1,1,'2026-11-14 08:22:17.909','2026-11-14 12:25:23.598','2026-11-14 12:30:00.000','2026-11-14 12:00:00.000'),(2026111418,'Hourly Draw (18:00 IST)','2026111418','2026-11-14 12:30:00.000','2026-11-14 13:30:00.000','2026-11-14 13:36:41.826',70,1,1,'2026-11-14 08:22:17.915','2026-11-14 13:36:42.636','2026-11-14 13:30:00.000','2026-11-14 13:00:00.000'),(2026111419,'Hourly Draw (19:00 IST)','2026111419','2026-11-14 13:30:00.000','2026-11-14 14:30:00.000','2026-11-14 14:34:57.267',70,1,1,'2026-11-14 08:22:17.920','2026-11-14 14:34:58.025','2026-11-14 14:30:00.000','2026-11-14 14:00:00.000'),(2026111420,'Hourly Draw (20:00 IST)','2026111420','2026-11-14 14:30:00.000','2026-11-14 15:30:00.000','2026-11-14 15:38:55.984',70,1,1,'2026-11-14 08:22:17.924','2026-11-14 15:38:56.226','2026-11-14 15:30:00.000','2026-11-14 15:00:00.000'),(2026111421,'Hourly Draw (21:00 IST)','2026111421','2026-11-14 15:30:00.000','2026-11-14 16:30:00.000','2026-11-14 16:34:46.881',70,1,1,'2026-11-14 08:22:17.928','2026-11-14 16:34:46.926','2026-11-14 16:30:00.000','2026-11-14 16:00:00.000'),(2026111422,'Hourly Draw (22:00 IST)','2026111422','2026-11-14 16:30:00.000','2026-11-14 17:30:00.000','2026-11-14 17:40:08.951',70,1,1,'2026-11-14 08:22:17.932','2026-11-14 17:40:09.083','2026-11-14 17:30:00.000','2026-11-14 17:00:00.000'),(2026111423,'Hourly Draw (23:00 IST)','2026111423','2026-11-14 17:30:00.000','2026-11-14 18:30:00.000','2026-11-14 18:39:03.449',70,1,1,'2026-11-14 08:22:17.936','2026-11-14 18:39:03.588','2026-11-14 18:30:00.000','2026-11-14 18:00:00.000'),(2026111500,'Hourly Draw (00:00 IST)','2026111500','2026-11-14 18:30:00.000','2026-11-14 19:30:00.000','2026-11-14 19:26:45.452',70,1,1,'2026-11-14 08:22:17.939','2026-11-14 19:26:45.504','2026-11-14 19:30:00.000','2026-11-14 19:00:00.000'),(2026111501,'Hourly Draw (01:00 IST)','2026111501','2026-11-14 19:30:00.000','2026-11-14 20:30:00.000','2026-11-14 20:26:15.935',70,1,1,'2026-11-14 08:22:17.942','2026-11-14 20:26:15.963','2026-11-14 20:30:00.000','2026-11-14 20:00:00.000'),(2026111502,'Hourly Draw (02:00 IST)','2026111502','2026-11-14 20:30:00.000','2026-11-14 21:30:00.000','2026-11-14 21:34:51.054',70,1,1,'2026-11-14 08:30:02.547','2026-11-14 21:34:51.237','2026-11-14 21:30:00.000','2026-11-14 21:00:00.000'),(2026111503,'Hourly Draw (03:00 IST)','2026111503','2026-11-14 21:30:00.000','2026-11-14 22:30:00.000','2026-11-14 22:26:09.333',70,1,1,'2026-11-14 09:30:03.594','2026-11-14 22:26:09.371','2026-11-14 22:30:00.000','2026-11-14 22:00:00.000'),(2026111504,'Hourly Draw (04:00 IST)','2026111504','2026-11-14 22:30:00.000','2026-11-14 23:30:00.000','2026-11-14 23:32:07.560',70,1,1,'2026-11-14 10:30:09.624','2026-11-14 23:32:07.612','2026-11-14 23:30:00.000','2026-11-14 23:00:00.000'),(2026111505,'Hourly Draw (05:00 IST)','2026111505','2026-11-14 23:30:00.000','2026-11-15 00:30:00.000','2026-11-15 00:28:54.209',70,1,1,'2026-11-14 11:30:00.656','2026-11-15 00:28:54.315','2026-11-15 00:30:00.000','2026-11-15 00:00:00.000'),(2026111506,'Hourly Draw (06:00 IST)','2026111506','2026-11-15 00:30:00.000','2026-11-15 01:30:00.000','2026-11-15 01:30:04.951',70,1,1,'2026-11-14 12:30:05.295','2026-11-15 01:30:04.983','2026-11-15 01:30:00.000','2026-11-15 01:00:00.000'),(2026111507,'Hourly Draw (07:00 IST)','2026111507','2026-11-15 01:30:00.000','2026-11-15 02:30:00.000','2026-11-15 02:32:42.753',70,1,1,'2026-11-14 13:36:42.713','2026-11-15 02:32:43.317','2026-11-15 02:30:00.000','2026-11-15 02:00:00.000'),(2026111508,'Hourly Draw (08:00 IST)','2026111508','2026-11-15 02:30:00.000','2026-11-15 03:30:00.000','2026-11-15 03:30:49.550',70,1,1,'2026-11-14 14:34:57.450','2026-11-15 03:30:49.617','2026-11-15 03:30:00.000','2026-11-15 03:00:00.000'),(2026111509,'Hourly Draw (09:00 IST)','2026111509','2026-11-15 03:30:00.000','2026-11-15 04:30:00.000','2026-11-15 04:28:26.535',70,1,1,'2026-11-14 15:38:56.100','2026-11-15 04:28:26.577','2026-11-15 04:30:00.000','2026-11-15 04:00:00.000'),(2026111510,'Hourly Draw (10:00 IST)','2026111510','2026-11-15 04:30:00.000','2026-11-15 05:30:00.000','2026-11-15 05:29:24.216',70,1,1,'2026-11-14 16:34:46.923','2026-11-15 05:29:24.286','2026-11-15 05:30:00.000','2026-11-15 05:00:00.000'),(2026111511,'Hourly Draw (11:00 IST)','2026111511','2026-11-15 05:30:00.000','2026-11-15 06:30:00.000','2026-11-15 06:25:00.475',70,1,1,'2026-11-14 17:40:08.821','2026-11-15 06:25:00.526','2026-11-15 06:30:00.000','2026-11-15 06:00:00.000'),(2026111512,'Hourly Draw (12:00 IST)','2026111512','2026-11-15 06:30:00.000','2026-11-15 07:30:00.000','2026-11-15 07:30:00.000',70,1,0,'2026-11-14 18:39:03.536','2026-11-14 18:39:03.537','2026-11-15 07:30:00.000','2026-11-15 07:00:00.000'),(2026111513,'Hourly Draw (13:00 IST)','2026111513','2026-11-15 07:30:00.000','2026-11-15 08:30:00.000','2026-11-15 08:30:00.000',70,1,0,'2026-11-14 19:40:33.869','2026-11-14 19:40:33.870','2026-11-15 08:30:00.000','2026-11-15 08:00:00.000'),(2026111514,'Hourly Draw (14:00 IST)','2026111514','2026-11-15 08:30:00.000','2026-11-15 09:30:00.000','2026-11-15 09:30:00.000',70,1,0,'2026-11-14 20:41:49.518','2026-11-14 20:41:49.520','2026-11-15 09:30:00.000','2026-11-15 09:00:00.000'),(2026111515,'Hourly Draw (15:00 IST)','2026111515','2026-11-15 09:30:00.000','2026-11-15 10:30:00.000','2026-11-15 10:30:00.000',70,1,0,'2026-11-14 21:34:51.016','2026-11-14 21:34:51.017','2026-11-15 10:30:00.000','2026-11-15 10:00:00.000'),(2026111516,'Hourly Draw (16:00 IST)','2026111516','2026-11-15 10:30:00.000','2026-11-15 11:30:00.000','2026-11-15 11:30:00.000',70,1,0,'2026-11-14 22:41:15.038','2026-11-14 22:41:15.039','2026-11-15 11:30:00.000','2026-11-15 11:00:00.000'),(2026111517,'Hourly Draw (17:00 IST)','2026111517','2026-11-15 11:30:00.000','2026-11-15 12:30:00.000','2026-11-15 12:30:00.000',70,1,0,'2026-11-14 23:32:07.600','2026-11-14 23:32:07.600','2026-11-15 12:30:00.000','2026-11-15 12:00:00.000'),(2026111518,'Hourly Draw (18:00 IST)','2026111518','2026-11-15 12:30:00.000','2026-11-15 13:30:00.000','2026-11-15 13:30:00.000',70,1,0,'2026-11-15 00:30:26.621','2026-11-15 00:30:26.621','2026-11-15 13:30:00.000','2026-11-15 13:00:00.000'),(2026111519,'Hourly Draw (19:00 IST)','2026111519','2026-11-15 13:30:00.000','2026-11-15 14:30:00.000','2026-11-15 14:30:00.000',70,1,0,'2026-11-15 01:30:04.969','2026-11-15 01:30:04.969','2026-11-15 14:30:00.000','2026-11-15 14:00:00.000'),(2026111520,'Hourly Draw (20:00 IST)','2026111520','2026-11-15 14:30:00.000','2026-11-15 15:30:00.000','2026-11-15 15:30:00.000',70,1,0,'2026-11-15 02:32:42.764','2026-11-15 02:32:42.765','2026-11-15 15:30:00.000','2026-11-15 15:00:00.000'),(2026111521,'Hourly Draw (21:00 IST)','2026111521','2026-11-15 15:30:00.000','2026-11-15 16:30:00.000','2026-11-15 16:30:00.000',70,1,0,'2026-11-15 03:30:49.606','2026-11-15 03:30:49.607','2026-11-15 16:30:00.000','2026-11-15 16:00:00.000'),(2026111522,'Hourly Draw (22:00 IST)','2026111522','2026-11-15 16:30:00.000','2026-11-15 17:30:00.000','2026-11-15 17:30:00.000',70,1,0,'2026-11-15 04:43:59.377','2026-11-15 04:43:59.378','2026-11-15 17:30:00.000','2026-11-15 17:00:00.000'),(2026111523,'Hourly Draw (23:00 IST)','2026111523','2026-11-15 17:30:00.000','2026-11-15 18:30:00.000','2026-11-15 18:30:00.000',70,1,0,'2026-11-15 05:37:47.146','2026-11-15 05:37:47.147','2026-11-15 18:30:00.000','2026-11-15 18:00:00.000'),(2026111600,'Hourly Draw (00:00 IST)','2026111600','2026-11-15 18:30:00.000','2026-11-15 19:30:00.000','2026-11-15 19:30:00.000',70,1,0,'2026-11-15 06:30:01.055','2026-11-15 06:30:01.057','2026-11-15 19:30:00.000','2026-11-15 19:00:00.000');
/*!40000 ALTER TABLE `Game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LoginActivity`
--

DROP TABLE IF EXISTS `LoginActivity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LoginActivity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employeeId` int NOT NULL,
  `loginTime` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `logoutTime` datetime(3) DEFAULT NULL,
  `deviceInfo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ipAddress` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `LoginActivity_employeeId_idx` (`employeeId`),
  CONSTRAINT `LoginActivity_employeeId_fkey` FOREIGN KEY (`employeeId`) REFERENCES `Employee` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LoginActivity`
--

LOCK TABLES `LoginActivity` WRITE;
/*!40000 ALTER TABLE `LoginActivity` DISABLE KEYS */;
INSERT INTO `LoginActivity` VALUES (198,1,'2026-11-14 09:26:05.240',NULL,'Tablet (TAB-01) - Terminal Client','::1'),(199,2,'2026-11-14 09:28:01.663',NULL,'Tablet (TAB-01) - Terminal Client','::1'),(200,1,'2026-11-14 10:37:01.529',NULL,'Tablet (TAB-01) - Terminal Client','::1'),(201,1,'2026-11-14 10:41:26.506',NULL,'Tablet (TAB-01) - Terminal Client','::1'),(202,1,'2026-11-14 10:43:38.046',NULL,'Tablet (TAB-01) - Terminal Client','::ffff:192.168.0.119'),(203,4,'2026-11-14 11:21:21.086',NULL,'Tablet (TAB-01) - Terminal Client','::1'),(204,1,'2026-11-14 11:21:38.682',NULL,'Tablet (TAB-01) - Terminal Client','::1'),(205,2,'2026-11-14 12:08:17.948',NULL,'Tablet (TAB-01) - Terminal Client','::1'),(206,1,'2026-11-14 12:08:45.880',NULL,'Tablet (TAB-01) - Terminal Client','::1'),(207,4,'2026-11-14 12:08:48.686',NULL,'Tablet (TAB-01) - Terminal Client','::1'),(208,4,'2026-11-14 12:29:35.428',NULL,'Tablet (TAB-01) - Terminal Client','::1'),(209,1,'2026-11-14 12:31:05.454',NULL,'Terminal Station Client (RFID Reader)','::1'),(210,1,'2026-11-14 12:33:52.347',NULL,'Terminal Station Client (RFID Reader)','::1'),(211,4,'2026-11-15 06:18:27.576',NULL,'Tablet (TAB-01) - Terminal Client','::1'),(212,4,'2026-11-15 06:18:28.141',NULL,'Tablet (TAB-01) - Terminal Client','::1');
/*!40000 ALTER TABLE `LoginActivity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payout`
--

DROP TABLE IF EXISTS `Payout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payout` (
  `id` int NOT NULL AUTO_INCREMENT,
  `betId` int NOT NULL,
  `winningAmount` double NOT NULL,
  `status` enum('PENDING','PAID','REJECTED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `claimedBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `processedById` int DEFAULT NULL,
  `paidAt` datetime(3) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `paidAmount` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Payout_betId_key` (`betId`),
  KEY `Payout_status_idx` (`status`),
  KEY `Payout_processedById_idx` (`processedById`),
  CONSTRAINT `Payout_betId_fkey` FOREIGN KEY (`betId`) REFERENCES `Bet` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Payout_processedById_fkey` FOREIGN KEY (`processedById`) REFERENCES `Employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payout`
--

LOCK TABLES `Payout` WRITE;
/*!40000 ALTER TABLE `Payout` DISABLE KEYS */;
/*!40000 ALTER TABLE `Payout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PayoutRule`
--

DROP TABLE IF EXISTS `PayoutRule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PayoutRule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `betType` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `multiplier` double NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `PayoutRule_betType_key` (`betType`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PayoutRule`
--

LOCK TABLES `PayoutRule` WRITE;
/*!40000 ALTER TABLE `PayoutRule` DISABLE KEYS */;
INSERT INTO `PayoutRule` VALUES (6,'Digit Bet',7,1),(7,'Fortune Pair',70,1),(8,'Single Line',100,1),(9,'Half Fortune',500,1),(10,'Full Fortune',1000,1);
/*!40000 ALTER TABLE `PayoutRule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Result`
--

DROP TABLE IF EXISTS `Result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Result` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gameId` int NOT NULL,
  `winningNumber` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `declaredAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `declaredById` int DEFAULT NULL,
  `closeDeclaredAt` datetime(3) DEFAULT NULL,
  `closeDigit` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `closePana` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `openDeclaredAt` datetime(3) DEFAULT NULL,
  `openDigit` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `openPana` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'COMPLETED',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Result_gameId_key` (`gameId`),
  KEY `Result_gameId_idx` (`gameId`),
  KEY `Result_declaredById_fkey` (`declaredById`),
  KEY `Result_status_idx` (`status`),
  CONSTRAINT `Result_declaredById_fkey` FOREIGN KEY (`declaredById`) REFERENCES `Employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Result_gameId_fkey` FOREIGN KEY (`gameId`) REFERENCES `Game` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Result`
--

LOCK TABLES `Result` WRITE;
/*!40000 ALTER TABLE `Result` DISABLE KEYS */;
INSERT INTO `Result` VALUES (133,2026111413,'235-02-688','2026-11-14 08:25:00.187',NULL,'2026-11-14 08:25:00.187','2','688','2026-11-14 08:25:00.148','0','235','COMPLETED'),(134,2026111414,'888-47-250','2026-11-14 09:25:00.923',NULL,'2026-11-14 09:25:00.923','7','250','2026-11-14 08:55:00.048','4','888','COMPLETED'),(135,2026111415,'789-44-699','2026-11-14 10:25:00.981',NULL,'2026-11-14 10:25:00.981','4','699','2026-11-14 09:55:00.756','4','789','COMPLETED'),(136,2026111416,'266-47-278','2026-11-14 11:25:00.294',NULL,'2026-11-14 11:25:00.294','7','278','2026-11-14 10:55:00.388','4','266','COMPLETED'),(137,2026111417,'345-21-128','2026-11-14 12:25:22.013',NULL,'2026-11-14 12:25:22.013','1','128','2026-11-14 11:55:00.506','2','345','COMPLETED'),(138,2026111418,'230-58-468','2026-11-14 13:36:41.826',NULL,'2026-11-14 13:36:41.826','8','468','2026-11-14 12:55:00.706','5','230','COMPLETED'),(139,2026111419,'189-82-138','2026-11-14 14:34:57.267',NULL,'2026-11-14 14:34:57.267','2','138','2026-11-14 14:11:14.106','8','189','COMPLETED'),(140,2026111420,'557-79-450','2026-11-14 15:38:55.984',NULL,'2026-11-14 15:38:55.984','9','450','2026-11-14 15:04:27.090','7','557','COMPLETED'),(141,2026111421,'890-72-660','2026-11-14 16:34:46.881',NULL,'2026-11-14 16:34:46.881','2','660','2026-11-14 15:56:53.690','7','890','COMPLETED'),(142,2026111422,'244-08-260','2026-11-14 17:40:08.951',NULL,'2026-11-14 17:40:08.951','8','260','2026-11-14 17:03:46.390','0','244','COMPLETED'),(143,2026111423,'566-72-679','2026-11-14 18:39:03.449',NULL,'2026-11-14 18:39:03.449','2','679','2026-11-14 18:06:18.476','7','566','COMPLETED'),(144,2026111500,'440-80-118','2026-11-14 19:26:45.452',NULL,'2026-11-14 19:26:45.452','0','118','2026-11-14 18:55:00.688','8','440','COMPLETED'),(145,2026111501,'579-11-489','2026-11-14 20:26:15.935',NULL,'2026-11-14 20:26:15.935','1','489','2026-11-14 20:00:55.934','1','579','COMPLETED'),(146,2026111502,'668-08-288','2026-11-14 21:34:51.054',NULL,'2026-11-14 21:34:51.054','8','288','2026-11-14 20:55:26.127','0','668','COMPLETED'),(147,2026111503,'578-05-168','2026-11-14 22:26:09.333',NULL,'2026-11-14 22:26:09.333','5','168','2026-11-14 22:10:20.894','0','578','COMPLETED'),(148,2026111504,'999-78-233','2026-11-14 23:32:07.560',NULL,'2026-11-14 23:32:07.560','8','233','2026-11-14 22:57:27.741','7','999','COMPLETED'),(149,2026111505,'135-96-277','2026-11-15 00:28:54.209',NULL,'2026-11-15 00:28:54.209','6','277','2026-11-15 00:04:14.945','9','135','COMPLETED'),(150,2026111506,'469-93-670','2026-11-15 01:30:04.951',NULL,'2026-11-15 01:30:04.951','3','670','2026-11-15 00:56:00.052','9','469','COMPLETED'),(151,2026111507,'689-35-357','2026-11-15 02:32:42.753',NULL,'2026-11-15 02:32:42.753','5','357','2026-11-15 02:01:21.803','3','689','COMPLETED'),(152,2026111508,'267-55-780','2026-11-15 03:30:49.550',NULL,'2026-11-15 03:30:49.550','5','780','2026-11-15 02:55:58.866','5','267','COMPLETED'),(153,2026111509,'680-41-579','2026-11-15 04:28:26.535',NULL,'2026-11-15 04:28:26.535','1','579','2026-11-15 03:55:00.707','4','680','COMPLETED'),(154,2026111510,'124-72-138','2026-11-15 05:29:24.216',NULL,'2026-11-15 05:29:24.216','2','138','2026-11-15 05:19:59.193','7','124','COMPLETED'),(155,2026111511,'566-72-480','2026-11-15 06:25:00.475',NULL,'2026-11-15 06:25:00.475','2','480','2026-11-15 06:05:31.787','7','566','COMPLETED');
/*!40000 ALTER TABLE `Result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ShiftAudit`
--

DROP TABLE IF EXISTS `ShiftAudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ShiftAudit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employeeId` int NOT NULL,
  `terminalId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'TERM-04',
  `openingFloat` double NOT NULL,
  `closingFloat` double DEFAULT NULL,
  `cashSales` double NOT NULL DEFAULT '0',
  `cashPayouts` double NOT NULL DEFAULT '0',
  `expectedCash` double NOT NULL DEFAULT '0',
  `actualCash` double DEFAULT NULL,
  `difference` double DEFAULT NULL,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'OPEN',
  `openedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `closedAt` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ShiftAudit_employeeId_idx` (`employeeId`),
  KEY `ShiftAudit_status_idx` (`status`),
  CONSTRAINT `ShiftAudit_employeeId_fkey` FOREIGN KEY (`employeeId`) REFERENCES `Employee` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ShiftAudit`
--

LOCK TABLES `ShiftAudit` WRITE;
/*!40000 ALTER TABLE `ShiftAudit` DISABLE KEYS */;
/*!40000 ALTER TABLE `ShiftAudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tablet`
--

DROP TABLE IF EXISTS `Tablet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tablet` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tabletId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `ownerId` int DEFAULT NULL,
  `lastUsed` datetime(3) DEFAULT NULL,
  `ipAddress` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `assignedAt` datetime(3) DEFAULT NULL,
  `deviceId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isAssigned` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Tablet_tabletId_key` (`tabletId`),
  KEY `Tablet_tabletId_idx` (`tabletId`),
  KEY `Tablet_ownerId_idx` (`ownerId`),
  KEY `Tablet_status_idx` (`status`),
  KEY `Tablet_isAssigned_idx` (`isAssigned`),
  CONSTRAINT `Tablet_ownerId_fkey` FOREIGN KEY (`ownerId`) REFERENCES `Employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tablet`
--

LOCK TABLES `Tablet` WRITE;
/*!40000 ALTER TABLE `Tablet` DISABLE KEYS */;
INSERT INTO `Tablet` VALUES (1,'TAB-01','Marcus Floor POS',1,2,'2026-11-15 06:18:27.986','::1','2026-10-21 23:51:22.302','2026-11-15 06:18:27.987','2026-11-14 10:43:38.248',NULL,1),(2,'TAB-02','Tablet 2',1,NULL,'2026-10-23 14:43:41.917','::1','2026-10-23 13:42:53.774','2026-11-14 11:35:50.067',NULL,NULL,0),(3,'TAB-03','Tablet (TAB-03)',1,1,'2026-10-23 13:44:28.345','::1','2026-10-23 13:44:28.346','2026-10-23 13:44:28.347',NULL,NULL,0);
/*!40000 ALTER TABLE `Tablet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TerminalConfig`
--

DROP TABLE IF EXISTS `TerminalConfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TerminalConfig` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stationName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Terminal Station #04',
  `terminalNodeId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NODE-4092-NYC-01',
  `maxBetPerLine` double NOT NULL DEFAULT '50000',
  `maxTicketLimit` double NOT NULL DEFAULT '250000',
  `autoPrintReceipt` tinyint(1) NOT NULL DEFAULT '1',
  `paperRollPct` int NOT NULL DEFAULT '88',
  `cutoffBufferSeconds` int NOT NULL DEFAULT '60',
  `soundEffectsEnabled` tinyint(1) NOT NULL DEFAULT '1',
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TerminalConfig`
--

LOCK TABLES `TerminalConfig` WRITE;
/*!40000 ALTER TABLE `TerminalConfig` DISABLE KEYS */;
INSERT INTO `TerminalConfig` VALUES (1,'Station #04 - Counter 1','NODE-4092-NYC-01',50000,250000,1,88,60,1,'2026-10-04 19:49:52.248');
/*!40000 ALTER TABLE `TerminalConfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ticket`
--

DROP TABLE IF EXISTS `Ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ticket` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ticketNumber` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `barcode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `securityCode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employeeId` int NOT NULL,
  `totalAmount` double NOT NULL,
  `status` enum('ACTIVE','CANCELLED','SETTLED','PAID','VOID') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `settledAt` datetime(3) DEFAULT NULL,
  `contact` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tabletId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idempotencyKey` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Ticket_ticketNumber_key` (`ticketNumber`),
  UNIQUE KEY `Ticket_barcode_key` (`barcode`),
  UNIQUE KEY `Ticket_idempotencyKey_key` (`idempotencyKey`),
  KEY `Ticket_employeeId_idx` (`employeeId`),
  KEY `Ticket_status_idx` (`status`),
  KEY `Ticket_createdAt_idx` (`createdAt`),
  KEY `Ticket_contact_idx` (`contact`),
  KEY `Ticket_tabletId_idx` (`tabletId`),
  KEY `Ticket_idempotencyKey_idx` (`idempotencyKey`),
  CONSTRAINT `Ticket_employeeId_fkey` FOREIGN KEY (`employeeId`) REFERENCES `Employee` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ticket`
--

LOCK TABLES `Ticket` WRITE;
/*!40000 ALTER TABLE `Ticket` DISABLE KEYS */;
INSERT INTO `Ticket` VALUES (88,'TK-261114-T01-404725','581021061049','V6XBIP',2,2500,'ACTIVE','2026-11-14 12:08:22.111',NULL,NULL,'TAB-01','tkt-1794658102085-lpb3i66'),(89,'TK-261114-T01-977863','608805423769','XPSUBE',2,2500,'ACTIVE','2026-11-14 12:54:40.551',NULL,NULL,'TAB-01','tkt-1794660879380-twr99b1');
/*!40000 ALTER TABLE `Ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transaction`
--

DROP TABLE IF EXISTS `Transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ticketId` int DEFAULT NULL,
  `employeeId` int DEFAULT NULL,
  `type` enum('SALE','PAYOUT','REFUND','FLOAT_IN','FLOAT_OUT') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `paymentMode` enum('CASH','UPI','CARD') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CASH',
  `referenceNote` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `idempotencyKey` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Transaction_idempotencyKey_key` (`idempotencyKey`),
  KEY `Transaction_ticketId_idx` (`ticketId`),
  KEY `Transaction_employeeId_idx` (`employeeId`),
  KEY `Transaction_type_idx` (`type`),
  KEY `Transaction_createdAt_idx` (`createdAt`),
  KEY `Transaction_idempotencyKey_idx` (`idempotencyKey`),
  CONSTRAINT `Transaction_employeeId_fkey` FOREIGN KEY (`employeeId`) REFERENCES `Employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Transaction_ticketId_fkey` FOREIGN KEY (`ticketId`) REFERENCES `Ticket` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transaction`
--

LOCK TABLES `Transaction` WRITE;
/*!40000 ALTER TABLE `Transaction` DISABLE KEYS */;
INSERT INTO `Transaction` VALUES (96,88,2,'SALE',2500,'CASH','Ticket sale: TK-261114-T01-404725','2026-11-14 12:08:22.135','sale-tkt-1794658102085-lpb3i66'),(97,89,2,'SALE',2500,'CASH','Ticket sale: TK-261114-T01-977863','2026-11-14 12:54:40.697','sale-tkt-1794660879380-twr99b1');
/*!40000 ALTER TABLE `Transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-15 12:09:50
