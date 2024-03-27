--CRIANDO O OBJETO tb_homens
CREATE TABLE  tb_homens(
rg			VARCHAR(11),
nm_homem	VARCHAR(60),
CONSTRAINT pk_tb_homens_rg 	PRIMARY KEY(rg)
);

--CRIANDO O OBJETO tb_mulheres
CREATE TABLE tb_mulheres(
rg			VARCHAR(11),
nm_homem	VARCHAR(60),
CONSTRAINT ok_tb_mulheres_rg PRIMARY KEY(rg)
);

--CRIANDO O OBJETO tb_casamento
CREATE TABLE tb_casamento(
rg_homem		VARCHAR(11),
rg_mulher		VARCHAR(11) CONSTRAINT uq_tb_casamento_rg_mulher UNIQUE,
dt_casamento	DATE,
CONSTRAINT pk_tb_casamento_rg_homem PRIMARY KEY(rg_homem),
CONSTRAINT fk_tb_casamento_rg_homem FOREIGN KEY(rg_homem)
	REFERENCES tb_homens(rg),
CONSTRAINT fk_tb_casamento_rg_mulher FOREIGN KEY(rg_mulher)
	REFERENCES tb_mulheres(rg)
);

--CRIANDO O OBJETO tb_departamento
CREATE TABLE tb_departamento(
cod_dep			INTEGER,
nm_dep			VARCHAR(15),
ramal			INTEGER,
CONSTRAINT tb_departamento_cod_dep 	PRIMARY KEY(cod_dep)
);

--CRIANDO O OBJETO tb_empregados
CREATE TABLE tb_empregados(
cpf			VARCHAR(11),
nm_emp		VARCHAR(60),
cod_dep		INTEGER CONSTRAINT nn_tb_empregados_cod_dep NOT NULL,
dt_lotacao	DATE,
CONSTRAINT pk_tb_empregados_cpf PRIMARY KEY(cpf),
CONSTRAINT fk_tb_empregados_cod_depto	FOREIGN KEY(cod_dep)
	REFERENCES tb_departamento(cod_dep)
);

--CRIANDO O OBJETO tb_pessoas
CREATE TABLE tb_pessoas(
rg				VARCHAR(11),
nm_pessoa		VARCHAR(60),
dt_nascimento	DATE,
CONSTRAINT pk_tb_pessoas_rg PRIMARY KEY(rg)
);

--CRIANDO O OBJETO tb_automovel
CREATE TABLE tb_automovel(
chassi			VARCHAR(17),
modelo			VARCHAR(15),
ano				INTEGER,
CONSTRAINT pk_tb_automovel_tb_chassi PRIMARY KEY(chassi)
);

--CRIANDO O OBJETO tb_posse
CREATE TABLE tb_posse(
rg			VARCHAR(11),
chassi		VARCHAR(17),
dt_compra	DATE,
CONSTRAINT pk_tb_posse_chassi PRIMARY KEY(chassi),
CONSTRAINT fk_tb_posse_chassi FOREIGN KEY(chassi)
	REFERENCES tb_automovel(chassi),
CONSTRAINT fk_tb_posse_rg FOREIGN KEY(rg)
	REFERENCES tb_pessoas(rg)
);

--REMOVENDO OBJETO tb_empregados
DROP TABLE tb_empregados CASCADE;

--RECRIANDO OBJETO tb_empregados
CREATE TABLE tb_empregados(
rg_emp			VARCHAR(11),
nm_emp			VARCHAR(60),
CONSTRAINT pk_tb_empregados_rg_emp 	PRIMARY KEY(rg_emp)
);

--CRIANDO O OBJETO tb_projetos
CREATE TABLE tb_projetos(
codigo			INTEGER,
nm_projeto		VARCHAR(15),
CONSTRAINT pk_tb_projetos_codigo PRIMARY KEY(codigo)
);

--CRIANDO O OBJETO tb_participações
CREATE TABLE tb_participacoes(
rg			VARCHAR(11),
cod_projeto	INTEGER,
dt_inicio	DATE,
CONSTRAINT pk_tb_participacoes_rg_cod_projeto PRIMARY KEY(rg, cod_projeto),
CONSTRAINT fk_tb_participacoes_rg FOREIGN KEY(rg)
	REFERENCES tb_empregados(rg_emp),
CONSTRAINT fk_tb_participacoes_cod_projeto FOREIGN KEY(cod_projeto)
	REFERENCES tb_projetos(codigo)
);

--REMOVENDO OBJETO tb_empregados
DROP TABLE tb_empregados CASCADE;

--RECRIANDO OBJETO tb_empregados QUE CONFIGURA UM AUTO-RELACIONAMENTO
CREATE TABLE tb_empregados(
rg_empregado		VARCHAR(11),
nome				VARCHAR(60),
idade				INTEGER,
rg_gerente			VARCHAR(11),
CONSTRAINT pk_tb_empregados_rg_empregado PRIMARY KEY(rg_empregado),
CONSTRAINT fk_tb_empregados_rg_gerente FOREIGN KEY(rg_gerente)
	REFERENCES tb_empregados(rg_empregado)
);


--REALIZANDO UMA CARGA DE DADOS COMO EXEMPLO DE AUTO-RELACIONAMENTO
INSERT INTO tb_empregados(rg_empregado, nome, idade, rg_gerente)
VALUES
('111','Bruno Oliveira', 29, NULL),
('222', 'Joana Braga', 20, '111'),
('333', 'Carlos Alberto', 49, '111'),
('444', 'Cintia Santos', 34, '222');

SELECT *
FROM tb_empregados

--ELABORAR UM RELATÓRIO PARA EXIBIR O NOME DO EMPREGADO, JUNTAMENTE COM O NOME
--DO SEU RESPECTIVO GERENTE
SELECT e.nome||' trabalha para '||g.nome "Quem é gerente de quem?"
FROM tb_empregados e
INNER JOIN tb_empregados g ON(e.rg_gerente = g.rg_empregado)
ORDER BY e.nome;