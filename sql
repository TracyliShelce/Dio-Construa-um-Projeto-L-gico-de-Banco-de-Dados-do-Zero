CREATE DATABASE OFICINA;

USE OFICINA;

CREATE TABLE Cliente (
	id INT NOT NULL IDENTITY(1, 1),
	Nome VARCHAR(100) NOT NULL,
	Telefone VARCHAR(25) NOT NULL,
	Email VARCHAR(100),
	CONSTRAINT pk_Cliente_id PRIMARY KEY (id)
);

CREATE TABLE StatusOrdemServico (
	id INT NOT NULL IDENTITY(1, 1),
	Identificacao VARCHAR(45) NOT NULL,
	CONSTRAINT unique_StatusOrdemServico_Identificacao UNIQUE (Identificacao),
	CONSTRAINT pk_StatusOrdemServico_id PRIMARY KEY (id)
);

CREATE TABLE OrdemServico (
	id INT NOT NULL IDENTITY(1, 1),
	idCliente INT NOT NULL,
	idStatusOrdemServico INT NOT NULL,
	Codigo VARCHAR(10) NOT NULL,
	DataEmissao DATETIME NOT NULL,
	DataParaConclusao DATETIME,
	Valor DECIMAL(18,2),
	DataAutorizacao DATETIME,
	Obs TEXT,
	CONSTRAINT unique_OrdemServico_Codigo UNIQUE (Codigo),
	CONSTRAINT pk_OrdemServico_id PRIMARY KEY (id),
	CONSTRAINT fk_OrdemServico_idCliente_Cliente_id FOREIGN KEY (idCliente) REFERENCES Cliente(id),
	CONSTRAINT fk_OrdemServico_idStatusOrdemServico_StatusOrdemServico_id FOREIGN KEY (idStatusOrdemServico) REFERENCES StatusOrdemServico(id)
);

CREATE TABLE Marca (
	id INT NOT NULL IDENTITY(1, 1),
	Identificacao VARCHAR(45) NOT NULL,
	CONSTRAINT unique_Marca_Identificacao UNIQUE (Identificacao),
	CONSTRAINT pk_Marca_id PRIMARY KEY (id)
);

CREATE TABLE Modelo (
	id INT NOT NULL IDENTITY(1, 1),
	idMarca INT NOT NULL,
	Identificacao VARCHAR(45) NOT NULL,
	Ano INT NOT NULL,
	CONSTRAINT unique_Modelo_Identificacao UNIQUE (Identificacao),
	CONSTRAINT pk_Modelo_id PRIMARY KEY (id),
	CONSTRAINT fk_Modelo_idMarca_Marca_id FOREIGN KEY (idMarca) REFERENCES Marca(id)
);

CREATE TABLE Equipe (
	id INT NOT NULL IDENTITY(1, 1),
	Identificacao VARCHAR(45) NOT NULL,
	CONSTRAINT unique_Equipe_Identificacao UNIQUE (Identificacao),
	CONSTRAINT pk_Equipe_id PRIMARY KEY (id)
);

CREATE TABLE StatusServico (
	id INT NOT NULL IDENTITY(1, 1),
	Identificacao VARCHAR(45) NOT NULL,
	CONSTRAINT unique_StatusServico_Identificacao UNIQUE (Identificacao),
	CONSTRAINT pk_StatusServico_id PRIMARY KEY (id)
);

CREATE TABLE TabelaServico (
	id INT NOT NULL IDENTITY(1, 1),
	Identificacao VARCHAR(100) NOT NULL,
	ValorTabela DECIMAL(18,2),
	CONSTRAINT unique_TabelaServico_Identificacao UNIQUE (Identificacao),
	CONSTRAINT pk_TabelaServico_id PRIMARY KEY (id)
);

CREATE TABLE Veiculo (
	id INT NOT NULL IDENTITY(1, 1),
	idOrdemServico INT NOT NULL,
	idModelo INT NOT NULL,
	Cor INT NOT NULL,
	Placa VARCHAR(20),
	CONSTRAINT pk_Veiculo_id PRIMARY KEY (id),
	CONSTRAINT fk_Veiculo_idOrdemServico_OrdemServico_id FOREIGN KEY (idOrdemServico) REFERENCES OrdemServico(id),
	CONSTRAINT fk_Veiculo_idModelo_Modelo_id FOREIGN KEY (idModelo) REFERENCES Modelo(id)
);

CREATE TABLE Servico (
	id INT NOT NULL IDENTITY(1, 1),
	idVeiculo INT NOT NULL,
	idTabelaServico INT NOT NULL,
	idEquipe INT NOT NULL,
	idStatusServico INT NOT NULL,
	Descricao TEXT NOT NULL,
	ValorPecas DECIMAL(18,2) NOT NULL,
	ValorMaoDeObra DECIMAL(18,2) NOT NULL,
	DataInicio DATETIME,
	DataTermino DATETIME,
	CONSTRAINT pk_Servico_id PRIMARY KEY (id),
	CONSTRAINT fk_Servico_idVeiculo_Veiculo_id FOREIGN KEY (idVeiculo) REFERENCES Veiculo(id),
	CONSTRAINT fk_Servico_idTabelaServico_TabelaServico_id FOREIGN KEY (idTabelaServico) REFERENCES TabelaServico(id),
	CONSTRAINT fk_Servico_idEquipe_Equipe_id FOREIGN KEY (idEquipe) REFERENCES Equipe(id),
	CONSTRAINT fk_Servico_idStatusServico_StatusServico_id FOREIGN KEY (idStatusServico) REFERENCES StatusServico(id)
);

CREATE TABLE Especialidade (
	id INT NOT NULL IDENTITY(1, 1),
	Identificacao VARCHAR(45) NOT NULL,
	CONSTRAINT unique_Especialidade_Identificacao UNIQUE (Identificacao),
	CONSTRAINT pk_Especialidade_id PRIMARY KEY (id)
);

CREATE TABLE Mecanico (
	id INT NOT NULL IDENTITY(1, 1),
	idEspecialidade INT NOT NULL,
	idEquipe INT NOT NULL,
	Codigo VARCHAR(45) NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	CEP VARCHAR(10) NOT NULL,
	Logradouro VARCHAR(150) NOT NULL,
	Numero VARCHAR(10) NOT NULL,
	Complemento VARCHAR(10),
	CONSTRAINT unique_Mecanico_Codigo UNIQUE (Codigo),
	CONSTRAINT pk_Mecanico_id PRIMARY KEY (id),
	CONSTRAINT fk_Mecanico_idEspecialidade_Especialidade_id FOREIGN KEY (idEspecialidade) REFERENCES Especialidade(id),
	CONSTRAINT fk_Mecanico_idEquipe_Equipe_id FOREIGN KEY (idEquipe) REFERENCES Equipe(id)
);

CREATE TABLE Peca (
	id INT NOT NULL IDENTITY(1, 1),
	Identificacao VARCHAR(45) NOT NULL,
	ValorReferencia DECIMAL(18,2) NOT NULL,
	CONSTRAINT unique_Peca_Identificacao UNIQUE (Identificacao),
	CONSTRAINT pk_Peca_id PRIMARY KEY (id)
);

CREATE TABLE ServicoPeca (
	id INT NOT NULL IDENTITY(1, 1),
	idServico INT NOT NULL,
	idPeca INT NOT NULL,
	ValorPeca DECIMAL(18,2) NOT NULL,
	CONSTRAINT pk_ServicoPeca_id PRIMARY KEY (id),
	CONSTRAINT fk_ServicoPeca_idServico_Servico_id FOREIGN KEY (idServico) REFERENCES Servico(id),
	CONSTRAINT fk_ServicoPeca_idPeca_Peca_id FOREIGN KEY (idPeca) REFERENCES Peca(id)
);
 74  
4-Construa_um_Projeto_Logico_de_Banco_de_Dados_do_Zero/2_insert.sql
@@ -0,0 +1,74 @@
INSERT INTO Cliente (Nome, Telefone, Email) VALUES ('Manoel Osvaldo Paulo da Mota', '(74)9951.9880', 'manoel@osvaldo.com');
INSERT INTO Cliente (Nome, Telefone, Email) VALUES ('Nicole Jéssica', '(80)58050.4239', 'nicole@jessica.com');
INSERT INTO Cliente (Nome, Telefone, Email) VALUES ('Liz Mariana Mirella', '(36)91132.0658', 'liz@mariana.com');
INSERT INTO Cliente (Nome, Telefone, Email) VALUES ('Luan Calebe Ramos', '(21)40934-6790', 'luan@calebe.com');
INSERT INTO Cliente (Nome, Telefone, Email) VALUES ('Manoel Osvaldo Paulo da Mota LTDA.', '(33)75364-5000', 'manoel@osvaldo.com');

INSERT INTO StatusOrdemServico (Identificacao) VALUES ('ABERTO');
INSERT INTO StatusOrdemServico (Identificacao) VALUES ('EM ANDAMENTO');
INSERT INTO StatusOrdemServico (Identificacao) VALUES ('EM PAUSA');
INSERT INTO StatusOrdemServico (Identificacao) VALUES ('CANCELADO');
INSERT INTO StatusOrdemServico (Identificacao) VALUES ('CONCLUÍDO');

INSERT INTO OrdemServico (idCliente, idStatusOrdemServico, Codigo, DataEmissao, DataParaConclusao, Valor, DataAutorizacao, Obs) VALUES (1, 1, '0000000001', '2022-09-09', null, 250, '2022-09-08', null);
INSERT INTO OrdemServico (idCliente, idStatusOrdemServico, Codigo, DataEmissao, DataParaConclusao, Valor, DataAutorizacao, Obs) VALUES (2, 1, '0000000002', '2022-09-10', null, 123, '2022-09-08', null);

INSERT INTO Marca (Identificacao) VALUES ('Ford');
INSERT INTO Marca (Identificacao) VALUES ('Renault');
INSERT INTO Marca (Identificacao) VALUES ('Volkswagen');
INSERT INTO Marca (Identificacao) VALUES ('Fiat');

INSERT INTO Modelo (idMarca, Identificacao, Ano) VALUES (1, 'KA', 2015);
INSERT INTO Modelo (idMarca, Identificacao, Ano) VALUES (1, 'Fiesta', 2013);
INSERT INTO Modelo (idMarca, Identificacao, Ano) VALUES (2, 'Gol', 2015);
INSERT INTO Modelo (idMarca, Identificacao, Ano) VALUES (3, 'Fiat', 2010);

INSERT INTO Equipe (Identificacao) VALUES ('Borracharia');
INSERT INTO Equipe (Identificacao) VALUES ('Pintura');
INSERT INTO Equipe (Identificacao) VALUES ('Funilaria');
INSERT INTO Equipe (Identificacao) VALUES ('Mecanica');
INSERT INTO Equipe (Identificacao) VALUES ('Elétrica');

INSERT INTO StatusServico (Identificacao) VALUES ('A FAZER');
INSERT INTO StatusServico (Identificacao) VALUES ('FAZENDO');
INSERT INTO StatusServico (Identificacao) VALUES ('AGUARANDO PEÇA');
INSERT INTO StatusServico (Identificacao) VALUES ('CANCELADO');
INSERT INTO StatusServico (Identificacao) VALUES ('CONCLUÍDO');

INSERT INTO TabelaServico (Identificacao, ValorTabela) VALUES ('Pintura geral', 2000);
INSERT INTO TabelaServico (Identificacao, ValorTabela) VALUES ('Troca do motor', 1500);
INSERT INTO TabelaServico (Identificacao, ValorTabela) VALUES ('Troca de lampada do farol', 30);
INSERT INTO TabelaServico (Identificacao, ValorTabela) VALUES ('Troca de pneu', 50);
INSERT INTO TabelaServico (Identificacao, ValorTabela) VALUES ('Alinhamento', 50);

INSERT INTO Veiculo (idOrdemServico, idModelo, Cor, Placa) VALUES (1, 1, 250025, 2015);
INSERT INTO Veiculo (idOrdemServico, idModelo, Cor, Placa) VALUES (1, 2, 250025, 2013);
INSERT INTO Veiculo (idOrdemServico, idModelo, Cor, Placa) VALUES (3, 3, 250025, 2015);
INSERT INTO Veiculo (idOrdemServico, idModelo, Cor, Placa) VALUES (3, 4, 250025, 2010);

INSERT INTO Servico (idVeiculo, idTabelaServico, idEquipe, idStatusServico, Descricao, ValorPecas, ValorMaoDeObra, DataInicio, DataTermino) VALUES (1, 1, 1, 1, 'Trocar Pneu', 0, 50, '2022-09-10', '2022-09-10');
INSERT INTO Servico (idVeiculo, idTabelaServico, idEquipe, idStatusServico, Descricao, ValorPecas, ValorMaoDeObra, DataInicio, DataTermino) VALUES (2, 2, 2, 2, 'Instalar som', 1500, 250, '2022-09-10', '2022-09-10');
INSERT INTO Servico (idVeiculo, idTabelaServico, idEquipe, idStatusServico, Descricao, ValorPecas, ValorMaoDeObra, DataInicio, DataTermino) VALUES (3, 3, 3, 3, 'Trocar palamala', 1000, 300, '2022-09-10', '2022-09-10');
INSERT INTO Servico (idVeiculo, idTabelaServico, idEquipe, idStatusServico, Descricao, ValorPecas, ValorMaoDeObra, DataInicio, DataTermino) VALUES (4, 4, 4, 4, 'Consertar motor', 100, 1000, '2022-09-10', '2022-09-10');

INSERT INTO Especialidade (Identificacao) VALUES ('Trocar Pneu');
INSERT INTO Especialidade (Identificacao) VALUES ('Pintar');
INSERT INTO Especialidade (Identificacao) VALUES ('Lixar');
INSERT INTO Especialidade (Identificacao) VALUES ('Mecanica Hidráulico');
INSERT INTO Especialidade (Identificacao) VALUES ('Instalar som');

INSERT INTO Mecanico (idEspecialidade, idEquipe, Codigo, Nome, CEP, Logradouro, Numero,	Complemento) VALUES (1, 1, 'JÃO', 'João da Silva', '00000-000', 'Rua..', 'S/N', null);
INSERT INTO Mecanico (idEspecialidade, idEquipe, Codigo, Nome, CEP, Logradouro, Numero,	Complemento) VALUES (2, 2, 'ZeH', 'José da Silva', '00000-000', 'Rua..', 'S/N', null);
INSERT INTO Mecanico (idEspecialidade, idEquipe, Codigo, Nome, CEP, Logradouro, Numero,	Complemento) VALUES (3, 3, 'Bora Bill!', 'Bora Bill!', '00000-000', 'Rua..', 'S/N', null);
INSERT INTO Mecanico (idEspecialidade, idEquipe, Codigo, Nome, CEP, Logradouro, Numero,	Complemento) VALUES (4, 4, 'Fil do Bill', 'Fil do Bill', '00000-000', 'Rua..', 'S/N', null);

INSERT INTO Peca (Identificacao, ValorReferencia) VALUES ('Tinta Galão', 150);
INSERT INTO Peca (Identificacao, ValorReferencia) VALUES ('Óloe 1lt', 40);
INSERT INTO Peca (Identificacao, ValorReferencia) VALUES ('Lâmpada do farol', 30);
INSERT INTO Peca (Identificacao, ValorReferencia) VALUES ('Pneu', 450);
INSERT INTO Peca (Identificacao, ValorReferencia) VALUES ('Filtro de óleo', 50);

INSERT INTO ServicoPeca (idServico, idPeca, ValorPeca) VALUES (1, 1, 50);
INSERT INTO ServicoPeca (idServico, idPeca, ValorPeca) VALUES (2, 2, 50);
INSERT INTO ServicoPeca (idServico, idPeca, ValorPeca) VALUES (3, 3, 50);
INSERT INTO ServicoPeca (idServico, idPeca, ValorPeca) VALUES (4, 4, 50);
 22  
4-Construa_um_Projeto_Logico_de_Banco_de_Dados_do_Zero/3_queries_diversas.sql
@@ -0,0 +1,22 @@
-- Recuperações simples com SELECT Statement
select * from dbo.Cliente;

-- Filtros com WHERE Statement
select * from dbo.Cliente where Nome like 'L%';

-- Crie expressões para gerar atributos derivados
select (sum(ValorPecas)+sum(ValorMaoDeObra)) as ValorTotal from dbo.Servico;

-- Defina ordenações dos dados com ORDER BY
select Descricao, (ValorPecas + ValorMaoDeObra) as Total from dbo.Servico order by Total desc;

-- Condições de filtros aos grupos – HAVING Statement
select idPeca from dbo.ServicoPeca group by idPeca having count(idPeca)>1;

-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados
select c.Nome
    from dbo.Cliente c
    inner join dbo.OrdemServico o on c.id = o.idCliente
    inner join dbo.StatusOrdemServico so on so.id = o.idStatusOrdemServico
    WHERE
    so.Identificacao = 'ABERTO'
    -----------------------------
