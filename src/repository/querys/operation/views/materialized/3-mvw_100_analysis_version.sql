CREATE MATERIALIZED VIEW mvw_100_analysis_version AS 
WITH group_by_version as (
    select 
        version,
        SUM(likes) as all_likes,
        SUM("views") as all_views,
        count(*) as all_videos
    from mvw_1_info_video
    group by version
), 
insert_data AS (
    select
        a.*, 
        b.date  -- já deve estar no tipo date
    from group_by_version a
    left join game_versions b on b.name = a.version
), 
shift_data as (
    select
        *,
        LAG(date) over (order by date) as previous_date,
        (date - LAG(date) over (order by date)) AS days_between_versions
    from insert_data
),
views_per_day as (
    select 
        *,
        (all_likes/days_between_versions) as likes_per_day,
        (all_views/days_between_versions) as views_per_day,
        (all_videos::decimal/days_between_versions) as videos_per_day
    from shift_data
    where days_between_versions IS NOT NULL AND days_between_versions > 0
    order by date desc
)
select version, all_likes, all_views, all_videos, "date", days_between_versions, likes_per_day, views_per_day, videos_per_day
from views_per_day;