-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.32-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para site
CREATE DATABASE IF NOT EXISTS `site` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `site`;

-- Copiando estrutura para tabela site.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `cidade` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela site.clientes: ~39 rows (aproximadamente)
REPLACE INTO `clientes` (`id`, `nome`, `cidade`) VALUES
	(1, 'Arlete', 'Campo Mourão'),
	(2, 'Bazar', 'Toledo'),
	(3, 'Cajú', 'Campo Mourão'),
	(4, 'Casa do Mel', 'Campo Mourão'),
	(5, 'Cíntia', 'Campo Mourão'),
	(6, 'Clair', 'Mercedes'),
	(7, 'Claudinete', 'Vera Cruz'),
	(8, 'Daniel', 'Guaíra'),
	(9, 'Denise', 'Campo Mourão'),
	(10, 'Eloi', 'Toledo'),
	(11, 'Equilíbrio Vital', 'Marechal Cândido Rondon'),
	(12, 'Jorge', 'Umuarama'),
	(13, 'José', 'Campo Mourão'),
	(14, 'Kelly', 'Santa Helena'),
	(15, 'Leonice', 'Toledo'),
	(16, 'Viva Mais', 'Toledo'),
	(17, 'Marly', 'Toledo'),
	(18, 'Rosimere', 'Campo Mourão'),
	(19, 'Neide', 'Tapejara'),
	(20, 'Nice', 'Santa Helena'),
	(21, 'Odete', 'Guaíra'),
	(22, 'Paulo', 'Toledo'),
	(23, 'Valter', 'Marechal Cândido Rondon'),
	(24, 'Rejane', 'Marechal Cândido Rondon'),
	(25, 'Eliane', 'Toledo'),
	(26, 'Laudicéia', 'Terra Boa'),
	(27, 'Esmael', 'Campo Mourão'),
	(28, 'Silmara', 'Campo Mourão'),
	(29, 'Maristela', 'Cascavel'),
	(30, 'Loja Lavanda', 'Vera Cruz'),
	(31, 'Fernanda', 'Marechal Cândido Rondon'),
	(32, 'Célia', 'Assis Chateaubriand'),
	(33, 'Flor de Liz', 'Marechal Cândido Rondon'),
	(34, 'Lucas', 'Tuneiras do Oeste'),
	(35, 'Lurdes', 'Cascavel'),
	(36, 'Sebastião', 'Toledo'),
	(37, 'Leda', 'Mato Grosso'),
	(38, 'Aniz', 'Toledo'),
	(39, 'Cirlei', 'Ponta Grossa'),
	(40, 'Márcia', 'Quatro Pontes');

-- Copiando estrutura para tabela site.produtos
CREATE TABLE IF NOT EXISTS `produtos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_de_barras` varchar(255) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela site.produtos: ~31 rows (aproximadamente)
REPLACE INTO `produtos` (`id`, `codigo_de_barras`, `nome`, `preco`) VALUES
	(1, '7898638811050', 'Amargo life 500ml', 12.90),
	(2, '7898231021897', 'Extrato de 39 Ervas 500ml', 12.90),
	(3, '7898231020590', 'Açaí Power 500ml', 12.90),
	(4, '7898909633985', 'Amargo Tea 500ml', 13.90),
	(5, '7898638810640', 'Aloe Vera 500ml', 13.90),
	(6, '78234055698937', 'Extrato de Amora 500ml', 12.90),
	(7, '7898638810626', 'Ácido Úrico 500ml', 12.90),
	(8, '7898638811180', 'Anti-depressivo 500ml', 12.90),
	(9, '7893405569899', 'Artrodor 500ml', 12.90),
	(10, '7898638811210', 'Bio Max 500ml', 12.90),
	(11, '7898638811326', 'Calmo Life 500ml', 12.90),
	(12, '7898638812323', 'Canela de Velho e Sucupira 500ml', 12.90),
	(13, '7898638812637', 'Canela de Velho Composta 500ml', 12.90),
	(14, '7898638812316', 'Canela de Velho 500ml', 12.90),
	(16, '7898638812613', 'Canela de Velho com Cloreto de Magnésio 500ml', 12.90),
	(17, '78934055698912', 'Emagre Life 500ml', 12.90),
	(18, '7898638812231', 'Elixir de Inhame 500ml', 12.90),
	(19, '7823405560000', 'Diuretic Life 500ml', 12.90),
	(20, '7898638812712', 'Colesterim 500ml', 12.90),
	(21, '7898231020842', 'Clorofilla 500ml', 12.90),
	(22, '7898638812033', 'Extrato Super Concentrado 500ml', 12.90),
	(23, '7898638811197', 'Stressfim 500ml', 12.90),
	(24, '7898638812781', 'Estigma de Milho 500ml', 12.90),
	(25, '7490818846991', 'Espinheira Santa 500ml', 12.90),
	(26, '7898638811036', 'Espinheira Santa 500ml', 12.90),
	(27, '7898638811807', 'Enzima Vegetal 500ml', 12.90),
	(28, '7898638811869', 'Flor da Noite 500ml', 12.90),
	(29, '7898638810749', 'Glico Life 500ml', 12.90),
	(30, '7898638811227', 'Graviola 500ml', 12.90),
	(31, '7898638811449', 'Harp 500ml', 12.90),
	(32, '7893405569929', 'Inflama Zero 500ml', 12.90);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
