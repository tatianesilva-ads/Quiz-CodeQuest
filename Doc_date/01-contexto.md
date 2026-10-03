# Passos 1 a 3 — Contexto, minimundo e requisitos

Marco M1. Copiem para `entregas/01-contexto.md`.

## 1. Introdução e contexto

 O CodeQuest é um quiz de multipla escolha com dez perguntas    sobre tecnologia que aborda temas como cibersegurança, desenvolvimento front e back-end, internet, história da computação e IA. Desenvolvido para estudantes, profissionais e interessados na área de tecnologia no formato desktop. 

### **Escopo.**

**O banco faz**  
-- Ele guarda as questões, alternativas e o gabarito do quiz.  
-- Ele classifica as questões por categoria ou de forma aleatória.   
-- Ele guarda a URL da referência de cada questão.  
-- Ele sorteia e corrige questões por consulta SQL.  
-- Cadastra apenas o nome do usuário.  
-- Guarda a nota, o histórico de respostas e o ranking.  
-- Guarda e exibe as explicações das questões. 

### **O banco não faz**  
-- Não guarda senha nem sessão  
-- Não Guarda o texto do livro nem título   
-- Não gera questões novas sozinho    


### **Usuários**  
 

| Usuário | O que faz |
| --- | --- |
| Estudantes de tecnologia | Responde o Quiz|  
| Interessandos em tecnologia| Responde o Quiz
| Aplicador do quiz | inserir, deletar, alterar e consultar as questões do Quiz|

## 2. Minimundo

O sistema consiste em uma aplicação desktop de quiz sobre tecnologia, desenvolvida no idioma Português (PT-BR).

Para iniciar uma partida, o usuário informa apenas o seu nome (nickname), e o sistema gera automaticamente um código único de identificação para registrar seu histórico e posição no placar.

Uma partida é composta por 10 questões de múltipla escolha, que podem ser selecionadas de duas formas:

1. Por categoria específica: questões sorteadas aleatoriamente dentro da categoria escolhida pelo jogador;

2. Modo geral: questões sorteadas aleatoriamente entre todas as categorias cadastradas no banco de dados.

Cada questão possui exatamente 4 alternativas (de A a D), sendo apenas uma correta.

Ao selecionar uma alternativa, o sistema fornece feedback imediato (indicando se o jogador acertou ou errou), exibe a explicação do gabarito e disponibiliza um link de referência externa para aprofundamento.

Ao término das 10 questões, o sistema exibe a pontuação final obtida na rodada e atualiza o ranking geral de jogadores, permitindo comparar o desempenho com os demais participantes.

> 

## 3. Requisitos e regras de negócio

Cada RD01–RD11 e cada RA01–RA07 entra numa linha. Não deixem código de fora.

| Código | Texto do requisito | Tipo |
| --- | --- | --- |
| RD01| O sistema deve permitir o cadastro do nickname do jogador para iniciar uma partida.| Funcional |
| RD02| O sistema deve gerar automaticamente um código único de identificação para cada jogador/partida| Funcional |
| RD03 | O sistema deve permitir ao jogador iniciar um quiz com 10 questões de múltipla escolha. | Funcional |
| RD04  | O sistema deve permitir selecionar questões por uma categoria específica ou pelo modo geral.  | Funcional |
| RD05   | O sistema deve selecionar aleatoriamente as questões disponíveis de acordo com o modo escolhido.  | Funcional |
| RD06    | O sistema deve apresentar exatamente quatro alternativas (A, B, C e D) para cada questão, sendo apenas uma correta  |  Regra de negócio |
| RD07    | O sistema deve informar imediatamente se a alternativa selecionada está correta ou incorreta.  | Funcional |
| RD08     | O sistema deve exibir a explicação referente ao gabarito após a resposta do jogador.  | Funcional |
| RD09      | O sistema deve disponibilizar uma URL de referência relacionada à questão para aprofundamento do conteúdo.  | Funcional |
| RD10       | O sistema deve calcular e exibir a pontuação final após o jogador responder as 10 questões e registrar seu desempenho no histórico. | Funcional |
| RD11       | O sistema deve atualizar e exibir o ranking geral dos jogadores de acordo com suas pontuações. | Funcional |
| RA01      | O sistema deve utilizar um Sistema Gerenciador de Banco de Dados (SGBD) para armazenar e consultar os dados do quiz.| Não funcional |
| RA02       |O sistema não deve permitir questões sem enunciado, alternativas ou gabarito.| Não funcional |
| RA03        | Cada questão deve possuir exatamente quatro alternativas, identificadas de A a D, e apenas uma delas deve ser marcada como correta.| Não funcional |
| RA04         | O código de identificação gerado para cada jogador/partida deve ser único e não pode ser duplicado.| Não funcional |
| RA05          | O nickname do jogador deve ser obrigatório para iniciar uma partida e não pode ser nulo.| Não funcional |
| RA06 | O sistema deve garantir a integridade dos relacionamentos entre jogadores, partidas, respostas e questões, impedindo registros relacionados a dados inexistentes. | Não funcional |
| RA07  | O sistema deve garantir que os dados obrigatórios das questões, categorias, respostas e pontuações não sejam armazenados como nulos. | Não funcional |

Não funcional inclui, no mínimo, o SGBD e a integridade (o que não pode duplicar nem ficar nulo).
