CREATE MATERIALIZED VIEW mvw_1_info_video_frequent_words AS 
WITH big_string_data AS (
    -- Combinar todos os textos em uma única string
    SELECT 
        iv.id_movie,
        iv.id_video,
        iv.id_playlist,
        iv.id_youtube,
        -- Concatenar título, descrição, nome da playlist e nome do canal
        LOWER(TRIM(
            COALESCE(iv.title, '') || ' ' ||
            COALESCE(iv.description, '') || ' ' ||
            COALESCE(iv.title_playlist, '') || ' ' ||
            COALESCE(ch.title, '') || ' ' ||
            COALESCE(ch.handle_name, '') || ' ' ||
            REGEXP_REPLACE(COALESCE(ch.handle, ''), '^@', '', 'g')
        )) as big_string
    FROM mvw_0_info_video iv
    LEFT JOIN public.channel ch ON (iv.id_youtube = ch.id_youtube)
    WHERE iv.id_movie IS NOT NULL
),
cleaned_strings AS (
    -- Limpar a big_string removendo caracteres especiais e múltiplos espaços
    SELECT 
        id_movie,
        id_video,
        id_playlist,
        id_youtube,
        TRIM(REGEXP_REPLACE(
            REGEXP_REPLACE(big_string, '[^a-zA-Z0-9\s]', ' ', 'g'),
            '\s+', ' ', 'g'
        )) as clean_big_string
    FROM big_string_data
    WHERE LENGTH(TRIM(big_string)) > 0
),
word_split AS (
    -- Quebrar a string em palavras individuais
    SELECT 
        cs.id_movie,
        cs.id_video,
        cs.id_playlist,
        cs.id_youtube,
        cs.clean_big_string,
        TRIM(unnest(string_to_array(cs.clean_big_string, ' '))) as word
    FROM cleaned_strings cs
),
filtered_words AS (
    -- Filtrar palavras muito curtas, números puros e stop words comuns
    SELECT 
        id_movie,
        id_video,
        id_playlist,
        id_youtube,
        clean_big_string,
        word
    FROM word_split
    WHERE 
        LENGTH(word) >= 3  -- Palavras com pelo menos 3 caracteres
        AND word !~ '^[0-9]+$'  -- Não é apenas números
        AND TRIM(word) != ''
),
word_frequency AS (
    -- Contar a frequência de cada palavra
    SELECT 
        word,
        COUNT(*) as frequency,
        COUNT(DISTINCT id_movie) as distinct_videos,
        -- Calcular percentual em relação ao total de palavras
        ROUND(
            (COUNT(*) * 100.0) / (SELECT COUNT(*) FROM filtered_words), 
            2
        ) as total_percentage
    FROM filtered_words
    GROUP BY word
    HAVING COUNT(*) >= 3  -- Aparecer em pelo menos 3 contextos
),
palavra_ranking AS (
    -- Rankear as palavras por frequência
    SELECT 
        ROW_NUMBER() OVER (ORDER BY frequency DESC, word ASC) as ranking,
        word,
        frequency,
        distinct_videos,
        total_percentage,
        -- Categorizar por frequência
        CASE 
            WHEN frequency >= 10000 THEN 'Muito Frequente'
            WHEN frequency >= 5000  THEN 'Frequente'
            WHEN frequency >= 2000  THEN 'Moderada'
            WHEN frequency >= 1000  THEN 'Baixa'
            ELSE 'Rara'
        END as frequency_category
    FROM word_frequency
),
detected_hero_proplayer as (
    SELECT 
        pr.ranking,
        pr.word,
        pr.frequency,
        pr.distinct_videos,
        pr.total_percentage,
        pr.frequency_category,
        -- Coluna ignore: TRUE se a palavra for um herói ou pro player
        CASE 
            WHEN 
                vh.localized_name IS NOT NULL           OR 
                vh.clean_name IS NOT NULL               OR 
                vh.clean_localized_name IS NOT NULL     OR
                vh.no_space_name IS NOT NULL            OR
                vh.first_name IS NOT NULL               OR
                vh.second_name IS NOT NULL            
            THEN TRUE 
            WHEN 
                vp.name IS NOT NULL                     OR 
                vp.clean_name IS NOT NULL               OR
                vp.regex_safe_name IS NOT NULL          OR
                vp.no_space_name IS NOT NULL            OR
                vp.clean_no_symbols_name IS NOT NULL    OR
                vp.first_name IS NOT NULL               OR
                vp.second_name IS NOT NULL    
            THEN TRUE
            ELSE FALSE 
        END as ignore
    FROM palavra_ranking pr
    LEFT JOIN vw_heroi vh ON (
        LOWER(pr.word) = LOWER(vh.localized_name)       OR
        LOWER(pr.word) = LOWER(vh.clean_name)           OR
        LOWER(pr.word) = LOWER(vh.clean_localized_name) OR
        LOWER(pr.word) = LOWER(vh.no_space_name)        OR
        LOWER(pr.word) = LOWER(vh.first_name)           OR
        LOWER(pr.word) = LOWER(vh.second_name)
    )
    LEFT JOIN vw_proplayers vp ON (
        LOWER(pr.word) = LOWER(vp.name)                 OR
        LOWER(pr.word) = LOWER(vp.clean_name)           OR
        LOWER(pr.word) = LOWER(vp.regex_safe_name)      OR
        LOWER(pr.word) = LOWER(vp.no_space_name)        OR
        LOWER(pr.word) = LOWER(vp.clean_no_symbols_name)
    )
    ORDER BY pr.ranking
)
select *
from detected_hero_proplayer;