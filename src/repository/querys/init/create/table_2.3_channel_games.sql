CREATE TABLE IF NOT EXISTS CHANNEL_GAMES (
    ID_YOUTUBE VARCHAR(50) NOT NULL,
    ID_GAME INTEGER NOT NULL,
    CONSTRAINT fk_channelgames_channel FOREIGN KEY (ID_YOUTUBE) REFERENCES CHANNEL(ID_YOUTUBE),
    CONSTRAINT fk_channelgames_game FOREIGN KEY (ID_GAME) REFERENCES GAMES(ID_GAME),
    PRIMARY KEY (ID_YOUTUBE, ID_GAME)
);

-- Comentários nas colunas
COMMENT ON TABLE CHANNEL_GAMES IS               'Tabela de relacionamento entre canais do YouTube e jogos (muitos-para-muitos)';
COMMENT ON COLUMN CHANNEL_GAMES.ID_YOUTUBE IS   'ID do canal do YouTube (referência à tabela CHANNEL)';
COMMENT ON COLUMN CHANNEL_GAMES.ID_GAME IS      'ID do jogo (referência à tabela GAMES)';

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA CHANNEL_GAMES
-- =====================================================================================

-- Índice para consultas por canal (encontrar jogos de um canal)
CREATE INDEX IF NOT EXISTS idx_channel_games_id_youtube 
ON CHANNEL_GAMES (ID_YOUTUBE) WHERE ID_YOUTUBE IS NOT NULL;

-- Índice para consultas por jogo (encontrar canais que jogam um jogo específico)
CREATE INDEX IF NOT EXISTS idx_channel_games_id_game 
ON CHANNEL_GAMES (ID_GAME) WHERE ID_GAME IS NOT NULL;