<?php
header("Content-Type: application/json");
require_once __DIR__ . "/../classes/Cliente.php";

$json_data = file_get_contents("php://input");
$data = json_decode($json_data, true);

$mail = isset($data['mail']) ? $data['mail'] : '';
$otp = isset($data['otp']) ? $data['otp'] : '';

$user = new Cliente();
if ($user->verifyOTP($mail, $otp)) {
    echo json_encode(["status" => true, "message" => "Account verificato con successo"]);
} else {
    echo json_encode(["status" => false, "message" => "Codice OTP non valido o scaduto"]);
}