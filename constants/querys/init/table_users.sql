-- TABELA DE MUNICIPIOS EXPORTADORES
CREATE TABLE IF NOT EXISTS users (
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    PRIMARY KEY (username)
);

INSERT INTO users (username, password) VALUES ('admin', 'admin');
