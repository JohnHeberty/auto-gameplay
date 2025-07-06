-- Tabela de referência para países
CREATE TABLE IF NOT EXISTS COUNTRIES (
    CODE VARCHAR(2) PRIMARY KEY, -- ISO 3166-1 alpha-2 (BR, US, etc.)
    "name" VARCHAR(100) NOT NULL,
    REGION VARCHAR(50),
    REGISTER_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Comentários nas colunas
COMMENT ON TABLE countries IS               'Tabela de referência para códigos de países conforme ISO 3166-1 alpha-2';
COMMENT ON COLUMN countries.code IS         'Código do país ISO 3166-1 alpha-2 (2 letras - BR, US, etc.)';
COMMENT ON COLUMN countries."name" IS       'Nome oficial do país em inglês';
COMMENT ON COLUMN countries.region IS       'Região geográfica do país (Europe, Asia, Africa, etc.)';
COMMENT ON COLUMN countries.created_at IS   'Timestamp de criação do registro';
