<?php
require_once __DIR__ . "/database.php";
require_once __DIR__ . "/../api/send_mail.php";

class Cliente
{

    private function sendVerificationEmail($email, $otp)
    {
        $subject = 'Verifica il tuo account Abacus';
        $linkVerifica = "http://localhost/abacus/verify.html?verifyEmail=" . urlencode($email) . "&verifyOTP=" . urlencode($otp);
        $body = "Il tuo codice di verifica è: <strong>$otp</strong><br>" .
            "Puoi cliccare qui per verificare automaticamente: <a href='$linkVerifica'>$linkVerifica</a>";

        sendMailExternal(
            'esercizio-5binf@ismonnet.eu',
            $email,
            $subject,
            $body
        );

        return true;
    }

    public function register($nome, $cognome, $password, $telefono, $mail)
    {
        $db = new database();
        $stmt = $db->prepare("SELECT * FROM cliente WHERE mail = ?");
        $stmt->bind_param("s", $mail);
        $stmt->execute();
        if ($stmt->get_result()->fetch_assoc()) {
            return false;
        }

        $otp = $this->generateGUID();
        while (true) {
            $stmt = $db->prepare("SELECT * FROM cliente WHERE CodiceOTP = ?");
            $stmt->bind_param("s", $otp);
            $stmt->execute();
            if (!$stmt->get_result()->fetch_assoc()) {
                break;
            }
            $otp = $this->generateGUID();
        }
        $scadenza = date('Y-m-d', strtotime('+1 day'));


        $stmt = $db->prepare("INSERT INTO cliente (nome, cognome, password, telefono, mail, CodiceOTP, ScadenzaOTP, Status) VALUES (?, ?, ?, ?, ?, ?, ?, 0)");
        $stmt->bind_param("sssssss", $nome, $cognome, $password, $telefono, $mail, $otp, $scadenza);

        if ($stmt->execute()) {
            return $this->sendVerificationEmail($mail, $otp);
        }
        return false;
    }

    public function verifyOTP($email, $otp)
    {
        $db = new database();
        $stmt = $db->prepare("SELECT CodiceOTP, ScadenzaOTP FROM cliente WHERE mail = ? AND Status = 0");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result()->fetch_assoc();

        if ($result && $result['CodiceOTP'] == $otp && date('Y-m-d') <= $result['ScadenzaOTP']) {
            $stmt = $db->prepare("UPDATE cliente SET Status = 1 WHERE mail = ?");
            $stmt->bind_param("s", $email);
            return $stmt->execute();
        }
        return false;
    }
    function generateGUID()
    {
        $data = random_bytes(16);

        // Set version to 0100 (UUID v4)
        $data[6] = chr(ord($data[6]) & 0x0f | 0x40);

        // Set bits 6-7 to 10
        $data[8] = chr(ord($data[8]) & 0x3f | 0x80);

        return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4));
    }
}