<?php
session_start();
header("Content-Type: application/json");

if (!isset($_SESSION['loggato']) || $_SESSION['ruolo'] !== 'magazziniere') {
    echo json_encode(["status" => false, "message" => "Accesso negato: solo magazziniere può aggiornare le quantità."]);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);
$type = $data['type'] ?? '';
$id = $data['id'] ?? 0;
$idOfficina = $data['id_officina'] ?? 0;
$quantity = $data['quantity'] ?? null;

if (!$type || !$id || !$idOfficina || !is_numeric($quantity) || $quantity < 0) {
    echo json_encode(["status" => false, "message" => "Dati non validi per l'aggiornamento."]);
    exit;
}

if (!in_array($type, ['pezzo_ricambio', 'accessorio'], true)) {
    echo json_encode(["status" => false, "message" => "Tipo di prodotto non valido."]);
    exit;
}

require_once __DIR__ . "/../classes/database.php";
$db = new database();
$connection = $db->getConnection();

$table = $type === 'pezzo_ricambio' ? 'officina_pezzo' : 'officina_accessorio';
$column = $type === 'pezzo_ricambio' ? 'CodicePezzo' : 'CodiceArticolo';

$sql = "UPDATE $table SET Quantita = ? WHERE CodiceOfficina = ? AND $column = ?";
$stmt = $connection->prepare($sql);
if (!$stmt) {
    echo json_encode(["status" => false, "message" => "Errore SQL."]);
    exit;
}
$stmt->bind_param("iii", $quantity, $idOfficina, $id);
$stmt->execute();

if ($stmt->affected_rows === 0) {
    echo json_encode(["status" => false, "message" => "Nessuna riga aggiornata: verifica i riferimenti."]);
    exit;
}

echo json_encode(["status" => true, "message" => "Quantità aggiornata con successo."]);
