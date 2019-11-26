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
INSERT INTO `locations` VALUES ('02927229000100','17510418','Rua Dermanio da Silva Lima','65','Palmital Prolongado','Marília','SP','55','',''),('05774403001183','17520240','Rua Joao Ramalho','634','Parque Sao Jorge','Marília','SP','55','',''),('46136925000165','17511342','Thomaz Alcalde','1220','Palmital','Marília','SP','55','',''),('65897910000164','17510402','Avenida República','2355','Palmital','Marília','SP','55','','');
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
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitems`
--

LOCK TABLES `orderitems` WRITE;
/*!40000 ALTER TABLE `orderitems` DISABLE KEYS */;
INSERT INTO `orderitems` VALUES (1,'201908301412485',1,1),(2,'201909052039125',2,1),(3,'201909052039125',3,2),(4,'201909052039125',4,1),(5,'201909052039125',5,1),(6,'201910151824545',2,1),(7,'201910151824545',4,1),(8,'201910151824545',3,2),(9,'201910151824545',5,1),(10,'201910151827505',2,1),(11,'201910151827505',4,5),(12,'201910151828275',4,8),(13,'201910151828275',2,1),(17,'201910201158595',4,3),(18,'201910201432025',4,5),(20,'201910201436295',4,4),(21,'201910222019215',4,8),(22,'201910222021205',4,9),(23,'201910222025345',4,1),(24,'201910222027075',4,1),(25,'201910222030145',4,1),(26,'201910222030455',4,3),(27,'201910222033415',4,1),(28,'201910222035435',4,1),(29,'201910222039155',4,1),(30,'201910222040475',4,1),(31,'201910222042065',4,1),(32,'201910222043245',4,2),(33,'201910232106495',4,3),(34,'201910232107395',4,1),(35,'201910232108145',4,1),(36,'201910232108515',4,1),(37,'201910232109235',4,1),(38,'201910232111285',4,4),(39,'201910232112105',4,4),(40,'201910232128575',4,3),(41,'201910232141385',4,4),(42,'201910232142255',4,1),(43,'201910232142565',4,4),(44,'201910232143255',4,1),(45,'201910232212555',4,2),(46,'201910232215115',4,1),(47,'201910232222355',4,4),(48,'201910232223295',4,1),(49,'201910232224205',4,1),(50,'201910232224385',4,1),(51,'201910232225125',4,1),(52,'201910232228085',4,1),(53,'201910281119415',4,4),(54,'201910281119415',5,15),(55,'201910281127035',3,5);
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
INSERT INTO `orders` VALUES ('201908301412485',5,1,'2019-08-30 14:08:11','6.99','1','4'),('201909052039125',5,2,'2019-09-05 08:20:15','32.73','5','4'),('201910151824545',5,2,'2019-10-15 18:24:54','32.78','5','4'),('201910151827505',5,2,'2019-10-15 18:27:50','19.59','6','4'),('201910151828275',5,2,'2019-10-15 18:28:27','25.35','9','4'),('201910201158595',5,2,'2019-10-20 11:58:59','9.76','3','4'),('201910201432025',5,2,'2019-10-20 14:32:02','13.60','5','4'),('201910201432545',5,2,'2019-10-20 14:32:54','9.76','3','4'),('201910201436295',5,2,'2019-10-20 14:36:29','11.68','4','4'),('201910222019215',5,2,'2019-10-22 20:19:21','15.36','8','4'),('201910222021205',5,2,'2019-10-22 20:21:20','17.28','9','4'),('201910222025345',5,2,'2019-10-22 20:25:34','1.92','1','4'),('201910222027075',5,2,'2019-10-22 20:27:07','1.92','1','4'),('201910222030145',5,2,'2019-10-22 20:30:14','1.92','1','4'),('201910222030455',5,2,'2019-10-22 20:30:45','5.76','3','4'),('201910222033415',5,2,'2019-10-22 20:33:41','1.92','1','4'),('201910222035435',5,2,'2019-10-22 20:35:43','1.92','1','4'),('201910222039155',5,2,'2019-10-22 20:39:15','1.92','1','4'),('201910222040475',5,2,'2019-10-22 20:40:47','1.92','1','4'),('201910222042065',5,2,'2019-10-22 20:42:06','1.92','1','4'),('201910222043245',5,2,'2019-10-22 20:43:24','3.84','2','4'),('201910232106495',5,2,'2019-10-23 21:06:49','5.76','3','4'),('201910232107395',5,2,'2019-10-23 21:07:39','1.92','1','4'),('201910232108145',5,2,'2019-10-23 21:08:14','1.92','1','4'),('201910232108515',5,2,'2019-10-23 21:08:51','1.92','1','4'),('201910232109235',5,2,'2019-10-23 21:09:23','1.92','1','4'),('201910232111285',5,2,'2019-10-23 21:11:28','7.68','4','4'),('201910232112105',5,2,'2019-10-23 21:12:10','7.68','4','4'),('201910232128575',5,2,'2019-10-23 21:28:57','5.76','3','4'),('201910232141385',5,2,'2019-10-23 21:41:38','7.68','4','4'),('201910232142255',5,2,'2019-10-23 21:42:25','1.92','1','4'),('201910232142565',5,2,'2019-10-23 21:42:56','7.68','4','4'),('201910232143255',5,2,'2019-10-23 21:43:25','1.92','1','4'),('201910232212555',5,2,'2019-10-23 22:12:55','3.84','2','4'),('201910232215115',5,2,'2019-10-23 22:15:11','1.92','1','4'),('201910232222355',5,2,'2019-10-23 22:22:35','7.68','4','4'),('201910232223295',5,2,'2019-10-23 22:23:29','1.92','1','4'),('201910232224205',5,2,'2019-10-23 22:24:20','1.92','1','4'),('201910232224385',5,2,'2019-10-23 22:24:38','1.92','1','4'),('201910232225125',5,2,'2019-10-23 22:25:12','1.92','1','4'),('201910232228085',5,2,'2019-10-23 22:28:08','1.92','1','3'),('201910281116485',5,2,'2019-10-28 11:16:48','NaN','20','0'),('201910281119415',5,2,'2019-10-28 11:19:41','66.93','19','0'),('201910281127035',5,2,'2019-10-28 11:27:03','42.30','5','0');
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
-- Dumping data for table `stores`
--

LOCK TABLES `stores` WRITE;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
INSERT INTO `stores` VALUES (1,'S M Preco Certo Ltda.','S M PRECO CERTO','02927229000100','144338000',1,'02927229000100','3.50'),(2,'Amigaolins Supermercado SA','Amigao Supermercado - Marilia','05774403001183','1435332710',2,'05774403001183','0'),(3,'TAUSTE SUPERMERCADOS LTDA','TAUSTE SUPERMERCADOS','65897910000164','1434021512',3,'65897910000164','3'),(4,'Supermercados Kawakami LTDA','Supermercado Kawakami','46136925000165','1434013004',4,'65897910000164','4.5');
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Jorge Luiz Clavico','jorgeclavico@precocerto.com','jorge@Skeelo','1980-01-01',55,14911111111,11111111111,11111111),(2,'Valdir Nogaroli Junior','valdirnogaroli@amigao.com','valdir@Skeelo','1980-01-02',55,14911111112,11111111112,11111112),(3,'Rogerio Magalhães Montolar','rogeriomontolar@tauste.com','rogerio@Skeelo','1980-01-03',55,14911111113,11111111113,11111113),(4,'Eduardo Kiyoshi Kawakami','eduardokawakami@kawakami.com','dudu@Skeelo','1980-01-04',55,14911111114,11111111114,11111114),(5,'Lucas Santana Nunes','ln.santana08@gmail.com','U2FsdGVkX19MZn91WpUshO4xRv4qW3HrdaO3xKrAceU=','2002-08-02',NULL,14998756610,46188786819,17510450),(6,'Vicente Pellicer','otherside155@gmail.com','U2FsdGVkX1/OXqk+QU/i6U5bcSJSpJpCJhTTmrnZfFY=','2002-07-15',NULL,14996912940,51985447878,17507260),(7,'Matheus Colombo','darkristhd22@outlook.com','U2FsdGVkX1+xSoDLrjyNk+nNHiE5/AGWSUIuXtBllc0=','2002-06-04',NULL,14998499266,43982184830,17512400),(8,'Matheus Colombo','darkristhd22@outlook.com','U2FsdGVkX187Kbk5td8/R92+TGFdQqGD2r35GCsujAZALrOxzhcn15dzNI3KZlsa+G9+kh/1X2h2F7mDBtOM3A==','2002-06-04',NULL,14998499266,43982184830,17512400),(9,'luiz Felipe Oliveira','luiz.oliveira372@etec.com','U2FsdGVkX19NXE4NSWMdypWQbIyax0faKiKheFrXhb0=','2002-11-01',NULL,0,0,19770000),(10,'lucas Beltrao','beltrao2002@gmail.com','U2FsdGVkX1/FCUBjzM4nNpDXnKonJV8IecrQXcIcoKc=','2002-03-07',NULL,11950679623,47524562847,17507220),(11,'lucas Beltrao','beltrao2002@gmail.com','U2FsdGVkX1+rRyE5XYR/QpuqjM1vIdG5dypQZmyeF4Z6BUoTRy7oEcJerk5l7MWViifTgSB1JoqnQj7pV7ye9yQn6ssAPe6lEuT4','2002-03-07',NULL,11950679623,47524562847,17507220),(12,'lucas Beltrao','beltrao2002@gmail.com','U2FsdGVkX1/Bh/ynb+FAejVoc7MdmSvOG5xZf4l6vOx97jSmDr3KrIKdfNBL6PUK0ZWRy9ydW/R3Wo2e9mMFzf+j+qMOmK8QQ4jX','2002-03-07',NULL,11950679623,47524562847,17507220),(13,'lucas Beltrao','beltrao2002@gmail.com','U2FsdGVkX180b31RTmzggNgEhKALnt1fPmjImVJJLlbVNDGbFXhE2ihIBRydsX4BhViXwkPL7wdfD5QH47BGoQ==','2002-03-07',NULL,11950679623,47524562847,17507220),(14,'lucas Beltrao','beltrao2002@gmail.com','U2FsdGVkX19FjxBFU7e2DjtMBPtWeOeKThigE+38SegQr+dzuYiy6h87BtmtNPaqIpOItiPYXsShA4AMjrZDNngJaaH0UiLtALn7','2002-03-07',NULL,11950679623,47524562847,17507220),(15,'lucas Beltrao','beltrao2002@gmail.com','U2FsdGVkX1+t+gxqPybMw8saCnJKiRN8mSV39c1uCKOjpwhiVR2ODvK5bxYFVf7IAqYhOYjB0uVFY0ISoQMCOtlcFjicE7mkhm2w','2002-03-07',NULL,11950679623,47524562847,17507220),(16,'lucas Beltrao','beltrao2002@gmail.com','U2FsdGVkX19tCdKSmSeUm+Ipp+s1K3JFeAjv7Dr0cNNQQ8iZ0eqgQJQ8Dc7euej7g87nO7Z+69Xc7vSqIC8vobp8OHvTu+A5uBCL','2002-03-07',NULL,11950679623,47524562847,17507220),(17,'Skeelo','admin@admin.com','U2FsdGVkX19d2rMpsnGE2kLZRdbHxBYw2Qnm9Rm7YaE=','2000-09-01',NULL,14901234567,12312366534,17510340);
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

-- Dump completed on 2019-11-26  7:30:39
