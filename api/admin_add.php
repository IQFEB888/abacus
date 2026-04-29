<?php
session_start(); 
header("Content-Type: application/json");

if (!isset($_SESSION['loggato']) || $_SESSION['ruolo'] !== 'admin') {
    echo json_encode([
        "status" => false, 
        "message" => "Errore: Accesso negato. Solo gli amministratori possono aggiungere elementi."
    ]);
    exit; 
}

require_once __DIR__ . "/../classes/Officina.php";

$data = json_decode(file_get_contents("php://input"), true);

$tabella = $data['type'] ?? ''; 
$descrizione = $data['descrizione'] ?? '';
$costo = $data['costo'] ?? 0;
$idOfficina = $data['id_officina'] ?? null;

if (!$idOfficina || !in_array($tabella, ['servizio', 'pezzo_ricambio', 'accessorio'])) {
    echo json_encode(["status" => false, "message" => "Dati mancanti o tabella non valida"]);
    exit;
}

$officina = new Officina();
$res = $officina->addArticoloEAssocia($tabella, $descrizione, $costo, $idOfficina);

echo json_encode(["status" => $res]);