function checkBorde(){
    document.getElementById("esconder-borde-impresion").hidden = (!document.getElementById("impresion-doble-cara").checked);
}

function rehacerComando(){
    // Limpiamos el comando
    document.getElementById("comando-consola").innerText = "";

    document.getElementById("confirmacion-copiado").hidden = true;

    document.getElementById("display-comando").hidden = false;

    document.getElementById("copy-button").hidden = false;

    let nombreArchivoPDF = document.getElementById("nombre-archivo-pdf").value;

    let nuevoComando = "";

    const nombreArchivoPS = document.getElementById("nombre-archivo-ps").value;

    nuevoComando += `pdf2ps ${nombreArchivoPDF} ${nombreArchivoPS} && `;

    // Volvemos a buscar los nombres
    if(document.getElementById("impresion-doble-cara").checked) {
        nuevoComando += "duplex "

        if (document.getElementById("borde-impresion").value === 'corto') {
            nuevoComando += "-l "
        }

        nuevoComando += `${nombreArchivoPS}|lpr`;

        if (document.getElementById("lugar-impresion").value === "salita") {
            nuevoComando += " -P hp335"
        }
    }
    else {
        nuevoComando += "lpr ";

        if (document.getElementById("lugar-impresion").value === "salita"){
            nuevoComando += "-P hp335 ";
        }

        nuevoComando += `${nombreArchivoPS}`;
    }



    document.getElementById("comando-consola").innerText = nuevoComando;

}

function copyToClipboard() {
    // Get the text field
    let copyText = document.getElementById("comando-consola");

    // Copy the text inside the text field
    navigator.clipboard.writeText(copyText.innerText);

    // Alert the copied text
    document.getElementById("confirmacion-copiado").hidden = false;
}
