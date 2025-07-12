CREATE TABLE IF NOT EXISTS HEROES (
    ID_HERO INTEGER NOT NULL UNIQUE,
    "name" VARCHAR(50) NOT NULL,
    ID_GAME INTEGER,
    "description" VARCHAR(5000),
    PRIMARY_ATTR VARCHAR(3),
    ATTACK_TYPE VARCHAR(6),
    ROLES TEXT[],
    IMG VARCHAR(70),
    ICON VARCHAR(70),
    BASE_HEALTH INTEGER,
    BASE_HEALTH_REGEN FLOAT,
    BASE_MANA INTEGER,
    BASE_MANA_REGEN FLOAT,
    BASE_ARMOR FLOAT,
    BASE_MR FLOAT,
    BASE_ATTACK_MIN INTEGER,
    BASE_ATTACK_MAX INTEGER,
    BASE_STR INTEGER,
    BASE_AGI INTEGER,
    BASE_INT INTEGER,
    STR_GAIN FLOAT,
    AGI_GAIN FLOAT,
    INT_GAIN FLOAT,
    ATTACK_RANGE INTEGER,
    PROJECTILE_SPEED INTEGER,
    ATTACK_RATE FLOAT,
    BASE_ATTACK_TIME FLOAT,
    ATTACK_POINT FLOAT,
    MOVE_SPEED INTEGER,
    TURN_RATE FLOAT,
    CM_ENABLED BOOLEAN,
    LEGS INTEGER,
    DAY_VISION INTEGER,
    NIGHT_VISION INTEGER,
    LOCALIZED_NAME VARCHAR(50) NOT NULL UNIQUE,
    REGISTER_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_heroes_game FOREIGN KEY (ID_GAME) REFERENCES GAMES(ID_GAME),
    PRIMARY KEY (ID_HERO)
);

-- Comentários nas colunas
COMMENT ON TABLE HEROES IS                      'Tabela para armazenar informações detalhadas dos heróis/personagens dos jogos';
COMMENT ON COLUMN HEROES.ID_HERO IS             'ID único do herói/personagem';
COMMENT ON COLUMN HEROES."name" IS              'Nome do herói/personagem no jogo';
COMMENT ON COLUMN HEROES.ID_GAME IS             'ID do jogo ao qual o herói pertence (referência à tabela GAMES)';
COMMENT ON COLUMN HEROES."description" IS       'Descrição do herói, suas habilidades e características';
COMMENT ON COLUMN HEROES.PRIMARY_ATTR IS        'Atributo primário do herói (STR, AGI, INT)';
COMMENT ON COLUMN HEROES.ATTACK_TYPE IS         'Tipo de ataque do herói (Melee, Ranged)';
COMMENT ON COLUMN HEROES.ROLES IS               'Array de funções/roles do herói (Carry, Support, etc.)';
COMMENT ON COLUMN HEROES.IMG IS                 'URL ou caminho da imagem principal do herói';
COMMENT ON COLUMN HEROES.ICON IS                'URL ou caminho do ícone do herói';
COMMENT ON COLUMN HEROES.BASE_HEALTH IS         'Pontos de vida base do herói';
COMMENT ON COLUMN HEROES.BASE_HEALTH_REGEN IS   'Regeneração de vida base por segundo';
COMMENT ON COLUMN HEROES.BASE_MANA IS           'Pontos de mana base do herói';
COMMENT ON COLUMN HEROES.BASE_MANA_REGEN IS     'Regeneração de mana base por segundo';
COMMENT ON COLUMN HEROES.BASE_ARMOR IS          'Armadura base do herói';
COMMENT ON COLUMN HEROES.BASE_MR IS             'Resistência mágica base do herói';
COMMENT ON COLUMN HEROES.BASE_ATTACK_MIN IS     'Dano de ataque mínimo base';
COMMENT ON COLUMN HEROES.BASE_ATTACK_MAX IS     'Dano de ataque máximo base';
COMMENT ON COLUMN HEROES.BASE_STR IS            'Valor base do atributo Força (Strength)';
COMMENT ON COLUMN HEROES.BASE_AGI IS            'Valor base do atributo Agilidade (Agility)';
COMMENT ON COLUMN HEROES.BASE_INT IS            'Valor base do atributo Inteligência (Intelligence)';
COMMENT ON COLUMN HEROES.STR_GAIN IS            'Ganho de Força por nível';
COMMENT ON COLUMN HEROES.AGI_GAIN IS            'Ganho de Agilidade por nível';
COMMENT ON COLUMN HEROES.INT_GAIN IS            'Ganho de Inteligência por nível';
COMMENT ON COLUMN HEROES.ATTACK_RANGE IS        'Alcance de ataque do herói';
COMMENT ON COLUMN HEROES.PROJECTILE_SPEED IS    'Velocidade do projétil (para heróis ranged)';
COMMENT ON COLUMN HEROES.ATTACK_RATE IS         'Taxa de ataque do herói';
COMMENT ON COLUMN HEROES.BASE_ATTACK_TIME IS    'Tempo base entre ataques';
COMMENT ON COLUMN HEROES.ATTACK_POINT IS        'Ponto de ataque na animação';
COMMENT ON COLUMN HEROES.MOVE_SPEED IS          'Velocidade de movimento do herói';
COMMENT ON COLUMN HEROES.TURN_RATE IS           'Taxa de rotação do herói';
COMMENT ON COLUMN HEROES.CM_ENABLED IS          'Indica se o herói está habilitado no Captain Mode';
COMMENT ON COLUMN HEROES.LEGS IS                'Número de pernas do herói (afeta alguns efeitos)';
COMMENT ON COLUMN HEROES.DAY_VISION IS          'Alcance de visão durante o dia';
COMMENT ON COLUMN HEROES.NIGHT_VISION IS        'Alcance de visão durante a noite';
COMMENT ON COLUMN HEROES.LOCALIZED_NAME IS      'Nome localizado/traduzido do herói';
COMMENT ON COLUMN HEROES.REGISTER_DATE IS       'Timestamp de criação do registro';

-- =====================================================================================
-- ÍNDICES DE PERFORMANCE PARA HEROES
-- =====================================================================================

-- Índice para busca por nome localizado (muito usado na detecção)
CREATE INDEX IF NOT EXISTS idx_heroes_localized_name_lower 
ON HEROES (LOWER(LOCALIZED_NAME));

-- Índice para busca por nome limpo (sem prefixo)
CREATE INDEX IF NOT EXISTS idx_heroes_name_clean 
ON HEROES (LOWER(REPLACE(REPLACE(name, 'npc_dota_hero_', ''), '_', ' ')));

-- Índice para busca de texto em nome e nome localizado
CREATE INDEX IF NOT EXISTS idx_heroes_name_text 
ON HEROES USING gin(to_tsvector('english', LOCALIZED_NAME || ' ' || name));

-- Índice para filtros por jogo
CREATE INDEX IF NOT EXISTS idx_heroes_id_game 
ON HEROES (ID_GAME);

-- Índice para consultas por atributo primário
CREATE INDEX IF NOT EXISTS idx_heroes_primary_attr 
ON HEROES (PRIMARY_ATTR);

-- Índice GIN para busca em roles de heróis
CREATE INDEX IF NOT EXISTS idx_heroes_roles 
ON HEROES USING gin(ROLES);

-- Índice para heróis ativos no Captain's Mode
CREATE INDEX IF NOT EXISTS idx_active_heroes 
ON HEROES (ID_HERO, LOCALIZED_NAME) 
WHERE CM_ENABLED = true;

-- Aumentar estatísticas para coluna de texto
ALTER TABLE HEROES 
ALTER COLUMN localized_name SET STATISTICS 1000;

