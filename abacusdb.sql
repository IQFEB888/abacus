-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Apr 22, 2026 alle 09:26
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.2.12

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
-- Struttura della tabella `accessorio`
--

CREATE TABLE `accessorio` (
  `CodiceArticolo` int(11) NOT NULL,
  `Descrizione` varchar(255) DEFAULT NULL,
  `CostoUnitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dump dei dati per la tabella `accessorio`
--

INSERT INTO `accessorio` (`CodiceArticolo`, `Descrizione`, `CostoUnitario`) VALUES
(3, 'Cerchi', 25.00),
(4, 'Imbuto', 10.00);

-- --------------------------------------------------------

--
-- Struttura della tabella `autoveicolo`
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
-- Struttura della tabella `cliente`
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
-- Dump dei dati per la tabella `cliente`
--

INSERT INTO `cliente` (`Codice`, `Nome`, `cognome`, `password`, `Telefono`, `Mail`, `CodiceOTP`, `ScadenzaOTP`, `Status`, `Ruolo`) VALUES
(13, 'Admin', 'Supremo', 'admin123', '3331234567', 'admin@abacus.it', 'VERIFICATO-MANUALMENTE', '2030-12-31', 1, 'admin'),
(15, 'Fabio', 'Beccalli', '123', '3342122559', 'beccalli.fabio4@gmail.com', 'd362f58f-206b-402e-9bef-38e82b07fa45', '2026-04-23', 1, '');

-- --------------------------------------------------------

--
-- Struttura della tabella `dipendente`
--

CREATE TABLE `dipendente` (
  `User` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `intervento`
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
-- Struttura della tabella `intervento_accessorio`
--

CREATE TABLE `intervento_accessorio` (
  `CodiceIntervento` int(11) NOT NULL,
  `CodiceArticolo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `intervento_pezzo`
--

CREATE TABLE `intervento_pezzo` (
  `CodiceIntervento` int(11) NOT NULL,
  `CodicePezzo` int(11) NOT NULL,
  `Quantita` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `intervento_servizio`
--

CREATE TABLE `intervento_servizio` (
  `CodiceIntervento` int(11) NOT NULL,
  `CodiceServizio` int(11) NOT NULL,
  `Ore` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `officina`
--

CREATE TABLE `officina` (
  `Codice` int(11) NOT NULL,
  `Denominazione` varchar(100) NOT NULL,
  `Indirizzo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dump dei dati per la tabella `officina`
--

INSERT INTO `officina` (`Codice`, `Denominazione`, `Indirizzo`) VALUES
(1, 'AutoExpert Milano', 'Via Roma 10, Milano'),
(2, 'Meccanica Veloce Torino', 'Corso Italia 55, Torino'),
(3, 'Officina del Borgo Bologna', 'Piazza Dante 2, Bologna');

-- --------------------------------------------------------

--
-- Struttura della tabella `officina_accessorio`
--

CREATE TABLE `officina_accessorio` (
  `CodiceOfficina` int(11) NOT NULL,
  `CodiceArticolo` int(11) NOT NULL,
  `Quantita` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dump dei dati per la tabella `officina_accessorio`
--

INSERT INTO `officina_accessorio` (`CodiceOfficina`, `CodiceArticolo`, `Quantita`) VALUES
(1, 3, 10),
(2, 4, 10);

-- --------------------------------------------------------

--
-- Struttura della tabella `officina_pezzo`
--

CREATE TABLE `officina_pezzo` (
  `CodiceOfficina` int(11) NOT NULL,
  `CodicePezzo` int(11) NOT NULL,
  `Quantita` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dump dei dati per la tabella `officina_pezzo`
--

INSERT INTO `officina_pezzo` (`CodiceOfficina`, `CodicePezzo`, `Quantita`) VALUES
(1, 0, 10),
(2, 2, 10);

-- --------------------------------------------------------

--
-- Struttura della tabella `officina_servizio`
--

CREATE TABLE `officina_servizio` (
  `CodiceOfficina` int(11) NOT NULL,
  `CodiceServizio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dump dei dati per la tabella `officina_servizio`
--

INSERT INTO `officina_servizio` (`CodiceOfficina`, `CodiceServizio`) VALUES
(1, 10),
(2, 11);

-- --------------------------------------------------------

--
-- Struttura della tabella `pezzo_ricambio`
--

CREATE TABLE `pezzo_ricambio` (
  `CodicePezzo` int(11) NOT NULL,
  `Descrizione` varchar(255) DEFAULT NULL,
  `CostoUnitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dump dei dati per la tabella `pezzo_ricambio`
--

INSERT INTO `pezzo_ricambio` (`CodicePezzo`, `Descrizione`, `CostoUnitario`) VALUES
(1, 'Gomme', 50.00),
(2, 'Olio', 25.00);

-- --------------------------------------------------------

--
-- Struttura della tabella `servizio`
--

CREATE TABLE `servizio` (
  `Codice` int(11) NOT NULL,
  `CostoOrario` decimal(10,2) NOT NULL,
  `Descrizione` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dump dei dati per la tabella `servizio`
--

INSERT INTO `servizio` (`Codice`, `CostoOrario`, `Descrizione`) VALUES
(10, 100.00, 'Cambio Gomme'),
(11, 70.00, 'Cambio Olio');

-- --------------------------------------------------------

--
-- Struttura della tabella `tipo_intervento`
--

CREATE TABLE `tipo_intervento` (
  `Codice` int(11) NOT NULL,
  `Descrizione` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `accessorio`
--
ALTER TABLE `accessorio`
  ADD PRIMARY KEY (`CodiceArticolo`);

--
-- Indici per le tabelle `autoveicolo`
--
ALTER TABLE `autoveicolo`
  ADD PRIMARY KEY (`Targa`),
  ADD UNIQUE KEY `Ntelaio` (`Ntelaio`),
  ADD KEY `CodiceCliente` (`CodiceCliente`);

--
-- Indici per le tabelle `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`Codice`);

--
-- Indici per le tabelle `dipendente`
--
ALTER TABLE `dipendente`
  ADD PRIMARY KEY (`User`);

--
-- Indici per le tabelle `intervento`
--
ALTER TABLE `intervento`
  ADD PRIMARY KEY (`Codice`),
  ADD KEY `CodiceOfficina` (`CodiceOfficina`),
  ADD KEY `TargaAutoveicolo` (`TargaAutoveicolo`),
  ADD KEY `CodiceCliente` (`CodiceCliente`),
  ADD KEY `CodiceTipoIntervento` (`CodiceTipoIntervento`);

--
-- Indici per le tabelle `intervento_accessorio`
--
ALTER TABLE `intervento_accessorio`
  ADD PRIMARY KEY (`CodiceIntervento`,`CodiceArticolo`),
  ADD KEY `CodiceArticolo` (`CodiceArticolo`);

--
-- Indici per le tabelle `intervento_pezzo`
--
ALTER TABLE `intervento_pezzo`
  ADD PRIMARY KEY (`CodiceIntervento`,`CodicePezzo`),
  ADD KEY `CodicePezzo` (`CodicePezzo`);

--
-- Indici per le tabelle `intervento_servizio`
--
ALTER TABLE `intervento_servizio`
  ADD PRIMARY KEY (`CodiceIntervento`,`CodiceServizio`),
  ADD KEY `CodiceServizio` (`CodiceServizio`);

--
-- Indici per le tabelle `officina`
--
ALTER TABLE `officina`
  ADD PRIMARY KEY (`Codice`);

--
-- Indici per le tabelle `officina_accessorio`
--
ALTER TABLE `officina_accessorio`
  ADD PRIMARY KEY (`CodiceOfficina`,`CodiceArticolo`),
  ADD KEY `CodiceArticolo` (`CodiceArticolo`);

--
-- Indici per le tabelle `officina_pezzo`
--
ALTER TABLE `officina_pezzo`
  ADD PRIMARY KEY (`CodiceOfficina`,`CodicePezzo`),
  ADD KEY `CodicePezzo` (`CodicePezzo`);

--
-- Indici per le tabelle `officina_servizio`
--
ALTER TABLE `officina_servizio`
  ADD PRIMARY KEY (`CodiceOfficina`,`CodiceServizio`),
  ADD KEY `CodiceServizio` (`CodiceServizio`);

--
-- Indici per le tabelle `pezzo_ricambio`
--
ALTER TABLE `pezzo_ricambio`
  ADD PRIMARY KEY (`CodicePezzo`);

--
-- Indici per le tabelle `servizio`
--
ALTER TABLE `servizio`
  ADD PRIMARY KEY (`Codice`);

--
-- Indici per le tabelle `tipo_intervento`
--
ALTER TABLE `tipo_intervento`
  ADD PRIMARY KEY (`Codice`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `accessorio`
--
ALTER TABLE `accessorio`
  MODIFY `CodiceArticolo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `cliente`
--
ALTER TABLE `cliente`
  MODIFY `Codice` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT per la tabella `intervento`
--
ALTER TABLE `intervento`
  MODIFY `Codice` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `officina`
--
ALTER TABLE `officina`
  MODIFY `Codice` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `pezzo_ricambio`
--
ALTER TABLE `pezzo_ricambio`
  MODIFY `CodicePezzo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `servizio`
--
ALTER TABLE `servizio`
  MODIFY `Codice` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `autoveicolo`
--
ALTER TABLE `autoveicolo`
  ADD CONSTRAINT `autoveicolo_ibfk_1` FOREIGN KEY (`CodiceCliente`) REFERENCES `cliente` (`Codice`);

--
-- Limiti per la tabella `intervento`
--
ALTER TABLE `intervento`
  ADD CONSTRAINT `intervento_ibfk_1` FOREIGN KEY (`CodiceOfficina`) REFERENCES `officina` (`Codice`),
  ADD CONSTRAINT `intervento_ibfk_2` FOREIGN KEY (`TargaAutoveicolo`) REFERENCES `autoveicolo` (`Targa`),
  ADD CONSTRAINT `intervento_ibfk_3` FOREIGN KEY (`CodiceCliente`) REFERENCES `cliente` (`Codice`),
  ADD CONSTRAINT `intervento_ibfk_4` FOREIGN KEY (`CodiceTipoIntervento`) REFERENCES `tipo_intervento` (`Codice`);

--
-- Limiti per la tabella `intervento_accessorio`
--
ALTER TABLE `intervento_accessorio`
  ADD CONSTRAINT `intervento_accessorio_ibfk_1` FOREIGN KEY (`CodiceIntervento`) REFERENCES `intervento` (`Codice`),
  ADD CONSTRAINT `intervento_accessorio_ibfk_2` FOREIGN KEY (`CodiceArticolo`) REFERENCES `accessorio` (`CodiceArticolo`);

--
-- Limiti per la tabella `intervento_pezzo`
--
ALTER TABLE `intervento_pezzo`
  ADD CONSTRAINT `intervento_pezzo_ibfk_1` FOREIGN KEY (`CodiceIntervento`) REFERENCES `intervento` (`Codice`),
  ADD CONSTRAINT `intervento_pezzo_ibfk_2` FOREIGN KEY (`CodicePezzo`) REFERENCES `pezzo_ricambio` (`CodicePezzo`);

--
-- Limiti per la tabella `intervento_servizio`
--
ALTER TABLE `intervento_servizio`
  ADD CONSTRAINT `intervento_servizio_ibfk_1` FOREIGN KEY (`CodiceIntervento`) REFERENCES `intervento` (`Codice`),
  ADD CONSTRAINT `intervento_servizio_ibfk_2` FOREIGN KEY (`CodiceServizio`) REFERENCES `servizio` (`Codice`);

--
-- Limiti per la tabella `officina_accessorio`
--
ALTER TABLE `officina_accessorio`
  ADD CONSTRAINT `officina_accessorio_ibfk_1` FOREIGN KEY (`CodiceOfficina`) REFERENCES `officina` (`Codice`),
  ADD CONSTRAINT `officina_accessorio_ibfk_2` FOREIGN KEY (`CodiceArticolo`) REFERENCES `accessorio` (`CodiceArticolo`);

--
-- Limiti per la tabella `officina_pezzo`
--
ALTER TABLE `officina_pezzo`
  ADD CONSTRAINT `officina_pezzo_ibfk_1` FOREIGN KEY (`CodiceOfficina`) REFERENCES `officina` (`Codice`),
  ADD CONSTRAINT `officina_pezzo_ibfk_2` FOREIGN KEY (`CodicePezzo`) REFERENCES `pezzo_ricambio` (`CodicePezzo`);

--
-- Limiti per la tabella `officina_servizio`
--
ALTER TABLE `officina_servizio`
  ADD CONSTRAINT `officina_servizio_ibfk_1` FOREIGN KEY (`CodiceOfficina`) REFERENCES `officina` (`Codice`),
  ADD CONSTRAINT `officina_servizio_ibfk_2` FOREIGN KEY (`CodiceServizio`) REFERENCES `servizio` (`Codice`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
