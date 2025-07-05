CREATE TABLE IF NOT EXISTS ITENS (
    ID_ITEM SERIAL,
    "name" VARCHAR(50) NOT NULL,
    ID_GAME INTEGER NOT NULL,
    "description" VARCHAR(1000),
    "value" INTEGER NOT NULL,
    CONSTRAINT fk_itens_game FOREIGN KEY (ID_GAME) REFERENCES GAMES(ID_GAME),
    PRIMARY KEY (ID_ITEM)
);

-- Comentários nas colunas
COMMENT ON TABLE ITENS IS                   'Tabela para armazenar informações dos itens dos jogos';
COMMENT ON COLUMN ITENS.ID_ITEM IS          'ID único do item (auto-incremento)';
COMMENT ON COLUMN ITENS."name" IS           'Nome do item no jogo';
COMMENT ON COLUMN ITENS.ID_GAME IS          'ID do jogo ao qual o item pertence (referência à tabela GAMES)';
COMMENT ON COLUMN ITENS."description" IS    'Descrição do item e suas características';
COMMENT ON COLUMN ITENS."value" IS          'Valor/preço do item no jogo (moeda do jogo)';