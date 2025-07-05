CREATE TABLE IF NOT EXISTS PLAYLIST_MOVIE_HISTORIC (
    ID_MOVIE INTEGER NOT NULL,
    TITLE VARCHAR(100) NOT NULL,
    "description" VARCHAR(5000),
    VIEWS INTEGER,
    LIKES INTEGER,
    LIVE BOOLEAN,
    keywords TEXT[], -- Array de palavras-chave
    available_countries VARCHAR(2)[], -- Array de códigos de países (ISO 3166-1 alpha-2)
    CATEGORY VARCHAR(50),
    FAMILY_FRIENDLY BOOLEAN,
    DT_UPLOAD DATE,
    DT_PUBLISH DATE,
    DT_START DATE NOT NULL,
    DT_END DATE,
    CONSTRAINT fk_playlistmoviehistoric_movie FOREIGN KEY (ID_MOVIE) REFERENCES PLAYLIST_MOVIE(ID_MOVIE),
    PRIMARY KEY (ID_MOVIE, DT_END)
);

-- Comentários nas colunas
COMMENT ON TABLE PLAYLIST_MOVIE_HISTORIC IS                         'Tabela para armazenar histórico de alterações e metadados dos vídeos das playlists';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.ID_MOVIE IS               'ID do vídeo relacionado (referência à tabela PLAYLIST_MOVIE)';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.TITLE IS                  'Título do vídeo no momento do registro histórico';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC."description" IS          'Descrição do vídeo no momento do registro histórico';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.VIEWS IS                  'Número de visualizações do vídeo no momento do registro';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.LIKES IS                  'Número de likes do vídeo no momento do registro';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.LIVE IS                   'Indica se o vídeo foi uma transmissão ao vivo';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.keywords IS               'Array de palavras-chave/tags associadas ao vídeo';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.available_countries IS    'Array de códigos de países onde o vídeo está disponível (ISO 3166-1 alpha-2)';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.CATEGORY IS               'Categoria do vídeo no YouTube (Gaming, Education, etc.)';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.FAMILY_FRIENDLY IS        'Indica se o vídeo é adequado para toda a família';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.DT_UPLOAD IS              'Data de upload do vídeo no YouTube';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.DT_PUBLISH IS             'Data de publicação do vídeo no YouTube';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.DT_START IS               'Data de início da vigência deste registro histórico';
COMMENT ON COLUMN PLAYLIST_MOVIE_HISTORIC.DT_END IS                 'Data de fim da vigência deste registro histórico (parte da chave primária)';
