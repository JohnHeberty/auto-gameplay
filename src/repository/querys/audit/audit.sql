with top_10_players as (
	SELECT *
	FROM public.mvw_103_analysis_version_proplayer
	limit 10
),
top_players_hero as (
	select b.*
	from top_10_players a
	left join mvw_104_analysis_version_proplayer_heroi b on (
		a.proplayer_final = b.proplayer_final and
		a.version = b.version
	)
)
select *
from top_players_hero;




with top_players as (
	select a.proplayer_final
	from public.mvw_103_analysis_version_proplayer a
	where version = '7.39' and a.total_videos > 2
	limit 20
),
top_proplayers_heroi as (
	select a.*
	from public.mvw_104_analysis_version_proplayer_heroi a
	where version = '7.39' and a.total_videos > 2
),
top_filters as (
	select a.*
	from top_proplayers_heroi a
	where a.proplayer_final in (select b.proplayer_final from top_players b)
)
select *
from top_filters



SELECT *
FROM public.mvw_4_info_video_heroi_proplayer
where proplayer_final = 'Miracle' and heroi_final = 'Invoker'
and "version" = '7.39'





