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
