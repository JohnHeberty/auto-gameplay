CREATE TABLE IF NOT EXISTS PLAYLIST_MOVIE (
    ID_MOVIE SERIAL PRIMARY KEY,
    ID_VIDEO VARCHAR(50) NOT NULL UNIQUE,
    URL VARCHAR(100) NOT NULL,
    ID_PLAYLIST VARCHAR(50) NOT NULL,
    ID_GAME INTEGER,
    ID_PROPLAYER INTEGER,
    ID_HERO INTEGER,
    REGISTER_DATE DATE NOT NULL,
    CONSTRAINT fk_playlistmovie_playlist FOREIGN KEY (ID_PLAYLIST) REFERENCES PLAYLIST(ID_PLAYLIST),
    CONSTRAINT fk_playlistmovie_game FOREIGN KEY (ID_GAME) REFERENCES GAMES(ID_GAME),
    CONSTRAINT fk_playlistmovie_proplayer FOREIGN KEY (ID_PROPLAYER) REFERENCES PROPLAYERS(ID_PROPLAYER),
    CONSTRAINT fk_playlistmovie_hero FOREIGN KEY (ID_HERO) REFERENCES HEROES(ID_HERO)
);

-- Comentários nas colunas
COMMENT ON TABLE PLAYLIST_MOVIE IS                  'Tabela para amarrar vídeos a sua playlist';
COMMENT ON COLUMN PLAYLIST_MOVIE.ID_MOVIE IS        'ID único do vídeo (auto-incremento)';
COMMENT ON COLUMN PLAYLIST_MOVIE.ID_VIDEO IS        'ID do vídeo no YouTube (único)';
COMMENT ON COLUMN PLAYLIST_MOVIE.URL IS             'URL completa do vídeo no YouTube';
COMMENT ON COLUMN PLAYLIST_MOVIE.ID_PLAYLIST IS     'ID da playlist à qual o vídeo pertence';
COMMENT ON COLUMN PLAYLIST_MOVIE.ID_GAME IS         'ID do jogo relacionado ao vídeo';
COMMENT ON COLUMN PLAYLIST_MOVIE.ID_PROPLAYER IS    'ID do jogador profissional (se aplicável)';
COMMENT ON COLUMN PLAYLIST_MOVIE.ID_HERO IS         'ID do herói/personagem (se aplicável)';
COMMENT ON COLUMN PLAYLIST_MOVIE.REGISTER_DATE IS   'Data de registro no sistema';

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA PLAYLIST_MOVIE
-- =====================================================================================

-- Índice para JOIN com playlist_movie_historic
CREATE INDEX IF NOT EXISTS idx_playlist_movie_id_movie 
ON PLAYLIST_MOVIE (ID_MOVIE);

-- Índice para JOIN com playlists
CREATE INDEX IF NOT EXISTS idx_playlist_movie_id_playlist 
ON PLAYLIST_MOVIE (ID_PLAYLIST);

-- Índice composto para filtros por jogo, herói e jogador
CREATE INDEX IF NOT EXISTS idx_playlist_movie_game_hero_player 
ON PLAYLIST_MOVIE (ID_GAME, ID_HERO, ID_PROPLAYER);

-- Índice para consultas por data de registro
CREATE INDEX IF NOT EXISTS idx_playlist_movie_register_date 
ON PLAYLIST_MOVIE (REGISTER_DATE DESC);

-- Índice único para ID_VIDEO (reforça performance da constraint UNIQUE)
CREATE INDEX IF NOT EXISTS idx_playlist_movie_id_video 
ON PLAYLIST_MOVIE (ID_VIDEO);

