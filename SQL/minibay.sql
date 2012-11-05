-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.58-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema minibay
--

CREATE DATABASE IF NOT EXISTS minibay;
USE minibay;

--
-- Definition of table `asta`
--

DROP TABLE IF EXISTS `asta`;
CREATE TABLE `asta` (
  `idasta` int(11) NOT NULL AUTO_INCREMENT,
  `titolo` varchar(200) NOT NULL COMMENT 'breve titolo (1 riga) dell''oggetto venduto',
  `descrizione` text NOT NULL COMMENT 'descrizione lunga (in html???)',
  `prezzobase` decimal(10,0) unsigned NOT NULL COMMENT 'prezzo minimo d''asta (in euro)',
  `stato` enum('caricata','attiva','scaduta','avuoto','aggiudicata','spedita','completata','pagata') DEFAULT 'caricata' COMMENT 'stato corrente dell''asta, su questo campo si gestisce l''intero ciclo di vita,',
  `idutentevenditore` int(11) NOT NULL COMMENT 'l''utente venditore che ha creato l''asta',
  `stamp_creazione` datetime DEFAULT NULL COMMENT 'timestamp di prima creazione (servirà???)',
  `stamp_scadenza` datetime NOT NULL COMMENT 'timestamp della scadenza dell asta',
  `idcategoria` int(11) NOT NULL,
  `idutenteaggiudicatario` int(11) DEFAULT NULL,
  `prezzoaggiudicato` float DEFAULT NULL,
  PRIMARY KEY (`idasta`),
  KEY `utentevenditore` (`idutentevenditore`),
  KEY `categoriaasta` (`idcategoria`),
  KEY `utenteaggiudicatario` (`idutenteaggiudicatario`),
  CONSTRAINT `categoriaasta` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `utenteaggiudicatario` FOREIGN KEY (`idutenteaggiudicatario`) REFERENCES `utente` (`idutente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `utentevenditore` FOREIGN KEY (`idutentevenditore`) REFERENCES `utente` (`idutente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=latin1 COMMENT='informazioni sugli oggetti venduti';

--
-- Dumping data for table `asta`
--

/*!40000 ALTER TABLE `asta` DISABLE KEYS */;
INSERT INTO `asta` (`idasta`,`titolo`,`descrizione`,`prezzobase`,`stato`,`idutentevenditore`,`stamp_creazione`,`stamp_scadenza`,`idcategoria`,`idutenteaggiudicatario`,`prezzoaggiudicato`) VALUES 
 (37,'Appunti di un venditore di donne','# Rilegato: 397 pagine\r\n# Editore: B.C. Dalai Editore (09 novembre 2010)\r\n# Collana: Romanzi e racconti\r\n# Lingua: Italiano\r\n# ISBN-10: 8860735394\r\n# ISBN-13: 978-8860735393\r\n# Peso di spedizione: 621 g\r\n# Media recensioni: 3.7 su 5 stelle','5','avuoto',6,'2011-03-01 23:23:32','2011-03-09 00:00:00',3,NULL,NULL),
 (38,'La mappa del destino','# Rilegato: 410 pagine\r\n# Editore: Nord (01 gennaio 2011)\r\n# Collana: Narrativa Nord\r\n# ISBN-10: 8842916714\r\n# ISBN-13: 978-8842916710\r\n# Peso di spedizione: 599 g\r\n# Media recensioni: Recensisci per primo questo articolo\r\n# Posizione nella classifica Bestseller di Amazon: n. 4 ','10','avuoto',6,'2011-03-01 23:23:44','2011-03-09 00:00:00',3,NULL,NULL),
 (39,'CONTACHILOMETRI TACHIMETRO DIGITALE BICI BICICLETTA','Questa unità COMPATTA e LEGGERA si attacca sul manubrio e il sensore si adatta perfettamente alla tua ruota anteriore, permettendoti una LETTURA ACCURATA e 14 FANTASTICHE FUNZIONI','4','avuoto',6,'2011-03-01 23:23:48','2011-03-15 12:00:00',6,NULL,NULL),
 (43,'ALLARME ANTIFURTO','','10','aggiudicata',6,'2011-03-01 23:24:00','2011-03-20 00:00:00',4,8,10),
 (45,'Meliconi Stendibiancheri','','80','avuoto',6,'2011-03-01 23:24:37','2011-03-15 00:00:00',5,NULL,NULL),
 (46,'IL CAPITAN FRACASSA','','9','avuoto',7,'2011-03-01 23:27:15','2011-03-15 00:00:00',3,NULL,NULL),
 (47,'	 IL FANTASMA DI SANDOKAN','','8','avuoto',7,'2011-03-01 23:27:24','2011-03-20 00:00:00',3,NULL,NULL),
 (48,'EVERNIGHT-GRAY CLAUDIA','','5','aggiudicata',7,'2011-03-01 23:29:46','2011-03-21 00:00:00',3,6,6),
 (49,'IL DIARIO DI ANNA FRANK','','15','avuoto',7,'2011-03-01 23:29:51','2011-03-20 00:00:00',3,NULL,NULL),
 (50,'FAVOLE di ANDERSEN','','12','aggiudicata',7,'2011-03-01 23:30:30','2011-03-15 00:00:00',3,6,15),
 (51,'JOHN LEE HOOKER - BURNING HELL','','15','avuoto',7,'2011-03-01 23:33:19','2011-03-16 00:00:00',9,NULL,NULL),
 (52,'Motorhead - Orgasmatron CD','','4','avuoto',7,'2011-03-01 23:34:04','2011-03-09 00:00:00',9,NULL,NULL),
 (53,'cd acid blues','','8','aggiudicata',2,'2011-03-01 23:39:57','2011-03-15 00:00:00',9,8,26),
 (54,'ALLMAN BROTHERS BAND','','1','avuoto',2,'2011-03-01 23:40:04','2011-03-15 00:00:00',5,NULL,NULL),
 (55,'Amplificatore per Basso 40/80Watt ','','90','avuoto',2,'2011-03-01 23:40:16','2011-03-09 00:00:00',9,NULL,NULL),
 (56,'TRACOLLA CHITARRA','','15','avuoto',2,'2011-03-01 23:40:11','2011-03-15 00:00:00',9,NULL,NULL),
 (57,'SUPPORTO PROEL PER TASTIERA','','15','avuoto',2,'2011-03-01 23:43:10','2011-03-16 00:00:00',9,NULL,NULL),
 (58,'Basso 6 corde','','120','aggiudicata',6,'2011-03-02 21:43:23','2011-03-20 00:00:00',8,10,123),
 (59,'Le balle di Newton','','8','aggiudicata',8,'2011-03-02 21:50:24','2011-03-24 18:45:00',3,10,9),
 (60,'libro1','','5','aggiudicata',6,'2011-03-04 00:27:43','2011-03-24 18:45:00',3,10,5),
 (61,'libro2','','8','avuoto',6,'2011-03-04 00:31:05','2011-03-15 00:00:00',3,NULL,NULL),
 (62,'libro3','','3','aggiudicata',6,'2011-03-04 00:31:13','2011-03-09 00:00:00',3,8,5),
 (63,'libro4','','5','aggiudicata',6,'2011-03-04 00:33:11','2011-03-16 00:00:00',3,10,5),
 (64,'libro1','','2','aggiudicata',8,'2011-03-04 00:34:50','2011-03-20 00:00:00',3,10,4),
 (65,'libro3','','9','aggiudicata',8,'2011-03-04 00:34:54','2011-03-15 00:00:00',3,10,10),
 (66,'libro5','','15','aggiudicata',8,'2011-03-04 01:50:20','2011-03-20 00:00:00',3,10,20),
 (67,'Scrivania dlabvshs','','21','avuoto',6,'2011-03-04 18:48:50','2011-03-20 00:00:00',5,NULL,NULL),
 (68,'Sedia dkfmvcd','','20','avuoto',6,'2011-03-04 18:48:57','2011-03-15 00:00:00',5,NULL,NULL),
 (69,'prova','','5','aggiudicata',6,'2011-03-04 20:30:08','2011-03-04 20:35:00',4,10,6),
 (70,'mericiao','','6','spedita',10,'2011-03-04 20:34:24','2011-03-04 20:38:00',7,6,8),
 (71,'libro10','','5','avuoto',6,'2011-03-06 03:02:48','2011-03-20 00:00:00',3,NULL,NULL),
 (72,'libro11','','10','avuoto',6,'2011-03-06 03:02:41','2011-03-15 00:00:00',3,NULL,NULL),
 (74,'ggg','','4','attiva',11,NULL,'2011-11-09 12:00:00',5,NULL,NULL),
 (75,'ggg','','4','caricata',11,NULL,'2011-11-09 12:00:00',5,NULL,NULL),
 (76,'ggg','','4','caricata',11,NULL,'2011-11-09 12:00:00',5,NULL,NULL),
 (77,'cacca2','cacca23','5','attiva',11,'2011-07-14 12:00:00','2011-11-09 12:00:00',5,NULL,NULL),
 (78,'radio','','10','attiva',12,'2011-07-18 18:00:00','2011-07-23 12:00:00',4,NULL,NULL),
 (79,'robot','','12','attiva',12,'2011-01-12 12:11:00','2012-11-13 12:11:00',4,NULL,NULL),
 (85,'Suzuki','','1323','caricata',12,'2011-01-12 12:11:00','2012-11-13 12:11:00',1,NULL,NULL),
 (86,'Ferrari','','1329288','caricata',12,'2011-01-12 12:11:00','2012-11-13 12:11:00',1,NULL,NULL),
 (87,'Harry Potter','','13','caricata',12,'2011-01-12 12:11:00','2012-11-13 12:11:00',3,NULL,NULL),
 (92,'Penna bic','','1','caricata',12,'2011-01-12 12:11:00','2012-11-13 12:11:00',5,NULL,NULL),
 (93,'Penna bic','','1','attiva',12,'2011-01-12 12:11:00','2012-11-13 12:11:00',5,NULL,NULL),
 (94,'Penna bic','','1','caricata',12,'2011-01-12 12:11:00','2012-11-13 12:11:00',5,NULL,NULL),
 (95,'Penna bic','','1','caricata',12,'2011-01-12 12:11:00','2012-11-13 12:11:00',5,NULL,NULL),
 (96,'Penna bic','','1','caricata',12,'2011-01-12 12:11:00','2012-11-13 12:11:00',3,NULL,NULL),
 (97,'Penna bic','','1','caricata',12,'2011-01-12 12:11:00','2012-11-13 12:11:00',2,NULL,NULL);
/*!40000 ALTER TABLE `asta` ENABLE KEYS */;


--
-- Definition of table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL AUTO_INCREMENT,
  `nomecategoria` varchar(45) NOT NULL,
  PRIMARY KEY (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COMMENT='categorie degli oggetti venduti';

--
-- Dumping data for table `categoria`
--

/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` (`idcategoria`,`nomecategoria`) VALUES 
 (1,'Motori'),
 (2,'Bricolage'),
 (3,'Libri'),
 (4,'Elettronica'),
 (5,'Articoli per la casa'),
 (6,'Sport'),
 (7,'Tempo Libero'),
 (8,'Strumenti Musicali'),
 (9,'Musica'),
 (10,'Video');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;


--
-- Definition of table `multicategoria`
--

DROP TABLE IF EXISTS `multicategoria`;
CREATE TABLE `multicategoria` (
  `idCategoria` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idasta` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idCategoria`,`idasta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `multicategoria`
--

/*!40000 ALTER TABLE `multicategoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `multicategoria` ENABLE KEYS */;


--
-- Definition of table `offerta`
--

DROP TABLE IF EXISTS `offerta`;
CREATE TABLE `offerta` (
  `idofferta` int(11) NOT NULL AUTO_INCREMENT,
  `idutenteofferente` int(11) NOT NULL COMMENT 'l''utente che compie l''offerta',
  `idasta` int(11) NOT NULL COMMENT 'l''asta per la quale l''offerta è relativa',
  `offerta` decimal(10,0) NOT NULL COMMENT 'valore dell''offerta (in euro). Deve essere superiore a asta.prezzobase',
  `valida` tinyint(1) NOT NULL COMMENT 'se ci sono più offerte dello stesso utente per la stessa asta, indica quale di esse è quella valida',
  `stamp` datetime NOT NULL COMMENT 'timestamp di creazione dell''offerta',
  PRIMARY KEY (`idofferta`),
  KEY `utenteofferente` (`idutenteofferente`),
  KEY `astaofferta` (`idasta`),
  CONSTRAINT `utenteofferente` FOREIGN KEY (`idutenteofferente`) REFERENCES `utente` (`idutente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1 COMMENT='le offerte dei diversi utenti offerenti per ciascuna asta';

--
-- Dumping data for table `offerta`
--

/*!40000 ALTER TABLE `offerta` DISABLE KEYS */;
INSERT INTO `offerta` (`idofferta`,`idutenteofferente`,`idasta`,`offerta`,`valida`,`stamp`) VALUES 
 (1,8,53,'25',0,'2011-03-04 00:38:55'),
 (2,8,53,'26',1,'2011-03-04 04:04:21'),
 (3,8,43,'10',0,'2011-03-04 04:05:09'),
 (4,8,43,'9',0,'2011-03-04 04:05:21'),
 (5,8,43,'10',1,'2011-03-04 04:05:39'),
 (6,6,64,'3',1,'2011-03-04 04:07:40'),
 (7,6,48,'6',1,'2011-03-04 04:09:00'),
 (8,6,50,'15',0,'2011-03-04 04:10:16'),
 (9,6,65,'9',0,'2011-03-04 04:23:37'),
 (10,6,66,'20',0,'2011-03-04 17:30:10'),
 (11,10,66,'20',1,'2011-03-04 17:32:28'),
 (12,10,65,'10',1,'2011-03-04 17:47:23'),
 (13,10,63,'5',1,'2011-03-04 17:57:33'),
 (14,10,62,'4',1,'2011-03-04 17:57:55'),
 (15,8,62,'4',0,'2011-03-04 18:00:37'),
 (16,8,62,'5',1,'2011-03-04 18:01:56'),
 (17,6,59,'8',0,'2011-03-04 18:06:49'),
 (18,10,59,'9',1,'2011-03-04 18:07:47'),
 (19,10,64,'4',1,'2011-03-04 18:08:45'),
 (20,10,58,'122',0,'2011-03-04 18:10:14'),
 (21,10,60,'5',1,'2011-03-04 18:13:29'),
 (22,10,58,'123',1,'2011-03-04 18:25:19'),
 (23,6,50,'16',0,'2011-03-04 18:39:38'),
 (24,6,59,'9',1,'2011-03-04 18:47:01'),
 (25,6,50,'15',1,'2011-03-04 18:50:41'),
 (26,10,69,'5',0,'2011-03-04 20:32:25'),
 (27,10,69,'6',1,'2011-03-04 20:32:39'),
 (28,6,70,'8',1,'2011-03-04 20:36:58'),
 (30,11,78,'12',1,'2011-07-18 18:59:01'),
 (31,12,77,'23',0,'2002-01-01 16:35:42'),
 (32,12,74,'21',0,'2002-01-01 20:11:20'),
 (33,12,74,'22',0,'2002-01-01 20:40:43'),
 (34,12,77,'12',0,'2002-01-01 21:12:56'),
 (35,12,77,'14',1,'2002-01-01 21:23:46');
/*!40000 ALTER TABLE `offerta` ENABLE KEYS */;


--
-- Definition of table `preferenze`
--

DROP TABLE IF EXISTS `preferenze`;
CREATE TABLE `preferenze` (
  `idutente` int(11) NOT NULL,
  `idcategoria` int(11) NOT NULL,
  PRIMARY KEY (`idutente`,`idcategoria`),
  KEY `utente` (`idutente`),
  KEY `categoria` (`idcategoria`),
  CONSTRAINT `categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `utente` FOREIGN KEY (`idutente`) REFERENCES `utente` (`idutente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `preferenze`
--

/*!40000 ALTER TABLE `preferenze` DISABLE KEYS */;
INSERT INTO `preferenze` (`idutente`,`idcategoria`) VALUES 
 (2,3),
 (2,6),
 (6,3),
 (6,4),
 (6,5),
 (6,9),
 (8,5),
 (8,6),
 (8,8),
 (10,3);
/*!40000 ALTER TABLE `preferenze` ENABLE KEYS */;


--
-- Definition of table `utente`
--

DROP TABLE IF EXISTS `utente`;
CREATE TABLE `utente` (
  `idutente` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL COMMENT 'username di login, max 20 caratteri\n',
  `password` varchar(20) NOT NULL COMMENT 'password (hash???)',
  `email` varchar(100) NOT NULL,
  `cognome` varchar(45) NOT NULL COMMENT 'cognome reale della persona',
  `nome` varchar(45) NOT NULL COMMENT 'nome reale della persona',
  `indirizzo` text COMMENT 'obbligatorio solo se voglio acquistare, mentre per vendere non è necessario',
  PRIMARY KEY (`idutente`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `utente`
--

/*!40000 ALTER TABLE `utente` DISABLE KEYS */;
INSERT INTO `utente` (`idutente`,`username`,`password`,`email`,`cognome`,`nome`,`indirizzo`) VALUES 
 (2,'Marco','marcoebay','gionnyb@hotmail.it','marchesi','marco','corso francesco ferrucci, 40 Torino 10138, Italia'),
 (6,'gionnyb','gionnybebay','gionnyb@hotmail.it','bonaventura','giovanni','corso francesco ferrucci, 40 Torino 10138, Italia'),
 (7,'alessia','alessiaebay','gionnyb@hotmail.it','pro','alessia','corso francesco ferrucci, 40 Torino 10138, Italia'),
 (8,'dario','darioebay','gionnyb@hotmail.it','pro','Dario',''),
 (9,'federica','federicaebay','gionnyb@hotmail.it','pro','federica',''),
 (10,'merina','merinaebay','brubru89@hotmail.it','di meri','merina',''),
 (11,'fede','fedeebay','fede.db@hotmail.com','Di Bartolomeo','Federico',''),
 (12,'sorre','minibay','sorrentinofabio@hotmail.it','Sorrentino','Fabio',''),
 (13,'sorre2','minibay','sublime_mem@hotmail.it','Sorrento','Fabio',''),
 (14,'vinci','minibay','a@beta.it','Sorrentino','Vincenzo','');
/*!40000 ALTER TABLE `utente` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
