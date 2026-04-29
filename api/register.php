<?php
header("Content-Type: application/json");
require_once __DIR__ . "/../classes/Cliente.php";

$json_data = file_get_contents("php://input");
$data = json_decode($json_data, true);

$nome = isset($data['nome']) ? $data['nome'] : '';
$cognome = isset($data['cognome']) ? $data['cognome'] : '';
$password = isset($data['password']) ? $data['password'] : '';
$telefono = isset($data['telefono']) ? $data['telefono'] : '';
$mail = isset($data['mail']) ? $data['mail'] : '';


$user = new Cliente();
if ($user->register($nome, $cognome, $password, $telefono, $mail)) {
    echo json_encode(["status" => true]);
} else {
    echo json_encode(["status" => false]);
}