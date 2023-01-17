-- usuario:

-- Inserir ao menos uma linha em cada uma das duas tabelas que ganhou acesso:
INSERT INTO gabrielb.funcionario (cpf, nome, sexo, salario, telefone, email, funcao, id_agencia) values (74464022180, 'Duque carme', 'M', 15300.14, '1658770623', 'duquec0@hud.gov', 'Consumer Services', 2);
INSERT INTO gabrielb.contem (id_funcionario, id_setor) VALUES (74464022180, 1003);
INSERT INTO gabrielb.setor (numero, nome, ramal, especializacao, id_agencia) VALUES (gabrielb.setor_sequence.nextval, 'Design', 1, 'Criação', 1);

-- Consultar dados de ao menos duas tabelas;
select * from gabrielb.funcionario;
select * from gabrielb.contem;
select * from gabrielb.setor;
select * from gabrielb.v_funcionario_terceirizado_lista;
