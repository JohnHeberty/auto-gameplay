CREATE TABLE IF NOT EXISTS GAMES (
    ID_GAME SERIAL,
    NAME VARCHAR(50) NOT NULL,
    GAME VARCHAR(25) NOT NULL,
    ICO BYTEA,
    PRIMARY KEY (ID_GAME)
);

-- Comentários nas colunas
COMMENT ON TABLE GAMES IS           'Tabela para armazenar informações dos jogos';
COMMENT ON COLUMN GAMES.ID_GAME IS  'ID único do jogo (auto-incremento)';
COMMENT ON COLUMN GAMES.NAME IS     'Nome completo do jogo';
COMMENT ON COLUMN GAMES.GAME IS     'Nome abreviado ou sigla do jogo';
COMMENT ON COLUMN GAMES.ICO IS      'Dados binários do ícone/logo do jogo em formato BYTEA';