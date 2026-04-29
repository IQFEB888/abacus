<?php
session_start();
header("Content-Type: application/json");
require_once __DIR__ . "/../classes/credentials_cliente.php";

$json_data = file_get_contents("php://input");
$data = json_decode($json_data, true);

$nome = $data['nome'] ?? '';
$cognome = $data['cognome'] ?? '';
$password = $data['password'] ?? '';

$cred = new credentials_cliente();
$ruolo = $cred->doLogin($nome, $cognome, $password);

if ($ruolo !== false) {
    $_SESSION['loggato'] = true;
    $_SESSION['nome'] = $nome;
    $_SESSION['ruolo'] = $ruolo !== '' ? $ruolo : 'user';

    echo json_encode([
        "status" => true,
        "ruolo" => $_SESSION['ruolo']
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => "Credenziali errate o account non verificato"
    ]);
}