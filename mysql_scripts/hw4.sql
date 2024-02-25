/*1. Заполнить все таблицы БД vk данными (по 10-100 записей в каждой таблице).
Для заполнения таблиц использовался комбинированный метод: данные с сайта filldb.info (большая часть таблиц), а также ручной ввод*/

DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(100),
    lastname VARCHAR(100) COMMENT 'Фамилия', -- COMMENT на случай, если имя неочевидное
    email VARCHAR(100) UNIQUE,
    password_hash varchar(100),
    phone BIGINT,
    is_deleted bit default 0,
    -- INDEX users_phone_idx(phone), -- помним: как выбирать индексы
    INDEX users_firstname_lastname_idx(firstname, lastname)
);

INSERT INTO `users` VALUES (1,'Trey','Metz','marks.lesley@example.org','9f8fbe2981c5dd036012545319e2fd7b9f37cf84',92,'\0'),(2,'Aditya','Brakus','torphy.ike@example.org','5d2d124ac473eb42df2f07e416d623aedcfb4d88',6232364477,''),(3,'Luisa','Medhurst','erin.frami@example.com','482be8e64c5098492510aae76dc34865ecdd3fff',73,'\0'),(4,'Elfrieda','Harvey','mckenzie.alfonso@example.org','973e3bdf0f7441eff9a4399e3decac9d88e07bfd',7023275804,''),(5,'Adam','Wintheiser','antonietta00@example.com','1f87f174e3be528345a308e700362feff7890ea3',76,'\0'),(6,'Ottilie','Spinka','angel.reinger@example.org','85bf930837df2b9216c13a04a7a30a29f3c24f38',0,'\0'),(7,'Moriah','Towne','fern97@example.org','0d395f0a67fd4714a06f7da1bec02d3cebcd2bc3',1,''),(8,'Horacio','Bailey','maureen.hintz@example.org','f4902850c9291a104bc067ab11a4fe0963880c0c',34,''),(9,'Price','Keebler','vmckenzie@example.net','0202e493899d0344b8c978d3ab6b3c7c56e1d4da',262184,''),(10,'Rosemary','Lemke','sadie78@example.com','20fe984e841b383e22cd426a037f8acfb23c0bd7',9682803744,''),(11,'Vernice','Cronin','ledner.dariana@example.com','0c0a619a034dab9df4ee35ff41b04fecdd1f0e35',1,'\0'),(12,'Florida','Haag','schoen.alford@example.net','7cc43807cba30f2856f4cc68573c7232d151730d',0,''),(13,'Kacey','Emmerich','stefan72@example.org','83795538c787b5d300decee3bab253d6156605ae',1,''),(14,'Blake','Kuhlman','maggie91@example.com','3a5e7dd37b8e5394a66ff639fe7125a6762cbb62',1,'\0'),(15,'Lilian','Buckridge','wilford.bode@example.org','18e6ca37a21502b4e9b95d4b4686b1daada60a27',0,'\0'),(16,'Raymond','Corkery','brakus.olen@example.org','3d27a740be17b83d6f582ffd45eda4868e5c444c',0,'\0'),(17,'Augustus','Wolff','oberbrunner.ronny@example.org','ac181330160275a22859721dc4415fa4af1175a8',655,''),(18,'Buddy','Paucek','maryam.kertzmann@example.net','4c77981458b10f5d8cad333f68dd24fb5d30c07b',676681,'\0'),(19,'Matilde','Murray','mertz.adelle@example.com','991e7ad8f825d2afc3d5d1e27a55724dc1ebf8fd',591,''),(20,'Llewellyn','Stamm','caleb87@example.com','a27f4b1d4240d6c219d1c1238126e9d2b712f117',613,''),(21,'Fatima','Reichert','molly17@example.com','572eaff5000a86cd212990c1652e1d9a6adec472',87,''),(22,'Edwardo','Connelly','whills@example.org','bcbe1861f81e0c147b0e4fbe2cbfdb4f4ad98b25',0,''),(23,'Ladarius','White','herminio91@example.com','35febdc99b61213f18c20b4b81ea0aee85f00fbd',4125803726,'\0'),(24,'Wade','Mayer','janiya69@example.net','f795c4d2513909339ba18287bc605440b2a91960',6747848755,'\0'),(25,'Josefina','Pfeffer','avery42@example.org','a9b562cfdceafb33a7d76fbb429335ab2b2b3738',508964,'\0'),(26,'Nella','Rutherford','feest.savanah@example.net','3ab9ccc51ce1b22419bf36e59c7fbaaabede64cc',0,'\0'),(27,'Eliza','Nader','clarabelle.walter@example.org','d51b16c2aafbfa5399d13a5227b04cc2f755816b',924,''),(28,'Murray','Thiel','ludie07@example.com','934859f5085582e4ba1ad9cea1b3183b3d2667f6',740378,''),(29,'Ruthie','McGlynn','pearlie45@example.com','8f1d9b6bb29fe2d54be4a8ad9009c5eb6f7585f2',2014330057,''),(30,'Margaret','Dietrich','makayla.willms@example.net','5763173c334d505b0e8c5e0e3322f3c0c13eb442',570886,''),(31,'Ansley','Waters','jledner@example.com','f0a23c6df9576cdf3926297b7c2933eb7134b78f',965734,'\0'),(32,'Carson','Breitenberg','agustin35@example.com','9d276d66c4e710588b36ce76921afe90cef40f9e',3513037427,''),(33,'Samir','Blick','duane.wisozk@example.net','c63d89e6f7a57289522b3c9cee0bcce5144bf4ff',517152,'\0'),(34,'Linnea','Gerhold','to\'keefe@example.com','de6f2075d61cb85d0916967a1baaee08ca7c622c',0,'\0'),(35,'Alexie','Rolfson','jerrod32@example.com','dfbd9493e9ca4108a225670129c87d27e6cf921c',496196,'\0'),(36,'Wyatt','Bode','makayla.bogisich@example.com','9a3496ad69bae0b40df8992caa26a397f78ea475',0,''),(37,'Stephon','Pfannerstill','kreinger@example.com','f0907ec6347ffb0c88c41f9d394b9a78aeca5856',1,''),(38,'Trudie','Toy','bonita86@example.net','c4685d08a65232c2cf3b17aa887df2d60782560e',507,'\0'),(39,'Casandra','Ruecker','olehner@example.com','f6c6a6fe0dcf4b5c717d12a020a1a7dbdf5e9e17',7,'\0'),(40,'Evie','Fritsch','rogelio54@example.com','92761f2a90bacbac51a7d29a48706dcd3913ca39',91,''),(41,'Hollis','Wolff','wlakin@example.com','1cb5bab56c69ff5a2d01f26ac773e44686ff41c5',714424,''),(42,'Carol','Pouros','wtremblay@example.net','1e8cc98d3f77e241387094caa2c43b9314f5fc7f',1,'\0'),(43,'Kip','Cartwright','hagenes.micheal@example.org','005f8ad64dfda70e8e78ce763ff8b168d7ab8620',630,'\0'),(44,'Makenna','Reichert','kaley.goodwin@example.com','830042ee0a304fb64a9d7006160a749ba91cb631',611,'\0'),(45,'Keira','Considine','lilyan46@example.net','66dbe33e509bd337f782ec464fb35741e3415ce6',0,'\0'),(46,'Crawford','Kulas','nnader@example.org','eb0731a0cd1c24c4ede1c8662f5b71b1314e3ac7',122474,''),(47,'Faustino','Collier','laverne.kulas@example.org','3084d75fba6055b0b97fb79136f7f6620583a7b5',9078772095,''),(48,'Isabel','Maggio','hettinger.euna@example.com','de5d5f9b5b3b5a17d6a75b4628101e61d4404630',566,'\0'),(49,'Marshall','Muller','blanche53@example.com','dbd53db42261aec00f8eb287ee02b4c2d7640b09',0,''),(50,'Winnifred','Kirlin','gonzalo20@example.org','ad860e1d9ea7726ce087204cc6eed3f487c81709',0,'\0'),(51,'Amos','Hermann','christelle72@example.org','f6f2ca09737079dd506bc015dfba7b058b93b7e2',1,'\0'),(52,'Beaulah','Steuber','cgibson@example.org','247692caf3d689da169dfa4100f97800ecfce46a',806207,''),(53,'Jayden','Beatty','eichmann.roger@example.com','42117839db871a79bf309893c02d18487617364e',228,''),(54,'Baby','Langosh','lockman.else@example.net','b8297bcc87fcccd3e4be650bf8d2f787ee9b9d11',0,''),(55,'Sigrid','Mitchell','randall13@example.com','d4f70f4297c4e052b4a82896d53dd4c1ff24862a',1,''),(56,'Brady','Herzog','melany.schaefer@example.org','9728b2d25492dd3aa0c158e2b83eede9528b18b5',0,'\0'),(57,'Jordy','Windler','rico.daugherty@example.net','289f5874f0b1669e260c02e68274f4a969986f10',468503,'\0'),(58,'Ashleigh','Effertz','cremin.imelda@example.net','f667621aade791be0b130d1dd9b53218288205e6',832,'\0'),(59,'Hillary','Pacocha','dickens.luisa@example.com','f34f71facc03a5efc7e24a70d4ec721734f85fa3',9,'\0'),(60,'Tia','Wisozk','ifunk@example.net','375daf049168a38260f7e57ab21896d0410b8ee6',0,'\0'),(61,'Luna','Hills','haley.deron@example.com','f6dfc7a9c691377920bcdcc1b07ea0d8815def87',853812,'\0'),(62,'Terrill','Hayes','xbarrows@example.net','c754a18837847d9b61fbb14aaa9042368759f0e0',15850,'\0'),(63,'Kayli','Lindgren','equigley@example.org','d54396ce934dbb11b53da95eb9800a5a99c0c83d',7390755542,'\0'),(64,'Ernest','Baumbach','antwon.ortiz@example.org','a198b5300517271645743288c38911547ef78fea',1,'\0'),(65,'Darron','Gutmann','lesly.champlin@example.org','ad9048d6cafab2ea201d90bc98f47cea6a219d96',517830,'\0'),(66,'Alexandro','Bogisich','mike.kulas@example.com','149994a8c614bf4c959b09d060c71a444367bf73',1,'\0'),(67,'Diana','Gerhold','pkub@example.com','1b650239a5a90955713f9474929962dacc55fc71',1,''),(68,'Kamren','Schuppe','yreinger@example.org','07f905e1a3b9947e199016faf80ad931539b1135',573,'\0'),(69,'Rick','Jones','kgutkowski@example.com','f9e370255854f3a34c296e509e75dbae8b4642ed',714,''),(70,'Autumn','Balistreri','fpfeffer@example.org','dea2461a7f1becbda52078acf1ddae1b540829a3',105804,'\0'),(71,'Luna','Ondricka','nelda.dibbert@example.com','32ff222d4ff1eface5b4eb564b7dd16b83ab442b',263224,''),(72,'Candace','Reilly','fern.casper@example.com','ed04e80f2e40930e9b05423976d93d5534e0282f',1,''),(73,'Neha','Abernathy','tyrique91@example.net','4dd126cf3d32044ab693a31b0f0f24174779e6cd',1,'\0'),(74,'Leslie','Quitzon','josiah11@example.net','3d08edd5169ec741261352e8f76bbc766674da68',60291,''),(75,'Kristin','Larson','dkeeling@example.net','4bbcd72371d215c3b59a616379b06308642c1bcb',4752056905,''),(76,'Kaitlin','Thiel','amalia66@example.org','b07b50af458300283585dc665682e38141739e2a',1,'\0'),(77,'Marianna','Hermiston','uriah19@example.com','71f5e1cf9cccea5f970b4e7faf436b259872a7b5',0,''),(78,'Eryn','Fay','gmayer@example.com','245953939fffd055e05a55935bf6aa8dad142285',0,'\0'),(79,'Cydney','Osinski','yolanda.klocko@example.org','7fa4e81fbacff2fb085a9907d792abfa520012ae',506674,''),(80,'Kianna','Jakubowski','shemar.quigley@example.com','00af5d248f8ac8882f8485d9d95ddd91772d154d',1,'\0'),(81,'Tavares','Shields','kassulke.francesco@example.net','dc9235cbd6e04e15beef0d5039220236b4bae36a',0,''),(82,'Leonor','Grant','wayne01@example.com','759e1312dabf5d36d09fab4e722ac5565f1dbf8b',742,'\0'),(83,'Britney','Gleichner','winnifred.torphy@example.com','35e10b5a0156ca6bfc6b283d8bcebcbb289e03a0',194547,''),(84,'Brad','Schowalter','lakin.fiona@example.com','4335f352ffd7a7413e287c66e955216201f943f0',1,''),(85,'Francesco','Ebert','matt61@example.org','a0a87d7d45911fa81b0296a677be9889a2059441',9868487783,''),(86,'Eldora','Murphy','fhuel@example.net','10e4aa64e5b8c4b9de15560206f7f6a6cb6b0184',890,'\0'),(87,'Edythe','Mayer','bo.schowalter@example.org','ec9f5545f4725e8622e425587b16af94adce6469',1,''),(88,'Sim','Douglas','ignacio32@example.org','938bfac9c661213a718c49d4146624a865053bd8',1,''),(89,'Rowland','Johnson','qhermann@example.net','7c7a8eb0f7250a19eb67812c12b2d16fe5d18477',72,''),(90,'Vilma','Shanahan','udickens@example.com','47a0d7f5ea9d8913e6bce130a6f27f2061773134',553708,''),(91,'Flo','Weimann','schimmel.maggie@example.org','d5a714f087f0b944d5580adaadc60b2b22c171f1',60871,''),(92,'Santa','Davis','miller.seth@example.net','8305cb75717c9d7e529677c22b3786e2078440a5',3304682148,'\0'),(93,'Jonas','Jacobson','nels.mills@example.net','d884abb076cf1a84ed020826cfb6c485ad9da06a',480453,'\0'),(94,'Sally','Senger','hilma.pouros@example.com','fbdb7e035b8a71349f766eba00e8a2b1579b4633',1,'\0'),(95,'Clarabelle','Schmeler','evert66@example.com','63d64c30f8e6a40a29df1da940a52e086640757a',1,'\0'),(96,'Clemens','Lesch','ervin.braun@example.net','d6d760795662c9d11d013d943e16000019b97e88',14,'\0'),(97,'Bennett','Schoen','alice50@example.net','24f74217beead3623fd966ab91b659f5c0a4ef58',0,''),(98,'Dexter','D\'Amore','wisozk.donny@example.org','7b0c7ab3aa4edc0939feaa271d25cd4ec2a23ee4',1,''),(99,'Breana','Rippin','estel.botsford@example.com','c21d93f95fa33b25326c838d716def67804475ae',52,''),(100,'Delaney','Senger','qhalvorson@example.com','b2663ce683f31d2f2d1beb1cc58e4885d02f8a46',5,'');

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id SERIAL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100)
    -- , FOREIGN KEY (photo_id) REFERENCES media(id) -- пока рано, т.к. таблицы media еще нет
);

ALTER TABLE `profiles` ADD CONSTRAINT fk_user_id
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON UPDATE CASCADE ON DELETE CASCADE;

INSERT INTO `profiles` VALUES (1,'m','2016-02-07',1,'2003-02-28 23:18:33','illo'),(2,'f','1973-07-10',2,'1995-06-05 20:26:00','veniam'),(3,'f','1974-01-06',3,'1976-02-17 08:15:17','eos'),(4,'m','1985-06-04',4,'2021-06-16 06:44:38','voluptatem'),(5,'f','1984-03-14',5,'2009-05-05 13:25:47','explicabo'),(6,'f','2020-02-24',6,'2009-08-02 07:56:29','et'),(7,'f','1981-03-13',7,'1992-05-23 05:11:37','impedit'),(8,'m','1996-08-31',8,'2016-09-14 12:34:10','voluptates'),(9,'f','2007-07-14',9,'2013-11-28 22:33:45','dicta'),(10,'f','2022-03-23',10,'2008-07-25 17:18:09','sint'),(11,'m','2001-12-11',11,'2005-01-08 13:25:06','eos'),(12,'m','1994-09-12',12,'1993-12-11 11:20:43','provident'),(13,'f','2003-01-09',13,'1977-07-23 11:50:33','quam'),(14,'m','1975-01-31',14,'2019-03-06 09:14:06','voluptatem'),(15,'m','2003-08-30',15,'1979-02-27 08:16:05','neque'),(16,'m','1999-10-13',16,'2009-11-10 14:45:58','fugit'),(17,'m','1997-11-16',17,'1979-03-10 19:15:24','mollitia'),(18,'f','2021-10-28',18,'2006-09-27 19:39:33','exercitationem'),(19,'f','2013-08-26',19,'1974-01-12 19:26:24','iure'),(20,'f','1987-05-15',20,'2009-09-10 00:59:33','quia'),(21,'m','1972-02-03',21,'1994-08-16 18:06:09','aut'),(22,'m','2012-11-05',22,'2007-05-14 17:48:43','quo'),(23,'f','1985-10-28',23,'1999-10-05 12:19:56','voluptates'),(24,'m','2013-06-05',24,'2014-08-26 11:01:33','unde'),(25,'m','2014-08-13',25,'2020-01-27 19:41:33','excepturi'),(26,'m','1973-03-09',26,'1975-01-30 16:52:39','accusamus'),(27,'f','1974-12-30',27,'2014-04-23 00:32:24','reprehenderit'),(28,'m','1978-08-23',28,'1974-04-19 00:13:24','veniam'),(29,'f','1983-09-27',29,'1971-02-13 07:12:10','nulla'),(30,'m','2013-09-25',30,'2004-09-07 06:45:42','maiores'),(31,'m','1978-05-29',1,'1990-01-28 22:04:49','eius'),(32,'m','1995-07-19',2,'2006-05-14 02:51:45','quo'),(33,'f','2018-06-18',3,'2000-06-11 22:49:11','a'),(34,'m','1984-05-26',4,'2007-09-14 21:13:06','et'),(35,'m','2012-03-08',5,'2012-01-24 10:11:59','est'),(36,'f','2015-12-18',6,'1976-04-11 12:27:48','voluptas'),(37,'f','2017-08-20',7,'1986-07-13 18:28:32','nostrum'),(38,'f','1982-07-03',8,'1973-10-14 20:44:03','qui'),(39,'m','1984-12-18',9,'1989-09-27 04:40:40','enim'),(40,'f','2003-09-10',10,'1996-09-03 04:08:19','quasi'),(41,'m','2007-08-22',11,'2011-09-15 15:40:09','qui'),(42,'f','2020-06-20',12,'2009-12-11 03:48:59','temporibus'),(43,'m','1974-12-24',13,'2005-04-20 00:13:28','aut'),(44,'m','1991-06-24',14,'1971-06-21 16:23:06','aliquam'),(45,'f','2010-09-03',15,'1987-06-07 17:42:46','incidunt'),(46,'f','2016-10-18',16,'2007-10-19 23:14:10','et'),(47,'m','2007-10-18',17,'1996-03-17 02:33:02','quae'),(48,'m','1978-10-10',18,'2010-09-21 00:25:49','aperiam'),(49,'m','1995-05-21',19,'2001-07-04 16:47:43','sint'),(50,'m','1971-10-16',20,'1972-11-05 10:34:24','sed'),(51,'m','2015-04-25',21,'2017-08-10 16:02:14','architecto'),(52,'f','2010-05-10',22,'2011-02-21 06:14:02','voluptatem'),(53,'f','2021-02-16',23,'2021-10-03 18:27:34','beatae'),(54,'f','1981-12-11',24,'1973-12-11 12:17:25','iste'),(55,'m','1999-07-01',25,'2019-03-20 11:54:10','facere'),(56,'m','1984-12-26',26,'1981-03-23 12:05:51','rerum'),(57,'f','2022-08-10',27,'2008-08-18 22:50:48','rerum'),(58,'m','2001-03-26',28,'1983-11-25 16:25:40','hic'),(59,'m','2020-01-05',29,'1985-07-04 22:50:05','nemo'),(60,'f','1982-08-12',30,'1981-09-10 12:02:19','magni'),(61,'m','2021-09-02',1,'1984-06-12 07:32:06','veritatis'),(62,'f','1984-07-21',2,'1992-05-12 19:27:23','consectetur'),(63,'m','2004-09-15',3,'2009-09-02 05:56:12','eum'),(64,'f','2021-02-22',4,'2020-06-08 21:37:34','doloremque'),(65,'m','2004-11-16',5,'1993-04-24 05:26:55','facere'),(66,'f','1976-12-16',6,'2019-11-23 14:16:50','quia'),(67,'m','2001-06-03',7,'1983-01-24 02:47:01','voluptatem'),(68,'f','2006-03-21',8,'2016-07-18 21:54:54','dolor'),(69,'m','2015-09-06',9,'1985-03-27 03:48:03','facere'),(70,'m','2016-07-07',10,'1994-09-19 00:53:18','impedit'),(71,'f','2012-07-30',11,'2020-09-22 20:03:59','accusamus'),(72,'f','2005-02-27',12,'2010-08-02 00:57:43','optio'),(73,'m','1985-07-27',13,'1992-03-23 12:36:00','alias'),(74,'m','1970-09-20',14,'1989-02-13 22:07:52','beatae'),(75,'f','2000-05-15',15,'2010-12-18 21:10:42','optio'),(76,'m','1979-06-30',16,'2013-02-09 06:27:05','est'),(77,'f','1975-02-27',17,'2007-01-03 06:19:12','modi'),(78,'f','1982-12-22',18,'2005-10-01 07:24:23','vel'),(79,'f','1989-07-27',19,'2002-02-24 00:28:03','aliquam'),(80,'m','1989-12-19',20,'1973-05-16 14:57:42','rerum'),(81,'f','2019-12-16',21,'2011-01-03 02:45:06','impedit'),(82,'f','2005-10-26',22,'2006-04-05 20:09:37','sint'),(83,'m','2014-07-22',23,'2002-10-21 18:21:18','ut'),(84,'m','2006-03-17',24,'2010-11-09 23:33:45','in'),(85,'m','2003-10-27',25,'2016-09-12 13:09:32','expedita'),(86,'m','1996-07-17',26,'1982-07-20 06:02:40','quos'),(87,'f','2007-11-13',27,'1977-10-19 16:52:59','praesentium'),(88,'m','1974-03-09',28,'1989-05-15 10:15:35','omnis'),(89,'m','2018-06-21',29,'1995-07-27 06:53:13','voluptatem'),(90,'f','2005-05-11',30,'1987-11-11 12:14:29','adipisci'),(91,'m','1996-09-29',1,'1993-09-27 01:03:52','beatae'),(92,'f','2015-08-22',2,'2003-07-18 02:16:40','ut'),(93,'f','2005-04-19',3,'2002-05-20 21:05:44','qui'),(94,'m','1984-09-06',4,'1977-09-23 18:25:19','non'),(95,'f','1988-09-06',5,'2007-11-07 23:45:09','consequatur'),(96,'f','1978-12-01',6,'1985-08-22 13:31:13','possimus'),(97,'m','1987-09-21',7,'1991-01-15 09:29:23','nam'),(98,'f','1978-07-18',8,'1994-09-03 17:08:42','et'),(99,'f','1999-07-15',9,'2008-01-18 12:26:27','dolor'),(100,'m','2013-07-28',10,'2020-07-04 16:33:38','aut');

-- NO ACTION
-- CASCADE 
-- RESTRICT
-- SET NULL
-- SET DEFAULT


DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(), -- можно будет даже не упоминать это поле при вставке

    FOREIGN KEY (from_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (to_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO `messages` VALUES (1,72,53,'Adipisci et numquam natus numquam sunt autem nam officia. Eaque nam eligendi dolores fuga iusto unde veniam a. Ducimus libero qui at necessitatibus consequatur. Quas exercitationem unde aut corrupti.','1992-08-27 12:15:06'),(2,98,59,'In veniam maxime at tempora dolor minus rerum. Et ex assumenda aut nemo assumenda. Quia iste dolor ut asperiores dolorum praesentium. Eos animi tempore repudiandae ex sed rerum voluptatibus.','1994-12-23 23:59:55'),(3,29,99,'Nihil quae aut voluptatum minima excepturi. Facilis praesentium tempore voluptatem dolor. Qui aliquid deserunt rerum impedit sequi. Vero et ipsam dolor debitis deleniti similique blanditiis.','1989-05-26 19:08:02'),(4,92,76,'Ullam sed et nisi facilis. Quis adipisci expedita ut rerum voluptatem ipsum. Odio quos fuga quos. Voluptas sint tenetur et corporis quis recusandae eveniet reprehenderit. Magni labore harum cumque nihil pariatur odio.','2001-03-15 22:47:40'),(5,11,82,'Dicta et facere rerum. Itaque voluptatem quae quos ut. Nihil culpa et delectus aut numquam voluptate reiciendis.','1996-07-16 00:33:50'),(6,94,50,'Tenetur culpa vitae sapiente aut sunt voluptas. Et nulla tempora et adipisci voluptatum. Fuga consequatur necessitatibus quaerat veritatis eligendi.','2012-06-28 03:54:46'),(7,20,55,'Ut adipisci commodi nemo excepturi impedit. Enim repudiandae iste molestiae odio vitae. Facilis in autem iusto. Tempora nihil possimus non dolorum minima eligendi et.','1981-06-04 09:10:58'),(8,19,44,'Dolores quibusdam quia sint in consequatur quod. Fugiat adipisci voluptate qui sint veritatis ab. Dolor mollitia est non minima voluptatem enim quisquam. Enim ducimus voluptatibus aliquid veniam.','1994-05-28 05:25:47'),(9,39,30,'Voluptatem corporis quo quidem quia et ut. Aut nihil dolorum facilis aut nobis. Corrupti voluptatem et consectetur.','1989-02-24 10:05:41'),(10,97,4,'Officiis quasi perspiciatis aut sed omnis voluptatem. Adipisci ut possimus aut sint. Enim ut sed sit pariatur sit. Reprehenderit sed illum corporis corrupti commodi amet.','1993-04-22 10:53:34'),(11,13,100,'Quibusdam nam inventore quia laudantium. Nobis iusto dolore consequuntur minus. Aut dolorem aut omnis velit tempora ipsam adipisci.','1992-02-06 21:12:44'),(12,88,20,'Eligendi vero odio debitis alias quam maxime. Deserunt accusantium aliquid debitis alias. Non ratione sunt sed. Deserunt harum iure ut recusandae dicta error reprehenderit.','2019-07-13 10:34:23'),(13,37,14,'Commodi consequuntur vero et expedita. Ea asperiores cum et officia possimus doloribus ut. Placeat quia dicta dolores sint. Dolorem velit qui itaque quasi cumque eligendi odio eius.','1987-12-13 17:15:42'),(14,51,88,'Aut cumque voluptatem totam cumque alias. Ut architecto at sed quo alias sed. Minima esse id inventore totam quis nisi consequatur dolore. Mollitia reiciendis ut et veritatis aut. Minus possimus non eum quos consectetur reiciendis.','1999-04-22 10:16:29'),(15,69,91,'Ipsum velit pariatur animi cupiditate. Ut porro architecto ea modi omnis. Omnis sequi corporis est aliquam similique.','2022-04-16 02:47:32'),(16,27,40,'Voluptatem corrupti illo nostrum omnis quas nisi voluptatem. Aut est ratione et provident provident quae cum. Consequuntur doloremque et non perspiciatis.','2022-04-16 08:59:51'),(17,44,24,'Qui laudantium harum minima. Ut et nostrum ut voluptatem. Sunt similique aspernatur qui unde occaecati inventore ut eum. Quibusdam ut dolor sit voluptatem perspiciatis eveniet. Est voluptates autem dicta officia neque accusamus nisi.','1997-12-15 16:56:48'),(18,98,73,'Voluptatem facere corporis vero. Vel ipsa laborum fugit. Nihil quis et quae soluta debitis. Et earum asperiores incidunt facere qui.','2007-07-30 14:39:56'),(19,23,90,'Alias voluptas soluta blanditiis ab qui vel in. Occaecati quo dolor totam. Dolor tempore quidem laudantium architecto omnis atque.','2006-08-20 09:10:20'),(20,48,34,'Consequatur incidunt debitis porro. Debitis excepturi vel dolore maxime accusamus vel praesentium ullam. Maiores quia blanditiis quod omnis consequatur consequatur nesciunt.','2000-10-28 10:19:14'),(21,71,41,'Quia sint eaque nulla velit recusandae doloremque. Sit magni praesentium et illo. Animi molestias quis dolores cumque nulla nesciunt voluptatem.','2021-10-29 05:57:35'),(22,83,91,'Tempora nihil est reprehenderit dolor asperiores maxime sequi. Et dicta vero aut qui dolore voluptatem voluptas sit. Aut sapiente dolor sed facere labore delectus occaecati.','2015-08-09 20:52:07'),(23,96,1,'Nihil quia placeat dolore dolor debitis quia. Ut dolores temporibus dolores corrupti perferendis odio. Nihil et dolorum hic aut aperiam veniam.','1990-12-27 22:01:19'),(24,34,34,'Ut velit a sed aliquam. Quas fuga ab modi minima est fuga. Quis totam rerum dolor est quasi.','1991-07-20 18:56:39'),(25,30,31,'Doloremque aliquam velit et in delectus asperiores. Ipsum reprehenderit modi odio et. Culpa aliquam sapiente eos repellat sed odit blanditiis.','1971-01-23 21:12:01'),(26,38,43,'Consequatur molestiae eveniet facere illo tenetur. Fugiat ratione quaerat voluptatum officia ut perspiciatis.','2009-04-27 12:27:21'),(27,31,25,'Ipsa numquam quis aspernatur. Quidem nisi quaerat esse. Sapiente et beatae dolorum.','1970-12-27 08:46:01'),(28,62,67,'A doloribus rerum labore aut commodi. Voluptas illo mollitia repellat non. Est explicabo dicta voluptatem necessitatibus provident. Assumenda rerum quasi rem consequuntur.','1979-12-31 18:10:04'),(29,39,12,'Quo alias hic officiis veritatis accusamus. Labore culpa saepe voluptas rerum enim necessitatibus facere. Quia ea ut nemo ad. Asperiores temporibus sint reiciendis occaecati dolore facilis.','2010-02-27 01:05:16'),(30,54,7,'Sed cum odio id non tempore ut. Repudiandae est ea aperiam non sit consectetur. Aut esse dolorem velit ea. Odio voluptas est non enim ullam voluptatibus.','2018-03-21 18:19:50'),(31,3,81,'Error nobis sint quaerat aut similique suscipit. Illo voluptatem voluptatem repellendus eius ut omnis illo. Quis totam iste eius placeat aperiam accusantium. At nam voluptatibus repellat eos.','2000-10-04 00:19:28'),(32,47,47,'Eos voluptatibus mollitia vero voluptas voluptas. Est a eum voluptatem autem. Quas delectus voluptatem expedita aperiam voluptate iusto. Autem eius sed nulla earum at ratione voluptatibus aliquam.','1971-10-10 04:17:20'),(33,4,44,'Est vitae ex debitis et quis dolor. Ut nihil non labore voluptatem. Est magni enim et soluta quis autem vel nulla. Error vel ad quia voluptatem magni repellendus.','1980-08-28 10:01:33'),(34,19,27,'Tempore adipisci aut dolores reiciendis molestiae quidem aut eveniet. Porro reprehenderit totam ut nulla quo commodi dolorum. Sunt corrupti et rerum nihil neque et. Alias atque vitae animi dolores nobis consequatur laborum.','2015-08-09 08:22:51'),(35,33,67,'Cupiditate doloribus quis culpa vitae sapiente voluptatibus ut. Molestiae saepe quis eius non aut. Molestiae voluptatem vel architecto quod. Voluptatibus atque quia repudiandae cum.','1996-02-09 21:17:24'),(36,60,4,'Explicabo dolorum voluptatem totam. Aut tenetur illo quae animi doloribus quaerat et. Sed et aperiam est voluptatem.','1984-05-25 03:33:46'),(37,7,43,'Et dolores quia voluptatem saepe. Modi nulla quod ut voluptatem. Ullam sed nisi ipsa vitae qui.','2017-05-28 01:20:16'),(38,94,2,'Sit exercitationem in qui sed natus ab. Totam vero ut eveniet quia omnis assumenda. Placeat enim et officia praesentium. Unde velit quidem molestiae nostrum autem dignissimos.','1990-08-12 13:27:22'),(39,43,27,'Recusandae accusantium assumenda facilis est nemo qui perferendis. Blanditiis atque ad et ut omnis ea occaecati. Qui porro sapiente numquam et.','1973-12-26 18:23:43'),(40,36,73,'Voluptatem architecto id quis maxime in. Rem omnis natus porro laboriosam quis quia dolor. Et incidunt enim ducimus eligendi vel ut. Ea repellat ut ullam corrupti consequatur sit.','1993-06-29 08:49:48');

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	-- id SERIAL PRIMARY KEY, -- изменили на составной ключ (initiator_user_id, target_user_id)
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    -- `status` TINYINT UNSIGNED,
    `status` ENUM('requested', 'approved', 'declined', 'unfriended'),
    -- `status` TINYINT UNSIGNED, -- в этом случае в коде хранили бы цифирный enum (0, 1, 2, 3...)
	requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME on update now(),
	
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (target_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO `friend_requests` VALUES (3,15,'requested','1971-10-15 20:26:22','2005-02-01 22:25:50'),(3,33,'requested','2012-04-20 07:22:07','2019-06-16 17:10:50'),(4,89,'declined','2008-02-15 03:04:56','1986-05-14 09:31:15'),(4,99,'declined','1993-11-14 11:55:44','2011-08-24 17:24:09'),(5,17,'unfriended','1993-02-13 00:10:20','2010-05-03 16:50:47'),(5,34,'unfriended','2001-11-13 03:56:44','1999-12-19 15:59:50'),(9,71,'unfriended','1977-06-15 12:14:39','2003-10-16 21:28:23'),(9,84,'unfriended','1994-03-12 19:38:43','1987-01-31 09:12:04'),(9,92,'approved','2002-05-07 10:58:11','2000-06-23 10:42:58'),(11,20,'unfriended','1978-02-16 04:50:17','2007-03-30 23:18:05'),(11,43,'approved','1989-01-03 21:42:04','1972-08-28 10:17:02'),(11,93,'requested','1976-05-27 11:34:25','2007-03-06 00:48:17'),(12,71,'requested','1974-03-25 22:49:15','2012-09-12 16:33:54'),(13,43,'requested','1993-09-10 21:24:58','1982-04-30 15:05:27'),(15,28,'requested','2001-01-01 15:33:18','2011-08-06 15:03:41'),(15,95,'unfriended','1994-06-10 15:20:49','1989-04-11 07:48:20'),(16,16,'declined','1992-12-24 22:45:05','1971-03-09 01:09:48'),(17,64,'approved','2020-05-11 14:30:25','1988-08-14 22:01:22'),(18,65,'requested','1998-11-07 05:43:18','2003-06-16 16:19:12'),(18,95,'approved','2018-09-26 23:52:37','2003-11-26 13:15:29'),(19,72,'approved','1995-03-07 10:57:13','2012-01-06 01:52:50'),(21,50,'declined','1999-01-09 04:53:07','1987-10-06 05:52:45'),(25,95,'declined','2010-06-30 17:34:58','2008-05-31 22:27:54'),(25,96,'unfriended','1975-06-23 01:45:07','2021-05-22 11:54:58'),(27,41,'declined','1985-11-19 17:31:41','1981-08-21 08:15:13'),(27,85,'approved','1978-01-28 03:29:10','2011-09-21 06:22:47'),(28,16,'unfriended','1983-07-11 12:54:20','2006-12-29 11:03:26'),(28,61,'approved','2003-05-10 03:22:57','1978-06-26 23:21:24'),(28,83,'unfriended','2011-05-05 20:27:33','2019-07-05 05:56:32'),(29,19,'declined','1997-11-18 19:04:23','2013-10-29 15:49:22'),(29,87,'declined','1983-01-11 12:42:08','2008-05-03 08:53:02'),(32,68,'declined','1973-02-10 14:28:59','1974-03-07 09:59:42'),(33,42,'unfriended','1993-12-27 00:01:54','1999-04-23 15:43:38'),(37,84,'unfriended','1998-04-10 13:00:36','1972-10-27 20:35:04'),(38,66,'declined','2015-02-16 13:54:14','2012-11-24 12:22:49'),(39,13,'declined','2009-09-04 07:47:24','2017-07-05 07:16:39'),(39,82,'declined','1989-09-24 23:10:47','2019-06-25 15:44:39'),(41,52,'unfriended','2008-01-30 16:18:14','2022-01-01 12:04:18'),(41,92,'approved','1980-08-20 01:36:48','2022-08-24 17:40:44'),(42,32,'declined','1973-07-19 22:15:28','1989-04-08 14:09:30'),(42,57,'unfriended','2016-02-23 07:57:56','2020-12-04 20:06:44'),(44,48,'unfriended','2020-06-04 16:22:34','1993-04-22 23:34:35'),(45,83,'approved','2000-06-05 23:00:17','2021-07-17 02:53:19'),(47,3,'requested','2000-12-10 23:37:38','1987-08-24 02:24:02'),(49,48,'declined','1975-12-11 02:17:05','1983-09-28 07:43:46'),(49,81,'declined','1992-12-05 15:50:56','2022-08-17 17:58:25'),(49,91,'requested','1996-11-01 12:04:35','1985-11-14 04:25:57'),(50,39,'requested','1988-06-23 19:50:32','1983-02-17 19:22:52'),(51,14,'requested','2013-11-07 21:43:08','2005-10-22 22:48:50'),(53,51,'unfriended','2018-02-21 10:36:04','2010-12-25 11:33:41'),(55,22,'unfriended','2005-03-04 21:42:45','2011-05-26 20:46:34'),(56,60,'declined','1997-03-23 00:08:58','2007-02-15 02:31:30'),(57,43,'approved','1979-08-04 06:10:57','2022-05-05 10:35:12'),(60,5,'unfriended','1971-12-21 03:35:20','2015-01-28 19:59:26'),(61,41,'unfriended','1975-07-23 04:41:18','1972-05-28 16:05:05'),(63,78,'approved','1970-04-26 20:17:27','1971-12-22 10:30:14'),(64,2,'approved','2007-04-13 06:44:34','2017-08-26 02:29:46'),(65,14,'unfriended','2003-12-12 05:31:15','1971-05-22 10:56:09'),(65,55,'declined','1990-09-11 11:13:17','2018-06-03 11:12:47'),(65,59,'approved','1990-12-03 20:23:54','1987-12-24 00:46:02'),(66,48,'declined','1970-09-11 23:08:12','2008-03-22 02:56:55'),(68,61,'approved','1983-06-29 21:48:52','1978-02-27 19:14:12'),(68,68,'unfriended','2010-10-27 04:09:07','1984-12-20 23:45:41'),(70,90,'requested','1986-07-26 19:53:54','2016-01-17 17:52:03'),(72,37,'requested','2010-04-30 04:24:02','2018-04-24 21:50:07'),(72,48,'declined','1998-11-07 21:26:18','2006-09-01 14:48:54'),(74,8,'requested','2006-02-10 07:04:31','1981-11-12 16:14:55'),(75,13,'unfriended','1971-09-27 18:51:34','2009-01-29 15:10:50'),(75,40,'approved','2002-12-09 11:46:06','1991-04-24 23:33:26'),(75,44,'approved','1996-05-01 18:27:42','1992-06-13 00:21:49'),(75,77,'approved','2001-05-04 22:56:47','1987-08-09 16:07:29'),(76,81,'declined','1991-12-23 01:07:28','1999-05-23 17:37:22'),(77,20,'declined','1993-02-06 13:47:13','1979-06-02 01:33:41'),(78,36,'declined','1972-12-22 11:06:58','1992-04-22 22:42:21'),(78,38,'requested','1978-01-01 14:18:55','1995-09-20 11:15:46'),(78,44,'declined','2012-03-19 10:27:39','1991-01-12 18:26:22'),(79,5,'unfriended','2019-09-05 15:14:25','1987-10-06 22:51:14'),(79,38,'declined','2005-05-22 09:14:21','1981-02-28 13:09:38'),(81,45,'unfriended','2005-02-14 20:57:24','1975-01-12 07:52:21'),(83,73,'requested','1974-09-20 20:01:04','2015-03-20 20:18:07'),(83,79,'unfriended','1970-01-22 10:59:33','1991-08-27 16:31:46'),(84,10,'approved','2013-08-04 18:57:59','1984-05-13 08:19:20'),(84,82,'unfriended','1984-06-30 19:35:41','1973-11-22 01:54:01'),(85,74,'declined','1975-10-11 14:51:57','1988-01-15 15:52:10'),(87,18,'declined','2001-05-15 07:46:03','2012-11-27 11:20:40'),(87,55,'unfriended','2019-05-26 06:06:04','2003-03-10 17:03:10'),(88,68,'approved','2011-09-26 14:26:37','2005-02-08 16:33:31'),(88,90,'approved','1998-05-14 07:49:26','1975-07-09 04:23:43'),(89,12,'approved','1978-08-21 02:13:24','1999-05-20 08:20:23'),(89,18,'unfriended','2011-09-24 20:22:08','2017-04-18 20:35:23'),(94,18,'unfriended','2021-10-10 19:06:26','1985-09-12 08:19:55'),(94,50,'approved','1970-06-18 00:23:06','1995-12-19 07:40:39'),(94,57,'approved','2005-05-09 09:00:39','2008-06-21 05:27:15'),(95,28,'unfriended','2017-02-10 11:14:18','1996-04-15 02:20:35'),(96,17,'unfriended','2009-05-02 22:25:06','2003-05-23 02:48:49'),(97,96,'declined','2003-11-09 08:44:50','1981-03-26 19:02:29'),(97,98,'approved','2016-08-23 07:21:22','2017-03-31 03:56:58'),(99,23,'unfriended','1977-08-12 09:17:55','1977-07-06 22:26:30'),(100,51,'approved','2013-04-10 23:57:20','2003-09-22 22:15:58'),(100,97,'unfriended','1993-10-12 13:34:36','1971-08-07 02:05:52');

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),
	admin_user_id BIGINT UNSIGNED,

	INDEX communities_name_idx(name),
	FOREIGN KEY (admin_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO `communities` VALUES (1,'optio',58),(2,'fugiat',54),(3,'qui',19),(4,'reprehenderit',57),(5,'aut',9),(6,'sed',89),(7,'officiis',52),(8,'eum',30),(9,'voluptatem',77),(10,'cupiditate',53);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (user_id, community_id), -- чтобы не было 2 записей о пользователе и сообществе
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (community_id) REFERENCES communities(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO `users_communities` VALUES (1,2),(2,10),(4,4),(5,5),(7,2),(10,5),(10,9),(11,6),(13,5),(14,6),(14,8),(14,9),(15,4),(17,9),(18,1),(19,6),(20,4),(21,3),(22,7),(26,6),(28,6),(28,8),(29,4),(30,1),(30,8),(31,9),(32,7),(33,9),(34,1),(36,5),(36,6),(38,1),(38,3),(39,4),(40,7),(41,10),(42,10),(43,5),(44,3),(48,9),(50,5),(51,5),(52,8),(55,5),(55,6),(56,10),(58,3),(58,8),(59,2),(59,8),(60,5),(60,10),(62,1),(63,3),(65,2),(69,4),(69,7),(69,8),(69,9),(70,4),(71,3),(71,9),(72,4),(72,5),(73,5),(73,7),(73,10),(74,5),(79,10),(80,9),(81,6),(85,1),(85,8),(86,1),(86,3),(86,8),(87,6),(87,8),(89,1),(89,5),(89,6),(89,9),(91,7),(92,2),(92,3),(92,5),(93,2),(95,3),(95,6),(96,4),(97,6),(97,10),(98,6),(98,10);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

    -- записей мало, поэтому индекс будет лишним (замедлит работу)!
);

INSERT INTO `media_types` VALUES (1,'laborum','1998-03-18 04:45:23','1996-04-24 20:09:33'),(2,'est','1982-11-24 05:33:50','2008-02-09 06:38:24'),(3,'magni','1982-01-03 23:05:06','2007-01-21 16:19:49'),(4,'aperiam','1972-09-04 23:46:28','1976-06-27 06:57:21'),(5,'dolorum','1997-09-24 23:31:46','1972-08-10 20:55:48');

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
    media_type_id BIGINT UNSIGNED,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    `size` INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (media_type_id) REFERENCES media_types(id) ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO `media` VALUES (1,4,73,'Hic voluptas ut voluptas illum nihil assumenda labore mollitia.','reprehenderit',9850,'6487895','2017-05-30 04:25:46','1984-10-25 15:26:37'),(2,4,14,'Corporis pariatur optio aperiam modi.','in',4136,'428265','1984-12-17 18:16:45','1978-06-12 22:29:36'),(3,1,65,'Voluptas unde consectetur et est ut repudiandae est.','sed',242073954,'88209736','1986-11-23 18:21:53','1982-09-07 04:45:43'),(4,2,10,'Quidem error quod id.','recusandae',4,'249','1976-12-28 07:49:19','1988-10-24 04:25:06'),(5,5,96,'Velit accusantium commodi totam harum quia ut.','nostrum',251056,'511','1999-03-16 01:59:44','2015-12-08 21:19:06'),(6,3,5,'Laudantium sed quisquam alias amet quidem.','aperiam',0,'9127','1977-01-30 01:02:54','1975-05-14 09:24:54'),(7,2,52,'Qui harum ex amet et pariatur sit.','et',9,'217328033','1997-05-13 09:31:17','2000-08-22 07:36:56'),(8,4,6,'Dolorem voluptatem quis id aut.','sapiente',8391264,'17225981','1978-08-19 13:17:32','1974-01-15 19:03:41'),(9,1,59,'Consequuntur excepturi inventore quia maxime inventore unde eaque.','qui',728238234,'2','1990-01-07 14:25:30','2008-07-08 12:47:33'),(10,2,79,'Incidunt vel placeat est deleniti quas ab perspiciatis earum.','harum',88,'7','2000-02-12 14:35:13','1995-11-13 17:44:11'),(11,2,95,'Laboriosam qui repellat velit facere qui.','qui',4,'465','1991-10-06 06:18:35','2018-04-02 22:21:33'),(12,2,17,'Dolorum nihil quod fugit et nihil.','dolorum',149700,'753','2018-09-20 14:33:50','1995-07-22 20:40:01'),(13,1,21,'Qui vero necessitatibus vel explicabo.','error',14,'9371','2021-08-30 23:31:06','2007-09-27 17:10:20'),(14,1,50,'Consectetur commodi non pariatur omnis fuga.','quo',833,'4709','1973-03-19 22:07:12','1970-08-24 12:23:22'),(15,2,44,'Vel maxime a quas magni ea id.','vel',51041977,'8813','1981-08-24 03:36:27','1996-11-05 10:50:16'),(16,5,36,'Quas sunt est officia accusamus id laborum dolorem.','facere',28,'76139145','1997-08-15 18:28:02','1988-05-12 01:30:09'),(17,1,16,'Vitae esse hic cum maiores doloribus cumque nihil et.','et',63,'3','2020-06-05 12:47:26','2004-11-23 18:14:23'),(18,3,92,'Aut saepe debitis quis repudiandae rem.','voluptas',255030,'2','1970-07-07 23:24:35','1991-03-01 17:10:27'),(19,1,100,'Recusandae animi sunt dolor voluptatum nemo commodi.','quia',0,'213386123','2014-03-21 01:58:50','1974-03-13 23:22:21'),(20,5,39,'Totam non laudantium earum facere.','quas',5,'9','2010-01-22 15:55:36','2010-07-22 15:14:49'),(21,3,73,'Consectetur beatae et quia omnis.','et',77564649,'19178','1998-07-15 02:42:51','1988-08-02 16:28:05'),(22,3,70,'Corporis suscipit itaque nihil deserunt.','maxime',2334099,'7856','2019-10-09 04:29:54','2007-12-21 01:23:46'),(23,2,70,'Totam tenetur et omnis omnis.','eius',9300492,'7846','1998-02-03 22:30:13','1996-03-09 08:00:43'),(24,3,66,'Veritatis quae sapiente labore veritatis impedit amet.','laborum',21412540,'8758','2002-09-27 00:56:10','1979-12-29 07:11:35'),(25,4,73,'Id occaecati quo eveniet itaque natus iste perferendis.','expedita',49,'9057','1977-12-08 16:09:28','2002-08-14 06:09:43'),(26,5,98,'Rerum sunt ducimus eius voluptatum.','ipsa',29736,'8076790','1970-03-10 02:50:09','1992-01-28 22:13:14'),(27,1,90,'Ea qui qui eos et.','id',537,'8413353','1984-07-26 19:19:42','1992-05-13 19:43:08'),(28,1,27,'Voluptatem aut esse blanditiis laboriosam id quia.','vitae',7472645,'895143692','2008-11-14 23:16:05','2019-06-12 02:58:11'),(29,2,85,'Quis quia et et est eveniet voluptatem vero quia.','voluptatem',5846121,'759361','1973-06-04 19:20:41','2018-02-06 13:05:09'),(30,1,61,'Error delectus necessitatibus eum ad et sint.','quis',3,'4766','2002-11-03 23:34:51','1989-04-05 20:09:01'),(31,2,93,'Quia voluptas aut corporis.','explicabo',1,'37598038','1986-07-26 00:32:25','1970-11-09 00:15:37'),(32,5,37,'Qui hic dolorem aut expedita ut.','corrupti',4023,'3646','2010-07-04 10:13:22','2015-10-17 07:19:25'),(33,1,43,'Tenetur dolores excepturi similique possimus ut reprehenderit ut.','cum',491699,'44080012','1970-06-25 12:11:33','2003-05-18 21:14:39'),(34,3,24,'Qui iure dolor ullam quo corrupti.','fugit',89114938,'211','2012-08-12 20:57:01','1984-11-02 02:47:44'),(35,3,93,'Sed minima eos aut et.','asperiores',8718,'52433','1972-09-21 22:43:37','2005-04-24 23:59:01'),(36,5,1,'Sapiente corporis sed dolor quisquam nisi molestiae et.','qui',9067558,'71916','1986-02-17 11:19:40','2010-06-25 20:36:53'),(37,4,28,'Doloremque explicabo voluptates qui necessitatibus minus excepturi velit.','laboriosam',69672610,'6315','1979-12-24 02:58:08','1992-02-07 06:46:06'),(38,4,11,'Expedita sit ullam ut est ex ut tempora sed.','amet',556722066,'712','1995-12-20 07:23:14','1980-06-18 21:24:35'),(39,5,34,'Omnis necessitatibus ea architecto et nostrum.','possimus',31056017,'50','1987-10-11 00:51:38','2010-06-25 20:42:14'),(40,5,75,'Cum dolores rerum suscipit ut voluptates qui eum.','aperiam',7206,'193144649','2012-03-29 17:35:59','2012-09-19 14:25:49'),(41,2,2,'Sed saepe et est odio.','voluptas',460,'6150909','2015-12-23 15:21:41','1979-04-13 20:49:36'),(42,4,50,'Reiciendis atque quae et nobis ut qui ipsam.','quaerat',651,'550','1992-12-31 16:39:36','1989-08-21 22:16:31'),(43,2,5,'Veritatis aut et eius sunt.','autem',674253,'9178220','2018-04-13 23:00:24','1973-11-18 07:57:39'),(44,2,32,'Porro quia voluptatem odit consequuntur beatae blanditiis id.','delectus',76229,'90687860','1973-03-03 17:07:51','1974-08-23 14:17:03'),(45,2,61,'Labore molestiae iusto corporis dolorem omnis quos.','architecto',86811,'25102572','2015-09-13 16:53:57','1989-07-20 14:55:36');

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),

    -- PRIMARY KEY (user_id, media_id) – можно было и так вместо id в качестве PK
  	-- слишком увлекаться индексами тоже опасно, рациональнее их добавлять по мере необходимости (напр., провисают по времени какие-то запросы)  

/* намеренно забыли, чтобы позднее увидеть их отсутствие в ER-диаграмме*/
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE

);

INSERT INTO `likes` VALUES (1,1,1,'1994-02-13 22:54:52'),(2,2,2,'1982-04-06 05:58:50'),(3,3,3,'1995-04-27 16:04:17'),(4,4,4,'1978-04-22 16:59:40'),(5,5,5,'1981-04-27 03:27:46'),(6,6,6,'2018-10-05 12:37:14'),(7,7,7,'1971-09-26 16:09:06'),(8,8,8,'1981-06-03 08:42:49'),(9,9,9,'1999-01-10 01:50:10'),(10,10,10,'1991-05-25 00:08:19'),(11,11,11,'1970-03-20 22:33:36'),(12,12,12,'1977-10-25 11:54:26'),(13,13,13,'2009-02-21 07:02:42'),(14,14,14,'2017-11-07 19:34:43'),(15,15,15,'1984-10-20 17:22:59'),(16,16,16,'2007-03-18 06:40:31'),(17,17,17,'1978-06-25 07:16:23'),(18,18,18,'2012-12-20 12:54:22'),(19,19,19,'1998-10-31 05:50:19'),(20,20,20,'1978-01-28 18:37:57'),(21,21,21,'1999-08-04 16:18:00'),(22,22,22,'1994-11-09 19:38:11'),(23,23,23,'2007-12-31 20:54:33'),(24,24,24,'1974-05-27 05:36:53'),(25,25,25,'1999-02-03 01:40:12'),(26,26,26,'1992-07-13 07:43:48'),(27,27,27,'1984-12-05 20:43:23'),(28,28,28,'2018-03-10 05:00:35'),(29,29,29,'1975-04-16 10:05:21'),(30,30,30,'1976-07-30 15:50:08'),(31,31,31,'2019-12-09 03:53:13'),(32,32,32,'1995-09-16 08:46:49'),(33,33,33,'1977-03-22 22:44:31'),(34,34,34,'2008-11-12 09:49:48'),(35,35,35,'1980-02-16 23:34:24'),(36,36,36,'2016-05-22 06:10:37'),(37,37,37,'1973-02-21 10:48:26'),(38,38,38,'2012-01-14 03:28:34'),(39,39,39,'1998-06-06 15:42:00'),(40,40,40,'2015-07-14 02:26:18');

DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
	`id` SERIAL,
	`name` varchar(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE SET NULL,
  	PRIMARY KEY (`id`)
);

INSERT INTO `photo_albums` VALUES (1,'non',1),(2,'facere',21),(3,'delectus',30),(4,'dolorem',80),(5,'eaque',44),(6,'voluptas',95),(7,'mollitia',59),(8,'quia',41),(9,'assumenda',59),(10,'placeat',76),(11,'aperiam',39),(12,'corporis',29),(13,'dicta',33),(14,'qui',98),(15,'delectus',1),(16,'officia',29),(17,'labore',64),(18,'optio',79),(19,'non',92),(20,'est',91),(21,'impedit',78),(22,'eos',44),(23,'omnis',9),(24,'quibusdam',52),(25,'quod',44),(26,'culpa',53),(27,'sint',3),(28,'eaque',59),(29,'deleniti',22),(30,'excepturi',89),(31,'rem',17),(32,'quo',23),(33,'quas',10),(34,'consequuntur',47),(35,'ullam',3),(36,'pariatur',53),(37,'aperiam',42),(38,'voluptatibus',61),(39,'adipisci',94),(40,'tenetur',1),(41,'repudiandae',37),(42,'natus',32),(43,'ut',29),(44,'dignissimos',69),(45,'animi',29),(46,'in',30),(47,'at',98),(48,'sit',93),(49,'odio',8),(50,'occaecati',90);

DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
	id SERIAL PRIMARY KEY,
	`album_id` BIGINT unsigned NOT NULL,
	`media_id` BIGINT unsigned NOT NULL,

	FOREIGN KEY (album_id) REFERENCES photo_albums(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO `photos` VALUES (1,34,18),(2,17,15),(3,4,28),(4,50,12),(5,20,26),(6,36,16),(7,12,16),(8,41,26),(9,16,38),(10,20,1),(11,23,8),(12,31,29),(13,10,18),(14,14,10),(15,49,24),(16,11,29),(17,46,24),(18,48,45),(19,7,43),(20,13,25),(21,26,43),(22,45,34),(23,15,32),(24,15,27),(25,27,31),(26,31,45),(27,44,11),(28,32,2),(29,31,41),(30,13,26);

ALTER TABLE `profiles` ADD CONSTRAINT fk_photo_id
    FOREIGN KEY (photo_id) REFERENCES photos(id)
    ON UPDATE CASCADE ON DELETE set NULL;
    
-- создаем таблицу учебных учреждений, где могли учиться пользователи VK
drop table if exists educational_institution;
create table educational_institution(
	id serial primary key,
    `name` varchar(100),
    type enum('University', 'College', 'School'),
    index educational_institution_name_idx(`name`) -- индексируем по названию учбного учреждения
    );

INSERT INTO `educational_institution` VALUES (1,'vitae','College'),(2,'voluptatem','University'),(3,'eius','University'),(4,'occaecati','College'),(5,'quis','University'),(6,'nulla','University'),(7,'et','College'),(8,'eius','College'),(9,'quibusdam','College'),(10,'consectetur','University'),(11,'blanditiis','University'),(12,'ad','University'),(13,'dolor','School'),(14,'accusamus','University'),(15,'blanditiis','College'),(16,'deserunt','College'),(17,'libero','School'),(18,'et','School'),(19,'ipsam','College'),(20,'alias','University');
    
/*создаем таблицу профессий, уровня образования и учебных учреждений, 
в которых учились пользователи, она связывает таблицу пользователей 
и таблицу учебных учреждений (связь многие ко многим)
*/
drop table if exists users_prof_edu;
create table users_prof_edu(
	id serial primary key,
    user_id bigint unsigned not null,
    profession varchar(100),
    educational_institution_id bigint unsigned not null,
    `level` enum('Higher - Bachelor`s', 'Higher - Master`s', 'Higher - PH.D', 'Associate degree', 'High-school', 'Middle-school', 'Elementary school', 'Nursery school'),
    graduation_year year,
    created_at datetime default now(),
    index level_prof_idx(`level`, profession), -- индексируем по составному индексу уровень-профессия, облегчит поиск по параметрам наличия пользователей с определенным уровнем образования по определенным профессиям
    
    foreign key (user_id) references users(id) on update cascade on delete cascade,
    foreign key (educational_institution_id) references educational_institution(id) on update cascade on delete cascade
);

INSERT INTO `users_prof_edu` VALUES (1,1,'dolores',5,'Higher - PH.D',1970,'1999-02-14 17:23:22'),(2,2,'quisquam',11,'Nursery school',2014,'2014-09-27 23:41:56'),(3,3,'enim',3,'Higher - Bachelor`s',1996,'1998-10-15 23:08:47'),(4,4,'aliquam',11,'Associate degree',1975,'2003-10-09 18:05:09'),(5,5,'nobis',3,'Associate degree',2008,'2016-04-05 14:58:47'),(6,6,'non',20,'Higher - PH.D',1977,'1997-01-20 05:29:34'),(7,7,'ipsa',16,'Higher - Bachelor`s',1977,'1977-06-25 16:52:12'),(8,8,'enim',4,'High-school',1987,'2010-10-22 15:17:27'),(9,9,'amet',17,'High-school',2012,'1970-11-04 01:06:29'),(10,10,'id',19,'Elementary school',1987,'2003-07-06 08:17:11'),(11,11,'totam',8,'High-school',1999,'2016-04-01 12:25:35'),(12,12,'eius',12,'Associate degree',2012,'2006-11-26 12:19:40'),(13,13,'harum',11,'Higher - Bachelor`s',1996,'2022-07-05 15:17:31'),(14,14,'deserunt',20,'Nursery school',2000,'1986-03-24 12:27:50'),(15,15,'et',18,'High-school',2008,'2003-09-15 02:59:35'),(16,16,'qui',8,'Higher - PH.D',1977,'2005-02-04 16:01:41'),(17,17,'placeat',3,'Higher - PH.D',1990,'1970-07-17 19:54:26'),(18,18,'impedit',16,'Higher - Master`s',1982,'1989-04-12 03:07:08'),(19,19,'qui',1,'Higher - Bachelor`s',1979,'1977-01-06 16:52:53'),(20,20,'sapiente',19,'Elementary school',2006,'2010-12-04 07:25:08'),(21,21,'officia',18,'Associate degree',2009,'1997-05-19 03:34:46'),(22,22,'incidunt',11,'Higher - Master`s',2008,'1979-07-03 14:16:01'),(23,23,'natus',1,'Higher - PH.D',1982,'2021-01-25 06:47:00'),(24,24,'est',19,'Higher - Master`s',2013,'2004-02-05 01:06:05'),(25,25,'sunt',19,'Associate degree',1987,'2021-02-28 17:33:16'),(26,26,'et',10,'Nursery school',1989,'2001-02-14 00:44:30'),(27,27,'sint',4,'Middle-school',1972,'2013-05-31 02:50:28'),(28,28,'et',1,'Elementary school',2000,'2002-01-20 19:08:13'),(29,29,'sunt',7,'Higher - Bachelor`s',1976,'1993-04-10 21:03:46'),(30,30,'qui',12,'Associate degree',2015,'2016-11-11 08:40:42'),(31,31,'porro',11,'Associate degree',1974,'1972-12-01 13:34:18'),(32,32,'consequatur',11,'Middle-school',2004,'2011-03-25 13:29:27'),(33,33,'aut',2,'Higher - Master`s',1989,'1997-09-22 19:15:36'),(34,34,'quae',13,'Associate degree',2009,'2001-06-04 15:21:06'),(35,35,'omnis',1,'Higher - Bachelor`s',1998,'1999-07-07 06:17:11'),(36,36,'enim',5,'Higher - Master`s',1990,'1981-09-06 00:29:36'),(37,37,'qui',13,'High-school',1985,'1983-01-08 07:55:57'),(38,38,'optio',17,'Higher - Bachelor`s',1986,'1970-07-23 13:50:48'),(39,39,'excepturi',8,'Associate degree',2020,'2019-06-28 19:09:50'),(40,40,'odio',9,'Higher - Bachelor`s',1977,'1994-02-15 13:32:15'),(41,41,'sapiente',16,'High-school',2020,'2008-06-05 15:20:54'),(42,42,'placeat',16,'Elementary school',1974,'2019-03-09 21:58:09'),(43,43,'beatae',20,'Higher - PH.D',1991,'1981-04-19 20:58:14'),(44,44,'numquam',6,'Associate degree',1997,'1991-04-02 16:27:40'),(45,45,'vel',16,'Higher - PH.D',1978,'1989-09-08 21:11:28'),(46,46,'et',17,'Higher - Bachelor`s',2010,'2008-05-14 08:32:21'),(47,47,'illo',13,'Associate degree',1971,'2005-01-14 21:08:02'),(48,48,'corporis',18,'Nursery school',2009,'2006-10-17 04:48:15'),(49,49,'sed',13,'Nursery school',1976,'1979-08-06 21:23:04'),(50,50,'et',14,'Associate degree',2007,'1975-12-30 11:12:43'),(51,51,'id',17,'Higher - Master`s',1975,'1984-02-01 11:39:01'),(52,52,'quos',10,'Higher - Bachelor`s',1994,'2005-01-16 12:22:40'),(53,53,'velit',5,'Higher - PH.D',1970,'1970-04-03 15:08:34'),(54,54,'autem',17,'Higher - Bachelor`s',2000,'2022-04-10 06:28:55'),(55,55,'laboriosam',8,'Elementary school',1979,'1991-07-03 02:38:04'),(56,56,'dolores',3,'Associate degree',1995,'1996-05-01 04:56:23'),(57,57,'quam',7,'Elementary school',2014,'2018-07-31 04:40:19'),(58,58,'nobis',11,'Higher - Master`s',2003,'1995-12-27 02:53:54'),(59,59,'similique',4,'Higher - Bachelor`s',1977,'1998-12-26 06:08:59'),(60,60,'dolores',13,'Associate degree',1975,'1982-10-27 14:40:46'),(61,61,'voluptatem',3,'Middle-school',2006,'2006-04-17 14:17:43'),(62,62,'ducimus',14,'High-school',2007,'1975-02-03 06:04:34'),(63,63,'consequatur',4,'Middle-school',2014,'1990-12-04 23:05:54'),(64,64,'omnis',5,'Middle-school',1975,'2017-07-02 00:29:48'),(65,65,'esse',7,'Middle-school',2004,'2013-02-08 19:02:46'),(66,66,'odit',5,'Higher - Bachelor`s',1977,'2010-05-06 04:00:52'),(67,67,'ea',9,'Associate degree',2019,'1971-06-16 03:43:30'),(68,68,'quos',19,'Higher - Bachelor`s',1991,'2001-03-27 17:44:56'),(69,69,'ad',1,'Associate degree',1989,'2016-07-11 22:23:52'),(70,70,'error',17,'Middle-school',1980,'2004-01-16 09:07:03'),(71,71,'et',7,'Elementary school',1979,'1971-08-01 20:30:17'),(72,72,'facilis',16,'Elementary school',2005,'1985-11-13 06:54:52'),(73,73,'voluptatem',13,'Elementary school',2011,'2018-05-16 08:33:34'),(74,74,'sed',6,'Nursery school',1991,'2008-04-22 00:29:59'),(75,75,'ab',2,'Associate degree',2012,'1981-01-15 02:37:07'),(76,76,'molestias',8,'Higher - PH.D',2010,'1990-05-03 01:32:14'),(77,77,'corporis',3,'Higher - PH.D',1996,'1971-08-31 16:40:53'),(78,78,'officia',15,'Associate degree',2002,'2000-02-08 02:26:37'),(79,79,'ut',6,'High-school',1977,'1979-05-28 12:14:52'),(80,80,'aspernatur',15,'Associate degree',1989,'2002-04-11 07:29:04'),(81,81,'optio',8,'High-school',1996,'1996-04-30 13:19:01'),(82,82,'corporis',2,'High-school',1971,'1998-03-05 23:20:09'),(83,83,'et',4,'Middle-school',1999,'2018-06-03 07:13:47'),(84,84,'exercitationem',13,'Higher - Master`s',2015,'1980-07-20 20:39:42'),(85,85,'qui',19,'High-school',2002,'2004-05-02 14:52:49'),(86,86,'velit',12,'Higher - Master`s',1978,'1997-09-13 00:40:43'),(87,87,'minus',15,'Nursery school',1995,'2018-05-26 22:28:33'),(88,88,'possimus',5,'Middle-school',1990,'1984-09-11 01:03:14'),(89,89,'sint',3,'Nursery school',2001,'1984-02-27 05:08:35'),(90,90,'iusto',18,'Associate degree',2006,'2001-07-10 18:58:41'),(91,91,'id',18,'Higher - Bachelor`s',1995,'1972-02-19 23:18:30'),(92,92,'iste',5,'Higher - PH.D',2021,'1996-12-25 18:00:18'),(93,93,'corrupti',12,'High-school',1988,'1979-10-19 07:22:08'),(94,94,'et',2,'Higher - Bachelor`s',1973,'2014-09-27 08:33:07'),(95,95,'voluptatem',10,'Higher - PH.D',2013,'2014-03-21 01:33:14'),(96,96,'aut',18,'Associate degree',2016,'1995-10-13 14:52:18'),(97,97,'deleniti',6,'Nursery school',1988,'1972-05-22 03:40:30'),(98,98,'minus',19,'Associate degree',1978,'2006-08-17 09:02:26'),(99,99,'et',16,'Elementary school',2001,'1992-06-25 21:25:30'),(100,100,'qui',7,'Elementary school',2020,'2003-07-10 20:21:49');

-- создаем таблицу домашних животных
drop table if exists pets;
create table pets(
	id serial primary key,
    animal varchar(100),
    breed varchar(100),
    index animal_breed_idx(animal, breed)
);

INSERT INTO `pets` VALUES (14,'accusantium','ut'),(8,'aspernatur','sit'),(13,'aut','animi'),(12,'dignissimos','molestias'),(18,'ducimus','nihil'),(16,'enim','necessitatibus'),(3,'et','cum'),(15,'et','et'),(6,'explicabo','est'),(19,'iure','qui'),(17,'labore','voluptas'),(4,'molestiae','voluptate'),(7,'mollitia','et'),(1,'nisi','nam'),(2,'qui','fuga'),(10,'qui','voluptatem'),(20,'quia','qui'),(11,'sed','autem'),(9,'ut','qui'),(5,'ut','quo');

-- создаем таблицу пользователей и их питомцев, она связывает таблицу пользователи и таблицу питомцы многие ко многим
drop table if exists users_pets;
create table users_pets(
	id serial primary key,
	user_id bigint unsigned not null,
    pets_id bigint unsigned not null,
    name varchar(50),
    color varchar(20),
    date_of_birth date, 
        
    foreign key (user_id) references users(id) on update cascade on delete cascade,
    foreign key (pets_id) references pets(id) on update cascade on delete cascade
);
insert into users_pets (user_id, pets_id, name, color, date_of_birth) values 
(2, 2, 'Cookie', 'black', '2022-01-01'),
(3, 5, 'Piggi', 'blue', '2022-01-01'),
(21, 1, 'Teddy', 'brown', '2022-01-01'),
(1, 3, 'Cony', 'red', '2022-01-01'),
(16, 2, 'Betty', 'white', '2022-01-01'),
(12, 4, 'Polly', 'orange', '2022-01-01'),
(21, 14, 'George', 'pink', '2022-01-01'),
(55, 12, 'Path', 'green', '2022-01-01'),
(11, 1, 'Mandy', 'purple', '2022-01-01'),
(63, 6, 'Ro', 'black', '2022-01-01');

-- создаем таблицу место жительства, связана с таблицей пользователей один к одному
drop table if exists place_of_residence;
create table place_of_residence(
	id serial primary key,
    user_id bigint unsigned not null,
    name varchar(20),
    
    foreign key (user_id) references users(id) on update cascade on delete cascade
);

insert into place_of_residence (user_id, name) values 
(2,'Moscow'),
(3, 'Tver'),
(21, 'Samara'),
(1, 'Stavropol'),
(16, 'Belgorod'),
(12, 'Rjev'),
(21, 'Gdansk'),
(55, 'Pskov'),
(11, 'Murom'),
(63, 'Riga');

-- 2. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке. 
select distinct firstname from users order by firstname; -- выбираем из таблицы пользователей столбец имя, без повторов, отсортированное по имени 

-- 3. Первые пять пользователей пометить как удаленные.
update users set is_deleted = 1 limit 5; -- помечаем как удаленные первые пять пользователей (первые пять по id)
select id, firstname, is_deleted from users limit 5; -- проверяем, что у первых пяти пользователей статус удаленных

-- 4. Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней).
insert into messages (from_user_id, to_user_id, body, created_at) -- создадим запись о сообщении с датой больше сегодняшней
values (1, 6, 'hello', '2023-10-10 12:12:00'); 
-- удалим записи с датой больше сегодняшней:
delete from messages
where created_at > now() and id > 0; -- добавили условие на первичный ключ для исключения ошибки 1175 (при режиме safe update mode отказывается удалять, если нет предиката с использованием первичного ключа)

-- 5. Тема курсовой работы "База данных Российской кинологической федерации" (питомники, породы собак, родословные, выставки, спорт и другая информация)
