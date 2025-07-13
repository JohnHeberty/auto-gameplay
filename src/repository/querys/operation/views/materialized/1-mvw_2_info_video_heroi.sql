CREATE MATERIALIZED VIEW mvw_2_info_video_heroi AS 
with hero_detection AS (
    -- Detectar heróis usando múltiplos critérios de precisão (do mais específico ao mais geral)
    SELECT DISTINCT ON (vd.id_movie)
        vd.*,
        hp.localized_name as detected_hero,
        hp.id_hero,
        -- Score de confiança da detecção (maior = mais confiável)
        CASE
            -- Correspondência exata no título (máxima confiança)
            WHEN vd.clean_title ~ ('(^|[^a-zA-Z0-9.])' || hp.clean_localized_name || '([^a-zA-Z0-9.]|$)') THEN 100
            WHEN vd.clean_title ~ ('(^|[^a-zA-Z0-9.])' || hp.clean_name || '([^a-zA-Z0-9.]|$)') THEN 95
            -- Correspondência exata na descrição
            WHEN vd.clean_description ~ ('(^|[^a-zA-Z0-9.])' || hp.clean_localized_name || '([^a-zA-Z0-9.]|$)') THEN 90
            WHEN vd.clean_description ~ ('(^|[^a-zA-Z0-9.])' || hp.clean_name || '([^a-zA-Z0-9.]|$)') THEN 85
            -- Correspondência exata no título da playlist
            WHEN vd.clean_playlist_title ~ ('(^|[^a-zA-Z0-9.])' || hp.clean_localized_name || '([^a-zA-Z0-9.]|$)') THEN 80
            WHEN vd.clean_playlist_title ~ ('(^|[^a-zA-Z0-9.])' || hp.clean_name || '([^a-zA-Z0-9.]|$)') THEN 75
            -- Correspondência sem espaços (ex: "pudge" em "pudgegameplay")
            WHEN vd.clean_title LIKE '%' || hp.no_space_name || '%' THEN 70
            WHEN vd.clean_description LIKE '%' || hp.no_space_name || '%' THEN 65
            -- Correspondência parcial com nomes longos (ex: "invo" para "invoker")
            WHEN hp.short_name IS NOT NULL AND (
                vd.clean_title LIKE '%' || hp.short_name || '%' OR
                vd.clean_description LIKE '%' || hp.short_name || '%'
            ) THEN 60
            -- Correspondência fuzzy usando LIKE (menos confiável)
            WHEN vd.clean_title LIKE '%' || hp.clean_localized_name || '%' THEN 50
            WHEN vd.clean_description LIKE '%' || hp.clean_localized_name || '%' THEN 45
            ELSE 0
        END as confidence_score_1
    FROM mvw_1_info_video vd
    CROSS JOIN vw_heroi hp
    WHERE 
        -- Aplicar filtros de detecção de forma eficiente
        (
            -- Busca com regex para palavras completas (mais preciso)
            vd.clean_title ~ ('(^|[^a-zA-Z0-9.])' || hp.clean_localized_name || '([^a-zA-Z0-9.]|$)') OR
            vd.clean_title ~ ('(^|[^a-zA-Z0-9.])' || hp.clean_name || '([^a-zA-Z0-9.]|$)') OR
            vd.clean_description ~ ('(^|[^a-zA-Z0-9.])' || hp.clean_localized_name || '([^a-zA-Z0-9.]|$)') OR
            vd.clean_description ~ ('(^|[^a-zA-Z0-9.])' || hp.clean_name || '([^a-zA-Z0-9.]|$)') OR
            vd.clean_playlist_title ~ ('(^|[^a-zA-Z0-9.])' || hp.clean_localized_name || '([^a-zA-Z0-9.]|$)') OR
            vd.clean_playlist_title ~ ('(^|[^a-zA-Z0-9.])' || hp.clean_name || '([^a-zA-Z0-9.]|$)') OR
            -- Busca com LIKE para casos especiais
            vd.clean_title LIKE '%' || hp.no_space_name || '%' OR
            vd.clean_description LIKE '%' || hp.no_space_name || '%' OR
            -- Busca por nome abreviado (apenas para nomes longos)
            (hp.short_name IS NOT NULL AND (
                vd.clean_title LIKE '%' || hp.short_name || '%' OR
                vd.clean_description LIKE '%' || hp.short_name || '%'
            )) OR
            -- Fallback com LIKE simples
            vd.clean_title LIKE '%' || hp.clean_localized_name || '%' OR
            vd.clean_description LIKE '%' || hp.clean_localized_name || '%'
        )
    ORDER BY vd.id_movie, confidence_score_1 DESC
)
SELECT 
    hd.*,
    -- Retornar herói apenas se confiança >= 60 (evita falsos positivos)
    CASE 
        WHEN hd.confidence_score_1 >= 60 THEN hd.detected_hero
        ELSE NULL 
    END as heroi
FROM hero_detection hd
WHERE hd.confidence_score_1 > 0;