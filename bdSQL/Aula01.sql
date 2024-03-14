-- É aqui que criamos os objetos a partir do DER lógico
-- CONSTRAINT sufix_nomeTabela_nomeColuna
-- caso FK -> REFERENCES nomeTabela(nomeColuna) = tem q ser PK

-- Criando o 1º objeto - "tb_curso"
-- Restrições: PK aplicada a coluna "cod_curso"
CREATE TABLE tb_curso (
cod_curso 				INTEGER,
nm_curso				VARCHAR(40),
CONSTRAINT pk_tb_curso_cod_curso PRIMARY KEY(cod_curso)
);

-- Consultando a "tb_curso"
SELECT * 
FROM tb_curso;

-- Criando o 2º objeto - "tb_aluno"
-- Restrição: PK "cod_aluno" && FK "cod_curso"
CREATE TABLE tb_aluno (
cod_aluno 				INTEGER,
cod_curso 				INTEGER,
nm_aluno 				VARCHAR(60),
CONSTRAINT pk_tb_aluno_cod_aluno PRIMARY KEY(cod_aluno),
CONSTRAINT fk_tb_aluno_cod_curso FOREIGN KEY(cod_curso)
	REFERENCES tb_curso(cod_curso)
);

-- Criando o 3º objeto - "tb_departamento"
-- Restrições: PK "cod_departamento"
CREATE TABLE tb_departamento (
cod_departamento 		INTEGER,
nm_departamento			VARCHAR(40),
CONSTRAINT pk_tb_dpto_cod_dpto PRIMARY KEY(cod_departamento)
);

-- Criando o 4º objeto - "tb_disciplina"
-- Restrições: PK "cod_disciplina"; FK "cod_departamento"
CREATE TABLE tb_disciplina (
cod_disciplina			INTEGER,
cod_departamento		INTEGER,
nm_disciplina			VARCHAR(40),
creditos 				INTEGER,
CONSTRAINT pk_tb_dspl_cod_dspl PRIMARY KEY(cod_disciplina),
CONSTRAINT fk_tb_dspl_cod_dpto FOREIGN KEY(cod_departamento)
	REFERENCES tb_departamento(cod_departamento)
);

-- Criando o 5º objeto - "tb_grade"
-- Restrições: PK composta "cod_curso + cod_dslp"; FK "cod_disciplina"; FK "cod_disciplina"
-- Colunas podem ter N restrições sem ser uma coluna especifica
CREATE TABLE tb_grade (
cod_curso 				INTEGER,
cod_disciplina 			INTEGER,
CONSTRAINT pk_tb_grade_cod_curso_cod_dslp PRIMARY KEY(cod_curso, cod_disciplina),
CONSTRAINT fk_tb_grade_cod_curso FOREIGN KEY(cod_curso)
	REFERENCES tb_curso(cod_curso),
CONSTRAINT fk_tb_grade_cod_dslp FOREIGN KEY(cod_disciplina)
	REFERENCES tb_disciplina(cod_disciplina)
);

-- Criando o 6º objeto - "tb_pre_requisitos"
-- Restrições: PK composta "cod_disciplina_liberada + cod_disciplina_liberadora"; FK "cod_disciplina_liberada"; FK "cod_disciplina_liberadora"
-- Colunas podem ter N restrições sem ser uma coluna especifica
CREATE TABLE tb_pre_requisitos (
cod_disciplina_liberadora	INTEGER,
cod_disciplina_liberada		INTEGER,
CONSTRAINT pk_tb_pre_requisitos_liberada_liberadora PRIMARY KEY(cod_disciplina_liberada, cod_disciplina_liberadora),
CONSTRAINT pk_tb_pre_requisitos_liberadora FOREIGN KEY(cod_disciplina_liberadora)
	REFERENCES tb_disciplina(cod_disciplina),
CONSTRAINT pk_tb_pre_requisitos_liberada FOREIGN KEY(cod_disciplina_liberada)
	REFERENCES tb_disciplina(cod_disciplina)
);