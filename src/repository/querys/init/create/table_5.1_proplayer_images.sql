CREATE TABLE IF NOT EXISTS PROPLAYERS_IMAGES (
    ID_IMAGE SERIAL,
    ID_PROPLAYER INTEGER NOT NULL,
    HASH_TUMBLR VARCHAR(64) NOT NULL UNIQUE,
    "image" BYTEA,
    CONSTRAINT fk_proplayersimages_proplayer FOREIGN KEY (ID_PROPLAYER) REFERENCES PROPLAYERS(ID_PROPLAYER),
    PRIMARY KEY (ID_IMAGE)
);

-- Comentários nas colunas
COMMENT ON TABLE PROPLAYERS_IMAGES IS                   'Tabela para armazenar imagens dos jogadores profissionais';
COMMENT ON COLUMN PROPLAYERS_IMAGES.ID_IMAGE IS         'ID único da imagem (auto-incremento)';
COMMENT ON COLUMN PROPLAYERS_IMAGES.ID_PROPLAYER IS     'ID do jogador profissional relacionado (referência à tabela PROPLAYERS)';
COMMENT ON COLUMN PROPLAYERS_IMAGES.HASH_TUMBLR IS      'Hash SHA-256 da imagem para identificação única e verificação de integridade';
COMMENT ON COLUMN PROPLAYERS_IMAGES."image" IS          'Dados binários da imagem do jogador profissional em formato BYTEA';

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA PROPLAYERS_IMAGES
-- =====================================================================================

-- Índice para consultas por jogador (encontrar imagens de um jogador)
CREATE INDEX IF NOT EXISTS idx_proplayers_images_id_proplayer 
ON PROPLAYERS_IMAGES (ID_PROPLAYER) WHERE ID_PROPLAYER IS NOT NULL;

-- Índice único para hash (já criado automaticamente pela constraint UNIQUE)
-- CREATE UNIQUE INDEX IF NOT EXISTS idx_proplayers_images_hash_tumblr 
-- ON PROPLAYERS_IMAGES (HASH_TUMBLR) WHERE HASH_TUMBLR IS NOT NULL;