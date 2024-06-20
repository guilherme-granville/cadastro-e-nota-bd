<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Lista de Produtos</title>    
    <link rel="shortcut icon" href="../icons/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="../css/produtos.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300..700&display=swap" rel="stylesheet">
    </head>
<body>
    <nav>
        <a class="a" href="../index.html">&#8617; Início</a>
</nav>
    <h1>Produtos</h1>
    <form method="GET" action="" class="search-container">
    <label for="search">Pesquisar por nome:</label>
    <input type="text" id="search" name="search" placeholder="Digite o nome do produto">
    <button type="submit">Pesquisar</button>
    <a href="?">Mostrar todos</a>
</form>

    <?php
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "site";

    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Conexão falhou: " . $conn->connect_error);
    }

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        if (isset($_POST['delete'])) {
            $codigo = $_POST['codigo_de_barras'];
            $sql = "DELETE FROM produtos WHERE codigo_de_barras='$codigo'";
            $conn->query($sql);
        } elseif (isset($_POST['edit'])) {
            $codigo = $_POST['codigo_de_barras'];
            $campo = $_POST['campo'];
            $valor = $_POST['valor'];
            $sql = "UPDATE produtos SET $campo='$valor' WHERE codigo_de_barras='$codigo'";
            $conn->query($sql);
        }
    }

    $sql = "SELECT codigo_de_barras, nome, preco FROM produtos";
        // Verifica se foi feita uma pesquisa por nome
        if (isset($_GET['search']) && !empty($_GET['search'])) {
            $search = $_GET['search'];
            $sql .= " WHERE nome LIKE '%$search%'";
        }
    $result = $conn->query($sql);

    echo '<table>';
    echo '<tr><th>Código de Barras</th><th>Nome</th><th>Preço</th><th>Deletar</th></tr>';

    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['codigo_de_barras']} <span class='icon edit-icon' onclick='openEditModal(\"{$row['codigo_de_barras']}\", \"codigo_de_barras\", \"{$row['codigo_de_barras']}\")'>&#x270E;</span></td>
                    <td>{$row['nome']} <span class='icon edit-icon' onclick='openEditModal(\"{$row['codigo_de_barras']}\", \"nome\", \"{$row['nome']}\")'>&#x270E;</span></td>
                    <td>R$ {$row['preco']} <span class='icon edit-icon' onclick='openEditModal(\"{$row['codigo_de_barras']}\", \"preco\", \"{$row['preco']}\")'>&#x270E;</span></td>
                    <td>
                        <form method='POST' action=''>
                            <input type='hidden' name='codigo_de_barras' value='{$row['codigo_de_barras']}'>
                            <button type='submit' name='delete' class='delete-button' onclick='return confirmDelete(\"{$row['codigo_de_barras']}\")'>
                                <span class='icon delete-icon'>&#x1F5D1;</span>
                            </button>
                        </form>
                    </td>
                  </tr>";
        }
    } else {
        echo '<tr><td colspan="4">Nenhum produto encontrado</td></tr>';
    }
    echo '</table>';

    $conn->close();
    ?>

    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeEditModal()">&times;</span>
            <form method="POST" action="">
                <input type="hidden" name="codigo_de_barras" id="editCodigoDeBarras">
                <input type="hidden" name="campo" id="editCampo">
                <label for="valor">Valor:</label>
                <input type="text" id="editValor" name="valor" required>
                <input type="hidden" name="edit" value="1">
                <button type="submit">Salvar</button>
            </form>
        </div>
    </div>
    <script>
        function openEditModal(codigo, campo, valor) {
            document.getElementById('editCodigoDeBarras').value = codigo;
            document.getElementById('editCampo').value = campo;
            document.getElementById('editValor').value = valor;
            document.getElementById('editModal').style.display = "block";
        }

        function closeEditModal() {
            document.getElementById('editModal').style.display = "none";
        }

        function confirmDelete(codigo) {
            return confirm("Você tem certeza que deseja deletar este produto?");
        }
    </script>
</body>
</html>