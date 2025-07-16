-- MATERIALIZED VIEW PARA DETECÇÃO DE MÚLTIPLOS HERÓIS
-- Implementa detecção de até 3 heróis por vídeo:
-- - heroi1: primeiro herói detectado (confiança > 60)
-- - heroi2: segundo herói detectado, excluindo o primeiro (confiança > 60)
-- - heroi3: verificação de existência de terceiro herói (apenas check, sem coluna)
-- - heroi_final: regra de negócio baseada na quantidade de heróis:
--   * NULL se existirem 3 heróis
--   * Nome do herói se existir apenas 1
--   * "x1" se existirem 2 heróis
-- - heroi: mantido para compatibilidade (igual a heroi1)

CREATE MATERIALIZED VIEW mvw_3_info_video_heroi AS 
with hero_detection_1 AS (
    -- Detectar primeiro herói usando múltiplos critérios de precisão com espaços para evitar falsos positivos
    SELECT DISTINCT ON (vd.id_movie)
        vd.*,
        hp.localized_name as detected_hero_1,
        hp.id_hero as id_hero_1,
        -- Score de confiança da detecção (maior = mais confiável)
        CASE
            -- Correspondência exata no título com as 3 variações de espaço (máxima confiança)
            WHEN (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR  -- ' Ace '
                 (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR   -- ' Ace'
                 (' ' || vd.clean_title || ' ') LIKE ('' || hp.clean_localized_name || ' %') THEN 100  -- 'Ace '
            WHEN (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
                 (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_name || '') OR
                 (' ' || vd.clean_title || ' ') LIKE ('' || hp.clean_name || ' %') THEN 95
            -- Correspondência exata no título da playlist com as 3 variações de espaço
            WHEN (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
                 (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
                 (' ' || vd.clean_playlist_title || ' ') LIKE ('' || hp.clean_localized_name || ' %') THEN 90
            WHEN (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
                 (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_name || '') OR
                 (' ' || vd.clean_playlist_title || ' ') LIKE ('' || hp.clean_name || ' %') THEN 85
            -- Correspondência exata na descrição com as 3 variações de espaço
            WHEN (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
                 (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
                 (' ' || vd.clean_description || ' ') LIKE ('' || hp.clean_localized_name || ' %') THEN 70
            WHEN (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
                 (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_name || '') OR
                 (' ' || vd.clean_description || ' ') LIKE ('' || hp.clean_name || ' %') THEN 75
            -- Correspondência parcial com nomes longos (ex: "invo" para "invoker") - apenas se >= 4 chars
            WHEN hp.short_name IS NOT NULL AND LENGTH(hp.short_name) >= 4 AND (
                (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || vd.clean_title || ' ') LIKE ('' || hp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || vd.clean_description || ' ') LIKE ('' || hp.short_name || ' %')
            ) THEN 60
            ELSE 0
        END as confidence_score_1
    FROM mvw_2_info_video_clean_words vd
    CROSS JOIN vw_heroi hp
    WHERE 
        -- Aplicar filtros de detecção com as 3 variações de espaço para evitar falsos positivos
        (
            -- Busca com as 3 variações de espaço para palavras completas (evita "ace" em "facebook")
            (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR  -- ' Ace '
            (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR   -- ' Ace'
            (' ' || vd.clean_title || ' ') LIKE ('' || hp.clean_localized_name || ' %') OR   -- 'Ace '
            (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
            (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.clean_name || '') OR
            (' ' || vd.clean_title || ' ') LIKE ('' || hp.clean_name || ' %') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('' || hp.clean_localized_name || ' %') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_name || '') OR
            (' ' || vd.clean_playlist_title || ' ') LIKE ('' || hp.clean_name || ' %') OR
            (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
            (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
            (' ' || vd.clean_description || ' ') LIKE ('' || hp.clean_localized_name || ' %') OR
            (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
            (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.clean_name || '') OR
            (' ' || vd.clean_description || ' ') LIKE ('' || hp.clean_name || ' %') OR
            -- Busca por nome abreviado com as 3 variações de espaço (apenas para nomes >= 4 chars)
            (hp.short_name IS NOT NULL AND LENGTH(hp.short_name) >= 4 AND (
                (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || vd.clean_title || ' ') LIKE ('' || hp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || vd.clean_description || ' ') LIKE ('' || hp.short_name || ' %')
            ))
        )
    ORDER BY vd.id_movie, confidence_score_1 DESC
),
hero_detection_2 AS (
    -- Detectar segundo herói excluindo o primeiro
    SELECT DISTINCT ON (hd1.id_movie)
        hd1.*,
        hp.localized_name as detected_hero_2,
        hp.id_hero as id_hero_2,
        -- Score de confiança da detecção do segundo herói
        CASE
            -- Correspondência exata no título com as 3 variações de espaço (máxima confiança)
            WHEN (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
                 (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
                 (' ' || hd1.clean_title || ' ') LIKE ('' || hp.clean_localized_name || ' %') THEN 100
            WHEN (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
                 (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.clean_name || '') OR
                 (' ' || hd1.clean_title || ' ') LIKE ('' || hp.clean_name || ' %') THEN 95
            -- Correspondência exata no título da playlist com as 3 variações de espaço
            WHEN (' ' || hd1.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
                 (' ' || hd1.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
                 (' ' || hd1.clean_playlist_title || ' ') LIKE ('' || hp.clean_localized_name || ' %') THEN 90
            WHEN (' ' || hd1.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
                 (' ' || hd1.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_name || '') OR
                 (' ' || hd1.clean_playlist_title || ' ') LIKE ('' || hp.clean_name || ' %') THEN 85
            -- Correspondência exata na descrição com as 3 variações de espaço
            WHEN (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
                 (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
                 (' ' || hd1.clean_description || ' ') LIKE ('' || hp.clean_localized_name || ' %') THEN 70
            WHEN (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
                 (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.clean_name || '') OR
                 (' ' || hd1.clean_description || ' ') LIKE ('' || hp.clean_name || ' %') THEN 75
            -- Correspondência parcial com nomes longos
            WHEN hp.short_name IS NOT NULL AND LENGTH(hp.short_name) >= 4 AND (
                (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || hd1.clean_title || ' ') LIKE ('' || hp.short_name || ' %') OR
                (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || hd1.clean_description || ' ') LIKE ('' || hp.short_name || ' %')
            ) THEN 60
            ELSE 0
        END as confidence_score_2
    FROM hero_detection_1 hd1
    CROSS JOIN vw_heroi hp
    WHERE 
        -- Excluir o primeiro herói detectado
        hp.id_hero != hd1.id_hero_1
        AND hd1.confidence_score_1 > 60  -- Só procurar segundo herói se o primeiro for válido
        AND (
            -- Mesmos critérios de detecção do primeiro herói
            (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
            (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
            (' ' || hd1.clean_title || ' ') LIKE ('' || hp.clean_localized_name || ' %') OR
            (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
            (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.clean_name || '') OR
            (' ' || hd1.clean_title || ' ') LIKE ('' || hp.clean_name || ' %') OR
            (' ' || hd1.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
            (' ' || hd1.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
            (' ' || hd1.clean_playlist_title || ' ') LIKE ('' || hp.clean_localized_name || ' %') OR
            (' ' || hd1.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
            (' ' || hd1.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_name || '') OR
            (' ' || hd1.clean_playlist_title || ' ') LIKE ('' || hp.clean_name || ' %') OR
            (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
            (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
            (' ' || hd1.clean_description || ' ') LIKE ('' || hp.clean_localized_name || ' %') OR
            (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
            (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.clean_name || '') OR
            (' ' || hd1.clean_description || ' ') LIKE ('' || hp.clean_name || ' %') OR
            -- Busca por nome abreviado
            (hp.short_name IS NOT NULL AND LENGTH(hp.short_name) >= 4 AND (
                (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || hd1.clean_title || ' ') LIKE ('' || hp.short_name || ' %') OR
                (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || hd1.clean_description || ' ') LIKE ('' || hp.short_name || ' %')
            ))
        )
    ORDER BY hd1.id_movie, confidence_score_2 DESC
),
hero_detection_3_check AS (
    -- Verificar se existe um terceiro herói
    SELECT DISTINCT 
        hd2.id_movie,
        CASE 
            WHEN COUNT(DISTINCT hp.id_hero) > 0 THEN TRUE
            ELSE FALSE
        END as has_third_hero
    FROM hero_detection_2 hd2
    CROSS JOIN vw_heroi hp
    WHERE 
        -- Excluir o primeiro e segundo herói detectados
        hp.id_hero != hd2.id_hero_1
        AND hp.id_hero != COALESCE(hd2.id_hero_2, -1)
        AND hd2.confidence_score_2 > 60  -- Só verificar terceiro herói se o segundo for válido
        AND (
            -- Mesmos critérios de detecção
            (' ' || hd2.clean_title || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
            (' ' || hd2.clean_title || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
            (' ' || hd2.clean_title || ' ') LIKE ('' || hp.clean_localized_name || ' %') OR
            (' ' || hd2.clean_title || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
            (' ' || hd2.clean_title || ' ') LIKE ('% ' || hp.clean_name || '') OR
            (' ' || hd2.clean_title || ' ') LIKE ('' || hp.clean_name || ' %') OR
            (' ' || hd2.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
            (' ' || hd2.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
            (' ' || hd2.clean_playlist_title || ' ') LIKE ('' || hp.clean_localized_name || ' %') OR
            (' ' || hd2.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
            (' ' || hd2.clean_playlist_title || ' ') LIKE ('% ' || hp.clean_name || '') OR
            (' ' || hd2.clean_playlist_title || ' ') LIKE ('' || hp.clean_name || ' %') OR
            (' ' || hd2.clean_description || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
            (' ' || hd2.clean_description || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
            (' ' || hd2.clean_description || ' ') LIKE ('' || hp.clean_localized_name || ' %') OR
            (' ' || hd2.clean_description || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
            (' ' || hd2.clean_description || ' ') LIKE ('% ' || hp.clean_name || '') OR
            (' ' || hd2.clean_description || ' ') LIKE ('' || hp.clean_name || ' %') OR
            -- Busca por nome abreviado
            (hp.short_name IS NOT NULL AND LENGTH(hp.short_name) >= 4 AND (
                (' ' || hd2.clean_title || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || hd2.clean_title || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || hd2.clean_title || ' ') LIKE ('' || hp.short_name || ' %') OR
                (' ' || hd2.clean_description || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || hd2.clean_description || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || hd2.clean_description || ' ') LIKE ('' || hp.short_name || ' %')
            ))
        )
    GROUP BY hd2.id_movie
)
SELECT 
    hd2.id_movie,
    hd2.id_video,
    ch.id_channel,
    hd2.id_playlist,
    hd2.title,
    hd2.description,
    hd2.views,
    hd2.likes,
    hd2.title_playlist,
    hd2.id_youtube,
    hd2.dt_upload,
    hd2.version,
    -- Aplicar limpeza diretamente nas colunas clean existentes (removendo o primeiro herói)
    CASE 
        WHEN hd2.confidence_score_1 > 60 THEN 
            TRIM(REGEXP_REPLACE(
                REGEXP_REPLACE(hd2.clean_title, 
                    '\y' || LOWER(hd2.detected_hero_1) || '\y', ' ', 'gi'),
                '\s+', ' ', 'g'))
        ELSE hd2.clean_title 
    END as clean_title,
    CASE 
        WHEN hd2.confidence_score_1 > 60 THEN 
            TRIM(REGEXP_REPLACE(
                REGEXP_REPLACE(hd2.clean_description, 
                    '\y' || LOWER(hd2.detected_hero_1) || '\y', ' ', 'gi'),
                '\s+', ' ', 'g'))
        ELSE hd2.clean_description 
    END as clean_description,
    CASE 
        WHEN hd2.confidence_score_1 > 60 THEN 
            TRIM(REGEXP_REPLACE(
                REGEXP_REPLACE(hd2.clean_playlist_title, 
                    '\y' || LOWER(hd2.detected_hero_1) || '\y', ' ', 'gi'),
                '\s+', ' ', 'g'))
        ELSE hd2.clean_playlist_title 
    END as clean_playlist_title,
    -- Colunas do primeiro herói
    hd2.detected_hero_1,
    hd2.id_hero_1,
    hd2.confidence_score_1,
    -- Herói1 (compatibilidade com view anterior)
    CASE 
        WHEN hd2.confidence_score_1 > 60 THEN hd2.detected_hero_1
        ELSE NULL 
    END as heroi,
    -- Colunas do segundo herói
    hd2.detected_hero_2,
    hd2.id_hero_2,
    hd2.confidence_score_2,
    -- Herói1 e Herói2 com as regras solicitadas
    CASE 
        WHEN hd2.confidence_score_1 > 60 THEN hd2.detected_hero_1
        ELSE NULL 
    END as heroi1,
    CASE 
        WHEN hd2.confidence_score_2 > 60 THEN hd2.detected_hero_2
        ELSE NULL 
    END as heroi2,
    -- Herói final baseado nas regras:
    -- NULL se existirem 3 heróis
    -- O nome do herói se só existir 1
    -- "x1" se existirem 2 heróis
    CASE 
        WHEN COALESCE(hd3.has_third_hero, FALSE) = TRUE THEN NULL  -- 3 heróis = NULL
        WHEN hd2.confidence_score_2 > 60 AND hd2.confidence_score_1 > 60 THEN 'x1'  -- 2 heróis = x1
        WHEN hd2.confidence_score_1 > 60 AND COALESCE(hd2.confidence_score_2, 0) <= 60 THEN hd2.detected_hero_1  -- 1 herói = nome do herói
        ELSE NULL  -- Nenhum herói válido
    END as heroi_final
FROM hero_detection_2 hd2
LEFT JOIN hero_detection_3_check hd3 ON (hd2.id_movie = hd3.id_movie)
LEFT JOIN public.channel ch ON (hd2.id_youtube = ch.id_youtube);