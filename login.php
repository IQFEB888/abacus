<?php
session_start();

if (isset($_SESSION['loggato']) && $_SESSION['loggato'] === true) {
    header("Location: index.html");
    exit;
}
?>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Abacus</title>
</head>
<body>
    <h1>Accedi</h1>
    <form id="loginForm">
        <label for="nomeInput">Nome</label>
        <input type="text" id="nomeInput" name="nome" required>
        <br>
        <label for="cognomeInput">Cognome</label>
        <input type="text" id="cognomeInput" name="cognome" required>
        <br>
        <label for="passwordInput">Password</label>
        <input type="password" id="passwordInput" name="password" required>
        <br>
        <button type="submit">Accedi</button>
    </form>
    <p>Non hai un account? <a href="register.html">Registrati</a></p>
    <div id="loginMessage"></div>

    <script src="js/login.js"></script>
</body>
</html>