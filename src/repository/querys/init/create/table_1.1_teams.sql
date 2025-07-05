CREATE TABLE IF NOT EXISTS TEAMS (
    ID_TEAM SERIAL,
    TEAM VARCHAR(50) NOT NULL,
    LOGO BYTEA,
    PRIMARY KEY (ID_TEAM)
);

-- Comentários nas colunas
COMMENT ON TABLE TEAMS IS           'Tabela para armazenar informações dos times de e-sports';
COMMENT ON COLUMN TEAMS.ID_TEAM IS  'ID único do time (auto-incremento)';
COMMENT ON COLUMN TEAMS.TEAM IS     'Nome do time de e-sports';
COMMENT ON COLUMN TEAMS.LOGO IS     'Dados binários do logo/logotipo do time em formato BYTEA';