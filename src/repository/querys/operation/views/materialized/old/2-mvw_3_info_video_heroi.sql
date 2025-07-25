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
        pmh.keywords,
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
            -- Correspondência exata nas keywords (array) com as 3 variações de espaço
            WHEN pmh.keywords IS NOT NULL AND (
                EXISTS (
                    SELECT 1 FROM unnest(pmh.keywords) AS keyword
                    WHERE (' ' || keyword || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
                          (' ' || keyword || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
                          (' ' || keyword || ' ') LIKE ('' || hp.clean_localized_name || ' %')
                )
            ) THEN 95
            WHEN pmh.keywords IS NOT NULL AND (
                EXISTS (
                    SELECT 1 FROM unnest(pmh.keywords) AS keyword
                    WHERE (' ' || keyword || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
                          (' ' || keyword || ' ') LIKE ('% ' || hp.clean_name || '') OR
                          (' ' || keyword || ' ') LIKE ('' || hp.clean_name || ' %')
                )
            ) THEN 90
            -- Correspondência parcial com nomes longos (ex: "invo" para "invoker") - apenas se >= 4 chars
            WHEN hp.short_name IS NOT NULL AND LENGTH(hp.short_name) >= 4 AND (
                (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || vd.clean_title || ' ') LIKE ('' || hp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || vd.clean_description || ' ') LIKE ('' || hp.short_name || ' %') OR
                (pmh.keywords IS NOT NULL AND (
                    EXISTS (
                        SELECT 1 FROM unnest(pmh.keywords) AS keyword
                        WHERE (' ' || keyword || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                              (' ' || keyword || ' ') LIKE ('% ' || hp.short_name || '') OR
                              (' ' || keyword || ' ') LIKE ('' || hp.short_name || ' %')
                    )
                ))
            ) THEN 60
            ELSE 0
        END as confidence_score_1
    FROM mvw_2_info_video_clean_words vd
    LEFT JOIN playlist_movie_historic pmh ON (vd.id_movie = pmh.id_movie)
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
            -- Busca nas keywords (array) com as 3 variações de espaço
            (pmh.keywords IS NOT NULL AND (
                EXISTS (
                    SELECT 1 FROM unnest(pmh.keywords) AS keyword
                    WHERE (' ' || keyword || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
                          (' ' || keyword || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
                          (' ' || keyword || ' ') LIKE ('' || hp.clean_localized_name || ' %') OR
                          (' ' || keyword || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
                          (' ' || keyword || ' ') LIKE ('% ' || hp.clean_name || '') OR
                          (' ' || keyword || ' ') LIKE ('' || hp.clean_name || ' %')
                )
            )) OR
            -- Busca por nome abreviado com as 3 variações de espaço (apenas para nomes >= 4 chars)
            (hp.short_name IS NOT NULL AND LENGTH(hp.short_name) >= 4 AND (
                (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || vd.clean_title || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || vd.clean_title || ' ') LIKE ('' || hp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || vd.clean_description || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || vd.clean_description || ' ') LIKE ('' || hp.short_name || ' %') OR
                (pmh.keywords IS NOT NULL AND (
                    EXISTS (
                        SELECT 1 FROM unnest(pmh.keywords) AS keyword
                        WHERE (' ' || keyword || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                              (' ' || keyword || ' ') LIKE ('% ' || hp.short_name || '') OR
                              (' ' || keyword || ' ') LIKE ('' || hp.short_name || ' %')
                    )
                ))
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
            -- Correspondência exata nas keywords (array) com as 3 variações de espaço
            WHEN hd1.keywords IS NOT NULL AND (
                EXISTS (
                    SELECT 1 FROM unnest(hd1.keywords) AS keyword
                    WHERE (' ' || keyword || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
                          (' ' || keyword || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
                          (' ' || keyword || ' ') LIKE ('' || hp.clean_localized_name || ' %')
                )
            ) THEN 95
            WHEN hd1.keywords IS NOT NULL AND (
                EXISTS (
                    SELECT 1 FROM unnest(hd1.keywords) AS keyword
                    WHERE (' ' || keyword || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
                          (' ' || keyword || ' ') LIKE ('% ' || hp.clean_name || '') OR
                          (' ' || keyword || ' ') LIKE ('' || hp.clean_name || ' %')
                )
            ) THEN 90
            -- Correspondência parcial com nomes longos
            WHEN hp.short_name IS NOT NULL AND LENGTH(hp.short_name) >= 4 AND (
                (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || hd1.clean_title || ' ') LIKE ('' || hp.short_name || ' %') OR
                (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || hd1.clean_description || ' ') LIKE ('' || hp.short_name || ' %') OR
                (hd1.keywords IS NOT NULL AND (
                    EXISTS (
                        SELECT 1 FROM unnest(hd1.keywords) AS keyword
                        WHERE (' ' || keyword || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                              (' ' || keyword || ' ') LIKE ('% ' || hp.short_name || '') OR
                              (' ' || keyword || ' ') LIKE ('' || hp.short_name || ' %')
                    )
                ))
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
            -- Busca nas keywords (array) com as 3 variações de espaço
            (hd1.keywords IS NOT NULL AND (
                EXISTS (
                    SELECT 1 FROM unnest(hd1.keywords) AS keyword
                    WHERE (' ' || keyword || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
                          (' ' || keyword || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
                          (' ' || keyword || ' ') LIKE ('' || hp.clean_localized_name || ' %') OR
                          (' ' || keyword || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
                          (' ' || keyword || ' ') LIKE ('% ' || hp.clean_name || '') OR
                          (' ' || keyword || ' ') LIKE ('' || hp.clean_name || ' %')
                )
            )) OR
            -- Busca por nome abreviado
            (hp.short_name IS NOT NULL AND LENGTH(hp.short_name) >= 4 AND (
                (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || hd1.clean_title || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || hd1.clean_title || ' ') LIKE ('' || hp.short_name || ' %') OR
                (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || hd1.clean_description || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || hd1.clean_description || ' ') LIKE ('' || hp.short_name || ' %') OR
                (hd1.keywords IS NOT NULL AND (
                    EXISTS (
                        SELECT 1 FROM unnest(hd1.keywords) AS keyword
                        WHERE (' ' || keyword || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                              (' ' || keyword || ' ') LIKE ('% ' || hp.short_name || '') OR
                              (' ' || keyword || ' ') LIKE ('' || hp.short_name || ' %')
                    )
                ))
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
            -- Busca nas keywords (array) com as 3 variações de espaço
            (hd2.keywords IS NOT NULL AND (
                EXISTS (
                    SELECT 1 FROM unnest(hd2.keywords) AS keyword
                    WHERE (' ' || keyword || ' ') LIKE ('% ' || hp.clean_localized_name || ' %') OR
                          (' ' || keyword || ' ') LIKE ('% ' || hp.clean_localized_name || '') OR
                          (' ' || keyword || ' ') LIKE ('' || hp.clean_localized_name || ' %') OR
                          (' ' || keyword || ' ') LIKE ('% ' || hp.clean_name || ' %') OR
                          (' ' || keyword || ' ') LIKE ('% ' || hp.clean_name || '') OR
                          (' ' || keyword || ' ') LIKE ('' || hp.clean_name || ' %')
                )
            )) OR
            -- Busca por nome abreviado
            (hp.short_name IS NOT NULL AND LENGTH(hp.short_name) >= 4 AND (
                (' ' || hd2.clean_title || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || hd2.clean_title || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || hd2.clean_title || ' ') LIKE ('' || hp.short_name || ' %') OR
                (' ' || hd2.clean_description || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                (' ' || hd2.clean_description || ' ') LIKE ('% ' || hp.short_name || '') OR
                (' ' || hd2.clean_description || ' ') LIKE ('' || hp.short_name || ' %') OR
                (hd2.keywords IS NOT NULL AND (
                    EXISTS (
                        SELECT 1 FROM unnest(hd2.keywords) AS keyword
                        WHERE (' ' || keyword || ' ') LIKE ('% ' || hp.short_name || ' %') OR
                              (' ' || keyword || ' ') LIKE ('% ' || hp.short_name || '') OR
                              (' ' || keyword || ' ') LIKE ('' || hp.short_name || ' %')
                    )
                ))
            ))
        )
    GROUP BY hd2.id_movie
),
hero_frequency_analysis AS (
    -- Contar frequência de detecção de cada herói DENTRO do mesmo vídeo (contagem real de ocorrências)
    SELECT 
        hd2.*,
        hd3.has_third_hero,
        -- Contar TODAS as ocorrências do heroi1 no título, descrição, playlist e keywords
        (
            -- Contar ocorrências no título usando diferença de length
            CASE WHEN LENGTH(hd2.detected_hero_1) > 0 THEN
                (LENGTH(LOWER(hd2.clean_title)) - LENGTH(REPLACE(LOWER(hd2.clean_title), LOWER(hd2.detected_hero_1), ''))) / LENGTH(LOWER(hd2.detected_hero_1))
            ELSE 0 END +
            -- Contar ocorrências na descrição
            CASE WHEN LENGTH(hd2.detected_hero_1) > 0 THEN
                (LENGTH(LOWER(hd2.clean_description)) - LENGTH(REPLACE(LOWER(hd2.clean_description), LOWER(hd2.detected_hero_1), ''))) / LENGTH(LOWER(hd2.detected_hero_1))
            ELSE 0 END +
            -- Contar ocorrências no título da playlist
            CASE WHEN LENGTH(hd2.detected_hero_1) > 0 THEN
                (LENGTH(LOWER(hd2.clean_playlist_title)) - LENGTH(REPLACE(LOWER(hd2.clean_playlist_title), LOWER(hd2.detected_hero_1), ''))) / LENGTH(LOWER(hd2.detected_hero_1))
            ELSE 0 END +
            -- Contar ocorrências nas keywords (somar todas as keywords que contêm o herói)
            CASE WHEN hd2.keywords IS NOT NULL AND LENGTH(hd2.detected_hero_1) > 0 THEN
                COALESCE((
                    SELECT SUM((LENGTH(LOWER(keyword)) - LENGTH(REPLACE(LOWER(keyword), LOWER(hd2.detected_hero_1), ''))) / LENGTH(LOWER(hd2.detected_hero_1)))
                    FROM unnest(hd2.keywords) AS keyword
                ), 0)
            ELSE 0 END
        ) as hero1_occurrences,
        -- Contar TODAS as ocorrências do heroi2 no título, descrição, playlist e keywords
        (
            CASE WHEN hd2.detected_hero_2 IS NOT NULL THEN
                -- Contar ocorrências no título
                CASE WHEN LENGTH(hd2.detected_hero_2) > 0 THEN
                    (LENGTH(LOWER(hd2.clean_title)) - LENGTH(REPLACE(LOWER(hd2.clean_title), LOWER(hd2.detected_hero_2), ''))) / LENGTH(LOWER(hd2.detected_hero_2))
                ELSE 0 END +
                -- Contar ocorrências na descrição
                CASE WHEN LENGTH(hd2.detected_hero_2) > 0 THEN
                    (LENGTH(LOWER(hd2.clean_description)) - LENGTH(REPLACE(LOWER(hd2.clean_description), LOWER(hd2.detected_hero_2), ''))) / LENGTH(LOWER(hd2.detected_hero_2))
                ELSE 0 END +
                -- Contar ocorrências no título da playlist
                CASE WHEN LENGTH(hd2.detected_hero_2) > 0 THEN
                    (LENGTH(LOWER(hd2.clean_playlist_title)) - LENGTH(REPLACE(LOWER(hd2.clean_playlist_title), LOWER(hd2.detected_hero_2), ''))) / LENGTH(LOWER(hd2.detected_hero_2))
                ELSE 0 END +
                -- Contar ocorrências nas keywords
                CASE WHEN hd2.keywords IS NOT NULL AND LENGTH(hd2.detected_hero_2) > 0 THEN
                    COALESCE((
                        SELECT SUM((LENGTH(LOWER(keyword)) - LENGTH(REPLACE(LOWER(keyword), LOWER(hd2.detected_hero_2), ''))) / LENGTH(LOWER(hd2.detected_hero_2)))
                        FROM unnest(hd2.keywords) AS keyword
                    ), 0)
                ELSE 0 END
            ELSE 0 END
        ) as hero2_occurrences
    FROM hero_detection_2 hd2
    LEFT JOIN hero_detection_3_check hd3 ON (hd2.id_movie = hd3.id_movie)
)
SELECT 
    hfa.id_movie,
    hfa.id_video,
    ch.id_channel,
    hfa.id_playlist,
    hfa.title,
    hfa.description,
    hfa.views,
    hfa.likes,
    hfa.title_playlist,
    hfa.id_youtube,
    hfa.dt_upload,
    hfa.version,
    hfa.keywords,
    -- Aplicar limpeza diretamente nas colunas clean existentes (removendo o primeiro herói)
    CASE 
        WHEN hfa.confidence_score_1 > 60 THEN 
            TRIM(REGEXP_REPLACE(
                REGEXP_REPLACE(hfa.clean_title, 
                    '\y' || LOWER(hfa.detected_hero_1) || '\y', ' ', 'gi'),
                '\s+', ' ', 'g'))
        ELSE hfa.clean_title 
    END as clean_title,
    CASE 
        WHEN hfa.confidence_score_1 > 60 THEN 
            TRIM(REGEXP_REPLACE(
                REGEXP_REPLACE(hfa.clean_description, 
                    '\y' || LOWER(hfa.detected_hero_1) || '\y', ' ', 'gi'),
                '\s+', ' ', 'g'))
        ELSE hfa.clean_description 
    END as clean_description,
    CASE 
        WHEN hfa.confidence_score_1 > 60 THEN 
            TRIM(REGEXP_REPLACE(
                REGEXP_REPLACE(hfa.clean_playlist_title, 
                    '\y' || LOWER(hfa.detected_hero_1) || '\y', ' ', 'gi'),
                '\s+', ' ', 'g'))
        ELSE hfa.clean_playlist_title 
    END as clean_playlist_title,
    -- Colunas do primeiro herói (sem inversão para compatibilidade)
    hfa.detected_hero_1,
    hfa.id_hero_1,
    hfa.confidence_score_1,
    -- Herói1 (compatibilidade com view anterior)
    CASE 
        WHEN hfa.confidence_score_1 > 60 THEN hfa.detected_hero_1
        ELSE NULL 
    END as heroi,
    -- Colunas do segundo herói (sem inversão para compatibilidade)
    hfa.detected_hero_2,
    hfa.id_hero_2,
    hfa.confidence_score_2,
    -- Herói1 e Herói2 com inversão baseada nas ocorrências DENTRO do vídeo
    CASE 
        WHEN hfa.confidence_score_2 > 60 AND hfa.confidence_score_1 > 60 AND hfa.hero2_occurrences > hfa.hero1_occurrences THEN hfa.detected_hero_2  -- heroi2 tem mais ocorrências, vira heroi1
        WHEN hfa.confidence_score_1 > 60 THEN hfa.detected_hero_1  -- heroi1 normal ou tem mais/igual ocorrências
        ELSE NULL 
    END as heroi1,
    CASE 
        WHEN hfa.confidence_score_2 > 60 AND hfa.confidence_score_1 > 60 AND hfa.hero2_occurrences > hfa.hero1_occurrences THEN hfa.detected_hero_1  -- heroi1 vira heroi2
        WHEN hfa.confidence_score_2 > 60 AND (hfa.hero2_occurrences <= hfa.hero1_occurrences OR hfa.confidence_score_1 <= 60) THEN hfa.detected_hero_2  -- heroi2 normal
        ELSE NULL 
    END as heroi2,
    -- Informações de ocorrências para debug/análise
    hfa.hero1_occurrences,
    hfa.hero2_occurrences,
    CASE WHEN hfa.confidence_score_2 > 60 AND hfa.confidence_score_1 > 60 AND hfa.hero2_occurrences > hfa.hero1_occurrences THEN TRUE ELSE FALSE END as should_invert_order,
    -- Herói final baseado nas regras (considerando inversão por ocorrências e diferença percentual):
    -- NULL se existirem 3 heróis
    -- O nome do herói com maior contagem se a diferença for > 80%
    -- "x1" se existirem 2 heróis com diferença <= 80%
    -- O nome do herói se só existir 1
    CASE 
        WHEN COALESCE(hfa.has_third_hero, FALSE) = TRUE THEN NULL  -- 3 heróis = NULL
        -- Caso existam 2 heróis válidos, verificar diferença percentual
        WHEN hfa.confidence_score_2 > 60 AND hfa.confidence_score_1 > 60 THEN
            CASE 
                -- Calcular diferença percentual e decidir se é > 80%
                WHEN hfa.hero1_occurrences > 0 AND hfa.hero2_occurrences > 0 THEN
                    CASE 
                        -- Se heroi1 tem mais ocorrências e diferença > 80%
                        WHEN hfa.hero1_occurrences > hfa.hero2_occurrences AND 
                             (CAST(hfa.hero1_occurrences - hfa.hero2_occurrences AS FLOAT) / CAST(hfa.hero2_occurrences AS FLOAT)) > 0.8 
                        THEN hfa.detected_hero_1
                        -- Se heroi2 tem mais ocorrências e diferença > 80%
                        WHEN hfa.hero2_occurrences > hfa.hero1_occurrences AND 
                             (CAST(hfa.hero2_occurrences - hfa.hero1_occurrences AS FLOAT) / CAST(hfa.hero1_occurrences AS FLOAT)) > 0.8 
                        THEN hfa.detected_hero_2
                        -- Diferença <= 80% = x1
                        ELSE 'x1'
                    END
                -- Se um dos heróis tem 0 ocorrências, pegar o que tem ocorrências
                WHEN hfa.hero1_occurrences > 0 AND hfa.hero2_occurrences = 0 THEN hfa.detected_hero_1
                WHEN hfa.hero2_occurrences > 0 AND hfa.hero1_occurrences = 0 THEN hfa.detected_hero_2
                -- Ambos têm 0 ocorrências = x1
                ELSE 'x1'
            END
        -- Casos de herói único
        WHEN hfa.confidence_score_2 > 60 AND COALESCE(hfa.confidence_score_1, 0) <= 60 THEN hfa.detected_hero_2  -- só heroi2 válido
        WHEN hfa.confidence_score_1 > 60 AND COALESCE(hfa.confidence_score_2, 0) <= 60 THEN hfa.detected_hero_1  -- só heroi1 válido
        ELSE NULL  -- Nenhum herói válido
    END as heroi_final
FROM hero_frequency_analysis hfa
LEFT JOIN public.channel ch ON (hfa.id_youtube = ch.id_youtube);