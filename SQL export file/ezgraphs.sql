-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 15, 2018 at 11:25 PM
-- Server version: 10.1.34-MariaDB
-- PHP Version: 7.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ezgraphs`
--

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `classID` int(10) NOT NULL,
  `profID` int(10) NOT NULL,
  `classPASS` varchar(50) DEFAULT NULL,
  `classNAME` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`classID`, `profID`, `classPASS`, `classNAME`) VALUES
(1, 2, '11M3pass', '11M3'),
(2, 11, 'Info2Group', 'CNMV-Info2'),
(3, 11, 'info-volei', 'CNILC-V'),
(4, 2, 'Info2', '10M2'),
(5, 11, 'Multi123', 'CNMV-Multimedia'),
(6, 2, '12N3Pass', '12N3');

-- --------------------------------------------------------

--
-- Table structure for table `comentarii`
--

CREATE TABLE `comentarii` (
  `commID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `commData` text NOT NULL,
  `nota` int(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comentarii`
--

INSERT INTO `comentarii` (`commID`, `userID`, `userName`, `commData`, `nota`) VALUES
(1, 2, 'Lincan', 'Aceasta aplicatie m-a ajutat sa monitorizez mai usor evolutia elevilor mei!', 4),
(2, 1, 'Teo', 'WOW! Acum pot si eu sa invat grafurile cum trebuie. Imi place mai ales ca pot sa vad si metoda de predare a alto\nr profesori, uitandu-ma in tabul de lectii!', 5),
(3, 5, 'Stan', 'Acum pot sa studiez si singur! ', 4),
(4, 7, 'Andrei', 'Ce ma ajuta foarte mult in procesul de invatare sunt animatiile pe graf. Impreuna cu explicatiile din panoul din s\ntanga pot sa inteleg grafurile ! :)', 4);

-- --------------------------------------------------------

--
-- Table structure for table `gamescores`
--

CREATE TABLE `gamescores` (
  `gameID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gamescores`
--

INSERT INTO `gamescores` (`gameID`, `userID`, `score`) VALUES
(2, 1, 5),
(3, 1, 0),
(3, 9, 134),
(3, 10, 530),
(3, 14, 320),
(4, 2, 1320),
(4, 4, 132),
(4, 14, 1000),
(5, 4, 80),
(5, 9, 70448),
(5, 10, 70),
(6, 2, 10);

-- --------------------------------------------------------

--
-- Table structure for table `lectiedata`
--

CREATE TABLE `lectiedata` (
  `lectieID` int(11) NOT NULL,
  `profID` int(11) NOT NULL,
  `lectieData` text NOT NULL,
  `lectieGraf` text NOT NULL,
  `lectieName` varchar(50) NOT NULL,
  `scor` float NOT NULL,
  `nrVotes` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lectiedata`
--

INSERT INTO `lectiedata` (`lectieID`, `profID`, `lectieData`, `lectieGraf`, `lectieName`, `scor`, `nrVotes`) VALUES
(4, 11, 'Cel de-al doilea algoritm greedy pentru determinarea arborelui partial de cost minim al unui graf se datoreaza lui Prim (1957). In acest algoritm, la fiecare pas, multimea A de muchii alese impreuna cu multimea X a varfurilor pe care le conecteaza formeaza un arbore partial de cost minim pentru subgraful <X, A> al lui G. Initial, multimea W a varfurilor acestui arbore contine un singur varf oarecare din X, care va fi radacina, iar multimea A a muchiilor este vida. La fiecare pas, se alege o muchie de cost minim, care se adauga la arborele precedent, dand nastere unui nou arbore partial de cost minim (deci, exact una dintre extremitatile acestei muchii este un varf in arborele precedent). Arborele partial de cost minim creste “natural”, cu cate o ramura, pina cand va atinge toate varfurile din X, adica pina cand W = X.  La sfarsit, A va contine aceleasi muchii ca si in cazul algoritmului lui Kruskal.', '0\n8\n808 405 1 0 \n1198 278 1 1 \n1208 633 1 2 \n1272 496 1 3 \n1107 457 1 4 \n976 281 1 5 \n942 648 1 6 \n769 646 1 7 \n8\n0 6 \n6 5 \n5 1 \n1 4 \n4 2 \n3 2 \n7 0 \n7 6 \n', 'Algoritmul lui Prim', 4.13333, 15),
(5, 11, 'Arborii binari de cautare sunt structuri de date care suporta un set de operatii\r\n\r\ndinamice cum ar fi: cautare , succesor , predecesor , minim , maxim , inserare sau stergere.\r\n\r\nTimpul in care operatiile de baza ,intr-n arbore binar de cautare, sunt rezolvate ,este direct\r\n\r\nproportional cu adancimea arborelui.  Cazul cel mai defavorabil apare in momentul cand avem\r\n\r\nun arbore binar complet cu n noduri sau arborele este reprezentat printr-un lant de n noduri. In\r\n\r\naceste doua cazuri avem cel mai slab timp de executie a operatiilor destinate acestei structuri.\r\n\r\n                Un arbore binar de cautare , dupa cum sugereaza si numele, este organizat intr-un\r\n\r\narbore binar ca si in figura de mai jos. Asemenea arbore poate fi reprezentat ca si o structura de\r\n\r\ndate inlantuita in care fiecare nod este un obiect. Fiecare nod contine cate un camp care\r\n\r\nreprezinta adresa catre subarborele stang respectiv subarborele drept. Daca acest subarbore\r\n\r\nlipseste , campul se va referi la o variabila presetata NIL care arata absenta acestuia. ', '0\n6\n792 352 1 0 \n938 291 1 1 \n1161 344 1 2 \n1271 443 1 3 \n904 633 1 4 \n1144 686 1 5 \n6\n4 0 \n0 1 \n1 4 \n2 3 \n3 5 \n5 4 \n', 'Prim', 3.9, 20),
(2, 2, 'Algoritmul lui Dijkstra este o metoda de a stabili drumul de cost \r\nminim de la un nod de start la orice altul dintr-un graf. Numele e\r\nste dat de Edsger Dijkstra, savantul care l-a descoperit.Se creeaza o lsita cu distante, o lista cu nodul anterior, o lista cu nodurile vizitate si un nod curent. Toate valorile din lsita cu distante sunt initialzate cu o valoare infinita,  cu exceptia nodului de start, care este setat cu 0. toate valorile din lista cu distante sunt initializate cu o valoare infinita, cu exceptia nodului de start, care este setat cu 0. Toate valorile din lista cu nodurile vizitate sunt setate cu fals. Toate valorile din lista cu nodurile anterioare sunt initializate cu -1. Nodul de start este setat ca nodul curent. Se marcheaza ca vizitat nodul curent. Se actualizeaza distantele, pe care nodurilor care pot fi vizitate imediat din noudl curent. Se actualizeaza nodul curent la nodul nevizitat care poate fi vizitat prin calea cea mai scurta de la nodul de start. Se repeta pana cand taote nodurile sunt vizitate.', '1\n8\n825 393 1 0 \n1026 271 1 1 \n1229 394 1 2 \n1035 670 1 3 \n1029 523 1 4 \n839 637 1 5 \n1233 652 1 6 \n1107 439 0 7 \n9\n0 1 \n1 2 \n2 3 \n3 4 \n3 5 \n3 6 \n4 3 \n0 2 \n2 0 \n', 'Dijkstra', 4.42858, 14),
(3, 2, 'Pentru gasirea APM se pot folosi doi algoritmi.\r\nPrimul este algoritmul lui Kruskal, ce are complexitatea O(m log m), unde m e numarul de muchii, iar al doilea este algoritmul lui Prim, care are complexitatea de O(n^2), unde n e numarul de noduri. In functie de numarul de muchii vom alege un algoritm sau altul.\r\nDe exemplu, daca numarul de muchii este mic, vom prefera algoritmul lui Kruskal.\r\nDaca insa numarul de muchii e mare si numarul lor se apropie de n^2, atunci e de preferat sa folosim algoritmul lui Prim.\r\nPasul 1: Initial, fiecare nod va fi un arbore. Vom avea deci o padure de n arbori.\r\nApoi, se executa de n-1 ori pasul urmator:\r\nPasul 2: Se cauta muchia de cost minim care uneste noduri care apartin la doi arbori diferiti. Se selecteaza muchia respectiva.\r\nDupa selectarea a n-1 muchii, se obtine APM.', '0\n5\n786 392 1 0 \n1028 304 1 1 \n1230 365 1 2 \n822 625 1 3 \n1225 628 1 4 \n6\n0 3 \n3 4 \n4 1 \n2 4 \n0 4 \n1 0 \n', 'Kruskal', 3.76922, 13);

-- --------------------------------------------------------

--
-- Table structure for table `lectievotes`
--

CREATE TABLE `lectievotes` (
  `lectieID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `vot` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `temadata`
--

CREATE TABLE `temadata` (
  `temaID` int(11) NOT NULL,
  `profID` int(11) NOT NULL,
  `classID` int(11) DEFAULT NULL,
  `tema` text NOT NULL,
  `temaName` varchar(40) NOT NULL,
  `date` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `temadata`
--

INSERT INTO `temadata` (`temaID`, `profID`, `classID`, `tema`, `temaName`, `date`) VALUES
(1, 2, 0, 'Tema vacanta+++sf+++sf3+++sfFiind dat un graf neorientat cu 6 varfuri, care din sirurile de grade de mai jos este corect?+++sf3+++sf(3, 5, 4, 2, 0, 2)+++sf(2, 3, 2, 2, 4, 1)+++sf(2, 1, 2, 1, 2, 5)+++sf1+++sf+++sf3+++sfCare este numarul maxim de componente conexe ale unui graf neorientat cu 17 varfuri si 20 de muchii?+++sf1+++sf11+++sf+++sf1+++sfCate elemente conexe exista in graful alaturat?+++sf3+++sf1+++sf7+++sf943 352 1+++sf1206 537 1+++sf873 639 1+++sf1056 684 1+++sf869 502 1+++sf975 450 1+++sf1148 332 1+++sf6+++sf1 2 1+++sf2 3 1+++sf4 5 1+++sf7 6 1+++sf4 6 1+++sf7 4 1+++sf1+++sf2+++sf3+++sf1+++sf+++sf3+++sfCate grafuri orientate distincte cu 3 noduri exista?+++sf3+++sf65+++sf70+++sf64+++sf2+++sf+++sf1+++sfCare dintre urmatoarele siruri reprezinta un circuit?+++sf3+++sf2+++sf7+++sf889 580 1+++sf1095 489 1+++sf1283 602 1+++sf1290 360 1+++sf929 348 1+++sf1076 669 1+++sf782 371 1+++sf10+++sf1 2 1+++sf2 3 1+++sf3 6 1+++sf6 1 1+++sf5 4 1+++sf5 1 1+++sf3 2 1+++sf3 4 1+++sf1 7 1+++sf5 7 1+++sf5, 7, 1, 5+++sf1, 2, 3, 4, 5, 1+++sf3, 6, 1, 2, 3+++sf2+++sf+++sf', 'Tema vacanta', '2018-07-19'),
(2, 2, 0, 'Tema recapitulare test+++sf+++sf3+++sfIntr-un graf orientat cu 7 noduri suma gradelor interioare ale tuturor nodurilor este egala cu 10. Care este valoarea sumei gradelor exterioare ale tuturor nodurilor?+++sf1+++sf10+++sf+++sf1+++sfCare dintre urmatoarele arce trebuie adaugate grafului alaturat astfel incat in acest graf sa existe cel putin un drum intre oricare doua varfuri?+++sf3+++sf2+++sf5+++sf965 349 1+++sf1176 400 1+++sf1148 618 1+++sf1015 630 1+++sf849 497 1+++sf5+++sf1 2 1+++sf1 4 1+++sf2 3 1+++sf4 5 1+++sf5 1 1+++sf(3, 5)+++sf(4, 1)+++sf(5, 3)+++sf0+++sf+++sf3+++sfCare sunt nodurile care au exact 2 descendenti directi pentru un arbore cu radacina, cu 7 noduri, numerotate de la 1 la 7, dat de vectorul de tati (3, 3, 0, 1, 2, 2, 4)?+++sf3+++sf1, 2+++sf2, 3+++sf5, 4+++sf1+++sf+++sf3+++sfCare dintre urmatoarele proprietati este adevarata pentru un graf orientat cu n varfuri si n arce (n>3) care are un circuit de lungime n?+++sf3+++sfexista un varf cu gradul intern n-1+++sfpentru orice varf, gradul intern si extern sunt egale+++sfgradul intern al fiecarui varf este 2+++sf1+++sf+++sf1+++sfCare este suma gradelor externe ale tuturor varfurilor din graful alaturat?+++sf3+++sf2+++sf6+++sf846 344 1+++sf1234 356 1+++sf1256 596 1+++sf1102 543 1+++sf977 414 1+++sf874 640 1+++sf8+++sf1 2 1+++sf2 3 1+++sf3 4 1+++sf4 2 1+++sf3 6 1+++sf5 6 1+++sf4 5 1+++sf6 1 1+++sf8+++sf16+++sf10+++sf0+++sf+++sf', 'Tema recapitulare test', '2018-07-23'),
(3, 11, 2, 'Recapitulare teza+++sf+++sf3+++sfUn arbore cu 11 noduri este memorat cu ajutorul vectorului de tati (2, 5, 5, 3, 0, 2, 4, 6, 6, 2, 3). Multimea       \r\n  descendentilor lui 8 este:+++sf3+++sf{6, 2, 5}+++sf{1, 2, 5, 6, 10}+++sf{6}+++sf0+++sf+++sf3+++sfDaca G este un graf neorientat cu 8 noduri si 2 componente conexe, poate avea cel mult ... muchii.+++sf1+++sf21+++sf+++sf3+++sfDaca un arbore cu radacina cu 100 de noduri este notat cu T, atunci T poate avea mimim ... frunze.+++sf3+++sf1+++sf100+++sf101+++sf0+++sf+++sf1+++sfCare sunt nodurile de tip frunza din arborele alaturat daca se alege ca radacina nodul 6?+++sf3+++sf1+++sf6+++sf1004 464 1+++sf1139 536 1+++sf1136 363 1+++sf997 629 1+++sf935 350 1+++sf830 510 1+++sf5+++sf3 1 1+++sf1 4 1+++sf1 2 1+++sf1 6 1+++sf6 5 1+++sf2, 3, 4+++sf2, 3, 4, 5+++sf3, 4+++sf1+++sf+++sf1+++sfCare este numarul minim de muchii ce trebuie mutate  \r\n   in graful din figura a.i. acesta sa fie conex si fiecare   \r\n nod sa apartina unui ciclu?+++sf1+++sf1+++sf0+++sf0+++sf2+++sf+++sf', 'Recapitulare teza', '2018-07-09'),
(4, 11, 2, 'Tema august+++sf+++sf1+++sfCate elemente conexe are graful alaturat?+++sf1+++sf1+++sf10+++sf983 349 1+++sf1120 343 1+++sf1247 349 1+++sf1221 665 1+++sf977 579 1+++sf823 629 1+++sf804 343 1+++sf752 477 1+++sf1316 484 1+++sf947 692 1+++sf16+++sf1 2 1+++sf2 4 1+++sf4 9 1+++sf9 10 1+++sf4 1 1+++sf7 1 1+++sf7 10 1+++sf2 9 1+++sf5 6 1+++sf5 3 1+++sf7 8 0+++sf1 8 0+++sf5 8 1+++sf3 8 1+++sf4 7 1+++sf5 9 0+++sf2+++sf+++sf1+++sfCate drumuri exista de la nodul 1 la 4 in figura?+++sf3+++sf2+++sf5+++sf866 410 1+++sf1093 382 1+++sf1225 459 1+++sf1138 602 1+++sf968 587 1+++sf6+++sf1 2 1+++sf2 3 1+++sf3 4 1+++sf2 5 1+++sf2 4 1+++sf5 4 1+++sf1+++sf2+++sf3+++sf2+++sf+++sf3+++sfCate muchii are un graf complet cu 4 noduri?+++sf1+++sf6+++sf+++sf3+++sfCati descendenti directi nu poate avea un nod component unui arbore binar?+++sf3+++sf0+++sf2+++sf3+++sf2+++sf+++sf1+++sfGraful alaturat este un graf cu suma gradelor nodurilor \r\n   1, 2 si 3 egala cu ...+++sf3+++sf1+++sf5+++sf888 373 1+++sf1089 363 1+++sf1211 478 1+++sf1096 620 1+++sf908 548 1+++sf9+++sf1 2 1+++sf3 1 1+++sf3 4 1+++sf4 5 1+++sf5 2 1+++sf2 4 1+++sf3 2 1+++sf1 5 1+++sf5 3 1+++sf11+++sf22+++sf9+++sf0+++sf+++sf', 'Tema august', '2018-07-20'),
(5, 2, 0, 'Tema vacanta2+++sf+++sf3+++sfUn arbore cu 8 noduri si niciun varf izolat este neaparat un graf conex. (A/F)+++sf1+++sfF+++sf+++sf1+++sfVarfurile izolate din graful alaturat sunt:+++sf3+++sf1+++sf7+++sf893 386 1+++sf1035 359 1+++sf1172 394 1+++sf1159 502 1+++sf1099 591 1+++sf996 600 1+++sf892 538 1+++sf6+++sf1 2 1+++sf2 7 1+++sf7 1 1+++sf5 4 1+++sf4 2 1+++sf2 5 1+++sf3+++sf4, 5, 1, 2, 7+++sf3, 6+++sf2+++sf+++sf1+++sfNu exista niciun drum de la orice nod la nodul 1. (A/F)+++sf1+++sf2+++sf7+++sf868 376 1+++sf1050 381 1+++sf1159 438 1+++sf1180 584 1+++sf1078 668 1+++sf963 646 1+++sf847 543 1+++sf8+++sf1 2 1+++sf2 3 1+++sf3 4 1+++sf4 5 1+++sf5 6 1+++sf6 7 1+++sf7 2 1+++sf6 2 1+++sfA+++sf+++sf1+++sfGraful alaturat nu este:+++sf3+++sf1+++sf9+++sf1008 349 1+++sf1143 492 1+++sf863 472 1+++sf877 621 1+++sf973 618 1+++sf1103 617 1+++sf1226 616 1+++sf766 612 1+++sf998 476 1+++sf8+++sf1 3 1+++sf1 2 1+++sf3 8 1+++sf3 4 1+++sf3 5 1+++sf2 6 1+++sf2 7 1+++sf1 9 1+++sfun arbore binar+++sfun arbore cu radacina+++sfun graf neorientat+++sf0+++sf+++sf1+++sfUn circuit ce contine nodul 6 este:+++sf3+++sf2+++sf9+++sf1047 340 1+++sf1205 360 1+++sf1254 510 1+++sf1170 633 1+++sf1008 655 1+++sf861 599 1+++sf901 347 1+++sf786 447 1+++sf1131 469 1+++sf11+++sf1 9 1+++sf9 2 1+++sf3 2 1+++sf4 9 1+++sf6 5 1+++sf6 9 1+++sf8 6 1+++sf7 1 1+++sf7 8 1+++sf7 6 1+++sf9 7 1+++sf8, 6, 9, 7, 8+++sf8, 6, 9, 1, 7, 8+++sf8, 6, 9, 7+++sf0+++sf+++sf', 'Tema vacanta2', '2018-07-08'),
(6, 2, 1, 'Tema recapitulativa de vacanta+++sf+++sf1+++sfDandu-se graful alaturat care sunt nodurile care au gradul interior egal cu gradul exterior?+++sf3+++sf2+++sf6+++sf782 378 1+++sf984 375 1+++sf1258 628 1+++sf770 635 1+++sf1108 566 1+++sf1203 347 1+++sf10+++sf1 2 1+++sf3 4 1+++sf1 4 1+++sf4 1 1+++sf5 6 1+++sf5 3 1+++sf6 3 1+++sf3 6 1+++sf5 4 1+++sf6 2 1+++sf2+++sf1+++sfniciunul+++sf0+++sf+++sf1+++sfCe tip de graf este cel reprezentat alaturi? (Te poti ajuta de functia MOVE)+++sf1+++sf1+++sf6+++sf820 362 1+++sf902 484 1+++sf815 623 1+++sf1180 358 1+++sf1075 479 1+++sf1196 626 1+++sf4+++sf1 5 1+++sf2 4 1+++sf2 6 1+++sf5 3 1+++sfBipartit+++sf+++sf3+++sfCare este numarul minim de muchii ale unui graf neorientat cu 24 de varfuri astfel incat acesta sa fie conex indiferent de dispunerea muchiilor?+++sf3+++sf254+++sf276+++sf253+++sf0+++sf+++sf1+++sfCate drumuri exista de la nodul 1 la nodul 4?+++sf3+++sf2+++sf5+++sf837 376 1+++sf825 599 1+++sf1164 371 1+++sf1157 601 1+++sf1003 461 1+++sf8+++sf1 5 1+++sf2 5 1+++sf4 3 1+++sf4 5 1+++sf1 3 1+++sf5 2 1+++sf3 5 1+++sf2 4 1+++sf1+++sf2+++sf3+++sf1+++sf+++sf1+++sfCate componente conexe exista in graful alaturat?+++sf1+++sf1+++sf8+++sf769 398 1+++sf848 633 1+++sf1191 602 1+++sf1279 372 1+++sf1009 495 1+++sf899 367 1+++sf1142 359 1+++sf1017 711 1+++sf6+++sf1 2 1+++sf3 2 1+++sf5 2 1+++sf3 5 1+++sf3 4 1+++sf6 7 1+++sf3+++sf+++sf', 'Tema recapitulativa de vacanta', '2018-07-30'),
(7, 11, 0, 'Tema weekend1+++sf+++sf1+++sfSe considera un arbore cu 6 noduri. Scrieti toate           \r\n  nodurile care pot fi alese ca radacina a arborelui a.i.    \r\n acesta sa aiba un numar maxim de frunze.+++sf3+++sf1+++sf6+++sf904 374 1+++sf1004 494 1+++sf1107 620 1+++sf843 583 1+++sf1185 478 1+++sf1134 395 1+++sf5+++sf1 2 1+++sf1 6 1+++sf2 3 1+++sf2 4 1+++sf2 5 1+++sf1, 2+++sf1+++sf2, 3, 4+++sf0+++sf+++sf3+++sfCate noduri are un graf complet cu 28 de muchii?+++sf1+++sf8+++sf+++sf3+++sfSe considera vectorul de tati al unui arbore cu radacina (3, 4, 0, 3, 3, 5). Afirmatia corecta este:+++sf3+++sfnodul 6 este tatal lui 5+++sfnodurile 1, 2, 6 sunt frunze+++sfnodurile 4 si 6 sunt frunze+++sf1+++sf+++sf1+++sfCate dintre nodurile din figura au gradul par?+++sf1+++sf1+++sf5+++sf959 357 1+++sf1127 380 1+++sf1189 517 1+++sf1051 619 1+++sf910 518 1+++sf7+++sf1 2 1+++sf1 5 1+++sf2 3 1+++sf2 4 1+++sf3 4 1+++sf3 5 1+++sf4 5 1+++sf1+++sf+++sf3+++sfPentru un arbore cu vectorul de tati (4, 8, 8, 0, 10, 4, 8, 6, 2, 6), care sunr frunzele sale?+++sf3+++sf1, 3, 5, 9+++sf2, 4, 6, 8, 10+++sf1, 3, 5, 7, 9+++sf2+++sf+++sf', 'Tema weekend1', '2018-07-24'),
(15, 2, 1, 'Tema XII M1+++sf+++sf1+++sfCare este lungimea celui mai scurt lant de la nodul 1 la nodul 4?+++sf1+++sf1+++sf6+++sf871 398 1+++sf1051 685 1+++sf1066 344 1+++sf899 592 1+++sf1216 697 1+++sf1296 586 1+++sf5+++sf1 6 1+++sf6 4 1+++sf2 1 1+++sf2 3 1+++sf3 5 1+++sf2+++sf+++sf3+++sfCare este numarul minim de muchii ale unui graf neorientat cu 24 de varfuri a.i. acesta sa fie conex indiferent de dispunerea muchiilor+++sf3+++sf253+++sf254+++sf273+++sf1+++sf+++sf1+++sfIn graful alaturat orientat, cate noduri au graful interior egal cu gradul exterior?+++sf1+++sf2+++sf6+++sf791 351 1+++sf1090 366 1+++sf1253 495 1+++sf1260 675 1+++sf956 634 1+++sf777 577 1+++sf10+++sf1 5 1+++sf1 6 1+++sf2 1 1+++sf2 3 1+++sf3 1 1+++sf3 4 1+++sf4 3 1+++sf4 5 1+++sf5 4 1+++sf6 5 1+++sf4+++sf+++sf3+++sfFie arborele cu radacina cu 9 noduri. Care este vecoturl de tati al acestui arbore stiind ca nodurile 1-8 au exact cate un descendent direct?+++sf3+++sf(1, 2, 3, 4, 5, 6, 7, 8, 9)+++sf(0, 1, 2, 3, 4, 5, 6, 7, 8)+++sf(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)+++sf1+++sf+++sf3+++sfSe considera arborele cu 12 noduri cu vectorul de tati (4, 8, 0, 3, 10, 1, 8, 3, 2, 4, 7, 10). Care din nodurile arborelui au exact un descendent direct?+++sf3+++sf1, 2, 7+++sf2, 7, 10+++sf1, 7+++sf0+++sf+++sf', 'Tema XII M1', '2018-07-31'),
(14, 2, 0, 'Tema weekend2+++sf+++sf1+++sfCe tip de graf este alaturi?+++sf1+++sf1+++sf5+++sf863 374 1+++sf853 578 1+++sf1164 354 1+++sf1167 497 1+++sf1171 664 1+++sf4+++sf1 4 1+++sf1 5 1+++sf2 3 1+++sf2 5 1+++sfBipartit+++sf+++sf1+++sfCate noduri au gradul interior egal cu cel exterior?+++sf3+++sf2+++sf6+++sf774 384 1+++sf760 668 1+++sf1145 387 1+++sf975 516 1+++sf1140 685 1+++sf1276 520 1+++sf8+++sf2 1 1+++sf1 3 1+++sf3 4 1+++sf5 4 1+++sf4 6 1+++sf4 2 1+++sf2 4 1+++sf5 2 1+++sf1+++sf2+++sf3+++sf2+++sf+++sf1+++sfCate drumuri exista din nodul 1 in nodul 4?+++sf1+++sf2+++sf5+++sf847 398 1+++sf820 591 1+++sf1170 359 1+++sf1205 607 1+++sf1040 502 1+++sf7+++sf1 5 1+++sf5 3 1+++sf3 4 1+++sf1 3 1+++sf4 5 1+++sf2 1 1+++sf2 5 1+++sf2+++sf+++sf3+++sfFie un graf cu 12 varfuri si 5 componente conexe. Care este numarul maxim de muchii pe care il poate avea graful?+++sf3+++sf28+++sf34+++sf21+++sf0+++sf+++sf3+++sfNumarul maxim de arbori cu n varfuri ce se pot construi este:+++sf1+++sfn^(n-2)+++sf+++sf', 'Tema weekend2', '2018-07-31');

-- --------------------------------------------------------

--
-- Table structure for table `temascores`
--

CREATE TABLE `temascores` (
  `temaID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `temascores`
--

INSERT INTO `temascores` (`temaID`, `userID`, `score`, `date`) VALUES
(1, 1, 9, '2018-07-23'),
(1, 3, 7, '2018-07-19'),
(2, 1, 8, '2018-07-23'),
(2, 7, 10, '2018-07-24'),
(4, 6, 7, '2018-07-15'),
(4, 5, 8, '2018-07-10'),
(15, 1, 10, '2018-07-31');

-- --------------------------------------------------------

--
-- Table structure for table `testdata`
--

CREATE TABLE `testdata` (
  `testID` int(11) NOT NULL,
  `profID` int(11) NOT NULL,
  `classID` int(11) DEFAULT NULL,
  `test` text NOT NULL,
  `testName` varchar(50) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `testdata`
--

INSERT INTO `testdata` (`testID`, `profID`, `classID`, `test`, `testName`, `date`) VALUES
(1, 2, 1, 'Test initial+++sfCate muchii are un graf cu suma gradelor 20?+++sf20+++sf10+++sf21+++sf1+++sf+++sfCate muchii are un graf complet cu 7 noduri?+++sf20+++sf25+++sf28+++sf2+++sf+++sfCare este gradul interior maxim al unui nod inclus intr-un graf orientat cu 8 noduri?+++sf8+++sf16+++sf7+++sf2+++sf+++sfSuma gradelor unui graf ?neorientat ?este egala cu:+++sf?dublul numarului ?de muchii din graf+++sf?numarul de noduri din graf+++sf?numarul de noduri * numarul de muchii+++sf0+++sf+++sfUn graf cu 7 noduri poate sa aiba maxim ... elemente conexe.+++sf1+++sf3+++sf7+++sf2+++sf+++sfUn arbore cu 8 noduri poate sa aiba maxim ... frunze.+++sf1+++sf8+++sf7+++sf2+++sf+++sf?Un lant format din 4 noduri are lungimea ...+++sf4+++sf3+++sf2+++sf1+++sf+++sfIn vectorul de muchii v al unui graf, muchia cu capetele v[i].x si v[i].y reprezinta ...+++sfmuchia de pe pozitia n-i+++sfnu reprezinta nimic+++sfmuchia de pe pozitia i+++sf2+++sf+++sfGradul interior al unui graf orientat reprezinta (d-(x)):?+++sf?numarul de arce? care au ?ca extre?mitate initiala pe x+++sfnumarul de arce care au ca extremitate finala pe x+++sfnumarul de arce legate cu x+++sf1+++sf+++sfCare dintre siruri nu este un ciclu elementar?+++sf[1, 2, 3, 4, 1]+++sf[2, 3, 4, 2]+++sf[4, 5, 6, 2, 4, 5, 2]??+++sf2+++sf+++sf', 'Test initial', '2018-07-18'),
(2, 2, 1, 'Teza sem 1+++sfCate muchii are un graf complet neorientat cu 5 noduri?+++sf20+++sf10+++sf15+++sf1+++sf+++sfCe afirmatie este adevarata? (grafuri orientate)+++sfsuma gradelor tuturor nodurilor este egala cu dublul numarului de arce+++sfsuma gradelor interioare tuturor nodurilor este egala cu dublul numarului de arce+++sfsuma gradelor exterioare tuturor nodurilor este egala cu dublul numarului de arce+++sf0+++sf+++sfCare este numarul mimim? de noduri pe care ?????????il poate avea un graf neorientat??????? cu 30 de muchii?+++sf8+++sf9+++sf10+++sf1+++sf+++sfUn nod intr-un grad orientat are gradul interior 4. Ce afirmatie este adevarata intotdeauna?+++sfnodul reprezinta extremitate initiala pentru 4 arce+++sfnodul reprezinta extremitate finala pentru 4 arce+++sfnodul este legal la 4 arce+++sf1+++sf+++sfCe este un graf partial al lui G?+++sfun graf care contine toate nodurile si muchiile lui G si caruia i se mai adauga alte muchii+++sfun graf care a fost construit prin eliminarea de noduri din graful G+++sfun graf care a fost construit prin eliminarea unor muchii si pastrarea tuturor varfurilor din graful G+++sf2+++sf+++sfCare nu este o proprietate a unui subgraf al lui G? +++sfse pastreaza toate muchiile lui G care sunt legate la varfurile pastrate+++sfse elimina muchii din graful G+++sfse adauga noduri la graful G+++sf0+++sf+++sfCate grafuri neorientate cu 3 noduri se pot forma?+++sf6+++sf5+++sf7+++sf1+++sf+++sfMatricea de adiacenta a unui graf neorientat este:+++sfsimetrica fata de diagonala principala+++sfsimetrica fata de diagonala secundara+++sfasimetrica+++sf0+++sf+++sfSuma elementelor de pe linia i a matricei de adiacenta a unui graf neorientat reprezina:+++sfnumarul de muchii din graf+++sfdublul numarului de muchii legate de nodul i+++sfnumarul de muchii legate de nodul i+++sf2+++sf+++sfCate noduri are un graf complet neorientat cu 45 de muchii?+++sf5+++sf10+++sf9+++sf1+++sf+++sf', 'Teza sem 1', '2018-07-30'),
(4, 2, 1, 'Test teorie+++sfNumarul? totalde grafuri ?turneu? cu n varfuri este:+++sf???3^(?n*(n-1)?/2)+++sf?2*?(n*?(n-1)?/2)?+++sf?2^(n*?(n-1))+++sf1+++sf+++sfNumarul maxim de ?muchii ???intr-un graf ?neorientat cu ?n varfuri ?este:+++sf??n*(n-1?)/2+++sf?n-1+++sfn*(n+1)/2+++sf0+++sf+++sf???Intr-un graf ?neorientat 	?cu n varfuri (n>=3) ?fiecare nod are gradul 2. ?Care este numarul maxim de	?? componente \nconexe ?din care ?poate fi alcatuit ?graful.+++sf?n+++sf2+++sf[n/3]+++sf2+++sf+++sfFie un graf cu ?12 varfuri ?si 5 elemente conexe. ?Care este numarul maxim ?de muchii ?pe care le poate avea ?        \n graful?+++sf??132+++sf28+++sf?21+++sf1+++sf+++sfCate grafuri neorientate si complete ?cu n varfuri exista?+++sf1+++sf?n+++sf?n*(n-1)?/2+++sf0+++sf+++sfUn graf ?conex ??are toate varfurile cu grad par. ?Acesta este un:+++sf?arbore+++sf?bipartit+++sf?eulerian+++sf2+++sf+++sf?Cate grafuri orientate cu ?n varfuri exista?+++sf?n??*(n-1)+++sf?2^(n?*(n-1))+++sf?2*(?n*(n+1))+++sf1+++sf+++sfNumarul de grafuri partiale ?obtinute dintr-un graf cu m muchii este:?+++sf??2^m?+++sf?2^m-1?+++sf?2^(m-1)+++sf0+++sf+++sf?Numarul maxim de arce ?intr-un graf? orientat ?cu n varfuri ?este:+++sf?n*(n-1)/2+++sf?n*(n+1)+++sfn*(n-1)/2?+++sf2+++sf+++sfCate muchii are un graf neorientat cu n varfuri?+++sfn*(n-1)/2+++sfn*(n+1)/2+++sfn*(n-1)+++sf0+++sf+++sf', 'Test teorie', '2018-07-30'),
(5, 2, 1, 'Test 12M3+++sfNumarul maxim de muchii intr-un graf cu n varfuri si p componente conexe (p<n) este:+++sfn*p+++sfn-p+1+++sfcomb(n,2)-p+1+++sf2+++sf+++sfNumarul total de grafuri turneu cu n varfuri este:?+++sf3^n+++sf2^(n*(n-1)/2)+++sf2^(n*(n-1))+++sf1+++sf+++sfCate grafuri orientate cu n varfuri exista?+++sf2^(n*n-1)+++sf3^n+++sf2^(n*(n-1))+++sf2+++sf+++sfUn graf complet hamiltonian si eulerian:+++sfpoate avea 3 varfuri+++sfpoate avea oricate varfuri+++sfnu exista+++sf0+++sf+++sfNumarul maxim de arbori cu n varfuri ce se pot construi este:+++sfn^n+++sfn^n-1+++sfn^(n-2)+++sf2+++sf+++sfNumarul maxim de arce intr-un graf orientat cu n varfuri este:+++sfn*(n-1)+++sfn*n+++sf2^n+++sf0+++sf+++sfNumarul maxim de muchii intr-un graf neorientat cu n varfuri este:+++sfn*n+++sfn*(n-1)/2+++sf2^n+++sf1+++sf+++sfCate grafuri neorientate si complete cu n varfuri exista?+++sf1+++sfn+++sf2^n+++sf0+++sf+++sfNumarul total de subgrafuri obtinute dintr-un graf cu n varfuri este:+++sf2^n+++sf2^(n-1)+++sf2^n-1+++sf2+++sf+++sfDaca toate varfurile unui graf conex sunt de grad par atunci este:+++sfhamiltonian+++sfeulerian+++sfbipartit+++sf1+++sf+++sf', 'Test 12M3', '2018-07-30');

-- --------------------------------------------------------

--
-- Table structure for table `testscores`
--

CREATE TABLE `testscores` (
  `testID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `score` int(3) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` int(10) NOT NULL,
  `name` varchar(15) NOT NULL,
  `surname` varchar(15) NOT NULL,
  `nickname` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL,
  `pass` varchar(70) NOT NULL,
  `isProfessor` tinyint(1) NOT NULL DEFAULT '0',
  `classID` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `name`, `surname`, `nickname`, `email`, `pass`, `isProfessor`, `classID`) VALUES
(1, 'Teodor', 'Virghileanu', 'KemyKo', 'teo.virghi@yahoo.ro', '$2a$10$k0KWpBmffOceZZIXvzGSf.NWzKkMfQT28koPlpinzXokYBYYwrufS', 0, 1),
(2, 'Lincan', 'Iulia', 'iulialincan', 'tedali@yahoo.com', '$2a$10$Xvi12icA1piZkUy6IEa8Guliya9dBMrQsWApdIcfZI/qqBh.wTizC', 1, 1),
(3, 'Olteanu', 'Catalina', 'catalina200029', 'catalina200029@yahoo.com', '$2a$10$Qto/Ya2WABPq7jw2UTdbteVx.Nr1/DsPOwK8LAR6nOGenD3tyHmPm', 0, 1),
(4, 'Marius', 'Marinel', 'Marcel', 'marinel@yahoo.com', '$2a$10$fVx2SE/PDkppYGPHZLXKieWc6kHfNU8zQUoVLFHnPJToGt6qWMCKC', 0, 1),
(5, 'Stan', 'Razvan', 'razvan', 'stanel@yahoo.ro', '$2a$10$Zvm4BcTbz5azQ4lq0YrenOaQX1Qdy7qFyvxp6Tmxnt6Q3NhleV5eG', 0, 2),
(6, 'Eduard', 'Stoicul', 'Eddyy', 'stoicy@gmail.ro', '$2a$10$Gzdo1im58i2PTj5c1Xqusue/RJww.5ccPuJ/z32EAMqvNg/u5TTGm', 0, 2),
(7, 'Andrei', 'Parvulescu', 'Magician', 'mag@gmail.com', '$2a$10$uyXcVwhD4zSUThNfVSPIK.mWM5gIdSvBoAXkWa/VmsJ9fgKGBRT4a', 0, 1),
(8, 'Timmy', 'Barbos', 'KimTim', 'barby@yahoo.ro', '$2a$10$KybHQUdmHYr5mhH6.Eq7B.hwcavdLY8hmrOSSHdLAmQGtckThqb5W', 0, 2),
(9, 'Ionela', 'Biscuit', 'Magurel', 'bicky123@index.ro', '$2a$10$nHgZfcY8mvcb4dSIw7CGleRjzAgJ1.apvgF5UV9uk2YgEOzmXpi82', 0, 2),
(10, 'Ana', 'Mirabela', 'Grijan', 'emailus.ro', '$2a$10$ZYnEyfe3WByYHfN/08OQuO3c3diOAWyI1phY5f1O2EWkw/aRfgRcG', 0, 1),
(11, 'Radu', 'Canu', 'Radulet', 'kanuradu@yahoo.ro', '$2a$10$6yhOuG5qVKtOycP9oiz2f.gtbu2p5aTa.m.vf53l/GKiNGmfJf6Wu', 1, 2),
(12, 'Marian', 'Andrei', 'Marianul', 'faggot@yahoo.ro', '$2a$10$YCVDEhdvMwiwRc0LOiJt5upFhdyFFUDhtuTtynHLRz0ENQdgXILfK', 1, 1),
(13, 'Androne', 'Vlad', 'grabogne', 'garr@yahoo.ro', '$2a$10$Xhn1/WMrnS85YVO1dD1/XO9pwpM7NLEjWN1h4CxyTMPm2ZTPW51ja', 0, 1),
(14, 'Raut', 'Ana-Maria', 'Sindy', 'sindd@gmail.com', '$2a$10$sIUCAHdTnAZXTOOJqsVoN.veB0p7jqQkGzj547P0DK7eFpswiO2zK', 1, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`classID`);

--
-- Indexes for table `comentarii`
--
ALTER TABLE `comentarii`
  ADD PRIMARY KEY (`commID`);

--
-- Indexes for table `gamescores`
--
ALTER TABLE `gamescores`
  ADD PRIMARY KEY (`gameID`,`userID`);

--
-- Indexes for table `lectiedata`
--
ALTER TABLE `lectiedata`
  ADD PRIMARY KEY (`lectieID`);

--
-- Indexes for table `lectievotes`
--
ALTER TABLE `lectievotes`
  ADD PRIMARY KEY (`lectieID`,`userID`);

--
-- Indexes for table `temadata`
--
ALTER TABLE `temadata`
  ADD PRIMARY KEY (`temaID`);

--
-- Indexes for table `temascores`
--
ALTER TABLE `temascores`
  ADD PRIMARY KEY (`temaID`,`userID`);

--
-- Indexes for table `testdata`
--
ALTER TABLE `testdata`
  ADD PRIMARY KEY (`testID`);

--
-- Indexes for table `testscores`
--
ALTER TABLE `testscores`
  ADD PRIMARY KEY (`testID`,`userID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `classID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `comentarii`
--
ALTER TABLE `comentarii`
  MODIFY `commID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lectiedata`
--
ALTER TABLE `lectiedata`
  MODIFY `lectieID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `temadata`
--
ALTER TABLE `temadata`
  MODIFY `temaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `testdata`
--
ALTER TABLE `testdata`
  MODIFY `testID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
