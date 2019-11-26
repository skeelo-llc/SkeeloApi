CREATE DATABASE  IF NOT EXISTS `skeelo` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `skeelo`;
-- MySQL dump 10.13  Distrib 5.7.21, for Win64 (x86_64)
--
-- Host: localhost    Database: skeelo
-- ------------------------------------------------------
-- Server version	5.7.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
-- Table structure for table `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` varchar(30) NOT NULL,
  `order_owner` int(11) NOT NULL,
  `order_store` int(11) NOT NULL,
  `order_date` datetime NOT NULL,
  `order_price` varchar(45) NOT NULL,
  `order_items` varchar(45) NOT NULL,
  `order_progress` varchar(45) DEFAULT NULL COMMENT '0 - Pedido aceito\n1 - Pedido preparado\n2 - Pedido pronto para retirada\n3 - Pedido retirado',
  PRIMARY KEY (`order_id`),
  KEY `order_owner_idx` (`order_owner`),
  KEY `order_store_idx` (`order_store`),
  CONSTRAINT `order_owner` FOREIGN KEY (`order_owner`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_store` FOREIGN KEY (`order_store`) REFERENCES `stores` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stores` (
  `store_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_name` varchar(100) NOT NULL,
  `store_displayname` varchar(100) DEFAULT NULL,
  `store_cnpj` varchar(14) NOT NULL,
  `store_phone` varchar(45) NOT NULL,
  `store_owner` int(11) NOT NULL,
  `store_location` varchar(14) NOT NULL,
  `store_deliverytax` varchar(45) NOT NULL,
  PRIMARY KEY (`store_id`),
  KEY `store_owner_idx` (`store_owner`),
  KEY `store_location_idx` (`store_location`),
  CONSTRAINT `store_location` FOREIGN KEY (`store_location`) REFERENCES `locations` (`location_cnpj`),
  CONSTRAINT `store_owner` FOREIGN KEY (`store_owner`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-26  7:31:20
