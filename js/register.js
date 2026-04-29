document.getElementById("registerButton").addEventListener("click", async () => {
    const n = document.getElementById("regNome").value;
    const c = document.getElementById("regCognome").value;
    const p = document.getElementById("regPassword").value;
    const t = document.getElementById("regTelefono").value;
    const m = document.getElementById("regEmail").value;
    const res = await fetch("api/register.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ nome: n, cognome: c, password: p, telefono: t, mail: m })
    });
    const data = await res.json();
    if (data.status) {
        alert("Registrazione completata! Controlla la tua email per il codice di verifica.");
        window.location.href = "verify.html";
    } else {
        alert("Errore registrazione - email già esistente o errore invio email");
    }
});