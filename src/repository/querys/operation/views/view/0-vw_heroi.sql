create view vw_heroi as 
with hero_patterns as (
    SELECT 
        h.id_hero,
        h.localized_name,
        -- Nome limpo (sem prefixo npc_dota_hero_)
        LOWER(TRIM(REPLACE(REPLACE(h.name, 'npc_dota_hero_', ''), '_', ' '))) as clean_name,
        -- Nome localizado em minúsculas
        LOWER(TRIM(h.localized_name)) as clean_localized_name,
        -- Variações comuns do nome (para melhor detecção)
        LOWER(TRIM(REPLACE(h.localized_name, ' ', ''))) as no_space_name,
        -- Nome abreviado (primeiras 4 letras para nomes longos)
        CASE 
            WHEN LENGTH(h.localized_name) > 6 
            THEN LOWER(LEFT(h.localized_name, 4))
            ELSE NULL 
        END as short_name,
        -- Repartição de nomes compostos
        CASE 
            WHEN POSITION('-' IN TRIM(h.localized_name)) > 0 
            THEN LOWER(TRIM(SPLIT_PART(h.localized_name, '-', 1)))
            WHEN POSITION(' ' IN TRIM(h.localized_name)) > 0 
            THEN LOWER(TRIM(SPLIT_PART(h.localized_name, ' ', 1)))
            ELSE LOWER(TRIM(h.localized_name))
        END as first_name,
        CASE 
            WHEN POSITION('-' IN TRIM(h.localized_name)) > 0 
            THEN LOWER(TRIM(SUBSTRING(h.localized_name FROM POSITION('-' IN h.localized_name) + 1)))
            WHEN POSITION(' ' IN TRIM(h.localized_name)) > 0 
            THEN LOWER(TRIM(SUBSTRING(h.localized_name FROM POSITION(' ' IN h.localized_name) + 1)))
            ELSE NULL
        END as second_name
    FROM heroes h
    WHERE h.localized_name IS NOT NULL 
    AND LENGTH(TRIM(h.localized_name)) > 2
)
select *
from hero_patterns;