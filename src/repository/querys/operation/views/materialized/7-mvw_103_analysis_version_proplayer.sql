create materialized view mvw_103_analysis_version_proplayer as 
with version_proplayer_filter as (
	select 
		proplayer,
		version,
		views,
		likes
	from public.mvw_4_info_video_heroi_proplayer
	where proplayer is not null and version is not null
),
group_by_proplayer_version as (
	select 
		proplayer,
		version,
		sum(views) total_views,
		sum(likes) total_likes,
		count(*) as total_videos
	from version_proplayer_filter
	group by version, proplayer
),
includ_days_of_version as (
	select a.*, mav.days_between_versions, mav.date as date_version
	from group_by_proplayer_version a
	left join mvw_100_analysis_version mav on (a.version = mav.version)
),
calc_day as (
	select 
		a.*,
		(a.total_likes/a.days_between_versions) as likes_per_day,
		(a.total_views/a.days_between_versions) as views_per_day,
		(a.total_videos::decimal/a.days_between_versions) as videos_per_day
	from includ_days_of_version a
)
select 
	a.*
from calc_day a
where a.views_per_day is not null and a.likes_per_day is not null
order by a.date_version desc, a.views_per_day desc;