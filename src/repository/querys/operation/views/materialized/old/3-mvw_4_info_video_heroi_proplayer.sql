-- MATERIALIZED VIEW PARA DETECÇÃO DE MÚLTIPLOS PROPLAYERS
-- Implementa detecção de até 3 proplayers por vídeo:
-- - proplayer1: primeiro proplayer detectado (confiança > 60)
-- - proplayer2: segundo proplayer detectado, excluindo o primeiro (confiança > 60)
-- - proplayer3: verificação de existência de terceiro proplayer (apenas check, sem coluna)
-- - proplayer_final: regra de negócio baseada na quantidade de proplayers:
--   * NULL se existirem 3 proplayers
--   * Nome do proplayer se existir apenas 1
--   * "x1" se existirem 2 proplayers
-- - proplayer: mantido para compatibilidade (igual a proplayer1)

CREATE MATERIALIZED VIEW mvw_4_info_video_heroi_proplayer AS 
with proplayer_detection_1 AS (
    -- Detectar primeiro proplayer usando múltiplos critérios de precisão com espaços para evitar falsos positivos
    SELECT DISTINCT ON (vd.id_movie)
        vd.*,
        pp.name as detected_proplayer_1,
        pp.id_proplayer as id_proplayer_1,
        -- Score de confiança da detecção (maior = mais confiável)
        CASE
            -- Correspondência exata no título com as 3 variações de espaço (máxima confiança)
            WHEN (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_name || ' %') OR  -- ' Name '
                 (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_name || '') OR   -- ' Name'
                 (' ' || vd.clean_title || ' ') LIKE ('' || pp.clean_name || ' %') THEN 100  -- 'Name '
            -- Correspondência exata na descrição com as 3 variações de espaço
            WHEN (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
                 (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_name || '') OR
                 (' ' || vd.clean_description || ' ') LIKE ('' || pp.clean_name || ' %') THEN 90
            -- Correspondência exata no título da playlist com as 3 variações de espaço
            WHEN (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
                 (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || pp.clean_name || '') OR
                 (' ' || vd.clean_playlist_title || ' ') LIKE ('' || pp.clean_name || ' %') THEN 80
            -- Correspondência sem símbolos com as 3 variações de espaço
            WHEN (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_no_symbols_name || ' %') OR
                 (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_no_symbols_name || '') OR
                 (' ' || vd.clean_title || ' ') LIKE ('' || pp.clean_no_symbols_name || ' %') THEN 75
            WHEN (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_no_symbols_name || ' %') OR
                 (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_no_symbols_name || '') OR
                 (' ' || vd.clean_description || ' ') LIKE ('' || pp.clean_no_symbols_name || ' %') THEN 70
            -- Correspondência parcial com nomes longos (ex: "mira" para "miracle") - apenas se >= 4 chars
            WHEN pp.short_name IS NOT NULL AND LENGTH(pp.short_name) >= 4 AND (
                (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.short_name || ' %') OR
                (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.short_name || '') OR
                (' ' || vd.clean_title || ' ') LIKE ('' || pp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.short_name || '') OR
                (' ' || vd.clean_description || ' ') LIKE ('' || pp.short_name || ' %')
            ) THEN 60
            ELSE 0
        END as confidence_score_proplayer_1
    FROM mvw_3_info_video_heroi vd
    CROSS JOIN vw_proplayers pp
    WHERE 
        -- Aplicar filtros de detecção com as 3 variações de espaço para evitar falsos positivos
        (
            -- Busca com as 3 variações de espaço para palavras completas (evita falsos positivos)
            (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_name || ' %') OR  -- ' Name '
            (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_name || '') OR   -- ' Name'
            (' ' || vd.clean_title || ' ') LIKE ('' || pp.clean_name || ' %') OR   -- 'Name '
            (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
            (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_name || '') OR
            (' ' || vd.clean_description || ' ') LIKE ('' || pp.clean_name || ' %') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || pp.clean_name || '') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('' || pp.clean_name || ' %') OR
            -- Busca sem símbolos com as 3 variações de espaço
            (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_no_symbols_name || ' %') OR
            (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.clean_no_symbols_name || '') OR
            (' ' || vd.clean_title || ' ') LIKE ('' || pp.clean_no_symbols_name || ' %') OR
            (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_no_symbols_name || ' %') OR
            (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.clean_no_symbols_name || '') OR
            (' ' || vd.clean_description || ' ') LIKE ('' || pp.clean_no_symbols_name || ' %') OR
            -- Busca por nome abreviado com as 3 variações de espaço (apenas para nomes >= 4 chars)
            (pp.short_name IS NOT NULL AND LENGTH(pp.short_name) >= 4 AND (
                (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.short_name || ' %') OR
                (' ' || vd.clean_title || ' ') LIKE ('% ' || pp.short_name || '') OR
                (' ' || vd.clean_title || ' ') LIKE ('' || pp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || pp.short_name || '') OR
                (' ' || vd.clean_description || ' ') LIKE ('' || pp.short_name || ' %')
            ))
        )
    ORDER BY vd.id_movie, confidence_score_proplayer_1 DESC
),
proplayer_detection_2 AS (
    -- Detectar segundo proplayer excluindo o primeiro
    SELECT DISTINCT ON (pd1.id_movie)
        pd1.*,
        pp.name as detected_proplayer_2,
        pp.id_proplayer as id_proplayer_2,
        -- Score de confiança da detecção do segundo proplayer
        CASE
            -- Correspondência exata no título com as 3 variações de espaço (máxima confiança)
            WHEN (' ' || pd1.clean_title || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
                 (' ' || pd1.clean_title || ' ') LIKE ('% ' || pp.clean_name || '') OR
                 (' ' || pd1.clean_title || ' ') LIKE ('' || pp.clean_name || ' %') THEN 100
            -- Correspondência exata na descrição com as 3 variações de espaço
            WHEN (' ' || pd1.clean_description || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
                 (' ' || pd1.clean_description || ' ') LIKE ('% ' || pp.clean_name || '') OR
                 (' ' || pd1.clean_description || ' ') LIKE ('' || pp.clean_name || ' %') THEN 90
            -- Correspondência exata no título da playlist com as 3 variações de espaço
            WHEN (' ' || pd1.clean_playlist_title || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
                 (' ' || pd1.clean_playlist_title || ' ') LIKE ('% ' || pp.clean_name || '') OR
                 (' ' || pd1.clean_playlist_title || ' ') LIKE ('' || pp.clean_name || ' %') THEN 80
            -- Correspondência sem símbolos com as 3 variações de espaço
            WHEN (' ' || pd1.clean_title || ' ') LIKE ('% ' || pp.clean_no_symbols_name || ' %') OR
                 (' ' || pd1.clean_title || ' ') LIKE ('% ' || pp.clean_no_symbols_name || '') OR
                 (' ' || pd1.clean_title || ' ') LIKE ('' || pp.clean_no_symbols_name || ' %') THEN 75
            WHEN (' ' || pd1.clean_description || ' ') LIKE ('% ' || pp.clean_no_symbols_name || ' %') OR
                 (' ' || pd1.clean_description || ' ') LIKE ('% ' || pp.clean_no_symbols_name || '') OR
                 (' ' || pd1.clean_description || ' ') LIKE ('' || pp.clean_no_symbols_name || ' %') THEN 70
            -- Correspondência parcial com nomes longos
            WHEN pp.short_name IS NOT NULL AND LENGTH(pp.short_name) >= 4 AND (
                (' ' || pd1.clean_title || ' ') LIKE ('% ' || pp.short_name || ' %') OR
                (' ' || pd1.clean_title || ' ') LIKE ('% ' || pp.short_name || '') OR
                (' ' || pd1.clean_title || ' ') LIKE ('' || pp.short_name || ' %') OR
                (' ' || pd1.clean_description || ' ') LIKE ('% ' || pp.short_name || ' %') OR
                (' ' || pd1.clean_description || ' ') LIKE ('% ' || pp.short_name || '') OR
                (' ' || pd1.clean_description || ' ') LIKE ('' || pp.short_name || ' %')
            ) THEN 60
            ELSE 0
        END as confidence_score_2_second
    FROM proplayer_detection_1 pd1
    CROSS JOIN vw_proplayers pp
    WHERE 
        -- Excluir o primeiro proplayer detectado
        pp.id_proplayer != pd1.id_proplayer_1
        AND pd1.confidence_score_proplayer_1 > 60  -- Só procurar segundo proplayer se o primeiro for válido
        AND (
            -- Mesmos critérios de detecção do primeiro proplayer
            (' ' || pd1.clean_title || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
            (' ' || pd1.clean_title || ' ') LIKE ('% ' || pp.clean_name || '') OR
            (' ' || pd1.clean_title || ' ') LIKE ('' || pp.clean_name || ' %') OR
            (' ' || pd1.clean_description || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
            (' ' || pd1.clean_description || ' ') LIKE ('% ' || pp.clean_name || '') OR
            (' ' || pd1.clean_description || ' ') LIKE ('' || pp.clean_name || ' %') OR
            (' ' || pd1.clean_playlist_title || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
            (' ' || pd1.clean_playlist_title || ' ') LIKE ('% ' || pp.clean_name || '') OR
            (' ' || pd1.clean_playlist_title || ' ') LIKE ('' || pp.clean_name || ' %') OR
            -- Busca sem símbolos
            (' ' || pd1.clean_title || ' ') LIKE ('% ' || pp.clean_no_symbols_name || ' %') OR
            (' ' || pd1.clean_title || ' ') LIKE ('% ' || pp.clean_no_symbols_name || '') OR
            (' ' || pd1.clean_title || ' ') LIKE ('' || pp.clean_no_symbols_name || ' %') OR
            (' ' || pd1.clean_description || ' ') LIKE ('% ' || pp.clean_no_symbols_name || ' %') OR
            (' ' || pd1.clean_description || ' ') LIKE ('% ' || pp.clean_no_symbols_name || '') OR
            (' ' || pd1.clean_description || ' ') LIKE ('' || pp.clean_no_symbols_name || ' %') OR
            -- Busca por nome abreviado
            (pp.short_name IS NOT NULL AND LENGTH(pp.short_name) >= 4 AND (
                (' ' || pd1.clean_title || ' ') LIKE ('% ' || pp.short_name || ' %') OR
                (' ' || pd1.clean_title || ' ') LIKE ('% ' || pp.short_name || '') OR
                (' ' || pd1.clean_title || ' ') LIKE ('' || pp.short_name || ' %') OR
                (' ' || pd1.clean_description || ' ') LIKE ('% ' || pp.short_name || ' %') OR
                (' ' || pd1.clean_description || ' ') LIKE ('% ' || pp.short_name || '') OR
                (' ' || pd1.clean_description || ' ') LIKE ('' || pp.short_name || ' %')
            ))
        )
    ORDER BY pd1.id_movie, confidence_score_2_second DESC
),
proplayer_detection_3_check AS (
    -- Verificar se existe um terceiro proplayer
    SELECT DISTINCT 
        pd2.id_movie,
        CASE 
            WHEN COUNT(DISTINCT pp.id_proplayer) > 0 THEN TRUE
            ELSE FALSE
        END as has_third_proplayer
    FROM proplayer_detection_2 pd2
    CROSS JOIN vw_proplayers pp
    WHERE 
        -- Excluir o primeiro e segundo proplayer detectados
        pp.id_proplayer != pd2.id_proplayer_1
        AND pp.id_proplayer != COALESCE(pd2.id_proplayer_2, -1)
        AND pd2.confidence_score_2_second > 60  -- Só verificar terceiro proplayer se o segundo for válido
        AND (
            -- Mesmos critérios de detecção
            (' ' || pd2.clean_title || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
            (' ' || pd2.clean_title || ' ') LIKE ('% ' || pp.clean_name || '') OR
            (' ' || pd2.clean_title || ' ') LIKE ('' || pp.clean_name || ' %') OR
            (' ' || pd2.clean_description || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
            (' ' || pd2.clean_description || ' ') LIKE ('% ' || pp.clean_name || '') OR
            (' ' || pd2.clean_description || ' ') LIKE ('' || pp.clean_name || ' %') OR
            (' ' || pd2.clean_playlist_title || ' ') LIKE ('% ' || pp.clean_name || ' %') OR
            (' ' || pd2.clean_playlist_title || ' ') LIKE ('% ' || pp.clean_name || '') OR
            (' ' || pd2.clean_playlist_title || ' ') LIKE ('' || pp.clean_name || ' %') OR
            -- Busca sem símbolos
            (' ' || pd2.clean_title || ' ') LIKE ('% ' || pp.clean_no_symbols_name || ' %') OR
            (' ' || pd2.clean_title || ' ') LIKE ('% ' || pp.clean_no_symbols_name || '') OR
            (' ' || pd2.clean_title || ' ') LIKE ('' || pp.clean_no_symbols_name || ' %') OR
            (' ' || pd2.clean_description || ' ') LIKE ('% ' || pp.clean_no_symbols_name || ' %') OR
            (' ' || pd2.clean_description || ' ') LIKE ('% ' || pp.clean_no_symbols_name || '') OR
            (' ' || pd2.clean_description || ' ') LIKE ('' || pp.clean_no_symbols_name || ' %') OR
            -- Busca por nome abreviado
            (pp.short_name IS NOT NULL AND LENGTH(pp.short_name) >= 4 AND (
                (' ' || pd2.clean_title || ' ') LIKE ('% ' || pp.short_name || ' %') OR
                (' ' || pd2.clean_title || ' ') LIKE ('% ' || pp.short_name || '') OR
                (' ' || pd2.clean_title || ' ') LIKE ('' || pp.short_name || ' %') OR
                (' ' || pd2.clean_description || ' ') LIKE ('% ' || pp.short_name || ' %') OR
                (' ' || pd2.clean_description || ' ') LIKE ('% ' || pp.short_name || '') OR
                (' ' || pd2.clean_description || ' ') LIKE ('' || pp.short_name || ' %')
            ))
        )
    GROUP BY pd2.id_movie
)
SELECT 
    pd2.*,
    -- Proplayer1 (compatibilidade com view anterior)
    CASE 
        WHEN pd2.confidence_score_proplayer_1 > 60 THEN pd2.detected_proplayer_1
        ELSE NULL 
    END as proplayer,
    -- Proplayer1 e Proplayer2 com as regras solicitadas
    CASE 
        WHEN pd2.confidence_score_proplayer_1 > 60 THEN pd2.detected_proplayer_1
        ELSE NULL 
    END as proplayer1,
    CASE 
        WHEN pd2.confidence_score_2_second > 60 THEN pd2.detected_proplayer_2
        ELSE NULL 
    END as proplayer2,
    -- Proplayer final baseado nas regras:
    -- NULL se existirem 3 proplayers
    -- O nome do proplayer se só existir 1
    -- "x1" se existirem 2 proplayers
    CASE 
        WHEN COALESCE(pd3.has_third_proplayer, FALSE) = TRUE THEN NULL  -- 3 proplayers = NULL
        WHEN pd2.confidence_score_2_second > 60 AND pd2.confidence_score_proplayer_1 > 60 THEN 'x1'  -- 2 proplayers = x1
        WHEN pd2.confidence_score_proplayer_1 > 60 AND COALESCE(pd2.confidence_score_2_second, 0) <= 60 THEN pd2.detected_proplayer_1  -- 1 proplayer = nome do proplayer
        ELSE NULL  -- Nenhum proplayer válido
    END as proplayer_final
FROM proplayer_detection_2 pd2
LEFT JOIN proplayer_detection_3_check pd3 ON (pd2.id_movie = pd3.id_movie);