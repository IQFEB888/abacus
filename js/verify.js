document.addEventListener("DOMContentLoaded", () => {
    console.log("Script caricato e DOM pronto!");

    const params = new URLSearchParams(window.location.search);
    const emailDaUrl = params.get('verifyEmail');
    const otpDaUrl = params.get('verifyOTP');

    console.log("Dati recuperati dall'URL:", { emailDaUrl, otpDaUrl });

    if (emailDaUrl) {
        const inputEmail = document.getElementById('verifyEmail');
        if (inputEmail) {
            inputEmail.value = emailDaUrl;
            console.log("Campo Email riempito!");
        } else {
            console.error("Errore: Non trovo l'input con id 'verifyEmail'");
        }
    }

    if (otpDaUrl) {
        const inputOTP = document.getElementById('verifyOTP');
        if (inputOTP) {
            inputOTP.value = otpDaUrl;
            console.log("Campo OTP riempito!");
        } else {
            console.error("Errore: Non trovo l'input con id 'verifyOTP'");
        }
    }

    if (emailDaUrl && otpDaUrl) document.getElementById("verifyButton").click();
});

document.getElementById("verifyButton").addEventListener("click", async () => {
    const email = document.getElementById("verifyEmail").value;
    const otp = document.getElementById("verifyOTP").value;

    if (!email || !otp) {
        document.getElementById("message").innerHTML = '<div class="alert alert-warning">Inserisci email e codice OTP</div>';
        return;
    }

    try {
        const res = await fetch("api/verify.php", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ mail: email, otp: otp })
        });

        const data = await res.json();
        if (data.status) {
            document.getElementById("message").innerHTML = '<div class="alert alert-success">' + data.message + '</div>';
            setTimeout(() => {
                window.location.href = "login.php";
            }, 2000);
        } else {
            document.getElementById("message").innerHTML = '<div class="alert alert-danger">' + data.message + '</div>';
        }
    } catch (error) {
        console.error("Errore fetch:", error);
        document.getElementById("message").innerHTML = '<div class="alert alert-danger">Errore di comunicazione con il server</div>';
    }
});