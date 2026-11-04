# Modelo lógico — CodeQuest

Documentação do modelo lógico relacional (diagrama feito no Visual Paradigm). O modelo tem **7 tabelas** e **7 relacionamentos**. O ranking não é uma tabela: ele é obtido por consulta sobre as pontuações das partidas (RD16).

## 1. Visão geral

```mermaid
erDiagram
    CATEGORIA ||--o{ QUESTAO : classifica
    JOGADOR ||--o{ PARTIDA : realiza
    QUESTAO ||--|{ ALTERNATIVA : possui
    PARTIDA ||--|{ PARTIDA_QUESTAO : contem
    QUESTAO ||--o{ PARTIDA_QUESTAO : "selecionada em"
    PARTIDA_QUESTAO ||--o| RESPOSTA : recebe
    ALTERNATIVA ||--o{ RESPOSTA : "escolhida em"
```

| Tabela | Papel no sistema |
| --- | --- |
| TabelaCategoria | Temas do quiz (IA, Front-End, Back-End, História, Segurança etc.) |
| TabelaJogador | Cadastro e credenciais dos jogadores |
| TabelaQuestao | Banco de questões, com explicação e URL de referência |
| TabelaAlternativa | As quatro alternativas (A a D) de cada questão |
| TabelaPartida | Partidas realizadas por um jogador |
| TabelaPartidaQuestao | Questões sorteadas para uma partida e a ordem de apresentação |
| TabelaResposta | Alternativa escolhida para cada questão da partida |

## 2. Dicionário de dados

### 2.1 TabelaCategoria

| Coluna | Chave | Descrição |
| --- | --- | --- |
| id_categoria | PK | Identificador único da categoria |
| nome | UK | Nome da categoria (não pode repetir) |
| descricao | — | Descrição do tema |

### 2.2 TabelaJogador

| Coluna | Chave | Descrição |
| --- | --- | --- |
| id_jogador | PK | Identificador único do jogador |
| nickname | UK | Nome de acesso (não pode repetir) |
| senha | — | Senha do jogador (deve guardar o hash, nunca texto puro) |
| data_cadastro | — | Data e hora do cadastro |

### 2.3 TabelaQuestao

| Coluna | Chave | Descrição |
| --- | --- | --- |
| id_questao | PK | Identificador único da questão |
| id_categoria | FK → TabelaCategoria | Categoria à qual a questão pertence |
| enunciado | — | Texto da pergunta |
| dificuldade | — | Nível de dificuldade |
| explicacao | — | Explicação exibida após a resposta |
| url_referencia | — | Link de referência externa |
| pontuacao | — | Pontos atribuídos ao acerto |

### 2.4 TabelaAlternativa

| Coluna | Chave | Descrição |
| --- | --- | --- |
| id_alternativa | PK | Identificador único da alternativa |
| id_questao | FK → TabelaQuestao | Questão a que a alternativa pertence |
| letra | — | Letra da alternativa (A, B, C ou D) |
| texto | — | Texto da alternativa |
| correta | — | Indica se é a alternativa correta |

### 2.5 TabelaPartida

| Coluna | Chave | Descrição |
| --- | --- | --- |
| id_partida | PK | Identificador único da partida |
| id_jogador | FK → TabelaJogador | Jogador que realizou a partida |
| data_inicio | — | Data e hora de início |
| data_fim | — | Data e hora de término (vazia enquanto em andamento) |
| modo_jogo | — | Modo escolhido: categoria específica ou geral |
| status | — | Estado da partida (em andamento ou concluída) |
| pontuacao_final | — | Pontuação obtida ao final das dez questões |

### 2.6 TabelaPartidaQuestao

| Coluna | Chave | Descrição |
| --- | --- | --- |
| id_partida_questao | PK | Identificador único do vínculo partida–questão |
| id_partida | FK → TabelaPartida | Partida em que a questão foi apresentada |
| id_questao | FK → TabelaQuestao | Questão sorteada |
| ordem | — | Posição da questão na partida (1 a 10) |

### 2.7 TabelaResposta

| Coluna | Chave | Descrição |
| --- | --- | --- |
| id_resposta | PK | Identificador único da resposta |
| id_partida_questao | FK → TabelaPartidaQuestao | Questão da partida que foi respondida |
| id_alternativa | FK → TabelaAlternativa | Alternativa selecionada pelo jogador |
| acerto | — | Resultado da correção (acertou ou errou) |
| data_resposta | — | Data e hora da resposta |

## 3. Relacionamentos

| Relacionamento | Tabela pai (1) | Tabela filha (N) | Cardinalidade | Significado |
| --- | --- | --- | --- | --- |
| classifica | TabelaCategoria | TabelaQuestao | 1:N | Uma categoria classifica várias questões; cada questão tem uma categoria |
| realiza | TabelaJogador | TabelaPartida | 1:N | Um jogador realiza várias partidas; cada partida é de um jogador |
| possui | TabelaQuestao | TabelaAlternativa | 1:N | Uma questão possui quatro alternativas |
| contem | TabelaPartida | TabelaPartidaQuestao | 1:N | Uma partida contém dez questões sorteadas |
| selecionada / participa | TabelaQuestao | TabelaPartidaQuestao | 1:N | Uma questão pode ser sorteada em várias partidas |
| recebe | TabelaPartidaQuestao | TabelaResposta | 1:0..1 | Cada questão da partida recebe no máximo uma resposta |
| selecionada em | TabelaAlternativa | TabelaResposta | 1:N | Uma alternativa pode ser escolhida em várias respostas |

A tabela **TabelaPartidaQuestao** resolve a relação N:N entre partidas e questões. Ela também guarda a ordem de apresentação, o que atende ao RD06.

## 4. Rastreabilidade com os requisitos

| Requisito | Onde é atendido no modelo |
| --- | --- |
| RD01, RD11 | TabelaJogador (`id_jogador`, `nickname` UK) |
| RD02 | TabelaCategoria |
| RD03 | TabelaQuestao |
| RD04, RD12 | TabelaAlternativa (`letra`, `texto`, `correta`) |
| RD05, RD13, RA12 | TabelaPartida (`data_inicio`, `data_fim`, `modo_jogo`, `status`, `pontuacao_final`) |
| RD06 | TabelaPartidaQuestao (`ordem`) |
| RD07 | TabelaResposta (`id_alternativa`, `acerto`, `data_resposta`) |
| RD08, RA06 | Chaves estrangeiras entre todas as tabelas |
| RD16 | Ranking por consulta (view) sobre `pontuacao_final`, sem tabela própria |

## 5. Pontos de atenção e melhorias sugeridas

O diagrama cobre as tabelas e os relacionamentos, mas algumas regras dos requisitos ainda não estão garantidas pela estrutura. As sugestões abaixo são recomendações minhas, não fazem parte do diagrama atual.

| # | Situação | Requisito | Sugestão |
| --- | --- | --- | --- |
| 1 | `senha` pode induzir a guardar texto puro | RA13, RNF03 | Renomear para `senha_hash` e armazenar apenas o hash |
| 2 | Nada impede duas respostas para a mesma questão da partida | RD14, RA10, RN10 | `UNIQUE (id_partida_questao)` em TabelaResposta |
| 3 | Nada impede a mesma questão duas vezes na partida | RA09, RN08 | `UNIQUE (id_partida, id_questao)` em TabelaPartidaQuestao |
| 4 | Posição repetida na partida | RA08 | `UNIQUE (id_partida, ordem)` e `CHECK (ordem BETWEEN 1 AND 10)` |
| 5 | Letra repetida na mesma questão | RN04, RA03 | `UNIQUE (id_questao, letra)` e `CHECK (letra IN ('A','B','C','D'))` |
| 6 | Mais de uma alternativa correta por questão | RN05 | Índice único parcial em `id_questao` onde `correta = true` |
| 7 | Exatamente quatro alternativas por questão | RD12, RN04 | Não se resolve só com chave; exige trigger ou validação na carga |
| 8 | Resposta pode apontar para alternativa de outra questão | RN09 | Trigger, ou chave composta (`id_alternativa`, `id_questao`) |
| 9 | Valores livres em `status`, `modo_jogo` e `dificuldade` | RA12 | `CHECK` com valores permitidos (ex.: `em_andamento` e `concluida`) |
| 10 | `data_fim` anterior a `data_inicio` | RD13 | `CHECK (data_fim IS NULL OR data_fim >= data_inicio)` |
| 11 | Não há como inativar uma questão | RN16, RD15 | Coluna `ativa` em TabelaQuestao e `ON DELETE RESTRICT` nas chaves estrangeiras |
| 12 | Modo "por categoria" não registra qual categoria foi escolhida | RN06 | Coluna opcional `id_categoria` em TabelaPartida |
| 13 | Campos obrigatórios | RD10, RA05, RA07 | `NOT NULL` em todos os atributos, exceto `data_fim` (e `id_categoria` da partida, se criada) |

Observações finais:
- No diagrama, a cardinalidade de "recebe" aparece como `(1:0)`. O mais preciso é **1:0..1**, o que combina com a sugestão nº 2.
- `acerto` e `pontuacao_final` são valores derivados (da alternativa correta e da soma dos pontos). Mantê-los é aceitável para preservar o histórico (RN12), desde que sejam calculados pelo sistema.
- O quadro vazio no canto superior esquerdo do diagrama parece um modelo de tabela esquecido. Vale removê-lo antes da entrega.
