async function login() {
    const nome = document.getElementById("nomeInput").value;
    const cognome = document.getElementById("cognomeInput").value;
    const password = document.getElementById("passwordInput").value;
    
    const response = await fetch("api/login.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ nome, cognome, password }),
    });
    
    const data = await response.json();
    
    if (data.status) {
        window.location.href = "index.html";
    } else {
        alert("Credenziali errate!");
    }
}

document.addEventListener("DOMContentLoaded", () => {
    const loginForm = document.getElementById("loginForm");
    if (loginForm) {
        loginForm.addEventListener("submit", (event) => {
            event.preventDefault();
            login();
        });
    }
});