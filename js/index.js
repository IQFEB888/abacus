async function loadIndexData() {
    const res = await fetch("api/getProduct.php");
    const json = await res.json();

    if (!json.status) {
        document.getElementById("inventoryContainer").innerText = "Errore nel caricamento dei prodotti.";
        return;
    }

    const ruolo = json.data.ruolo || "";
    const inventoryContainer = document.getElementById("inventoryContainer");
    inventoryContainer.innerHTML = "";

    inventoryContainer.innerHTML += renderInventoryTable(
        "Inventario pezzi di ricambio",
        json.data.inventario_pezzi,
        ruolo,
        "pezzo_ricambio"
    );

    inventoryContainer.innerHTML += renderInventoryTable(
        "Inventario accessori",
        json.data.inventario_accessori,
        ruolo,
        "accessorio"
    );
}

function renderInventoryTable(title, items, ruolo, type) {
    let html = `\n        <section>\n            <h2>${title}</h2>\n            <table border="1" cellspacing="0" cellpadding="6">\n                <thead>\n                    <tr>\n                        <th>ID</th>\n                        <th>Descrizione</th>\n                        <th>Officina</th>\n                        <th>Quantità</th>\n                        ${ruolo === "magazziniere" ? "<th>Azione</th>" : ""}\n                    </tr>\n                </thead>\n                <tbody>\n`;

    if (items.length === 0) {
        html += `                    <tr><td colspan="${ruolo === "magazziniere" ? 5 : 4}">Nessun elemento disponibile</td></tr>\n`;
    } else {
        items.forEach(item => {
            const quantityValue = parseInt(item.Quantita, 10) || 0;
            html += `                    <tr>\n                        <td>${item.id}</td>\n                        <td>${item.Descrizione}</td>\n                        <td>${item.officina}</td>\n                        <td>${ruolo === "magazziniere" ? `<input type="number" min="0" value="${quantityValue}" class="qtyInput" data-type="${type}" data-id="${item.id}" data-officina="${item.id_officina}">` : quantityValue}</td>\n`;
            if (ruolo === "magazziniere") {
                html += `                        <td><button class="updateQtyBtn" data-type="${type}" data-id="${item.id}" data-officina="${item.id_officina}">Salva</button></td>\n`;
            }
            html += `                    </tr>\n`;
        });
    }

    html += `                </tbody>\n            </table>\n        </section>\n`;
    return html;
}

async function updateQuantity(type, id, idOfficina, quantity, button) {
    button.disabled = true;
    const response = await fetch("api/updateQuantity.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ type, id, id_officina: idOfficina, quantity })
    });

    const json = await response.json();
    button.disabled = false;

    if (!json.status) {
        alert(json.message || "Errore nell'aggiornamento della quantità.");
        return;
    }

    button.innerText = "Salvato";
    setTimeout(() => {
        button.innerText = "Salva";
    }, 1500);
}

document.addEventListener("click", (event) => {
    if (event.target.classList.contains("updateQtyBtn")) {
        const button = event.target;
        const type = button.dataset.type;
        const id = button.dataset.id;
        const idOfficina = button.dataset.officina;
        const row = button.closest("tr");
        const input = row.querySelector(".qtyInput");
        const quantity = parseInt(input.value, 10);

        if (isNaN(quantity) || quantity < 0) {
            alert("Inserisci una quantità valida.");
            return;
        }

        updateQuantity(type, id, idOfficina, quantity, button);
    }
});

loadIndexData();
