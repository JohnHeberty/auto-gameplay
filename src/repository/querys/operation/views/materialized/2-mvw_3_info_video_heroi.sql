-- MATERIALIZED VIEW PARA DETECÇÃO DE MÚLTIPLOS HERÓIS
-- Nova abordagem otimizada:
-- 1. Usar big_string já criada na mvw_2_info_video_clean_words
-- 2. Contar ocorrências de cada herói na big_string
-- 3. Ranking por ocorrências (filtrar > 1)
-- 4. Top1 = heroi1, Top2 = heroi2, heroi_final baseado na diferença

CREATE MATERIALIZED VIEW mvw_3_info_video_heroi AS 
WITH nomes_herois AS (
    -- Buscar todos os nomes de heróis para filtrar da big_string após detecção
    SELECT DISTINCT
        LOWER(TRIM(hp.localized_name)) as hero_name
    FROM vw_heroi hp
    WHERE hp.localized_name IS NOT NULL AND LENGTH(TRIM(hp.localized_name)) >= 3
    UNION
    SELECT DISTINCT
        LOWER(TRIM(hp.clean_name)) as hero_name  
    FROM vw_heroi hp
    WHERE hp.clean_name IS NOT NULL AND LENGTH(TRIM(hp.clean_name)) >= 3
    UNION
    SELECT DISTINCT
        LOWER(TRIM(hp.short_name)) as hero_name
    FROM vw_heroi hp
    WHERE hp.short_name IS NOT NULL AND LENGTH(TRIM(hp.short_name)) >= 4
    UNION
    SELECT DISTINCT
        LOWER(TRIM(hp.first_name)) as hero_name
    FROM vw_heroi hp
    WHERE hp.first_name IS NOT NULL AND LENGTH(TRIM(hp.first_name)) >= 3
    UNION 
    SELECT DISTINCT
        LOWER(TRIM(hp.second_name)) as hero_name
    FROM vw_heroi hp
    WHERE hp.second_name IS NOT NULL AND LENGTH(TRIM(hp.second_name)) >= 3
),
hero_occurrence_count AS (
    -- Contar ocorrências de cada herói na big_string
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
        vd.big_string,
        hp.id_hero,
        hp.localized_name as hero_name,
        -- Contar ocorrências do herói na big_string usando length/replace (com espaços para palavras completas)
        (
            CASE WHEN LENGTH(LOWER(hp.localized_name)) > 0 AND LENGTH(vd.big_string) > 0 THEN
                (LENGTH(LOWER(vd.big_string)) - LENGTH(REPLACE(LOWER(vd.big_string), CONCAT(' ', LOWER(hp.localized_name), ' '), ''))) / LENGTH(CONCAT(' ', LOWER(hp.localized_name), ' '))
            ELSE 0 END +
            -- Também contar usando clean_name se diferente de localized_name
            CASE WHEN hp.clean_name != hp.clean_localized_name AND LENGTH(LOWER(hp.clean_name)) > 0 AND LENGTH(vd.big_string) > 0 THEN
                (LENGTH(LOWER(vd.big_string)) - LENGTH(REPLACE(LOWER(vd.big_string), CONCAT(' ', LOWER(hp.clean_name), ' '), ''))) / LENGTH(CONCAT(' ', LOWER(hp.clean_name), ' '))
            ELSE 0 END +
            -- Também contar usando short_name se existir e >= 4 chars
            CASE WHEN hp.short_name IS NOT NULL AND LENGTH(hp.short_name) >= 4 AND LENGTH(vd.big_string) > 0 THEN
                (LENGTH(LOWER(vd.big_string)) - LENGTH(REPLACE(LOWER(vd.big_string), CONCAT(' ', LOWER(hp.short_name), ' '), ''))) / LENGTH(CONCAT(' ', LOWER(hp.short_name), ' '))
            ELSE 0 END
        ) as hero_occurrence_count
    FROM mvw_2_info_video_clean_words vd
    CROSS JOIN vw_heroi hp
),
hero_ranking AS (
    -- Criar ranking por ocorrências e filtrar apenas heróis com contagem > 1
    SELECT 
        hoc.*,
        ROW_NUMBER() OVER (PARTITION BY hoc.id_movie ORDER BY hoc.hero_occurrence_count DESC, hoc.id_hero) as hero_rank
    FROM hero_occurrence_count hoc
    WHERE hoc.hero_occurrence_count > 1  -- Filtrar apenas heróis com mais de 1 ocorrência
),
hero_top2 AS (
    -- Pegar apenas Top1 e Top2 por vídeo
    SELECT 
        id_movie,
        MAX(CASE WHEN hero_rank = 1 THEN id_hero END) as top1_id_hero,
        MAX(CASE WHEN hero_rank = 1 THEN hero_name END) as top1_hero_name,
        MAX(CASE WHEN hero_rank = 1 THEN hero_occurrence_count END) as top1_occurrences,
        MAX(CASE WHEN hero_rank = 2 THEN id_hero END) as top2_id_hero,
        MAX(CASE WHEN hero_rank = 2 THEN hero_name END) as top2_hero_name,
        MAX(CASE WHEN hero_rank = 2 THEN hero_occurrence_count END) as top2_occurrences
    FROM hero_ranking
    WHERE hero_rank <= 2  -- Apenas top 2
    GROUP BY id_movie
),
big_string_sem_herois AS (
    -- Remover nomes de heróis detectados da big_string
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
        ht2.top1_hero_name,
        ht2.top2_hero_name,
        -- Substituir big_string removendo os nomes de heróis detectados (filtrar palavras)
        TRIM(REGEXP_REPLACE(
            COALESCE(
                (SELECT string_agg(
                    CASE 
                        WHEN LENGTH(TRIM(palavra_individual)) >= 3 
                             AND LOWER(TRIM(palavra_individual)) NOT IN (SELECT hero_name FROM nomes_herois)
                        THEN TRIM(palavra_individual)
                        ELSE NULL 
                    END, ' '
                ) FROM unnest(string_to_array(vd.big_string, ' ')) AS palavra_individual),
                ''
            ),
            '\s+', ' ', 'g'
        )) as big_string
    FROM mvw_2_info_video_clean_words vd
    LEFT JOIN hero_top2 ht2 ON (vd.id_movie = ht2.id_movie)
)
-- SELECT final com colunas essenciais
SELECT 
    bsh.id_movie,
    bsh.id_video,
    ch.id_channel,
    bsh.id_playlist,
    bsh.title,
    bsh.description,
    bsh.views,
    bsh.likes,
    bsh.title_playlist,
    bsh.id_youtube,
    bsh.dt_upload,
    bsh.version,
    -- Keywords já processadas
    bsh.keywords,
    -- Herói1 e Herói2
    bsh.top1_hero_name as heroi1,
    bsh.top2_hero_name as heroi2,
    -- Detecção de confronto em coluna separada (não afeta qualidade dos dados)
    CASE 
        WHEN (bsh.big_string LIKE '% vs %' OR 
              bsh.big_string LIKE '% vs. %' OR 
              bsh.big_string LIKE '% versus %' OR 
              bsh.big_string LIKE '% versus. %' OR 
              bsh.big_string LIKE '% 1v1 %' OR 
              bsh.big_string LIKE '% 1v1. %' OR 
              bsh.big_string LIKE '% 1x1 %' OR
              bsh.big_string LIKE '% 1x1. %' OR
              bsh.big_string LIKE '% x1. %' OR
              bsh.big_string LIKE '% x1 %')
        THEN TRUE
        ELSE FALSE
    END as x1_detectado,
    -- Herói final: lógica limpa baseada apenas na diferença percentual
    CASE 
        -- Se existe apenas heroi1 (sem heroi2), heroi_final = heroi1
        WHEN bsh.top1_hero_name IS NOT NULL AND bsh.top2_hero_name IS NULL THEN 
            bsh.top1_hero_name
        -- Se existem heroi1 e heroi2, só definir heroi_final se diferença >= 50%
        WHEN bsh.top1_hero_name IS NOT NULL AND bsh.top2_hero_name IS NOT NULL THEN
            CASE 
                -- Calcular diferença percentual: (heroi1 - heroi2) / heroi2 >= 0.5
                WHEN ht2.top2_occurrences > 0 AND 
                     (CAST(ht2.top1_occurrences - ht2.top2_occurrences AS FLOAT) / CAST(ht2.top2_occurrences AS FLOAT)) >= 0.5 
                THEN bsh.top1_hero_name
                -- Diferença < 50% = NULL (qualidade preservada)
                ELSE NULL
            END
        -- Caso padrão: nenhum herói detectado
        ELSE NULL
    END as heroi_final,
    -- Big string já sem os nomes de heróis detectados
    bsh.big_string
FROM big_string_sem_herois bsh
LEFT JOIN hero_top2 ht2 ON (bsh.id_movie = ht2.id_movie)
LEFT JOIN public.channel ch ON (bsh.id_youtube = ch.id_youtube)