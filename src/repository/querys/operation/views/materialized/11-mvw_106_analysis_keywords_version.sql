CREATE MATERIALIZED VIEW mvw_106_analysis_keywords_version AS 
WITH video_keywords_by_version AS (
    -- Buscar vídeos com keywords e versão válidas
    SELECT 
        vd.id_movie,
        vd.version,
        vd.views,
        vd.likes,
        vd.keywords as keywords_array,
        array_length(vd.keywords, 1) as total_keywords_count  -- Contar total de keywords por vídeo
    FROM mvw_4_info_video_heroi_proplayer vd
    WHERE vd.version IS NOT NULL 
      AND vd.keywords IS NOT NULL 
      AND array_length(vd.keywords, 1) > 0
      AND vd.views IS NOT NULL
      AND vd.views > 0
),
keywords_exploded_with_proportional_views AS (
    -- Explodir array de keywords e dividir views proporcionalmente
    SELECT 
        vkv.id_movie,
        vkv.version,
        vkv.views,
        vkv.likes,
        vkv.total_keywords_count,
        LOWER(TRIM(unnest(vkv.keywords_array))) as keyword_individual,
        -- Dividir views proporcionalmente entre as keywords
        (vkv.views::decimal / vkv.total_keywords_count) as proportional_views,
        -- Dividir likes proporcionalmente entre as keywords
        (vkv.likes::decimal / vkv.total_keywords_count) as proportional_likes
    FROM video_keywords_by_version vkv
),
keywords_filtered_with_metrics AS (
    -- Filtrar keywords válidas e manter métricas proporcionais
    SELECT 
        ke.id_movie,
        ke.version,
        ke.keyword_individual,
        ke.proportional_views,
        ke.proportional_likes
    FROM keywords_exploded_with_proportional_views ke
    WHERE LENGTH(ke.keyword_individual) >= 3
      AND ke.keyword_individual NOT LIKE '%http%'
      AND ke.keyword_individual NOT LIKE '%.com%'
      AND ke.keyword_individual NOT LIKE '%www.%'
      AND ke.keyword_individual NOT LIKE '%youtube%'
      AND REGEXP_REPLACE(ke.keyword_individual, '[^a-zA-Z0-9\s]', '', 'g') = ke.keyword_individual
),
keyword_metrics_by_version AS (
    -- Agrupar e calcular métricas por keyword e versão
    SELECT 
        kf.keyword_individual,
        kf.version,
        COUNT(*) as total_occurrences,  -- Total de ocorrências da keyword
        COUNT(DISTINCT kf.id_movie) as unique_videos,  -- Vídeos únicos que usam esta keyword
        SUM(kf.proportional_views) as total_proportional_views,  -- Soma de views proporcionais
        SUM(kf.proportional_likes) as total_proportional_likes,  -- Soma de likes proporcionais
        AVG(kf.proportional_views) as avg_views_per_keyword,  -- Média de views por ocorrência da keyword
        AVG(kf.proportional_likes) as avg_likes_per_keyword  -- Média de likes por ocorrência da keyword
    FROM keywords_filtered_with_metrics kf
    GROUP BY kf.keyword_individual, kf.version
    HAVING COUNT(DISTINCT kf.id_movie) > 5  -- Mais de 5 vídeos únicos
),
include_days_of_version AS (
    -- Incluir informações de dias da versão
    SELECT 
        kmv.*,
        mav.days_between_versions,
        mav.date as date_version
    FROM keyword_metrics_by_version kmv
    LEFT JOIN mvw_100_analysis_version mav ON (kmv.version = mav.version)
),
calc_day_metrics AS (
    -- Calcular métricas por dia
    SELECT 
        idv.*,
        CASE WHEN idv.days_between_versions > 0 THEN 
            (idv.total_proportional_views::decimal / idv.days_between_versions) 
        ELSE NULL END as views_per_day,
        CASE WHEN idv.days_between_versions > 0 THEN 
            (idv.total_proportional_likes::decimal / idv.days_between_versions) 
        ELSE NULL END as likes_per_day,
        CASE WHEN idv.days_between_versions > 0 THEN 
            (idv.total_occurrences::decimal / idv.days_between_versions) 
        ELSE NULL END as occurrences_per_day,
        CASE WHEN idv.days_between_versions > 0 THEN 
            (idv.unique_videos::decimal / idv.days_between_versions) 
        ELSE NULL END as unique_videos_per_day
    FROM include_days_of_version idv
),
keyword_ranking AS (
    -- Criar ranking de keywords por versão
    SELECT 
        cdm.*,
        ROW_NUMBER() OVER (PARTITION BY cdm.version ORDER BY cdm.total_proportional_views DESC, cdm.unique_videos DESC) as rank_by_views,
        ROW_NUMBER() OVER (PARTITION BY cdm.version ORDER BY cdm.total_proportional_likes DESC, cdm.unique_videos DESC) as rank_by_likes,
        ROW_NUMBER() OVER (PARTITION BY cdm.version ORDER BY cdm.unique_videos DESC, cdm.total_occurrences DESC) as rank_by_frequency,
        ROW_NUMBER() OVER (PARTITION BY cdm.version ORDER BY cdm.avg_views_per_keyword DESC, cdm.avg_likes_per_keyword DESC) as rank_by_avg_performance
    FROM calc_day_metrics cdm
    WHERE cdm.unique_videos > 0
)
-- SELECT final com análise completa de keywords por versão
SELECT 
    kr.keyword_individual,
    kr.version,
    kr.date_version,
    kr.total_occurrences,
    kr.unique_videos,
    ROUND(kr.total_proportional_views, 0) as total_proportional_views,
    ROUND(kr.total_proportional_likes, 0) as total_proportional_likes,
    ROUND(kr.avg_views_per_keyword, 0) as avg_views_per_keyword,
    ROUND(kr.avg_likes_per_keyword, 0) as avg_likes_per_keyword,
    kr.days_between_versions,
    ROUND(kr.views_per_day, 2) as views_per_day,
    ROUND(kr.likes_per_day, 2) as likes_per_day,
    ROUND(kr.occurrences_per_day, 2) as occurrences_per_day,
    ROUND(kr.unique_videos_per_day, 2) as unique_videos_per_day,
    kr.rank_by_views,
    kr.rank_by_likes,
    kr.rank_by_frequency,
    kr.rank_by_avg_performance
FROM keyword_ranking kr
WHERE kr.views_per_day IS NOT NULL 
   OR kr.total_proportional_views >= 1000  -- Incluir keywords com alta visualização mesmo sem data de versão
ORDER BY kr.date_version DESC NULLS LAST, kr.rank_by_views ASC;
