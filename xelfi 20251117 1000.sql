CREATE DATABASE  IF NOT EXISTS `xelfi` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `xelfi`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: xelfi
-- ------------------------------------------------------
-- Server version	9.4.0

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
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articles` (
  `CODE` varchar(6) NOT NULL,
  `CODE_CATEGORIE` varchar(3) DEFAULT NULL,
  `DESIGNATION` varchar(100) DEFAULT NULL,
  `QUANTITE` int DEFAULT NULL,
  `PRIX_UNITAIRE` double DEFAULT NULL,
  `DATE` date DEFAULT NULL,
  PRIMARY KEY (`CODE`),
  UNIQUE KEY `CODE_UNIQUE` (`CODE`),
  KEY `CODE_CATEGORIE_INDEX` (`CODE_CATEGORIE`),
  KEY `DESIGNATION_INDEX` (`DESIGNATION`),
  KEY `DATE_INDEX` (`DATE`),
  CONSTRAINT `CODE_CATEGORIE` FOREIGN KEY (`CODE_CATEGORIE`) REFERENCES `categories` (`CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES ('ART','ECR','Ecran 24 pouces LED',10,300,'2012-05-25'),('ART1','POR','Portable PC DELL',10,800,'2012-04-10'),('ART2','TAB','Tablette Azerty',10,450,'2012-04-20');
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `CODE` varchar(3) NOT NULL,
  `DESIGNATION` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`CODE`),
  UNIQUE KEY `CODE_UNIQUE` (`CODE`),
  KEY `DESIGNATION_INDEX` (`DESIGNATION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES ('ECR','Ecran'),('POR','Portable'),('TAB','Tablette');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `CODE` varchar(6) NOT NULL,
  `NOM` varchar(15) DEFAULT NULL,
  `PRENOM` varchar(15) DEFAULT NULL,
  `CARTE_FIDELE` tinyint DEFAULT NULL,
  `DATE` date DEFAULT NULL,
  `ADRESSE` varchar(200) DEFAULT NULL,
  `CODE_POSTAL` varchar(9) DEFAULT NULL,
  `VILLE` varchar(15) DEFAULT NULL,
  `TEL_FIXE` varchar(12) DEFAULT NULL,
  `MOBILIS` varchar(12) DEFAULT NULL,
  `EMAIL` varchar(45) DEFAULT NULL,
  `REMARQUES` text,
  PRIMARY KEY (`CODE`),
  UNIQUE KEY `CODE_UNIQUE` (`CODE`),
  KEY `NOM_INDEX` (`NOM`),
  KEY `PRENOM_INDEX` (`PRENOM`),
  KEY `CARTE_FIDELE_INDEX` (`CARTE_FIDELE`),
  KEY `DATE_INDEX` (`DATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES ('BOPA01','BOUCHON','Paul',1,'2012-06-07',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('DUCA01','DUPONT','Carole',1,'2012-05-28',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('MAMA01','MARTIN','Marcel',0,'2012-04-05',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factures`
--

DROP TABLE IF EXISTS `factures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factures` (
  `CODE` varchar(15) NOT NULL,
  `CODE_CLIENT` varchar(6) DEFAULT NULL,
  `TOTAL_TTC` double DEFAULT NULL,
  `CODE_MODE_REGLEMENT` int DEFAULT NULL,
  `DATE` date DEFAULT NULL,
  PRIMARY KEY (`CODE`),
  UNIQUE KEY `CODE_UNIQUE` (`CODE`),
  KEY `CODE_CLIENT_INDEX` (`CODE_CLIENT`),
  KEY `CODE_MODE_REGLEMENT_INDEX` (`CODE_MODE_REGLEMENT`),
  KEY `DATE_INDEX` (`DATE`),
  CONSTRAINT `CODE_CLIENT` FOREIGN KEY (`CODE_CLIENT`) REFERENCES `clients` (`CODE`),
  CONSTRAINT `CODE_MODE_REGLEMENT` FOREIGN KEY (`CODE_MODE_REGLEMENT`) REFERENCES `mode_reglements` (`CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factures`
--

LOCK TABLES `factures` WRITE;
/*!40000 ALTER TABLE `factures` DISABLE KEYS */;
/*!40000 ALTER TABLE `factures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lignes_factures`
--

DROP TABLE IF EXISTS `lignes_factures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lignes_factures` (
  `CODE_FACTURE` varchar(15) NOT NULL,
  `CODE_ARTICLE` varchar(6) NOT NULL,
  `QUANTITE` int DEFAULT NULL,
  `PRIX_UNITAIRE` double DEFAULT NULL,
  `TOTAL` double DEFAULT NULL,
  PRIMARY KEY (`CODE_FACTURE`,`CODE_ARTICLE`),
  UNIQUE KEY `CODE_FACTURE_UNIQUE` (`CODE_FACTURE`),
  UNIQUE KEY `CODE_ARTICLE_UNIQUE` (`CODE_ARTICLE`),
  CONSTRAINT `CODE_ARTICLE` FOREIGN KEY (`CODE_ARTICLE`) REFERENCES `articles` (`CODE`),
  CONSTRAINT `CODE_FACTURE` FOREIGN KEY (`CODE_FACTURE`) REFERENCES `factures` (`CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lignes_factures`
--

LOCK TABLES `lignes_factures` WRITE;
/*!40000 ALTER TABLE `lignes_factures` DISABLE KEYS */;
/*!40000 ALTER TABLE `lignes_factures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mode_reglements`
--

DROP TABLE IF EXISTS `mode_reglements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mode_reglements` (
  `CODE` int NOT NULL,
  `TYPE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`CODE`),
  UNIQUE KEY `CODE_UNIQUE` (`CODE`),
  KEY `TYPE_INDEX` (`TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mode_reglements`
--

LOCK TABLES `mode_reglements` WRITE;
/*!40000 ALTER TABLE `mode_reglements` DISABLE KEYS */;
INSERT INTO `mode_reglements` VALUES (2,'Carte'),(1,'Chèque'),(3,'Espèce');
/*!40000 ALTER TABLE `mode_reglements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'xelfi'
--

--
-- Dumping routines for database 'xelfi'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-17  9:38:20
