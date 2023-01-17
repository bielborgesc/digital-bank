-- SYSTEM:
--  Criar um usuário no oracle (seu nome) e conceder as devidas permissões de acesso a ele
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE USER gabrielb IDENTIFIED BY gabrielb;

CREATE ROLE desenvolvedor;

-- Concessao de Acesso:
GRANT
    CREATE SESSION,
    CREATE ANY TABLE,
    SELECT ANY TABLE,
    INSERT ANY TABLE,
    UPDATE ANY TABLE,
    CREATE ANY SEQUENCE,
    CREATE ANY VIEW,
    CREATE MATERIALIZED VIEW,
    CREATE ANY PROCEDURE, -- Permissao para criar Procedures          (Parte 2)
    CREATE ANY TRIGGER, -- Permissao para criar Trigger               (Parte 2)
    CREATE ANY INDEX TO desenvolvedor; -- Permissao para criar Index  (Parte 2)
    
-- Atribuindo acesso de desenvolvedor ao gabrielb:
GRANT desenvolvedor TO gabrielb;
ALTER USER gabrielb QUOTA UNLIMITED ON USERS;

-- Criar um novo usuario (nome qualquer) e conceder a ele:
CREATE USER usuario IDENTIFIED BY usuario;

-- Permissoes de acesso ao banco de dados:
GRANT CREATE SESSION TO usuario, desenvolvedor;

-- Consulta (SELECT) em todas as tabelas do BD:
GRANT SELECT ON gabrielb.banco TO usuario, desenvolvedor;
GRANT SELECT ON gabrielb.agencia TO usuario, desenvolvedor;
GRANT SELECT ON gabrielb.funcionario TO usuario, desenvolvedor;
GRANT SELECT ON gabrielb.funcionario_institucional TO usuario, desenvolvedor;
GRANT SELECT ON gabrielb.funcionario_terceirizado TO usuario, desenvolvedor;
GRANT SELECT ON gabrielb.contem TO usuario, desenvolvedor;

-- Insert, Update, Delete em duas das tabelas:
GRANT INSERT, UPDATE, DELETE ON gabrielb.funcionario TO usuario, desenvolvedor;
GRANT INSERT, UPDATE, DELETE ON gabrielb.contem TO usuario, desenvolvedor;
GRANT INSERT, UPDATE, DELETE ON gabrielb.setor TO usuario, desenvolvedor;

-- Consulta nas views:
GRANT SELECT ON gabrielb.v_funcionario_terceirizado_lista TO usuario;
GRANT SELECT ON gabrielb.v_funcionario_nubank TO usuario;
GRANT SELECT ON gabrielb.setor TO usuario, desenvolvedor;

-- Inclusao do usuario nas sequences envolvidas nas tabelas em que ganhou acesso de Insert, Update e Delete:
grant select, alter on gabrielb.setor_sequence to usuario;

-- Revogar o acesso de delete concedido ao usuario nas tabelas do item anterior:
REVOKE DELETE ON gabrielb.funcionario FROM usuario;
REVOKE DELETE ON gabrielb.contem FROM usuario;
REVOKE DELETE ON gabrielb.setor FROM usuario;

--CREATE OR REPLACE DIRECTORY bancario_dump AS 'C:\Users\gabri\OneDrive\Área de Trabalho\Faculdade\Semestre 4\BD2\Banco de dados 2\Part-2\Dump';
--GRANT READ, WRITE ON DIRECTORY bancario_dump TO gabrielb;





