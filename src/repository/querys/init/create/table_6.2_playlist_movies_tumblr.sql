CREATE TABLE IF NOT EXISTS PLAYLIST_MOVIE_TUMBLR (
    ID_MOVIE INTEGER NOT NULL,
    HASH_TUMBLR VARCHAR(64) NOT NULL,
    TUMBLR BYTEA NOT NULL,
    REGISTER_DATE DATE NOT NULL,
    CONSTRAINT fk_playlistmovietumblr_movie FOREIGN KEY (ID_MOVIE) REFERENCES PLAYLIST_MOVIE(ID_MOVIE),
    PRIMARY KEY (HASH_TUMBLR)
);

-- Comentários nas colunas
COMMENT ON TABLE PLAYLIST_MOVIE_TUMBLR IS                   'Tabela para armazenar thumbnails dos vídeos das playlists';
COMMENT ON COLUMN PLAYLIST_MOVIE_TUMBLR.ID_MOVIE IS         'ID do vídeo relacionado (referência à tabela PLAYLIST_MOVIE)';
COMMENT ON COLUMN PLAYLIST_MOVIE_TUMBLR.HASH_TUMBLR IS      'Hash SHA-256 da thumbnail para identificação única e verificação de integridade';
COMMENT ON COLUMN PLAYLIST_MOVIE_TUMBLR.TUMBLR IS           'Dados binários da thumbnail (imagem em formato BYTEA)';
COMMENT ON COLUMN PLAYLIST_MOVIE_TUMBLR.REGISTER_DATE IS    'Data de registro da thumbnail no sistema';

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA PLAYLIST_MOVIE_TUMBLR
-- =====================================================================================

-- Índice para consultas por vídeo (encontrar thumbnails de um vídeo específico)
CREATE INDEX IF NOT EXISTS idx_playlist_movie_tumblr_id_movie 
ON PLAYLIST_MOVIE_TUMBLR (ID_MOVIE) WHERE ID_MOVIE IS NOT NULL;

-- Índice para ordenação por data de registro
CREATE INDEX IF NOT EXISTS idx_playlist_movie_tumblr_register_date 
ON PLAYLIST_MOVIE_TUMBLR (REGISTER_DATE) WHERE REGISTER_DATE IS NOT NULL;

-- Índice composto para consultas por vídeo e data
CREATE INDEX IF NOT EXISTS idx_playlist_movie_tumblr_movie_date 
ON PLAYLIST_MOVIE_TUMBLR (ID_MOVIE, REGISTER_DATE) WHERE ID_MOVIE IS NOT NULL AND REGISTER_DATE IS NOT NULL;

