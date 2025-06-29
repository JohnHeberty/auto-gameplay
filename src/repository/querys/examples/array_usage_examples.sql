-- Exemplos de como usar os campos keywords e available_countries

-- 1. INSERIR dados com arrays
INSERT INTO playlist_movie_historic (
    id_movie, 
    titulo, 
    description, 
    keywords, 
    available_countries,
    category,
    date_start,
    date_end
) VALUES (
    1, 
    'Amazing Dota 2 Gameplay', 
    'Professional player showcase',
    ARRAY['dota2', 'gaming', 'professional', 'esports'], -- Array de keywords
    ARRAY['BR', 'US', 'GB', 'CA'], -- Array de países
    'Gaming',
    '2025-06-29',
    '2025-06-30'
);

-- 2. CONSULTAR dados com arrays

-- Buscar vídeos que contêm uma keyword específica
SELECT * FROM playlist_movie_historic 
WHERE 'dota2' = ANY(keywords);

-- Buscar vídeos disponíveis no Brasil
SELECT * FROM playlist_movie_historic 
WHERE 'BR' = ANY(available_countries);

-- Buscar vídeos com múltiplas keywords
SELECT * FROM playlist_movie_historic 
WHERE keywords && ARRAY['gaming', 'esports']; -- Operador && verifica sobreposição

-- Contar quantas keywords um vídeo tem
SELECT titulo, array_length(keywords, 1) as num_keywords
FROM playlist_movie_historic;

-- Buscar vídeos disponíveis em países específicos
SELECT * FROM playlist_movie_historic 
WHERE available_countries && ARRAY['BR', 'US'];

-- 3. ATUALIZAR arrays

-- Adicionar uma nova keyword
UPDATE playlist_movie_historic 
SET keywords = array_append(keywords, 'highlights')
WHERE id_movie = 1;

-- Remover uma keyword
UPDATE playlist_movie_historic 
SET keywords = array_remove(keywords, 'old_keyword')
WHERE id_movie = 1;

-- Adicionar um país
UPDATE playlist_movie_historic 
SET available_countries = array_append(available_countries, 'DE')
WHERE id_movie = 1;

-- 4. VALIDAÇÕES com as tabelas de referência

-- Verificar se todas as keywords existem na tabela de referência
SELECT DISTINCT unnest(keywords) as keyword
FROM playlist_movie_historic
WHERE NOT EXISTS (
    SELECT 1 FROM keywords k 
    WHERE k.keyword = unnest(keywords)
);

-- Verificar se todos os países existem na tabela de referência
SELECT DISTINCT unnest(available_countries) as country
FROM playlist_movie_historic
WHERE NOT EXISTS (
    SELECT 1 FROM countries c 
    WHERE c.country_code = unnest(available_countries)
);

-- 5. ESTATÍSTICAS

-- Keywords mais utilizadas
SELECT keyword, COUNT(*) as usage_count
FROM (
    SELECT unnest(keywords) as keyword
    FROM playlist_movie_historic
) as expanded_keywords
GROUP BY keyword
ORDER BY usage_count DESC;

-- Países com mais conteúdo disponível
SELECT country_code, COUNT(*) as video_count
FROM (
    SELECT unnest(available_countries) as country_code
    FROM playlist_movie_historic
) as expanded_countries
GROUP BY country_code
ORDER BY video_count DESC;
