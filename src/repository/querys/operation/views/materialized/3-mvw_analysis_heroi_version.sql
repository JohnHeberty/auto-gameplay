create materialized view mvw_analysis_heroi_version as 
with version_heroi_filter as (
	select 
		heroi,
		versao_final,
		views,
		likes
	from vw_video_version_heroi
	where heroi is not null and versao_final is not null
),
group_by_heroi_version as (
	select 
		heroi,
		versao_final,
		sum(views) total_views,
		sum(likes) total_likes
	from version_heroi_filter
	group by versao_final, heroi
),
includ_days_of_version as (
	select a.*, mav.dias_entre_versoes, mav.date as date_version
	from group_by_heroi_version a
	left join mvw_analysis_version mav on (a.versao_final = mav.versao_final)
),
calc_day as (
	select 
		a.*,
		(a.total_likes/a.dias_entre_versoes) as likes_per_day,
		(a.total_views/a.dias_entre_versoes) as views_per_day
	from includ_days_of_version a
)
select 
	a.*
from calc_day a
order by a.date_version desc, a.views_per_day desc;
