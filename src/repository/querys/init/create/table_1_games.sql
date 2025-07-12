CREATE TABLE IF NOT EXISTS GAMES (
    ID_GAME SERIAL,
    NAME VARCHAR(50) NOT NULL,
    GAME VARCHAR(25) NOT NULL,
    ICO BYTEA,
    PRIMARY KEY (ID_GAME)
);

-- Comentários nas colunas
COMMENT ON TABLE GAMES IS           'Tabela para armazenar informações dos jogos';
COMMENT ON COLUMN GAMES.ID_GAME IS  'ID único do jogo (auto-incremento)';
COMMENT ON COLUMN GAMES.NAME IS     'Nome completo do jogo';
COMMENT ON COLUMN GAMES.GAME IS     'Nome abreviado ou sigla do jogo';
COMMENT ON COLUMN GAMES.ICO IS      'Dados binários do ícone/logo do jogo em formato BYTEA';

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA GAMES
-- =====================================================================================

-- Índice único para nome completo do jogo
CREATE UNIQUE INDEX IF NOT EXISTS idx_games_name 
ON GAMES (NAME) WHERE NAME IS NOT NULL;

-- Índice único para nome abreviado/sigla do jogo
CREATE UNIQUE INDEX IF NOT EXISTS idx_games_game 
ON GAMES (GAME) WHERE GAME IS NOT NULL;

-- Índice GIN para busca textual no nome completo
CREATE INDEX IF NOT EXISTS idx_games_name_gin 
ON GAMES USING GIN (to_tsvector('portuguese', NAME)) WHERE NAME IS NOT NULL;

-- Índice para busca case-insensitive no nome
CREATE INDEX IF NOT EXISTS idx_games_name_lower 
ON GAMES (LOWER(NAME)) WHERE NAME IS NOT NULL;

-- Configuração de estatísticas para melhor performance
ALTER TABLE GAMES ALTER COLUMN NAME SET STATISTICS 1000;
ALTER TABLE GAMES ALTER COLUMN GAME SET STATISTICS 1000;