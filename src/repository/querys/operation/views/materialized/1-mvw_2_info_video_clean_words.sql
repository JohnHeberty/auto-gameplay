CREATE MATERIALIZED VIEW mvw_2_info_video_clean_words AS 
WITH palavras_frequentes AS (
    -- Buscar palavras com categoria 'Frequente' ou 'Muito Frequente' da view de palavras frequentes
    SELECT word
    FROM mvw_1_info_video_frequent_words
    WHERE frequency_category IN ('Moderada', 'Frequente', 'Muito Frequente') AND ignore = FALSE
),
info_video_limpo AS (
    -- Aplicar limpeza removendo palavras frequentes das colunas clean
    SELECT 
        iv.id_movie,
        iv.title,
        iv.description,
        iv.views,
        iv.likes,
        iv.id_video,
        iv.id_playlist,
        iv.title_playlist,
        iv.id_youtube,
        iv.dt_upload,
        iv.version,
        -- Limpar palavras frequentes das colunas clean
        TRIM(REGEXP_REPLACE(
            COALESCE(
                (SELECT string_agg(
                    CASE 
                        WHEN palavra_individual NOT IN (SELECT word FROM palavras_frequentes) 
                             AND palavra_individual NOT LIKE '%.com%'
                             AND palavra_individual NOT LIKE '%.com.br%'
                             AND palavra_individual NOT LIKE '%www.%'
                             AND palavra_individual NOT LIKE 'http%'
                             AND palavra_individual NOT LIKE '%youtube.%'
                        THEN palavra_individual 
                        ELSE NULL 
                    END, ' '
                ) FROM unnest(string_to_array(iv.clean_title, ' ')) AS palavra_individual),
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
                             AND palavra_individual NOT LIKE 'http%'
                             AND palavra_individual NOT LIKE '%youtube.%'
                        THEN palavra_individual 
                        ELSE NULL 
                    END, ' '
                ) FROM unnest(string_to_array(iv.clean_description, ' ')) AS palavra_individual),
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
                             AND palavra_individual NOT LIKE 'http%'
                             AND palavra_individual NOT LIKE '%youtube.%'
                        THEN palavra_individual 
                        ELSE NULL 
                    END, ' '
                ) FROM unnest(string_to_array(iv.clean_playlist_title, ' ')) AS palavra_individual),
                ''
            ),
            '\s+', ' ', 'g'
        )) as clean_playlist_title
    FROM mvw_0_info_video iv
),
final_clean AS (
    -- Aplicar filtro final de comprimento de palavras
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
        -- Filtrar palavras com mais de 3 letras no resultado final
        TRIM(REGEXP_REPLACE(
            COALESCE(
                (SELECT string_agg(
                    CASE 
                        WHEN LENGTH(TRIM(palavra_final)) >= 3 
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
                        THEN TRIM(palavra_final)
                        ELSE NULL 
                    END, ' '
                ) FROM unnest(string_to_array(clean_playlist_title, ' ')) AS palavra_final),
                ''
            ),
            '\s+', ' ', 'g'
        )) as clean_playlist_title
    FROM info_video_limpo
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
    clean_title,
    clean_description,
    clean_playlist_title,
    version
FROM final_clean
WHERE id_movie IS NOT NULL;