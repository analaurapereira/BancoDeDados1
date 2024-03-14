-- CRIANDO TABELA CLINICAS

CREATE TABLE tb_clinica(
cnpj		VARCHAR(15),
nm_clinica 	VARCHAR(60),
CONSTRAINT pk_tb_clinica_cnpj PRIMARY KEY(cnpj)
)

--CONSULTANDO O OBJETO
SELECT *
FROM tb_clinica

--REALIZANDO UMA CARGA DE DADOS
INSERT INTO tb_clinica(cnpj, nm_clinica)
VALUES
('12345676543213', 'UNIMED'),
('87543675768976', 'SANTA CASA')

-- CRIANDO TABELA ESPECIALIDADES
CREATE TABLE tb_especialidades(
cod_especialidades			INTEGER,
ds_especialidades			VARCHAR(40),
CONSTRAINT pk_tb_esp_cod_esp PRIMARY KEY(cod_especialidades)
)

--CONSULTANDO O OBJETO
SELECT *
FROM tb_especialidades

--REALIZANDO UMA CARGA DE DADOS
INSERT INTO tb_especialidades(cod_especialidades, ds_especialidades)
VALUES
(2, 'PEDIATRIA'),
(7, 'CARDIOL0GIA')

-- CRIANDO TABELA MEDICOS
CREATE TABLE tb_medicos(
crm					VARCHAR(8),
cod_especialidades	INTEGER,
nm_medico			VARCHAR(60),
salario				NUMERIC(7,2),

CONSTRAINT pk_tb_medicos_crm PRIMARY KEY(crm),
CONSTRAINT fk_tb_medicos_cod_esp FOREIGN KEY(cod_especialidades)
	REFERENCES tb_especialidades(cod_especialidades)
)

--CONSULTANDO O OBJETO
SELECT *
FROM tb_medicos

--REALIZANDO UMA CARGA DE DADOS
INSERT INTO tb_medicos(crm, cod_especialidades, nm_medico, salario)
VALUES
('764540', 2, 'João', 12345.67),
('764567', 7, 'Carlos', 12387.67)

-- CRIANDO TABELA QUARTOS
CREATE TABLE tb_quartos(
nr_quarto			INTEGER,
andar  				INTEGER,
tamanho				FLOAT,
categoria 			VARCHAR(10),

CONSTRAINT pk_tb_nr_quarto PRIMARY KEY(nr_quarto)
)

--CONSULTANDO O OBJETO
SELECT *
FROM tb_quartos

--REALIZANDO UMA CARGA DE DADOS
INSERT INTO tb_quartos(nr_quarto, andar, tamanho, categoria)
VALUES
(12,3, 4.5, 'pobre'),
(45, 2, 8.9, 'quase la')

-- CRIANDO TABELA PACIENTES
CREATE TABLE tb_pacientes(
cpf				INTEGER,
nr_quarto		INTEGER CONSTRAINT uq_tb_pacientes_nr_quarto UNIQUE,
crm				VARCHAR(8),
nm_paciente		VARCHAR(60),
endereco  		VARCHAR(60),
rg				VARCHAR(11),
telefone		VARCHAR(15),
hr_visitas		TIME,
CONSTRAINT pk_tb_pacientes_cpf PRIMARY KEY(cpf),
CONSTRAINT fk_tb_pacientes_nr_quarto FOREIGN KEY(nr_quarto)
	REFERENCES tb_quartos(nr_quarto),
CONSTRAINT fk_tb_pacientes_crm FOREIGN KEY(crm)
	REFERENCES tb_medicos(crm)
)

-- CRIANDO TABELA TRATAMENTOS
CREATE TABLE tb_tratamentos(
crm 			VARCHAR(8),
cpf				INTEGER,
CONSTRAINT pk_tb_tratamentos_crm_cpf PRIMARY KEY(crm, cpf),
CONSTRAINT fk_tb_tratamentos_crm FOREIGN KEY(crm)
	REFERENCES tb_medicos(crm),
CONSTRAINT fk_tb_tratamentos_cpf FOREIGN KEY(cpf)
	REFERENCES tb_pacientes(cpf)
)

-- CRIANDO TABELA CLINICA X MEDICOS
CREATE TABLE tb_clinicas_medicos(
cnpj				VARCHAR(15),
crm					VARCHAR(8),
CONSTRAINT pk_tb_clinicas_medicos_cnpj_crm PRIMARY KEY(cnpj, crm),
CONSTRAINT fk_tb_crm_cnpj FOREIGN KEY(cnpj)
	REFERENCES tb_clinicas(cnpj),
CONSTRAINT fk_tb_crm_cnpj FOREIGN KEY(crm)
	REFERENCES tb_medicos(crm)
)

-- CRIANDO TABELA CLINICA X PACIENTES
CREATE TABLE tb_clinicas_pacientes(
cnpj				VARCHAR(15),
cpf					INTEGER,
CONSTRAINT pk_tb_cnpj_cpf PRIMARY KEY(cnpj, cpf),
CONSTRAINT fk_tb_crm_cnpj FOREIGN KEY(cnpj)
	REFERENCES tb_clinica(cnpj),
CONSTRAINT fk_tb_cpf_cnpj FOREIGN KEY(cpf)
	REFERENCES tb_pacientes(cpf)
)
