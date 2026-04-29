document.getElementById("addBtn").onclick = async () => {
    const body = {
        type: document.getElementById("type").value,
        descrizione: document.getElementById("desc").value,
        costo: document.getElementById("costo").value,
        id_officina: document.getElementById("officina").value
    };
    
    const res = await fetch("api/admin_add.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body)
    });
    const json = await res.json();
    alert(json.status ? "Successo" : "Errore");
};