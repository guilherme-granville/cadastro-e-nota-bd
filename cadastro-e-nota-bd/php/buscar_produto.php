<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "site";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

if (isset($_GET['codBarras'])) {
    $codBarras = $_GET['codBarras'];

    $sql = "SELECT nome, preco FROM produtos WHERE codigo_barras = '$codBarras'";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        
        $produto = array(
            "codBarras" => $codBarras,
            "nome" => $row["nome"],
            "preco" => $row["preco"]
        );

        echo json_encode($produto);
    } else {
        echo "";
    }
}

$conn->close();
?>