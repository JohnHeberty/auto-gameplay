CREATE TABLE IF NOT EXISTS CHANNEL (
    ID_CHANNEL SERIAL,
    ID_YOUTUBE VARCHAR(50) NOT NULL,
    URL VARCHAR(100) NOT NULL,
    TITLE VARCHAR(50) NOT NULL,
    DESCRIPTION VARCHAR(1000),
    DESCRIPTION_SNIPPET VARCHAR(500),
    HANDLE_NAME VARCHAR(50) NOT NULL,
    HANDLE VARCHAR(50) NOT NULL,
    ID_GAME INTEGER,
    COUNTRY VARCHAR(30),
    REGISTER_DATE DATE,
    MY_CHANNEL BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT fk_channel_game FOREIGN KEY (ID_GAME) REFERENCES GAMES(ID_GAME),
    PRIMARY KEY (ID_YOUTUBE)
);

-- Comentários nas colunas
COMMENT ON TABLE CHANNEL IS                         'Tabela para armazenar informações dos canais do YouTube';
COMMENT ON COLUMN CHANNEL.ID_CHANNEL IS             'ID único do canal (auto-incremento)';
COMMENT ON COLUMN CHANNEL.ID_YOUTUBE IS             'ID único do canal no YouTube - chave primária';
COMMENT ON COLUMN CHANNEL.URL IS                    'URL completa do canal no YouTube';
COMMENT ON COLUMN CHANNEL.TITLE IS                  'Título/nome do canal';
COMMENT ON COLUMN CHANNEL.DESCRIPTION IS            'Descrição completa do canal';
COMMENT ON COLUMN CHANNEL.DESCRIPTION_SNIPPET IS    'Snippet/resumo da descrição do canal';
COMMENT ON COLUMN CHANNEL.HANDLE_NAME IS            'Nome do handle personalizado do canal';
COMMENT ON COLUMN CHANNEL.HANDLE IS                 'Handle/username do canal (@usuario)';
COMMENT ON COLUMN CHANNEL.ID_GAME IS                'ID do jogo principal associado ao canal (referência à tabela GAMES)';
COMMENT ON COLUMN CHANNEL.COUNTRY IS                'País de origem do canal';
COMMENT ON COLUMN CHANNEL.REGISTER_DATE IS          'Data de registro do canal no sistema';
COMMENT ON COLUMN CHANNEL.MY_CHANNEL IS             'Indica se é um canal próprio/gerenciado pelo usuário';
