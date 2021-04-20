-- Criação das tabelas que farão parte do banco de dados
CREATE TABLE IF NOT EXISTS banco ( 
	numero INTEGER NOT NULL,
	nome VARCHAR(50) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE, /*para saber se o banco esta ativo ou não (boa pratica) */
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, /* saber qual eh a hora atuual */
	PRIMARY KEY (numero)
);

CREATE TABLE IF NOT EXISTS agencia (
	banco_numero INTEGER NOT NULL,
	numero INTEGER NOT NULL,
	nome VARCHAR(80) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE, /*para saber se o banco esta ativo ou não (boa pratica) */
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (banco_numero, numero),/* campos que não podem se repetir */
	FOREIGN KEY (banco_numero) REFERENCES banco (numero) /* qual é o campo que referencia a tabela banco?*/
);

CREATE TABLE cliente (
	numero BIGSERIAL PRIMARY KEY,
	nome VARCHAR(120) NOT NULL,
	email VARCHAR(250) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE conta_corrente (
	banco_numero INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	numero BIGINT NOT NULL,
	digito SMALLINT NOT NULL,
	cliente_numero BIGINT NOT NULL,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (banco_numero, agencia_numero, numero, digito, cliente_numero), 
	FOREIGN KEY (banco_numero, agencia_numero) REFERENCES agencia (banco_numero, numero),/* me referenciando a tabela agencia,
	então como em agencia eu tenho duas PRIMARY KEY (banco_numero, numero), logo preciso colocar as duas*/
	FOREIGN KEY (cliente_numero) REFERENCES cliente (numero)
);

CREATE TABLE tipo_transacao (
	id SMALLSERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE, /*para saber se o banco esta ativo ou não (boa pratica) */
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cliente_transacoes (
	id BIGSERIAL PRIMARY KEY,
	banco_numero INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	conta_corrente_numero BIGINT NOT NULL,
	conta_corrente_digito SMALLINT NOT NULL,
	cliente_numero BIGINT NOT NULL,
	tipo_transacao_id SMALLINT NOT NULL,
	valor NUMERIC(15,2) NOT NULL, /* 15 DIGITOS E MAIS DUAS CASAS DECIMAIS */
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	/* NAO PRECISA O CAMPO ATIVO POR QUE EH UMA TRANSACAO E VAI ACONTECER */
	FOREIGN KEY (banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito, cliente_numero) REFERENCES conta_corrente (
	banco_numero, agencia_numero, numero, digito, cliente_numero)
	);
	
-- ACREDITO QUE FALTA A FOREIGN KEY TIPO DE TRANCACAO PRA TIPO DE TRANSACAO
-- ARQUIVO COMPLETO DDL github.com/drobcosta/digital_innovation_one
	
--INSERT INTO banco (numero, nome) VALUES (654,'Banco A.J.Renner S.A.'::VARCHAR(50));
--INSERT INTO banco (numero, nome) VALUES (246,'Banco ABC Brasil S.A.'::VARCHAR(50));
--inserir o restante, será em outro arquivo
	
