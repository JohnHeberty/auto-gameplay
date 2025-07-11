CREATE TABLE IF NOT EXISTS PROPLAYERS (
    ID_PROPLAYER SERIAL,
    ID_ACCOUNT INTEGER NOT NULL UNIQUE,
    NAME VARCHAR(50) NOT NULL,
    DESCRIPTION VARCHAR(1000),
    REGISTER_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (ID_PROPLAYER)
);

-- Comentários nas colunas
COMMENT ON TABLE PROPLAYERS IS                  'Tabela para armazenar informações dos jogadores profissionais';
COMMENT ON COLUMN PROPLAYERS.ID_PROPLAYER IS    'ID único do jogador profissional (auto-incremento)';
COMMENT ON COLUMN PROPLAYERS.ID_ACCOUNT IS      'ID da conta associada ao jogador profissional';
COMMENT ON COLUMN PROPLAYERS.NOME IS            'Nome do jogador profissional';
COMMENT ON COLUMN PROPLAYERS.DESCRIPTION IS     'Descrição ou biografia do jogador profissional';
COMMENT ON COLUMN PROPLAYERS.REGISTER_DATE IS   'Data de registro do jogador profissional no sistema';
