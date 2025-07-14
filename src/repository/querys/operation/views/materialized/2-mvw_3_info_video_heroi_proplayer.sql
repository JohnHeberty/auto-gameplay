CREATE MATERIALIZED VIEW mvw_3_info_video_heroi_proplayer AS 
with proplayer_detection AS (
    -- Detectar proplayers usando múltiplos critérios de precisão com espaços para evitar falsos positivos
    SELECT DISTINCT ON (vd.id_movie)
        vd.*,
        pp.name as detected_proplayer,
        pp.id_proplayer,
        -- Score de confiança da detecção (maior = mais confiável)
        CASE
            -- Correspondência exata no título com as 3 variações de espaço (máxima confiança)
            WHEN (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_name || ' %') OR  -- ' Name '
                 (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_name || '%') OR   -- ' Name'
                 (' ' || vd.clean_title || ' ') LIKE ('%' || pp.clean_name || ' %') THEN 100  -- 'Name '
            -- Correspondência exata na descrição com as 3 variações de espaço
            WHEN (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
                 (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_name || '%') OR
                 (' ' || vd.clean_description || ' ') LIKE ('%' || pp.clean_name || ' %') THEN 90
            -- Correspondência exata no título da playlist com as 3 variações de espaço
            WHEN (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
                 (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || pp.clean_name || '%') OR
                 (' ' || vd.clean_playlist_title || ' ') LIKE ('%' || pp.clean_name || ' %') THEN 80
            -- Correspondência sem símbolos com as 3 variações de espaço
            WHEN (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_no_symbols_name || ' %') OR
                 (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_no_symbols_name || '%') OR
                 (' ' || vd.clean_title || ' ') LIKE ('%' || pp.clean_no_symbols_name || ' %') THEN 75
            WHEN (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_no_symbols_name || ' %') OR
                 (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_no_symbols_name || '%') OR
                 (' ' || vd.clean_description || ' ') LIKE ('%' || pp.clean_no_symbols_name || ' %') THEN 70
            -- Correspondência parcial com nomes longos (ex: "mira" para "miracle") - apenas se >= 4 chars
            WHEN pp.short_name IS NOT NULL AND LENGTH(pp.short_name) >= 4 AND (
                (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.short_name || ' %') OR
                (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.short_name || '%') OR
                (' ' || vd.clean_title || ' ') LIKE ('%' || pp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.short_name || '%') OR
                (' ' || vd.clean_description || ' ') LIKE ('%' || pp.short_name || ' %')
            ) THEN 60
            ELSE 0
        END as confidence_score_2
    FROM mvw_2_info_video_heroi vd
    CROSS JOIN vw_proplayers pp
    WHERE 
        -- Aplicar filtros de detecção com as 3 variações de espaço para evitar falsos positivos
        (
            -- Busca com as 3 variações de espaço para palavras completas (evita falsos positivos)
            (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_name || ' %') OR  -- ' Name '
            (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_name || '%') OR   -- ' Name'
            (' ' || vd.clean_title || ' ') LIKE ('%' || pp.clean_name || ' %') OR   -- 'Name '
            (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
            (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_name || '%') OR
            (' ' || vd.clean_description || ' ') LIKE ('%' || pp.clean_name || ' %') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || pp.clean_name || '%') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('%' || pp.clean_name || ' %') OR
            -- Busca sem símbolos com as 3 variações de espaço
            (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_no_symbols_name || ' %') OR
            (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_no_symbols_name || '%') OR
            (' ' || vd.clean_title || ' ') LIKE ('%' || pp.clean_no_symbols_name || ' %') OR
            (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_no_symbols_name || ' %') OR
            (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_no_symbols_name || '%') OR
            (' ' || vd.clean_description || ' ') LIKE ('%' || pp.clean_no_symbols_name || ' %') OR
            -- Busca por nome abreviado com as 3 variações de espaço (apenas para nomes >= 4 chars)
            (pp.short_name IS NOT NULL AND LENGTH(pp.short_name) >= 4 AND (
                (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.short_name || ' %') OR
                (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.short_name || '%') OR
                (' ' || vd.clean_title || ' ') LIKE ('%' || pp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.short_name || '%') OR
                (' ' || vd.clean_description || ' ') LIKE ('%' || pp.short_name || ' %')
            ))
        )
    ORDER BY vd.id_movie, confidence_score_2 DESC
)
SELECT 
    pd.*,
    -- Retornar proplayer apenas se confiança >= 60 (evita falsos positivos)
    CASE 
        WHEN pd.confidence_score_2 >= 60 THEN pd.detected_proplayer
        ELSE NULL 
    END as proplayer
FROM proplayer_detection pd
WHERE pd.confidence_score_2 > 0;