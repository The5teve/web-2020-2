-- MySQL dump 10.17  Distrib 10.3.22-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: std-mysql.ist.mospolytech.ru    Database: std_1230
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.16.04.1

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
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('c7a13aac455f');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collections`
--

DROP TABLE IF EXISTS `collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_collections_user_id_users5` (`user_id`),
  CONSTRAINT `fk_collections_user_id_users5` FOREIGN KEY (`user_id`) REFERENCES `users5` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collections`
--

LOCK TABLES `collections` WRITE;
/*!40000 ALTER TABLE `collections` DISABLE KEYS */;
INSERT INTO `collections` VALUES (6,'Моя подборка',1),(7,'Неплохая подборка',4),(8,'Хорошая',1);
/*!40000 ALTER TABLE `collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_genres_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (2,'Боевик'),(7,'Документальный'),(5,'Драма'),(3,'Комедия'),(6,'Криминал'),(1,'Триллер'),(4,'Ужасы');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_collections`
--

DROP TABLE IF EXISTS `movie_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movie_collections` (
  `collection_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  PRIMARY KEY (`collection_id`,`movie_id`),
  KEY `fk_movie_collections_movie_id_movies` (`movie_id`),
  CONSTRAINT `fk_movie_collections_collection_id_collections` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`),
  CONSTRAINT `fk_movie_collections_movie_id_movies` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_collections`
--

LOCK TABLES `movie_collections` WRITE;
/*!40000 ALTER TABLE `movie_collections` DISABLE KEYS */;
INSERT INTO `movie_collections` VALUES (6,9),(8,9),(6,13),(7,13),(6,17),(7,22);
/*!40000 ALTER TABLE `movie_collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_genres`
--

DROP TABLE IF EXISTS `movie_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movie_genres` (
  `movie_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`movie_id`,`genre_id`),
  KEY `fk_movie_genres_genre_id_genres` (`genre_id`),
  CONSTRAINT `fk_movie_genres_genre_id_genres` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`),
  CONSTRAINT `fk_movie_genres_movie_id_movies` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_genres`
--

LOCK TABLES `movie_genres` WRITE;
/*!40000 ALTER TABLE `movie_genres` DISABLE KEYS */;
INSERT INTO `movie_genres` VALUES (12,1),(18,1),(23,1),(25,1),(9,2),(12,2),(12,3),(13,3),(16,3),(17,3),(18,4),(9,5),(12,5),(13,5),(17,5),(19,5),(22,5),(23,5),(25,5),(27,5),(19,6),(22,6),(27,6),(15,7);
/*!40000 ALTER TABLE `movie_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `production_year` int(11) NOT NULL,
  `country` varchar(100) NOT NULL,
  `director` varchar(100) NOT NULL,
  `screenwriter` varchar(100) NOT NULL,
  `actors` varchar(255) NOT NULL,
  `duration` int(11) NOT NULL,
  `poster_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_movies_poster_id_posters` (`poster_id`),
  CONSTRAINT `fk_movies_poster_id_posters` FOREIGN KEY (`poster_id`) REFERENCES `posters` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (9,'Ярость','Стоит апрель 1945 года, и победа над немцами уже близка: союзники уверенно продвигаются вглубь вражеской территории, и оказываемое им сопротивление становится слабее день ото дня. Это, однако, совсем не значит, что на пути к победе союзные войска не потеряют еще множество людей, и многие солдаты сознают, что смерть ждет на расстоянии вытянутой руки. Среди закаленных в бою пессимистов, каждый день ведущих ожесточенные бои во имя победы, экипаж танка, на чьем дуле намалевано слово «Ярость».\n\nКомандир экипажа, известный как Уордэдди, воевавший с нацистскими войсками сначала в Африке, а потом в Европе, преследует одну цель – выжить в войне и сохранить жизнь своим людям. Этот относительно амбициозный план оказывается под угрозой, когда к его экипажу присоединяется зеленый новобранец Норман Эллисон, никогда раньше не воевавший и еще не успевший привыкнуть к тому, что должен быстро и без колебаний обрывать человеческие жизни. Надежда выжить становится совсем призрачной, когда экипажу «Ярости» приходится принять участие в самоубийственной миссии.',2014,'США','Дэвид Эйер','Роман Васьянов','   Брэд Питт, Шайа Лабаф, Логан Лерман   ',135,'fe6abfb2-e7e4-4211-a37f-2f853ede69ff'),(12,'Возмездие','Мексиканец **Педро** бежал из города Канкун в Россию. На родине он промышлял мелким грабежом и продавал поддельное \"Лего\". Здесь же, в России, он меняет имя и находит единомышленников. Команда новоиспеченных недо-бандитов решается на самое рискованное дело их жизни : украсть реликвию главного криминального авторитета Москвы - **Виктора**.\nОднако не каждая авантюра щедро поощряется...Особенно преступная...',2019,'Россия','Гладышев Федор','Гладышев Федор, Фаградян Артем','Максим Панин       ',22,'6092b4ea-4805-4856-96f9-9c2d6b431858'),(13,'Волк с Уолл-стрит','**Джордан Белфорт** основал одну из крупнейших брокерских контор в *1987* году, но десять лет спустя был осужден за отмывание денег и ряд прочих финансовых преступлений. Автор справился с алкогольной и наркотической зависимостью, выработанной за время махинаций на Уолл-стрит, написал две книги и теперь читает лекции о том, как достичь ***успеха***.',2013,'США','Мартин Скорсезе','Мартин Скорсезе','Леонардо Ди Каприо, Джордан Белфорт, Джона Хилл, Марго Робби      ',180,'927179b3-25f8-4868-939e-b79a5d243a0d'),(15,'Послушай, мама, я могу летать','В фильме представлены кадры рабочего процесса создания альбома ***«Astroworld»***, детство артиста, становление лейбла CACTUS JACK и эксклюзивные съемки за кулисами различных выступлений.',2019,'США','Дилан Коран',' Дилан Коран','Тревис Скотт                                      ',84,'ea450b9a-d5cb-42ff-be39-44653a3b7073'),(16,'Ларс и настоящая девушка','Трагикомедия *** «Ларс и настоящая девушка»*** принесла исполнителю главной роли **Райану Гослингу** очередную престижную кино-номинацию, на этот раз на *«Золотой глобус»*. От истории, где в первых рядах фигурирует секс-кукла, сложно ожидать глубокой философии и отсутствия низкопробного юмора, однако в данной картине это именно так. Добрая, непошлая, подталкивающая к размышлениям лента имеет все шансы понравиться именно вам. **Ларсу Линдстрому** 28 лет и у него большие проблемы с общением. Тревожность, перерастающая в навязчивое паническое состояние накрывает его с головой всякий раз, когда кто-то пытается приблизиться к зоне его психологического комфорта, особенно, если этот кто-то – женщина. При всём этом Ларс человек добрый и отзывчивый. И вот однажды он приглашает своих родных познакомиться с девушкой, которую он повстречал в Интернете. Приятное удивление в глазах **Кэрин** и **Газа** сменяется недоумением: **Бьянка**, которую с гордостью представил им Ларс – всего лишь красивая кукла. Если вы еще не решили, чем заняться субботним вечером, то рекомендуем смотреть онлайн «Ларс и настоящая девушка».',2007,'США','Крейг Гиллеспи','Нэнси Оливер',' Райан Гослинг, Эмили Мортимер, Пол Шнайдер\r\n ',106,'598e7b71-b976-4f4f-997c-8155799c3557'),(17,'Однажды в... Голливуде','Фильм повествует о череде событий, произошедших в **Голливуде** в 1969 году, на закате его «золотого века». По сюжету, известный ТВ актер **Рик Далтон** и его дублер **Клифф Бут** пытаются найти свое место в стремительно меняющемся мире киноиндустрии.',2019,'США','Квентин Тарантино','Квентин Тарантино','Брэд Питт, Леонардо Ди Каприо, Марго Робби, Дакота Фэннинг         ',160,'084df4ea-6f51-4543-8fa3-bf4b8cd46e9b'),(18,' Американский психопат','Днем он ничем не отличается от окружающих, и в толпе вы не ***обратите на него внимания***. Но ночью этот ***благовоспитанный гражданин*** превращается в изощренного убийцу, терроризирующего спящий город.',2000,'США','Мэри Хэррон','Брет Истон Эллис','Кристиан Бэйл, Брет Истон Эллис, Джаред Лето, Хлоя Севиньи',102,'c15c01c2-7679-4e30-bca2-88c7d3c2aed7'),(19,'Американская история Икс','Лидер местной банды скинхэдов **Дерек Виньярд** прочно удерживает авторитет в своем районе. Убежденный в своей правоте, он беспощадно расправляется с теми, кто имеет не белый цвет кожи. Независимость и смелость **Дерека** вызывают восхищение у его младшего брата **Дэнни**, который уже тоже сделал свой выбор.',1998,'США','Тони Кэй','Тони Кэй','  Эдвард Нортон, Эдвард Фёрлонг, Итан Сапли, Файруза Балк',119,'3caa0b0f-9086-44f5-a594-894923e8da7d'),(22,'Лицо со шрамом','Весной 1980 года был открыт порт Мэйриэл Харбор, и тысячи кубинских беженцев ринулись в Соединенные Штаты на поиски Американской Мечты. Один из них нашел ее на залитых солнцем улицах Майами. Богатство, власть и страсть превзошли даже самые невероятные его мечты. Его звали **Тони Монтана**. Мир запомнил его под другим именем -*** «Лицо со шрамом»***...',1983,'США','Брайан де Пальма','Брайан де Пальма',' Аль Пачино, Стивен Бауэр, Мишель Пфайф, Роберт Лоджа',170,'a86e6346-c3f9-4508-8f5c-f48cdb633dac'),(23,'Бойцовский клуб','Терзаемый **хронической бессонницей** и отчаянно пытающийся вырваться из мучительно скучной жизни клерк встречает некоего **Тайлера Дардена**, харизматического торговца мылом с извращенной философией. Тайлер уверен, что самосовершенствование — удел слабых, а саморазрушение — единственное, ради чего стоит жить.',1999,'США','Дэвид Финчер','Дэвид Финчер','Брэд Питт, Эдвард Нортон, Хелена Бонэм Картер, Мит Лоуф',151,'791c443e-cda1-492d-bae0-d5aed193620a'),(25,'Реквием по мечте','Каждый из главных героев фильма стремился к своей заветной мечте. Сара Голдфарб мечтала сняться в известном телешоу, ее сын Гарольд со своим другом **Тайроном** — сказочно разбогатеть, подруга Гарольда Мэрион грезила о собственном модном магазине, но на их пути были всяческие препятствия. События фильма разворачиваются стремительно, герои погрязли в наркотиках. Мечты по-прежнему остаются недостижимыми, а жизни героев рушатся безвозвратно.',2000,'США','Даррен Аронофски','Даррен Аронофски','Дженнифер Коннелли, Джаред Лето, Эллен Бёрстин, Марлон Уэйанс',110,'e35d3201-bb80-4db5-ae6c-a0c7f3d29d25'),(27,'Джокер','Готэм, начало 1980-х годов. Комик **Артур Флек** живет с больной матерью, которая с детства учит его *«ходить с улыбкой»*. Пытаясь нести в мир хорошее и дарить людям радость, **Артур** сталкивается с человеческой жестокостью и постепенно приходит к выводу, что этот мир получит от него не добрую улыбку, а ухмылку злодея Джокера.',2019,'США','Тодд Филлипс','Тодд Филлипс','Хоакин Феникс, Роберт Де Ниро, Зази Битц, Фрэнсис Конрой',122,'eebf542e-4584-4114-a04d-21d4e30a2d31');
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posters`
--

DROP TABLE IF EXISTS `posters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posters` (
  `id` varchar(36) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `mime_type` varchar(45) NOT NULL,
  `md5_hash` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_posters_md5_hash` (`md5_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posters`
--

LOCK TABLES `posters` WRITE;
/*!40000 ALTER TABLE `posters` DISABLE KEYS */;
INSERT INTO `posters` VALUES ('084df4ea-6f51-4543-8fa3-bf4b8cd46e9b','maxresdefault.jpg','image/jpeg','63ed3ebf82d8be6b736d1144fb7412ce'),('3caa0b0f-9086-44f5-a594-894923e8da7d','storyx.jpg','image/jpeg','12f858e4f0a7fe6cd3c60e1bf857dc56'),('598e7b71-b976-4f4f-997c-8155799c3557','1_4dWwQ0ktb2ra8EyIAcK3lw.jpeg','image/jpeg','579ddc7be74f04d68a6b83806c070c62'),('6092b4ea-4805-4856-96f9-9c2d6b431858','jpg','image/jpeg','93f134fc650c8eca951063f6fa6ed6f6'),('791c443e-cda1-492d-bae0-d5aed193620a','1000x600-140819-05.png','image/png','235571e2366f32ba9d0aa25d26e8ec39'),('927179b3-25f8-4868-939e-b79a5d243a0d','234cfbf1d9c84e73b50c78daf5c9af45.jpg','image/jpeg','5ce0e876a0eb68842dca15abbf91a68f'),('9b324e39-ca7c-46ec-9406-614cbfee6a43','dog_PNG50321.png','image/png','1111aec80ceb7a46381187cda120b65c'),('a86e6346-c3f9-4508-8f5c-f48cdb633dac','960x540.jpg','image/jpeg','8b52c10fe07ce333a6f6e64046662eb6'),('bd8d2eed-7d35-49a4-838e-333b08ceca89','D4issu7YUIM.jpg','image/jpeg','6387ee6daba4caef123db0f6baa013b3'),('c15c01c2-7679-4e30-bca2-88c7d3c2aed7','001-men-christian-bale-psycho-starwiki.org.jpg','image/jpeg','5703bc16f84cf04f9d81731577a74958'),('e35d3201-bb80-4db5-ae6c-a0c7f3d29d25','unnamed.jpg','image/jpeg','1b827d14ac039279352a45d77eecb9cb'),('ea450b9a-d5cb-42ff-be39-44653a3b7073','97d9edfc93e24f0f9ee8965b49e5.jpg','image/jpeg','0b7cb07e5db10ce2beff2382813e44c1'),('eebf542e-4584-4114-a04d-21d4e30a2d31','e8ee09977e6d41cb37af0fc1275160e6670d069e.jpg','image/jpeg','4a9ff06fc7d50c5a2ed5515749ba5a56'),('f8afcf77-5ef8-4520-95eb-171f0cda7df3','q9y_4SEwmUY.jpg','image/jpeg','3ead48f70afd608b8b8370c07714f33b'),('fb8653c0-ef0b-4d57-9782-6dde33094856','jpg','image/jpeg','9da27865b6edd27101f13ae1711e7c81'),('fe6abfb2-e7e4-4211-a37f-2f853ede69ff','fury.jpg','image/jpeg','26c01b9c653582cd659926004d27620a');
/*!40000 ALTER TABLE `posters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `score` int(11) NOT NULL,
  `text` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_reviews_movie_id_movies` (`movie_id`),
  KEY `fk_reviews_user_id_users5` (`user_id`),
  CONSTRAINT `fk_reviews_movie_id_movies` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`),
  CONSTRAINT `fk_reviews_user_id_users5` FOREIGN KEY (`user_id`) REFERENCES `users5` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (3,17,1,4,'Сильный фильм Тарантино с его **любимой** манерой немного ***переписать историю***.','2021-01-23 14:56:57'),(4,17,3,5,'Отличный фильм на вечер. Ничего лишнего: **хороший юмор**, **красивая история** и **настоящие персонажи**.','2021-01-23 17:57:10'),(5,15,1,5,'*душещипательно*','2021-01-24 00:11:12'),(6,22,4,5,'*«Лицо со шрамом»* - это театр одного актера. Уже с начальной сцены, в которой камера словно «приклеивается» к *Аль Пачино*, становится понятно, что всё в этом фильме будет подчинено этому великому актеру. Когда такой актер, прекрасно зная, что он находится в своей лучшей форме, солирует настолько ярко, красочно и эффектно, то всё остальное становится абсолютно не важно.','2021-01-24 18:30:00'),(7,13,4,5,'«Волк с Уолл-стрит» ждали, кажется, все. Во-первых, ***ДиКаприо*** за главную роль в этой картине прочат «Оскар», как прочат его с каждой новой ролью актёра. Во-вторых, в талант ***Мартина Скорсезе*** мир по-прежнему верит, отмечая лишь, что вернуться к уровню своих лучших лент он вряд ли сможет. В-третьих, мир больших денег в кино выглядит всё так же привлекательно, какими бы чёрными красками его ни рисовали кинематографисты. В конце концов, трейлер фильма выглядел настолько хулиганским, что посмотреть «Волка» захотели даже те, на кого первые три пункта не производят никакого впечатления.','2021-01-24 18:36:17'),(8,17,4,2,'“Однажды в Голливуде” — кинокартина-”культурный срез” эпохи 60-х, взгляд автора на определенное событие с точки зрения среднестатистического обывателя и творческого допущения. Это фильм переосмысление, ответ на новые вызовы времени с позиции “ностальгирующей” точки зрения. Это работа мастера, это знак качества кино.','2021-01-24 18:43:52');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Пользователь',NULL),(2,'Админ',NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles5`
--

DROP TABLE IF EXISTS `roles5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles5` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `desc` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles5`
--

LOCK TABLES `roles5` WRITE;
/*!40000 ALTER TABLE `roles5` DISABLE KEYS */;
INSERT INTO `roles5` VALUES (1,'администратор','суперпользователь, имеет полный доступ к системе, в том числе к созданию и удалению фильмов'),(2,'модератор','может редактировать фильмы и производить модерацию рецензий'),(3,'пользователь','может оставлять рецензии');
/*!40000 ALTER TABLE `roles5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(25) NOT NULL,
  `last_name` varchar(25) NOT NULL,
  `middle_name` varchar(25) DEFAULT NULL,
  `password_hash` varchar(256) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users5`
--

DROP TABLE IF EXISTS `users5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users5` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_name` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `login` varchar(100) NOT NULL,
  `password_hash` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users5_login` (`login`),
  KEY `fk_users5_role_id_roles5` (`role_id`),
  CONSTRAINT `fk_users5_role_id_roles5` FOREIGN KEY (`role_id`) REFERENCES `roles5` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users5`
--

LOCK TABLES `users5` WRITE;
/*!40000 ALTER TABLE `users5` DISABLE KEYS */;
INSERT INTO `users5` VALUES (1,'Иванов','Петр',NULL,'user','pbkdf2:sha256:150000$o7FL2HeX$3b31dd8536d53a2f34ae03b02deee5e5f67ce9f7dae318a2aa226301f1c431c8','2021-01-22 18:15:46',3),(2,'Модер','Модер',NULL,'moder','pbkdf2:sha256:150000$jGyQXTd4$539602dd8cc72b9a0ab98d896ad18c1b6dbe8149b279c6fafbce8877d5cff4b0','2021-01-23 17:45:29',2),(3,'Кружалов','Алексей',NULL,'admin','pbkdf2:sha256:150000$rp2svMvw$659e713b283e628db04eaba46e23bdbd50893df15f93e845943ae44be25c81a3','2021-01-23 17:49:36',1),(4,'Андрей','Юзер',NULL,'user1','pbkdf2:sha256:150000$JoOq4GuV$1e492737ee7a7b6133853030ddc6c7f934bef52096e84ffb0f1728f486c6dd09','2021-01-23 23:15:12',3);
/*!40000 ALTER TABLE `users5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_logs`
--

DROP TABLE IF EXISTS `visit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(100) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `visit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_logs`
--

LOCK TABLES `visit_logs` WRITE;
/*!40000 ALTER TABLE `visit_logs` DISABLE KEYS */;
INSERT INTO `visit_logs` VALUES (1,'/users',1,'2020-12-22 12:50:51'),(2,'/users',1,'2020-12-22 12:50:52'),(3,'/',NULL,'2020-12-28 13:14:00'),(4,'/',NULL,'2020-12-28 13:15:11'),(5,'/',NULL,'2020-12-28 13:15:17'),(6,'/',NULL,'2020-12-28 13:15:19'),(7,'/',NULL,'2020-12-28 13:15:20'),(8,'/',NULL,'2020-12-28 13:16:55'),(9,'/',NULL,'2020-12-28 13:17:16'),(10,'/',NULL,'2020-12-28 13:17:18'),(11,'/',NULL,'2020-12-28 13:17:34'),(12,'/',NULL,'2020-12-28 13:17:56'),(13,'/auth/login',NULL,'2020-12-28 13:17:58'),(14,'/auth/login',NULL,'2020-12-28 13:18:04'),(15,'/',1,'2020-12-28 13:18:05'),(16,'/auth/logout',1,'2020-12-28 13:18:15'),(17,'/',NULL,'2020-12-28 13:18:15'),(18,'/visits/logs',NULL,'2020-12-28 13:19:55'),(19,'/auth/login',NULL,'2020-12-28 13:20:06'),(20,'/auth/login',NULL,'2020-12-28 13:21:57'),(21,'/',NULL,'2020-12-28 13:22:34'),(22,'/',NULL,'2020-12-28 13:23:08'),(23,'/',NULL,'2020-12-28 13:24:52'),(24,'/visits/logs',NULL,'2020-12-28 13:24:55'),(25,'/visits/logs',NULL,'2020-12-28 13:25:34'),(26,'/visits/logs',NULL,'2020-12-28 13:25:51'),(27,'/visits/logs',NULL,'2020-12-28 13:25:55'),(28,'/visits/logs',NULL,'2020-12-28 13:26:11'),(29,'/visits/stat/pages',NULL,'2020-12-28 13:26:21'),(30,'/visits/stat/users',NULL,'2020-12-28 13:26:22'),(31,'/visits/logs',NULL,'2020-12-28 13:26:23'),(32,'/visits/logs',NULL,'2020-12-28 14:06:49'),(33,'/auth/login',NULL,'2020-12-28 14:15:49'),(34,'/auth/login',NULL,'2020-12-28 14:15:56'),(35,'/',1,'2020-12-28 14:15:56'),(36,'/visits/logs',1,'2020-12-28 14:15:58'),(37,'/users',1,'2020-12-28 14:15:59'),(38,'/users/3/edit',1,'2020-12-28 14:16:01'),(39,'/users',1,'2020-12-28 14:17:06'),(40,'/users/3/edit',1,'2020-12-28 14:17:09'),(41,'/auth/logout',1,'2020-12-28 14:17:15'),(42,'/',NULL,'2020-12-28 14:17:15'),(43,'/auth/login',NULL,'2020-12-28 14:17:17'),(44,'/auth/login',NULL,'2020-12-28 14:17:19'),(45,'/',3,'2020-12-28 14:17:19'),(46,'/users',3,'2020-12-28 14:17:22'),(47,'/users/3/edit',3,'2020-12-28 14:17:23'),(48,'/new',3,'2020-12-28 14:17:30'),(49,'/auth/logout',3,'2020-12-28 14:17:35'),(50,'/',NULL,'2020-12-28 14:17:35'),(51,'/auth/login',NULL,'2020-12-28 14:17:37'),(52,'/auth/login',NULL,'2020-12-28 14:17:41'),(53,'/',1,'2020-12-28 14:17:41'),(54,'/new',1,'2020-12-28 14:17:45'),(55,'/',1,'2020-12-28 14:17:50'),(56,'/users',1,'2020-12-28 14:17:51'),(57,'/users/new',1,'2020-12-28 14:17:54'),(58,'/auth/logout',1,'2020-12-28 14:17:55'),(59,'/',NULL,'2020-12-28 14:17:56'),(60,'/auth/login',NULL,'2020-12-28 14:17:57'),(61,'/auth/login',NULL,'2020-12-28 14:17:58'),(62,'/',3,'2020-12-28 14:17:59'),(63,'/users',3,'2020-12-28 14:18:00'),(64,'/users/new',3,'2020-12-28 14:18:03'),(65,'/',3,'2020-12-28 14:18:03'),(66,'/users',3,'2020-12-28 14:18:06'),(67,'/users',3,'2020-12-28 14:20:11'),(68,'/users/3',3,'2020-12-28 14:20:15'),(69,'/users/3',3,'2020-12-28 14:20:47'),(70,'/users/3/edit',3,'2020-12-28 14:20:51'),(71,'/users/3/edit',3,'2020-12-28 14:21:11'),(72,'/users/3/edit',3,'2020-12-28 14:21:28'),(73,'/users/3/edit',3,'2020-12-28 14:22:12'),(74,'/users/3/edit',3,'2020-12-28 14:22:34'),(75,'/users/3',3,'2020-12-28 14:22:39'),(76,'/visits/logs',3,'2020-12-28 14:22:40'),(77,'/users',3,'2020-12-28 14:22:42'),(78,'/users/3/edit',3,'2020-12-28 14:22:46'),(79,'/visits/logs',3,'2020-12-28 14:22:52'),(80,'/visits/logs',3,'2020-12-28 15:46:30'),(81,'/visits/logs',3,'2020-12-28 15:47:07'),(82,'/users',3,'2020-12-28 18:32:02'),(83,'/users/3/edit',3,'2020-12-28 18:32:03'),(84,'/users/3/edit',3,'2020-12-28 18:43:52'),(85,'/visits/logs',3,'2020-12-28 18:43:55'),(86,'/visits/stat/pages',3,'2020-12-28 18:43:57'),(87,'/visits/stat/users',3,'2020-12-28 18:43:59'),(88,'/visits/stat/users',3,'2020-12-28 18:44:23'),(89,'/visits/stat/pages',3,'2020-12-28 18:44:27'),(90,'/visits/logs',3,'2020-12-28 18:44:27'),(91,'/visits/stat/pages',3,'2020-12-28 18:44:29'),(92,'/visits/stat/users',3,'2020-12-28 18:44:30'),(93,'/visits/stat/users',3,'2020-12-28 18:44:40'),(94,'/visits/stat/pages',3,'2020-12-28 18:44:41'),(95,'/visits/stat/users',3,'2020-12-28 18:44:42'),(96,'/visits/stat/pages',3,'2020-12-28 18:44:43'),(97,'/visits/stat/pages',3,'2020-12-28 19:19:33'),(98,'/visits/stat/users',3,'2020-12-28 19:19:34'),(99,'/visits/stat/users',3,'2020-12-28 19:19:35'),(100,'/visits/stat/users',3,'2020-12-28 19:19:49'),(101,'/visits/logs',3,'2020-12-28 19:19:54'),(102,'/visits/stat/users',3,'2020-12-28 19:19:56'),(103,'/visits/stat/users',3,'2020-12-28 19:20:29'),(104,'/visits/stat/pages',3,'2020-12-28 19:20:34'),(105,'/visits/stat/pages',3,'2020-12-28 19:24:14'),(106,'/visits/stat/pages',3,'2020-12-28 19:24:23'),(107,'/visits/stat/pages',3,'2020-12-28 19:27:08'),(108,'/visits/stat/pages',3,'2020-12-28 20:50:31'),(109,'/visits/stat/users',3,'2020-12-28 20:50:43'),(110,'/visits/stat/users',3,'2020-12-28 20:50:45'),(111,'/visits/stat/pages',3,'2020-12-28 20:50:46'),(112,'/visits/stat/pages',3,'2020-12-28 20:50:48'),(113,'/visits/logs',3,'2020-12-28 20:50:59'),(114,'/visits/logs',3,'2020-12-28 20:51:14'),(115,'/visits/logs',3,'2020-12-28 20:51:36'),(116,'/visits/logs',3,'2020-12-28 21:02:50'),(117,'/visits/logs',3,'2020-12-28 21:03:09'),(118,'/visits/logs',3,'2020-12-28 21:03:11'),(119,'/visits/logs',3,'2020-12-28 21:03:14'),(120,'/visits/logs',3,'2020-12-28 21:03:15'),(121,'/visits/logs',3,'2020-12-28 21:03:17'),(122,'/visits/logs',3,'2020-12-28 21:03:18'),(123,'/visits/logs',3,'2020-12-28 21:03:19'),(124,'/visits/logs',3,'2020-12-28 21:03:19'),(125,'/visits/logs',3,'2020-12-28 21:03:22'),(126,'/visits/logs',3,'2020-12-28 21:03:23'),(127,'/visits/logs',3,'2020-12-28 21:03:48'),(128,'/visits/logs',3,'2020-12-28 21:03:49'),(129,'/visits/logs',3,'2020-12-28 21:03:50'),(130,'/visits/logs',3,'2020-12-28 21:03:51'),(131,'/visits/logs',3,'2020-12-28 21:03:53'),(132,'/visits/logs',3,'2020-12-28 21:03:55'),(133,'/visits/logs',3,'2020-12-28 21:03:57'),(134,'/visits/logs',3,'2020-12-28 21:03:59'),(135,'/visits/logs',3,'2020-12-28 21:03:59'),(136,'/visits/logs',3,'2020-12-28 21:04:00'),(137,'/visits/logs',3,'2020-12-28 21:04:01'),(138,'/visits/logs',3,'2020-12-28 21:04:52'),(139,'/visits/logs',3,'2020-12-28 21:04:54'),(140,'/visits/logs',3,'2020-12-28 21:04:55'),(141,'/visits/logs',3,'2020-12-28 21:04:55'),(142,'/visits/logs',3,'2020-12-28 21:04:57'),(143,'/visits/logs',3,'2020-12-28 21:04:57'),(144,'/visits/logs',3,'2020-12-28 21:04:59'),(145,'/visits/logs',3,'2020-12-28 21:05:00'),(146,'/visits/logs',3,'2020-12-28 21:05:00'),(147,'/visits/logs',3,'2020-12-28 21:05:22'),(148,'/visits/logs',3,'2020-12-28 21:05:24'),(149,'/visits/logs',3,'2020-12-28 21:05:26'),(150,'/visits/logs',3,'2020-12-28 21:05:27'),(151,'/visits/logs',3,'2020-12-28 21:05:39'),(152,'/visits/logs',3,'2020-12-28 21:07:57'),(153,'/visits/logs',3,'2020-12-28 21:07:59'),(154,'/visits/logs',3,'2020-12-28 21:08:37'),(155,'/visits/logs',3,'2020-12-28 21:08:53'),(156,'/visits/logs',3,'2020-12-28 21:09:35'),(157,'/visits/logs',3,'2020-12-28 21:09:56'),(158,'/visits/logs',3,'2020-12-28 21:10:40'),(159,'/visits/logs',3,'2020-12-28 21:10:42'),(160,'/visits/logs',3,'2020-12-28 21:10:43'),(161,'/visits/logs',3,'2020-12-28 21:10:45'),(162,'/visits/logs',3,'2020-12-28 21:11:02'),(163,'/visits/logs',3,'2020-12-28 21:11:06'),(164,'/visits/logs',3,'2020-12-28 21:11:07'),(165,'/visits/logs',3,'2020-12-28 21:11:08'),(166,'/visits/logs',3,'2020-12-28 21:11:09'),(167,'/visits/logs',3,'2020-12-28 21:11:10'),(168,'/visits/logs',3,'2020-12-28 21:11:11'),(169,'/visits/logs',3,'2020-12-28 21:11:12'),(170,'/visits/logs',3,'2020-12-28 21:11:12'),(171,'/visits/logs',3,'2020-12-28 21:11:13'),(172,'/visits/logs',3,'2020-12-28 21:11:14'),(173,'/',3,'2020-12-28 21:11:17'),(174,'/',NULL,'2021-01-09 11:55:37'),(175,'/auth/login',NULL,'2021-01-09 11:55:39'),(176,'/auth/login',NULL,'2021-01-09 11:55:43'),(177,'/',1,'2021-01-09 11:55:43'),(178,'/visits/logs',1,'2021-01-09 11:55:45'),(179,'/visits/logs',1,'2021-01-09 11:55:48'),(180,'/visits/logs',1,'2021-01-09 11:55:50'),(181,'/visits/logs',1,'2021-01-09 11:55:51'),(182,'/visits/logs',1,'2021-01-09 11:55:52'),(183,'/visits/logs',1,'2021-01-09 11:55:53'),(184,'/visits/logs',1,'2021-01-09 11:55:54'),(185,'/visits/logs',1,'2021-01-09 11:55:55'),(186,'/visits/logs',1,'2021-01-09 11:55:56'),(187,'/visits/stat/pages',1,'2021-01-09 11:56:02'),(188,'/visits/stat/users',1,'2021-01-09 11:56:03'),(189,'/visits/stat/pages',1,'2021-01-09 11:56:05'),(190,'/visits/stat/users',1,'2021-01-09 11:56:06'),(191,'/visits/logs',1,'2021-01-09 11:56:07'),(192,'/visits/stat/users',1,'2021-01-09 11:56:09'),(193,'/visits/stat/users',1,'2021-01-09 11:56:12'),(194,'/visits/stat/pages',1,'2021-01-09 11:56:19'),(195,'/visits/logs',1,'2021-01-09 11:56:22'),(196,'/visits/stat/pages',1,'2021-01-09 11:56:24'),(197,'/visits/logs',1,'2021-01-09 11:56:26'),(198,'/visits/stat/pages',1,'2021-01-09 11:56:29'),(199,'/visits/stat/pages',1,'2021-01-09 11:57:05'),(200,'/visits/stat/pages',1,'2021-01-09 11:57:08'),(201,'/visits/stat/users',1,'2021-01-09 11:57:16');
/*!40000 ALTER TABLE `visit_logs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-26  0:02:11
