CREATE TABLE IF NOT EXISTS ITENS (
    ID_ITEM INTEGER NOT NULL UNIQUE,
    "name" VARCHAR(40) NOT NULL UNIQUE,
    DNAME VARCHAR(40) NOT NULL,
    IMG VARCHAR(100) NOT NULL,
    QUAL VARCHAR(50),
    COST INTEGER,
    DMG_TYPE VARCHAR(50),
    NOTES VARCHAR(400),
    MC INTEGER,
    HC INTEGER,
    CD INTEGER,
    LORE VARCHAR(250),
    CREATED BOOLEAN,
    CHARGES BOOLEAN,
    ID_GAME INTEGER NOT NULL,
    CONSTRAINT fk_itens_game FOREIGN KEY (ID_GAME) REFERENCES GAMES(ID_GAME),
    PRIMARY KEY (ID_ITEM)
);

-- Comentários nas colunas
COMMENT ON TABLE ITENS IS                   'Tabela para armazenar informações detalhadas dos itens dos jogos';
COMMENT ON COLUMN ITENS.ID_ITEM IS          'ID único do item';
COMMENT ON COLUMN ITENS."name" IS           'Nome interno/chave do item (ex: overwhelming_blink)';
COMMENT ON COLUMN ITENS.DNAME IS            'Nome de exibição do item (ex: Overwhelming Blink)';
COMMENT ON COLUMN ITENS.IMG IS              'Caminho para a imagem/ícone do item';
COMMENT ON COLUMN ITENS.QUAL IS             'Qualidade/raridade do item (component, consumable, artifact, etc.)';
COMMENT ON COLUMN ITENS.COST IS             'Custo do item em moeda do jogo';
COMMENT ON COLUMN ITENS.DMG_TYPE IS         'Tipo de dano do item (Physical, Magical, Pure, etc.)';
COMMENT ON COLUMN ITENS.NOTES IS            'Notas especiais sobre o uso do item';
COMMENT ON COLUMN ITENS.MC IS               'Indica se o item pode ser usado por múltiplos personagens (Multi Cast)';
COMMENT ON COLUMN ITENS.HC IS               'Indica se o item pode ser usado por heróis específicos (Hero Cast)';
COMMENT ON COLUMN ITENS.CD IS               'Cooldown do item em segundos';
COMMENT ON COLUMN ITENS.LORE IS             'História/lore do item no universo do jogo';
COMMENT ON COLUMN ITENS.CREATED IS          'Indica se o item é criado através de componentes';
COMMENT ON COLUMN ITENS.CHARGES IS          'Indica se o item possui cargas limitadas de uso';
COMMENT ON COLUMN ITENS.ID_GAME IS          'ID do jogo ao qual o item pertence (chave estrangeira para GAMES)';
