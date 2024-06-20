function obterParametroDaURL(nomeParametro) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(nomeParametro);
}

const cliente = obterParametroDaURL('cliente');
const data = obterParametroDaURL('data');

const dataLocal = new Date(data + 'T00:00:00');
const offset = new Date().getTimezoneOffset();
const dataFormatada = new Date(dataLocal.getTime() + offset * 60 * 1000).toLocaleDateString('pt-BR');

const xhr = new XMLHttpRequest();
xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
        const cidade = xhr.responseText;

        const detalhesRomaneio = document.getElementById('detalhesRomaneio');
        detalhesRomaneio.innerHTML =
            `<table border="1" width="80%">
                <thead>
                    <tr>
                        <th colspan="5">Cliente</th>
                        <th colspan="5">Cidade</th>
                        <th colspan="5">Data</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <tr>
                        <td colspan="5">${cliente}</td>
                        <td colspan="5">${cidade}</td>
                        <td colspan="5">${dataFormatada}</td>
                    </tr> 
                    <tr>
                        <td class="product" colspan="7"><strong>Produto</strong></td>
                        <td class="quantity" colspan="2"><strong>Quantidade</strong></td>
                        <td class="price" colspan="3"><strong>Preço Unitário</strong></td>
                        <td class="total" colspan="3"><strong>Total</strong></td>
                    </tr>
                </tbody>
            </table>`;
    }
};

xhr.open("GET", `php/obter_cidade.php?cliente=${encodeURIComponent(cliente)}`, true);
xhr.send();

document.getElementById('codBarras').addEventListener("submit", function (e) {
    e.preventDefault();
    const input = document.getElementById("codBarrasInput").value.trim();

    if (input === "") return;

    fetch(`php/obter_produto.php?codigo_de_barras=${encodeURIComponent(input)}`)
        .then(response => response.json())
        .then(data => {
            if (data.nome !== '') {
                updateOrAddProduct(input, data.nome, parseFloat(data.preco.replace(',', '.')));
            } else {
                alert('Produto não encontrado');
            }
        })
        .catch(error => console.error('Erro:', error));

    document.getElementById("codBarrasInput").value = "";
});

function updateOrAddProduct(codigoDeBarras, nome, preco) {
    const tableBody = document.getElementById("tableBody");
    let found = false;

    tableBody.querySelectorAll(".product").forEach(productCell => {
        if (productCell.textContent === nome) {
            const row = productCell.parentElement;
            const quantityCell = row.querySelector(".quantity span");
            const totalCell = row.querySelector(".total");

            let currentQuantity = parseInt(quantityCell.textContent);
            currentQuantity++;
            quantityCell.textContent = currentQuantity;
            totalCell.textContent = formatCurrency(preco * currentQuantity);

            found = true;
        }
    });

    if (!found) {
        addProductRow(codigoDeBarras, nome, preco);
    }

    updateDeclaracaoForm();
}

function addProductRow(codigoDeBarras, nome, preco) {
    const tableBody = document.getElementById("tableBody");

    const row = document.createElement("tr");
    tableBody.appendChild(row);

    const product = document.createElement("td");
    const quantity = document.createElement("td");
    const price = document.createElement("td");
    const total = document.createElement("td");

    product.setAttribute("class", "product");
    quantity.setAttribute("class", "quantity");
    price.setAttribute("class", "price");
    total.setAttribute("class", "total");

    product.setAttribute("colspan", "7");
    quantity.setAttribute("colspan", "2");
    price.setAttribute("colspan", "3");
    total.setAttribute("colspan", "3");

    row.appendChild(product);
    row.appendChild(quantity);
    row.appendChild(price);
    row.appendChild(total);

    product.textContent = nome;
    quantity.innerHTML = `<span>1</span> <img src="icons/pencil.svg" class="edit-icon" onclick="editQuantity(this)">`;
    price.textContent = formatCurrency(preco);
    total.textContent = formatCurrency(preco);

    updateDeclaracaoForm();
}

function editQuantity(icon) {
    const quantityCell = icon.parentElement;
    const quantitySpan = quantityCell.querySelector('span');
    const oldQuantity = quantitySpan.textContent;

    const newQuantity = prompt("Digite a nova quantidade:", oldQuantity);

    if (newQuantity !== null && !isNaN(newQuantity) && newQuantity > 0) {
        const row = quantityCell.parentElement;
        const priceCell = row.querySelector(".price");
        const totalCell = row.querySelector(".total");

        quantitySpan.textContent = newQuantity;
        totalCell.textContent = formatCurrency(parseFloat(priceCell.textContent.replace("R$", "").trim().replace(',', '.')) * newQuantity);
    }

    updateDeclaracaoForm();
}

function formatCurrency(value) {
let formattedValue = value.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });

if (formattedValue.includes('.')) {
let parts = formattedValue.split(',');

if (parts.length === 2) {
    let integerPart = parts[0];
    let decimalPart = parts[1];

    integerPart = integerPart.replace(/\./g, '');

    formattedValue = integerPart + ',' + decimalPart;
}
}

return formattedValue;
}

function updateDeclaracaoForm() {
    const tableBody = document.getElementById("tableBody");
    const rows = Array.from(tableBody.getElementsByTagName('tr'));

    const products = rows.slice(2).map(row => {
        const cells = row.getElementsByTagName('td');
        return {
            name: cells[0].textContent,
            price: parseFloat(cells[2].textContent.replace("R$", "").trim().replace(',', '.')),
            quantity: parseInt(cells[1].querySelector('span').textContent.trim()),
            total: parseFloat(cells[3].textContent.replace("R$", "").trim().replace(',', '.'))
        };
    });

    const cliente = obterParametroDaURL('cliente');
    const cidade = document.getElementById('detalhesRomaneio').getElementsByTagName('td')[1].textContent;
    const data = document.getElementById('detalhesRomaneio').getElementsByTagName('td')[2].textContent;

    const form = document.getElementById('declaracaoForm');
    form.innerHTML = '';

    form.innerHTML += `<input type="hidden" name="cliente" value="${cliente}">`;
    form.innerHTML += `<input type="hidden" name="cidade" value="${cidade}">`;
    form.innerHTML += `<input type="hidden" name="data" value="${data}">`;

    products.forEach((product, index) => {
        form.innerHTML += `<input type="hidden" name="product_${index}_name" value="${product.name}">`;
        form.innerHTML += `<input type="hidden" name="product_${index}_price" value="${product.price.toFixed(2)}">`;
        form.innerHTML += `<input type="hidden" name="product_${index}_quantity" value="${product.quantity}">`;
        form.innerHTML += `<input type="hidden" name="product_${index}_total" value="${product.total.toFixed(2)}">`;
    });

    form.innerHTML += `<input id="declaracao" type="submit" value="Imprimir Declaração">`;
}