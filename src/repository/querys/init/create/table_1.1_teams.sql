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

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA TEAMS
-- =====================================================================================

-- Índice para busca por nome do time (único recomendado)
CREATE UNIQUE INDEX IF NOT EXISTS idx_teams_team_name 
ON TEAMS (TEAM) WHERE TEAM IS NOT NULL;

-- Índice GIN para busca textual no nome do time
CREATE INDEX IF NOT EXISTS idx_teams_team_gin 
ON TEAMS USING GIN (to_tsvector('portuguese', TEAM)) WHERE TEAM IS NOT NULL;

-- Configuração de estatísticas para melhor performance
ALTER TABLE TEAMS ALTER COLUMN TEAM SET STATISTICS 1000;