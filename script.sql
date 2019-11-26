CREATE DATABASE  IF NOT EXISTS `skeelo` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `skeelo`;
-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: localhost    Database: skeelo
-- ------------------------------------------------------
-- Server version	5.7.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL COMMENT 'STOREID + CATEGORYID',
  `category_name` varchar(45) NOT NULL,
  `category_description` tinytext,
  `category_store` int(11) NOT NULL,
  PRIMARY KEY (`category_id`),
  KEY `category_store_idx` (`category_store`),
  CONSTRAINT `category_store` FOREIGN KEY (`category_store`) REFERENCES `stores` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (10,'Bebidas','Bebidas',1),(11,'Doces','Doces',1),(20,'Bebidas','Bebidas',2),(21,'Doces','Doces',2),(22,'Alimentos','Alimentos',2);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_store` int(11) NOT NULL,
  `item_barcode` varchar(45) NOT NULL,
  `item_category` int(11) NOT NULL,
  `item_name` varchar(45) NOT NULL,
  `item_description` varchar(45) NOT NULL,
  `item_amount` varchar(45) NOT NULL,
  `item_price` varchar(45) NOT NULL,
  `item_discount` tinyint(4) DEFAULT NULL,
  `item_discounttype` tinyint(4) DEFAULT NULL,
  `item_discountpercent` varchar(45) DEFAULT NULL,
  `item_discountminus` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `item_store_idx` (`item_store`),
  KEY `item_category_idx` (`item_category`),
  CONSTRAINT `item_category` FOREIGN KEY (`item_category`) REFERENCES `categories` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `item_store` FOREIGN KEY (`item_store`) REFERENCES `stores` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,1,'7894900011531',10,'Refrigerante Coca-Cola','REFRIGERANTE COCA-COLA 2LT','2L','6.99',NULL,NULL,NULL,NULL),(2,2,'7894900011531',20,'Refrigerante Coca-Cola','REFRIGERANTE COCA-COLA 2LT','2L','5.99',NULL,NULL,NULL,NULL),(3,2,'7892840222949',22,'Salgadinho Fandangos Queijo','SALGADINHO FANDANGOS QUEIJO','164G','8.46',NULL,NULL,NULL,NULL),(4,2,'7895800144428',21,'Trident Menta','TRIDENT MENTA','1U','1.92',NULL,NULL,NULL,NULL),(5,2,'7891000005156',21,'Chocolate Suflair Aerado Preto','Nestlé Chocolate Suflair Aerado Preto 50g','50g','3.95',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `locations` (
  `location_cnpj` varchar(14) NOT NULL,
  `location_zip` varchar(8) NOT NULL,
  `location_address` varchar(100) NOT NULL,
  `location_number` varchar(5) NOT NULL,
  `location_neighbourhood` varchar(50) DEFAULT NULL,
  `location_city` varchar(50) NOT NULL,
  `location_province` varchar(50) DEFAULT NULL,
  `location_country` varchar(50) NOT NULL,
  `location_lat` varchar(50) DEFAULT NULL,
  `location_lng` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`location_cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES ('02927229000100','17510418','Rua Dermanio da Silva Lima','65','Palmital Prolongado','Marília','SP','55','',''),('05774403001183','17520240','Rua Joao Ramalho','634','Parque Sao Jorge','Marília','SP','55','',''),('46136925000165','17511342','Thomaz Alcalde','1220','Palmital','Marília','SP','55','',''),('65897910000164','17510402','Avenida República','2355','Palmital','Marília','SP','55','','');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `orderitems` (
  `orderitems_id` int(11) NOT NULL AUTO_INCREMENT,
  `orderitems_order` varchar(30) NOT NULL,
  `orderitems_item` int(11) NOT NULL,
  `orderitems_quantity` int(10) NOT NULL,
  PRIMARY KEY (`orderitems_id`),
  KEY `orderitems_item_idx` (`orderitems_item`),
  KEY `orderitems_order_idx` (`orderitems_order`),
  CONSTRAINT `orderitems_item` FOREIGN KEY (`orderitems_item`) REFERENCES `items` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `orderitems_order` FOREIGN KEY (`orderitems_order`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitems`
--

LOCK TABLES `orderitems` WRITE;
/*!40000 ALTER TABLE `orderitems` DISABLE KEYS */;
INSERT INTO `orderitems` VALUES (1,'201908301412485',1,1),(2,'201909052039125',2,1),(3,'201909052039125',3,2),(4,'201909052039125',4,1),(5,'201909052039125',5,1);
/*!40000 ALTER TABLE `orderitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `orders` (
  `order_id` varchar(30) NOT NULL,
  `order_owner` int(11) NOT NULL,
  `order_store` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `order_price` varchar(45) NOT NULL,
  `order_items` varchar(45) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `order_owner_idx` (`order_owner`),
  KEY `order_store_idx` (`order_store`),
  CONSTRAINT `order_owner` FOREIGN KEY (`order_owner`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_store` FOREIGN KEY (`order_store`) REFERENCES `stores` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES ('201908301412485',5,1,'2019-08-30','6.99','1'),('201909052039125',5,2,'2019-09-05','32.73','5');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `stores` (
  `store_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_name` varchar(100) NOT NULL,
  `store_displayname` varchar(100) DEFAULT NULL,
  `store_cnpj` varchar(14) NOT NULL,
  `store_phone` varchar(45) NOT NULL,
  `store_owner` int(11) NOT NULL,
  `store_location` varchar(14) NOT NULL,
  PRIMARY KEY (`store_id`),
  KEY `store_owner_idx` (`store_owner`),
  KEY `store_location_idx` (`store_location`),
  CONSTRAINT `store_location` FOREIGN KEY (`store_location`) REFERENCES `locations` (`location_cnpj`),
  CONSTRAINT `store_owner` FOREIGN KEY (`store_owner`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stores`
--

LOCK TABLES `stores` WRITE;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
INSERT INTO `stores` VALUES (1,'S M Preco Certo Ltda.','S M PRECO CERTO','02927229000100','144338000',1,'02927229000100'),(2,'Amigaolins Supermercado SA','Amigao Supermercado - Marilia','05774403001183','1435332710',2,'05774403001183'),(3,'TAUSTE SUPERMERCADOS LTDA','TAUSTE SUPERMERCADOS','65897910000164','1434021512',3,'65897910000164'),(4,'Supermercados Kawakami LTDA','Supermercado Kawakami','46136925000165','1434013004',4,'65897910000164');
/*!40000 ALTER TABLE `stores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_password` varchar(100) NOT NULL,
  `user_birthdate` date NOT NULL,
  `user_country` int(4) DEFAULT NULL,
  `user_phone` bigint(11) NOT NULL,
  `user_cpf` bigint(11) DEFAULT NULL,
  `user_zip` int(8) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Jorge Luiz Clavico','jorgeclavico@precocerto.com','jorge@Skeelo','1980-01-01',55,14911111111,11111111111,11111111),(2,'Valdir Nogaroli Junior','valdirnogaroli@amigao.com','valdir@Skeelo','1980-01-02',55,14911111112,11111111112,11111112),(3,'Rogerio Magalhães Montolar','rogeriomontolar@tauste.com','rogerio@Skeelo','1980-01-03',55,14911111113,11111111113,11111113),(4,'Eduardo Kiyoshi Kawakami','eduardokawakami@kawakami.com','dudu@Skeelo','1980-01-04',55,14911111114,11111111114,11111114),(5,'Lucas Santana','ln.santana08@gmail.com','U2FsdGVkX19MZn91WpUshO4xRv4qW3HrdaO3xKrAceU=','2002-08-02',NULL,14998756610,46188786819,17510450);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-24 23:52:25
