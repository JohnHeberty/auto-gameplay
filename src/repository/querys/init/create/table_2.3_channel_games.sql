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