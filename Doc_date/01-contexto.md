# Passos 1 a 3 — Contexto, minimundo e requisitos

Marco M1. Copiem para `entregas/01-contexto.md`.

## 1. Introdução e contexto

 O CodeQuest é um quiz de multipla escolha sobre tecnologia que aborda temas como cibersegurança, desenvolvimento front e back-end, internet, história da computação e IA. Desenvolvido para estudantes, profissionais e interessados na área de tecnologia no formato desktop. 

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
| Quem cadastra perguntas | inserir, deletar, alterar e consultar as questões do Quiz|

## 2. Minimundo

Um ou dois parágrafos, na voz de quem encomenda o sistema. É deste texto que saem as entidades e as regras. Cubram pergunta, categoria, fonte, publicador, idioma e alternativas, inclusive a possibilidade de mais de duas alternativas no futuro.

> 

## 3. Requisitos e regras de negócio

Cada RD01–RD11 e cada RA01–RA07 entra numa linha. Não deixem código de fora.

| Código | Texto do requisito | Tipo |
| --- | --- | --- |
| | | funcional / não funcional / regra de negócio |

Não funcional inclui, no mínimo, o SGBD e a integridade (o que não pode duplicar nem ficar nulo).
