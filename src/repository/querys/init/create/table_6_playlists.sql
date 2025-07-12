CREATE TABLE IF NOT EXISTS PLAYLIST (
    ID_PLAYLIST VARCHAR(50) NOT NULL,
    ID_YOUTUBE VARCHAR(50) NOT NULL,
    ID_GAME INTEGER,
    TITLE VARCHAR(200) NOT NULL,
    "description" VARCHAR(1000),
    REGISTER_DATE DATE NOT NULL,
    CONSTRAINT fk_playlist_channel FOREIGN KEY (ID_YOUTUBE) REFERENCES CHANNEL(ID_YOUTUBE),
    CONSTRAINT fk_playlist_game FOREIGN KEY (ID_GAME) REFERENCES GAMES(ID_GAME),
    PRIMARY KEY (ID_PLAYLIST)
);

-- Comentários nas colunas
COMMENT ON TABLE PLAYLIST IS                'Tabela para armazenar informações das playlists do YouTube';
COMMENT ON COLUMN PLAYLIST.ID_PLAYLIST IS   'ID único da playlist no YouTube (chave primária)';
COMMENT ON COLUMN PLAYLIST.ID_YOUTUBE IS    'ID do canal do YouTube proprietário da playlist';
COMMENT ON COLUMN PLAYLIST.ID_GAME IS       'ID do jogo relacionado à playlist (opcional)';
COMMENT ON COLUMN PLAYLIST.TITLE IS         'Título da playlist';
COMMENT ON COLUMN PLAYLIST."description" IS 'Descrição da playlist (opcional)';
COMMENT ON COLUMN PLAYLIST.REGISTER_DATE IS 'Data de registro da playlist no sistema';

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA PLAYLIST
-- =====================================================================================

-- Índice para JOIN com channels
CREATE INDEX IF NOT EXISTS idx_playlist_id_youtube 
ON PLAYLIST (ID_YOUTUBE);

-- Índice para filtros por jogo
CREATE INDEX IF NOT EXISTS idx_playlist_id_game 
ON PLAYLIST (ID_GAME);

-- Índice para busca no título da playlist (usado na detecção de heróis)
CREATE INDEX IF NOT EXISTS idx_playlist_title_text 
ON PLAYLIST USING gin(to_tsvector('english', TITLE));

-- Índice para consultas por data de registro
CREATE INDEX IF NOT EXISTS idx_playlist_register_date 
ON PLAYLIST (REGISTER_DATE DESC);

-- Aumentar estatísticas para coluna de texto
ALTER TABLE PLAYLIST 
ALTER COLUMN title SET STATISTICS 1000;