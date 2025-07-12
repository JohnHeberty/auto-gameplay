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

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA CHANNEL_HISTORIC
-- =====================================================================================

-- Índice para consultas por canal (temporal)
CREATE INDEX IF NOT EXISTS idx_channel_historic_id_youtube 
ON CHANNEL_HISTORIC (ID_YOUTUBE) WHERE ID_YOUTUBE IS NOT NULL;

-- Índice para consultas por data (encontrar histórico de uma data específica)
CREATE INDEX IF NOT EXISTS idx_channel_historic_register_date 
ON CHANNEL_HISTORIC (REGISTER_DATE) WHERE REGISTER_DATE IS NOT NULL;

-- Índice para ordenação por visualizações
CREATE INDEX IF NOT EXISTS idx_channel_historic_views 
ON CHANNEL_HISTORIC (VIEWS) WHERE VIEWS IS NOT NULL;

-- Índice para ordenação por número de inscritos
CREATE INDEX IF NOT EXISTS idx_channel_historic_subscribers 
ON CHANNEL_HISTORIC (SUBSCRIBERS) WHERE SUBSCRIBERS IS NOT NULL;

-- Índice composto para análises temporais por canal
CREATE INDEX IF NOT EXISTS idx_channel_historic_youtube_date 
ON CHANNEL_HISTORIC (ID_YOUTUBE, REGISTER_DATE) WHERE ID_YOUTUBE IS NOT NULL AND REGISTER_DATE IS NOT NULL;