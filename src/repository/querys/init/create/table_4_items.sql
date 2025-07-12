CREATE TABLE IF NOT EXISTS ITEMS (
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
    CHARGES INTEGER,
    ID_GAME INTEGER NOT NULL,
    CONSTRAINT fk_itens_game FOREIGN KEY (ID_GAME) REFERENCES GAMES(ID_GAME),
    PRIMARY KEY (ID_ITEM)
);

-- Comentários nas colunas
COMMENT ON TABLE ITEMS IS                   'Tabela para armazenar informações detalhadas dos itens dos jogos';
COMMENT ON COLUMN ITEMS.ID_ITEM IS          'ID único do item';
COMMENT ON COLUMN ITEMS."name" IS           'Nome interno/chave do item (ex: overwhelming_blink)';
COMMENT ON COLUMN ITEMS.DNAME IS            'Nome de exibição do item (ex: Overwhelming Blink)';
COMMENT ON COLUMN ITEMS.IMG IS              'Caminho para a imagem/ícone do item';
COMMENT ON COLUMN ITEMS.QUAL IS             'Qualidade/raridade do item (component, consumable, artifact, etc.)';
COMMENT ON COLUMN ITEMS.COST IS             'Custo do item em moeda do jogo';
COMMENT ON COLUMN ITEMS.DMG_TYPE IS         'Tipo de dano do item (Physical, Magical, Pure, etc.)';
COMMENT ON COLUMN ITEMS.NOTES IS            'Notas especiais sobre o uso do item';
COMMENT ON COLUMN ITEMS.MC IS               'Indica se o item pode ser usado por múltiplos personagens (Multi Cast)';
COMMENT ON COLUMN ITEMS.HC IS               'Indica se o item pode ser usado por heróis específicos (Hero Cast)';
COMMENT ON COLUMN ITEMS.CD IS               'Cooldown do item em segundos';
COMMENT ON COLUMN ITEMS.LORE IS             'História/lore do item no universo do jogo';
COMMENT ON COLUMN ITEMS.CREATED IS          'Indica se o item é criado através de componentes';
COMMENT ON COLUMN ITEMS.CHARGES IS          'Indica se o item possui cargas limitadas de uso';
COMMENT ON COLUMN ITEMS.ID_GAME IS          'ID do jogo ao qual o item pertence (chave estrangeira para GAMES)';

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA ITEMS
-- =====================================================================================

-- Índice para busca por nome (único)
CREATE UNIQUE INDEX IF NOT EXISTS idx_itens_name 
ON ITEMS ("name") WHERE "name" IS NOT NULL;

-- Índice GIN para busca textual no nome de exibição
CREATE INDEX IF NOT EXISTS idx_itens_dname_gin 
ON ITEMS USING GIN (to_tsvector('portuguese', DNAME)) WHERE DNAME IS NOT NULL;

-- Índice para busca case-insensitive no nome de exibição
CREATE INDEX IF NOT EXISTS idx_itens_dname_lower 
ON ITEMS (LOWER(DNAME)) WHERE DNAME IS NOT NULL;

-- Índice para filtrar por jogo
CREATE INDEX IF NOT EXISTS idx_itens_id_game 
ON ITEMS (ID_GAME) WHERE ID_GAME IS NOT NULL;

-- Índice para filtrar por qualidade
CREATE INDEX IF NOT EXISTS idx_itens_qual 
ON ITEMS (QUAL) WHERE QUAL IS NOT NULL;

-- Índice para filtrar por custo
CREATE INDEX IF NOT EXISTS idx_itens_cost 
ON ITEMS (COST) WHERE COST IS NOT NULL;

-- Índice para filtrar por tipo de dano
CREATE INDEX IF NOT EXISTS idx_itens_dmg_type 
ON ITEMS (DMG_TYPE) WHERE DMG_TYPE IS NOT NULL;

-- Índice para filtrar itens criados através de componentes
CREATE INDEX IF NOT EXISTS idx_itens_created 
ON ITEMS (CREATED) WHERE CREATED IS NOT NULL;

-- Índice para filtrar itens com cargas
CREATE INDEX IF NOT EXISTS idx_itens_charges 
ON ITEMS (CHARGES) WHERE CHARGES IS NOT NULL;

-- Índice composto para consultas por jogo e qualidade
CREATE INDEX IF NOT EXISTS idx_itens_game_qual 
ON ITEMS (ID_GAME, QUAL) WHERE ID_GAME IS NOT NULL AND QUAL IS NOT NULL;

-- Configuração de estatísticas para melhor performance
ALTER TABLE ITEMS ALTER COLUMN "name" SET STATISTICS 1000;
ALTER TABLE ITEMS ALTER COLUMN DNAME SET STATISTICS 1000;
