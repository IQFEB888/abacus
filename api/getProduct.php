<?php
session_start();
header("Content-Type: application/json");
require_once __DIR__ . "/../classes/Officina.php";

$officina = new Officina();
$con = $officina->getConnection();

$pezziInventario = [];
$accessoriInventario = [];

$pezziQuery = $con->query("SELECT op.CodicePezzo AS id, p.Descrizione, op.CodiceOfficina AS id_officina, o.Denominazione AS officina, op.Quantita FROM officina_pezzo op JOIN pezzo_ricambio p ON op.CodicePezzo = p.CodicePezzo JOIN officina o ON op.CodiceOfficina = o.Codice");
if ($pezziQuery) {
    $pezziInventario = $pezziQuery->fetch_all(MYSQLI_ASSOC);
}

$accessoriQuery = $con->query("SELECT oa.CodiceArticolo AS id, a.Descrizione, oa.CodiceOfficina AS id_officina, o.Denominazione AS officina, oa.Quantita FROM officina_accessorio oa JOIN accessorio a ON oa.CodiceArticolo = a.CodiceArticolo JOIN officina o ON oa.CodiceOfficina = o.Codice");
if ($accessoriQuery) {
    $accessoriInventario = $accessoriQuery->fetch_all(MYSQLI_ASSOC);
}

echo json_encode([
    "status" => true,
    "data" => [
        "servizi" => $officina->getServizi(),
        "accessori" => $officina->getAccessori(),
        "pezzi" => $officina->getPezziRicambio(),
        "inventario_pezzi" => $pezziInventario,
        "inventario_accessori" => $accessoriInventario,
        "ruolo" => $_SESSION['ruolo'] ?? ''
    ]
]);