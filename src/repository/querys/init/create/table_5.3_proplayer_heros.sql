CREATE TABLE IF NOT EXISTS PROPLAYERS_HEROES (
    ID_PROPLAYER INTEGER NOT NULL,
    ID_HERO INTEGER NOT NULL,
    REGISTER_DATE DATE NOT NULL,
    CONSTRAINT fk_proplayersheroes_proplayer FOREIGN KEY (ID_PROPLAYER) REFERENCES PROPLAYERS(ID_PROPLAYER),
    CONSTRAINT fk_proplayersheroes_hero FOREIGN KEY (ID_HERO) REFERENCES HEROES(ID_HERO),
    PRIMARY KEY (ID_PROPLAYER, ID_HERO)
);

-- Comentários nas colunas
COMMENT ON TABLE PROPLAYERS_HEROES IS                   'Tabela de relacionamento entre jogadores profissionais e heróis (muitos-para-muitos)';
COMMENT ON COLUMN PROPLAYERS_HEROES.ID_PROPLAYER IS     'ID do jogador profissional (referência à tabela PROPLAYERS)';
COMMENT ON COLUMN PROPLAYERS_HEROES.ID_HERO IS          'ID do herói/personagem (referência à tabela HEROES)';
COMMENT ON COLUMN PROPLAYERS_HEROES.REGISTER_DATE IS    'Data de registro da associação do jogador com o herói';
