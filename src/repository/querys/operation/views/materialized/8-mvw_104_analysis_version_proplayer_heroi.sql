create materialized view mvw_104_analysis_version_proplayer_heroi as 
with video_proplayer_heroi as (
	select 
		ph.proplayer_final,
		hh.heroi_final as hero,
		ph.version,
		ph.views,
		ph.likes,
		ph.id_movie
	from public.mvw_4_info_video_heroi_proplayer ph
	inner join mvw_3_info_video_heroi hh on (ph.id_movie = hh.id_movie)
	where ph.proplayer_final is not null 
	  and hh.heroi_final is not null 
	  and ph.version is not null
),
group_by_proplayer_heroi_version as (
	select 
		proplayer_final,
		hero,
		version,
		sum(views) total_views,
		sum(likes) total_likes,
		count(*) as total_videos
	from video_proplayer_heroi
	group by version, proplayer_final, hero
),
includ_days_of_version as (
	select a.*, mav.days_between_versions, mav.date as date_version
	from group_by_proplayer_heroi_version a
	left join mvw_100_analysis_version mav on (a.version = mav.version)
),
calc_day as (
	select 
		a.*,
		case when a.days_between_versions > 0 then 
			(a.total_likes::decimal/a.days_between_versions) 
		else null end as likes_per_day,
		case when a.days_between_versions > 0 then 
			(a.total_views::decimal/a.days_between_versions) 
		else null end as views_per_day,
		case when a.days_between_versions > 0 then 
			(a.total_videos::decimal/a.days_between_versions) 
		else null end as videos_per_day
	from includ_days_of_version a
)
select 
	a.*
from calc_day a
where a.views_per_day is not null and a.likes_per_day is not null
order by a.date_version desc, a.views_per_day desc;