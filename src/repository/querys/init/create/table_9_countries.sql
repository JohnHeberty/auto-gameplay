-- Tabela de referência para países
CREATE TABLE IF NOT EXISTS COUNTRIES (
    CODE VARCHAR(2) PRIMARY KEY, -- ISO 3166-1 alpha-2 (BR, US, etc.)
    "name" VARCHAR(100) NOT NULL,
    REGION VARCHAR(50),
    REGISTER_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Comentários nas colunas
COMMENT ON TABLE COUNTRIES IS                  'Tabela de referência para códigos de países conforme ISO 3166-1 alpha-2';
COMMENT ON COLUMN COUNTRIES.CODE IS            'Código do país ISO 3166-1 alpha-2 (2 letras - BR, US, etc.)';
COMMENT ON COLUMN COUNTRIES."name" IS          'Nome oficial do país em inglês';
COMMENT ON COLUMN COUNTRIES.REGION IS          'Região geográfica do país (Europe, Asia, Africa, etc.)';
COMMENT ON COLUMN COUNTRIES.REGISTER_DATE IS   'Timestamp de criação do registro';

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA COUNTRIES
-- =====================================================================================

-- O código do país já é a chave primária (índice automático)

-- Índice para busca por nome do país
CREATE INDEX IF NOT EXISTS idx_countries_name 
ON COUNTRIES ("name") WHERE "name" IS NOT NULL;

-- Índice para filtrar por região
CREATE INDEX IF NOT EXISTS idx_countries_region 
ON COUNTRIES (REGION) WHERE REGION IS NOT NULL;

-- Índice GIN para busca textual no nome do país
CREATE INDEX IF NOT EXISTS idx_countries_name_gin 
ON COUNTRIES USING GIN (to_tsvector('portuguese', "name")) WHERE "name" IS NOT NULL;

-- Índice para busca case-insensitive no nome
CREATE INDEX IF NOT EXISTS idx_countries_name_lower 
ON COUNTRIES (LOWER("name")) WHERE "name" IS NOT NULL;

-- Configuração de estatísticas para melhor performance
ALTER TABLE COUNTRIES ALTER COLUMN "name" SET STATISTICS 1000;
