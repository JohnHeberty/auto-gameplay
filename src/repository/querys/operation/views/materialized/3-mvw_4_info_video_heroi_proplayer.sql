-- MATERIALIZED VIEW PARA DETECÇÃO DE MÚLTIPLOS PROPLAYERS
-- Nova abordagem otimizada:
-- 1. Usar big_string já processada (sem heróis) do mvw_3_info_video_heroi
-- 2. Contar ocorrências de cada proplayer na big_string
-- 3. Ranking por ocorrências (filtrar > 1)
-- 4. Top1 = proplayer1, Top2 = proplayer2, proplayer_final baseado na diferença
-- 5. Remover nomes de proplayers detectados da big_string

CREATE MATERIALIZED VIEW mvw_4_info_video_heroi_proplayer AS 
WITH nomes_proplayers AS (
    -- Buscar todos os nomes de proplayers para filtrar da big_string após detecção
    SELECT DISTINCT
        LOWER(TRIM(pp.name)) as proplayer_name
    FROM vw_proplayers pp
    WHERE pp.name IS NOT NULL AND LENGTH(TRIM(pp.name)) >= 3
    UNION
    SELECT DISTINCT
        LOWER(TRIM(pp.clean_name)) as proplayer_name  
    FROM vw_proplayers pp
    WHERE pp.clean_name IS NOT NULL AND LENGTH(TRIM(pp.clean_name)) >= 3
    UNION
    SELECT DISTINCT
        LOWER(TRIM(pp.clean_no_symbols_name)) as proplayer_name
    FROM vw_proplayers pp
    WHERE pp.clean_no_symbols_name IS NOT NULL AND LENGTH(TRIM(pp.clean_no_symbols_name)) >= 3
    UNION
    SELECT DISTINCT
        LOWER(TRIM(pp.short_name)) as proplayer_name
    FROM vw_proplayers pp
    WHERE pp.short_name IS NOT NULL AND LENGTH(TRIM(pp.short_name)) >= 4
),
proplayer_occurrence_count AS (
    -- Contar ocorrências de cada proplayer na big_string (já sem heróis da view anterior)
    SELECT 
        vd.id_movie,
        vd.id_video,
        vd.id_playlist,
        vd.title,
        vd.description,
        vd.views,
        vd.likes,
        vd.title_playlist,
        vd.id_youtube,
        vd.dt_upload,
        vd.version,
        vd.keywords,
        vd.heroi1,
        vd.heroi2,
        vd.x1_detectado,
        vd.heroi_final,
        vd.big_string,
        pp.id_proplayer,
        pp.name as proplayer_name,
        -- Contar ocorrências do proplayer na big_string usando length/replace (com espaços para palavras completas)
        (
            CASE WHEN LENGTH(LOWER(pp.name)) > 0 AND LENGTH(vd.big_string) > 0 THEN
                (LENGTH(LOWER(vd.big_string)) - LENGTH(REPLACE(LOWER(vd.big_string), CONCAT(' ', LOWER(pp.name), ' '), ''))) / LENGTH(CONCAT(' ', LOWER(pp.name), ' '))
            ELSE 0 END +
            -- Também contar usando clean_name se diferente de name
            CASE WHEN pp.clean_name != LOWER(pp.name) AND LENGTH(LOWER(pp.clean_name)) > 0 AND LENGTH(vd.big_string) > 0 THEN
                (LENGTH(LOWER(vd.big_string)) - LENGTH(REPLACE(LOWER(vd.big_string), CONCAT(' ', LOWER(pp.clean_name), ' '), ''))) / LENGTH(CONCAT(' ', LOWER(pp.clean_name), ' '))
            ELSE 0 END +
            -- Também contar usando clean_no_symbols_name se existir
            CASE WHEN pp.clean_no_symbols_name IS NOT NULL AND LENGTH(LOWER(pp.clean_no_symbols_name)) > 0 AND LENGTH(vd.big_string) > 0 THEN
                (LENGTH(LOWER(vd.big_string)) - LENGTH(REPLACE(LOWER(vd.big_string), CONCAT(' ', LOWER(pp.clean_no_symbols_name), ' '), ''))) / LENGTH(CONCAT(' ', LOWER(pp.clean_no_symbols_name), ' '))
            ELSE 0 END +
            -- Também contar usando short_name se existir e >= 4 chars
            CASE WHEN pp.short_name IS NOT NULL AND LENGTH(pp.short_name) >= 4 AND LENGTH(vd.big_string) > 0 THEN
                (LENGTH(LOWER(vd.big_string)) - LENGTH(REPLACE(LOWER(vd.big_string), CONCAT(' ', LOWER(pp.short_name), ' '), ''))) / LENGTH(CONCAT(' ', LOWER(pp.short_name), ' '))
            ELSE 0 END
        ) as proplayer_occurrence_count
    FROM mvw_3_info_video_heroi vd
    CROSS JOIN vw_proplayers pp
),
proplayer_ranking AS (
    -- Criar ranking por ocorrências e filtrar apenas proplayers com contagem > 1
    SELECT 
        poc.*,
        ROW_NUMBER() OVER (PARTITION BY poc.id_movie ORDER BY poc.proplayer_occurrence_count DESC, poc.id_proplayer) as proplayer_rank
    FROM proplayer_occurrence_count poc
    WHERE poc.proplayer_occurrence_count > 1  -- Filtrar apenas proplayers com mais de 1 ocorrência
),
proplayer_top2 AS (
    -- Pegar apenas Top1 e Top2 por vídeo
    SELECT 
        id_movie,
        MAX(CASE WHEN proplayer_rank = 1 THEN id_proplayer END) as top1_id_proplayer,
        MAX(CASE WHEN proplayer_rank = 1 THEN proplayer_name END) as top1_proplayer_name,
        MAX(CASE WHEN proplayer_rank = 1 THEN proplayer_occurrence_count END) as top1_occurrences,
        MAX(CASE WHEN proplayer_rank = 2 THEN id_proplayer END) as top2_id_proplayer,
        MAX(CASE WHEN proplayer_rank = 2 THEN proplayer_name END) as top2_proplayer_name,
        MAX(CASE WHEN proplayer_rank = 2 THEN proplayer_occurrence_count END) as top2_occurrences
    FROM proplayer_ranking
    WHERE proplayer_rank <= 2  -- Apenas top 2
    GROUP BY id_movie
),
big_string_sem_proplayers AS (
    -- Remover nomes de proplayers detectados da big_string
    SELECT 
        vd.id_movie,
        vd.id_video,
        vd.id_playlist,
        vd.title,
        vd.description,
        vd.views,
        vd.likes,
        vd.title_playlist,
        vd.id_youtube,
        vd.dt_upload,
        vd.version,
        vd.keywords,
        vd.heroi1,
        vd.heroi2,
        vd.x1_detectado,
        vd.heroi_final,
        pt2.top1_proplayer_name,
        pt2.top2_proplayer_name,
        -- Substituir big_string removendo os nomes de proplayers detectados (filtrar palavras)
        TRIM(REGEXP_REPLACE(
            COALESCE(
                (SELECT string_agg(
                    CASE 
                        WHEN LENGTH(TRIM(palavra_individual)) >= 3 
                             AND LOWER(TRIM(palavra_individual)) NOT IN (SELECT proplayer_name FROM nomes_proplayers)
                        THEN TRIM(palavra_individual)
                        ELSE NULL 
                    END, ' '
                ) FROM unnest(string_to_array(vd.big_string, ' ')) AS palavra_individual),
                ''
            ),
            '\s+', ' ', 'g'
        )) as big_string
    FROM mvw_3_info_video_heroi vd
    LEFT JOIN proplayer_top2 pt2 ON (vd.id_movie = pt2.id_movie)
)
-- SELECT final com colunas essenciais
SELECT 
    bsp.id_movie,
    bsp.id_video,
    bsp.id_playlist,
    bsp.title,
    bsp.description,
    bsp.views,
    bsp.likes,
    bsp.title_playlist,
    bsp.id_youtube,
    bsp.dt_upload,
    bsp.version,
    -- Keywords já processadas
    bsp.keywords,
    -- Colunas de heróis vindas da view anterior
    bsp.heroi1,
    bsp.heroi2,
    bsp.x1_detectado,
    bsp.heroi_final,
    -- Proplayer1 e Proplayer2
    bsp.top1_proplayer_name as proplayer1,
    bsp.top2_proplayer_name as proplayer2,
    -- Proplayer final: lógica limpa baseada apenas na diferença percentual
    CASE 
        -- Se existe apenas proplayer1 (sem proplayer2), proplayer_final = proplayer1
        WHEN bsp.top1_proplayer_name IS NOT NULL AND bsp.top2_proplayer_name IS NULL THEN 
            bsp.top1_proplayer_name
        -- Se existem proplayer1 e proplayer2, só definir proplayer_final se diferença >= 50%
        WHEN bsp.top1_proplayer_name IS NOT NULL AND bsp.top2_proplayer_name IS NOT NULL THEN
            CASE 
                -- Calcular diferença percentual: (proplayer1 - proplayer2) / proplayer2 >= 0.5
                WHEN pt2.top2_occurrences > 0 AND 
                     (CAST(pt2.top1_occurrences - pt2.top2_occurrences AS FLOAT) / CAST(pt2.top2_occurrences AS FLOAT)) >= 0.5 
                THEN bsp.top1_proplayer_name
                -- Diferença < 50% = NULL (qualidade preservada)
                ELSE NULL
            END
        -- Caso padrão: nenhum proplayer detectado
        ELSE NULL
    END as proplayer_final,
    -- Big string já sem os nomes de proplayers detectados
    bsp.big_string
FROM big_string_sem_proplayers bsp
LEFT JOIN proplayer_top2 pt2 ON (bsp.id_movie = pt2.id_movie);