CREATE MATERIALIZED VIEW mvw_3_info_video_proplayer AS 
with proplayer_detection AS (
    -- Detectar proplayers usando múltiplos critérios de precisão (do mais específico ao mais geral)
    SELECT DISTINCT ON (vd.id_movie)
        vd.*,
        pp.name as detected_proplayer,
        pp.id_proplayer,
        -- Score de confiança da detecção (maior = mais confiável)
        CASE
            -- Correspondência exata no título (máxima confiança)
            WHEN vd.clean_title ~ ('\y' || pp.regex_safe_name || '\y') THEN 100
            -- Correspondência exata na descrição
            WHEN vd.clean_description ~ ('\y' || pp.regex_safe_name || '\y') THEN 90
            -- Correspondência exata no título da playlist
            WHEN vd.clean_playlist_title ~ ('\y' || pp.regex_safe_name || '\y') THEN 80
            -- Correspondência sem espaços (ex: "miracle" em "miraclegameplay")
            WHEN vd.clean_title LIKE '%' || pp.no_space_name || '%' THEN 70
            WHEN vd.clean_description LIKE '%' || pp.no_space_name || '%' THEN 65
            -- Correspondência sem símbolos (ex: "miracle" em "miracle-dota")
            WHEN vd.clean_title LIKE '%' || pp.clean_no_symbols_name || '%' THEN 68
            WHEN vd.clean_description LIKE '%' || pp.clean_no_symbols_name || '%' THEN 63
            -- Correspondência parcial com nomes longos (ex: "mira" para "miracle")
            WHEN pp.short_name IS NOT NULL AND (
                vd.clean_title LIKE '%' || pp.short_name || '%' OR
                vd.clean_description LIKE '%' || pp.short_name || '%'
            ) THEN 60
            -- Correspondência fuzzy usando LIKE (menos confiável)
            WHEN vd.clean_title LIKE '%' || pp.clean_name || '%' THEN 50
            WHEN vd.clean_description LIKE '%' || pp.clean_name || '%' THEN 45
            ELSE 0
        END as confidence_score
    FROM mvw_1_info_video vd
    CROSS JOIN vw_proplayers pp
    WHERE 
        -- Aplicar filtros de detecção de forma eficiente
        (
            -- Busca com regex para palavras completas (mais preciso)
            vd.clean_title ~ ('\y' || pp.regex_safe_name || '\y') OR
            vd.clean_description ~ ('\y' || pp.regex_safe_name || '\y') OR
            vd.clean_playlist_title ~ ('\y' || pp.regex_safe_name || '\y') OR
            -- Busca com LIKE para casos especiais
            vd.clean_title LIKE '%' || pp.no_space_name || '%' OR
            vd.clean_description LIKE '%' || pp.no_space_name || '%' OR
            vd.clean_title LIKE '%' || pp.clean_no_symbols_name || '%' OR
            vd.clean_description LIKE '%' || pp.clean_no_symbols_name || '%' OR
            -- Busca por nome abreviado (apenas para nomes longos)
            (pp.short_name IS NOT NULL AND (
                vd.clean_title LIKE '%' || pp.short_name || '%' OR
                vd.clean_description LIKE '%' || pp.short_name || '%'
            )) OR
            -- Fallback com LIKE simples
            vd.clean_title LIKE '%' || pp.clean_name || '%' OR
            vd.clean_description LIKE '%' || pp.clean_name || '%'
        )
    ORDER BY vd.id_movie, confidence_score DESC
)
SELECT 
    pd.*,
    -- Retornar proplayer apenas se confiança >= 60 (evita falsos positivos)
    CASE 
        WHEN pd.confidence_score >= 60 THEN pd.detected_proplayer
        ELSE NULL 
    END as proplayer
FROM proplayer_detection pd
WHERE pd.confidence_score > 0;