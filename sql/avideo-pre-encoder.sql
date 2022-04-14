-- MariaDB dump 10.19  Distrib 10.5.9-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: AVideo
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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `clean_name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nextVideoOrder` int(2) NOT NULL DEFAULT 0,
  `parentId` int(11) NOT NULL DEFAULT 0,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `iconClass` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fa fa-folder',
  `users_id` int(11) NOT NULL DEFAULT 1,
  `private` tinyint(1) DEFAULT 0,
  `allow_download` tinyint(1) DEFAULT 1,
  `order` int(11) DEFAULT NULL,
  `suggested` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clean_name_UNIQUE` (`clean_name`),
  KEY `fk_categories_users1_idx` (`users_id`),
  KEY `clean_name_INDEX2` (`clean_name`),
  KEY `sortcategoryOrderIndex` (`order`),
  KEY `category_name_idx` (`name`),
  KEY `categoriesindex9suggested` (`suggested`),
  FULLTEXT KEY `index7cname` (`name`),
  FULLTEXT KEY `index8cdescr` (`description`),
  CONSTRAINT `fk_categories_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Default','default','',0,0,'2022-04-13 23:50:46','2022-04-13 23:50:46','fa fa-folder',1,0,1,NULL,NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_has_users_groups`
--

DROP TABLE IF EXISTS `categories_has_users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories_has_users_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categories_id` int(11) NOT NULL,
  `users_groups_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'a',
  PRIMARY KEY (`id`),
  KEY `fk_categories_has_users_groups_users_groups1_idx` (`users_groups_id`),
  KEY `fk_categories_has_users_groups_categories1_idx` (`categories_id`),
  CONSTRAINT `fk_categories_has_users_groups_categories1` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_categories_has_users_groups_users_groups1` FOREIGN KEY (`users_groups_id`) REFERENCES `users_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_has_users_groups`
--

LOCK TABLES `categories_has_users_groups` WRITE;
/*!40000 ALTER TABLE `categories_has_users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories_has_users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_type_cache`
--

DROP TABLE IF EXISTS `category_type_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_type_cache` (
  `categoryId` int(11) NOT NULL,
  `type` int(2) NOT NULL DEFAULT 0 COMMENT '0=both, 1=audio, 2=video',
  `manualSet` int(1) NOT NULL DEFAULT 0 COMMENT '0=auto, 1=manual',
  UNIQUE KEY `categoryId` (`categoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_type_cache`
--

LOCK TABLES `category_type_cache` WRITE;
/*!40000 ALTER TABLE `category_type_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_type_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `videos_id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `comments_id_pai` int(11) DEFAULT NULL,
  `pin` int(1) NOT NULL DEFAULT 0 COMMENT 'If = 1 will be on the top',
  PRIMARY KEY (`id`),
  KEY `fk_comments_videos1_idx` (`videos_id`),
  KEY `fk_comments_users1_idx` (`users_id`),
  KEY `fk_comments_comments1_idx` (`comments_id_pai`),
  CONSTRAINT `fk_comments_comments1` FOREIGN KEY (`comments_id_pai`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_videos1` FOREIGN KEY (`videos_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments_likes`
--

DROP TABLE IF EXISTS `comments_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `like` int(1) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `users_id` int(11) NOT NULL,
  `comments_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comments_likes_users1_idx` (`users_id`),
  KEY `fk_comments_likes_comments1_idx` (`comments_id`),
  CONSTRAINT `fk_comments_likes_comments1` FOREIGN KEY (`comments_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_likes_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_likes`
--

LOCK TABLES `comments_likes` WRITE;
/*!40000 ALTER TABLE `comments_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configurations`
--

DROP TABLE IF EXISTS `configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configurations` (
  `id` int(11) NOT NULL,
  `video_resolution` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `users_id` int(11) NOT NULL,
  `version` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `webSiteTitle` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AVideo',
  `language` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `contactEmail` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modified` datetime NOT NULL,
  `created` datetime NOT NULL,
  `authGoogle_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authGoogle_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authGoogle_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `authFacebook_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authFacebook_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authFacebook_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `authCanUploadVideos` tinyint(1) NOT NULL DEFAULT 0,
  `authCanViewChart` tinyint(2) NOT NULL DEFAULT 0,
  `authCanComment` tinyint(1) NOT NULL DEFAULT 1,
  `head` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_small` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adsense` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mode` enum('Youtube','Gallery') COLLATE utf8mb4_unicode_ci DEFAULT 'Youtube',
  `disable_analytics` tinyint(1) DEFAULT 0,
  `disable_youtubeupload` tinyint(1) DEFAULT 0,
  `allow_download` tinyint(1) DEFAULT 0,
  `session_timeout` int(11) DEFAULT 3600,
  `autoplay` tinyint(1) DEFAULT NULL,
  `theme` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT 'default',
  `smtp` tinyint(1) DEFAULT NULL,
  `smtpAuth` tinyint(1) DEFAULT NULL,
  `smtpSecure` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '''ssl''; // secure transfer enabled REQUIRED for Gmail',
  `smtpHost` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '"smtp.gmail.com"',
  `smtpUsername` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '"email@gmail.com"',
  `smtpPassword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtpPort` int(11) DEFAULT NULL,
  `encoderURL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_configurations_users1_idx` (`users_id`),
  CONSTRAINT `fk_configurations_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configurations`
--

LOCK TABLES `configurations` WRITE;
/*!40000 ALTER TABLE `configurations` DISABLE KEYS */;
INSERT INTO `configurations` VALUES (1,'858:480',1,'11.7','AVideo','us','root@localhost','2022-04-13 23:50:46','2022-04-13 23:50:46',NULL,NULL,0,NULL,NULL,0,0,0,1,NULL,NULL,NULL,NULL,'Youtube',0,0,0,3600,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'https://encoder1.wwbn.net/');
/*!40000 ALTER TABLE `configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `like` int(1) NOT NULL DEFAULT 0 COMMENT '1 = Like\n0 = Does not metter\n-1 = Dislike',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `videos_id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_likes_videos1_idx` (`videos_id`),
  KEY `fk_likes_users1_idx` (`users_id`),
  KEY `likes_likes_idx` (`like`),
  CONSTRAINT `fk_likes_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_likes_videos1` FOREIGN KEY (`videos_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlists`
--

DROP TABLE IF EXISTS `playlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playlists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `users_id` int(11) NOT NULL,
  `status` enum('public','private','unlisted','favorite','watch_later') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'public',
  `showOnTV` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_playlists_users1_idx` (`users_id`),
  KEY `showOnTVindex3` (`showOnTV`),
  CONSTRAINT `fk_playlists_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlists`
--

LOCK TABLES `playlists` WRITE;
/*!40000 ALTER TABLE `playlists` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlists_has_videos`
--

DROP TABLE IF EXISTS `playlists_has_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playlists_has_videos` (
  `playlists_id` int(11) NOT NULL,
  `videos_id` int(11) NOT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`playlists_id`,`videos_id`),
  KEY `fk_playlists_has_videos_videos1_idx` (`videos_id`),
  KEY `fk_playlists_has_videos_playlists1_idx` (`playlists_id`),
  CONSTRAINT `fk_playlists_has_videos_playlists1` FOREIGN KEY (`playlists_id`) REFERENCES `playlists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_playlists_has_videos_videos1` FOREIGN KEY (`videos_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlists_has_videos`
--

LOCK TABLES `playlists_has_videos` WRITE;
/*!40000 ALTER TABLE `playlists_has_videos` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlists_has_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `object_data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dirName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pluginversion` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid_UNIQUE` (`uuid`),
  KEY `plugin_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
INSERT INTO `plugins` VALUES (1,'a06505bf-3570-4b1f-977a-fd0e5cab205d','active','2022-04-13 23:50:46','2022-04-13 23:50:46','','Gallery','Gallery','1.0'),(2,'layout84-8f5a-4d1b-b912-172c608bf9e3','active','2022-04-13 23:50:47','2022-04-13 23:50:47','{\"categoriesTopButtons\":false,\"categoriesTopButtonsShowOnlyOnFirstPage\":true,\"categoriesTopButtonsShowVideosCount\":false,\"categoriesTopButtonsFluid\":true,\"pageLoader\":{\"type\":{\"0\":\"-- Random\",\"avideo\":\"Avideo\",\"circle\":\"Circle\",\"default\":\"Default\",\"dual-ring\":\"Dual-ring\",\"ellipsis\":\"Ellipsis\",\"facebook\":\"Facebook\",\"grid\":\"Grid\",\"heart\":\"Heart\",\"hourglass\":\"Hourglass\",\"jumpingDots\":\"JumpingDots\",\"loaderXLVI\":\"LoaderXLVI\",\"matrix\":\"Matrix\",\"ring\":\"Ring\",\"ripple\":\"Ripple\",\"roller\":\"Roller\",\"spinner\":\"Spinner\"},\"value\":\"avideo\"}}','Layout','Layout','1.1'),(3,'55a4fa56-8a30-48d4-a0fb-8aa6b3fuser3','active','2022-04-13 23:50:47','2022-04-13 23:50:47','{\"nonAdminCannotDownload\":false,\"userCanAllowFilesDownload\":false,\"userCanAllowFilesShare\":false,\"userCanAllowFilesDownloadSelectPerVideo\":false,\"userCanAllowFilesShareSelectPerVideo\":false,\"blockEmbedFromSharedVideos\":true,\"userCanProtectVideosWithPassword\":true,\"userCanChangeVideoOwner\":false,\"usersCanCreateNewCategories\":false,\"userCanNotChangeCategory\":false,\"userCanNotChangeUserGroup\":false,\"userDefaultUserGroup\":{\"type\":[\"Default\"],\"value\":0},\"userMustBeLoggedIn\":false,\"userMustBeLoggedInCloseButtonURL\":\"\",\"onlyVerifiedEmailCanUpload\":false,\"sendVerificationMailAutomatic\":false,\"verificationMailTextLine1\":\"Just a quick note to say a big welcome and an even bigger thank you for registering\",\"verificationMailTextLine2\":\"Cheers, %s Team.\",\"verificationMailTextLine3\":\"You are just one click away from starting your journey with %s!\",\"verificationMailTextLine4\":\"All you need to do is to verify your e-mail by clicking the link below\",\"unverifiedEmailsCanNOTLogin\":false,\"unverifiedEmailsCanNOTComment\":false,\"newUsersCanStream\":false,\"doNotIdentifyByName\":false,\"doNotIdentifyByEmail\":false,\"doNotIdentifyByUserName\":false,\"hideRemoveChannelFromModeYoutube\":false,\"showChannelBannerOnModeYoutube\":false,\"showChannelHomeTab\":true,\"showChannelVideosTab\":true,\"showChannelProgramsTab\":true,\"showBigVideoOnChannelVideosTab\":true,\"encryptPasswordsWithSalt\":false,\"requestCaptchaAfterLoginsAttempts\":0,\"disableSignOutButton\":false,\"disableNativeSignUp\":false,\"disableCompanySignUp\":true,\"disableNativeSignIn\":false,\"disablePersonalInfo\":true,\"loginBackgroundAnimation\":{\"type\":{\"0\":\"-- None\",\"1\":\"-- Random\",\"Animated\":\"Animated\",\"Animated3\":\"Animated3\",\"Animated4\":\"Animated4\",\"Bokeh\":\"Bokeh\",\"Breeze\":\"Breeze\"},\"value\":1},\"userCanChangeUsername\":true,\"signInOnRight\":false,\"doNotShowRightProfile\":false,\"doNotShowLeftProfile\":false,\"forceLoginToBeTheEmail\":false,\"emailMustBeUnique\":false,\"messageToAppearBelowLoginBox\":{\"type\":\"textarea\",\"value\":\"\"},\"messageToAppearAboveSignUpBox\":{\"type\":\"textarea\",\"value\":\"\"},\"keepViewerOnChannel\":false,\"showLeaveChannelButton\":false,\"addChannelNameOnLinks\":true,\"doNotShowTopBannerOnChannel\":false,\"doNotShowMyChannelNameOnBasicInfo\":false,\"doNotShowMyAnalyticsCodeOnBasicInfo\":false,\"doNotShowMyAboutOnBasicInfo\":false,\"MyChannelLabel\":\"My Channel\",\"afterLoginGoToMyChannel\":false,\"afterLoginGoToURL\":\"\",\"afterLogoffGoToMyChannel\":false,\"afterLogoffGoToURL\":\"\",\"allowDonationLink\":false,\"donationButtonLabel\":\"Donation\",\"allowWalletDirectTransferDonation\":false,\"UsersCanCustomizeWalletDirectTransferDonation\":false,\"donationWalletButtonLabel\":\"Donate from your wallet\",\"disableCaptchaOnWalletDirectTransferDonation\":false,\"showEmailVerifiedMark\":true,\"Checkmark1Enabled\":true,\"Checkmark1HTML\":\"<i class=\\\"fas fa-check\\\" data-toggle=\\\"tooltip\\\" data-placement=\\\"bottom\\\" title=\\\"Trustable User\\\"><\\/i>\",\"Checkmark2Enabled\":true,\"Checkmark2HTML\":\"<i class=\\\"fas fa-shield-alt\\\" data-toggle=\\\"tooltip\\\" data-placement=\\\"bottom\\\" title=\\\"Official User\\\"><\\/i>\",\"Checkmark3Enabled\":true,\"Checkmark3HTML\":\"<i class=\\\"fas fa-certificate fa-spin\\\" data-toggle=\\\"tooltip\\\" data-placement=\\\"bottom\\\" title=\\\"Premium User\\\"><\\/i>\",\"autoSaveUsersOnCategorySelectedGroups\":false,\"enableExtraInfo\":false,\"videosSearchAlsoSearchesOnChannelName\":false,\"doNotShowPhoneMyAccount\":true,\"doNotShowPhoneOnSignup\":true,\"enableAffiliation\":false}','CustomizeUser','CustomizeUser','3.0'),(4,'55a4fa56-8a30-48d4-a0fb-8aa6b3f69033','active','2022-04-13 23:50:47','2022-04-13 23:50:47','{\"logoMenuBarURL\":\"\",\"encoderNetwork\":\"https:\\/\\/network.wwbn.net\\/\",\"useEncoderNetworkRecomendation\":false,\"doNotShowEncoderNetwork\":true,\"doNotShowUploadButton\":false,\"uploadButtonDropdownIcon\":\"fas fa-video\",\"uploadButtonDropdownText\":\"\",\"encoderNetworkLabel\":\"\",\"doNotShowUploadMP4Button\":true,\"disablePDFUpload\":false,\"disableImageUpload\":false,\"disableZipUpload\":true,\"disableMP4Upload\":false,\"disableMP3Upload\":false,\"uploadMP4ButtonLabel\":\"\",\"doNotShowImportMP4Button\":true,\"importMP4ButtonLabel\":\"\",\"doNotShowEncoderButton\":false,\"encoderButtonLabel\":\"\",\"doNotShowEmbedButton\":false,\"embedBackgroundColor\":\"white\",\"embedButtonLabel\":\"\",\"embedCodeTemplate\":\"<div class=\\\"embed-responsive embed-responsive-16by9\\\"><iframe width=\\\"640\\\" height=\\\"360\\\" style=\\\"max-width: 100%;max-height: 100%; border:none;\\\" src=\\\"{embedURL}\\\" frameborder=\\\"0\\\" allowfullscreen=\\\"allowfullscreen\\\" allow=\\\"autoplay\\\" scrolling=\\\"no\\\" videoLengthInSeconds=\\\"{videoLengthInSeconds}\\\">iFrame is not supported!<\\/iframe><\\/div>\",\"embedCodeTemplateObject\":\"<div class=\\\"embed-responsive embed-responsive-16by9\\\"><object width=\\\"640\\\" height=\\\"360\\\"><param name=\\\"movie\\\" value=\\\"{embedURL}\\\"><\\/param><param name=\\\"allowFullScreen\\\" value=\\\"true\\\"><\\/param><param name=\\\"allowscriptaccess\\\" value=\\\"always\\\"><\\/param><embed src=\\\"{embedURL}\\\" allowscriptaccess=\\\"always\\\" allowfullscreen=\\\"true\\\" width=\\\"640\\\" height=\\\"360\\\"><\\/embed><\\/object><\\/div>\",\"htmlCodeTemplate\":\"<a href=\\\"{permaLink}\\\"><img src=\\\"{imgSRC}\\\">{title}<\\/a>\",\"BBCodeTemplate\":\"[url={permaLink}][img]{imgSRC}[\\/img]{title}[\\/url]\",\"embedControls\":{\"type\":{\"-1\":\"Basic Controls\",\"0\":\"No Controls\",\"1\":\"All controls\"},\"value\":1},\"embedAutoplay\":false,\"embedLoop\":false,\"embedStartMuted\":false,\"embedShowinfo\":true,\"doNotShowEncoderHLS\":false,\"doNotShowEncoderResolutionLow\":false,\"doNotShowEncoderResolutionSD\":false,\"doNotShowEncoderResolutionHD\":false,\"openEncoderInIFrame\":false,\"showOnlyEncoderAutomaticResolutions\":true,\"doNotShowEncoderAutomaticHLS\":false,\"doNotShowEncoderAutomaticMP4\":false,\"doNotShowEncoderAutomaticWebm\":false,\"doNotShowEncoderAutomaticAudio\":false,\"saveOriginalVideoResolution\":false,\"doNotShowExtractAudio\":false,\"doNotShowCreateVideoSpectrum\":false,\"doNotShowLeftMenuAudioAndVideoButtons\":false,\"doNotShowWebsiteOnContactForm\":false,\"doNotUseXsendFile\":false,\"makeVideosInactiveAfterEncode\":false,\"makeVideosUnlistedAfterEncode\":false,\"usePermalinks\":false,\"useVideoIDOnSEOLinks\":true,\"disableAnimatedGif\":false,\"removeBrowserChannelLinkFromMenu\":false,\"EnableMinifyJS\":false,\"disableShareAndPlaylist\":false,\"disableShareOnly\":false,\"disableEmailSharing\":false,\"splitBulkEmailSend\":50,\"disableComments\":false,\"commentsMaxLength\":200,\"commentsNoIndex\":false,\"disableYoutubePlayerIntegration\":false,\"utf8Encode\":false,\"utf8Decode\":false,\"menuBarHTMLCode\":{\"type\":\"textarea\",\"value\":\"\"},\"underMenuBarHTMLCode\":{\"type\":\"textarea\",\"value\":\"\"},\"footerHTMLCode\":{\"type\":\"textarea\",\"value\":\"\"},\"signInOnRight\":true,\"signInOnLeft\":true,\"forceCategory\":false,\"showCategoryTopImages\":true,\"autoPlayAjax\":false,\"disableInstallPWAButton\":false,\"disablePlayLink\":false,\"disableHelpLeftMenu\":false,\"disableAboutLeftMenu\":false,\"disableContactLeftMenu\":false,\"disableAnimations\":false,\"disableNavbar\":false,\"disableNavBarInsideIframe\":true,\"autoHideNavbar\":true,\"autoHideNavbarInSeconds\":0,\"videosCDN\":\"\",\"useFFMPEGToGenerateThumbs\":false,\"thumbsWidthPortrait\":170,\"thumbsHeightPortrait\":250,\"thumbsWidthLandscape\":640,\"thumbsHeightLandscape\":360,\"usePreloadLowResolutionImages\":false,\"showImageDownloadOption\":false,\"doNotDisplayViews\":false,\"doNotDisplayLikes\":false,\"doNotDisplayCategoryLeftMenu\":false,\"doNotDisplayCategory\":false,\"doNotDisplayGroupsTags\":false,\"doNotDisplayPluginsTags\":false,\"showNotRatedLabel\":false,\"showShareMenuOpenByDefault\":false,\"showShareButton_Facebook\":true,\"showShareButton_Twitter\":true,\"showShareButton_Tumblr\":true,\"showShareButton_Pinterest\":true,\"showShareButton_Reddit\":true,\"showShareButton_LinkedIn\":true,\"showShareButton_Wordpress\":true,\"showShareButton_Pinboard\":true,\"showShareButton_Gab\":true,\"showShareButton_CloutHub\":true,\"askRRatingConfirmationBeforePlay_G\":false,\"askRRatingConfirmationBeforePlay_PG\":false,\"askRRatingConfirmationBeforePlay_PG13\":false,\"askRRatingConfirmationBeforePlay_R\":false,\"askRRatingConfirmationBeforePlay_NC17\":true,\"askRRatingConfirmationBeforePlay_MA\":true,\"filterRRating\":false,\"doNotShowLeftHomeButton\":false,\"doNotShowLeftTrendingButton\":false,\"CategoryLabel\":\"Categories\",\"ShowAllVideosOnCategory\":false,\"hideCategoryVideosCount\":false,\"hideEditAdvancedFromVideosManager\":false,\"paidOnlyUsersTellWhatVideoIs\":false,\"paidOnlyShowLabels\":false,\"paidOnlyLabel\":\"Premium\",\"paidOnlyFreeLabel\":\"Free\",\"removeSubscribeButton\":false,\"removeThumbsUpAndDown\":false,\"videoNotFoundText\":{\"type\":\"textarea\",\"value\":\"\"},\"siteMapRowsLimit\":100,\"siteMapUTF8Fix\":false,\"showPrivateVideosOnSitemap\":false,\"enableOldPassHashCheck\":true,\"disableHTMLDescription\":false,\"disableVideoSwap\":false,\"makeSwapVideosOnlyForAdmin\":false,\"disableCopyEmbed\":false,\"disableDownloadVideosList\":false,\"videosManegerRowCount\":\"[10, 25, 50, -1]\",\"videosListRowCount\":\"[10, 20, 30, 40, 50]\",\"videosManegerBulkActionButtons\":true,\"twitter_site\":\"@127001\",\"twitter_player\":true,\"twitter_summary_large_image\":false,\"footerStyle\":\"position: fixed;bottom: 0;width: 100%;\",\"disableVideoTags\":false,\"doNotAllowEncoderOverwriteStatus\":false,\"doNotAllowUpdateVideoId\":false,\"makeVideosIDHarderToGuess\":false,\"timeZone\":{\"type\":[\"Africa\\/Abidjan\",\"Africa\\/Accra\",\"Africa\\/Addis_Ababa\",\"Africa\\/Algiers\",\"Africa\\/Asmara\",\"Africa\\/Bamako\",\"Africa\\/Bangui\",\"Africa\\/Banjul\",\"Africa\\/Bissau\",\"Africa\\/Blantyre\",\"Africa\\/Brazzaville\",\"Africa\\/Bujumbura\",\"Africa\\/Cairo\",\"Africa\\/Casablanca\",\"Africa\\/Ceuta\",\"Africa\\/Conakry\",\"Africa\\/Dakar\",\"Africa\\/Dar_es_Salaam\",\"Africa\\/Djibouti\",\"Africa\\/Douala\",\"Africa\\/El_Aaiun\",\"Africa\\/Freetown\",\"Africa\\/Gaborone\",\"Africa\\/Harare\",\"Africa\\/Johannesburg\",\"Africa\\/Juba\",\"Africa\\/Kampala\",\"Africa\\/Khartoum\",\"Africa\\/Kigali\",\"Africa\\/Kinshasa\",\"Africa\\/Lagos\",\"Africa\\/Libreville\",\"Africa\\/Lome\",\"Africa\\/Luanda\",\"Africa\\/Lubumbashi\",\"Africa\\/Lusaka\",\"Africa\\/Malabo\",\"Africa\\/Maputo\",\"Africa\\/Maseru\",\"Africa\\/Mbabane\",\"Africa\\/Mogadishu\",\"Africa\\/Monrovia\",\"Africa\\/Nairobi\",\"Africa\\/Ndjamena\",\"Africa\\/Niamey\",\"Africa\\/Nouakchott\",\"Africa\\/Ouagadougou\",\"Africa\\/Porto-Novo\",\"Africa\\/Sao_Tome\",\"Africa\\/Tripoli\",\"Africa\\/Tunis\",\"Africa\\/Windhoek\",\"America\\/Adak\",\"America\\/Anchorage\",\"America\\/Anguilla\",\"America\\/Antigua\",\"America\\/Araguaina\",\"America\\/Argentina\\/Buenos_Aires\",\"America\\/Argentina\\/Catamarca\",\"America\\/Argentina\\/Cordoba\",\"America\\/Argentina\\/Jujuy\",\"America\\/Argentina\\/La_Rioja\",\"America\\/Argentina\\/Mendoza\",\"America\\/Argentina\\/Rio_Gallegos\",\"America\\/Argentina\\/Salta\",\"America\\/Argentina\\/San_Juan\",\"America\\/Argentina\\/San_Luis\",\"America\\/Argentina\\/Tucuman\",\"America\\/Argentina\\/Ushuaia\",\"America\\/Aruba\",\"America\\/Asuncion\",\"America\\/Atikokan\",\"America\\/Bahia\",\"America\\/Bahia_Banderas\",\"America\\/Barbados\",\"America\\/Belem\",\"America\\/Belize\",\"America\\/Blanc-Sablon\",\"America\\/Boa_Vista\",\"America\\/Bogota\",\"America\\/Boise\",\"America\\/Cambridge_Bay\",\"America\\/Campo_Grande\",\"America\\/Cancun\",\"America\\/Caracas\",\"America\\/Cayenne\",\"America\\/Cayman\",\"America\\/Chicago\",\"America\\/Chihuahua\",\"America\\/Costa_Rica\",\"America\\/Creston\",\"America\\/Cuiaba\",\"America\\/Curacao\",\"America\\/Danmarkshavn\",\"America\\/Dawson\",\"America\\/Dawson_Creek\",\"America\\/Denver\",\"America\\/Detroit\",\"America\\/Dominica\",\"America\\/Edmonton\",\"America\\/Eirunepe\",\"America\\/El_Salvador\",\"America\\/Fort_Nelson\",\"America\\/Fortaleza\",\"America\\/Glace_Bay\",\"America\\/Goose_Bay\",\"America\\/Grand_Turk\",\"America\\/Grenada\",\"America\\/Guadeloupe\",\"America\\/Guatemala\",\"America\\/Guayaquil\",\"America\\/Guyana\",\"America\\/Halifax\",\"America\\/Havana\",\"America\\/Hermosillo\",\"America\\/Indiana\\/Indianapolis\",\"America\\/Indiana\\/Knox\",\"America\\/Indiana\\/Marengo\",\"America\\/Indiana\\/Petersburg\",\"America\\/Indiana\\/Tell_City\",\"America\\/Indiana\\/Vevay\",\"America\\/Indiana\\/Vincennes\",\"America\\/Indiana\\/Winamac\",\"America\\/Inuvik\",\"America\\/Iqaluit\",\"America\\/Jamaica\",\"America\\/Juneau\",\"America\\/Kentucky\\/Louisville\",\"America\\/Kentucky\\/Monticello\",\"America\\/Kralendijk\",\"America\\/La_Paz\",\"America\\/Lima\",\"America\\/Los_Angeles\",\"America\\/Lower_Princes\",\"America\\/Maceio\",\"America\\/Managua\",\"America\\/Manaus\",\"America\\/Marigot\",\"America\\/Martinique\",\"America\\/Matamoros\",\"America\\/Mazatlan\",\"America\\/Menominee\",\"America\\/Merida\",\"America\\/Metlakatla\",\"America\\/Mexico_City\",\"America\\/Miquelon\",\"America\\/Moncton\",\"America\\/Monterrey\",\"America\\/Montevideo\",\"America\\/Montserrat\",\"America\\/Nassau\",\"America\\/New_York\",\"America\\/Nipigon\",\"America\\/Nome\",\"America\\/Noronha\",\"America\\/North_Dakota\\/Beulah\",\"America\\/North_Dakota\\/Center\",\"America\\/North_Dakota\\/New_Salem\",\"America\\/Nuuk\",\"America\\/Ojinaga\",\"America\\/Panama\",\"America\\/Pangnirtung\",\"America\\/Paramaribo\",\"America\\/Phoenix\",\"America\\/Port-au-Prince\",\"America\\/Port_of_Spain\",\"America\\/Porto_Velho\",\"America\\/Puerto_Rico\",\"America\\/Punta_Arenas\",\"America\\/Rainy_River\",\"America\\/Rankin_Inlet\",\"America\\/Recife\",\"America\\/Regina\",\"America\\/Resolute\",\"America\\/Rio_Branco\",\"America\\/Santarem\",\"America\\/Santiago\",\"America\\/Santo_Domingo\",\"America\\/Sao_Paulo\",\"America\\/Scoresbysund\",\"America\\/Sitka\",\"America\\/St_Barthelemy\",\"America\\/St_Johns\",\"America\\/St_Kitts\",\"America\\/St_Lucia\",\"America\\/St_Thomas\",\"America\\/St_Vincent\",\"America\\/Swift_Current\",\"America\\/Tegucigalpa\",\"America\\/Thule\",\"America\\/Thunder_Bay\",\"America\\/Tijuana\",\"America\\/Toronto\",\"America\\/Tortola\",\"America\\/Vancouver\",\"America\\/Whitehorse\",\"America\\/Winnipeg\",\"America\\/Yakutat\",\"America\\/Yellowknife\",\"Antarctica\\/Casey\",\"Antarctica\\/Davis\",\"Antarctica\\/DumontDUrville\",\"Antarctica\\/Macquarie\",\"Antarctica\\/Mawson\",\"Antarctica\\/McMurdo\",\"Antarctica\\/Palmer\",\"Antarctica\\/Rothera\",\"Antarctica\\/Syowa\",\"Antarctica\\/Troll\",\"Antarctica\\/Vostok\",\"Arctic\\/Longyearbyen\",\"Asia\\/Aden\",\"Asia\\/Almaty\",\"Asia\\/Amman\",\"Asia\\/Anadyr\",\"Asia\\/Aqtau\",\"Asia\\/Aqtobe\",\"Asia\\/Ashgabat\",\"Asia\\/Atyrau\",\"Asia\\/Baghdad\",\"Asia\\/Bahrain\",\"Asia\\/Baku\",\"Asia\\/Bangkok\",\"Asia\\/Barnaul\",\"Asia\\/Beirut\",\"Asia\\/Bishkek\",\"Asia\\/Brunei\",\"Asia\\/Chita\",\"Asia\\/Choibalsan\",\"Asia\\/Colombo\",\"Asia\\/Damascus\",\"Asia\\/Dhaka\",\"Asia\\/Dili\",\"Asia\\/Dubai\",\"Asia\\/Dushanbe\",\"Asia\\/Famagusta\",\"Asia\\/Gaza\",\"Asia\\/Hebron\",\"Asia\\/Ho_Chi_Minh\",\"Asia\\/Hong_Kong\",\"Asia\\/Hovd\",\"Asia\\/Irkutsk\",\"Asia\\/Jakarta\",\"Asia\\/Jayapura\",\"Asia\\/Jerusalem\",\"Asia\\/Kabul\",\"Asia\\/Kamchatka\",\"Asia\\/Karachi\",\"Asia\\/Kathmandu\",\"Asia\\/Khandyga\",\"Asia\\/Kolkata\",\"Asia\\/Krasnoyarsk\",\"Asia\\/Kuala_Lumpur\",\"Asia\\/Kuching\",\"Asia\\/Kuwait\",\"Asia\\/Macau\",\"Asia\\/Magadan\",\"Asia\\/Makassar\",\"Asia\\/Manila\",\"Asia\\/Muscat\",\"Asia\\/Nicosia\",\"Asia\\/Novokuznetsk\",\"Asia\\/Novosibirsk\",\"Asia\\/Omsk\",\"Asia\\/Oral\",\"Asia\\/Phnom_Penh\",\"Asia\\/Pontianak\",\"Asia\\/Pyongyang\",\"Asia\\/Qatar\",\"Asia\\/Qostanay\",\"Asia\\/Qyzylorda\",\"Asia\\/Riyadh\",\"Asia\\/Sakhalin\",\"Asia\\/Samarkand\",\"Asia\\/Seoul\",\"Asia\\/Shanghai\",\"Asia\\/Singapore\",\"Asia\\/Srednekolymsk\",\"Asia\\/Taipei\",\"Asia\\/Tashkent\",\"Asia\\/Tbilisi\",\"Asia\\/Tehran\",\"Asia\\/Thimphu\",\"Asia\\/Tokyo\",\"Asia\\/Tomsk\",\"Asia\\/Ulaanbaatar\",\"Asia\\/Urumqi\",\"Asia\\/Ust-Nera\",\"Asia\\/Vientiane\",\"Asia\\/Vladivostok\",\"Asia\\/Yakutsk\",\"Asia\\/Yangon\",\"Asia\\/Yekaterinburg\",\"Asia\\/Yerevan\",\"Atlantic\\/Azores\",\"Atlantic\\/Bermuda\",\"Atlantic\\/Canary\",\"Atlantic\\/Cape_Verde\",\"Atlantic\\/Faroe\",\"Atlantic\\/Madeira\",\"Atlantic\\/Reykjavik\",\"Atlantic\\/South_Georgia\",\"Atlantic\\/St_Helena\",\"Atlantic\\/Stanley\",\"Australia\\/Adelaide\",\"Australia\\/Brisbane\",\"Australia\\/Broken_Hill\",\"Australia\\/Darwin\",\"Australia\\/Eucla\",\"Australia\\/Hobart\",\"Australia\\/Lindeman\",\"Australia\\/Lord_Howe\",\"Australia\\/Melbourne\",\"Australia\\/Perth\",\"Australia\\/Sydney\",\"Europe\\/Amsterdam\",\"Europe\\/Andorra\",\"Europe\\/Astrakhan\",\"Europe\\/Athens\",\"Europe\\/Belgrade\",\"Europe\\/Berlin\",\"Europe\\/Bratislava\",\"Europe\\/Brussels\",\"Europe\\/Bucharest\",\"Europe\\/Budapest\",\"Europe\\/Busingen\",\"Europe\\/Chisinau\",\"Europe\\/Copenhagen\",\"Europe\\/Dublin\",\"Europe\\/Gibraltar\",\"Europe\\/Guernsey\",\"Europe\\/Helsinki\",\"Europe\\/Isle_of_Man\",\"Europe\\/Istanbul\",\"Europe\\/Jersey\",\"Europe\\/Kaliningrad\",\"Europe\\/Kiev\",\"Europe\\/Kirov\",\"Europe\\/Lisbon\",\"Europe\\/Ljubljana\",\"Europe\\/London\",\"Europe\\/Luxembourg\",\"Europe\\/Madrid\",\"Europe\\/Malta\",\"Europe\\/Mariehamn\",\"Europe\\/Minsk\",\"Europe\\/Monaco\",\"Europe\\/Moscow\",\"Europe\\/Oslo\",\"Europe\\/Paris\",\"Europe\\/Podgorica\",\"Europe\\/Prague\",\"Europe\\/Riga\",\"Europe\\/Rome\",\"Europe\\/Samara\",\"Europe\\/San_Marino\",\"Europe\\/Sarajevo\",\"Europe\\/Saratov\",\"Europe\\/Simferopol\",\"Europe\\/Skopje\",\"Europe\\/Sofia\",\"Europe\\/Stockholm\",\"Europe\\/Tallinn\",\"Europe\\/Tirane\",\"Europe\\/Ulyanovsk\",\"Europe\\/Uzhgorod\",\"Europe\\/Vaduz\",\"Europe\\/Vatican\",\"Europe\\/Vienna\",\"Europe\\/Vilnius\",\"Europe\\/Volgograd\",\"Europe\\/Warsaw\",\"Europe\\/Zagreb\",\"Europe\\/Zaporozhye\",\"Europe\\/Zurich\",\"Indian\\/Antananarivo\",\"Indian\\/Chagos\",\"Indian\\/Christmas\",\"Indian\\/Cocos\",\"Indian\\/Comoro\",\"Indian\\/Kerguelen\",\"Indian\\/Mahe\",\"Indian\\/Maldives\",\"Indian\\/Mauritius\",\"Indian\\/Mayotte\",\"Indian\\/Reunion\",\"Pacific\\/Apia\",\"Pacific\\/Auckland\",\"Pacific\\/Bougainville\",\"Pacific\\/Chatham\",\"Pacific\\/Chuuk\",\"Pacific\\/Easter\",\"Pacific\\/Efate\",\"Pacific\\/Fakaofo\",\"Pacific\\/Fiji\",\"Pacific\\/Funafuti\",\"Pacific\\/Galapagos\",\"Pacific\\/Gambier\",\"Pacific\\/Guadalcanal\",\"Pacific\\/Guam\",\"Pacific\\/Honolulu\",\"Pacific\\/Kanton\",\"Pacific\\/Kiritimati\",\"Pacific\\/Kosrae\",\"Pacific\\/Kwajalein\",\"Pacific\\/Majuro\",\"Pacific\\/Marquesas\",\"Pacific\\/Midway\",\"Pacific\\/Nauru\",\"Pacific\\/Niue\",\"Pacific\\/Norfolk\",\"Pacific\\/Noumea\",\"Pacific\\/Pago_Pago\",\"Pacific\\/Palau\",\"Pacific\\/Pitcairn\",\"Pacific\\/Pohnpei\",\"Pacific\\/Port_Moresby\",\"Pacific\\/Rarotonga\",\"Pacific\\/Saipan\",\"Pacific\\/Tahiti\",\"Pacific\\/Tarawa\",\"Pacific\\/Tongatapu\",\"Pacific\\/Wake\",\"Pacific\\/Wallis\",\"UTC\"],\"value\":0},\"keywords\":\"AVideo, videos, live, movies\",\"doNotSaveCacheOnFilesystem\":false,\"robotsTXT\":{\"type\":\"textarea\",\"value\":\"Allow: \\/plugin\\/Live\\/?*\\r\\nAllow: \\/plugin\\/PlayLists\\/*.css\\r\\nAllow: \\/plugin\\/PlayLists\\/*.js\\r\\nAllow: \\/plugin\\/TopMenu\\/*.css\\r\\nAllow: \\/plugin\\/TopMenu\\/*.js\\r\\nAllow: \\/plugin\\/SubtitleSwitcher\\/*.css\\r\\nAllow: \\/plugin\\/SubtitleSwitcher\\/*.js\\r\\nAllow: \\/plugin\\/Gallery\\/*.css\\r\\nAllow: \\/plugin\\/Gallery\\/*.js\\r\\nAllow: \\/plugin\\/YouPHPFlix2\\/*.png\\r\\nAllow: \\/plugin\\/Live\\/*.css\\r\\nAllow: \\/plugin\\/Live\\/*.js\\r\\nAllow: \\/plugin\\/*.css\\r\\nAllow: \\/plugin\\/*.js\\r\\nAllow: .js\\r\\nAllow: .css\\r\\nDisallow: \\/user\\r\\nDisallow: \\/plugin\\r\\nDisallow: \\/mvideos\\r\\nDisallow: \\/usersGroups\\r\\nDisallow: \\/charts\\r\\nDisallow: \\/upload\\r\\nDisallow: \\/comments\\r\\nDisallow: \\/subscribes\\r\\nDisallow: \\/update\\r\\nDisallow: \\/locale\\r\\nDisallow: \\/objects\\/*\\r\\nAllow: \\/plugin\\/Live\\/?*\\r\\nAllow: \\/plugin\\/LiveLink\\/?*\\r\\nAllow: \\/plugin\\/PlayLists\\/*.css\\r\\nAllow: \\/plugin\\/PlayLists\\/*.js\\r\\nAllow: \\/plugin\\/TopMenu\\/*.css\\r\\nAllow: \\/plugin\\/TopMenu\\/*.js\\r\\nAllow: \\/plugin\\/SubtitleSwitcher\\/*.css\\r\\nAllow: \\/plugin\\/SubtitleSwitcher\\/*.js\\r\\nAllow: \\/plugin\\/Gallery\\/*.css\\r\\nAllow: \\/plugin\\/Gallery\\/*.js\\r\\nAllow: \\/plugin\\/YouPHPFlix2\\/*.png\\r\\nAllow: \\/plugin\\/Live\\/*.css\\r\\nAllow: \\/plugin\\/Live\\/*.js\\r\\nAllow: \\/plugin\\/*.css\\r\\nAllow: \\/plugin\\/*.js\\r\\nAllow: .js\\r\\nAllow: .css\"}}','CustomizeAdvanced','CustomizeAdvanced','1.0'),(5,'e9a568e6-ef61-4dcc-aad0-0109e9be8e36','active','2022-04-13 23:50:47','2022-04-13 23:50:47','{\"skin\":\"avideo\",\"playbackRates\":\"[0.5, 1, 1.5, 2]\",\"playerCustomDataSetup\":\"\",\"showSocialShareOnEmbed\":true,\"showLoopButton\":true,\"showLogo\":false,\"showShareSocial\":true,\"showShareAutoplay\":true,\"forceAlwaysAutoplay\":false,\"showLogoOnEmbed\":false,\"showLogoAdjustScale\":\"0.4\",\"showLogoAdjustLeft\":\"-74px\",\"showLogoAdjustTop\":\"-22px;\",\"disableEmbedTopInfo\":false,\"contextMenuDisableEmbedOnly\":false,\"contextMenuLoop\":true,\"contextMenuCopyVideoURL\":true,\"contextMenuCopyVideoURLCurrentTime\":true,\"contextMenuCopyEmbedCode\":true,\"contextMenuShare\":true,\"playerFullHeight\":false}','PlayerSkins','PlayerSkins','1.1'),(6,'Permissions-5ee8405eaaa16','active','2022-04-13 23:50:47','2022-04-13 23:50:47','{}','Permissions','Permissions','1.0'),(7,'Scheduler-5ee8405eaaa16','active','2022-04-13 23:50:47','2022-04-13 23:50:47','{}','Scheduler','Scheduler','3.0');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secret` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscribes`
--

DROP TABLE IF EXISTS `subscribes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscribes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('a','i') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'a',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `users_id` int(11) NOT NULL DEFAULT 1 COMMENT 'subscribes to user channel',
  `notify` tinyint(1) NOT NULL DEFAULT 1,
  `subscriber_users_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subscribes_users1_idx` (`users_id`),
  KEY `fk_subscribes_users2_idx` (`subscriber_users_id`),
  CONSTRAINT `fk_subscribes_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_subscribes_users2` FOREIGN KEY (`subscriber_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscribes`
--

LOCK TABLES `subscribes` WRITE;
/*!40000 ALTER TABLE `subscribes` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscribes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(145) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `modified` datetime NOT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('a','i') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'a',
  `photoURL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastLogin` datetime DEFAULT NULL,
  `recoverPass` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `backgroundURL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `canStream` tinyint(1) DEFAULT NULL,
  `canUpload` tinyint(1) DEFAULT NULL,
  `canCreateMeet` tinyint(1) DEFAULT NULL,
  `canViewChart` tinyint(1) NOT NULL DEFAULT 0,
  `about` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channelName` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emailVerified` tinyint(1) NOT NULL DEFAULT 0,
  `analyticsCode` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `externalOptions` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `donationLink` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extra_info` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_company` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_UNIQUE` (`user`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin',NULL,'root@localhost','81dc9bdb52d04dc20036dbd8313ed055','2022-04-13 23:50:46','2022-04-13 23:50:46',1,'a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_affiliations`
--

DROP TABLE IF EXISTS `users_affiliations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_affiliations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `users_id_company` int(11) NOT NULL,
  `users_id_affiliate` int(11) NOT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_agree_date` datetime DEFAULT NULL,
  `affiliate_agree_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_users_affiliations_users1_idx` (`users_id_company`),
  KEY `fk_users_affiliations_users2_idx` (`users_id_affiliate`),
  CONSTRAINT `fk_users_affiliations_users1` FOREIGN KEY (`users_id_company`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_users_affiliations_users2` FOREIGN KEY (`users_id_affiliate`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_affiliations`
--

LOCK TABLES `users_affiliations` WRITE;
/*!40000 ALTER TABLE `users_affiliations` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_affiliations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_blob`
--

DROP TABLE IF EXISTS `users_blob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_blob` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blob` longblob DEFAULT NULL,
  `users_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_users_document_image_users1_idx` (`users_id`),
  CONSTRAINT `fk_users_document_image_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_blob`
--

LOCK TABLES `users_blob` WRITE;
/*!40000 ALTER TABLE `users_blob` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_blob` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_extra_info`
--

DROP TABLE IF EXISTS `users_extra_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_extra_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_type` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_options` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_default_value` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'a',
  `order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ordersortusers_extra_info` (`order`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_extra_info`
--

LOCK TABLES `users_extra_info` WRITE;
/*!40000 ALTER TABLE `users_extra_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_extra_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_has_users_groups`
--

DROP TABLE IF EXISTS `users_has_users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_has_users_groups` (
  `users_id` int(11) NOT NULL,
  `users_groups_id` int(11) NOT NULL,
  PRIMARY KEY (`users_id`,`users_groups_id`),
  UNIQUE KEY `index_user_groups_unique` (`users_groups_id`,`users_id`),
  KEY `fk_users_has_users_groups_users_groups1_idx` (`users_groups_id`),
  KEY `fk_users_has_users_groups_users1_idx` (`users_id`),
  CONSTRAINT `fk_users_has_users_groups_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_users_has_users_groups_users_groups1` FOREIGN KEY (`users_groups_id`) REFERENCES `users_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_has_users_groups`
--

LOCK TABLES `users_has_users_groups` WRITE;
/*!40000 ALTER TABLE `users_has_users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_has_users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `clean_title` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `views_count` int(11) NOT NULL DEFAULT 0,
  `views_count_25` int(11) DEFAULT 0,
  `views_count_50` int(11) DEFAULT 0,
  `views_count_75` int(11) DEFAULT 0,
  `views_count_100` int(11) DEFAULT 0,
  `status` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'e',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `users_id` int(11) NOT NULL,
  `categories_id` int(11) NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('audio','video','embed','linkVideo','linkAudio','torrent','pdf','image','gallery','article','serie','zip') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'video',
  `videoDownloadedLink` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int(10) unsigned NOT NULL DEFAULT 1,
  `rotation` smallint(6) DEFAULT 0,
  `zoom` float DEFAULT 1,
  `youtubeId` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `videoLink` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `next_videos_id` int(11) DEFAULT NULL,
  `isSuggested` int(1) NOT NULL DEFAULT 0,
  `trailer1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trailer2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trailer3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate` float(4,2) DEFAULT NULL,
  `can_download` tinyint(1) DEFAULT NULL,
  `can_share` tinyint(1) DEFAULT NULL,
  `rrating` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `externalOptions` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `only_for_paid` tinyint(1) DEFAULT NULL,
  `serie_playlists_id` int(11) DEFAULT NULL,
  `sites_id` int(11) DEFAULT NULL,
  `video_password` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `encoderURL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filepath` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filesize` bigint(19) unsigned DEFAULT 0,
  `live_transmitions_history_id` int(11) DEFAULT NULL,
  `total_seconds_watching` int(11) DEFAULT 0,
  `duration_in_seconds` int(11) DEFAULT NULL,
  `likes` int(11) DEFAULT NULL,
  `dislikes` int(11) DEFAULT NULL,
  `users_id_company` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clean_title_UNIQUE` (`clean_title`),
  KEY `fk_videos_users1_idx` (`users_id_company`),
  KEY `fk_videos_users_idx` (`users_id`),
  KEY `fk_videos_categories1_idx` (`categories_id`),
  KEY `index5` (`order`),
  KEY `fk_videos_videos1_idx` (`next_videos_id`),
  KEY `fk_videos_sites1_idx` (`sites_id`),
  KEY `clean_title_INDEX` (`clean_title`),
  KEY `video_filename_INDEX` (`filename`),
  KEY `video_status_idx` (`status`),
  KEY `video_type_idx` (`type`),
  KEY `videos_likes_index` (`likes`),
  KEY `videos_dislikes_index` (`dislikes`),
  KEY `fk_videos_live_transmitions_history1_idx` (`live_transmitions_history_id`),
  KEY `total_sec_watchinindex` (`total_seconds_watching`),
  KEY `fk_videos_playlists1` (`serie_playlists_id`),
  KEY `videos_status_index` (`status`),
  KEY `is_suggested_index` (`isSuggested`),
  KEY `views_count_index` (`views_count`),
  KEY `filename_index` (`filename`),
  FULLTEXT KEY `index17vname` (`title`),
  FULLTEXT KEY `index18vdesc` (`description`),
  CONSTRAINT `fk_videos_categories1` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_videos_playlists1` FOREIGN KEY (`serie_playlists_id`) REFERENCES `playlists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_videos_sites1` FOREIGN KEY (`sites_id`) REFERENCES `sites` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_videos_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_videos_users1` FOREIGN KEY (`users_id_company`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fk_videos_videos1` FOREIGN KEY (`next_videos_id`) REFERENCES `videos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos`
--

LOCK TABLES `videos` WRITE;
/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos_group_view`
--

DROP TABLE IF EXISTS `videos_group_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `videos_group_view` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_groups_id` int(11) NOT NULL,
  `videos_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_videos_group_view_users_groups1_idx` (`users_groups_id`),
  KEY `fk_videos_group_view_videos1_idx` (`videos_id`),
  CONSTRAINT `fk_videos_group_view_users_groups1` FOREIGN KEY (`users_groups_id`) REFERENCES `users_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_videos_group_view_videos1` FOREIGN KEY (`videos_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos_group_view`
--

LOCK TABLES `videos_group_view` WRITE;
/*!40000 ALTER TABLE `videos_group_view` DISABLE KEYS */;
/*!40000 ALTER TABLE `videos_group_view` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos_metadata`
--

DROP TABLE IF EXISTS `videos_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `videos_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `videos_id` int(11) NOT NULL,
  `resolution` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `format` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stream_id` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `videos_id` (`videos_id`,`resolution`,`format`,`stream_id`,`name`),
  KEY `fk_videos_metadata_videos1_idx` (`videos_id`),
  CONSTRAINT `fk_videos_metadata_videos1` FOREIGN KEY (`videos_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos_metadata`
--

LOCK TABLES `videos_metadata` WRITE;
/*!40000 ALTER TABLE `videos_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `videos_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos_statistics`
--

DROP TABLE IF EXISTS `videos_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `videos_statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `when` datetime NOT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `users_id` int(11) DEFAULT NULL,
  `videos_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `lastVideoTime` int(11) DEFAULT NULL,
  `session_id` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seconds_watching_video` int(11) DEFAULT NULL,
  `json` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_videos_statistics_users1_idx` (`users_id`),
  KEY `fk_videos_statistics_videos1_idx` (`videos_id`),
  KEY `when_statisci` (`when`),
  KEY `session_id_statistics` (`session_id`),
  KEY `sec_watchin_videos` (`seconds_watching_video`),
  CONSTRAINT `fk_videos_statistics_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_videos_statistics_videos1` FOREIGN KEY (`videos_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos_statistics`
--

LOCK TABLES `videos_statistics` WRITE;
/*!40000 ALTER TABLE `videos_statistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `videos_statistics` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-13 23:52:53
