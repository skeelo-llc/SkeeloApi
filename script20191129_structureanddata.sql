CREATE DATABASE  IF NOT EXISTS `skeelo` /*!40100 DEFAULT CHARACTER SET utf8 */;
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
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) NOT NULL,
  `category_description` tinytext,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Matinais','Lácteos e Achocolatados, Cafés e Chás, Bolos e Biscoitos, Aveia e Cereias.'),(2,'Mercearia','Alimentos Básicos, Biscoitos e Snacks, Doces e Sobremesas, Massas e Molhos, Grãos e Sementes, Temperos e Condimentos, Conservas e Enlatados, Farinacios.'),(3,'Padaria','Tortas, Biscoitos, Bolos, Pães, Torradas, Panetones.'),(4,'Hortifrúti','Frutas, Ovos, Verduras, Legumes.'),(5,'Frios e Laticínios','Lácteos, Queijos, Frios, Massas, Fondue, Pão de alho.'),(6,'Congelados','Petiscos, Frutas congeladas, Hambúrguer, Sorvetes.'),(7,'Açougue','Peixe, Bovinos, Suinos, Frutos do mar, Aves.'),(8,'Bebidas','Refrigerantes, Chás, Cervejas, Sucos, Destilados.'),(9,'Higiene e Beleza','Facial, Bebes, Cabelo, Higiene, Corpo, Mãos e pés.'),(10,'Limpeza','Banheiro, Cozinha, Casa, Roupas.');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

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
  `item_imageurl` varchar(120) DEFAULT NULL,
  `item_discount` tinyint(4) DEFAULT NULL,
  `item_discounttype` tinyint(4) DEFAULT NULL,
  `item_discountpercent` varchar(45) DEFAULT NULL,
  `item_discountminus` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `item_store_idx` (`item_store`),
  KEY `item_category_idx` (`item_category`),
  CONSTRAINT `item_category` FOREIGN KEY (`item_category`) REFERENCES `categories` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `item_store` FOREIGN KEY (`item_store`) REFERENCES `stores` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES ('00063960000109','17044620','R. Chaim Mauad, 2100','255','Vila Regina','Bauru','SP','55','',''),('00819201001359','18670000','R. Ver. Ignácio Leite','812','Nucleo Hab. Comendador Jose Zillo','Areiópolis','SP','55','',''),('04039570000146','15800200','Av. Eng. José Nelson Machado','280',' Parque Iracema','Catanduva','SP','55','',''),('10277682000138','17560000','R. Paes Leme','313','Centro','Vera Cruz','SP','55','',''),('53045266000974','17507400','R. Dr. Thimo Bruno Belucci','255','Jardim Aquarius','Marília','SP','55','','');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitems`
--

LOCK TABLES `orderitems` WRITE;
/*!40000 ALTER TABLE `orderitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderitems` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

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
  `store_imageurl` varchar(120) NOT NULL,
  `store_owner` int(11) NOT NULL,
  `store_location` varchar(14) NOT NULL,
  `store_deliverytax` varchar(45) NOT NULL,
  PRIMARY KEY (`store_id`),
  KEY `store_owner_idx` (`store_owner`),
  KEY `store_location_idx` (`store_location`),
  CONSTRAINT `store_location` FOREIGN KEY (`store_location`) REFERENCES `locations` (`location_cnpj`),
  CONSTRAINT `store_owner` FOREIGN KEY (`store_owner`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stores`
--

LOCK TABLES `stores` WRITE;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
INSERT INTO `stores` VALUES (1,'SUPERMERCADOS CONFIANÇA','Supermercados Confiança','53045266000974','1433035555','https://i.imgur.com/5xnrOiY.jpg',2,'53045266000974','4.5'),(2,'LOJAS EXTRA LTDA','Lojas Extra','04039570000146','1735213377','https://i.imgur.com/Ibpjcsb.jpg',3,'04039570000146','5.5'),(3,'SUPERMERCADOS LIDER LTDA','Supermercados Líder','10277682000138','1434921323','https://i.imgur.com/UTrE4wf.jpg',4,'10277682000138','3'),(4,'WAL MART BRASIL LTDA','Walmart','00063960000109','1421063737','https://i.imgur.com/Vaf6Uuu.jpg',5,'00063960000109','4.5'),(5,'LOJAS AVENIDA S.A','Lojas Avenida','00819201001359','1434062549','https://i.imgur.com/5b9xOxS.jpg',6,'00819201001359','0');
/*!40000 ALTER TABLE `stores` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Lucas Santana','ln.santana08@gmail.com','U2FsdGVkX1/OLv6qMegbnYjgW7344bid6JZkBZk1K5Q=','2002-08-02',NULL,14998756610,46188786819,17510450),(2,'Confianca Owner','confianca@owner.com.br','U2FsdGVkX19n9dKOto/eD2wA9QfEdMBsputazt9KQctfbn2kCpDurH5Pik4JFkzY','1975-11-29',NULL,14912341234,NULL,17500000),(3,'Extra Owner','extra@owner.com','U2FsdGVkX19nr74yq3DzTUaxQIaYA3Jws2bp8Uj65nTLqd627wFukpDcr1h7DoN6','1975-11-12',NULL,14912341235,NULL,17500000),(4,'Lider Owner','lider@owner.com','U2FsdGVkX1+jqbPWXWanXqHh4pVr/CpHUUPQ+rTjI+NM9EpmKSdZ13LN5HTTLltO','1987-04-02',NULL,14912341236,NULL,17500000),(5,'Walmart Owner','walmart@owner.com','U2FsdGVkX1+fouHib72Hu6le5Z21eLA6nsvALsNA+5q3JOqV9IVxi8Q0SazHNhXC','1982-08-09',NULL,14912341237,NULL,17500000),(6,'Avenida Owner','avenida@owner.com','U2FsdGVkX19Gh+k2s5Aiaw2FKSxwada/73NQDEtvHbTioGvAUurJkIs0PcIqe/s/','1889-09-08',NULL,14912341238,NULL,17500000);
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

-- Dump completed on 2019-11-29  9:25:50
