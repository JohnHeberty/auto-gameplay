create materialized view mvw_105_analysis_market_share as
with 
video_proplayer_heroi as (
	select 
		ph.proplayer_final,
		hh.heroi_final,
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
		heroi_final,
		version,
		sum(views) total_views,
		sum(likes) total_likes,
		count(*) as total_videos
	from video_proplayer_heroi
	group by version, proplayer_final, heroi_final
),
-- Agregação por herói para calcular market-share
heroi_totals as (
	select 
		heroi_final,
		version,
		sum(views) as heroi_total_views,
		sum(likes) as heroi_total_likes,
		count(*) as heroi_total_videos
	from video_proplayer_heroi
	group by version, heroi_final
),
-- Agregação por proplayer para calcular market-share
proplayer_totals as (
	select 
		proplayer_final,
		version,
		sum(views) as proplayer_total_views,
		sum(likes) as proplayer_total_likes,
		count(*) as proplayer_total_videos
	from video_proplayer_heroi
	group by version, proplayer_final
),
-- Totais gerais por versão para market-share absoluto
version_totals as (
	select 
		version,
		sum(views) as version_total_views,
		sum(likes) as version_total_likes,
		count(*) as version_total_videos
	from video_proplayer_heroi
	group by version
),
-- Calcular market-share em todas as dimensões
market_share_calculations as (
	select 
		ph.proplayer_final,
		ph.heroi_final,
		ph.version,
		ph.total_views,
		ph.total_likes,
		ph.total_videos,
		ht.heroi_total_views,
		ht.heroi_total_likes,
		ht.heroi_total_videos,
		pt.proplayer_total_views,
		pt.proplayer_total_likes,
		pt.proplayer_total_videos,
		vt.version_total_views,
		vt.version_total_likes,
		vt.version_total_videos,
		-- Market-share do proplayer no herói específico
		case when ht.heroi_total_views > 0 then 
			round((ph.total_views::decimal / ht.heroi_total_views * 100), 2) 
		else null end as market_share_hero_views_percent,
		case when ht.heroi_total_likes > 0 then 
			round((ph.total_likes::decimal / ht.heroi_total_likes * 100), 2) 
		else null end as market_share_hero_likes_percent,
		case when ht.heroi_total_videos > 0 then 
			round((ph.total_videos::decimal / ht.heroi_total_videos * 100), 2) 
		else null end as market_share_hero_videos_percent,
		-- Market-share do herói no proplayer específico
		case when pt.proplayer_total_views > 0 then 
			round((ph.total_views::decimal / pt.proplayer_total_views * 100), 2) 
		else null end as market_share_proplayer_views_percent,
		case when pt.proplayer_total_likes > 0 then 
			round((ph.total_likes::decimal / pt.proplayer_total_likes * 100), 2) 
		else null end as market_share_proplayer_likes_percent,
		case when pt.proplayer_total_videos > 0 then 
			round((ph.total_videos::decimal / pt.proplayer_total_videos * 100), 2) 
		else null end as market_share_proplayer_videos_percent,
		-- Market-share absoluto na versão
		case when vt.version_total_views > 0 then 
			round((ph.total_views::decimal / vt.version_total_views * 100), 2) 
		else null end as market_share_version_views_percent,
		case when vt.version_total_likes > 0 then 
			round((ph.total_likes::decimal / vt.version_total_likes * 100), 2) 
		else null end as market_share_version_likes_percent,
		case when vt.version_total_videos > 0 then 
			round((ph.total_videos::decimal / vt.version_total_videos * 100), 2) 
		else null end as market_share_version_videos_percent
	from group_by_proplayer_heroi_version ph
	left join heroi_totals ht on (ph.heroi_final = ht.heroi_final and ph.version = ht.version)
	left join proplayer_totals pt on (ph.proplayer_final = pt.proplayer_final and ph.version = pt.version)
	left join version_totals vt on (ph.version = vt.version)
),
includ_days_of_version as (
	select a.*, mav.days_between_versions, mav.date as date_version
	from market_share_calculations a
	left join mvw_100_analysis_version mav on (a.version = mav.version)
)
select 
	a.*
from includ_days_of_version a
where a.market_share_version_views_percent is not null 
  and a.market_share_hero_views_percent is not null
  and a.market_share_proplayer_views_percent is not null
  and a.date_version is not null
order by a.date_version desc, a.market_share_version_views_percent desc, a.market_share_hero_views_percent desc;