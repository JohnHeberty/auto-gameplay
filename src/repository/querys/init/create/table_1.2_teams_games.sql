CREATE TABLE IF NOT EXISTS TEAMS_GAME (
    ID_TEAM INTEGER NOT NULL,
    ID_GAME INTEGER,
    BANNER BYTEA,
    CONSTRAINT fk_teamsgame_team FOREIGN KEY (ID_TEAM) REFERENCES TEAMS(ID_TEAM),
    CONSTRAINT fk_teamsgame_game FOREIGN KEY (ID_GAME) REFERENCES GAMES(ID_GAME),
    PRIMARY KEY (ID_TEAM, ID_GAME)
);

-- Comentários nas colunas
COMMENT ON TABLE TEAMS_GAME IS          'Tabela de relacionamento entre times e jogos com banner específico para cada combinação';
COMMENT ON COLUMN TEAMS_GAME.ID_TEAM IS 'ID do time (referência à tabela TEAMS)';
COMMENT ON COLUMN TEAMS_GAME.ID_GAME IS 'ID do jogo (referência à tabela GAMES)';
COMMENT ON COLUMN TEAMS_GAME.BANNER IS  'Dados binários do banner/logo do time específico para este jogo em formato BYTEA';

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA TEAMS_GAME
-- =====================================================================================

-- Índice para consultas por time (encontrar jogos de um time)
CREATE INDEX IF NOT EXISTS idx_teams_game_id_team 
ON TEAMS_GAME (ID_TEAM) WHERE ID_TEAM IS NOT NULL;

-- Índice para consultas por jogo (encontrar times que jogam um jogo específico)
CREATE INDEX IF NOT EXISTS idx_teams_game_id_game 
ON TEAMS_GAME (ID_GAME) WHERE ID_GAME IS NOT NULL;
