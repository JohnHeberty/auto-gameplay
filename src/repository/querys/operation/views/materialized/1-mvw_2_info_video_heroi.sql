CREATE MATERIALIZED VIEW mvw_2_info_video_heroi AS 
with hero_detection AS (
    -- Detectar heróis usando múltiplos critérios de precisão com espaços para evitar falsos positivos
    SELECT DISTINCT ON (vd.id_movie)
        vd.*,
        hp.localized_name as detected_hero,
        hp.id_hero,
        -- Score de confiança da detecção (maior = mais confiável)
        CASE
            -- Correspondência exata no título com as 3 variações de espaço (máxima confiança)
            WHEN (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR  -- ' Ace '
                 (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_localized_name || '%') OR   -- ' Ace'
                 (' ' || vd.clean_title || ' ') LIKE ('%' || hp.clean_localized_name || ' %') THEN 100  -- 'Ace '
            WHEN (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
                 (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_name || '%') OR
                 (' ' || vd.clean_title || ' ') LIKE ('%' || hp.clean_name || ' %') THEN 95
            -- Correspondência exata na descrição com as 3 variações de espaço
            WHEN (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
                 (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_localized_name || '%') OR
                 (' ' || vd.clean_description || ' ') LIKE ('%' || hp.clean_localized_name || ' %') THEN 90
            WHEN (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
                 (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_name || '%') OR
                 (' ' || vd.clean_description || ' ') LIKE ('%' || hp.clean_name || ' %') THEN 85
            -- Correspondência exata no título da playlist com as 3 variações de espaço
            WHEN (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
                 (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_localized_name || '%') OR
                 (' ' || vd.clean_playlist_title || ' ') LIKE ('%' || hp.clean_localized_name || ' %') THEN 80
            WHEN (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
                 (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_name || '%') OR
                 (' ' || vd.clean_playlist_title || ' ') LIKE ('%' || hp.clean_name || ' %') THEN 75
            -- Correspondência parcial com nomes longos (ex: "invo" para "invoker") - apenas se >= 4 chars
            WHEN hp.short_name IS NOT NULL AND LENGTH(hp.short_name) >= 4 AND (
                (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.short_name || '%') OR
                (' ' || vd.clean_title || ' ') LIKE ('%' || hp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.short_name || '%') OR
                (' ' || vd.clean_description || ' ') LIKE ('%' || hp.short_name || ' %')
            ) THEN 60
            ELSE 0
        END as confidence_score_1
    FROM mvw_1_info_video vd
    CROSS JOIN vw_heroi hp
    WHERE 
        -- Aplicar filtros de detecção com as 3 variações de espaço para evitar falsos positivos
        (
            -- Busca com as 3 variações de espaço para palavras completas (evita "ace" em "facebook")
            (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR  -- ' Ace '
            (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_localized_name || '%') OR   -- ' Ace'
            (' ' || vd.clean_title || ' ') LIKE ('%' || hp.clean_localized_name || ' %') OR   -- 'Ace '
            (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
            (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_name || '%') OR
            (' ' || vd.clean_title || ' ') LIKE ('%' || hp.clean_name || ' %') OR
            (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
            (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_localized_name || '%') OR
            (' ' || vd.clean_description || ' ') LIKE ('%' || hp.clean_localized_name || ' %') OR
            (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
            (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_name || '%') OR
            (' ' || vd.clean_description || ' ') LIKE ('%' || hp.clean_name || ' %') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_localized_name || '%') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('%' || hp.clean_localized_name || ' %') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_name || '%') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('%' || hp.clean_name || ' %') OR
            -- Busca por nome abreviado com as 3 variações de espaço (apenas para nomes >= 4 chars)
            (hp.short_name IS NOT NULL AND LENGTH(hp.short_name) >= 4 AND (
                (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.short_name || '%') OR
                (' ' || vd.clean_title || ' ') LIKE ('%' || hp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.short_name || '%') OR
                (' ' || vd.clean_description || ' ') LIKE ('%' || hp.short_name || ' %')
            ))
        )
    ORDER BY vd.id_movie, confidence_score_1 DESC
)
SELECT 
    hd.id_movie,
    hd.id_video,
    ch.id_channel,
    hd.id_playlist,
    hd.title,
    hd.description,
    hd.views,
    hd.likes,
    hd.title_playlist,
    hd.id_youtube,
    hd.dt_upload,
    hd.version,
    -- Aplicar limpeza diretamente nas colunas clean existentes
    CASE 
        WHEN hd.confidence_score_1 >= 60 THEN 
            TRIM(REGEXP_REPLACE(
                REGEXP_REPLACE(hd.clean_title, 
                    '\y' || LOWER(hd.detected_hero) || '\y', ' ', 'gi'),
                '\s+', ' ', 'g'))
        ELSE hd.clean_title 
    END as clean_title,
    CASE 
        WHEN hd.confidence_score_1 >= 60 THEN 
            TRIM(REGEXP_REPLACE(
                REGEXP_REPLACE(hd.clean_description, 
                    '\y' || LOWER(hd.detected_hero) || '\y', ' ', 'gi'),
                '\s+', ' ', 'g'))
        ELSE hd.clean_description 
    END as clean_description,
    CASE 
        WHEN hd.confidence_score_1 >= 60 THEN 
            TRIM(REGEXP_REPLACE(
                REGEXP_REPLACE(hd.clean_playlist_title, 
                    '\y' || LOWER(hd.detected_hero) || '\y', ' ', 'gi'),
                '\s+', ' ', 'g'))
        ELSE hd.clean_playlist_title 
    END as clean_playlist_title,
    hd.detected_hero,
    hd.id_hero,
    hd.confidence_score_1,
    -- Retornar herói apenas se confiança >= 60 (evita falsos positivos)
    CASE 
        WHEN hd.confidence_score_1 >= 60 THEN hd.detected_hero
        ELSE NULL 
    END as heroi
FROM hero_detection hd
LEFT JOIN public.channel ch ON (hd.id_youtube = ch.id_youtube)
WHERE hd.confidence_score_1 > 0;