CREATE TABLE IF NOT EXISTS HEROES (
    ID_HERO SERIAL,
    "name" VARCHAR(50) NOT NULL,
    ID_GAME INTEGER,
    "description" VARCHAR(1000),
    CONSTRAINT fk_heroes_game FOREIGN KEY (ID_GAME) REFERENCES GAMES(ID_GAME),
    PRIMARY KEY (ID_HERO)
);

-- Comentários nas colunas
COMMENT ON TABLE HEROES IS                  'Tabela para armazenar informações dos heróis/personagens dos jogos';
COMMENT ON COLUMN HEROES.ID_HERO IS         'ID único do herói/personagem (auto-incremento)';
COMMENT ON COLUMN HEROES."name" IS          'Nome do herói/personagem no jogo';
COMMENT ON COLUMN HEROES.ID_GAME IS         'ID do jogo ao qual o herói pertence (referência à tabela GAMES)';
COMMENT ON COLUMN HEROES."description" IS   'Descrição do herói, suas habilidades e características';
