-- Passo 9 — Testes das regras de negócio
-- Rode depois da carga. Cada bloco deve falhar.
-- Colem a mensagem de erro do PostgreSQL no comentário Resultado.
-- Troquem os nomes pelos do dicionário.

-- Regra: não existem duas categorias com o mesmo nome.
-- Resultado:
-- INSERT INTO categoria (nome) VALUES ('nome que já existe');

-- Regra: não existem duas fontes com a mesma URL.
-- Resultado:
-- INSERT INTO fonte (titulo, url, id_publicador, id_idioma)
-- VALUES ('outra', 'url que já existe', 1, 'en');

-- Regra: pergunta sem título, enunciado ou explicação não entra.
-- Resultado:
-- INSERT INTO pergunta (id_pergunta, titulo, enunciado, explicacao, id_categoria, id_fonte, id_alternativa_correta)
-- VALUES ('fact-999', NULL, 'enunciado', 'explicacao', 1, 1, 1);
-- Rode depois de 01_schema.sql e 02_carga.sql.
-- As mensagens abaixo foram obtidas rodando de verdade no PostgreSQL 16.
-- Cada bloco T01 a T15 deve falhar.

-- Carga mínima para os testes
INSERT INTO usuarios (username) VALUES ('ana');
INSERT INTO partidas (usuario_id, categoria_id) VALUES (1, 1);
INSERT INTO respostas (partida_id, pergunta_id, escolhida) VALUES (1, 1, 'b');

-- T01 Regra: não existem duas categorias com o mesmo nome.
-- Resultado: ERROR: duplicate key value violates unique constraint "categorias_nome_key"
-- INSERT INTO categorias (nome) VALUES ('IA');

-- T02 Regra: não existem dois usuários com o mesmo username.
-- Resultado: ERROR: duplicate key value violates unique constraint "usuarios_username_key"
-- INSERT INTO usuarios (username) VALUES ('ana');

-- T03 Regra: username com mais de 20 caracteres não entra.
-- Resultado: ERROR: value too long for type character varying(20)
-- INSERT INTO usuarios (username) VALUES ('usuario_com_nome_muito_grande');

-- T04 Regra: username é obrigatório.
-- Resultado: ERROR: null value in column "username" of relation "usuarios" violates not-null constraint
-- INSERT INTO usuarios (username) VALUES (NULL);

-- T05 Regra: pergunta sem enunciado não entra.
-- Resultado: ERROR: null value in column "enunciado" of relation "perguntas" violates not-null constraint
-- INSERT INTO perguntas (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, correta)
-- VALUES (1, NULL, 'a', 'b', 'c', 'd', 'a');

-- T06 Regra: pergunta sem alternativa correta não entra.
-- Resultado: ERROR: null value in column "correta" of relation "perguntas" violates not-null constraint
-- INSERT INTO perguntas (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, correta)
-- VALUES (1, 'enunciado', 'a', 'b', 'c', 'd', NULL);

-- T07 Regra: pergunta precisa de categoria que exista.
-- Resultado: ERROR: insert or update on table "perguntas" violates foreign key constraint "perguntas_categoria_id_fkey"
-- INSERT INTO perguntas (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, correta)
-- VALUES (999, 'enunciado', 'a', 'b', 'c', 'd', 'a');

-- T08 Regra: a alternativa correta tem só 1 caractere.
-- Resultado: ERROR: value too long for type character(1)
-- INSERT INTO perguntas (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, correta)
-- VALUES (1, 'enunciado', 'a', 'b', 'c', 'd', 'ab');

-- T09 Regra: não se responde a mesma pergunta duas vezes na mesma partida.
-- Resultado: ERROR: duplicate key value violates unique constraint "respostas_pkey"
-- INSERT INTO respostas (partida_id, pergunta_id, escolhida) VALUES (1, 1, 'a');

-- T10 Regra: resposta precisa de partida que exista.
-- Resultado: ERROR: insert or update on table "respostas" violates foreign key constraint "respostas_partida_id_fkey"
-- INSERT INTO respostas (partida_id, pergunta_id, escolhida) VALUES (999, 1, 'a');

-- T11 Regra: resposta precisa de pergunta que exista.
-- Resultado: ERROR: insert or update on table "respostas" violates foreign key constraint "respostas_pergunta_id_fkey"
-- INSERT INTO respostas (partida_id, pergunta_id, escolhida) VALUES (1, 999, 'a');

-- T12 Regra: partida precisa de usuário que exista.
-- Resultado: ERROR: insert or update on table "partidas" violates foreign key constraint "partidas_usuario_id_fkey"
-- INSERT INTO partidas (usuario_id, categoria_id) VALUES (999, 1);

-- T13 Regra: não dá para apagar uma categoria que ainda tem perguntas.
-- Resultado: ERROR: update or delete on table "categorias" violates foreign key constraint "perguntas_categoria_id_fkey" on table "perguntas"
-- DELETE FROM categorias WHERE id = 1;

-- T14 Regra: não dá para apagar um usuário que já tem partidas.
-- Resultado: ERROR: update or delete on table "usuarios" violates foreign key constraint "partidas_usuario_id_fkey" on table "partidas"
-- DELETE FROM usuarios WHERE id = 1;

-- T15 Regra: não dá para apagar uma pergunta que já foi respondida.
-- Resultado: ERROR: update or delete on table "perguntas" violates foreign key constraint "respostas_pergunta_id_fkey" on table "respostas"
-- DELETE FROM perguntas WHERE id = 1;

-- ---------------------------------------------------------------
-- Testes que DEVEM FUNCIONAR
-- ---------------------------------------------------------------

-- T16 A view ranking mostra a partida da ana.
-- Resultado: 1 linha: partida_id 1 | ana | IA | pontos 10 | acertos 1 | respondidas 1
-- SELECT * FROM ranking;

-- ---------------------------------------------------------------
-- Brechas do esquema simplificado (sem CHECK): estes inserts PASSAM,
-- mas não deveriam. Rode 04_checks_opcional.sql para fechá-las.
-- ---------------------------------------------------------------

-- T17 Alternativa correta inválida ('z'): passa (INSERT 0 1).
-- Com o CHECK: ERROR: new row for relation "perguntas" violates check constraint "perguntas_correta_check"

-- T18 Pontos negativos (-5): passa (INSERT 0 1).
-- Com o CHECK: ERROR: new row for relation "perguntas" violates check constraint "perguntas_pontos_check"

-- T19 Resposta escolhida inválida ('k'): passa (INSERT 0 1).
-- Com o CHECK: ERROR: new row for relation "respostas" violates check constraint "respostas_escolhida_check"
