create materialized view mvw_analysis_channel_version as
with group_by_channel as (
	SELECT  
		id_youtube,
		versao_final as versao,
		sum(likes) as total_likes,
		sum(views) as total_views 
	FROM public.vw_video_versao
	group by id_youtube, versao_final
),
get_channel_and_days_version as (
	select c.title, c.handle, a.*, mav.date as date_version, mav.dias_entre_versoes
	from group_by_channel a
	left join channel c on (a.id_youtube = c.id_youtube)
	left join mvw_analysis_version mav on (mav.versao_final = a.versao)
	order by a.total_views desc
),
get_channel_rank_per_version as (
	select 
		a.*,
		(a.total_likes/a.dias_entre_versoes) as likes_per_day,
		(a.total_views/a.dias_entre_versoes) as views_per_day
	from get_channel_and_days_version a
	where a.total_views is not null and a.total_likes is not null and a.versao is not null
)
select a.*
from get_channel_rank_per_version a
order by a.date_version desc, a.views_per_day desc;
