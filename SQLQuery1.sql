USE dbFotografia;

CREATE TABLE Cliente (
    idCliente INT IDENTITY (1,1),
    nomeCliente VARCHAR(100) NOT NULL,
    telefoneResidencial VARCHAR(10),
    telefoneComercial VARCHAR(11),
    telefoneCelular VARCHAR(11),
    numeroEndereco INT NOT NULL,
    complemento VARCHAR(20),
	CONSTRAINT PkCliente PRIMARY KEY (idCliente)
);

INSERT INTO Cliente (nomeCliente, telefoneResidencial, telefoneComercial, telefoneCelular, numeroEndereco, complemento) 
VALUES
	('Carolina Oliveira', '9876543210', '1112223333', '11987654321', 303, 'Bloco B'),
    ('Pedro Rodrigues', '1234567890', '9998887777', '11912345678', 404, 'Cobertura'),
    ('Mariana Silva', NULL, NULL, '11923456789', 505, 'Casa dos Fundos');

CREATE TABLE Funcionario (
    idFuncionario INT IDENTITY (1,1),
    nomeFuncionario VARCHAR(100) NOT NULL,
    telefoneResidencial VARCHAR(10),
	telefoneComercial VARCHAR (11),
	telefoneCelular VARCHAR (11),
	numeroEndereco INT NOT NULL,
	complemento VARCHAR (20),
	CONSTRAINT PkFuncionario PRIMARY KEY (idFuncionario)
);

-- Inserindo dados Funcionario
INSERT INTO Funcionario (nomeFuncionario, telefoneResidencial, telefoneComercial, telefoneCelular, numeroEndereco, complemento) 
VALUES
	('Rodrigo Oliveira', '9876543210', '1112223333', '11987654321', 101, 'Bloco C'),
    ('Aline Pereira', '1234567890', '9998887777', '11912345678', 202, 'Andar 7'),
    ('Bruno Silva', NULL, NULL, '11923456789', 303, 'Casa Principal');

CREATE TABLE Endereco (
    idEndereco INT IDENTITY (1,1),
    logradouro VARCHAR(80) NOT NULL,
    numero VARCHAR(5) NOT NULL,
    complemento VARCHAR(50),
    bairro VARCHAR(30) NOT NULL,
    cidade VARCHAR(30) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(8) NOT NULL,
	CONSTRAINT PkEndereco PRIMARY KEY (idEndereco)
);

INSERT INTO Endereco (logradouro, numero, complemento, bairro, cidade, estado, cep) 
VALUES
	('Rua dos Girassóis', '456', 'Bloco B', 'Jardim Botânico', 'Rio de Janeiro', 'RJ', '22041010'),
    ('Avenida Atlântica', '1000', 'Cobertura', 'Copacabana', 'Rio de Janeiro', 'RJ', '22041000'),
    ('Rua das Palmeiras', '30', 'Casa dos Fundos', 'Botafogo', 'Rio de Janeiro', 'RJ', '22050020'),
    ('Rua Minas Gerais', '250', 'Apto 404', 'Centro', 'Belo Horizonte', 'MG', '30160030'),
    ('Avenida Getúlio Vargas', '500', 'Casa 1', 'São José', 'Belo Horizonte', 'MG', '30160050');

-- Tabela Cliente Endereco
CREATE TABLE ClienteEndereco (
    idCliente INT,
    idEndereco INT,
    tipoEndereco VARCHAR(20),
    CONSTRAINT PkClienteEndereco PRIMARY KEY (idCliente, idEndereco),
    CONSTRAINT FkCliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    CONSTRAINT FkEnderecoC FOREIGN KEY (idEndereco) REFERENCES Endereco(idEndereco)
);

-- Inserindo dados Cliente Endereco
INSERT INTO ClienteEndereco (idCliente, idEndereco, tipoEndereco) 
VALUES
	(4, 4, 'Residencial'),
	(5, 5, 'Comercial'),
	(6, 1, 'Comercial');

-- Tabela Funcionario Endereco 
CREATE TABLE FuncionarioEndereco (
    idFuncionario INT,
    idEndereco INT,
    tipoEndereco VARCHAR(20),
    CONSTRAINT PkFuncionarioEndereco PRIMARY KEY (idFuncionario, idEndereco),
    CONSTRAINT FkFuncionario FOREIGN KEY (idFuncionario) REFERENCES Funcionario(idFuncionario),
    CONSTRAINT FkEnderecoF FOREIGN KEY (idEndereco) REFERENCES Endereco(idEndereco)
);

-- Inserindo dados Funcionario Endereco
INSERT INTO FuncionarioEndereco (idFuncionario, idEndereco, tipoEndereco) 
VALUES
	(3, 3, 'Comercial'),
	(1, 2, 'Residencial');

-- Tabela Pessoa Fisica 
CREATE TABLE PessoaFisica (
    idCliente INT NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
	rg VARCHAR(9) NOT NULL UNIQUE,
    dataNascimento DATE NOT NULL,
	sexo CHAR,
	CONSTRAINT PkPessoaFisica PRIMARY KEY (idCliente, cpf),
    CONSTRAINT FkClientePF FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Inserindo dados na tabela Pessoa Fisica
INSERT INTO PessoaFisica (idCliente, cpf, rg, dataNascimento, sexo) 
VALUES
	(4, '01234567890', 'RJ1234567', '1985-10-25', 'F'),
    (5, '87654321098', 'BH654321', '1990-03-20', 'M');

-- Tabela PessoaJ uridica 
CREATE TABLE PessoaJuridica (
    idCliente INT NOT NULL,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    razaoSocial VARCHAR(100) NOT NULL,
	inscEstadual VARCHAR(14) NOT NULL,
	nomeResponsavel VARCHAR (100) NOT NULL,
	CONSTRAINT PkPessoaJuridica PRIMARY KEY (idCliente, cnpj),
    CONSTRAINT FkClientePJ FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Inserindo dados Pessoa Juridica
INSERT INTO PessoaJuridica (idCliente, cnpj, razaoSocial, inscEstadual, nomeResponsavel) 
VALUES
	(6, '09876543210098', 'Empresa Y S/A', 'IE0987654321', 'João Silva');

-- Tabela Produtos
CREATE TABLE Produto (
    idProduto INT IDENTITY (1,1),
    nomeProduto VARCHAR(100) NOT NULL,
    descricaoProduto VARCHAR(200),
    precoCusto DECIMAL(10, 2) NOT NULL,
	precoVenda DECIMAL (10,2) NOT NULL,
    estoqueProduto INT NOT NULL,
	quantidadeMinima INT NOT NULL,
	CONSTRAINT PkProduto PRIMARY KEY (idProduto)
);

-- Inserindo dados Produto
INSERT INTO Produto (nomeProduto, descricaoProduto, precoCusto, precoVenda, estoqueProduto, quantidadeMinima) 
VALUES
	('Câmera', 'Câmera fotográfica compacta e versátil', 2000.00, 2500.00, 10, 2),
    ('Flash', 'Flash portátil para iluminação em fotos', 300.00, 400.00, 20, 5);

-- Tabela Categorias
CREATE TABLE Categoria (
    idCategoria INT IDENTITY (1,1),
    nomeCategoria VARCHAR(100) NOT NULL,
	CONSTRAINT PkCategoria PRIMARY KEY (idCategoria)
);

-- Inserindo dados Categoria
INSERT INTO Categoria (nomeCategoria) 
VALUES
	('Câmeras'),
	('Flash');

-- Tabela Categoria Produto
CREATE TABLE ProdutoCategoria (
    idProduto INT,
    idCategoria INT,
    CONSTRAINT PkProdutoCategoria PRIMARY KEY (idProduto, idCategoria),
    CONSTRAINT FkProduto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    CONSTRAINT FkCategoria FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria)
);

-- Dados na tabela Categoria Produto
INSERT INTO ProdutoCategoria (idProduto, idCategoria) 
VALUES
	(1, 1), -- Camera
	(2, 2); -- Flash

-- Tabela Vendas
CREATE TABLE Venda (
    idVenda INT IDENTITY (1,1),
    idCliente INT NOT NULL,
	idFuncionario INT NOT NULL,
    dataVenda DATE NOT NULL,
    totalVenda DECIMAL(10, 2) NOT NULL,
	condicaoVenda VARCHAR (10) NOT NULL,
	CONSTRAINT PkVenda PRIMARY KEY (idVenda),
    CONSTRAINT FkClienteV FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
	CONSTRAINT FkFuncionarioV FOREIGN KEY (idFuncionario) REFERENCES Funcionario(idFuncionario)
);

-- Dados na tabela Venda
INSERT INTO Venda (idCliente, idFuncionario, dataVenda, totalVenda, condicaoVenda) 
VALUES
	(4, 3, '2023-05-03', 4500.00, 'A vista'),
    (5, 1, '2023-05-04', 1200.00, 'A vista');

-- Tabela ItensVenda itens vendidos em cada venda
CREATE TABLE ItemVenda (
    idVenda INT,
    idProduto INT,
    quantidade INT NOT NULL,
    totalItem DECIMAL(10, 2) NOT NULL,
	CONSTRAINT PkItemVenda PRIMARY KEY (idVenda, idProduto),
    CONSTRAINT FkVenda FOREIGN KEY (idVenda) REFERENCES Venda(idVenda),
    CONSTRAINT FkProdutoIV FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

-- Dados na tabela ItemVenda
INSERT INTO ItemVenda (idVenda, idProduto, quantidade, totalItem) 
VALUES
	(1, 1, 1, 5000.00), -- Venda de 2 Câmeras 
    (1, 2, 1, 400.00),  -- Venda de 1 Flash 
    (2, 2, 1, 800.00);  -- Venda de 2 Flash 

SELECT * FROM Cliente;
SELECT * FROM Funcionario;
SELECT * FROM Endereco;
SELECT * FROM ClienteEndereco;
SELECT * FROM FuncionarioEndereco;
SELECT * FROM PessoaFisica;
SELECT * FROM PessoaJuridica;
SELECT * FROM Produto;
SELECT * FROM Categoria;
SELECT * FROM ProdutoCategoria;
SELECT * FROM Venda;
SELECT * FROM ItemVenda;


WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER ( ORDER BY (SELECT NULL)) AS RowNumber
    FROM Cliente
)
DELETE FROM CTE
WHERE RowNumber > 1;

