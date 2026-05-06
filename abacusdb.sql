-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 30, 2026 at 05:25 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `abacusdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `accessorio`
--

CREATE TABLE `accessorio` (
  `CodiceArticolo` int(11) NOT NULL,
  `Descrizione` varchar(255) DEFAULT NULL,
  `CostoUnitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `accessorio`
--

INSERT INTO `accessorio` (`CodiceArticolo`, `Descrizione`, `CostoUnitario`) VALUES
(3, 'Cerchi', 25.00),
(4, 'Imbuto', 10.00);

-- --------------------------------------------------------

--
-- Table structure for table `autoveicolo`
--

CREATE TABLE `autoveicolo` (
  `Targa` varchar(10) NOT NULL,
  `Ntelaio` varchar(50) NOT NULL,
  `Descrizione` varchar(255) DEFAULT NULL,
  `Annocostruzione` int(11) DEFAULT NULL,
  `CodiceCliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cliente`
--

CREATE TABLE `cliente` (
  `Codice` int(11) NOT NULL,
  `Nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `password` varchar(40) NOT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Mail` varchar(50) DEFAULT NULL,
  `CodiceOTP` varchar(256) DEFAULT NULL,
  `ScadenzaOTP` date DEFAULT NULL,
  `Status` tinyint(1) DEFAULT NULL,
  `Ruolo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `cliente`
--

INSERT INTO `cliente` (`Codice`, `Nome`, `cognome`, `password`, `Telefono`, `Mail`, `CodiceOTP`, `ScadenzaOTP`, `Status`, `Ruolo`) VALUES
(13, 'Admin', 'Supremo', 'admin123', '3331234567', 'admin@abacus.it', 'VERIFICATO-MANUALMENTE', '2030-12-31', 1, 'admin'),
(15, 'Fabio', 'Beccalli', '123', '3342122559', 'beccalli.fabio4@gmail.com', 'd362f58f-206b-402e-9bef-38e82b07fa45', '2026-04-23', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `dipendente`
--

CREATE TABLE `dipendente` (
  `User` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `intervento`
--

CREATE TABLE `intervento` (
  `Codice` int(11) NOT NULL,
  `Data` date NOT NULL,
  `CodiceOfficina` int(11) NOT NULL,
  `TargaAutoveicolo` varchar(10) NOT NULL,
  `CodiceCliente` int(11) NOT NULL,
  `CodiceTipoIntervento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `intervento_accessorio`
--

CREATE TABLE `intervento_accessorio` (
  `CodiceIntervento` int(11) NOT NULL,
  `CodiceArticolo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `intervento_pezzo`
--

CREATE TABLE `intervento_pezzo` (
  `CodiceIntervento` int(11) NOT NULL,
  `CodicePezzo` int(11) NOT NULL,
  `Quantita` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `intervento_servizio`
--

CREATE TABLE `intervento_servizio` (
  `CodiceIntervento` int(11) NOT NULL,
  `CodiceServizio` int(11) NOT NULL,
  `Ore` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `officina`
--

CREATE TABLE `officina` (
  `Codice` int(11) NOT NULL,
  `Denominazione` varchar(100) NOT NULL,
  `Indirizzo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `officina`
--

INSERT INTO `officina` (`Codice`, `Denominazione`, `Indirizzo`) VALUES
(1, 'AutoExpert Milano', 'Via Roma 10, Milano'),
(2, 'Meccanica Veloce Torino', 'Corso Italia 55, Torino'),
(3, 'Officina del Borgo Bologna', 'Piazza Dante 2, Bologna');

-- --------------------------------------------------------

--
-- Table structure for table `officina_accessorio`
--

CREATE TABLE `officina_accessorio` (
  `CodiceOfficina` int(11) NOT NULL,
  `CodiceArticolo` int(11) NOT NULL,
  `Quantita` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `officina_accessorio`
--

INSERT INTO `officina_accessorio` (`CodiceOfficina`, `CodiceArticolo`, `Quantita`) VALUES
(1, 3, 10),
(2, 4, 10);

-- --------------------------------------------------------

--
-- Table structure for table `officina_pezzo`
--

CREATE TABLE `officina_pezzo` (
  `CodiceOfficina` int(11) NOT NULL,
  `CodicePezzo` int(11) NOT NULL,
  `Quantita` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `officina_servizio`
--

CREATE TABLE `officina_servizio` (
  `CodiceOfficina` int(11) NOT NULL,
  `CodiceServizio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `officina_servizio`
--

INSERT INTO `officina_servizio` (`CodiceOfficina`, `CodiceServizio`) VALUES
(1, 10),
(1, 12),
(2, 11);

-- --------------------------------------------------------

--
-- Table structure for table `pezzo_ricambio`
--

CREATE TABLE `pezzo_ricambio` (
  `CodicePezzo` int(11) NOT NULL,
  `Descrizione` varchar(255) DEFAULT NULL,
  `CostoUnitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `pezzo_ricambio`
--

INSERT INTO `pezzo_ricambio` (`CodicePezzo`, `Descrizione`, `CostoUnitario`) VALUES
(1, 'Gomme', 50.00),
(2, 'Olio', 25.00);

-- --------------------------------------------------------

--
-- Table structure for table `servizio`
--

CREATE TABLE `servizio` (
  `Codice` int(11) NOT NULL,
  `CostoOrario` decimal(10,2) NOT NULL,
  `Descrizione` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `servizio`
--

INSERT INTO `servizio` (`Codice`, `CostoOrario`, `Descrizione`) VALUES
(10, 100.00, 'Cambio Gomme'),
(11, 70.00, 'Cambio Olio'),
(12, 1.00, 'ciao');

-- --------------------------------------------------------

--
-- Table structure for table `tipo_intervento`
--

CREATE TABLE `tipo_intervento` (
  `Codice` int(11) NOT NULL,
  `Descrizione` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accessorio`
--
ALTER TABLE `accessorio`
  ADD PRIMARY KEY (`CodiceArticolo`);

--
-- Indexes for table `autoveicolo`
--
ALTER TABLE `autoveicolo`
  ADD PRIMARY KEY (`Targa`),
  ADD UNIQUE KEY `Ntelaio` (`Ntelaio`),
  ADD KEY `CodiceCliente` (`CodiceCliente`);

--
-- Indexes for table `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`Codice`);

--
-- Indexes for table `dipendente`
--
ALTER TABLE `dipendente`
  ADD PRIMARY KEY (`User`);

--
-- Indexes for table `intervento`
--
ALTER TABLE `intervento`
  ADD PRIMARY KEY (`Codice`),
  ADD KEY `CodiceOfficina` (`CodiceOfficina`),
  ADD KEY `TargaAutoveicolo` (`TargaAutoveicolo`),
  ADD KEY `CodiceCliente` (`CodiceCliente`),
  ADD KEY `CodiceTipoIntervento` (`CodiceTipoIntervento`);

--
-- Indexes for table `intervento_accessorio`
--
ALTER TABLE `intervento_accessorio`
  ADD PRIMARY KEY (`CodiceIntervento`,`CodiceArticolo`),
  ADD KEY `CodiceArticolo` (`CodiceArticolo`);

--
-- Indexes for table `intervento_pezzo`
--
ALTER TABLE `intervento_pezzo`
  ADD PRIMARY KEY (`CodiceIntervento`,`CodicePezzo`),
  ADD KEY `CodicePezzo` (`CodicePezzo`);

--
-- Indexes for table `intervento_servizio`
--
ALTER TABLE `intervento_servizio`
  ADD PRIMARY KEY (`CodiceIntervento`,`CodiceServizio`),
  ADD KEY `CodiceServizio` (`CodiceServizio`);

--
-- Indexes for table `officina`
--
ALTER TABLE `officina`
  ADD PRIMARY KEY (`Codice`);

--
-- Indexes for table `officina_accessorio`
--
ALTER TABLE `officina_accessorio`
  ADD PRIMARY KEY (`CodiceOfficina`,`CodiceArticolo`),
  ADD KEY `CodiceArticolo` (`CodiceArticolo`);

--
-- Indexes for table `officina_pezzo`
--
ALTER TABLE `officina_pezzo`
  ADD PRIMARY KEY (`CodiceOfficina`,`CodicePezzo`),
  ADD KEY `CodicePezzo` (`CodicePezzo`);

--
-- Indexes for table `officina_servizio`
--
ALTER TABLE `officina_servizio`
  ADD PRIMARY KEY (`CodiceOfficina`,`CodiceServizio`),
  ADD KEY `CodiceServizio` (`CodiceServizio`);

--
-- Indexes for table `pezzo_ricambio`
--
ALTER TABLE `pezzo_ricambio`
  ADD PRIMARY KEY (`CodicePezzo`);

--
-- Indexes for table `servizio`
--
ALTER TABLE `servizio`
  ADD PRIMARY KEY (`Codice`);

--
-- Indexes for table `tipo_intervento`
--
ALTER TABLE `tipo_intervento`
  ADD PRIMARY KEY (`Codice`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accessorio`
--
ALTER TABLE `accessorio`
  MODIFY `CodiceArticolo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cliente`
--
ALTER TABLE `cliente`
  MODIFY `Codice` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `intervento`
--
ALTER TABLE `intervento`
  MODIFY `Codice` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `officina`
--
ALTER TABLE `officina`
  MODIFY `Codice` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `officina_pezzo`
--
ALTER TABLE `officina_pezzo`
  MODIFY `CodiceOfficina` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pezzo_ricambio`
--
ALTER TABLE `pezzo_ricambio`
  MODIFY `CodicePezzo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `servizio`
--
ALTER TABLE `servizio`
  MODIFY `Codice` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `autoveicolo`
--
ALTER TABLE `autoveicolo`
  ADD CONSTRAINT `autoveicolo_ibfk_1` FOREIGN KEY (`CodiceCliente`) REFERENCES `cliente` (`Codice`);

--
-- Constraints for table `intervento`
--
ALTER TABLE `intervento`
  ADD CONSTRAINT `intervento_ibfk_1` FOREIGN KEY (`CodiceOfficina`) REFERENCES `officina` (`Codice`),
  ADD CONSTRAINT `intervento_ibfk_2` FOREIGN KEY (`TargaAutoveicolo`) REFERENCES `autoveicolo` (`Targa`),
  ADD CONSTRAINT `intervento_ibfk_3` FOREIGN KEY (`CodiceCliente`) REFERENCES `cliente` (`Codice`),
  ADD CONSTRAINT `intervento_ibfk_4` FOREIGN KEY (`CodiceTipoIntervento`) REFERENCES `tipo_intervento` (`Codice`);

--
-- Constraints for table `intervento_accessorio`
--
ALTER TABLE `intervento_accessorio`
  ADD CONSTRAINT `intervento_accessorio_ibfk_1` FOREIGN KEY (`CodiceIntervento`) REFERENCES `intervento` (`Codice`),
  ADD CONSTRAINT `intervento_accessorio_ibfk_2` FOREIGN KEY (`CodiceArticolo`) REFERENCES `accessorio` (`CodiceArticolo`);

--
-- Constraints for table `intervento_pezzo`
--
ALTER TABLE `intervento_pezzo`
  ADD CONSTRAINT `intervento_pezzo_ibfk_1` FOREIGN KEY (`CodiceIntervento`) REFERENCES `intervento` (`Codice`),
  ADD CONSTRAINT `intervento_pezzo_ibfk_2` FOREIGN KEY (`CodicePezzo`) REFERENCES `pezzo_ricambio` (`CodicePezzo`);

--
-- Constraints for table `intervento_servizio`
--
ALTER TABLE `intervento_servizio`
  ADD CONSTRAINT `intervento_servizio_ibfk_1` FOREIGN KEY (`CodiceIntervento`) REFERENCES `intervento` (`Codice`),
  ADD CONSTRAINT `intervento_servizio_ibfk_2` FOREIGN KEY (`CodiceServizio`) REFERENCES `servizio` (`Codice`);

--
-- Constraints for table `officina_accessorio`
--
ALTER TABLE `officina_accessorio`
  ADD CONSTRAINT `officina_accessorio_ibfk_1` FOREIGN KEY (`CodiceOfficina`) REFERENCES `officina` (`Codice`),
  ADD CONSTRAINT `officina_accessorio_ibfk_2` FOREIGN KEY (`CodiceArticolo`) REFERENCES `accessorio` (`CodiceArticolo`);

--
-- Constraints for table `officina_servizio`
--
ALTER TABLE `officina_servizio`
  ADD CONSTRAINT `officina_servizio_ibfk_1` FOREIGN KEY (`CodiceOfficina`) REFERENCES `officina` (`Codice`),
  ADD CONSTRAINT `officina_servizio_ibfk_2` FOREIGN KEY (`CodiceServizio`) REFERENCES `servizio` (`Codice`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
