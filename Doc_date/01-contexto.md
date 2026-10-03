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
| | | funcional / não funcional / regra de negócio |

Não funcional inclui, no mínimo, o SGBD e a integridade (o que não pode duplicar nem ficar nulo).
