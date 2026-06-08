/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.6-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: u894221422_apexprimetv
-- ------------------------------------------------------
-- Server version	11.8.6-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `activity_log`
--

DROP TABLE IF EXISTS `activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `log_name` varchar(191) DEFAULT NULL,
  `description` text NOT NULL,
  `subject_type` varchar(191) DEFAULT NULL,
  `subject_id` bigint(20) unsigned DEFAULT NULL,
  `event` varchar(191) DEFAULT NULL,
  `causer_type` varchar(191) DEFAULT NULL,
  `causer_id` bigint(20) unsigned DEFAULT NULL,
  `properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`properties`)),
  `batch_uuid` char(36) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subject` (`subject_type`,`subject_id`),
  KEY `causer` (`causer_type`,`causer_id`),
  KEY `activity_log_log_name_index` (`log_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_log`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `activity_log` WRITE;
/*!40000 ALTER TABLE `activity_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_log` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `address_line_1` varchar(191) NOT NULL,
  `address_line_2` varchar(191) DEFAULT NULL,
  `postal_code` varchar(191) DEFAULT NULL,
  `city` varchar(191) NOT NULL,
  `state` varchar(191) NOT NULL,
  `country` varchar(191) NOT NULL,
  `latitude` double NOT NULL DEFAULT 1,
  `longitude` double NOT NULL DEFAULT 1,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `addressable_type` varchar(191) NOT NULL,
  `addressable_id` bigint(20) unsigned NOT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `addresses_addressable_type_addressable_id_index` (`addressable_type`,`addressable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `ads`
--

DROP TABLE IF EXISTS `ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `ads` WRITE;
/*!40000 ALTER TABLE `ads` DISABLE KEYS */;
/*!40000 ALTER TABLE `ads` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `audio`
--

DROP TABLE IF EXISTS `audio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `audio` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `artist` varchar(191) DEFAULT NULL,
  `album` varchar(191) DEFAULT NULL,
  `genre` varchar(191) DEFAULT NULL,
  `audio_path` varchar(191) NOT NULL,
  `thumbnail` varchar(191) DEFAULT NULL,
  `video_preview_url` varchar(191) DEFAULT NULL,
  `video_preview_duration` int(11) DEFAULT NULL,
  `lyrics` text DEFAULT NULL,
  `lyrics_timestamps` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`lyrics_timestamps`)),
  `spotify_id` varchar(191) DEFAULT NULL,
  `youtube_id` varchar(191) DEFAULT NULL,
  `external_urls` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`external_urls`)),
  `waveform_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`waveform_data`)),
  `music_video_url` varchar(191) DEFAULT NULL,
  `music_video_duration` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `format` varchar(191) NOT NULL DEFAULT 'mp3',
  `bitrate` int(11) DEFAULT NULL,
  `plays_count` int(11) NOT NULL DEFAULT 0,
  `likes_count` int(11) NOT NULL DEFAULT 0,
  `skip_count` int(11) NOT NULL DEFAULT 0,
  `completion_rate` int(11) NOT NULL DEFAULT 0,
  `play_history` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`play_history`)),
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audio`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `audio` WRITE;
/*!40000 ALTER TABLE `audio` DISABLE KEYS */;
/*!40000 ALTER TABLE `audio` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `banners`
--

DROP TABLE IF EXISTS `banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `banners` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) DEFAULT NULL,
  `file_url` text DEFAULT NULL,
  `poster_url` text DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `type_id` varchar(191) DEFAULT NULL,
  `type_name` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `banner_for` varchar(20) DEFAULT 'home',
  `poster_tv_url` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `banners_status_deleted_at_index` (`status`,`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banners`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `banners` WRITE;
/*!40000 ALTER TABLE `banners` DISABLE KEYS */;
INSERT INTO `banners` VALUES
(1,NULL,'web-home-player.jpg','app-home-player.jpg','movie','104','The Daring Player',NULL,1,2,2,NULL,'2024-10-08 05:18:48','2026-02-18 08:17:54',NULL,'home','tv-home-player.jpg'),
(2,NULL,'web-home.jpg','app-home.jpg','tvshow','109','The Smiling Doll',NULL,1,2,2,NULL,'2024-10-08 05:19:29','2026-02-18 08:17:54',NULL,'home','tv-home.jpg'),
(3,NULL,'web-home-bluey.jpg','app-home-bluey.jpg','movie','104','Bluey',NULL,1,2,1,NULL,'2024-10-08 05:20:16','2026-02-18 08:17:54',NULL,'movie','tv-home-bluey.jpg'),
(4,NULL,'web-movie-black.jpg','app-movie-black.jpg','movie','104','Men in black',NULL,1,2,1,NULL,'2024-10-08 05:20:53','2026-02-18 08:17:54',NULL,'movie','tv-movie-black.jpg'),
(5,NULL,'web-videos-heal.jpg','app-videos-heal.jpg','video','2','Heal Your Mind Before You Fix Your Life',NULL,1,1,1,NULL,'2025-04-22 10:54:11','2026-02-18 08:17:54',NULL,'video','tv-videos-heal.jpg'),
(6,NULL,'web-videos-mind.jpg','app-videos-mind.jpg','video','5','Spiritual Habits for a Calm Mind',NULL,1,1,1,NULL,'2025-04-22 10:54:25','2026-02-18 08:17:54',NULL,'video','tv-videos-mind.jpg'),
(7,NULL,'web-home-vibe.jpg','app-home-vibe.jpg','video','7','Victory Vibes',NULL,1,1,1,NULL,'2025-04-22 10:54:36','2026-02-18 08:17:54',NULL,'home','tv-home-vibe.jpg'),
(8,NULL,'web-show-game.jpg','app-show-game.jpg','tvshow','109','Game of Thrones',NULL,1,1,1,NULL,'2025-04-22 10:55:18','2026-02-18 08:17:54',NULL,'tv_show','tv-show-game.jpg'),
(9,NULL,'web-show-factor.jpg','app-show-factor.jpg','tvshow','109','Fear Factor',NULL,1,1,1,NULL,'2025-04-22 10:55:31','2026-02-18 08:17:54',NULL,'tv_show','tv-show-factor.jpg'),
(10,'Discover Unlimited Entertainment',NULL,'banner1.png',NULL,NULL,NULL,NULL,1,1,1,NULL,'2025-04-22 10:55:31','2026-02-18 08:17:54',NULL,'promotional',NULL),
(11,'Watch Anytime, On Any Device',NULL,'banner2.png',NULL,NULL,NULL,NULL,1,1,1,NULL,'2025-04-22 10:55:31','2026-02-18 08:17:54',NULL,'promotional',NULL),
(12,'Explore Movies, Shows & Sports',NULL,'banner3.png',NULL,NULL,NULL,NULL,1,1,1,NULL,'2025-04-22 10:55:31','2026-02-18 08:17:54',NULL,'promotional',NULL),
(13,'Subscribe to Get Unlimited Access',NULL,'banner4.png',NULL,NULL,NULL,NULL,1,1,1,NULL,'2025-04-22 10:55:31','2026-02-18 08:17:54',NULL,'promotional',NULL);
/*!40000 ALTER TABLE `banners` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `cast_crew`
--

DROP TABLE IF EXISTS `cast_crew`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cast_crew` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) DEFAULT NULL,
  `file_url` varchar(191) DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `tmdb_id` varchar(191) DEFAULT NULL,
  `bio` longtext DEFAULT NULL,
  `place_of_birth` varchar(191) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `designation` varchar(191) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cast_crew_deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cast_crew`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `cast_crew` WRITE;
/*!40000 ALTER TABLE `cast_crew` DISABLE KEYS */;
INSERT INTO `cast_crew` VALUES
(1,'Edward Norton',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:43:57','2026-03-04 22:43:57'),
(2,'Brad Pitt',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:42','2026-03-04 22:46:42'),
(3,'Helena Bonham Carter',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:42','2026-03-04 22:46:42'),
(4,'Meat Loaf',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:42','2026-03-04 22:46:42'),
(5,'Jared Leto',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:42','2026-03-04 22:46:42'),
(6,'Tom Hanks',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:46','2026-03-04 22:46:46'),
(7,'Robin Wright',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:46','2026-03-04 22:46:46'),
(8,'Gary Sinise',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:46','2026-03-04 22:46:46'),
(9,'Sally Field',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:46','2026-03-04 22:46:46'),
(10,'Mykelti Williamson',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:46','2026-03-04 22:46:46'),
(11,'Christian Bale',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:48','2026-03-04 22:46:48'),
(12,'Heath Ledger',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:48','2026-03-04 22:46:48'),
(13,'Aaron Eckhart',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:48','2026-03-04 22:46:48'),
(14,'Michael Caine',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:48','2026-03-04 22:46:48'),
(15,'Maggie Gyllenhaal',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:48','2026-03-04 22:46:48'),
(16,'Leonardo DiCaprio',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51'),
(17,'Joseph Gordon-Levitt',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51'),
(18,'Ken Watanabe',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51'),
(19,'Tom Hardy',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51'),
(20,'Elliot Page',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51'),
(21,'John Travolta',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:52','2026-03-04 22:46:52'),
(22,'Samuel L. Jackson',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:52','2026-03-04 22:46:52'),
(23,'Uma Thurman',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:52','2026-03-04 22:46:52'),
(24,'Bruce Willis',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:52','2026-03-04 22:46:52'),
(25,'Ving Rhames',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:52','2026-03-04 22:46:52'),
(26,'Tim Robbins',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:57','2026-03-04 22:46:57'),
(27,'Morgan Freeman',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:57','2026-03-04 22:46:57'),
(28,'Bob Gunton',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:57','2026-03-04 22:46:57'),
(29,'William Sadler',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:57','2026-03-04 22:46:57'),
(30,'Clancy Brown',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:46:57','2026-03-04 22:46:57'),
(31,'Marlon Brando',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:03','2026-03-04 22:47:03'),
(32,'Al Pacino',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:03','2026-03-04 22:47:03'),
(33,'James Caan',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:03','2026-03-04 22:47:03'),
(34,'Robert Duvall',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:03','2026-03-04 22:47:03'),
(35,'Richard S. Castellano',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:03','2026-03-04 22:47:03'),
(36,'Liam Neeson',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09'),
(37,'Ben Kingsley',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09'),
(38,'Ralph Fiennes',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09'),
(39,'Caroline Goodall',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09'),
(40,'Jonathan Sagall',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09'),
(41,'Rumi Hiiragi',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13'),
(42,'Miyu Irino',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13'),
(43,'Mari Natsuki',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13'),
(44,'Takashi Naito',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13'),
(45,'Yasuko Sawaguchi',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13'),
(46,'Kajol',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:15','2026-03-04 22:47:15'),
(47,'Shah Rukh Khan',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:15','2026-03-04 22:47:15'),
(48,'Amrish Puri',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:15','2026-03-04 22:47:15'),
(49,'Farida Jalal',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:15','2026-03-04 22:47:15'),
(50,'Anupam Kher',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:15','2026-03-04 22:47:15'),
(51,'Peter Dinklage',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19'),
(52,'Kit Harington',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19'),
(53,'Nikolaj Coster-Waldau',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19'),
(54,'Lena Headey',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19'),
(55,'Emilia Clarke',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19'),
(56,'Pedro Pascal',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:25','2026-03-04 22:47:25'),
(57,'Katee Sackhoff',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:25','2026-03-04 22:47:25'),
(58,'Grant Gustin',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:27','2026-03-04 22:47:27'),
(59,'Candice Patton',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:27','2026-03-04 22:47:27'),
(60,'Danielle Panabaker',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:27','2026-03-04 22:47:27'),
(61,'Danielle Nicolet',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:27','2026-03-04 22:47:27'),
(62,'Kayla Compton',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:27','2026-03-04 22:47:27'),
(63,'Bryan Cranston',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:29','2026-03-04 22:47:29'),
(64,'Aaron Paul',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:29','2026-03-04 22:47:29'),
(65,'Anna Gunn',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:29','2026-03-04 22:47:29'),
(66,'RJ Mitte',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:29','2026-03-04 22:47:29'),
(67,'Dean Norris',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:29','2026-03-04 22:47:29'),
(68,'Winona Ryder',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:31','2026-03-04 22:47:31'),
(69,'David Harbour',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:31','2026-03-04 22:47:31'),
(70,'Millie Bobby Brown',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:31','2026-03-04 22:47:31'),
(71,'Finn Wolfhard',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:31','2026-03-04 22:47:31'),
(72,'Gaten Matarazzo',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:31','2026-03-04 22:47:31'),
(73,'Matt Smith',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:37','2026-03-04 22:47:37'),
(74,'Ewan Mitchell',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:37','2026-03-04 22:47:37'),
(75,'Sonoya Mizuno',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:37','2026-03-04 22:47:37'),
(76,'Kurt Egyiawan',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:37','2026-03-04 22:47:37'),
(77,'Matthew Needham',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:37','2026-03-04 22:47:37'),
(78,'Zendaya',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:38','2026-03-04 22:47:38'),
(79,'Hunter Schafer',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:38','2026-03-04 22:47:38'),
(80,'Sydney Sweeney',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:38','2026-03-04 22:47:38'),
(81,'Jacob Elordi',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:38','2026-03-04 22:47:38'),
(82,'Alexa Demie',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:38','2026-03-04 22:47:38'),
(83,'Steven Yeun',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:40','2026-03-04 22:47:40'),
(84,'Sandra Oh',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:40','2026-03-04 22:47:40'),
(85,'J.K. Simmons',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:40','2026-03-04 22:47:40'),
(86,'Anthony Mackie',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:46','2026-03-04 22:47:46'),
(87,'Sebastian Stan',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:46','2026-03-04 22:47:46'),
(88,'Wyatt Russell',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:46','2026-03-04 22:47:46'),
(89,'Erin Kellyman',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:46','2026-03-04 22:47:46'),
(90,'Daniel Brühl',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:46','2026-03-04 22:47:46'),
(91,'Liam Hemsworth',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:55','2026-03-04 22:47:55'),
(92,'Anya Chalotra',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:55','2026-03-04 22:47:55'),
(93,'Freya Allan',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:55','2026-03-04 22:47:55'),
(94,'Joey Batey',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:55','2026-03-04 22:47:55'),
(95,'Eamon Farren',NULL,'cast',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-03-04 22:47:55','2026-03-04 22:47:55');
/*!40000 ALTER TABLE `cast_crew` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `state_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `clips`
--

DROP TABLE IF EXISTS `clips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clips` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` bigint(20) DEFAULT NULL,
  `content_type` varchar(191) DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `poster_url` text DEFAULT NULL,
  `tv_poster_url` text DEFAULT NULL,
  `title` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clips`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `clips` WRITE;
/*!40000 ALTER TABLE `clips` DISABLE KEYS */;
INSERT INTO `clips` VALUES
(1,1,'video','YouTube','https://youtu.be/WI7ePVquOtk?si=VA0nuamHvD-zeS2S','tumse_pyar_lofi_love_mix.png','tumse_pyar_lofi_love_mix.png','Lofi Love Mix Clip','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(2,2,'video','YouTube','https://youtu.be/7cPMriE8fKU?si=Cg3fbsGTtlxUoEMy','seize_your_life.png','seize_your_life.png','Seize Your Life Motivation','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(3,1,'tvshow','YouTube','https://youtu.be/pmLP0QQPqFw?si=kd3uvLlmQeAOIdMw','the_smiling_shadows_poster.png','the_smiling_shadows_thumb.webp','Smiling Shadows Teaser','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(4,21,'movie','YouTube','https://youtu.be/gEF9GiwHTdc?si=dc8Yftad5lk3Iy5Y','operation_viper_poster.png','operation_viper_thumb.png','Operation Viper Action','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(5,3,'video','YouTube','https://youtu.be/JDbwEQG2cqI?si=6BMw5MalDfTdFOsi','serenity_of_nature.png','serenity_of_nature.png','Nature Calmness','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(6,4,'tvshow','YouTube','https://youtu.be/wxL8bVJhXCM?si=vMnSbMh8LJo9POxu','shadow_pursuit_poster.png','shadow_pursuit_thumb.png','Shadow Pursuit Chase','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(7,22,'movie','YouTube','https://youtu.be/9j6p7ajuh-E?si=VRWfLmNsJ5_ujAg0','the_cure_final_redemption_poster.png','the_cure_final_redemption_thumb.png','The Cure Trailer','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(8,6,'video','YouTube','https://youtu.be/wM6exo00T5I?si=gCTV_d4h032YhHzM','echoes_of_valor.png','echoes_of_valor.png','Echoes of Valor Highlight','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(9,4,'video','YouTube','https://youtu.be/RQSmfzfg2MY?si=kPpmh2xnEBDX-7OE','run_for_your_life.png','run_for_your_life.png','Run - Survival Mode','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(10,2,'tvshow','YouTube','https://youtu.be/Z7MMTmVZcVs?si=wMJm7eiVAw4sxMMd','gunslingers_justice_poster.png','gunslingers_justice_thumb.png','Justice Served','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(11,23,'movie','YouTube','https://youtu.be/qokW76nsM4Y?si=mCfHQbDPujKYBb_o','the_gunfighters_redemption_poster.png','the_gunfighters_redemption_thumb.webp','Gunfighter Duel','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(12,5,'video','YouTube','https://youtu.be/oomCIXGzsR0?si=UwoW4DyRpHcyAET6','cityscape_escapade.png','cityscape_escapade.png','City Lights','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(13,3,'tvshow','YouTube','https://youtu.be/a_z4IuxAqpE?si=er9XhFerfQkQAX3g','raziels_daring_rescue_poster.png','raziels_daring_rescue_thumb.png','Raziel Magic Moment','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(14,24,'movie','YouTube','https://youtu.be/_YYmfM2TfUA?si=YZ-U3ucPdf_zBUUr','daizys_enchanted_journey_poster.png','daizys_enchanted_journey_thumb.webp','Enchanted Forest','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(15,7,'video','YouTube','https://youtu.be/LbN9LbuBHk0?si=r-ejAvb48w0a3tic','victory_vibes.png','victory_vibes.png','Winning Moment','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(16,5,'tvshow','YouTube','https://youtu.be/PJlmYh27MHg?si=xkSO89CT6Jd_jor2','veil_of_darkness_poster.png','veil_of_darkness_thumb.png','Darkness Falls','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(17,25,'movie','YouTube','https://youtu.be/LBBni_-tMNs?si=lKOBiWR56U3yy7Gu','secrets_of_zambezia_poster.png','secrets_of_zambezia_thumb.png','Fly High','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(18,8,'video','YouTube','https://youtu.be/xqbb1FCX6wM?si=CtUefpTBezN0tP8-','midnight_thrills.png','midnight_thrills.png','Midnight Scare','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(19,6,'tvshow','YouTube','https://youtu.be/S1i5coU-0_Q?si=YUTmicQFwTWS6DEh','the_hidden_truth_poster.png','the_hidden_truth_thumb.png','Truth Revealed','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(20,26,'movie','YouTube','https://youtu.be/hZ1Rb9hC4JY?si=LELLKsF46bCcc3J9','the_new_empire_poster.png','the_new_empire_thumb.png','Empire Strikes','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(21,9,'video','YouTube','https://youtu.be/gLYTObRhcSY?si=10kFIVk_bL-x-H84','hearts_entwined.png','hearts_entwined.png','Romantic Gaze','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(22,7,'tvshow','YouTube','https://youtu.be/gCQRvfWvdt8?si=KRoGL_s-XoSOKJ-i','the_forgotten_road_poster.png','the_forgotten_road_thumb.png','Forgotten Path','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(23,27,'movie','YouTube','https://youtu.be/usdcpWXPaDY?si=utsn-As0lUuPFtx7','the_daring_player_poster.png','the_daring_player_thumb.webp','Daring Stunt','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(24,10,'video','YouTube','https://youtu.be/uZNRzc3hWvE?si=cpm3hCMCrRJiH7WR','gnomeos_love_stories.png','gnomeos_love_stories.png','Gnomeo Love','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(25,8,'tvshow','YouTube','https://youtu.be/pJCgeOAKXyg?si=Gk5JNJQaMEnimaVK','wolfbound_poster.png','wolfbound_thumb.png','Alpha Wolf','2026-02-18 08:17:59','2026-02-18 08:17:59',NULL);
/*!40000 ALTER TABLE `clips` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `constants`
--

DROP TABLE IF EXISTS `constants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `constants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL DEFAULT '',
  `type` varchar(191) NOT NULL,
  `value` longtext NOT NULL,
  `language_image` varchar(191) DEFAULT NULL,
  `sequence` int(11) NOT NULL DEFAULT 0,
  `sub_type` varchar(191) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `constants`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `constants` WRITE;
/*!40000 ALTER TABLE `constants` DISABLE KEYS */;
INSERT INTO `constants` VALUES
(1,'x265','upload_type','x265',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:11','2026-02-18 08:10:11',NULL),
(2,'Embedded','upload_type','Embedded',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:11','2026-02-18 08:10:11',NULL),
(3,'x265','STREAM_TYPE','x265',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:11','2026-02-18 08:10:11',NULL),
(4,'Change Password','notification_type','change_password',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(5,'Forget Email/Password','notification_type','forget_email_password',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(6,'ID','notification_param_button','id',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(7,'User Name','notification_param_button','user_name',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(8,'Description / Note','notification_param_button','description',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(9,'Your Name','notification_param_button','logged_in_user_fullname',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(10,'Your Position','notification_param_button','logged_in_user_role',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(11,'User\' ID','notification_param_button','user_id',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(12,'User Password','notification_param_button','user_password',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(13,'Site URL','notification_param_button','site_url',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(14,'Episode Name','notification_param_button','episode_name',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(15,'Movie Name','notification_param_button','movie_name',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(16,'Season Name','notification_param_button','season_name',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(17,'TV Show Name','notification_param_button','tvshow_name',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(18,'Expiry Date','notification_param_button','end_date',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(19,'Start Date','notification_param_button','start_date',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(20,'Plan Name','notification_param_button','subscription_plan',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(21,'Content Type','notification_param_button','content_type',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(22,'User','notification_to','user',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(23,'Admin','notification_to','admin',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(24,'Demo Admin','notification_to','demo_admin',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(25,'TV Show Add','notification_type','tv_show_add',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(26,'Movie Add','notification_type','movie_add',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(27,'Episode Add','notification_type','episode_add',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(28,'Season Add','notification_type','season_add',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(29,'New Subscription','notification_type','new_subscription',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(30,'One Time Purchase Content','notification_type','purchase_video',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(31,'Rental Content','notification_type','rent_video',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(32,'Rental Is Expire Soon','notification_type','rent_expiry_reminder',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(33,'One Time Purchase Is Expired Soon','notification_type','purchase_expiry_reminder',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(34,'Cancle Subscription','notification_type','cancle_subscription',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(35,'Video Add','notification_type','video_add',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(36,'Subscription Expiry Reminder','notification_type','subscription_expiry_reminder',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(37,'Expiry Plan','notification_type','expiry_plan',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(38,'Upcoming','notification_type','upcoming',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(39,'Continue Watch','notification_type','continue_watch',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(40,'Parental Control OTP','notification_type','parental_control_otp',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(41,'OTP Code','notification_param_button','otp',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:10:13','2026-02-18 08:10:13',NULL),
(42,'Paid','PAYMENT_STATUS','1',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(43,'Pending','PAYMENT_STATUS','0',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(44,'Pending','PAYMENT_STATUS','0',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(45,'Local','upload_type','Local',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(46,'URL','upload_type','URL',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(47,'YouTube','upload_type','YouTube',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(48,'HLS(M3U8)','upload_type','HLS',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(49,'Vimeo','upload_type','Vimeo',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(50,'x265','upload_type','x265',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(51,'English','movie_language','english','English.png',0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(52,'Hindi','movie_language','hindi','Hindi.png',0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(53,'Tamil','movie_language','tamil','Tamil.png',0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(54,'Telugu','movie_language','telugu','Telugu.png',0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(55,'Malayalam','movie_language','malayalam','Malyalam.png',0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(56,'Spanish','movie_language','spanish','Spanish.png',0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(57,'French','movie_language','french','Freanch.png',0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(58,'Arabic','movie_language','arabic','Arebic.png',0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(59,'German','movie_language','german','German.png',0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(60,'480p','video_quality','480p',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(61,'720p','video_quality','720p',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(62,'1080p','video_quality','1080p',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(63,'1440p','video_quality','1440p',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(64,'2K','video_quality','2K',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(65,'4K','video_quality','4K',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(66,'8K','video_quality','8K',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(67,'URL','STREAM_TYPE','URL',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(68,'YouTube','STREAM_TYPE','YouTube',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(69,'HLS(M3U8)','STREAM_TYPE','HLS',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(70,'Vimeo','STREAM_TYPE','Vimeo',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(71,'Embedded','STREAM_TYPE','Embedded',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(72,'x265','STREAM_TYPE','x265',NULL,0,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(73,'English','subtitle_language','en',NULL,1,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(74,'French','subtitle_language','fr',NULL,2,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(75,'Arebic','subtitle_language','ar',NULL,3,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(76,'Vietnamese','subtitle_language','vi',NULL,4,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(77,'Spanish','subtitle_language','es',NULL,5,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(78,'Dutch','subtitle_language','nl',NULL,7,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(79,'Portuguese','subtitle_language','pt',NULL,6,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL);
/*!40000 ALTER TABLE `constants` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `continue_watch`
--

DROP TABLE IF EXISTS `continue_watch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `continue_watch` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entertainment_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `entertainment_type` varchar(191) DEFAULT NULL,
  `watched_time` varchar(191) DEFAULT NULL,
  `total_watched_time` varchar(191) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `episode_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `continue_watch_user_id_profile_id_deleted_at_index` (`user_id`,`profile_id`,`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `continue_watch`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `continue_watch` WRITE;
/*!40000 ALTER TABLE `continue_watch` DISABLE KEYS */;
INSERT INTO `continue_watch` VALUES
(1,28,3,3,'movie','00:03:00','00:03:00',3,3,NULL,'2024-09-26 11:12:14','2024-09-26 11:12:14',NULL,NULL),
(2,99,3,3,'movie','00:06:00','00:06:00',3,3,NULL,'2024-09-26 11:13:01','2024-09-26 11:13:01',NULL,NULL),
(3,87,3,3,'movie','00:02:00','00:02:00',3,3,NULL,'2024-09-26 11:13:37','2024-09-26 11:13:37',NULL,NULL),
(4,13,3,3,'tvshow','00:04:00','00:04:00',3,3,NULL,'2024-09-26 11:14:40','2024-09-26 11:14:40',NULL,41),
(5,4,3,3,'tvshow','00:05:00','00:05:00',3,3,NULL,'2024-09-26 11:15:31','2024-09-26 11:15:31',NULL,15),
(6,1,3,3,'tvshow','00:01:00','00:01:00',3,3,NULL,'2024-09-26 11:16:55','2024-09-26 11:20:23',NULL,1),
(7,18,3,3,'tvshow','00:05:00','00:05:00',3,3,NULL,'2024-09-26 11:17:54','2024-09-26 11:17:54',NULL,61),
(8,26,3,3,'movie','00:02:00','00:02:00',3,3,NULL,'2024-09-26 11:18:35','2024-09-26 11:18:35',NULL,NULL),
(9,30,3,3,'movie','00:03:00','00:03:00',3,3,NULL,'2024-09-26 11:19:18','2024-09-26 11:19:18',NULL,NULL),
(10,2,3,3,'tvshow','00:04:00','00:04:00',3,3,NULL,'2024-09-26 11:19:38','2024-09-26 11:19:38',NULL,9),
(11,80,14,14,'movie','00:03:00','00:03:00',14,14,NULL,'2024-09-26 11:22:09','2024-09-26 11:22:09',NULL,NULL),
(12,83,14,14,'movie','00:04:00','00:04:00',14,14,NULL,'2024-09-26 11:23:03','2024-09-26 11:23:03',NULL,NULL),
(13,63,14,14,'movie','00:02:00','00:02:00',14,14,NULL,'2024-09-26 11:24:10','2024-09-26 11:24:10',NULL,NULL),
(14,1,14,14,'tvshow','00:01:00','00:01:00',14,14,NULL,'2024-09-26 11:25:25','2024-09-26 11:25:25',NULL,8),
(15,20,14,14,'tvshow','00:03:00','00:03:00',14,14,NULL,'2024-09-26 11:26:16','2024-09-26 11:26:16',NULL,70),
(16,19,14,14,'tvshow','00:02:00','00:02:00',14,14,NULL,'2024-09-26 11:26:39','2024-09-26 11:26:39',NULL,64),
(17,1,16,29,'video','00:00:07','03:41:54',16,16,NULL,'2026-02-21 13:47:06','2026-02-21 13:47:06',NULL,NULL);
/*!40000 ALTER TABLE `continue_watch` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `dial_code` int(11) DEFAULT NULL,
  `currency_name` varchar(191) DEFAULT NULL,
  `symbol` varchar(191) DEFAULT NULL,
  `currency_code` varchar(191) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES
(1,'AF','Afghanistan',93,'Afghan Afghani','؋','AFN',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(2,'AL','Albania',355,'Albanian Lek','Lek','ALL',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(3,'DZ','Algeria',213,'Algerian Dinar','د.ج','DZD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(4,'AS','American Samoa',1684,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(5,'AD','Andorra',376,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(6,'AO','Angola',244,'Angolan Kwanza','Kz','AOA',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(7,'AI','Anguilla',1264,'East Caribbean Dollar','$','XCD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(8,'AQ','Antarctica',0,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(9,'AG','Antigua And Barbuda',1268,'East Caribbean Dollar','$','XCD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(10,'AR','Argentina',54,'Argentine Peso','$','ARS',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(11,'AM','Armenia',374,'Armenian Dram','֏','AMD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(12,'AW','Aruba',297,'Aruban Florin','ƒ','AWG',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(13,'AU','Australia',61,'Australian Dollar','$','AUD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(14,'AT','Austria',43,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(15,'AZ','Azerbaijan',994,'Azerbaijani Manat','₼','AZN',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(16,'BS','Bahamas The',1242,'Bahamian Dollar','$','BSD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(17,'BH','Bahrain',973,'Bahraini Dinar','ب.د','BHD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(18,'BD','Bangladesh',880,'Bangladeshi Taka','৳','BDT',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(19,'BB','Barbados',1246,'Barbadian Dollar','$','BBD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(20,'BY','Belarus',375,'Belarusian Ruble','Br','BYN',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(21,'BE','Belgium',32,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(22,'BZ','Belize',501,'Belize Dollar','$','BZD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(23,'BJ','Benin',229,'West African CFA franc','Fr','XOF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(24,'BM','Bermuda',1441,'Bermudian Dollar','$','BMD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(25,'BT','Bhutan',975,'Bhutanese Ngultrum','Nu.','BTN',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(26,'BO','Bolivia',591,'Bolivian Boliviano','Bs.','BOB',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(27,'BA','Bosnia and Herzegovina',387,'Bosnia and Herzegovina Convertible Mark','КМ','BAM',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(28,'BW','Botswana',267,'Botswana Pula','P','BWP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(29,'BV','Bouvet Island',0,'Norwegian Krone','kr','NOK',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(30,'BR','Brazil',55,'Brazilian Real','R$','BRL',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(31,'IO','British Indian Ocean Territory',246,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(32,'BN','Brunei',673,'Brunei Dollar','$','BND',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(33,'BG','Bulgaria',359,'Bulgarian Lev','лв.','BGN',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(34,'BF','Burkina Faso',226,'West African CFA franc','Fr','XOF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(35,'BI','Burundi',257,'Burundian Franc','Fr','BIF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(36,'KH','Cambodia',855,'Cambodian Riel','៛','KHR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(37,'CM','Cameroon',237,'Central African CFA franc','Fr','XAF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(38,'CA','Canada',1,'Canadian Dollar','$','CAD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(39,'CV','Cape Verde',238,'Cape Verdean Escudo','$','CVE',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(40,'KY','Cayman Islands',1345,'Cayman Islands Dollar','$','KYD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(41,'CF','Central African Republic',236,'Central African CFA franc','Fr','XAF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(42,'TD','Chad',235,'Central African CFA franc','Fr','XAF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(43,'CL','Chile',56,'Chilean Peso','$','CLP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(44,'CN','China',86,'Chinese Yuan','¥','CNY',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(45,'CX','Christmas Island',61,'Australian Dollar','$','AUD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(46,'CC','Cocos (Keeling) Islands',672,'Australian Dollar','$','AUD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(47,'CO','Colombia',57,'Colombian Peso','$','COP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(48,'KM','Comoros',269,'Comorian Franc','Fr','KMF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(49,'CG','Republic Of The Congo',242,'Central African CFA franc','Fr','XAF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(50,'CD','Democratic Republic Of The Congo',242,'Congolese Franc','Fr','CDF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(51,'CK','Cook Islands',682,'New Zealand Dollar','$','NZD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(52,'CR','Costa Rica',506,'Costa Rican Colon','₡','CRC',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(53,'CI','Cote D\'Ivoire (Ivory Coast)',225,'West African CFA franc','Fr','XOF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(54,'HR','Croatia (Hrvatska)',385,'Croatian Kuna','kn','HRK',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(55,'CU','Cuba',53,'Cuban Peso','$','CUP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(56,'CY','Cyprus',357,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(57,'CZ','Czech Republic',420,'Czech Koruna','Kč','CZK',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(58,'DK','Denmark',45,'Danish Krone','kr','DKK',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(59,'DJ','Djibouti',253,'Djiboutian Franc','Fr','DJF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(60,'DM','Dominica',1767,'East Caribbean Dollar','$','XCD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(61,'DO','Dominican Republic',1809,'Dominican Peso','$','DOP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(62,'TP','East Timor',670,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(63,'EC','Ecuador',593,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(64,'EG','Egypt',20,'Egyptian Pound','E£','EGP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(65,'SV','El Salvador',503,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(66,'GQ','Equatorial Guinea',240,'Central African CFA franc','Fr','XAF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(67,'ER','Eritrea',291,'Eritrean Nakfa','Nfk','ERN',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(68,'EE','Estonia',372,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(69,'ET','Ethiopia',251,'Ethiopian Birr','Br','ETB',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(70,'XA','External Territories of Australia',61,'Australian Dollar','$','AUD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(71,'FK','Falkland Islands',500,'Falkland Islands Pound','£','FKP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(72,'FO','Faroe Islands',298,'Danish Krone','kr','DKK',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(73,'FJ','Fiji Islands',679,'Fijian Dollar','$','FJD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(74,'FI','Finland',358,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(75,'FR','France',33,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(76,'GF','French Guiana',594,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(77,'PF','French Polynesia',689,'CFP Franc','Fr','XPF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(78,'TF','French Southern Territories',0,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(79,'GA','Gabon',241,'Central African CFA franc','Fr','XAF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(80,'GM','Gambia The',220,'Gambian Dalasi','D','GMD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(81,'GE','Georgia',995,'Georgian Lari','ლ','GEL',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(82,'DE','Germany',49,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(83,'GH','Ghana',233,'Ghanaian Cedi','₵','GHS',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(84,'GI','Gibraltar',350,'Gibraltar Pound','£','GIP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(85,'GR','Greece',30,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(86,'GL','Greenland',299,'Danish Krone','kr','DKK',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(87,'GD','Grenada',1473,'East Caribbean Dollar','$','XCD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(88,'GP','Guadeloupe',590,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(89,'GU','Guam',1671,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(90,'GT','Guatemala',502,'Guatemalan Quetzal','Q','GTQ',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(91,'XU','Guernsey and Alderney',44,'Pound Sterling','£','GBP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(92,'GN','Guinea',224,'Guinean Franc','Fr','GNF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(93,'GW','Guinea-Bissau',245,'West African CFA franc','Fr','XOF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(94,'GY','Guyana',592,'Guyanaese Dollar','$','GYD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(95,'HT','Haiti',509,'Haitian Gourde','G','HTG',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(96,'HM','Heard and McDonald Islands',0,'Australian Dollar','$','AUD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(97,'HN','Honduras',504,'Honduran Lempira','L','HNL',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(98,'HK','Hong Kong S.A.R.',852,'Hong Kong Dollar','$','HKD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(99,'HU','Hungary',36,'Hungarian Forint','Ft','HUF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(100,'IS','Iceland',354,'Icelandic Krona','kr','ISK',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(101,'IN','India',91,'Indian Rupee','₹','INR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(102,'ID','Indonesia',62,'Indonesian Rupiah','Rp','IDR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(103,'IR','Iran',98,'Iranian Rial','﷼','IRR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(104,'IQ','Iraq',964,'Iraqi Dinar','ع.د','IQD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(105,'IE','Ireland',353,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(106,'IL','Israel',972,'Israeli New Shekel','₪','ILS',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(107,'IT','Italy',39,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(108,'JM','Jamaica',1876,'Jamaican Dollar','$','JMD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(109,'JP','Japan',81,'Japanese Yen','¥','JPY',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(110,'XJ','Jersey',44,'Pound Sterling','£','GBP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(111,'JO','Jordan',962,'Jordanian Dinar','د.ا','JOD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(112,'KZ','Kazakhstan',7,'Kazakhstani Tenge','〒','KZT',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(113,'KE','Kenya',254,'Kenyan Shilling','Sh','KES',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(114,'KI','Kiribati',686,'Australian Dollar','$','AUD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(115,'KP','Korea North',850,'North Korean Won','₩','KPW',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(116,'KR','Korea South',82,'South Korean Won','₩','KRW',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(117,'KW','Kuwait',965,'Kuwaiti Dinar','د.ك','KWD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(118,'KG','Kyrgyzstan',996,'Kyrgyzstani Som','с','KGS',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(119,'LA','Laos',856,'Lao Kip','₭','LAK',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(120,'LV','Latvia',371,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(121,'LB','Lebanon',961,'Lebanese Pound','ل.ل','LBP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(122,'LS','Lesotho',266,'Lesotho Loti','L','LSL',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(123,'LR','Liberia',231,'Liberian Dollar','$','LRD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(124,'LY','Libya',218,'Libyan Dinar','ل.د','LYD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(125,'LI','Liechtenstein',423,'Swiss Franc','Fr','CHF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(126,'LT','Lithuania',370,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(127,'LU','Luxembourg',352,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(128,'MO','Macau S.A.R.',853,'Macanese Pataca','MOP$','MOP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(129,'MK','Macedonia',389,'Macedonian Denar','ден','MKD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(130,'MG','Madagascar',261,'Malagasy Ariary','Ar','MGA',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(131,'MW','Malawi',265,'Malawian Kwacha','MK','MWK',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(132,'MY','Malaysia',60,'Malaysian Ringgit','RM','MYR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(133,'MV','Maldives',960,'Maldivian Rufiyaa','.ރ','MVR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(134,'ML','Mali',223,'West African CFA franc','Fr','XOF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(135,'MT','Malta',356,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(136,'XM','Man (Isle of)',44,'Pound Sterling','£','GBP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(137,'MH','Marshall Islands',692,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(138,'MQ','Martinique',596,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(139,'MR','Mauritania',222,'Mauritanian Ouguiya','UM','MRU',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(140,'MU','Mauritius',230,'Mauritian Rupee','₨','MUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(141,'YT','Mayotte',269,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(142,'MX','Mexico',52,'Mexican Peso','$','MXN',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(143,'FM','Micronesia',691,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(144,'MD','Moldova',373,'Moldovan Leu','L','MDL',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(145,'MC','Monaco',377,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(146,'MN','Mongolia',976,'Mongolian Tugrik','₮','MNT',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(147,'MS','Montserrat',1664,'East Caribbean Dollar','$','XCD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(148,'MA','Morocco',212,'Moroccan Dirham','DH','MAD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(149,'MZ','Mozambique',258,'Mozambican Metical','MT','MZN',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(150,'MM','Myanmar',95,'Myanmar Kyat','Ks','MMK',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(151,'NA','Namibia',264,'Namibian Dollar','$','NAD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(152,'NR','Nauru',674,'Australian Dollar','$','AUD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(153,'NP','Nepal',977,'Nepalese Rupee','₨','NPR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(154,'AN','Netherlands Antilles',599,'Netherlands Antillean Guilder','ƒ','ANG',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(155,'NL','Netherlands The',31,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(156,'NC','New Caledonia',687,'CFP Franc','Fr','XPF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(157,'NZ','New Zealand',64,'New Zealand Dollar','$','NZD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(158,'NI','Nicaragua',505,'Nicaraguan Cordoba','C$','NIO',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(159,'NE','Niger',227,'West African CFA franc','Fr','XOF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(160,'NG','Nigeria',234,'Nigerian Naira','₦','NGN',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(161,'NU','Niue',683,'New Zealand Dollar','$','NZD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(162,'NF','Norfolk Island',672,'Australian Dollar','$','AUD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(163,'MP','Northern Mariana Islands',1670,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(164,'NO','Norway',47,'Norwegian Krone','kr','NOK',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(165,'OM','Oman',968,'Omani Rial','ر.ع.','OMR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(166,'PK','Pakistan',92,'Pakistani Rupee','₨','PKR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(167,'PW','Palau',680,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(168,'PS','Palestinian Territory Occupied',970,'Israeli New Shekel','₪','ILS',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(169,'PA','Panama',507,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(170,'PG','Papua new Guinea',675,'Papua New Guinean Kina','K','PGK',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(171,'PY','Paraguay',595,'Paraguayan Guarani','₲','PYG',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(172,'PE','Peru',51,'Peruvian Nuevo Sol','S/.','PEN',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(173,'PH','Philippines',63,'Philippine Peso','₱','PHP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(174,'PN','Pitcairn Island',0,'New Zealand Dollar','$','NZD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(175,'PL','Poland',48,'Polish Zloty','zł','PLN',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(176,'PT','Portugal',351,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(177,'PR','Puerto Rico',1787,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(178,'QA','Qatar',974,'Qatari Rial','ر.ق','QAR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(179,'RE','Reunion',262,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(180,'RO','Romania',40,'Romanian Leu','lei','RON',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(181,'RU','Russia',7,'Russian Ruble','₽','RUB',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(182,'RW','Rwanda',250,'Rwandan Franc','Fr','RWF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(183,'SH','Saint Helena',290,'Saint Helena Pound','£','SHP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(184,'KN','Saint Kitts And Nevis',1869,'East Caribbean Dollar','$','XCD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(185,'LC','Saint Lucia',1758,'East Caribbean Dollar','$','XCD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(186,'PM','Saint Pierre and Miquelon',508,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(187,'VC','Saint Vincent And The Grenadines',1784,'East Caribbean Dollar','$','XCD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(188,'WS','Samoa',684,'Samoan Tala','T','WST',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(189,'SM','San Marino',378,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(190,'ST','Sao Tome and Principe',239,'Sao Tome and Principe Dobra','Db','STN',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(191,'SA','Saudi Arabia',966,'Saudi Riyal','ر.س','SAR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(192,'SN','Senegal',221,'West African CFA franc','Fr','XOF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(193,'RS','Serbia',381,'Serbian Dinar','дин.','RSD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(194,'SC','Seychelles',248,'Seychellois Rupee','₨','SCR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(195,'SL','Sierra Leone',232,'Sierra Leonean Leone','Le','SLL',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(196,'SG','Singapore',65,'Singapore Dollar','$','SGD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(197,'SK','Slovakia',421,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(198,'SI','Slovenia',386,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(199,'SB','Solomon Islands',677,'Solomon Islands Dollar','$','SBD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(200,'SO','Somalia',252,'Somali Shilling','Sh','SOS',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(201,'ZA','South Africa',27,'South African Rand','R','ZAR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(202,'GS','South Georgia',0,'British Pound Sterling','£','GBP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(203,'SS','South Sudan',211,'South Sudanese Pound','£','SSP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(204,'ES','Spain',34,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(205,'LK','Sri Lanka',94,'Sri Lankan Rupee','₨','LKR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(206,'SD','Sudan',249,'Sudanese Pound','ج.س.','SDG',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(207,'SR','Suriname',597,'Surinamese Dollar','$','SRD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(208,'SJ','Svalbard And Jan Mayen Islands',47,'Norwegian Krone','kr','NOK',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(209,'SZ','Swaziland',268,'Swazi Lilangeni','L','SZL',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(210,'SE','Sweden',46,'Swedish Krona','kr','SEK',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(211,'CH','Switzerland',41,'Swiss Franc','Fr','CHF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(212,'SY','Syria',963,'Syrian Pound','£','SYP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(213,'TW','Taiwan',886,'Taiwan Dollar','NT$','TWD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(214,'TJ','Tajikistan',992,'Tajikistani Somoni','ЅМ','TJS',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(215,'TZ','Tanzania',255,'Tanzanian Shilling','Sh','TZS',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(216,'TH','Thailand',66,'Thai Baht','฿','THB',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(217,'TG','Togo',228,'West African CFA franc','Fr','XOF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(218,'TK','Tokelau',690,'New Zealand Dollar','$','NZD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(219,'TO','Tonga',676,'Tongan Pa\'anga','T$','TOP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(220,'TT','Trinidad And Tobago',1868,'Trinidad and Tobago Dollar','$','TTD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(221,'TN','Tunisia',216,'Tunisian Dinar','د.ت','TND',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(222,'TR','Turkey',90,'Turkish Lira','₺','TRY',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(223,'TM','Turkmenistan',993,'Turkmenistani Manat','m','TMT',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(224,'TC','Turks And Caicos Islands',1649,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(225,'TV','Tuvalu',688,'Australian Dollar','$','AUD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(226,'UG','Uganda',256,'Ugandan Shilling','Sh','UGX',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(227,'UA','Ukraine',380,'Ukrainian Hryvnia','₴','UAH',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(228,'AE','United Arab Emirates',971,'United Arab Emirates Dirham','د.إ','AED',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(229,'GB','United Kingdom',44,'British Pound Sterling','£','GBP',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(230,'US','United States',1,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(231,'UM','United States Minor Outlying Islands',1,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(232,'UY','Uruguay',598,'Uruguayan Peso','$','UYU',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(233,'UZ','Uzbekistan',998,'Uzbekistani Som','лв','UZS',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(234,'VU','Vanuatu',678,'Vanuatu Vatu','VT','VUV',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(235,'VA','Vatican City State (Holy See)',39,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(236,'VE','Venezuela',58,'Venezuelan Bolivar','Bs.','VES',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(237,'VN','Vietnam',84,'Vietnamese Dong','₫','VND',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(238,'VG','Virgin Islands (British)',1284,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(239,'VI','Virgin Islands (US)',1340,'United States Dollar','$','USD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(240,'WF','Wallis And Futuna Islands',681,'CFP Franc','Fr','XPF',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(241,'EH','Western Sahara',212,'Moroccan Dirham','DH','MAD',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(242,'YE','Yemen',967,'Yemeni Rial','﷼','YER',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(243,'YU','Yugoslavia',38,'Yugoslavian Dinar','дин.','YUN',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(244,'ZM','Zambia',260,'Zambian Kwacha','ZK','ZMW',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(245,'ZW','Zimbabwe',263,'Zimbabwean Dollar','$','ZWL',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(246,'AX','Åland Islands',358,'Euro','€','EUR',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `coupon_subscription_plan`
--

DROP TABLE IF EXISTS `coupon_subscription_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_subscription_plan` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `coupon_id` bigint(20) unsigned NOT NULL,
  `subscription_plan_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `coupon_subscription_plan_coupon_id_foreign` (`coupon_id`),
  KEY `coupon_subscription_plan_subscription_plan_id_foreign` (`subscription_plan_id`),
  CONSTRAINT `coupon_subscription_plan_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `coupon_subscription_plan_subscription_plan_id_foreign` FOREIGN KEY (`subscription_plan_id`) REFERENCES `plan` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon_subscription_plan`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `coupon_subscription_plan` WRITE;
/*!40000 ALTER TABLE `coupon_subscription_plan` DISABLE KEYS */;
INSERT INTO `coupon_subscription_plan` VALUES
(1,1,1),
(2,1,4),
(3,2,4),
(4,2,5),
(5,2,6),
(6,3,1),
(7,3,2),
(8,3,3),
(9,3,4),
(10,3,5),
(11,3,6),
(12,4,3),
(13,4,5),
(14,4,6),
(15,5,1),
(16,5,2),
(17,5,3),
(18,5,4),
(19,5,5),
(20,5,6);
/*!40000 ALTER TABLE `coupon_subscription_plan` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `discount_type` enum('fixed','percentage') NOT NULL,
  `discount` decimal(8,2) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupons_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES
(1,'WELCOME20','Welcome offer - Get 20% off ','2026-02-18','2026-05-18','percentage',20.00,1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(2,'SAVE50','Save 50% on annual plans - Limited time offer','2026-02-18','2026-08-18','percentage',50.00,1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(3,'SUMMER25','Summer special - 25% discount ','2026-02-18','2026-03-20','percentage',25.00,1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(4,'FLAT10','Flat $10 discount ','2026-02-18','2026-04-18','fixed',10.00,1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(5,'NEWYEAR30','New Year celebration - 30% off ','2026-02-18','2026-03-18','percentage',30.00,1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL);
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `currency_name` varchar(191) NOT NULL,
  `currency_symbol` varchar(191) DEFAULT NULL,
  `currency_code` varchar(191) NOT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `currency_position` enum('left','right','left_with_space','right_with_space') NOT NULL DEFAULT 'left',
  `no_of_decimal` int(10) unsigned NOT NULL,
  `thousand_separator` varchar(191) DEFAULT NULL,
  `decimal_separator` varchar(191) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` VALUES
(1,'United States Dollar','$','USD',0,'left',2,',','.',2,2,NULL,'2024-07-30 07:18:52','2026-02-18 14:25:30',NULL),
(2,'Euro','€','EUR',0,'left',2,',','.',2,2,NULL,'2024-07-30 07:19:08','2024-07-30 07:19:08',NULL),
(3,'Indian Rupee','₹','INR',1,'left',2,',','.',2,15,NULL,'2024-07-30 07:19:52','2026-02-18 14:25:30',NULL);
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `custom_ads_setting`
--

DROP TABLE IF EXISTS `custom_ads_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_ads_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL,
  `url_type` varchar(191) NOT NULL,
  `placement` varchar(191) DEFAULT NULL,
  `media` varchar(191) DEFAULT NULL,
  `redirect_url` varchar(191) DEFAULT NULL,
  `duration` varchar(191) DEFAULT NULL,
  `skip_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `skip_after` varchar(191) DEFAULT NULL,
  `target_content_type` varchar(191) DEFAULT NULL,
  `target_categories` longtext DEFAULT NULL,
  `max_views` int(11) DEFAULT NULL,
  `is_enable` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_ads_setting`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `custom_ads_setting` WRITE;
/*!40000 ALTER TABLE `custom_ads_setting` DISABLE KEYS */;
INSERT INTO `custom_ads_setting` VALUES
(1,'BigSale','image','local','home_page','pexels-kyle-loftus-1280314238-32439172.jpg',NULL,NULL,0,NULL,NULL,'[]',NULL,0,1,'2026-02-18','2027-02-18','2025-08-12 07:38:23','2026-02-18 08:17:59',NULL),
(2,'MovieTicket','image','local','home_page','pexels-kyle-loftus-1280314238-32439172.jpg',NULL,NULL,0,NULL,NULL,'[]',NULL,0,1,'2026-02-18','2027-02-18','2025-08-12 07:39:08','2026-02-18 08:17:59',NULL),
(3,'EpisodePromo','image','local','home_page','pexels-minhle17vn-3062545.jpg',NULL,NULL,0,NULL,NULL,'[]',NULL,0,1,'2026-02-18','2027-02-18','2025-08-12 07:40:35','2026-02-18 08:17:59',NULL),
(4,'ServicePromo','image','local','home_page','pexels-ron-lach-9627162.jpg',NULL,NULL,0,NULL,NULL,'[]',NULL,0,1,'2026-02-18','2027-02-18','2025-08-12 07:41:21','2026-02-18 08:17:59',NULL),
(5,'GamingEvent','image','local','player','pexels-ron-lach-9627169.jpg',NULL,NULL,0,NULL,'movie','[29,31,34,36,42,83]',NULL,0,1,'2026-02-18','2027-02-18','2025-08-12 07:43:53','2026-02-18 08:17:59',NULL),
(6,'FashionLine','image','local','player','pexels-minhle17vn-3062545.jpg',NULL,NULL,0,NULL,'video','[7,8,9,11,31,32,33,34]',NULL,0,1,'2026-02-18','2027-02-18','2025-08-12 07:51:40','2026-02-18 08:17:59',NULL),
(7,'NewMusicAlbum','image','local','banner','pexels-kyle-loftus-1280314238-32439172.jpg',NULL,NULL,0,NULL,'movie','[88,89,91,103]',NULL,0,1,'2026-02-18','2027-02-18','2025-08-12 07:53:36','2026-02-18 08:17:59',NULL),
(8,'StreamingSvc','image','local','banner','pexels-ron-lach-9627169.jpg',NULL,NULL,0,NULL,'video','[12,15,16]',NULL,0,1,'2026-02-18','2027-02-18','2025-08-12 07:55:05','2026-02-18 08:17:59',NULL),
(9,'GamingPromo','image','local','banner','pexels-ron-lach-9627162.jpg',NULL,NULL,0,NULL,'tvshow','[15,16,21,22]',NULL,0,1,'2026-02-18','2027-02-18','2025-08-12 07:56:26','2026-02-18 08:17:59',NULL);
/*!40000 ALTER TABLE `custom_ads_setting` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `session_id` varchar(191) DEFAULT NULL,
  `last_activity` timestamp NULL DEFAULT NULL,
  `device_id` varchar(191) DEFAULT NULL,
  `device_name` varchar(191) DEFAULT NULL,
  `active_profile` varchar(191) DEFAULT NULL,
  `platform` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `devices_session_id_index` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
INSERT INTO `devices` VALUES
(2,17,'8IHqZQDglSWhMP5D44gmCriQmShgMsEAKSeSrnVA','2026-02-22 18:27:35','AP3A.240617.008','realme(RMX3686)','31','Android','2026-02-22 18:27:35','2026-02-22 18:27:35',NULL),
(5,22,'iCbkbOrSsKiTgr073JNu0lfu2B80bBtMf3Ts5ARd','2026-04-04 06:41:22','BQ2A.250610.001-BP2A.250605.031.A3_V000L1','vivo(V2415)','35','Android','2026-04-04 06:41:22','2026-04-04 06:41:22',NULL),
(7,23,'tPFwaWScUNw0agHgqQET9fWigns57L1TUPL7b8TP','2026-05-01 11:26:51','RP1A.200720.011','Infinix(Infinix X697)','37','Android','2026-05-01 11:26:51','2026-05-01 11:26:51',NULL),
(8,24,'05xxSkJalmPJADsrjZkqKVcG1CEVv88hOPGZoauO','2026-05-09 10:24:07','BP2A.250605.015','OPPO(CPH2695)','39','Android','2026-05-09 10:24:07','2026-05-09 10:24:07',NULL),
(12,28,'Ldfw8OcX8tszRmFLIWzvyYQ49cBxS9RO4yG5t2EH','2026-06-02 17:34:13','UP1A.231005.007','Infinix(Infinix X6531B)','47','Android','2026-06-02 17:34:13','2026-06-02 17:34:13',NULL),
(13,29,'QR32OadJjA6tLK2O62Pd5MJAupWhsDGUfVPHPO77','2026-06-03 06:07:19','test123','Android',NULL,'android','2026-06-03 06:07:19','2026-06-03 06:07:19',NULL),
(15,3,'Cp0XEZEFfe4V24stWKmeMwLbHeBCedIqqCxJmNE6','2026-06-05 05:04:15','test','test',NULL,'android','2026-06-05 05:04:15','2026-06-05 05:04:15',NULL),
(16,30,'80bbGZXGiahssrDi5fQYzD3BTGAoFVjvOGuVmvIV','2026-06-05 14:26:05','1C85DCD3-19A7-47D8-B5CE-97349759C618','iPad',NULL,'iOS','2026-06-05 14:26:05','2026-06-05 14:26:05',NULL),
(20,16,'673wbqewNE4JktmSKDrSuuf5CoJEldWIvhO4MI1J','2026-06-07 02:55:36','UP1A.231005.007','Redmi(22101316UP)',NULL,'Android','2026-06-07 02:55:36','2026-06-07 02:55:36',NULL);
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `entertainment_country_mapping`
--

DROP TABLE IF EXISTS `entertainment_country_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entertainment_country_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entertainment_id` bigint(20) NOT NULL,
  `country_id` bigint(20) NOT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=227 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entertainment_country_mapping`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `entertainment_country_mapping` WRITE;
/*!40000 ALTER TABLE `entertainment_country_mapping` DISABLE KEYS */;
INSERT INTO `entertainment_country_mapping` VALUES
(1,1,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(2,1,45,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(3,1,78,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(4,1,25,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(5,2,12,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(6,2,35,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(7,2,55,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(8,3,2,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(9,3,8,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(10,3,20,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(11,4,1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(12,4,64,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(13,4,23,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(14,4,78,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(15,5,19,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(16,5,46,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(17,5,88,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(18,5,246,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(19,6,152,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(20,6,225,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(21,6,188,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(22,7,111,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(23,7,158,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(24,7,68,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(25,7,95,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(26,8,110,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(27,8,96,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(28,8,83,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(29,9,5,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(30,9,145,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(31,10,122,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(32,10,118,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(33,10,128,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(34,11,221,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(35,12,200,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(36,12,100,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(37,13,99,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(38,13,199,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(39,14,9,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(40,14,19,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(41,14,29,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(42,15,8,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(43,15,18,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(44,15,28,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(45,16,7,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(46,16,17,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(47,16,27,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(48,16,37,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(49,17,47,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(50,17,57,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(51,17,67,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(52,18,177,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(53,18,167,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(54,18,157,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(55,19,197,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(56,20,187,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(57,20,137,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(58,21,1,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(59,21,100,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(60,21,225,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(61,21,91,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(62,22,1,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(63,22,100,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(64,22,225,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(65,23,126,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(66,23,226,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(67,24,26,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(68,24,46,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(69,25,221,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(70,25,101,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(71,26,101,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(72,26,212,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(73,26,220,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(74,27,221,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(75,27,227,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(76,27,117,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(77,27,37,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(78,28,154,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(79,28,174,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(80,28,24,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(81,28,34,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(82,29,244,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(83,30,144,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(84,30,156,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(85,31,177,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(86,31,58,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(87,32,199,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(88,32,69,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(89,33,129,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(90,33,77,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(91,34,48,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(92,34,12,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(93,35,224,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(94,36,268,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(95,37,46,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(96,37,246,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(97,38,222,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(98,39,169,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(99,39,78,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(100,40,168,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(101,40,72,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(102,41,18,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(103,41,49,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(104,41,167,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(105,42,154,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(106,42,137,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(107,43,125,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(108,43,197,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(109,44,197,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(110,45,139,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(111,45,101,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(112,46,160,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(113,46,170,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(114,47,145,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(115,48,117,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(116,48,101,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(117,49,2,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(118,49,1,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(119,50,72,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(120,50,76,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(121,51,101,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(122,52,49,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(123,52,38,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(124,53,19,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(125,53,72,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(126,54,37,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(127,54,49,NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(128,55,139,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(129,55,239,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(130,56,231,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(131,56,238,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(132,57,101,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(133,57,208,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(134,58,209,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(135,58,206,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(136,59,212,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(137,59,219,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(138,60,229,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(139,60,224,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(140,61,101,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(141,61,29,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(142,62,36,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(143,62,45,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(144,63,220,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(145,64,7,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(146,64,180,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(147,65,19,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(148,65,80,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(149,66,70,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(150,66,99,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(151,67,30,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(152,67,40,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(153,68,70,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(154,68,80,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(155,69,79,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(156,69,37,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(157,70,78,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(158,70,49,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(159,70,58,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(160,71,7,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(161,71,17,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(162,71,27,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(163,71,37,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(164,72,7,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(165,72,17,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(166,72,27,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(167,73,70,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(168,73,17,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(169,73,246,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(170,74,101,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(171,75,240,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(172,76,49,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(173,76,28,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(174,77,74,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(175,77,82,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(176,78,38,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(177,78,101,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(178,78,49,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(179,79,46,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(180,79,28,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(181,80,10,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(182,80,20,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(183,81,49,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(184,81,2,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(185,82,17,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(186,83,7,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(187,83,25,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(188,84,27,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(189,84,37,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(190,85,210,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(191,85,187,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(192,86,120,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(193,86,180,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(194,87,230,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(195,87,17,NULL,NULL,NULL,'2026-02-18 08:17:56','2026-02-18 08:17:56',NULL),
(196,88,2,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(197,88,9,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(198,89,27,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(199,89,37,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(200,90,220,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(201,90,77,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(202,91,27,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(203,91,37,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(204,92,2,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(205,92,37,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(206,93,27,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(207,93,37,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(208,94,27,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(209,94,37,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(210,95,37,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(211,96,27,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(212,96,37,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(213,97,27,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(214,97,37,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(215,98,27,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(216,98,37,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(217,99,27,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(218,99,37,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(219,100,27,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(220,100,37,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(221,101,27,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(222,101,37,NULL,NULL,NULL,'2026-02-18 08:17:57','2026-02-18 08:17:57',NULL),
(223,102,27,NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL),
(224,102,37,NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL),
(225,103,27,NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL),
(226,103,37,NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL);
/*!40000 ALTER TABLE `entertainment_country_mapping` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `entertainment_download_mapping`
--

DROP TABLE IF EXISTS `entertainment_download_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entertainment_download_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entertainment_id` int(11) DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `quality` varchar(191) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entertainment_download_mapping`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `entertainment_download_mapping` WRITE;
/*!40000 ALTER TABLE `entertainment_download_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `entertainment_download_mapping` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `entertainment_downloads`
--

DROP TABLE IF EXISTS `entertainment_downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entertainment_downloads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entertainment_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `entertainment_type` varchar(191) DEFAULT NULL,
  `is_download` tinyint(1) NOT NULL DEFAULT 0,
  `type` varchar(191) DEFAULT NULL,
  `quality` varchar(191) DEFAULT NULL,
  `device_id` varchar(191) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entertainment_downloads`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `entertainment_downloads` WRITE;
/*!40000 ALTER TABLE `entertainment_downloads` DISABLE KEYS */;
/*!40000 ALTER TABLE `entertainment_downloads` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `entertainment_gener_mapping`
--

DROP TABLE IF EXISTS `entertainment_gener_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entertainment_gener_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entertainment_id` bigint(20) NOT NULL,
  `genre_id` bigint(20) NOT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entertainment_gener_mapping_entertainment_id_deleted_at_index` (`entertainment_id`,`deleted_at`),
  KEY `entertainment_gener_mapping_genre_id_index` (`genre_id`),
  KEY `entertainment_gener_mapping_deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entertainment_gener_mapping`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `entertainment_gener_mapping` WRITE;
/*!40000 ALTER TABLE `entertainment_gener_mapping` DISABLE KEYS */;
INSERT INTO `entertainment_gener_mapping` VALUES
(5,117,9,NULL,NULL,NULL,'2026-03-04 22:46:42','2026-03-04 22:46:42',NULL),
(6,117,8,NULL,NULL,NULL,'2026-03-04 22:46:42','2026-03-04 22:46:42',NULL),
(7,118,3,NULL,NULL,NULL,'2026-03-04 22:46:46','2026-03-04 22:46:46',NULL),
(8,118,9,NULL,NULL,NULL,'2026-03-04 22:46:46','2026-03-04 22:46:46',NULL),
(9,118,10,NULL,NULL,NULL,'2026-03-04 22:46:46','2026-03-04 22:46:46',NULL),
(10,119,1,NULL,NULL,NULL,'2026-03-04 22:46:48','2026-03-04 22:46:48',NULL),
(11,119,11,NULL,NULL,NULL,'2026-03-04 22:46:48','2026-03-04 22:46:48',NULL),
(12,119,8,NULL,NULL,NULL,'2026-03-04 22:46:48','2026-03-04 22:46:48',NULL),
(13,120,1,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51',NULL),
(14,120,12,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51',NULL),
(15,120,13,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51',NULL),
(16,121,8,NULL,NULL,NULL,'2026-03-04 22:46:52','2026-03-04 22:46:52',NULL),
(17,121,11,NULL,NULL,NULL,'2026-03-04 22:46:52','2026-03-04 22:46:52',NULL),
(18,121,3,NULL,NULL,NULL,'2026-03-04 22:46:52','2026-03-04 22:46:52',NULL),
(19,122,9,NULL,NULL,NULL,'2026-03-04 22:46:57','2026-03-04 22:46:57',NULL),
(20,122,11,NULL,NULL,NULL,'2026-03-04 22:46:57','2026-03-04 22:46:57',NULL),
(21,123,9,NULL,NULL,NULL,'2026-03-04 22:47:03','2026-03-04 22:47:03',NULL),
(22,123,11,NULL,NULL,NULL,'2026-03-04 22:47:03','2026-03-04 22:47:03',NULL),
(23,124,9,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09',NULL),
(24,124,14,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09',NULL),
(25,124,15,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09',NULL),
(26,125,2,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13',NULL),
(27,125,16,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13',NULL),
(28,125,17,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13',NULL),
(29,126,3,NULL,NULL,NULL,'2026-03-04 22:47:15','2026-03-04 22:47:15',NULL),
(30,126,9,NULL,NULL,NULL,'2026-03-04 22:47:15','2026-03-04 22:47:15',NULL),
(31,126,10,NULL,NULL,NULL,'2026-03-04 22:47:15','2026-03-04 22:47:15',NULL),
(32,127,18,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19',NULL),
(33,127,9,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19',NULL),
(34,127,19,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19',NULL),
(35,128,18,NULL,NULL,NULL,'2026-03-04 22:47:25','2026-03-04 22:47:25',NULL),
(36,128,19,NULL,NULL,NULL,'2026-03-04 22:47:25','2026-03-04 22:47:25',NULL),
(37,129,9,NULL,NULL,NULL,'2026-03-04 22:47:27','2026-03-04 22:47:27',NULL),
(38,129,18,NULL,NULL,NULL,'2026-03-04 22:47:27','2026-03-04 22:47:27',NULL),
(39,130,9,NULL,NULL,NULL,'2026-03-04 22:47:29','2026-03-04 22:47:29',NULL),
(40,130,11,NULL,NULL,NULL,'2026-03-04 22:47:29','2026-03-04 22:47:29',NULL),
(41,131,18,NULL,NULL,NULL,'2026-03-04 22:47:31','2026-03-04 22:47:31',NULL),
(42,131,20,NULL,NULL,NULL,'2026-03-04 22:47:31','2026-03-04 22:47:31',NULL),
(43,131,19,NULL,NULL,NULL,'2026-03-04 22:47:31','2026-03-04 22:47:31',NULL),
(44,132,18,NULL,NULL,NULL,'2026-03-04 22:47:37','2026-03-04 22:47:37',NULL),
(45,132,9,NULL,NULL,NULL,'2026-03-04 22:47:37','2026-03-04 22:47:37',NULL),
(46,132,19,NULL,NULL,NULL,'2026-03-04 22:47:37','2026-03-04 22:47:37',NULL),
(47,133,9,NULL,NULL,NULL,'2026-03-04 22:47:38','2026-03-04 22:47:38',NULL),
(48,134,2,NULL,NULL,NULL,'2026-03-04 22:47:40','2026-03-04 22:47:40',NULL),
(49,134,18,NULL,NULL,NULL,'2026-03-04 22:47:40','2026-03-04 22:47:40',NULL),
(50,134,19,NULL,NULL,NULL,'2026-03-04 22:47:40','2026-03-04 22:47:40',NULL),
(51,134,9,NULL,NULL,NULL,'2026-03-04 22:47:40','2026-03-04 22:47:40',NULL),
(52,135,19,NULL,NULL,NULL,'2026-03-04 22:47:46','2026-03-04 22:47:46',NULL),
(53,135,9,NULL,NULL,NULL,'2026-03-04 22:47:46','2026-03-04 22:47:46',NULL),
(54,135,18,NULL,NULL,NULL,'2026-03-04 22:47:46','2026-03-04 22:47:46',NULL),
(55,136,9,NULL,NULL,NULL,'2026-03-04 22:47:55','2026-03-04 22:47:55',NULL),
(56,136,19,NULL,NULL,NULL,'2026-03-04 22:47:55','2026-03-04 22:47:55',NULL);
/*!40000 ALTER TABLE `entertainment_gener_mapping` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `entertainment_stream_content_mapping`
--

DROP TABLE IF EXISTS `entertainment_stream_content_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entertainment_stream_content_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entertainment_id` bigint(20) unsigned NOT NULL,
  `type` varchar(191) DEFAULT NULL,
  `quality` varchar(191) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entertainment_stream_content_mapping`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `entertainment_stream_content_mapping` WRITE;
/*!40000 ALTER TABLE `entertainment_stream_content_mapping` DISABLE KEYS */;
INSERT INTO `entertainment_stream_content_mapping` VALUES
(1,21,'YouTube','480p','https://youtu.be/5zSPGLoN9lQ?si=-BRLpMNIEJrnKm6f',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(2,21,'YouTube','720p','https://youtu.be/5zSPGLoN9lQ?si=sygr-NcCZcS00O0p',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(3,21,'YouTube','1080p','https://youtu.be/5zSPGLoN9lQ?si=eckyQwNdCsW6Pao6',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(4,21,'YouTube','2K','https://youtu.be/5zSPGLoN9lQ?si=eckyQwNdCsW6Pao6',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(5,22,'YouTube','480p','https://youtu.be/PdxPlbKFkaM?si=NydEmXECOvT1blJL',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(6,22,'YouTube','720p','https://youtu.be/PdxPlbKFkaM?si=zaa1bCmFWRbSxZEB',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(7,22,'YouTube','1080p','https://youtu.be/PdxPlbKFkaM?si=zlHHbalMgDJWz9Tp',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(8,22,'YouTube','2K','https://youtu.be/PdxPlbKFkaM?si=qaZ1H82OVU3sVx0V',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(9,26,'YouTube','480p','https://youtu.be/hlKFxyxOWIQ?si=d5nuCs6BYaIZJhSn',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(10,26,'YouTube','720p','https://youtu.be/hlKFxyxOWIQ?si=0NmD4yAoShQigs07',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(11,26,'YouTube','1080p','https://youtu.be/hlKFxyxOWIQ?si=_KagBhO3OxIJxdyx',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(12,26,'YouTube','1440p','https://youtu.be/hlKFxyxOWIQ?si=H096nrbHzq3_2hWF',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(13,27,'YouTube','480p','https://youtu.be/U-KfnCpEEl4?si=Vc70N3_zFcBD0yR4',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(14,27,'YouTube','720p','https://youtu.be/U-KfnCpEEl4?si=HUmROBp9MupZ_mAa',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(15,27,'YouTube','1080p','https://youtu.be/U-KfnCpEEl4?si=Wd3qSh7kodL-LvxC',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(16,27,'YouTube','1440p','https://youtu.be/U-KfnCpEEl4?si=QcjXOGpAHgsq1IJl',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(17,29,'YouTube','480p','https://youtu.be/so2XtxcSLHQ?si=ac0V29WoRwQyTNc7',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(18,29,'YouTube','720p','https://youtu.be/so2XtxcSLHQ?si=N97AW29RFILE1nZ0',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(19,29,'YouTube','1080p','https://youtu.be/so2XtxcSLHQ?si=yk7Cvs-MlKkT8MQy',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(20,36,'YouTube','480p','https://youtu.be/WltJPKFo_J4?si=zz4-zHhey7CK-d3N',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(21,36,'YouTube','720p','https://youtu.be/WltJPKFo_J4?si=0wIlovLv2RVlfjxt6',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(22,36,'YouTube','1080p','https://youtu.be/WltJPKFo_J4?si=BvEAyAoOkOdLnFr4',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(23,40,'YouTube','480p','https://youtu.be/22l6w8n9iCc?si=ojEDxNeMZ9DEFg8J',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(24,40,'YouTube','720p','https://youtu.be/22l6w8n9iCc?si=4gAqMfc4DUSUyg3G',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL),
(25,40,'YouTube','1080p','https://youtu.be/22l6w8n9iCc?si=gVdCokIa76dm3gJy',NULL,NULL,NULL,'2026-02-18 08:17:55','2026-02-18 08:17:55',NULL);
/*!40000 ALTER TABLE `entertainment_stream_content_mapping` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `entertainment_talent_mapping`
--

DROP TABLE IF EXISTS `entertainment_talent_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entertainment_talent_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entertainment_id` bigint(20) NOT NULL,
  `talent_id` bigint(20) NOT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entertainment_talent_mapping_entertainment_id_index` (`entertainment_id`),
  KEY `entertainment_talent_mapping_deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entertainment_talent_mapping`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `entertainment_talent_mapping` WRITE;
/*!40000 ALTER TABLE `entertainment_talent_mapping` DISABLE KEYS */;
INSERT INTO `entertainment_talent_mapping` VALUES
(1,117,1,NULL,NULL,NULL,'2026-03-04 22:46:42','2026-03-04 22:46:42',NULL),
(2,117,2,NULL,NULL,NULL,'2026-03-04 22:46:42','2026-03-04 22:46:42',NULL),
(3,117,3,NULL,NULL,NULL,'2026-03-04 22:46:42','2026-03-04 22:46:42',NULL),
(4,117,4,NULL,NULL,NULL,'2026-03-04 22:46:42','2026-03-04 22:46:42',NULL),
(5,117,5,NULL,NULL,NULL,'2026-03-04 22:46:42','2026-03-04 22:46:42',NULL),
(6,118,6,NULL,NULL,NULL,'2026-03-04 22:46:46','2026-03-04 22:46:46',NULL),
(7,118,7,NULL,NULL,NULL,'2026-03-04 22:46:46','2026-03-04 22:46:46',NULL),
(8,118,8,NULL,NULL,NULL,'2026-03-04 22:46:46','2026-03-04 22:46:46',NULL),
(9,118,9,NULL,NULL,NULL,'2026-03-04 22:46:46','2026-03-04 22:46:46',NULL),
(10,118,10,NULL,NULL,NULL,'2026-03-04 22:46:46','2026-03-04 22:46:46',NULL),
(11,119,11,NULL,NULL,NULL,'2026-03-04 22:46:48','2026-03-04 22:46:48',NULL),
(12,119,12,NULL,NULL,NULL,'2026-03-04 22:46:48','2026-03-04 22:46:48',NULL),
(13,119,13,NULL,NULL,NULL,'2026-03-04 22:46:48','2026-03-04 22:46:48',NULL),
(14,119,14,NULL,NULL,NULL,'2026-03-04 22:46:48','2026-03-04 22:46:48',NULL),
(15,119,15,NULL,NULL,NULL,'2026-03-04 22:46:48','2026-03-04 22:46:48',NULL),
(16,120,16,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51',NULL),
(17,120,17,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51',NULL),
(18,120,18,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51',NULL),
(19,120,19,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51',NULL),
(20,120,20,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51',NULL),
(21,121,21,NULL,NULL,NULL,'2026-03-04 22:46:52','2026-03-04 22:46:52',NULL),
(22,121,22,NULL,NULL,NULL,'2026-03-04 22:46:52','2026-03-04 22:46:52',NULL),
(23,121,23,NULL,NULL,NULL,'2026-03-04 22:46:52','2026-03-04 22:46:52',NULL),
(24,121,24,NULL,NULL,NULL,'2026-03-04 22:46:52','2026-03-04 22:46:52',NULL),
(25,121,25,NULL,NULL,NULL,'2026-03-04 22:46:52','2026-03-04 22:46:52',NULL),
(26,122,26,NULL,NULL,NULL,'2026-03-04 22:46:57','2026-03-04 22:46:57',NULL),
(27,122,27,NULL,NULL,NULL,'2026-03-04 22:46:57','2026-03-04 22:46:57',NULL),
(28,122,28,NULL,NULL,NULL,'2026-03-04 22:46:57','2026-03-04 22:46:57',NULL),
(29,122,29,NULL,NULL,NULL,'2026-03-04 22:46:57','2026-03-04 22:46:57',NULL),
(30,122,30,NULL,NULL,NULL,'2026-03-04 22:46:57','2026-03-04 22:46:57',NULL),
(31,123,31,NULL,NULL,NULL,'2026-03-04 22:47:03','2026-03-04 22:47:03',NULL),
(32,123,32,NULL,NULL,NULL,'2026-03-04 22:47:03','2026-03-04 22:47:03',NULL),
(33,123,33,NULL,NULL,NULL,'2026-03-04 22:47:03','2026-03-04 22:47:03',NULL),
(34,123,34,NULL,NULL,NULL,'2026-03-04 22:47:03','2026-03-04 22:47:03',NULL),
(35,123,35,NULL,NULL,NULL,'2026-03-04 22:47:03','2026-03-04 22:47:03',NULL),
(36,124,36,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09',NULL),
(37,124,37,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09',NULL),
(38,124,38,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09',NULL),
(39,124,39,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09',NULL),
(40,124,40,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09',NULL),
(41,125,41,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13',NULL),
(42,125,42,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13',NULL),
(43,125,43,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13',NULL),
(44,125,44,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13',NULL),
(45,125,45,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13',NULL),
(46,126,46,NULL,NULL,NULL,'2026-03-04 22:47:15','2026-03-04 22:47:15',NULL),
(47,126,47,NULL,NULL,NULL,'2026-03-04 22:47:15','2026-03-04 22:47:15',NULL),
(48,126,48,NULL,NULL,NULL,'2026-03-04 22:47:15','2026-03-04 22:47:15',NULL),
(49,126,49,NULL,NULL,NULL,'2026-03-04 22:47:15','2026-03-04 22:47:15',NULL),
(50,126,50,NULL,NULL,NULL,'2026-03-04 22:47:15','2026-03-04 22:47:15',NULL),
(51,127,51,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19',NULL),
(52,127,52,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19',NULL),
(53,127,53,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19',NULL),
(54,127,54,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19',NULL),
(55,127,55,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19',NULL),
(56,128,56,NULL,NULL,NULL,'2026-03-04 22:47:25','2026-03-04 22:47:25',NULL),
(57,128,57,NULL,NULL,NULL,'2026-03-04 22:47:25','2026-03-04 22:47:25',NULL),
(58,129,58,NULL,NULL,NULL,'2026-03-04 22:47:27','2026-03-04 22:47:27',NULL),
(59,129,59,NULL,NULL,NULL,'2026-03-04 22:47:27','2026-03-04 22:47:27',NULL),
(60,129,60,NULL,NULL,NULL,'2026-03-04 22:47:27','2026-03-04 22:47:27',NULL),
(61,129,61,NULL,NULL,NULL,'2026-03-04 22:47:27','2026-03-04 22:47:27',NULL),
(62,129,62,NULL,NULL,NULL,'2026-03-04 22:47:27','2026-03-04 22:47:27',NULL),
(63,130,63,NULL,NULL,NULL,'2026-03-04 22:47:29','2026-03-04 22:47:29',NULL),
(64,130,64,NULL,NULL,NULL,'2026-03-04 22:47:29','2026-03-04 22:47:29',NULL),
(65,130,65,NULL,NULL,NULL,'2026-03-04 22:47:29','2026-03-04 22:47:29',NULL),
(66,130,66,NULL,NULL,NULL,'2026-03-04 22:47:29','2026-03-04 22:47:29',NULL),
(67,130,67,NULL,NULL,NULL,'2026-03-04 22:47:29','2026-03-04 22:47:29',NULL),
(68,131,68,NULL,NULL,NULL,'2026-03-04 22:47:31','2026-03-04 22:47:31',NULL),
(69,131,69,NULL,NULL,NULL,'2026-03-04 22:47:31','2026-03-04 22:47:31',NULL),
(70,131,70,NULL,NULL,NULL,'2026-03-04 22:47:31','2026-03-04 22:47:31',NULL),
(71,131,71,NULL,NULL,NULL,'2026-03-04 22:47:31','2026-03-04 22:47:31',NULL),
(72,131,72,NULL,NULL,NULL,'2026-03-04 22:47:31','2026-03-04 22:47:31',NULL),
(73,132,73,NULL,NULL,NULL,'2026-03-04 22:47:37','2026-03-04 22:47:37',NULL),
(74,132,74,NULL,NULL,NULL,'2026-03-04 22:47:37','2026-03-04 22:47:37',NULL),
(75,132,75,NULL,NULL,NULL,'2026-03-04 22:47:37','2026-03-04 22:47:37',NULL),
(76,132,76,NULL,NULL,NULL,'2026-03-04 22:47:37','2026-03-04 22:47:37',NULL),
(77,132,77,NULL,NULL,NULL,'2026-03-04 22:47:37','2026-03-04 22:47:37',NULL),
(78,133,78,NULL,NULL,NULL,'2026-03-04 22:47:38','2026-03-04 22:47:38',NULL),
(79,133,79,NULL,NULL,NULL,'2026-03-04 22:47:38','2026-03-04 22:47:38',NULL),
(80,133,80,NULL,NULL,NULL,'2026-03-04 22:47:38','2026-03-04 22:47:38',NULL),
(81,133,81,NULL,NULL,NULL,'2026-03-04 22:47:38','2026-03-04 22:47:38',NULL),
(82,133,82,NULL,NULL,NULL,'2026-03-04 22:47:38','2026-03-04 22:47:38',NULL),
(83,134,83,NULL,NULL,NULL,'2026-03-04 22:47:40','2026-03-04 22:47:40',NULL),
(84,134,84,NULL,NULL,NULL,'2026-03-04 22:47:40','2026-03-04 22:47:40',NULL),
(85,134,85,NULL,NULL,NULL,'2026-03-04 22:47:40','2026-03-04 22:47:40',NULL),
(86,135,86,NULL,NULL,NULL,'2026-03-04 22:47:46','2026-03-04 22:47:46',NULL),
(87,135,87,NULL,NULL,NULL,'2026-03-04 22:47:46','2026-03-04 22:47:46',NULL),
(88,135,88,NULL,NULL,NULL,'2026-03-04 22:47:46','2026-03-04 22:47:46',NULL),
(89,135,89,NULL,NULL,NULL,'2026-03-04 22:47:46','2026-03-04 22:47:46',NULL),
(90,135,90,NULL,NULL,NULL,'2026-03-04 22:47:46','2026-03-04 22:47:46',NULL),
(91,136,91,NULL,NULL,NULL,'2026-03-04 22:47:55','2026-03-04 22:47:55',NULL),
(92,136,92,NULL,NULL,NULL,'2026-03-04 22:47:55','2026-03-04 22:47:55',NULL),
(93,136,93,NULL,NULL,NULL,'2026-03-04 22:47:55','2026-03-04 22:47:55',NULL),
(94,136,94,NULL,NULL,NULL,'2026-03-04 22:47:55','2026-03-04 22:47:55',NULL),
(95,136,95,NULL,NULL,NULL,'2026-03-04 22:47:55','2026-03-04 22:47:55',NULL);
/*!40000 ALTER TABLE `entertainment_talent_mapping` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `entertainment_views`
--

DROP TABLE IF EXISTS `entertainment_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entertainment_views` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entertainment_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entertainment_views`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `entertainment_views` WRITE;
/*!40000 ALTER TABLE `entertainment_views` DISABLE KEYS */;
INSERT INTO `entertainment_views` VALUES
(1,99,4,4,NULL,NULL,NULL,'2026-01-05 11:43:47','2026-01-19 01:25:02',NULL),
(2,95,5,5,NULL,NULL,NULL,'2024-04-12 06:56:39','2024-04-12 06:56:39',NULL),
(3,35,6,6,NULL,NULL,NULL,'2024-05-12 06:56:46','2024-05-12 06:56:46',NULL),
(4,49,7,7,NULL,NULL,NULL,'2024-07-12 06:57:19','2024-07-12 06:57:19',NULL),
(5,69,3,3,NULL,NULL,NULL,'2024-06-12 06:57:44','2024-06-12 06:57:44',NULL),
(6,76,8,8,NULL,NULL,NULL,'2024-04-12 06:57:44','2024-04-12 06:57:44',NULL),
(7,89,9,9,NULL,NULL,NULL,'2026-02-17 17:49:41','2026-02-12 23:45:25',NULL),
(8,102,10,10,NULL,NULL,NULL,'2024-05-12 06:57:44','2024-05-12 06:57:44',NULL),
(9,94,11,11,NULL,NULL,NULL,'2026-01-25 10:42:23','2026-02-04 09:08:11',NULL),
(10,22,12,12,NULL,NULL,NULL,'2024-06-20 06:57:44','2024-06-20 06:57:44',NULL),
(11,25,13,13,NULL,NULL,NULL,'2024-01-01 06:57:44','2024-01-01 06:57:44',NULL),
(12,35,4,4,NULL,NULL,NULL,'2026-02-16 16:53:56','2026-01-19 06:36:19',NULL),
(13,40,5,5,NULL,NULL,NULL,'2024-02-20 06:57:44','2024-02-20 06:57:44',NULL),
(14,55,6,6,NULL,NULL,NULL,'2024-01-12 06:57:44','2024-01-12 06:57:44',NULL),
(15,62,7,7,NULL,NULL,NULL,'2026-02-17 14:23:09','2026-02-03 03:36:01',NULL),
(16,68,3,3,NULL,NULL,NULL,'2024-04-12 06:57:44','2024-04-12 06:57:44',NULL),
(17,75,10,10,NULL,NULL,NULL,'2026-02-11 09:47:41','2026-01-21 12:31:27',NULL),
(18,83,12,12,NULL,NULL,NULL,'2024-09-12 06:57:44','2024-09-12 06:57:44',NULL),
(19,89,13,13,NULL,NULL,NULL,'2024-10-12 06:57:44','2024-10-12 06:57:44',NULL),
(20,93,15,15,NULL,NULL,NULL,'2026-01-23 19:10:45','2026-02-03 08:13:38',NULL),
(21,99,4,4,NULL,NULL,NULL,'2024-09-12 06:57:44','2024-09-12 06:57:44',NULL),
(22,101,5,5,NULL,NULL,NULL,'2026-01-17 07:58:20','2026-02-07 00:18:21',NULL),
(23,102,12,12,NULL,NULL,NULL,'2026-01-10 11:32:29','2026-01-07 10:22:18',NULL),
(24,1,16,NULL,16,16,NULL,'2026-02-21 13:45:10','2026-02-21 13:45:10',NULL),
(25,21,16,NULL,16,16,NULL,'2026-02-21 13:46:09','2026-02-21 13:46:09',NULL),
(26,68,16,NULL,16,16,NULL,'2026-02-21 13:47:28','2026-02-21 13:47:28',NULL),
(27,25,17,NULL,17,17,NULL,'2026-02-22 18:31:42','2026-02-22 18:31:42',NULL),
(28,36,21,NULL,21,21,NULL,'2026-03-07 19:46:28','2026-03-07 19:46:28',NULL),
(29,1,22,NULL,22,22,NULL,'2026-04-04 06:41:29','2026-04-04 06:41:29',NULL),
(30,17,22,NULL,22,22,NULL,'2026-04-04 06:41:42','2026-04-04 06:41:42',NULL),
(31,24,22,NULL,22,22,NULL,'2026-04-04 06:41:54','2026-04-04 06:41:54',NULL),
(32,36,16,NULL,16,16,NULL,'2026-05-24 05:52:32','2026-05-24 05:52:32',NULL);
/*!40000 ALTER TABLE `entertainment_views` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `entertainments`
--

DROP TABLE IF EXISTS `entertainments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entertainments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) DEFAULT NULL,
  `tmdb_id` varchar(191) DEFAULT NULL,
  `thumbnail_url` text DEFAULT NULL,
  `poster_url` text DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `trailer_url_type` varchar(191) DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `trailer_url` text DEFAULT NULL,
  `movie_access` varchar(191) DEFAULT NULL,
  `plan_id` bigint(20) unsigned DEFAULT NULL,
  `language` varchar(191) DEFAULT NULL,
  `IMDb_rating` varchar(191) DEFAULT NULL,
  `content_rating` longtext DEFAULT NULL,
  `duration` varchar(191) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `is_restricted` tinyint(1) NOT NULL DEFAULT 0,
  `video_upload_type` varchar(191) DEFAULT NULL,
  `video_url_input` text DEFAULT NULL,
  `video_quality_url` text DEFAULT NULL,
  `enable_quality` tinyint(1) NOT NULL DEFAULT 0,
  `download_status` tinyint(1) NOT NULL DEFAULT 0,
  `download_type` varchar(191) DEFAULT NULL,
  `download_url` text DEFAULT NULL,
  `enable_download_quality` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `poster_tv_url` text DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `purchase_type` varchar(191) DEFAULT NULL,
  `access_duration` int(11) DEFAULT NULL,
  `discount` varchar(191) DEFAULT NULL,
  `available_for` int(11) DEFAULT NULL,
  `subtitle_file` varchar(191) DEFAULT NULL,
  `enable_subtitle` tinyint(1) NOT NULL DEFAULT 0,
  `subtitle_language` varchar(191) DEFAULT NULL,
  `is_default_subtitle` tinyint(1) NOT NULL DEFAULT 0,
  `meta_title` varchar(191) DEFAULT NULL,
  `meta_keywords` varchar(191) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `seo_image` varchar(191) DEFAULT NULL,
  `google_site_verification` varchar(191) DEFAULT NULL,
  `canonical_url` varchar(191) DEFAULT NULL,
  `short_description` text DEFAULT NULL,
  `enable_clips` tinyint(1) NOT NULL DEFAULT 0,
  `slug` text DEFAULT NULL,
  `bunny_trailer_url` text DEFAULT NULL,
  `bunny_video_url` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entertainments_id_deleted_at_index` (`id`,`deleted_at`),
  KEY `entertainments_id_status_release_date_deleted_at_index` (`id`,`status`,`release_date`,`deleted_at`),
  KEY `entertainments_id_status_release_date_index` (`id`,`status`,`release_date`),
  KEY `entertainments_type_index` (`type`),
  KEY `entertainments_release_date_index` (`release_date`),
  KEY `entertainments_status_index` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entertainments`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `entertainments` WRITE;
/*!40000 ALTER TABLE `entertainments` DISABLE KEYS */;
INSERT INTO `entertainments` VALUES
(117,'Fight Club','550','https://image.tmdb.org/t/p/original/c6OLXfKAk5BKeR6broC8pYiCquX.jpg','https://image.tmdb.org/t/p/original/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg','A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.',NULL,'movie',NULL,NULL,NULL,'en','8.438',NULL,'02:19:00',NULL,NULL,'1999-10-15',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:46:42','2026-03-04 22:46:42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(118,'Forrest Gump','13','https://image.tmdb.org/t/p/original/67HggiWaP9ZLv5sPYmyRV37yAJM.jpg','https://image.tmdb.org/t/p/original/saHP97rTPS5eLmrLQEcANmKrsFl.jpg','A man with a low IQ has accomplished great things in his life and been present during significant historic events—in each case, far exceeding what anyone imagined he could do. But despite all he has achieved, his one true love eludes him.',NULL,'movie',NULL,NULL,NULL,'en','8.462',NULL,'02:22:00',NULL,NULL,'1994-06-23',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:46:46','2026-03-04 22:46:46',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(119,'The Dark Knight','155','https://image.tmdb.org/t/p/original/dqK9Hag1054tghRQSqLSfrkvQnA.jpg','https://image.tmdb.org/t/p/original/qJ2tW6WMUDux911r6m7haRef0WH.jpg','Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.',NULL,'movie',NULL,NULL,NULL,'en','8.527',NULL,'02:32:00',NULL,NULL,'2008-07-16',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:46:48','2026-03-04 22:46:48',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(120,'Inception','27205','https://image.tmdb.org/t/p/original/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg','https://image.tmdb.org/t/p/original/xlaY2zyzMfkhk0HSC5VUwzoZPU1.jpg','Cobb, a skilled thief who commits corporate espionage by infiltrating the subconscious of his targets is offered a chance to regain his old life as payment for a task considered to be impossible: \"inception\", the implantation of another person\'s idea into a target\'s subconscious.',NULL,'movie',NULL,NULL,NULL,'en','8.371',NULL,'02:28:00',NULL,NULL,'2010-07-15',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(121,'Pulp Fiction','680','https://image.tmdb.org/t/p/original/96hiUXEuYsu4tcnvlaY8tEMFM0m.jpg','https://image.tmdb.org/t/p/original/vQWk5YBFWF4bZaofAbv0tShwBvQ.jpg','A burger-loving hit man, his philosophical partner, a drug-addled gangster\'s moll and a washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories that ingeniously trip back and forth in time.',NULL,'movie',NULL,NULL,NULL,'en','8.486',NULL,'02:34:00',NULL,NULL,'1994-09-10',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:46:52','2026-03-04 22:46:52',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(122,'The Shawshank Redemption','278','https://image.tmdb.org/t/p/original/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg','https://image.tmdb.org/t/p/original/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg','Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.',NULL,'movie',NULL,NULL,NULL,'en','8.716',NULL,'02:22:00',NULL,NULL,'1994-09-23',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:46:57','2026-03-04 22:46:57',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(123,'The Godfather','238','https://image.tmdb.org/t/p/original/tSPT36ZKlP2WVHJLM4cQPLSzv3b.jpg','https://image.tmdb.org/t/p/original/3bhkrj58Vtu7enYsRolD1fZdja1.jpg','Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.',NULL,'movie',NULL,NULL,NULL,'en','8.687',NULL,'02:55:00',NULL,NULL,'1972-03-14',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:47:03','2026-03-04 22:47:03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(124,'Schindler\'s List','424','https://image.tmdb.org/t/p/original/zb6fM1CX41D9rF9hdgclu0peUmy.jpg','https://image.tmdb.org/t/p/original/sF1U4EUQS8YHUYjNl3pMGNIQyr0.jpg','The true story of how businessman Oskar Schindler saved over a thousand Jewish lives from the Nazis while they worked as slaves in his factory during World War II.',NULL,'movie',NULL,NULL,NULL,'en','8.566',NULL,'03:15:00',NULL,NULL,'1993-12-15',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(125,'Spirited Away','129','https://image.tmdb.org/t/p/original/ukfI9QkU1aIhOhKXYWE9n3z1mFR.jpg','https://image.tmdb.org/t/p/original/39wmItIWsg5sZMyRUHLkWBcuVCM.jpg','A young girl, Chihiro, becomes trapped in a strange new world of spirits. When her parents undergo a mysterious transformation, she must call upon the courage she never knew she had to free her family.',NULL,'movie',NULL,NULL,NULL,'ja','8.534',NULL,'02:05:00',NULL,NULL,'2001-07-20',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(126,'Dilwale Dulhania Le Jayenge','19404','https://image.tmdb.org/t/p/original/zQDFHYNVVVp9OAYSixYAG1SyX1l.jpg','https://image.tmdb.org/t/p/original/2CAL2433ZeIihfX1Hb2139CX0pW.jpg','Raj is a rich, carefree, happy-go-lucky second generation NRI. Simran is the daughter of Chaudhary Baldev Singh, who in spite of being an NRI is very strict about adherence to Indian values. Simran has left for India to be married to her childhood fiancé. Raj leaves for India with a mission at his hands, to claim his lady love under the noses of her whole family. Thus begins a saga.',NULL,'movie',NULL,NULL,NULL,'hi','8.518',NULL,'03:10:00',NULL,NULL,'1995-10-20',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:47:15','2026-03-04 22:47:15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(127,'Game of Thrones','1399','https://image.tmdb.org/t/p/original/zZqpAXxVSBtxV9qPBcscfXBcL2w.jpg','https://image.tmdb.org/t/p/original/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg','Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night\'s Watch, is all that stands between the realms of men and icy horrors beyond.',NULL,'tvshow',NULL,NULL,NULL,'en','8.459',NULL,NULL,NULL,NULL,'2011-04-17',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(128,'The Mandalorian','82856','https://image.tmdb.org/t/p/original/9zcbqSxdsRMZWHYtyCd1nXPr2xq.jpg','https://image.tmdb.org/t/p/original/sWgBv7LV2PRoQgkxwlibdGXKz1S.jpg','After the fall of the Galactic Empire, lawlessness has spread throughout the galaxy. A lone gunfighter makes his way through the outer reaches, earning his keep as a bounty hunter.',NULL,'tvshow',NULL,NULL,NULL,'en','8.409',NULL,NULL,NULL,NULL,'2019-11-12',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:47:25','2026-03-04 22:47:25',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(129,'The Flash','60735','https://image.tmdb.org/t/p/original/gFkHcIh7iE5G0oVOgpmY8ONQjhl.jpg','https://image.tmdb.org/t/p/original/yZevl2vHQgmosfwUdVNzviIfaWS.jpg','After being struck by lightning, CSI investigator Barry Allen awakens from a nine-month coma to discover he has been  granted the gift of super speed.  Teaming up with S.T.A.R. Labs, Barry takes on the persona of The Flash, the Fastest  Man Alive, to protect his city.',NULL,'tvshow',NULL,NULL,NULL,'en','7.763',NULL,NULL,NULL,NULL,'2014-10-07',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:47:27','2026-03-04 22:47:27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(130,'Breaking Bad','1396','https://image.tmdb.org/t/p/original/tsRy63Mu5cu8etL1X7ZLyf7UP1M.jpg','https://image.tmdb.org/t/p/original/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg','Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family\'s financial future at any cost as he enters the dangerous world of drugs and crime.',NULL,'tvshow',NULL,NULL,NULL,'en','8.937',NULL,NULL,NULL,NULL,'2008-01-20',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:47:29','2026-03-04 22:47:29',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(131,'Stranger Things','66732','https://image.tmdb.org/t/p/original/8zbAoryWbtH0DKdev8abFAjdufy.jpg','https://image.tmdb.org/t/p/original/uOOtwVbSr4QDjAGIifLDwpb2Pdl.jpg','When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',NULL,'tvshow',NULL,NULL,NULL,'en','8.577',NULL,NULL,NULL,NULL,'2016-07-15',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:47:31','2026-03-04 22:47:31',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(132,'House of the Dragon','94997','https://image.tmdb.org/t/p/original/2xGcSLyTAzConiHAByWqhfLiatT.jpg','https://image.tmdb.org/t/p/original/7QMsOTMUswlwxJP0rTTZfmz2tX2.jpg','The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.',NULL,'tvshow',NULL,NULL,NULL,'en','8.291',NULL,NULL,NULL,NULL,'2022-08-21',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:47:37','2026-03-04 22:47:37',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(133,'Euphoria','85552','https://image.tmdb.org/t/p/original/9KnIzPCv9XpWA0MqmwiKBZvV1Sj.jpg','https://image.tmdb.org/t/p/original/3Q0hd3heuWwDWpwcDkhQOA6TYWI.jpg','A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.',NULL,'tvshow',NULL,NULL,NULL,'en','8.284',NULL,NULL,NULL,NULL,'2019-06-16',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:47:38','2026-03-04 22:47:38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(134,'Invincible','95557','https://image.tmdb.org/t/p/original/dfmPbyeZZSz3bekeESvMJaH91gS.jpg','https://image.tmdb.org/t/p/original/jBn4LWlgdsf6xIUYhYBwpctBVsj.jpg','Mark Grayson is a normal teenager except for the fact that his father is the most powerful superhero on the planet. Shortly after his seventeenth birthday, Mark begins to develop powers of his own and enters into his father’s tutelage.',NULL,'tvshow',NULL,NULL,NULL,'en','8.614',NULL,NULL,NULL,NULL,'2021-03-25',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:47:40','2026-03-04 22:47:40',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(135,'The Falcon and the Winter Soldier','88396','https://image.tmdb.org/t/p/original/aTjbqMONy77fHJrIYu14g1F0d5h.jpg','https://image.tmdb.org/t/p/original/6kbAMLteGO8yyewYau6bJ683sw7.jpg','Following the events of “Avengers: Endgame”, the Falcon, Sam Wilson and the Winter Soldier, Bucky Barnes team up in a global adventure that tests their abilities, and their patience.',NULL,'tvshow',NULL,NULL,NULL,'en','7.605',NULL,NULL,NULL,NULL,'2021-03-19',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:47:46','2026-03-04 22:47:46',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),
(136,'The Witcher','71912','https://image.tmdb.org/t/p/original/foGkPxpw9h8zln81j63mix5B7m8.jpg','https://image.tmdb.org/t/p/original/AoGsDM02UVt0npBA8OvpDcZbaMi.jpg','Geralt of Rivia, a mutated monster-hunter for hire, journeys toward his destiny in a turbulent world where people often prove more wicked than beasts.',NULL,'tvshow',NULL,NULL,NULL,'en','7.94',NULL,NULL,NULL,NULL,'2019-12-20',0,NULL,NULL,NULL,0,0,NULL,NULL,0,1,NULL,NULL,NULL,'2026-03-04 22:47:55','2026-03-04 22:47:55',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `entertainments` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `episode_download_mapping`
--

DROP TABLE IF EXISTS `episode_download_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `episode_download_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `episode_id` int(11) DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `quality` varchar(191) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episode_download_mapping`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `episode_download_mapping` WRITE;
/*!40000 ALTER TABLE `episode_download_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `episode_download_mapping` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `episode_stream_content_mapping`
--

DROP TABLE IF EXISTS `episode_stream_content_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `episode_stream_content_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `episode_id` bigint(20) unsigned NOT NULL,
  `quality` varchar(191) DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `episode_stream_content_mapping_episode_id_index` (`episode_id`),
  KEY `episode_stream_content_mapping_deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episode_stream_content_mapping`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `episode_stream_content_mapping` WRITE;
/*!40000 ALTER TABLE `episode_stream_content_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `episode_stream_content_mapping` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `episodes`
--

DROP TABLE IF EXISTS `episodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `episodes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) DEFAULT NULL,
  `poster_url` text DEFAULT NULL,
  `entertainment_id` bigint(20) unsigned DEFAULT NULL,
  `season_id` bigint(20) unsigned DEFAULT NULL,
  `trailer_url_type` varchar(191) DEFAULT NULL,
  `trailer_url` text DEFAULT NULL,
  `access` varchar(191) DEFAULT NULL,
  `plan_id` bigint(20) unsigned DEFAULT NULL,
  `IMDb_rating` varchar(191) DEFAULT NULL,
  `content_rating` longtext DEFAULT NULL,
  `duration` varchar(191) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `is_restricted` tinyint(1) NOT NULL DEFAULT 0,
  `short_desc` longtext DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `enable_quality` tinyint(1) NOT NULL DEFAULT 0,
  `video_upload_type` varchar(191) DEFAULT NULL,
  `video_url_input` text DEFAULT NULL,
  `download_status` tinyint(1) NOT NULL DEFAULT 0,
  `download_type` varchar(191) DEFAULT NULL,
  `download_url` text DEFAULT NULL,
  `enable_download_quality` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `video_quality_url` text DEFAULT NULL,
  `tmdb_id` varchar(191) DEFAULT NULL,
  `tmdb_season` varchar(191) DEFAULT NULL,
  `episode_number` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `poster_tv_url` text DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `purchase_type` varchar(191) DEFAULT NULL,
  `access_duration` int(11) DEFAULT NULL,
  `discount` varchar(191) DEFAULT NULL,
  `available_for` int(11) DEFAULT NULL,
  `enable_subtitle` tinyint(1) NOT NULL DEFAULT 0,
  `subtitle_file` varchar(191) DEFAULT NULL,
  `subtitle_language` varchar(191) DEFAULT NULL,
  `is_default_subtitle` tinyint(1) NOT NULL DEFAULT 0,
  `meta_title` varchar(191) DEFAULT NULL,
  `meta_keywords` varchar(191) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `seo_image` varchar(191) DEFAULT NULL,
  `google_site_verification` varchar(191) DEFAULT NULL,
  `canonical_url` varchar(191) DEFAULT NULL,
  `short_description` text DEFAULT NULL,
  `slug` text DEFAULT NULL,
  `bunny_trailer_url` text DEFAULT NULL,
  `bunny_video_url` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `episodes_id_deleted_at_index` (`id`,`deleted_at`),
  KEY `episodes_entertainment_id_index` (`entertainment_id`),
  KEY `episodes_status_index` (`status`),
  KEY `episodes_deleted_at_index` (`deleted_at`),
  KEY `episodes_season_id_index` (`season_id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episodes`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `episodes` WRITE;
/*!40000 ALTER TABLE `episodes` DISABLE KEYS */;
INSERT INTO `episodes` VALUES
(1,'S1 E1 The Awakening','s1_e1_the_awakening_thumb.png',1,1,'YouTube','https://youtu.be/7_MJp5AbSwA?si=Mtx9h0wlxtn4o_2Q','free',NULL,NULL,'TV-MA (Mature Audiences)','02:56',NULL,NULL,'2019-04-23',1,'A series of mysterious events awaken an ancient evil. 😱','The team must uncover the truth behind these occurrences before it\'s too late. A series of mysterious events awaken an ancient evil. 😱',0,'YouTube','https://youtu.be/mBYGUn6Q7tQ?si=2ijlo4497ab-ZMpU',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_the_awakening_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-the-awakening',NULL,NULL),
(2,'S1 E2 The Haunted','s1_e2_the_haunted_thumb.png',1,1,'YouTube','https://www.youtube.com/watch?v=mBYGUn6Q7tQ&t=17s','free',NULL,NULL,'TV-MA (Mature Audiences)','05:13',NULL,NULL,'2019-04-24',1,'The team discovers a haunted house with a dark secret. 🏚️','As they explore, they encounter terrifying apparitions and uncover the house\'s grim history. The team discovers a haunted house with a dark secret. 🏚️',0,'YouTube','https://youtu.be/oZDzZNm4k6M?si=Hv33WihW-44xFvkm',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_the_awakening_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-the-haunted',NULL,NULL),
(3,'S1 E3 The Possession','s1_e3_the_possession_thumb.png',1,1,'YouTube','https://www.youtube.com/watch?v=mBYGUn6Q7tQ&t=17s','free',NULL,'1','TV-MA (Mature Audiences)','02:09',NULL,NULL,'2019-04-25',1,'One of the investigators becomes possessed by a malevolent spirit. 👻','The team struggles to save their friend and find a way to expel the dark force. One of the investigators becomes possessed by a malevolent spirit. 👻',0,'YouTube','https://youtu.be/ng9BW-vQ_2k?si=z-uDACI2iFie0-HY',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'3','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e3_the_possession_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e3-the-possession',NULL,NULL),
(4,'S1 E4 The Ritual','s1_e4_the_ritual_thumb.png',1,1,'YouTube','https://www.youtube.com/watch?v=mBYGUn6Q7tQ&t=17s','pay-per-view',NULL,'2','TV-MA (Mature Audiences)','03:20',NULL,NULL,'2019-04-26',1,'The team uncovers a ritual that could banish the evil entity. 🕯️','The team uncovers a ritual that could banish the evil entity. They must perform it correctly amidst mounting supernatural threats. 🕯️',0,'YouTube','https://youtu.be/M6EMl7HPw6M?si=b5GV20LyRV6xd5Cn',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'4','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e4_the_ritual_thumb.png',40.00,'onetime',NULL,'10',20,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e4-the-ritual',NULL,NULL),
(5,'S1 E5 The Final Confrontation','s1_e5_the_final_confrontation_thumb.png',1,1,'YouTube','https://www.youtube.com/watch?v=mBYGUn6Q7tQ&t=17s','pay-per-view',NULL,'3','TV-MA (Mature Audiences)','03:28',NULL,NULL,'2019-04-27',1,'A climactic battle to defeat the ancient evil once and for all. ⚔️','A climactic battle to defeat the ancient evil once and for all. The team faces their greatest challenge yet, risking everything to save humanity. ⚔️',0,'YouTube','https://youtu.be/WHBOBgDTLak?si=zrUg1McYVIr9POWc',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'5','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e5_the_final_confrontation_thumb.png',40.00,'onetime',NULL,'10',20,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e5-the-final-confrontation',NULL,NULL),
(6,'S2 E1 The Return','s2_e1_the_return_thumb.png',1,2,'YouTube','https://youtu.be/1sCBEzxF_K4?si=B-rZUby9EXaMWkKD','free',NULL,'4','TV-MA (Mature Audiences)','02:43',NULL,NULL,'2019-06-08',1,'The ancient evil returns, more powerful than ever. 🔥','The ancient evil returns, more powerful than ever. The team must regroup and devise a new plan to confront this formidable foe. 🔥',0,'YouTube','https://youtu.be/_U7wKRtf8C4?si=nGKAxMOgs9YDMEPq',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_e1_the_return_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-e1-the-return',NULL,NULL),
(7,'S2 E2 The Darkness Within','s2_e2_the_darkness_within_thumb.png',1,2,'YouTube','https://youtu.be/_U7wKRtf8C4?si=nGKAxMOgs9YDMEPq','free',NULL,'5','TV-MA (Mature Audiences)','04:08',NULL,NULL,'2019-06-09',1,'The team faces their darkest fears and inner demons. 🌑','The team faces their darkest fears and inner demons. As they battle the rising shadows, personal struggles threaten to tear them apart. 🌑',0,'YouTube','https://youtu.be/1sCBEzxF_K4?si=B-rZUby9EXaMWkKD',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_e2_the_darkness_within_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-e2-the-darkness-within',NULL,NULL),
(8,'S2 E3 The Last Stand','s2_e3_the_last_stand_thumb.png',1,2,'YouTube','https://youtu.be/_U7wKRtf8C4?si=nGKAxMOgs9YDMEPq','pay-per-view',NULL,'6','TV-MA (Mature Audiences)','03:53',NULL,NULL,'2019-06-10',1,'A desperate struggle to save humanity from eternal darkness. 🛡️','A desperate struggle to save humanity from eternal darkness. The team unites for a final stand, determined to vanquish the evil once and for all. 🛡️',0,'YouTube','https://youtu.be/7_MJp5AbSwA?si=Mtx9h0wlxtn4o_2Q',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'3','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_e3_the_last_stand_thumb.png',40.00,'onetime',NULL,'10',20,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-e3-the-last-stand',NULL,NULL),
(9,'S1 E1 The Gunslinger Rides Again','s1_e1_the_gunslinger_rides_again_thumb.png',2,3,'YouTube','https://youtu.be/ob8iKn-gLFI?si=sUpU_bMpIDocTFZ6','paid',1,'7','PG-13','02:00',NULL,NULL,'2020-05-03',0,'A legendary gunslinger returns to a lawless town, determined to restore order and seek redemption. 🏜️💥','A legendary gunslinger returns to the lawless town he once fled. Haunted by his past and driven by a desire to restore order, he confronts a landscape rife with crime and corruption. As he reclaims his old territory, the townsfolk look to him as their last hope against the rampant lawlessness. But his arrival stirs up old enemies, setting the stage for a fierce struggle for control. 🌵💥',0,'YouTube','https://youtu.be/8AHMiNxUuPE?si=uUIiune3aZFQPc56',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_the_gunslinger_rides_again_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-the-gunslinger-rides-again',NULL,NULL),
(10,'S1 E2 Showdown at High Noon','s1_e2_showdown_at_high_noon_thumb.png',2,3,'YouTube','https://youtu.be/iABaiZO5Vjs?si=-86t28oJD4cIwkY0','paid',1,'8','PG-14','03:25',NULL,NULL,'2020-05-10',0,'Tensions escalate as the gunslinger faces off against a notorious gang leader in a deadly showdown. 🕛🔥','The gunslinger\'s return shakes the town\'s criminal underbelly, culminating in a high-stakes showdown at high noon. The notorious gang leader, determined to maintain his grip on the town, challenges the gunslinger to a deadly duel. As the sun reaches its zenith, tensions explode in a brutal face-off that will determine the town’s future. The gunslinger must draw on all his skills and courage to survive and restore justice. 🕛🔥',0,'YouTube','https://youtu.be/XvJRBXhRBWo?si=MQ9HEGeXtrhyvi5o',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_showdown_at_high_noon_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-showdown-at-high-noon',NULL,NULL),
(11,'S1 E1 Into the Enchanted Forest','s1_e1_into_the_enchanted_forest_thumb.png',3,4,'YouTube','https://youtu.be/G44HxQpAcI4?si=_k-CjJMC436eRDsV','paid',2,'9','PG (Parental Guidance Suggested)','01:25',NULL,NULL,'2021-06-09',0,'Raziel enters the mystical forest, beginning his heroic journey. 🌲✨','Raziel steps into the enchanted forest, facing magical creatures and mysterious challenges. With determination and courage, he starts his quest to rescue his friend, encountering allies and enemies along the way. 🌲✨',0,'YouTube','https://youtu.be/w2wIsq-M1Ac?si=ui48aPEbC14IbJgV',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_into_the_enchanted_forest_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-into-the-enchanted-forest',NULL,NULL),
(12,'S1 E2 The Guardian\'s Challenge','s1_e2_the_guardians_challenge_thumb.png',3,4,'YouTube','https://youtu.be/yGkGMzupaVs?si=O0EBto49niZjBm_e','paid',2,'5','PG (Parental Guidance Suggested)','02:20',NULL,NULL,'2021-06-16',0,'Raziel must pass a trial set by the forest guardian. 🛡️🌟','As Raziel ventures deeper into the forest, he encounters a wise guardian who sets a challenging trial. To prove his worthiness, Raziel must solve riddles and overcome obstacles, showcasing his bravery and intelligence. 🛡️🌟',0,'YouTube','https://youtu.be/1c3O3-sVFC0?si=8rPDiNHndDz_XIa-',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_the_guardians_challenge_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-the-guardians-challenge',NULL,NULL),
(13,'S2 E1 The Hidden Fortress','s2_e1_the_hidden_fortress_thumb.png',3,5,'YouTube','https://youtu.be/0R3YS_k6a5E?si=k1-dG2Wqap3vkvGQ','paid',2,'6','PG (Parental Guidance Suggested)','01:05',NULL,NULL,'2021-07-08',0,'Raziel discovers Gothel\'s secret fortress and plans his next move. 🏰🔍','Raziel uncovers the location of Gothel\'s hidden fortress, a dark and formidable structure. With newfound allies, he devises a daring plan to infiltrate the fortress and rescue his friend, facing greater dangers than ever before. 🏰🔍',0,'YouTube','https://youtu.be/M2aTryFM6Kg?si=aK8poGJaCpbR5J86',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_e1_the_hidden_fortress_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-e1-the-hidden-fortress',NULL,NULL),
(14,'S2 E2 The Final Showdown','s2_e2_the_final_showdown_thumb.png',3,5,'YouTube','https://youtu.be/UwsbkXkEyOE?si=tNhFI_T6RWg77WNq','paid',2,'3','PG (Parental Guidance Suggested)','01:15',NULL,NULL,'2021-07-09',0,'Raziel confronts Gothel in an epic battle to save his friend. ⚔️🔥','In a climactic showdown, Raziel faces Gothel in a battle of wits and strength. With everything on the line, Raziel must summon all his courage and skills to defeat Gothel and free his friend, bringing his daring rescue mission to a thrilling conclusion. ⚔️🔥',0,'YouTube','https://youtu.be/iw_0KFjRY_Y?si=WjsPaMtnVjHO7x8N',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_e2_the_final_showdown_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-e2-the-final-showdown',NULL,NULL),
(15,'S1 E1 The Midnight Chase','s1_e1_the_midnight_chase_thumb.png',4,6,'YouTube','https://youtu.be/T5UokLYVJMI?si=7DVFmcXSmf5zVGKj','paid',3,'4','TV-MA (Mature Audiences)','02:18',NULL,NULL,'2022-08-05',1,'Detective Black tracks a vital lead through the dark city streets. 🌃🚔','The Midnight Chase plunges viewers into a heart-pounding pursuit through the city. Detective Black, following a crucial lead, navigates the underbelly of the metropolis, facing danger at every turn. As he gets closer to uncovering The Phantom’s next move, the stakes grow higher, and the chase more perilous. 🌃🚔',0,'YouTube','https://youtu.be/DwXrfN_-GuE?si=v4uz4roJylb8w3tx',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_the_midnight_chase_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-the-midnight-chase',NULL,NULL),
(16,'S1 E2 Web of Deceit','s1_e2_web_of_deceit_thumb.png',4,6,'YouTube','https://youtu.be/T5UokLYVJMI?si=7DVFmcXSmf5zVGKj','paid',3,'5','TV-MA (Mature Audiences)','01:10',NULL,NULL,'2022-08-07',1,'A tangled web of lies puts Detective Black in grave danger. 🕸️⚠️','In Web of Deceit, Detective Black uncovers a complex network of deception that threatens his mission. With allies turning into enemies and truth entwined with lies, he must tread carefully to avoid deadly traps. The episode is a thrilling exploration of trust, betrayal, and the relentless quest for justice. 🕸️⚠️',0,'YouTube','https://youtu.be/alT7IxwYd6U?si=hmf8B75acVelyLS3',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_web_of_deceit_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-web-of-deceit',NULL,NULL),
(17,'S2 E1 Shadows in the Dark','s2_e1_shadows_in_the_dark_thumb.png',4,7,'YouTube','https://youtu.be/N5d16cUKqu0?si=xGfISG2Yw1ho9bzj','paid',3,'9','TV-MA (Mature Audiences)','01:08',NULL,NULL,'2022-08-09',1,'Detective Black uncovers hidden clues in the darkest corners of the city. 🕵️‍♂️🌑','In Shadows in the Dark, Detective Black ventures into the most dangerous and obscure parts of the city to uncover hidden clues that could lead to The Phantom. As he navigates through abandoned buildings and forgotten alleyways, he encounters unexpected allies and faces deadly ambushes. Each discovery brings him closer to understanding The Phantom\'s master plan, but the journey is fraught with peril and intrigue. 🕵️‍♂️🌑',0,'YouTube','https://youtu.be/EiHzphCFBqE?si=OfKTr8nEozYOd5wP',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_e1_shadows_in_the_dark_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-e1-shadows-in-the-dark',NULL,NULL),
(18,'S1 E1 The Haunted Arrival','s1_e1_the_haunted_arrival_thumb.png',5,8,'YouTube','https://youtu.be/bX-PTsk0SPQ?si=joyPGPGvhXxxRi2o','paid',4,'7','TV-MA (Mature Audiences)','02:08',NULL,NULL,'2023-09-14',1,'New residents experience eerie occurrences as they settle into their home. 🏚️👀','In The Haunted Arrival, a new family moves into an old mansion in Ravenwood, unaware of the horrors that await them. Strange noises, ghostly apparitions, and unexplainable events soon plague their daily lives. As they seek help from locals, they begin to unravel the mansion\'s dark past and the malevolent spirit that resides within. 🏚️👀',0,'YouTube','https://youtu.be/mPtCeemqdE0?si=vfZgZoBE4QPdlfp4',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_the_haunted_arrival_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-the-haunted-arrival',NULL,NULL),
(19,'S1 E2 Echoes of the Past','s1_e2_echoes_of_the_past_thumb.png',5,8,'YouTube','https://youtu.be/V6wWKNij_1M?si=T0CX05U6pKcEyyOM','paid',4,'5','TV-MA (Mature Audiences)','03:08',NULL,NULL,'2023-09-15',1,'Residents uncover hidden secrets in an old diary that leads to terrifying revelations. 📖😱','Echoes of the Past follows the residents as they find an old diary hidden in the mansion\'s attic. The diary reveals chilling accounts of previous inhabitants and the horrors they faced. As they read further, the current residents realize that the malevolent spirit is more powerful and dangerous than they imagined. With each page, the terror escalates, bringing them closer to the truth and deeper into danger. 📖😱',0,'YouTube','https://youtu.be/2ODO6tIIzN0?si=2mobmPhb3V_vS58g',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_echoes_of_the_past_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-echoes-of-the-past',NULL,NULL),
(20,'S1 E3 Whispers in the Shadows','s1_e3_whispers_in_the_shadows_thumb.png',5,8,'YouTube','https://youtu.be/7FfGW-2dpx8?si=ed1gFGTajO5jkQ0t','paid',4,'2','TV-MA (Mature Audiences)','04:08',NULL,NULL,'2023-09-22',1,'Mysterious voices haunt the residents of Ravenwood, foretelling ominous events. 🗣️🌑','Whispers in the Shadows explores the unsettling phenomenon plaguing Ravenwood\'s inhabitants as eerie voices echo through the town, hinting at dark and foreboding events to come. As paranoia grips the community and tensions rise, the residents must decipher the cryptic messages before they fall prey to the malevolent forces lurking in the shadows. The episode unravels layers of fear and intrigue, pushing the characters to confront their deepest fears in a race against time to uncover the truth behind the whispered omens. 🗣️🌑',0,'YouTube','https://youtu.be/2ul2vOA39cU?si=jrg8Y0eur17V8A8r',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'3','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e3_whispers_in_the_shadows_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e3-whispers-in-the-shadows',NULL,NULL),
(21,'S2 E1 The Return of Darkness','s2_e1_the_return_of_darkness_thumb.png',5,9,'YouTube','https://youtu.be/2X7G6p-oNG8?si=m0TREbT6RB_rppT_','paid',4,'3','TV-MA (Mature Audiences)','05:08',NULL,NULL,'2023-11-03',1,'Dark forces grow stronger, and the town faces renewed terror. 🖤🕯️','In The Return of Darkness, the malevolent forces in Ravenwood grow even stronger, casting a deeper shadow over the town. The residents, now aware of the historical curses, find themselves facing new and more terrifying manifestations. As they fight to protect their loved ones, they uncover more about the nature of the darkness that plagues their home. 🖤🕯️',0,'YouTube','https://youtu.be/Bfdirk3dCew?si=MVE2OfPUWhjY7bQX',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_e1_the_return_of_darkness_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-e1-the-return-of-darkness',NULL,NULL),
(22,'S2 E2 The Shadow\'s Grasp','s2_e2_the_shadows_grasp_thumb.png',5,9,'YouTube','https://youtu.be/IuqaXBFS0ug?si=Gz7n0cIeja5gCuOu','paid',4,'6','TV-MA (Mature Audiences)','06:08',NULL,NULL,'2023-11-10',1,'The town\'s residents struggle against the encroaching darkness as secrets come to light. 🌑🖤','In The Shadow\'s Grasp, the encroaching darkness begins to engulf Ravenwood, causing widespread fear and chaos. As the town\'s residents fight to survive, they uncover more secrets about the malevolent forces and their connection to the town\'s history. The episode highlights their desperate attempts to combat the evil while dealing with personal sacrifices and unexpected revelations. 🌑🖤',0,'YouTube','https://youtu.be/9ZXFaaQJb0c?si=mErWWDpqEFzijyRA',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_e2_the_shadows_grasp_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-e2-the-shadows-grasp',NULL,NULL),
(23,'S1 E1 The Silent Witness','s1_e1_the_silent_witness_thumb.png',6,10,'YouTube','https://youtu.be/em1ec7BZHJw?si=MSD31eT22XrZ7ohu','free',NULL,'1','TV-MA (Mature Audiences)','03:28',NULL,NULL,'2024-01-11',1,'Investigator Reed finds a crucial clue from an unexpected silent witness. 🕵️‍♂️🔎','In The Silent Witness, Investigator Reed discovers a crucial clue from an unexpected source — a silent witness whose testimony could unravel the mystery. As he pieces together the information, he uncovers a pattern that points to a much larger conspiracy. The episode is filled with tension and the slow, deliberate uncovering of hidden truths. 🕵️‍♂️🔎',0,'YouTube','https://youtu.be/_2un1aU7mT0?si=Ztan6plG7Is5osDt',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_the_silent_witness_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-the-silent-witness',NULL,NULL),
(24,'S1 E2 Web of Lies','s1_e2_web_of_lies_thumb.png',6,10,'YouTube','https://youtu.be/m1J8sqBex18?si=SqY0DIpLR7Lr13Sk','pay-per-view',NULL,'6','TV-MA (Mature Audiences)','02:43',NULL,NULL,'2024-01-18',1,'Reed navigates a tangled web of lies to find the truth behind a high-profile crime. 🕸️⚖️','Web of Lies sees Investigator Reed diving deep into a complex network of deception surrounding a high-profile crime. As he navigates through false leads and deceitful informants, he gets closer to the truth, but also finds himself in greater danger. The episode is a thrilling exploration of the lengths people will go to keep their secrets hidden. 🕸️⚖️',0,'YouTube','https://youtu.be/epVRE3nWWAg?si=pLxJXbcPhmIuLYe0',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_web_of_lies_thumb.png',10.00,'rental',5,'10',20,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-web-of-lies',NULL,NULL),
(25,'S1 E3 The Hidden Code','s1_e3_the_hidden_code_thumb.png',6,10,'YouTube','https://youtu.be/SjkcA2ZCmDU?si=F9hJLcsxVvJCfDta','pay-per-view',NULL,'4','TV-MA (Mature Audiences)','03:20',NULL,NULL,'2024-01-25',1,'Reed deciphers a cryptic code that leads him closer to the heart of the conspiracy. 🔍🗝️','In The Hidden Code, Investigator Reed discovers a cryptic code embedded in seemingly unrelated pieces of evidence. As he deciphers the code, it leads him closer to the heart of the conspiracy, revealing connections he never expected. The episode is a thrilling blend of puzzle-solving and suspense, as Reed races against time to stay ahead of those who would do anything to keep the secrets hidden. 🔍🗝️',0,'YouTube','https://youtu.be/-WzB5wqpkbg?si=snkkYmtcH9TuuUEb',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'3','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e3_the_hidden_code_thumb.png',10.00,'rental',5,'10',20,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e3-the-hidden-code',NULL,NULL),
(26,'S1 E1 Echoes of the Emerald','s1_e1_echoes_of_the_emerald_thumb.png',7,11,'YouTube','https://youtu.be/7VXOHmaTd7g?si=Qjm-q92VPXnVG5NN','paid',1,'2','TV-MA (Mature Audiences)','03:28',NULL,NULL,'2024-02-01',0,'Emily is drawn into Oz after receiving cryptic messages, discovering that her grandmother’s past is not just a story, but a nightmare waiting for her.','Emily Gale receives mysterious messages linked to her grandmother’s past, leading her to a cursed book left behind by Dorothy. Curious yet fearful, she follows the clues, only to find herself trapped in a decaying version of Oz. There, she is haunted by visions of a once-great land, now overrun with dangerous shadows and monstrous creatures. As she struggles to understand her grandmother’s connection to the forgotten world, Emily realizes that her fate is intertwined with the horrors that now lurk within. 🌪️📜🖤',0,'YouTube','https://youtu.be/A5fBmZHgcT0?si=n8vuYfPWIsQCkMwg',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_echoes_of_the_emerald_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-echoes-of-the-emerald',NULL,NULL),
(27,'S1 E2 The Curse Unveiled','s1_e2_the_curse_unveiled_thumb.png',7,11,'YouTube','https://youtu.be/H0u8yO9kiAA?si=V__ZIHm_Pu3yCqI8','paid',1,'7','TV-MA (Mature Audiences)','02:43',NULL,NULL,'2024-02-08',0,'Emily encounters a mysterious figure from her grandmother’s past, who reveals the true nature of the curse that haunts the Gale family.','Emily comes face to face with a figure who claims to have fought alongside her grandmother, Dorothy, in a battle to contain the dark forces of Oz. This stranger reveals the shocking truth: Dorothy never truly defeated the evil lurking in Oz; she merely contained it. Now, with Dorothy gone, the evil has been unleashed again, and it is hungry for revenge. Emily learns that her journey is not just one of survival, but of destiny. As the darkness grows around her, Emily must decide whether to embrace her family’s legacy or fall victim to the curse. 🌑🔮🖋️',0,'YouTube','https://youtu.be/7-Sy9azQIC8?si=fFrb5lgs0BTcLzs6',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_the_curse_unveiled_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-the-curse-unveiled',NULL,NULL),
(28,'S2 E1 The Forgotten Kingdom','s2_e1_the_forgotten_kingdom_thumb.png',7,12,'YouTube','https://youtu.be/PI4Z7t3AZ5E?si=QNKYohZ1ZgLol_OP','paid',1,'9','TV-MA (Mature Audiences)','03:20',NULL,NULL,'2024-02-11',0,'Emily stumbles upon the ruins of the Emerald City, where she faces her first true battle against the creatures of Oz and uncovers a shocking revelation about her grandmother.','\"The Forgotten Kingdom\" sees Emily journey deeper into the haunted lands of Oz, where she discovers the ruins of the once-glorious Emerald City. The streets are empty, and the city’s vibrant green glow has faded into a lifeless grey. As she explores the eerie remnants of the kingdom, Emily encounters dangerous creatures—twisted versions of the characters her grandmother once knew. In a harrowing battle, she is forced to rely on her instincts and newfound strength. Amid the chaos, Emily uncovers a hidden journal that reveals secrets about Dorothy’s time in Oz and the real reason behind the family curse. 🏰🌲⚔️',0,'YouTube','https://youtu.be/-I2mVPRZ2_c?si=rb2c2k8wXRepTp5v',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_e1_the_forgotten_kingdom_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-e1-the-forgotten-kingdom',NULL,NULL),
(29,'S1 E1 The New Moon','s1_e1_the_new_moon_thumb.png',8,13,'YouTube','https://youtu.be/MAFsRmx6pPo?si=CJjoeRbHVtKJt9oC','free',NULL,'8','TV-MA (Mature Audiences)','03:28',NULL,NULL,'2024-02-15',0,'🌑 Maddy’s life takes a dramatic turn when she meets Rhydian, a boy with an unknown connection to her wolfblood pack.','🌑 Maddy, a confident young wolfblood, is used to keeping her secret hidden from the world. But everything changes when a new boy, Rhydian, arrives at her school. He smells like her pack, yet he’s completely unaware of his wolfblood nature. Suspicious and intrigued, Maddy decides to uncover his secrets, leading her into a world of danger she never expected. Will Rhydian accept his true identity, or will his rebellious streak threaten them both? 🐺⚔️',0,'YouTube','https://youtu.be/cYCcnV0YO1U?si=ZLrL3UVoHmf9JY4V',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_the_new_moon_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-the-new-moon',NULL,NULL),
(30,'S1 E2 Pack Bonds','s1_e2_pack_bonds_thumb.png',8,13,'YouTube','https://youtu.be/GKq7QlNz3CA?si=E6fnSD4CvpEPcMu7','pay-per-view',NULL,'4','TV-MA (Mature Audiences)','02:43',NULL,NULL,'2024-02-15',0,'🐺 Rhydian struggles to come to terms with his new reality as Maddy tries to teach him the ways of the wolfbloods.','🐺 As Rhydian begins to process the truth about his wolfblood heritage, Maddy steps in to guide him through the transformation process. But things aren’t easy—Rhydian’s rebellious nature causes friction, and the dangers of exposure grow as strange happenings around town raise suspicion. With hunters lurking nearby, Maddy must help Rhydian quickly adapt, or they’ll both risk the safety of their pack. Bonds of trust will be tested, and survival depends on their ability to work together. 🌕🔥👣',0,'YouTube','https://youtu.be/2c1X2wmqxZs?si=-BhAYJvr_f8AUpGj',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_pack_bonds_thumb.png',10.00,'rental',5,'10',20,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-pack-bonds',NULL,NULL),
(31,'S1 E1 Call of the Ancestors','s1_e1_call_of_the_ancestors_thumb.png',9,14,'YouTube','https://youtu.be/iJkspWwwZLM?si=chtl8vdmLqPNKPfE','free',NULL,'6','TV-MA (Mature Audiences)','03:08',NULL,NULL,'2024-02-20',0,'🌿 As invaders approach, tribal leaders must decide whether to unite or face destruction alone.','🌿 In the opening episode, the tribes are scattered and in disarray. When the threat of invaders looms on the horizon, ancient prophecies begin to unfold. A young warrior from the Mountain Tribe receives a vision from his ancestors, urging him to unite the tribes. However, distrust and rivalry run deep among the leaders. As the invaders draw nearer, the tribes must decide whether to join forces or perish alone. The episode sets the stage for the epic struggle ahead, filled with suspense, political intrigue, and the first hints of war. ⚔️🌄🔥',0,'YouTube','https://youtu.be/VOwUgraDBFI?si=1IUq1nOWZzSogcE8',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_call_of_the_ancestors_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-call-of-the-ancestors',NULL,NULL),
(32,'S1 E2 Forging Alliances','s1_e2_forging_alliances_thumb.png',9,14,'YouTube','https://youtu.be/6sxnOLRGkhw?si=WrBfEDVah3Z-vFwO','pay-per-view',NULL,'9','TV-MA (Mature Audiences)','04:02',NULL,NULL,'2024-02-21',0,'Tribes unite to protect their sacred land from invaders, forging a timeless legacy of courage and unity. 🛡️🔥🌄','Amidst the rugged terrain of ancient lands, many tribes rise against the threats that seek to desecrate their sacred homeland. As they fight to preserve their heritage, their bravery and unity carve an enduring legacy that will resonate through the ages. 🐺🌟⚔️',0,'YouTube','https://youtu.be/o0OkTEK9KKs?si=BDW4TC4uDF7VluOz',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_forging_alliances_thumb.png',10.00,'rental',5,'10',20,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-forging-alliances',NULL,NULL),
(33,'S1 E1 The Final Watch','s1_e1_the_final_watch_thumb.png',10,15,'YouTube','https://youtu.be/QROfT5dT_yQ?si=jt4LxdBIIe5h7xY_','paid',4,'4','TV-MA (Mature Audiences)','02:50',NULL,NULL,'2024-03-01',0,'During the Indo-Pak War, \"The Final Watch\" follows a sniper and his spotter grappling with moral dilemmas as they hunt their enemies amidst intense conflict. 🎯','In \"The Final Watch,\" set against the backdrop of the Indo-Pak War, a sniper and his spotter are embroiled in a moral struggle while navigating the battlefield. The film delves into the complexities of war, showcasing suspense, drama, and a hauntingly beautiful soundtrack that resonates with the film\'s themes of sacrifice and duty. 🎖️🔥',0,'YouTube','https://youtu.be/JEKCMP3w9zs?si=psaIC0wKC3akDOqp',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_the_final_watch_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-the-final-watch',NULL,NULL),
(34,'S1 E2 The Silent Marksman','s1_e2_the_silent_marksman_thumb.png',10,15,'YouTube','https://youtu.be/s2-1hz1juBI?si=OG5eOFO6QnSfLiFb','paid',4,'6','TV-MA (Mature Audiences)','03:45',NULL,NULL,'2024-03-08',0,'In \"The Silent Marksman,\" a sniper and his spotter face a moral dilemma while hunting their enemies during the Indo-Pak War, set against a dramatic and suspenseful backdrop. 🎯','The Silent Marksman follows a sniper and his spotter as they navigate the complexities of war during the Indo-Pak conflict. As they engage in high-stakes combat, they must confront their own moral questions and the harsh realities of their mission. With a gripping narrative and a poignant musical score, the film provides a deep exploration of duty and sacrifice. 🎖️💔',0,'YouTube','https://youtu.be/AWuxeDm1SGA?si=5rZ3rc4LnLYtmJ2u',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_the_silent_marksman_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-the-silent-marksman',NULL,NULL),
(35,'S1 E3 Last Stand: Retreat of Valor','s1_e3_last_stand_retreat_of_valor_thumb.png',10,15,'YouTube','https://youtu.be/hf8EYbVxtCY?si=ayaY0YZtZu4seFnF','paid',4,'8','TV-MA (Mature Audiences)','04:15',NULL,NULL,'2024-03-15',0,'Abandoned by their retreating army, a group of soldiers makes a heroic last stand in the face of danger. 🛡️🔥','Last Stand: Retreat of Valor follows a brave group of German soldiers who are left stranded after their army retreats. As they face betrayal, relentless enemies, and dwindling supplies, they must summon their inner strength and make their final stand in a war-torn battlefield. 🛡️🔥⚔️',0,'YouTube','https://youtu.be/PdxPlbKFkaM?si=H_nwgJKc4Ioqj1tR',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'3','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e3_last_stand_retreat_of_valor_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e3-last-stand-retreat-of-valor',NULL,NULL),
(36,'S1 E1 The Battle of PT-76','s1_e1_the_battle_of_pt_76_thumb.png',11,16,'YouTube','https://youtu.be/5dTtuN5BceI?si=rQukzFVuulLJY3K4','free',NULL,'4','TV-MA (Mature Audiences)','05:20',NULL,NULL,'2024-03-16',0,'Captain Balram Singh Mehta’s heroic efforts with the Indian 45 Cavalry during the 1971 Indo-Pakistani War, leading the charge for Bangladesh’s independence. 🚩🌟','The Battle of PT-76 tells the gripping story of Captain Balram Singh Mehta and his regiment as they engage in crucial battles during the 1971 Indo-Pakistani War. Named after the amphibious PT-76 tank, the film showcases Mehta’s rise to prominence as he navigates the trials of war and strives to secure Bangladesh\'s freedom. A tale of valor and dedication, underscoring a significant historical moment. 🏆🚀',0,'YouTube','https://youtu.be/vAp-9i4mFBQ?si=53kE_c6K8fftINMb',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_the_battle_of_pt_76_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-the-battle-of-pt-76',NULL,NULL),
(37,'S1 E2 Apocalypse Vault','s1_e2_apocalypse_vault_thumb.png',11,16,'YouTube','https://youtu.be/HHJkUQGm2H8?si=ciuK8Jd5Mp4vyHTe','pay-per-view',NULL,'7','TV-MA (Mature Audiences)','06:45',NULL,NULL,'2024-03-17',0,'A crew of mercenaries must pull off an impossible heist in a zombie-infested Las Vegas before the city is nuked. 🧟‍♂️🔥💵','A group of elite thieves is tasked with infiltrating a walled-off, zombie-overrun Las Vegas to retrieve $200 million. With the clock ticking and deadly Alpha zombies closing in, this high-stakes mission becomes a race for survival. 🧟‍♂️🔥💣💵',0,'YouTube','https://youtu.be/iwA8ooWRNBs?si=JqXh28NIx2Dgk8aA',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_apocalypse_vault_thumb.png',10.00,'rental',5,'10',20,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-apocalypse-vault',NULL,NULL),
(38,'S1 E1 Depths of Discovery','s1_e1_depths_of_discovery_thumb.png',12,17,'YouTube','https://youtu.be/rze8QYwWGMs?si=UQIYYM4LQtxLTILi','paid',1,'1','TV-MA (Mature Audiences)','03:10',NULL,NULL,'2024-04-13',0,'The team descends into the Earth’s core, unveiling ancient secrets and battling unknown forces in their quest to unlock the mysteries of the planet\'s inner depths. 🌋🌪️','A thrilling expedition into the Earth’s core unearths a dangerous, ancient world in this action-packed adventure. 🌍⚒️ In \"Depths of Discovery,\" a scientist, his curious nephew, and an experienced mountain guide descend into the earth’s core on a daring mission to find his missing brother. What awaits them is an extraordinary world filled with prehistoric creatures, uncharted landscapes, and unknown dangers. Their journey turns into a heart-pounding adventure of survival and self-discovery. 🌍🦕⚒️',0,'YouTube','https://youtu.be/M6h5AS971hY?si=T7Sf0Gjetp_7Ld2C',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_depths_of_discovery_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-depths-of-discovery',NULL,NULL),
(39,'S1 E2 Into the Earth\'s Core','s1_e2_into_the_earths_core_thumb.png',12,17,'YouTube','https://youtu.be/jzQn0-WH4WM?si=BLrfsFpVGzCttbRF','paid',1,'6','TV-MA (Mature Audiences)','04:15',NULL,NULL,'2024-04-14',0,'A scientist and his companions uncover a dangerous lost world hidden beneath the Earth\'s surface, fighting to survive in an epic action-adventure. 🌋🦕','Into the Earth\'s Core follows a group of explorers as they delve into the unknown in search of a missing brother. What begins as a scientific quest soon transforms into a perilous journey, where danger lurks around every corner and survival is far from guaranteed. Facing monstrous creatures and earth-shattering discoveries, they must push beyond their limits to make it back alive. 🌋⚠️🦖',0,'YouTube','https://youtu.be/gkBEd41mOIo?si=yItQlzbz60lijY9m',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_into_the_earths_core_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-into-the-earths-core',NULL,NULL),
(40,'S1 E3 Clash of Empires','s1_e3_clash_of_empires_thumb.png',12,17,'YouTube','https://youtu.be/rFq52e7wYws?si=n4XnFfiHBI3pBko4','paid',1,'3','PG (Parental Guidance Suggested)','02:50',NULL,NULL,'2024-04-15',0,'Clash of Empires unfolds in a world torn apart by conflict between rival factions. The Alliance and Horde engage in a fierce struggle, with legendary warriors, powerful magic, and unstoppable armies driving the chaos. 🏰⚔️💥','The ultimate battle for supremacy erupts as two powerful factions clash in a world-altering war. 🏰💥⚔️',0,'YouTube','https://youtu.be/AWuxeDm1SGA?si=5rZ3rc4LnLYtmJ2u',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'3','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e3_clash_of_empires_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e3-clash-of-empires',NULL,NULL),
(41,'S1 E1 Cutting Edge Chaos','s1_e1_cutting_edge_chaos_thumb.png',13,18,'YouTube','https://youtu.be/hSxLUd8aly4?si=ishR_1RLpsgRm1R_','paid',3,'1','PG (Parental Guidance Suggested)','03:20',NULL,NULL,'2024-04-28',1,'The Razor\'s Edge - A janitor-turned-barber accidentally stumbles into a world of espionage, where every haircut leads to explosive action. ✂️🕶️💣','When an unsuspecting janitor, Jack, is mistaken for the new barber at an underground espionage hideout, he’s thrust into a whirlwind of high-octane action. Armed only with barber tools, Jack must fight off international spies and uncover hidden secrets, all while delivering the sharpest haircuts of his life. ✂️💣🕵️‍♂️💥',0,'YouTube','https://youtu.be/OthBEy73VQ4?si=PdWE8bicX90lhHKb',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_cutting_edge_chaos_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-cutting-edge-chaos',NULL,NULL),
(42,'S1 E2 Snip & Strike','s1_e2_snip_strike_thumb.png',13,18,'YouTube','https://youtu.be/OxLQZVmKWEo?si=RYQIiu7LQpnSfdRf','paid',3,'4','PG (Parental Guidance Suggested)','03:28',NULL,NULL,'2024-04-29',1,'A hairstylist becomes an unlikely hero as he battles criminals in a salon over a hidden microchip. Snips turn into strikes in this thrilling action adventure! ✂️🕶️⚔️','Leo, a mild-mannered hairstylist, is forced to become a hero when a gang of criminals invade his salon, looking for a hidden microchip that could change the world. Using only his barber skills and quick wit, Leo must outsmart the villains and save the day, turning an ordinary haircut into a high-stakes showdown. ✂️💥💈🕵️‍♂️',0,'YouTube','https://youtu.be/13FLawVtwSc?si=Wsdj4GsSHoCq0VsP',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_snip_strike_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-snip-strike',NULL,NULL),
(43,'S1 E3 The Barber\'s Edge','s1_e3_the_barbers_edge_thumb.png',13,18,'YouTube','https://youtu.be/-Qv6p6pTz5I?si=aeaLICb9s9VAgl4W','paid',3,'5','PG (Parental Guidance Suggested)','02:43',NULL,NULL,'2024-04-30',1,'Mr. Cool must defend his barbershop and secret hair formula from enemy agents, using only his quirky charm and barber tools. ✂️💣💇‍♂️','Mr. Cool is unwittingly caught in a conspiracy involving a top-secret hair formula hidden in his barbershop. Chaos ensues when rival agents and dangerous criminals come after him, forcing Bean to fight back using only barber tools and his incredible knack for slapstick combat. ✂️🕶️💣💇‍♂️',0,'YouTube','https://youtu.be/QTli1HU9axY?si=wgvnUQBuY2rVXJn0',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'3','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e3_the_barbers_edge_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e3-the-barbers-edge',NULL,NULL),
(44,'S1 E4 Cut to the Chase','s1_e4_cut_to_the_chase_thumb.png',13,18,'YouTube','https://youtu.be/dKkT8_RGDYg?si=4gdepK-sTlGcxcPw','paid',3,'6','PG (Parental Guidance Suggested)','03:08',NULL,NULL,'2024-05-01',1,'Mr. Bean\'s bad haircut turns into a wild chase as he accidentally gets involved in a spy mission, running from both criminals and the law! ✂️🚗🔥','Cut to the Chase sees Mr. Bean accidentally tangled in an international spy ring when a client he gives a terrible haircut to turns out to be a wanted criminal. Now, with both criminals and law enforcement after him, Bean must dodge bullets and hair clippers as he races through the city in his Mini, turning every barber shop into a battleground. 🚗✂️🕶️🔥',0,'YouTube','https://youtu.be/kSGrk5gVkmM?si=YJbvb2tBrC490XKe',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'4','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e4_cut_to_the_chase_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e4-cut-to-the-chase',NULL,NULL),
(45,'S2 E1 Blade Runner: Salon Showdown','s2_e1_blade_runner_salon_showdown_thumb.png',13,19,'YouTube','https://youtu.be/7mT8El4mBVw?si=QURW5DdZ0HMm1wOm','paid',3,'9','PG (Parental Guidance Suggested)','03:20',NULL,NULL,'2024-05-02',1,'Ethan, a former special ops agent turned barber, is pulled back into action when his old nemesis resurfaces, targeting his salon as the front for a dangerous arms deal. 💈✂️💥🕵️‍♂️','A retired special ops agent turned barber must fend off a criminal syndicate using only his skills and tools in an epic salon showdown. ✂️💣💈',0,'YouTube','https://youtu.be/FG3ohfDASao?si=urEsRJhkQmg5YDI4',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_e1_blade_runner_salon_showdown_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-e1-blade-runner-salon-showdown',NULL,NULL),
(46,'S2 E2 Lens Lunacy: The Great Camera Caper','s2_e2_lens_lunacy_the_great_camera_caper_thumb.png',13,19,'YouTube','https://youtu.be/eH7EyPs_Va8?si=BRcgB15dMbdoEj7G','paid',3,'5','PG (Parental Guidance Suggested)','04:15',NULL,NULL,'2024-05-03',1,'When a beloved camera goes missing, a well-meaning but hapless amateur sleuth takes on the challenge of finding it. With a mix of slapstick humor and endearing blunders, he navigates through a series of comedic escapades, learning that sometimes laughter is the best tool for solving a mystery. 📸🎭🔎','A bumbling detective’s quest to recover his stolen camera turns into a comedy of errors and mishaps. 📷😂🕵️‍♂️',0,'YouTube','https://youtu.be/UD-22FD3GQo?si=ROszF3zF7jHwcBgb',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_e2_lens_lunacy_the_great_camera_caper_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-e2-lens-lunacy-the-great-camera-caper',NULL,NULL),
(47,'S1 E1 Waves of the Past','s1_e1_waves_of_the_past_thumb.png',14,20,'YouTube','https://youtu.be/xqzR_h3_84c?si=bpYToPY4e4uZ76oV','free',NULL,'7','TV-MA (Mature Audiences)','06:45',NULL,NULL,'2024-05-02',0,'A legendary football star confronts his past mistakes while teaching a group of kids the fundamentals of baseball. As he learns from their determination, he starts to see life in a new light. ⚾🏆🌊','In \"Waves of the Past\", the star athlete, once a pro football legend, takes on the daunting task of coaching a ragtag team of kids in baseball. With little experience in the sport, he struggles to connect with the kids, haunted by his own past failures. As the children begin to open up to him, the waves of his past mistakes start to surface, pushing him to face the life lessons he’s avoided for years. In teaching the kids how to win on the field, he learns valuable lessons on how to find redemption and inner strength. ⚾🏆🌊',0,'YouTube','https://youtu.be/XbP-Mc1RDEg?si=RFJqHSXMUkvCfmnZ',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_waves_of_the_past_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-waves-of-the-past',NULL,NULL),
(48,'S1 E2 Pit Stops and Breakdowns','s1_e2_pit_stops_and_breakdowns_thumb.png',14,20,'YouTube','https://youtu.be/pRH5u5lpArQ?si=ld4xRo9ELtLQXzbN','free',NULL,NULL,'TV-MA (Mature Audiences)','03:10',NULL,NULL,'2024-05-04',0,'After a tough start, the coach faces new challenges both on and off the field. When things fall apart, the kids teach him that the journey is just as important as the destination. 🛠️⚾🛑','In \"Pit Stops and Breakdowns\", the coach’s frustration reaches a breaking point as the baseball team faces multiple setbacks during their early training sessions. Off the field, his personal life begins to unravel, mirroring the chaos on the diamond. The kids, however, show him that perseverance, even through small pit stops and breakdowns, is the key to success. Through their humor and resilience, the coach starts to realize that life, much like the game, is about bouncing back from mistakes and enjoying the ride, not just focusing on the final score. 🛠️⚾🛑',0,'YouTube','https://youtu.be/F2nO-6mzCF8?si=V3pk2XavKdRQSa5Z',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_pit_stops_and_breakdowns_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-pit-stops-and-breakdowns',NULL,NULL),
(49,'S1 E3 Bridges and Boundaries','s1_e3_bridges_and_boundaries_thumb.png',14,20,'YouTube','https://youtu.be/5eQKOr6sFgk?si=aGYzXoiBPFTf1XtA','free',NULL,'9','TV-MA (Mature Audiences)','04:15',NULL,NULL,'2024-05-06',0,'As relationships grow, the coach struggles with setting boundaries while building emotional bridges with the kids. Their bond becomes the key to success both on and off the field. 🌉⚾❤️','In \"Bridges and Boundaries\", the coach finds himself balancing the growing bond between himself and the kids, while still trying to keep professional boundaries. As the team begins to show progress, personal conflicts arise, forcing the coach to question how deeply he should involve himself in their lives. Through moments of tension and heartfelt revelations, he begins to build emotional bridges with the kids, discovering that strong relationships are the foundation of success, whether in sports or in life. As the team starts to come together, so does the coach’s understanding of what it means to truly lead and inspire. 🌉⚾❤️',0,'YouTube','https://youtu.be/nohSnrV2CgE?si=6HiPnf176gJ9VNdm',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'3','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e3_bridges_and_boundaries_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e3-bridges-and-boundaries',NULL,NULL),
(50,'S1 E1 Grandpa\'s Hectic Heirlooms','s1_e1_grandpas_hectic_heirlooms_thumb.png',15,21,'YouTube','https://youtu.be/mJ_Tex6KT6w?si=0bhjIh5zYTZlk9EU','free',NULL,'4','TV-MA (Mature Audiences)','02:50',NULL,NULL,'2024-06-21',0,'A wealthy man’s glamorous life turns chaotic with the arrival of his six lively grandchildren, leading to hilarious lessons in family values. 👴👨‍👩‍👧‍👦🤣','David McDoll’s posh life hits a comedic snag when he inherits six energetic grandchildren. His once-perfect world is thrown into delightful chaos as the kids upend his lavish lifestyle. Amidst the laughter and mayhem, David discovers the joys of family life and the value of putting loved ones first. 👴🎢🏡😂',0,'YouTube','https://youtu.be/4hA2ZuK5axU?si=0koN4EoSNXUXaXaH',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_grandpas_hectic_heirlooms_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-grandpas-hectic-heirlooms',NULL,NULL),
(51,'S1 E2 Chaos at the McDoll Mansion','s1_e2_chaos_at_the_mcdoll_mansion_thumb.png',15,21,'YouTube','https://youtu.be/bgeRUptdlqU?si=xylQNW3eZdIDQ-_Y','free',NULL,'7','TV-MA (Mature Audiences)','03:20',NULL,NULL,'2024-06-22',0,'A wealthy man’s life is hilariously transformed when his six grandkids turn his mansion into a comedic playground, teaching him the true meaning of family. 🏰👨‍👩‍👧‍👦😂','David McDoll’s opulent world is turned upside down when his six spirited grandchildren move in. From fancy cars to family feuds, the mansion becomes a whirlwind of laughter and mishaps. David’s journey from a self-absorbed tycoon to a loving grandfather is packed with humor and heart. 🏰👶🚗😂',0,'YouTube','https://youtu.be/X0K5cA2hS6g?si=dCiATYDWrJmKK86q',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_chaos_at_the_mcdoll_mansion_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-chaos-at-the-mcdoll-mansion',NULL,NULL),
(52,'S1 E3 Grandpa\'s Wild Ride','s1_e3_grandpas_wild_ride_thumb.png',15,21,'YouTube','https://youtu.be/skl7gYRZHwE?si=kiekCHcihmEJH54D','free',NULL,'6','TV-MA (Mature Audiences)','03:28',NULL,NULL,'2024-06-23',0,'Jason Kelly’s meticulously planned life takes a hilarious detour when he’s roped into driving his rambunctious grandfather, Dick, to Daytona Beach. What starts as a routine trip becomes a wild adventure full of raucous parties, unexpected encounters, and karaoke chaos. 🚗🎉🎤','A straight-laced groom-to-be finds his life upended by his wild grandfather’s outrageous spring break escapades, leading to a comedy-filled journey of discovery and family bonding. 🚗😂🎉',0,'YouTube','https://youtu.be/D7vcG9bHtJI?si=ndF6thZ6eEMZ79-v',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'3','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e3_grandpas_wild_ride_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e3-grandpas-wild-ride',NULL,NULL),
(53,'S1 E4 Funeral Frenzy','s1_e4_funeral_frenzy_thumb.png',15,21,'YouTube','https://youtu.be/0Ji6i79LiL8?si=IIG3-D6Jl72oJq0_','free',NULL,'9','TV-MA (Mature Audiences)','02:43',NULL,NULL,'2024-06-24',0,'A family patriarch\'s doorstep death turns into a hilarious fiasco. Amid old family feuds and a well-meaning paramedic\'s attempts to help, the funeral becomes a comedy of errors and misunderstandings, leaving everyone in stitches. 💔🚨😂','Funeral Frenzy kicks off with the sudden death of the estranged Jones family patriarch right on their doorstep. As a well-intentioned paramedic tries to assist, he finds himself in the midst of a whirlwind of old family feuds and unresolved conflicts. The funeral turns into a series of hilarious escapades and mishaps as the family grapples with their differences and attempts to navigate through the chaos. Prepare for a comedy of errors and family revelations that will leave everyone in stitches! 💔🎩🚨😂',0,'YouTube','https://youtu.be/JAoR9u85DQ0?si=JggaatJIEG5HxlOm',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'4','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e4_funeral_frenzy_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e4-funeral-frenzy',NULL,NULL),
(54,'S1 E1 Beneath the Mask','s1_e1_beneath_the_mask_thumb.png',16,22,'YouTube','https://youtu.be/WTLgg8oRSBE?si=SDS3_CB0MY1zNzko','paid',1,'5','TV-MA (Mature Audiences)','05:20',NULL,NULL,'2024-07-10',0,'The journalist uncovers startling truths about the model’s hidden life, forcing both to confront the barriers they’ve built around their hearts. 🖤💔','In \"Beneath the Mask\", the walls of secrecy start to crumble as the journalist begins to piece together the model’s hidden past. What starts as a lighthearted romance quickly deepens into something far more complex when he learns that her seemingly glamorous life is filled with shadows and secrets. As they both struggle to maintain their facades, their growing connection forces them to confront the emotional masks they’ve been wearing. Vulnerability, fear, and longing come to the forefront in this pivotal episode, as they realize that love requires more than attraction—it demands honesty and trust. Will they be brave enough to reveal their true selves, or will their hidden lives tear them apart? 🖤💔🌹',0,'YouTube','https://youtu.be/lYyPmA_nuDE?si=aMi1KgykEpC9KDEf',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_beneath_the_mask_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-beneath-the-mask',NULL,NULL),
(55,'S1 E2 Veil of Deception','s1_e2_veil_of_deception_thumb.png',16,22,'YouTube','https://youtu.be/2vrTz4kC6Ls?si=jzIQOzSIoExlyheH','paid',1,'4','TV-MA (Mature Audiences)','06:45',NULL,NULL,'2024-07-10',0,'The journalist’s pursuit of truth puts him on a collision course with the model’s double life, where love and betrayal walk a fine line. 💔🕵️‍♂️','The stakes rise as the journalist delves deeper into the model’s mysterious past, uncovering secrets that threaten to shatter the fragile bond they’ve built. As he gets closer to the truth, the model\'s carefully constructed facade begins to unravel, revealing hidden motives and unexpected connections. Torn between his desire for the woman he’s grown to care for and his instinct to expose the truth, the journalist must decide if love is worth the risk of betrayal. This episode explores the tension between trust and deceit, as both characters struggle to protect their hearts from the fallout of a love built on lies. 💔🕵️‍♂️🌹',0,'YouTube','https://youtu.be/M1J-uv6oNYg?si=_3Auidh-lwrk5ll2',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_veil_of_deception_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-veil-of-deception',NULL,NULL),
(56,'S1 E3 Whispers of Her World','s1_e3_whispers_of_her_world_thumb.png',16,22,'YouTube','https://youtu.be/zF9YIYc0d7w?si=qy32xEf0hsJD9jyz','paid',1,'3','TV-MA (Mature Audiences)','03:10',NULL,NULL,'2024-07-17',0,'A smooth-talking journalist is shaken when a mysterious model with a secret life opens his heart, challenging him to rethink everything he believed about love.','A well-known womanizer who’s used to fast romances. But when he meets a beautiful model leading a double life, his world is turned upside down. Her enigma draws him in, making him reflect on his own life and what truly matters. As they unravel each other’s truths, love takes center stage in a story of redemption and transformation. 💑🎭💫',0,'YouTube','https://youtu.be/rzR3KkzKwCY?si=jJN2ZFJz2afzdeqa',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'3','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e3_whispers_of_her_world_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e3-whispers-of-her-world',NULL,NULL),
(57,'S1 E4 Double Hearts','s1_e4_double_hearts_thumb.png',16,22,'YouTube','https://youtu.be/l3P2vrcKiXs?si=PG6Yj6Bff7KrDaeB','paid',1,'6','TV-MA (Mature Audiences)','04:15',NULL,NULL,'2024-07-17',0,'A charming celebrity journalist known for his carefree lifestyle is swept off his feet by a mysterious model. As he uncovers her secret double life, he begins to question his own choices, discovering that love may be more than just a fleeting moment. ✨💑','“Double Hearts” tells the story of a celebrity journalist with a reputation for being a womanizer. His life takes an unexpected turn when he falls for a captivating model, only to learn she leads a double life filled with secrets. As their relationship deepens, he finds himself reevaluating his past decisions and confronting his feelings in a way he never expected. In this romantic journey of self-discovery, love proves to be more complex than he ever imagined. 🌹✨💑',0,'YouTube','https://youtu.be/H6UjfiD1iZs?si=V092vd-AZko1XB3N',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'4','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e4_double_hearts_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e4-double-hearts',NULL,NULL),
(58,'S1 E1 Echoes of Guilt','s1_e1_echoes_of_guilt_thumb.png',17,23,'YouTube','https://youtu.be/O9i2vmFhSSY?si=YYmzH5_dw63-BeNU','paid',1,'9','TV-MA (Mature Audiences)','02:43',NULL,NULL,'2024-08-12',0,'Father James returns to Blackthorn Manor, where the memories of the tragic suicide resurface, and the first eerie signs of paranormal activity begin to haunt him. 👻⛪','In the series opener, \"Echoes of Guilt,\" Father James is drawn back to Blackthorn Manor after months of avoiding it. The dilapidated mansion brings back painful memories of the young girl he failed to save. As night falls, unsettling occurrences begin to unfold—whispers in the dark, shadowy figures, and chilling cold spots. James questions whether he’s losing his mind or if the spirits of the girl and her stepfather are indeed lurking in the shadows. The tension builds as he starts to sense a supernatural presence watching him, setting the stage for the terror that’s about to be unleashed. 👻🏚️🩸',0,'YouTube','https://youtu.be/HvZKVGFVT5A?si=vAazBlRh1t_rhCK0',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_echoes_of_guilt_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-echoes-of-guilt',NULL,NULL),
(59,'S1 E2 The Stepfather’s Revenge','s1_e2_the_stepfathers_revenge_thumb.png',17,23,'YouTube','https://youtu.be/hJo91wpGrz8?si=uVKgkkeEcNQjnp1r','paid',1,'4','TV-MA (Mature Audiences)','03:08',NULL,NULL,'2024-08-19',0,'As the night deepens, Father James encounters the vengeful spirit of the stepfather, who begins to reveal dark secrets about the girl’s death and demands justice. 💀⚰️','In \"The Stepfather’s Revenge,\" Father James is confronted by the spirit of the girl’s violent stepfather, who accuses him of being complicit in her death. The ghostly figure torments James with cryptic messages, unsettling visions, and violent outbursts. The priest must piece together the sinister truth about the stepfather’s role in the tragedy, all while enduring terrifying hauntings that blur the line between reality and the supernatural. As the horrors escalate, James starts to unravel emotionally, grappling with his responsibility and the malevolent forces that now surround him. 🕯️💀👻',0,'YouTube','https://youtu.be/jwErAY9QjMA?si=WE3i0QOSQ7BBfe5b',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_the_stepfathers_revenge_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-the-stepfathers-revenge',NULL,NULL),
(60,'S1 E3 Night of the Damned','s1_e3_night_of_the_damned_thumb.png',17,23,'YouTube','https://youtu.be/rZQQbtK8wHk?si=EzoFuBhf2hR7LDcG','paid',1,'7','TV-MA (Mature Audiences)','03:20',NULL,NULL,'2024-08-26',0,'Father James faces the full wrath of the spirits in a climactic battle for his life and soul, as the mansion reveals its final horrifying secrets. 🔥🩸','In \"Night of the Damned,\" Father James’ ordeal reaches its terrifying peak. The spirits of the girl and her stepfather become increasingly violent, unleashing supernatural chaos that threatens to consume the priest. As James fights to survive, the truth about what really happened in Blackthorn Manor is revealed in a shocking twist. The priest is forced to confront not only the spirits but his own guilt, as the lines between redemption and damnation blur. With the dawn fast approaching, James must find a way to escape the haunted mansion—or be trapped there forever. 💀🏚️🔥',0,'YouTube','https://youtu.be/nujakIrBDCU?si=cXGG42k3lquWC2It',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'3','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e3_night_of_the_damned_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e3-night-of-the-damned',NULL,NULL),
(61,'S1 E1 The Blackness Project','s1_e1_the_blackness_project_thumb.png',18,24,'YouTube','https://youtu.be/pCMHc-IFAB0?si=vIVQzT73CoPjbEio','free',NULL,'9','TV-MA (Mature Audiences)','06:45',NULL,NULL,'2024-09-05',0,'The main character starts his journey to reconnect with his African American roots, but his well-meaning white best friend’s ideas about culture lead to hilarious missteps. 🏫🎭','In \"The Blackness Project,\" the main character embarks on his quest to understand his African American heritage, starting with simple research into his cultural roots. His white best friend eagerly offers advice, but their attempts to engage with black culture lead to a series of funny and awkward encounters. From cultural festivals to botched conversations, their journey quickly turns into a comedic exploration of identity, misunderstandings, and unexpected revelations. Amidst the laughter, both friends begin to realize that finding one\'s cultural roots is far more complex—and amusing—than they ever imagined. 🌍🎉',0,'YouTube','https://youtu.be/DJ0_rhsljpc?si=6KwFhULBBgZ0mKEG',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_the_blackness_project_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-the-blackness-project',NULL,NULL),
(62,'S1 E2 Roots and Revelations','s1_e2_roots_and_revelations_thumb.png',18,24,'YouTube','https://youtu.be/eazggD_i7T0?si=6Gm4KeZo4sO2kP8b','free',NULL,'5','TV-MA (Mature Audiences)','03:10',NULL,NULL,'2024-09-12',0,'The families finally meet, leading to a clash of perspectives as the main character’s white liberal family and African American relatives attempt to connect, creating comedic tensions. 👪🎭','The main character’s worlds collide as his white adoptive family and African American relatives come together for the first time. What starts as a well-intentioned family gathering quickly spirals into chaos as differing viewpoints, cultural misunderstandings, and personal quirks lead to a series of comical mishaps. From awkward cultural references to unintentional faux pas, both families struggle to connect, making the main character question his place within both. The episode is a laugh-out-loud exploration of what happens when two families, with vastly different cultural backgrounds, attempt to come together under one roof. 🎉👫',0,'YouTube','https://youtu.be/gchPb1y3iMM?si=M1NGoZ7pbFDNTgK3',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_roots_and_revelations_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-roots-and-revelations',NULL,NULL),
(63,'S1 E3 Family Fusion Frenzy','s1_e3_family_fusion_frenzy_thumb.png',18,24,'YouTube','https://youtu.be/7lSzGK5HR1M?si=ltOK7kx6m3IIWv2b','free',NULL,'6','TV-MA (Mature Audiences)','04:15',NULL,NULL,'2024-09-19',0,'In this episode, the best friends take on an ambitious cultural project that goes hilariously wrong, bringing both families into the mix for a chaotic but heartwarming conclusion. 💥😂','The main character and his best friend decide to create a cultural project aimed at bringing both their families together. However, things quickly go awry as their overly ambitious ideas result in humorous disasters. From a mishandled food fusion experiment to a poorly planned family talent show, the duo\'s well-meaning efforts only heighten the chaos. The episode brings all the characters together in a whirlwind of laughter, with each family member’s quirks adding to the madness. By the end of the episode, amidst the chaos and confusion, the families share a moment of understanding and connection, realizing that despite their differences, they can laugh—and learn—together. 🎭👪',0,'YouTube','https://youtu.be/qcP2BpG4Ido?si=egp_pGrIpPMi51kH',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'3','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e3_family_fusion_frenzy_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e3-family-fusion-frenzy',NULL,NULL),
(64,'S1 E1 Haunted Harmony and Sleepwalking Antics','s1_e1_haunted_harmony_and_sleepwalking_antics_thumb.png',19,25,'YouTube','https://youtu.be/2X7G6p-oNG8?si=Y2MRnmG1oRRQI0yV','free',NULL,'2','TV-MA (Mature Audiences)','02:50',NULL,NULL,'2024-09-26',0,'When a group of friends unintentionally awakens an ancient evil, eerie harmonies and bizarre sleepwalking incidents begin to plague their lives. As the horrors intensify, the group struggles to grasp the full extent of the terror they’ve unleashed. 👻🎶','The group of young adults stumbles upon the cursed Necronomicon while exploring an old, abandoned mansion. Their discovery unknowingly awakens ancient, flesh-hungry demons that begin to haunt their lives in strange and terrifying ways. What starts as harmless sleepwalking and strange harmonies soon escalates into supernatural chaos. As each member of the group experiences bizarre incidents, they realize something far more sinister is lurking in the shadows. The once-peaceful atmosphere of their lives turns into a horrifying nightmare as they confront the first signs of the demonic presence they’ve unleashed. 😨📖🎵',0,'YouTube','https://youtu.be/CasA8WERLo8?si=B16VsXQTnRwn2vcc',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_haunted_harmony_and_sleepwalking_antics_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-haunted-harmony-and-sleepwalking-antics',NULL,NULL),
(65,'S1 E2 Ghostly Giggles and Sleepwalking Shenanigans','s1_e2_ghostly_giggles_and_sleepwalking_shenanigans_thumb.png',19,25,'YouTube','https://youtu.be/smTK_AeAPHs?si=_DHZCV-kD4mjwIKd','free',NULL,'6','TV-MA (Mature Audiences)','03:20',NULL,NULL,'2024-10-01',0,'A seemingly harmless sleepwalking incident spirals into chaos as the awakened demons begin to manipulate the group’s every move, using ghostly tricks to break their spirits. 🎭👹','After the strange events of the previous episode, the group is further tormented by sleepwalking pranks and eerie ghostly laughter that echo throughout their surroundings. The demons, now unleashed, toy with the group’s fears and insecurities, slowly breaking their mental resolve. As the sleepwalking escalates into dangerous actions, the group begins to lose control, realizing that the demonic forces are manipulating them from within. Every corner they turn, they are met with chilling laughter and ghostly pranks that remind them of the horrifying evil they’ve awakened. As the group struggles to maintain their sanity, their bond begins to crack under the relentless pressure. 👻🎶😱',0,'YouTube','https://youtu.be/FZAafmCPSjs?si=9G_CjrZlb3vwFPTC',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_ghostly_giggles_and_sleepwalking_shenanigans_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-ghostly-giggles-and-sleepwalking-shenanigans',NULL,NULL),
(66,'S1 E3 Sleepwalker Shenanigans and Ghostly Giggles','s1_e3_sleepwalker_shenanigans_and_ghostly_giggles_thumb.png',19,25,'YouTube','https://youtu.be/Jxq13WJxLDY?si=AjKX1zULDPQ-Lqiw','free',NULL,'1','TV-MA (Mature Audiences)','03:28',NULL,NULL,'2024-10-05',0,'The demonic forces step up their game, using nightmarish sleepwalking to pit the group against each other in a series of terrifying and deadly pranks. 👻🕵️‍♂️','The group is plunged deeper into chaos as the demons grow stronger, amplifying their control over the friends\' subconscious minds. Sleepwalking becomes a terrifying tool used by the demons to turn the group against one another. With every prank, the lines between reality and the supernatural blur, causing mistrust and paranoia to fester. The group’s attempts to break the demonic curse are foiled by increasingly dangerous antics orchestrated by the demons, who delight in their suffering. As friendships begin to fracture, the group is pushed to its limits, realizing that they are no longer just fighting supernatural forces—they are fighting for their lives. 👹🎭🔪',0,'YouTube','https://youtu.be/SX1LiKN4ZcQ?si=6uJZt7OGt6EUzHD_',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'3','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e3_sleepwalker_shenanigans_and_ghostly_giggles_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e3-sleepwalker-shenanigans-and-ghostly-giggles',NULL,NULL),
(67,'S1 E4 Haunting Beneath the Luck','s1_e4_haunting_beneath_the_luck_thumb.png',19,25,'YouTube','https://youtu.be/bhYh4_FWxNo?si=UGh5bJqr6gta9Nhb','free',NULL,'2','TV-MA (Mature Audiences)','02:43',NULL,NULL,'2024-10-15',0,'A string of unexpected fortune hides a sinister secret as the group uncovers the dark truth behind the curse, forcing them to confront the demons head-on. 🕵️‍♀️👻','In this chilling episode, the group experiences a bizarre twist in their fortunes—everything seems to suddenly go their way, but beneath the surface lies a terrifying truth. The demonic forces, now fully unleashed, offer the group moments of false hope, lulling them into a sense of security. However, this “luck” is nothing more than a twisted game. As they delve deeper into the mystery, the group uncovers the haunting connection between their newfound luck and the vengeful spirits they’ve awakened. With time running out and the true nature of the curse revealed, the group must face the horrifying reality of the demons’ endgame. What started as a seemingly harmless discovery has turned into a fight for their souls. 😨🍀👹',0,'YouTube','https://youtu.be/gmO2_FcfhgY?si=eu8bv_GcLKxlkXrs',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'4','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e4_haunting_beneath_the_luck_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e4-haunting-beneath-the-luck',NULL,NULL),
(68,'S1 E1 Crimson Divide','s1_e1_crimson_divide_thumb.png',20,26,'YouTube','https://youtu.be/HO4uLABrIuc?si=_JUkCi82TFa6KaVT','free',NULL,'6','TV-MA (Mature Audiences)','02:50',NULL,NULL,'2024-10-16',0,'The reunion starts with joy, but eerie signs in the wilderness begin to unsettle the group, hinting at something sinister watching them from the shadows. 😨🌲','The four friends—Esme, Hannah, Ben, and Shan—arrive at the remote cabin for their long-awaited reunion. At first, everything seems perfect: laughter, memories, and the beauty of the wilderness. However, subtle signs of danger emerge as strange noises, shadows in the forest, and unsettling feelings creep in. What starts as a fun getaway quickly turns into a night filled with dread. Tensions rise as the group senses that something is wrong, setting the stage for the escalating horror to come. 🌑👀',0,'YouTube','https://youtu.be/AmpLWp_9YtU?si=CfCfsRUnffhTZSgL',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'1','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e1_crimson_divide_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e1-crimson-divide',NULL,NULL),
(69,'S1 E2 Torn Horizons','s1_e2_torn_horizons_thumb.png',20,26,'YouTube','https://youtu.be/pAxGJfEYuJI?si=usPEgPrVvANZVl8F','free',NULL,'3','TV-MA (Mature Audiences)','03:20',NULL,NULL,'2024-10-17',0,'As the group struggles to make sense of the strange occurrences, secrets from their pasts begin to surface, tearing them apart emotionally while the threat outside intensifies. 💥🌳','In Torn Horizons, the group’s unity is tested as old wounds reopen, revealing the complicated history between the friends. Meanwhile, the eerie happenings grow more aggressive, with cryptic messages and terrifying encounters in the woods. Esme and Hannah find themselves at odds as they face their unresolved issues, while Ben and Shan uncover a clue that suggests they may not be the first visitors to fall victim to the mysterious force in the wilderness. The physical and emotional divide between them widens as they race to survive, leading to explosive confrontations and deepening suspense. 🔥🕵️‍♀️',0,'YouTube','https://youtu.be/h-Y77SQeMD4?si=OMij7ddBHRDtKwgz',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'2','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e2_torn_horizons_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e2-torn-horizons',NULL,NULL),
(70,'S1 E3 Fading Light','s1_e3_fading_light_thumb.png',20,26,'YouTube','https://youtu.be/FXOtkvx25gI?si=iD3LrO0BIQv7Fz4d','free',NULL,'7','TV-MA (Mature Audiences)','03:28',NULL,NULL,'2024-10-18',0,'With nightfall approaching and the danger closing in, the group’s hope dwindles. Desperation takes hold as they struggle to find a way out of the woods. 🌒⚔️','As night falls in Fading Light, the group’s fear intensifies, and they realize that their chances of survival are growing slimmer. With their escape route cut off and the presence in the woods becoming more menacing, Esme and her friends face their darkest hour. They begin to understand that they are not just being hunted but manipulated by an unseen force. As paranoia grows, the friends turn on each other, unsure of who they can trust. The chilling atmosphere of the episode creates a sense of inescapable dread, as the group struggles to find light—both literal and metaphorical—in the enveloping darkness. 🕯️🌘',0,'YouTube','https://youtu.be/nujakIrBDCU?si=cXGG42k3lquWC2It',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'3','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e3_fading_light_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e3-fading-light',NULL,NULL),
(71,'S1 E4 Silent Betrayal','s1_e4_silent_betrayal_thumb.png',12,1,'YouTube','https://youtu.be/7EzpvriIQ3I?si=32wWLtYpLoOf7QuP','free',NULL,'8','TV-MA (Mature Audiences)','02:43',NULL,NULL,'2024-10-19',0,'A shocking betrayal comes to light, fracturing the group as they face the ultimate confrontation with the malevolent force in the woods. 😱💔','In the intense finale, Silent Betrayal, the group’s fragile trust is shattered when a long-buried secret is revealed. This revelation causes chaos among the friends, just as they are forced to confront the malevolent entity that has been haunting them. Esme takes charge as they prepare for the final showdown, but the betrayal weighs heavily on her. With their friendship in tatters, the group must decide whether to stand together or let the darkness consume them. As the true nature of the evil in the woods is unveiled, they face a deadly choice: fight for their lives or fall prey to the horrors lurking in the shadows. 🔪🌲',0,'YouTube','https://youtu.be/BrDKY3RRg-g?si=SJgkbOqPdgCZCCOs',0,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,'6','2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_e4_silent_betrayal_thumb.png',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-e4-silent-betrayal',NULL,NULL);
/*!40000 ALTER TABLE `episodes` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `faqs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question` varchar(191) NOT NULL,
  `answer` longtext NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faqs`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `faqs` WRITE;
/*!40000 ALTER TABLE `faqs` DISABLE KEYS */;
INSERT INTO `faqs` VALUES
(1,'1. What is Apex Prime TV?','Apex Prime TV is a cutting-edge streaming platform developed by Varchaswaa International Pvt Ltd that allows users to watch movies, TV shows, and live content seamlessly. It provides a feature-rich experience with personalized recommendations, multiple subscription plans, and high-quality streaming.',1,2,2,NULL,'2024-09-28 06:43:30','2026-03-05 11:19:45',NULL),
(2,'2. How can I create an account on Apex Prime TV?','To create an account, simply click on the \"Sign Up\" button on the homepage, enter your details, and follow the on-screen instructions. Once registered, you can start exploring our extensive content library.',1,2,2,NULL,'2024-09-28 06:44:16','2026-03-05 11:19:45',NULL),
(3,'3. What subscription plans are available?','We offer multiple subscription plans tailored to your needs:\n- Basic Plan: Weekly subscription.\n- Premium Plan: Monthly subscription.\n- Ultimate Plan: Quarterly subscription.\n- Elite Plan: Yearly subscription.\nEach plan offers different features such as HD streaming, multi-device support, and download options. Visit our Subscription Plans page for more details.',1,2,2,NULL,'2024-09-28 06:44:36','2026-03-05 11:19:45',NULL),
(4,'4. What payment methods do you accept?','We accept a variety of payment gateways for your convenience:\n- Stripe\n- RazorPay\n- Paystack\n- PayPal\n- FlutterWave\nYou can choose your preferred method at checkout.',1,2,2,NULL,'2024-09-28 06:44:57','2026-03-05 11:19:45',NULL),
(5,'5. How can I manage my subscription?','To manage your subscription, log into your account, go to the \"Account Settings\" section, and select \"Subscription.\" From there, you can upgrade, downgrade, or cancel your plan at any time.',1,2,2,NULL,'2024-09-28 06:45:14','2026-03-05 11:19:45',NULL),
(6,'6. How can I add content to my watchlist?','While browsing movies or TV shows, simply click on the \"Add to Watchlist\" button. You can view your watchlist anytime under the \"My Watchlist\" section of your account dashboard.',1,2,2,NULL,'2024-09-28 06:45:33','2026-03-05 11:19:45',NULL),
(7,'7. Can I download content for offline viewing?','Yes, Apex Prime TV allows you to download selected content for offline viewing, depending on your subscription plan. This feature is available for both mobile and tablet devices.',1,2,2,NULL,'2024-09-28 06:45:48','2026-03-05 11:19:45',NULL),
(8,'8. Does Apex Prime TV support multiple devices?','Yes, you can stream on multiple devices based on your subscription plan. The higher the plan, the more devices you can use simultaneously.',1,2,2,NULL,'2024-09-28 06:46:05','2026-03-05 11:19:45',NULL),
(9,'9. How does the recommendation system work?','Our platform uses a smart recommendation engine that suggests content based on your viewing history and preferences. The more you watch, the better the recommendations get!',1,2,2,NULL,'2024-09-28 06:46:21','2026-03-05 11:19:45',NULL),
(10,'10. Is there a free trial available?','Yes, we offer a limited-time free trial for new users. During the trial, you can explore all the features of the platform and decide if you want to subscribe to a full plan.',1,2,2,NULL,'2024-09-28 06:46:40','2026-03-05 11:19:45',NULL),
(11,'11. How does the referral program work?','Our referral program rewards you for inviting friends to join Apex Prime TV. For each friend who subscribes using your referral link, you both receive a discount on your next billing cycle. Check the referral section in your account for more details!',1,2,2,NULL,'2024-09-28 06:51:25','2026-03-05 11:19:45',NULL),
(12,'12. What types of content are available on Apex Prime TV?','Apex Prime TV offers a diverse range of content, including movies, TV shows, documentaries, and live events across various genres. You\'ll find everything from action and comedy to horror and romance!',1,2,2,NULL,'2024-09-28 06:51:47','2026-03-05 11:19:45',NULL),
(13,'13. Can I change my subscription plan later?','Absolutely! You can change your subscription plan at any time through your account settings. Simply select a different plan, and your new billing will take effect at the end of your current billing cycle.',1,2,2,NULL,'2024-09-28 06:52:05','2026-03-05 11:19:45',NULL),
(14,'14. What should I do if I forget my password?','If you forget your password, click on the \"Forgot Password?\" link on the login page. Follow the instructions to reset your password via the email associated with your account.',1,2,2,NULL,'2024-09-28 06:52:21','2026-03-05 11:19:45',NULL),
(15,'15. Is there any age restriction for using Apex Prime TV?','Yes, users must be at least 13 years old to create an account. We recommend parental guidance for users under 18, as some content may not be suitable for younger viewers.',1,2,2,NULL,'2024-09-28 06:52:38','2026-03-05 11:19:45',NULL),
(16,'16. Can I share my account with family members?','Yes, depending on your subscription plan, you can share your account with family members. However, please note that simultaneous streaming may be limited based on your chosen plan.',1,2,2,NULL,'2024-09-28 06:52:56','2026-03-05 11:19:45',NULL),
(17,'17. How often is new content added to the platform?','We regularly update our library with new content! You can expect new movies, TV shows, and episodes added every week, so there\'s always something fresh to watch.',1,2,2,NULL,'2024-09-28 06:53:14','2026-03-05 11:19:45',NULL),
(18,'18. Does Apex Prime TV offer subtitles or closed captions?','Yes, many of our titles offer subtitles and closed captions in various languages. You can enable them through the video player settings while watching content.',1,2,2,NULL,'2024-09-28 06:54:30','2026-03-05 11:19:45',NULL),
(19,'19. What should I do if I encounter a streaming issue?','If you experience buffering or streaming issues, first check your internet connection. If the problem persists, try clearing your cache or refreshing the page. If you continue to have issues, please contact our support team for assistance.',1,2,2,NULL,'2024-09-28 06:54:44','2026-03-05 11:19:45',NULL),
(20,'20. How do I use the parental controls on Streamit?','To use parental controls on Streamit, navigate to your account settings. Here, you can set age restrictions for various content types and block specific shows or movies. Additionally, you can create custom profiles for family members with tailored controls. For added security, consider setting a PIN or password.',1,2,2,NULL,'2024-09-28 06:58:39','2026-03-05 11:19:45',NULL),
(21,'21. How do I enable subtitles or closed captions?','To enable subtitles or closed captions while watching content on Streamit, look for the \"Subtitles\" or \"CC\" icon on the video player. Click on it, and you can choose your preferred language for subtitles. This feature enhances your viewing experience and accessibility.',1,2,2,NULL,'2024-09-28 06:59:10','2026-03-05 11:19:45',NULL),
(22,'22. How do I customize my Streamit homepage?','To customize your Streamit homepage, log into your account and navigate to the \"Settings\" section. From there, you can personalize your homepage by selecting your favorite genres, organizing your watchlist, and adjusting display preferences to see content that interests you most.',1,2,2,NULL,'2024-09-28 06:59:36','2026-03-05 11:19:45',NULL),
(23,'23. How do I download videos for offline viewing?','To download videos for offline viewing on Streamit, find the desired movie or show and look for the download icon. Click it, and the content will be saved to your device for offline access. Note that the ability to download may depend on your subscription plan.',1,2,2,NULL,'2024-09-28 07:00:06','2026-03-05 11:19:45',NULL),
(24,'24. Can I delete my account?','Yes, you can delete your account at any time. To do this, log into your account, navigate to the \"Account Settings\" section, and select \"Delete Account.\" Please note that this action is irreversible, and all your data will be permanently removed.',1,2,2,NULL,'2024-09-28 07:00:40','2026-03-05 11:19:45',NULL),
(25,'25. How can I contact customer support?','If you need assistance, you can reach our customer support team via email at support@apexprimetv.com. We\'re here to help!',1,2,2,NULL,'2024-09-28 07:00:53','2026-03-05 11:19:45',NULL);
/*!40000 ALTER TABLE `faqs` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `filemanagers`
--

DROP TABLE IF EXISTS `filemanagers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `filemanagers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `file_url` varchar(191) NOT NULL DEFAULT '',
  `file_name` varchar(191) NOT NULL DEFAULT '',
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filemanagers`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `filemanagers` WRITE;
/*!40000 ALTER TABLE `filemanagers` DISABLE KEYS */;
INSERT INTO `filemanagers` VALUES
(1,'temp/uploads/applogotop_6995b9665e0b3.png','applogotop_6995b9665e0b3.png',15,15,NULL,'2026-02-18 13:06:46','2026-02-18 13:06:46',NULL),
(2,'temp/uploads/applogotop_6995b98477073.png','applogotop_6995b98477073.png',15,15,NULL,'2026-02-18 13:07:16','2026-02-18 13:07:16',NULL),
(3,'temp/uploads/applogotop_6995b9c5817b1.png','applogotop_6995b9c5817b1.png',15,15,NULL,'2026-02-18 13:08:21','2026-02-18 13:08:21',NULL),
(4,'temp/uploads/icon_192_6995d4bb45911.png','icon_192_6995d4bb45911.png',15,15,NULL,'2026-02-18 15:03:23','2026-02-18 15:03:23',NULL),
(5,'temp/uploads/gif_apex_logo_6996b6e9744f1.gif','gif_apex_logo_6996b6e9744f1.gif',15,15,NULL,'2026-02-19 07:08:25','2026-02-19 07:08:25',NULL),
(6,'temp/uploads/gif_apex_logo_6996b72387c58.gif','gif_apex_logo_6996b72387c58.gif',15,15,NULL,'2026-02-19 07:09:23','2026-02-19 07:09:23',NULL),
(7,'temp/uploads/9_x_16_re_699b39d10d7e2.gif','9_x_16_re_699b39d10d7e2.gif',15,15,NULL,'2026-02-22 17:16:01','2026-02-22 17:16:01',NULL),
(8,'temp/uploads/applogotop_699b5bb03c055.png','applogotop_699b5bb03c055.png',15,15,NULL,'2026-02-22 19:40:32','2026-02-22 19:40:32',NULL),
(9,'temp/uploads/apple_touch_icon_699b5c040fdc2.png','apple_touch_icon_699b5c040fdc2.png',15,15,NULL,'2026-02-22 19:41:56','2026-02-22 19:41:56',NULL),
(10,'temp/uploads/apple_touch_icon_699b615b6b2fe.png','apple_touch_icon_699b615b6b2fe.png',15,15,NULL,'2026-02-22 20:04:43','2026-02-22 20:04:43',NULL),
(11,'temp/uploads/9_x_16_re_699b673b78bd3.gif','9_x_16_re_699b673b78bd3.gif',15,15,NULL,'2026-02-22 20:29:47','2026-02-22 20:29:47',NULL),
(12,'temp/uploads/applogotop_699b67564394c.png','applogotop_699b67564394c.png',15,15,NULL,'2026-02-22 20:30:14','2026-02-22 20:30:14',NULL),
(13,'temp/uploads/applogotop_69a0b7808eab0.png','applogotop_69a0b7808eab0.png',1,1,NULL,'2026-02-26 21:13:36','2026-02-26 21:13:36',NULL),
(14,'temp/uploads/applogotop_69a3a818dc114.png','applogotop_69a3a818dc114.png',15,15,NULL,'2026-03-01 02:44:40','2026-03-01 02:44:40',NULL),
(15,'temp/uploads/9_x_16_re_69a42cad3e520.gif','9_x_16_re_69a42cad3e520.gif',15,15,NULL,'2026-03-01 12:10:21','2026-03-01 12:10:21',NULL),
(16,'temp/uploads/generated_image_(4)_69a73079e71ef.png','generated_image_(4)_69a73079e71ef.png',15,15,NULL,'2026-03-03 19:03:21','2026-03-03 19:03:21',NULL),
(17,'temp/uploads/icon_512_maskable_69a73a92f3e45.png','icon_512_maskable_69a73a92f3e45.png',15,15,NULL,'2026-03-03 19:46:27','2026-03-03 19:46:27',NULL),
(18,'temp/uploads/maxresdefault_69ae8b343f856.jpg','maxresdefault_69ae8b343f856.jpg',2,2,NULL,'2026-03-09 08:56:20','2026-03-09 08:56:20',NULL),
(19,'temp/uploads/चंदा_मामा_आवा_(लोरी_)_Singer_@panchamigoswami_@kumarsangeet____1280x720_6a253ccdd5599.jpg','चंदा_मामा_आवा_(लोरी_)_Singer_@panchamigoswami_@kumarsangeet____1280x720_6a253ccdd5599.jpg',15,15,NULL,'2026-06-07 09:41:33','2026-06-07 09:41:33',NULL);
/*!40000 ALTER TABLE `filemanagers` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `file_url` text DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `genres_id_deleted_at_index` (`id`,`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES
(1,'Action','action','action_genre.png','Action movies are packed with high-energy sequences, intense battles, and thrilling adventures. These films deliver non-stop excitement and adrenaline-pumping scenes that captivate audiences. 💥🏃‍♂️',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(2,'Animation','animation','animation_genre.png','Captivating animated stories that bring imaginative worlds and characters to life. These films use creative visuals and storytelling to enchant audiences of all ages. 🎨✨',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(3,'Comedy','comedy','comedy_genre.png','Light-hearted films designed to entertain and amuse with humor and wit. These movies offer a delightful escape filled with laughter and joy. 😂🎬',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(4,'Historical','historical','historical_genre.png','Movies that delve into significant historical events, figures, and eras. They offer a glimpse into the past, bringing history to life with compelling narratives. 📜🏰',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(5,'Horror','horror','horror_genre.png','Spine-chilling movies that evoke fear and suspense, often featuring supernatural elements. These films are designed to haunt and thrill viewers. 👻🕯️',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(6,'Inspirational','inspirational','inspirational_genre.png','Uplifting films that motivate and inspire with stories of courage, perseverance, and triumph. They often highlight the resilience of the human spirit. 🌟💪',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(7,'Romantic','romantic','romantic_genre.png','Heartwarming stories focusing on love, relationships, and the complexities of romance. These films explore the beauty and challenges of romantic connections. 💖🌹',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(8,'Thriller','thriller','thriller_genre.png','High-stakes scenarios and intense suspense that keep you on the edge of your seat. Expect unexpected twists and heart-pounding moments. 🔪🎬',1,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(9,'Drama',NULL,NULL,NULL,1,NULL,NULL,NULL,'2026-03-04 22:35:51','2026-03-04 22:35:51',NULL),
(10,'Romance',NULL,NULL,NULL,1,NULL,NULL,NULL,'2026-03-04 22:46:46','2026-03-04 22:46:46',NULL),
(11,'Crime',NULL,NULL,NULL,1,NULL,NULL,NULL,'2026-03-04 22:46:48','2026-03-04 22:46:48',NULL),
(12,'Science Fiction',NULL,NULL,NULL,1,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51',NULL),
(13,'Adventure',NULL,NULL,NULL,1,NULL,NULL,NULL,'2026-03-04 22:46:51','2026-03-04 22:46:51',NULL),
(14,'History',NULL,NULL,NULL,1,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09',NULL),
(15,'War',NULL,NULL,NULL,1,NULL,NULL,NULL,'2026-03-04 22:47:09','2026-03-04 22:47:09',NULL),
(16,'Family',NULL,NULL,NULL,1,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13',NULL),
(17,'Fantasy',NULL,NULL,NULL,1,NULL,NULL,NULL,'2026-03-04 22:47:13','2026-03-04 22:47:13',NULL),
(18,'Sci-Fi & Fantasy',NULL,NULL,NULL,1,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19',NULL),
(19,'Action & Adventure',NULL,NULL,NULL,1,NULL,NULL,NULL,'2026-03-04 22:47:19','2026-03-04 22:47:19',NULL),
(20,'Mystery',NULL,NULL,NULL,1,NULL,NULL,NULL,'2026-03-04 22:47:31','2026-03-04 22:47:31',NULL);
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `installers`
--

DROP TABLE IF EXISTS `installers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `installers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `installers`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `installers` WRITE;
/*!40000 ALTER TABLE `installers` DISABLE KEYS */;
INSERT INTO `installers` VALUES
(1,'installation_complete',1,1,NULL,'2026-02-26 20:56:09','2026-02-26 20:56:09',NULL);
/*!40000 ALTER TABLE `installers` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
INSERT INTO `job_batches` VALUES
('a11c1605-f8cc-417c-b511-6987e9c8d365','',1,1,0,'[]','a:0:{}',NULL,1771420006,NULL),
('a11c1633-cbd3-4413-b571-8b983b42e203','',1,1,0,'[]','a:0:{}',NULL,1771420036,NULL),
('a11c1697-0bf4-4563-a2ed-87c31c70d681','',1,1,0,'[]','a:0:{}',NULL,1771420101,NULL),
('a11c3fba-633a-477a-9227-4e146107300b','',1,1,0,'[]','a:0:{}',NULL,1771427003,NULL),
('a11d98da-267f-4ea7-b450-4b677f2df9c7','',1,1,0,'[]','a:0:{}',NULL,1771484905,NULL),
('a11d9932-a833-4a68-b263-eb859965b486','',1,1,0,'[]','a:0:{}',NULL,1771484963,NULL),
('a1247b18-c06e-4865-9cf9-240f2dde556a','',1,1,0,'[]','a:0:{}',NULL,1771780561,NULL),
('a124aec7-eabe-424c-a12b-080ec399f8d2','',1,1,0,'[]','a:0:{}',NULL,1771789232,NULL),
('a124af47-b640-4d79-a224-198bb82142c4','',1,1,0,'[]','a:0:{}',NULL,1771789316,NULL),
('a124b76e-3bfa-4847-943d-026070b5e605','',1,1,0,'[]','a:0:{}',NULL,1771790683,NULL),
('a124c065-4213-4dab-a1e3-a7c9a9b4afc6','',1,1,0,'[]','a:0:{}',NULL,1771792187,NULL),
('a124c08e-0895-4184-ab65-14e98a238bf0','',1,1,0,'[]','a:0:{}',NULL,1771792214,NULL),
('a12cdc00-add3-4782-bfd4-933d939967c1','',1,0,0,'[]','a:0:{}',NULL,1772140416,1772140416),
('a131585f-1c40-45d2-9f48-67700b999d23','',1,0,0,'[]','a:0:{}',NULL,1772333080,1772333081),
('a13222ab-f6e3-4555-8f42-efad9c9c3146','',1,0,0,'[]','a:0:{}',NULL,1772367021,1772367021),
('a136bc58-2b81-4fff-89ed-376d3e8db6a2','',1,0,0,'[]','a:0:{}',NULL,1772564602,1772564602),
('a136cbc0-b309-4754-a1e2-28f3482034f8','',1,0,0,'[]','a:0:{}',NULL,1772567187,1772567187),
('a141f528-b4a4-4b96-ad7c-3fe04b27ea9f','',1,0,0,'[]','a:0:{}',NULL,1773046580,1773046580),
('a1f711e7-bd0f-49f4-b5d9-ecfd81666b8a','',1,0,0,'[]','a:0:{}',NULL,1780825293,1780825294);
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` VALUES
(1,'default','{\"uuid\":\"b3dccd21-a2d5-4469-a819-bdaad08464db\",\"displayName\":\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":22:{s:5:\\\"class\\\";s:60:\\\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:30:\\\"App\\\\Events\\\\Backend\\\\UserCreated\\\":1:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1771402673,\"delay\":null}',0,NULL,1771402673,1771402673),
(2,'default','{\"uuid\":\"2206cf28-9681-4caf-a067-3be441759ab9\",\"displayName\":\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":22:{s:5:\\\"class\\\";s:60:\\\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:30:\\\"App\\\\Events\\\\Backend\\\\UserCreated\\\":1:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1771402674,\"delay\":null}',0,NULL,1771402674,1771402674),
(3,'default','{\"uuid\":\"82b027fb-5c2d-4771-bdc4-82ac079f87c4\",\"displayName\":\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":22:{s:5:\\\"class\\\";s:60:\\\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:30:\\\"App\\\\Events\\\\Backend\\\\UserCreated\\\":1:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1771402674,\"delay\":null}',0,NULL,1771402674,1771402674),
(4,'default','{\"uuid\":\"9ca6a6f4-259c-48ae-9917-8f7fa40baa2e\",\"displayName\":\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":22:{s:5:\\\"class\\\";s:60:\\\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:30:\\\"App\\\\Events\\\\Backend\\\\UserCreated\\\":1:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1771402674,\"delay\":null}',0,NULL,1771402674,1771402674),
(5,'default','{\"uuid\":\"4a61c042-1986-4a1c-a282-37677b860922\",\"displayName\":\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":22:{s:5:\\\"class\\\";s:60:\\\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:30:\\\"App\\\\Events\\\\Backend\\\\UserCreated\\\":1:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:5;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1771402674,\"delay\":null}',0,NULL,1771402674,1771402674),
(6,'default','{\"uuid\":\"db4e2810-b33f-4b45-b1ab-170c3a4ed63e\",\"displayName\":\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":22:{s:5:\\\"class\\\";s:60:\\\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:30:\\\"App\\\\Events\\\\Backend\\\\UserCreated\\\":1:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:6;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1771402674,\"delay\":null}',0,NULL,1771402674,1771402674),
(7,'default','{\"uuid\":\"5cb0fe68-30f1-4985-a31d-1f0ef1e38c49\",\"displayName\":\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":22:{s:5:\\\"class\\\";s:60:\\\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:30:\\\"App\\\\Events\\\\Backend\\\\UserCreated\\\":1:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:7;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1771402674,\"delay\":null}',0,NULL,1771402674,1771402674),
(8,'default','{\"uuid\":\"6a458016-b5e9-45a6-bc6e-4440ac38b0d2\",\"displayName\":\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":22:{s:5:\\\"class\\\";s:60:\\\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:30:\\\"App\\\\Events\\\\Backend\\\\UserCreated\\\":1:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:8;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1771402674,\"delay\":null}',0,NULL,1771402674,1771402674),
(9,'default','{\"uuid\":\"3cf7eac2-0c10-4481-b299-ea8b50fbd460\",\"displayName\":\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":22:{s:5:\\\"class\\\";s:60:\\\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:30:\\\"App\\\\Events\\\\Backend\\\\UserCreated\\\":1:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:9;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1771402674,\"delay\":null}',0,NULL,1771402674,1771402674),
(10,'default','{\"uuid\":\"a6151143-3228-459b-8738-3735c4219caa\",\"displayName\":\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":22:{s:5:\\\"class\\\";s:60:\\\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:30:\\\"App\\\\Events\\\\Backend\\\\UserCreated\\\":1:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:10;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1771402674,\"delay\":null}',0,NULL,1771402674,1771402674),
(11,'default','{\"uuid\":\"80639550-6b89-4b34-96a9-58a517c66308\",\"displayName\":\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":22:{s:5:\\\"class\\\";s:60:\\\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:30:\\\"App\\\\Events\\\\Backend\\\\UserCreated\\\":1:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:11;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1771402674,\"delay\":null}',0,NULL,1771402674,1771402674),
(12,'default','{\"uuid\":\"b5b9f4cf-ec8e-4b74-99c8-1f39254a308d\",\"displayName\":\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":22:{s:5:\\\"class\\\";s:60:\\\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:30:\\\"App\\\\Events\\\\Backend\\\\UserCreated\\\":1:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:12;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1771402674,\"delay\":null}',0,NULL,1771402674,1771402674),
(13,'default','{\"uuid\":\"b5f5a720-4363-48c8-8435-859b07434a5e\",\"displayName\":\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":22:{s:5:\\\"class\\\";s:60:\\\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:30:\\\"App\\\\Events\\\\Backend\\\\UserCreated\\\":1:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:13;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1771402674,\"delay\":null}',0,NULL,1771402674,1771402674),
(14,'default','{\"uuid\":\"20b0047c-bd95-468b-b2e5-c30a83e25ae5\",\"displayName\":\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":22:{s:5:\\\"class\\\";s:60:\\\"App\\\\Listeners\\\\Backend\\\\UserCreated\\\\UserCreatedNotifySuperUser\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:30:\\\"App\\\\Events\\\\Backend\\\\UserCreated\\\":1:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:14;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1771402674,\"delay\":null}',0,NULL,1771402674,1771402674),
(15,'default','{\"uuid\":\"3ac2a1c0-c702-4696-92f2-c932f1cdf56e\",\"displayName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"command\":\"O:26:\\\"App\\\\Jobs\\\\ProcessFileUpload\\\":7:{s:11:\\\"filemanager\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Modules\\\\Filemanager\\\\Models\\\\Filemanager\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:8:\\\"filePath\\\";s:41:\\\"temp\\/uploads\\/applogotop_6995b9665e0b3.png\\\";s:8:\\\"diskType\\\";s:5:\\\"local\\\";s:12:\\\"originalName\\\";s:14:\\\"applogotop.png\\\";s:9:\\\"page_type\\\";s:5:\\\"logos\\\";s:8:\\\"fileType\\\";s:5:\\\"image\\\";s:7:\\\"batchId\\\";s:36:\\\"a11c1605-f8cc-417c-b511-6987e9c8d365\\\";}\"},\"createdAt\":1771420006,\"delay\":null}',0,NULL,1771420006,1771420006),
(16,'default','{\"uuid\":\"4e93591e-5743-4f6c-b863-5c9e07f9db6d\",\"displayName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"command\":\"O:26:\\\"App\\\\Jobs\\\\ProcessFileUpload\\\":7:{s:11:\\\"filemanager\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Modules\\\\Filemanager\\\\Models\\\\Filemanager\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:8:\\\"filePath\\\";s:41:\\\"temp\\/uploads\\/applogotop_6995b98477073.png\\\";s:8:\\\"diskType\\\";s:5:\\\"local\\\";s:12:\\\"originalName\\\";s:14:\\\"applogotop.png\\\";s:9:\\\"page_type\\\";s:5:\\\"logos\\\";s:8:\\\"fileType\\\";s:5:\\\"image\\\";s:7:\\\"batchId\\\";s:36:\\\"a11c1633-cbd3-4413-b571-8b983b42e203\\\";}\"},\"createdAt\":1771420036,\"delay\":null}',0,NULL,1771420036,1771420036),
(17,'default','{\"uuid\":\"bfa99b7d-6026-4e70-9354-a192e4944dd2\",\"displayName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"command\":\"O:26:\\\"App\\\\Jobs\\\\ProcessFileUpload\\\":7:{s:11:\\\"filemanager\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Modules\\\\Filemanager\\\\Models\\\\Filemanager\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:8:\\\"filePath\\\";s:41:\\\"temp\\/uploads\\/applogotop_6995b9c5817b1.png\\\";s:8:\\\"diskType\\\";s:5:\\\"local\\\";s:12:\\\"originalName\\\";s:14:\\\"applogotop.png\\\";s:9:\\\"page_type\\\";s:5:\\\"logos\\\";s:8:\\\"fileType\\\";s:5:\\\"image\\\";s:7:\\\"batchId\\\";s:36:\\\"a11c1697-0bf4-4563-a2ed-87c31c70d681\\\";}\"},\"createdAt\":1771420101,\"delay\":null}',0,NULL,1771420101,1771420101),
(18,'default','{\"uuid\":\"665fb7cf-847a-4fdd-b4e2-638d332dfdaf\",\"displayName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"command\":\"O:26:\\\"App\\\\Jobs\\\\ProcessFileUpload\\\":7:{s:11:\\\"filemanager\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Modules\\\\Filemanager\\\\Models\\\\Filemanager\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:8:\\\"filePath\\\";s:39:\\\"temp\\/uploads\\/icon_192_6995d4bb45911.png\\\";s:8:\\\"diskType\\\";s:5:\\\"local\\\";s:12:\\\"originalName\\\";s:12:\\\"icon-192.png\\\";s:9:\\\"page_type\\\";s:5:\\\"logos\\\";s:8:\\\"fileType\\\";s:5:\\\"image\\\";s:7:\\\"batchId\\\";s:36:\\\"a11c3fba-633a-477a-9227-4e146107300b\\\";}\"},\"createdAt\":1771427003,\"delay\":null}',0,NULL,1771427003,1771427003),
(19,'default','{\"uuid\":\"650c99ea-0e25-423e-8f15-e62fe2e26ef5\",\"displayName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"command\":\"O:26:\\\"App\\\\Jobs\\\\ProcessFileUpload\\\":7:{s:11:\\\"filemanager\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Modules\\\\Filemanager\\\\Models\\\\Filemanager\\\";s:2:\\\"id\\\";i:5;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:8:\\\"filePath\\\";s:44:\\\"temp\\/uploads\\/gif_apex_logo_6996b6e9744f1.gif\\\";s:8:\\\"diskType\\\";s:5:\\\"local\\\";s:12:\\\"originalName\\\";s:17:\\\"gif apex logo.gif\\\";s:9:\\\"page_type\\\";s:5:\\\"logos\\\";s:8:\\\"fileType\\\";s:5:\\\"image\\\";s:7:\\\"batchId\\\";s:36:\\\"a11d98da-267f-4ea7-b450-4b677f2df9c7\\\";}\"},\"createdAt\":1771484905,\"delay\":null}',0,NULL,1771484905,1771484905),
(20,'default','{\"uuid\":\"67eebfc0-68ed-46e8-98f1-68aa394b0d75\",\"displayName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"command\":\"O:26:\\\"App\\\\Jobs\\\\ProcessFileUpload\\\":7:{s:11:\\\"filemanager\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Modules\\\\Filemanager\\\\Models\\\\Filemanager\\\";s:2:\\\"id\\\";i:6;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:8:\\\"filePath\\\";s:44:\\\"temp\\/uploads\\/gif_apex_logo_6996b72387c58.gif\\\";s:8:\\\"diskType\\\";s:5:\\\"local\\\";s:12:\\\"originalName\\\";s:17:\\\"gif apex logo.gif\\\";s:9:\\\"page_type\\\";s:5:\\\"logos\\\";s:8:\\\"fileType\\\";s:5:\\\"image\\\";s:7:\\\"batchId\\\";s:36:\\\"a11d9932-a833-4a68-b263-eb859965b486\\\";}\"},\"createdAt\":1771484963,\"delay\":null}',0,NULL,1771484963,1771484963),
(21,'default','{\"uuid\":\"353c34c4-0909-470d-9788-a987937ca48c\",\"displayName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"command\":\"O:26:\\\"App\\\\Jobs\\\\ProcessFileUpload\\\":7:{s:11:\\\"filemanager\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Modules\\\\Filemanager\\\\Models\\\\Filemanager\\\";s:2:\\\"id\\\";i:7;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:8:\\\"filePath\\\";s:40:\\\"temp\\/uploads\\/9_x_16_re_699b39d10d7e2.gif\\\";s:8:\\\"diskType\\\";s:5:\\\"local\\\";s:12:\\\"originalName\\\";s:13:\\\"9 x 16 re.gif\\\";s:9:\\\"page_type\\\";s:5:\\\"logos\\\";s:8:\\\"fileType\\\";s:5:\\\"image\\\";s:7:\\\"batchId\\\";s:36:\\\"a1247b18-c06e-4865-9cf9-240f2dde556a\\\";}\"},\"createdAt\":1771780561,\"delay\":null}',0,NULL,1771780561,1771780561),
(22,'default','{\"uuid\":\"94848f33-c73d-4e58-a036-6ec10ca907cd\",\"displayName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"command\":\"O:26:\\\"App\\\\Jobs\\\\ProcessFileUpload\\\":7:{s:11:\\\"filemanager\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Modules\\\\Filemanager\\\\Models\\\\Filemanager\\\";s:2:\\\"id\\\";i:8;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:8:\\\"filePath\\\";s:41:\\\"temp\\/uploads\\/applogotop_699b5bb03c055.png\\\";s:8:\\\"diskType\\\";s:5:\\\"local\\\";s:12:\\\"originalName\\\";s:14:\\\"applogotop.png\\\";s:9:\\\"page_type\\\";s:5:\\\"logos\\\";s:8:\\\"fileType\\\";s:5:\\\"image\\\";s:7:\\\"batchId\\\";s:36:\\\"a124aec7-eabe-424c-a12b-080ec399f8d2\\\";}\"},\"createdAt\":1771789232,\"delay\":null}',0,NULL,1771789232,1771789232),
(23,'default','{\"uuid\":\"7af22ebf-c599-4cdc-8b2a-5b76639a3411\",\"displayName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"command\":\"O:26:\\\"App\\\\Jobs\\\\ProcessFileUpload\\\":7:{s:11:\\\"filemanager\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Modules\\\\Filemanager\\\\Models\\\\Filemanager\\\";s:2:\\\"id\\\";i:9;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:8:\\\"filePath\\\";s:47:\\\"temp\\/uploads\\/apple_touch_icon_699b5c040fdc2.png\\\";s:8:\\\"diskType\\\";s:5:\\\"local\\\";s:12:\\\"originalName\\\";s:20:\\\"apple-touch-icon.png\\\";s:9:\\\"page_type\\\";s:5:\\\"logos\\\";s:8:\\\"fileType\\\";s:5:\\\"image\\\";s:7:\\\"batchId\\\";s:36:\\\"a124af47-b640-4d79-a224-198bb82142c4\\\";}\"},\"createdAt\":1771789316,\"delay\":null}',0,NULL,1771789316,1771789316),
(24,'default','{\"uuid\":\"6626756d-e4ac-4cd6-90a1-1be4a7fdc46f\",\"displayName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"command\":\"O:26:\\\"App\\\\Jobs\\\\ProcessFileUpload\\\":7:{s:11:\\\"filemanager\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Modules\\\\Filemanager\\\\Models\\\\Filemanager\\\";s:2:\\\"id\\\";i:10;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:8:\\\"filePath\\\";s:47:\\\"temp\\/uploads\\/apple_touch_icon_699b615b6b2fe.png\\\";s:8:\\\"diskType\\\";s:5:\\\"local\\\";s:12:\\\"originalName\\\";s:20:\\\"apple-touch-icon.png\\\";s:9:\\\"page_type\\\";s:5:\\\"logos\\\";s:8:\\\"fileType\\\";s:5:\\\"image\\\";s:7:\\\"batchId\\\";s:36:\\\"a124b76e-3bfa-4847-943d-026070b5e605\\\";}\"},\"createdAt\":1771790683,\"delay\":null}',0,NULL,1771790683,1771790683),
(25,'default','{\"uuid\":\"b4b3ea6e-953b-443e-a459-3448e59a8139\",\"displayName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"command\":\"O:26:\\\"App\\\\Jobs\\\\ProcessFileUpload\\\":7:{s:11:\\\"filemanager\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Modules\\\\Filemanager\\\\Models\\\\Filemanager\\\";s:2:\\\"id\\\";i:11;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:8:\\\"filePath\\\";s:40:\\\"temp\\/uploads\\/9_x_16_re_699b673b78bd3.gif\\\";s:8:\\\"diskType\\\";s:5:\\\"local\\\";s:12:\\\"originalName\\\";s:13:\\\"9 x 16 re.gif\\\";s:9:\\\"page_type\\\";s:5:\\\"logos\\\";s:8:\\\"fileType\\\";s:5:\\\"image\\\";s:7:\\\"batchId\\\";s:36:\\\"a124c065-4213-4dab-a1e3-a7c9a9b4afc6\\\";}\"},\"createdAt\":1771792187,\"delay\":null}',0,NULL,1771792187,1771792187),
(26,'default','{\"uuid\":\"ec9ba958-6b6a-4fe4-8140-54e1ec3b1e53\",\"displayName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\ProcessFileUpload\",\"command\":\"O:26:\\\"App\\\\Jobs\\\\ProcessFileUpload\\\":7:{s:11:\\\"filemanager\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Modules\\\\Filemanager\\\\Models\\\\Filemanager\\\";s:2:\\\"id\\\";i:12;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:8:\\\"filePath\\\";s:41:\\\"temp\\/uploads\\/applogotop_699b67564394c.png\\\";s:8:\\\"diskType\\\";s:5:\\\"local\\\";s:12:\\\"originalName\\\";s:14:\\\"applogotop.png\\\";s:9:\\\"page_type\\\";s:5:\\\"logos\\\";s:8:\\\"fileType\\\";s:5:\\\"image\\\";s:7:\\\"batchId\\\";s:36:\\\"a124c08e-0895-4184-ab65-14e98a238bf0\\\";}\"},\"createdAt\":1771792214,\"delay\":null}',0,NULL,1771792214,1771792214);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) NOT NULL,
  `value` varchar(191) NOT NULL,
  `language` varchar(191) NOT NULL,
  `file` varchar(191) NOT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entertainment_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_like` tinyint(1) NOT NULL DEFAULT 0,
  `profile_id` int(11) DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES
(1,1,6,1,6,'tvshow',6,6,NULL,'2024-09-25 15:23:07','2024-09-25 15:23:07',NULL),
(2,5,6,1,6,'tvshow',6,6,NULL,'2024-09-25 15:24:20','2024-09-25 15:24:20',NULL),
(3,10,4,1,4,'tvshow',3,3,NULL,'2024-09-25 15:24:27','2024-09-25 15:24:27',NULL),
(4,14,4,1,4,'tvshow',3,3,NULL,'2024-09-25 15:24:45','2024-09-25 15:24:45',NULL),
(5,94,4,1,4,'movie',4,4,NULL,'2024-09-25 15:26:42','2024-09-25 15:26:42',NULL),
(6,45,10,1,10,'movie',3,3,NULL,'2024-09-25 15:27:07','2024-09-25 15:27:07',NULL),
(7,90,12,1,12,'movie',4,4,NULL,'2024-09-25 15:27:19','2024-09-25 15:27:19',NULL),
(8,95,12,1,12,'movie',6,6,NULL,'2024-09-25 15:27:31','2024-09-25 15:27:31',NULL),
(9,95,7,1,7,'movie',7,7,NULL,'2024-09-25 15:29:34','2024-09-25 15:29:34',NULL),
(10,102,7,1,7,'movie',7,7,NULL,'2024-09-25 15:30:12','2024-09-25 15:30:12',NULL),
(11,101,7,1,7,'movie',7,7,NULL,'2024-09-25 15:30:24','2024-09-25 15:30:24',NULL),
(12,99,7,1,7,'video',7,7,NULL,'2024-09-25 15:30:29','2024-09-25 15:30:29',NULL),
(13,14,7,1,7,'video',7,7,NULL,'2024-09-25 15:30:46','2024-09-25 15:30:46',NULL),
(14,10,8,1,8,'video',7,7,NULL,'2024-09-25 15:30:53','2024-09-25 15:30:53',NULL),
(15,5,9,1,9,'video',7,7,NULL,'2024-09-25 15:31:02','2024-09-25 15:31:02',NULL),
(16,1,14,1,14,'tvshow',7,7,NULL,'2024-09-25 15:31:10','2024-09-25 15:31:10',NULL),
(17,1,5,1,5,'tvshow',5,5,NULL,'2024-09-25 15:32:25','2024-09-25 15:32:25',NULL),
(18,5,5,1,5,'tvshow',5,5,NULL,'2024-09-25 15:32:38','2024-09-25 15:32:38',NULL),
(19,89,5,1,5,'movie',5,5,NULL,'2024-09-25 15:32:43','2024-09-25 15:32:43',NULL),
(20,101,5,1,5,'move',5,5,NULL,'2024-09-25 15:32:49','2024-09-25 15:32:49',NULL),
(21,87,5,1,5,'movie',5,5,NULL,'2024-09-25 15:32:53','2024-09-25 15:32:53',NULL),
(22,102,5,1,5,'movie',5,5,NULL,'2024-09-25 15:32:57','2024-09-25 15:32:57',NULL),
(23,97,5,1,5,'movie',5,5,NULL,'2024-09-25 15:33:06','2024-09-25 15:33:06',NULL),
(24,98,5,1,5,'movie',5,5,NULL,'2024-09-25 15:33:13','2024-09-25 15:33:13',NULL),
(25,103,5,1,5,'movie',5,5,NULL,'2024-09-25 15:33:26','2024-09-25 15:33:26',NULL),
(26,100,3,1,3,'movie',5,5,NULL,'2024-09-25 15:33:26','2024-09-25 15:33:26',NULL),
(27,25,3,1,3,'movie',5,5,NULL,'2024-09-25 15:33:26','2024-09-25 15:33:26',NULL),
(28,16,3,1,3,'movie',5,5,NULL,'2024-09-25 15:33:26','2024-09-25 15:33:26',NULL);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `live_tv_category`
--

DROP TABLE IF EXISTS `live_tv_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_tv_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `file_url` text DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `slug` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `live_tv_category`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `live_tv_category` WRITE;
/*!40000 ALTER TABLE `live_tv_category` DISABLE KEYS */;
INSERT INTO `live_tv_category` VALUES
(1,'News & Current Affairs','news_current_affairs.png','Stay informed with the latest updates from around the world. This category brings you live news broadcasts, in-depth analysis, and breaking news coverage. From politics to finance, and global events to local happenings, never miss a moment of what\'s happening. 📰🌍🕒',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'news-current-affairs'),
(2,'Sports & Action','sports_action.png','Catch all the live sports action from your favorite games and tournaments. Whether it\'s football, basketball, tennis, or any other sport, this category covers live matches, expert commentary, and thrilling highlights. Cheer for your teams and witness unforgettable moments. 🏆⚽🏀',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'sports-action'),
(3,'Entertainment & Variety','entertainment_variety.png','Enjoy a diverse range of live entertainment shows, from reality TV and talent competitions to talk shows and award ceremonies. This category offers something for everyone, featuring your favorite stars and hosts bringing you laughter, drama, and excitement. 🎤🎬🎉',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'entertainment-variety'),
(4,'Music & Concerts','music_concerts.png','Experience live music like never before with concerts, festivals, and exclusive performances from top artists. This category brings the stage to your screen, allowing you to enjoy your favorite genres and discover new talents from the comfort of your home. 🎸🎤🎶',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'music-concerts'),
(5,'Educational & Documentary','educational_documentary.png','Expand your knowledge with live educational programs and documentaries covering a wide range of topics. From science and history to nature and technology, this category provides informative content that enlightens and inspires. Ideal for curious minds of all ages. 📚🔬🌿',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'educational-documentary');
/*!40000 ALTER TABLE `live_tv_category` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `live_tv_channel`
--

DROP TABLE IF EXISTS `live_tv_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_tv_channel` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) DEFAULT NULL,
  `poster_url` text DEFAULT NULL,
  `category_id` bigint(20) unsigned DEFAULT NULL,
  `thumb_url` text DEFAULT NULL,
  `access` varchar(191) DEFAULT NULL,
  `plan_id` bigint(20) unsigned DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `poster_tv_url` text DEFAULT NULL,
  `slug` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `live_tv_channel`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `live_tv_channel` WRITE;
/*!40000 ALTER TABLE `live_tv_channel` DISABLE KEYS */;
INSERT INTO `live_tv_channel` VALUES
(1,'Aaj Kal LIVE TV','aaj_kal_live_tv.png',1,'aaj_kal_live_tv.png','free',NULL,'Stay informed with live news broadcasts and in-depth analysis on Aaj Kal LIVE TV. Never miss a moment of the latest updates from around the world.',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'aaj_kal_live_tv.png','aaj-kal-live-tv'),
(2,'ABP Sports','abp_sports.png',2,'abp_sports.png','paid',1,'Catch all the live sports action on ABP Sports, covering your favorite games and tournaments with expert commentary and thrilling highlights.',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'abp_sports.png','abp-sports'),
(3,'DN TV','dn_tv.png',3,'dn_tv.png','paid',2,'Enjoy a variety of entertainment shows on DN TV, featuring reality TV, talent competitions, talk shows, and award ceremonies.',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'dn_tv.png','dn-tv'),
(4,'9xm','9xm.png',4,'9xm.png','paid',3,'Music & Concerts channel featuring live performances and more.',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'9xm.png','9xm'),
(5,'BBP','bbp.png',5,'bbp.png','paid',4,'Educational & Documentary channel with a wide range of informative content.',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'bbp.png','bbp'),
(6,'M TV','m_tv.png',4,'m_tv.png','free',NULL,'Free Music & Concerts channel with live performances and more.',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'m_tv.png','m-tv'),
(7,'ZNews 24/7','znews_247.png',1,'znews_247.png','free',NULL,'Round-the-clock coverage of global news and current events to keep you informed all day. 🌍🕓',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'znews_247.png','znews-247'),
(8,'Sports Max','sports_max.png',2,'sports_max.png','paid',1,'The ultimate channel for live sports events, from football to cricket, with non-stop action. 🏆📢',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'sports_max.png','sports-max'),
(9,'Vibe TV','vibe_tv.png',3,'vibe_tv.png','paid',2,'The hottest variety of live entertainment, from reality shows to talk shows and much more. 🎭🔥',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'vibe_tv.png','vibe-tv'),
(10,'Beat Box','beat_box.png',4,'beat_box.png','free',NULL,'Feel the beat with live music performances, DJ sets, and non-stop tunes. 🎧🎵',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'beat_box.png','beat-box'),
(11,'Brain TV','brain_tv.png',5,'brain_tv.png','paid',4,'Dive into a world of learning with live educational shows and insightful documentaries. 🧠📺',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'brain_tv.png','brain-tv'),
(12,'Khabar NOW','khabar_now.png',1,'khabar_now.png','paid',2,'Instant access to real-time news and headlines that matter most, bringing the world to your screen. 📰📢',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'khabar_now.png','khabar-now'),
(13,'Goal TV','goal_tv.png',2,'goal_tv.png','free',NULL,'Your destination for all things football, with live coverage of matches, interviews, and goals. ⚽🎥',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'goal_tv.png','goal-tv'),
(14,'Star Bliss','star_bliss.png',3,'star_bliss.png','free',NULL,'Bringing you a star-studded lineup of live entertainment, talk shows, and celebrity interviews. ⭐🎬',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'star_bliss.png','star-bliss'),
(15,'Groove LIVE','groove_live.png',4,'groove_live.png','free',NULL,'Get into the groove with live music shows, concerts, and your favorite artists. 🎼🎸',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'groove_live.png','groove-live'),
(16,'Docu Vision','docu_vision.png',5,'docu_vision.png','paid',4,'Explore fascinating live documentaries on a range of topics, from history to science. 📚🎬',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'docu_vision.png','docu-vision'),
(17,'Vision TV','vision_tv.png',1,'vision_tv.png','free',NULL,'Sharp and focused news, providing clear insights into the events shaping the world today. 🔍📺',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'vision_tv.png','vision-tv'),
(18,'Win Sports','win_sports.png',2,'win_sports.png','paid',1,'Bringing the winning moments from the biggest sporting events, straight to your screen, live. 🎖️📺',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'win_sports.png','win-sports'),
(19,'Buzz LIVE','buzz_live.png',3,'buzz_live.png','free',NULL,'All the buzzworthy content in one place, from live interviews to fun, energetic shows. 🎤⚡',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'buzz_live.png','buzz-live'),
(20,'Tune IN','tune_in.png',4,'tune_in.png','paid',3,'Stay tuned to the latest live music performances and the freshest beats from top artists. 🎙️📻',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'tune_in.png','tune-in'),
(21,'DiscoverX','discoverx.png',5,'discoverx.png','paid',4,'Uncover the unknown with live explorations and educational content from around the globe. 🌍🔎',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'discoverx.png','discoverx'),
(22,'HeadlineX','headlinex.png',1,'headlinex.png','free',NULL,'Your go-to for breaking headlines and live updates, keeping you in the know. 🗞️🎯',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'headlinex.png','headlinex'),
(23,'Xtreme Sports','xtreme_sports.png',2,'xtreme_sports.png','paid',2,'Tune in for adrenaline-pumping sports events, from extreme sports to intense competition. 🏄‍♂️🔥',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'xtreme_sports.png','xtreme-sports'),
(24,'Fun Box','fun_box.png',3,'fun_box.png','free',NULL,'A playful mix of live comedy, gameshows, and entertainment to keep you laughing. 🤣📺',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'fun_box.png','fun-box'),
(25,'Sound Wave','sound_wave.png',4,'sound_wave.png','paid',2,'Feel the pulse of live music as you experience concerts and performances from the world’s best artists. 🎤🌊',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'sound_wave.png','sound-wave'),
(26,'Learn LIVE','learn_live.png',5,'learn_live.png','paid',4,'Interactive educational programming, live lectures, and documentaries to spark your curiosity. 🎓📡',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'learn_live.png','learn-live'),
(27,'Live Line','live_line.png',1,'live_line.png','free',NULL,'Breaking news, live updates, and in-depth analysis at the speed of live broadcast. 📡⚡',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'live_line.png','live-line'),
(28,'Pro Play','pro_play.png',2,'pro_play.png','paid',3,'Watch your favorite athletes and teams go head-to-head in thrilling live action. 🏅🎬',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'pro_play.png','pro-play'),
(29,'Show MAX','show_max.png',3,'show_max.png','paid',2,'Maximize your entertainment with live shows, contests, and endless variety! 🎭💫',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'show_max.png','show-max'),
(30,'RhythmX','rhythmx.png',4,'rhythmx.png','free',NULL,'Tune in for live performances, chart-topping hits, and music from around the world. 🎶🎧',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'rhythmx.png','rhythmx'),
(31,'Insight TV','insight_tv.png',5,'insight_tv.png','free',NULL,'Dive deep into thought-provoking live content that educates and inspires, from documentaries to expert talks. 📘🔍',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'insight_tv.png','insight-tv'),
(32,'Live News Channel','app-live-channel-1.jpg',1,'web-live-channel-1.jpg','free',NULL,'Watch live news coverage with real-time updates on breaking events, politics, business, and global affairs. Stay informed with reliable reporting as stories unfold.',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'tv-live-channel-1.jpg','live-news-channel'),
(33,'Live WWE','app-live-wwe.jpg',2,'web-live-wwe.jpg','free',NULL,'Watch live WWE events featuring intense matches, exclusive moments, and nonstop wrestling action.Experience the thrill of WWE as it happens, all in one place.',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'tv-live-wwe.jpg','live-wwe'),
(34,'Hindi News Channel','app-live-news.jpg',1,'web-live-news.jpg','free',NULL,'Watch live news coverage with real-time updates on breaking events, politics, business, and global affairs. Stay informed with reliable reporting as stories unfold.',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'tv-live-news.jpg','hindi-news-channel'),
(35,'Soccer','app-live-soccer.jpg',2,'web-live-soccer.jpg','free',NULL,'Track live scores with real-time updates across ongoing matches and tournaments.Stay updated with accurate scores as the action unfolds.',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL,'tv-live-soccer.jpg','soccer'),
(36,'Apex live','generated_image_(4)_69a73079e71ef.png',1,'generated_image_(4)_69a73079e71ef.png','free',NULL,NULL,1,15,15,NULL,'2026-03-07 19:43:03','2026-03-07 19:43:03',NULL,'generated_image_(4)_69a73079e71ef.png','apex-live');
/*!40000 ALTER TABLE `live_tv_channel` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `live_tv_stream_content_mapping`
--

DROP TABLE IF EXISTS `live_tv_stream_content_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_tv_stream_content_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tv_channel_id` bigint(20) unsigned NOT NULL,
  `type` varchar(191) DEFAULT NULL,
  `stream_type` varchar(191) DEFAULT NULL,
  `embedded` longtext DEFAULT NULL,
  `server_url` text DEFAULT NULL,
  `server_url1` text DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `live_tv_stream_content_mapping`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `live_tv_stream_content_mapping` WRITE;
/*!40000 ALTER TABLE `live_tv_stream_content_mapping` DISABLE KEYS */;
INSERT INTO `live_tv_stream_content_mapping` VALUES
(1,1,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(2,2,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(3,3,'t_url','URL',NULL,'https://abplivetv.akamaized.net/hls/live/2043010/hindi/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(4,4,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(5,5,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(6,6,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(7,7,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(8,8,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(9,9,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(10,10,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(11,11,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(12,12,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(13,13,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(14,14,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(15,15,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(16,16,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(17,17,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(18,18,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(19,19,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(20,20,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(21,21,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(22,22,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(23,23,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(24,24,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(25,25,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(26,26,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(27,27,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(28,28,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(29,29,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(30,30,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(31,31,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(32,32,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(33,33,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(34,34,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(35,35,'t_url','URL',NULL,'https://feeds.intoday.in/aajtak/api/aajtakhd/master.m3u8',NULL,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(36,36,'t_url','HLS',NULL,'https://itassist.one/apex/ent/index.m3u8',NULL,15,15,NULL,'2026-03-07 19:43:03','2026-03-07 19:43:03',NULL),
(37,36,'t_url','HLS',NULL,'https://itassist.one/apex/ent/index.m3u8',NULL,15,15,NULL,'2026-03-07 19:43:03','2026-03-07 19:43:03',NULL);
/*!40000 ALTER TABLE `live_tv_stream_content_mapping` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `livetvs`
--

DROP TABLE IF EXISTS `livetvs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `livetvs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livetvs`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `livetvs` WRITE;
/*!40000 ALTER TABLE `livetvs` DISABLE KEYS */;
/*!40000 ALTER TABLE `livetvs` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  `uuid` char(36) DEFAULT NULL,
  `collection_name` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `file_name` varchar(191) NOT NULL,
  `mime_type` varchar(191) DEFAULT NULL,
  `disk` varchar(191) NOT NULL,
  `conversions_disk` varchar(191) DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `manipulations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`manipulations`)),
  `custom_properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`custom_properties`)),
  `generated_conversions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`generated_conversions`)),
  `responsive_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`responsive_images`)),
  `order_column` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `media_uuid_unique` (`uuid`),
  KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  KEY `media_order_column_index` (`order_column`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(1,'2019_12_14_000001_create_personal_access_tokens_table',1),
(2,'2023_01_01_000010_create_users_table',1),
(3,'2023_01_01_000012_create_user_providers_table',1),
(4,'2023_01_01_000020_create_password_resets_table',1),
(5,'2023_01_01_000021_create_permission_tables',1),
(6,'2023_01_01_000040_create_settings_table',1),
(7,'2023_01_01_000041_create_notifications_table',1),
(8,'2023_01_01_000200_create_media_table',1),
(9,'2023_01_01_000400_create_activity_log_table',1),
(10,'2023_01_01_000400_create_failed_jobs_table',1),
(11,'2023_01_27_141241_create_service_providers_table',1),
(12,'2023_01_27_190720_create_addresses_table',1),
(13,'2023_04_11_120721_create_notificationtemplates_table',1),
(14,'2023_04_11_140938_NotificationTemplateContentMapping',1),
(15,'2023_04_27_113639_create_planlimitation_table',1),
(16,'2023_05_02_111101_create_plan_table',1),
(17,'2023_05_02_111622_create_planlimitation_mapping_table',1),
(18,'2023_05_06_160755_create_subscriptions_table',1),
(19,'2023_05_06_160843_create_subscriptions_transactions_table',1),
(20,'2023_06_17_075047_create_webhook_calls_table',1),
(21,'2023_06_17_121725_create_jobs_table',1),
(22,'2023_06_21_170019_create_user_profiles_table',1),
(23,'2023_06_24_050019_create_modules_table',1),
(24,'2023_07_22_080045_create_languages_table',1),
(25,'2023_08_07_132655_alter_module_table',1),
(26,'2024_02_15_000001_add_fcm_token_to_users_table',1),
(27,'2024_05_20_095807_create_countries_table',1),
(28,'2024_05_20_095808_create_cities_table',1),
(29,'2024_05_20_095809_create_states_table',1),
(30,'2024_06_02_114414_create_genres_table',1),
(31,'2024_06_03_074305_create_cast_crew_table',1),
(32,'2024_06_06_073505_create_constants_table',1),
(33,'2024_06_06_120151_create_taxes_table',1),
(34,'2024_06_06_121650_create_devices_table',1),
(35,'2024_06_06_121909_create_worlds_table',1),
(36,'2024_06_07_085105_create_entertainments_table',1),
(37,'2024_06_07_092336_create_currencies_table',1),
(38,'2024_06_07_095208_create_livetvs_table',1),
(39,'2024_06_07_095529_create_live_tv_category_table',1),
(40,'2024_06_08_043704_create_watchlists_table',1),
(41,'2024_06_08_054515_create_entertainment_gener_mapping_table',1),
(42,'2024_06_08_054936_create_entertainment_talent_mapping_table',1),
(43,'2024_06_08_055333_create_entertainment_stream_content_mapping_table',1),
(44,'2024_06_08_065711_create_reviews_table',1),
(45,'2024_06_08_091320_create_settings_table',1),
(46,'2024_06_11_050857_create_seasons_table',1),
(47,'2024_06_11_084656_create_episodes_table',1),
(48,'2024_06_11_090807_create_episode_stream_content_mapping_table',1),
(49,'2024_06_13_073417_create_continue_watch_table',1),
(50,'2024_06_13_092807_create_likes_table',1),
(51,'2024_06_13_120109_create_videos_table',1),
(52,'2024_06_13_121428_create_video_stream_content_mapping_table',1),
(53,'2024_06_14_044624_create_entertainment_downloads_table',1),
(54,'2024_06_14_061737_create_live_tv_channel_table',1),
(55,'2024_06_14_062751_create_live_tv_stream_content_mapping_table',1),
(56,'2024_06_14_115456_create_filemanagers_table',1),
(57,'2024_06_15_083524_create_entertainment_download_mapping_table',1),
(58,'2024_06_18_041529_create_banners_table',1),
(59,'2024_06_20_094819_create_job_batches_table',1),
(60,'2024_06_21_070413_create_dashboard_settings_table',1),
(61,'2024_06_25_051445_create_user_reminder_table',1),
(62,'2024_06_26_054413_create_entertainment_views_table',1),
(63,'2024_07_01_075814_create_episode_download_mapping_table',1),
(64,'2024_07_03_122744_create_pages_table',1),
(65,'2024_07_09_094304_create_video_download_mappings_table',1),
(66,'2024_09_13_122239_create_faqs_table',1),
(67,'2024_09_18_111806_create_user_multi_profiles_table',1),
(68,'2024_09_19_072214_create_user_search_histories_table',1),
(69,'2024_09_19_084000_create_user_watch_histories_table',1),
(70,'2024_09_24_095445_create_entertainment_country_mapping_table',1),
(71,'2024_09_24_111520_create_sessions_table',1),
(72,'2024_11_06_121652_create_installers_table',1),
(73,'2024_12_17_053218_create_alter_continue_watch_table',1),
(74,'2025_01_22_113233_create_alter_review_table',1),
(75,'2025_03_26_173650_alter_user_multi_profiles_table',1),
(76,'2025_03_27_121756_alter_poster_tv_image_table',1),
(77,'2025_03_29_065106_alter_users_table_add_pin_otp_column',1),
(78,'2025_03_30_152325_index_for_profile_detail',1),
(79,'2025_03_31_112851_create_alter_episode_poster_tv_image_table',1),
(80,'2025_03_31_121344_create_alter_season_poster_tv_image_table',1),
(81,'2025_04_01_045818_add_banner_for_to_banners_table',1),
(82,'2025_04_01_162912_index_for_entertainments_table',1),
(83,'2025_04_02_072249_create_video_poster_tv_image_table',1),
(84,'2025_04_02_101553_create_tvchannel_poster_tv_image_table',1),
(85,'2025_04_02_104434_create_banner_poster_tv_image_table',1),
(86,'2025_04_04_161627_add_index_selected_table',1),
(87,'2025_04_14_093857_Coupon',1),
(88,'2025_04_15_071822_coupon_subscription_plan',1),
(89,'2025_04_17_052158_UserCouponRedeem',1),
(90,'2025_04_19_095303_add_parental_flag_users',1),
(91,'2025_05_02_074312_add_pricing_fields_to_entertainments_table',1),
(92,'2025_05_02_095730_add_pricing_fields_to_videos_table',1),
(93,'2025_05_02_111741_add_pricing_fields_to_seasons_table',1),
(94,'2025_05_02_115012_add_pricing_fields_to_episodes_table',1),
(95,'2025_05_05_040137_alter_entertainment_subtitle_table',1),
(96,'2025_05_06_094938_create_pay_per_views_table',1),
(97,'2025_05_07_040757_create_payperviewstransactions_table',1),
(98,'2025_05_09_091111_create_tv_login_sessions_table',1),
(99,'2025_05_10_034958_alter_subscriptions_table',1),
(100,'2025_05_10_091146_add_coupon_discount_to_subscriptions_table',1),
(101,'2025_05_13_114620_add_column_to_entertainment_table',1),
(102,'2025_05_16_103735_add_column_to_video_table',1),
(103,'2025_05_16_104824_add_column_to_video_table_subtitle_file',1),
(104,'2025_05_16_112032_add_column_to_episode_table_',1),
(105,'2025_05_19_094309_create_subtitle_tabel',1),
(106,'2025_05_22_055600_create_ads_table',1),
(107,'2025_05_22_055800_create_vast_ads_setting',1),
(108,'2025_05_22_083413_create_custom_ads_setting',1),
(109,'2025_05_23_000000_add_dates_to_vast_ads_setting',1),
(110,'2025_06_19_100923_add_start_end_date_to_custom_ads_setting_table',1),
(111,'2025_07_08_100927_create_seo_table',1),
(112,'2025_07_11_110337_add_columns_to_entertainments_table',1),
(113,'2025_07_14_100351_add_seo_fields_to_seasons_table',1),
(114,'2025_07_14_124514_add_seo_fields_to_epispdes_table',1),
(115,'2025_07_15_103922_add_seo_fields_to_videos_table',1),
(116,'2025_08_19_084841_alter_role_permission_table',1),
(117,'2025_08_21_054322_alter_seo_cloumns_remove',1),
(118,'2025_09_01_000000_add_mail_and_user_type_to_notification_template_content_mapping',1),
(119,'2025_09_02_000000_refresh_notification_templates',1),
(120,'2025_09_16_054414_add_skip_intro_fields_to_entertainments_table',1),
(121,'2025_09_22_052737_create_clips_table',1),
(122,'2025_09_29_064919_create_web_qr_sessions_table',1),
(123,'2025_10_10_044320_add_language_image_url_to_constants_table',1),
(124,'2025_10_14_055640_add_description_to_banners_table',1),
(125,'2025_10_29_104110_add_country_code_to_users_table',1),
(126,'2025_10_31_092651_create_onboardings_table',1),
(127,'2025_11_03_120500_add_onboarding_permissions_to_roles',1),
(128,'2025_11_05_082128_add_thumbnail_url_to_videos_table',1),
(129,'2025_11_12_103358_add_status_to_cast_crew_table',1),
(130,'2025_12_12_084715_add_episode_ids',1),
(131,'2025_12_17_061159_add_session_id_and_last_activity_to_devices_table',1),
(132,'2026_02_13_170829_add_soft_deletes_to_engagement_tables',1),
(133,'2026_02_13_171150_add_missing_shorts_columns',1),
(134,'2025_02_13_000002_add_missing_music_tables',2),
(135,'2026_02_25_000001_create_audio_table',3),
(136,'2026_02_25_000002_create_reels_table',3),
(137,'2026_02_25_000003_create_reel_interactions_table',3),
(138,'2026_03_25_000001_create_music_listening_sessions_table',4),
(139,'2026_03_25_000002_create_user_music_preferences_table',5);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `mobile_settings`
--

DROP TABLE IF EXISTS `mobile_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mobile_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) DEFAULT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mobile_settings_slug_deleted_at_index` (`slug`,`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobile_settings`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `mobile_settings` WRITE;
/*!40000 ALTER TABLE `mobile_settings` DISABLE KEYS */;
INSERT INTO `mobile_settings` VALUES
(1,'Banner','banner',1,'1','2024-07-12 10:28:06','2024-07-12 10:28:06',NULL,NULL),
(2,'Continue Watching','continue-watching',2,'1','2024-07-12 10:28:21','2024-07-12 10:28:21',NULL,NULL),
(3,'Top 10','top-10',3,'[\"40\",\"38\",\"69\",\"49\",\"76\",\"89\",\"94\",\"95\",\"99\",\"102\"]','2024-07-12 10:28:33','2024-07-12 10:43:17',NULL,NULL),
(4,'Advertisement','advertisement',4,'1','2024-07-12 10:28:47','2024-07-12 10:28:47',NULL,NULL),
(5,'Latest Movies','latest-movies',5,'[\"103\",\"97\",\"102\",\"95\",\"96\",\"100\",\"98\",\"94\"]','2024-07-12 10:29:02','2024-07-12 10:44:11',NULL,NULL),
(6,'Popular language','enjoy-in-your-native-tongue',6,'[\"51\",\"52\",\"53\",\"54\",\"55\",\"56\",\"57\"]','2024-07-12 10:29:20','2024-07-12 10:33:08',NULL,NULL),
(7,'Popular Movies','popular-movies',7,'[\"22\",\"25\",\"26\",\"28\",\"29\",\"31\",\"34\",\"36\",\"37\",\"40\",\"38\"]','2024-07-12 10:29:36','2024-07-12 10:48:33',NULL,NULL),
(8,'Top Channels','top-channels',8,'[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\"]','2024-07-12 10:30:54','2024-07-12 10:30:54',NULL,NULL),
(9,'Popular Personalities','your-favorite-personality',9,'[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\"]','2024-07-12 10:31:08','2024-07-12 10:47:13',NULL,NULL),
(10,'Free Movies','500-free-movies',10,'[\"21\",\"23\",\"24\",\"25\",\"30\",\"31\",\"32\",\"34\",\"33\",\"35\"]','2024-07-12 10:31:38','2024-07-12 10:47:34',NULL,NULL),
(11,'Genres','genre',11,'[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\"]','2024-07-12 10:31:52','2024-07-12 10:49:42',NULL,NULL),
(12,'Rate our app','rate-our-app',12,'1','2024-07-12 10:32:08','2024-07-12 10:32:08',NULL,NULL),
(13,'Popular TV Show','popular-tvshows',13,'[4,6,1,8,10,17,9,12]','2024-07-12 10:29:36','2024-07-12 10:48:33',NULL,NULL),
(14,'Popular Videos','popular-videos',14,'[\"1\",\"2\",\"3\",\"4\",\"5\",\"12\",\"14\",\"15\",\"17\",\"18\",\"19\",\"20\",\"25\",\"35\"]','2024-07-12 10:29:36','2024-07-12 10:48:33',NULL,NULL);
/*!40000 ALTER TABLE `mobile_settings` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES
(1,'App\\Models\\User',1),
(2,'App\\Models\\User',2),
(3,'App\\Models\\User',3),
(3,'App\\Models\\User',4),
(3,'App\\Models\\User',5),
(3,'App\\Models\\User',6),
(3,'App\\Models\\User',7),
(3,'App\\Models\\User',8),
(3,'App\\Models\\User',9),
(3,'App\\Models\\User',10),
(3,'App\\Models\\User',11),
(3,'App\\Models\\User',12),
(3,'App\\Models\\User',13),
(3,'App\\Models\\User',14),
(1,'App\\Models\\User',15),
(3,'App\\Models\\User',16),
(3,'App\\Models\\User',17),
(3,'App\\Models\\User',21),
(3,'App\\Models\\User',22),
(3,'App\\Models\\User',23),
(3,'App\\Models\\User',24),
(3,'App\\Models\\User',25),
(3,'App\\Models\\User',26),
(3,'App\\Models\\User',27),
(3,'App\\Models\\User',28),
(3,'App\\Models\\User',29),
(3,'App\\Models\\User',30);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `module_name` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `more_permission` text DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_custom_permission` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `music_albums`
--

DROP TABLE IF EXISTS `music_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `music_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `cover_art_url` text DEFAULT NULL,
  `artist_name` varchar(191) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `genre` varchar(191) DEFAULT NULL,
  `copyright_info` text DEFAULT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_trending` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `category_id` bigint(20) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `music_albums_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music_albums`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `music_albums` WRITE;
/*!40000 ALTER TABLE `music_albums` DISABLE KEYS */;
/*!40000 ALTER TABLE `music_albums` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `music_categories`
--

DROP TABLE IF EXISTS `music_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `music_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(191) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `music_categories_name_unique` (`name`),
  UNIQUE KEY `music_categories_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music_categories`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `music_categories` WRITE;
/*!40000 ALTER TABLE `music_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `music_categories` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `music_engagement`
--

DROP TABLE IF EXISTS `music_engagement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `music_engagement` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `track_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `engagement_type` enum('like','play','download') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_music_engagement` (`track_id`,`user_id`,`engagement_type`),
  KEY `music_engagement_user_id_foreign` (`user_id`),
  CONSTRAINT `music_engagement_track_id_foreign` FOREIGN KEY (`track_id`) REFERENCES `music_tracks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `music_engagement_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music_engagement`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `music_engagement` WRITE;
/*!40000 ALTER TABLE `music_engagement` DISABLE KEYS */;
/*!40000 ALTER TABLE `music_engagement` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `music_listening_sessions`
--

DROP TABLE IF EXISTS `music_listening_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `music_listening_sessions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `track_id` bigint(20) unsigned NOT NULL,
  `started_at` timestamp NOT NULL,
  `ended_at` timestamp NULL DEFAULT NULL,
  `duration_listened` int(11) NOT NULL DEFAULT 0,
  `completion_percentage` decimal(5,2) NOT NULL DEFAULT 0.00,
  `device_type` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `music_listening_sessions_track_id_foreign` (`track_id`),
  KEY `music_listening_sessions_user_id_created_at_index` (`user_id`,`created_at`),
  CONSTRAINT `music_listening_sessions_track_id_foreign` FOREIGN KEY (`track_id`) REFERENCES `music_tracks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `music_listening_sessions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music_listening_sessions`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `music_listening_sessions` WRITE;
/*!40000 ALTER TABLE `music_listening_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `music_listening_sessions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `music_playlist_track`
--

DROP TABLE IF EXISTS `music_playlist_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `music_playlist_track` (
  `playlist_id` bigint(20) unsigned NOT NULL,
  `track_id` bigint(20) unsigned NOT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`playlist_id`,`track_id`),
  CONSTRAINT `music_playlist_track_playlist_id_foreign` FOREIGN KEY (`playlist_id`) REFERENCES `music_playlists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music_playlist_track`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `music_playlist_track` WRITE;
/*!40000 ALTER TABLE `music_playlist_track` DISABLE KEYS */;
/*!40000 ALTER TABLE `music_playlist_track` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `music_playlists`
--

DROP TABLE IF EXISTS `music_playlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `music_playlists` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `cover_art_url` text DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT 0,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `music_playlists_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music_playlists`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `music_playlists` WRITE;
/*!40000 ALTER TABLE `music_playlists` DISABLE KEYS */;
/*!40000 ALTER TABLE `music_playlists` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `music_tracks`
--

DROP TABLE IF EXISTS `music_tracks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `music_tracks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `isrc` char(36) DEFAULT NULL,
  `artist_name` varchar(191) NOT NULL,
  `album_name` varchar(191) DEFAULT NULL,
  `album_id` bigint(20) unsigned DEFAULT NULL,
  `artist_id` bigint(20) unsigned DEFAULT NULL,
  `description` text DEFAULT NULL,
  `genre` varchar(191) NOT NULL,
  `sub_genres` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`sub_genres`)),
  `duration` int(11) NOT NULL COMMENT 'Duration in seconds',
  `track_number` int(11) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `file_url` text DEFAULT NULL,
  `file_format` varchar(191) NOT NULL DEFAULT 'mp3' COMMENT 'mp3, flac, wav, aac',
  `file_size` bigint(20) DEFAULT NULL COMMENT 'Size in bytes',
  `bitrate` varchar(191) DEFAULT NULL COMMENT '128kbps, 256kbps, 320kbps, lossless',
  `sample_rate` varchar(191) DEFAULT NULL COMMENT '44.1kHz, 48kHz, 96kHz, 192kHz',
  `cover_art_url` text DEFAULT NULL,
  `lyrics` text DEFAULT NULL,
  `credits` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`credits`)),
  `copyright_info` varchar(191) DEFAULT NULL,
  `label` varchar(191) DEFAULT NULL,
  `price` decimal(8,2) NOT NULL DEFAULT 0.00,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tags`)),
  `is_explicit` tinyint(1) NOT NULL DEFAULT 0,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_trending` tinyint(1) NOT NULL DEFAULT 0,
  `is_premium` tinyint(1) NOT NULL DEFAULT 0,
  `allow_download` tinyint(1) NOT NULL DEFAULT 0,
  `allow_sharing` tinyint(1) NOT NULL DEFAULT 1,
  `play_count` bigint(20) unsigned NOT NULL DEFAULT 0,
  `like_count` bigint(20) unsigned NOT NULL DEFAULT 0,
  `share_count` bigint(20) unsigned NOT NULL DEFAULT 0,
  `download_count` bigint(20) unsigned NOT NULL DEFAULT 0,
  `rating` decimal(3,2) DEFAULT NULL,
  `rating_count` int(10) unsigned NOT NULL DEFAULT 0,
  `category_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `music_tracks_album_id_foreign` (`album_id`),
  CONSTRAINT `music_tracks_album_id_foreign` FOREIGN KEY (`album_id`) REFERENCES `music_albums` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music_tracks`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `music_tracks` WRITE;
/*!40000 ALTER TABLE `music_tracks` DISABLE KEYS */;
INSERT INTO `music_tracks` VALUES
(1,'Summer Vibes','summer-vibes',NULL,'The Beats','Sunny Days',NULL,NULL,'An uplifting pop track perfect for summer days','Pop',NULL,240,1,'2026-01-15',NULL,'mp3',NULL,'320kbps','44.1kHz',NULL,NULL,NULL,NULL,NULL,0.00,NULL,0,1,1,0,0,1,1250,89,45,0,4.50,234,NULL,1,1,1,1,NULL,'2026-02-27 21:06:53','2026-02-27 21:06:53'),
(2,'Midnight Dreams','midnight-dreams',NULL,'Luna Echo','Night Tales',NULL,NULL,'A mesmerizing electronic track for late night listening','Electronic',NULL,280,2,'2026-01-20',NULL,'mp3',NULL,'320kbps','48kHz',NULL,NULL,NULL,NULL,NULL,0.00,NULL,0,1,0,0,0,1,890,156,67,0,4.70,189,NULL,1,1,1,1,NULL,'2026-02-27 21:06:53','2026-02-27 21:06:53'),
(3,'Jazz Nights','jazz-nights',NULL,'Smooth Quartet','Urban Jazz',NULL,NULL,'Smooth jazz for relaxation and contemplation','Jazz',NULL,320,3,'2026-01-25',NULL,'flac',NULL,'lossless','96kHz',NULL,NULL,NULL,NULL,NULL,0.00,NULL,0,0,1,0,0,1,650,234,89,0,4.80,312,NULL,1,1,1,1,NULL,'2026-02-27 21:06:53','2026-02-27 21:06:53'),
(4,'Electric Pulse','electric-pulse',NULL,'Neon Lights','Digital Age',NULL,NULL,'High-energy synthwave with retro vibes','Synthwave',NULL,260,4,'2026-02-01',NULL,'mp3',NULL,'320kbps','44.1kHz',NULL,NULL,NULL,NULL,NULL,0.00,NULL,0,1,1,0,0,1,2100,567,234,0,4.60,456,NULL,1,1,1,1,NULL,'2026-02-27 21:06:53','2026-02-27 21:06:53'),
(5,'Acoustic Soul','acoustic-soul',NULL,'Wooden Strings','Unplugged',NULL,NULL,'Intimate acoustic performance with heartfelt lyrics','Acoustic',NULL,300,5,'2026-02-05',NULL,'wav',NULL,'lossless','192kHz',NULL,NULL,NULL,NULL,NULL,0.00,NULL,0,0,0,0,0,1,450,178,56,0,4.90,267,NULL,1,1,1,1,NULL,'2026-02-27 21:06:53','2026-02-27 21:06:53');
/*!40000 ALTER TABLE `music_tracks` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `notification_template_content_mapping`
--

DROP TABLE IF EXISTS `notification_template_content_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_template_content_mapping` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template_id` bigint(20) unsigned DEFAULT NULL,
  `language` varchar(191) DEFAULT NULL,
  `user_type` varchar(191) DEFAULT NULL,
  `template_detail` longtext DEFAULT NULL,
  `subject` varchar(191) DEFAULT NULL,
  `notification_subject` varchar(191) DEFAULT NULL,
  `notification_template_detail` longtext DEFAULT NULL,
  `notification_message` varchar(191) DEFAULT NULL,
  `notification_link` varchar(191) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_template_content_mapping`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `notification_template_content_mapping` WRITE;
/*!40000 ALTER TABLE `notification_template_content_mapping` DISABLE KEYS */;
INSERT INTO `notification_template_content_mapping` VALUES
(49,19,'en','user','\n            <p>Subject: Password Change alert</p>\n            <p>Dear [[ user_name ]],</p>\n            <p>Your password has been changed successfully.</p>\n            <br>\n            <p>Thank you,</p>\n            <p>[[ app_name ]]</p>\n          ','Change Password','Password Changed Successfully','Password change confirmation for [[ user_name ]] - Account security update completed.','Your password has been changed successfully.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(50,19,'en','admin','\n            <p>Subject: Admin Password Change Alert</p>\n            <p>Dear [[ user_name ]],</p>\n            <p>&nbsp;</p>\n            <p>This is an administrative notification regarding a password change for your admin account. As an administrator, please ensure this change was authorized and follows our security protocols.</p>\n            <p>&nbsp;</p>\n            <p>Security Recommendations:</p>\n            <p>&nbsp;</p>\n            <p>• Verify the change was initiated by you</p>\n            <p>• Use a strong, unique password</p>\n            <p>• Enable two-factor authentication if not already active</p>\n            <p>• Review recent account activities</p>\n            <p>&nbsp;</p>\n            <p>If you suspect unauthorized access, immediately:</p>\n            <p>• Contact system security team</p>\n            <p>• Review access logs</p>\n            <p>• Update other related credentials</p>\n            <p>&nbsp;</p>\n            <p>Best regards,</p>\n            <p>System Security Team<br />[[ company_name ]]</p>\n          ','Change Password','Admin Password Change Alert','Admin password change detected for [[ user_name ]] - Security verification required.','Admin password change notification sent.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(51,19,'en','demo_admin','\n            <p>Subject: Admin Password Change Alert</p>\n            <p>Dear [[ user_name ]],</p>\n            <p>&nbsp;</p>\n            <p>This is an administrative notification regarding a password change for your admin account. As an administrator, please ensure this change was authorized and follows our security protocols.</p>\n            <p>&nbsp;</p>\n            <p>Security Recommendations:</p>\n            <p>&nbsp;</p>\n            <p>• Verify the change was initiated by you</p>\n            <p>• Use a strong, unique password</p>\n            <p>• Enable two-factor authentication if not already active</p>\n            <p>• Review recent account activities</p>\n            <p>&nbsp;</p>\n            <p>If you suspect unauthorized access, immediately:</p>\n            <p>• Contact system security team</p>\n            <p>• Review access logs</p>\n            <p>• Update other related credentials</p>\n            <p>&nbsp;</p>\n            <p>Best regards,</p>\n            <p>System Security Team<br />[[ company_name ]]</p>\n          ','Change Password','Admin Password Change Alert','Admin password change detected for [[ user_name ]] - Security verification required.','Admin password change notification sent.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(52,20,'en','user','\n                 <h2>Password Change Successful </h2>\n                <p>Hello [[ user_name ]],</p>\n                <p>Your password has been changed successfully.</p>\n                <br>\n                <p>Thank you,</p>\n                <p>[[ app_name ]]</p>\n          ','Password Reset Successful','Your Password Has Been Updated','Hello [[ user_name ]], your password has been updated successfully for your account.','Your password has been successfully changed.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(53,20,'en','admin','\n            <p>Subject: Password Change Alert</p>\n            <p>&nbsp;</p>\n            <p>User [[ user_name ]] has successfully changed their account password.</p>\n            <br>\n            <p>Thank you,</p>\n            <p>[[ app_name ]]</p>\n          ','Password Change Successful','Password Change Alert','User [[ user_name ]] has successfully changed their account password.','User password has been changed successfully.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(54,20,'en','demo_admin','\n            <p>Subject: Password Change Alert</p>\n            <p>&nbsp;</p>\n            <p>User [[ user_name ]] has successfully changed their account password.</p>\n            <br>\n            <p>Thank you,</p>\n            <p>[[ app_name ]]</p>\n          ','Password Change Successful','Password Change Alert','User [[ user_name ]] has successfully changed their account password.','User password has been changed successfully.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(55,21,'en','user','<p>Dear [[ user_name ]],</p><p>Great news! A new TV show \"<strong>[[ tvshow_name ]]</strong>\" has been added to our collection.</p><p>Start watching now and enjoy the latest entertainment!</p>','TV Show Added!','New TV Show Available','New TV show \"[[ tvshow_name ]]\" added to collection - Start watching now!','New TV show \"[[ tvshow_name ]]\" has been added to our collection!','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(56,21,'en','admin','<p>Dear [[ user_name ]],</p><p>The TV show \"<strong>[[ tvshow_name ]]</strong>\" has been successfully added to the content management system.</p><p>Content Details:</p><ul><li>Show Name: [[ name ]]</li><li>Added By: [[ logged_in_user_fullname ]]</li><li>Status: Active</li></ul><p>Please review and verify the content details.</p>','TV Show Added!','Content Added - Review Required','TV show \"[[ tvshow_name ]]\" added by [[ logged_in_user_fullname ]] - Content management update.','TV show \"[[ tvshow_name ]]\" has been successfully added to the system.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(57,21,'en','demo_admin','<p>Dear [[ user_name ]],</p><p>The TV show \"<strong>[[ tvshow_name ]]</strong>\" has been successfully added to the content management system.</p><p>Content Details:</p><ul><li>Show Name: [[ name ]]</li><li>Added By: [[ logged_in_user_fullname ]]</li><li>Status: Active</li></ul><p>Please review and verify the content details.</p>','TV Show Added!','Content Added - Review Required','TV show \"[[ tvshow_name ]]\" added by [[ logged_in_user_fullname ]] - Content management update.','TV show \"[[ tvshow_name ]]\" has been successfully added to the system.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(58,22,'en','user','<p>Dear [[ user_name ]],</p>\r\n<p>Exciting news! A new movie \"<strong>[[ movie_name ]]</strong>\" is now available for streaming.</p>\r\n<p>Grab your popcorn and enjoy the latest entertainment!</p>','Movie Added!','New Movie Available','<p>New movie \"[[ movie_name ]]\" available for streaming - Grab your popcorn!</p>',NULL,NULL,1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-03-01 02:35:34',NULL),
(59,22,'en','admin','<p>Dear [[ user_name ]],</p><p>The movie \"<strong>[[ movie_name ]]</strong>\" has been successfully added to the content management system.</p><p>Content Details:</p><ul><li>Movie Title: [[ name ]]</li><li>Added By: [[ logged_in_user_fullname ]]</li><li>Status: Active</li><li>Available for streaming</li></ul><p>Please review the content details and metadata.</p>','Movie Added!','Content Added - Review Required','Movie \"[[ movie_name ]]\" added by [[ logged_in_user_fullname ]] - Content management update.','Movie \"[[ movie_name ]]\" has been successfully added to the content system.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(60,22,'en','demo_admin','<p>Dear [[ user_name ]],</p><p>The movie \"<strong>[[ movie_name ]]</strong>\" has been successfully added to the content management system.</p><p>Content Details:</p><ul><li>Movie Title: [[ name ]]</li><li>Added By: [[ logged_in_user_fullname ]]</li><li>Status: Active</li><li>Available for streaming</li></ul><p>Please review the content details and metadata.</p>','Movie Added!','Content Added - Review Required','Movie \"[[ movie_name ]]\" added by [[ logged_in_user_fullname ]] - Content management update.','Movie \"[[ movie_name ]]\" has been successfully added to the content system.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(61,23,'en','user','<p>Dear [[ user_name ]],</p><p>Great news! A new episode \"<strong>[[ episode_name ]]</strong>\" is now available for streaming.</p><p>Don\'t miss out on the latest episode!</p>','Episode Added!','New Episode Available','New episode \"[[ episode_name ]]\" available - Don\'t miss out!','New episode \"[[ episode_name ]]\" is now available!','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(62,23,'en','admin','<p>Dear [[ user_name ]],</p><p>The episode \"<strong>[[ episode_name ]]</strong>\" has been successfully added to the content management system.</p><p>Episode Details:</p><ul><li>Episode Name: [[ name ]]</li><li>Added By: [[ logged_in_user_fullname ]]</li><li>Status: Active</li><li>Available for streaming</li></ul><p>Please review the episode details and ensure proper metadata.</p>','Episode Added!','Content Added - Review Required','Episode \"[[ episode_name ]]\" added by [[ logged_in_user_fullname ]] - Content management update.','Episode \"[[ episode_name ]]\" has been successfully added to the system.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(63,23,'en','demo_admin','<p>Dear [[ user_name ]],</p><p>The episode \"<strong>[[ episode_name ]]</strong>\" has been successfully added to the content management system.</p><p>Episode Details:</p><ul><li>Episode Name: [[ name ]]</li><li>Added By: [[ logged_in_user_fullname ]]</li><li>Status: Active</li><li>Available for streaming</li></ul><p>Please review the episode details and ensure proper metadata.</p>','Episode Added!','Content Added - Review Required','Episode \"[[ episode_name ]]\" added by [[ logged_in_user_fullname ]] - Content management update.','Episode \"[[ episode_name ]]\" has been successfully added to the system.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(64,24,'en','user','<p>Dear [[ user_name ]],</p><p>Exciting news! A new season \"<strong>[[ season_name ]]</strong>\" is now available for streaming.</p><p>Get ready for hours of entertainment!</p>','Season Added!','New Season Available','New season \"[[ season_name ]]\" available - Get ready for hours of entertainment!','New season \"[[ season_name ]]\" is now available for streaming!','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(65,24,'en','admin','<p>Dear [[ user_name ]],</p><p>The season \"<strong>[[ season_name ]]</strong>\" has been successfully added to the content management system.</p><p>Season Details:</p><ul><li>Season Name: [[ name ]]</li><li>Added By: [[ logged_in_user_fullname ]]</li><li>Status: Active</li><li>Available for streaming</li></ul><p>Please review the season details and episode structure.</p>','Season Added!','Content Added - Review Required','Season \"[[ season_name ]]\" added by [[ logged_in_user_fullname ]] - Content management update.','Season \"[[ season_name ]]\" has been successfully added to the system.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(66,24,'en','demo_admin','<p>Dear [[ user_name ]],</p><p>The season \"<strong>[[ name ]]</strong>\" has been successfully added to the content management system.</p><p>Season Details:</p><ul><li>Season Name: [[ name ]]</li><li>Added By: [[ logged_in_user_fullname ]]</li><li>Status: Active</li><li>Available for streaming</li></ul><p>Please review the season details and episode structure.</p>','Season Added!','Content Added - Review Required','Season \"[[ name ]]\" added by [[ logged_in_user_fullname ]] - Content management update.','Season \"[[ name ]]\" has been successfully added to the system.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(67,25,'en','user','<h2>Welcome to  [[ app_name ]]🎉</h2><p>Your subscription has been activated successfully.</p><br><h2>Subscription Details</h2><p>User: [[ user_name ]]</p><p>Email: [[ user_email ]]</p><p>Contact No: [[ user_mobile ]]</p><p>Plan: [[ subscription_plan ]]</p><p>End Date: [[ end_date ]]</p><p>Amount: [[ amount_formatted ]]</p><p>Tax Amount: [[ tax_amount_formatted ]]</p><p>Total Amount: [[ total_amount_formatted ]]</p><p>Duration: [[ duration_formatted ]] </p>','New User is subscribe!','Welcome - Subscription Active!','Welcome [[ user_name ]]! Your subscription is now active - Start exploring our content library.','Welcome to our streaming platform! Your subscription is now active.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(68,25,'en','admin','<p>Dear [[ user_name ]],</p><p>A new user has subscribed to the platform.</p><p>Subscription Details:</p><ul><li>New User: [[ user_name ]]</li><li>Subscription Date: [[ start_date ]]</li><li>Plan Type: [[ subscription_plan ]]</li><li>Status: Active</li></ul><p>Please review the subscription details and welcome the new user.</p>','New User is subscribe!','New Subscription - Review Required','New user [[ user_name ]] subscribed - Plan: [[ subscription_plan ]]','New user subscription: [[ user_name ]] has joined the platform.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(69,25,'en','demo_admin','<p>Dear [[ user_name ]],</p><p>A new user has subscribed to the platform.</p><p>Subscription Details:</p><ul><li>New User: [[ user_name ]]</li><li>Subscription Date: [[ start_date ]]</li><li>Plan Type: [[ subscription_plan ]]</li><li>Status: Active</li></ul><p>Please review the subscription details and welcome the new user.</p>','New User is subscribe!','New Subscription - Review Required','New user [[ user_name ]] subscribed - Plan: [[ subscription_plan ]]','New user subscription: [[ user_name ]] has joined the platform.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(70,26,'en','user','<p>Dear [[ user_name ]],</p><p>We\'re sorry to see you go! Your subscription has been cancelled as requested.</p><p>You can reactivate your subscription anytime by visiting your account settings.</p><p>Thank you for being part of our community!</p>','A User is cancle subscribe!','Subscription Cancelled','Subscription cancelled for [[ user_name ]] - You can reactivate anytime.','Your subscription has been cancelled. We\'re sorry to see you go.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(71,26,'en','admin','<p>Dear [[ user_name ]],</p><p>A user has cancelled their subscription.</p><p>Cancellation Details:</p><ul><li>User: [[ user_name ]]</li><li>Cancellation Date: [[ end_date ]]</li><li>Reason: [[ cancellation_reason ]]</li><li>Previous Plan: [[ subscription_plan ]]</li></ul><p>Please review and consider reaching out to understand their feedback.</p>','A User is cancle subscribe!','Subscription Cancelled - Review Required','User [[ user_name ]] cancelled subscription','User [[ user_name ]] has cancelled their subscription.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(72,26,'en','demo_admin','<p>Dear [[ user_name ]],</p><p>A user has cancelled their subscription.</p><p>Cancellation Details:</p><ul><li>User: [[ user_name ]]</li><li>Cancellation Date: [[ end_date ]]</li><li>Reason: [[ cancellation_reason ]]</li><li>Previous Plan: [[ subscription_plan ]]</li></ul><p>Please review and consider reaching out to understand their feedback.</p>','A User is cancle subscribe!','Subscription Cancelled - Review Required','User [[ user_name ]] cancelled subscription','User [[ user_name ]] has cancelled their subscription.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(73,27,'en','user','\n                <p>Dear [[ user_name ]],</p>\n                <p>Thank you for purchasing the [[ content_type ]] \"<strong>[[ name ]]</strong>\" on our platform.</p>\n                <p>You now have full access starting from <strong>[[ start_date ]] to [[ end_date ]]</strong>.</p>\n                <p>We hope you enjoy your viewing experience!</p>\n                <p>Best regards,</p>\n            ','You have successfully purchased!','Purchase Confirmed','Purchase confirmed for [[ user_name ]] - [[ content_type ]] \"[[ name ]]\" from [[ start_date ]] to [[ end_date ]]','You have successfully purchased [[ content_type ]] \"[[ name ]]\"','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(74,27,'en','admin','\n                <p>Dear [[ user_name ]],</p>\n                <p>A new video purchase has been made on the platform.</p>\n                <p>Purchase Details:</p>\n                <ul>\n                    <li>User: [[ user_name ]]</li>\n                    <li>Content: [[ content_type ]] \"[[ name ]]\"</li>\n                    <li>Purchase Date: [[ start_date ]]</li>\n                    <li>Access Until: [[ end_date ]]</li>\n                    <li>Transaction Status: Completed</li>\n                </ul>\n                <p>Please review the transaction details.</p>\n            ','You have successfully purchased!','New Purchase - Review Required','User [[ user_name ]] purchased [[ content_type ]] \"[[ name ]]\" on [[ start_date ]] - Access until [[ end_date ]]','User [[ user_name ]] has purchased [[ content_type ]] \"[[ name ]]\".','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(75,27,'en','demo_admin','\n                <p>Dear [[ user_name ]],</p>\n                <p>A new video purchase has been made on the platform.</p>\n                <p>Purchase Details:</p>\n                <ul>\n                    <li>User: [[ user_name ]]</li>\n                    <li>Content: [[ content_type ]] \"[[ name ]]\"</li>\n                    <li>Purchase Date: [[ start_date ]]</li>\n                    <li>Access Until: [[ end_date ]]</li>\n                    <li>Transaction Status: Completed</li>\n                </ul>\n                <p>Please review the transaction details.</p>\n            ','You have successfully purchased!','New Purchase - Review Required','User [[ user_name ]] purchased [[ content_type ]] \"[[ name ]]\" on [[ start_date ]] - Access until [[ end_date ]]','User [[ user_name ]] has purchased [[ content_type ]] \"[[ name ]]\".','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(76,28,'en','user','\n                <p>Dear [[ user_name ]],</p>\n                <p>Thank you for renting the [[ content_type ]] \"<strong>[[ name ]]</strong>\" from our platform.</p>\n                <p>Your rental starts on <strong>[[ start_date ]]</strong> and will be available until <strong>[[ end_date ]]</strong>.</p>\n                <p>Be sure to complete watching it before your rental expires!</p>\n\n            ','You have successfully rent!','Rental Confirmed','Rental confirmed for [[ user_name ]] - [[ content_type ]] \"[[ name ]]\" from [[ start_date ]] to [[ end_date ]]','You have successfully rent [[ content_type ]] \"[[ name ]]\"','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(77,28,'en','admin','\n                <p>Dear [[ user_name ]],</p>\n                <p>A new video rental has been made on the platform.</p>\n                <p>Rental Details:</p>\n                <ul>\n                    <li>User: [[ user_name ]]</li>\n                    <li>Content: [[ content_type ]] \"[[ name ]]\"</li>\n                    <li>Rental Start: [[ start_date ]]</li>\n                    <li>Rental End: [[ end_date ]]</li>\n                    <li>Rental Status: Active</li>\n                </ul>\n                <p>Please review the rental transaction details.</p>\n            ','You have successfully rent!','New Rental - Review Required','User [[ user_name ]] rented [[ content_type ]] \"[[ name ]]\" on [[ start_date ]] - Rental until [[ end_date ]]','User [[ user_name ]] has rented [[ content_type ]] \"[[ name ]]\".','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(78,28,'en','demo_admin','\n                <p>Dear [[ user_name ]],</p>\n                <p>A new video rental has been made on the platform.</p>\n                <p>Rental Details:</p>\n                <ul>\n                    <li>User: [[ user_name ]]</li>\n                    <li>Content: [[ content_type ]] \"[[ name ]]\"</li>\n                    <li>Rental Start: [[ start_date ]]</li>\n                    <li>Rental End: [[ end_date ]]</li>\n                    <li>Rental Status: Active</li>\n                </ul>\n                <p>Please review the rental transaction details.</p>\n            ','You have successfully rent!','New Rental - Review Required','User [[ user_name ]] rented [[ content_type ]] \"[[ name ]]\" on [[ start_date ]] - Rental until [[ end_date ]]','User [[ user_name ]] has rented [[ content_type ]] \"[[ name ]]\".','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(79,29,'en','user','\n                <p>Hi [[ user_name ]],</p>\n                <p>This is a reminder that your rental access to the [[ content_type ]] \"<strong>[[ name ]]</strong>\" will expire in <strong>[[ end_date ]]</strong>.</p>\n                <p>If you haven\'t finished watching it yet, please make sure to complete it before your rental period ends.</p>\n                <p>Enjoy your content,<br>\n            ','Rent Is Expire Soon!','Rental Expiry Reminder','Rental expiry reminder for [[ user_name ]] - [[ content_type ]] \"[[ name ]]\" expires on [[ end_date ]]','Reminder: Your access to [[ content_type ]] \"[[ name ]]\" will expire in [[ end_date ]].','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(80,29,'en','admin','\n                <p>Dear [[ user_name ]],</p>\n                <p>A rental expiry reminder has been sent to a user.</p>\n                <p>Rental Details:</p>\n                <ul>\n                    <li>User: [[ user_name ]]</li>\n                    <li>Content: [[ content_type ]] \"[[ name ]]\"</li>\n                    <li>Expiry Date: [[ end_date ]]</li>\n                    <li>Reminder Status: Sent</li>\n                </ul>\n                <p>Please monitor the rental status and ensure proper expiry handling.</p>\n            ','Rent Is Expire Soon!','Rental Expiry Notification Sent','Rental expiry reminder sent to [[ user_name ]] for [[ content_type ]] \"[[ name ]]\" - Expires on [[ end_date ]]','Rental expiry reminder sent to user [[ user_name ]] for [[ content_type ]] \"[[ name ]]\".','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(81,29,'en','demo_admin','\n                <p>Dear [[ user_name ]],</p>\n                <p>A rental expiry reminder has been sent to a user.</p>\n                <p>Rental Details:</p>\n                <ul>\n                    <li>User: [[ user_name ]]</li>\n                    <li>Content: [[ content_type ]] \"[[ name ]]\"</li>\n                    <li>Expiry Date: [[ end_date ]]</li>\n                    <li>Reminder Status: Sent</li>\n                </ul>\n                <p>Please monitor the rental status and ensure proper expiry handling.</p>\n            ','Rent Is Expire Soon!','Rental Expiry Notification Sent','Rental expiry reminder sent to [[ user_name ]] for [[ content_type ]] \"[[ name ]]\" - Expires on [[ end_date ]]','Rental expiry reminder sent to user [[ user_name ]] for [[ content_type ]] \"[[ name ]]\".','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(82,30,'en','user','\n                <p>Hello [[ user_name ]],</p>\n                <p>This is a reminder that your access to the purchased [[ type ]] \"<strong>[[ name ]]</strong>\" will expire in <strong>[[ end_date ]]</strong>.</p>\n                <p>Please ensure you complete watching it before your access period ends.</p>\n            ','Purchase Is Expire Soon!','Purchase Expiry Reminder','Purchase expiry reminder for [[ user_name ]] - [[ type ]] \"[[ name ]]\" expires on [[ end_date ]]','Reminder: Your access to purchased [[ type ]] \"[[ name ]]\" will expire in [[ end_date ]].','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(83,30,'en','admin','\n                <p>Dear [[ user_name ]],</p>\n                <p>A purchase expiry reminder has been sent to a user.</p>\n                <p>Purchase Details:</p>\n                <ul>\n                    <li>User: [[ user_name ]]</li>\n                    <li>Content: [[ type ]] \"[[ name ]]\"</li>\n                    <li>Expiry Date: [[ end_date ]]</li>\n                    <li>Reminder Status: Sent</li>\n                    <li>Access Type: Purchased</li>\n                </ul>\n                <p>Please monitor the access status and ensure proper expiry handling.</p>\n            ','Purchase Is Expire Soon!','Purchase Expiry Notification Sent','Purchase expiry reminder sent to [[ user_name ]] for [[ type ]] \"[[ name ]]\" - Expires on [[ end_date ]]','Purchase expiry reminder sent to user [[ user_name ]] for [[ type ]] \"[[ name ]]\".','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(84,30,'en','demo_admin','\n                <p>Dear [[ user_name ]],</p>\n                <p>A purchase expiry reminder has been sent to a user.</p>\n                <p>Purchase Details:</p>\n                <ul>\n                    <li>User: [[ user_name ]]</li>\n                    <li>Content: [[ type ]] \"[[ name ]]\"</li>\n                    <li>Expiry Date: [[ end_date ]]</li>\n                    <li>Reminder Status: Sent</li>\n                    <li>Access Type: Purchased</li>\n                </ul>\n                <p>Please monitor the access status and ensure proper expiry handling.</p>\n            ','Purchase Is Expire Soon!','Purchase Expiry Notification Sent','Purchase expiry reminder sent to [[ user_name ]] for [[ type ]] \"[[ name ]]\" - Expires on [[ end_date ]]','Purchase expiry reminder sent to user [[ user_name ]] for [[ type ]] \"[[ name ]]\".','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(85,31,'en','user','<p>Dear [[ user_name ]],</p><p>Exciting news! A new video \"<strong>[[ video_name ]]</strong>\" is now available for streaming.</p><p>Get ready for hours of entertainment!</p>','Video Added!','New Video Available','New video \"[[ video_name ]]\" available - Get ready for hours of entertainment!','New video \"[[ video_name ]]\" is now available for streaming!','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(86,31,'en','admin','<p>Dear [[ user_name ]],</p><p>The season \"<strong>[[ season_name ]]</strong>\" has been successfully added to the content management system.</p><p>Season Details:</p><ul><li>Season Name: [[ name ]]</li><li>Added By: [[ logged_in_user_fullname ]]</li><li>Status: Active</li><li>Available for streaming</li></ul><p>Please review the season details and episode structure.</p>','Video Added!','Content Added - Review Required','Video \"[[ video_name ]]\" added by [[ logged_in_user_fullname ]] - Content management update.','Video \"[[ video_name ]]\" has been successfully added to the system.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(87,31,'en','demo_admin','<p>Dear [[ user_name ]],</p><p>The video \"<strong>[[ name ]]</strong>\" has been successfully added to the content management system.</p><p>Video Details:</p><ul><li>Video Name: [[ name ]]</li><li>Added By: [[ logged_in_user_fullname ]]</li><li>Status: Active</li><li>Available for streaming</li></ul><p>Please review the video details and episode structure.</p>','Video Added!','Content Added - Review Required','Video \"[[ name ]]\" added by [[ logged_in_user_fullname ]] - Content management update.','Video \"[[ name ]]\" has been successfully added to the system.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(88,32,'en','user','\n                <p>Hello [[ user_name ]],</p>\n                <p>Your subscription plan \"<strong>[[ subscription_plan ]]</strong>\" is expiring soon. Please renew your subscription plan within the next few days to continue enjoying our services.</p>\n                <p><strong>Subscription Details:</strong></p>\n                <ul>\n                    <li>Plan: [[ subscription_plan ]]</li>\n                    <li>Expiry Date: [[ end_date ]]</li>\n                    <li>Amount: [[ amount_formatted ]]</li>\n                </ul>\n                <p>Don\'t miss out on your favorite content! Renew now to continue streaming.</p>\n                <p>Thank you for being a valued member!</p>\n            ','Subscription Expiring Soon!','Subscription Expiry Reminder','Your subscription \"[[ subscription_plan ]]\" expires on [[ end_date ]]. Renew now to continue enjoying our services.','Your subscription plan \"[[ subscription_plan ]]\" is expiring soon. Please renew to continue enjoying our services.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(89,33,'en','user','\n                <p>Hello [[ user_name ]],</p>\n                <p>This is a reminder that your subscription plan \"<strong>[[ subscription_plan ]]</strong>\" will expire in <strong>[[ days ]]</strong> day(s).</p>\n                <p><strong>Subscription Details:</strong></p>\n                <ul>\n                    <li>Plan: [[ subscription_plan ]]</li>\n                    <li>Expiry Date: [[ end_date ]]</li>\n                    <li>Days Remaining: [[ days ]]</li>\n                    <li>Amount: [[ amount_formatted ]]</li>\n                </ul>\n                <p>Don\'t miss out on your favorite content! Renew now to continue streaming without interruption.</p>\n                <p>Thank you for being a valued member!</p>\n            ','Subscription Plan Expiring Soon!','Subscription Plan Expiry Reminder','Your subscription plan \"[[ subscription_plan ]]\" will expire in [[ days ]] day(s). Expiry date: [[ end_date ]].','Your subscription plan \"[[ subscription_plan ]]\" will expire in [[ days ]] day(s). Please renew to continue enjoying our services.','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(90,34,'en','user','\n                <p>Hello [[ user_name ]],</p>\n                <p>Great news! \"<strong>[[ name ]]</strong>\" is releasing in <strong>[[ days ]]</strong> day(s).</p>\n                <p><strong>Content Details:</strong></p>\n                <ul>\n                    <li>Title: [[ name ]]</li>\n                    <li>Type: [[ content_type ]]</li>\n                    <li>Release Date: [[ release_date ]]</li>\n                    <li>Days Until Release: [[ days ]]</li>\n                </ul>\n                <p>Don\'t miss out on this exciting new content! Set a reminder and be the first to watch.</p>\n                <p>We can\'t wait for you to enjoy it!</p>\n            ','Upcoming Release: [[ name ]]','Upcoming Content Release','Upcoming release: \"[[ name ]]\" will be available in [[ days ]] day(s) on [[ release_date ]].','Great news! \"[[ name ]]\" is releasing in [[ days ]] day(s). Don\'t miss it!','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(91,34,'en','admin','<p>Dear [[ user_name ]],</p><p>This is a notification about an upcoming content release.</p><ul><li>Title: <strong>[[ name ]]</strong></li><li>Type: [[ content_type ]]</li><li>Release Date: [[ release_date ]]</li><li>Days Remaining: [[ days ]]</li></ul><p>Please ensure all metadata and assets are ready.</p>','Upcoming Release Detected','Upcoming Content Alert','Upcoming content \"[[ name ]]\" (Type: [[ content_type ]]) releasing on [[ release_date ]].','Upcoming release: \"[[ name ]]\" will be launching in [[ days ]] day(s).','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(92,34,'en','demo_admin','<p>Dear [[ user_name ]],</p><p>This is a notification about an upcoming content release.</p><ul><li>Title: <strong>[[ name ]]</strong></li><li>Type: [[ content_type ]]</li><li>Release Date: [[ release_date ]]</li><li>Days Remaining: [[ days ]]</li></ul><p>Please ensure all metadata and assets are ready.</p>','Upcoming Release Detected','Upcoming Content Alert','Upcoming content \"[[ name ]]\" (Type: [[ content_type ]]) releasing on [[ release_date ]].','Upcoming release: \"[[ name ]]\" will be launching in [[ days ]] day(s).','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(93,35,'en','user','\n                <p>Hello [[ user_name ]],</p>\n                <p>You haven\'t watched \"<strong>[[ name ]]</strong>\" in a while. Pick up where you left off!</p>\n                <p><strong>Content Details:</strong></p>\n                <ul>\n                    <li>Title: [[ name ]]</li>\n                    <li>Type: [[ content_type ]]</li>\n                    <li>Release Date: [[ release_date ]]</li>\n                </ul>\n                <p>Continue your viewing experience and enjoy the rest of the content!</p>\n                <p>Happy streaming!</p>\n            ','Continue Watching: [[ name ]]','Continue Watching Reminder','Continue watching \"[[ name ]]\". You haven\'t watched this in a while - pick up where you left off!','Continue watching \"[[ name ]]\". Pick up where you left off!','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(94,35,'en','admin','<p>Dear [[ user_name ]],</p><p>A continue watching reminder for \"<strong>[[ name ]]</strong>\" has been processed.</p><p>Content Details:</p><ul><li>Title: [[ name ]]</li><li>Type: [[ content_type ]]</li></ul>','Continue Watch Reminder Sent','Continue Watch - User Notification','Continue watch reminder for \"[[ name ]]\".','User reminder: Continue watching \"[[ name ]]\".','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(95,35,'en','demo_admin','<p>Dear [[ user_name ]],</p><p>A continue watching reminder for \"<strong>[[ name ]]</strong>\" has been processed.</p><p>Content Details:</p><ul><li>Title: [[ name ]]</li><li>Type: [[ content_type ]]</li></ul>','Continue Watch Reminder Sent','Continue Watch - User Notification','Continue watch reminder for \"[[ name ]]\".','User reminder: Continue watching \"[[ name ]]\".','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(96,36,'en','user','\n                <p>Hello [[ user_name ]],</p>\n                <p>We have sent a one-time password (OTP) to your registered email. Use the code below to verify your request. Do not share this code with anyone.</p>\n                <p><strong>One-Time Password (OTP)</strong></p>\n                <p style=\"font-size: 24px; font-weight: bold; letter-spacing: 4px; text-align: center; padding: 20px; background-color: #f5f5f5; border-radius: 5px;\">[[ otp ]]</p>\n                <p>This OTP is valid for a limited time. If you did not request this OTP, please ignore this email.</p>\n            ','OTP Verification','OTP Verification','Your OTP for parental control PIN change is [[ otp ]].','Your OTP for parental control PIN change is [[ otp ]].','',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL);
/*!40000 ALTER TABLE `notification_template_content_mapping` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `notification_templates`
--

DROP TABLE IF EXISTS `notification_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_templates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) DEFAULT NULL,
  `label` varchar(191) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `to` longtext DEFAULT NULL,
  `bcc` longtext DEFAULT NULL,
  `cc` longtext DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `channels` varchar(191) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_templates`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `notification_templates` WRITE;
/*!40000 ALTER TABLE `notification_templates` DISABLE KEYS */;
INSERT INTO `notification_templates` VALUES
(19,'change_password','Change Password',NULL,'change_password','[\"user\",\"admin\",\"demo_admin\"]',NULL,NULL,1,'{\"IS_MAIL\":\"0\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(20,'forget_email_password','Forget Email/Password',NULL,'forget_email_password','[\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"0\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(21,'tv_show_add','TV Show Added',NULL,'tv_show_add','[\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"0\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(22,'movie_add','Movie Added',NULL,'movie_add','[\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"0\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,15,NULL,'2026-02-18 08:17:59','2026-03-01 02:35:34',NULL),
(23,'episode_add','Episode Added',NULL,'episode_add','[\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"0\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(24,'season_add','Season Added',NULL,'season_add','[\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"0\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(25,'new_subscription','New User Subscribed',NULL,'new_subscription','[\"admin\",\"demo_admin\",\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"1\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(26,'cancle_subscription','User Cancel Subscription',NULL,'cancle_subscription','[\"admin\",\"demo_admin\",\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"0\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(27,'purchase_video','One Time Purchase Content',NULL,'purchase_video','[\"admin\",\"demo_admin\",\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"1\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(28,'rent_video','Rental Content',NULL,'rent_video','[\"admin\",\"demo_admin\",\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"1\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(29,'rent_expiry_reminder','Rental Is Expire Soon',NULL,'rent_expiry_reminder','[\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"1\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(30,'purchase_expiry_reminder','One Time Purchase Is Expired Soon',NULL,'purchase_expiry_reminder','[\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"1\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(31,'Video Added','Video Added',NULL,'video_add','[\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"0\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(32,'subscription_expiry_reminder','Subscription Expiry Reminder',NULL,'subscription_expiry_reminder','[\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"1\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(33,'expiry_plan','Expiry Plan',NULL,'expiry_plan','[\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"1\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(34,'upcoming','Upcoming',NULL,'upcoming','[\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"1\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(35,'continue_watch','Continue Watch',NULL,'continue_watch','[\"user\",\"admin\",\"demo_admin\"]',NULL,NULL,1,'{\"IS_MAIL\":\"1\",\"PUSH_NOTIFICATION\":\"1\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(36,'parental_control_otp','Parental Control OTP',NULL,'parental_control_otp','[\"user\"]',NULL,NULL,1,'{\"IS_MAIL\":\"1\",\"PUSH_NOTIFICATION\":\"0\",\"IS_CUSTOM_WEBHOOK\":\"0\"}',NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL);
/*!40000 ALTER TABLE `notification_templates` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(191) NOT NULL,
  `notifiable_type` varchar(191) NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` longtext NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES
('02a605e9-478a-4ea9-9076-6dbadea87250','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',8,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":8,\"user_name\":\"Joy Hanry\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('1476f83e-d278-41c2-b877-ed3df190f42d','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',4,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":4,\"user_name\":\"Tristan Erickson\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('14c807a1-3d6a-4419-8bac-590b80ab52b5','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',28,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":28,\"user_name\":\"Itopa Ijiji\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('2a9fde7d-2fdd-408c-97a4-8dfe7f891ba4','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',21,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":21,\"user_name\":\"Mohammad Mohsin\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('2ba6eafa-b771-4c93-b973-687d97f5b7ac','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',12,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":12,\"user_name\":\"Lisa Lucas\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('2f2cbf6b-26f3-4387-8cb4-1edf8eee782d','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',23,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":23,\"user_name\":\"Jude Opebiyi\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('385d738e-6efc-401f-9ec4-8709bf367889','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',7,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":7,\"user_name\":\"Jorge Perez\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('540d369f-0e9e-4163-b020-3aad4c3e6dd9','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',24,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":24,\"user_name\":\"Rajesh Vishwakarma\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('595dec8d-40ad-407d-bcc4-16c1b0dacc78','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',3,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":3,\"user_name\":\"John Doe\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('5bcb844f-5204-42f8-8874-a8bc3cc28b70','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',13,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":13,\"user_name\":\"Tracy Jones\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('6bd3aeb6-1781-4cbd-9031-9e0f7f33890c','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',17,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":17,\"user_name\":\"Ravi Kapoor\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('8c0d1e6c-bfd5-4a6e-a914-a484f2ce7bb2','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',9,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":9,\"user_name\":\"Deborah Thomas\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('8ea024b0-1357-4b0d-a091-39b001ad0e35','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',10,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":10,\"user_name\":\"Katie Brown\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('9cb86136-34a9-4f32-9b97-c96d81dcc0af','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',26,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":26,\"user_name\":\"Sara Fatima\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('a0539e41-9817-4043-9be7-0fe05fc85b34','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',14,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":14,\"user_name\":\"Stella Green\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('a9c5d4f5-740f-41b0-991a-ea615e35701e','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',27,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":27,\"user_name\":\"Sara Fatima\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('ad2f1adb-044a-436f-a6f5-fd0de264b5aa','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',25,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":25,\"user_name\":\"Ali Khan\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('cbc2834f-c3ff-47fd-8ded-7668a1c209bc','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',16,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":16,\"user_name\":\"Mohammad Ahsan Ahsan Ali\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('cd9814b3-6feb-4c04-bcd9-1f336e607c3d','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',30,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":30,\"user_name\":\"John Apple\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('d11dd4b0-df09-4f20-8564-c8c407fe1bad','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',11,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":11,\"user_name\":\"Dorothy Erickson\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('e65f34cb-d657-4eef-a124-24d256ba50be','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',22,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":22,\"user_name\":\"Shinu Kp\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('eb377b08-481c-4d4a-89ca-17a2a10b9d36','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',6,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":6,\"user_name\":\"Harry Victoria\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('fd62cebb-55da-41f3-b1ca-c31b12d5ed12','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',5,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":5,\"user_name\":\"Felix Harris\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50'),
('fe90f43a-6dde-4e61-a602-d948e2a7b40a','Modules\\NotificationTemplate\\Notifications\\CommonNotification','App\\Models\\User',29,'{\"subject\":\"New Video Available\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\",\"data\":{\"notification_type\":\"video_add\",\"id\":37,\"video_name\":\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\",\"release_date\":\"2026-06-07T00:00:00.000000Z\",\"type\":\"New Video Available\",\"logged_in_user_fullname\":\"Admin User\",\"logged_in_user_role\":\"admin\",\"company_name\":\"ApexPrime TV\",\"company_contact_info\":\"+15265897485\",\"user_id\":29,\"user_name\":\"Test User\",\"movie_name\":\"\",\"tvshow_name\":\"\",\"season_name\":\"\",\"episode_name\":\"\",\"end_date\":null,\"content_type\":\"\",\"start_date\":null,\"app_name\":\"Apex Prime TV\",\"user_type\":\"user\",\"message\":\"New video \\\"\\u091a\\u0902\\u0926\\u093e \\u092e\\u093e\\u092e\\u093e \\u0906\\u0935\\u093e (\\u0932\\u094b\\u0930\\u0940 ) Singer-\\u202a@panchamigoswami\\u202c \\u202a@kumarsangeet\\u202c\\\" available - Get ready for hours of entertainment!\"}}',NULL,'2026-06-07 09:43:50','2026-06-07 09:43:50');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `onboardings`
--

DROP TABLE IF EXISTS `onboardings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `onboardings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` text DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `file_url` text DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `onboardings`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `onboardings` WRITE;
/*!40000 ALTER TABLE `onboardings` DISABLE KEYS */;
INSERT INTO `onboardings` VALUES
(1,'Watch on any device: Enjoy our content wherever you go!','Stream across all devices without extra charges.','walk_image1.png',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(2,'Download and Go: Access Your Content Anywhere, Anytime, on Any Device','Download & enjoy content on the go, anywhere, anytime.','walk_image2.png',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL),
(3,'Enjoy Freedom Without Commitments or Hassles - Join Us Today!','Join us hassle-free and no contracts required.','walk_image3.png',1,NULL,NULL,NULL,'2026-02-18 08:17:59','2026-02-18 08:17:59',NULL);
/*!40000 ALTER TABLE `onboardings` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `sequence` int(11) DEFAULT NULL,
  `description` longtext NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES
(1,'Privacy Policy','privacy-policy',NULL,'<p data-pm-slice=\"0 0 []\">Varchaswaa International Pvt Ltd Apex Prime TV (&ldquo;we,&rdquo; &ldquo;our,&rdquo; or &ldquo;us&rdquo;) is committed to protecting your privacy. At Varchaswaa International Pvt Ltd, we are committed to protecting your privacy and ensuring that your personal information is handled securely.</p>\n<p>This Privacy Policy applies to our website, and its associated subdomains (collectively, our &ldquo;Service&rdquo;) alongside our application, Varchaswaa International Pvt Ltd Apex Prime TV. By accessing or using our Service, you signify that you have read, understood, and agree to our collection described in this Privacy Policy and our Terms of Service.</p>\n<p>This Privacy Policy outlines how we collect, use, and safeguard your data when you use Apex Prime TV.</p>\n<p><strong>1. Introduction </strong></p>\n<p>At Varchaswaa International Pvt Ltd, we are dedicated to safeguarding your privacy and ensuring your personal data is handled securely. This Privacy Policy explains how we collect, use, and protect your information when you use our services through the Apex Prime TV platform, including our website and associated applications. By accessing or using our services, you acknowledge that you have read and understood this Privacy Policy and agree to its terms.</p>\n<p><strong>2. Information We Collect </strong></p>\n<p>We may collect several types of information when you use Apex Prime TV, including:</p>\n<p><strong>- Personal Information:</strong> Information you provide, such as your name, email address, payment information (e.g., credit card details), and any other personal information required for account creation and subscription services.</p>\n<p><strong>- Usage Data:</strong> Details about how you interact with the platform, such as your IP address, browser type, device details, pages you visit, and your streaming activity. This data helps us optimize your experience and improve our service.</p>\n<p><strong>- Cookies and Tracking Technologies:</strong> We use cookies and similar technologies to track user preferences, enhance your experience, and analyze traffic. You can manage your cookie settings through your browser.</p>\n<p><strong>3. How We Use Your Information </strong></p>\n<p>We collect and use your information to:</p>\n<p><strong>- Provide Streaming Services:</strong> To deliver content, manage user accounts, and personalize recommendations based on your viewing habits.</p>\n<p><strong>- Process Transactions:</strong> For managing subscriptions, handling payments securely, and maintaining transaction histories.</p>\n<p><strong>- Improve User Experience:</strong> Analyze how users interact with the platform to improve navigation, content suggestions, and overall performance.</p>\n<p><strong>- Communications:</strong> Send important notifications related to service updates, billing, and personalized marketing content based on your preferences (you can opt out of marketing communications).</p>\n<p><strong>- Security:</strong> Use collected information to ensure the security of the platform, prevent fraud, and monitor potential misuse.</p>\n<p><strong>4. Data Sharing and Disclosure </strong></p>\n<p>WWe value your privacy and do not sell, rent, or disclose your personal information to third parties except in the following circumstances:</p>\n<p><strong>- Service Providers:</strong> We may share your data with third-party service providers, such as payment processors or cloud storage providers, solely to help us deliver our services. These providers are bound by strict confidentiality agreements and are only authorized to use your information for the purpose of providing services to us.</p>\n<p><strong>- Legal Requirements:</strong> We will only disclose your personal information if required by law, such as to comply with a legal obligation, or in response to valid legal processes like subpoenas, court orders, or other government demands. This will only occur when we have a legal basis to do so.</p>\n<p>-<strong> Business Transfers (If Applicable):</strong> In the event that Varchaswaa International Pvt Ltd undergoes a business transition such as a merger, acquisition, or sale of all or part of our assets, your information may be transferred as part of the transaction. If such a transfer occurs, we will notify you and ensure that the new entity adheres to this Privacy Policy or offers similar protections.</p>\n<p><strong>5. Your Rights </strong></p>\n<p>You have certain rights regarding your personal information, including:</p>\n<p><strong>- Apex Prime TVAccess and CorrectionApex Prime TV:</strong> You may access, correct, or update your personal data through your account settings.</p>\n<p><strong>- Apex Prime TVDeletionApex Prime TV:</strong> You may request the deletion of your account and associated data by contacting our support team.</p>\n<p><strong>- Apex Prime TVData PortabilityApex Prime TV:</strong> You have the right to request your personal data in a structured, machine-readable format to transfer to another service provider.</p>\n<p><strong>- Apex Prime TVOpting Out of Marketing CommunicationsApex Prime TV:</strong> You can opt out of receiving promotional emails or other communications at any time by adjusting your account settings or contacting us.</p>\n<p><strong>6. Data Security </strong></p>\n<p>We take the protection of your personal data very seriously and prioritize its security using a range of industry-standard security measures. These measures are designed to safeguard your information from unauthorized access, disclosure, or misuse. Our security practices include the use of encryption, secure data storage systems, firewalls, and regular security audits to detect vulnerabilities. In addition to these technical measures, we employ strict internal policies to control access to sensitive data, ensuring that only authorized personnel can handle it.</p>\n<p>Despite our efforts to implement strong security systems, it\'s important to recognize that no method of transmission over the internet or method of electronic storage is completely secure. As such, while we are committed to doing our utmost to protect your personal information, we cannot guarantee absolute security. If you suspect any breach or unauthorized access to your account, please notify us immediately so we can take appropriate action to secure your data.</p>\n<p><strong> 7. Children&rsquo;s Privacy </strong></p>\n<p>The Apex Prime TV platform is designed for use by individuals aged 13 and older. We are committed to protecting the privacy of children and do not knowingly collect personal information from individuals under the age of 13. In compliance with the Children&rsquo;s Online Privacy Protection Act (COPPA) and similar regulations, we take precautions to avoid collecting any data from minors.</p>\n<p>If you are a parent or guardian and become aware that your child has provided us with personal information without your consent, please contact us immediately. Upon receiving such a request, we will promptly review and remove the child\'s information from our system to ensure it is not used or stored. We take the privacy of minors seriously, and we will act quickly to address any concerns.</p>\n<p><strong>8. Changes to This Privacy Policy </strong></p>\n<p>Our privacy practices may evolve over time as we introduce new features, services, or update our operational procedures. To ensure transparency, we reserve the right to make changes to this Privacy Policy from time to time. Such updates may reflect changes in legal requirements, our business practices, or the introduction of new technologies.</p>\n<p>In the event of any significant modifications to the way we collect, use, or store your data, we will provide you with clear notification either via email or by placing a prominent notice on our platform. We encourage you to review this Privacy Policy periodically to stay informed of any updates or changes. Your continued use of our services after changes have been made constitutes your acceptance of the updated policy.</p>\n<p><strong>9. Contact Us </strong></p>\n<p>If you have any questions, concerns, or require further clarification regarding this Privacy Policy, our team is here to help. We value open communication with our users and are committed to addressing any concerns related to your personal data and privacy.</p>\n<p>You can contact us via the following email:</p>\n<p><strong>- Email:</strong> support@apexprimetv.com</p>\n<p>We aim to respond to all queries in a timely manner and ensure that your privacy concerns are addressed effectively.</p>\n<p><strong>10. Data Deletion Request </strong></p>\n<p>We are committed to providing you with control over your personal information and ensuring that your data is handled in accordance with your preferences. If at any time you wish to request the deletion of your personal data from our servers, we offer a straightforward process to facilitate this.</p>\n<p>To request the deletion of your data, please send an email from your registered email address to our dedicated privacy inbox at support@apexprimetv.com. Include the subject line \"Data Deletion Request\" and provide any necessary details regarding your account. Upon receiving your request, our team will thoroughly review the provided information, verify your identity, and proceed with the deletion of your data as required by our privacy policies and applicable legal obligations.</p>\n<p>Please note that certain legal requirements or regulatory obligations may require us to retain certain information for a specified period, even after a deletion request has been made. However, we will ensure that any retained data is handled securely and in compliance with relevant privacy laws.</p>\n<p>&nbsp;</p>\n<p><strong>This privacy policy helps ensure transparency and clarity about how Varchaswaa International Pvt Ltd handles your data within Apex Prime TV. </strong></p>\n<p><strong>Thank you for using Apex Prime TV. Your privacy is important to us, and we are committed to safeguarding your personal information.&nbsp;&nbsp;</strong></p>',1,NULL,1,NULL,'2024-09-28 03:49:15','2026-03-05 11:04:39',NULL),
(2,'Terms & Conditions','terms-conditions',NULL,'<p>Welcome to Apex Prime TV, a premier streaming platform developed by Varchaswaa International Pvt Ltd. By accessing or using our services, you agree to comply with and be bound by these Terms and Conditions. These terms outline your rights and responsibilities when using our platform, and we encourage you to read them carefully. If you do not agree with these terms, please refrain from using the service.</p>\n<p><strong>1. Acceptance of Terms</strong></p>\n<p>By using Apex Prime TV, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions. This agreement serves as a legally binding contract between you and Varchaswaa International Pvt Ltd. If you do not agree to any of these terms, please refrain from using our services. We reserve the right to update these terms at any time, and it is your responsibility to review them periodically for changes.</p>\n<p><strong>2. Eligibility</strong></p>\n<p>To access and use Apex Prime TV, you must be at least 18 years old or the age of majority in your jurisdiction. If you are under 18, you may only use the service under the supervision of a parent or legal guardian who agrees to these Terms and Conditions. By using the service, you represent that you meet these eligibility requirements and that you are legally able to enter into this agreement. We reserve the right to terminate your account if you do not meet these criteria.</p>\n<p><strong>3. User Accounts</strong></p>\n<p>To access certain features of Apex Prime TV, you may be required to create a user account. When creating an account, you agree to provide accurate, complete, and up-to-date information, including your name, email address, and any other required details. You are responsible for maintaining the confidentiality of your account information, including your password. Any activity performed using your account is your responsibility, and you agree to notify us immediately of any unauthorized use of your account or any other breach of security. We are not liable for any loss or damage arising from your failure to comply with these requirements.</p>\n<p><strong>4. Subscription Plans</strong></p>\n<p>Apex Prime TV offers a variety of subscription plans, each with different features and benefits tailored to meet the needs of our diverse user base. By subscribing, you agree to pay the applicable fees associated with your chosen plan, which will be billed in advance on a recurring basis. Subscription fees are non-refundable, except as specified in our refund policy. The specific features of each subscription plan are detailed on our platform. We reserve the right to modify, enhance, or discontinue any plan at our discretion, ensuring that we continuously provide value to our users.</p>\n<p><strong>5. Payment and Billing</strong></p>\n<p>Payments for subscriptions are processed through secure third-party payment gateways, including Stripe, RazorPay, Paystack, PayPal, and FlutterWave. You are responsible for providing accurate and complete payment information. If the payment is not successfully processed due to insufficient funds, expired card information, or any other reason, we reserve the right to suspend or terminate your account. All fees are subject to applicable taxes, and you are responsible for paying any additional charges incurred in your region. By providing payment information, you authorize us to charge the payment method for the subscription fees and any other applicable charges.</p>\n<p><strong>6. Content Access and Usage</strong></p>\n<p>Upon subscribing, you are granted a limited, non-exclusive, non-transferable license to access and view the content available on Apex Prime TV for personal, non-commercial use. This license is intended solely for your enjoyment and personal viewing. You may not reproduce, distribute, modify, publicly display, publicly perform, republish, download, or store any content from the service without obtaining prior written consent from us. All content remains the property of Varchaswaa International Pvt Ltd or its content providers, and unauthorized use of the content may result in legal action.</p>\n<p><strong>7. Intellectual Property</strong></p>\n<p>All content available on Apex Prime TV, including but not limited to movies, TV shows, graphics, logos, software, and any associated trademarks, is protected by copyright, trademark, and other intellectual property laws. You agree not to infringe, violate, or misuse any intellectual property rights belonging to Varchaswaa International Pvt Ltd or third-party content providers. Unauthorized use of the content may lead to civil and criminal penalties. If you wish to use any content for commercial purposes, you must obtain prior written permission from the rightful owner.</p>\n<p><strong>8. Prohibited Activities</strong></p>\n<p>While using Apex Prime TV, you agree not to engage in any unlawful activities or conduct that violates these Terms and Conditions. This includes, but is not limited to:</p>\n<p>- Uploading or distributing malicious software, viruses, or any other harmful code.</p>\n<p>- Interfering with the security of the service or the experience of other users.</p>\n<p>- Attempting to bypass any content protection mechanisms or access restricted areas of the platform.</p>\n<p>- Sharing your login credentials with others or using another user\'s account without permission. Engaging in any of these prohibited activities may result in immediate termination of your account and potential legal action.</p>\n<p><strong>9. Third-Party Links</strong></p>\n<p>Apex Prime TV may contain links to third-party websites or services that are not owned or controlled by Varchaswaa International Pvt Ltd. We have no control over, and assume no responsibility for, the content, privacy policies, or practices of any third-party sites. Your interactions with these third-party services are governed by their own terms and policies. We encourage you to read the terms and conditions of any third-party website you visit. Varchaswaa International Pvt Ltd is not responsible for any damages or losses caused by your use of these third-party services.</p>\n<p><strong>10. Termination of Service</strong></p>\n<p>We reserve the right to suspend or terminate your access to Apex Prime TV at any time, with or without notice, if you breach these Terms and Conditions or engage in conduct that we deem harmful to the platform or other users. In the event of termination, your right to use the service will immediately cease, and you may lose access to any content associated with your account. We will not be liable to you or any third party for any termination of your access to the service. Upon termination, any provisions of these terms that, by their nature, should survive termination shall remain in effect.</p>\n<p><strong>11. Limitation of Liability</strong></p>\n<p>In no event shall Varchaswaa International Pvt Ltd or its affiliates be liable for any indirect, incidental, special, or consequential damages arising from your use or inability to use the Apex Prime TV service. This includes, but is not limited to, damages for loss of profits, data, or other intangible losses, even if we have been advised of the possibility of such damages. Your sole remedy for dissatisfaction with the service is to stop using it. Our liability for any claims arising out of these Terms and Conditions shall not exceed the total amount paid by you for the service during the twelve (12) months preceding the claim.</p>\n<p><strong>12. Disclaimer of Warranties</strong></p>\n<p>The Apex Prime TV service is provided \"as is\" and \"as available.\" Varchaswaa International Pvt Ltd makes no warranties or representations about the accuracy, reliability, or availability of the service. We disclaim all warranties, whether express or implied, including but not limited to implied warranties of merchantability, fitness for a particular purpose, and non-infringement. We do not guarantee that the service will be uninterrupted, secure, or error-free, and we are not responsible for any interruptions or errors in the service. Your use of the service is at your own risk.</p>\n<p><strong>13. Modifications to Terms</strong></p>\n<p>We reserve the right to modify these Terms and Conditions at any time. Any changes will be effective immediately upon posting on our platform. Your continued use of the service after the changes means you accept the new terms. We encourage you to review these Terms regularly to stay informed of any updates. If you do not agree with any changes, you should stop using the service. Continued access to Apex Prime TV after modifications indicates your acceptance of the updated terms.</p>\n<p><strong>14. Governing Law</strong></p>\n<p>These Terms and Conditions shall be governed by and construed in accordance with the laws of the jurisdiction in which Varchaswaa International Pvt Ltd operates. Any legal actions arising from these terms must be filed in the appropriate courts of that jurisdiction. If any provision of these terms is found to be unenforceable, the remaining provisions will remain in full force and effect. By using Apex Prime TV, you consent to the exclusive jurisdiction of the courts located in that jurisdiction.</p>\n<p><strong>15. Contact Us</strong></p>\n<p>If you have any questions, concerns, or comments about these Terms and Conditions, please contact us at:</p>\n<p>- Email: support@apexprimetv.com</p>\n<p><strong>We appreciate your cooperation and understanding of these Terms and Conditions. They are designed to protect both your rights and those of our users, ensuring a secure and enjoyable streaming experience on Apex Prime TV.</strong></p>\n<p>&nbsp;</p>',1,NULL,1,NULL,'2024-09-28 03:49:15','2026-03-05 11:04:39',NULL),
(3,'Help and Support','help-and-support',NULL,'<p>Welcome to Apex Prime TV Help &amp; Support! At Varchaswaa International Pvt Ltd, we strive to offer you the best streaming experience possible. Should you have any questions, concerns, or need assistance with Apex Prime TV, you&rsquo;ve come to the right place. Our dedicated support team is here to help you with technical issues, general queries, and everything in between. We are committed to ensuring a smooth and enjoyable streaming experience.</p>\n<p><strong>Frequently Asked Questions (FAQs)</strong></p>\n<p>Before contacting us, we highly recommend checking our [FAQ Page] for common issues and their solutions. We continuously update this page to address frequently asked user queries, offering you the quickest route to a solution.</p>\n<p><strong>Contact Support</strong></p>\n<p>If you need further assistance, feel free to contact our support team at:</p>\n<p>📧 <strong>Email: support@apexprimetv.com</strong></p>\n<p>We aim to respond to all queries within 24 to 48 hours (Monday through Friday). Our priority is resolving your issue as swiftly as possible.</p>\n<p><strong>How Can We Assist You?</strong></p>\n<p>Our support services include:</p>\n<p><strong>1. Account &amp; Subscription Issues&nbsp;&nbsp;</strong></p>\n<p>&nbsp; &nbsp;- Experiencing issues with your account setup, subscription, or payments? We&rsquo;re available to assist with any difficulties you encounter during the process of managing your account or subscription plan.</p>\n<p><strong>2. App Navigation &amp; Features&nbsp;&nbsp;</strong></p>\n<p>&nbsp; &nbsp;- Whether you\'re a new user or need help with specific features, we can guide you. Apex Prime TV is designed with user-friendly features, and we are here to help you make the most out of them.</p>\n<p><strong>3. Technical Support&nbsp;&nbsp;</strong></p>\n<p>&nbsp; &nbsp;- Facing technical difficulties with the app? Our technical team is prepared to assist with any malfunctions, connectivity problems, or performance issues to ensure that your streaming experience is uninterrupted.</p>\n<p><strong>4. Content Inquiries&nbsp;</strong>&nbsp;</p>\n<p>&nbsp; &nbsp;- Do you have questions about our content? We&rsquo;re happy to clarify any concerns regarding the availability, features, or quality of the content in our library.</p>\n<p><strong>5. Feedback &amp; Suggestions&nbsp;&nbsp;</strong></p>\n<p>&nbsp; &nbsp;- We value your feedback! Your input helps us improve your experience, and we carefully consider all suggestions and reported issues.</p>\n<p><strong>Quick Assistance Steps</strong></p>\n<p><strong>For a faster response, follow these steps:</strong></p>\n<p>1. Check our FAQ page to see if your issue has already been addressed.</p>\n<p>2. Email us at support@apexprimetv.com with your query.</p>\n<p>3. Include the following details for faster resolution:</p>\n<p>- Your device model and operating system (OS) version.</p>\n<p>- A brief description of the issue.</p>\n<p>- Screenshots or steps to replicate the problem (if applicable).</p>\n<p><strong>Help Us Help You</strong></p>\n<p>To help us serve you better, please provide the following information in your support request:</p>\n<p>- Your registered email address associated with Apex Prime TV.</p>\n<p>- A detailed description of the issue you\'re experiencing.</p>\n<p>- Any relevant steps to replicate the problem, including device and app information.</p>\n<p>&nbsp;</p>\n<p><strong>We are committed to ensuring your experience is smooth and enjoyable. Our team works diligently to resolve all queries and technical issues, helping you return to your seamless streaming experience as quickly as possible.</strong></p>\n<p><strong>Thank you for choosing Apex Prime TV! Your satisfaction is our top priority, and we&rsquo;re always here to assist you with any concerns or questions.</strong></p>',1,NULL,1,NULL,'2024-09-28 03:49:15','2026-03-05 11:04:39',NULL),
(4,'Refund and Cancellation Policy','refund-and-cancellation-policy',NULL,'<p>At Varchaswaa International Pvt Ltd, we strive to ensure our customers have a seamless experience with Apex Prime TV. Please read our Refund and Cancellation Policy carefully to understand your rights and obligations.</p>\n<p><strong>1. Subscription Cancellations</strong></p>\n<p>You may cancel your subscription to Apex Prime TV at any time. Upon cancellation:</p>\n<p><strong>- Continued Access:</strong> You will retain access to premium content and services until the end of your current billing cycle. There will be no disruption in service during this period.</p>\n<p><strong>- No Refund for Partial Periods:</strong> We do not provide refunds for unused portions of the subscription period. Your access will remain until the next billing date.</p>\n<p><strong>- How to Cancel:</strong> To cancel your subscription, visit your account settings in the app or contact our support team at support@apexprimetv.com. Ensure that you follow the instructions clearly to avoid any confusion regarding cancellation timing.</p>\n<p><strong>2. Refund Eligibility</strong></p>\n<p><strong>Refunds may be granted under the following circumstances:</strong></p>\n<p><strong>- Accidental Billing:</strong> If you were incorrectly charged due to a technical error or duplicate billing, please contact us immediately to resolve the issue.</p>\n<p><strong>- Unauthorized Transactions:</strong> In the event your account was used without your permission, please notify us within 7 days of the transaction to be eligible for a refund.</p>\n<p><strong>Non-Refundable Cases:</strong></p>\n<p>Refunds will not be provided under the following circumstances:</p>\n<p><strong>- Change of Mind:</strong> If you decide you no longer want the subscription after purchase, we cannot provide a refund.</p>\n<p><strong>- Dissatisfaction with Content:</strong> Refunds will not be given solely based on dissatisfaction with the available content unless the service is defective or significantly misrepresented.</p>\n<p><strong>- Lack of Usage:</strong> If you do not use the service after subscribing, you will not be eligible for a refund.</p>\n<p><strong>3. Refund Process</strong></p>\n<p>If you qualify for a refund, the process will be as follows:</p>\n<p><strong>- Contact Support:</strong> Email us at support@apexprimetv.com with the following details:</p>\n<p>&nbsp; * Your registered email address.</p>\n<p>&nbsp; * Subscription details (Plan name, Payment Date).</p>\n<p>&nbsp; * Reason for the refund request.</p>\n<p><strong>- Verification Process:</strong> We will review your request and confirm your eligibility for a refund. Additional information may be requested to complete this verification.</p>\n<p><strong>- Processing Time:</strong> Once approved, refunds will be processed within 7&ndash;10 business days. The refunded amount will be credited to the original payment method used during the transaction.</p>\n<p><strong>4. Free Trials</strong></p>\n<p>If you sign up for a free trial and choose not to continue with a paid subscription, you must cancel before the trial period ends to avoid being charged. No refunds will be provided if the subscription is not canceled before the trial expiration date. Ensure you monitor your trial period closely to avoid unwanted charges.</p>\n<p><strong>5. Changes to This Policy</strong></p>\n<p>Varchaswaa International Pvt Ltd reserves the right to update or modify this Refund and Cancellation Policy at any time. We will notify users of any significant changes via email or in-app notifications. Continued use of Apex Prime TV after changes are made will signify your acceptance of the revised policy.</p>\n<p><strong>6. Contact Us</strong></p>\n<p>If you have any questions about this policy or need further assistance, please reach out to us at:</p>\n<p><strong>📧 Email: support@apexprimetv.com&nbsp;&nbsp;</strong></p>\n<p><strong>We are always available to assist with any concerns you may have about refunds or cancellations. Your satisfaction is important to us, and we strive to address any issues promptly.</strong></p>\n<p><strong>Thank you for choosing Apex Prime TV and for being a valued customer of Varchaswaa International Pvt Ltd!</strong></p>\n<p>Company:<strong>&nbsp;Varchaswaa International Pvt Ltd&nbsp;&nbsp;</strong></p>\n<p>Product:<strong>&nbsp;Apex Prime TV&nbsp;&nbsp;</strong></p>\n<p>Support Contact:<strong>&nbsp;support@apexprimetv.com</strong></p>',1,NULL,1,NULL,'2024-09-28 03:49:15','2026-03-05 11:04:39',NULL),
(5,'Data Deletion Request','data-deletation-request',NULL,'<p>At Varchaswaa International Pvt Ltd, we value the privacy of our users and are committed to ensuring your personal data is handled securely. If you wish to request the deletion of your data associated with Apex Prime TV, please review the following guidelines.</p>\n<p><strong>1. Right to Data Deletion</strong></p>\n<p>In accordance with global data protection laws, you have the right to request the deletion of your personal data stored within our systems. Once your request is verified, we will remove your data from our servers unless certain legal obligations require us to retain it.</p>\n<p><strong>2. Information We Delete</strong></p>\n<p>When submitting a data deletion request, the following data will be removed:</p>\n<p><strong>* Personal Information:</strong> Name, email address, phone number, and any other personally identifiable information.</p>\n<p><strong>* Account Details:</strong> Subscription history, payment details, and usage data.</p>\n<p><strong>* Watchlists and Preferences:</strong> Any watchlist, preferences, or custom content recommendations.</p>\n<p><strong>**Please note: After the data is deleted, you will no longer have access to your Apex Prime TV account, and the action is irreversible**</strong></p>\n<p><strong>3. How to Submit a Data Deletion Request</strong></p>\n<p>To request the deletion of your data:</p>\n<p><strong>* Email Request:</strong> Send an email to support@apexprimetv.com with the subject line \"Data Deletion Request.\"</p>\n<p><strong>* Required Information:</strong> Include the following details in your email:</p>\n<p>&nbsp; &nbsp;- Your full name.</p>\n<p>&nbsp; &nbsp;- Your registered email address.</p>\n<p>&nbsp; &nbsp;- Reason for your data deletion request (optional).</p>\n<p><strong>* Verification:</strong> We may contact you to verify your identity before proceeding with the deletion.</p>\n<p><strong>4. Processing Time</strong></p>\n<p>Upon receiving and verifying your request, we will process the deletion within 30 days. You will be notified once your data has been successfully deleted.</p>\n<p><strong>5. Exceptions to Data Deletion</strong></p>\n<p>Certain data may not be eligible for deletion if:</p>\n<p>- Legal Obligations: We are required to retain your data for legal, regulatory, or contractual reasons.</p>\n<p>- Ongoing Transactions: If there are any unresolved issues such as pending transactions, your data may be retained until those issues are resolved.</p>\n<p><strong>6. Impact of Data Deletion</strong></p>\n<p>Once your data is deleted:</p>\n<p>- You will lose access to your Apex Prime TV account.</p>\n<p>- Any remaining subscription time will be forfeited, and no refunds will be issued.</p>\n<p>- You will need to create a new account if you wish to use our services again in the future.</p>\n<p><strong>7. Contact Us</strong></p>\n<p>If you have any questions about this policy or need assistance with your data deletion request, please reach out to us at:</p>\n<p>📧 Email: support@apexprimetv.com&nbsp;&nbsp;</p>\n<p>&nbsp;</p>\n<p><strong>Our team is here to help you with any concerns related to your personal data and privacy.</strong></p>\n<p><strong>Thank you for using Apex Prime TV, and for trusting Varchaswaa International Pvt Ltd with your privacy.</strong></p>',1,NULL,1,NULL,'2024-09-28 03:49:15','2026-03-05 11:04:39',NULL),
(6,'About Us','about-us',NULL,'<p><strong>About Apex Prime TV by Varchaswaa International Pvt Ltd</strong></p>\n<p>Welcome to Apex Prime TV, a next-generation streaming platform proudly developed by Varchaswaa International Pvt Ltd. We specialize in creating cutting-edge digital solutions, and Apex Prime TV is our latest breakthrough in the world of online entertainment. Whether you\'re a movie lover, a TV show binge-watcher, or enjoy live events, our platform is designed to deliver high-quality content directly to your device, ensuring a seamless, uninterrupted experience. Apex Prime TV combines advanced technology with a user-friendly interface to cater to audiences worldwide.</p>\n<p><strong>Our Mission</strong></p>\n<p>Our mission at Varchaswaa International Pvt Ltd is to reshape how digital content is consumed by creating a streaming platform that prioritizes speed, reliability, and personalization. Apex Prime TV is built using the latest technologies to provide users with superior streaming quality, customized recommendations, and an easy-to-use content management system. We are committed to making entertainment accessible and enjoyable for all audiences, whether you\'re at home or on the go.</p>\n<p><strong>Why Choose Apex Prime TV?</strong></p>\n<p>- Top-Tier Streaming Experience: Dive into high-definition and 4K content with smooth playback, ensuring no buffering even during high-traffic periods.</p>\n<p>- Personalized Content Recommendations: Our AI-driven recommendation system curates content based on your viewing history, making it easy to discover your next favorite show or movie.</p>\n<p>- Multi-Device Compatibility: Enjoy Apex Prime TV on your mobile, tablet, smart TV, or desktop, with seamless syncing across all devices.</p>\n<p>- Exclusive Content &amp; Features: Gain access to exclusive shows, movies, and live events that are unavailable on other platforms, along with features like offline downloads and customizable viewing settings.</p>\n<p>- Scalable &amp; Customizable for Developers: Apex Prime TV offers a flexible architecture that developers can tailor to specific needs, with options for scalability and integrations with other platforms.</p>\n<p>- Comprehensive Content Management: Our platform is designed for content creators and streamers, allowing them to efficiently manage their movies, TV shows, episodes, and live TV in one easy-to-use dashboard.</p>\n<p>- Enhanced Security &amp; Privacy: We employ cutting-edge encryption and security protocols to safeguard your data and protect against unauthorized access or breaches.</p>\n<p><strong>Our Vision&nbsp;&nbsp;</strong></p>\n<p>We envision a world where entertainment is no longer bound by geographical or technological limitations. With Apex Prime TV, we aim to revolutionize digital content consumption, offering users the flexibility to watch anything, anywhere, at any time. Our vision extends beyond just entertainment&mdash;we seek to empower creators by providing a dynamic platform where they can showcase their content to a global audience while maintaining full control over their media. As technology evolves, so does Apex Prime TV, constantly improving to meet the demands of today&rsquo;s and tomorrow&rsquo;s viewers.</p>\n<p><strong>What Sets Us Apart?</strong></p>\n<p><strong>- Adaptive Streaming Technology:</strong> Our adaptive bitrate streaming automatically adjusts video quality based on your internet connection, ensuring uninterrupted playback at the highest quality your network supports.</p>\n<p><strong>- Collaborative Content Creation:</strong> Apex Prime TV allows content creators to collaborate, share, and co-produce projects, fostering a community of innovation and creativity.</p>\n<p><strong>- Immersive Viewing Experience:</strong> Our platform offers advanced features like multi-language subtitles, customizable captions, and interactive content for an enhanced viewing experience.</p>\n<p><strong>- Diverse Genre Library:</strong> Explore a wide range of genres, from action and thrillers to romance, horror, and documentaries. Whatever your preference, there&rsquo;s something for everyone on Apex Prime TV.</p>\n<p><strong>- Real-Time Notifications &amp; Updates:</strong> Stay updated with new releases, exclusive content, and upcoming live events with personalized notifications based on your preferences.</p>\n<p><strong>Connect with Us&nbsp;&nbsp;</strong></p>\n<p>We value our community and encourage feedback to help us improve. If you have any questions, suggestions, or require assistance, our support team is ready to help:</p>\n<p><strong>📧 Support Email: support@apexprimetv.com</strong></p>\n<p>Join us in our journey to transform the entertainment landscape with Apex Prime TV&mdash;where technology and creativity come together to offer the ultimate streaming experience.</p>\n<p>Company:&nbsp;<strong>Varchaswaa International Pvt Ltd&nbsp;&nbsp;</strong></p>\n<p>Product:&nbsp;<strong>Apex Prime TV&nbsp;&nbsp;</strong></p>\n<p>Support Contact:&nbsp;<strong>support@apexprimetv.com</strong></p>',1,NULL,1,NULL,'2024-09-28 03:49:15','2026-03-05 11:04:39',NULL);
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `pay_per_views`
--

DROP TABLE IF EXISTS `pay_per_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pay_per_views` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `movie_id` bigint(20) unsigned NOT NULL,
  `type` varchar(191) NOT NULL,
  `content_price` decimal(10,2) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `discount_percentage` decimal(5,2) DEFAULT NULL,
  `first_play_date` datetime DEFAULT NULL,
  `view_expiry_date` timestamp NULL DEFAULT NULL,
  `access_duration` int(11) DEFAULT NULL,
  `available_for` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pay_per_views_user_id_foreign` (`user_id`),
  KEY `pay_per_views_movie_id_foreign` (`movie_id`),
  CONSTRAINT `pay_per_views_movie_id_foreign` FOREIGN KEY (`movie_id`) REFERENCES `entertainments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pay_per_views_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_per_views`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `pay_per_views` WRITE;
/*!40000 ALTER TABLE `pay_per_views` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_per_views` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `payperviewstransactions`
--

DROP TABLE IF EXISTS `payperviewstransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payperviewstransactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_type` varchar(191) NOT NULL,
  `payment_status` varchar(191) DEFAULT NULL,
  `transaction_id` varchar(191) DEFAULT NULL,
  `pay_per_view_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payperviewstransactions_user_id_foreign` (`user_id`),
  KEY `payperviewstransactions_pay_per_view_id_foreign` (`pay_per_view_id`),
  CONSTRAINT `payperviewstransactions_pay_per_view_id_foreign` FOREIGN KEY (`pay_per_view_id`) REFERENCES `pay_per_views` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payperviewstransactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payperviewstransactions`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `payperviewstransactions` WRITE;
/*!40000 ALTER TABLE `payperviewstransactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `payperviewstransactions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(125) NOT NULL,
  `guard_name` varchar(125) NOT NULL,
  `is_fixed` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES
(1,'edit_settings','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(2,'view_logs','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(3,'view_genres','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(4,'add_genres','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(5,'edit_genres','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(6,'delete_genres','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(7,'restore_genres','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(8,'force_delete_genres','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(9,'view_movies','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(10,'add_movies','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(11,'edit_movies','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(12,'delete_movies','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(13,'restore_movies','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(14,'force_delete_movies','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(15,'view_tvshows','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(16,'add_tvshows','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(17,'edit_tvshows','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(18,'delete_tvshows','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(19,'restore_tvshows','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(20,'force_delete_tvshows','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(21,'view_seasons','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(22,'add_seasons','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(23,'edit_seasons','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(24,'delete_seasons','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(25,'restore_seasons','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(26,'force_delete_seasons','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(27,'view_episodes','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(28,'add_episodes','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(29,'edit_episodes','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(30,'delete_episodes','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(31,'restore_episodes','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(32,'force_delete_episodes','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(33,'view_videos','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(34,'add_videos','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(35,'edit_videos','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(36,'delete_videos','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(37,'restore_videos','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(38,'force_delete_videos','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(39,'view_tvcategory','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(40,'add_tvcategory','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(41,'edit_tvcategory','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(42,'delete_tvcategory','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(43,'restore_tvcategory','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(44,'force_delete_tvcategory','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(45,'view_tvchannel','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(46,'add_tvchannel','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(47,'edit_tvchannel','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(48,'delete_tvchannel','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(49,'restore_tvchannel','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(50,'force_delete_tvchannel','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(51,'view_actor','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(52,'add_actor','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(53,'edit_actor','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(54,'delete_actor','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(55,'restore_actor','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(56,'force_delete_actor','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(57,'view_director','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(58,'add_director','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(59,'edit_director','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(60,'delete_director','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(61,'restore_director','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(62,'force_delete_director','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(63,'view_plans','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(64,'add_plans','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(65,'edit_plans','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(66,'delete_plans','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(67,'restore_plans','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(68,'force_delete_plans','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(69,'view_planlimitation','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(70,'add_planlimitation','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(71,'edit_planlimitation','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(72,'delete_planlimitation','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(73,'restore_planlimitation','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(74,'force_delete_planlimitation','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(75,'view_subscriptions','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(76,'add_subscriptions','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(77,'edit_subscriptions','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(78,'delete_subscriptions','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(79,'restore_subscriptions','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(80,'force_delete_subscriptions','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(81,'view_banners','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(82,'add_banners','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(83,'edit_banners','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(84,'delete_banners','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(85,'restore_banners','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(86,'force_delete_banners','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(87,'view_currency','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(88,'add_currency','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(89,'edit_currency','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(90,'delete_currency','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(91,'restore_currency','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(92,'force_delete_currency','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(93,'view_notification','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(94,'add_notification','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(95,'edit_notification','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(96,'delete_notification','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(97,'restore_notification','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(98,'force_delete_notification','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(99,'view_notification_template','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(100,'add_notification_template','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(101,'edit_notification_template','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(102,'delete_notification_template','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(103,'restore_notification_template','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(104,'force_delete_notification_template','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(105,'view_constant','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(106,'add_constant','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(107,'edit_constant','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(108,'delete_constant','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(109,'restore_constant','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(110,'force_delete_constant','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(111,'view_subscription','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(112,'add_subscription','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(113,'edit_subscription','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(114,'delete_subscription','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(115,'restore_subscription','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(116,'force_delete_subscription','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(117,'view_castcrew','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(118,'add_castcrew','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(119,'edit_castcrew','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(120,'delete_castcrew','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(121,'restore_castcrew','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(122,'force_delete_castcrew','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(123,'view_livetv','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(124,'add_livetv','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(125,'edit_livetv','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(126,'delete_livetv','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(127,'restore_livetv','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(128,'force_delete_livetv','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(129,'view_video','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(130,'add_video','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(131,'edit_video','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(132,'delete_video','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(133,'restore_video','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(134,'force_delete_video','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(135,'view_media','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(136,'add_media','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(137,'edit_media','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(138,'delete_media','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(139,'restore_media','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(140,'force_delete_media','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(141,'view_onboarding','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(142,'add_onboarding','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(143,'edit_onboarding','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(144,'delete_onboarding','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(145,'restore_onboarding','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(146,'force_delete_onboarding','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(147,'view_tvshow','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(148,'add_tvshow','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(149,'edit_tvshow','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(150,'delete_tvshow','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(151,'restore_tvshow','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(152,'force_delete_tvshow','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(153,'view_taxes','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(154,'add_taxes','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(155,'edit_taxes','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(156,'delete_taxes','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(157,'restore_taxes','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(158,'force_delete_taxes','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(159,'view_page','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(160,'add_page','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(161,'edit_page','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(162,'delete_page','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(163,'restore_page','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(164,'force_delete_page','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(165,'view_dashboard_setting','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(166,'add_dashboard_setting','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(167,'edit_dashboard_setting','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(168,'delete_dashboard_setting','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(169,'restore_dashboard_setting','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(170,'force_delete_dashboard_setting','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(171,'view_app_config','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(172,'add_app_config','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(173,'edit_app_config','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(174,'delete_app_config','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(175,'restore_app_config','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(176,'force_delete_app_config','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(177,'view_constants','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(178,'add_constants','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(179,'edit_constants','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(180,'delete_constants','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(181,'restore_constants','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(182,'force_delete_constants','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(183,'view_coupon','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(184,'add_coupon','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(185,'edit_coupon','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(186,'delete_coupon','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(187,'restore_coupon','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(188,'force_delete_coupon','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(189,'view_setting','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(190,'add_setting','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(191,'edit_setting','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(192,'delete_setting','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(193,'restore_setting','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(194,'force_delete_setting','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(195,'setting_bussiness','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(196,'setting_misc','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(197,'setting_custom_code','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(198,'setting_customization','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(199,'setting_mail','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(200,'setting_notification','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(201,'setting_intigrations','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(202,'setting_language','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(203,'setting_invoice','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(204,'setting_module','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(205,'setting_app_setting','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(206,'view_ads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(207,'add_ads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(208,'edit_ads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(209,'delete_ads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(210,'restore_ads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(211,'force_delete_ads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(212,'view_vastads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(213,'add_vastads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(214,'edit_vastads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(215,'delete_vastads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(216,'restore_vastads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(217,'force_delete_vastads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(218,'view_customads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(219,'add_customads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(220,'edit_customads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(221,'delete_customads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(222,'restore_customads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(223,'force_delete_customads','web',1,'2026-02-26 20:54:00','2026-02-26 20:54:00'),
(224,'view_music_tracks','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42'),
(225,'create_music_tracks','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42'),
(226,'edit_music_tracks','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42'),
(227,'delete_music_tracks','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42'),
(228,'view_music_albums','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42'),
(229,'create_music_albums','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42'),
(230,'edit_music_albums','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42'),
(231,'delete_music_albums','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42'),
(232,'view_music_playlists','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42'),
(233,'create_music_playlists','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42'),
(234,'edit_music_playlists','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42'),
(235,'delete_music_playlists','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42'),
(236,'view_shorts','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42'),
(237,'create_shorts','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42'),
(238,'edit_shorts','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42'),
(239,'delete_shorts','web',0,'2026-02-27 21:56:42','2026-02-27 21:56:42');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` longtext DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES
(2,'App\\Models\\User',17,'ApexPrime TV','2644ff700314c1affcb524ecf3fb0b45cb1ebad02219984d914671bd56e01f13','[\"*\"]',NULL,NULL,'2026-02-22 18:27:35','2026-02-22 18:27:35'),
(3,'App\\Models\\User',17,'AP3A.240617.008','c8249caf2fe14a1c09f9b9de78dc8287b28dc394cc309616b695394f7154ec18','[\"*\"]','2026-05-09 10:29:16',NULL,'2026-02-22 18:27:35','2026-05-09 10:29:16'),
(5,'App\\Models\\User',15,'2401:4900:1c3c:295f:d526:c52d:470c:6de5','b62501b1f30d88b4a0c74925f7b1a7f20ad5c77d3fe6e48da3746406f93ac621','[\"*\"]',NULL,NULL,'2026-04-03 08:35:09','2026-04-03 08:35:09'),
(6,'App\\Models\\User',22,'ApexPrime TV','bb173f8638c361e9eddf792d49dc7f6b74b8bad8a0fc74b5c98b2c7dc9cc6819','[\"*\"]',NULL,NULL,'2026-04-04 06:41:22','2026-04-04 06:41:22'),
(7,'App\\Models\\User',22,'BQ2A.250610.001-BP2A.250605.031.A3_V000L1','e4797182a26f02ca66f6b3bb7e9ab011bb4f8c13b1f2aa7b0079d309626b096d','[\"*\"]','2026-04-04 06:41:54',NULL,'2026-04-04 06:41:22','2026-04-04 06:41:54'),
(8,'App\\Models\\User',15,'2401:4900:1c83:4a36:d961:6d92:c61f:9ffa','46c0b17f7a4d41688dfdc2ca9751e1fb54a28bf732982fa2660d5e63e654d015','[\"*\"]',NULL,NULL,'2026-05-01 09:27:16','2026-05-01 09:27:16'),
(9,'App\\Models\\User',23,'ApexPrime TV','d570bb60f801eafc20a469086ac8e6917e5aa859e502f3a1ea55362d74209740','[\"*\"]',NULL,NULL,'2026-05-01 11:26:50','2026-05-01 11:26:50'),
(10,'App\\Models\\User',23,'RP1A.200720.011','c6d689e444006b8c1ea53156d149ac3e0327857df1bec5278ceb6e8372bd7096','[\"*\"]','2026-05-01 11:26:52',NULL,'2026-05-01 11:26:51','2026-05-01 11:26:52'),
(11,'App\\Models\\User',24,'ApexPrime TV','34af2a52e448a3c330c9fc1287a818337f09ab67208d4cef85b7ac7801ab05f0','[\"*\"]',NULL,NULL,'2026-05-09 10:24:06','2026-05-09 10:24:06'),
(12,'App\\Models\\User',24,'BP2A.250605.015','002aa65b85bafcb606e292f2987806f636bc5782071c2f9e76e3c852ce71ae41','[\"*\"]','2026-05-14 15:07:52',NULL,'2026-05-09 10:24:07','2026-05-14 15:07:52'),
(13,'App\\Models\\User',25,'ApexPrime TV','4f175a7cf2f9dd57148034d249b32cd6c774571a70c7fe719c3e5ee98532f2b9','[\"*\"]',NULL,NULL,'2026-05-15 22:04:06','2026-05-15 22:04:06'),
(19,'App\\Models\\User',28,'ApexPrime TV','77eb35d8cc063d2aaa97d47ac0d46e0c4bf1ef60332e4ae492496e59f68742cd','[\"*\"]',NULL,NULL,'2026-06-02 17:34:12','2026-06-02 17:34:12'),
(20,'App\\Models\\User',28,'UP1A.231005.007','78bdbecca321e2d39261ff9ddedeeef88b71a782efbc5b078615259ac23a6822','[\"*\"]','2026-06-03 18:19:43',NULL,'2026-06-02 17:34:13','2026-06-03 18:19:43'),
(21,'App\\Models\\User',29,'test123','09549a3bf71ad1d90c7cdb4dc2cc55bdb312313a50e74f583575472d3e31e069','[\"*\"]','2026-06-03 06:09:58',NULL,'2026-06-03 06:07:19','2026-06-03 06:09:58'),
(23,'App\\Models\\User',3,'test','b13de8f099d52bc07be1101c8ee0cb6291f2aba7aa087e02553d095014f1cf99','[\"*\"]',NULL,NULL,'2026-06-05 05:04:15','2026-06-05 05:04:15'),
(24,'App\\Models\\User',30,'1C85DCD3-19A7-47D8-B5CE-97349759C618','e9fc3a4296e923b2a11cae9cd8d823428bb02858419cbe26ddc28417f7b1073f','[\"*\"]','2026-06-05 14:32:11',NULL,'2026-06-05 14:26:05','2026-06-05 14:32:11'),
(25,'App\\Models\\User',15,'2401:4900:1c3d:1c64:3c6e:5ad1:60c0:e25','1309220594427628e8df6d42b0017c152d4648f540c0021426cc76954b6e0085','[\"*\"]',NULL,NULL,'2026-06-06 10:30:07','2026-06-06 10:30:07'),
(26,'App\\Models\\User',15,'2401:4900:1c3d:1c64:3c6e:5ad1:60c0:e25','863145123afec27c26a8409ef31e01ab15c660cce2d5a63f91c616d8af788086','[\"*\"]',NULL,NULL,'2026-06-06 10:30:31','2026-06-06 10:30:31'),
(28,'App\\Models\\User',16,'UP1A.231005.007','59e63dc275f2a150b3286cef383f5e437b0f14d3f21cacab9a938231316a6a20','[\"*\"]','2026-06-08 10:53:27',NULL,'2026-06-07 02:55:36','2026-06-08 10:53:27');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `plan`
--

DROP TABLE IF EXISTS `plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `plan` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `identifier` varchar(191) NOT NULL,
  `android_identifier` varchar(191) DEFAULT NULL,
  `apple_identifier` varchar(191) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `discount` tinyint(1) NOT NULL DEFAULT 0,
  `discount_percentage` double DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `level` bigint(20) NOT NULL DEFAULT 0,
  `duration` varchar(191) DEFAULT NULL,
  `duration_value` bigint(20) NOT NULL DEFAULT 1,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `description` text DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plan_level_deleted_at_index` (`level`,`deleted_at`),
  KEY `plan_id_deleted_at_index` (`id`,`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `plan` WRITE;
/*!40000 ALTER TABLE `plan` DISABLE KEYS */;
INSERT INTO `plan` VALUES
(1,'Basic','basic',NULL,NULL,5,0,NULL,5,1,'month',1,1,'The Basic Plan offers access to a limited selection of content on a weekly basis, perfect for casual viewers.',2,2,NULL,NULL,'2024-07-11 04:42:21','2024-07-11 04:42:21'),
(2,'Premium Plan','premium_plan',NULL,NULL,20,0,NULL,20,2,'month',1,1,'<p>The Premium Plan provides monthly access to a wider range of content, including exclusive shows and features.</p>',2,2,NULL,NULL,'2024-07-11 04:43:13','2024-10-08 09:28:11'),
(3,'Ultimate Plan','ultimate_plan',NULL,NULL,50,0,NULL,50,3,'month',3,1,'The Ultimate Plan offers quarterly access with additional perks, such as early access to new releases and special content.',2,2,NULL,NULL,'2024-07-11 04:45:14','2024-07-11 04:45:14'),
(4,'Basic','basic',NULL,NULL,100,0,NULL,100,4,'year',1,1,'The Basic Plan offers access to a limited selection of content on a weekly basis, perfect for casual viewers.',2,2,NULL,NULL,'2024-07-11 04:42:21','2024-07-11 04:42:21'),
(5,'Premium Plan','premium_plan',NULL,NULL,200,0,NULL,200,5,'year',1,1,'<p>The Premium Plan provides monthly access to a wider range of content, including exclusive shows and features.</p>',2,2,NULL,NULL,'2024-07-11 04:43:13','2024-10-08 09:28:11'),
(6,'Ultimate Plan','ultimate_plan',NULL,NULL,500,0,NULL,500,6,'year',1,1,'The Ultimate Plan offers quarterly access with additional perks, such as early access to new releases and special content.',2,2,NULL,NULL,'2024-07-11 04:45:14','2024-07-11 04:45:14');
/*!40000 ALTER TABLE `plan` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `planlimitation`
--

DROP TABLE IF EXISTS `planlimitation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `planlimitation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planlimitation`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `planlimitation` WRITE;
/*!40000 ALTER TABLE `planlimitation` DISABLE KEYS */;
INSERT INTO `planlimitation` VALUES
(1,'Video Cast','video-cast','Enhance your viewing experience with our Video Cast feature. Seamlessly stream your favorite shows and movies from your device to your TV or other compatible screens. Enjoy high-quality playback and easy controls for a truly immersive entertainment experience.',1,2,2,NULL,'2024-07-10 11:13:04','2024-07-10 11:13:04',NULL),
(2,'Ads','ads','Discover a new way to enjoy content with minimal interruptions through our Ads feature. Our strategically placed advertisements are designed to provide relevant and engaging information without overwhelming your viewing experience.',1,2,2,NULL,'2024-07-10 11:14:45','2024-07-10 11:14:45',NULL),
(3,'Device Limit','device-limit','Manage your device connections effortlessly with our Device Limit feature. Easily monitor and control the number of devices linked to your account, ensuring a secure and personalized streaming experience.',1,2,2,NULL,'2024-07-10 11:16:10','2024-07-10 11:16:10',NULL),
(4,'Download Status','download-status','Keep track of your content downloads with our Download Status feature. View the progress of your current downloads, check completed files, and manage your storage efficiently. This feature provides real-time updates, allowing you to pause, resume, or cancel downloads as needed, ensuring you have access to your favorite content anytime, even offline.',1,2,2,NULL,'2024-07-10 11:17:41','2024-07-10 11:17:41',NULL),
(5,'Supported Device Type','supported-device-type','Our platform supports a wide range of devices including smartphones, tablets, smart TVs, and gaming consoles. Enjoy seamless streaming on any device with optimized performance and high-quality playback.',1,2,2,NULL,'2024-07-10 11:20:00','2024-07-10 11:20:00',NULL),
(6,'Profile Limit','profile-limit','Manage and customize your streaming experience with our Profile Limit feature. Set limits on the number of profiles that can be created under a single account, ensuring each user enjoys a personalized experience while keeping account usage within your preferred parameters.',1,2,2,NULL,'2024-09-19 12:00:00','2024-09-19 12:00:00',NULL);
/*!40000 ALTER TABLE `planlimitation` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `planlimitation_mapping`
--

DROP TABLE IF EXISTS `planlimitation_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `planlimitation_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `plan_id` int(11) DEFAULT NULL,
  `planlimitation_id` int(11) DEFAULT NULL,
  `limitation_slug` varchar(191) DEFAULT NULL,
  `limitation_value` int(11) DEFAULT NULL,
  `limit` longtext DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `planlimitation_mapping_plan_id_deleted_at_index` (`plan_id`,`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planlimitation_mapping`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `planlimitation_mapping` WRITE;
/*!40000 ALTER TABLE `planlimitation_mapping` DISABLE KEYS */;
INSERT INTO `planlimitation_mapping` VALUES
(1,1,1,'video-cast',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(2,1,2,'ads',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(3,1,3,'device-limit',1,'1',NULL,NULL,NULL,NULL,NULL,NULL),
(4,1,4,'download-status',1,'{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":0,\"2K\":0,\"4K\":0,\"8K\":0}',NULL,NULL,NULL,NULL,NULL,NULL),
(5,2,1,'video-cast',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(6,2,2,'ads',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(7,2,3,'device-limit',1,'2',NULL,NULL,NULL,NULL,NULL,NULL),
(8,2,4,'download-status',1,'{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":1,\"2K\":0,\"4K\":0,\"8K\":0}',NULL,NULL,NULL,NULL,NULL,NULL),
(9,3,1,'video-cast',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10,3,2,'ads',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(11,3,3,'device-limit',1,'5',NULL,NULL,NULL,NULL,NULL,NULL),
(12,3,4,'download-status',1,'{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":1,\"2K\":1,\"4K\":0,\"8K\":0}',NULL,NULL,NULL,NULL,NULL,NULL),
(13,4,1,'video-cast',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(14,4,2,'ads',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(15,4,3,'device-limit',1,'1',NULL,NULL,NULL,NULL,NULL,NULL),
(16,4,4,'download-status',1,'{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":0,\"2K\":0,\"4K\":0,\"8K\":0}',NULL,NULL,NULL,NULL,NULL,NULL),
(17,1,5,'supported-device-type',1,'{\"tablet\":\"0\",\"laptop\":\"0\",\"mobile\":\"1\",\"tv\":\"0\"}',NULL,NULL,NULL,NULL,NULL,NULL),
(18,1,6,'profile-limit',1,'2',NULL,NULL,NULL,NULL,NULL,NULL),
(19,2,5,'supported-device-type',1,'{\"tablet\":\"1\",\"laptop\":\"0\",\"mobile\":\"1\",\"tv\":\"0\"}',NULL,NULL,NULL,NULL,NULL,NULL),
(20,2,6,'profile-limit',1,'3',NULL,NULL,NULL,NULL,NULL,NULL),
(21,3,5,'supported-device-type',1,'{\"tablet\":\"0\",\"laptop\":\"1\",\"mobile\":\"1\",\"tv\":\"1\"}',NULL,NULL,NULL,NULL,NULL,NULL),
(22,3,6,'profile-limit',1,'3',NULL,NULL,NULL,NULL,NULL,NULL),
(23,4,5,'supported-device-type',1,'{\"tablet\":\"0\",\"laptop\":\"0\",\"mobile\":\"1\",\"tv\":\"0\"}',NULL,NULL,NULL,NULL,NULL,NULL),
(24,4,6,'profile-limit',1,'2',NULL,NULL,NULL,NULL,NULL,NULL),
(25,5,1,'video-cast',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(26,5,2,'ads',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(27,5,3,'device-limit',1,'2',NULL,NULL,NULL,NULL,NULL,NULL),
(28,5,4,'download-status',1,'{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":1,\"2K\":0,\"4K\":0,\"8K\":0}',NULL,NULL,NULL,NULL,NULL,NULL),
(29,5,5,'supported-device-type',1,'{\"tablet\":\"1\",\"laptop\":\"0\",\"mobile\":\"1\",\"tv\":\"0\"}',NULL,NULL,NULL,NULL,NULL,NULL),
(30,5,6,'profile-limit',1,'3',NULL,NULL,NULL,NULL,NULL,NULL),
(31,6,1,'video-cast',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(32,6,2,'ads',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(33,6,3,'device-limit',1,'5',NULL,NULL,NULL,NULL,NULL,NULL),
(34,6,4,'download-status',1,'{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":1,\"2K\":1,\"4K\":0,\"8K\":0}',NULL,NULL,NULL,NULL,NULL,NULL),
(35,6,5,'supported-device-type',1,'{\"tablet\":\"0\",\"laptop\":\"1\",\"mobile\":\"1\",\"tv\":\"1\"}',NULL,NULL,NULL,NULL,NULL,NULL),
(36,6,6,'profile-limit',1,'3',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `planlimitation_mapping` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `reel_comments`
--

DROP TABLE IF EXISTS `reel_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reel_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reel_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reel_comments_reel_id_foreign` (`reel_id`),
  KEY `reel_comments_user_id_foreign` (`user_id`),
  CONSTRAINT `reel_comments_reel_id_foreign` FOREIGN KEY (`reel_id`) REFERENCES `reels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reel_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reel_comments`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `reel_comments` WRITE;
/*!40000 ALTER TABLE `reel_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `reel_comments` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `reel_likes`
--

DROP TABLE IF EXISTS `reel_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reel_likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reel_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reel_likes_reel_id_user_id_unique` (`reel_id`,`user_id`),
  KEY `reel_likes_user_id_foreign` (`user_id`),
  CONSTRAINT `reel_likes_reel_id_foreign` FOREIGN KEY (`reel_id`) REFERENCES `reels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reel_likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reel_likes`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `reel_likes` WRITE;
/*!40000 ALTER TABLE `reel_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `reel_likes` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `reels`
--

DROP TABLE IF EXISTS `reels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `caption` text DEFAULT NULL,
  `video_path` varchar(191) NOT NULL,
  `duration` int(10) unsigned NOT NULL,
  `width` int(10) unsigned DEFAULT NULL,
  `height` int(10) unsigned DEFAULT NULL,
  `genre_id` bigint(20) unsigned NOT NULL,
  `views_count` bigint(20) unsigned NOT NULL DEFAULT 0,
  `youtube_id` varchar(191) DEFAULT NULL,
  `youtube_url` varchar(191) DEFAULT NULL,
  `youtube_embed_url` varchar(191) DEFAULT NULL,
  `channel_id` varchar(191) DEFAULT NULL,
  `channel_title` varchar(191) DEFAULT NULL,
  `is_youtube` tinyint(1) NOT NULL DEFAULT 0,
  `youtube_published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reels_user_id_foreign` (`user_id`),
  KEY `reels_genre_id_foreign` (`genre_id`),
  CONSTRAINT `reels_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reels_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reels`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `reels` WRITE;
/*!40000 ALTER TABLE `reels` DISABLE KEYS */;
/*!40000 ALTER TABLE `reels` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entertainment_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `rating` int(11) NOT NULL DEFAULT 0,
  `review` longtext DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES
(1,8,12,5,'A gripping storyline with unexpected twists. Keeps you hooked till the very end. 🤯🔥',NULL,NULL,NULL,'2025-11-12 08:17:58','2025-11-12 08:17:58',NULL),
(2,5,13,4,'Amazing atmosphere and spooky vibes. Perfect for horror fans! 👁️🌑',NULL,NULL,NULL,'2025-09-25 08:17:58','2025-09-25 08:17:58',NULL),
(3,14,8,4,'Keeps you guessing with every turn. The Monkey King\'s journey is riveting and intense. 🤯👀',NULL,NULL,NULL,'2025-10-08 08:17:58','2025-10-08 08:17:58',NULL),
(4,8,11,5,'Non-stop action from start to finish! The fight scenes were incredible. 🎬💥',NULL,NULL,NULL,'2025-10-16 08:17:58','2025-10-16 08:17:58',NULL),
(5,2,10,4,'Absolutely loved the showdown scenes! The tension is palpable throughout. 🥳🎬',NULL,NULL,NULL,'2025-03-19 08:17:58','2025-03-19 08:17:58',NULL),
(6,13,9,4,'The cinematography and special effects are top-notch. A visual treat for action enthusiasts. 🌟🎥',NULL,NULL,NULL,'2025-11-22 08:17:58','2025-11-22 08:17:58',NULL),
(7,6,14,5,'Absolutely gripping from the first episode! The suspense is incredible. 🕵️‍♂️🔍',NULL,NULL,NULL,'2025-07-19 08:17:58','2025-07-19 08:17:58',NULL),
(8,17,7,4,'Hilarious from start to finish! Couldn\'t stop laughing! 😂👏',NULL,NULL,NULL,'2025-10-05 08:17:58','2025-10-05 08:17:58',NULL),
(9,6,6,3,'Brilliantly executed with superb acting. A must-watch for thriller fans. 🎭🌟',NULL,NULL,NULL,'2025-07-09 08:17:58','2025-07-09 08:17:58',NULL),
(10,7,3,4,'Fantastic choreography and intense combat sequences. Top-notch action film! 💪🎥',NULL,NULL,NULL,'2026-01-08 08:17:58','2026-01-08 08:17:58',NULL),
(11,4,5,4,'Each episode leaves you wanting more. The storyline is so gripping! 🎉🕶️',NULL,NULL,NULL,'2026-02-17 08:17:58','2026-02-17 08:17:58',NULL),
(12,1,4,5,'Perfectly blends psychological horror with supernatural elements, keeping you on the edge of your seat and craving for more after each episode. 🔮😱',NULL,NULL,NULL,'2025-12-19 08:17:58','2025-12-19 08:17:58',NULL),
(13,9,9,5,'A thrilling ride that keeps you hooked with its intense plot twists and stunning visuals. 🎬🌟',NULL,NULL,NULL,'2026-01-19 08:17:58','2026-01-19 08:17:58',NULL),
(14,10,13,5,'Loved the creativity and imagination in every scene. It\'s a delightful watch! 🌈✨',NULL,NULL,NULL,'2025-10-06 08:17:58','2025-10-06 08:17:58',NULL),
(15,1,3,4,'A chilling series that grips you from the first scene to the last, leaving you haunted by its eerie atmosphere and suspenseful plot twists. 👻🌑',NULL,NULL,NULL,'2025-09-12 08:17:58','2025-09-12 08:17:58',NULL),
(16,6,5,4,'The suspense is unbearable! Can’t wait for the next episode. 😬🚀',NULL,NULL,NULL,'2025-05-22 08:17:58','2025-05-22 08:17:58',NULL),
(17,3,8,5,'My favorite show this season! The Guardian\'s Challenge episode was thrilling! 🛡️🚀',NULL,NULL,NULL,'2025-05-04 08:17:58','2025-05-04 08:17:58',NULL),
(18,10,3,4,'A magical adventure with charming characters and beautiful animation! 🌼🌟',NULL,NULL,NULL,'2026-02-05 08:17:58','2026-02-05 08:17:58',NULL),
(19,8,4,5,'Amazing cinematography and special effects! Truly a visual treat. 🎥✨',NULL,NULL,NULL,'2025-08-22 08:17:58','2025-08-22 08:17:58',NULL),
(20,11,10,4,'Secrets of Zambezia delivers a powerful message with humor and adventure. 🌍😄',NULL,NULL,NULL,'2025-12-04 08:17:58','2025-12-04 08:17:58',NULL),
(21,16,5,4,'Couldn\'t stop laughing! The antics of Tim and Tom are pure genius. 🤣🎉',NULL,NULL,NULL,'2025-07-22 08:17:58','2025-07-22 08:17:58',NULL),
(22,7,7,5,'A thrilling ride with non-stop adrenaline! Couldn\'t take my eyes off the screen. 🚁🔥',NULL,NULL,NULL,'2025-10-05 08:17:58','2025-10-05 08:17:58',NULL),
(23,5,4,5,'The suspense and horror elements are top-notch. Can\'t wait for more! 👻🔪',NULL,NULL,NULL,'2025-05-29 08:17:58','2025-05-29 08:17:58',NULL),
(24,15,8,5,'Deep Sea Mysteries keeps you at the edge of your seat. Unveiling secrets of the deep has never been more thrilling! 🚢💀',NULL,NULL,NULL,'2026-01-16 08:17:58','2026-01-16 08:17:58',NULL),
(25,9,7,5,'Loved the character development and the emotional depth. It\'s more than just action- it\'s a redemption story! 👍🎥',NULL,NULL,NULL,'2025-04-21 08:17:58','2025-04-21 08:17:58',NULL),
(26,5,8,5,'Each episode gets better and scarier. Highly recommend! 🕸️🕷️',NULL,NULL,NULL,'2026-02-17 08:17:58','2026-02-17 08:17:58',NULL),
(27,9,14,3,'The Gunfighter\'s Redemption is a true masterpiece of action cinema. It leaves you wanting more with its gripping storyline and epic showdowns. 🏆🌌',NULL,NULL,NULL,'2025-03-25 08:17:58','2025-03-25 08:17:58',NULL),
(28,10,4,3,'Daizy\'s Enchanted Journey brings a smile to your face with its enchanting story. 🌸😄',NULL,NULL,NULL,'2025-11-24 08:17:58','2025-11-24 08:17:58',NULL),
(29,6,3,4,'Twists and turns at every corner! Keeps you guessing until the end. 🤯🔎',NULL,NULL,NULL,'2025-11-24 08:17:58','2025-11-24 08:17:58',NULL),
(30,2,9,4,'An intense start with plenty of action and a gripping storyline. Can\'t wait for more! 🤠🔥',NULL,NULL,NULL,'2025-08-31 08:17:58','2025-08-31 08:17:58',NULL),
(31,5,3,3,'A chilling start that kept me hooked from the first episode. So creepy! 😱🖤',NULL,NULL,NULL,'2025-07-12 08:17:58','2025-07-12 08:17:58',NULL),
(32,9,10,5,'The Gunfighter\'s quest for redemption is both heart-wrenching and exhilarating. Captivating from the first shot to the last. 💔🔫',NULL,NULL,NULL,'2025-04-07 08:17:58','2025-04-07 08:17:58',NULL),
(33,1,5,4,'An immersive journey into darkness where every shadow hides a secret, keeping you guessing and terrified until the very end. 🕯️😨',NULL,NULL,NULL,'2025-05-06 08:17:58','2025-05-06 08:17:58',NULL),
(34,22,14,5,'Impressive cinematography and a storyline that keeps you hooked till the end. 🎥👌',NULL,NULL,NULL,'2025-03-17 08:17:58','2025-03-17 08:17:58',NULL),
(35,14,5,5,'Gripping storyline with unexpected twists and heart-pounding action scenes! 🐒👑',NULL,NULL,NULL,'2025-11-26 08:17:58','2025-11-26 08:17:58',NULL),
(36,13,3,4,'Loved the protagonist\'s charisma and the intense plot twists. Keeps you guessing! 🔥🕵️‍♂️',NULL,NULL,NULL,'2025-11-05 08:17:58','2025-11-05 08:17:58',NULL),
(37,6,4,5,'The plot is so intricate and well-crafted. A real edge-of-your-seat thriller. 😲🔥',NULL,NULL,NULL,'2025-06-01 08:17:58','2025-06-01 08:17:58',NULL),
(38,2,11,4,'The characters are well-developed and the plot keeps you on the edge of your seat. 👍🕵️‍♂️',NULL,NULL,NULL,'2025-03-22 08:17:58','2025-03-22 08:17:58',NULL),
(39,3,10,4,'Raziel\'s journey is inspiring and beautifully animated. Can\'t wait for more! 🎉🦄',NULL,NULL,NULL,'2025-03-28 08:17:58','2025-03-28 08:17:58',NULL),
(40,7,9,3,'Heart-pounding action with a hint of suspense. Action movie buffs will enjoy every moment. 🎞️👏',NULL,NULL,NULL,'2025-09-19 08:17:58','2025-09-19 08:17:58',NULL),
(41,4,12,4,'The suspense in every episode keeps me hooked! Can\'t get enough of it. 🔍🎬',NULL,NULL,NULL,'2025-12-29 08:17:58','2025-12-29 08:17:58',NULL),
(42,10,5,5,'Perfect for family movie night - captivating and full of wonder! 🍿👪',NULL,NULL,NULL,'2025-09-25 08:17:58','2025-09-25 08:17:58',NULL),
(43,5,7,5,'The storyline is gripping and the scares are genuine. Loving it! 🎃💀',NULL,NULL,NULL,'2025-04-07 08:17:58','2025-04-07 08:17:58',NULL),
(44,12,8,4,'A visually stunning adventure that captivates from start to finish! 🎬🌟',NULL,NULL,NULL,'2025-02-28 08:17:58','2025-02-28 08:17:58',NULL),
(45,22,11,5,'Educational yet entertaining, perfect for history buffs and casual viewers alike. 📚📺',NULL,NULL,NULL,'2025-04-07 08:17:58','2025-04-07 08:17:58',NULL),
(46,5,6,4,'Edge-of-your-seat horror with a captivating plot. So intense! 🥶🏚️',NULL,NULL,NULL,'2025-04-02 08:17:58','2025-04-02 08:17:58',NULL),
(47,8,3,5,'The characters were so well-developed, and the plot was intense. Loved every moment! 👍🌟',NULL,NULL,NULL,'2025-12-10 08:17:58','2025-12-10 08:17:58',NULL),
(48,6,8,5,'The characters are compelling, and the mystery deepens with each episode. 👏🕵️‍♀️',NULL,NULL,NULL,'2025-03-09 08:17:58','2025-03-09 08:17:58',NULL),
(49,11,6,5,'Loved the soundtrack! It perfectly complements the magical atmosphere of Zambezia. 🎵🎶',NULL,NULL,NULL,'2025-05-04 08:17:58','2025-05-04 08:17:58',NULL),
(50,15,4,5,'The ocean depths come alive with mystery and danger. Riveting from start to finish. 🌊🦑',NULL,NULL,NULL,'2025-08-01 08:17:58','2025-08-01 08:17:58',NULL),
(51,6,9,3,'Each episode unveils more secrets and keeps you hooked. Fantastic storytelling! 📚🎬',NULL,NULL,NULL,'2025-05-10 08:17:58','2025-05-10 08:17:58',NULL),
(52,7,6,4,'Action-packed from start to finish! The stunts were mind-blowing. 🎬💥',NULL,NULL,NULL,'2026-02-05 08:17:58','2026-02-05 08:17:58',NULL),
(53,8,13,5,'The pacing was perfect, never a dull moment. Can\'t wait for a sequel! 🚀🎉',NULL,NULL,NULL,'2025-07-31 08:17:58','2025-07-31 08:17:58',NULL),
(54,16,14,3,'Tim and Tom\'s chemistry is unbeatable. I wish there were more movies like this! 🌟👬',NULL,NULL,NULL,'2025-11-08 08:17:58','2025-11-08 08:17:58',NULL),
(55,9,6,5,'Action-packed and emotionally charged—this movie delivers on all fronts. A must-watch for action enthusiasts! 💥🎞️',NULL,NULL,NULL,'2025-10-11 08:17:58','2025-10-11 08:17:58',NULL),
(56,18,11,4,'I couldn\'t get enough of the comedic timing in this film. Pure comedy gold! ⏱️😄',NULL,NULL,NULL,'2025-11-23 08:17:58','2025-11-23 08:17:58',NULL),
(57,8,14,5,'A thrilling ride with heart-pounding moments. Definitely recommend it to action fans! 🎢👏',NULL,NULL,NULL,'2025-07-23 08:17:58','2025-07-23 08:17:58',NULL),
(58,11,7,5,'The storyline is engaging, and the characters are lovable. A must-watch animation! 🐦💖',NULL,NULL,NULL,'2025-09-17 08:17:58','2025-09-17 08:17:58',NULL),
(59,5,9,5,'The acting and special effects are fantastic. Truly terrifying! 🌲🧟‍♀️',NULL,NULL,NULL,'2025-02-22 08:17:58','2025-02-22 08:17:58',NULL),
(60,12,14,5,'Clever humor and heartfelt moments make this a timeless classic. Highly recommend! 😄👏',NULL,NULL,NULL,'2026-01-25 08:17:58','2026-01-25 08:17:58',NULL),
(61,22,4,5,'The costumes and set designs transport you back in time. A visual feast! 🎨✨',NULL,NULL,NULL,'2025-08-21 08:17:58','2025-08-21 08:17:58',NULL),
(62,9,5,4,'Gripping action from start to finish! The Gunfighter\'s journey is packed with adrenaline-pumping scenes. 🤠🔥',NULL,NULL,NULL,'2025-07-26 08:17:58','2025-07-26 08:17:58',NULL),
(63,26,14,4,'The scenery and music complement the story beautifully. It\'s a visual and emotional treat. 🎵🎥',NULL,NULL,NULL,'2025-04-05 08:17:58','2025-04-05 08:17:58',NULL),
(64,15,11,4,'Intriguing characters and a plot that sinks its hooks deep. Thrills and suspense galore! 👀🎥',NULL,NULL,NULL,'2025-10-13 08:17:58','2025-10-13 08:17:58',NULL),
(65,17,6,5,'Clever humor and witty dialogue make this a must-watch comedy! 🎭👍',NULL,NULL,NULL,'2025-04-05 08:17:58','2025-04-05 08:17:58',NULL),
(66,13,14,4,'Gripping storyline with unexpected turns. I couldn\'t look away for a second! 🤯🔫',NULL,NULL,NULL,'2025-11-05 08:17:58','2025-11-05 08:17:58',NULL),
(67,19,11,5,'Creepy atmosphere and unexpected twists make it a standout horror film. 🌑🕯️',NULL,NULL,NULL,'2025-08-11 08:17:58','2025-08-11 08:17:58',NULL),
(68,7,8,3,'Explosive scenes and gripping storyline. Kept me at the edge of my seat throughout. 🌟🔫',NULL,NULL,NULL,'2025-03-26 08:17:58','2025-03-26 08:17:58',NULL),
(69,16,10,4,'A delightful comedy that had me giggling throughout. Tim and Tom are my new favorites! 🎈😁',NULL,NULL,NULL,'2025-07-26 08:17:58','2025-07-26 08:17:58',NULL),
(70,7,10,5,'Loved the plot twists and the lead actor\'s performance. Definitely worth watching! 👍🎬',NULL,NULL,NULL,'2025-05-10 08:17:58','2025-05-10 08:17:58',NULL),
(71,11,3,4,'Captivating animation and a heartwarming storyline that keeps you engaged till the end. 🌟🎬',NULL,NULL,NULL,'2025-05-15 08:17:58','2025-05-15 08:17:58',NULL),
(72,16,13,5,'A feel-good movie with endless laughs. Perfect for a movie night with friends! 🍿😆',NULL,NULL,NULL,'2025-04-17 08:17:58','2025-04-17 08:17:58',NULL),
(73,11,11,5,'Beautifully crafted characters and stunning visuals. A delight for all ages! 🦅🎨',NULL,NULL,NULL,'2025-08-11 08:17:58','2025-08-11 08:17:58',NULL),
(74,23,8,5,'A feel-good film that leaves you motivated and optimistic. 🎥🌻',NULL,NULL,NULL,'2025-08-25 08:17:58','2025-08-25 08:17:58',NULL),
(75,12,12,5,'The animation is top-notch, and the plot is both engaging and thought-provoking. 🎥🤔',NULL,NULL,NULL,'2025-05-23 08:17:58','2025-05-23 08:17:58',NULL),
(76,13,7,3,'Perfect blend of action and suspense. It kept me at the edge of my seat throughout. 👏🎭',NULL,NULL,NULL,'2025-09-19 08:17:58','2025-09-19 08:17:58',NULL),
(77,18,14,4,'Frank and Fearless bring laughter and charm to the screen. Thoroughly entertaining! 😂🎉',NULL,NULL,NULL,'2025-07-30 08:17:58','2025-07-30 08:17:58',NULL),
(78,13,4,5,'Action-packed from start to finish! The stunts and fight scenes are mind-blowing. 🎬💥',NULL,NULL,NULL,'2025-12-13 08:17:58','2025-12-13 08:17:58',NULL),
(79,17,5,3,'The cast nailed it! Each scene had me in stitches. 🤣🎬',NULL,NULL,NULL,'2025-03-23 08:17:58','2025-03-23 08:17:58',NULL),
(80,15,12,5,'Captivating storyline with chilling moments that leave you breathless. A must-watch for thriller enthusiasts! 😱🎬',NULL,NULL,NULL,'2025-11-03 08:17:58','2025-11-03 08:17:58',NULL),
(81,13,13,4,'Heart-pounding adrenaline rush! The Daring Player sets a new standard for action movies. 🚀👊',NULL,NULL,NULL,'2025-07-12 08:17:58','2025-07-12 08:17:58',NULL),
(82,14,11,5,'Impressive cinematography and a plot that keeps you on the edge of your seat. Bravo! 🌟👏',NULL,NULL,NULL,'2025-08-04 08:17:58','2025-08-04 08:17:58',NULL),
(83,19,4,5,'A terrifying rollercoaster of fear and suspense. 🎢😨',NULL,NULL,NULL,'2025-08-25 08:17:58','2025-08-25 08:17:58',NULL),
(84,21,10,4,'Engrossing narratives and stunning visuals make history come alive! 🎥✨',NULL,NULL,NULL,'2025-05-04 08:17:58','2025-05-04 08:17:58',NULL),
(85,25,13,5,'I couldn\'t stop smiling throughout! A perfect feel-good movie for any day. 😊🎥',NULL,NULL,NULL,'2025-05-30 08:17:58','2025-05-30 08:17:58',NULL),
(86,14,10,4,'The suspense builds up perfectly. I couldn\'t take my eyes off the screen! 🎥🔍',NULL,NULL,NULL,'2025-06-15 08:17:58','2025-06-15 08:17:58',NULL),
(87,1,6,4,'Masterfully crafted with spine-tingling moments that linger long after you\'ve finished watching. A must-watch for horror aficionados! 🎬👻',NULL,NULL,NULL,'2025-06-25 08:17:58','2025-06-25 08:17:58',NULL),
(88,15,3,5,'Gripping plot twists and eerie underwater suspense! Keeps you guessing till the end. 🌊🔍',NULL,NULL,NULL,'2025-03-01 08:17:58','2025-03-01 08:17:58',NULL),
(89,26,5,4,'A perfect movie for a cozy evening. It\'s romantic, emotional, and uplifting. 🍿🎬',NULL,NULL,NULL,'2025-07-06 08:17:58','2025-07-06 08:17:58',NULL),
(90,21,13,5,'Detailed and enlightening! It\'s like stepping back in time. 🕰️📜',NULL,NULL,NULL,'2025-10-01 08:17:58','2025-10-01 08:17:58',NULL),
(91,19,7,3,'Hauntingly good! The suspense builds up perfectly. 🕰️🔦',NULL,NULL,NULL,'2025-05-18 08:17:58','2025-05-18 08:17:58',NULL),
(92,16,9,4,'Hilarious from start to finish! Tim and Tom are comedy gold. 😂👌',NULL,NULL,NULL,'2025-06-18 08:17:58','2025-06-18 08:17:58',NULL),
(93,24,13,5,'An emotional rollercoaster with a powerful message of perseverance. 🎢💫',NULL,NULL,NULL,'2025-08-17 08:17:58','2025-08-17 08:17:58',NULL),
(94,23,5,4,'Rise Above is a testament to the human spirit\'s ability to overcome challenges. 🌠🙌',NULL,NULL,NULL,'2025-05-14 08:17:58','2025-05-14 08:17:58',NULL),
(95,26,12,5,'This movie reminds us that love conquers all. It\'s a must-watch for romantics! 🌹💫',NULL,NULL,NULL,'2026-01-05 08:17:58','2026-01-05 08:17:58',NULL),
(96,16,6,5,'Quirky and entertaining, this movie brightened my day. Highly recommend! 🌈❤️',NULL,NULL,NULL,'2025-07-23 08:17:58','2025-07-23 08:17:58',NULL),
(97,17,3,5,'Perfect pick-me-up comedy for any day of the week. 😄🎥',NULL,NULL,NULL,'2025-08-11 08:17:58','2025-08-11 08:17:58',NULL),
(98,15,7,5,'Atmospheric and hauntingly beautiful. Dive into this thriller for an unforgettable ride. 🌊🎞️',NULL,NULL,NULL,'2025-07-01 08:17:58','2025-07-01 08:17:58',NULL),
(99,17,10,3,'A feel-good comedy that delivers non-stop laughs. Highly recommend! 🌟🎉',NULL,NULL,NULL,'2025-03-30 08:17:58','2025-03-30 08:17:58',NULL),
(100,24,8,5,'Inspirational from start to finish. It reminds us to never give up on our dreams. 🌟🎬',NULL,NULL,NULL,'2025-04-06 08:17:58','2025-04-06 08:17:58',NULL),
(101,18,9,5,'The chemistry between the characters is spot-on. Enjoyable and witty! 👏😆',NULL,NULL,NULL,'2025-09-24 08:17:58','2025-09-24 08:17:58',NULL),
(102,21,6,3,'Each episode is a treasure trove of knowledge. Highly recommend for all ages! 🎓🌟',NULL,NULL,NULL,'2025-03-05 08:17:58','2025-03-05 08:17:58',NULL),
(103,23,11,5,'The performances are outstanding, making the message even more impactful. 👍🎭',NULL,NULL,NULL,'2025-05-22 08:17:58','2025-05-22 08:17:58',NULL),
(104,26,3,4,'Such a heartwarming story! It\'s a beautiful journey of love and second chances. 💖😊',NULL,NULL,NULL,'2025-03-10 08:17:58','2025-03-10 08:17:58',NULL),
(105,21,7,5,'A must-watch for history buffs! The storytelling is impeccable. 🤓🎬',NULL,NULL,NULL,'2025-07-30 08:17:58','2025-07-30 08:17:58',NULL),
(106,24,6,5,'A beautiful story of resilience and triumph against all odds. 🎥🌟',NULL,NULL,NULL,'2025-03-04 08:17:58','2025-03-04 08:17:58',NULL),
(107,20,10,5,'Perfect blend of suspense and horror. Hauntingly good! 👀🔪',NULL,NULL,NULL,'2025-04-10 08:17:58','2025-04-10 08:17:58',NULL),
(108,26,8,5,'Forever in My Heart touched my soul. It\'s a timeless love story that stays with you. 💞📽️',NULL,NULL,NULL,'2025-06-23 08:17:58','2025-06-23 08:17:58',NULL),
(109,12,13,4,'An imaginative world that brings out the child in everyone. Loved every moment! 🌈👶',NULL,NULL,NULL,'2025-11-05 08:17:58','2025-11-05 08:17:58',NULL),
(110,19,6,4,'Couldn\'t look away despite being scared out of my wits! 👀😳',NULL,NULL,NULL,'2026-02-15 08:17:58','2026-02-15 08:17:58',NULL),
(111,18,12,5,'Clever writing and great performances make this movie a joy to watch. 📝🎥',NULL,NULL,NULL,'2025-11-20 08:17:58','2025-11-20 08:17:58',NULL),
(112,12,3,4,'The New Empire sets a new standard for animated movies. Truly magical! 🌠🎉',NULL,NULL,NULL,'2025-03-06 08:17:58','2025-03-06 08:17:58',NULL),
(113,19,9,5,'Spine-chilling! Kept me awake all night. 😱👻',NULL,NULL,NULL,'2025-05-12 08:17:58','2025-05-12 08:17:58',NULL),
(114,23,9,5,'This movie reminds us that anything is possible with determination and courage. 🌟💪',NULL,NULL,NULL,'2025-03-17 08:17:58','2025-03-17 08:17:58',NULL),
(115,20,5,5,'Kept me on the edge of my seat the entire time! Terrifying twists and turns. 😱👻',NULL,NULL,NULL,'2025-06-14 08:17:58','2025-06-14 08:17:58',NULL),
(116,25,7,5,'A timeless romance that sweeps you off your feet. Pure cinematic bliss! 🎬💞',NULL,NULL,NULL,'2025-03-08 08:17:58','2025-03-08 08:17:58',NULL),
(117,21,12,4,'A fascinating exploration of ancient history, beautifully presented. 🌍🏛️',NULL,NULL,NULL,'2025-05-29 08:17:58','2025-05-29 08:17:58',NULL),
(118,20,4,5,'The atmosphere was eerie, and the scares were genuinely frightening. Bravo! 🌑🎬',NULL,NULL,NULL,'2025-06-18 08:17:58','2025-06-18 08:17:58',NULL),
(119,26,4,5,'The chemistry between the leads is undeniable. I couldn\'t stop smiling throughout! 💑🌟',NULL,NULL,NULL,'2025-08-19 08:17:58','2025-08-19 08:17:58',NULL),
(120,22,3,5,'Captivating portrayal of ancient civilizations, rich in detail and authenticity. 🏛️📜',NULL,NULL,NULL,'2025-03-29 08:17:58','2025-03-29 08:17:58',NULL),
(121,23,3,5,'Rise Above delivers a powerful message of perseverance and resilience. 🌈👏',NULL,NULL,NULL,'2025-11-02 08:17:58','2025-11-02 08:17:58',NULL),
(122,22,8,5,'A fascinating journey through history, beautifully depicted with stellar performances. 🎭🌍',NULL,NULL,NULL,'2025-08-30 08:17:58','2025-08-30 08:17:58',NULL),
(123,24,12,3,'Touching and motivational. It\'s a journey everyone should experience. 🚀😊',NULL,NULL,NULL,'2025-03-15 08:17:58','2025-03-15 08:17:58',NULL),
(124,23,14,3,'A deeply inspiring movie that touches the heart and uplifts the spirit. 🌟😊',NULL,NULL,NULL,'2026-01-08 08:17:58','2026-01-08 08:17:58',NULL),
(125,22,9,5,'Engrossing narrative that brings the past to life with every scene. 🕰️🔍',NULL,NULL,NULL,'2025-04-24 08:17:58','2025-04-24 08:17:58',NULL),
(126,23,4,3,'The storyline is moving, and the characters\' journeys are truly inspirational. 🎬❤️',NULL,NULL,NULL,'2025-08-17 08:17:58','2025-08-17 08:17:58',NULL),
(127,25,6,3,'Heartwarming and beautifully romantic, a love story that stays with you forever. 💖🌟',NULL,NULL,NULL,'2025-11-24 08:17:58','2025-11-24 08:17:58',NULL),
(128,24,3,4,'This movie inspired me deeply. A powerful reminder of the strength within us all. 🌟🙌',NULL,NULL,NULL,'2025-03-02 08:17:58','2025-03-02 08:17:58',NULL),
(129,20,12,4,'Creepy and atmospheric. It\'s a horror fan\'s dream come true! 🌌🏚️',NULL,NULL,NULL,'2025-10-24 08:17:58','2025-10-24 08:17:58',NULL),
(130,21,3,5,'An epic journey through the origins of civilization. Educational and captivating! 📚🌅',NULL,NULL,NULL,'2025-04-21 08:17:58','2025-04-21 08:17:58',NULL),
(131,25,3,5,'This movie made me believe in love all over again. Simply breathtaking! 💕😍',NULL,NULL,NULL,'2025-09-18 08:17:58','2025-09-18 08:17:58',NULL),
(132,20,8,4,'A bone-chilling experience that left me checking over my shoulder. Highly recommend! 🕯️👁️',NULL,NULL,NULL,'2025-07-22 08:17:58','2025-07-22 08:17:58',NULL),
(133,10,12,5,'Daizy\'s journey is heartwarming and filled with lessons for all ages. 🎈😊',NULL,NULL,NULL,'2025-07-21 08:17:58','2025-07-21 08:17:58',NULL),
(134,24,7,5,'The characters\' journeys are incredibly moving. You\'ll laugh, cry, and feel inspired. 💖😭',NULL,NULL,NULL,'2025-05-19 08:17:58','2025-05-19 08:17:58',NULL),
(135,19,14,4,'Every shadow feels like it\'s watching you. Thrilling till the end! 🌌👁️',NULL,NULL,NULL,'2025-07-22 08:17:58','2025-07-22 08:17:58',NULL),
(136,1,7,5,'Evokes a sense of dread and excitement simultaneously, offering a thrilling rollercoaster ride through fear and suspense. 🎢😱',NULL,NULL,NULL,'2025-05-27 08:17:58','2025-05-27 08:17:58',NULL),
(137,2,12,4,'Fantastic cinematography and thrilling gunfights! A must-watch for Western fans. 📽️🌟',NULL,NULL,NULL,'2025-08-03 08:17:58','2025-08-03 08:17:58',NULL),
(138,22,5,5,'Each moment feels like a glimpse into a forgotten era. Absolutely mesmerizing! 🌌🔮',NULL,NULL,NULL,'2025-02-22 08:17:58','2025-02-22 08:17:58',NULL),
(139,2,13,5,'Each episode is better than the last. The story is captivating and full of surprises. 🎉🚀',NULL,NULL,NULL,'2025-04-23 08:17:58','2025-04-23 08:17:58',NULL),
(140,5,12,4,'The twists and turns are brilliant. A must-watch for horror lovers! 🌫️📺',NULL,NULL,NULL,'2025-08-26 08:17:58','2025-08-26 08:17:58',NULL),
(141,4,13,5,'Edge-of-your-seat excitement and unexpected twists. Absolutely thrilling! 😱🚀',NULL,NULL,NULL,'2025-07-10 08:17:58','2025-07-10 08:17:58',NULL),
(142,10,7,5,'The animation is top-notch, and the story keeps you hooked from start to finish. 🎬💖',NULL,NULL,NULL,'2025-12-07 08:17:58','2025-12-07 08:17:58',NULL),
(143,20,3,5,'Gripping from start to finish. The tension builds up beautifully. 🎢💀',NULL,NULL,NULL,'2026-01-08 08:17:58','2026-01-08 08:17:58',NULL),
(144,25,12,5,'Touching and emotional, it captures the essence of true love\'s journey. 🌹😢',NULL,NULL,NULL,'2025-02-18 08:17:58','2025-02-18 08:17:58',NULL),
(145,1,8,5,'Captivating and spine-chilling, with a narrative that grips your imagination and leaves you pondering its mysteries. 🔍🌑',NULL,NULL,NULL,'2025-09-28 08:17:58','2025-09-28 08:17:58',NULL),
(146,4,4,5,'Great character development and intense scenes. A top-notch thriller! 👏🔥',NULL,NULL,NULL,'2025-04-15 08:17:58','2025-04-15 08:17:58',NULL),
(147,2,14,5,'The perfect blend of drama and action. The Gunslinger is a true hero! 👏🏜️',NULL,NULL,NULL,'2025-07-13 08:17:58','2025-07-13 08:17:58',NULL),
(148,11,9,4,'An enchanting journey that sparks imagination and leaves you wanting more. ✨🌟',NULL,NULL,NULL,'2025-04-02 08:17:58','2025-04-02 08:17:58',NULL),
(149,3,9,5,'The animation is stunning, and the story is captivating. Love Raziel\'s bravery! 🐉🎨',NULL,NULL,NULL,'2025-08-31 08:17:58','2025-08-31 08:17:58',NULL),
(150,26,10,3,'I cried happy tears! This movie reaffirms the power of love and hope. 💖😊',NULL,NULL,NULL,'2025-10-26 08:17:58','2025-10-26 08:17:58',NULL),
(151,3,3,5,'A magical adventure that kept my kids and me glued to the screen! 🌲✨',NULL,NULL,NULL,'2025-02-24 08:17:58','2025-02-24 08:17:58',NULL),
(152,14,12,4,'A must-watch for thriller enthusiasts. The Monkey King\'s quest will leave you wanting more. 🎭🌌',NULL,NULL,NULL,'2025-10-05 08:17:58','2025-10-05 08:17:58',NULL),
(153,18,3,5,'A comedy that hits all the right notes. Fun, light-hearted, and highly enjoyable! 🎶😊',NULL,NULL,NULL,'2026-02-05 08:17:58','2026-02-05 08:17:58',NULL),
(154,16,6,5,'The cinematography is fantastic, and the suspense never lets up. Highly recommend! 🎥🌟',NULL,NULL,NULL,'2025-10-25 08:17:58','2025-10-25 08:17:58',NULL),
(155,21,8,4,'The scale and depth of this series are truly impressive. History enthusiasts will be hooked! 🌐🔍',NULL,NULL,NULL,'2025-05-23 08:17:58','2025-05-23 08:17:58',NULL),
(156,13,11,5,'Perfect mix of fantasy and adventure. The Final Showdown was epic! ⚔️🌟',NULL,NULL,NULL,'2025-07-30 08:17:58','2025-07-30 08:17:58',NULL),
(157,19,13,4,'Heart-pounding moments that will linger long after the credits roll. Must-watch for horror enthusiasts! 🎥👹',NULL,NULL,NULL,'2025-08-10 08:17:58','2025-08-10 08:17:58',NULL),
(158,14,6,4,'Intriguing characters and stunning visual effects. A thrilling ride from start to finish. 🎬🔥',NULL,NULL,NULL,'2025-08-29 08:17:58','2025-08-29 08:17:58',NULL),
(159,12,5,5,'Heartwarming story with lovable characters. Perfect for family movie night! 🍿❤️',NULL,NULL,NULL,'2025-03-24 08:17:58','2025-03-24 08:17:58',NULL),
(160,19,3,4,'Gripping horror that leaves you checking the shadows. Not for the faint-hearted! 🚪🌚',NULL,NULL,NULL,'2025-11-09 08:17:58','2025-11-09 08:17:58',NULL),
(161,18,4,5,'A comedic adventure that keeps you smiling from start to finish. 😄🌟',NULL,NULL,NULL,'2025-03-09 08:17:58','2025-03-09 08:17:58',NULL),
(162,13,7,5,'The Hidden Fortress episode was full of unexpected twists and turns! So exciting! 🏰🔍',NULL,NULL,NULL,'2025-10-24 08:17:58','2025-10-24 08:17:58',NULL),
(163,17,9,5,'The plot is brilliantly crafted with a perfect mix of mystery and action. 📺🕵️‍♂️',NULL,NULL,NULL,'2025-09-02 08:17:58','2025-09-02 08:17:58',NULL),
(164,24,4,4,'Couldn\'t help but smile throughout. Pure comedy gold! 😊👌',NULL,NULL,NULL,'2025-03-28 08:17:58','2025-03-28 08:17:58',NULL),
(165,9,14,5,'A masterful blend of intrigue and drama. Every scene is filled with tension. 😱🏙️',NULL,NULL,NULL,'2025-11-07 08:17:58','2025-11-07 08:17:58',NULL),
(166,12,11,4,'Forever and a Day is a masterpiece in romantic storytelling. A must-watch! 🌈❤️',NULL,NULL,NULL,'2025-09-22 08:17:58','2025-09-22 08:17:58',NULL),
(167,7,10,4,'Heartfelt and uplifting. It leaves you with a sense of hope and determination. 🌈💪',NULL,NULL,NULL,'2025-08-04 08:17:58','2025-08-04 08:17:58',NULL),
(168,12,5,5,'The chemistry between the leads is magical. It\'s a love story you won\'t forget. ✨👫',NULL,NULL,NULL,'2025-08-03 08:17:58','2025-08-03 08:17:58',NULL),
(169,18,8,4,'Loved the quirky humor and unexpected twists. A must-watch for comedy lovers. 🎬🤩',NULL,NULL,NULL,'2025-10-29 08:17:58','2025-10-29 08:17:58',NULL);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1),
(11,1),
(12,1),
(13,1),
(14,1),
(15,1),
(16,1),
(17,1),
(18,1),
(19,1),
(20,1),
(21,1),
(22,1),
(23,1),
(24,1),
(25,1),
(26,1),
(27,1),
(28,1),
(29,1),
(30,1),
(31,1),
(32,1),
(33,1),
(34,1),
(35,1),
(36,1),
(37,1),
(38,1),
(39,1),
(40,1),
(41,1),
(42,1),
(43,1),
(44,1),
(45,1),
(46,1),
(47,1),
(48,1),
(49,1),
(50,1),
(51,1),
(52,1),
(53,1),
(54,1),
(55,1),
(56,1),
(57,1),
(58,1),
(59,1),
(60,1),
(61,1),
(62,1),
(63,1),
(64,1),
(65,1),
(66,1),
(67,1),
(68,1),
(69,1),
(70,1),
(71,1),
(72,1),
(73,1),
(74,1),
(75,1),
(76,1),
(77,1),
(78,1),
(79,1),
(80,1),
(81,1),
(82,1),
(83,1),
(84,1),
(85,1),
(86,1),
(87,1),
(88,1),
(89,1),
(90,1),
(91,1),
(92,1),
(93,1),
(94,1),
(95,1),
(96,1),
(97,1),
(98,1),
(99,1),
(100,1),
(101,1),
(102,1),
(103,1),
(104,1),
(105,1),
(106,1),
(107,1),
(108,1),
(109,1),
(110,1),
(111,1),
(112,1),
(113,1),
(114,1),
(115,1),
(116,1),
(117,1),
(118,1),
(119,1),
(120,1),
(121,1),
(122,1),
(123,1),
(124,1),
(125,1),
(126,1),
(127,1),
(128,1),
(129,1),
(130,1),
(131,1),
(132,1),
(133,1),
(134,1),
(135,1),
(136,1),
(137,1),
(138,1),
(139,1),
(140,1),
(141,1),
(142,1),
(143,1),
(144,1),
(145,1),
(146,1),
(147,1),
(148,1),
(149,1),
(150,1),
(151,1),
(152,1),
(153,1),
(154,1),
(155,1),
(156,1),
(157,1),
(158,1),
(159,1),
(160,1),
(161,1),
(162,1),
(163,1),
(164,1),
(165,1),
(166,1),
(167,1),
(168,1),
(169,1),
(170,1),
(171,1),
(172,1),
(173,1),
(174,1),
(175,1),
(176,1),
(177,1),
(178,1),
(179,1),
(180,1),
(181,1),
(182,1),
(183,1),
(184,1),
(185,1),
(186,1),
(187,1),
(188,1),
(189,1),
(190,1),
(191,1),
(192,1),
(193,1),
(194,1),
(195,1),
(196,1),
(197,1),
(198,1),
(199,1),
(200,1),
(201,1),
(202,1),
(203,1),
(204,1),
(205,1),
(206,1),
(207,1),
(208,1),
(209,1),
(210,1),
(211,1),
(212,1),
(213,1),
(214,1),
(215,1),
(216,1),
(217,1),
(218,1),
(219,1),
(220,1),
(221,1),
(222,1),
(223,1),
(224,1),
(225,1),
(226,1),
(227,1),
(228,1),
(229,1),
(230,1),
(231,1),
(232,1),
(233,1),
(234,1),
(235,1),
(236,1),
(237,1),
(238,1),
(239,1),
(1,2),
(2,2),
(3,2),
(4,2),
(5,2),
(6,2),
(7,2),
(8,2),
(9,2),
(10,2),
(11,2),
(12,2),
(13,2),
(14,2),
(15,2),
(16,2),
(17,2),
(18,2),
(19,2),
(20,2),
(21,2),
(22,2),
(23,2),
(24,2),
(25,2),
(26,2),
(27,2),
(28,2),
(29,2),
(30,2),
(31,2),
(32,2),
(33,2),
(34,2),
(35,2),
(36,2),
(37,2),
(38,2),
(39,2),
(40,2),
(41,2),
(42,2),
(43,2),
(44,2),
(45,2),
(46,2),
(47,2),
(48,2),
(49,2),
(50,2),
(51,2),
(52,2),
(53,2),
(54,2),
(55,2),
(56,2),
(57,2),
(58,2),
(59,2),
(60,2),
(61,2),
(62,2),
(63,2),
(64,2),
(65,2),
(66,2),
(67,2),
(68,2),
(69,2),
(70,2),
(71,2),
(72,2),
(73,2),
(74,2),
(75,2),
(76,2),
(77,2),
(78,2),
(79,2),
(80,2),
(81,2),
(82,2),
(83,2),
(84,2),
(85,2),
(86,2),
(87,2),
(88,2),
(89,2),
(90,2),
(91,2),
(92,2),
(93,2),
(94,2),
(95,2),
(96,2),
(97,2),
(98,2),
(99,2),
(100,2),
(101,2),
(102,2),
(103,2),
(104,2),
(105,2),
(106,2),
(107,2),
(108,2),
(109,2),
(110,2),
(111,2),
(112,2),
(113,2),
(114,2),
(115,2),
(116,2),
(117,2),
(118,2),
(119,2),
(120,2),
(121,2),
(122,2),
(123,2),
(124,2),
(125,2),
(126,2),
(127,2),
(128,2),
(129,2),
(130,2),
(131,2),
(132,2),
(133,2),
(134,2),
(135,2),
(136,2),
(137,2),
(138,2),
(139,2),
(140,2),
(141,2),
(142,2),
(143,2),
(144,2),
(145,2),
(146,2),
(147,2),
(148,2),
(149,2),
(150,2),
(151,2),
(152,2),
(153,2),
(154,2),
(155,2),
(156,2),
(157,2),
(158,2),
(159,2),
(160,2),
(161,2),
(162,2),
(163,2),
(164,2),
(165,2),
(166,2),
(167,2),
(168,2),
(169,2),
(170,2),
(171,2),
(172,2),
(173,2),
(174,2),
(175,2),
(176,2),
(177,2),
(178,2),
(179,2),
(180,2),
(181,2),
(182,2),
(183,2),
(184,2),
(185,2),
(186,2),
(187,2),
(188,2),
(189,2),
(190,2),
(191,2),
(192,2),
(193,2),
(194,2),
(195,2),
(196,2),
(197,2),
(198,2),
(199,2),
(200,2),
(201,2),
(202,2),
(203,2),
(204,2),
(205,2),
(206,2),
(207,2),
(208,2),
(209,2),
(210,2),
(211,2),
(212,2),
(213,2),
(214,2),
(215,2),
(216,2),
(217,2),
(218,2),
(219,2),
(220,2),
(221,2),
(222,2),
(223,2);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(125) NOT NULL,
  `title` varchar(191) NOT NULL,
  `guard_name` varchar(125) NOT NULL,
  `is_fixed` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES
(1,'admin','Admin','web',1,'2026-02-18 08:17:52','2026-02-18 08:17:52'),
(2,'demo_admin','Demo Admin','web',1,'2026-02-18 08:17:52','2026-02-18 08:17:52'),
(3,'user','user','web',1,'2026-02-18 08:17:52','2026-02-18 08:17:52');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `seasons`
--

DROP TABLE IF EXISTS `seasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `seasons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tmdb_id` varchar(191) DEFAULT NULL,
  `season_index` varchar(191) DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `poster_url` text DEFAULT NULL,
  `entertainment_id` bigint(20) unsigned DEFAULT NULL,
  `trailer_url_type` varchar(191) DEFAULT NULL,
  `trailer_url` text DEFAULT NULL,
  `access` varchar(191) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `plan_id` bigint(20) unsigned DEFAULT NULL,
  `short_desc` longtext DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `poster_tv_url` text DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `purchase_type` varchar(191) DEFAULT NULL,
  `access_duration` int(11) DEFAULT NULL,
  `discount` varchar(191) DEFAULT NULL,
  `available_for` int(11) DEFAULT NULL,
  `meta_title` varchar(191) DEFAULT NULL,
  `meta_keywords` varchar(191) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `seo_image` varchar(191) DEFAULT NULL,
  `google_site_verification` varchar(191) DEFAULT NULL,
  `canonical_url` varchar(191) DEFAULT NULL,
  `short_description` text DEFAULT NULL,
  `slug` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `seasons_entertainment_id_index` (`entertainment_id`),
  KEY `seasons_deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seasons`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `seasons` WRITE;
/*!40000 ALTER TABLE `seasons` DISABLE KEYS */;
INSERT INTO `seasons` VALUES
(1,NULL,NULL,'S1 The Awakening Shadows','s1_the_awakening_shadows_thumb.png',1,'YouTube','https://youtu.be/1sCBEzxF_K4?si=B-rZUby9EXaMWkKD','free',1,NULL,'The team battles an ancient evil that awakens from the shadows. 🌒','The team encounters a series of mysterious events that awaken an ancient evil. Their battle to understand and confront this malevolent force begins. 🏚️👻',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_the_awakening_shadows_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-the-awakening-shadows'),
(2,NULL,NULL,'S2 The Rising Shadows','s2_the_rising_shadows_thumb.png',1,'YouTube','https://youtu.be/7_MJp5AbSwA?si=Mtx9h0wlxtn4o_2Q','free',1,NULL,'Darkness intensifies as the ancient evil returns, stronger than before.','As the ancient evil rises again, the team faces even darker and more powerful threats. They must confront their deepest fears to save humanity from eternal darkness. 🌑🛡️',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_the_rising_shadows_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-the-rising-shadows'),
(3,NULL,NULL,'S1 Lawless Frontier','s1_lawless_frontier_thumb.png',2,'YouTube','https://youtu.be/iABaiZO5Vjs?si=-86t28oJD4cIwkY0','paid',1,1,'The Gunslinger returns to a chaotic town, battling ruthless outlaws and his own demons to restore justice. 🤠🔥','A legendary gunslinger rides back into town, where chaos and corruption reign. Determined to rid the land of crime and find redemption for his troubled past, he faces off against ruthless outlaws and must confront his own inner demons. As the battle for justice unfolds, the town’s fate hangs in the balance, and the gunslinger’s resolve is tested like never before. 🌵⚔️',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_lawless_frontier_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-lawless-frontier'),
(4,NULL,NULL,'S1 The Journey Begins','s1_the_journey_begins_thumb.png',3,'YouTube','https://youtu.be/yGkGMzupaVs?si=O0EBto49niZjBm_e','paid',1,2,'Follow Raziel\'s first steps on a heroic quest to save his friend from the clutches of the wicked Gothel. 🏞️✨','Follow the young and courageous Raziel as he embarks on a heroic quest to save his friend from the clutches of the wicked Gothel. This season chronicles Raziel\'s initial steps into the enchanted forest, where he encounters magical creatures, forms new alliances, and faces the first of many trials. Through determination, bravery, and a growing sense of self-discovery, Raziel begins to uncover the true extent of Gothel\'s sinister plans. Join Raziel on this enchanting journey filled with adventure, mystery, and the unyielding spirit of a true hero. 🏞️✨',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_the_journey_begins_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-the-journey-begins'),
(5,NULL,NULL,'S2 Trials and Triumphs','s2_trials_and_triumphs_thumb.png',3,'YouTube','https://youtu.be/0R3YS_k6a5E?si=hu-eCRA6KQFfIEg2','paid',1,2,'Raziel faces greater challenges and uncovers deeper secrets as he continues his daring rescue mission. 🏰⚔️','Raziel\'s quest intensifies as he delves deeper into the heart of Gothel\'s domain. This season is marked by greater challenges, deeper secrets, and high-stakes confrontations. Raziel and his allies must navigate treacherous landscapes, solve intricate puzzles, and battle formidable foes. As they uncover the layers of Gothel\'s dark magic, Raziel\'s resolve and skills are tested like never before. The season builds to a thrilling climax as Raziel confronts Gothel in a final showdown, determined to rescue his friend and bring peace to the land. Experience the trials and triumphs that define a hero\'s journey in this captivating continuation of Raziel\'s adventure. 🏰⚔️',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_trials_and_triumphs_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-trials-and-triumphs'),
(6,NULL,NULL,'S1 The Hunt Begins','s1_the_hunt_begins_thumb.png',4,'YouTube','https://youtu.be/4IByYWqUrvM?si=ikragPXgMAAECJw8','paid',1,3,'A relentless detective embarks on a dark quest to track down a cunning criminal mastermind. 🔍🕵️‍♂️','The Hunt Begins follows Detective James Black as he dives into a labyrinth of crime and deceit, pursuing the elusive criminal known only as The Phantom. With each clue, the mystery deepens, leading to shocking revelations and deadly encounters. As James races against time, he discovers that the chase is personal, and failure is not an option. 🔍🕵️‍♂️',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_the_hunt_begins_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-the-hunt-begins'),
(7,NULL,NULL,'S2 The Phantom Strikes Back','s2_the_phantom_strikes_back_thumb.png',4,'YouTube','https://youtu.be/T5UokLYVJMI?si=7DVFmcXSmf5zVGKj','paid',1,3,'The Phantom returns, setting off a deadly game of cat and mouse with Detective Black. 🕵️‍♂️💥','The stakes are higher and the danger more imminent. Detective Black faces new challenges as The Phantom resurfaces, orchestrating a series of crimes that push the city to the brink. James must outwit his nemesis in a battle of wits and wills, uncovering secrets that could change everything. The tension mounts as the line between hunter and hunted blurs. 🕵️‍♂️💥',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_the_phantom_strikes_back_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-the-phantom-strikes-back'),
(8,NULL,NULL,'S1 The Shrouded Beginnings','s1_the_shrouded_beginnings_thumb.png',5,'YouTube','https://youtu.be/h1miqLzgKp0?si=5PYD5oOv2MwxwEvw','paid',1,4,'Explore the terrifying mysteries of a town shrouded in darkness as unseen forces strike. 🌑👻','The Shrouded Beginnings explores the eerie origins of Ravenwood, where ancient and malevolent forces begin to awaken. As strange occurrences and ghostly apparitions plague the town, a group of determined residents sets out to uncover the truth behind the growing darkness. Their journey reveals chilling secrets and tests their courage as they delve into the heart of the town\'s haunted past. 🌑🕯️',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_the_shrouded_beginnings_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-the-shrouded-beginnings'),
(9,NULL,NULL,'S2 The Deepening Shadows','s2_the_deepening_shadows.png',5,'YouTube','https://youtu.be/dt8gBF1uZ3E?si=AI2JENWIAUD_SKmr','paid',1,4,'Darkness intensifies, and the struggle for survival grows fiercer. 🌘⚔️','The Deepening Shadows sees the malevolent forces in Ravenwood growing stronger and more vengeful. The residents, now armed with knowledge from their previous encounters, must face even greater horrors. As they delve deeper into the town\'s haunted history, they uncover shocking truths and form unlikely alliances to combat the rising evil. The struggle for survival reaches a critical point, pushing the residents to their limits and revealing the true extent of their bravery. 🌘⚔️',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_the_deepening_shadows.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-the-deepening-shadows'),
(10,NULL,NULL,'S1 Whispers of Betrayal','s1_whispers_of_betrayal_thumb.png',6,'YouTube','https://youtu.be/kWTcFa0DEl0?si=zTjxDCxXXqOLB29F','free',1,NULL,'A relentless investigator uncovers hidden truths and faces betrayals that threaten to unravel everything. 🔍🕵️‍♂️','Whispers of Betrayal follows Investigator Alex Reed as he dives into a labyrinth of hidden truths and deception. As he uncovers layers of betrayal that cut close to home, he realizes that the people he trusts most might be hiding the darkest secrets. The season is a gripping tale of trust, treachery, and the relentless pursuit of justice. 🔍🕵️‍♂️',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_whispers_of_betrayal_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-whispers-of-betrayal'),
(11,NULL,NULL,'S1 The Darkened Path','s1_the_darkened_path_thumb.png',7,'YouTube','https://youtu.be/PI4Z7t3AZ5E?si=QNKYohZ1ZgLol_OP','paid',1,1,'Emily steps onto the darkened path, discovering the haunted legacy of her grandmother, Dorothy, as she navigates the dangerous and decayed world of Oz.','In \"The Darkened Path\", Emily Gale\'s world is turned upside down when she stumbles upon her family\'s long-hidden connection to the mystical realm of Oz. But this is not the Oz of fairy tales—this is a twisted, shadow-filled land where nightmares come alive. As Emily sets out on a harrowing journey down the forgotten road, she must unravel the secrets of her grandmother\'s past, confront terrifying creatures, and uncover the truth about the curse that binds her family to this darkened path. The stakes are high, and survival is uncertain in this thrilling first series. 🌪️🖤',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_the_darkened_path_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-the-darkened-path'),
(12,NULL,NULL,'S2 The Curse Unveiled','s2_the_curse_unveiled_thumb.png',7,'YouTube','https://youtu.be/W0_55mECsa4?si=b_AlIpdvNC_wZ5Zr','paid',1,1,'Emily returns to Oz as rising shadows threaten to consume both worlds, forcing her into a final confrontation with the ancient evil that haunts her bloodline.','Emily, still haunted by the horrors of her first journey, is pulled back into the decaying world of Oz. This time, the shadows have grown stronger, their influence spreading into her own reality. With new allies and old enemies lurking in the darkness, Emily faces her greatest challenge yet: to stop an ancient evil from fully awakening. As the lines between the real world and Oz blur, Emily must summon all her strength to fight the rising shadows and end the family curse once and for all. 🌑⚡💀',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_the_curse_unveiled_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-the-curse-unveiled'),
(13,NULL,NULL,'S1 The Wild Awakening','s1_the_wild_awakening_thumb.png',8,'YouTube','https://youtu.be/iJkspWwwZLM?si=chtl8vdmLqPNKPfE','free',1,NULL,'🌕 Maddy and Rhydian discover their true natures as they fight to protect their identities from hunters and rival wolfbloods. 👩','🌕 Maddy’s world is turned upside down when Rhydian enters her life, sparking a journey of self-discovery and adventure. Together, they must navigate the challenges of being wolfbloods—hunted by those who fear them and rivaled by those who threaten them. As their powers grow, so does the danger around them. Rhydian’s mysterious past and Maddy’s loyalty to her pack will be tested in a thrilling fight for survival. 🐺🔥⚡ This action-packed series offers excitement, drama, and emotional depth, making Wolfbound an epic journey for fans of adventure and mystery.',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_the_wild_awakening_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-the-wild-awakening'),
(14,NULL,NULL,'S1 Rise of the Tribes','s1_rise_of_the_tribes_thumb.png',9,'YouTube','https://youtu.be/MAFsRmx6pPo?si=CJjoeRbHVtKJt9oC','free',1,NULL,'🌍 The tribes unite for the first time as a powerful enemy threatens to destroy their homeland, forcing them to rise up together in a battle for survival.','🔥 The tribes scattered and divided, but when a brutal force of invaders descends upon their land, they must set aside old rivalries and forge a new alliance. The story follows warriors from different tribes as they band together, learning to trust one another while navigating ancient prophecies, mysterious allies, and dangerous enemies. As they face impossible odds, the tribes grow stronger, discovering that unity is their greatest weapon. This season sets the stage for an epic war that will determine the fate of their people and homeland. ⚔️🐾🛡️',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_rise_of_the_tribes_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-rise-of-the-tribes'),
(15,NULL,NULL,'S1 Warrior’s End','s1_warriors_end_thumb.png',10,'YouTube','https://youtu.be/-Denciie5oA?si=GBZdawncCJfXbjWk','paid',1,4,'🛡️ \"Warrior’s End\" captures the final, defining moments of legendary battles where valor and sacrifice shape the destiny of heroes and their world.','⚔️ \"Warrior’s End\" is a gripping series that delves into the climactic endgame of legendary conflicts. Following a series of monumental battles, the show focuses on the warriors who stand at the crossroads of history. As they face their final tests of bravery, strategy, and sacrifice, the series highlights their pivotal roles in shaping the fate of their world. Through intense action sequences and deep character development, \"Warrior’s End\" explores the essence of heroism and the enduring impact of those who fight for honor and freedom. Each episode unveils the final chapters of epic sagas, celebrating the courage and legacy of those who determined the course of history. 🌄🔥🛡️',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_warriors_end_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-warriors-end'),
(16,NULL,NULL,'S1 Tides of War','s1_tides_of_war_thumb.png',11,'YouTube','https://youtu.be/Cg8sbRFS3zU?si=lB_55d61yMCtZ1bx','free',1,NULL,'🔥 \"Tides of War\" unravels the turning points of history’s most critical battles, where strategy, technology, and sheer willpower shape the outcome of empires and civilizations. 🌍⚔️','\"Tides of War\" captures the ebb and flow of monumental military campaigns that have reshaped the course of history. The series focuses on critical moments when innovation, leadership, and determination collide in the face of overwhelming odds. As armies clash and powerful technologies are unleashed, heroes rise from the chaos, forging new paths and legacies. Whether in the heat of modern warfare or amidst futuristic apocalyptic threats, \"Tides of War\" examines the high stakes, the human cost, and the lasting impact of these pivotal battles. 🌍⚔️🔥🛡️',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_tides_of_war_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-tides-of-war'),
(17,NULL,NULL,'S1 Into the Abyss','s1_into_the_abyss_thumb.png',12,'YouTube','https://youtu.be/rcsMELh_3TA?si=lvKpb3FsVt7_-SEZ','paid',1,1,'The team descends into the Earth’s core, unveiling ancient secrets and battling unknown forces in their quest to unlock the mysteries of the planet\'s inner depths. 🌋🌪️','\"Into the Abyss,\" kicks off the thrilling adventure as a team of expert geologists, archaeologists, and military personnel dive into the unknown, heading deep into the Earth\'s core. What they discover beneath the surface challenges everything they thought they knew about human history. As they journey through vast underground caverns and encounter remnants of lost civilizations, they also find themselves in the crosshairs of a hidden empire determined to protect its ancient secrets. The deeper they go, the higher the stakes become, as the team must not only survive the physical dangers of the subterranean world but also unravel the mysteries that could alter the fate of humankind. This season is filled with relentless action, high stakes, and breathtaking discoveries. 🌍🛡️💥',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_into_the_abyss_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-into-the-abyss'),
(18,NULL,NULL,'S1 Blades of Espionage','s1_blades_of_espionage_thumb.png',13,'YouTube','https://youtu.be/dKkT8_RGDYg?si=4gdepK-sTlGcxcPw','paid',1,3,'A former special ops agent-turned-barber is pulled back into the world of espionage, where each haircut unravels a dangerous web of secrets and spies. ✂️💈🕵️‍♂️💥','Cutting Edge: Blades of Espionage follows Ethan, a once-decorated special ops agent who now leads a quiet life as a barber. However, his shop is a front for high-stakes international intrigue, as his clients range from spies to assassins, all bringing their secrets to his chair. When a new threat arises, Ethan is pulled back into the world of covert missions, forced to wield his blade both for hair and for survival. Balancing his dual identities, Ethan navigates a dangerous game where every snip of the scissors could be his last. This action-packed series combines sharp wit, intense drama, and stylish espionage. ✂️🕵️‍♂️💥',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_blades_of_espionage_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-blades-of-espionage'),
(19,NULL,NULL,'S2 The Cutthroat Mission','s2_the_cutthroat_mission_thumb.png',13,'YouTube','https://youtu.be/-Qv6p6pTz5I?si=aeaLICb9s9VAgl4W','paid',1,3,'Ethan, a former agent turned barber, is dragged back into the deadly world of espionage, where every haircut holds a secret and every enemy lurks in the shadows. 💈✂️🕵️‍♂️','In the first series, \"Snip & Spy: The Razor\'s Edge,\" Ethan\'s quiet life as a barber is shattered when his past comes back to haunt him. His once-thriving salon becomes the center of a high-stakes operation involving covert agents, hidden microchips, and an old nemesis intent on destroying him. Forced to rely on his barber tools and combat skills, Ethan must outwit dangerous enemies, protect his clients, and solve a mystery that leads him deep into the world of espionage. Packed with adrenaline-pumping action, clever humor, and a unique mix of barbershop charm and spy drama, \"The Razor\'s Edge\" will keep viewers on the edge of their seats. ✂️💣⚔️',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s2_the_cutthroat_mission_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s2-the-cutthroat-mission'),
(20,NULL,NULL,'S1 Mending Tides','s1_mending_tides_thumb.png',14,'YouTube','https://youtu.be/5eQKOr6sFgk?si=aGYzXoiBPFTf1XtA','free',1,NULL,'Three estranged sisters embark on a transformative road trip along the Pacific Coast, mending broken family bonds as they confront their troubled past. 🚗💔🌊','In Mending Tides, June Stevenson leads her estranged sisters on an unforgettable road trip along the Pacific Coast, determined to reconcile with their difficult father and heal old wounds. As they navigate breathtaking landscapes, lively pit stops, and the emotional currents of their past, the sisters begin to uncover hidden truths about their fractured family. Through laughter, heartache, and unexpected adventures, they realize that the journey toward forgiveness may be as important as the destination. Mending Tides is an inspiring tale of sisterhood, healing, and the courage to face one\'s past. 🌊💞🌅',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_mending_tides_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-mending-tides'),
(21,NULL,NULL,'S1 The McDoll Chronicles','s1_the_mcdoll_chronicles_thumb.png',15,'YouTube','https://youtu.be/X0K5cA2hS6g?si=dCiATYDWrJmKK86q','free',1,NULL,'Follow the uproarious journey of David McDoll as he navigates the chaos of inheriting six lively grandchildren, discovering the true meaning of family amidst the hilarity. 🏠👨‍👩‍👧‍👦🤣','The McDoll Chronicles takes you on a side-splitting journey with David McDoll, a wealthy and self-indulgent man whose life is turned upside down when he suddenly becomes the guardian of his six boisterous grandchildren. As his extravagant lifestyle collides with the rambunctious energy of his new family members, David faces a whirlwind of comedic escapades and heartfelt moments. Through chaotic family dinners, wild adventures, and touching revelations, David learns the true value of family and finds joy in the mayhem. This series is a heartwarming and hilarious exploration of how unexpected changes can lead to the most rewarding experiences. 🏰💖😂',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_the_mcdoll_chronicles_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-the-mcdoll-chronicles'),
(22,NULL,NULL,'S1 Secrets Beneath the Surface','s1_secrets_beneath_the_surface_thumb.png',16,'YouTube','https://youtu.be/qfyF0HmRv_0?si=s27BZDReq7BD4f7M','paid',1,1,'As their romance grows, both must face their hidden pasts and unravel the mysteries that bind them, learning that love requires trust and vulnerability. 🗝️❤️🌹','In \"Secrets Beneath the Surface\", the first season of \"Enigma of the Heart\", the focus is on the deepening relationship between the playboy journalist and the enigmatic model. Their love begins with intrigue and attraction but soon evolves into something more profound as both of them are forced to confront the secrets they’ve been hiding. As their worlds collide, they must navigate the emotional and moral complexities of their double lives, learning that trust and vulnerability are key to unlocking true love. Along the way, they discover that love is not just about passion—it’s about embracing one’s flaws and finding redemption through the power of connection. 🗝️❤️🌹',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_secrets_beneath_the_surface_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-secrets-beneath-the-surface'),
(23,NULL,NULL,'S1 The Haunting of Blackthorn Manor','s1_the_haunting_of_blackthorn_manor_thumb.png',17,'YouTube','https://youtu.be/UEJuNHOd8Dw?si=xMwHr2S-WM2Aautr','paid',1,1,'Father James returns to Blackthorn Manor, where he must face terrifying spirits and his deepest fears in a fight for his soul. 👻🏚️','\"The Haunting of Blackthorn Manor\" kicks off with Father James returning to the eerie mansion that haunts his memories. The season focuses on James’ night in Blackthorn Manor, where the spirits of the girl and her stepfather torment him, forcing him to confront the tragedy he could not prevent. Each episode deepens the psychological tension as James battles to keep his sanity while uncovering the truth about the mansion\'s dark history. As the supernatural forces grow stronger, so too does his need for redemption, but the path is fraught with danger and terror. This season blends supernatural thrills with intense emotional drama as Father James seeks salvation in the face of overwhelming darkness. 👻🏚️🕯️',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_the_haunting_of_blackthorn_manor_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-the-haunting-of-blackthorn-manor'),
(24,NULL,NULL,'S1 Roots and Revelations','s1_roots_and_revelations_thumb.png',18,'YouTube','https://youtu.be/7lSzGK5HR1M?si=ltOK7kx6m3IIWv2b','free',1,NULL,'The main character begins his comedic journey of cultural discovery, leading to laugh-out-loud clashes between his upbringing and newfound understanding of his heritage. 👪🎭','The first season of \"Heritage Hijinks,\" titled \"Roots and Revelations,\" takes viewers on a rollercoaster ride through the life of the main character as he seeks to reconnect with his African American roots while navigating the humorous differences between his liberal white upbringing and the cultural identity he\'s discovering. With his quirky best friend by his side, every family dinner turns into a comedy show of contrasting beliefs, while each new experience brings both laughter and deeper self-awareness. As their cultural explorations continue, this season sets the tone for a series full of heart, humor, and acceptance. 🎉🌍👫',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_roots_and_revelations_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-roots-and-revelations'),
(25,NULL,NULL,'S1 The Unleashing','s1_the_unleashing_thumb.png',19,'YouTube','https://youtu.be/j2Fec39AHJ8?si=c9WEIe5NXoF_tmrE','free',1,NULL,'A cursed relic releases terrifying demons upon an unsuspecting city. A group of survivors must fight to survive as evil forces threaten to consume them. 🏙️👹','\"Evil Awakening\" titled \"The Unleashing,\" a group of young adults inadvertently awakens ancient, flesh-hungry demons by uncovering the cursed Necronomicon. Moving from the deep woods to the sprawling cityscape, the horrors quickly spread, turning their once-familiar environment into a nightmare. Two estranged sisters, reunited in the face of terror, must put aside their differences and team up with others to survive the rise of the demons. The season escalates into a series of terrifying confrontations, as they are hunted by the most horrifying incarnation of evil imaginable. From haunted buildings to nightmarish alleyways, \"The Unleashing\" will keep viewers on edge as the group battles to break the curse and prevent the total destruction of their world. 😨📖',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_the_unleashing_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-the-unleashing'),
(26,NULL,NULL,'S1 The Reckoning Retreat','s1_the_reckoning_retreat_thumb.png',20,'YouTube','https://youtu.be/bvDArsKoTOE?si=bfxIZyuVGNqpdu81','free',1,NULL,'A peaceful cabin retreat for four friends spirals into a suspense-filled nightmare when they discover something sinister lurking in the woods. 🌲👻','\"The Reckoning Retreat\", four old friends—Esme, Hannah, Ben, and Shan—attempt to reconnect during a weekend getaway at a secluded cabin. Their hopes for peace and bonding are quickly dashed when they discover they are not alone. As unsettling events unfold, the group\'s old wounds resurface, and deep-seated secrets emerge. The quiet wilderness turns into a dark, foreboding setting as they realize something—or someone—is watching them. Each episode escalates the tension as the friends confront both the external threat and their inner demons. Survival becomes paramount as they uncover the truth about the sinister force stalking them. 😱🌲🔍',NULL,NULL,NULL,'2026-02-18 08:17:58','2026-02-18 08:17:58',NULL,'s1_the_reckoning_retreat_thumb.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'s1-the-reckoning-retreat');
/*!40000 ALTER TABLE `seasons` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `seo`
--

DROP TABLE IF EXISTS `seo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `seo` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `meta_title` varchar(191) DEFAULT NULL,
  `meta_keywords` varchar(191) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `seo_image` varchar(191) DEFAULT NULL,
  `google_site_verification` varchar(191) DEFAULT NULL,
  `canonical_url` varchar(191) DEFAULT NULL,
  `short_description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seo`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `seo` WRITE;
/*!40000 ALTER TABLE `seo` DISABLE KEYS */;
/*!40000 ALTER TABLE `seo` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `service_providers`
--

DROP TABLE IF EXISTS `service_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_providers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `payment_method` varchar(191) DEFAULT NULL,
  `manager_id` bigint(20) unsigned DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `contact_email` text NOT NULL,
  `contact_number` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_providers`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `service_providers` WRITE;
/*!40000 ALTER TABLE `service_providers` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_providers` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(191) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES
('IjAGLPFLRQWIgkN8fG4M74ER7aGOQjENCpBRgq9c',15,'103.175.134.177','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiWUJNQlE1bDdtTUY0WFA0anJ6SGxmUFdPeU9waERSa1lWOGhqZ1dCaiI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjExNzoiaHR0cHM6Ly9hcGV4cHJpbWV0di5jb20vYXBwL21lZGlhLWxpYnJhcnkvZ2V0LWZvbGRlci1jb250ZW50cz9fdD0xNzcxNzkyMjE2Njc0JmZvbGRlcj1sb2dvcyUyRmltYWdlJmxpbWl0PTYwJm9mZnNldD0wIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTU7fQ==',1771792218);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `setting`
--

DROP TABLE IF EXISTS `setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `setting` WRITE;
/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `setting` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) DEFAULT NULL,
  `val` text DEFAULT NULL,
  `type` varchar(90) NOT NULL DEFAULT 'string',
  `datatype` varchar(90) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES
(1,'movie','1','module_settings',NULL,2,2,NULL,'2024-08-08 05:27:31','2024-08-08 05:27:31',NULL),
(2,'tvshow','1','module_settings',NULL,2,2,NULL,'2024-08-08 05:27:31','2024-08-08 05:27:31',NULL),
(3,'livetv','1','module_settings',NULL,2,2,NULL,'2024-08-08 05:27:31','2024-08-08 05:27:31',NULL),
(4,'video','1','module_settings',NULL,2,2,NULL,'2024-08-08 05:27:31','2024-08-08 05:27:31',NULL),
(5,'enable_tmdb_api','1','module_settings',NULL,2,2,NULL,'2024-08-08 05:27:31','2024-08-08 05:27:31',NULL),
(6,'app_name','ApexPrime TV','bussiness','bussiness',2,15,NULL,'2024-08-08 10:12:31','2026-03-03 19:45:07',NULL),
(7,'user_app_name','Streamit: Your Ultimate Entertainment Hub','bussiness','bussiness',2,2,NULL,'2024-08-08 10:12:31','2024-08-08 10:12:31',NULL),
(8,'helpline_number','+15265897485','bussiness','bussiness',2,15,NULL,'2024-08-08 10:12:31','2026-03-03 19:45:07',NULL),
(9,'inquriy_email','hello@apexprimetv.com','bussiness','bussiness',2,15,NULL,'2024-08-08 10:12:31','2026-03-03 19:45:07',NULL),
(10,'short_description','Ap','bussiness','bussiness',2,15,NULL,'2024-08-08 10:12:31','2026-03-03 19:45:07',NULL),
(11,'google_analytics','Google Analytics','text','misc',2,2,NULL,'2024-08-08 10:31:01','2024-08-08 10:31:01',NULL),
(12,'default_language','en','misc','misc',2,2,NULL,'2024-08-08 10:31:01','2024-08-08 10:31:01',NULL),
(13,'default_time_zone','Asia/Kolkata','misc','misc',2,2,NULL,'2024-08-08 10:31:01','2024-08-08 10:31:01',NULL),
(14,'disc_type','local','misc','misc',2,2,NULL,'2024-08-08 10:31:01','2024-08-08 10:31:01',NULL),
(15,'cash_payment_method','1','cashpayment',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(16,'razor_payment_method','1','razorpayPayment',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(17,'razorpay_secretkey','','razor_payment_method',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(18,'razorpay_publickey','','razor_payment_method',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(19,'str_payment_method','1','stripePayment',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(20,'stripe_secretkey','','str_payment_method',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(21,'stripe_publickey','','str_payment_method',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(22,'paystack_payment_method','1','paystackPayment',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(23,'paystack_secretkey','','paystack_payment_method',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(24,'paystack_publickey','','paystack_payment_method',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(25,'paypal_payment_method','1','paypalPayment',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(26,'paypal_secretkey','','paypal_payment_method',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(27,'paypal_clientid','','paypal_payment_method',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(28,'flutterwave_payment_method','1','flutterwavePayment',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(29,'flutterwave_secretkey','','flutterwave_payment_method',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(30,'flutterwave_publickey','','flutterwave_payment_method',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(31,'cinet_payment_method','0','paymentcinet',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(32,'sadad_payment_method','0','paymentsadad',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(33,'airtel_payment_method','0','airtelpayment',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(34,'phonepe_payment_method','0','phonepepayment',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(35,'midtrans_payment_method','0','midtranspayment',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(36,'local','1','storageconfig','storage_settings',2,15,NULL,'2024-08-08 10:38:37','2026-02-18 14:25:45',NULL),
(37,'s3','0','storageconfig','storage_settings',2,15,NULL,'2024-08-08 10:38:37','2026-02-18 14:25:45',NULL),
(38,'aws_access_key',NULL,'storageconfig','storage_settings',2,15,NULL,'2024-08-08 10:38:37','2026-02-18 14:25:45',NULL),
(39,'aws_secret_key',NULL,'storageconfig','storage_settings',2,15,NULL,'2024-08-08 10:38:37','2026-02-18 14:25:45',NULL),
(40,'aws_region',NULL,'storageconfig','storage_settings',2,15,NULL,'2024-08-08 10:38:37','2026-02-18 14:25:45',NULL),
(41,'aws_bucket',NULL,'storageconfig','storage_settings',2,15,NULL,'2024-08-08 10:38:37','2026-02-18 14:25:45',NULL),
(42,'tmdb_api_key','49d0b74ed0fd341920bbb79400020be0','module_settings',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(43,'is_social_login','1','','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(44,'is_google_login','1','','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(45,'is_otp_login','1','','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(46,'is_apple_login','1','appconfig',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(47,'is_firebase_notification','1','','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(48,'firebase_key',NULL,'','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(49,'is_user_push_notification','1','','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(50,'is_application_link','1','','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(51,'ios_url','https://apps.apple.com/us/app/streamit-laravel/id6736365806','','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(52,'android_url','https://play.google.com/store/apps/details?id=com.iqonic.streamitlaravel&pcampaignid=web_share','','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(53,'force_update','0','','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(54,'app_version',NULL,'appconfig',NULL,2,2,NULL,'2024-08-08 10:38:37','2024-08-08 10:38:37',NULL),
(55,'is_ChatGPT_integration','1','','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(56,'ChatGPT_key',NULL,'','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(57,'google_client_id',NULL,'','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(58,'google_client_secret',NULL,'','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(59,'google_redirect_uri',NULL,'','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(62,'databaseURL','https://apexprime-ott-default-rtdb.firebaseio.com','','appconfig',2,15,NULL,'2024-08-08 10:38:37','2026-06-08 12:32:30',NULL),
(68,'demo_login','1','module_settings',NULL,1,1,NULL,'2024-08-08 05:27:31','2024-08-08 05:27:31',NULL),
(69,'facebook_url','https://www.facebook.com/iqonicdesign','bussiness','bussiness',2,15,NULL,'2024-08-08 10:12:31','2026-03-03 19:45:07',NULL),
(70,'x_url','https://twitter.com/iqonicdesign','bussiness','bussiness',2,15,NULL,'2024-08-08 10:12:31','2026-03-03 19:45:07',NULL),
(71,'instagram_url','https://www.instagram.com/iqonicdesign','bussiness','bussiness',2,15,NULL,'2024-08-08 10:12:31','2026-03-03 19:45:07',NULL),
(72,'youtube_url','https://www.youtube.com/c/IqonicDesign','bussiness','bussiness',2,15,NULL,'2024-08-08 10:12:31','2026-03-03 19:45:07',NULL),
(73,'backward_seconds','10','misc','misc',2,2,NULL,'2024-08-08 10:31:01','2024-08-08 10:31:01',NULL),
(74,'forward_seconds','10','misc','misc',2,2,NULL,'2024-08-08 10:31:01','2024-08-08 10:31:01',NULL),
(75,'mini_logo','https://apexprimetv.com/storage/logos/image/icon_512_maskable_69a73a92f3e45.png','bussiness','string',2,15,NULL,'2024-08-08 10:31:01','2026-03-03 19:46:44',NULL),
(76,'dark_logo','https://apexprimetv.com/storage/logos/image/applogotop_69a3a818dc114.png','bussiness','string',2,15,NULL,'2024-08-08 10:31:01','2026-03-03 19:45:07',NULL),
(77,'loader_gif','https://apexprimetv.com/storage/logos/image/9_x_16_re_69a42cad3e520.gif','bussiness','string',2,15,NULL,'2024-08-08 10:31:01','2026-03-03 19:46:44',NULL),
(78,'favicon','https://apexprimetv.com/storage/logos/image/icon_512_maskable_69a73a92f3e45.png','bussiness','string',2,15,NULL,'2024-08-08 10:31:01','2026-03-03 19:47:01',NULL),
(79,'loader_gif_remove','0','','string',15,15,NULL,'2026-02-18 13:07:01','2026-03-03 19:47:44',NULL),
(80,'copyright_text','© 2026 Varchaswaa International Pvt Ltd. All rights reserved.','','string',15,15,NULL,'2026-02-18 13:07:01','2026-03-03 19:47:44',NULL),
(81,'bunny','0','storage_settings','storageconfig',15,15,NULL,'2026-02-18 14:25:45','2026-02-18 14:25:45',NULL),
(82,'aws_path_style','false','storage_settings','storageconfig',15,15,NULL,'2026-02-18 14:25:45','2026-02-18 14:25:45',NULL),
(83,'bunny_storage_zone',NULL,'storage_settings','storageconfig',15,15,NULL,'2026-02-18 14:25:45','2026-02-18 14:25:45',NULL),
(84,'bunny_api_key',NULL,'storage_settings','storageconfig',15,15,NULL,'2026-02-18 14:25:45','2026-02-18 14:25:45',NULL),
(85,'bunny_cdn_url',NULL,'storage_settings','storageconfig',15,15,NULL,'2026-02-18 14:25:45','2026-02-18 14:25:45',NULL),
(86,'bunny_region',NULL,'storage_settings','storageconfig',15,15,NULL,'2026-02-18 14:25:45','2026-02-18 14:25:45',NULL),
(87,'bunny_stream_api_key',NULL,'storage_settings','storageconfig',15,15,NULL,'2026-02-18 14:25:45','2026-02-18 14:25:45',NULL),
(88,'bunny_video_key',NULL,'storage_settings','storageconfig',15,15,NULL,'2026-02-18 14:25:45','2026-02-18 14:25:45',NULL),
(89,'bunny_cdn_hostname',NULL,'storage_settings','storageconfig',15,15,NULL,'2026-02-18 14:25:45','2026-02-18 14:25:45',NULL),
(90,'bunny_stream_pull_zone',NULL,'storage_settings','storageconfig',15,15,NULL,'2026-02-18 14:25:45','2026-02-18 14:25:45',NULL),
(91,'music','1','string',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(92,'shorts','1','string',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(93,'apiKey','AIzaSyC6TtlXCSgIGvamfpH3BYIlUcg1jGUFoS8','','appconfig',NULL,15,NULL,'2026-06-08 12:23:12','2026-06-08 12:32:30',NULL),
(94,'authDomain','apexprime-ott.firebaseapp.com','','appconfig',NULL,15,NULL,'2026-06-08 12:23:12','2026-06-08 12:32:30',NULL),
(95,'projectId','apexprime-ott','','appconfig',NULL,15,NULL,'2026-06-08 12:23:12','2026-06-08 12:32:30',NULL),
(96,'storageBucket','apexprime-ott.firebasestorage.app','','appconfig',NULL,15,NULL,'2026-06-08 12:23:12','2026-06-08 12:32:30',NULL),
(97,'messagingSenderId','903667670865','','appconfig',NULL,15,NULL,'2026-06-08 12:23:12','2026-06-08 12:32:30',NULL),
(98,'appId','1:903667670865:web:bb2f213a5dcb1998c53d70','','appconfig',NULL,15,NULL,'2026-06-08 12:23:12','2026-06-08 12:32:30',NULL),
(99,'measurementId','G-5BK85Q5K6E','','appconfig',NULL,15,NULL,'2026-06-08 12:23:12','2026-06-08 12:32:30',NULL),
(100,'android_tv_url',NULL,'','appconfig',15,15,NULL,'2026-06-08 12:32:18','2026-06-08 12:32:30',NULL),
(101,'banner_ad_id',NULL,'','appconfig',15,15,NULL,'2026-06-08 12:32:18','2026-06-08 12:32:30',NULL),
(102,'ios_banner_id',NULL,'','appconfig',15,15,NULL,'2026-06-08 12:32:18','2026-06-08 12:32:30',NULL),
(103,'mobile_app','0','','appconfig',15,15,NULL,'2026-06-08 12:32:18','2026-06-08 12:32:30',NULL),
(104,'android_minimum_required_version',NULL,'','appconfig',15,15,NULL,'2026-06-08 12:32:18','2026-06-08 12:32:30',NULL),
(105,'android_latest_version',NULL,'','appconfig',15,15,NULL,'2026-06-08 12:32:18','2026-06-08 12:32:30',NULL),
(106,'ios_minimum_required_version',NULL,'','appconfig',15,15,NULL,'2026-06-08 12:32:18','2026-06-08 12:32:30',NULL),
(107,'ios_latest_version',NULL,'','appconfig',15,15,NULL,'2026-06-08 12:32:18','2026-06-08 12:32:30',NULL),
(108,'tv_app','0','','appconfig',15,15,NULL,'2026-06-08 12:32:18','2026-06-08 12:32:30',NULL),
(109,'android_tv_minimum_required_version',NULL,'','appconfig',15,15,NULL,'2026-06-08 12:32:18','2026-06-08 12:32:30',NULL),
(110,'android_tv_latest_version',NULL,'','appconfig',15,15,NULL,'2026-06-08 12:32:18','2026-06-08 12:32:30',NULL);
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `shorts`
--

DROP TABLE IF EXISTS `shorts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `shorts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `uuid` char(36) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `file_url` longtext DEFAULT NULL,
  `file_format` varchar(191) DEFAULT 'mp4',
  `file_size` bigint(20) DEFAULT NULL,
  `bitrate` varchar(191) DEFAULT NULL,
  `codec` varchar(191) DEFAULT NULL,
  `width` int(11) DEFAULT 1080,
  `height` int(11) DEFAULT 1920,
  `aspect_ratio` varchar(191) DEFAULT '9:16',
  `frame_rate` varchar(191) DEFAULT '30',
  `thumbnail_url` longtext DEFAULT NULL,
  `preview_url` longtext DEFAULT NULL,
  `subtitles` longtext DEFAULT NULL,
  `captions` longtext DEFAULT NULL,
  `source_type` enum('upload','youtube','vimeo','external') DEFAULT 'upload',
  `youtube_id` varchar(191) DEFAULT NULL,
  `youtube_url` longtext DEFAULT NULL,
  `vimeo_id` varchar(191) DEFAULT NULL,
  `external_url` longtext DEFAULT NULL,
  `category_id` bigint(20) unsigned DEFAULT NULL,
  `tags` longtext DEFAULT NULL,
  `content_rating` varchar(191) DEFAULT 'G',
  `is_explicit` tinyint(1) DEFAULT 0,
  `is_featured` tinyint(1) DEFAULT 0,
  `is_trending` tinyint(1) DEFAULT 0,
  `is_premium` tinyint(1) DEFAULT 0,
  `is_verified` tinyint(1) DEFAULT 0,
  `allow_comments` tinyint(1) DEFAULT 1,
  `allow_likes` tinyint(1) DEFAULT 1,
  `allow_shares` tinyint(1) DEFAULT 1,
  `allow_download` tinyint(1) DEFAULT 0,
  `allow_duets` tinyint(1) DEFAULT 1,
  `allow_stitches` tinyint(1) DEFAULT 1,
  `view_count` bigint(20) unsigned DEFAULT 0,
  `like_count` bigint(20) unsigned DEFAULT 0,
  `comment_count` bigint(20) unsigned DEFAULT 0,
  `share_count` bigint(20) unsigned DEFAULT 0,
  `download_count` bigint(20) unsigned DEFAULT 0,
  `duet_count` bigint(20) unsigned DEFAULT 0,
  `stitch_count` bigint(20) unsigned DEFAULT 0,
  `rating` decimal(3,2) DEFAULT NULL,
  `rating_count` int(10) unsigned DEFAULT 0,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `creator_name` varchar(191) DEFAULT NULL,
  `creator_handle` varchar(191) DEFAULT NULL,
  `is_monetized` tinyint(1) DEFAULT 0,
  `revenue` decimal(10,2) DEFAULT 0.00,
  `status` tinyint(1) DEFAULT 1,
  `published_at` timestamp NULL DEFAULT NULL,
  `scheduled_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `idx_title` (`title`),
  KEY `idx_source_type` (`source_type`),
  KEY `idx_is_featured` (`is_featured`),
  KEY `idx_is_trending` (`is_trending`),
  KEY `idx_view_count` (`view_count`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_source_status` (`source_type`,`status`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_user_status` (`user_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shorts`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `shorts` WRITE;
/*!40000 ALTER TABLE `shorts` DISABLE KEYS */;
INSERT INTO `shorts` VALUES
(1,'Quick Dance Moves','quick-dance-moves',NULL,'Learn 5 easy dance moves in 30 seconds',30,NULL,'mp4',NULL,'5000kbps','h264',1080,1920,'9:16','30',NULL,NULL,NULL,NULL,'upload',NULL,NULL,NULL,NULL,NULL,NULL,'G',0,1,1,0,0,1,1,1,0,1,1,2500,450,89,123,0,45,67,4.50,234,1,'Dance Master','@dancemaster',0,0.00,1,NULL,NULL,1,1,NULL,'2026-02-27 21:06:53','2026-02-27 21:06:53'),
(2,'Cooking Hack','cooking-hack',NULL,'Amazing kitchen hack you never knew about',45,NULL,'mp4',NULL,'5000kbps','h264',1080,1920,'9:16','30',NULL,NULL,NULL,NULL,'upload',NULL,NULL,NULL,NULL,NULL,NULL,'G',0,1,0,0,0,1,1,1,0,0,0,1800,320,156,234,0,0,0,4.70,189,1,'Chef Pro','@chefpro',0,0.00,1,NULL,NULL,1,1,NULL,'2026-02-27 21:06:53','2026-02-27 21:06:53'),
(3,'Fitness Challenge','fitness-challenge',NULL,'10 minute full body workout challenge',600,NULL,'mp4',NULL,'8000kbps','h265',1080,1920,'9:16','30',NULL,NULL,NULL,NULL,'upload',NULL,NULL,NULL,NULL,NULL,NULL,'G',0,0,1,0,0,1,1,1,0,1,1,3200,680,234,456,0,89,123,4.80,312,1,'Fitness Coach','@fitnessguru',0,0.00,1,NULL,NULL,1,1,NULL,'2026-02-27 21:06:53','2026-02-27 21:06:53'),
(4,'Travel Vlog','travel-vlog',NULL,'Exploring hidden gems in the city',120,NULL,'mp4',NULL,'6000kbps','h264',1080,1920,'9:16','24',NULL,NULL,NULL,NULL,'upload',NULL,NULL,NULL,NULL,NULL,NULL,'PG',0,1,1,0,0,1,1,1,0,0,0,1500,290,78,145,0,0,0,4.60,198,1,'Travel Vlogger','@travelvlogger',0,0.00,1,NULL,NULL,1,1,NULL,'2026-02-27 21:06:53','2026-02-27 21:06:53'),
(5,'Pet Moments','pet-moments',NULL,'Cute and funny pet videos compilation',60,NULL,'mp4',NULL,'5000kbps','h264',1080,1920,'9:16','30',NULL,NULL,NULL,NULL,'upload',NULL,NULL,NULL,NULL,NULL,NULL,'G',0,0,0,0,0,1,1,1,0,1,1,4100,950,412,678,0,234,156,4.90,567,1,'Pet Lover','@petlover',0,0.00,1,NULL,NULL,1,1,NULL,'2026-02-27 21:06:53','2026-02-27 21:06:53');
/*!40000 ALTER TABLE `shorts` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `shorts_categories`
--

DROP TABLE IF EXISTS `shorts_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `shorts_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(191) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `shorts_categories_name_unique` (`name`),
  UNIQUE KEY `shorts_categories_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shorts_categories`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `shorts_categories` WRITE;
/*!40000 ALTER TABLE `shorts_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `shorts_categories` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `shorts_engagement`
--

DROP TABLE IF EXISTS `shorts_engagement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `shorts_engagement` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `short_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `engagement_type` enum('like','share','comment','view') NOT NULL,
  `comment_text` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shorts_engagement`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `shorts_engagement` WRITE;
/*!40000 ALTER TABLE `shorts_engagement` DISABLE KEYS */;
/*!40000 ALTER TABLE `shorts_engagement` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `states` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `country_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `plan_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `status` varchar(191) DEFAULT NULL,
  `is_manual` tinyint(1) NOT NULL DEFAULT 0,
  `amount` double DEFAULT NULL,
  `discount_percentage` double DEFAULT NULL,
  `tax_amount` double DEFAULT NULL,
  `coupon_discount` double DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `identifier` varchar(191) DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `level` bigint(20) NOT NULL DEFAULT 0,
  `plan_type` longtext DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `device_id` varchar(191) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
INSERT INTO `subscriptions` VALUES
(1,2,14,'2026-01-20 00:00:00','2026-02-20 00:00:00','active',0,20,NULL,0,NULL,20,'Premium Plan','premium_plan','month',1,2,'[{\"id\":1,\"planlimitation_id\":1,\"limitation_title\":\"Video Cast\",\"limitation_value\":1,\"limit\":null,\"slug\":\"video-cast\",\"status\":1,\"message\":\"Cast videos to your TV with ease.\"},{\"id\":2,\"planlimitation_id\":2,\"limitation_title\":\"Ads\",\"limitation_value\":1,\"limit\":null,\"slug\":\"ads\",\"status\":1,\"message\":\"This plan includes ads.\"},{\"id\":3,\"planlimitation_id\":3,\"limitation_title\":\"Device Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"1\"},\"slug\":\"device-limit\",\"status\":1,\"message\":\"Stream on up to 1 devices simultaneously.\"},{\"id\":4,\"planlimitation_id\":4,\"limitation_title\":\"Download Status\",\"limitation_value\":1,\"limit\":{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":0,\"2K\":0,\"4K\":0,\"8K\":0},\"slug\":\"download-status\",\"status\":1,\"message\":\"Enjoy unlimited downloads with this plan.\"},{\"id\":17,\"planlimitation_id\":5,\"limitation_title\":\"Supported Device Type\",\"limitation_value\":1,\"limit\":{\"tablet\":\"0\",\"laptop\":\"0\",\"mobile\":\"1\"},\"slug\":\"supported-device-type\",\"status\":1,\"message\":null},{\"id\":18,\"planlimitation_id\":6,\"limitation_title\":\"Profile Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"2\"},\"slug\":\"profile-limit\",\"status\":1,\"message\":null}]',8,'5',NULL,NULL,NULL,NULL,'2026-01-20 00:00:00','2026-01-20 00:00:00'),
(2,2,5,'2025-11-24 00:00:00','2025-12-24 00:00:00','inactive',0,20,NULL,0,NULL,20,'Premium Plan','premium_plan','month',1,2,'[{\"id\":1,\"planlimitation_id\":1,\"limitation_title\":\"Video Cast\",\"limitation_value\":1,\"limit\":null,\"slug\":\"video-cast\",\"status\":1,\"message\":\"Cast videos to your TV with ease.\"},{\"id\":2,\"planlimitation_id\":2,\"limitation_title\":\"Ads\",\"limitation_value\":1,\"limit\":null,\"slug\":\"ads\",\"status\":1,\"message\":\"This plan includes ads.\"},{\"id\":3,\"planlimitation_id\":3,\"limitation_title\":\"Device Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"1\"},\"slug\":\"device-limit\",\"status\":1,\"message\":\"Stream on up to 1 devices simultaneously.\"},{\"id\":4,\"planlimitation_id\":4,\"limitation_title\":\"Download Status\",\"limitation_value\":1,\"limit\":{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":0,\"2K\":0,\"4K\":0,\"8K\":0},\"slug\":\"download-status\",\"status\":1,\"message\":\"Enjoy unlimited downloads with this plan.\"},{\"id\":17,\"planlimitation_id\":5,\"limitation_title\":\"Supported Device Type\",\"limitation_value\":1,\"limit\":{\"tablet\":\"0\",\"laptop\":\"0\",\"mobile\":\"1\"},\"slug\":\"supported-device-type\",\"status\":1,\"message\":null},{\"id\":18,\"planlimitation_id\":6,\"limitation_title\":\"Profile Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"2\"},\"slug\":\"profile-limit\",\"status\":1,\"message\":null}]',3,'3',NULL,NULL,NULL,NULL,'2025-11-24 00:00:00','2025-11-24 00:00:00'),
(3,3,3,'2026-01-19 00:00:00','2026-04-19 00:00:00','active',0,50,NULL,0,NULL,50,'Ultimate Plan','ultimate_plan','month',3,3,'[{\"id\":9,\"planlimitation_id\":1,\"limitation_title\":\"Video Cast\",\"limitation_value\":1,\"limit\":null,\"slug\":\"video-cast\",\"status\":1,\"message\":\"Cast videos to your TV with ease.\"},{\"id\":10,\"planlimitation_id\":2,\"limitation_title\":\"Ads\",\"limitation_value\":0,\"limit\":null,\"slug\":\"ads\",\"status\":1,\"message\":\"Ad-free streaming with this plan.\"},{\"id\":11,\"planlimitation_id\":3,\"limitation_title\":\"Device Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"5\"},\"slug\":\"device-limit\",\"status\":1,\"message\":\"Stream on up to 5 devices simultaneously.\"},{\"id\":12,\"planlimitation_id\":4,\"limitation_title\":\"Download Status\",\"limitation_value\":1,\"limit\":{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":1,\"2K\":1,\"4K\":0,\"8K\":0},\"slug\":\"download-status\",\"status\":1,\"message\":\"Enjoy unlimited downloads with this plan.\"},{\"id\":21,\"planlimitation_id\":5,\"limitation_title\":\"Supported Device Type\",\"limitation_value\":1,\"limit\":{\"tablet\":\"0\",\"laptop\":\"1\",\"mobile\":\"1\"},\"slug\":\"supported-device-type\",\"status\":1,\"message\":null},{\"id\":22,\"planlimitation_id\":6,\"limitation_title\":\"Profile Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"3\"},\"slug\":\"profile-limit\",\"status\":1,\"message\":null}]',1,'test11',NULL,NULL,NULL,NULL,'2026-01-19 00:00:00','2026-01-19 00:00:00'),
(4,3,6,'2025-10-24 00:00:00','2026-01-24 00:00:00','inactive',0,50,NULL,0,NULL,50,'Ultimate Plan','ultimate_plan','month',3,3,'[{\"id\":9,\"planlimitation_id\":1,\"limitation_title\":\"Video Cast\",\"limitation_value\":1,\"limit\":null,\"slug\":\"video-cast\",\"status\":1,\"message\":\"Cast videos to your TV with ease.\"},{\"id\":10,\"planlimitation_id\":2,\"limitation_title\":\"Ads\",\"limitation_value\":0,\"limit\":null,\"slug\":\"ads\",\"status\":1,\"message\":\"Ad-free streaming with this plan.\"},{\"id\":11,\"planlimitation_id\":3,\"limitation_title\":\"Device Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"5\"},\"slug\":\"device-limit\",\"status\":1,\"message\":\"Stream on up to 5 devices simultaneously.\"},{\"id\":12,\"planlimitation_id\":4,\"limitation_title\":\"Download Status\",\"limitation_value\":1,\"limit\":{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":1,\"2K\":1,\"4K\":0,\"8K\":0},\"slug\":\"download-status\",\"status\":1,\"message\":\"Enjoy unlimited downloads with this plan.\"},{\"id\":21,\"planlimitation_id\":5,\"limitation_title\":\"Supported Device Type\",\"limitation_value\":1,\"limit\":{\"tablet\":\"0\",\"laptop\":\"1\",\"mobile\":\"1\"},\"slug\":\"supported-device-type\",\"status\":1,\"message\":null},{\"id\":22,\"planlimitation_id\":6,\"limitation_title\":\"Profile Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"3\"},\"slug\":\"profile-limit\",\"status\":1,\"message\":null}]',4,'3',NULL,NULL,NULL,NULL,'2025-10-24 00:00:00','2025-10-24 00:00:00'),
(5,1,4,'2026-01-20 00:00:00','2026-02-20 00:00:00','active',0,5,NULL,0,NULL,5,'Basic','basic','month',1,1,'[{\"id\":1,\"planlimitation_id\":1,\"limitation_title\":\"Video Cast\",\"limitation_value\":1,\"limit\":null,\"slug\":\"video-cast\",\"status\":1,\"message\":\"Cast videos to your TV with ease.\"},{\"id\":2,\"planlimitation_id\":2,\"limitation_title\":\"Ads\",\"limitation_value\":1,\"limit\":null,\"slug\":\"ads\",\"status\":1,\"message\":\"This plan includes ads.\"},{\"id\":3,\"planlimitation_id\":3,\"limitation_title\":\"Device Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"1\"},\"slug\":\"device-limit\",\"status\":1,\"message\":\"Stream on up to 1 devices simultaneously.\"},{\"id\":4,\"planlimitation_id\":4,\"limitation_title\":\"Download Status\",\"limitation_value\":1,\"limit\":{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":0,\"2K\":0,\"4K\":0,\"8K\":0},\"slug\":\"download-status\",\"status\":1,\"message\":\"Enjoy unlimited downloads with this plan.\"},{\"id\":17,\"planlimitation_id\":5,\"limitation_title\":\"Supported Device Type\",\"limitation_value\":1,\"limit\":{\"tablet\":\"0\",\"laptop\":\"0\",\"mobile\":\"1\"},\"slug\":\"supported-device-type\",\"status\":1,\"message\":null},{\"id\":18,\"planlimitation_id\":6,\"limitation_title\":\"Profile Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"2\"},\"slug\":\"profile-limit\",\"status\":1,\"message\":null}]',2,'test11',NULL,NULL,NULL,NULL,'2026-01-20 00:00:00','2026-01-20 00:00:00'),
(6,1,10,'2026-01-24 00:00:00','2026-02-24 00:00:00','active',0,5,NULL,0,NULL,5,'Basic','basic','month',1,1,'[{\"id\":1,\"planlimitation_id\":1,\"limitation_title\":\"Video Cast\",\"limitation_value\":1,\"limit\":null,\"slug\":\"video-cast\",\"status\":1,\"message\":\"Cast videos to your TV with ease.\"},{\"id\":2,\"planlimitation_id\":2,\"limitation_title\":\"Ads\",\"limitation_value\":1,\"limit\":null,\"slug\":\"ads\",\"status\":1,\"message\":\"This plan includes ads.\"},{\"id\":3,\"planlimitation_id\":3,\"limitation_title\":\"Device Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"1\"},\"slug\":\"device-limit\",\"status\":1,\"message\":\"Stream on up to 1 devices simultaneously.\"},{\"id\":4,\"planlimitation_id\":4,\"limitation_title\":\"Download Status\",\"limitation_value\":1,\"limit\":{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":0,\"2K\":0,\"4K\":0,\"8K\":0},\"slug\":\"download-status\",\"status\":1,\"message\":\"Enjoy unlimited downloads with this plan.\"},{\"id\":17,\"planlimitation_id\":5,\"limitation_title\":\"Supported Device Type\",\"limitation_value\":1,\"limit\":{\"tablet\":\"0\",\"laptop\":\"0\",\"mobile\":\"1\"},\"slug\":\"supported-device-type\",\"status\":1,\"message\":null},{\"id\":18,\"planlimitation_id\":6,\"limitation_title\":\"Profile Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"2\"},\"slug\":\"profile-limit\",\"status\":1,\"message\":null}]',7,'4',NULL,NULL,NULL,NULL,'2026-01-24 00:00:00','2026-01-24 00:00:00'),
(7,4,8,'2025-02-20 00:00:00','2026-02-20 00:00:00','active',0,80,NULL,0,NULL,80,'Elite Plan','elite_plan','month',12,4,'[{\"id\":13,\"planlimitation_id\":1,\"limitation_title\":\"Video Cast\",\"limitation_value\":1,\"limit\":null,\"slug\":\"video-cast\",\"status\":1,\"message\":\"Cast videos to your TV with ease.\"},{\"id\":14,\"planlimitation_id\":2,\"limitation_title\":\"Ads\",\"limitation_value\":0,\"limit\":null,\"slug\":\"ads\",\"status\":1,\"message\":\"Ad-free streaming with this plan.\"},{\"id\":15,\"planlimitation_id\":3,\"limitation_title\":\"Device Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"8\"},\"slug\":\"device-limit\",\"status\":1,\"message\":\"Stream on up to 8 devices simultaneously.\"},{\"id\":16,\"planlimitation_id\":4,\"limitation_title\":\"Download Status\",\"limitation_value\":1,\"limit\":{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":1,\"2K\":1,\"4K\":1,\"8K\":1},\"slug\":\"download-status\",\"status\":1,\"message\":\"Enjoy unlimited downloads with this plan.\"},{\"id\":23,\"planlimitation_id\":5,\"limitation_title\":\"Supported Device Type\",\"limitation_value\":1,\"limit\":{\"tablet\":\"1\",\"laptop\":\"1\",\"mobile\":\"1\"},\"slug\":\"supported-device-type\",\"status\":1,\"message\":null},{\"id\":24,\"planlimitation_id\":6,\"limitation_title\":\"Profile Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"4\"},\"slug\":\"profile-limit\",\"status\":1,\"message\":null}]',5,'4',NULL,NULL,NULL,NULL,'2025-02-20 00:00:00','2025-02-20 00:00:00'),
(8,4,9,'2026-01-08 00:00:00','2027-01-08 00:00:00','active',0,80,NULL,0,NULL,80,'Elite Plan','elite_plan','month',12,4,'[{\"id\":13,\"planlimitation_id\":1,\"limitation_title\":\"Video Cast\",\"limitation_value\":1,\"limit\":null,\"slug\":\"video-cast\",\"status\":1,\"message\":\"Cast videos to your TV with ease.\"},{\"id\":14,\"planlimitation_id\":2,\"limitation_title\":\"Ads\",\"limitation_value\":0,\"limit\":null,\"slug\":\"ads\",\"status\":1,\"message\":\"Ad-free streaming with this plan.\"},{\"id\":15,\"planlimitation_id\":3,\"limitation_title\":\"Device Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"8\"},\"slug\":\"device-limit\",\"status\":1,\"message\":\"Stream on up to 8 devices simultaneously.\"},{\"id\":16,\"planlimitation_id\":4,\"limitation_title\":\"Download Status\",\"limitation_value\":1,\"limit\":{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":1,\"2K\":1,\"4K\":1,\"8K\":1},\"slug\":\"download-status\",\"status\":1,\"message\":\"Enjoy unlimited downloads with this plan.\"},{\"id\":23,\"planlimitation_id\":5,\"limitation_title\":\"Supported Device Type\",\"limitation_value\":1,\"limit\":{\"tablet\":\"1\",\"laptop\":\"1\",\"mobile\":\"1\"},\"slug\":\"supported-device-type\",\"status\":1,\"message\":null},{\"id\":24,\"planlimitation_id\":6,\"limitation_title\":\"Profile Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"4\"},\"slug\":\"profile-limit\",\"status\":1,\"message\":null}]',6,'4',NULL,NULL,NULL,NULL,'2026-01-08 00:00:00','2026-01-08 00:00:00'),
(9,1,11,'2026-01-22 00:00:00','2026-02-21 00:00:00','active',0,5,NULL,0,NULL,5,'Basic','basic','month',1,1,'[{\"id\":1,\"planlimitation_id\":1,\"limitation_title\":\"Video Cast\",\"limitation_value\":1,\"limit\":null,\"slug\":\"video-cast\",\"status\":1,\"message\":\"Cast videos to your TV with ease.\"},{\"id\":2,\"planlimitation_id\":2,\"limitation_title\":\"Ads\",\"limitation_value\":1,\"limit\":null,\"slug\":\"ads\",\"status\":1,\"message\":\"This plan includes ads.\"},{\"id\":3,\"planlimitation_id\":3,\"limitation_title\":\"Device Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"1\"},\"slug\":\"device-limit\",\"status\":1,\"message\":\"Stream on up to 1 devices simultaneously.\"},{\"id\":4,\"planlimitation_id\":4,\"limitation_title\":\"Download Status\",\"limitation_value\":1,\"limit\":{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":0,\"2K\":0,\"4K\":0,\"8K\":0},\"slug\":\"download-status\",\"status\":1,\"message\":\"Enjoy unlimited downloads with this plan.\"},{\"id\":17,\"planlimitation_id\":5,\"limitation_title\":\"Supported Device Type\",\"limitation_value\":1,\"limit\":{\"tablet\":\"0\",\"laptop\":\"0\",\"mobile\":\"1\"},\"slug\":\"supported-device-type\",\"status\":1,\"message\":null},{\"id\":18,\"planlimitation_id\":6,\"limitation_title\":\"Profile Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"2\"},\"slug\":\"profile-limit\",\"status\":1,\"message\":null}]',9,'5',NULL,NULL,NULL,NULL,'2026-01-22 00:00:00','2026-01-22 00:00:00'),
(10,2,12,'2026-01-23 00:00:00','2026-02-22 00:00:00','active',0,20,NULL,0,NULL,20,'Premium Plan','premium_plan','month',1,2,'[{\"id\":1,\"planlimitation_id\":1,\"limitation_title\":\"Video Cast\",\"limitation_value\":1,\"limit\":null,\"slug\":\"video-cast\",\"status\":1,\"message\":\"Cast videos to your TV with ease.\"},{\"id\":2,\"planlimitation_id\":2,\"limitation_title\":\"Ads\",\"limitation_value\":1,\"limit\":null,\"slug\":\"ads\",\"status\":1,\"message\":\"This plan includes ads.\"},{\"id\":3,\"planlimitation_id\":3,\"limitation_title\":\"Device Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"1\"},\"slug\":\"device-limit\",\"status\":1,\"message\":\"Stream on up to 1 devices simultaneously.\"},{\"id\":4,\"planlimitation_id\":4,\"limitation_title\":\"Download Status\",\"limitation_value\":1,\"limit\":{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":0,\"2K\":0,\"4K\":0,\"8K\":0},\"slug\":\"download-status\",\"status\":1,\"message\":\"Enjoy unlimited downloads with this plan.\"},{\"id\":17,\"planlimitation_id\":5,\"limitation_title\":\"Supported Device Type\",\"limitation_value\":1,\"limit\":{\"tablet\":\"0\",\"laptop\":\"0\",\"mobile\":\"1\"},\"slug\":\"supported-device-type\",\"status\":1,\"message\":null},{\"id\":18,\"planlimitation_id\":6,\"limitation_title\":\"Profile Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"2\"},\"slug\":\"profile-limit\",\"status\":1,\"message\":null}]',10,'6',NULL,NULL,NULL,NULL,'2026-01-23 00:00:00','2026-01-23 00:00:00'),
(11,3,13,'2025-11-17 00:00:00','2026-02-21 00:00:00','active',0,50,NULL,0,NULL,50,'Ultimate Plan','ultimate_plan','month',3,3,'[{\"id\":9,\"planlimitation_id\":1,\"limitation_title\":\"Video Cast\",\"limitation_value\":1,\"limit\":null,\"slug\":\"video-cast\",\"status\":1,\"message\":\"Cast videos to your TV with ease.\"},{\"id\":10,\"planlimitation_id\":2,\"limitation_title\":\"Ads\",\"limitation_value\":0,\"limit\":null,\"slug\":\"ads\",\"status\":1,\"message\":\"Ad-free streaming with this plan.\"},{\"id\":11,\"planlimitation_id\":3,\"limitation_title\":\"Device Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"5\"},\"slug\":\"device-limit\",\"status\":1,\"message\":\"Stream on up to 5 devices simultaneously.\"},{\"id\":12,\"planlimitation_id\":4,\"limitation_title\":\"Download Status\",\"limitation_value\":1,\"limit\":{\"480p\":1,\"720p\":1,\"1080p\":1,\"1440p\":1,\"2K\":1,\"4K\":0,\"8K\":0},\"slug\":\"download-status\",\"status\":1,\"message\":\"Enjoy unlimited downloads with this plan.\"},{\"id\":21,\"planlimitation_id\":5,\"limitation_title\":\"Supported Device Type\",\"limitation_value\":1,\"limit\":{\"tablet\":\"0\",\"laptop\":\"1\",\"mobile\":\"1\"},\"slug\":\"supported-device-type\",\"status\":1,\"message\":null},{\"id\":22,\"planlimitation_id\":6,\"limitation_title\":\"Profile Limit\",\"limitation_value\":1,\"limit\":{\"value\":\"3\"},\"slug\":\"profile-limit\",\"status\":1,\"message\":null}]',11,'7',NULL,NULL,NULL,NULL,'2025-11-17 00:00:00','2025-11-17 00:00:00');
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `subscriptions_transactions`
--

DROP TABLE IF EXISTS `subscriptions_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions_transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subscriptions_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `payment_type` varchar(191) DEFAULT NULL,
  `payment_status` varchar(191) DEFAULT NULL,
  `transaction_id` varchar(191) DEFAULT NULL,
  `tax_data` text DEFAULT NULL,
  `other_transactions_details` text DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions_transactions`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `subscriptions_transactions` WRITE;
/*!40000 ALTER TABLE `subscriptions_transactions` DISABLE KEYS */;
INSERT INTO `subscriptions_transactions` VALUES
(1,1,3,50,'stripe','paid','pi_1OnGh1FTMa5P8ht0pEWTz',NULL,NULL,3,3,NULL,NULL,'2026-01-20 00:00:00','2026-01-20 00:00:00'),
(2,2,4,5,'stripe','paid','pi_1OnGh1FTMa5P8ht0pEWTz',NULL,NULL,4,4,NULL,NULL,'2025-11-24 00:00:00','2025-11-24 00:00:00'),
(3,3,5,20,'stripe','paid','pi_1OnGh1FTMa5P8ht0pEWTz',NULL,NULL,5,5,NULL,NULL,'2026-01-19 00:00:00','2026-01-19 00:00:00'),
(4,4,6,50,'stripe','paid','pi_1OnGh1FTMa5P8ht0pEWTz',NULL,NULL,6,6,NULL,NULL,'2025-10-24 00:00:00','2025-10-24 00:00:00'),
(5,5,8,80,'stripe','paid','pi_1OnGh1FTMa5P8ht0pEWTz',NULL,NULL,8,8,NULL,NULL,'2026-01-20 00:00:00','2026-01-20 00:00:00'),
(6,6,9,80,'stripe','paid','pi_1OnGh1FTMa5P8ht0pEWTz',NULL,NULL,9,9,NULL,NULL,'2026-01-24 00:00:00','2026-01-24 00:00:00'),
(7,7,10,5,'stripe','paid','pi_1OnGh1FTMa5P8ht0pEWTz',NULL,NULL,10,10,NULL,NULL,'2025-02-20 00:00:00','2025-02-20 00:00:00'),
(8,8,14,20,'stripe','paid','pi_1OnGh1FTMa5P8ht0pEWTz',NULL,NULL,14,14,NULL,NULL,'2026-01-08 00:00:00','2026-01-08 00:00:00');
/*!40000 ALTER TABLE `subscriptions_transactions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `subtitles`
--

DROP TABLE IF EXISTS `subtitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `subtitles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entertainment_id` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(191) NOT NULL DEFAULT 'movie',
  `language` varchar(191) NOT NULL,
  `language_code` varchar(191) NOT NULL,
  `subtitle_file` varchar(191) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subtitles_entertainment_id_foreign` (`entertainment_id`),
  CONSTRAINT `subtitles_entertainment_id_foreign` FOREIGN KEY (`entertainment_id`) REFERENCES `entertainments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subtitles`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `subtitles` WRITE;
/*!40000 ALTER TABLE `subtitles` DISABLE KEYS */;
/*!40000 ALTER TABLE `subtitles` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `taxes`
--

DROP TABLE IF EXISTS `taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `taxes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `type` varchar(100) DEFAULT 'percent' COMMENT 'fixed , percent',
  `value` double DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxes`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `taxes` WRITE;
/*!40000 ALTER TABLE `taxes` DISABLE KEYS */;
INSERT INTO `taxes` VALUES
(1,'GST','Percentage',18,1,2,2,NULL,'2024-10-09 12:30:27','2024-10-09 12:30:27',NULL),
(2,'CGST','Percentage',9,1,2,2,NULL,'2024-10-09 12:30:53','2024-10-09 12:32:17',NULL),
(3,'VAT','Percentage',20,1,2,2,NULL,'2024-10-09 12:34:57','2024-10-09 12:34:57',NULL);
/*!40000 ALTER TABLE `taxes` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `tv_login_sessions`
--

DROP TABLE IF EXISTS `tv_login_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tv_login_sessions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` char(36) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `confirmed_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tv_login_sessions_session_id_unique` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tv_login_sessions`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `tv_login_sessions` WRITE;
/*!40000 ALTER TABLE `tv_login_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `tv_login_sessions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user_coupon_redeem`
--

DROP TABLE IF EXISTS `user_coupon_redeem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_coupon_redeem` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `coupon_code` varchar(191) NOT NULL,
  `discount` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `coupon_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_coupon_redeem`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user_coupon_redeem` WRITE;
/*!40000 ALTER TABLE `user_coupon_redeem` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_coupon_redeem` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user_multi_profiles`
--

DROP TABLE IF EXISTS `user_multi_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_multi_profiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `avatar` varchar(191) DEFAULT NULL,
  `is_child_profile` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_multi_profiles_user_id_foreign` (`user_id`),
  CONSTRAINT `user_multi_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_multi_profiles`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user_multi_profiles` WRITE;
/*!40000 ALTER TABLE `user_multi_profiles` DISABLE KEYS */;
INSERT INTO `user_multi_profiles` VALUES
(1,1,'Super Admin','http://127.0.0.1:8000/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(2,1,'kids','http://127.0.0.1:8000/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(3,2,'Ivan Norris','http://127.0.0.1:8000/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(4,2,'kids','http://127.0.0.1:8000/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(5,3,'John Doe','http://127.0.0.1:8000/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(6,3,'kids','http://127.0.0.1:8000/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(7,4,'Tristan Erickson','http://127.0.0.1:8000/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(8,4,'kids','http://127.0.0.1:8000/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(9,5,'Felix Harris','http://127.0.0.1:8000/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(10,5,'kids','http://127.0.0.1:8000/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(11,6,'Harry Victoria','http://127.0.0.1:8000/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(12,6,'kids','http://127.0.0.1:8000/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(13,7,'Jorge Perez','http://127.0.0.1:8000/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(14,7,'kids','http://127.0.0.1:8000/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(15,8,'Joy Hanry','http://127.0.0.1:8000/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(16,8,'kids','http://127.0.0.1:8000/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(17,9,'Deborah Thomas','http://127.0.0.1:8000/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(18,9,'kids','http://127.0.0.1:8000/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(19,10,'Katie Brown','http://127.0.0.1:8000/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(20,10,'kids','http://127.0.0.1:8000/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(21,11,'Dorothy Erickson','http://127.0.0.1:8000/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(22,11,'kids','http://127.0.0.1:8000/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(23,12,'Lisa Lucas','http://127.0.0.1:8000/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(24,12,'kids','http://127.0.0.1:8000/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(25,13,'Tracy Jones','http://127.0.0.1:8000/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(26,13,'kids','http://127.0.0.1:8000/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(27,14,'Stella Green','http://127.0.0.1:8000/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(28,14,'kids','http://127.0.0.1:8000/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-18 08:17:54','2026-02-18 08:17:54'),
(29,16,'Mohammad Ahsan','https://apexprimetv.com/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-21 13:45:03','2026-02-21 13:45:03'),
(30,16,'Kids','https://apexprimetv.com/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-21 13:45:03','2026-02-21 13:45:03'),
(31,17,'Ravi','https://apexprimetv.com/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-02-22 18:27:35','2026-02-22 18:27:35'),
(32,17,'Kids','https://apexprimetv.com/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-02-22 18:27:35','2026-02-22 18:27:35'),
(33,21,'Mohammad','https://apexprimetv.com/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-03-06 21:33:02','2026-03-06 21:33:02'),
(34,21,'Kids','https://apexprimetv.com/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-03-06 21:33:02','2026-03-06 21:33:02'),
(35,22,'Shinu','https://apexprimetv.com/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-04-04 06:41:22','2026-04-04 06:41:22'),
(36,22,'Kids','https://apexprimetv.com/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-04-04 06:41:22','2026-04-04 06:41:22'),
(37,23,'Jude','https://apexprimetv.com/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-05-01 11:26:50','2026-05-01 11:26:50'),
(38,23,'Kids','https://apexprimetv.com/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-05-01 11:26:50','2026-05-01 11:26:50'),
(39,24,'Rajesh','https://apexprimetv.com/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-05-09 10:24:06','2026-05-09 10:24:06'),
(40,24,'Kids','https://apexprimetv.com/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-05-09 10:24:06','2026-05-09 10:24:06'),
(41,25,'Ali','https://apexprimetv.com/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-05-15 22:04:06','2026-05-15 22:04:06'),
(42,25,'Kids','https://apexprimetv.com/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-05-15 22:04:06','2026-05-15 22:04:06'),
(43,26,'Sara','https://apexprimetv.com/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-05-26 20:15:49','2026-05-26 20:15:49'),
(44,26,'Kids','https://apexprimetv.com/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-05-26 20:15:49','2026-05-26 20:15:49'),
(45,27,'Sara','https://apexprimetv.com/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-05-26 20:16:12','2026-05-26 20:16:12'),
(46,27,'Kids','https://apexprimetv.com/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-05-26 20:16:12','2026-05-26 20:16:12'),
(47,28,'Itopa','https://apexprimetv.com/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-06-02 17:34:12','2026-06-02 17:34:12'),
(48,28,'Kids','https://apexprimetv.com/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-06-02 17:34:12','2026-06-02 17:34:12'),
(49,29,'Test','https://apexprimetv.com/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-06-03 06:07:19','2026-06-03 06:07:19'),
(50,29,'Kids','https://apexprimetv.com/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-06-03 06:07:19','2026-06-03 06:07:19'),
(51,30,'John','https://apexprimetv.com/storage/avatars/image/icon2.png',0,NULL,NULL,NULL,NULL,'2026-06-05 14:26:05','2026-06-05 14:26:05'),
(52,30,'Kids','https://apexprimetv.com/storage/avatars/image/icon4.png',1,NULL,NULL,NULL,NULL,'2026-06-05 14:26:05','2026-06-05 14:26:05');
/*!40000 ALTER TABLE `user_multi_profiles` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user_music_preferences`
--

DROP TABLE IF EXISTS `user_music_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_music_preferences` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `favorite_genres` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`favorite_genres`)),
  `favorite_artists` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`favorite_artists`)),
  `listening_history` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`listening_history`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_music_preferences_user_id_unique` (`user_id`),
  CONSTRAINT `user_music_preferences_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_music_preferences`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user_music_preferences` WRITE;
/*!40000 ALTER TABLE `user_music_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_music_preferences` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user_profiles`
--

DROP TABLE IF EXISTS `user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `about_self` varchar(191) DEFAULT NULL,
  `expert` varchar(191) DEFAULT NULL,
  `facebook_link` varchar(191) DEFAULT NULL,
  `instagram_link` varchar(191) DEFAULT NULL,
  `twitter_link` varchar(191) DEFAULT NULL,
  `dribbble_link` varchar(191) DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profiles`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user_profiles` WRITE;
/*!40000 ALTER TABLE `user_profiles` DISABLE KEYS */;
INSERT INTO `user_profiles` VALUES
(1,'I am a passionate developer.','Web Development','https://facebook.com/user1','https://instagram.com/user1','https://twitter.com/user1','https://dribbble.com/user1',1,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(2,'Love creating content and engaging with my audience.','Content Creation','https://facebook.com/user2','https://instagram.com/user2','https://twitter.com/user2','https://dribbble.com/user2',2,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL),
(3,'Tech enthusiast and blogger.','Tech Blogging','https://facebook.com/user3','https://instagram.com/user3','https://twitter.com/user3','https://dribbble.com/user3',3,'2026-02-18 08:17:54','2026-02-18 08:17:54',NULL);
/*!40000 ALTER TABLE `user_profiles` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user_providers`
--

DROP TABLE IF EXISTS `user_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_providers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `provider` varchar(191) NOT NULL,
  `provider_id` varchar(191) NOT NULL,
  `avatar` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_providers`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user_providers` WRITE;
/*!40000 ALTER TABLE `user_providers` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_providers` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user_reminder`
--

DROP TABLE IF EXISTS `user_reminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_reminder` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entertainment_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `is_remind` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_reminder`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user_reminder` WRITE;
/*!40000 ALTER TABLE `user_reminder` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_reminder` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user_search_histories`
--

DROP TABLE IF EXISTS `user_search_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_search_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `profile_id` bigint(20) unsigned DEFAULT NULL,
  `search_query` varchar(191) DEFAULT NULL,
  `search_id` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_search_histories`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user_search_histories` WRITE;
/*!40000 ALTER TABLE `user_search_histories` DISABLE KEYS */;
INSERT INTO `user_search_histories` VALUES
(1,3,3,'Shadow Pursuit',4,'tvshow','2026-02-18 08:17:54','2026-02-18 08:17:54'),
(2,3,3,'Wolfbound',8,'tvshow','2026-02-18 08:17:54','2026-02-18 08:17:54'),
(3,3,3,'Road to Reconnection',14,'tvshow','2026-02-18 08:17:54','2026-02-18 08:17:54'),
(4,4,4,'The Daring Player',27,'movie','2026-02-18 08:17:54','2026-02-18 08:17:54'),
(5,3,3,'Legacy of Antiquity: Origins of Civilization',36,'movie','2026-02-18 08:17:54','2026-02-18 08:17:54'),
(6,3,3,'Guardians of the Abyss: The Beast Awakens',46,'tvshow','2026-02-18 08:17:54','2026-02-18 08:17:54'),
(7,4,4,'Blade of Chaos',52,'movie','2026-02-18 08:17:54','2026-02-18 08:17:54'),
(8,3,3,'Echoes of Valor',6,'video','2026-02-18 08:17:54','2026-02-18 08:17:54'),
(9,3,3,'Warrior\'s Dilemma',11,'video','2026-02-18 08:17:54','2026-02-18 08:17:54'),
(10,3,3,'School Hacks & Fun DIY Crafts',15,'video','2026-02-18 08:17:54','2026-02-18 08:17:54'),
(11,4,4,'Motel of Nightmares',21,'video','2026-02-18 08:17:54','2026-02-18 08:17:54'),
(12,4,4,'Mango Mousse Delight',24,'video','2026-02-18 08:17:54','2026-02-18 08:17:54');
/*!40000 ALTER TABLE `user_search_histories` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user_watch_histories`
--

DROP TABLE IF EXISTS `user_watch_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_watch_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entertainment_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `entertainment_type` varchar(191) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_watch_histories`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user_watch_histories` WRITE;
/*!40000 ALTER TABLE `user_watch_histories` DISABLE KEYS */;
INSERT INTO `user_watch_histories` VALUES
(1,101,3,3,'movie',3,3,NULL,NULL,NULL,NULL),
(2,15,3,3,'tvshow',3,3,NULL,NULL,NULL,NULL),
(3,35,3,3,'movie',3,3,NULL,NULL,NULL,NULL),
(4,12,4,4,'tvshow',4,4,NULL,NULL,NULL,NULL),
(5,15,4,4,'video',4,4,NULL,NULL,NULL,NULL),
(6,10,4,4,'video',4,4,NULL,NULL,NULL,NULL),
(7,5,3,3,'video',3,3,NULL,NULL,NULL,NULL),
(8,65,3,3,'movie',3,3,NULL,NULL,NULL,NULL),
(9,2,4,4,'tvshow',4,4,NULL,NULL,NULL,NULL),
(10,8,3,3,'video',3,3,NULL,NULL,NULL,NULL),
(11,18,4,4,'video',4,4,NULL,NULL,NULL,NULL),
(12,18,3,3,'tvshow',3,3,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user_watch_histories` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(191) DEFAULT NULL,
  `first_name` varchar(191) DEFAULT NULL,
  `last_name` varchar(191) DEFAULT NULL,
  `email` varchar(191) NOT NULL,
  `fcm_token` varchar(191) DEFAULT NULL,
  `mobile` varchar(191) DEFAULT NULL,
  `login_type` varchar(191) DEFAULT NULL,
  `file_url` text DEFAULT NULL,
  `gender` varchar(191) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) NOT NULL,
  `is_banned` tinyint(4) NOT NULL DEFAULT 0,
  `is_subscribe` tinyint(4) NOT NULL DEFAULT 0,
  `country_code` varchar(5) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `last_notification_seen` timestamp NULL DEFAULT NULL,
  `address` longtext DEFAULT NULL,
  `user_type` varchar(191) DEFAULT NULL,
  `pin` smallint(6) DEFAULT NULL,
  `otp` smallint(6) DEFAULT NULL,
  `is_parental_lock_enable` tinyint(1) NOT NULL DEFAULT 0,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_fcm_token_index` (`fcm_token`),
  KEY `users_deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,NULL,'Super','Admin','admin@streamit.com',NULL,'+12123567890',NULL,'super_admin.png','female','2020-02-04','2026-02-18 08:17:53','$2y$10$CYrINOtNRe1XCruupDlvmuK6BYO8AS0HNVXhDmcvIHDZFzbqO6eKi',0,0,'1',1,NULL,NULL,'admin',NULL,NULL,0,NULL,'2026-02-18 08:17:53','2026-02-18 08:17:53',NULL),
(2,NULL,'Ivan','Norris','demo@streamit.com',NULL,'+12124567899',NULL,'demo_admin.png','male','1994-01-09','2026-02-18 08:17:53','$2y$10$xC0/b4U9o1pbsYRELyvJTu.lXgqavBKywUWuiyz/1bXM2381f9Qdm',0,0,'1',1,NULL,NULL,'demo_admin',NULL,NULL,0,NULL,'2026-02-18 08:17:53','2026-02-18 08:17:54',NULL),
(3,NULL,'John','Doe','john@gmail.com',NULL,'+911234567890','otp','john.png','male','1990-02-13','2026-02-18 08:17:53','$2y$10$x4ucpRlt.nWZaVfUvZjKOOuXK0deLYt7lE0vqNqQxE1Xtr8An8fUa',0,1,'1',1,NULL,'101 Pine Lane Miami, FL 33101 United States','user',NULL,NULL,0,NULL,'2026-02-18 08:17:53','2026-02-18 08:17:54',NULL),
(4,NULL,'Tristan','Erickson','tristan@gmail.com',NULL,'+447911123456','otp','tristan.png','male','1992-05-21','2026-02-18 08:17:53','$2y$10$enrUXY/w00hV/vKVwJ2D6OYv96/kvkgcx4ppx.CeoFmC6D9tRGicO',0,1,'44',1,NULL,'46 Oxford Road London, W1D 1BS United Kingdom','user',NULL,NULL,0,NULL,'2026-02-18 08:17:53','2026-02-18 08:17:54',NULL),
(5,NULL,'Felix','Harris','felix@gmail.com',NULL,'+12124567890','otp','felix.png','male','1996-02-02','2026-02-18 08:17:53','$2y$10$AdQEMZ/TYLNiwNS9OtroaOKZSSe/EOM2Y4TYnhh5OOVV5j9D9vxL6',0,1,'61',1,NULL,'3 Queen Street Sydney, NSW 2000 Australia','user',NULL,NULL,0,NULL,'2026-02-18 08:17:53','2026-02-18 08:17:54',NULL),
(6,NULL,'Harry','Victoria','harry@gmail.com',NULL,'+447911123456','otp','harry.png','male','1987-07-08','2026-02-18 08:17:53','$2y$10$tnWCgAubg39GMyKiKFOM0enVsR1hx8UC1k9DW9oSLHrZ4qohBBPNG',0,1,'33',1,NULL,'11 Rue de Rivoli Paris, 75001 France','user',NULL,NULL,0,NULL,'2026-02-18 08:17:53','2026-02-18 08:17:54',NULL),
(7,NULL,'Jorge','Perez','jorge@gmail.com',NULL,'+496912345678','otp','jorge.png','male','1991-01-01','2026-02-18 08:17:53','$2y$10$wocI8OUTQkRlcyzKpa1Cb.DU4ubittdf5w9DN4Bs3g8DUL4clTiDi',0,0,'49',1,NULL,'20 Kurfürstendamm Berlin, 10719 Germany','user',NULL,NULL,0,NULL,'2026-02-18 08:17:53','2026-02-18 08:17:54',NULL),
(8,NULL,'Joy','Hanry','joy@gmail.com',NULL,'+81312345678','otp','joy.png','male','1993-07-10','2026-02-18 08:17:53','$2y$10$vpmNnU5bTFeUtEWsrJaIBuwiNBXYs3BQSAhQK.hIsSP185iyhi8TC',0,1,'81',1,NULL,'3 Shibuya Street Tokyo, 150-0002 Japan','user',NULL,NULL,0,NULL,'2026-02-18 08:17:53','2026-02-18 08:17:54',NULL),
(9,NULL,'Deborah','Thomas','deborah@gmail.com',NULL,'+81312355678','otp','deborah.png','female','1992-03-26','2026-02-18 08:17:53','$2y$10$Hy25jnzZhy0VIzZyBTlviOzqRgON6NnbnqV.fxcXVtxcbie9DD8/C',0,1,'1',1,NULL,'7 Maple Avenue Toronto, ON M5H 2N2 Canada','user',NULL,NULL,0,NULL,'2026-02-18 08:17:53','2026-02-18 08:17:54',NULL),
(10,NULL,'Katie','Brown','katie@gmail.com',NULL,'+12124467890','otp','katie.png','female','1994-08-16','2026-02-18 08:17:53','$2y$10$P0qw3.pU3SvD4x7c.RCKaeq4SM3yNKbgiTuh23CMCsa3.xUFSvVG.',0,1,'34',1,NULL,'14 Gran Vía Madrid, 28013 Spain','user',NULL,NULL,0,NULL,'2026-02-18 08:17:53','2026-02-18 08:17:54',NULL),
(11,NULL,'Dorothy','Erickson','dorothy@gmail.com',NULL,'+12124577890','otp','dorothy.png','female','1989-10-10','2026-02-18 08:17:53','$2y$10$jNun/x4eHTWGqlPindd5Y.lMAsGFDo0I8/uSFulTr22Q8ZUFQQYoe',0,0,'55',1,NULL,'50 Paulista Avenue São Paulo, SP 01310-100 Brazil','user',NULL,NULL,0,NULL,'2026-02-18 08:17:53','2026-02-18 08:17:54',NULL),
(12,NULL,'Lisa','Lucas','lisa@gmail.com',NULL,'+12124567790','otp','lisa.png','female','1993-08-03','2026-02-18 08:17:53','$2y$10$BfKxVsScgdb9sOLxBLewlelGDKKkGRmF8f.GdEvnEzrrjxczJwxuC',0,0,'971',1,NULL,'6 Sheikh Zayed Road Dubai, 00000 United Arab Emirates','user',NULL,NULL,0,NULL,'2026-02-18 08:17:53','2026-02-18 08:17:54',NULL),
(13,NULL,'Tracy','Jones','tracy@gmail.com',NULL,'+913465656789','otp','tracy.png','female','1990-11-19','2026-02-18 08:17:53','$2y$10$9iIjzxF/gfxSZuOokcQnQO.iZaFr92y9jZsJD7Hdzu/ztnQ/qgOa.',0,0,'65',1,NULL,'71 Orchard Road Singapore, 238838 Singapore','user',NULL,NULL,0,NULL,'2026-02-18 08:17:53','2026-02-18 08:17:54',NULL),
(14,NULL,'Stella','Green','stella@gmail.com',NULL,'+913465756789','otp','stella.png','female','1991-12-18','2026-02-18 08:17:53','$2y$10$/WhojNoyFOrgco8ZwMlxoOqkAr3rUGfjBr2sd5fSWG8RkuqPdP7O2',0,1,'1',1,NULL,'15 Redwood Way Phoenix, AZ 85001 United States','user',NULL,NULL,0,NULL,'2026-02-18 08:17:53','2026-02-18 08:17:54',NULL),
(15,'admin','Admin','User','admin@apexprimetv.com',NULL,NULL,'email',NULL,NULL,NULL,'2026-02-18 09:40:38','$2y$10$NJEu5lE5jQvI7Pv9LgniLu6MBDKrxunyW/imgOC.CEI.qGihCr/Bq',0,0,NULL,1,NULL,NULL,'admin',NULL,NULL,0,'PY1uYM32WZkkypUb8Iyg22XsdAWhVWebgxh8TzH8BJgEoP6FxvvGe6BiPJ62','2026-02-18 09:40:38','2026-03-01 02:01:05',NULL),
(16,NULL,'Mohammad Ahsan','Ahsan Ali','alikhan6677665@gmail.com',NULL,NULL,'google',NULL,NULL,NULL,NULL,'$2y$10$3HPHMs9hADwzMre2QoQtt.mXazsIh6H5fhxPPZRmsgEID2gaTWZCq',0,0,NULL,1,'2026-03-03 23:23:34',NULL,'user',NULL,NULL,0,NULL,'2026-02-21 13:45:03','2026-03-05 11:42:15',NULL),
(17,'8090814150','Ravi','Kapoor','djravikapoor@gmail.com',NULL,'+918090814150',NULL,NULL,NULL,NULL,NULL,'$2y$10$S0TbpPUv2tDa.WK1Y5L4mOOAcVm8.svSMFPRE4ipV1wdIWOyrV/tO',0,0,'91',1,NULL,NULL,'user',NULL,NULL,0,NULL,'2026-02-22 18:27:35','2026-02-22 18:29:38',NULL),
(21,NULL,'Mohammad','Mohsin','mohsin.adwords84@gmail.com',NULL,NULL,'google',NULL,NULL,NULL,NULL,'$2y$10$.hBUo.YdWTUFUEiaXNJp0eMOq9mm5SU404FlQk.hyFzf./W4dWuGa',0,0,NULL,1,NULL,NULL,'user',NULL,NULL,0,NULL,'2026-03-06 21:33:02','2026-03-06 21:33:02',NULL),
(22,'9895803768','Shinu','Kp','malayalamtvhd@gmail.com',NULL,'+919895803768',NULL,NULL,NULL,NULL,NULL,'$2y$10$7V4xvLdFmGwLlvgXaP3PGO28aqNcFFxjKfqQV/3IIVDYYou.VDcP2',0,0,'91',1,NULL,NULL,'user',NULL,NULL,0,NULL,'2026-04-04 06:41:22','2026-04-04 06:41:22',NULL),
(23,'8050584161','Jude','Opebiyi','dejavoo2sure@gmail.com',NULL,'+2348050584161',NULL,NULL,NULL,NULL,NULL,'$2y$10$8gKZQyBjXXsoZJxBipfcCO8CPHeyCwz5KYS4kLKhlYWuzS6eleebq',0,0,'234',1,NULL,NULL,'user',NULL,NULL,0,NULL,'2026-05-01 11:26:50','2026-05-01 11:26:50',NULL),
(24,'9702766586','Rajesh','Vishwakarma','rajesh.deuro@gmail.com',NULL,'+919702766586',NULL,NULL,NULL,NULL,NULL,'$2y$10$6mLSZICW0X2CYsKRSvHLJOWXAS7Aw5437U.kANVjeG2N5H/v0jveK',0,0,'91',1,NULL,NULL,'user',NULL,NULL,0,NULL,'2026-05-09 10:24:06','2026-05-09 10:24:06',NULL),
(25,'9182902164','Ali','Khan','testing@gmail.com',NULL,'+919182902164',NULL,NULL,NULL,NULL,NULL,'$2y$10$Z8rd6mlBLgnyQ4Tij4xgBui3r6T3tqTzJl1ThRW30ye9E/E0qJae.',0,0,'91',1,NULL,NULL,'user',NULL,NULL,0,NULL,'2026-05-15 22:04:06','2026-05-15 22:04:06',NULL),
(26,NULL,'Sara','Fatima','saraahsanali2014@gmail.com',NULL,NULL,'google',NULL,NULL,NULL,NULL,'$2y$10$KkEAuhvX16VOfdpjhUYone//5kie3r4kNgIkhtKe5Q3cdP5Ud1upu',0,0,NULL,1,NULL,NULL,'user',NULL,NULL,0,NULL,'2026-05-26 20:15:49','2026-05-26 20:15:49',NULL),
(27,NULL,'Sara','Fatima','sarafatimaahsan@gmail.com',NULL,NULL,'google',NULL,NULL,NULL,NULL,'$2y$10$xu0Mw6MTIrUp5ySE914QVezUZ3hOttV/CiRS8Ak4nqTWuaXwrsZLe',0,0,NULL,1,NULL,NULL,'user',NULL,NULL,0,NULL,'2026-05-26 20:16:12','2026-05-26 20:16:12',NULL),
(28,'08132395450','Itopa','Ijiji','generalit5450@gmail.com',NULL,'+23408132395450',NULL,NULL,NULL,NULL,NULL,'$2y$10$4QtpzO8r8mgdUdFlOEL8k.O46Es1jzZr31kLkDgoWD9GNRRbRKfTW',0,0,'234',1,NULL,NULL,'user',NULL,NULL,0,NULL,'2026-06-02 17:34:12','2026-06-02 17:34:12',NULL),
(29,NULL,'Test','User','test@gmail.com',NULL,NULL,'google',NULL,NULL,NULL,NULL,'$2y$10$oMvuZyGlNBU0OGncci7w.eNgfw99ANM.a75fD.tkX2srdKUSrlMZW',0,0,NULL,1,'2026-06-03 06:09:58',NULL,'user',NULL,NULL,0,NULL,'2026-06-03 06:07:19','2026-06-03 06:09:58',NULL),
(30,NULL,'John','Apple','gvfjg4n2kd@privaterelay.appleid.com',NULL,NULL,'apple',NULL,NULL,NULL,NULL,'$2y$10$gran0fGX5UcewYK7OKig5edTFyXIzL9kDHA4u0yFy.v5ive3fBCT6',0,0,NULL,1,NULL,NULL,'user',NULL,NULL,0,NULL,'2026-06-05 14:26:04','2026-06-05 14:31:58',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `vast_ads_setting`
--

DROP TABLE IF EXISTS `vast_ads_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vast_ads_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `type` varchar(191) DEFAULT NULL,
  `url` varchar(191) DEFAULT NULL,
  `duration` varchar(191) DEFAULT NULL,
  `target_type` varchar(191) DEFAULT NULL,
  `target_selection` longtext DEFAULT NULL,
  `enable_skip` tinyint(1) NOT NULL DEFAULT 0,
  `skip_after` varchar(191) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_enable` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vast_ads_setting_status_index` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vast_ads_setting`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `vast_ads_setting` WRITE;
/*!40000 ALTER TABLE `vast_ads_setting` DISABLE KEYS */;
INSERT INTO `vast_ads_setting` VALUES
(1,'BigSale','pre-roll','https://basil79.github.io/vast-sample-tags/pg/vast.xml',NULL,'movie','[22,23,25,26,28,94,95,96]',0,NULL,NULL,'2026-02-18','2027-02-18',0,1,'2025-07-25 06:04:17','2025-07-25 06:04:17',NULL),
(2,'MovieTicket','mid-roll','https://basil79.github.io/vast-sample-tags/pg/vast.xml',NULL,'movie','[22,23,25,26,28,94,95,96]',0,NULL,NULL,'2026-02-18','2027-02-18',0,1,'2025-07-25 06:06:03','2025-07-25 06:06:03',NULL),
(3,'EpisodePromo','post-roll','https://basil79.github.io/vast-sample-tags/pg/vast.xml',NULL,'movie','[22,23,25,26,28,94,95,96]',0,NULL,NULL,'2026-02-18','2027-02-18',0,1,'2025-07-25 06:07:32','2025-07-25 06:07:32',NULL),
(4,'ServicePromo','overlay','https://raw.githubusercontent.com/InteractiveAdvertisingBureau/VAST_Samples/master/VAST%203.0%20Samples/Inline_Non-Linear_Tag-test.xml',NULL,'movie','[22,23,25,26,28,94,95,96]',0,NULL,NULL,'2026-02-18','2027-02-18',0,1,'2025-07-25 06:09:01','2025-07-25 06:09:01',NULL),
(5,'BigSale','pre-roll','https://basil79.github.io/vast-sample-tags/pg/vast.xml',NULL,'video','[1,2,3,4,5,17,26]',0,NULL,NULL,'2026-02-18','2027-02-18',0,1,'2025-07-25 06:11:03','2025-07-25 06:11:03',NULL),
(6,'MovieTicket','mid-roll','https://basil79.github.io/vast-sample-tags/pg/vast.xml',NULL,'video','[1,2,3,4,5,17,26]',0,NULL,NULL,'2026-02-18','2027-02-18',0,1,'2025-07-25 06:12:26','2025-07-25 06:12:26',NULL),
(7,'EpisodePromo','post-roll','https://basil79.github.io/vast-sample-tags/pg/vast.xml',NULL,'video','[1,2,3,4,5,17,26]',0,NULL,NULL,'2026-02-18','2027-02-18',0,1,'2025-07-25 06:13:38','2025-07-25 06:13:38',NULL),
(8,'ServicePromo','overlay','https://raw.githubusercontent.com/InteractiveAdvertisingBureau/VAST_Samples/master/VAST%203.0%20Samples/Inline_Non-Linear_Tag-test.xml',NULL,'video','[1,2,3,4,5,17,26]',0,NULL,NULL,'2026-02-18','2027-02-18',0,1,'2025-07-25 06:17:56','2025-07-25 06:17:56',NULL),
(9,'BigSale','pre-roll','https://basil79.github.io/vast-sample-tags/pg/vast.xml',NULL,'tvshow','[1,2,3,11,12,23,24,25]',0,NULL,NULL,'2026-02-18','2027-02-18',0,1,'2025-07-25 06:19:54','2025-07-25 06:19:54',NULL),
(10,'MovieTicket','mid-roll','https://basil79.github.io/vast-sample-tags/pg/vast.xml',NULL,'tvshow','[1,2,3,11,12,23,24,25]',0,NULL,NULL,'2026-02-18','2027-02-18',0,1,'2025-07-25 06:21:34','2025-07-25 06:21:34',NULL),
(11,'EpisodePromo','post-roll','https://basil79.github.io/vast-sample-tags/pg/vast.xml',NULL,'tvshow','[1,2,3,11,12,23,24,25]',0,NULL,NULL,'2026-02-18','2027-02-18',0,1,'2025-07-25 06:23:06','2025-07-25 06:23:06',NULL);
/*!40000 ALTER TABLE `vast_ads_setting` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `video_download_mappings`
--

DROP TABLE IF EXISTS `video_download_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `video_download_mappings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `video_id` bigint(20) unsigned NOT NULL,
  `type` varchar(191) DEFAULT NULL,
  `quality` varchar(191) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_download_mappings`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `video_download_mappings` WRITE;
/*!40000 ALTER TABLE `video_download_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_download_mappings` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `video_stream_content_mapping`
--

DROP TABLE IF EXISTS `video_stream_content_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `video_stream_content_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `video_id` bigint(20) unsigned NOT NULL,
  `type` varchar(191) DEFAULT NULL,
  `quality` varchar(191) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_stream_content_mapping`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `video_stream_content_mapping` WRITE;
/*!40000 ALTER TABLE `video_stream_content_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_stream_content_mapping` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) DEFAULT NULL,
  `poster_url` text DEFAULT NULL,
  `trailer_url_type` varchar(191) DEFAULT NULL,
  `trailer_url` text DEFAULT NULL,
  `thumbnail_url` text DEFAULT NULL,
  `access` varchar(191) DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `plan_id` bigint(20) unsigned DEFAULT NULL,
  `IMDb_rating` int(11) DEFAULT NULL,
  `content_rating` longtext DEFAULT NULL,
  `duration` varchar(191) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `is_restricted` tinyint(1) NOT NULL DEFAULT 0,
  `short_desc` longtext DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `enable_quality` tinyint(1) NOT NULL DEFAULT 0,
  `video_upload_type` varchar(191) DEFAULT NULL,
  `video_url_input` text DEFAULT NULL,
  `download_status` tinyint(1) NOT NULL DEFAULT 0,
  `download_type` varchar(191) DEFAULT NULL,
  `download_url` text DEFAULT NULL,
  `enable_download_quality` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `poster_tv_url` text DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `purchase_type` varchar(191) DEFAULT NULL,
  `access_duration` int(11) DEFAULT NULL,
  `discount` varchar(191) DEFAULT NULL,
  `available_for` int(11) DEFAULT NULL,
  `enable_subtitle` tinyint(1) NOT NULL DEFAULT 0,
  `subtitle_language` varchar(191) DEFAULT NULL,
  `is_default_subtitle` tinyint(1) NOT NULL DEFAULT 0,
  `subtitle_file` varchar(191) DEFAULT NULL,
  `meta_title` varchar(191) DEFAULT NULL,
  `meta_keywords` varchar(191) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `seo_image` varchar(191) DEFAULT NULL,
  `google_site_verification` varchar(191) DEFAULT NULL,
  `canonical_url` varchar(191) DEFAULT NULL,
  `short_description` text DEFAULT NULL,
  `enable_clips` tinyint(1) NOT NULL DEFAULT 0,
  `slug` text DEFAULT NULL,
  `bunny_video_url` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `videos` WRITE;
/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
INSERT INTO `videos` VALUES
(37,'चंदा मामा आवा (लोरी ) Singer-‪@panchamigoswami‬ ‪@kumarsangeet‬','%E0%A4%9A%E0%A4%82%E0%A4%A6%E0%A4%BE_%E0%A4%AE%E0%A4%BE%E0%A4%AE%E0%A4%BE_%E0%A4%86%E0%A4%B5%E0%A4%BE_(%E0%A4%B2%E0%A5%8B%E0%A4%B0%E0%A5%80_)_Singer_@panchamigoswami_@kumarsangeet____1280x720_6a253ccdd5599.jpg',NULL,NULL,'%E0%A4%9A%E0%A4%82%E0%A4%A6%E0%A4%BE_%E0%A4%AE%E0%A4%BE%E0%A4%AE%E0%A4%BE_%E0%A4%86%E0%A4%B5%E0%A4%BE_(%E0%A4%B2%E0%A5%8B%E0%A4%B0%E0%A5%80_)_Singer_@panchamigoswami_@kumarsangeet____1280x720_6a253ccdd5599.jpg','free','video',NULL,NULL,NULL,'03:38','00:00:00','00:00:00','2026-06-07',0,NULL,'<p><span style=\"background-color: rgba(0, 0, 0, 0.05); color: #131313; font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;\">ong :- चंदा मामा आवा (लोरी )</span></p>\r\n<p><span style=\"color: #131313; font-family: Roboto, Arial, sans-serif; white-space: pre-wrap; background-color: rgba(0, 0, 0, 0.05);\">Singer :- Panchami Goswami Lyrics :- Kumar Sangeet Music :-Satyam Singh Recording &amp; Mixing :- Shashi ji (Punjab) Dop:- Sanjay Shahni Assistant Camera Man:- Sanjay Sahani Editor:- Dev Company/ Label :- Apex Digital World Bhojpuri</span></p>',0,'YouTube','https://youtu.be/8D-IXxyRr28',1,'URL','https://youtu.be/8D-IXxyRr28',0,1,15,15,NULL,'2026-06-07 09:43:49','2026-06-07 09:43:49',NULL,'%E0%A4%9A%E0%A4%82%E0%A4%A6%E0%A4%BE_%E0%A4%AE%E0%A4%BE%E0%A4%AE%E0%A4%BE_%E0%A4%86%E0%A4%B5%E0%A4%BE_(%E0%A4%B2%E0%A5%8B%E0%A4%B0%E0%A5%80_)_Singer_@panchamigoswami_@kumarsangeet____1280x720_6a253ccdd5599.jpg',NULL,'rental',NULL,NULL,NULL,0,NULL,0,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,0,'catha-mama-aava-lra-singer-at-panchamigoswami-at-kumarsangeet',NULL);
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `watchlists`
--

DROP TABLE IF EXISTS `watchlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `watchlists` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entertainment_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `watchlists_id_deleted_at_index` (`id`,`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchlists`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `watchlists` WRITE;
/*!40000 ALTER TABLE `watchlists` DISABLE KEYS */;
INSERT INTO `watchlists` VALUES
(1,1,3,3,'tvshow',NULL,NULL,NULL,'2024-03-12 06:55:53','2024-03-12 06:55:53',NULL),
(2,2,3,3,'tvshow',NULL,NULL,NULL,'2024-04-12 06:56:39','2024-04-12 06:56:39',NULL),
(3,33,14,14,'movie',NULL,NULL,NULL,'2024-05-12 06:56:46','2024-05-12 06:56:46',NULL),
(4,4,3,3,'tvshow',NULL,NULL,NULL,'2024-07-12 06:57:19','2024-07-12 06:57:19',NULL),
(5,5,3,3,'tvshow',NULL,NULL,NULL,'2024-06-12 06:57:44','2024-06-12 06:57:44',NULL),
(6,6,3,3,'tvshow',NULL,NULL,NULL,'2024-04-12 06:57:44','2024-04-12 06:57:44',NULL),
(7,7,3,3,'tvshow',NULL,NULL,NULL,'2024-07-12 06:57:44','2024-07-12 06:57:44',NULL),
(8,58,3,3,'movie',NULL,NULL,NULL,'2024-05-12 06:57:44','2024-05-12 06:57:44',NULL),
(9,9,3,3,'tvshow',NULL,NULL,NULL,'2024-06-12 06:57:44','2024-06-12 06:57:44',NULL);
/*!40000 ALTER TABLE `watchlists` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `web_qr_sessions`
--

DROP TABLE IF EXISTS `web_qr_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `web_qr_sessions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` char(36) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `status` enum('pending','authenticated','expired') NOT NULL DEFAULT 'pending',
  `confirmed_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_qr_sessions_session_id_unique` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_qr_sessions`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `web_qr_sessions` WRITE;
/*!40000 ALTER TABLE `web_qr_sessions` DISABLE KEYS */;
INSERT INTO `web_qr_sessions` VALUES
(1,'246b3677-a5c5-42cd-a5d6-21046070908e',NULL,'pending',NULL,'2026-02-26 22:42:33','2026-02-26 22:37:33','2026-02-26 22:37:33'),
(2,'08da4967-5c0d-45f5-be33-0541584ce10d',NULL,'pending',NULL,'2026-03-02 05:36:46','2026-03-02 05:31:46','2026-03-02 05:31:46'),
(3,'f5e5b1a2-8c75-4376-a45c-f16536220fe0',NULL,'pending',NULL,'2026-03-29 16:32:13','2026-03-29 16:27:13','2026-03-29 16:27:13'),
(4,'0d7a9f7e-6c75-4573-8d17-0c08108292b9',NULL,'pending',NULL,'2026-04-06 03:48:11','2026-04-06 03:43:11','2026-04-06 03:43:11'),
(5,'9b63875d-6562-4d10-b03c-a7ad114b8530',NULL,'pending',NULL,'2026-04-17 10:41:37','2026-04-17 10:36:37','2026-04-17 10:36:37'),
(6,'beaa7f84-6a8d-4c97-a032-fd41541875df',NULL,'pending',NULL,'2026-04-28 22:29:48','2026-04-28 22:24:48','2026-04-28 22:24:48'),
(7,'ed02a733-b712-4359-b588-85b721fed69a',NULL,'pending',NULL,'2026-04-30 13:51:09','2026-04-30 13:46:09','2026-04-30 13:46:09'),
(8,'8035adef-24b6-4a44-b421-c08338264b05',NULL,'pending',NULL,'2026-05-24 18:13:43','2026-05-24 18:08:43','2026-05-24 18:08:43'),
(9,'4c51f760-0858-42df-a24b-6f8f0f786634',NULL,'pending',NULL,'2026-05-26 13:48:39','2026-05-26 13:43:39','2026-05-26 13:43:39');
/*!40000 ALTER TABLE `web_qr_sessions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `webhook_calls`
--

DROP TABLE IF EXISTS `webhook_calls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `webhook_calls` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `url` varchar(191) NOT NULL,
  `headers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`headers`)),
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `exception` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_calls`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `webhook_calls` WRITE;
/*!40000 ALTER TABLE `webhook_calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook_calls` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `worlds`
--

DROP TABLE IF EXISTS `worlds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `worlds` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `worlds`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `worlds` WRITE;
/*!40000 ALTER TABLE `worlds` DISABLE KEYS */;
/*!40000 ALTER TABLE `worlds` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-06-08 12:40:36
