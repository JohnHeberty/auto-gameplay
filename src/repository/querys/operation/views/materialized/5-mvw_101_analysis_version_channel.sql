create materialized view mvw_101_analysis_version_channel as
with group_by_channel as (
	SELECT  
		id_youtube,
		version as versao,
		sum(likes) as total_likes,
		sum(views) as total_views,
		count(*) as total_videos
	FROM public.mvw_2_info_video_clean_words
	group by id_youtube, version
),
get_channel_and_days_version as (
	select c.title, c.handle, a.*, mav.date as date_version, mav.days_between_versions as dias_entre_versoes
	from group_by_channel a
	left join channel c on (a.id_youtube = c.id_youtube)
	left join mvw_100_analysis_version mav on (mav.version = a.versao)
	order by a.total_views desc
),
get_channel_rank_per_version as (
	select 
		a.*,
		(a.total_likes/a.dias_entre_versoes) as likes_per_day,
		(a.total_views/a.dias_entre_versoes) as views_per_day,
		(a.total_videos::decimal/a.dias_entre_versoes) as videos_per_day
	from get_channel_and_days_version a
	where a.total_views is not null and a.total_likes is not null and a.versao is not null
)
select a.*
from get_channel_rank_per_version a
where a.views_per_day is not null and a.likes_per_day is not null
order by a.date_version desc, a.views_per_day desc;
