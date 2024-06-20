function adicionarRomaneio() {
    const cliente = document.getElementById('clienteInput').value;
    const data = document.getElementById('data').value;

    const url = `outra_pagina.html?cliente=${encodeURIComponent(cliente)}&data=${encodeURIComponent(data)}`;

    window.location.href = url;
}