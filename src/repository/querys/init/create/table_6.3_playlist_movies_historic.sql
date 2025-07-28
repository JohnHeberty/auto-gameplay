CREATE TABLE IF NOT EXISTS PLAYLIST_MOVIE_HISTORIC_2 (
    ID_MOVIE INTEGER UNIQUE NOT NULL,
    TITLE VARCHAR(100) NOT NULL,
    "description" VARCHAR(5000),
    VIEWS INTEGER,
    LIKES INTEGER,
    LIVE BOOLEAN,
    KEYWORDS TEXT[], -- Array de palavras-chave
    AVAILABLE_COUNTRIES VARCHAR(2)[], -- Array de códigos de países (ISO 3166-1 alpha-2)
    CATEGORY VARCHAR(50),
    FAMILY_FRIENDLY BOOLEAN,
    DT_UPLOAD DATE,
    DT_PUBLISH DATE,
    REGISTER_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    SYNCHRONIZED BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_playlistmoviehistoric_movie FOREIGN KEY (ID_MOVIE) REFERENCES PLAYLIST_MOVIE(ID_MOVIE),
    PRIMARY KEY (ID_MOVIE)
);

ALTER TABLE PLAYLIST_MOVIE_HISTORIC 
ADD CONSTRAINT unique_id_movie UNIQUE (ID_MOVIE);

-- Comentários nas colunas
COMMENT ON TABLE PLAYLIST_MOVIE_HISTORIC IS                         'Tabela para armazenar histórico de alterações e metadados dos vídeos das playlists';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.ID_MOVIE IS               'ID do vídeo relacionado (referência à tabela PLAYLIST_MOVIE)';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.TITLE IS                  'Título do vídeo no momento do registro histórico';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC."description" IS          'Descrição do vídeo no momento do registro histórico';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.VIEWS IS                  'Número de visualizações do vídeo no momento do registro';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.LIKES IS                  'Número de likes do vídeo no momento do registro';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.LIVE IS                   'Indica se o vídeo foi uma transmissão ao vivo';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.KEYWORDS IS               'Array de palavras-chave/tags associadas ao vídeo';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.AVAILABLE_COUNTRIES IS    'Array de códigos de países onde o vídeo está disponível (ISO 3166-1 alpha-2)';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.CATEGORY IS               'Categoria do vídeo no YouTube (Gaming, Education, etc.)';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.FAMILY_FRIENDLY IS        'Indica se o vídeo é adequado para toda a família';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.DT_UPLOAD IS              'Data de upload do vídeo no YouTube';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.DT_PUBLISH IS             'Data de publicação do vídeo no YouTube';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.REGISTER_DATE IS          'Data e hora do registro deste histórico';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.SYNCHRONIZED IS           'Indica se o registro foi sincronizado com o YouTube';

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA PLAYLIST_MOVIE_HISTORIC
-- =====================================================================================

-- Índice principal para consultas por ID_MOVIE e datas
CREATE INDEX IF NOT EXISTS idx_playlist_movie_historic_id_movie_dt 
ON PLAYLIST_MOVIE_HISTORIC (ID_MOVIE, DT_UPLOAD, DT_PUBLISH);

-- Índice para consultas por data de upload (muito usado nas views)
CREATE INDEX IF NOT EXISTS idx_playlist_movie_historic_dt_upload 
ON PLAYLIST_MOVIE_HISTORIC (DT_UPLOAD DESC);

-- Índice para consultas por data de publicação
CREATE INDEX IF NOT EXISTS idx_playlist_movie_historic_dt_publish 
ON PLAYLIST_MOVIE_HISTORIC (DT_PUBLISH DESC);

-- Índice para busca de texto no título (usado na detecção de heróis)
CREATE INDEX IF NOT EXISTS idx_playlist_movie_historic_title_text 
ON PLAYLIST_MOVIE_HISTORIC USING gin(to_tsvector('english', TITLE));

-- Índice para busca de texto na descrição (usado na detecção de heróis)
CREATE INDEX IF NOT EXISTS idx_playlist_movie_historic_description_text 
ON PLAYLIST_MOVIE_HISTORIC USING gin(to_tsvector('english', "description"));

-- Índice para consultas por views e likes (usado em análises)
CREATE INDEX IF NOT EXISTS idx_playlist_movie_historic_views_likes 
ON PLAYLIST_MOVIE_HISTORIC (VIEWS DESC, LIKES DESC);

-- Índice para range de datas (DT_START, DT_END)
CREATE INDEX IF NOT EXISTS idx_playlist_movie_historic_date_range 
ON PLAYLIST_MOVIE_HISTORIC (DT_START, DT_END);

-- Índice para vídeos com views altas (análises de performance)
CREATE INDEX IF NOT EXISTS idx_high_performance_videos 
ON PLAYLIST_MOVIE_HISTORIC (ID_MOVIE, VIEWS, LIKES) 
WHERE VIEWS > 1000;

-- Índice para vídeos recentes
CREATE INDEX IF NOT EXISTS idx_recent_videos 
ON PLAYLIST_MOVIE_HISTORIC (DT_UPLOAD DESC, ID_MOVIE) 
WHERE DT_UPLOAD IS NOT NULL;

-- Índice GIN para busca em keywords
CREATE INDEX IF NOT EXISTS idx_playlist_movie_historic_keywords 
ON PLAYLIST_MOVIE_HISTORIC USING gin(KEYWORDS);

-- Índices MD5 hash para detecção de heróis (evita limite de tamanho)
CREATE INDEX IF NOT EXISTS idx_hero_detection_title_hash 
ON PLAYLIST_MOVIE_HISTORIC (
    MD5(LOWER(REGEXP_REPLACE(COALESCE(title, ''), '[^a-zA-Z0-9\s]', '', 'g')))
);

CREATE INDEX IF NOT EXISTS idx_hero_detection_description_hash 
ON PLAYLIST_MOVIE_HISTORIC (
    MD5(LOWER(REGEXP_REPLACE(COALESCE("description", ''), '[^a-zA-Z0-9\s]', '', 'g')))
);

-- Índice GIN para busca de texto completo (detecção de heróis)
CREATE INDEX IF NOT EXISTS idx_hero_detection_fulltext 
ON PLAYLIST_MOVIE_HISTORIC USING gin(
    to_tsvector('english', COALESCE(title, '') || ' ' || COALESCE("description", ''))
);

-- Índice para análises de versão
CREATE INDEX IF NOT EXISTS idx_version_analysis 
ON PLAYLIST_MOVIE_HISTORIC (DT_UPLOAD, VIEWS, LIKES) 
WHERE VIEWS IS NOT NULL AND LIKES IS NOT NULL;

-- Aumentar estatísticas para colunas de texto (melhor plano de consulta)
ALTER TABLE PLAYLIST_MOVIE_HISTORIC 
ALTER COLUMN title SET STATISTICS 1000;

ALTER TABLE PLAYLIST_MOVIE_HISTORIC 
ALTER COLUMN "description" SET STATISTICS 1000;
