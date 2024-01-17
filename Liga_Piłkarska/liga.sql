CREATE DATABASE  IF NOT EXISTS `liga`;
USE `liga`;

DROP TABLE IF EXISTS `bramki`;

CREATE TABLE `bramki` (
    `id_bramki` int NOT NULL AUTO_INCREMENT,
    `id_zawodnik` int NOT NULL,
    `id_meczu` int NOT NULL,
    `id_druzyny` int NOT NULL,
    PRIMARY KEY (`id_bramki`),
    UNIQUE KEY `id_bramki_UNIQUE` (`id_bramki`),
    KEY `fk_Bramki_Mecz1_idx` (`id_meczu`),
    KEY `fk_Bramki_Zawodnik1_idx` (`id_zawodnik`),
    CONSTRAINT `fk_Bramki_Mecz1` FOREIGN KEY (`id_meczu`) REFERENCES `mecz` (`id_mecz`),
    CONSTRAINT `fk_Bramki_Zawodnik1` FOREIGN KEY (`id_zawodnik`) REFERENCES `zawodnik` (`id_zawodnik`),
    CONSTRAINT `fk_Bramki_druzyna` FOREIGN KEY (`id_druzyny`) REFERENCES `drużyna` (`id_druzyna)` 
);

LOCK TABLES `bramki` WRITE;
INSERT INTO `bramki` VALUES (1,2,1),(2,3,1),(3,14,1),(4,23,2),(5,22,2),(6,2,2),(7,39,3),(8,39,3),(9,7,3),(10,15,5),(11,15,5),(12,15,5),(13,27,6),(14,25,6),(15,33,6),(16,57,7),(17,53,7),(18,69,8),(19,52,9),(20,69,10),(21,78,11),(22,74,12);
UNLOCK TABLES;

DROP TABLE IF EXISTS `drużyna`;
CREATE TABLE `drużyna` (
    `id_druzyna` int NOT NULL AUTO_INCREMENT,
    `nazwa` varchar(200) NOT NULL,
    `miasto` varchar(100) NOT NULL,
    `id_liga` int NOT NULL,
    PRIMARY KEY (`id_druzyna`),
    KEY `fk_Drużyna_Liga1_idx` (`id_liga`),
    CONSTRAINT `fk_Drużyna_Liga1` FOREIGN KEY (`id_liga`) REFERENCES `liga` (`id_liga`)
);

LOCK TABLES `drużyna` WRITE;
INSERT INTO `drużyna` VALUES (1,'\"TS Wisła Kraków\"','Kraków',1),(2,'\"KS Cracovia\"','Kraków',1),(3,'\"Raków Częstochowa\"','Częstochowa',1),(4,'\"Lech Poznań\"','Poznań',1),(5,'\"Widzew Łódź\"','Łódź',2),(6,'\"Stal Stalowa Wola\"','\"Stalowa Wola\"',2),(7,'\"Arka Gdynia\"','Gdynia',2),(8,'\"Stal Rzeszów\"','Rzeszów',2);
UNLOCK TABLES;

DROP TABLE IF EXISTS `liga`;

CREATE TABLE `liga` (
    `id_liga` int NOT NULL,
    `nazwa` varchar(100) NOT NULL,
    PRIMARY KEY (`id_liga`),
    UNIQUE KEY `id_league_UNIQUE` (`id_liga`)
);

LOCK TABLES `liga` WRITE;
INSERT INTO `liga` VALUES (1,'Pierwsza'),(2,'Druga');
UNLOCK TABLES;
DROP TABLE IF EXISTS `mecz`;

CREATE TABLE `mecz` (
    `id_mecz` int NOT NULL AUTO_INCREMENT,
    `id_termin` int NOT NULL,
    `id_druzyna_1` int NOT NULL,
    `id_druzyna_2` int NOT NULL,
    PRIMARY KEY (`id_mecz`),
    KEY `fk_Mecz_Terminy1_idx` (`id_termin`),
    CONSTRAINT `fk_Mecz_Terminy1` FOREIGN KEY (`id_termin`) REFERENCES `terminy` (`id_termin`)
);

LOCK TABLES `mecz` WRITE;
INSERT INTO `mecz` VALUES (1,1,1,2),(2,2,1,3),(3,3,1,4),(4,4,2,3),(5,5,2,4),(6,6,3,4),(7,7,5,6),(8,8,5,7),(9,9,5,8),(10,10,6,7),(11,11,6,8),(12,12,7,8);
UNLOCK TABLES;

DROP TABLE IF EXISTS `terminy`;
CREATE TABLE `terminy` (
    `id_termin` int NOT NULL AUTO_INCREMENT,
    `data_rozpoczecia` datetime NOT NULL,
    `data_zakonczenia` datetime NOT NULL,
    PRIMARY KEY (`id_termin`)
);

LOCK TABLES `terminy` WRITE;
INSERT INTO `terminy` VALUES (1,'2023-12-01 14:00:00','2023-12-01 15:30:00'),(2,'2023-12-02 16:00:00','2023-12-02 17:30:00'),(3,'2023-12-03 18:00:00','2023-12-03 19:30:00'),(4,'2023-12-04 14:30:00','2023-12-04 16:00:00'),(5,'2023-12-05 17:00:00','2023-12-05 18:30:00'),(6,'2023-12-06 19:30:00','2023-12-06 21:00:00'),(7,'2023-12-07 15:00:00','2023-12-07 16:30:00'),(8,'2023-12-08 17:30:00','2023-12-08 19:00:00'),(9,'2023-12-09 14:30:00','2023-12-09 16:00:00'),(10,'2023-12-10 18:00:00','2023-12-10 19:30:00'),(11,'2023-12-11 16:30:00','2023-12-11 18:00:00'),(12,'2023-12-12 14:00:00','2023-12-12 15:30:00');
UNLOCK TABLES;

DROP TABLE IF EXISTS `wynik`;
CREATE TABLE `wynik` (
    `id_wynik` int NOT NULL AUTO_INCREMENT,
    `id_mecz` int NOT NULL,
    `zwycieska_druzyna` int DEFAULT NULL,
    PRIMARY KEY (`id_wynik`),
    KEY `fk_Wynik_Mecz1_idx` (`id_mecz`),
    KEY `fk_zwycieska_druzyna_idx` (`zwycieska_druzyna`),
    CONSTRAINT `fk_Wynik_Mecz1` FOREIGN KEY (`id_mecz`) REFERENCES `mecz` (`id_mecz`),
    CONSTRAINT `fk_zwycieska_druzyna` FOREIGN KEY (`zwycieska_druzyna`) REFERENCES `drużyna` (`id_druzyna`)
);

LOCK TABLES `wynik` WRITE;
INSERT INTO `wynik` VALUES (1,1,1),(2,2,3),(3,3,4),(4,4,NULL),(5,5,2),(6,6,3),(7,7,5),(8,8,7),(9,9,5),(10,10,7),(11,11,7),(12,12,7);
UNLOCK TABLES;

DROP TABLE IF EXISTS `zawodnik`;
CREATE TABLE `zawodnik` (
    `id_zawodnik` int NOT NULL AUTO_INCREMENT,
    `imie` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `nazwisko` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `pozycja` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `id_druzyna` int NOT NULL,
    PRIMARY KEY (`id_zawodnik`),
    KEY `fk_Zawodnik_Drużyna1_idx` (`id_druzyna`),
    CONSTRAINT `fk_Zawodnik_Drużyna1` FOREIGN KEY (`id_druzyna`) REFERENCES `drużyna` (`id_druzyna`)
);

LOCK TABLES `zawodnik` WRITE;
INSERT INTO `zawodnik` VALUES (1,'Lucas','Hernandez','Obrońca',1),(2,'Isaac','Watson','Napastnik',1),(3,'Olivia','Barnes','Pomocnik',1),(4,'Leo','Miller','Obrońca',1),(5,'Sophia','Reyes','Obrońca',1),(6,'Liam','Lopez','Pomocnik',1),(7,'Ella','Cook','Pomocnik',1),(8,'Logan','Richardson','Obrońca',1),(9,'Aria','Bailey','Napastnik',1),(10,'Amelia','Rossi','Obrońca',1),(11,'Mason','Gray','Obrońca',2),(12,'Harper','Gomez','Pomocnik',2),(13,'Ethan','Cruz','Pomocnik',2),(14,'Ava','Howard','Obrońca',2),(15,'Caden','Cooper','Napastnik',2),(16,'Emma','Morris','Obrońca',2),(17,'Noah','Russell','Obrońca',2),(18,'Mia','Martinez','Pomocnik',2),(19,'Lucas','Murphy','Pomocnik',2),(20,'Sofia','Turner','Obrońca',2),(21,'Aiden','Simmons','Napastnik',2),(22,'Zoe','Gray','Obrońca',3),(23,'William','Campbell','Obrońca',3),(24,'Evelyn','Diaz','Pomocnik',3),(25,'Jackson','Adams','Pomocnik',3),(26,'Ellie','Stewart','Obrońca',3),(27,'James','Fisher','Napastnik',3),(28,'Lily','Anderson','Obrońca',3),(29,'Lincoln','Collins','Obrońca',3),(30,'Avery','Cook','Pomocnik',3),(31,'Mateo','Ford','Pomocnik',3),(32,'Luna','Martinez','Obrońca',3),(33,'Logan','Cole','Napastnik',3),(34,'Grace','Hughes','Obrońca',4),(35,'Jacob','Hernandez','Obrońca',4),(36,'Aria','Evans','Pomocnik',4),(37,'Liam','Martinez','Pomocnik',4),(38,'Isabella','Wilson','Obrońca',4),(39,'Ethan','Ward','Napastnik',4),(40,'Olivia','Roberts','Obrońca',4),(41,'Noah','Cruz','Obrońca',4),(42,'Sophia','Perez','Pomocnik',4),(43,'Mason','Morris','Pomocnik',4),(44,'Emma','Kelly','Obrońca',4),(45,'Aiden','Watson','Napastnik',4),(46,'Mia','Russell','Obrońca',5),(47,'Lucas','Cooper','Obrońca',5),(48,'Ella','Hernandez','Pomocnik',5),(49,'Logan','Ward','Pomocnik',5),(50,'Harper','Lopez','Obrońca',5),(51,'Caden','Hughes','Napastnik',5),(52,'Amelia','Murphy','Obrońca',5),(53,'Ethan','Simmons','Obrońca',5),(54,'Ava','Adams','Pomocnik',5),(55,'Noah','Stewart','Pomocnik',5),(56,'Mia','Fisher','Obrońca',5),(57,'Lucas','Anderson','Napastnik',5),(58,'Sophia','Collins','Obrońca',6),(59,'Liam','Cook','Obrońca',6),(60,'Ella','Martinez','Pomocnik',6),(61,'Logan','Ford','Pomocnik',6),(62,'Aria','Martinez','Obrońca',6),(63,'Ethan','Cruz','Napastnik',6),(64,'Olivia','Hughes','Obrońca',6),(65,'Leo','Murphy','Obrońca',6),(66,'Sophia','Watson','Pomocnik',6),(67,'Jackson','Gomez','Pomocnik',6),(68,'Ella','Rossi','Obrońca',6),(69,'Mia','Bailey','Napastnik',7),(70,'Lucas','Howard','Obrońca',7),(71,'Isaac','Campbell','Obrońca',7),(72,'Olivia','Diaz','Pomocnik',7),(73,'Leo','Adams','Pomocnik',7),(74,'Sophia','Stewart','Obrońca',7),(75,'Liam','Fisher','Napastnik',7),(76,'Ella','Anderson','Obrońca',7),(77,'Noah','Collins','Obrońca',7),(78,'Mia','Cook','Pomocnik',7),(79,'Lucas','Ford','Pomocnik',8),(80,'Ava','Martinez','Obrońca',8),(81,'Ethan','Evans','Napastnik',8),(82,'Olivia','Wilson','Obrońca',8),(83,'Leo','Ward','Obrońca',8),(84,'Sophia','Perez','Pomocnik',8),(85,'Jackson','Morris','Pomocnik',8),(86,'Ella','Kelly','Obrońca',8),(87,'Mia','Watson','Napastnik',8),(88,'Liam','Russell','Obrońca',8)
);

UNLOCK TABLES;
