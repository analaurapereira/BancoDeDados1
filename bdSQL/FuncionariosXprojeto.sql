-- CRIANDO TABELA DEPARTAMENTOS

CREATE TABLE tb_departamento(
sigla_dep			VARCHAR(3),
nome_dep			VARCHAR(15),
ramal_dep			INTEGER,
data_lotacao		DATE,
	
CONSTRAINT pk_tb_departamento PRIMARY KEY(sigla_dep)
)


-- CRIANDO TABELA FUNCIONARIOS
CREATE TABLE tb_funcionarios(
matricula_func			INTEGER,
sigla_dep				VARCHAR(3) CONSTRAINT nn_tb_func_sigla_dep NOT NULL,
nome_func				VARCHAR(40),
data_admissao_func		DATE,
data_nasc_func			DATE,
	
CONSTRAINT pk_tb_funcionarios_matricula_func PRIMARY KEY(matricula_func),
CONSTRAINT fk_tb_funcionarios_sigla_dep FOREIGN KEY(sigla_dep) 
	REFERENCES tb_departamento(sigla_dep)
)

-- CRIANDO TABELA PROJETO
CREATE TABLE tb_projeto(
cod_proj			INTEGER,
nome_proj			VARCHAR(30),
	
CONSTRAINT pk_tb_projeto_cod_proj PRIMARY KEY(cod_proj)
)

-- CRIANDO TABELA FUNCIONARIOS X PROJETO
CREATE TABLE tb_funcionarios_projeto(
matricula_func			INTEGER,
cod_proj   				INTEGER,
data_locacao			DATE,
	
CONSTRAINT pk_tb_funcionarios_projeto_matricula_cod PRIMARY KEY(matricula_func, cod_proj),
CONSTRAINT fk_tb_funcionarios_projeto_func FOREIGN KEY (matricula_func)
	REFERENCES tb_funcionarios(matricula_func),
CONSTRAINT fk_tb_funcionario_projeto  FOREIGN KEY(cod_proj)
	REFERENCES tb_projeto(cod_proj)
)