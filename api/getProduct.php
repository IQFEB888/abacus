<?php
header("Content-Type: application/json");
require_once __DIR__ . "/../classes/Officina.php";

$officina = new Officina();

echo json_encode([
    "status" => true,
    "data" => [
        "servizi" => $officina->getServizi(),
        "accessori" => $officina->getAccessori(),
        "pezzi" => $officina->getPezziRicambio()
    ]
]);