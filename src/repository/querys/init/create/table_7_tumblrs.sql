CREATE TABLE IF NOT EXISTS TUMBLR (
    ID_HERO INTEGER NOT NULL,
    "description" VARCHAR(1000),
    HASH_TUMBLR VARCHAR(64) NOT NULL,
    "image" BYTEA,
    CONSTRAINT fk_tumblr_hero FOREIGN KEY (ID_HERO) REFERENCES HEROES(ID_HERO),
    PRIMARY KEY (ID_HERO, HASH_TUMBLR)
);

-- Comentários nas colunas
COMMENT ON TABLE TUMBLR IS                  'Tabela para armazenar imagens/thumbnails dos heróis';
COMMENT ON COLUMN TUMBLR.ID_HERO IS         'ID do herói relacionado (referência à tabela HEROES)';
COMMENT ON COLUMN TUMBLR."description" IS   'Descrição da imagem/thumbnail do herói';
COMMENT ON COLUMN TUMBLR.HASH_TUMBLR IS     'Hash SHA-256 da imagem para identificação única e verificação de integridade';
COMMENT ON COLUMN TUMBLR."image" IS         'Dados binários da imagem do herói em formato BYTEA';

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA TUMBLR
-- =====================================================================================

-- Índice para consultas por herói (encontrar thumbnails de um herói)
CREATE INDEX IF NOT EXISTS idx_tumblr_id_hero 
ON TUMBLR (ID_HERO) WHERE ID_HERO IS NOT NULL;

-- Índice único para hash (parte da chave primária composta)
-- O PostgreSQL já cria índice automático para a PRIMARY KEY (ID_HERO, HASH_TUMBLR)

-- Índice GIN para busca textual na descrição
CREATE INDEX IF NOT EXISTS idx_tumblr_description_gin 
ON TUMBLR USING GIN (to_tsvector('portuguese', "description")) WHERE "description" IS NOT NULL;