CREATE MATERIALIZED VIEW mvw_2_info_video_clean_words AS 
WITH palavras_frequentes AS (
    -- Buscar palavras com categoria 'Frequente' ou 'Muito Frequente' da view de palavras frequentes
    SELECT word
    FROM mvw_1_info_video_frequent_words
    WHERE frequency_category IN ('Moderada', 'Frequente', 'Muito Frequente') AND ignore = FALSE
),
nomes_canais AS (
    -- Buscar nomes de canais para filtrar da big_string
    SELECT DISTINCT
        LOWER(REGEXP_REPLACE(title, '[^a-zA-Z0-9\s.]', '', 'g')) as canal_name
    FROM public.channel
    WHERE title IS NOT NULL AND LENGTH(TRIM(title)) >= 3
    UNION
    SELECT DISTINCT
        LOWER(REGEXP_REPLACE(handle_name, '[^a-zA-Z0-9\s.]', '', 'g')) as canal_name
    FROM public.channel  
    WHERE handle_name IS NOT NULL AND LENGTH(TRIM(handle_name)) >= 3
    UNION
    SELECT DISTINCT
        LOWER(REGEXP_REPLACE(REPLACE(handle, '@', ''), '[^a-zA-Z0-9\s.]', '', 'g')) as canal_name
    FROM public.channel
    WHERE handle IS NOT NULL AND LENGTH(TRIM(REPLACE(handle, '@', ''))) >= 3
),
video_with_keywords AS (
    -- Trazer keywords da tabela playlist_movie_historic
    SELECT 
        iv.*,
        -- Converter array de keywords em string única separada por espaços
        CASE 
            WHEN pmh.keywords IS NOT NULL AND array_length(pmh.keywords, 1) > 0 THEN array_to_string(pmh.keywords, ' ')
            ELSE ''
        END as keywords_str,
        pmh.keywords as keywords_array
    FROM mvw_0_info_video iv
    LEFT JOIN playlist_movie_historic pmh ON (iv.id_movie = pmh.id_movie)
),
info_video_limpo AS (
    -- Aplicar limpeza removendo palavras frequentes das colunas clean
    SELECT 
        vwk.id_movie,
        vwk.title,
        vwk.description,
        vwk.views,
        vwk.likes,
        vwk.id_video,
        vwk.id_playlist,
        vwk.title_playlist,
        vwk.id_youtube,
        vwk.dt_upload,
        vwk.version,
        vwk.keywords_str,
        vwk.keywords_array,
        -- Limpar keywords_str usando mesma lógica da mvw_0_info_video
        LOWER(REGEXP_REPLACE(COALESCE(vwk.keywords_str, ''), '[^a-zA-Z0-9\s.]', '', 'g')) as clean_keywords_str,
        -- Limpar palavras frequentes das colunas clean
        TRIM(REGEXP_REPLACE(
            COALESCE(
                (SELECT string_agg(
                    CASE 
                        WHEN palavra_individual NOT IN (SELECT word FROM palavras_frequentes) 
                             AND palavra_individual NOT LIKE '%.com%'
                             AND palavra_individual NOT LIKE '%.com.br%'
                             AND palavra_individual NOT LIKE '%www.%'
                             AND palavra_individual NOT LIKE '%http%'
                             AND palavra_individual NOT LIKE '%youtube.%'
                        THEN palavra_individual 
                        ELSE NULL 
                    END, ' '
                ) FROM unnest(string_to_array(vwk.clean_title, ' ')) AS palavra_individual),
                ''
            ),
            '\s+', ' ', 'g'
        )) as clean_title,
        TRIM(REGEXP_REPLACE(
            COALESCE(
                (SELECT string_agg(
                    CASE 
                        WHEN palavra_individual NOT IN (SELECT word FROM palavras_frequentes) 
                             AND palavra_individual NOT LIKE '%.com%'
                             AND palavra_individual NOT LIKE '%.com.br%'
                             AND palavra_individual NOT LIKE '%www.%'
                             AND palavra_individual NOT LIKE '%http%'
                             AND palavra_individual NOT LIKE '%youtube.%'
                        THEN palavra_individual 
                        ELSE NULL 
                    END, ' '
                ) FROM unnest(string_to_array(vwk.clean_description, ' ')) AS palavra_individual),
                ''
            ),
            '\s+', ' ', 'g'
        )) as clean_description,
        TRIM(REGEXP_REPLACE(
            COALESCE(
                (SELECT string_agg(
                    CASE 
                        WHEN palavra_individual NOT IN (SELECT word FROM palavras_frequentes) 
                             AND palavra_individual NOT LIKE '%.com%'
                             AND palavra_individual NOT LIKE '%.com.br%'
                             AND palavra_individual NOT LIKE '%www.%'
                             AND palavra_individual NOT LIKE '%http%'
                             AND palavra_individual NOT LIKE '%youtube.%'
                        THEN palavra_individual 
                        ELSE NULL 
                    END, ' '
                ) FROM unnest(string_to_array(vwk.clean_playlist_title, ' ')) AS palavra_individual),
                ''
            ),
            '\s+', ' ', 'g'
        )) as clean_playlist_title
    FROM video_with_keywords vwk
),
final_clean AS (
    -- Aplicar filtro final de comprimento de palavras e remoção de nomes de canais
    SELECT 
        id_movie,
        title,
        description,
        views,
        likes,
        id_video,
        id_playlist,
        title_playlist,
        id_youtube,
        dt_upload,
        version,
        keywords_str,
        keywords_array,
        clean_keywords_str,
        -- Filtrar palavras com mais de 3 letras e remover nomes de canais
        TRIM(REGEXP_REPLACE(
            COALESCE(
                (SELECT string_agg(
                    CASE 
                        WHEN LENGTH(TRIM(palavra_final)) >= 3 
                             AND LOWER(TRIM(palavra_final)) NOT IN (SELECT canal_name FROM nomes_canais)
                        THEN TRIM(palavra_final)
                        ELSE NULL 
                    END, ' '
                ) FROM unnest(string_to_array(clean_title, ' ')) AS palavra_final),
                ''
            ),
            '\s+', ' ', 'g'
        )) as clean_title,
        TRIM(REGEXP_REPLACE(
            COALESCE(
                (SELECT string_agg(
                    CASE 
                        WHEN LENGTH(TRIM(palavra_final)) >= 3 
                             AND LOWER(TRIM(palavra_final)) NOT IN (SELECT canal_name FROM nomes_canais)
                        THEN TRIM(palavra_final)
                        ELSE NULL 
                    END, ' '
                ) FROM unnest(string_to_array(clean_description, ' ')) AS palavra_final),
                ''
            ),
            '\s+', ' ', 'g'
        )) as clean_description,
        TRIM(REGEXP_REPLACE(
            COALESCE(
                (SELECT string_agg(
                    CASE 
                        WHEN LENGTH(TRIM(palavra_final)) >= 3 
                             AND LOWER(TRIM(palavra_final)) NOT IN (SELECT canal_name FROM nomes_canais)
                        THEN TRIM(palavra_final)
                        ELSE NULL 
                    END, ' '
                ) FROM unnest(string_to_array(clean_playlist_title, ' ')) AS palavra_final),
                ''
            ),
            '\s+', ' ', 'g'
        )) as clean_playlist_title
    FROM info_video_limpo
),
final_with_big_string AS (
    -- Criar big_string concatenando todas as strings limpas
    SELECT 
        fc.*,
        -- Criar big_string concatenando todas as strings limpas separadas por espaços (com espaço no início e fim)
        TRIM(CONCAT(
            ' ',
            COALESCE(fc.clean_title, ''), ' ',
            COALESCE(fc.clean_playlist_title, ''), ' ',
            COALESCE(fc.clean_description, ''), ' ',
            COALESCE(fc.clean_keywords_str, ''),
            ' '
        )) as big_string
    FROM final_clean fc
)
SELECT 
    id_movie,
    title,
    description,
    views,
    likes,
    id_video,
    id_playlist,
    title_playlist,
    id_youtube,
    dt_upload,
    version,
    -- Keywords processadas
    keywords_array as keywords,
    keywords_str,
    clean_keywords_str,
    -- Big string para detecção (única coluna clean necessária)
    big_string
FROM final_with_big_string
WHERE id_movie IS NOT NULL and dt_upload is not null;