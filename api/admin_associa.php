<?php
header("Content-Type: application/json");
require_once __DIR__ . "/../classes/Officina.php";

$data = json_decode(file_get_contents("php://input"), true);

$idOff = $data['id_officina'] ?? null;
$idArt = $data['id_articolo'] ?? null;
$tipo  = $data['tipo'] ?? null;
$qty   = $data['quantita'] ?? 0;

if (!$idOff || !$idArt || !$tipo) {
    echo json_encode(["status" => false, "message" => "Dati mancanti"]);
    exit;
}

$officina = new Officina();
$res = $officina->addArticoloEAssocia($idOff, $idArt, $tipo, $qty);

echo json_encode(["status" => $res]);