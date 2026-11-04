CREATE TABLE usuarios (
  id       SERIAL PRIMARY KEY,
  username VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE categorias (
  id     SERIAL PRIMARY KEY,
  nome   VARCHAR(50) NOT NULL UNIQUE,
  imagem VARCHAR(255)
);

CREATE TABLE perguntas (
  id           SERIAL PRIMARY KEY,
  categoria_id INT NOT NULL,
  enunciado    TEXT NOT NULL,
  pontos       INT NOT NULL DEFAULT 1,
  opcao_a      TEXT NOT NULL,
  opcao_b      TEXT NOT NULL,
  opcao_c      TEXT NOT NULL,
  opcao_d      TEXT NOT NULL,
  correta      CHAR(1) NOT NULL,
  explicacao   TEXT,
  fonte        TEXT,
  FOREIGN KEY (categoria_id) REFERENCES categorias (id)
);

CREATE TABLE partidas (
  id           SERIAL PRIMARY KEY,
  usuario_id   INT NOT NULL,
  categoria_id INT NOT NULL,
  criada_em    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id) REFERENCES usuarios (id),
  FOREIGN KEY (categoria_id) REFERENCES categorias (id)
);

CREATE TABLE respostas (
  partida_id  INT NOT NULL,
  pergunta_id INT NOT NULL,
  escolhida   CHAR(1) NOT NULL,
  PRIMARY KEY (partida_id, pergunta_id),
  FOREIGN KEY (partida_id) REFERENCES partidas (id),
  FOREIGN KEY (pergunta_id) REFERENCES perguntas (id)
);

CREATE VIEW ranking AS
SELECT p.id AS partida_id,
       u.username,
       c.nome AS categoria,
       SUM(CASE WHEN r.escolhida = pg.correta THEN pg.pontos ELSE 0 END) AS pontos,
       SUM(CASE WHEN r.escolhida = pg.correta THEN 1 ELSE 0 END) AS acertos,
       COUNT(*) AS respondidas
FROM partidas p
JOIN usuarios   u  ON u.id = p.usuario_id
JOIN categorias c  ON c.id = p.categoria_id
JOIN respostas  r  ON r.partida_id = p.id
JOIN perguntas  pg ON pg.id = r.pergunta_id
GROUP BY p.id, u.username, c.nome;
