<?php
header("Content-Type: application/json");
require_once __DIR__ . "/../classes/Officina.php";

$idServizio = $_GET['servizio'] ?? null;
$idPezzo = $_GET['pezzo'] ?? null;
$idAccessorio = $_GET['accessorio'] ?? null;

$officina = new Officina();
$data = $officina->cercaCompatibili($idServizio, $idPezzo, $idAccessorio);

echo json_encode(["status" => true, "data" => $data]);