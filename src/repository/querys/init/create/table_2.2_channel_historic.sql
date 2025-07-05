CREATE TABLE IF NOT EXISTS CHANNEL_HISTORIC (
    ID_YOUTUBE VARCHAR(50) NOT NULL,
    VIEWS INTEGER NOT NULL,
    SUBSCRIBERS INTEGER NOT NULL,
    REGISTER_DATE DATE NOT NULL,
    CONSTRAINT fk_channelhistoric_channel FOREIGN KEY (ID_YOUTUBE) REFERENCES CHANNEL(ID_YOUTUBE),
    PRIMARY KEY (ID_YOUTUBE, REGISTER_DATE)
);

-- Comentários nas colunas
COMMENT ON TABLE CHANNEL_HISTORIC IS                'Tabela para armazenar histórico de métricas dos canais do YouTube';
COMMENT ON COLUMN CHANNEL_HISTORIC.ID_YOUTUBE IS    'ID do canal do YouTube (referência à tabela CHANNEL)';
COMMENT ON COLUMN CHANNEL_HISTORIC.VIEWS IS         'Número total de visualizações do canal na data do registro';
COMMENT ON COLUMN CHANNEL_HISTORIC.SUBSCRIBERS IS   'Número total de inscritos do canal na data do registro';
COMMENT ON COLUMN CHANNEL_HISTORIC.REGISTER_DATE IS 'Data do registro histórico das métricas (parte da chave primária)';