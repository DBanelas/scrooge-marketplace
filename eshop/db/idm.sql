-- MariaDB dump 10.19  Distrib 10.9.4-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: idm
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `SequelizeMeta`
--

DROP TABLE IF EXISTS `SequelizeMeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SequelizeMeta` (
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SequelizeMeta`
--

LOCK TABLES `SequelizeMeta` WRITE;
/*!40000 ALTER TABLE `SequelizeMeta` DISABLE KEYS */;
INSERT INTO `SequelizeMeta` VALUES
('201802190000-CreateUserTable.js'),
('201802190003-CreateUserRegistrationProfileTable.js'),
('201802190005-CreateOrganizationTable.js'),
('201802190008-CreateOAuthClientTable.js'),
('201802190009-CreateUserAuthorizedApplicationTable.js'),
('201802190010-CreateRoleTable.js'),
('201802190015-CreatePermissionTable.js'),
('201802190020-CreateRoleAssignmentTable.js'),
('201802190025-CreateRolePermissionTable.js'),
('201802190030-CreateUserOrganizationTable.js'),
('201802190035-CreateIotTable.js'),
('201802190040-CreatePepProxyTable.js'),
('201802190045-CreateAuthZForceTable.js'),
('201802190050-CreateAuthTokenTable.js'),
('201802190060-CreateOAuthAuthorizationCodeTable.js'),
('201802190065-CreateOAuthAccessTokenTable.js'),
('201802190070-CreateOAuthRefreshTokenTable.js'),
('201802190075-CreateOAuthScopeTable.js'),
('20180405125424-CreateUserTourAttribute.js'),
('20180612134640-CreateEidasTable.js'),
('20180727101745-CreateUserEidasIdAttribute.js'),
('20180730094347-CreateTrustedApplicationsTable.js'),
('20180828133454-CreatePasswordSalt.js'),
('20180921104653-CreateEidasNifColumn.js'),
('20180922140934-CreateOauthTokenType.js'),
('20181022103002-CreateEidasTypeAndAttributes.js'),
('20181108144720-RevokeToken.js'),
('20181113121450-FixExtraAndScopeAttribute.js'),
('20181203120316-FixTokenTypesLength.js'),
('20190116101526-CreateSignOutUrl.js'),
('20190316203230-CreatePermissionIsRegex.js'),
('20190429164755-CreateUsagePolicyTable.js'),
('20190507112246-CreateRoleUsagePolicyTable.js'),
('20190507112259-CreatePtpTable.js'),
('20191019153205-UpdateUserAuthorizedApplicationTable.js'),
('20200107102154-CreatePermissionFiwareService.js'),
('20200107102154-CreatePermissionUseFiwareService.js'),
('20200928134556-AddDisable2faKey.js'),
('20210422214057-init-visible_attributes.js'),
('20210423161823-AddOidcNonce.js.js'),
('20210603073911-hashed-access-tokens.js'),
('20210607162019-CreateDelegationEvidenceTable.js'),
('20210707102154-CreatePermissionFiwarePayload.js');
/*!40000 ALTER TABLE `SequelizeMeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_token`
--

DROP TABLE IF EXISTS `auth_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_token` (
  `access_token` varchar(255) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `valid` tinyint(1) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `pep_proxy_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`access_token`),
  UNIQUE KEY `access_token` (`access_token`),
  KEY `user_id` (`user_id`),
  KEY `pep_proxy_id` (`pep_proxy_id`),
  CONSTRAINT `auth_token_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `auth_token_ibfk_2` FOREIGN KEY (`pep_proxy_id`) REFERENCES `pep_proxy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_token`
--

LOCK TABLES `auth_token` WRITE;
/*!40000 ALTER TABLE `auth_token` DISABLE KEYS */;
INSERT INTO `auth_token` VALUES
('003abdc0-4d12-4795-9132-36dab4909f8b','2022-12-12 11:32:18',1,'admin',NULL),
('01930e9a-27ae-4a4c-9927-32e5e3b7fc54','2022-12-11 23:32:29',1,'admin',NULL),
('02e4e3e0-454f-411c-b31b-25b0ada1c5fb','2022-12-11 17:56:12',1,'admin',NULL),
('04afbd95-2772-4f11-ba3a-8e198e4fdca1','2022-12-11 17:52:17',1,'admin',NULL),
('07490b0d-dbcf-4cda-b619-cf9187dfd265','2022-12-11 17:24:12',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('08e3f9f6-35e2-423c-9f84-b6578aa8ce82','2022-12-11 23:32:18',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('0915ab41-e063-47ba-a307-81fa6f74a6bc','2022-12-11 18:15:00',1,'admin',NULL),
('0b5f2926-335e-44b1-8fc6-eba3e50648ea','2022-12-11 18:24:38',1,'admin',NULL),
('0be24573-970f-479a-b44c-4e93afa29511','2022-12-12 13:17:10',1,'admin',NULL),
('0d980155-60b9-4a5e-b32f-a0a0285df6d5','2022-12-12 13:17:06',1,'admin',NULL),
('1207af74-758e-49dc-aa7b-37b529700168','2022-12-12 11:34:05',1,'admin',NULL),
('12869f8e-d8fe-4443-9191-3b2dd3be114c','2022-12-11 22:52:41',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('14a38146-fd0b-4aa9-8a6c-8a3f76f05179','2022-12-11 19:59:32',1,'admin',NULL),
('14d01315-e230-4fb5-8827-c16f100be5ed','2022-12-11 23:33:05',1,'admin',NULL),
('16e18df9-18df-4efb-9b23-06155b176b05','2022-12-12 13:43:45',1,'admin',NULL),
('17c5efe1-c8a8-4ea6-829c-948295607f91','2022-12-12 13:07:32',1,'admin',NULL),
('1b730b69-f723-4985-b24d-b90b5ad709f1','2022-12-11 17:42:33',1,'admin',NULL),
('1b8cc471-ab56-43ed-95b0-c7c337d7d87d','2022-12-11 19:53:14',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('1bddf2f9-2242-466a-9d29-88b008cc11be','2022-12-11 17:13:29',1,'admin',NULL),
('1d7348b9-5e46-4bcf-afc8-02919977a2fb','2022-12-11 23:26:33',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('1ec755e1-a705-4626-892b-620347dfb92f','2022-12-12 11:31:45',1,'admin',NULL),
('1f3fe463-c348-4a9a-9ea4-c70caae03331','2022-12-11 20:07:17',1,'admin',NULL),
('2169993c-1462-4ac6-b286-879c141948f1','2022-12-11 19:47:05',1,'admin',NULL),
('21d43d75-af80-429a-adc1-ae1360638a6a','2022-12-12 11:54:57',1,'admin',NULL),
('26069fef-a88c-4607-9e57-7f8881b4a441','2022-12-11 17:30:30',1,'admin',NULL),
('272c4293-57e9-450e-9de5-d5d52bc874b4','2022-12-11 18:23:26',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('294db8db-e392-4443-b0ca-1c75458ea7d7','2022-12-11 22:59:17',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('296c26ff-0db0-4d8d-8ba3-cbde590612fb','2022-12-11 19:30:29',1,'admin',NULL),
('299fadb0-cbac-4f3f-92ce-58f329e552db','2022-12-12 11:26:45',1,'admin',NULL),
('29ddf6af-5e2c-424c-a52d-8594ada70bf6','2022-12-11 18:08:29',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('2b3ac93a-8392-416a-b7bc-c2dd949dcefc','2022-12-12 13:43:43',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('2cb3ce22-1b75-4dc8-915d-26f7aaa326b3','2022-12-12 11:48:27',1,'admin',NULL),
('2d24dd49-f65c-477d-8ee7-7d81bf3e03ef','2022-12-12 13:06:04',1,'admin',NULL),
('2d2fab41-1677-46a6-97f0-32249bf40d4b','2022-12-11 18:24:37',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('2d5fef86-acd1-4387-8ae8-c5c4df6bd642','2022-12-11 17:22:53',1,'admin',NULL),
('2fa89f60-704b-4edb-b163-96340b83c410','2022-12-11 23:32:23',1,'admin',NULL),
('32b96b66-e577-445d-8f41-807f92b69ea8','2022-12-11 19:47:03',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('342744a8-6871-4081-a0ab-5feda8e22245','2022-12-11 23:37:11',1,'admin',NULL),
('3485071a-1d54-4158-8909-25643b136770','2022-12-12 13:44:05',1,'09372be2-3975-490f-b0e5-65cd28d0ef70',NULL),
('3a28cee2-14a9-4f01-9c37-b4d77a128888','2022-12-11 18:27:08',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('3b3009da-787a-4071-a940-39effb547f3d','2022-12-09 01:37:43',1,'admin',NULL),
('3c3a5629-4be0-437d-bc13-2381945f8192','2022-12-11 22:49:49',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('3d46e2f6-b634-4191-9f55-632968712f9a','2022-12-11 23:37:07',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('3d6f9272-32de-4b40-9a48-558310fcfe8b','2022-12-12 13:16:30',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('3e7c9c65-7d87-4a14-b9b3-58d8f601c088','2022-12-11 17:56:11',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('3fd1d412-4bcc-438b-b736-366696a2bc07','2022-12-11 18:03:10',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('43a978b7-d4ba-4d38-b359-61ce5ff31955','2022-12-11 23:26:40',1,'admin',NULL),
('459a9be5-9745-4eea-b0b0-6ba76850f8f9','2022-12-11 23:28:59',1,'admin',NULL),
('473b8866-d17e-42b6-9cf1-0934ea85af9d','2022-12-11 23:26:47',1,'admin',NULL),
('4f08de57-01ba-4430-a43b-d1571e150975','2022-12-11 22:52:46',1,'admin',NULL),
('4f69c9c2-b2af-4b61-a83a-a4e661ae8f04','2022-12-11 23:27:07',1,'admin',NULL),
('5042b4e0-c2f4-45d8-a1a9-bb01b610fd59','2022-12-11 23:27:30',1,'admin',NULL),
('515454e1-f90d-41c9-a382-ea7084beb6d8','2022-12-12 11:48:24',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('526a22f5-ce37-4b4c-b64d-7dd6599fac00','2022-12-12 13:42:44',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('527b98ee-783a-47e3-b1d9-f6a374aa4a26','2022-12-11 22:49:51',1,'admin',NULL),
('52a71a12-f071-44a5-b0e7-a3a0783ef1bd','2022-12-11 22:59:25',1,'admin',NULL),
('5311f78a-21f7-493c-9e8b-26c1a249cc0d','2022-12-12 13:43:17',1,'admin',NULL),
('532ad830-f945-49f0-b2cf-037df38e3435','2022-12-11 23:29:13',1,'admin',NULL),
('552a4727-ff9a-4b9e-82a5-bf4a457bb64f','2022-12-11 19:34:57',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('583ddd1e-5de2-4337-9e12-58700ddb3613','2022-12-12 11:33:42',1,'admin',NULL),
('58fe21eb-a293-4b48-9df5-2532cd510f06','2022-12-11 18:34:50',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('5a9377b7-2091-4540-8b03-1acb91382e70','2022-12-11 23:26:55',1,'admin',NULL),
('5b05c9e0-cb79-44cc-be66-34e3feeaf6e2','2022-12-11 17:42:31',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('5d19abbf-73d4-4b90-982c-50f6ea35a390','2022-12-12 11:49:52',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('5d294293-6f4a-4b62-a1cb-045f81f916f2','2022-12-12 11:31:43',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('5d67c84f-59f9-4a2f-8beb-9e1788333355','2022-12-11 18:08:31',1,'admin',NULL),
('5e43ecc1-d3f1-489d-b1e1-079ca8b20f6b','2022-12-11 23:29:04',1,'admin',NULL),
('5ee3b46f-dd86-4768-ba42-49dec882ab66','2022-12-12 13:04:10',1,'admin',NULL),
('5f55cc81-a21d-4da2-a126-5d96334317a9','2022-12-12 11:22:56',1,'admin',NULL),
('6227d556-6905-46f1-b9e1-ea0881a21ca3','2022-12-12 11:24:48',1,'admin',NULL),
('62b424a0-c26f-4e33-a867-b84d3f35e4ba','2022-12-09 01:38:16',1,'admin',NULL),
('638ea25d-d9dd-4926-b6b2-a362bc583da4','2022-12-12 13:16:32',1,'admin',NULL),
('63fa73be-36d2-47f2-9944-cec390105372','2022-12-11 18:14:55',1,'admin',NULL),
('646fa035-6121-4cdf-99f9-ca25f4b209a2','2022-12-12 13:16:54',1,'admin',NULL),
('6657c4f8-c890-4cd8-bb8b-2b8841f3236e','2022-12-12 12:59:17',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('670e933e-57ad-4294-9e13-c37f8c0212bf','2022-12-11 17:30:25',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('675bf2a9-36c5-4b1e-aa8a-d7a9fee1bfc6','2022-12-11 18:35:50',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('6856cd12-bc69-46e5-85e7-01917ddd3ca0','2022-12-12 11:32:56',1,'admin',NULL),
('6a5c3c03-8750-4380-b7a3-dec7e6f54b98','2022-12-11 20:07:15',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('6c1881ee-a083-4ddb-85e1-f55699dc1226','2022-12-11 19:30:27',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('6e353694-9dad-4efb-bfd7-b34f9e65796f','2022-12-12 11:34:26',1,'admin',NULL),
('76303f5b-c61e-42a7-9729-41a6e0ba469d','2022-12-11 18:34:51',1,'admin',NULL),
('7a70fb11-17e2-44c7-bc5e-6ac6c3dad530','2022-12-12 11:33:47',1,'admin',NULL),
('7a8a377c-31a7-4878-90e4-67e6c066c037','2022-12-12 11:33:47',1,'admin',NULL),
('7b09a635-5e6e-4e13-a559-354e33b6b888','2022-12-11 19:37:46',1,'admin',NULL),
('7d3faebd-7cf2-4f58-9490-3408f67abdb9','2022-12-11 17:52:15',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('7e262f6d-3888-4df1-bf27-83d6033c3cae','2022-12-11 19:56:56',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('80f5bfd5-5c82-4d9c-9007-167bbd4442c8','2022-12-11 23:28:57',1,'admin',NULL),
('845397ad-e14a-4a3f-92dc-bac14115f0da','2022-12-11 14:16:02',1,'admin',NULL),
('85084d19-0303-4559-bf84-c951ba35bba6','2022-12-12 11:32:27',1,'admin',NULL),
('871538a7-9efe-4dec-96d5-cf44c675762f','2022-12-11 19:59:18',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('894bd93e-01e3-4e30-a56d-34ca72118cd5','2022-12-09 01:51:51',1,'admin',NULL),
('8a70e2cc-9aef-4567-a3ef-0013cec8065d','2022-12-11 22:50:01',1,'admin',NULL),
('8bd82df2-311b-4cb5-9c84-dcb1d7c929b7','2022-12-11 18:23:07',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('8ed26403-0b13-4868-a929-ced878d376c3','2022-12-11 23:32:32',1,'admin',NULL),
('8f9d1729-52f2-4d3a-919d-40f40c3f3ab4','2022-12-12 11:26:42',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('92c34668-2ccf-4250-b1bb-6bc91de378cc','2022-12-11 18:16:34',1,'admin',NULL),
('932127c6-f603-4e02-9e94-8d119c188228','2022-12-12 11:24:50',1,'admin',NULL),
('960127c2-4e3e-4038-ba8a-83744b5a4563','2022-12-11 19:42:33',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('96df766f-fda9-43c3-9cac-87ea349a834a','2022-12-11 14:16:13',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('98c9aa5c-a7fe-48aa-a8f9-ee946b4d71c2','2022-12-09 01:38:33',1,'admin',NULL),
('99b69c17-1821-4a4e-819c-ac755ae31be8','2022-12-12 11:32:03',1,'admin',NULL),
('99f3fcb5-20e9-40d4-8350-50ec0610f367','2022-12-11 18:38:59',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('99fef7ca-63f6-404c-b5ca-d4ad32261eb1','2022-12-11 23:27:21',1,'admin',NULL),
('9a475146-8cad-4c85-a672-9858023516fc','2022-12-11 22:55:55',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('9de5ef0d-ac79-46f6-a86d-03e22873db92','2022-12-11 23:32:20',1,'admin',NULL),
('a057940b-aa0f-47d9-8dac-98d748d2fdc9','2022-12-11 22:48:03',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('a28fc515-7026-4e93-ae71-04bf08d6f363','2022-12-12 11:22:54',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('a3029c24-d9b4-4e47-9fe0-3b483b1e195b','2022-12-12 11:34:21',1,'admin',NULL),
('a851a2a4-a711-4014-bf86-fd12da5da342','2022-12-11 18:27:26',1,'admin',NULL),
('aa15bfd9-8258-45a8-85db-916178f09a8d','2022-12-11 18:16:31',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('ab58bfb6-86de-4d84-ba96-2eb71d37cfed','2022-12-12 11:32:10',1,'admin',NULL),
('aba3d884-15e1-43a6-b9ce-1fd7926ff0b8','2022-12-12 13:17:03',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('b1092433-ffee-4487-acc9-021f70ddfa70','2022-12-11 17:22:48',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('b4ff72cc-6d17-4058-a038-dc23256f4929','2022-12-11 22:59:27',1,'admin',NULL),
('b70aaf20-87f9-4b56-ae62-78298370c196','2022-12-11 19:34:01',1,'admin',NULL),
('b9b4e5bd-95a4-4aef-8874-7b181d55ba5a','2022-12-11 18:35:51',1,'admin',NULL),
('ba20f046-1e0d-4dd9-8ebf-440b903a653c','2022-12-12 11:32:18',1,'admin',NULL),
('c28fdf5f-a095-49d1-a10f-78f304f46b24','2022-12-11 19:40:00',1,'admin',NULL),
('c4bb3f31-afc2-4179-8e7a-7802639e888b','2022-12-11 18:10:23',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('c6027e2a-e7aa-4f74-ade8-77fdbc1aefdb','2022-12-09 01:40:49',1,'admin',NULL),
('c6ec9ba0-a861-4db6-b2a2-411ee467d379','2022-12-12 11:32:35',1,'admin',NULL),
('c7b52508-1e0a-46d2-bfe9-756fe5a5f44a','2022-12-11 19:55:48',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('c99d4d6d-d045-470c-87f8-5e43a252b4e2','2022-12-12 11:34:11',1,'admin',NULL),
('c9d0f3f2-3e4f-4ac7-ac99-7afcda18429a','2022-12-11 23:32:28',1,'admin',NULL),
('ca093779-6a7d-4d3d-b851-bb7f588b7d3c','2022-12-11 19:39:58',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('cc44dc74-090a-40d4-bf27-6ef63173a2d5','2022-12-11 23:28:54',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('cca10d13-30a1-4b0f-9ed9-dfa27a02348b','2022-12-12 11:49:55',1,'admin',NULL),
('cd3195ae-bcb7-4637-bda1-92b4be0f6b69','2022-12-12 11:22:59',1,'admin',NULL),
('cddcf8c1-0010-40df-b406-2b84cbb7e84c','2022-12-11 23:29:25',1,'admin',NULL),
('d060ead1-d8da-455e-938d-3f2e2257f804','2022-12-11 18:39:00',1,'admin',NULL),
('d1e2fc58-7c0d-4e01-83d7-34da6dd43f77','2022-12-11 23:27:21',1,'admin',NULL),
('d2665e70-7dab-49a0-bf53-998e0b473851','2022-12-12 13:04:04',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('d2c41120-3f96-4967-915e-677c161bc936','2022-12-11 18:00:52',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('d2cd8206-e054-4832-8091-3dc80e061737','2022-12-11 22:59:30',1,'admin',NULL),
('d3faeb3d-9312-43d1-b1a8-0a2d04ae9c25','2022-12-12 11:34:10',1,'admin',NULL),
('d4625960-756a-4a0e-872c-f42a430bc436','2022-12-11 17:24:14',1,'admin',NULL),
('d4ecfe23-5f70-4d9e-ae1e-dfaf075fa632','2022-12-11 18:00:54',1,'admin',NULL),
('d55d0c07-2c82-44a7-8c6c-cbca7afdaca4','2022-12-11 23:29:27',1,'admin',NULL),
('d565f526-2f1e-4c64-9605-e089eff0caa9','2022-12-11 20:07:20',1,'admin',NULL),
('d5c57636-9bee-416f-9187-5bc9c151cfcd','2022-12-11 23:32:46',1,'admin',NULL),
('d873325a-d3d8-492b-a3cd-106039b4c708','2022-12-12 11:24:55',1,'admin',NULL),
('dbedea21-a0e6-48a6-a5a8-8e143f4bc74d','2022-12-11 18:26:12',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('dc1a1378-8c41-465d-a4fb-fd6d3a73dfda','2022-12-11 18:10:24',1,'admin',NULL),
('dd2336d7-5401-46a5-be22-5a1cfdfb9914','2022-12-11 22:50:18',1,'admin',NULL),
('ddc18e06-076c-429a-949e-be84ec8856df','2022-12-12 13:04:05',1,'admin',NULL),
('e1840256-d125-4c3b-bf78-8ce4c97a5835','2022-12-12 11:32:58',1,'admin',NULL),
('e38707c5-a405-4d17-a1b4-030e3b2533cc','2022-12-11 23:33:11',1,'admin',NULL),
('e4aca3fa-49af-4a71-aa5f-0bd307dfa786','2022-12-09 01:42:30',1,'admin',NULL),
('e57f7fbb-4822-4dec-b74e-39147c7f7d81','2022-12-11 19:42:36',1,'admin',NULL),
('e581f19a-5295-4a60-9759-59753401fc71','2022-12-11 23:26:47',1,'admin',NULL),
('e5cfbe96-c08d-43dd-a022-b458e29f4f20','2022-12-11 20:00:08',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('e6d525c6-c923-4c13-9a27-5b218b768d1d','2022-12-11 23:37:17',1,'admin',NULL),
('e9e4a657-3964-47af-8ae4-6773da3b59b3','2022-12-11 20:07:38',1,'admin',NULL),
('eacc8b8b-8303-479f-a3d0-78b8187ecac9','2022-12-11 20:00:26',1,'admin',NULL),
('ed9c8e28-9c7f-444c-bef1-acc0d3f449b3','2022-12-12 11:34:49',1,'admin',NULL),
('ef7a4425-c548-4466-b15f-27b427cc18ab','2022-12-12 13:42:47',1,'admin',NULL),
('efb9c5d5-7c08-4b4e-acfc-0dc36b997ef1','2022-12-11 18:26:14',1,'admin',NULL),
('efe37da8-5ca7-4b7f-9017-504b1c08658a','2022-12-12 11:26:43',1,'admin',NULL),
('f030a31c-61c3-4627-85ce-812a5153b987','2022-12-12 11:32:58',1,'admin',NULL),
('f16c72f3-8e9b-4796-a75e-96fb30d12860','2022-12-11 18:03:14',1,'admin',NULL),
('f22601c8-ea24-428b-9f83-933ada687830','2022-12-12 11:32:36',1,'admin',NULL),
('f69eb3aa-3824-4bd1-b174-f064b515b27e','2022-12-11 22:59:35',1,'admin',NULL),
('f6c1d788-6aea-42d9-80bf-f41bba09c8bc','2022-12-11 19:47:56',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('f70f1260-44dd-4e26-91b9-1bf71a47c2ab','2022-12-12 11:54:44',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('f8a3b260-3239-4bc7-a1b2-7592dd8e50bb','2022-12-11 23:29:27',1,'admin',NULL),
('f9f1a64a-d95e-41f3-8406-6326a4df6bc0','2022-12-11 19:33:59',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('fad3af29-a5c4-40b7-96e3-72d3563f4b39','2022-12-11 23:26:35',1,'admin',NULL),
('fb6a95a5-97f3-4463-ad56-603b5be3f76a','2022-12-11 22:43:20',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('fbc46baa-44d5-47f8-b359-819e4b5fd928','2022-12-12 11:34:26',1,'admin',NULL),
('fbd187df-ab3d-45cd-91ec-1096214de1d3','2022-12-12 11:26:50',1,'admin',NULL),
('fc312784-cd19-4486-ad3a-66c42e84c68c','2022-12-11 22:35:48',1,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL),
('fc70a383-c947-4918-8335-3d286d7458cd','2022-12-11 23:29:04',1,'admin',NULL),
('fcdb70f8-966b-4470-9e05-5372165e599f','2022-12-12 12:59:19',1,'admin',NULL),
('ff460336-0b23-429a-90fc-123e43b735dd','2022-12-11 23:37:09',1,'admin',NULL);
/*!40000 ALTER TABLE `auth_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authzforce`
--

DROP TABLE IF EXISTS `authzforce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authzforce` (
  `az_domain` varchar(255) NOT NULL,
  `policy` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `version` int DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`az_domain`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `authzforce_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authzforce`
--

LOCK TABLES `authzforce` WRITE;
/*!40000 ALTER TABLE `authzforce` DISABLE KEYS */;
/*!40000 ALTER TABLE `authzforce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delegation_evidence`
--

DROP TABLE IF EXISTS `delegation_evidence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delegation_evidence` (
  `policy_issuer` varchar(255) NOT NULL,
  `access_subject` varchar(255) NOT NULL,
  `policy` json NOT NULL,
  PRIMARY KEY (`policy_issuer`,`access_subject`),
  UNIQUE KEY `policy_issuer_access_subject_unique` (`policy_issuer`,`access_subject`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delegation_evidence`
--

LOCK TABLES `delegation_evidence` WRITE;
/*!40000 ALTER TABLE `delegation_evidence` DISABLE KEYS */;
/*!40000 ALTER TABLE `delegation_evidence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eidas_credentials`
--

DROP TABLE IF EXISTS `eidas_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eidas_credentials` (
  `id` varchar(36) NOT NULL,
  `support_contact_person_name` varchar(255) DEFAULT NULL,
  `support_contact_person_surname` varchar(255) DEFAULT NULL,
  `support_contact_person_email` varchar(255) DEFAULT NULL,
  `support_contact_person_telephone_number` varchar(255) DEFAULT NULL,
  `support_contact_person_company` varchar(255) DEFAULT NULL,
  `technical_contact_person_name` varchar(255) DEFAULT NULL,
  `technical_contact_person_surname` varchar(255) DEFAULT NULL,
  `technical_contact_person_email` varchar(255) DEFAULT NULL,
  `technical_contact_person_telephone_number` varchar(255) DEFAULT NULL,
  `technical_contact_person_company` varchar(255) DEFAULT NULL,
  `organization_name` varchar(255) DEFAULT NULL,
  `organization_url` varchar(255) DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `organization_nif` varchar(255) DEFAULT NULL,
  `sp_type` varchar(255) DEFAULT 'private',
  `attributes_list` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `eidas_credentials_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eidas_credentials`
--

LOCK TABLES `eidas_credentials` WRITE;
/*!40000 ALTER TABLE `eidas_credentials` DISABLE KEYS */;
/*!40000 ALTER TABLE `eidas_credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iot`
--

DROP TABLE IF EXISTS `iot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iot` (
  `id` varchar(255) NOT NULL,
  `password` varchar(40) DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `iot_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iot`
--

LOCK TABLES `iot` WRITE;
/*!40000 ALTER TABLE `iot` DISABLE KEYS */;
/*!40000 ALTER TABLE `iot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_token`
--

DROP TABLE IF EXISTS `oauth_access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_token` (
  `access_token` text NOT NULL,
  `expires` datetime DEFAULT NULL,
  `scope` varchar(2000) DEFAULT NULL,
  `refresh_token` varchar(255) DEFAULT NULL,
  `valid` tinyint(1) DEFAULT NULL,
  `extra` json DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `iot_id` varchar(255) DEFAULT NULL,
  `authorization_code` varchar(255) DEFAULT NULL,
  `hash` char(64) NOT NULL,
  PRIMARY KEY (`hash`),
  UNIQUE KEY `oauth_access_token_hash_uk` (`hash`),
  KEY `oauth_client_id` (`oauth_client_id`),
  KEY `user_id` (`user_id`),
  KEY `iot_id` (`iot_id`),
  KEY `refresh_token` (`refresh_token`),
  KEY `authorization_code_at` (`authorization_code`),
  CONSTRAINT `authorization_code_at` FOREIGN KEY (`authorization_code`) REFERENCES `oauth_authorization_code` (`authorization_code`) ON DELETE CASCADE,
  CONSTRAINT `oauth_access_token_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE,
  CONSTRAINT `oauth_access_token_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `oauth_access_token_ibfk_3` FOREIGN KEY (`iot_id`) REFERENCES `iot` (`id`) ON DELETE CASCADE,
  CONSTRAINT `refresh_token` FOREIGN KEY (`refresh_token`) REFERENCES `oauth_refresh_token` (`refresh_token`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_token`
--

LOCK TABLES `oauth_access_token` WRITE;
/*!40000 ALTER TABLE `oauth_access_token` DISABLE KEYS */;
INSERT INTO `oauth_access_token` VALUES
('966155a3613d2795ebe9c2052d7ca76ce7ec6842','2022-12-11 18:38:59','bearer','3a7c6b2ef0fc91664e38651d0c9668091f565bdc',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'146cd94629e69af7900bf43619a3a7a5e4b5d36f6835c190f2206204a772244f'),
('cf4ba3f88333de4a5833b8a643af616a3cc82b7f','2022-12-12 13:04:04','bearer','19e61373abed376099a55c5fdd9acc18336f505a',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'19ff55b740f26e2ee76aab29d9787ae1e9f5b1c13f544daa7706270aecdf6885'),
('4971a81790fd7467f4c1b1b4efc33f6372d3c5a3','2022-12-11 23:28:54','bearer','00ab77339bd15e49eca132dfe0db665956becc88',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'23e2c9370a36c54f755bbdacf103c9082b76a61b5c1eafc79cc5b0722f16c298'),
('a45f6e5730def26969f292b1968a1c892d1c337c','2022-12-11 18:24:37','bearer','61aee441866dba9d0774e35e584dee6fbc6178e4',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'2564ab46ee1755ac16eb8ca711f38b016a89f9cb2952b93c9c7b237376b411f8'),
('83cd137a2c321fb1c65728d47e6c1b0e4ca050da','2022-12-11 18:10:23','bearer','a0732f3502008b0327b6f1ce92442fd3081dce30',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'2584a86ef6bc036be271d32b0495f24ce14ced08ee0e4c1fc9da457c5114cb22'),
('870620b70db19a86ab613dd0af4683e3869cb318','2022-12-11 18:08:29','bearer','180bc82026ab890ab5388ef97ad251ef9290c206',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'319cde9d03b6077443dbff0522bd571ddf8e7fd75b1e62fb170ab29dfb5523f0'),
('424063d018a16b8c9bc003acee4d8f0ba85e5895','2022-12-11 17:22:48','bearer','bdd42d45ccf90cd7a967dd9a9aba9ec513c032b9',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'3b242b451a58d47eb6de92b09920157659fa1179c3c80f30f6985b2844a6511e'),
('5639d17408bffbebfe64d5692cca07d41ac33663','2022-12-11 18:34:50','bearer','0b535fe81a8543f5f57aadaa3193a84bd41c90dc',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'429423febed0f017c48d9e45838d18645a241fda0dd0a277226f1161d666591a'),
('1d1041c3f8c1a0d480c7ac3ba0577e31d4059db4','2022-12-11 22:59:17','bearer','3b87b011dbee5d0e2e290d86bbfaa3f9be9580db',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'4431849444bbe581e8fd3195ab6c8c13398aa63ef9fa397d40af910d832bcb96'),
('9b60069d3c28b6053af4a5616a2c56ae71ce9df2','2022-12-11 19:30:27','bearer','8792b47c54d15815aba35feef7bb960f6c8ef475',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'4f3817fbc41e987fe9d83b3cb8ce0694175a10b2ae5b0150c1600ca99e3503b0'),
('5ec0bdb8c0d3930208aa0f20738c91388d9a5405','2022-12-12 11:31:43','bearer','51e13b07b75686fc1d67ddc3b89fbef6e7354f89',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'5e03026b39da1539a648bdd041fcb7cdb6287f14afc8bb5812554b73da8371e3'),
('81981c32dd456d0967a4994403cdae57c3a32deb','2022-12-11 18:23:07','bearer','20ebc7c547197c0dd1cfad3a88c6b3b735aea902',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'639e0da76a6fbfa243a54b14ea050c8d0d85f0ea97767f1df1387bc10770dd64'),
('e37b5fd004f5b84ea31bf7204c1e7ca132195db1','2022-12-11 19:39:58','bearer','c1a28e092987d91b5dce02961345f42084cbe102',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'7643de8d909736373fedeab5694d60020872f40b9db579d050ab3f2b7ab34f9a'),
('3c13697b54f36d2cc6f578c97d72fde412d5c010','2022-12-11 18:03:10','bearer','cdb5351641fbccb8cf5bf0db3eb1829d6eba3180',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'783a798ad0fe15a08caf683a913fe19c4654910fc20e78f8fb4d89608db3a9ab'),
('feed98248c1694a89a8107379f850d297de615f8','2022-12-12 11:26:42','bearer','951c96060c6f3a327597fc17211a80656b2fa721',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'7f63d524f8d7c52ce1dd3c8c5421f95a2c24866f8c602303f76b064aa3887fd5'),
('b1ac76a0b4a04ce18d0db3ccd3ec97a94cd24fa1','2022-12-11 17:30:25','bearer','10fdacb2650d80f8d87c0e368fc5e7adcc817aaf',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'857ee229df0d5ae95828125405039260eda3c9bea96e96375e9fb8e304f5e00f'),
('447c80e39cc36390628a10dc1a65d4661ef26cdc','2022-12-11 18:35:50','bearer','af408fd0bd8a42f2b52afea3a035db6e202cc9a3',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'8743cc8764a8abc63de15864552b2ee652f9684facc5aabec3622df085407dc0'),
('d0868b86ad4b72dac89475c040a87934a26735ee','2022-12-11 14:16:13','bearer','90165541d8eca53ee434e9dd973b070f29de9715',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'89553164401c36b5bb8320ab9ea6193f09d5c72b6ffa7cc0ad931e778caaabc3'),
('4c80b2223d971e89ee68925fb1ed22d0f9df50c9','2022-12-11 23:32:18','bearer','dc930bab5bcaf4ef5660683f6da4c621bcdb3997',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'8ee8f07b1cad58f89cc9525836907d0067c25f104f6f6cb9a844fbd88f453289'),
('63e94827a580f63d2bd6af6dbf3470c899f238c0','2022-12-11 19:33:59','bearer','65abe3cce5849b73ffa67b04dd180a132d3a66bd',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'8f59db25bb5d92205d5b8a3ede72d95591bd184811cd70d9b966bc924a7b0649'),
('f22948ac3080776bf69c3ac41d41133935dcab31','2022-12-12 12:59:17','bearer','b172c7d6e76bee6896ade83a9bf4e344583391ef',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'91e1f2f90c4f4604cbf502d2d11eac3f897a9e9344857778918e3c5c56e7aa10'),
('084b0dfae48a8b5b7ffa0f2a556a167f37c2e52b','2022-12-12 13:16:30','bearer','fa14addcb9b4eaba163cc9af729bc28dfc0b29b7',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'a06dfea501f9f1f6c7c0c44ce847690a0d91722b39c20b2661f64315cc55da14'),
('9f691ac3238c6c8ab74d9d2b422fc9318104b2e7','2022-12-11 19:47:03','bearer','258671759193c4d0ab326d6e4e9f8bd1d67f37cc',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'a24b891f344b6edd09b846d4f42211ccab2c2968d01d45a270a0d48301638ce5'),
('46599f5de8d94f8550685cb47962602460b39ca1','2022-12-11 22:52:41','bearer','942f8704bde1d4fc393e94452274ef5852110a60',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'a617047979187d4e401640155575231198f813d033bcf255cada4412d4d110c8'),
('02d746baeec6d1440982222dab9415ed233aaf83','2022-12-11 18:16:31','bearer','bacf4368457f4c300308d64f90523e8168684b38',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'a84d332cf83ae3b2cf8814974076e947e5cf50f9e423e29bcd45c1193d4cf743'),
('d5b693dd9633bb7a74bee185032562382c6547d9','2022-12-11 18:27:08','bearer','ba3031913ff5ff39fa6867cd83ce292111b11423',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'a9703763fd72de6f1ab9dd40d7ad446030e7da6631c7f9274eb7a2dc8d991946'),
('f9e1d863d388fc45ffb0785d379ff3bac5c80b3b','2022-12-11 23:37:07','bearer','6680bf9498a4431eaf595dbcc31e01c8552bc864',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'ab550a33a3eebb092edcf9787b3d7d33992754e31b0da70cf642bcc5617f4e44'),
('879f5eee920e906252ec4e74221366827826245b','2022-12-12 13:17:03','bearer','5d7afceca414607f6fb3a9dd187554b3c4e45189',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'ae766e35d178b3cbce44363f894e9fac1a87556a0c96d8ef4571437a2ae6b3c6'),
('5ea624c2b1d7e89b62f3bdc3708df8bddc40d801','2022-12-11 18:00:52','bearer','fd54d1828f2ebc0ef34887eee93f8c1e74a8999f',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'b025251499fca50deeb09d573ec463ad732556f2d457207ffd4b9e5fe62a44e3'),
('6f9f2e517fdaaf2afe05bb12374c67cb4f3cd3b5','2022-12-12 11:54:44','bearer','4e1967e4ae6fb8edee8213008ced08e9b146a179',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'b36bdb453dbd346f5c391af7bede3a2faf520702116bf94d2d528fa4440d2a24'),
('c657bf6ab6621d5a8d5b0ce792ee641c4cc29d33','2022-12-11 22:48:03','bearer','0bff3715478eb59161f2a7233df271d2be3a5364',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'b6732a732b50a60f72afadc50872d51402588e71aab880699b2f2f2fd80b4f9a'),
('7978b3d7444fab043793dc43143df1524616e0d9','2022-12-11 17:24:12','bearer','64fe115b5462fa69e56e733372206372cc6d0662',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'bc7bfa5abf1c0a73d893696f5003ab872a67b169863d5cb2643c1fd54d430684'),
('80190e20e39adbce4042cbeb4e8590674c32bfe2','2022-12-11 19:42:33','bearer','33b61a11615baa208d601d428d696fcb7b241671',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'bd1c1437aab6cd23a9d3571163c95113b9f4ca3fde5313062cd9a77a6304f758'),
('e997a73bb1cdc2413c78610cd2e1b34f0ce8b71e','2022-12-11 17:52:15','bearer','89767e048b53b721d24c29dfc6b8e9a339ec43ce',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'ce82c6fac1d872f7795d375593851b94b30e7ab10f08a2c3e502dcde7b4db69e'),
('2e700ef62f76513cc2ee8cab30ff964bd7f32ff0','2022-12-12 13:42:44','bearer','7f6e9d7a37b7182b85d84f3a4064c239c7cf19c2',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'d11bce58e132acff463b89cffefdc310c9aed76c04f19dfe0ad3aab3bc8b6792'),
('acffc243ec9e1a19f603529ac22407d92fb520cf','2022-12-11 23:26:33','bearer','4766868e96f4c967a3302d3bd90801942dc9bc90',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'d23acd015e46d415a58c2e000e157e769e5d77329b9e8ee7cedd0284a751a6c8'),
('7c557628e562f3768c0fb580651513f6deddc060','2022-12-11 17:42:31','bearer','1c17cdb65533ce2aea01115a39d936f6543095e6',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'d42443cd7b4bcf106c29f2f1fed68fefe25d8ea2f5a901ca1b09c36fc372db52'),
('27f9b11e05525df643181cd56b704e4b374689d4','2022-12-11 22:49:49','bearer','0a6d474e95b8df973b10074ce0d257cc190909d2',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'d7cbf165857af507db9929f629f33191c95b9230d3256f37b641aff1583cf901'),
('a8cb9333bf010a4d0deea34bca8a94053db0eda3','2022-12-11 18:26:12','bearer','f6daba508a2b572657374cf3be7e270611dd0245',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'d8db6b4923176941a10fe9923e3053008edb516c11f360c7603b425da390c461'),
('07d6cdc741fcd47733c67ffe2e7dfe92a06c8618','2022-12-11 17:56:11','bearer','512d865848150454fa23b5316c275a65b6601fb8',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'dd4e98aae127308eb9fd43b63009bc60ecbb5ba0ce3e91da8d789e6f1eb286d2'),
('2c5e065eb385c98ea19010506a6d4405f33c6eed','2022-12-12 13:43:43','bearer','94559ee09a734e2acd556af225bedff342e76bd2',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'e50b7984dd07bd7cfa0440fe6ccda1d22eb3e9c698f948bf8741e852d2622a90'),
('b00ea3f106f8131949c56cb7483c9e0114b3e88e','2022-12-12 11:22:54','bearer','2645ef5d29038e01b96f6062c82a9f0282ddb056',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'ed4e9f48a15c36cfd3cc10c714e959a6bda038d01ad08863807b9b0c1e0c1636'),
('bc66f50e2eebd4421ea5558528c9a7fe41318a44','2022-12-12 11:48:24','bearer','a07ef8d417c99c971a51ed1d2d29957f63d83d30',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'eea50f81d2c9a00e55616a43c1d8efe7eaa19c04ee5265d251a34a9212c80777'),
('d34eed9b0220575d320127eb08cee3f21793fc63','2022-12-11 20:07:15','bearer','5af803a984e7510059c77d8aecc284cd4c795522',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'f6bef11a85b44355986578ae1f9db61edc37a0e23f9af0996a1aeb1a1e9db40e'),
('a09ffb3ad012b7e839f14cf1e5c1177d0dc153d7','2022-12-11 18:23:26','bearer','b54f301eb8b8382f87cca6a1341d2def48347dc0',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'f8cf6343fe31d37eda83bb01495f86f2aa1dea2c2aaf28f03d595ddfc1c4af75'),
('58ba7c18abb571ee2b6796115d5e9a5f108e065f','2022-12-12 13:44:05','bearer','666d38822b2c3d2682dd3c3b688b38a3162a9c1a',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','09372be2-3975-490f-b0e5-65cd28d0ef70',NULL,NULL,'f8f7d27a64512b4bd8f2a3f4e48f4f99091927e0299a83247f038926b5bac963'),
('abfc0ae156421a3f00edbe305a4fa625aa968c2c','2022-12-12 11:49:52','bearer','15b9ea8ef1f675e0189a75b3dbdb1e4ff9d1869d',1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,'ff2a614b29055789da0e89201e5f67d77ab886ee7951934e0e642988bac7fe12');
/*!40000 ALTER TABLE `oauth_access_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_authorization_code`
--

DROP TABLE IF EXISTS `oauth_authorization_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_authorization_code` (
  `authorization_code` varchar(256) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `redirect_uri` varchar(2000) DEFAULT NULL,
  `scope` varchar(2000) DEFAULT NULL,
  `valid` tinyint(1) DEFAULT NULL,
  `extra` json DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `nonce` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`authorization_code`),
  UNIQUE KEY `authorization_code` (`authorization_code`),
  KEY `oauth_client_id` (`oauth_client_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `oauth_authorization_code_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE,
  CONSTRAINT `oauth_authorization_code_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_authorization_code`
--

LOCK TABLES `oauth_authorization_code` WRITE;
/*!40000 ALTER TABLE `oauth_authorization_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_authorization_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_client`
--

DROP TABLE IF EXISTS `oauth_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_client` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `secret` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `url` varchar(2000) DEFAULT NULL,
  `redirect_uri` varchar(2000) DEFAULT NULL,
  `image` varchar(255) DEFAULT 'default',
  `grant_type` varchar(255) DEFAULT NULL,
  `response_type` varchar(255) DEFAULT NULL,
  `client_type` varchar(15) DEFAULT NULL,
  `scope` varchar(2000) DEFAULT NULL,
  `extra` json DEFAULT NULL,
  `token_types` varchar(2000) DEFAULT NULL,
  `jwt_secret` varchar(255) DEFAULT NULL,
  `redirect_sign_out_uri` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_client`
--

LOCK TABLES `oauth_client` WRITE;
/*!40000 ALTER TABLE `oauth_client` DISABLE KEYS */;
INSERT INTO `oauth_client` VALUES
('b7221fc8-5c00-44bb-a303-ecffdabe056a','Scrooge Marketplace','A digital marketplace','5998029d-aa6e-42c0-a8aa-47b506e05592','http://localhost:8000','http://localhost:8000','default','authorization_code,implicit,password,client_credentials,refresh_token,hybrid','code,token',NULL,NULL,NULL,NULL,NULL,'http://localhost:8000'),
('idm_admin_app','idm','idm',NULL,'','','default','','',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `oauth_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_token`
--

DROP TABLE IF EXISTS `oauth_refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_refresh_token` (
  `refresh_token` varchar(256) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `scope` varchar(2000) DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `iot_id` varchar(255) DEFAULT NULL,
  `authorization_code` varchar(255) DEFAULT NULL,
  `valid` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`refresh_token`),
  UNIQUE KEY `refresh_token` (`refresh_token`),
  KEY `oauth_client_id` (`oauth_client_id`),
  KEY `user_id` (`user_id`),
  KEY `iot_id` (`iot_id`),
  KEY `authorization_code_rt` (`authorization_code`),
  CONSTRAINT `authorization_code_rt` FOREIGN KEY (`authorization_code`) REFERENCES `oauth_authorization_code` (`authorization_code`) ON DELETE CASCADE,
  CONSTRAINT `oauth_refresh_token_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE,
  CONSTRAINT `oauth_refresh_token_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `oauth_refresh_token_ibfk_3` FOREIGN KEY (`iot_id`) REFERENCES `iot` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_token`
--

LOCK TABLES `oauth_refresh_token` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_token` DISABLE KEYS */;
INSERT INTO `oauth_refresh_token` VALUES
('00ab77339bd15e49eca132dfe0db665956becc88','2022-12-25 22:28:54','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('0a6d474e95b8df973b10074ce0d257cc190909d2','2022-12-25 21:49:49','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('0b535fe81a8543f5f57aadaa3193a84bd41c90dc','2022-12-25 17:34:50','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('0bff3715478eb59161f2a7233df271d2be3a5364','2022-12-25 21:48:03','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('10fdacb2650d80f8d87c0e368fc5e7adcc817aaf','2022-12-25 16:30:25','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('15b9ea8ef1f675e0189a75b3dbdb1e4ff9d1869d','2022-12-26 10:49:52','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('180bc82026ab890ab5388ef97ad251ef9290c206','2022-12-25 17:08:29','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('19e61373abed376099a55c5fdd9acc18336f505a','2022-12-26 12:04:04','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('1c17cdb65533ce2aea01115a39d936f6543095e6','2022-12-25 16:42:31','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('20ebc7c547197c0dd1cfad3a88c6b3b735aea902','2022-12-25 17:23:07','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('258671759193c4d0ab326d6e4e9f8bd1d67f37cc','2022-12-25 18:47:03','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('2645ef5d29038e01b96f6062c82a9f0282ddb056','2022-12-26 10:22:54','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('33b61a11615baa208d601d428d696fcb7b241671','2022-12-25 18:42:33','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('3a7c6b2ef0fc91664e38651d0c9668091f565bdc','2022-12-25 17:38:59','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('3b87b011dbee5d0e2e290d86bbfaa3f9be9580db','2022-12-25 21:59:17','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('4766868e96f4c967a3302d3bd90801942dc9bc90','2022-12-25 22:26:33','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('4e1967e4ae6fb8edee8213008ced08e9b146a179','2022-12-26 10:54:44','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('512d865848150454fa23b5316c275a65b6601fb8','2022-12-25 16:56:11','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('51e13b07b75686fc1d67ddc3b89fbef6e7354f89','2022-12-26 10:31:43','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('5af803a984e7510059c77d8aecc284cd4c795522','2022-12-25 19:07:15','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('5d7afceca414607f6fb3a9dd187554b3c4e45189','2022-12-26 12:17:03','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('61aee441866dba9d0774e35e584dee6fbc6178e4','2022-12-25 17:24:37','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('64fe115b5462fa69e56e733372206372cc6d0662','2022-12-25 16:24:12','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('65abe3cce5849b73ffa67b04dd180a132d3a66bd','2022-12-25 18:33:59','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('666d38822b2c3d2682dd3c3b688b38a3162a9c1a','2022-12-26 12:44:05','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','09372be2-3975-490f-b0e5-65cd28d0ef70',NULL,NULL,1),
('6680bf9498a4431eaf595dbcc31e01c8552bc864','2022-12-25 22:37:07','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('7f6e9d7a37b7182b85d84f3a4064c239c7cf19c2','2022-12-26 12:42:44','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('8792b47c54d15815aba35feef7bb960f6c8ef475','2022-12-25 18:30:27','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('89767e048b53b721d24c29dfc6b8e9a339ec43ce','2022-12-25 16:52:15','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('90165541d8eca53ee434e9dd973b070f29de9715','2022-12-25 13:16:13','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('942f8704bde1d4fc393e94452274ef5852110a60','2022-12-25 21:52:41','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('94559ee09a734e2acd556af225bedff342e76bd2','2022-12-26 12:43:43','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('951c96060c6f3a327597fc17211a80656b2fa721','2022-12-26 10:26:42','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('a0732f3502008b0327b6f1ce92442fd3081dce30','2022-12-25 17:10:23','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('a07ef8d417c99c971a51ed1d2d29957f63d83d30','2022-12-26 10:48:24','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('af408fd0bd8a42f2b52afea3a035db6e202cc9a3','2022-12-25 17:35:50','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('b172c7d6e76bee6896ade83a9bf4e344583391ef','2022-12-26 11:59:17','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('b54f301eb8b8382f87cca6a1341d2def48347dc0','2022-12-25 17:23:26','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('ba3031913ff5ff39fa6867cd83ce292111b11423','2022-12-25 17:27:08','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('bacf4368457f4c300308d64f90523e8168684b38','2022-12-25 17:16:31','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('bdd42d45ccf90cd7a967dd9a9aba9ec513c032b9','2022-12-25 16:22:48','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('c1a28e092987d91b5dce02961345f42084cbe102','2022-12-25 18:39:58','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('cdb5351641fbccb8cf5bf0db3eb1829d6eba3180','2022-12-25 17:03:10','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('dc930bab5bcaf4ef5660683f6da4c621bcdb3997','2022-12-25 22:32:18','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('f6daba508a2b572657374cf3be7e270611dd0245','2022-12-25 17:26:12','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('fa14addcb9b4eaba163cc9af729bc28dfc0b29b7','2022-12-26 12:16:30','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1),
('fd54d1828f2ebc0ef34887eee93f8c1e74a8999f','2022-12-25 17:00:52','bearer','b7221fc8-5c00-44bb-a303-ecffdabe056a','4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c',NULL,NULL,1);
/*!40000 ALTER TABLE `oauth_refresh_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_scope`
--

DROP TABLE IF EXISTS `oauth_scope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_scope` (
  `id` int NOT NULL AUTO_INCREMENT,
  `scope` varchar(255) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_scope`
--

LOCK TABLES `oauth_scope` WRITE;
/*!40000 ALTER TABLE `oauth_scope` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_scope` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization` (
  `id` varchar(36) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `description` text,
  `website` varchar(2000) DEFAULT NULL,
  `image` varchar(255) DEFAULT 'default',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pep_proxy`
--

DROP TABLE IF EXISTS `pep_proxy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pep_proxy` (
  `id` varchar(255) NOT NULL,
  `password` varchar(40) DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `pep_proxy_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pep_proxy`
--

LOCK TABLES `pep_proxy` WRITE;
/*!40000 ALTER TABLE `pep_proxy` DISABLE KEYS */;
/*!40000 ALTER TABLE `pep_proxy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `is_internal` tinyint(1) DEFAULT '0',
  `action` varchar(255) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `xml` text,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `is_regex` tinyint(1) NOT NULL DEFAULT '0',
  `authorization_service_header` varchar(255) DEFAULT NULL,
  `use_authorization_service_header` tinyint(1) NOT NULL DEFAULT '0',
  `regex_entity_ids` varchar(255) DEFAULT NULL,
  `regex_attributes` varchar(255) DEFAULT NULL,
  `regex_types` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `permission_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES
('1','Get and assign all internal application roles',NULL,1,NULL,NULL,NULL,'idm_admin_app',0,NULL,0,NULL,NULL,NULL),
('2','Manage the application',NULL,1,NULL,NULL,NULL,'idm_admin_app',0,NULL,0,NULL,NULL,NULL),
('3','Manage roles',NULL,1,NULL,NULL,NULL,'idm_admin_app',0,NULL,0,NULL,NULL,NULL),
('4','Manage authorizations',NULL,1,NULL,NULL,NULL,'idm_admin_app',0,NULL,0,NULL,NULL,NULL),
('5','Get and assign all public application roles',NULL,1,NULL,NULL,NULL,'idm_admin_app',0,NULL,0,NULL,NULL,NULL),
('6','Get and assign only public owned roles',NULL,1,NULL,NULL,NULL,'idm_admin_app',0,NULL,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ptp`
--

DROP TABLE IF EXISTS `ptp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ptp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `previous_job_id` varchar(255) NOT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`,`previous_job_id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `ptp_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ptp`
--

LOCK TABLES `ptp` WRITE;
/*!40000 ALTER TABLE `ptp` DISABLE KEYS */;
/*!40000 ALTER TABLE `ptp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` varchar(36) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `is_internal` tinyint(1) DEFAULT '0',
  `oauth_client_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `role_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES
('provider','Provider',1,'idm_admin_app'),
('purchaser','Purchaser',1,'idm_admin_app');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_assignment`
--

DROP TABLE IF EXISTS `role_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_assignment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_organization` varchar(255) DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `role_id` varchar(36) DEFAULT NULL,
  `organization_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  KEY `role_id` (`role_id`),
  KEY `organization_id` (`organization_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `role_assignment_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_assignment_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_assignment_ibfk_3` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_assignment_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_assignment`
--

LOCK TABLES `role_assignment` WRITE;
/*!40000 ALTER TABLE `role_assignment` DISABLE KEYS */;
INSERT INTO `role_assignment` VALUES
(1,NULL,'b7221fc8-5c00-44bb-a303-ecffdabe056a','provider',NULL,'admin');
/*!40000 ALTER TABLE `role_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` varchar(36) DEFAULT NULL,
  `permission_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES
(1,'provider','1'),
(2,'provider','2'),
(3,'provider','3'),
(4,'provider','4'),
(5,'provider','5'),
(6,'provider','6'),
(7,'purchaser','5');
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_usage_policy`
--

DROP TABLE IF EXISTS `role_usage_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_usage_policy` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` varchar(36) DEFAULT NULL,
  `usage_policy_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `usage_policy_id` (`usage_policy_id`),
  CONSTRAINT `role_usage_policy_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_usage_policy_ibfk_2` FOREIGN KEY (`usage_policy_id`) REFERENCES `usage_policy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_usage_policy`
--

LOCK TABLES `role_usage_policy` WRITE;
/*!40000 ALTER TABLE `role_usage_policy` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_usage_policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trusted_application`
--

DROP TABLE IF EXISTS `trusted_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trusted_application` (
  `id` int NOT NULL AUTO_INCREMENT,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `trusted_oauth_client_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  KEY `trusted_oauth_client_id` (`trusted_oauth_client_id`),
  CONSTRAINT `trusted_application_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trusted_application_ibfk_2` FOREIGN KEY (`trusted_oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trusted_application`
--

LOCK TABLES `trusted_application` WRITE;
/*!40000 ALTER TABLE `trusted_application` DISABLE KEYS */;
/*!40000 ALTER TABLE `trusted_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usage_policy`
--

DROP TABLE IF EXISTS `usage_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usage_policy` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `type` enum('COUNT_POLICY','AGGREGATION_POLICY','CUSTOM_POLICY') DEFAULT NULL,
  `parameters` json DEFAULT NULL,
  `punishment` enum('KILL_JOB','UNSUBSCRIBE','MONETIZE') DEFAULT NULL,
  `from` time DEFAULT NULL,
  `to` time DEFAULT NULL,
  `odrl` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `usage_policy_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usage_policy`
--

LOCK TABLES `usage_policy` WRITE;
/*!40000 ALTER TABLE `usage_policy` DISABLE KEYS */;
/*!40000 ALTER TABLE `usage_policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` varchar(36) NOT NULL,
  `username` varchar(64) DEFAULT NULL,
  `description` text,
  `website` varchar(2000) DEFAULT NULL,
  `image` varchar(255) DEFAULT 'default',
  `gravatar` tinyint(1) DEFAULT '0',
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `date_password` datetime DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '0',
  `admin` tinyint(1) DEFAULT '0',
  `extra` json DEFAULT NULL,
  `scope` varchar(2000) DEFAULT NULL,
  `starters_tour_ended` tinyint(1) DEFAULT '0',
  `eidas_id` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
('09372be2-3975-490f-b0e5-65cd28d0ef70','dbanelas','Dimitrios Banelas','USER','default',0,'dbanelas@gmail.com','dbe6032c053b12f7fab36aaa67c2b62a427eb0ad','2022-12-12 12:43:17',1,0,NULL,NULL,0,NULL,'9b745911d875d9de'),
('4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c','pbanelas','Panagiotis Banelas','ADMIN','default',0,'pbanelas@gmail.com','55237c42ae74a8728e359e2642fa4e8ced969057','2022-12-11 13:16:02',1,0,NULL,NULL,0,NULL,'456fa44f83afbf58'),
('admin','admin',NULL,NULL,'default',0,'admin@test.com','4aed5ccd668af9b7433b1c13721d9cf25cdb1133','2022-12-09 00:36:22',1,1,'{\"visible_attributes\": [\"username\", \"description\"]}',NULL,0,NULL,'a33d09791a8d217a');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_authorized_application`
--

DROP TABLE IF EXISTS `user_authorized_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_authorized_application` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `shared_attributes` varchar(255) DEFAULT NULL,
  `login_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `user_authorized_application_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_authorized_application_ibfk_2` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_authorized_application`
--

LOCK TABLES `user_authorized_application` WRITE;
/*!40000 ALTER TABLE `user_authorized_application` DISABLE KEYS */;
INSERT INTO `user_authorized_application` VALUES
(2,'4bf29fdb-4d67-43c3-8dd8-1370c49b1b3c','b7221fc8-5c00-44bb-a303-ecffdabe056a','username,email','2022-12-11 13:16:13'),
(3,'09372be2-3975-490f-b0e5-65cd28d0ef70','b7221fc8-5c00-44bb-a303-ecffdabe056a','username,email','2022-12-12 12:44:05');
/*!40000 ALTER TABLE `user_authorized_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_organization`
--

DROP TABLE IF EXISTS `user_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_organization` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role` varchar(10) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `organization_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `organization_id` (`organization_id`),
  CONSTRAINT `user_organization_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_organization_ibfk_2` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_organization`
--

LOCK TABLES `user_organization` WRITE;
/*!40000 ALTER TABLE `user_organization` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_registration_profile`
--

DROP TABLE IF EXISTS `user_registration_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_registration_profile` (
  `id` int NOT NULL AUTO_INCREMENT,
  `activation_key` varchar(255) DEFAULT NULL,
  `activation_expires` datetime DEFAULT NULL,
  `reset_key` varchar(255) DEFAULT NULL,
  `reset_expires` datetime DEFAULT NULL,
  `verification_key` varchar(255) DEFAULT NULL,
  `verification_expires` datetime DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `disable_2fa_key` varchar(255) DEFAULT NULL,
  `disable_2fa_expires` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_email` (`user_email`),
  CONSTRAINT `user_registration_profile_ibfk_1` FOREIGN KEY (`user_email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_registration_profile`
--

LOCK TABLES `user_registration_profile` WRITE;
/*!40000 ALTER TABLE `user_registration_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_registration_profile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-12 17:07:37
