# Passo 4 — Modelo conceitual

Marco M1. A entrega deste passo é o modelo conceitual: o desenho em `entregas/02-conceitual.pdf` (ou `.png`) e as tabelas abaixo.

## Entidades

| Entidade | Atributos | Identificador |
| --- | --- | --- |
| JOGADOR| CODIGO, NICKNAME (único), SENHA, DATA_CADASTRO| CÓDIGO |
|CATEGORIA| CODIGO, NOME (único), DESCRICAO| CÓDIGO |
|QUESTÃO | CODIGO, ENUNCIADO, DIFICULDADE, EXPLICACAO, URL_REFERENCIA, PONTUACAO, ATIVA| CÓDIGO |
|PARTIDA | CODIGO, MODO_JOGO, DATA_INICIO, DATA_FIM (opcional), STATUS, PONTUACAO_FINAL (derivado)| CÓDIGO |
|RESPOSTA| CODIGO, ACERTO (derivado), DATA_RESPOSTA| CÓDIGO |
|PARTIDA_QUESTÃO| CODIGO, ORDEM| CÓDIGO |
|ALTERNATIVA| CODIGO, LETRA, TEXTO, CORRETA| CÓDIGO |
|RANKING | CÓDIGO, PONTUAÇÃO, NOME_JOGADORFK, HISTORICOFK| CÓDIGO

## Relacionamentos

Uma frase por linha, ligada a um requisito. Cardinalidade dos dois lados, mínimo e máximo.

| Relacionamento | Cardinalidade | Justificativa | Requisito |
| --- | --- | --- | --- |
| JOGADOR realiza PARTIDA | JOGADOR (0,N) — PARTIDA (1,1)  | Um jogador cadastrado pode realizar várias partidas, e cada partida pertence a exatamente um jogador. | RD05, RF05, RN02 |
| CATEGORIA classifica QUESTAO | CATEGORIA (0,N) — QUESTAO (1,1) | Uma categoria pode classificar várias questões, e cada questão pertence a exatamente uma categoria.  | RD03, RN06, RN07 |
| QUESTAO possui ALTERNATIVA | QUESTAO (4,4) — ALTERNATIVA (1,1)  | Cada questão possui exatamente quatro alternativas, e cada alternativa pertence a uma única questão. | RD04, RD12, RN04, RA03 |
| PARTIDA contém PARTIDA_QUESTAO | PARTIDA (10,10) — PARTIDA_QUESTAO (1,1)  | Cada partida reúne dez questões sorteadas, e cada vínculo pertence a uma única partida. | RD06, RN01, RF07, RA09 |
| QUESTAO participa de PARTIDA_QUESTAO | QUESTAO (0,N) — PARTIDA_QUESTAO (1,1)  | Uma questão pode ser sorteada em várias partidas, ou em nenhuma. | RD06, RN08, RF07 |
| PARTIDA_QUESTAO recebe RESPOSTA | PARTIDA_QUESTAO (0,1) — RESPOSTA (1,1)  | Cada questão da partida recebe no máximo uma resposta, e nenhuma enquanto não for respondida. | RD07, RD14, RN10, RA10 |
| ALTERNATIVA é selecionada em RESPOSTA | ALTERNATIVA (0,N) — RESPOSTA (1,1)  | Uma alternativa pode ser escolhida em várias respostas, e cada resposta aponta para uma única alternativa. | RD07, RN09, RF09 |
| CATEGORIA é escolhida em PARTIDA | CATEGORIA (0,N) — PARTIDA (0,1)  | No modo por categoria, a partida fica ligada à categoria escolhida; no modo geral, não há categoria. | RF06, RN06, RN07 |
