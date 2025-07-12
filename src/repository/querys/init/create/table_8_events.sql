CREATE TABLE IF NOT EXISTS EVENTS (
    ID_EVENT SERIAL PRIMARY KEY,
    "name" VARCHAR(50) NOT NULL,
    ID_GAME INTEGER NOT NULL,
    DATE_START DATE,
    DATE_END DATE,
    CONSTRAINT fk_events_game FOREIGN KEY (ID_GAME) REFERENCES GAMES(ID_GAME)
);

-- Comentários nas colunas
COMMENT ON TABLE EVENTS IS              'Tabela para armazenar informações dos eventos de e-sports';
COMMENT ON COLUMN EVENTS.ID_EVENT IS    'ID único do evento (auto-incremento)';
COMMENT ON COLUMN EVENTS."name" IS      'Nome do evento de e-sports';
COMMENT ON COLUMN EVENTS.ID_GAME IS     'ID do jogo relacionado ao evento (referência à tabela GAMES)';
COMMENT ON COLUMN EVENTS.DATE_START IS  'Data de início do evento';
COMMENT ON COLUMN EVENTS.DATE_END IS    'Data de término do evento';

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA EVENTS
-- =====================================================================================

-- Índice para busca por nome do evento
CREATE INDEX IF NOT EXISTS idx_events_name 
ON EVENTS ("name") WHERE "name" IS NOT NULL;

-- Índice para filtrar eventos por jogo
CREATE INDEX IF NOT EXISTS idx_events_id_game 
ON EVENTS (ID_GAME) WHERE ID_GAME IS NOT NULL;

-- Índice para filtrar eventos por data de início
CREATE INDEX IF NOT EXISTS idx_events_date_start 
ON EVENTS (DATE_START) WHERE DATE_START IS NOT NULL;

-- Índice para filtrar eventos por data de término
CREATE INDEX IF NOT EXISTS idx_events_date_end 
ON EVENTS (DATE_END) WHERE DATE_END IS NOT NULL;

-- Índice composto para consultas por jogo e período
CREATE INDEX IF NOT EXISTS idx_events_game_dates 
ON EVENTS (ID_GAME, DATE_START, DATE_END) WHERE ID_GAME IS NOT NULL;

-- Índice GIN para busca textual no nome do evento
CREATE INDEX IF NOT EXISTS idx_events_name_gin 
ON EVENTS USING GIN (to_tsvector('portuguese', "name")) WHERE "name" IS NOT NULL;

-- Configuração de estatísticas para melhor performance
ALTER TABLE EVENTS ALTER COLUMN "name" SET STATISTICS 1000;
