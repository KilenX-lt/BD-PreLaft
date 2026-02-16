-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: prelaft_db
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `alerta`
--

DROP TABLE IF EXISTS `alerta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerta` (
  `id_alerta` int NOT NULL AUTO_INCREMENT,
  `estado` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `nivel_alerta` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `id_transaccion` int NOT NULL,
  PRIMARY KEY (`id_alerta`),
  KEY `id_transaccion` (`id_transaccion`),
  CONSTRAINT `alerta_ibfk_1` FOREIGN KEY (`id_transaccion`) REFERENCES `transaccion` (`id_transaccion`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerta`
--

LOCK TABLES `alerta` WRITE;
/*!40000 ALTER TABLE `alerta` DISABLE KEYS */;
INSERT INTO `alerta` VALUES (1,'Abierta','Alto',1),(2,'Abierta','Alto',4),(3,'Abierta','Medio',7),(4,'Cerrada','Medio',8),(5,'Abierta','Alto',10),(6,'Abierta','Medio',12);
/*!40000 ALTER TABLE `alerta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analista`
--

DROP TABLE IF EXISTS `analista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analista` (
  `id_analista` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `cargo` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_analista`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analista`
--

LOCK TABLES `analista` WRITE;
/*!40000 ALTER TABLE `analista` DISABLE KEYS */;
INSERT INTO `analista` VALUES (1,'Ana Torres','Analista'),(2,'Carlos Ruiz','Analista'),(3,'Laura Mena','Supervisor'),(4,'José Lara','Analista'),(5,'Paula Ortiz','Analista'),(6,'Diego Molina','Auditor'),(7,'Carmen Paz','Analista'),(8,'Luis Flores','Supervisor'),(9,'Sofía Vera','Analista'),(10,'Marco Núñez','Analista'),(11,'Diana Cedeño','Auditor'),(12,'Andrés Lima','Analista');
/*!40000 ALTER TABLE `analista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `ruc` varchar(13) COLLATE utf8mb4_general_ci NOT NULL,
  `tipo_cliente` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `direccion` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `ruc` (`ruc`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Juan Pérez','1723456789','Natural','Quito','0999999999'),(2,'María López','1712345678','Natural','Quito','0988888888'),(3,'Carlos Vega','1701122334','Natural','Quito','0977777777'),(4,'Ana Ruiz','1798765432','Jurídico','Quito','0966666666'),(5,'Luis Mora','1711111111','Natural','Quito','0955555555'),(6,'Elena Paz','1722222222','Natural','Quito','0944444444'),(7,'Diego Cruz','1733333333','Natural','Quito','0933333333'),(8,'Sofía León','1744444444','Natural','Quito','0922222222'),(9,'Pedro Silva','1755555555','Natural','Quito','0911111111'),(10,'Laura Ríos','1766666666','Natural','Quito','0900000000'),(11,'Andrés Ponce','1777777777','Natural','Quito','0990000000'),(12,'Valeria Soto','1788888888','Natural','Quito','0980000000');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluacion`
--

DROP TABLE IF EXISTS `evaluacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evaluacion` (
  `id_evaluacion` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `nivel_riesgo` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `puntaje` int NOT NULL,
  `id_cliente` int NOT NULL,
  `id_analista` int NOT NULL,
  PRIMARY KEY (`id_evaluacion`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_analista` (`id_analista`),
  CONSTRAINT `evaluacion_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `evaluacion_ibfk_2` FOREIGN KEY (`id_analista`) REFERENCES `analista` (`id_analista`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluacion`
--

LOCK TABLES `evaluacion` WRITE;
/*!40000 ALTER TABLE `evaluacion` DISABLE KEYS */;
INSERT INTO `evaluacion` VALUES (1,'2024-01-05','Alto',90,1,1),(2,'2024-01-10','Medio',60,1,1),(3,'2024-01-12','Bajo',20,2,2),(4,'2024-01-15','Alto',95,3,3),(5,'2024-01-18','Medio',55,4,4),(6,'2024-01-20','Bajo',15,5,5),(7,'2024-01-22','Alto',80,6,6),(8,'2024-01-25','Medio',65,7,7),(9,'2024-01-27','Bajo',25,8,8),(10,'2024-01-29','Alto',88,9,9),(11,'2024-01-30','Medio',50,10,10),(12,'2024-02-01','Alto',78,11,11),(13,'2024-02-03','Bajo',18,12,12);
/*!40000 ALTER TABLE `evaluacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluacion_lista`
--

DROP TABLE IF EXISTS `evaluacion_lista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evaluacion_lista` (
  `id_evaluacion` int NOT NULL,
  `id_lista` int NOT NULL,
  PRIMARY KEY (`id_evaluacion`,`id_lista`),
  KEY `id_lista` (`id_lista`),
  CONSTRAINT `evaluacion_lista_ibfk_1` FOREIGN KEY (`id_evaluacion`) REFERENCES `evaluacion` (`id_evaluacion`),
  CONSTRAINT `evaluacion_lista_ibfk_2` FOREIGN KEY (`id_lista`) REFERENCES `lista_control` (`id_lista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluacion_lista`
--

LOCK TABLES `evaluacion_lista` WRITE;
/*!40000 ALTER TABLE `evaluacion_lista` DISABLE KEYS */;
INSERT INTO `evaluacion_lista` VALUES (1,1),(4,1),(8,1),(10,1),(1,2),(10,2),(7,3),(12,4);
/*!40000 ALTER TABLE `evaluacion_lista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista_control`
--

DROP TABLE IF EXISTS `lista_control`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lista_control` (
  `id_lista` int NOT NULL AUTO_INCREMENT,
  `nombre_lista` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_lista`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lista_control`
--

LOCK TABLES `lista_control` WRITE;
/*!40000 ALTER TABLE `lista_control` DISABLE KEYS */;
INSERT INTO `lista_control` VALUES (1,'OFAC'),(2,'PEP'),(3,'ONU'),(4,'UAFE');
/*!40000 ALTER TABLE `lista_control` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaccion`
--

DROP TABLE IF EXISTS `transaccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaccion` (
  `id_transaccion` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `tipo_transaccion` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `id_cliente` int NOT NULL,
  PRIMARY KEY (`id_transaccion`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `transaccion_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaccion`
--

LOCK TABLES `transaccion` WRITE;
/*!40000 ALTER TABLE `transaccion` DISABLE KEYS */;
INSERT INTO `transaccion` VALUES (1,'2024-01-04',15000.00,'Transferencia',1),(2,'2024-01-09',5000.00,'Depósito',1),(3,'2024-01-11',800.00,'Retiro',2),(4,'2024-01-14',22000.00,'Transferencia',3),(5,'2024-01-17',1000.00,'Depósito',4),(6,'2024-01-19',400.00,'Retiro',5),(7,'2024-01-21',7500.00,'Transferencia',6),(8,'2024-01-24',9000.00,'Transferencia',7),(9,'2024-01-26',1200.00,'Depósito',8),(10,'2024-01-28',18000.00,'Transferencia',9),(11,'2024-01-29',300.00,'Retiro',10),(12,'2024-01-31',6000.00,'Depósito',11),(13,'2024-02-02',200.00,'Retiro',12);
/*!40000 ALTER TABLE `transaccion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-08 21:01:06
