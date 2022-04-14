-- MariaDB dump 10.19  Distrib 10.5.9-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: AVideoEncoder
-- ------------------------------------------------------
-- Server version	10.5.9-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `configurations_encoder`
--

DROP TABLE IF EXISTS `configurations_encoder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configurations_encoder` (
  `id` int(11) NOT NULL,
  `allowedStreamersURL` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `defaultPriority` int(1) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `version` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `autodelete` tinyint(1) DEFAULT 1,
  `resolutions` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configurations_encoder`
--

LOCK TABLES `configurations_encoder` WRITE;
/*!40000 ALTER TABLE `configurations_encoder` DISABLE KEYS */;
INSERT INTO `configurations_encoder` VALUES (1,'http://127.0.0.1/',1,'2022-04-13 23:54:18','2022-04-13 23:54:18','3.9',1,NULL);
/*!40000 ALTER TABLE `configurations_encoder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encoder_queue`
--

DROP TABLE IF EXISTS `encoder_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encoder_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fileURI` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_obs` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_vars` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `worker_pid` int(11) DEFAULT NULL,
  `worker_ppid` int(11) DEFAULT NULL,
  `priority` int(1) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `videoDownloadedLink` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `downloadedFileName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `streamers_id` int(11) NOT NULL,
  `override_status` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `formats_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_encoder_queue_formats_idx` (`formats_id`),
  KEY `fk_encoder_queue_streamers1_idx` (`streamers_id`),
  CONSTRAINT `fk_encoder_queue_formats` FOREIGN KEY (`formats_id`) REFERENCES `formats` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_encoder_queue_streamers1` FOREIGN KEY (`streamers_id`) REFERENCES `streamers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encoder_queue`
--

LOCK TABLES `encoder_queue` WRITE;
/*!40000 ALTER TABLE `encoder_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `encoder_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formats`
--

DROP TABLE IF EXISTS `formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `extension` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extension_from` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formats`
--

LOCK TABLES `formats` WRITE;
/*!40000 ALTER TABLE `formats` DISABLE KEYS */;
INSERT INTO `formats` VALUES (1,'MP4 Low','ffmpeg -i {$pathFileName} -vf scale=-2:360 -movflags +faststart -preset veryfast -vcodec h264 -acodec aac -strict -2 -max_muxing_queue_size 1024 -y {$destinationFile}','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',10),(2,'WEBM Low','ffmpeg -i {$pathFileName} -vf scale=-2:360 -movflags +faststart -preset veryfast -f webm -c:v libvpx -b:v 1M -acodec libvorbis -y {$destinationFile}','2022-04-13 23:54:17','2022-04-13 23:54:17','webm','mp4',20),(3,'MP3','ffmpeg -i {$pathFileName} -acodec libmp3lame -y {$destinationFile}','2022-04-13 23:54:17','2022-04-13 23:54:17','mp3','mp3',30),(4,'OGG','ffmpeg -i {$pathFileName} -acodec libvorbis -y {$destinationFile}','2022-04-13 23:54:17','2022-04-13 23:54:17','ogg','mp3',40),(5,'MP3 to Spectrum.MP4','ffmpeg -i {$pathFileName} -filter_complex \'[0:a]showwaves=s=1280x720:mode=line,format=yuv420p[v]\' -map \'[v]\' -map 0:a -c:v libx264 -c:a copy {$destinationFile}','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp3',50),(6,'Video.MP4 to Audio.MP3','ffmpeg -i {$pathFileName} -y {$destinationFile}','2022-04-13 23:54:17','2022-04-13 23:54:17','mp3','mp4',60),(7,'MP4 SD','ffmpeg -i {$pathFileName} -vf scale=-2:540 -movflags +faststart -preset veryfast -vcodec h264 -acodec aac -strict -2 -max_muxing_queue_size 1024 -y {$destinationFile}','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',11),(8,'MP4 HD','ffmpeg -i {$pathFileName} -vf scale=-2:720 -movflags +faststart -preset veryfast -vcodec h264 -acodec aac -strict -2 -max_muxing_queue_size 1024 -y {$destinationFile}','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',12),(9,'WEBM SD','ffmpeg -i {$pathFileName} -vf scale=-2:540 -movflags +faststart -preset veryfast -f webm -c:v libvpx -b:v 1M -acodec libvorbis -y {$destinationFile}','2022-04-13 23:54:17','2022-04-13 23:54:17','webm','mp4',21),(10,'WEBM HD','ffmpeg -i {$pathFileName} -vf scale=-2:720 -movflags +faststart -preset veryfast -f webm -c:v libvpx -b:v 1M -acodec libvorbis -y {$destinationFile}','2022-04-13 23:54:17','2022-04-13 23:54:17','webm','mp4',22),(11,'Video to Spectrum','60-50-10','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',70),(12,'Video to Audio','60-40','2022-04-13 23:54:17','2022-04-13 23:54:17','mp3','mp4',71),(13,'Both Video','10-20','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',72),(14,'Both Audio','30-40','2022-04-13 23:54:17','2022-04-13 23:54:17','mp3','mp3',73),(15,'MP4 Low','10','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',74),(16,'MP4 SD','11','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',75),(17,'MP4 HD','12','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',76),(18,'MP4 Low SD','10-11','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',77),(19,'MP4 SD HD','11-12','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',78),(20,'MP4 Low HD','10 12','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',79),(21,'MP4 Low SD HD','10-11-12','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',80),(22,'Both Low','10-20','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',81),(23,'Both SD','11-21','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',82),(24,'Both HD','12-22','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',83),(25,'Both Low SD','10-11-20-21','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',84),(26,'Both SD HD','11-12-21-22','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',85),(27,'Both Low HD','10-12-20-22','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',86),(28,'Both Low SD HD','10-11-12-20-21-22','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','mp4',87),(29,'Multi Bitrate HLS VOD encrypted','ffmpeg -re -i {$pathFileName} -c:a aac -strict -2 -b:a 128k -c:v libx264 -vf scale=-2:360 -g 48 -keyint_min 48  -sc_threshold 0 -bf 3 -b_strategy 2 -b:v 800k -maxrate 856k -bufsize 1200k -f hls -hls_time 6 -hls_list_size 0 -hls_key_info_file {$destinationFile}keyinfo {$destinationFile}low/index.m3u8 -c:a aac -strict -2 -b:a 128k -c:v libx264 -vf scale=-2:540 -g 48 -keyint_min 48 -sc_threshold 0 -bf 3 -b_strategy 2 -b:v 1400k -maxrate 1498k -bufsize 2100k -f hls -hls_time 6 -hls_list_size 0 -hls_key_info_file {$destinationFile}keyinfo {$destinationFile}sd/index.m3u8 -c:a aac -strict -2 -b:a 128k -c:v libx264 -vf scale=-2:720 -g 48 -keyint_min 48 -sc_threshold 0 -bf 3 -b_strategy 2 -b:v 2800k -maxrate 2996k -bufsize 4200k -f hls -hls_time 6 -hls_list_size 0 -hls_key_info_file {$destinationFile}keyinfo {$destinationFile}hd/index.m3u8','2022-04-13 23:54:17','2022-04-13 23:54:17','mp4','m3u8',9),(30,'Dynamic HLS','-c:v h264 -vf scale=-2:{$resolution} -r 24 -g 48 -keyint_min 48 -sc_threshold 0 -bf 3 -b_strategy 2 -minrate {$minrate}k -crf 23 -maxrate {$maxrate}k -bufsize {$bufsize}k -c:a aac -b:a {$autioBitrate}k -f hls -hls_time 6 -hls_list_size 0 -hls_key_info_file {$destinationFile}keyinfo {$destinationFile}res{$resolution}/index.m3u8','2022-04-13 23:54:17','2022-04-13 23:54:17','m3u8','mp4',6),(31,'Dynamic MP4','-vf scale=-2:{$resolution} -movflags +faststart -preset veryfast -vcodec h264 -acodec aac -strict -2 -b:a {$autioBitrate}k  -max_muxing_queue_size 1024 -y {$destinationFile}','2022-04-13 23:54:18','2022-04-13 23:54:18','mp4','mp4',7),(32,'Dynamic WEBM','-vf scale=-2:{$resolution} -movflags +faststart -preset veryfast -f webm -c:v libvpx -b:v 1M -acodec libvorbis -b:a {$autioBitrate}k  -y {$destinationFile}','2022-04-13 23:54:18','2022-04-13 23:54:18','webm','mp4',8),(33,'Audio to HLS','','2022-04-13 23:54:18','2022-04-13 23:54:18','m3u8','mp3',88),(34,'Audio to MP4','','2022-04-13 23:54:18','2022-04-13 23:54:18','mp4','mp3',89),(35,'Audio to WEBM','','2022-04-13 23:54:18','2022-04-13 23:54:18','webm','mp3',90);
/*!40000 ALTER TABLE `formats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `streamers`
--

DROP TABLE IF EXISTS `streamers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `streamers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteURL` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pass` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` int(11) NOT NULL DEFAULT 3,
  `isAdmin` tinyint(1) NOT NULL DEFAULT 0,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `streamers`
--

LOCK TABLES `streamers` WRITE;
/*!40000 ALTER TABLE `streamers` DISABLE KEYS */;
INSERT INTO `streamers` VALUES (1,'http://127.0.0.1/','admin','1234',1,1,'2022-04-13 23:54:18','2022-04-13 23:54:18');
/*!40000 ALTER TABLE `streamers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upload_queue`
--

DROP TABLE IF EXISTS `upload_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upload_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `encoders_id` int(11) NOT NULL,
  `resolution` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `format` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `videos_id` int(11) NOT NULL,
  `status` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_upload_queue_encoders_idx` (`encoders_id`),
  CONSTRAINT `fk_upload_queue_encoders` FOREIGN KEY (`encoders_id`) REFERENCES `encoder_queue` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upload_queue`
--

LOCK TABLES `upload_queue` WRITE;
/*!40000 ALTER TABLE `upload_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `upload_queue` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-13 23:55:56
