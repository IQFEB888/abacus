<?php
require_once __DIR__ . "/database.php";

class credentials_cliente
{
    public function __construct()
    {
    }

    public function doLogin($nome, $cognome, $password)
    {
        $db = new database();
        $stmt = $db->prepare("SELECT Ruolo FROM cliente WHERE Nome = ? AND cognome = ? AND password = ? AND Status = 1");
        $stmt->bind_param("sss", $nome, $cognome, $password);
        $stmt->execute();
        $result = $stmt->get_result()->fetch_assoc();

        if ($result) {
            return $result['Ruolo']; 
        }
        return false;
    }
}