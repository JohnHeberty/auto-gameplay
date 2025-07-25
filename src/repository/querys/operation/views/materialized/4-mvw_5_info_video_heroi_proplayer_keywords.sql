CREATE MATERIALIZED VIEW mvw_5_info_video_heroi_proplayer_keywords AS 
WITH video_keywords_by_proplayer_heroi_version AS (
    -- Buscar vídeos com proplayer, herói, keywords e versão válidas
    SELECT 
        vd.id_movie,
        vd.proplayer_final,
        vd.heroi_final,
        vd.version,
        vd.keywords as keywords_array
    FROM mvw_4_info_video_heroi_proplayer vd
    WHERE vd.version IS NOT NULL 
      AND vd.proplayer_final IS NOT NULL
      AND vd.heroi_final IS NOT NULL
      AND vd.keywords IS NOT NULL 
      AND array_length(vd.keywords, 1) > 0
),
keywords_exploded AS (
    -- Explodir array de keywords em linhas individuais
    SELECT 
        vkv.id_movie,
        vkv.proplayer_final,
        vkv.heroi_final,
        vkv.version,
        LOWER(TRIM(unnest(vkv.keywords_array))) as keyword_individual
    FROM video_keywords_by_proplayer_heroi_version vkv
),
keywords_filtered AS (
    -- Filtrar keywords válidas (mais de 2 caracteres, sem caracteres especiais)
    SELECT 
        ke.id_movie,
        ke.proplayer_final,
        ke.heroi_final,
        ke.version,
        ke.keyword_individual
    FROM keywords_exploded ke
    WHERE LENGTH(ke.keyword_individual) >= 3
      AND ke.keyword_individual NOT LIKE '%http%'
      AND ke.keyword_individual NOT LIKE '%.com%'
      AND ke.keyword_individual NOT LIKE '%www.%'
      AND ke.keyword_individual NOT LIKE '%youtube%'
      AND REGEXP_REPLACE(ke.keyword_individual, '[^a-zA-Z0-9\s]', '', 'g') = ke.keyword_individual
),
group_by_proplayer_heroi_keyword_version AS (
    -- Agrupar por proplayer, herói, keyword e versão
    SELECT 
        kf.proplayer_final,
        kf.heroi_final,
        kf.keyword_individual,
        kf.version,
        COUNT(*) as total_occurrences,  -- Total de ocorrências da keyword para esta combinação
        COUNT(DISTINCT kf.id_movie) as unique_videos  -- Vídeos únicos que usam esta keyword para esta combinação
    FROM keywords_filtered kf
    GROUP BY kf.proplayer_final, kf.heroi_final, kf.keyword_individual, kf.version
    HAVING COUNT(DISTINCT kf.id_movie) > 5  -- Mais de 10 vídeos únicos
)
-- SELECT final com todas as keywords válidas por proplayer, herói e versão
SELECT 
    gphkv.proplayer_final,
    gphkv.heroi_final,
    gphkv.version,
    gphkv.keyword_individual,
    gphkv.total_occurrences,
    gphkv.unique_videos
FROM group_by_proplayer_heroi_keyword_version gphkv
ORDER BY gphkv.version DESC, gphkv.total_occurrences DESC, gphkv.proplayer_final, gphkv.heroi_final;
