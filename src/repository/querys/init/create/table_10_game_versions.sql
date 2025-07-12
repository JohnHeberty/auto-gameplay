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

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA GAME_VERSIONS
-- =====================================================================================

-- Índice para consultas por data (muito usado nas views)
CREATE INDEX IF NOT EXISTS idx_game_versions_date 
ON GAME_VERSIONS (date DESC);

-- Índice para busca por nome da versão
CREATE INDEX IF NOT EXISTS idx_game_versions_name 
ON GAME_VERSIONS (name);

-- Índice composto para jogo e data
CREATE INDEX IF NOT EXISTS idx_game_versions_game_date 
ON GAME_VERSIONS (ID_GAME, date DESC);

-- Índice otimizado para view vw_video_versao
CREATE INDEX IF NOT EXISTS idx_game_versions_date_optimized 
ON GAME_VERSIONS (date DESC, name);

-- Índice para busca de versão na descrição usando position()
CREATE INDEX IF NOT EXISTS idx_game_versions_name_position 
ON GAME_VERSIONS (name) 
WHERE LENGTH(name) >= 3;
