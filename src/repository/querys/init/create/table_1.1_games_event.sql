CREATE TABLE IF NOT EXISTS GAMES_EVENT (
    ID_EVENT SERIAL,
    ID_GAME INTEGER NOT NULL,
    NAME VARCHAR(100) NOT NULL,
    DESCRIPTION VARCHAR(255),
    USE_RECORD BOOLEAN DEFAULT FALSE,
    REGISTER_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_gamesgames_event FOREIGN KEY (ID_GAME) REFERENCES GAMES(ID_GAME),
    PRIMARY KEY (ID_GAME, NAME)
);

-- Comentários nas colunas
COMMENT ON TABLE GAMES_EVENT IS                 'Tabela para armazenar informações dos eventos dos jogos';
COMMENT ON COLUMN GAMES_EVENT.ID_EVENT IS       'ID do evento (referência à tabela GAMES)';
COMMENT ON COLUMN GAMES_EVENT.ID_GAME IS        'ID único do jogo (auto-incremento)';
COMMENT ON COLUMN GAMES_EVENT.NAME IS           'Nome completo do evento do jogo';
COMMENT ON COLUMN GAMES_EVENT.DESCRIPTION IS    'Descrição do evento do jogo';
COMMENT ON COLUMN GAMES_EVENT.USE_RECORD IS     'Indica se o evento deve ser gravado';
COMMENT ON COLUMN GAMES_EVENT.REGISTER_DATE IS  'Data de registro do evento no banco de dados';

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA GAMES_EVENT
-- =====================================================================================

-- Índice único para nome completo do evento do jogo
CREATE UNIQUE INDEX IF NOT EXISTS idx_games_event_name 
ON GAMES_EVENT (NAME) WHERE NAME IS NOT NULL;

-- Índice único para nome abreviado/sigla do evento do jogo
-- CREATE UNIQUE INDEX IF NOT EXISTS idx_games_event 
-- ON GAMES_EVENT (EVENT) WHERE EVENT IS NOT NULL;

-- Índice GIN para busca textual no nome completo
CREATE INDEX IF NOT EXISTS idx_games_event_name_gin 
ON GAMES_EVENT USING GIN (to_tsvector('portuguese', NAME)) WHERE NAME IS NOT NULL;

-- Índice para busca case-insensitive no nome
CREATE INDEX IF NOT EXISTS idx_games_event_name_lower 
ON GAMES_EVENT (LOWER(NAME)) WHERE NAME IS NOT NULL;

-- Configuração de estatísticas para melhor performance
ALTER TABLE GAMES_EVENT ALTER COLUMN NAME SET STATISTICS 1000;
ALTER TABLE GAMES_EVENT ALTER COLUMN ID_GAME SET STATISTICS 1000;