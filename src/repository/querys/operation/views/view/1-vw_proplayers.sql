create view vw_proplayers as 
SELECT 
    p.id_proplayer,
    p.name,
    -- Nome limpo em minúsculas
    LOWER(TRIM(p.name)) as clean_name,
    -- Nome escapado para regex (escape de caracteres especiais)
    LOWER(TRIM(REGEXP_REPLACE(p.name, '([\\\/\[\]\(\)\.\*\+\?\^\$\{\}\|])', '\\\1', 'g'))) as regex_safe_name,
    -- Variações comuns do nome (para melhor detecção)
    LOWER(TRIM(REPLACE(p.name, ' ', ''))) as no_space_name,
    LOWER(TRIM(REPLACE(p.name, '-', ''))) as no_dash_name,
    LOWER(TRIM(REPLACE(REPLACE(p.name, ' ', ''), '-', ''))) as clean_no_symbols_name,
    -- Nome abreviado (primeiras 4 letras para nomes longos)
    CASE 
        WHEN LENGTH(p.name) > 6 
        THEN LOWER(LEFT(p.name, 4))
        ELSE NULL 
    END as short_name
FROM proplayers p
WHERE p.name IS NOT NULL 
AND LENGTH(TRIM(p.name)) > 2;