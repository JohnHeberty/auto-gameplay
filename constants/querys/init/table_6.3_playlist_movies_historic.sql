CREATE TABLE IF NOT EXISTS PLAYLIST_MOVIE_HISTORIC (
    ID_MOVIE INTEGER NOT NULL,
    "titulo" VARCHAR(50) NOT NULL,
    "description" VARCHAR(1000),
    LIKES INTEGER NOT NULL,
    "date_start" DATE NOT NULL,
    "date" DATE NOT NULL,
    "date_end" DATE,
    CONSTRAINT fk_playlistmoviehistoric_movie FOREIGN KEY (ID_MOVIE) REFERENCES PLAYLIST_MOVIE(ID_MOVIE),
    PRIMARY KEY (ID_MOVIE, "date_start", "date", "date_end")
);
