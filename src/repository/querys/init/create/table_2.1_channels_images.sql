CREATE TABLE IF NOT EXISTS CHANNEL_IMAGES (
    ID_YOUTUBE VARCHAR(50) NOT NULL,
    LOGO BYTEA,
    BANNER BYTEA,
    VANITY BYTEA,
    CONSTRAINT fk_channelimages_channel FOREIGN KEY (ID_YOUTUBE) REFERENCES CHANNEL(ID_YOUTUBE),
    PRIMARY KEY (ID_YOUTUBE)
);

-- Comentários nas colunas
COMMENT ON TABLE CHANNEL_IMAGES IS              'Tabela para armazenar imagens dos canais do YouTube (logo, banner, vanity)';
COMMENT ON COLUMN CHANNEL_IMAGES.ID_YOUTUBE IS  'ID do canal do YouTube (referência à tabela CHANNEL) - chave primária';
COMMENT ON COLUMN CHANNEL_IMAGES.LOGO IS        'Dados binários da logo/avatar do canal em formato BYTEA';
COMMENT ON COLUMN CHANNEL_IMAGES.BANNER IS      'Dados binários do banner/capa do canal em formato BYTEA';
COMMENT ON COLUMN CHANNEL_IMAGES.VANITY IS      'Dados binários da imagem de vanity/miniatura do canal em formato BYTEA';

