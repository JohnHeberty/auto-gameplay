with top_10_players as (
	SELECT *
	FROM public.mvw_103_analysis_version_proplayer
	limit 10
),
top_players_hero as (
	select b.*
	from top_10_players a
	left join mvw_104_analysis_version_proplayer_heroi b on (
		a.proplayer = b.proplayer and
		a.version = b.version
	)
)
select *
from top_players_hero;


SELECT id_movie, title, description, "views", likes, id_video, id_playlist, title_playlist, id_youtube, dt_upload, clean_title, clean_description, clean_playlist_title, "version", detected_hero, id_hero, confidence_score_1, heroi, detected_proplayer, id_proplayer, confidence_score_2, proplayer
FROM public.mvw_3_info_video_heroi_proplayer
where proplayer = 'Ace' and heroi = 'Faceless Void' and "version" = '7.39'


