-- Tabela de referência para países
CREATE TABLE IF NOT EXISTS GAME_VERSIONS (
    ID INTEGER NOT NULL,
    "name" VARCHAR(10) NOT NULL UNIQUE,
    "date" date NOT NULL,
    ID_GAME INTEGER,
    REGISTER_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_gameversions_game FOREIGN KEY (ID_GAME) REFERENCES GAMES(ID_GAME),
    PRIMARY KEY (ID)

);

-- Comentários nas colunas
COMMENT ON TABLE GAME_VERSIONS IS                   'Tabela de referência para versões dos jogos';
COMMENT ON COLUMN GAME_VERSIONS.id IS               'ID único da versão do jogo';
COMMENT ON COLUMN GAME_VERSIONS."name" IS           'Nome/identificador da versão do jogo (ex: 7.31, 13.10, etc.)';
COMMENT ON COLUMN GAME_VERSIONS."date" IS           'Data de lançamento da versão do jogo';
COMMENT ON COLUMN GAME_VERSIONS.REGISTER_DATE IS    'Timestamp de criação do registro';
