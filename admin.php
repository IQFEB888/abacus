<?php
session_start();

if (!isset($_SESSION['loggato']) || $_SESSION['ruolo'] !== 'admin') {
    header("Location: index.html");
    exit;
}
?>



<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <title>Pannello Admin</title>
</head>

<body>
    <h1>Aggiungi Elemento</h1>
    <select id="type">
        <option value="servizio">Servizio</option>
        <option value="pezzo_ricambio">Pezzo Ricambio</option>
        <option value="accessorio">Accessorio</option>
    </select><br><br>
    <input type="text" id="desc" placeholder="Descrizione"><br>
    <input type="number" id="costo" placeholder="Costo"><br><br>
    <input type="number" id="officina" placeholder="Officina"><br><br>
    <button id="addBtn">Aggiungi</button>


    <script src="js/admin_add.js"></script>

</body>

</html>