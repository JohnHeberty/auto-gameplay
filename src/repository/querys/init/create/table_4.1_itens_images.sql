CREATE TABLE IF NOT EXISTS ITENS_IMAGES (
    ID_ITEM INTEGER NOT NULL,
    HASH_IMAGE VARCHAR(64) NOT NULL UNIQUE,
    "image" BYTEA,
    CONSTRAINT fk_itensimages_item FOREIGN KEY (ID_ITEM) REFERENCES ITENS(ID_ITEM),
    PRIMARY KEY (ID_ITEM)
);

-- Comentários nas colunas
COMMENT ON TABLE ITENS_IMAGES IS                'Tabela para armazenar imagens dos itens do jogo';
COMMENT ON COLUMN ITENS_IMAGES.ID_ITEM IS       'ID do item relacionado (referência à tabela ITENS) - chave primária';
COMMENT ON COLUMN ITENS_IMAGES.HASH_IMAGE IS    'Hash SHA-256 da imagem para identificação única e verificação de integridade';
COMMENT ON COLUMN ITENS_IMAGES."image" IS       'Dados binários da imagem do item em formato BYTEA';
