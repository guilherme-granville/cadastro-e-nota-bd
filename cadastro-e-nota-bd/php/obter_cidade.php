<?php
// Conexão com o banco de dados
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "site";

// Criar conexão
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexão
if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

// Verificar se o parâmetro cliente foi passado
if (isset($_GET['cliente'])) {
    // Obter o cliente da URL
    $cliente = $_GET['cliente'];

    // Consulta SQL para obter a cidade do cliente
    $sql = "SELECT cidade FROM clientes WHERE nome = '$cliente'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Retorna a cidade como resposta
        $row = $result->fetch_assoc();
        echo $row['cidade'];
    } else {
        // Caso não encontre o cliente, retorna uma mensagem de erro
        echo "Não encontrado no Banco de Dados";
    }
}

// Fechar conexão
$conn->close();
?>