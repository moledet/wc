-- MySQL dump 10.13  Distrib 5.6.42, for Linux (x86_64)
--
-- Host: localhost    Database: wc
-- ------------------------------------------------------
-- Server version	5.6.42

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
-- Table structure for table `entities`
--

DROP TABLE IF EXISTS `entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entities` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(254) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entities`
--

LOCK TABLES `entities` WRITE;
/*!40000 ALTER TABLE `entities` DISABLE KEYS */;
INSERT INTO `entities` VALUES (7,'test','asdfasdf asdfa'),(8,'test 3','asdfasdf asdfasssv'),(9,'test12e','asdfasdf asdfasssva cd');
/*!40000 ALTER TABLE `entities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'login','Login privileges, granted after account confirmation'),(2,'admin','Administrative user, has access to everything.');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_users`
--

DROP TABLE IF EXISTS `roles_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles_users` (
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `fk_role_id` (`role_id`),
  CONSTRAINT `roles_users_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `roles_users_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_users`
--

LOCK TABLES `roles_users` WRITE;
/*!40000 ALTER TABLE `roles_users` DISABLE KEYS */;
INSERT INTO `roles_users` VALUES (3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1);
/*!40000 ALTER TABLE `roles_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tokens`
--

DROP TABLE IF EXISTS `user_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tokens` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `user_agent` varchar(40) NOT NULL,
  `token` varchar(40) NOT NULL,
  `created` int(10) unsigned NOT NULL,
  `expires` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_token` (`token`),
  KEY `fk_user_id` (`user_id`),
  KEY `expires` (`expires`),
  CONSTRAINT `user_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tokens`
--

LOCK TABLES `user_tokens` WRITE;
/*!40000 ALTER TABLE `user_tokens` DISABLE KEYS */;
INSERT INTO `user_tokens` VALUES (1,4,'9850658d1e302a7579fe64cbbd1fd3be38119445','84b161469a4485de0eb666c8c89f6dd69f686583',1542271413,1543481012),(2,5,'9850658d1e302a7579fe64cbbd1fd3be38119445','8fbdc1b65191c01d95a31a7991e066dadb7232bd',1542273936,1543483536),(3,6,'9850658d1e302a7579fe64cbbd1fd3be38119445','9b11a484d840c3441588af4e65d2ce62dfe871f0',1542274236,1543483836),(4,7,'9850658d1e302a7579fe64cbbd1fd3be38119445','590c61e296768c75b6ab3e57d964db6d0e17567a',1542274644,1543484244),(5,8,'9850658d1e302a7579fe64cbbd1fd3be38119445','b0eae275e71e89e920025bb289fe56d0adcffb31',1542275194,1543484794),(6,9,'9850658d1e302a7579fe64cbbd1fd3be38119445','9bae49fb7f738e22310df94fd5aa0a4d30c00919',1542276317,1543485917),(7,10,'9850658d1e302a7579fe64cbbd1fd3be38119445','b9004be9d053c6c63e631468692b0ec94bea256f',1542292012,1543501612),(8,11,'9850658d1e302a7579fe64cbbd1fd3be38119445','644dbd0087b69794e66fd4b692fe348408c3dc94',1542314815,1543524415),(9,12,'9850658d1e302a7579fe64cbbd1fd3be38119445','0ba6743ad833cde1e2adaf85066eff5e411c1830',1542474211,1543683811);
/*!40000 ALTER TABLE `user_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `username` varchar(32) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL,
  `logins` int(10) unsigned NOT NULL DEFAULT '0',
  `last_login` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_username` (`username`),
  UNIQUE KEY `uniq_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'test@mail.ru','test@mail.ru','c03783a22ec07ab8e278685e147c273a8aac0b6e201a8516d95b6d663e48d84b',0,NULL),(2,'test2@mail.ru','test2@mail.ru','c03783a22ec07ab8e278685e147c273a8aac0b6e201a8516d95b6d663e48d84b',0,NULL),(3,'test3@mail.ru','test3@mail.ru','c03783a22ec07ab8e278685e147c273a8aac0b6e201a8516d95b6d663e48d84b',0,NULL),(4,'test4@mail.ru','test4@mail.ru','c03783a22ec07ab8e278685e147c273a8aac0b6e201a8516d95b6d663e48d84b',1,1542271413),(5,'test5@mail.ru','test5@mail.ru','c03783a22ec07ab8e278685e147c273a8aac0b6e201a8516d95b6d663e48d84b',1,1542273936),(6,'test6@mail.ru','test6@mail.ru','c03783a22ec07ab8e278685e147c273a8aac0b6e201a8516d95b6d663e48d84b',1,1542274236),(7,'test8@mail.ru','test8@mail.ru','c03783a22ec07ab8e278685e147c273a8aac0b6e201a8516d95b6d663e48d84b',1,1542274644),(8,'test9@mail.ru','test9@mail.ru','c03783a22ec07ab8e278685e147c273a8aac0b6e201a8516d95b6d663e48d84b',1,1542275194),(9,'test10@mail.ru','test10@mail.ru','c03783a22ec07ab8e278685e147c273a8aac0b6e201a8516d95b6d663e48d84b',1,1542276317),(10,'test11@mail.ru','test11@mail.ru','c03783a22ec07ab8e278685e147c273a8aac0b6e201a8516d95b6d663e48d84b',1,1542292012),(11,'test121@mail.ru','test121@mail.ru','c03783a22ec07ab8e278685e147c273a8aac0b6e201a8516d95b6d663e48d84b',1,1542314815),(12,'test_21@mail.ru','test_21@mail.ru','c03783a22ec07ab8e278685e147c273a8aac0b6e201a8516d95b6d663e48d84b',1,1542474211);
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

-- Dump completed on 2018-11-17 17:21:09
