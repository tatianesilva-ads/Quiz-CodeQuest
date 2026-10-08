# Passo 4 — Modelo conceitual

Marco M1. A entrega deste passo é o modelo conceitual: o desenho em `entregas/02-conceitual.pdf` (ou `.png`) e as tabelas abaixo.

É um DER na notação de Chen, no brModelo ou no Visual Paradigm Online. Entidades, atributos, relacionamentos e cardinalidades. Ainda não aparecem tabela, chave estrangeira nem tipo de coluna: isso é o modelo lógico, no passo 5.

## Entidades

| Entidade | Atributos | Identificador |
| --- | --- | --- |
| JOGADOR| CÓDIGO, NOME| CÓDIGO |
|CATEGORIA| CÓDIGO, NOME| CÓDIGO |
|QUESTÕES | CÓDIGO, NOME, CATEGORIAFK, RESPOSTAFK, ALTERNATIVAS| CÓDIGO |
|RESPOSTAS| CÓDIGO, HISTÓRICO, EXPLICAÇÃOFK| CÓDIGO |
|EXPLICAÇÃO| CÓDIGO, DESCRIÇÃO, REFERÊNCIA, CATEGORIAFK| CÓDIGO |
|RANKING | CÓDIGO, PONTUAÇÃO, NOME_JOGADORFK, HISTORICOFK| CÓDIGO

## Relacionamentos

Uma frase por linha, ligada a um requisito. Cardinalidade dos dois lados, mínimo e máximo.

| Relacionamento | Cardinalidade | Justificativa | Requisito |
| --- | --- | --- | --- |
| JOGADOR - CATEGORIA | 1:1  | Jogador escolhe a categoria | RD04 |
| CATEGORIA - QUESTÕES | 1:N | Questões são direcionadas a uma determinada categoria  | RD04, RD05 |
| QUESTÕES - RESPOSTAS | 1:1  | Resposta direcionada de acordo com a questão | RD06, RD07 |
| RESPOSTAS - EXPLICAÇÃO | 1:1  | Explicação aparece após a resposta ser exibida | RD08, RD09 |
| RESPOSTAS - RANKING | N:1  | Respostas contabilizadas após o término do Quiz | RD10, RD11 |


O diagrama e esta tabela descrevem o mesmo modelo. Toda entidade do desenho está na tabela.