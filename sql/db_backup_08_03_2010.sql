-- MySQL dump 10.11
--
-- Host: localhost    Database: eluabuilder
-- ------------------------------------------------------
-- Server version	5.0.67-0ubuntu6

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
-- Table structure for table `builds`
--

DROP TABLE IF EXISTS `builds`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `builds` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `configs` text,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `builds`
--

LOCK TABLES `builds` WRITE;
/*!40000 ALTER TABLE `builds` DISABLE KEYS */;
INSERT INTO `builds` VALUES (1,'teste','2009-10-21 14:55:50','{file_id=\"\",dns2=100,ip0=192,target=\"EK-LM3S8962\",build_con_generic=\"//\",created_at=\"2009-10-21 14:55:50\",dns3=20,build_con_tcp=\"//\",title=\"teste\",mask1=255,dns0=192,mask3=0,mask0=255,mask2=255,build_uip=\"//\",build_xmodem=\"//\",gateway0=192,ip3=5,scons=\"scons board=EK-LM3S8962  toolchain=codesourcery  romfs=verbatim prog > log.txt 2> log_errors.txt\",gateway1=168,gateway3=20,toolchain=\"codesourcery\",dns1=168,id=1,romfsmode=\"verbatim\",ip2=100,build_term=\"//\",build_dhcpc=\"//\",build_adc=\"//\",build_dns=\"//\",ip1=168,build_romfs=\"//\",build_shell=\"//\",gateway2=100,}',1),(2,'teste2','2009-10-21 14:56:47','{file_id=\"\",dns2=100,ip0=192,target=\"EK-LM3S8962\",build_con_generic=\"//\",created_at=\"2009-10-21 14:56:47\",dns3=20,build_con_tcp=\"//\",title=\"teste2\",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip=\"\",build_xmodem=\"//\",gateway0=192,ip3=5,scons=\"scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt\",gateway1=168,dns1=168,toolchain=\"default\",id=2,romfsmode=\"verbatim\",build_shell=\"//\",ip2=100,gateway3=20,build_dns=\"\",build_adc=\"//\",build_dhcpc=\"//\",ip1=168,build_term=\"//\",build_romfs=\"//\",mask0=255,}',1),(3,'teste3','2009-10-21 15:19:13','{file_id=\"\",dns2=100,ip0=192,target=\"EK-LM3S8962\",build_con_generic=\"//\",created_at=\"2009-10-21 15:19:13\",dns3=20,build_con_tcp=\"//\",title=\"teste3\",mask1=255,dns0=192,mask3=0,mask0=255,mask2=255,build_uip=\"//\",build_xmodem=\"//\",gateway0=192,ip3=5,scons=\"scons board=EK-LM3S8962  toolchain=codesourcery  romfs=verbatim prog > log.txt 2> log_errors.txt\",gateway1=168,gateway3=20,toolchain=\"codesourcery\",dns1=168,id=3,romfsmode=\"verbatim\",ip2=100,build_term=\"//\",build_dhcpc=\"//\",build_adc=\"//\",build_dns=\"//\",ip1=168,build_romfs=\"//\",build_shell=\"//\",gateway2=100,}',1),(4,'build do mauricio','2009-11-11 19:17:02','{file_id=\"\",dns2=100,ip0=192,target=\"EK-LM3S8962\",build_con_generic=\"\",created_at=\"2009-11-11 19:17:02\",dns3=20,build_con_tcp=\"//\",title=\"build do mauricio\",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip=\"\",build_xmodem=\"//\",gateway0=192,ip3=5,scons=\"scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt\",gateway1=168,build_dns=\"\",toolchain=\"default\",id=4,dns1=168,romfsmode=\"verbatim\",ip2=100,gateway3=20,build_adc=\"//\",build_shell=\"//\",build_dhcpc=\"\",ip1=168,build_term=\"//\",build_romfs=\"//\",mask0=255,}',1),(7,'Tetrives','2009-11-12 17:10:33','{file_id={9,10,},build_shell=\"true\",build_adc=\"true\",toolchain=\"default\",id=7,build_uip=\"true\",created_at=\"2009-11-12 17:10:33\",build_xmodem=\"true\",build_con_tcp=\"true\",build_term=\"true\",title=\"Tetrives\",build_dhcpc=\"true\",target=\"EK-LM3S8962\",build_dns=\"true\",build_romfs=\"true\",build_con_generic=\"true\",}',3),(8,'sadfasdf','2009-11-16 13:58:56','{file_id=\"\",build_shell=\"true\",build_adc=\"false\",toolchain=\"codesourcery\",id=\"\",build_uip=\"false\",created_at=\"\",build_xmodem=\"true\",build_con_tcp=\"false\",build_dns=\"false\",title=\"sadfasdf\",build_dhcpc=\"false\",target=\"EK-LM3S6965\",build_term=\"false\",build_romfs=\"false\",build_con_generic=\"true\",}',5),(9,'Default components for LM3S8962','2009-11-18 12:51:12','{file_id=\"\",dns2=100,ip0=192,target=\"EK-LM3S8962\",build_con_generic=\"//\",created_at=\"2009-11-18 12:51:12\",dns3=20,build_con_tcp=\"\",title=\"Default components for LM3S8962\",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip=\"\",build_xmodem=\"\",gateway0=192,build_romfs=\"\",scons=\"scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt\",gateway1=168,build_shell=\"\",toolchain=\"default\",id=9,build_term=\"\",build_dns=\"\",ip2=100,build_adc=\"\",dns1=168,ip3=5,build_dhcpc=\"\",ip1=168,romfsmode=\"verbatim\",gateway3=20,mask0=255,}',1),(10,'Default components for LM3S6965','2009-11-18 12:52:32','{file_id=\"\",dns2=100,ip0=192,target=\"EK-LM3S6965\",build_con_generic=\"//\",created_at=\"2009-11-18 12:52:32\",dns3=20,build_con_tcp=\"\",title=\"Default components for LM3S6965\",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip=\"\",build_xmodem=\"\",gateway0=192,build_romfs=\"\",scons=\"scons board=EK-LM3S6965   romfs=compress prog > log.txt 2> log_errors.txt\",gateway1=168,build_shell=\"\",toolchain=\"default\",id=10,build_term=\"\",build_dns=\"\",ip2=100,build_adc=\"\",dns1=168,ip3=5,build_dhcpc=\"\",ip1=168,romfsmode=\"compress\",gateway3=20,mask0=255,}',1),(11,'teste55','2009-11-18 12:57:38','{file_id=\"\",dns2=100,ip0=192,target=\"EK-LM3S9B92\",build_con_generic=\"//\",created_at=\"2009-11-18 12:57:38\",dns3=20,build_con_tcp=\"//\",title=\"teste55\",mask1=255,dns0=192,mask3=0,mask0=255,mask2=255,build_rpc=\"\",build_xmodem=\"//\",gateway0=192,ip3=5,scons=\"scons board=EK-LM3S9B92   romfs=verbatim prog > log.txt 2> log_errors.txt\",gateway3=20,gateway1=168,id=11,toolchain=\"default\",dns1=168,build_adc=\"\",romfsmode=\"verbatim\",ip2=100,build_dhcpc=\"//\",build_shell=\"//\",build_uip=\"//\",build_dns=\"//\",ip1=168,build_term=\"//\",build_romfs=\"//\",gateway2=100,}',1),(13,'Meu build novo','2009-12-14 10:00:01','{file_id={6,7,},dns2=100,ip0=192,target=\"EK-LM3S8962\",build_con_generic=\"\",created_at=\"2009-12-14 10:00:01\",dns3=20,build_con_tcp=\"//\",title=\"Meu build novo\",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip=\"//\",build_xmodem=\"\",gateway0=192,ip3=5,scons=\"scons board=EK-LM3S8962   romfs=compile prog > log.txt 2> log_errors.txt\",build_shell=\"\",gateway3=20,toolchain=\"default\",id=13,build_romfs=\"\",dns1=168,ip2=100,build_adc=\"//\",build_dhcpc=\"//\",romfsmode=\"compile\",build_dns=\"//\",ip1=168,gateway1=168,build_term=\"\",mask0=255,}',1),(27,'novo build do zero','2010-02-22 18:39:14','{file_id=7,dns2=100,ip0=192,build_mmcfs=\"\",target=\"EAGLE-100\",build_con_generic=\"\",created_at=\"\",dns3=20,build_con_tcp=\"//\",title=\"novo build do zero\",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_rpc=\"\",build_xmodem=\"\",gateway0=192,ip3=5,scons=\"scons board=EAGLE-100   romfs=verbatim prog > log.txt 2> log_errors.txt\",gateway3=20,gateway1=168,build_shell=\"\",toolchain=\"default\",dns1=168,build_romfs=\"\",romfsmode=\"verbatim\",ip2=100,build_dhcpc=\"//\",build_term=\"\",build_adc=\"\",build_dns=\"//\",ip1=168,build_uip=\"//\",mask0=255,id=\"\",}',1),(28,'sfsafasdfasfd','2010-03-05 08:53:36','{file_id=\"\",dns2=100,ip0=192,build_mmcfs=\"\",target=\"EK-LM3S8962\",build_con_generic=\"\",created_at=\"\",dns3=20,build_con_tcp=\"//\",title=\"sfsafasdfasfd\",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip=\"\",build_xmodem=\"\",gateway0=192,build_romfs=\"\",scons=\"scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt\",build_shell=\"\",gateway1=168,gateway3=20,toolchain=\"default\",id=\"\",build_term=\"\",build_adc=\"\",ip2=100,build_dns=\"\",ip3=5,dns1=168,build_dhcpc=\"//\",ip1=168,build_rpc=\"\",romfsmode=\"verbatim\",mask0=255,}',1),(29,'testanto jquery','2010-03-05 08:55:37','{file_id=6,dns2=100,ip0=192,build_mmcfs=\"\",target=\"EK-LM3S9B92\",build_con_generic=\"\",created_at=\"\",dns3=20,build_con_tcp=\"//\",title=\"testanto jquery\",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_rpc=\"\",build_xmodem=\"\",gateway0=192,ip3=5,scons=\"scons board=EK-LM3S9B92   romfs=verbatim prog > log.txt 2> log_errors.txt\",gateway3=20,gateway1=168,build_shell=\"\",toolchain=\"default\",dns1=168,build_romfs=\"\",romfsmode=\"verbatim\",ip2=100,build_dhcpc=\"//\",build_term=\"\",build_adc=\"\",build_dns=\"//\",ip1=168,build_uip=\"//\",mask0=255,id=\"\",}',1),(30,'jhfdfdfjhfdfdssddld','2010-03-05 09:03:59','{file_id=5,dns2=100,ip0=192,build_mmcfs=\"\",target=\"EK-LM3S9B92\",build_con_generic=\"\",created_at=\"\",dns3=20,build_con_tcp=\"//\",title=\"jhfdfdfjhfdfdssddld\",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip=\"\",build_xmodem=\"\",gateway0=192,build_romfs=\"\",scons=\"scons board=EK-LM3S9B92   romfs=verbatim prog > log.txt 2> log_errors.txt\",build_shell=\"\",gateway1=168,gateway3=20,toolchain=\"default\",id=\"\",build_term=\"\",build_adc=\"\",ip2=100,build_dns=\"\",ip3=5,dns1=168,build_dhcpc=\"//\",ip1=168,build_rpc=\"\",mask0=255,romfsmode=\"verbatim\",}',1),(31,'testando de novo','2010-03-05 09:15:56','{file_id={7,8,},dns2=100,ip0=192,build_mmcfs=\"true\",target=\"EK-LM3S9B92\",build_con_generic=\"false\",created_at=\"2010-03-05 09:15:56\",dns3=20,build_con_tcp=\"true\",title=\"testando de novo\",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip=\"true\",build_xmodem=\"false\",gateway0=192,ip3=5,scons=\"scons board=EK-LM3S9B92   romfs=verbatim prog > log.txt 2> log_errors.txt\",gateway3=20,gateway1=168,build_romfs=\"true\",toolchain=\"default\",id=31,build_term=\"true\",build_rpc=\"true\",ip2=100,build_dns=\"true\",dns1=168,build_adc=\"true\",build_dhcpc=\"false\",ip1=168,romfsmode=\"verbatim\",build_shell=\"false\",mask0=255,}',1),(32,'agora com novo layout','2010-03-08 11:06:53','{file_id=5,dns2=\"\",ip0=\"\",build_mmcfs=\"true\",target=\"EK-LM3S6965\",build_con_generic=\"true\",created_at=\"\",dns3=\"\",build_con_tcp=\"false\",romfsmode=\"verbatim\",mask1=\"\",dns0=\"\",mask3=\"\",gateway2=\"\",mask2=\"\",build_uip=\"true\",build_xmodem=\"false\",gateway0=\"\",ip3=\"\",scons=\"scons board=EK-LM3S6965   romfs=verbatim prog > log.txt 2> log_errors.txt\",title=\"agora com novo layout\",gateway1=\"\",build_romfs=\"true\",toolchain=\"default\",build_adc=\"true\",gateway3=\"\",build_shell=\"false\",ip2=\"\",build_dhcpc=\"false\",dns1=\"\",build_rpc=\"true\",build_dns=\"false\",ip1=\"\",mask0=\"\",id=\"\",build_term=\"false\",}',1);
/*!40000 ALTER TABLE `builds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `builds_files`
--

DROP TABLE IF EXISTS `builds_files`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `builds_files` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `build_id` int(10) unsigned NOT NULL,
  `file_id` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `builds_files`
--

LOCK TABLES `builds_files` WRITE;
/*!40000 ALTER TABLE `builds_files` DISABLE KEYS */;
INSERT INTO `builds_files` VALUES (2,2,'1'),(4,1,'1'),(12,3,''),(13,4,'1'),(17,7,'9'),(18,7,'10'),(19,8,''),(20,9,''),(21,10,''),(24,11,'1'),(75,1,''),(76,1,''),(77,1,''),(78,2,''),(79,3,''),(80,4,''),(81,9,''),(82,10,''),(83,11,''),(84,13,'6'),(85,13,'7'),(86,27,'7'),(87,28,''),(88,29,'6'),(89,30,'5'),(107,31,'7'),(108,31,'8'),(109,32,'5');
/*!40000 ALTER TABLE `builds_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `files` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `filename` varchar(255) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `category` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (4,'eluabuilder.txt',1,'2009-11-23 12:48:51','User File'),(5,'sconstruct_old',1,'2009-11-23 14:19:38','User File'),(6,'hangman.lua',1,'2009-12-14 10:00:01','User File'),(7,'bisect.lua',1,'2009-12-14 10:41:40','User File'),(8,'pong.lua',1,'2009-12-16 11:06:22','User File'),(9,'adcpoll.lua',1,'2010-03-05 09:15:56','User File');
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `actived` tinyint(1) unsigned zerofill NOT NULL default '1',
  `login` varchar(10) NOT NULL,
  `passwd` varchar(32) NOT NULL,
  `email` varchar(80) NOT NULL,
  `name` varchar(80) NOT NULL,
  `country` varchar(50) default NULL,
  `organization` varchar(80) default NULL,
  `elua_list` tinyint(1) default NULL,
  `remarks` text,
  `resume` text,
  `user_hash` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'carlos','987197373a91dd51d8b7cac435b7921f','carlos.deodoro@gmail.com','Carlos','BR','Inteligent Sensors',NULL,'dfgdfgsdrr',NULL,''),(2,1,'carlostest','987197373a91dd51d8b7cac435b7921f','carlos.deodoro@gmail.com','carlos','','',NULL,'',NULL,NULL),(3,1,'ivesnc','73fd004ad7ac7f9e352e1f42cdef5759','ivesncc@gmail.com','Ives Negreiros','BR','Academic',NULL,'',NULL,NULL),(4,1,'teofb','743567feb05dfa00db7d92dd0d6a21a2','teo.benjamin@gmail.com','TÃ©o Benjamin','BR','Military',NULL,'',NULL,NULL),(5,1,'ceduardo','987197373a91dd51d8b7cac435b7921f','carlos.deodoro@gmail.com','Carlos Eduardo','BS','Other',NULL,'sdfsd',NULL,NULL);
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

-- Dump completed on 2010-03-08 17:46:19
