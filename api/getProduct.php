<?php
session_start();
header("Content-Type: application/json");
require_once __DIR__ . "/../classes/Officina.php";

try {
    $officina = new Officina();
    $con = $officina->getConnection();

    $pezziInventario = [];
    $accessoriInventario = [];

    $pezziQuery = $con->query("SELECT op.CodicePezzo AS id, p.Descrizione, op.CodiceOfficina AS id_officina, o.Denominazione AS officina, op.Quantita FROM officina_pezzo op JOIN pezzo_ricambio p ON op.CodicePezzo = p.CodicePezzo JOIN officina o ON op.CodiceOfficina = o.Codice");
    if ($pezziQuery) {
        $pezziInventario = $pezziQuery->fetch_all(MYSQLI_ASSOC);
    } else {
        throw new Exception("Errore nella query pezzi: " . $con->error);
    }

    $accessoriQuery = $con->query("SELECT oa.CodiceArticolo AS id, a.Descrizione, oa.CodiceOfficina AS id_officina, o.Denominazione AS officina, oa.Quantita FROM officina_accessorio oa JOIN accessorio a ON oa.CodiceArticolo = a.CodiceArticolo JOIN officina o ON oa.CodiceOfficina = o.Codice");
    if ($accessoriQuery) {
        $accessoriInventario = $accessoriQuery->fetch_all(MYSQLI_ASSOC);
    } else {
        throw new Exception("Errore nella query accessori: " . $con->error);
    }

    $servizi = $officina->getServizi();
    $accessori = $officina->getAccessori();
    $pezzi = $officina->getPezziRicambio();

    echo json_encode([
        "status" => true,
        "data" => [
            "servizi" => $servizi,
            "accessori" => $accessori,
            "pezzi" => $pezzi,
            "inventario_pezzi" => $pezziInventario,
            "inventario_accessori" => $accessoriInventario,
            "ruolo" => $_SESSION['ruolo'] ?? ''
        ]
    ]);
} catch (Exception $e) {
    echo json_encode([
        "status" => false,
        "message" => $e->getMessage()
    ]);
}