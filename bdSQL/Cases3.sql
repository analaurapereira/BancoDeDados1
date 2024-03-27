--CRIANDO O OBJETO tb_clientes
CREATE TABLE tb_clientes(
rg_clientes			VARCHAR(11),
nm_clientes			VARCHAR(60),
dt_nascimento		DATE,
CONSTRAINT pk_tb_clientes_rg_clientes PRIMARY KEY(rg_clientes)
);

--CRIANDO O OBJETO tb_bibliotecarias
CREATE TABLE tb_bibliotecarias(
rg_bibli			VARCHAR(11),
nm_bibli			VARCHAR(60),
dt_nascimento		DATE,
CONSTRAINT ok_tb_blibliotecarias_rg_bibli PRIMARY KEY(rg_bibli)
);

--CRIANDO O OBJETO tb_livros
CREATE TABLE tb_livros(
cod				INTEGER,
ds_livro		VARCHAR(25),
ds_categoria	VARCHAR(15),
rg_cliente		VARCHAR(11),
dt_devolucao	DATE,
rg_bibli		VARCHAR(11),
CONSTRAINT pk_tb_livros_cod	PRIMARY KEY(cod),
CONSTRAINT fk_tb_livros_rg_clientes FOREIGN KEY(rg_cliente)
	REFERENCES tb_clientes(rg_clientes),
CONSTRAINT fk_tb_livros_rg_bibli FOREIGN KEY(rg_bibli)
	REFERENCES tb_bibliotecarias(rg_bibli)
);

--REMOVENTO A TABELA tb_clientes
DROP TABLE tb_clientes CASCADE;

--RECRIANDO O OBJETO tb_clientes
CREATE TABLE tb_clientes(
rg_clientes			VARCHAR(11),
nm_clientes			VARCHAR(60),
dt_nascimento		DATE,
CONSTRAINT pk_tb_clientes_rg_clientes PRIMARY KEY(rg_clientes)
);

-- CRIANDO O OBJETO tb_contas
CREATE TABLE tb_contas(
nr_conta		INTEGER,
ds_conta		VARCHAR(15),
dt_abertura		DATE,
CONSTRAINT pk_tb_contas_nr_conta PRIMARY KEY(nr_conta)
);

--CRIANDO A TABELA tb_correntistas
CREATE TABLE tb_correntistas(
rg_clientes			VARCHAR(11),
nr_conta			INTEGER,
CONSTRAINT pk_tb_correntistas_rg_nr PRIMARY KEY(rg_clientes, nr_conta),
CONSTRAINT fk_tb_correntistas_rg_clientes FOREIGN KEY(rg_clientes)
	REFERENCES tb_clientes(rg_clientes),
CONSTRAINT fk_tb_correntistas_nr_conta FOREIGN KEY(nr_conta)
	REFERENCES tb_contas(nr_conta)
);

--CRIANDO O OBJETO tb_cartoes_magneticos
CREATE TABLE tb_cartoes_magneticos(
nr_cartoes			INTEGER,
dt_expedicao		DATE,
rg_clientes			VARCHAR(11) CONSTRAINT nn_tb_cm_rg_clientes NOT NULL,
nr_conta			INTEGER CONSTRAINT nn_tb_cm_nr_conta NOT NULL,
CONSTRAINT pk_tb_cm_nr_cartao PRIMARY KEY(nr_cartoes),
CONSTRAINT fk_tb_cm_rg_clientes FOREIGN KEY(rg_clientes)
	REFERENCES tb_clientes(rg_clientes),
CONSTRAINT fk_tb_cm_nr_conta FOREIGN KEY(nr_conta)
	REFERENCES tb_contas(nr_conta)
);

--CRIANDO O OBJETO tb_instituicao
CREATE TABLE tb_instituicoes(
sigla			CHAR(3),
nm_instituicao	VARCHAR(60),
CONSTRAINT pk_tb_instituicoes_sigla PRIMARY KEY(sigla)
);

--CRIANDO O OBJETO tb_projetos
CREATE TABLE tb_projetos(
nr_projeto		INTEGER,
ds_projeto		VARCHAR(25),
CONSTRAINT pk_tb_projetos_nr_projeto PRIMARY KEY(nr_projeto)
);

--CRIANDO O OBJETO tb_pesquisadores
CREATE TABLE tb_pesquisadores(
rg_pesquisador			VARCHAR(11),
nm_pesquisador			VARCHAR(60),
titulacao				VARCHAR(15),
CONSTRAINT pk_tb_pesquisadores_rg_pesquisador PRIMARY KEY(rg_pesquisador)
);

--CRIANDO O OBJETO tb_pesquisas
CREATE TABLE tb_pesquisas(
sigla				CHAR(3),
nr_projeto			INTEGER,
rg_pesquisador		VARCHAR(11),
CONSTRAINT pk_tb_pesquisas_sigla_nr_rg PRIMARY KEY(sigla, nr_projeto, rg_pesquisador),
CONSTRAINT fk_tb_pesquisas_sigla FOREIGN KEY(sigla)
	REFERENCES tb_instituicoes(sigla),
CONSTRAINT fk_tb_pesquisas_nr_projeto FOREIGN KEY(nr_projeto)
	REFERENCES tb_projetos(nr_projeto),
CONSTRAINT fk_tb_pesquisas_rg_pesquisador FOREIGN KEY(rg_pesquisador)
	REFERENCES tb_pesquisadores(rg_pesquisador)
);

--CRIANDO O OBJETO tb_produtos
CREATE TABLE tb_produtos(
codigo			INTEGER,
ds_produto		VARCHAR(25),
preco_venda		NUMERIC(5,2),
CONSTRAINT pk_tb_produtos_codigo PRIMARY KEY(codigo)
);

--CRIANDO O OBJETO tb_cidades
CREATE TABLE tb_cidades(
codigo			INTEGER,
nm_cidade		VARCHAR(40),
estado			CHAR(2),
CONSTRAINT pk_tb_cidades_codigo PRIMARY KEY(codigo)
);

--CRIANDO O OBJETO tb_distribuidores
CREATE TABLE tb_distribuidores(
rg_distribuidor			VARCHAR(11),
nm_distribuidor			VARCHAR(60),
CONSTRAINT pk_tb_distribuidores_rg_distribuidor PRIMARY KEY(rg_distribuidor)
);

--CRIANDO O OBJETO tb_distribuicoes para atender o relacionamento "1:N:N"
CREATE TABLE tb_distribuicoes(
cod_produto			INTEGER,
cod_cidade			INTEGER,
rg_distribuidor		VARCHAR(11),
CONSTRAINT pk_tb_distribuicoes_cod_prod_cidade	PRIMARY KEY(cod_produto, cod_cidade),
CONSTRAINT fk_tb_distribuicoes_cod_produto FOREIGN KEY(cod_produto)
	REFERENCES tb_produtos(codigo),
CONSTRAINT fk_tb_distribuicoes_cod_cidade FOREIGN KEY(cod_cidade)
	REFERENCES tb_cidades(codigo),
CONSTRAINT fk_tb_distribuicoes_rg_distribuidor FOREIGN KEY(rg_distribuidor)
	REFERENCES tb_distribuidores(rg_distribuidor)
);

--CRIANDO O OBJETO tb_bairros
CREATE TABLE tb_bairros(
codigo			INTEGER,
ds_bairro		VARCHAR(25),
CONSTRAINT pk_tb_bairros_codigo PRIMARY KEY(codigo)
);


--CRIANDO O OBJETO tb_carteiros
CREATE TABLE tb_carteiros(
rg_carteiro			VARCHAR(11),
nm_carteiro			VARCHAR(60),	
dt_admissao			DATE,
CONSTRAINT pk_tb_carteiros_rg_carteiro PRIMARY KEY(rg_carteiro)
);

--CRIANDO O OBJETO tb_correspondencias O QUAL ACOMODARÁ AS CHAVES-ESTRANGEIRAS "1:1:N"
CREATE TABLE tb_correspondencias(
codigo			INTEGER,
peso			FLOAT,	
cod_bairro		INTEGER,
rg_carteiro		VARCHAR(11),
CONSTRAINT pk_tb_correspond_codigo PRIMARY KEY(codigo),
CONSTRAINT fk_tb_correspond_cod_bairro FOREIGN KEY(cod_bairro)
	REFERENCES tb_bairros(codigo),
CONSTRAINT fk_tb_correspond_rg_carteiro FOREIGN KEY(rg_carteiro)
	REFERENCES tb_carteiros(rg_carteiro)
);





