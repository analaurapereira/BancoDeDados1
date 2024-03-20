-- CRIANDO TABELA EMPREGADOS
CREATE TABLE tb_empregados(
rg 					VARCHAR(11),
nm_empregado		VARCHAR(40),
idade				INTEGER,
CONSTRAINT pk_tb_empregados_rg PRIMARY KEY(rg)
);
DROP TABLE tb_empregados CASCADE;

--CRIANDO TABELA PEDIDOS
CREATE TABLE tb_pedidos(
nr_pedido		INTEGER,
desc_pedido		VARCHAR(20),
data_pedido		DATE,
CONSTRAINT pk_tb_pedidos_numero PRIMARY KEY(nr_pedido)
);

--CRIANDO TABELA ITENS
--DROP TABLE tb_itens CASCADE(apagar tabela)
CREATE TABLE tb_itens(
nr_pedido			INTEGER,
nr_item				INTEGER,
nm_produto			VARCHAR(40),
quantidade			INTEGER,
CONSTRAINT pk_tb_itens_nr_pedido_nr_item PRIMARY KEY(nr_pedido, nr_item),
CONSTRAINT fk_tb_itens_nr_pedido FOREIGN KEY(nr_pedido)
	REFERENCES tb_pedidos(nr_pedido)
)

--CRIANDO NOVA VERSÃO DA TABELA EMPREGADOS
CREATE TABLE tb_empregados(
rg				VARCHAR(11),
nm_empregado	VARCHAR(60),
idade			INTEGER,
plano_saude		VARCHAR(10),
rua  			VARCHAR(20),
numero			VARCHAR(5),
cidade			VARCHAR(30),
CONSTRAINT pk_tb_empregados_rg PRIMARY KEY(rg)
);

--CRIANDO TABELA TELEFONES
CREATE TABLE tb_telefones(
rg				VARCHAR(11),
nr_telefone		VARCHAR(15),
CONSTRAINT pk_tb_telefones_rg_nr PRIMARY KEY(rg, nr_telefone),
CONSTRAINT fk_tb_telefones_rg FOREIGN KEY(rg)
	REFERENCES tb_empregados(rg)
);

--CRIANDO TABELA SERVIDORES
CREATE TABLE tb_servidores(
cpf				VARCHAR(11),
nome_servidor	VARCHAR(40),
CONSTRAINT pk_tb_servidores_cpf PRIMARY KEY(cpf)
);

--CRIANDO TABELA FUNCIONARIOS
CREATE TABLE tb_funcionarios(
cpf			VARCHAR(11),
ds_funcao	VARCHAR(20),
CONSTRAINT pk_tb_funcionarios_cpf PRIMARY KEY(cpf),
CONSTRAINT fk_tb_funcionarios_cpf FOREIGN KEY(cpf)
	REFERENCES tb_servidores(cpf)
);

--CRIANDO TABELA PROFESSORES
CREATE TABLE tb_professores(
cpf			VARCHAR(11),
titulacao	VARCHAR(15),
categoria	VARCHAR(15),
CONSTRAINT pk_tb_professores_cpf PRIMARY KEY(cpf),
CONSTRAINT fk_tb_professores_cpf FOREIGN KEY(cpf)
	REFERENCES tb_servidores(cpf)
);

--CRIANDO TABELA PESSOAS
CREATE TABLE tb_pessoas(
codigo			INTEGER,
nm_pessoa		VARCHAR(40),
CONSTRAINT pk_tb_pessoas_codigo PRIMARY KEY(codigo)
);

--CRIANDO TABELA CNH
CREATE TABLE tb_cnh(
nr_cnh			INTEGER,
dt_expedicao	DATE,
validade		DATE,
categoria		VARCHAR(6),
codigo			INTEGER CONSTRAINT nn_tb_cnh_codigo NOT NULL
						CONSTRAINT uq_tb_cnh_codigo UNIQUE,
dt_retirada		DATE,
CONSTRAINT pk_tb_cnh_nr_cnh PRIMARY KEY(nr_cnh),
CONSTRAINT fk_tb_cnh_codigo FOREIGN KEY(codigo)
	REFERENCES tb_pessoas(codigo)
);