-- gabrielb
-- Criar as tabelas de acordo com o Modelo Relacional, indicando as devidas PKs, FKs e demais constraints
CREATE TABLE BANCO (
 cnpj           NUMBER(14) NOT NULL,
 nome 	        VARCHAR2(50) NOT NULL,
 data_fundacao 	DATE,
 CONSTRAINT banco_pk PRIMARY KEY (cnpj)
);

CREATE TABLE AGENCIA (
 codigo           NUMBER(4) NOT NULL,
 endereco 	      VARCHAR2(120) NOT NULL,
 email            VARCHAR2(50),
 telefone         NUMBER(12),
 id_banco         NUMBER(14),
 CONSTRAINT agencia_pk PRIMARY KEY (codigo),
 CONSTRAINT banco_fk FOREIGN KEY (id_banco) REFERENCES banco(cnpj)
);

CREATE TABLE SETOR (
 numero           NUMBER(4) NOT NULL,
 nome    	      VARCHAR2(30) NOT NULL,
 ramal            NUMBER(3) NOT NULL,
 especializacao   VARCHAR(30),
 id_agencia       NUMBER(4),
 CONSTRAINT setor_pk PRIMARY KEY (numero),
 CONSTRAINT setor_agencia_fk FOREIGN KEY (id_agencia) REFERENCES agencia(codigo),
 CONSTRAINT setor_uk UNIQUE (ramal)
);


CREATE TABLE FUNCIONARIO (
 cpf                NUMBER(11) NOT NULL,
 nome               VARCHAR2(100),
 sexo 			    CHAR(1), 
 salario 		    NUMBER(10,2) NOT NULL, 
 telefone 		    VARCHAR2(20), 
 email 			    VARCHAR2(80), 
 funcao 		    VARCHAR2(50) NOT NULL, 
 id_agencia      	NUMBER(4), 
 CONSTRAINT funcionario_pk PRIMARY KEY (cpf),
 CONSTRAINT funcionario_sexo_ck CHECK (sexo IN ('M','F','m','f')),
 CONSTRAINT funcionario_salario_ck CHECK (salario > 0),
 CONSTRAINT agencia_fk FOREIGN KEY (id_agencia) REFERENCES agencia(codigo)
);

CREATE TABLE FUNCIONARIO_INSTITUCIONAL (
 id_funcionario_institucional 	NUMBER(11),
 gratificacao 			        NUMBER(10,2) NOT NULL,
 CONSTRAINT funcionario_institucional_pk PRIMARY KEY (id_funcionario_institucional),
 CONSTRAINT funcionario_fk FOREIGN KEY (id_funcionario_institucional) REFERENCES funcionario(cpf)
);

CREATE TABLE FUNCIONARIO_TERCEIRIZADO (
 id_funcionario_terceirizado 	NUMBER(11),
 nome_empresa 			        VARCHAR(30) NOT NULL,
 data_inicio                    DATE,
 data_fim                       DATE,
 CONSTRAINT funcionario_terceirizado_pk PRIMARY KEY (id_funcionario_terceirizado),
 CONSTRAINT funcionario_terceirizado_fk FOREIGN KEY (id_funcionario_terceirizado) REFERENCES funcionario(cpf)
);

CREATE TABLE CONTEM (
 id_funcionario 	        NUMBER(11),
 id_setor 			        NUMBER(4),
 CONSTRAINT contem_pk PRIMARY KEY (id_funcionario, id_setor),
 CONSTRAINT contem_funcionario_fk FOREIGN KEY(id_funcionario) REFERENCES funcionario(cpf),
 CONSTRAINT contem_setor_fk FOREIGN KEY(id_setor) REFERENCES setor(numero)
);

-- Criacao das Sequences:
CREATE SEQUENCE agencia_sequence INCREMENT BY 1 START WITH 1 MAXVALUE 9999 NOCYCLE NOCACHE;
CREATE SEQUENCE setor_sequence INCREMENT BY 1 START WITH 1000 MAXVALUE 9999 NOCYCLE NOCACHE;

/*
DROP SEQUENCE agencia_sequence;
DROP SEQUENCE setor_sequence;
*/

-- Popular as tabelas com no mínimo 5 tuplas em cada uma;
-- Insercao de dados BANCO:
INSERT INTO  BANCO (cnpj, nome, data_fundacao) VALUES ( 73222334770001, 'Nubank', to_date('01/01/2005','dd/mm/yyyy'));
INSERT INTO  BANCO (cnpj, nome, data_fundacao) VALUES ( 90057017710001, 'Itaú', to_date('07/04/1974','dd/mm/yyyy'));
INSERT INTO  BANCO (cnpj, nome, data_fundacao) VALUES ( 91230960630001, 'Bradesco', to_date('15/03/1985','dd/mm/yyyy'));
INSERT INTO  BANCO (cnpj, nome, data_fundacao) VALUES ( 51457726430001, 'C6 Bank', to_date('26/11/2009','dd/mm/yyyy'));
INSERT INTO  BANCO (cnpj, nome, data_fundacao) VALUES ( 61841457177443, 'Pic Pay', to_date('30/12/2010','dd/mm/yyyy'));
SELECT * FROM BANCO;

-- Insercao  de dados AGENCIA:
INSERT INTO  AGENCIA (codigo, endereco, email, telefone, id_banco) VALUES ( agencia_sequence.nextval, 'Rua Cristiano Olsen - Jardim Sumaré São Paulo SP 04545005', 'faleconosco@nubank.com.br', 6823299755, 73222334770001);
INSERT INTO  AGENCIA (codigo, endereco, email, telefone, id_banco) VALUES ( agencia_sequence.nextval, 'Praça da República - República São Paulo SP 01045001', 'faleconosco@itau.com.br', 1628706683, 90057017710001);
INSERT INTO  AGENCIA (codigo, endereco, email, telefone, id_banco) VALUES ( agencia_sequence.nextval, 'Avenida Tocantins - Vila Jardim Rio Claro Jataí GO 75802095', 'faleconosco@bradesco.com.br', 6935635637, 91230960630001);
INSERT INTO  AGENCIA (codigo, endereco, email, telefone, id_banco) VALUES ( agencia_sequence.nextval, 'Rua Barão de Vitória - Casa Grande Diadema SP 09961660', 'faleconosco@c6bank.com.br', 4120913351, 51457726430001);
INSERT INTO  AGENCIA (codigo, endereco, email, telefone, id_banco) VALUES ( agencia_sequence.nextval, 'Rua Serra de Bragança - Vila Gomes Cardim São Paulo SP 03318000', 'faleconosco@picpay.com.br', 1421471869, 61841457177443);
SELECT * FROM AGENCIA;

-- Insercao  de dados SETOR:
INSERT INTO SETOR (numero, nome, ramal, especializacao, id_agencia) VALUES (setor_sequence.nextval, 'Reclamações', 1, 'Falar com clientes', 1);
INSERT INTO SETOR (numero, nome, ramal, especializacao, id_agencia) VALUES (setor_sequence.nextval, 'Finanças', 2, 'Realizar contabilidade', 1);
INSERT INTO SETOR (numero, nome, ramal, especializacao, id_agencia) VALUES (setor_sequence.nextval, 'Suporte', 3, 'Atendimento geral', 1);
INSERT INTO SETOR (numero, nome, ramal, especializacao, id_agencia) VALUES (setor_sequence.nextval, 'Finanças', 1, 'Realizar contabilidade', 2);
INSERT INTO SETOR (numero, nome, ramal, especializacao, id_agencia) VALUES (setor_sequence.nextval, 'Balcão', 2, 'Agenda de reuniões', 2);
INSERT INTO SETOR (numero, nome, ramal, especializacao, id_agencia) VALUES (setor_sequence.nextval, 'Balcão', 1, 'Agenda de reuniões', 3);
INSERT INTO SETOR (numero, nome, ramal, especializacao, id_agencia) VALUES (setor_sequence.nextval, 'T.I.', 2, 'Tecnico', 3);
INSERT INTO SETOR (numero, nome, ramal, especializacao, id_agencia) VALUES (setor_sequence.nextval, 'Marketing', 3, 'Produz conteúdo', 3);
INSERT INTO SETOR (numero, nome, ramal, especializacao, id_agencia) VALUES (setor_sequence.nextval, 'Motorista', 4, 'Faz entregas', 3);
INSERT INTO SETOR (numero, nome, ramal, especializacao, id_agencia) VALUES (setor_sequence.nextval, 'Trader', 1, 'Faz Day Trade', 4);
INSERT INTO SETOR (numero, nome, ramal, especializacao, id_agencia) VALUES (setor_sequence.nextval, 'Suporte', 1, 'Atende o público', 5);
INSERT INTO SETOR (numero, nome, ramal, especializacao, id_agencia) VALUES (setor_sequence.nextval, 'Faxina', 2, 'Cuida da limpeza', 5);
SELECT * FROM SETOR;

-- Insercao  de dados FUNCIONARIO:
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (74494012180, 'Linn ducarme', 'M', 14300.14, '1658580623', 'lducarme0@hud.gov', 'Consumer Services', 2);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (89689536010, 'Tedmund Pyer', 'M', 18215.53, '3783097454', 'tpyer1@utexas.edu', 'Consumer Services', 3);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (54036398303, 'Martica Bouttell', 'F', 3336.6, '3316938017', 'mbouttell2@kickstarter.com', 'Health Care', 5);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (48939575294, 'Nappy Bakes', 'F', 15190.53, '3659366703', 'nbakes3@hp.com', 'Health Care', 3);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (59872629213, 'Glynda Coenraets', 'M', 10406.68, '3282578446', 'gcoenraets4@adobe.com', 'Miscellaneous', 4);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (52347205837, 'Tessi Everit', 'F', 1323.69, '2342952913', 'teverit5@over-blog.com', 'Basic Industries', 4);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (31559094796, 'Myrtie Schafer', 'M', 8378.24, '4252743764', 'mschafer6@webs.com', 'Miscellaneous', 4);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (66065265653, 'Billye Ference', 'M', 12807.69, '2694085413', 'bference7@oracle.com', 'Finance', 5);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (10640344003, 'Teador Jindracek', 'M', 19605.63, '2342461462', 'tjindracek8@google.com', 'Basic Industries', 5);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (74232388618, 'Lind Tindall', 'F', 1158.97, '4368828577', 'ltindall9@shutterfly.com', 'Health Care', 2);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (68962527813, 'Baird Mixer', 'F', 18925.72, '3097998772', 'bmixera@mozilla.com', 'Health Care', 5);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (20387707936, 'Bjorn Fardoe', 'F', 5125.87, '1735632431', 'bfardoeb@zdnet.com', 'Health Care', 5);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (49977949738, 'Sophi Ashelford', 'M', 5519.84, '2022263816', 'sashelfordc@yandex.ru', 'Consumer Services', 1);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (83564693646, 'Reilly Sare', 'M', 6478.15, '2717749016', 'rsared@yelp.com', 'Health Care', 5);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (19194514636, 'Dennie Yakunin', 'M', 16047.2, '8394979153', 'dyakunine@craigslist.org', 'Health Care', 1);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (64561732911, 'Wendy Fullilove', 'F', 13294.19, '5863268729', 'wfullilovef@ehow.com', 'Transportation', 1);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (81787637808, 'Mame Plessing', 'M', 19554.09, '4259931764', 'mplessingg@chicagotribune.com', 'Technology', 5);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (12157879806, 'Judith Clyma', 'M', 10476.25, '5207862254', 'jclymah@github.io', 'Public Utilities', 4);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (93742962983, 'Shaylah Kinghorne', 'F', 16773.66, '5165137494', 'skinghornei@noaa.gov', 'Public Utilities', 4);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (87545845484, 'Elene Bloor', 'F', 8704.08, '2959458236', 'ebloorj@npr.org', 'Technology', 2);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (44622431165, 'Star Barnsdall', 'F', 16521.81, '9304131243', 'sbarnsdallk@squidoo.com', 'Technology', 5);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (41270301178, 'Ynes Hollebon', 'M', 6005.35, '7031717643', 'yhollebonl@sun.com', 'Technology', 2);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (37070875686, 'Brannon Bareford', 'F', 7870.01, '3045652980', 'bbarefordm@t-online.de', 'Consumer Durables', 4);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (63356307004, 'Carey Joist', 'F', 9830.37, '5008412925', 'cjoistn@yahoo.com', 'Health Care', 5);
INSERT INTO FUNCIONARIO (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (59546738936, 'Ronica McEntee', 'F', 13954.41, '7102516423', 'rmcenteeo@gov.uk', 'Consumer Non-Durables', 1);
SELECT * FROM FUNCIONARIO;

-- Insercao  de dados FUNCIONARIO_INSTITUCIONAL:
INSERT INTO FUNCIONARIO_INSTITUCIONAL (id_funcionario_institucional, gratificacao) values (74494012180, 720.58);
INSERT INTO FUNCIONARIO_INSTITUCIONAL (id_funcionario_institucional, gratificacao) values (89689536010, 824.4);
INSERT INTO FUNCIONARIO_INSTITUCIONAL (id_funcionario_institucional, gratificacao) values (54036398303, 684.37);
INSERT INTO FUNCIONARIO_INSTITUCIONAL (id_funcionario_institucional, gratificacao) values (48939575294, 706.59);
INSERT INTO FUNCIONARIO_INSTITUCIONAL (id_funcionario_institucional, gratificacao) values (59872629213, 699.34);
INSERT INTO FUNCIONARIO_INSTITUCIONAL (id_funcionario_institucional, gratificacao) values (52347205837, 792.47);
INSERT INTO FUNCIONARIO_INSTITUCIONAL (id_funcionario_institucional, gratificacao) values (31559094796, 922.14);
INSERT INTO FUNCIONARIO_INSTITUCIONAL (id_funcionario_institucional, gratificacao) values (66065265653, 734.39);
INSERT INTO FUNCIONARIO_INSTITUCIONAL (id_funcionario_institucional, gratificacao) values (10640344003, 705.89);
INSERT INTO FUNCIONARIO_INSTITUCIONAL (id_funcionario_institucional, gratificacao) values (74232388618, 942.71);
INSERT INTO FUNCIONARIO_INSTITUCIONAL (id_funcionario_institucional, gratificacao) values (68962527813, 987.82);
INSERT INTO FUNCIONARIO_INSTITUCIONAL (id_funcionario_institucional, gratificacao) values (20387707936, 815.72);
SELECT * FROM FUNCIONARIO_INSTITUCIONAL;

-- Insercao  de dados FUNCIONARIO_TERCEIRIZADO:
INSERT INTO FUNCIONARIO_TERCEIRIZADO (id_funcionario_terceirizado, nome_empresa, data_inicio, data_fim) values (49977949738, 'Fiveclub', '7/6/2020', '8/12/2023');
INSERT INTO FUNCIONARIO_TERCEIRIZADO (id_funcionario_terceirizado, nome_empresa, data_inicio, data_fim) values (83564693646, 'Edgeclub', '1/6/2020', '6/5/2023');
INSERT INTO FUNCIONARIO_TERCEIRIZADO (id_funcionario_terceirizado, nome_empresa, data_inicio, data_fim) values (19194514636, 'Trudeo', '1/5/2022', '16/11/2023');
INSERT INTO FUNCIONARIO_TERCEIRIZADO (id_funcionario_terceirizado, nome_empresa, data_inicio, data_fim) values (64561732911, 'Brainlounge', '2/7/2020', '31/7/2023');
INSERT INTO FUNCIONARIO_TERCEIRIZADO (id_funcionario_terceirizado, nome_empresa, data_inicio, data_fim) values (81787637808, 'Realpoint', '11/12/2020', '20/3/2023');
INSERT INTO FUNCIONARIO_TERCEIRIZADO (id_funcionario_terceirizado, nome_empresa, data_inicio, data_fim) values (12157879806, 'Buzzster', '23/1/2022', '9/12/2023');
INSERT INTO FUNCIONARIO_TERCEIRIZADO (id_funcionario_terceirizado, nome_empresa, data_inicio, data_fim) values (93742962983, 'Tagcat', '12/12/2021', '14/8/2023');
INSERT INTO FUNCIONARIO_TERCEIRIZADO (id_funcionario_terceirizado, nome_empresa, data_inicio, data_fim) values (87545845484, 'Divanoodle', '29/1/2021', '11/11/2023');
INSERT INTO FUNCIONARIO_TERCEIRIZADO (id_funcionario_terceirizado, nome_empresa, data_inicio, data_fim) values (44622431165, 'Babblestorm', '9/12/2021', '10/12/2023');
INSERT INTO FUNCIONARIO_TERCEIRIZADO (id_funcionario_terceirizado, nome_empresa, data_inicio, data_fim) values (41270301178, 'Twitterlist', '1/4/2022', '8/12/2023');
INSERT INTO FUNCIONARIO_TERCEIRIZADO (id_funcionario_terceirizado, nome_empresa, data_inicio, data_fim) values (37070875686, 'Quimm', '6/1/2021', '28/5/2023');
INSERT INTO FUNCIONARIO_TERCEIRIZADO (id_funcionario_terceirizado, nome_empresa, data_inicio, data_fim) values (63356307004, 'Ntags', '20/1/2022', '24/6/2023');
INSERT INTO FUNCIONARIO_TERCEIRIZADO (id_funcionario_terceirizado, nome_empresa, data_inicio, data_fim) values (59546738936, 'Trudoo', '7/7/2021', '23/3/2023');
SELECT * FROM FUNCIONARIO_TERCEIRIZADO;

-- Insercao  de dados CONTEM:
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (74494012180, 1000);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (89689536010, 1002);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (54036398303, 1003);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (48939575294, 1004);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (59872629213, 1005);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (52347205837, 1006);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (31559094796, 1007);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (66065265653, 1008);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (10640344003, 1009);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (74232388618, 1010);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (68962527813, 1011);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (20387707936, 1012);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (49977949738, 1013);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (83564693646, 1000);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (19194514636, 1002);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (64561732911, 1003);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (81787637808, 1004);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (12157879806, 1005);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (93742962983, 1006);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (87545845484, 1007);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (44622431165, 1008);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (41270301178, 1009);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (37070875686, 1010);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (63356307004, 1011);
INSERT INTO CONTEM (id_funcionario, id_setor) VALUES (59546738936, 1012);

/*
DROP TABLE BANCO;
DROP TABLE AGENCIA;
DROP TABLE SETOR;
DROP TABLE FUNCIONARIO;
DROP TABLE FUNCIONARIO_INSTITUCIONAL;
DROP TABLE FUNCIONARIO_TERCEIRIZADO;
DROP TABLE CONTEM;
*/

-- Criar no mínimo 3 visões, podendo ser simples ou complexas (envolvendo junções, funções de agrupamento, etc);
-- 1. View que lista todos os funcionarios terceirizados: 
CREATE VIEW v_funcionario_terceirizado_lista(funcionario_terceirizado) AS
    SELECT f.nome FROM funcionario_terceirizado ft
        JOIN funcionario f ON ft.id_funcionario_terceirizado = f.cpf;
SELECT * FROM v_funcionario_terceirizado_lista;         

-- 2. View que lista os funcionarios que trabalham no nubank:  
CREATE VIEW v_funcionario_nubank AS
SELECT f.nome
    from funcionario f join agencia a
    on f.id_agencia = a.codigo
    join banco b on b.nome = 'Nubank';
SELECT * FROM v_funcionario_nubank; 
 
-- 3. View que lista todos os funcionarios terceirizados: 
CREATE VIEW v_funcionari_terceirizado_lista(funcionario_terceirizado) AS
    SELECT f.nome FROM funcionario_terceirizado ft
        JOIN funcionario f ON ft.id_funcionario_terceirizado = f.cpf;
SELECT * FROM v_funcionari_terceirizado_lista; 

-- Criar no mínimo 1 visão materializada com refresh on demand (sob demanda);
CREATE MATERIALIZED VIEW custo_em_gratificacao
    BUILD DEFERRED
    REFRESH COMPLETE
    ON DEMAND
    AS SELECT SUM(gratificacao) custo_total FROM funcionario_institucional;

-- Elaborar 8 consultas SELECT utilizando recursos e funções aprendidas em Oracle (junção, subconsulta, agregação de dados, funções de manipulação de caracteres, etc).

-- 1. Seleciona a soma salarial por numero dos setores com soma salarial superior a 20.000:
SELECT numero, SUM(f.salario)
FROM setor s join contem c
on s.numero = c.id_setor
join funcionario f 
on f.cpf = c.id_funcionario
GROUP BY numero
HAVING SUM(salario) > 20000
ORDER BY 1;

-- 2. Seleciona as ocorrencias de sexo e acrescenta por extenso o siginificado:    
SELECT nome, sexo,
    DECODE(sexo, 'M', 'Masculino', 'F', 'Feminino')
    FROM funcionario;

-- 3. Seleciona o valor maximo, minimo e media salarial dos funcionarios:
SELECT MAX(salario), MIN(salario), AVG(salario),COUNT(*)FROM funcionario;
    
-- 4. Seleciona o maior salario do funcionario que trabalha no setor de id: 1003:
SELECT  max(f.salario) salario
    FROM funcionario f join contem c
    ON f.cpf = c.id_funcionario
    WHERE c.id_setor = 1003;

-- 5. Mostra quantos funcionarios trabalham em cada banco:
SELECT b.nome as banco, count(*) qttd_funcionarios
    FROM banco b join agencia a
    on b.cnpj = a.id_banco
    join funcionario f
    on f.id_agencia = a.codigo
    group by b.nome
    order by qttd_funcionarios;

-- 6. Seleciona a quantidade de servidores publicos por sexo;
SELECT sexo, count(*)
    FROM funcionario
    GROUP BY sexo;
    
-- 7. Seleciona a subconsulta que mostre o cpf, nome e salario dos funcionarios que ganham mais do que o funcionario Linn ducarme.
SELECT cpf, nome, salario
    FROM funcionario
        WHERE salario > (SELECT salario FROM funcionario
        WHERE nome = 'Linn ducarme');

-- 8.  Seleciona uma listagem unica que contenha os cpfs dos funcionarios institucionais e tercerizados:
SELECT id_funcionario_institucional
    FROM funcionario_institucional
UNION
SELECT id_funcionario_terceirizado
    FROM funcionario_terceirizado;
