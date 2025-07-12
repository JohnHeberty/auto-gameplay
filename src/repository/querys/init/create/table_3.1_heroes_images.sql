CREATE TABLE IF NOT EXISTS HEROES_IMAGES (
    ID_HERO INTEGER NOT NULL,
    HASH_IMAGE VARCHAR(64) NOT NULL UNIQUE,
    "image" BYTEA,
    CONSTRAINT fk_heroesimages_heros FOREIGN KEY (ID_HERO) REFERENCES HEROES(ID_HERO),
    PRIMARY KEY (ID_HERO)
);

-- Comentários nas colunas
COMMENT ON TABLE HEROES_IMAGES IS                'Tabela para armazenar imagens dos herois do jogo';
COMMENT ON COLUMN HEROES_IMAGES.ID_HERO IS       'ID do item relacionado (referência à tabela HEROES) - chave primária';
COMMENT ON COLUMN HEROES_IMAGES.HASH_IMAGE IS    'Hash SHA-256 da imagem para identificação única e verificação de integridade';
COMMENT ON COLUMN HEROES_IMAGES."image" IS       'Dados binários da imagem do item em formato BYTEA';

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA HEROES_IMAGES
-- =====================================================================================

-- Nota: Esta tabela tem relacionamento 1:1 com HEROES, então a chave primária ID_HERO
-- já fornece acesso direto. O índice único para HASH_IMAGE já é criado automaticamente
-- pela constraint UNIQUE.
-- Não são necessários índices adicionais para campos BYTEA.