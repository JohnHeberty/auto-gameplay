CREATE TABLE IF NOT EXISTS PROPLAYERS (
    ID_PROPLAYER SERIAL,
    "NOME" VARCHAR(50) NOT NULL,
    "description" VARCHAR(1000),
    REGISTER_DATE DATE NOT NULL,
    PRIMARY KEY (ID_PROPLAYER)
);

-- Comentários nas colunas
COMMENT ON TABLE PROPLAYERS IS                  'Tabela para armazenar informações dos jogadores profissionais';
COMMENT ON COLUMN PROPLAYERS.ID_PROPLAYER IS    'ID único do jogador profissional (auto-incremento)';
COMMENT ON COLUMN PROPLAYERS."NOME" IS          'Nome do jogador profissional';
COMMENT ON COLUMN PROPLAYERS."description" IS   'Descrição ou biografia do jogador profissional';
COMMENT ON COLUMN PROPLAYERS.REGISTER_DATE IS   'Data de registro do jogador profissional no sistema';
