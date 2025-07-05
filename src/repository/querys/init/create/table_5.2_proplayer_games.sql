CREATE TABLE IF NOT EXISTS PROPLAYERS_GAMES (
    ID_PROPLAYER INTEGER NOT NULL,
    ID_GAME INTEGER NOT NULL,
    REGISTER_DATE DATE NOT NULL,
    CONSTRAINT fk_proplayersgames_proplayer FOREIGN KEY (ID_PROPLAYER) REFERENCES PROPLAYERS(ID_PROPLAYER),
    CONSTRAINT fk_proplayersgames_game FOREIGN KEY (ID_GAME) REFERENCES GAMES(ID_GAME),
    PRIMARY KEY (ID_PROPLAYER, ID_GAME)
);

-- Comentários nas colunas
COMMENT ON TABLE PROPLAYERS_GAMES IS                'Tabela de relacionamento entre jogadores profissionais e jogos (muitos-para-muitos)';
COMMENT ON COLUMN PROPLAYERS_GAMES.ID_PROPLAYER IS  'ID do jogador profissional (referência à tabela PROPLAYERS)';
COMMENT ON COLUMN PROPLAYERS_GAMES.ID_GAME IS       'ID do jogo (referência à tabela GAMES)';
COMMENT ON COLUMN PROPLAYERS_GAMES.REGISTER_DATE IS 'Data de registro da associação do jogador com o jogo';
