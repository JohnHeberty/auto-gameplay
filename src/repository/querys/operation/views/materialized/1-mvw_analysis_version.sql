CREATE MATERIALIZED VIEW mvw_analysis_version AS 
WITH group_by_version as (
    select 
        versao_final,
        SUM(likes) as total_likes,
        SUM("views") as total_views
    from vw_video_versao
    group by versao_final
), 
insert_data AS (
    select
        a.*, 
        b.date  -- já deve estar no tipo date
    from group_by_version a
    left join game_versions b on b.name = a.versao_final
), 
shift_data as (
    select
        *,
        LAG(date) over (order by date) as date_anterior,
        (date - LAG(date) over (order by date)) AS dias_entre_versoes
    from insert_data
),
views_per_day as (
	select 
		*,
		(total_likes/dias_entre_versoes) as likes_per_day,
		(total_views/dias_entre_versoes) as views_per_day
	from shift_data
	order by date desc
)
select versao_final, total_likes, total_views, "date", dias_entre_versoes, likes_per_day, views_per_day
from views_per_day;