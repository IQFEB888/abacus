<?php
require_once __DIR__ . "/database.php";

class Officina
{
    private $conn;

    public function __construct()
    {
        $db = new database();
        $this->conn = $db->getConnection();
    }

    public function getServizi()
    {
        $result = $this->conn->query("SELECT Codice, CostoOrario, Descrizione FROM servizio");
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    public function getPezziRicambio()
    {
        $result = $this->conn->query("SELECT CodicePezzo, Descrizione, CostoUnitario FROM pezzo_ricambio");
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    public function getAccessori()
    {
        $result = $this->conn->query("SELECT CodiceArticolo, Descrizione, CostoUnitario FROM accessorio");
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    public function getConnection()
    {
        return $this->conn;
    }

    public function cercaCompatibili($idServizio, $idPezzo, $idAccessorio)
    {   

       $query = "SELECT DISTINCT o.* FROM officina o 
                  LEFT JOIN officina_servizio os ON o.Codice = os.CodiceOfficina 
                  LEFT JOIN officina_pezzo op ON o.Codice = op.CodiceOfficina 
                  LEFT JOIN officina_accessorio oa ON o.Codice = oa.CodiceOfficina 
                  WHERE 1=0";

        if ($idServizio)
            $query .= " OR os.CodiceServizio = " . $idServizio;
        if ($idPezzo)
            $query .= " OR op.CodicePezzo = " . $idPezzo;
        if ($idAccessorio)
            $query .= " OR oa.CodiceArticolo = " . $idAccessorio;

        $result = $this->conn->query($query);
        return $result->fetch_all(MYSQLI_ASSOC);        
    }

    public function getOfficine()
    {
        $result = $this->conn->query("SELECT Codice, Denominazione FROM officina");
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    public function addArticoloEAssocia($tabella, $descrizione, $costo, $idOfficina)
    {
        $colonnaCosto = ($tabella == 'servizio') ? 'CostoOrario' : 'CostoUnitario';
        $stmt = $this->conn->prepare("INSERT INTO $tabella (Descrizione, $colonnaCosto) VALUES (?, ?)");
        $stmt->bind_param("sd", $descrizione, $costo);
        
        if (!$stmt->execute()) return false;
        
        $nuovoId = $this->conn->insert_id;

        if ($tabella == 'servizio') {
            $stmtAssoc = $this->conn->prepare("INSERT INTO officina_servizio (CodiceOfficina, CodiceServizio) VALUES (?, ?)");
            $stmtAssoc->bind_param("ii", $idOfficina, $nuovoId);
        } elseif ($tabella == 'pezzo_ricambio') {
            $stmtAssoc = $this->conn->prepare("INSERT INTO officina_pezzo (CodiceOfficina, CodicePezzo, Quantita) VALUES (?, ?, ?)");
            $qty = 10;
            $stmtAssoc->bind_param("iii", $idOfficina, $nuovoId, $qty);
        } else {
            $stmtAssoc = $this->conn->prepare("INSERT INTO officina_accessorio (CodiceOfficina, CodiceArticolo, Quantita) VALUES (?, ?, ?)");
            $qty = 10;
            $stmtAssoc->bind_param("iii", $idOfficina, $nuovoId, $qty);
        }

        return $stmtAssoc->execute();
    }
}