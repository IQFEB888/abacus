async function popolaSelezioni() {
    const res = await fetch("api/getProduct.php");
    const json = await res.json();

    const s = document.getElementById("selectServizio");
    const p = document.getElementById("selectPezzo");
    const a = document.getElementById("selectAccessorio");

    json.data.servizi.forEach(serv => {
        s.innerHTML += `<option value="${serv.Codice}">${serv.Descrizione}</option>`;
    });

    json.data.pezzi.forEach(pez => {
        p.innerHTML += `<option value="${pez.CodicePezzo}">${pez.Descrizione}</option>`;
    });

    json.data.accessori.forEach(acc => {
        a.innerHTML += `<option value="${acc.CodiceArticolo}">${acc.Descrizione}</option>`;
    });
}

document.getElementById("searchBtn").onclick = async () => {
    const s = document.getElementById("selectServizio").value;
    const p = document.getElementById("selectPezzo").value;
    const a = document.getElementById("selectAccessorio").value;

    const res = await fetch(`api/cerca_officine.php?servizio=${s}&pezzo=${p}&accessorio=${a}`);
    const json = await res.json();

    const resultsDiv = document.getElementById("results");
    resultsDiv.innerHTML = "";

    if (json.data.length === 0) {
        resultsDiv.innerHTML = "<p>Nessuna officina trovata</p>";
        return;
    }

    json.data.forEach(off => {
        resultsDiv.innerHTML += `
            <div >
                <h3>${off.Denominazione}</h3>
                <p>Indirizzo: ${off.Indirizzo}</p>
            </div>
        `;
    });
};

popolaSelezioni();